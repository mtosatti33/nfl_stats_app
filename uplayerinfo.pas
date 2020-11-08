unit UPlayerInfo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  ustats, ZDataset;

type

  { TfrmPlayerInfo }

  TfrmPlayerInfo = class(TForm)
    btnStats: TButton;
    DataSource1: TDataSource;
    DBText1: TDBText;
    DBText10: TDBText;
    DBText11: TDBText;
    DBText12: TDBText;
    DBText13: TDBText;
    DBText14: TDBText;
    DBText15: TDBText;
    DBText16: TDBText;
    DBText17: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    DBText8: TDBText;
    DBText9: TDBText;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label17: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ZQuery1: TZQuery;
    procedure btnStatsClick(Sender: TObject);
    procedure btnStatsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private

  public
    player_id:integer;
  end;

var
  frmPlayerInfo: TfrmPlayerInfo;

implementation

{$R *.lfm}

{ TfrmPlayerInfo }

procedure TfrmPlayerInfo.FormShow(Sender: TObject);
begin
  ZQuery1.Close;
  ZQuery1.ParamByName('player_id').AsInteger:= player_id;
  ZQuery1.Open;

  if not Label6.Visible then Label6.Visible := True;
  if not Label9.Visible then Label9.Visible := True; 
  if not Label17.Visible then Label17.Visible := True;
  if not Label12.Visible then Label12.Visible := True;
  if not Label13.Visible then Label13.Visible := True;
  if not Label14.Visible then Label14.Visible := True;

  if ZQuery1.FieldByName('death_date').IsNull then
     Label6.Visible:=false;

  if ZQuery1.FieldByName('current_team').IsNull then
     Label9.Visible:=false;

  if ZQuery1.FieldByName('hof_induction_year').IsNull then
     Label17.Visible:=false;

  if ZQuery1.FieldByName('draft_team').Value = 'Undrafted' then
  begin
     Label12.Visible:=false;
     Label13.Visible:=false;
     Label14.Visible:=false;
  end;
end;

procedure TfrmPlayerInfo.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Key = 27 then Close;
end;

procedure TfrmPlayerInfo.btnStatsClick(Sender: TObject);
begin
  if frmStats = nil then
     frmStats := TfrmStats.Create(self);

  with frmStats do
  begin
       player_id:=self.ZQuery1['player_id'];
       ShowModal;
  end;
end;

procedure TfrmPlayerInfo.btnStatsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 27) or (Key = 81) then Close;
end;

end.

