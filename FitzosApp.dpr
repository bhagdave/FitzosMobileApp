program FitzosApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  untMainForm in 'untMainForm.pas' {frmMain},
  untJSONFunctions in 'untJSONFunctions.pas',
  untFrmSignUp in 'untFrmSignUp.pas' {frmSignUp},
  untAPI in 'untAPI.pas',
  untAthleteWelcome in 'untAthleteWelcome.pas' {frmAthleteWelcome},
  untAthleteProfile in 'untAthleteProfile.pas' {frmAthleteProfile};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
