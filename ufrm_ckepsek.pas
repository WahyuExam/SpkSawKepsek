unit ufrm_ckepsek;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ComCtrls, DB, lib_ku, jpeg,
  ExtCtrls;

type
  Tf_ckepsek = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp2: TGroupBox;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    edtnip: TEdit;
    edtnm: TEdit;
    edtjabatan: TEdit;
    edttempa: TEdit;
    edtnohp: TEdit;
    dtptgllahir: TDateTimePicker;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    grp3: TGroupBox;
    btncampur: TBitBtn;
    btnsimpan: TBitBtn;
    btnubah: TBitBtn;
    btnhapus: TBitBtn;
    btnkeluar: TBitBtn;
    grp4: TGroupBox;
    grp5: TGroupBox;
    dbgrd1: TDBGrid;
    lbl14: TLabel;
    lbl15: TLabel;
    edtcari: TEdit;
    mmoalamat: TMemo;
    img1: TImage;
    procedure btnkeluarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btncampurClick(Sender: TObject);
    procedure btnsimpanClick(Sender: TObject);
    procedure dtptgllahirCloseUp(Sender: TObject);
    procedure edtcariChange(Sender: TObject);
    procedure btnhapusClick(Sender: TObject);
    procedure edtnipKeyPress(Sender: TObject; var Key: Char);
    procedure edtnmChange(Sender: TObject);
    procedure edtnmKeyPress(Sender: TObject; var Key: Char);
    procedure mmoalamatChange(Sender: TObject);
    procedure dbgrd1CellClick(Column: TColumn);
    procedure edtcariClick(Sender: TObject);
    procedure dbgrd1DblClick(Sender: TObject);
    procedure btnubahClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Konek(status:Boolean);
  end;

var
  f_ckepsek: Tf_ckepsek;
  status : Boolean;
  nip, nama, jabatan, tempat, tgl, alamat, no_hp : string;
  act : Integer;

implementation

uses ufrm_dm;

{$R *.dfm}

procedure Tf_ckepsek.btnkeluarClick(Sender: TObject);
begin
// act := (sender as TBitBtn).Tag;
 close;
end;

procedure Tf_ckepsek.FormShow(Sender: TObject);
begin
 edit_kosong([edtnip,edtnm,edtjabatan,edttempa,edtnohp,edtcari]);
 edit_mati([edtnip,edtnm,edtjabatan,edttempa,edtnohp]);
 mmoalamat.Clear; mmoalamat.Enabled:=false;
 dtptgllahir.Format :=' '; dtptgllahir.Enabled:= False;

 btn_mati([btnsimpan,btnubah,btnhapus]); btn_hidup([btncampur,btnkeluar]);
 btncampur.Caption:='Tambah';
 tgl := '';

 dbgrd1.Enabled:=True; edtcari.Enabled:=True;
end;

procedure Tf_ckepsek.FormCreate(Sender: TObject);
begin
 Konek(True);
end;

procedure Tf_ckepsek.Konek(status: Boolean);
begin
 if status=True then konek_awal(dm.qryckepsek,'t_kepsek','NIP') else
 if status=False then pencarian_data(dm.qryckepsek,'t_kepsek',['NIP','nm_ckepsek'],edtcari.Text);
end;

procedure Tf_ckepsek.btncampurClick(Sender: TObject);
begin
 if btncampur.Caption='Tambah' then
  begin
    FormShow(Sender);
    edit_hidup([edtnip,edtnm,edtjabatan,edttempa,edtnohp]);
    dtptgllahir.Enabled:=True; dtptgllahir.Date:=Now;
    mmoalamat.Enabled:=True; edtnip.SetFocus;

    edtcari.Enabled:=False; dbgrd1.Enabled:=false;
    btncampur.Caption:='Batal';
    btn_hidup([btncampur,btnsimpan]); btn_mati([btnubah,btnhapus,btnkeluar]);
    status := True;
  end
  else
 if btncampur.Caption='Batal' then FormShow(Sender);
end;

procedure Tf_ckepsek.btnsimpanClick(Sender: TObject);
begin
 if (edtnip.Text='') or (Trim(edtnm.Text)='') or (Trim(edtjabatan.Text)='') or
    (Trim(edttempa.Text)='') or (tgl='') or (Trim(mmoalamat.Text)='') or (edtnohp.Text='') then
    begin
      MessageDlg('Semua Data Harus Diisi',mtWarning,[mbOK],0);
      if edtnip.Text='' then edtnip.SetFocus else
      if Trim(edtnm.Text)='' then edtnm.SetFocus else
      if Trim(edtjabatan.Text)='' then edtjabatan.SetFocus else
      if Trim(edttempa.Text)='' then edttempa.SetFocus else
      if tgl='' then dtptgllahir.SetFocus else
      if Trim(mmoalamat.Text)='' then mmoalamat.SetFocus else
      if edtnohp.Text='' then edtnohp.SetFocus;
      Exit;
    end;

 with dm.qryckepsek do
  begin
    if status=True then
     begin
       if Locate('nip',edtnip.Text,[]) then
        begin
          MessageDlg('Data Sudah Ada',mtWarning,[mbOK],0);
          edtnip.SetFocus;
          Exit;
        end
        else
       if Locate('nm_ckepsek;jab_ckepsek;tmp_lhir_ckepsek;almt_ckepsek;no_hp_ckepsek;tgl_lhir_ckepsek',
          VarArrayOf([edtnm.Text,edtjabatan.Text,edttempa.Text,mmoalamat.Text,edtnohp.Text,DateToStr(dtptgllahir.Date)]),[]) then
         begin
          MessageDlg('Data Sudah Ada',mtWarning,[mbOK],0);
          edtnip.SetFocus;
          Exit;
         end;

       simpan_data(dm.qryckepsek,'t_kepsek',['nip','nm_ckepsek','jab_ckepsek','tmp_lhir_ckepsek',
                  'tgl_lhir_ckepsek','almt_ckepsek','no_hp_ckepsek'],[edtnip.Text,edtnm.Text,
                   edtjabatan.Text,edttempa.Text,DateToStr(dtptgllahir.Date),mmoalamat.Text,edtnohp.Text]);
       FormCreate(Sender);
       MessageDlg('Data Sudah Disimpan',mtInformation,[mbok],0);
       FormShow(Sender);
     end
     else
    if status=False then
     begin
       if (nama=edtnm.Text) and (edtjabatan.Text=jabatan) and (edttempa.Text=tempat)
          and (tgl=DateToStr(dtptgllahir.Date)) and (mmoalamat.Text=alamat) and (edtnohp.Text=no_hp) then
          begin
            FormShow(Sender);
            Exit;
          end
       else
       if (nama<>edtnm.Text) or (edtjabatan.Text<>jabatan) or (edttempa.Text<>tempat)
          or (tgl<>DateToStr(dtptgllahir.Date)) or (mmoalamat.Text<>alamat) or (edtnohp.Text=no_hp) then
          begin
           if Locate('nm_ckepsek;jab_ckepsek;tmp_lhir_ckepsek;almt_ckepsek;no_hp_ckepsek;tgl_lhir_ckepsek',
              VarArrayOf([edtnm.Text,edtjabatan.Text,edttempa.Text,mmoalamat.Text,edtnohp.Text,DateToStr(dtptgllahir.Date)]),[]) then
             begin
              MessageDlg('Data Sudah Ada',mtWarning,[mbOK],0);
              Exit;
             end
            else
             begin
              ubah_data(dm.qryckepsek,'t_kepsek',['nm_ckepsek','jab_ckepsek','tmp_lhir_ckepsek',
                       'tgl_lhir_ckepsek','almt_ckepsek','no_hp_ckepsek'],[edtnm.Text,
                        edtjabatan.Text,edttempa.Text,DateToStr(dtptgllahir.Date),
                        mmoalamat.Text,edtnohp.Text],'nip',nip);
              FormCreate(Sender);
              MessageDlg('Data Sudah Diubah',mtInformation,[mbok],0);
              FormShow(Sender);
             end;
          end;
     end;
  end;
end;

procedure Tf_ckepsek.dtptgllahirCloseUp(Sender: TObject);
begin
 tgl := DateToStr(dtptgllahir.Date);
 dtptgllahir.Format := 'dd/MM/yyyy';
end;

procedure Tf_ckepsek.edtcariChange(Sender: TObject);
begin
 if edtcari.Text='' then Konek(True) else Konek(False);
end;

procedure Tf_ckepsek.btnhapusClick(Sender: TObject);
begin
 if MessageDlg('Yakin Data Akan Dihapus ?',mtConfirmation,[mbYes,mbNo],0)=mryes then
  begin
    hapus_data(dm.qryckepsek,'t_kepsek','nip',edtnip.Text);
    FormCreate(Sender);
    MessageDlg('Data Sudah Dihapus',mtInformation,[mbOK],0);
    FormShow(Sender);
  end;
end;

procedure Tf_ckepsek.edtnipKeyPress(Sender: TObject; var Key: Char);
begin
 if not (Key in ['0'..'9',#13,#8,#9]) then Key:=#0;
 if Key=#13 then
  SelectNext(sender as TWinControl, True, True);
end;

procedure Tf_ckepsek.edtnmChange(Sender: TObject);
begin
 HurufBesar(Sender);
end;

procedure Tf_ckepsek.edtnmKeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['a'..'z','A'..'Z',#13,#8,#9,#32,',','.','''','-','_']) then Key:=#0;
 if Key=#13 then
  SelectNext(sender as TWinControl, True, True);
end;

procedure Tf_ckepsek.mmoalamatChange(Sender: TObject);
begin
 HurufBesarM(Sender);
end;

procedure Tf_ckepsek.dbgrd1CellClick(Column: TColumn);
begin
 if Trim(dbgrd1.Fields[0].AsString)='' then Exit else
  begin
    edtnip.Text     := dbgrd1.Fields[0].AsString; nip     := edtnip.Text;
    edtnm.Text      := dbgrd1.Fields[1].AsString; nama    := edtnm.Text;
    edtjabatan.Text := dbgrd1.Fields[2].AsString; jabatan := edtjabatan.Text;
    edttempa.Text   := dbgrd1.Fields[3].AsString; tempat  := edttempa.Text;
    mmoalamat.Text  := dbgrd1.Fields[5].AsString; alamat  := mmoalamat.Text;
    edtnohp.Text    := dbgrd1.Fields[6].AsString; no_hp   := edtnohp.Text;
    dtptgllahir.Format := 'dd/MM/yyyy';
    dtptgllahir.Date   := StrToDate(dbgrd1.Fields[4].AsString);
    tgl                := DateToStr(dtptgllahir.Date);
  end;
end;

procedure Tf_ckepsek.edtcariClick(Sender: TObject);
begin
 FormShow(Sender);
end;

procedure Tf_ckepsek.dbgrd1DblClick(Sender: TObject);
begin
 if Trim(dbgrd1.Fields[0].AsString)='' then Exit;
 btn_hidup([btnubah,btnhapus,btncampur]); btn_mati([btnsimpan,btnkeluar]);
 dbgrd1.Enabled:=False; edtcari.Clear; edtcari.Enabled:=False;
 btncampur.Caption:='Batal';
 TDateField(dm.qry1.FieldByName('tgl_lhir_ckepsek')).DisplayFormat := 'dd/MM/yyyy';
end;

procedure Tf_ckepsek.btnubahClick(Sender: TObject);
begin
 edit_hidup([edtnm,edtjabatan,edttempa,edtnohp]);
 mmoalamat.Enabled:=True; dtptgllahir.Enabled:=True; edtnm.SetFocus;

 btn_hidup([btncampur,btnsimpan]); btn_mati([btnubah,btnhapus,btnkeluar]);
 status := False;
end;

procedure Tf_ckepsek.FormClose(Sender: TObject; var Action: TCloseAction);
begin
{ if act=1 then
  begin
    Action := caFree;
    Exit;
  end
  else
  Action := caNone;   }
end;

end.
