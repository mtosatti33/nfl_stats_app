unit UGamedetail;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  UClasses, ZDataset;

type

  { TfrmGameDetail }

  TfrmGameDetail = class(TForm)
    ComboBox1: TComboBox;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Label1: TLabel;
    ZQuery1: TZQuery;
    ZQuery2: TZQuery;
    qryTeams: TZQuery;
    procedure ComboBox1Change(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    firstIndex : Boolean;
  public   
    game_id: string;

  end;

var
  frmGameDetail: TfrmGameDetail;

implementation

uses udm;

{$R *.lfm}

{ TfrmGameDetail }

procedure TfrmGameDetail.FormShow(Sender: TObject);
var
  GridTools: TGridTools;
begin
  ZQuery2.Close;
  ZQuery2.ParamByName('game_id').AsString:= game_id;
  ZQuery2.Open;
  
  qryTeams.Close;
  qryTeams.ParamByName('game_id').AsString:= game_id;
  qryTeams.Open;

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
  firstIndex := true;
  ComboBox1.ItemIndex:=0;
  ComboBox1Change(nil);
end;

procedure TfrmGameDetail.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 112 then
  begin
   firstIndex := not firstIndex;

   if firstIndex then
       ComboBox1.ItemIndex:=0
   else
       ComboBox1.ItemIndex:=1;

       ComboBox1Change(nil);
  end;
  if (Key = 27) or (Key = 81) then Close;
end;

procedure TfrmGameDetail.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DBGrid2.SelectedIndex:=DBGrid1.SelectedIndex;
end;

procedure TfrmGameDetail.DBGrid2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DBGrid1.SelectedIndex:=DBGrid2.SelectedIndex;
end;

procedure TfrmGameDetail.ComboBox1Change(Sender: TObject);
begin
  ZQuery1.Close;
  ZQuery1.ParamByName('game_id').AsString:= game_id;
  ZQuery1.ParamByName('team').AsString:= ComboBox1.Items[ComboBox1.ItemIndex];
  ZQuery1.Open;
end;

end.

