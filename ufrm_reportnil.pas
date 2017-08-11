unit ufrm_reportnil;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB;

type
  Tf_reportnil = class(TQuickRep)
    qry1: TADOQuery;
    grpfooter: TQRBand;
    QRShape6: TQRShape;
    TitleBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRShape1: TQRShape;
    QRLabeljudul: TQRLabel;
    DetailBand1: TQRBand;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRGroup1: TQRGroup;
    QRLabel3: TQRLabel;
    QRShape2: TQRShape;
    QRLabel4: TQRLabel;
    QRShape3: TQRShape;
    QRLabel5: TQRLabel;
    QRDBText3: TQRDBText;
    SummaryBand1: TQRBand;
    QRLabelbulan: TQRLabel;
    QRLabeljabatan: TQRLabel;
    QRLabelnama: TQRLabel;
    QRLabelnip: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBText4: TQRDBText;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRDBText5: TQRDBText;
    QRShape7: TQRShape;
    QRLabel9: TQRLabel;
    QRShape8: TQRShape;
    QRDBText6: TQRDBText;
    QRLabel10: TQRLabel;
    QRShape9: TQRShape;
    QRDBText7: TQRDBText;
  private

  public

  end;

var
  f_reportnil: Tf_reportnil;

implementation

{$R *.DFM}

end.
