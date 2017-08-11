unit ufrm_reportsub;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB;

type
  Tf_reportsub = class(TQuickRep)
    qry1: TADOQuery;
    grpfooter: TQRBand;
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRShape1: TQRShape;
    QRGroup1: TQRGroup;
    QRLabel3: TQRLabel;
    QRShape2: TQRShape;
    QRLabel4: TQRLabel;
    QRShape3: TQRShape;
    QRLabel5: TQRLabel;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRShape6: TQRShape;
    SummaryBand1: TQRBand;
    QRLabelbulan: TQRLabel;
    QRLabeljabatan: TQRLabel;
    QRLabelnama: TQRLabel;
    QRLabelnip: TQRLabel;
    QRLabeljudul: TQRLabel;
  private

  public

  end;

var
  f_reportsub: Tf_reportsub;

implementation

uses ufrm_dm;

{$R *.DFM}

end.
