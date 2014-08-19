unit untJSONFunctions;

interface
  function getResultString(Content : String):String;
  function getResultBoolean(Content, Value : String):Boolean;

implementation

uses
  System.json, System.SysUtils;

function getResultString(Content : String):String;
var
  lJSONObject : TJSONObject;
  lJSONPair   : TJSONPair;
  lStatus     : TJsonValue;
begin
    try
      lJSONObject := TJSONObject.Create();
      lJSONObject.Parse(TEncoding.ASCII.GetBytes(Content),0);
      lStatus := lJSONObject.Get('Status').JsonValue;
      result  := lStatus.Value;
    finally
      lJSONObject.Free;
    end;
end;
function getResultBoolean(Content, Value : String):Boolean;
var
  lJSONObject : TJSONObject;
  lJSONPair   : TJSONPair;
  lStatus     : TJsonValue;
begin
    try
      lJSONObject := TJSONObject.Create();
      lJSONObject.Parse(TEncoding.ASCII.GetBytes(Content),0);
      lStatus := lJSONObject.Get(Value).JsonValue;
      lStatus.TryGetValue<Boolean>(result);
    finally
      lJSONObject.Free;
    end;
end;

end.
