unit UChart;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, TAGraph, TADbSource,
  TASeries;

type

  { TfrmChart }

  TfrmChart = class(TForm)
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    DbChartSource1: TDbChartSource;
  private

  public

  end;

var
  frmChart: TfrmChart;

implementation

{$R *.lfm}

end.

