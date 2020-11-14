unit uTeamStatsByYear;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  ComCtrls, udm, UPlayerInfo, uTeamSchedule, UClasses, db, ZDataset, Grids;

type

  { TfrmTeamStatsByYear }

  TfrmTeamStatsByYear = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    qryYears: TZQuery;
    UpDown1: TUpDown;
    ZQuery1: TZQuery;
    ZQuery2: TZQuery;
    qryTeams: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmTeamStatsByYear: TfrmTeamStatsByYear;

implementation

{$R *.lfm}

{ TfrmTeamStatsByYear }

procedure TfrmTeamStatsByYear.FormShow(Sender: TObject);
var
  GridTools: TGridTools;
begin
  if not qryTeams.Active then qryTeams.Active:=True;
  if not qryYears.Active then qryYears.Active:=True;

  GridTools := TGridTools.Create;
  try
    GridTools.Initialize(self,nil);
  finally
   GridTools.Free;
  end;

  if ComboBox1.Items.Count <> 0 then ComboBox1.Items.Clear;

  qryTeams.First;
  while not qryTeams.EOF do
  begin
      ComboBox1.Items.Add(qryTeams['team']);
      qryTeams.Next;
  end;

  UpDown1.Max:=qryYears['year'];
  Edit1.Text:= IntToStr(UpDown1.Max - 1);
end;

procedure TfrmTeamStatsByYear.ComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 27 then Close;
end;

procedure TfrmTeamStatsByYear.DBGrid1DblClick(Sender: TObject);
begin
  if ZQuery1.RecordCount <> 0 then
  begin
    if frmPlayerInfo = nil then
       frmPlayerInfo := TfrmPlayerInfo.Create(Application);
    with frmPlayerInfo do
    begin
         player_id:= self.ZQuery1['player_id'];

         ShowModal;
    end;
  end;
end;

procedure TfrmTeamStatsByYear.ComboBox1Change(Sender: TObject);
begin
  ZQuery1.Close;
  ZQuery1.ParamByName('team').AsString:=ComboBox1.Text;
  ZQuery1.ParamByName('year').AsString:=Edit1.Text;
  ZQuery1.Open;

  ZQuery2.Close;
  ZQuery2.ParamByName('team').AsString:=ComboBox1.Text;
  ZQuery2.ParamByName('year').AsString:=Edit1.Text;
  ZQuery2.Open;
end;

procedure TfrmTeamStatsByYear.Button1Click(Sender: TObject);
begin
  if ComboBox1.Text <> '' then
  begin
    if frmTeamSchedule = nil then
       frmTeamSchedule := TfrmTeamSchedule.Create(self);

    with frmTeamSchedule do
    begin
      team:=ComboBox1.Text;
      year:=Edit1.Text;

      ShowModal;
    end;
  end;
end;

procedure TfrmTeamStatsByYear.Button2Click(Sender: TObject);
begin
  ShowMessage('Comming Soon...');
end;

procedure TfrmTeamStatsByYear.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = 27) or (Key = 81)then Close;
  if Key = 112 then ComboBox1.SetFocus;
  if Key = 113 then Edit1.SetFocus;
  if Key = 13 then DBGrid1DblClick(nil);
end;

procedure TfrmTeamStatsByYear.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DBGrid2.SelectedIndex:=DBGrid1.SelectedIndex;
end;

end.

