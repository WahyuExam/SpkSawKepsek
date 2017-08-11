unit ufrm_subkriteria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, Grids, DBGrids, StdCtrls, Buttons, lib_ku, jpeg,
  ExtCtrls;

type
  Tf_subkriteria = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp2: TGroupBox;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    edtkodesub: TEdit;
    edtsubkriteria: TEdit;
    edtbbt_sub: TEdit;
    grp3: TGroupBox;
    btncampur: TBitBtn;
    btnsimpan: TBitBtn;
    btnubah: TBitBtn;
    btnhapus: TBitBtn;
    btnkeluar: TBitBtn;
    grp4: TGroupBox;
    dbgrd1: TDBGrid;
    dblkcbbkriteria: TDBLookupComboBox;
    img1: TImage;
    procedure btnkeluarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btncampurClick(Sender: TObject);
    procedure dblkcbbkriteriaCloseUp(Sender: TObject);
    procedure btnsimpanClick(Sender: TObject);
    procedure btnhapusClick(Sender: TObject);
    procedure dbgrd1CellClick(Column: TColumn);
    procedure dbgrd1DblClick(Sender: TObject);
    procedure btnubahClick(Sender: TObject);
    procedure edtsubkriteriaChange(Sender: TObject);
    procedure edtsubkriteriaKeyPress(Sender: TObject; var Key: Char);
    procedure edtbbt_subKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_subkriteria: Tf_subkriteria;
  status : Boolean;
  kode, subkriteria, kriteria, bbt : string;
  act : Integer;

implementation

uses ufrm_dm;

{$R *.dfm}

procedure Tf_subkriteria.btnkeluarClick(Sender: TObject);
begin
// act := (Sender as TBitBtn).tag;
 close;
end;

procedure Tf_subkriteria.FormCreate(Sender: TObject);
begin
 konek_awal(dm.qry1,'q_kriteria','kd_sub_kriteria');
 konek_awal(dm.qry2,'t_kriteria','kd_kriteria');
 konek_awal(dm.qry3,'t_sub_kriteria','kd_sub_kriteria');
end;

procedure Tf_subkriteria.FormShow(Sender: TObject);
begin
 FormCreate(Sender);
 edit_kosong([edtkodesub,edtsubkriteria,edtbbt_sub]);
 edit_mati([edtkodesub,edtsubkriteria,edtbbt_sub]);
 dblkcbbkriteria.Enabled:=False; dblkcbbkriteria.KeyValue:=null;

 dbgrd1.Enabled:=True;
 btn_hidup([btncampur,btnkeluar]); btn_mati([btnsimpan,btnubah,btnhapus]);
 btncampur.Caption:='Tambah';
end;

procedure Tf_subkriteria.btncampurClick(Sender: TObject);
begin
 if btncampur.Caption='Tambah' then
  begin
    FormShow(Sender);
    edtkodesub.Text := kode_oto('t_sub_kriteria','kd_sub_kriteria','SK',2,dm.qry3);
    edit_hidup([edtsubkriteria,edtbbt_sub]);
    dblkcbbkriteria.Enabled:=True; dblkcbbkriteria.SetFocus; dbgrd1.Enabled:=False;

    btn_hidup([btncampur,btnsimpan]); btn_mati([btnubah,btnhapus,btnkeluar]);
    btncampur.Caption:='Batal'; status:= True;
  end
  else
 if btncampur.Caption='Batal' then FormShow(Sender);
end;

procedure Tf_subkriteria.dblkcbbkriteriaCloseUp(Sender: TObject);
begin
 if dblkcbbkriteria.KeyValue=null then Exit else
  begin
    pencarian_data(dm.qry1,'q_kriteria',['kd_kriteria'],dblkcbbkriteria.KeyValue);
    edtsubkriteria.SetFocus;
  end;
end;

procedure Tf_subkriteria.btnsimpanClick(Sender: TObject);
begin
 if (dblkcbbkriteria.KeyValue=null) or (Trim(edtsubkriteria.Text)='') or (edtbbt_sub.Text='') then
  begin
    MessageDlg('Semua Data Harus Diisi',mtWarning,[mbOK],0);
    if dblkcbbkriteria.KeyValue=null then dblkcbbkriteria.SetFocus else
    if Trim(edtsubkriteria.Text)='' then edtsubkriteria.SetFocus else
    if edtbbt_sub.Text='' then edtbbt_sub.SetFocus;
    Exit;
  end;

 with dm.qry3 do
  begin
    if status=True then
     begin
       if Locate('kd_kriteria;nm_sub_kriteria',VarArrayOf([dblkcbbkriteria.KeyValue,edtsubkriteria.Text]),[]) then
        begin
          MessageDlg('Nama Subkriteria Sudah Ada Pada Kriteria ini',mtWarning,[mbOK],0);
          edtsubkriteria.SetFocus; Exit;
        end;

       if Locate('kd_kriteria;bbt_sub',VarArrayOf([dblkcbbkriteria.KeyValue,edtbbt_sub.Text]),[]) then
        begin
          MessageDlg('Bobot Nilai Subkriteria Sudah Ada Pada Kriteria ini',mtWarning,[mbOK],0);
          edtbbt_sub.SetFocus; Exit;
        end;

       simpan_data(dm.qry3,'t_sub_kriteria',['kd_kriteria','kd_sub_kriteria',
                  'nm_sub_kriteria','bbt_sub'],[dblkcbbkriteria.KeyValue,edtkodesub.Text,
                  edtsubkriteria.Text,edtbbt_sub.Text]);
       FormCreate(Sender);
       MessageDlg('Data Sudah Disimpan',mtInformation,[mbok],0);
       FormShow(Sender);
     end
     else
    if status=False then
     begin
       if (edtsubkriteria.Text=subkriteria) and (edtbbt_sub.Text=bbt) then
        begin
          FormShow(Sender);
          Exit;
        end
        else
       if (edtsubkriteria.Text<>subkriteria) or (edtbbt_sub.Text<>bbt) then
        begin
          if edtsubkriteria.Text<>subkriteria then
           begin
             if Locate('kd_kriteria;nm_sub_kriteria',VarArrayOf([dblkcbbkriteria.KeyValue,edtsubkriteria.Text]),[]) then
              begin
                MessageDlg('Nama Subkriteria Sudah Ada Pada Kriteria ini',mtWarning,[mbOK],0);
                edtsubkriteria.SetFocus; edtsubkriteria.Text:=subkriteria; Exit;
              end;
           end;

          if edtbbt_sub.Text<>bbt then
           begin
             if Locate('kd_kriteria;bbt_sub',VarArrayOf([dblkcbbkriteria.KeyValue,edtbbt_sub.Text]),[]) then
              begin
                MessageDlg('Bobot Nilai Subkriteria Sudah Ada Pada Kriteria ini',mtWarning,[mbOK],0);
                edtbbt_sub.SetFocus; edtbbt_sub.Text:=bbt; Exit;
              end;
           end;

          ubah_data(dm.qry3,'t_sub_kriteria',['nm_sub_kriteria','bbt_sub'],[edtsubkriteria.Text,edtbbt_sub.Text],
                   'kd_sub_kriteria',edtkodesub.Text);
          FormCreate(Sender);
          MessageDlg('Data Sudah Diubah',mtInformation,[mbok],0);
          FormShow(Sender);
        end;
     end;
  end;
end;

procedure Tf_subkriteria.btnhapusClick(Sender: TObject);
begin
 if MessageDlg('Apakah Data Akan Dihapus ?',mtConfirmation,[mbyes,mbNo],0)=mryes then
  begin
    hapus_data(dm.qry3,'t_sub_kriteria','kd_sub_kriteria',edtkodesub.Text);
    FormCreate(Sender);
    MessageDlg('Data Sudah Dihapus',mtInformation,[mbOK],0);
    FormShow(Sender);
  end;
end;

procedure Tf_subkriteria.dbgrd1CellClick(Column: TColumn);
begin
 if trim(dbgrd1.Fields[0].AsString)='' then Exit;
 edtkodesub.Text          := dbgrd1.Fields[0].AsString;
 edtsubkriteria.Text      := dbgrd1.Fields[1].AsString;
 edtbbt_sub.Text          := dbgrd1.Fields[2].AsString;
 dblkcbbkriteria.KeyValue := dbgrd1.Fields[4].AsString;

 kode        := edtkodesub.Text;
 kriteria    := dblkcbbkriteria.KeyValue;
 subkriteria := edtsubkriteria.Text;
 bbt         := edtbbt_sub.Text;
end;

procedure Tf_subkriteria.dbgrd1DblClick(Sender: TObject);
begin
 if Trim(dbgrd1.Fields[0].AsString)='' then Exit else
  begin
    btn_hidup([btnubah,btnhapus,btncampur]);
    btn_mati([btnsimpan,btnkeluar]); btncampur.Caption:='Batal';
  end;
end;

procedure Tf_subkriteria.btnubahClick(Sender: TObject);
begin
 edit_hidup([edtsubkriteria,edtbbt_sub]); edtsubkriteria.SetFocus;
 btn_mati([btnubah,btnhapus,btnkeluar]); btn_hidup([btncampur,btnsimpan]);
 status:=False;
end;

procedure Tf_subkriteria.edtsubkriteriaChange(Sender: TObject);
begin
 HurufBesar(Sender);
end;

procedure Tf_subkriteria.edtsubkriteriaKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not (key in ['0'..'9','A'..'Z','a'..'z',#13,#32,#8,#9,'-','>','<','=']) then Key:=#0;
 if Key=#13 then
  SelectNext(sender as TWinControl, True, True);
end;

procedure Tf_subkriteria.edtbbt_subKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not (key in ['0'..'9','.',#13,#8,#9]) then Key:=#0;
 if Key=#13 then
  SelectNext(sender as TWinControl, True, True);
end;

procedure Tf_subkriteria.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
{ if act=1 then
  begin
    Action := caFree;
    Exit;
  end
  else
  Action := caNone;  }
end;

end.
