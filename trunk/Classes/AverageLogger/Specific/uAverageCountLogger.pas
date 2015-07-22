unit uAverageCountLogger;

interface

uses uAverageLogger;

type
  TAverageCountLogger = class(TAverageLogger)
  protected
    function GetUnit: Double; virtual; override; 
  end;

implementation

function TAverageCountLogger.GetUnit: Double; 
begin
  result := 1;
end;
end.
