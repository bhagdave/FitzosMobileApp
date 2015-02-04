program FitzosApp;

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  untMainForm in 'untMainForm.pas' {frmMain},
  untDataModule in 'untDataModule.pas' {dmdDataModule: TDataModule},
  untBaseForm in 'untBaseForm.pas' {frmBase},
  untNotifications in 'untNotifications.pas' {frmNotifications},
  untEvents in 'untEvents.pas' {frmEvents},
  untTeams in 'untTeams.pas' {frmTeams},
  untNotification in 'untNotification.pas' {frmNotification},
  untSearch in 'untSearch.pas' {frmSearch},
  untEvent in 'untEvent.pas' {frmEvent},
  untTeam in 'untTeam.pas' {frmTeam},
  untTeamCreate in 'untTeamCreate.pas' {frmTeamCreate},
  untEventCreation in 'untEventCreation.pas' {frmEventCreation},
  untSettings in 'untSettings.pas' {frmSettings},
  untProfile in 'untProfile.pas' {frmProfile},
  untEventDataModule in 'untEventDataModule.pas' {dmdEvent: TDataModule},
  untSignUpForm in 'untSignUpForm.pas' {frmSignup},
  untTeamWall in 'untTeamWall.pas' {frmTeamWall},
  untDmdSignup in 'untDmdSignup.pas' {dmdSignup: TDataModule},
  untDmdSports in 'untDmdSports.pas' {dmdSports: TDataModule},
  untFormRegistry in 'untFormRegistry.pas',
  untJSONFunctions in 'untJSONFunctions.pas',
  untMenuForm in 'untMenuForm.pas' {frmMenu};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmdDataModule, dmdDataModule);
  Application.CreateForm(TdmdEvent, dmdEvent);
  Application.CreateForm(TdmdSports, dmdSports);
  Application.Run;
end.
