unit untMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Layouts,
  FMX.ExtCtrls, FMX.Edit, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, FMX.Memo, IdHTTP, untDataModule,untNotifications,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,DBXJSON,
  FMX.Objects, Rest.Client, FMX.Controls.Presentation;

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
    idTCPConnection: TIdTCPClient;
    tmrConnected: TTimer;
    lblUsername: TLabel;
    lblPassword: TLabel;
    pnlLoginFrm: TGridPanelLayout;
    procedure btnLoginClick(Sender: TObject);
    procedure btnSignupClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmrConnectedTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    isConnected : Boolean;
    procedure loginComplete;
    procedure threadTerminated(Sender : TObject);
    function connected : boolean;
  public
    { Public declarations }
    property internet : boolean read isConnected;
  end;

var
  frmMain: TfrmMain;
  myThread : TRESTExecutionThread;

implementation

{$R *.fmx}
uses
  untBaseForm,System.JSON,untFormRegistry, FMX.Styles;


procedure TfrmMain.btnLoginClick(Sender: TObject);
begin
  if isConnected then
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
end;


procedure TfrmMain.btnSignupClick(Sender: TObject);
begin
  showNewForm('TfrmSignup');
end;

function TfrmMain.connected: boolean;
begin
  result := false;
  isConnected := false;
  try
     IdTCPConnection.ReadTimeout := 2000;
     IdTCPConnection.ConnectTimeout := 2000;
     IdTCPConnection.port := 80;
     IdTCPConnection.host := 'www.reach-your-peak.com';
     IdTCPConnection.Connect;
     IdTCPConnection.Disconnect;
     result := true;
     isConnected := true;
  except on E: Exception do
  begin
    isConnected := false;
    result := false;
  end;
  end;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
    if not connected then
    begin
      showmessage('Unable to connect to Internet!');
      tmrConnected.Enabled := true;
    end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
    Style: TFMXObject;
begin
    {$IFDEF MSWINDOWS}
        Style := TStyleStreaming.LoadFromResource(HInstance, 'OrangeStyle', RT_RCDATA);
    {$ENDIF}
    {$IFDEF Android}
        Style := TStyleStreaming.LoadFromResource(HInstance, 'OrangeStyle', RT_RCDATA);
    {$ENDIF}
    {$IFDEF iOS}
        Style := TStyleStreaming.LoadFromResource(HInstance, 'OrangeStyle', RT_RCDATA);
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

procedure TfrmMain.tmrConnectedTimer(Sender: TObject);
begin
  tmrConnected.Enabled := false;
  if connected then
  begin
      btnLogin.Enabled := true;
      btnSignUp.Enabled := true;
  end
  else
  begin
    tmrConnected.Enabled := true;
  end;
end;

end.
