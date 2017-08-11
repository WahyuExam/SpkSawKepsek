unit ufrm_kriteriabbt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, lib_ku, jpeg, ExtCtrls;

type
  Tf_kriteriabbt = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp2: TGroupBox;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    edtkode: TEdit;
    edtkriteria: TEdit;
    edtbbt: TEdit;
    grp3: TGroupBox;
    btnsimpan: TBitBtn;
    btnubah: TBitBtn;
    btnkeluar: TBitBtn;
    grp4: TGroupBox;
    dbgrd1: TDBGrid;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    img1: TImage;
    procedure btnkeluarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgrd1CellClick(Column: TColumn);
    procedure btnubahClick(Sender: TObject);
    procedure dbgrd1DblClick(Sender: TObject);
    procedure edtbbtKeyPress(Sender: TObject; var Key: Char);
    procedure edtkriteriaChange(Sender: TObject);
    procedure edtkriteriaKeyPress(Sender: TObject; var Key: Char);
    procedure btnsimpanClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function total_bbt : Integer;
  end;

var
  f_kriteriabbt: Tf_kriteriabbt;
  kode, kriteria : string;
  bbt, ttl, act  : Integer;

implementation

uses ufrm_dm;

{$R *.dfm}

procedure Tf_kriteriabbt.btnkeluarClick(Sender: TObject);
begin
 ttl := total_bbt;
 if ttl < 100 then
  begin
    MessageDlg('Tidak Bisa Keluar Dari Form, Total Bobot Harus 100%',mtWarning,[mbOK],0);
    Exit;
  end;
// act := (Sender as TBitBtn).Tag; 
 Close;
end;

function Tf_kriteriabbt.total_bbt: Integer;
var aaa : Integer;
    ttl : Integer;
begin
  konek_awal(dm.qry1,'t_kriteria','kd_kriteria');
  ttl := 0;
  with dm.qry1 do
   begin
     for aaa:=1 to RecordCount do
      begin
        RecNo := aaa;
        ttl := ttl + fieldbyname('bbt_kriteria').AsInteger;
      end;
   end;
   Result := ttl;
end;

procedure Tf_kriteriabbt.FormCreate(Sender: TObject);
begin
 konek_awal(dm.qry1,'t_kriteria','kd_kriteria');
end;

procedure Tf_kriteriabbt.FormShow(Sender: TObject);
begin
 edit_kosong([edtkode,edtkriteria,edtbbt]);
 edit_mati([edtkode,edtkriteria,edtbbt]);
 dbgrd1.Enabled:=True;

 btn_mati([btnubah,btnsimpan]); btnkeluar.Enabled:=True;
 btnubah.Caption:='Ubah';
 lbl7.Caption := IntToStr(total_bbt)+' %';
 dm.qry1.First;
end;

procedure Tf_kriteriabbt.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
{ if act=1 then
  begin
    Action := caFree;
    Exit;
  end
  else
  Action := caNone;   }
end;

procedure Tf_kriteriabbt.dbgrd1CellClick(Column: TColumn);
begin
  if Trim(dbgrd1.Fields[0].AsString)='' then Exit;
  edtkode.Text     := dbgrd1.Fields[0].AsString; kode     := edtkode.Text;
  edtkriteria.Text := dbgrd1.Fields[1].AsString; kriteria := edtkriteria.Text;
  edtbbt.Text      := dbgrd1.Fields[2].AsString; bbt      := StrToInt(edtbbt.Text)
end;

procedure Tf_kriteriabbt.btnubahClick(Sender: TObject);
begin
 if btnubah.Caption='Ubah' then
  begin
    edit_hidup([edtkriteria,edtbbt]);
    btnubah.Caption:='Batal'; btnkeluar.Enabled:=false; btnsimpan.Enabled:=True;
    edtkriteria.SetFocus;
  end
  else
 if btnubah.Caption='Batal' then FormShow(Sender);
end;

procedure Tf_kriteriabbt.dbgrd1DblClick(Sender: TObject);
begin
 btnubah.Enabled:=True;
end;

procedure Tf_kriteriabbt.edtbbtKeyPress(Sender: TObject; var Key: Char);
begin
 if not (Key in ['0'..'9',#13,#8,#9]) then Key:=#0;
 if key=#13 then
  SelectNext(sender as TWinControl,True,True);
end;

procedure Tf_kriteriabbt.edtkriteriaChange(Sender: TObject);
begin
 HurufBesar(Sender);
end;

procedure Tf_kriteriabbt.edtkriteriaKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not (Key in ['0'..'9','a'..'z','A'..'Z','-',#13,#8,#9,#32]) then Key:=#0;
 if key=#13 then
  SelectNext(sender as TWinControl,True,True);
end;

procedure Tf_kriteriabbt.btnsimpanClick(Sender: TObject);
begin
 if (Trim(edtkriteria.Text)='') or (edtbbt.Text='') then
  begin
    MessageDlg('Semua Data Harus Diisi',mtWarning,[mbok],0);
    if Trim(edtkriteria.Text)='' then edtkriteria.SetFocus else
    if edtbbt.Text='' then edtbbt.SetFocus;
    Exit;
  end;

 if (edtkriteria.Text=kriteria) and (edtbbt.Text=IntToStr(bbt)) then
  begin
   FormShow(Sender); Exit;
  end
 else
 if(edtkriteria.Text<>kriteria) or (edtbbt.Text<>IntToStr(bbt)) then
  begin
   if edtkriteria.Text<>kriteria then
    begin
      if dm.qry1.Locate('nm_kriteria',edtkriteria.Text,[]) then
        begin
         MessageDlg('Nama kriteria Sudah Ada',mtWarning,[mbOK],0);
         edtkriteria.Text := kriteria; edtkriteria.SetFocus;
         Exit;
        end
    end;

    if MessageDlg('Yakin Data Akan Diubah ?',mtConfirmation,[mbYes,mbNo],0)=mryes then
     begin
      ubah_data(dm.qry1,'t_kriteria',['nm_kriteria','bbt_kriteria'],
               [edtkriteria.text,edtbbt.text],'kd_kriteria',edtkode.Text);
      FormCreate(Sender);
      MessageDlg('Data Sudah Diubah',mtInformation,[mbOK],0);
      FormShow(Sender);
     end;
  end;
end;

end.
