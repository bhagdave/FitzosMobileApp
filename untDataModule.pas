unit untDataModule;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope,IdHashMessageDigest,idHash,System.JSON,
  REST.Response.Adapter, Data.DB, Datasnap.DBClient, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TdmdDataModule = class(TDataModule)
    restAPI: TRESTClient;
    reqOpenSession: TRESTRequest;
    respOpenSession: TRESTResponse;
    reqLogin: TRESTRequest;
    respLogin: TRESTResponse;
    reqNotifications: TRESTRequest;
    respNotifications: TRESTResponse;
    rdsaNotifications: TRESTResponseDataSetAdapter;
    cdsNotifications: TClientDataSet;
    reqMember: TRESTRequest;
    respMember: TRESTResponse;
    rdsaMember: TRESTResponseDataSetAdapter;
    cdsMember: TClientDataSet;
    reqGeneric: TRESTRequest;
    respGeneric: TRESTResponse;
    rdsaGeneric: TRESTResponseDataSetAdapter;
    cdsGeneric: TClientDataSet;
  private
    { Private declarations }
    sSessionKey : String;
    sMemberSalt : String;
    sMemberType : String;
  public
    { Public declarations }
    function openSession : Boolean;
    function checkLogin : Boolean;
    function md5(input: String) : String;
    function getApiKey() : String;
    function signature(method: String): String;
    property sessionKey : String  read sSessionKey;
    property memberId : String read sMemberSalt;
    property memberType : String read sMemberType;
  end;

var
  dmdDataModule: TdmdDataModule;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TdmdDataModule }
const
  API_NAME = 'mobile';
  API_KEY  = 'eu47rh485u3485';
  API_COMBINED = 'eu47rh485u3485mobile';

function TdmdDataModule.checkLogin: Boolean;
var
  lJSONObject : TJSONObject;
  lJSONPair   : TJSONPair;
  lResult,lStatus,lItem  : TJsonValue;
begin
  result := false;
    try
      lJSONObject := TJSONObject.Create();
      lJSONObject.Parse(TEncoding.ASCII.GetBytes(respLogin.Content),0);
      lResult := lJSONObject.Get('Result').JsonValue;
      lStatus := lJSONObject.Get('Status').JsonValue;
      if (lStatus.Value = 'OK') then
      begin
        lItem := TJSONObject(lResult).Get('salt').JsonValue;
        sMemberSalt := lItem.Value;
        lItem := TJSONObject(lResult).Get('type').JsonValue;
        sMemberType := lItem.Value;
        result := true;
      end
      else
        result := false;
    finally
      lJSONObject.Free;
      lStatus.Free;
      lResult.Free;
    end;
end;

function TdmdDataModule.getApiKey: String;
begin
  result := API_KEY;
end;

function TdmdDataModule.md5(input: String): String;
var
  idmd5 : TIdHashMessageDigest5;
begin
  idmd5 := TIdHashMessageDigest5.Create;
  try
    result := idmd5.HashStringAsHex(input);
  finally
    idmd5.Free;
  end;
end;

function TdmdDataModule.openSession: Boolean;
var
  lJSONObject : TJSONObject;
  lJSONPair   : TJSONPair;
  lResult,lStatus  : TJsonValue;
begin
    reqOpenSession.Params.ParameterByName('key').Value  :=  self.md5(API_COMBINED);
    reqOpenSession.Params.ParameterByName('name').Value :=  API_NAME;
    reqOpenSession.Execute;
    try
      lJSONObject := TJSONObject.Create();
      lJSONObject.Parse(TEncoding.ASCII.GetBytes(respOpenSession.Content),0);
      lResult := lJSONObject.Get('Result').JsonValue;
      lStatus := lJSONObject.Get('Status').JsonValue;
      if (lStatus.Value = 'OK') then
      begin
        sSessionKey := lResult.Value;
        openSession := true;
      end
      else
        openSession := false;
    finally
      lJSONObject.Free;
      lResult.Free;
      lStatus.Free;
    end;
end;

function TdmdDataModule.signature(method: String): String;
begin
  result := self.md5(API_NAME + API_KEY + method);
end;

end.
