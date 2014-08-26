unit untMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Layouts,
  FMX.ExtCtrls, FMX.Edit, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, FMX.Memo, IdHTTP, untDataModule,untNotifications,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,DBXJSON,
  FMX.Objects, Rest.Client;

type
  TfrmMain = class(TForm)
    imgLogo: TImageControl;
    edtUsername: TEdit;
    edtPassword: TEdit;
    btnLogin: TButton;
    btnSignup: TButton;
    txtWelcomeMessage: TText;
    StyleBook1: TStyleBook;
    AniIndicator1: TAniIndicator;
    procedure btnLoginClick(Sender: TObject);
    procedure btnSignupClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    sUserSalt   : String;
    procedure loginComplete;
    procedure threadTerminated(Sender : TObject);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  myThread : TRESTExecutionThread;

implementation

{$R *.fmx}
uses
  untBaseForm,System.JSON,untFormRegistry, FMX.Styles;


procedure TfrmMain.btnLoginClick(Sender: TObject);
var
  signature : string;
begin
  //  open a session first.....
  dmdDataModule.openSession;
  dmdDataModule.reqLogin.Params.ParameterByName('signature').Value := dmdDataModule.signature('login');
  dmdDataModule.reqLogin.Params.ParameterByName('username').Value  := edtUsername.Text;
  dmdDataModule.reqLogin.Params.ParameterByName('password').Value  := edtPassword.Text;
  dmdDataModule.reqLogin.Params.ParameterByName('key').Value  := dmdDataModule.sessionKey;
  AniIndicator1.Visible := true;
  AniIndicator1.enabled := true;
  mythread := dmdDataModule.reqLogin.ExecuteAsync(loginComplete, true, true);
  mythread.OnTerminate := threadTerminated;
end;


procedure TfrmMain.btnSignupClick(Sender: TObject);
begin
  showNewForm('TfrmSignup');
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
    Style: TFMXObject;
begin
    {$IFDEF Android}
        Style := TStyleManager.LoadFromResource(HInstance, 'OrangeStyle', RT_RCDATA);
    {$ENDIF}
    {$IFDEF iOS}
        Style := TStyleManager.LoadFromResource(HInstance, 'OrangeStyle', RT_RCDATA);
    {$ENDIF}
    if Style<> nil then
        TStyleManager.SetStyle(Style);
end;

procedure TfrmMain.loginComplete;
var
  bLoggedIn : Boolean;
begin
  // check if valid or invalid... by getting the datamodule to check.
  bLoggedIn := dmdDataModule.checkLogin;
  if bLoggedIn then
  begin
    showNewForm('TfrmMenu');
  end
  else
  begin
      showmessage('Error in login!');
  end;
end;

procedure TfrmMain.threadTerminated(Sender : TObject);
begin
    mythread := nil;
    AniIndicator1.Visible := false;
    AniIndicator1.enabled := false;
end;

end.
