unit ufrm_login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, lib_ku, jpeg, ExtCtrls;

type
  Tf_login = class(TForm)
    edtsandi: TEdit;
    btnmasuk: TBitBtn;
    btnkeluar: TBitBtn;
    img1: TImage;
    procedure btnkeluarClick(Sender: TObject);
    procedure btnmasukClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtsandiKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_login: Tf_login;

implementation

uses ufrm_dm, ufrm_menu;

{$R *.dfm}

procedure Tf_login.btnkeluarClick(Sender: TObject);
begin
 Application.Terminate;
end;

procedure Tf_login.btnmasukClick(Sender: TObject);
begin
 if Trim(edtsandi.Text)='' then
  begin
    MessageDlg('Kata Sandi Belum Dimasukkan',mtInformation,[mbok],0);
    edtsandi.SetFocus; Exit;
  end
  else
  begin
    konek_awal(dm.qry3,'t_pengguna','pengguna');
    if dm.qry3['sandi'] <> edtsandi.Text then
     begin
       MessageDlg('Login Gagal, Kata Sandi Salah',mtError,[mbOK],0);
       edtsandi.SetFocus; edtsandi.Clear; Exit;
     end
     else
     begin
       f_menu.ShowModal;
       Self.Close;
     end;
  end;
end;

procedure Tf_login.FormShow(Sender: TObject);
begin
 edtsandi.Clear; edtsandi.SetFocus;
end;

procedure Tf_login.edtsandiKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#13 then btnmasuk.Click;
end;

end.
