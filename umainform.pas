unit umainform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  UPlayerSearch, uTeamStatsByYear;

type

  { TfrmMainForm }

  TfrmMainForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
  private

  public

  end;

var
  frmMainForm: TfrmMainForm;

implementation

{$R *.lfm}

{ TfrmMainForm }

procedure TfrmMainForm.Button1Click(Sender: TObject);
begin
  //Players Stats
  if Sender = Button1 then
  begin
    if frmPlayerSearch = nil then
         frmPlayerSearch := TfrmPlayerSearch.Create(Application);

    frmPlayerSearch.ShowModal;
  end;
  //Team Stats
  if Sender = Button2 then
  begin
    //TODO: makes the team stats form with team players stats for each year
       if frmTeamStatsByYear = nil then
         frmTeamStatsByYear := TfrmTeamStatsByYear.Create(Application);

    frmTeamStatsByYear.ShowModal;
  end;
  //Season Stats
  if Sender = Button3 then
  begin
    //TODO: makes the season stats form, for each year and stat type
       ShowMessage('Comming Soon');
  end;
end;

procedure TfrmMainForm.Button1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 27) or (Key = 81) then Application.Terminate;
end;

end.

