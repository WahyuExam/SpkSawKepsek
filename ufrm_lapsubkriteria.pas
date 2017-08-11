unit ufrm_lapsubkriteria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, StdCtrls, Buttons, lib_ku, jpeg, ExtCtrls;

type
  Tf_lap_sub = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp2: TGroupBox;
    grp3: TGroupBox;
    btnlihat: TBitBtn;
    btnkeluar: TBitBtn;
    rb1: TRadioButton;
    rb2: TRadioButton;
    dblkcbbkriteria: TDBLookupComboBox;
    img1: TImage;
    procedure btnkeluarClick(Sender: TObject);
    procedure rb1Click(Sender: TObject);
    procedure rb2Click(Sender: TObject);
    procedure btnlihatClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_lap_sub: Tf_lap_sub;

implementation

uses ufrm_dm, ufrm_reportsub;

{$R *.dfm}

procedure Tf_lap_sub.btnkeluarClick(Sender: TObject);
begin
 Close;
end;

procedure Tf_lap_sub.rb1Click(Sender: TObject);
begin
 dblkcbbkriteria.Enabled:=False; dblkcbbkriteria.KeyValue:=Null;
end;

procedure Tf_lap_sub.rb2Click(Sender: TObject);
begin
 konek_awal(dm.qry2,'t_kriteria','kd_kriteria');
 dblkcbbkriteria.Enabled:=True; dblkcbbkriteria.KeyValue:=Null;
 dblkcbbkriteria.SetFocus;
end;

procedure Tf_lap_sub.btnlihatClick(Sender: TObject);
var sss, jjj : string;
begin
 if (rb1.Checked=False) and (rb2.Checked=false) then
  begin
    MessageDlg('Jenis Laporan Belum Dipilih',mtWarning,[mbok],0);
    Exit;
  end
  else
  begin
    if rb1.Checked=True then
     begin
       sss :=' select * from q_kriteria order by kd_kriteria asc, kd_sub_kriteria asc';
       jjj :=' Laporan Nilai Bobot Sub kriteria';
     end
     else
    if rb2.Checked=True then
     begin
       if dblkcbbkriteria.KeyValue=Null then
        begin
          MessageDlg('Kriteria Belum Dipilih',mtWarning,[mbok],0);
          dblkcbbkriteria.SetFocus; Exit;
        end
        else
        begin
          sss := ' select * from q_kriteria where kd_kriteria = '+QuotedStr(dblkcbbkriteria.KeyValue)+
                 ' order by kd_sub_kriteria asc';
          jjj :=' Laporan Nilai Bobot Sub kriteria Perkriteria';
        end;
     end;

    with f_reportsub do
     begin
       with qry1 do
        begin
         Close;
         SQL.Text := sss;
         Open;
        end;

       konek_awal(dm.qry3,'t_jawab','nip');
       QRLabeljudul.Caption   := jjj;
       QRLabelbulan.Caption   := 'Nama Kota, '+bulan(Now);
       QRLabeljabatan.Caption := dm.qry3['jabatan'];
       QRLabelnama.Caption    := dm.qry3['nama'];
       QRLabelnip.Caption     := dm.qry3['nip'];
       Preview;
     end;
  end;
end;

procedure Tf_lap_sub.FormShow(Sender: TObject);
begin
 dblkcbbkriteria.Enabled:=False;
 rb1.Checked:=False; rb2.Checked:=False;
end;

end.
