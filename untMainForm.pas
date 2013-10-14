unit untMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Layouts,
  FMX.ExtCtrls, FMX.Edit, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, FMX.Memo,  untJSONFunctions, untAPI, untFrmSignUp, IdHTTP,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,DBXJSON,
  untAthleteWelcome;

type
  TfrmMain = class(TForm)
    imgLogo: TImageControl;
    edtUsername: TEdit;
    edtPassword: TEdit;
    btnLogin: TButton;
    memLog: TMemo;
    btnSignup: TButton;
    httpClient: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    procedure btnLoginClick(Sender: TObject);
    procedure btnSignupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    sUserSalt   : String;
    API : TAPI;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}
Const
ACCESS_NAME = 'mobile';
API_KEY     = 'eu47rh485u3485';

procedure TfrmMain.btnLoginClick(Sender: TObject);
var
  result  : String;
  options : TStringList;
  return  : String;
  LJSONObject : TJSonObject;
  sType   : String;
  frmAthleteWelcome: TfrmAthleteWelcome;
begin
  result := API.login(edtUsername.text,edtPassword.text);
  if (checkJsonStatus(result) = 'OK') then
  begin
    memLog.Lines.Add('Login worked...');
    // get user salt...
    return    := getResultValue(result);
    LJSONObject := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(return), 0) as TJSONObject;

    sUserSalt := getStringValueFromPair(LJSONObject,'salt');
    sType     := getStringValueFromPair(LJSONObject,'type');
    // go to the relevant page...
    if (sType = 'athlete') then
    begin
      // show the athlete welcome page
      frmAthleteWelcome := TfrmAthleteWelcome.Create(self);
      frmAthleteWelcome.Show;
      FreeAndNil(frmAthleteWelcome);
    end;
  end
  else
  begin
    memLog.Lines.Add('Login failed...');
  end;
  FreeAndNil(options);
end;


procedure TfrmMain.btnSignupClick(Sender: TObject);
var
  frmSignUp : TfrmSignUp;
begin
  frmSignUp := TFrmSignUp.Create(self);
  frmSignUp.API := API;
  frmSignUp.Show;
  FreeAndNil(frmSignUp);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  API := TAPI.Create();
end;

end.
