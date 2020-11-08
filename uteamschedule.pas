unit uTeamSchedule;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, DBGrids,
  UGamedetail, ZDataset;

type

  { TfrmTeamSchedule }

  TfrmTeamSchedule = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    ZQuery1: TZQuery;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormShow(Sender: TObject);
  private

  public
   year: string;
   team: string;
  end;

var
  frmTeamSchedule: TfrmTeamSchedule;

implementation

{$R *.lfm}

{ TfrmTeamSchedule }

procedure TfrmTeamSchedule.FormShow(Sender: TObject);
begin
  ZQuery1.close;
  ZQuery1.ParamByName('year').asstring:= year;
  ZQuery1.ParamByName('team').AsString:=team;
  ZQuery1.Open;
end;

procedure TfrmTeamSchedule.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = 27) or (Key = 81)then Close;
  if Key = 13 then DBGrid1DblClick(nil);
end;

procedure TfrmTeamSchedule.DBGrid1DblClick(Sender: TObject);
begin
  if frmGameDetail = nil then
     frmGameDetail := TfrmGameDetail.Create(self);

  with frmGameDetail do
  begin
    game_id:= self.ZQuery1['game_id'];

    ShowModal;
  end;
end;

end.

