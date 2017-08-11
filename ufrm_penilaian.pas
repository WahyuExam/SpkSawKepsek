unit ufrm_penilaian;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, StdCtrls, DBCtrls, Buttons, lib_ku,
  jpeg;

type
  Tf_penilaian = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp2: TGroupBox;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    edttahun: TEdit;
    edtnip: TEdit;
    edtnama: TEdit;
    grp3: TGroupBox;
    grp4: TGroupBox;
    btncampur: TBitBtn;
    btnsimpan: TBitBtn;
    btnubah: TBitBtn;
    btnhapus: TBitBtn;
    btnkeluar: TBitBtn;
    grp5: TGroupBox;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    edtkriteria: TEdit;
    dblkcbbnilai: TDBLookupComboBox;
    btnset: TBitBtn;
    btnulang: TBitBtn;
    btnpilih: TBitBtn;
    dbgrd1: TDBGrid;
    img1: TImage;
    procedure btnkeluarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edttahunKeyPress(Sender: TObject; var Key: Char);
    procedure btnpilihClick(Sender: TObject);
    procedure btncampurClick(Sender: TObject);
    procedure btnsimpanClick(Sender: TObject);
    procedure dbgrd1CellClick(Column: TColumn);
    procedure dbgrd1DblClick(Sender: TObject);
    procedure btnulangClick(Sender: TObject);
    procedure btnsetClick(Sender: TObject);
    procedure btnhapusClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnubahClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure konek (status : Boolean);
    procedure SimpanBantu (status : Boolean);
    procedure Bantu;
    function CekStatus : Boolean;

  end;

var
  f_penilaian: Tf_penilaian;
  kode_proses, kode_sub : string;
  status,cek            : Boolean;
  act                   : Integer;

implementation

uses ufrm_dm, ufrm_bantukepsek;

{$R *.dfm}

procedure Tf_penilaian.btnkeluarClick(Sender: TObject);
begin
// act := (Sender as TBitBtn).Tag;
 cek := True;
 Close;
end;

procedure Tf_penilaian.FormShow(Sender: TObject);
begin
 edit_kosong([edttahun,edtnip,edtnama,edtkriteria]); edtkriteria.Enabled:=false;
 edit_mati([edtnip,edtnama]);
 edttahun.Text:=FormatDateTime('yyyy',Now); kode_proses := '';

 btn_hidup([btncampur,btnkeluar]); btncampur.Caption:='Tambah';
 btn_mati([btnsimpan,btnubah,btnhapus,btnset,btnubah,btnulang]);
 btnpilih.Enabled:=True; btnpilih.SetFocus;

 dbgrd1.Enabled:=false;
 dblkcbbnilai.Enabled:=false; dblkcbbnilai.KeyValue:=null;
 konek(True);
end;

procedure Tf_penilaian.FormCreate(Sender: TObject);
begin
 konek_awal(dm.qry4,'t_sub_kriteria','kd_sub_kriteria');
 cek := False;
end;

procedure Tf_penilaian.konek(status: Boolean);
var aaa : string;
begin
 if status=True then aaa := 'kosong' else
 if status=False then aaa := kode_proses;

 with dm.qry1 do
  begin
    close;
    SQL.Clear;
    SQL.Text := 'select * from q_penilaian_bantu where kd_proses='+QuotedStr(aaa)
                +' order by kd_kriteria asc';
    Open;
  end;
end;

procedure Tf_penilaian.edttahunKeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9',#13,#8,#9]) then key:=#0;
 if key=#13 then btnpilih.SetFocus;
end;

procedure Tf_penilaian.btnpilihClick(Sender: TObject);
begin
  konek_awal(dm.qryckepsek,'t_kepsek','nip');
  if dm.qryckepsek.IsEmpty then
   begin
     MessageDlg('Data Kosong',mtWarning,[mbok],0);
     Exit;
   end;

  hapus_data(dm.qry3,'t_bantu_nilai','kd_proses',kode_proses);
  f_bantukepsek.edt1.Text := 'nilai'; f_bantukepsek.ShowModal;
  btn_mati([btnubah,btnhapus]); konek(True);
end;

procedure Tf_penilaian.btncampurClick(Sender: TObject);
begin
 if btncampur.Caption='Tambah' then
  begin
   if edtnip.Text='' then
    begin
     MessageDlg('Calon Kepala Sekolah Belum Dipilih',mtWarning,[mbok],0);
     btnpilih.Click;
     Exit;
    end;

   konek_awal(dm.qry3,'t_rangking','kd_proses');
   with dm.qry3 do
    begin
      if Locate('tahun;nip',VarArrayOf([edttahun.Text,edtnip.Text]),[]) then
       begin
         MessageDlg('Calon Kepala Sekolah Sudah Dinilai Pada Tahun ini ',mtInformation,[mbOK],0);
         btn_hidup([btnubah,btnhapus,btncampur]);
         kode_proses:=fieldbyname('kd_proses').AsString;
         hapus_data(dm.qry3,'t_bantu_nilai','kd_proses',kode_proses);
         SimpanBantu(True); Exit;
       end;
    end;

   kode_proses := kode_oto('t_rangking','kd_proses','P',3,dm.qry3);
   simpan_data(dm.qry3,'t_rangking',['kd_proses','tahun','nip','nilai_saw'],
              [kode_proses,edttahun.Text,edtnip.Text,'0']);
   hapus_data(dm.qry3,'t_bantu_nilai','kd_proses',kode_proses);
   SimpanBantu(False);

   btncampur.Caption:='Batal'; status:=True; edttahun.Enabled:=False;
   btn_hidup([btncampur,btnsimpan]);
   btn_mati([btnubah,btnhapus,btnkeluar,btnset,btnubah,btnpilih]);
   dbgrd1.Enabled:=True;
  end
  else
 if btncampur.Caption='Batal' then
  begin
    if status=True then
     begin
       hapus_data(dm.qry3,'t_rangking','kd_proses',kode_proses);
       //FormShow(Sender);
     end;
    FormShow(Sender);
  end;
end;

procedure Tf_penilaian.btnsimpanClick(Sender: TObject);
begin
 if CekStatus=True then
  begin
    MessageDlg('Semua Kriteria Harus Dinilai',mtWarning,[mbOk],0);
    Exit;
  end
  else
  begin
   hapus_data(dm.qry3,'t_bantu_nilai','kd_proses',kode_proses);
   FormCreate(Sender);
   MessageDlg('Data Sudah Disimpan',mtInformation,[mbOK],0);
   FormShow(Sender);
  end;
end;

function Tf_penilaian.CekStatus: Boolean;
var ada, ket : Boolean;
begin
 with dm.qry1 do
  begin
   konek(False);
   ket := False;
   First;
   while ket=False do
    begin
     if FieldByName('status').AsString='' then
      begin
       ada  := True;
       ket  := True;
      end
     else
     begin
      ada := False;
      if Eof then ket:=True else Next;
     end;
    end;
  end;
  Result := ada;
end;

procedure Tf_penilaian.dbgrd1CellClick(Column: TColumn);
begin
 edtkriteria.Text := dbgrd1.Fields[1].AsString;
 pencarian_data(dm.qry4,'t_sub_kriteria',['kd_kriteria'],dbgrd1.Fields[3].AsString);
 konek_awal(dm.qry3,'q_rangking','kd_proses');
 with dm.qry3 do
  begin
    if Locate('kd_proses;kd_kriteria',VarArrayOf([kode_proses,dbgrd1.Fields[3].AsString]),[]) then
     begin
      dblkcbbnilai.KeyValue:= fieldbyname('kd_sub_kriteria').AsString;
      kode_sub             := fieldbyname('kd_sub_kriteria').AsString;
     end;
  end;
end;

procedure Tf_penilaian.dbgrd1DblClick(Sender: TObject);
begin
 dbgrd1CellClick(dbgrd1.Columns[0]);
 dblkcbbnilai.Enabled:=True; dbgrd1.Enabled:=False;
 btn_hidup([btnset,btnulang]); btn_mati([btncampur,btnsimpan]);
end;

procedure Tf_penilaian.btnulangClick(Sender: TObject);
begin
 dbgrd1.Enabled:=True; edtkriteria.Clear;
 dblkcbbnilai.KeyValue:=null; dblkcbbnilai.Enabled:=False;
 btn_mati([btnset,btnulang]); btn_hidup([btncampur,btnsimpan]);
end;

procedure Tf_penilaian.btnsetClick(Sender: TObject);
begin
 if dblkcbbnilai.Text='' then
  begin
    MessageDlg('Penilaian Belum Diberikan',mtWarning,[mbok],0);
    dblkcbbnilai.SetFocus; Exit;
  end;

 if status=True then
  begin
   ubah_data(dm.qry3,'t_bantu_nilai',['status'],['Sudah Dinilai'],'kd_kriteria',dbgrd1.Fields[3].AsString);
   simpan_data(dm.qry3,'t_penilaian',['kd_proses','kd_sub_kriteria'],[kode_proses,dblkcbbnilai.KeyValue]);
   konek(False);
   if CekStatus=True then dbgrd1DblClick(Sender) else
    begin
      btncampur.Enabled := True;
      Bantu;
    end;
  end
  else
  begin
   if kode_sub <> dblkcbbnilai.KeyValue then
    begin
     if MessageDlg('Apakah Penilaian Akan Diubah ?',mtConfirmation,[mbYes,mbNo],0)=mryes then
      begin
       with dm.qry3 do
        begin
         close;
         SQL.Clear;
         sql.Text := 'update t_penilaian set kd_sub_kriteria = '+QuotedStr(dblkcbbnilai.KeyValue)+
                     ' where kd_proses='+QuotedStr(kode_proses)+' and kd_sub_kriteria='+QuotedStr(kode_sub)+'';
         ExecSQL;
        end;
        btncampur.Enabled:=false;
      end;
    end;
   konek(False);
   Bantu;
  end;
end;

procedure Tf_penilaian.SimpanBantu(status: Boolean);
var iii : Integer;
begin
  konek_awal(dm.qry2,'t_kriteria','kd_kriteria');
  with dm.qry2 do
   begin
    for iii:=1 to RecordCount do
     begin
      RecNo := iii;

      if status=True then
       begin
        simpan_data(dm.qry3,'t_bantu_nilai',['kd_proses','kd_kriteria','status'],
                   [kode_proses,FieldByName('kd_kriteria').AsString,'Sudah Dinilai']);
       end
      else
      begin
       simpan_data(dm.qry3,'t_bantu_nilai',['kd_proses','kd_kriteria'],
                  [kode_proses,FieldByName('kd_kriteria').AsString]);
      end;
     end;
   end;
  konek(false);
end;

procedure Tf_penilaian.btnhapusClick(Sender: TObject);
begin
 if MessageDlg('Yakin Data Akan Dihapus ?',mtInformation,[mbYes,mbNo],0)=mryes then
  begin
    hapus_data(dm.qry3,'t_rangking','kd_proses',kode_proses);
    MessageDlg('Data Sudah Dihapus',mtInformation,[mbOK],0);
    FormShow(Sender);
  end;
end; 

procedure Tf_penilaian.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
{ if act = 1 then
  begin
    Action := caFree;
    Exit;
    //Self.Free;
  end
  else
  Action := caNone;   }
end;

procedure Tf_penilaian.btnubahClick(Sender: TObject);
begin
 status            := False;
 dbgrd1.Enabled    := True;
 edttahun.Enabled  := False;
 btncampur.Caption :='Batal';
 btn_mati([btnubah,btnhapus,btnkeluar,btnset,btnulang,btnpilih]);
 btn_hidup([btncampur,btnsimpan]);
end;

procedure Tf_penilaian.Bantu;
begin
 btnsimpan.Enabled := True;
 btn_mati([btnset,btnulang]);
 edtkriteria.Clear; dblkcbbnilai.KeyValue:=Null; dblkcbbnilai.Enabled:=False;
 dbgrd1.Enabled:=True;
end;

procedure Tf_penilaian.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 if cek=False then CanClose:=False else CanClose:=True;
end;

end.
