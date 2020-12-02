unit UChart;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, TAGraph,
  TADbSource, TASeries;

type

  { TfrmChart }

  TfrmChart = class(TForm)
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    cmbTypeStat: TComboBox;
    DbChartSource1: TDbChartSource;
    procedure cmbTypeStatChange(Sender: TObject);
    procedure cmbTypeStatKeyDown(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmChart: TfrmChart;

implementation

{$R *.lfm}

{ TfrmChart }

procedure TfrmChart.cmbTypeStatKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if (Key = 27) or (Key = 81) then
    Close;
end;

procedure TfrmChart.FormShow(Sender: TObject);
begin
  cmbTypeStatChange(nil);
end;

procedure TfrmChart.cmbTypeStatChange(Sender: TObject);
begin
  DbChartSource1.FieldX := 'Year';
  case cmbTypeStat.ItemIndex of
    //Passing
    0: DbChartSource1.FieldY := 'Rate';

    //Rushing
    1: DbChartSource1.FieldY := 'Ru.Av';

    //Receiving
    2: DbChartSource1.FieldY := 'Re.Av';

    //Tackles
    3: DbChartSource1.FieldY := 'Comb';

    //Sacks
    4: DbChartSource1.FieldY := 'Scks';

    //Interceptions
    5: DbChartSource1.FieldY := 'Int';

    //Kicking
    6: DbChartSource1.FieldY := 'FG.Pct';

    //Punting
    7: DbChartSource1.FieldY := 'Pu.Av';

    //Returning
    8: DbChartSource1.FieldY := 'KR.Av';
  end;
  Chart1LineSeries1.ListSource.CopyFrom(DbChartSource1);
end;

end.
