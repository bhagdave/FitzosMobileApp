program FitzosApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  untMainForm in 'untMainForm.pas' {frmMain},
  untDataModule in 'untDataModule.pas' {dmdDataModule: TDataModule},
  untBaseForm in 'untBaseForm.pas' {frmBase},
  untNotifications in 'untNotifications.pas' {frmNotifications},
  untFriends in 'untFriends.pas' {frmFriends},
  untEvents in 'untEvents.pas' {frmEvents},
  untTeams in 'untTeams.pas' {frmTeams},
  untNotification in 'untNotification.pas' {frmNotification},
  untSearch in 'untSearch.pas' {frmSearch},
  untFriend in 'untFriend.pas' {frmFriend},
  untEvent in 'untEvent.pas' {frmEvent},
  untTeam in 'untTeam.pas' {frmTeam},
  untTeamCreate in 'untTeamCreate.pas' {frmTeamCreate},
  untEventCreation in 'untEventCreation.pas' {frmEventCreation},
  untSettings in 'untSettings.pas' {frmSettings},
  untProfile in 'untProfile.pas' {frmProfile};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmdDataModule, dmdDataModule);
  Application.CreateForm(TfrmNotifications, frmNotifications);
  Application.Run;
end.
