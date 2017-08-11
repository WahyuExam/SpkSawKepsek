unit ufrm_salindata;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, lib_ku, jpeg, ExtCtrls;

type
  Tf_salin = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp3: TGroupBox;
    btnpanggil: TBitBtn;
    btnsalin: TBitBtn;
    btnkeluar: TBitBtn;
    dlgOpen1: TOpenDialog;
    dlgSave1: TSaveDialog;
    img1: TImage;
    procedure btnkeluarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnsalinClick(Sender: TObject);
    procedure btnpanggilClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_salin: Tf_salin;
  a   : string;
  act : Integer;

implementation

uses ufrm_dm;

{$R *.dfm}

procedure Tf_salin.btnkeluarClick(Sender: TObject);
begin
 act := (sender as TBitBtn).Tag;
 close;
end;

procedure Tf_salin.FormShow(Sender: TObject);
begin
  a := GetCurrentDir+'\db_kepsek.mdb';
end;

procedure Tf_salin.btnsalinClick(Sender: TObject);
begin
 salin_data(dlgSave1,'db_kepsek.mdb',a);
end;

procedure Tf_salin.btnpanggilClick(Sender: TObject);
begin
  panggil_data(dlgOpen1,dm.con1,'db_kepsek.mdb',a); 
end;

procedure Tf_salin.FormClose(Sender: TObject; var Action: TCloseAction);
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
