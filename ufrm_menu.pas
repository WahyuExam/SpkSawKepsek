unit ufrm_menu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, ComCtrls, ExtCtrls, lib_ku, jpeg;

type
  Tf_menu = class(TForm)
    mm1: TMainMenu;
    Master1: TMenuItem;
    CalonKepalaSekolah1: TMenuItem;
    Kriteria1: TMenuItem;
    ransaksi1: TMenuItem;
    NilauSubKriteria1: TMenuItem;
    PenilaianCalonKepalaSekolah1: TMenuItem;
    PerangkinganCalonKepalaSekolah1: TMenuItem;
    Laporan1: TMenuItem;
    Pengaturan1: TMenuItem;
    Keluar1: TMenuItem;
    UbahKataSandi1: TMenuItem;
    PanggildanKembalikanDatabase1: TMenuItem;
    UbahPenanggungJawab1: TMenuItem;
    NilaiSubKriteria1: TMenuItem;
    PenilananCalonKepalaSekolah1: TMenuItem;
    PerangkinganCalonKepalaSekolah2: TMenuItem;
    stat1: TStatusBar;
    il1: TImageList;
    tmr1: TTimer;
    img1: TImage;
    procedure Keluar1Click(Sender: TObject);
    procedure CalonKepalaSekolah1Click(Sender: TObject);
    procedure Kriteria1Click(Sender: TObject);
    procedure NilauSubKriteria1Click(Sender: TObject);
    procedure UbahKataSandi1Click(Sender: TObject);
    procedure UbahPenanggungJawab1Click(Sender: TObject);
    procedure PanggildanKembalikanDatabase1Click(Sender: TObject);
    procedure PenilaianCalonKepalaSekolah1Click(Sender: TObject);
    procedure PerangkinganCalonKepalaSekolah1Click(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure stat1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure NilaiSubKriteria1Click(Sender: TObject);
    procedure PenilananCalonKepalaSekolah1Click(Sender: TObject);
    procedure PerangkinganCalonKepalaSekolah2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_menu: Tf_menu;

implementation

uses ufrm_ckepsek, ufrm_kriteriabbt, ufrm_subkriteria, ufrm_ubahsandi,
     ufrm_jawab, ufrm_salindata, ufrm_penilaian, ufrm_rangking,
     ufrm_lapsubkriteria, ufrm_lapnilai, ufrm_laprangking;

{$R *.dfm}

procedure Tf_menu.Keluar1Click(Sender: TObject);
begin
 Application.Terminate;
end;

procedure Tf_menu.CalonKepalaSekolah1Click(Sender: TObject);
begin
 f_ckepsek.ShowModal;
end;

procedure Tf_menu.Kriteria1Click(Sender: TObject);
begin
 f_kriteriabbt.ShowModal;
end;

procedure Tf_menu.NilauSubKriteria1Click(Sender: TObject);
begin
  f_subkriteria.ShowModal;
end;

procedure Tf_menu.UbahKataSandi1Click(Sender: TObject);
begin
 f_ubahsandi.ShowModal;
end;

procedure Tf_menu.UbahPenanggungJawab1Click(Sender: TObject);
begin
 f_jawab.ShowModal;
end;

procedure Tf_menu.PanggildanKembalikanDatabase1Click(Sender: TObject);
begin
 f_salin.ShowModal;
end;

procedure Tf_menu.PenilaianCalonKepalaSekolah1Click(Sender: TObject);
begin
  f_penilaian.ShowModal;
end;

procedure Tf_menu.PerangkinganCalonKepalaSekolah1Click(Sender: TObject);
var form : Tf_rangking;
begin
  form := Tf_rangking.Create(nil);
  try
    form.ShowModal;
  finally
    form.Free;
  end;
  //f_rangking.ShowModal;
end;

procedure Tf_menu.tmr1Timer(Sender: TObject);
begin
 stat1.Panels[3].Text := bulan(now);
end;

procedure Tf_menu.FormShow(Sender: TObject);
begin
 stat1.Panels[1].Text := 'Admin';
end;

procedure Tf_menu.stat1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
 il1.Draw(stat1.Canvas,Rect.Left+5,Rect.Top+2,Panel.Index);
end;

procedure Tf_menu.NilaiSubKriteria1Click(Sender: TObject);
begin
  f_lap_sub.ShowModal;
end;

procedure Tf_menu.PenilananCalonKepalaSekolah1Click(Sender: TObject);
begin
 f_lapnilai.ShowModal;
end;

procedure Tf_menu.PerangkinganCalonKepalaSekolah2Click(Sender: TObject);
begin
  f_laprang.ShowModal;
end;

end.
