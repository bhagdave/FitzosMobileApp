unit untMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Layouts,
  FMX.ExtCtrls, FMX.Edit, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, FMX.Memo, untAPI, untFrmSignUp, IdHTTP,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,DBXJSON,
  untAthleteWelcome, FMX.Objects;

type
  TfrmMain = class(TForm)
    imgLogo: TImageControl;
    edtUsername: TEdit;
    edtPassword: TEdit;
    btnLogin: TButton;
    btnSignup: TButton;
    txtWelcomeMessage: TText;
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
  sType   : String;
  frmAthleteWelcome: TfrmAthleteWelcome;
begin
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
