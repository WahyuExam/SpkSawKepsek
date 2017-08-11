unit ufrm_ubahsandi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, lib_ku, jpeg, ExtCtrls;

type
  Tf_ubahsandi = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp2: TGroupBox;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    edtpengguna: TEdit;
    edtsandilama: TEdit;
    edtsandibaru: TEdit;
    grp3: TGroupBox;
    btnsimpan: TBitBtn;
    btnubah: TBitBtn;
    btnkeluar: TBitBtn;
    img1: TImage;
    procedure btnkeluarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnubahClick(Sender: TObject);
    procedure btnsimpanClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_ubahsandi: Tf_ubahsandi;
  act : Integer;

implementation

uses ufrm_dm;

{$R *.dfm}

procedure Tf_ubahsandi.btnkeluarClick(Sender: TObject);
begin
 act := (sender as TBitBtn).Tag;
 close;
end;

procedure Tf_ubahsandi.FormCreate(Sender: TObject);
begin
 konek_awal(dm.qry1,'t_pengguna','pengguna');
 with dm.qry1 do
  begin
    edtpengguna.Text  := fieldbyname('pengguna').AsString;
    edtsandilama.Text := Fieldbyname('sandi').AsString;
  end;
end;

procedure Tf_ubahsandi.FormShow(Sender: TObject);
begin
 edit_mati([edtpengguna,edtsandilama,edtsandibaru]);
 edtsandibaru.Clear;

 btn_hidup([btnubah,btnkeluar]); btnsimpan.Enabled:=False;
 btnubah.Caption:='Ubah';
end;

procedure Tf_ubahsandi.btnubahClick(Sender: TObject);
begin
 if btnubah.Caption='Ubah' then
  begin
   edtsandibaru.Enabled:=True;
   btn_hidup([btnubah,btnsimpan]); btnkeluar.Enabled:=False;
   btnubah.Caption:='Batal'; edtsandibaru.SetFocus;
  end
  else
 if btnubah.Caption='Batal' then FormShow(Sender);
end;

procedure Tf_ubahsandi.btnsimpanClick(Sender: TObject);
begin
 if Trim(edtsandibaru.Text)='' then
  begin
    MessageDlg('Kata Sandi Baru Belum Diisi',mtWarning,[mbok],0);
    edtsandibaru.SetFocus; Exit;
  end;
  
 if MessageDlg('Yakin Data Akan Diubah',mtConfirmation,[mbYes,mbNo],0)=mryes then
  begin
    ubah_data(dm.qry1,'t_pengguna',['sandi'],[edtsandibaru.Text],'pengguna',edtpengguna.Text);
    FormCreate(Sender);
    MessageDlg('Data Sudah Diubah',mtInformation,[mbok],0);
    FormShow(Sender);
  end;
end;

procedure Tf_ubahsandi.FormClose(Sender: TObject;
  var Action: TCloseAction);
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
