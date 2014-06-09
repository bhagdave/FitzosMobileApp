program FitzosApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  untMainForm in 'untMainForm.pas' {frmMain},
  untDataModule in 'untDataModule.pas' {dmdDataModule: TDataModule},
  untBaseForm in 'untBaseForm.pas' {frmBase};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmdDataModule, dmdDataModule);
  Application.Run;
end.
