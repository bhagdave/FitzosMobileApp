unit untFrmSignUp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, DBXJSON, untAPI;

type
  TfrmSignUp = class(TForm)
    imgLogo: TImageControl;
    gbType: TGroupBox;
    btnAthlete: TRadioButton;
    btnTrainer: TRadioButton;
    edtUsername: TEdit;
    edtPassword: TEdit;
    edtConfirmPassword: TEdit;
    edtEmail: TEdit;
    btnSignup: TButton;
    procedure btnSignupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    API : TAPI;
  end;

implementation

{$R *.fmx}
Const
ACCESS_NAME = 'mobile';

procedure TfrmSignUp.btnSignupClick(Sender: TObject);
begin
  API.signUp(edtUsername.Text,edtEmail.Text,edtPassword.text, edtConfirmPassword.text)
end;

end.
