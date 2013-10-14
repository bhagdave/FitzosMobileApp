unit untAPI;

interface

uses
  SysUtils, DBXJSON, System.Classes, IdHTTP, IdSSL, IdSSLOpenSSL, untJSONFunctions,IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient,IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, FMX.Dialogs;

type
  TAPI = Class(TObject)
    private
      sSessionKey : String;
      HTTPClient  : TIdHTTP;
      SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
    public
    function openSession(): Boolean;
    function login(username:String; password: String) : String;
    function signUp(username, email, password, confirmpassword : String): String;
    Constructor Create(); overload;
    Destructor Destroy; override;
  End;

implementation

Const
ACCESS_NAME = 'mobile';
API_KEY     = 'eu47rh485u3485';

{ TAPI }

constructor TAPI.Create();
begin
  HTTPClient := TIDHttp.Create();
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create();
  HTTPClient.IOHandler := SSLHandler;
end;

destructor TAPI.Destroy;
begin
  inherited;
end;

function TAPI.login(username, password: String): String;
var
  options  : TStringList;
begin
  if sSessionKey = '' then
  begin
    if not openSession() then
    begin
      result := 'ERR';
      exit;
    end;
  end;
  options := TStringList.Create;
  options.Add('access_name=' + ACCESS_NAME);
  options.Add('api_key=' + sSessionKey);
  options.Add('username=' + username);
  options.Add('password=' + password);
  result := HTTPClient.Post('http://beta.fitzos.com/api/login',options);
  login := result;
  FreeAndNil(options);
end;

function TAPI.openSession: Boolean;
var
  options  : TStringList;
  response : String;
begin
  options := TStringList.Create;
  options.Add('name=' + ACCESS_NAME);
  options.Add('key=' + API_KEY);
  response := HTTPClient.Post('http://beta.fitzos.com/api/openSession',options);
  if (checkJsonStatus(response) = 'OK') then
  begin
    sSessionKey := getResultValue(response);
    sSessionKey := StringReplace(sSessionKey,'"','',[rfReplaceAll]);
    result := True;
  end
  else
  begin
    showmessage(response);
    result := False;
  end;
  FreeAndNil(options);
end;

function TAPI.signUp(username, email, password, confirmpassword : String): String;
var
  options : TStringList;
begin
  if (sSessionKey = '') then
    openSession();
  options := TStringList.Create;
  options.Add('access_name=mobile');
  options.Add('api_key=' + sSessionKey);
  options.Add('name=' + username);
  options.Add('email=' + email);
  options.Add('password=' + password);
  options.Add('confirm_password=' + ConfirmPassword);

  result := httpClient.Post('http://beta.fitzos.com/api/createMember',options);
  if (checkJsonStatus(result) = 'OK') then
  begin
    // show a message to activate
    ShowMessage('Account created please check your email for activation instructions.');
  end
  else
  begin
    // show a message
    ShowMessage('Unable to create account...');
  end;
  FreeAndNil(options);
end;

end.
