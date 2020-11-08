unit udm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection;

type

  { Tdm }

  Tdm = class(TDataModule)
    ZConnection1: TZConnection;
  private

  public

  end;

var
  dm: Tdm;

implementation

{$R *.lfm}

end.

