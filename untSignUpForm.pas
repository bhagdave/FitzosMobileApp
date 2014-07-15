unit untSignUpForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.ListBox, FMX.Edit,untDmdSignup;

type
  TfrmSignup = class(TForm)
    imgLogo: TImageControl;
    txtWelcomeMessage: TText;
    cboType: TComboBox;
    edtName: TEdit;
    edtEmail: TEdit;
    edtPassword: TEdit;
    btnSignup: TButton;
    StyleBook1: TStyleBook;
    procedure btnSignupClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    dmdSignup: TdmdSignup;
  public
    { Public declarations }
  end;

implementation

uses
  untMainForm;

{$R *.fmx}
procedure TfrmSignup.btnSignupClick(Sender: TObject);
var
  sResult : String;
  bExists : Boolean;
begin
  // ok lets check to see if the user exists already
  with dmdSignup do
  begin
      respCheckExists.Content.Empty;
      reqCheckExists.ClearBody;
      reqCheckExists.Params.ParameterByName('data[email]').Value := edtEmail.Text;
      reqCheckExists.Execute;
      sResult := getResultString(respCheckExists.Content);
      if (sResult = 'OK') then
      begin
        bExists := getResultBoolean(respCheckExists.Content,'Result');
        if bExists then
        begin
          showmessage('That email address is already in use!');
        end
        else
        begin
          // ok we can process the call
        end;
      end
      else
      begin
        showmessage('UNable to connect to server. Please try later!');
      end;
  end;
end;

procedure TfrmSignup.FormCreate(Sender: TObject);
begin
  dmdSignup := TdmdSignup.Create(self);
end;

procedure TfrmSignup.FormDestroy(Sender: TObject);
begin
  dmdSignup.Free;
end;

initialization
RegisterFMXClasses([TfrmSignup]);

end.
