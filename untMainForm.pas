unit untMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Layouts,
  FMX.ExtCtrls, FMX.Edit, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, FMX.Memo, IdHTTP, untDataModule,untNotifications,
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
  private
    { Private declarations }
    sUserSalt   : String;
    procedure loginComplete;
  public
    { Public declarations }
  end;

  procedure showNewForm(ClassName : String);
  procedure showNewFormWithId(ClassName, sId : String);
  function getResultString(Content : String):String;

var
  frmMain: TfrmMain;
  FormRegistry : TStringList;

implementation

{$R *.fmx}
uses
  untBaseForm,System.JSON;

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

procedure showNewForm(ClassName : String);
var ObjClass: TFmxObjectClass;
    NewForm: TCustomForm;
    idx : Integer;
begin
  ObjClass := TFmxObjectClass(GetClass(ClassName));
  if ObjClass <> nil then
  begin
    // is it in the list???
    idx := FormRegistry.IndexOf(ClassName);
    if idx > -1 then
    begin
      NewForm := FormRegistry.Objects[idx] as TCustomForm;
    end
    else
    begin
      NewForm := ObjClass.Create(Application) as TCustomForm;
      FormRegistry.AddObject(ClassName,NewForm);
    end;
    if Assigned(NewForm) then
      NewForm.Show;
  end
end;

procedure showNewFormWithId(ClassName,sId : String);
var ObjClass: TFmxObjectClass;
    NewForm: TCustomForm;
    idx : Integer;
begin
  ObjClass := TFmxObjectClass(GetClass(ClassName));
  if ObjClass <> nil then
  begin
    // is it in the list???
    idx := FormRegistry.IndexOf(ClassName);
    if idx > -1 then
    begin
      NewForm := FormRegistry.Objects[idx] as TCustomForm;
    end
    else
    begin
      NewForm := ObjClass.Create(Application) as TCustomForm;
      FormRegistry.AddObject(ClassName,NewForm);
    end;
    if Assigned(NewForm) then
    begin
      TfrmBase(NewForm).id := sId;
      NewForm.Show;
    end;
  end
end;

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


procedure TfrmMain.loginComplete;
var
  bLoggedIn : Boolean;
begin
  // check if valid or invalid... by getting the datamodule to check.
  bLoggedIn := dmdDataModule.checkLogin;
  if bLoggedIn then
  begin
    showNewForm('TfrmNotifications');
  end
  else
    showmessage(dmdDataModule.respLogin.Content);
end;

initialization
  FormRegistry := TStringList.Create;
  FormRegistry.Duplicates := dupIgnore;
  FormRegistry.Sorted := True;
finalization
  FreeAndNil(FormRegistry);
end.
