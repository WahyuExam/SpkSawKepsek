unit ufrm_reportrang;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  Tf_rang = class(TQuickRep)
    TitleBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRShape1: TQRShape;
    QRLabeljudul: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBText4: TQRDBText;
    DetailBand1: TQRBand;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRDBText2: TQRDBText;
    QRShape8: TQRShape;
    QRDBText6: TQRDBText;
    SummaryBand1: TQRBand;
    QRLabelbulan: TQRLabel;
    QRLabeljabatan: TQRLabel;
    QRLabelnama: TQRLabel;
    QRLabelnip: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRShape2: TQRShape;
    QRLabel4: TQRLabel;
    QRShape7: TQRShape;
    QRLabel9: TQRLabel;
    QRShape3: TQRShape;
    QRLabel5: TQRLabel;
    QRShape6: TQRShape;
    QRLabel3: TQRLabel;
    QRShape9: TQRShape;
    QRDBText3: TQRDBText;
    QRSysData1: TQRSysData;
    QRShape10: TQRShape;
  private

  public

  end;

var
  f_rang: Tf_rang;

implementation

uses ufrm_dm;

{$R *.DFM}

end.
