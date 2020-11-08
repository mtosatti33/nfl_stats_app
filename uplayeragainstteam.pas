unit uPlayerAgainstTeam;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, DBGrids, DBCtrls,
  StdCtrls, UGamedetail, UClasses, ZDataset;

type

  { TfrmPlayerAgainstTeam }

  TfrmPlayerAgainstTeam = class(TForm)
    Button1: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ZQuery1: TZQuery;
    ZQuery1Games: TLargeintField;
    ZQuery1lost: TLargeintField;
    ZQuery1Opp: TStringField;
    ZQuery1Player: TStringField;
    ZQuery1WinPct: TFloatField;
    ZQuery1won: TLargeintField;
    ZQuery2: TZQuery;
    ZQuery3: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private

  public
    player_id:integer;
    opponent:string;
  end;

var
  frmPlayerAgainstTeam: TfrmPlayerAgainstTeam;

implementation

{$R *.lfm}

{ TfrmPlayerAgainstTeam }

procedure TfrmPlayerAgainstTeam.FormShow(Sender: TObject);
var
  GridTools: TGridTools;
begin
  ZQuery1.Close;
  ZQuery1.ParamByName('player_id').AsInteger:=player_id;
  ZQuery1.ParamByName('opponent').AsString:=opponent;
  ZQuery1.Open;

  ZQuery2.Close;
  ZQuery2.ParamByName('player_id').AsInteger:=player_id;
  ZQuery2.ParamByName('opponent').AsString:=opponent;
  ZQuery2.Open;

  ZQuery3.Close;
  ZQuery3.ParamByName('player_id').AsInteger:=player_id;
  ZQuery3.ParamByName('opponent').AsString:=opponent;
  ZQuery3.Open;

  GridTools := TGridTools.Create;
  try
    GridTools.Initialize(self,ZQuery3);
  finally
   GridTools.Free;
  end;
end;

procedure TfrmPlayerAgainstTeam.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 27) or (Key = 81) then Close;
  if Key = 13 then DBGrid1DblClick(nil);
end;

procedure TfrmPlayerAgainstTeam.DBGrid1DblClick(Sender: TObject);
begin
  if self.ZQuery2.RecordCount <> 0 then
  begin
    if frmGameDetail = nil then
       frmGameDetail := TfrmGameDetail.Create(self);

    with frmGameDetail do
    begin
      game_id := self.ZQuery2['game_id'];
      ShowModal;
    end;

  end;
end;

procedure TfrmPlayerAgainstTeam.Button1Click(Sender: TObject);
begin
  ShowMessage('Comming Soon...');
end;

procedure TfrmPlayerAgainstTeam.Button1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin   
  if (Key = 27) or (Key = 81) then Close;
end;

procedure TfrmPlayerAgainstTeam.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DBGrid2.SelectedIndex:=DBGrid1.SelectedIndex;
end;

procedure TfrmPlayerAgainstTeam.DBGrid2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DBGrid1.SelectedIndex:=DBGrid2.SelectedIndex;
end;

end.

