unit ustats;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, ComCtrls,
  StdCtrls, Ustatdetails, UClasses, UChart, ZDataset;

type

  { TfrmStats }

  TfrmStats = class(TForm)
    Button1: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    ZQuery1: TZQuery;
    ZQuery2: TZQuery;
    ZQuery3: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure DBGrid2KeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure DBGrid3KeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private

  public
    player_id: integer;
  end;

var
  frmStats: TfrmStats;

implementation

{$R *.lfm}

{ TfrmStats }

procedure TfrmStats.DBGrid1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if Key = 13 then
    DBGrid1DblClick(nil);
  if (Key = 27) or (Key = 81) then
    Close;
end;

procedure TfrmStats.DBGrid1KeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  DBGrid2.SelectedIndex := DBGrid1.SelectedIndex;
  DBGrid3.SelectedIndex := DBGrid1.SelectedIndex;
end;

procedure TfrmStats.DBGrid2KeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  DBGrid1.SelectedIndex := DBGrid2.SelectedIndex;
  DBGrid3.SelectedIndex := DBGrid2.SelectedIndex;
end;

procedure TfrmStats.DBGrid3KeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  DBGrid1.SelectedIndex := DBGrid3.SelectedIndex;
  DBGrid2.SelectedIndex := DBGrid3.SelectedIndex;
end;

procedure TfrmStats.DBGrid1DblClick(Sender: TObject);
begin
  if frmStatDetails = nil then
    frmStatDetails := TfrmStatDetails.Create(self);

  with frmStatDetails do
  begin
    player_id := self.ZQuery1['player_id'];
    year := self.ZQuery1['year'];

    ShowModal;
  end;
end;

procedure TfrmStats.Button1Click(Sender: TObject);
begin
  if frmChart = nil then
    frmChart := TfrmChart.Create(application);

  with frmChart do
  begin
<<<<<<< HEAD
    DbChartSource1.DataSource := self.DataSource1;
    DbChartSource1.FieldX := 'Year';
    DbChartSource1.FieldY := 'Rate';
    Chart1LineSeries1.ListSource.CopyFrom(DbChartSource1);
    try
      ShowModal;

    finally
      DbChartSource1.Reset;
    end;
=======

       DbChartSource1.DataSource := self.DataSource1;
       DbChartSource1.FieldX:= 'Year';
       DbChartSource1.FieldY:= 'Rate';
       Chart1LineSeries1.ListSource.CopyFrom(DbChartSource1);
       try
          ShowModal;

       finally
              DbChartSource1.Reset;
       end;
>>>>>>> 8e80e302dcd59c8312ed35bc151140e36bdc135d
  end;
end;

procedure TfrmStats.Button1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if (Key = 27) or (Key = 81) then
    Close;
end;

procedure TfrmStats.FormShow(Sender: TObject);
var
  GridTools: TGridTools;
begin
  ZQuery1.Close;
  ZQuery1.ParamByName('player_id').AsInteger := player_id;
  ZQuery1.Open;

  ZQuery2.Close;
  ZQuery2.ParamByName('player_id').AsInteger := player_id;
  ZQuery2.Open;

  ZQuery3.Close;
  ZQuery3.ParamByName('player_id').AsInteger := player_id;
  ZQuery3.Open;

  GridTools := TGridTools.Create;
  try
    GridTools.Initialize(self, ZQuery3);
  finally
    GridTools.Free;
  end;
end;

end.





