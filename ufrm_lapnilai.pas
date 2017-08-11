unit ufrm_lapnilai;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, lib_ku, jpeg, ExtCtrls;

type
  Tf_lapnilai = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp2: TGroupBox;
    rb1: TRadioButton;
    rb2: TRadioButton;
    grp3: TGroupBox;
    btnlihat: TBitBtn;
    btnkeluar: TBitBtn;
    lbl2: TLabel;
    edttahun: TEdit;
    edtnip: TEdit;
    edtnama: TEdit;
    btnpilih: TBitBtn;
    img1: TImage;
    procedure btnkeluarClick(Sender: TObject);
    procedure edttahunKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnlihatClick(Sender: TObject);
    procedure rb1lick(Sender: TObject);
    procedure rb2Click(Sender: TObject);
    procedure btnpilihClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_lapnilai: Tf_lapnilai;

implementation

uses ufrm_bantukepsek, ufrm_dm, ufrm_reportnil;

{$R *.dfm}

procedure Tf_lapnilai.btnkeluarClick(Sender: TObject);
begin
 Close;
end;

procedure Tf_lapnilai.edttahunKeyPress(Sender: TObject; var Key: Char);
begin
 if not (Key in ['0'..'9',#13,#8,#9]) then Key:=#0;
end;

procedure Tf_lapnilai.FormShow(Sender: TObject);
begin
 edttahun.Text := FormatDateTime('yyyy',Now);
 edit_mati([edtnip,edtnama]); btnpilih.Enabled:=False;
 rb1.Checked:=False; rb2.Checked:=False;
 edit_kosong([edtnip,edtnama]);
end;

procedure Tf_lapnilai.btnlihatClick(Sender: TObject);
var sss : string;
begin
 if edttahun.Text='' then
  begin
    MessageDlg('Tahun Belum Disi',mtWarning,[mbOK],0);
    edttahun.SetFocus; Exit;
  end
  else
  begin
    if (rb1.Checked=False) and (rb2.Checked=False) then
     begin
       MessageDlg('Jenis Laporan Belum Dipilih',mtWarning,[mbok],0);
       Exit;
     end
     else
     begin
       pencarian_data(dm.qry3,'q_rangking',['tahun'],edttahun.Text);
       if dm.qry3.IsEmpty then
        begin
          MessageDlg('Data Tidak Ada',mtInformation,[mbok],0);
          edttahun.SetFocus; Exit;
        end
        else
        begin
         if rb1.Checked=True then
          begin
            sss := 'select * from q_rangking where tahun='+QuotedStr(edttahun.Text)+
                   ' order by kd_proses asc, kd_kriteria asc';
          end
          else
         if rb2.Checked=True then
          begin
            if edtnip.Text='' then
             begin
               MessageDlg('Calon Kepala Sekolah Belum Dipilih',mtWarning,[mbok],0);
               btnpilih.SetFocus; Exit;
             end
             else
             begin
              sss := ' select * from q_rangking where tahun='+QuotedStr(edttahun.Text)+
                     ' and nip='+QuotedStr(edtnip.Text)+' order by kd_kriteria asc';
             end;
          end;

         with f_reportnil do
          begin
            with qry1 do
             begin
               Close;
               SQL.Text := sss;
               Open;
             end;

            konek_awal(dm.qry3,'t_jawab','nip'); 
            QRLabelbulan.Caption :='Nama Kota, '+bulan(Now);
            QRLabeljabatan.Caption := dm.qry3['jabatan'];
            QRLabelnama.Caption    := dm.qry3['nama'];
            QRLabelnip.Caption     := dm.qry3['nip'];
            Preview;
          end;
        end;
     end;
  end;
end;

procedure Tf_lapnilai.rb1lick(Sender: TObject);
begin
 btnpilih.Enabled := False;
 edit_kosong([edtnip,edtnama]);
end;

procedure Tf_lapnilai.rb2Click(Sender: TObject);
begin
 btnpilih.Enabled := True;
 edit_kosong([edtnip,edtnama]);
end;

procedure Tf_lapnilai.btnpilihClick(Sender: TObject);
begin
  f_bantukepsek.edt1.Text := 'lap';
  f_bantukepsek.ShowModal;
end;

end.
