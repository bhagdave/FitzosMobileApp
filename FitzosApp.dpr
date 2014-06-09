program FitzosApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  untMainForm in 'untMainForm.pas' {frmMain},
  untDataModule in 'untDataModule.pas' {dmdDataModule: TDataModule},
  untBaseForm in 'untBaseForm.pas' {frmBase},
  untNotifications in 'untNotifications.pas' {frmNotifications};

{$R *.res}

begin
  Application.Initialize;
  AApplication.CreateForm(TfrmMain, frmMain);
  AApplication.CreateForm(TdmdDataModule, dmdDataModule);
  AApplication.CreateForm(TfrmNotifications, frmNotifications);
  lication.Run;
end.
