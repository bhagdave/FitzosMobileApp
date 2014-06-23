unit untMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Layouts,
  FMX.ExtCtrls, FMX.Edit, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, FMX.Memo, IdHTTP, untDataModule,untNotifications, untFormController,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,DBXJSON, FMX.Objects;

type
  TfrmMain = class(TForm)
    imgLogo: TImageControl;
    edtUsername: TEdit;
    edtPassword: TEdit;
    btnLogin: TButton;
    btnSignup: TButton;
    txtWelcomeMessage: TText;
    procedure btnLoginClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    sUserSalt   : String;
    fController : TFormController;
    procedure loginComplete;
  public
    { Public declarations }
    constructor create; overload;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}
uses
  untBaseForm;

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
  dmdDataModule.reqLogin.ExecuteAsync(self.loginComplete);
end;

constructor TfrmMain.create;
begin
  fController := TFormController.Create;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  fController.Free;
end;

procedure TfrmMain.loginComplete;
var
  bLoggedIn : Boolean;
begin
  // check if valid or invalid... by getting the datamodule to check.
  bLoggedIn := dmdDataModule.checkLogin;
  if bLoggedIn then
  begin
    fController.showForm(TfrmNotifications);
  end
  else
    showmessage(dmdDataModule.respLogin.Content);
end;

end.
