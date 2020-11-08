unit Ustatdetails;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  Menus, UGamedetail, uPlayerAgainstTeam, UClasses, ZDataset;

type

  { TfrmStatDetails }

  TfrmStatDetails = class(TForm)
    Button1: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    MenuItem1: TMenuItem;
    PopupMenu1: TPopupMenu;
    ZQuery1: TZQuery;
    ZQuery2: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
  private

  public
    year: integer;
    player_id:integer;
  end;

var
  frmStatDetails: TfrmStatDetails;

implementation

{$R *.lfm}

{ TfrmStatDetails }

procedure TfrmStatDetails.FormShow(Sender: TObject);
var
  GridTools: TGridTools;
begin
  ZQuery1.Close;
  ZQuery1.ParamByName('player_id').AsInteger   :=player_id;
  ZQuery1.ParamByName('year').AsInteger        :=year;
  ZQuery1.Open;

  ZQuery2.Close;
  ZQuery2.ParamByName('player_id').AsInteger   :=player_id;
  ZQuery2.ParamByName('year').AsInteger        :=year;
  ZQuery2.Open;

  GridTools := TGridTools.Create;
  try
    GridTools.Initialize(self, ZQuery2);
  finally
   GridTools.Free;
  end;
end;

procedure TfrmStatDetails.MenuItem1Click(Sender: TObject);
begin
  if frmPlayerAgainstTeam = nil then
     frmPlayerAgainstTeam := TfrmPlayerAgainstTeam.Create(Application);

  with frmPlayerAgainstTeam do
  begin
    player_id   := Self.ZQuery1['player_id'];
    opponent    := self.ZQuery1['opponent'];

    ShowModal;
  end;
end;

procedure TfrmStatDetails.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 27) or (Key = 81) then Close;
  if key = 13 then DBGrid1DblClick(nil);
end;

procedure TfrmStatDetails.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DBGrid2.SelectedIndex:=DBGrid1.SelectedIndex;
end;

procedure TfrmStatDetails.DBGrid2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     DBGrid1.SelectedIndex:=DBGrid2.SelectedIndex;
end;

procedure TfrmStatDetails.DBGrid1DblClick(Sender: TObject);
begin
  if self.ZQuery1.RecordCount <> 0 then
  begin
    if frmGameDetail = nil then
       frmGameDetail := TfrmGameDetail.Create(self);

    with frmGameDetail do
    begin
      game_id := self.ZQuery1['game_id'];
      ShowModal;
    end;

  end;
end;

procedure TfrmStatDetails.Button1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin                        
  if (Key = 27) or (Key = 81) then Close;
end;

procedure TfrmStatDetails.Button1Click(Sender: TObject);
begin
  ShowMessage('Comming Soon...');
end;

end.

