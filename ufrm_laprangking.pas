unit ufrm_laprangking;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, lib_ku, jpeg, ExtCtrls;

type
  Tf_laprang = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp2: TGroupBox;
    lbl2: TLabel;
    edttahun: TEdit;
    btnlihat: TBitBtn;
    btnkeluar: TBitBtn;
    img1: TImage;
    procedure btnkeluarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnlihatClick(Sender: TObject);
    procedure edttahunKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_laprang: Tf_laprang;

implementation

uses ufrm_dm, ufrm_reportrang;

{$R *.dfm}

procedure Tf_laprang.btnkeluarClick(Sender: TObject);
begin
 close;
end;

procedure Tf_laprang.FormShow(Sender: TObject);
begin
 edttahun.Text := FormatDateTime('yyyy', Now);
end;

procedure Tf_laprang.btnlihatClick(Sender: TObject);
begin
 if edttahun.Text='' then
  begin
    MessageDlg('Tahun Belum Diisi',mtWarning,[mbok],0);
    edttahun.SetFocus; Exit;
  end
  else
  begin
    pencarian_data(dm.qry3,'t_rangking',['tahun'],edttahun.Text);
    if dm.qry3.IsEmpty then
     begin
       MessageDlg('Data Tidak Ada',mtWarning,[mbOK],0);
       edttahun.SetFocus; Exit;
     end;

    with dm.qry3 do
     begin
       Close;
       SQL.Text :=' select a.kd_proses, a.tahun, b.nip, b.nm_ckepsek,'+
                  ' a.nilai_saw from t_rangking a, t_kepsek b where a.nip=b.nip order by a.nilai_saw desc';
       Open;
     end;

    konek_awal(dm.qry1,'t_jawab','nip');
    with f_rang do
     begin
      QRLabelbulan.Caption   := 'Nama Kota, '+bulan(Now);
      QRLabeljabatan.Caption := dm.qry1['jabatan'];
      QRLabelnama.Caption    := dm.qry1['nama'];
      QRLabelnip.Caption     := dm.qry1['nip'];
      Preview;
     end;
  end;
end;

procedure Tf_laprang.edttahunKeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9',#13,#8,#9]) then key:=#0;
end;

end.
