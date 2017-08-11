unit ufrm_rangking;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, lib_ku, ExtCtrls, DBGrids, jpeg;

type
  Tf_rangking = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp2: TGroupBox;
    edttahun: TEdit;
    btnproses: TBitBtn;
    btnkeluar: TBitBtn;
    btnbersih: TBitBtn;
    lbl2: TLabel;
    bvl1: TBevel;
    dbgrd1: TDBGrid;
    StringGrid1: TStringGrid;
    img1: TImage;
    procedure btnprosesClick(Sender: TObject);
    procedure btnkeluarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnbersihClick(Sender: TObject);
    procedure edttahunKeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure dbgrd1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure TampilGrid;
    procedure SAW;
  end;

var
  f_rangking: Tf_rangking;
  act                      : Integer;
  save                     : Word;
  iii, nnn, mmm            : Integer;
  kriteria, kepala_sekolah : TStringList;

implementation

uses ufrm_dm, DB, ADODB;

{$R *.dfm}

procedure Tf_rangking.btnprosesClick(Sender: TObject);
begin
 pencarian_data(dm.qry3,'t_rangking',['tahun'],edttahun.Text);
 if dm.qry3.IsEmpty then
  begin
    MessageDlg('Tidak Ada Penilaian Pada Tahun ini',mtInformation,[mbok],0);
    edttahun.SetFocus; Exit;
  end
  else
  begin
    with dm.qry3 do
     begin
       Close;
       SQL.Clear;
       sql.Text := 'select * from t_rangking where tahun='+QuotedStr(edttahun.Text)+' and nilai_saw=0';
       Open;
       if not IsEmpty then SAW;
     end;

    //TampilGrid;
    with dm.qryrangking do
     begin
      Close;
      SQL.Text := 'select a.kd_proses, a.tahun, b.nip, b.nm_ckepsek, a.nilai_saw '+
                  'from t_rangking a, t_kepsek b where tahun='+QuotedStr(edttahun.Text)+
                  'and a.nip=b.nip order by a.nilai_saw desc';
      Open;
     end;

    MessageDlg('Proses Perhitungan Selesai',mtInformation,[mbOK],0);
    btnbersih.Enabled:=True; btn_mati([btnproses,btnkeluar]);
    edttahun.Enabled:=False;
  end;
end;

procedure Tf_rangking.btnkeluarClick(Sender: TObject);
begin
 act := (sender as TBitBtn).Tag;
 Close;
end;

procedure Tf_rangking.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if act=1 then
  begin
    Action := caFree;
    Exit;
  end
  else
  action := caNone;
end;

procedure Tf_rangking.FormShow(Sender: TObject);
begin
 edttahun.Text := FormatDateTime('yyyy',Now);
 edttahun.Enabled := True; edttahun.SetFocus;
 StringGrid1.RowCount := 1; StringGrid1.ColCount := 1;
 StringGrid1.Cells[0,0] := ' ';
 btnbersih.Enabled:=False; btn_hidup([btnproses,btnkeluar]);

 with dm.qryrangking do
  begin
    Close;
    SQL.Text := 'select a.kd_proses, a.tahun, b.nip, b.nm_ckepsek, a.nilai_saw '+
                'from t_rangking a, t_kepsek b where tahun='+QuotedStr('kosong')+'';
    Open;
  end;
end;

procedure Tf_rangking.btnbersihClick(Sender: TObject);
begin
 FormShow(Sender);
end;

procedure Tf_rangking.edttahunKeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9',#13,#8,#9]) then Key:=#0;
end;

procedure Tf_rangking.TampilGrid;
var tes : TStringList;
begin
 pencarian_data(dm.qry1,'t_rangking',['tahun'],edttahun.Text);
 konek_awal(dm.qry3,'t_kriteria','kd_kriteria');
 with StringGrid1 do
  begin
    ColCount := dm.qry3.RecordCount + 4;
    RowCount := dm.qry1.RecordCount + 1;
    FixedCols := 0; FixedRows :=1;

    //judul
    Cells[0,0] := 'No';
    Cells[1,0] := 'NIP';
    Cells[2,0] := 'Calon Kepala Sekolah';

    for iii := 1 to dm.qry3.RecordCount do
     begin
       dm.qry3.RecNo := iii;
       Cells[iii+2,0] := dm.qry3.Fieldbyname('kd_kriteria').AsString;
     end;

    Cells[dm.qry3.RecordCount+3,0] := 'Nilai SAW';
    ColWidths[0] := 25;
    ColWidths[2] := 150;
    //////////////////////////////////

    kepala_sekolah := TStringList.Create;
    with dm.qry1 do
     begin
       Close;
       SQL.Clear;
       sql.Text := 'select * from t_rangking where tahun='+QuotedStr(edttahun.Text)+' order by nilai_saw desc';
       Open;
       for iii := 1 to RecordCount do
        begin
         dm.qry1.RecNo := iii;
         kepala_sekolah.Add(dm.qry1.fieldbyname('kd_proses').AsString);
        end;
     end;

    kriteria := TStringList.Create;
    konek_awal(dm.qry1,'t_kriteria','kd_kriteria');
    for iii := 1 to dm.qry1.RecordCount do
     begin
       dm.qry1.RecNo := iii;
       kriteria.Add(dm.qry1.fieldbyname('kd_kriteria').AsString);
     end;

    for iii := 0 to kepala_sekolah.Count-1 do
     begin
      with dm.qry1 do
       begin
         Close;
         SQL.Clear;
         sql.Text := 'select * from q_rangking where kd_proses='+QuotedStr(kepala_sekolah[iii])+'';
         Open;
       end;

      StringGrid1.Cells[0,iii+1] := IntToStr(iii+1);
      StringGrid1.Cells[1,iii+1] := dm.qry1.fieldbyname('nip').AsString;
      StringGrid1.Cells[2,iii+1] := dm.qry1.fieldbyname('nm_ckepsek').AsString;

      for mmm := 0 to kriteria.Count-1 do
       begin
        with dm.qry1 do
         begin
          close;
          SQL.Clear;
          sql.Text :=' select * from q_rangking where kd_proses='+QuotedStr(kepala_sekolah[iii])+
                     ' and kd_kriteria='+QuotedStr(kriteria[mmm])+'';
          Open;
         end;

        with StringGrid1 do
         begin
          Cells[mmm+3,iii+1] := dm.qry1.fieldbyname('bbt_sub').AsString
         end;
       end;

      StringGrid1.Cells[dm.qry3.RecordCount+3,iii+1] := dm.qry1.fieldbyname('nilai_saw').AsString
     end
  end;

  kriteria.Free;
  kepala_sekolah.Free;
end;

procedure Tf_rangking.SAW;
var hasil         : Real;
    tampung       : string;
    nilai_tertinggi, hasil_bagi, bobot : TStringList;
begin
 //tampung kriteria;
 kriteria := TStringList.Create;
 konek_awal(dm.qry3,'t_kriteria','kd_kriteria');
 with dm.qry3 do
  begin
   for iii := 1 to RecordCount do
    begin
      RecNo := iii;
      kriteria.Add(fieldbyname('kd_kriteria').AsString);
    end;
  end;

 //tampung nilai tertinggi setiap kepala sekolah;
 nilai_tertinggi := TStringList.Create;
 for iii:= 0 to kriteria.Count-1 do
  begin
   with dm.qry3 do
    begin
     close;
     SQL.Clear;
     SQL.Text := 'select max (bbt_sub) as mak'+IntToStr(iii+1)+' from q_rangking '+
                 'where kd_kriteria='+QuotedStr(kriteria[iii])+' and tahun='+QuotedStr(edttahun.Text)+'';
     Open;
     if FieldByName('mak'+IntToStr(iii+1)).AsString='0' then tampung:='1' else tampung := fieldbyname('mak'+IntToStr(iii+1)).AsString;
     nilai_tertinggi.Add(tampung);
    end;
  end;

 //tampung kepala sekolah
 kepala_sekolah := TStringList.Create;
 pencarian_data(dm.qry3,'t_rangking',['tahun'],edttahun.Text);
 with dm.qry3 do
  begin
   for iii := 1 to RecordCount do
    begin
     RecNo := iii;
     kepala_sekolah.Add(fieldbyname('kd_proses').AsString);
    end;
  end;

  //tampung bobot;
 bobot := TStringList.Create;
 konek_awal(dm.qry3,'t_kriteria','kd_kriteria');
 with dm.qry3 do
  begin
   for iii := 1 to RecordCount do
    begin
     RecNo := iii;
     bobot.Add(fieldbyname('bbt_kriteria').AsVariant / 100);
    end;
  end;

  //perhitungan SAW
 for iii:=0 to kepala_sekolah.Count-1 do
  begin
   hasil := 0;
   hasil_bagi := TStringList.Create;
   for mmm:=0 to kriteria.Count-1 do
    begin
     with dm.qry3 do
      begin
       Close;
       //SQL.Clear;
       SQL.Text := 'select * from q_rangking where kd_proses='+QuotedStr(kepala_sekolah[iii])+
                   'and kd_kriteria='+QuotedStr(kriteria[mmm])+'';
       Open;
       hasil_bagi.Add(fieldbyname('bbt_sub').AsVariant / nilai_tertinggi[mmm]);
      end;
    end;

    for nnn:=0 to bobot.Count-1 do
     begin
      hasil := hasil + (StrToFloat(hasil_bagi[nnn]) * StrToFloat(bobot[nnn]));
     end;

   ubah_data(dm.qry3,'t_rangking',['nilai_saw'],[FloatToStr(hasil)],'kd_proses',kepala_sekolah[iii]);
  end;

  kriteria.Free;
  nilai_tertinggi.Free;
  kepala_sekolah.Free;
  hasil_bagi.Free;
  bobot.Free;
end;

procedure Tf_rangking.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
{  var a,xi       : Integer;
      savedalign : word;
      judul      : TStringList;     }
begin
 { judul := TStringList.Create;
  judul.Add('No');
  judul.Add('NIP');
  judul.Add('Calon Kepala Sekolah');

  konek_awal(dm.qry3,'t_kriteria','kd_kriteria');
  for a:=1 to dm.qry3.RecordCount do
   begin
     dm.qry3.RecNo := a;
     judul.Add(dm.qry3.fieldbyname('kd_kriteria').AsString);
   end;

 judul.Add('Nilai SAW');

 for a:=0 to judul.Count-1 do
  begin
   if (ACol=a) and (ARow=0) then
    begin
      StringGrid1.Canvas.Font.Style := [fsBold];
      StringGrid1.Canvas.Font.Size := 11;
      StringGrid1.Canvas.Font.Name := 'Times New Roman';

      //rata tengah
      savedalign := SetTextAlign(StringGrid1.Canvas.Handle, TA_CENTER or  VTA_CENTER);
      xi := (Rect.Right - Rect.Left) div 2;
      StringGrid1.Canvas.TextRect(Rect, Rect.Left + xi, Rect.Top+3,judul[a]);
      SetTextAlign(StringGrid1.Canvas.Handle, savedalign);
    end;
  end;

  for a:=1 to StringGrid1.RowCount do
   begin
    if (ACol=0) and (ARow=a) then
     begin
      savedalign := SetTextAlign(StringGrid1.Canvas.Handle, TA_CENTER or  VTA_CENTER);
      xi := (Rect.Right - Rect.Left) div 2;
      StringGrid1.Canvas.TextRect(Rect, Rect.Left + xi, Rect.Top+3,StringGrid1.Cells[acol,arow]);
      SetTextAlign(StringGrid1.Canvas.Handle, savedalign);
     end;
   end;                               }
end;


procedure Tf_rangking.dbgrd1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
 if dm.dsrangking.DataSet.RecNo > 0 then
  begin
  if Column.Title.Caption = 'No' then
   begin
    dbgrd1.Canvas.TextOut(Rect.Left + ((Rect.Right - Rect.Left) div 2), Rect.Top,
                          IntToStr(dm.dsrangking.DataSet.RecNo));
   end;
  end;
end;

end.
