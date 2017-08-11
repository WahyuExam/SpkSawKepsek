program App_Kepsek_SAW;

uses
  Forms,
  ufrm_menu in 'ufrm_menu.pas' {f_menu},
  ufrm_dm in 'ufrm_dm.pas' {dm: TDataModule},
  ufrm_ckepsek in 'ufrm_ckepsek.pas' {f_ckepsek},
  ufrm_kriteriabbt in 'ufrm_kriteriabbt.pas' {f_kriteriabbt},
  ufrm_subkriteria in 'ufrm_subkriteria.pas' {f_subkriteria},
  ufrm_ubahsandi in 'ufrm_ubahsandi.pas' {f_ubahsandi},
  ufrm_jawab in 'ufrm_jawab.pas' {f_jawab},
  ufrm_salindata in 'ufrm_salindata.pas' {f_salin},
  ufrm_penilaian in 'ufrm_penilaian.pas' {f_penilaian},
  ufrm_bantukepsek in 'ufrm_bantukepsek.pas' {f_bantukepsek},
  ufrm_rangking in 'ufrm_rangking.pas' {f_rangking},
  ufrm_login in 'ufrm_login.pas' {f_login},
  ufrm_lapsubkriteria in 'ufrm_lapsubkriteria.pas' {f_lap_sub},
  ufrm_reportsub in 'ufrm_reportsub.pas' {f_reportsub: TQuickRep},
  ufrm_lapnilai in 'ufrm_lapnilai.pas' {f_lapnilai},
  ufrm_reportnil in 'ufrm_reportnil.pas' {f_reportnil: TQuickRep},
  ufrm_laprangking in 'ufrm_laprangking.pas' {f_laprang},
  ufrm_reportrang in 'ufrm_reportrang.pas' {f_rang: TQuickRep};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tf_login, f_login);
  Application.CreateForm(Tf_menu, f_menu);
  Application.CreateForm(Tf_ckepsek, f_ckepsek);
  Application.CreateForm(Tf_kriteriabbt, f_kriteriabbt);
  Application.CreateForm(Tf_subkriteria, f_subkriteria);
  Application.CreateForm(Tf_ubahsandi, f_ubahsandi);
  Application.CreateForm(Tf_jawab, f_jawab);
  Application.CreateForm(Tf_salin, f_salin);
  Application.CreateForm(Tf_penilaian, f_penilaian);
  Application.CreateForm(Tf_bantukepsek, f_bantukepsek);
  Application.CreateForm(Tf_rangking, f_rangking);
  Application.CreateForm(Tf_lap_sub, f_lap_sub);
  Application.CreateForm(Tf_reportsub, f_reportsub);
  Application.CreateForm(Tf_lapnilai, f_lapnilai);
  Application.CreateForm(Tf_reportnil, f_reportnil);
  Application.CreateForm(Tf_laprang, f_laprang);
  Application.CreateForm(Tf_rang, f_rang);
  Application.Run;
end.
