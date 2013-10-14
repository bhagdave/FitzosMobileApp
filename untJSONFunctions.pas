unit untJSONFunctions;

interface

uses
  SysUtils, DBXJSON;

function checkJsonStatus(JSON: String): String;
function getResultValue(data: String) : String;
function getStringValueFromPair(JSONObject : TJsonObject; Field : String): String;
function getStringValueFromString(data : String; Field : String) : String;

implementation

function checkJsonStatus(JSON: String): String;
var
  LJSONObject : TJSONObject;
  LJSONPair   : TJSONPair;
begin
  LJSONObject := nil;
  try
    LJSONObject     := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(JSON), 0) as TJSONObject;
    LJSONPair       := LJSONObject.Get('Status');
    checkJsonStatus := StringReplace(LJSONPair.JsonValue.ToString,'"','',[rfReplaceAll]);
  finally
    LJSONObject.Free;
  end;
end;

function getResultValue(data: String) : String;
var
  LJSONObject : TJSONObject;
  LJSONPair   : TJSONPair;
  LJSONValue  : TJSONValue;
begin
  LJSONObject := nil;
  try
    LJSONObject := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(data), 0) as TJSONObject;
    LJSONPair   := LJSONObject.Get('Result');
    LJSONValue  := LJSONPair.JsonValue;
    getResultValue := LJSONValue.ToString;
  finally
    LJSONObject.Free;
  end;
end;
function getStringValueFromPair(JSONObject : TJsonObject; Field : String): String;
var
  LData : TJsonPair;
begin
    LData := JSONObject.get(Field);
    getStringValueFromPair := StringReplace(LData.JsonValue.ToString, '"', '', [rfReplaceAll]);
end;
function getStringValueFromString(data:String; Field : String): String;
var
  LJSONObject : TJSONObject;
begin
  LJSONObject := nil;
  try
    LJSONObject := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(data), 0) as TJSONObject;
    getStringValueFromString := getStringValueFromPair(LJSONObject, Field);
  finally
    LJSONObject.Free;
  end;
end;

end.
