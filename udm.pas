unit udm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection;

type

  { Tdm }

  Tdm = class(TDataModule)
    ZConnection1: TZConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    index: byte;
  public

  end;

var
  dm: Tdm;

implementation

{$R *.lfm}

{ Tdm }

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  //Loads automatically if the default configs went wrong
  with ZConnection1 do
  begin
    Database := 'nfl_stats';
    HostName := 'localhost';
    User := 'postgres';
    Password := '1234';
    Port := 5432;
    Protocol := 'postgresql';

    Connected := True;

  end;
end;

end.

