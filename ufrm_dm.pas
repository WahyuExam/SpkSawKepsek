unit ufrm_dm;

interface

uses
  SysUtils, Classes, DB, ADODB, XPMan;

type
  Tdm = class(TDataModule)
    con1: TADOConnection;
    XPManifest1: TXPManifest;
    qry1: TADOQuery;
    ds1: TDataSource;
    qryckepsek: TADOQuery;
    dsckepsek: TDataSource;
    qry3: TADOQuery;
    qryckepsekNIP: TWideStringField;
    qryckepseknm_ckepsek: TWideStringField;
    qryckepsekjab_ckepsek: TWideStringField;
    qryckepsektmp_lhir_ckepsek: TWideStringField;
    qryckepsektgl_lhir_ckepsek: TDateTimeField;
    qryckepsekalmt_ckepsek: TWideStringField;
    qryckepsekno_hp_ckepsek: TWideStringField;
    qry2: TADOQuery;
    ds2: TDataSource;
    qry4: TADOQuery;
    ds3: TDataSource;
    qrynilbesar: TADOQuery;
    qryrangking: TADOQuery;
    dsrangking: TDataSource;
    qryrangkingkd_proses: TWideStringField;
    qryrangkingtahun: TWideStringField;
    qryrangkingnip: TWideStringField;
    qryrangkingnm_ckepsek: TWideStringField;
    qryrangkingnilai_saw: TFloatField;
    qryrangkingNo: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{$R *.dfm}

end.
