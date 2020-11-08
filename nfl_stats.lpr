program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, tachartlazaruspkg, zcomponent, UPlayerInfo, ustats, Ustatdetails,
  UGamedetail, udm, UPlayerSearch, umainform, uPlayerAgainstTeam,
  uTeamStatsByYear, UClasses, uTeamSchedule, UChart;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmMainForm, frmMainForm);
  Application.Run;
end.

