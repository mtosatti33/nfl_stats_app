unit UPlayerSearch;

{$mode objfpc}{$H+}

{
       KEYMAPS:
       13            = ENTER        (acess the full information)
       27            = ESC          (exits from form/program)
       81            = Q KEY        (exits from form/program)
       112 + ssCtrl  = CTRL+F1 KEY  (focus on first edit)
       112           = F1 KEY       (focus on first edit)
       113           = F2 KEY       (focus on second edit)
}
interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  UPlayerInfo, udm, ZDataset;

type

  { TfrmPlayerSearch }

  TfrmPlayerSearch = class(TForm)
    btnClear: TButton;
    CheckBox1: TCheckBox;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    edtPlayerName: TEdit;
    edtCollege: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ZQuery1: TZQuery;
    procedure btnClearClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure edtPlayerNameChange(Sender: TObject);
    procedure edtPlayerNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private

  public

  end;

var
  frmPlayerSearch: TfrmPlayerSearch;

implementation

{$R *.lfm}

{ TfrmPlayerSearch }

procedure TfrmPlayerSearch.edtPlayerNameChange(Sender: TObject);
begin
  ZQuery1.Close;
  ZQuery1.ParamByName('name').AsString:='%' + edtPlayerName.Text + '%';
  ZQuery1.ParamByName('college').AsString:= '%' + edtCollege.Text + '%';
  ZQuery1.ParamByName('is_active').AsBoolean:= CheckBox1.Checked;
  ZQuery1.Open;
end;

procedure TfrmPlayerSearch.edtPlayerNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then Close;
  if Key = 13 then DBGrid1.SetFocus;
end;

procedure TfrmPlayerSearch.btnClearClick(Sender: TObject);
var
  i: Byte;
begin
  for i:=0 to self.ComponentCount - 1 do
  begin
    if Components[i] is TEdit then TEdit(Components[i]).Clear;
  end;
  edtPlayerName.SetFocus;
end;

procedure TfrmPlayerSearch.DBGrid1DblClick(Sender: TObject);
begin
  if ZQuery1.RecordCount <> 0 then
  begin
    if frmPlayerInfo = nil then
       frmPlayerInfo := TfrmPlayerInfo.Create(Application);
    with frmPlayerInfo do
    begin
      player_id:=self.ZQuery1['player_id'];

      ShowModal;
    end;
  end;
end;

procedure TfrmPlayerSearch.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then DBGrid1DblClick(nil);
  if (Key = 27) or (Key = 81) then Close;
  if Key = 112 then edtPlayerName.SetFocus;
  if Key = 113 then edtCollege.SetFocus;
  if Key = 114 then btnClear.Click;
end;

end.

