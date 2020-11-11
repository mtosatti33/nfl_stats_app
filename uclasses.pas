unit UClasses;
{
    HOW TO ADJUST THE COLUMNS:

    (Year, Player Name, Team Name, Scores etc.)
    - 0 to ColCount - 44

    (Passing)
    - colCount - 43 - C/A
    - colCount - 42 - Pa.Pct
    - colCount - 41 - Pa.Yds
    - colCount - 40 - Pa.TD
    - colCount - 39 - Pa.Int
    - colCount - 38 - Rate
    - colCount - 37 - Sckd

    (Rushing)
    - colCount - 36 - Rush
    - colCount - 35 - Ru.Yds
    - colCount - 34 - Ru.Av
    - colCount - 33 - Ru.TD

    (Receiving)
    - colCount - 32 - Tgt
    - colCount - 31 - Rec
    - colCount - 30 - Re.Yds
    - colCount - 29 - Re.Av
    - colCount - 28 - Re.TD

    (Defense)
    - colCount - 27 - Comb
    - colCount - 26 - T/A
    - colCount - 25 - Scks
    - colCount - 24 - Int
    - colCount - 23 - Int.Yds
    - colCount - 22 - Int.TD
    - colCount - 21 - Sft

    (Kickoff Returning)
    - colCount - 20 - KR
    - colCount - 19 - KR.Yds
    - colCount - 18 - KR.Av
    - colCount - 17 - KR.TD

    (Punt Returning)
    - colCount - 16 - PR
    - colCount - 15 - PR.Yds
    - colCount - 14 - PR.Av
    - colCount - 13 - PR.TD

    (Kicking)
    - colCount - 12 - FM/FA
    - colCount - 11 - FG.Pct
    - colCount - 10 - XM/XA
    - colCount - 9  - Xp.Pct

    (Punting)
    - colCount - 8  - Punts
    - colCount - 7  - Pu.Yds
    - colCount - 6  - Pu.Av
    - colCount - 5  - Blckd

    (Fumbles)
    - colCount - 4
    (Fumbles Lost)
    - colCount - 3
    (Fumbles Forced)
    - colCount - 2
    (Fumbles Recovery)
    - colCount - 1

    In future:
    - Pass Yards per completion
    - Pass Yards per Game
    - Interception per attempt
    - TD-Int margin
    - Times Sacked per game
    - Rush Yards per game
    - Receiving Yards per game
    - Combined solo/assist per game
    - Sacks per game
}
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DBGrids, ZDataset, Graphics, Forms, Dialogs;

type

  { TGridTools }

  TGridTools = class
    public
      procedure Initialize(frm: TForm; qry: TZQuery);
    private
      procedure SetVisibleByStat(qry: TZQuery; grid: TDBGrid;
        ColCount: integer);
      procedure SetColumnsProperties(frm:TForm; qry: TZQuery; grid: TDBGrid;
        ColCount: integer);
  end;

  TAdvancedQuery = class

  end;

implementation

{ TGridTools }

procedure TGridTools.Initialize(frm: TForm; qry: TZQuery);
var
  i: integer;
  ColCount: integer;
  grid: TDBGrid;
begin
  for i:=0 to frm.ComponentCount - 1 do
  begin
    if frm.Components[i] is TDBGrid then
     begin
       ColCount:=TDBGrid(frm.Components[i]).Columns.Count;
       grid := TDBGrid(frm.Components[i]);
       SetColumnsProperties(frm, qry, grid, ColCount);
     end;
  end;
end;

procedure TGridTools.SetVisibleByStat(qry: TZQuery; grid: TDBGrid;
  ColCount: integer);
var
  i: integer;
begin
  //Set All Columns to false
  for i:= 0 to ColCount -1 do
      grid.Columns[i].Visible:=False;

  //Set These columns as true per default
  for i:=0 to ColCount - 44 do
      grid.Columns[i].Visible:=True;

  //Passing
  if not qry.FieldByName('Pa.Pct').IsNull then
  begin
      for i:=colCount-43 to colCount-37 do
          grid.Columns[i].Visible:=True;
      grid.Columns[colCount-43].Width:=75;
  end;
  //Rushing
  if qry.FieldByName('Rush').Value > 0 then
  begin
      for i:=colCount-36 to colCount-33 do
          grid.Columns[i].Visible:=True;
  end;
  //Receiving
  if qry.FieldByName('Rec').Value > 0 then
  begin
      for i:=colCount-32 to colCount-28 do
          grid.Columns[i].Visible:=True;
  end;
  //Defense
  if (qry.FieldByName('Comb').Value > 0) or
     (qry.FieldByName('Scks').Value > 0) or
     (qry.FieldByName('Int').Value > 0)  then
  begin
      for i:=colCount-27 to colCount-21 do
          grid.Columns[i].Visible:=True;
  end;
  //Kickoff Returning
  if qry.FieldByName('KR').Value > 0 then
  begin
     for i:=colCount-20 to colCount-17 do
         grid.Columns[i].Visible:=True;
  end;
  //Punt Returning
  if qry.FieldByName('PR').Value > 0 then
  begin
      for i:=colCount-16 to colCount-13 do
          grid.Columns[i].Visible:=True;
  end;
  //Kicking
  if (not qry.FieldByName('FG.Pct').IsNull) or
     (not qry.FieldByName('XP.Pct').IsNull) then
  begin
      for i:=colCount-12 to colCount-9 do
          grid.Columns[i].Visible:=True;
  end;
  //Punting
  if not qry.FieldByName('Pu.Av').IsNull then
  begin
      for i:=colCount-8 to colCount-5 do
          grid.Columns[i].Visible:=True;
  end;
  //Fumbles
  if (qry.FieldByName('Fmb').Value > 0) then
    grid.Columns[colCount - 4].Visible:=True;
  if (qry.FieldByName('Lost').Value > 0) then
    grid.Columns[colCount - 3].Visible:=True;
  if (qry.FieldByName('FF').Value > 0) then
    grid.Columns[colCount - 2].Visible:=True;
  if (qry.FieldByName('FR').Value > 0) then
    grid.Columns[colCount - 1].Visible:=True;
end;

procedure TGridTools.SetColumnsProperties(frm:TForm; qry: TZQuery;
  grid: TDBGrid; ColCount: integer);
var 
  TDColor: TColor;
  TOColor: TColor;
  format: string;
  i:integer;
begin
  //Set column width
  for i:= 0 to ColCount -1 do
      grid.Columns[i].Width:= 45;

  if frm.Name = 'frmStats' then
  begin
    grid.Columns[0].Width:= 35;
    grid.Columns[1].Width:= 35;
    grid.Columns[2].Width:= 30;
  end;
  if frm.Name = 'frmStatDetails' then
  begin
    grid.Columns[0].Width:= 35;
    grid.Columns[1].Width:= 35;
    grid.Columns[2].Width:= 20;
    grid.Columns[3].Width:= 90;
    grid.Columns[4].Width:= 75;
  end;
  if frm.Name = 'frmPlayerAgainstTeam' then
  begin
    grid.Columns[0].Width:= 35;
    grid.Columns[1].Width:= 45;
    grid.Columns[2].Width:= 90;
    grid.Columns[3].Width:= 70;
  end;  
  if frm.Name = 'frmGameDetail' then
  begin
    grid.Columns[0].Width:= 120;
    grid.Columns[1].Width:= 35;
    grid.Columns[2].Width:= 35;
    //Set this param as nil following the condition above
    qry := nil;
  end;
  if frm.Name = 'frmTeamStatsByYear' then
  begin
    grid.Columns[0].Width:= 120;
    grid.Columns[1].Width:= 35;
    grid.Columns[2].Width:= 35;
    grid.Columns[3].Width:= 55;
    //Set this param as nil following the condition above
    qry := nil;
  end;

  grid.FixedCols := (ColCount - 42);
  
  //Initialize these variables
  //----------------------------------------------------------------------------
  //Touchdowns
  TDColor  := clLime;
  //Turnovers
  TOColor  := $3357ff;
  //Format Float like Pct. Avg. Sacks...
  format   := '#,###,###0.0';

  //Set Color columns properties
  //----------------------------------------------------------------------------
  //Pass TD
  grid.Columns[colCount - 40].Font.Color:=TDColor;  
  //Rushing TD
  grid.Columns[colCount - 33].Font.Color:=TDColor;
  //Receiving TD
  grid.Columns[colCount - 28].Font.Color:=TDColor; 
  //Int Ret TD
  grid.Columns[colCount - 22].Font.Color:=TDColor;
  //Kickoff Ret TD
  grid.Columns[colCount - 17].Font.Color:=TDColor; 
  //Punt Ret TD
  grid.Columns[colCount - 13].Font.Color:=TDColor;

  //Pass Intercepted
  grid.Columns[colCount - 39].Font.Color:=TOColor;
  //Fumble Lost
  grid.Columns[colCount - 3].Font.Color :=TOColor;

  //Pass Pct.
  grid.Columns[colCount - 42].Font.Style:=[fsBold];   
  //Pass Rating.
  grid.Columns[colCount - 38].Font.Style:=[fsBold, fsItalic];
  //Rushing Avg.
  grid.Columns[colCount - 34].Font.Style:=[fsBold]; 
  //Receiving Avg.
  grid.Columns[colCount - 29].Font.Style:=[fsBold]; 
  //Kickoff Ret  Avg.
  grid.Columns[colCount - 18].Font.Style:=[fsBold]; 
  //Punt Ret Avg.
  grid.Columns[colCount - 14].Font.Style:=[fsBold]; 
  //FG Pct.
  grid.Columns[colCount - 11].Font.Style:=[fsBold]; 
  //XP Pct.
  grid.Columns[colCount - 9].Font.Style :=[fsBold]; 
  //Punt Avg.
  grid.Columns[colCount - 6].Font.Style :=[fsBold];



  //----------------------------------------------------------------------------

  //Pass Pct.
  grid.Columns[colCount - 42].DisplayFormat:=format;
  //Pass Rating.
  grid.Columns[colCount - 38].DisplayFormat:=format; 
  //Rushing Avg.
  grid.Columns[colCount - 34].DisplayFormat:=format; 
  //Receiving Avg.
  grid.Columns[colCount - 29].DisplayFormat:=format; 
  //Sacks
  grid.Columns[colCount - 25].DisplayFormat:=format;
  //Kickoff Ret  Avg.
  grid.Columns[colCount - 18].DisplayFormat:=format; 
  //Punt Ret Avg.
  grid.Columns[colCount - 14].DisplayFormat:=format;  
  //FG Pct.
  grid.Columns[colCount - 11].DisplayFormat:=format; 
  //XP Pct.
  grid.Columns[colCount - 9].DisplayFormat :=format; 
  //Punt Avg.
  grid.Columns[colCount - 6].DisplayFormat :=format;

  //Set visibility IF qry param is diferent from nil
  if qry <> nil then
     SetVisibleByStat(qry,grid,ColCount);
end;

end.

