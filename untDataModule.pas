unit untDataModule;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope,IdHashMessageDigest,idHash;

type
  TdmdDataModule = class(TDataModule)
    restAPI: TRESTClient;
    reqOpenSession: TRESTRequest;
    respOpenSession: TRESTResponse;
    reqLogin: TRESTRequest;
    respLogin: TRESTResponse;
  private
    { Private declarations }
    sSessionKey : String;
  public
    { Public declarations }
    function openSession : Boolean;
    function md5(input: String) : String;
    property sessionKey : String  read sSessionKey;
  end;

var
  dmdDataModule: TdmdDataModule;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TdmdDataModule }


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
begin
    reqOpenSession.Execute;
    reqOpenSession.Params.ParameterByName('key').Value :=  md5(reqOpenSession.Params.ParameterByName('key').Value + reqOpenSession.Params.ParameterByName('name').Value);
    sSessionKey := respOpenSession.Content;
    openSession := true;
end;

end.
