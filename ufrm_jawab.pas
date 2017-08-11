unit ufrm_jawab;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, lib_ku, jpeg, ExtCtrls;

type
  Tf_jawab = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp2: TGroupBox;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    edtnip: TEdit;
    edtnama: TEdit;
    edtjabatan: TEdit;
    grp3: TGroupBox;
    btnsimpan: TBitBtn;
    btnubah: TBitBtn;
    btnkeluar: TBitBtn;
    img1: TImage;
    procedure btnubahClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnkeluarClick(Sender: TObject);
    procedure btnsimpanClick(Sender: TObject);
    procedure edtnamaChange(Sender: TObject);
    procedure edtnipKeyPress(Sender: TObject; var Key: Char);
    procedure edtnamaKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_jawab: Tf_jawab;
  nip : string;
  act : Integer;

implementation

uses ufrm_dm;

{$R *.dfm}

procedure Tf_jawab.btnubahClick(Sender: TObject);
begin
 if btnubah.Caption='Ubah' then
  begin
   edit_hidup([edtnip,edtnama,edtjabatan]);
   btn_hidup([btnubah,btnsimpan]); btnkeluar.Enabled:=False;
   btnubah.Caption:='Batal'; edtnip.SetFocus;
  end
  else
 if btnubah.Caption='Batal' then FormShow(Sender);
end;

procedure Tf_jawab.FormCreate(Sender: TObject);
begin
 konek_awal(dm.qry1,'t_jawab','NIP');
 with dm.qry1 do
  begin
    edtnip.Text     := fieldbyname('nip').AsString;
    edtnama.Text    := Fieldbyname('nama').AsString;
    edtjabatan.Text := fieldbyname('jabatan').asstring;
    nip             := edtnip.Text;
  end;
end;

procedure Tf_jawab.FormShow(Sender: TObject);
begin
 edit_mati([edtnip,edtnama,edtjabatan]);

 btn_hidup([btnubah,btnkeluar]); btnsimpan.Enabled:=False;
 btnubah.Caption:='Ubah';
end;

procedure Tf_jawab.btnkeluarClick(Sender: TObject);
begin
 act := (sender as TBitBtn).Tag;
 close;
end;

procedure Tf_jawab.btnsimpanClick(Sender: TObject);
begin
 if (Trim(edtnip.Text)='') or (Trim(edtnama.Text)='') or (Trim(edtjabatan.Text)='') then
  begin
    MessageDlg('Semua Data Harus Diisi',mtWarning,[mbok],0);
    if edtnip.Text='' then edtnip.SetFocus else
    if Trim(edtnama.Text)='' then edtnama.SetFocus else
    if Trim(edtjabatan.Text)='' then edtjabatan.SetFocus;
    Exit;
  end;

 if MessageDlg('Yakin Data Akan Diubah',mtConfirmation,[mbYes,mbNo],0)=mryes then
  begin
    ubah_data(dm.qry1,'t_jawab',['nip','nama','jabatan'],[edtnip.Text,edtnama.Text,
             edtjabatan.Text],'nip',nip);
    FormCreate(Sender);
    MessageDlg('Data Sudah Diubah',mtInformation,[mbok],0);
    FormShow(Sender);
  end;
end;

procedure Tf_jawab.edtnamaChange(Sender: TObject);
begin
 HurufBesar(Sender);
end;

procedure Tf_jawab.edtnipKeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9',#13,#8,#9]) then Key:=#0;
 if Key=#13 then
  SelectNext(sender as TWinControl, True, True);
end;

procedure Tf_jawab.edtnamaKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#13,#8,#9,#32,'a'..'z','A'..'Z','-','.',',','''']) then Key:=#0;
 if Key=#13 then
  SelectNext(sender as TWinControl, True, True);
end;

procedure Tf_jawab.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if act=1 then
   begin
     Action := caFree;
     Exit;
   end
   else
   Action := caNone;
end;

end.
