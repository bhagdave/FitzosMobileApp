unit untJSONFunctions;

interface
  function getResultString(Content : String):String;
  function getResultBoolean(Content, Value : String):Boolean;
  function getStringFromResult(Content:String):String;
  function getResultElementAsString(content,element : String):String;

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
function getStringFromResult(Content:String):String;
var
  lJSONObject : TJSONObject;
  lJSONPair   : TJSONPair;
  lStatus     : TJsonValue;
begin
    try
      lJSONObject := TJSONObject.Create();
      lJSONObject.Parse(TEncoding.ASCII.GetBytes(Content),0);
      lStatus := lJSONObject.Get('Result').JsonValue;
      result  := lStatus.Value;
    finally
      lJSONObject.Free;
    end;
end;
function getResultElementAsString(content,element : String):String;
var
  lJSONObject,LResult : TJSONObject;
  lData : TJsonPair;
begin
  try
    lJSONObject := TJSONObject.Create();
    lJSONObject.Parse(TEncoding.ASCII.GetBytes(Content),0);
    lResult := TJsonObject(lJsonObject.Values['Result']);
    lData := lResult.Get(element);
    Result := lData.JsonValue.ToString;
  finally
    lJSONObject.Free;
  end;
end;


end.
