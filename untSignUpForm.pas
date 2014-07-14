unit untSignUpForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.ListBox, FMX.Edit;

type
  TfrmSignup = class(TForm)
    imgLogo: TImageControl;
    txtWelcomeMessage: TText;
    cboType: TComboBox;
    edtName: TEdit;
    edtEmail: TEdit;
    edtPassword: TEdit;
    btnSignup: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  untMainForm;

{$R *.fmx}
initialization
RegisterFMXClasses([TfrmSignup]);

end.
