unit ufrm_bantukepsek;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, lib_ku, jpeg, ExtCtrls;

type
  Tf_bantukepsek = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp4: TGroupBox;
    dbgrd1: TDBGrid;
    grp3: TGroupBox;
    btncampur: TBitBtn;
    btnkeluar: TBitBtn;
    edt1: TEdit;
    img1: TImage;
    procedure btnkeluarClick(Sender: TObject);
    procedure btncampurClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgrd1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_bantukepsek: Tf_bantukepsek;
  act : Integer;

implementation

uses ufrm_penilaian, ufrm_dm, ufrm_lapnilai;

{$R *.dfm}

procedure Tf_bantukepsek.btnkeluarClick(Sender: TObject);
begin
 //act := (sender as TBitBtn).Tag;
 close;
end;

procedure Tf_bantukepsek.btncampurClick(Sender: TObject);
begin
 if edt1.Text='nilai' then
  begin
   with f_penilaian do
    begin
     edtnip.Text  := Self.dbgrd1.Fields[0].AsString;
     edtnama.Text := Self.dbgrd1.Fields[1].AsString;
    end;
  end
  else
 if edt1.Text='lap' then
  begin
   with f_lapnilai do
    begin
     edtnip.Text  := Self.dbgrd1.Fields[0].AsString;
     edtnama.Text := Self.dbgrd1.Fields[1].AsString;
    end;
  end;

 btnkeluar.Click;
end;

procedure Tf_bantukepsek.FormCreate(Sender: TObject);
begin
  konek_awal(dm.qryckepsek,'t_kepsek','nip');
end;

procedure Tf_bantukepsek.dbgrd1DblClick(Sender: TObject);
begin
 btncampur.Click;
end;

procedure Tf_bantukepsek.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  {if act=2 then
   begin
     Action := caFree;
     Exit;
   end
   else
   Action := caNone;}
end;

end.
