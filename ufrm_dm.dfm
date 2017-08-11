object dm: Tdm
  OldCreateOrder = False
  Left = 808
  Top = 55
  Height = 315
  Width = 454
  object con1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=db_kepsek.mdb;Persi' +
      'st Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 16
    Top = 16
  end
  object XPManifest1: TXPManifest
    Left = 64
    Top = 24
  end
  object qry1: TADOQuery
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select a.kd_proses, a.tahun, b.nip, b.nm_ckepsek, a.nilai_saw fr' +
        'om t_rangking a, t_kepsek b where a.nip=b.nip')
    Left = 16
    Top = 112
  end
  object ds1: TDataSource
    DataSet = qry1
    Left = 56
    Top = 112
  end
  object qryckepsek: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from t_kepsek')
    Left = 296
    Top = 24
    object qryckepsekNIP: TWideStringField
      FieldName = 'NIP'
      Size = 25
    end
    object qryckepseknm_ckepsek: TWideStringField
      FieldName = 'nm_ckepsek'
      Size = 30
    end
    object qryckepsekjab_ckepsek: TWideStringField
      FieldName = 'jab_ckepsek'
      Size = 25
    end
    object qryckepsektmp_lhir_ckepsek: TWideStringField
      FieldName = 'tmp_lhir_ckepsek'
    end
    object qryckepsektgl_lhir_ckepsek: TDateTimeField
      FieldName = 'tgl_lhir_ckepsek'
      DisplayFormat = 'dd/MM/yyyy'
    end
    object qryckepsekalmt_ckepsek: TWideStringField
      FieldName = 'almt_ckepsek'
      Size = 30
    end
    object qryckepsekno_hp_ckepsek: TWideStringField
      FieldName = 'no_hp_ckepsek'
      Size = 12
    end
  end
  object dsckepsek: TDataSource
    DataSet = qryckepsek
    Left = 352
    Top = 32
  end
  object qry3: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select a.kd_proses, a.tahun, b.nip, b.nm_ckepsek, a.nilai_saw fr' +
        'om t_rangking a, t_kepsek b where a.nip=b.nip')
    Left = 16
    Top = 168
  end
  object qry2: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from t_kriteria')
    Left = 304
    Top = 96
  end
  object ds2: TDataSource
    DataSet = qry2
    Left = 344
    Top = 96
  end
  object qry4: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from t_sub_kriteria')
    Left = 304
    Top = 160
  end
  object ds3: TDataSource
    DataSet = qry4
    Left = 344
    Top = 176
  end
  object qrynilbesar: TADOQuery
    Connection = con1
    Parameters = <>
    Left = 96
    Top = 112
  end
  object qryrangking: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select a.kd_proses, a.tahun, b.nip, b.nm_ckepsek, a.nilai_saw fr' +
        'om t_rangking a, t_kepsek b where a.nip=b.nip')
    Left = 304
    Top = 224
    object qryrangkingkd_proses: TWideStringField
      FieldName = 'kd_proses'
      Size = 10
    end
    object qryrangkingtahun: TWideStringField
      FieldName = 'tahun'
      Size = 4
    end
    object qryrangkingnip: TWideStringField
      FieldName = 'nip'
      Size = 25
    end
    object qryrangkingnm_ckepsek: TWideStringField
      FieldName = 'nm_ckepsek'
      Size = 30
    end
    object qryrangkingnilai_saw: TFloatField
      FieldName = 'nilai_saw'
    end
    object qryrangkingNo: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'No'
      Calculated = True
    end
  end
  object dsrangking: TDataSource
    DataSet = qryrangking
    Left = 344
    Top = 224
  end
end
