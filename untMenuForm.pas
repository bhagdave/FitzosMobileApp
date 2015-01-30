unit untMenuForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Objects, untDataModule, FGX.ProgressDialog;

type
  TfrmMenu = class(TForm)
    GridPanelLayout1: TGridPanelLayout;
    btnEvents: TRectangle;
    lblEvents: TLabel;
    btnTeams: TRectangle;
    lblTeams: TLabel;
    btnNotifications: TRectangle;
    btnFriends: TRectangle;
    lblNotifications: TLabel;
    lblFriends: TLabel;
    btnSports: TRectangle;
    btnProfile: TRectangle;
    lblSports: TLabel;
    lblProfile: TLabel;
    imgLogo: TImageControl;
    imgEvents: TImage;
    imgTeams: TImage;
    imgNotifications: TImage;
    imgFriends: TImage;
    imgSports: TImage;
    imgProfile: TImage;
    fgActivityDialog: TfgActivityDialog;
    procedure btnEventsClick(Sender: TObject);
    procedure btnFriendsClick(Sender: TObject);
    procedure btnNotificationsClick(Sender: TObject);
    procedure btnProfileClick(Sender: TObject);
    procedure btnSportsClick(Sender: TObject);
    procedure btnTeamsClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
    procedure showActivityDialog(Title,Mesg : String);
  public
    { Public declarations }
  end;


implementation

uses
  untFormRegistry,FMX.Styles;

{$R *.fmx}
{$R *.SmXhdpiPh.fmx ANDROID}

procedure TfrmMenu.btnEventsClick(Sender: TObject);
begin
  showActivityDialog('Loading Events','Please wait');
  shownewForm('TFrmEvents');
  fgActivityDialog.Hide;
end;

procedure TfrmMenu.btnFriendsClick(Sender: TObject);
begin
  showActivityDialog('Loading Friends','Please wait');
  showNewForm('TfrmFriends');
  fgActivityDialog.Hide;
end;

procedure TfrmMenu.btnNotificationsClick(Sender: TObject);
begin
  showActivityDialog('Loading Notifications','Please wait');
  showNewForm('TfrmNotifications');
  fgActivityDialog.Hide;
end;

procedure TfrmMenu.btnProfileClick(Sender: TObject);
begin
  showActivityDialog('Loading Profile','Please wait');
  showNewFormWithId('TfrmProfile',dmdDataModule.memberId);
  fgActivityDialog.Hide;
end;

procedure TfrmMenu.btnSportsClick(Sender: TObject);
begin
  showActivityDialog('Loading Sports','Please wait');
  showNewForm('TfrmSports');
  fgActivityDialog.Hide;
end;

procedure TfrmMenu.btnTeamsClick(Sender: TObject);
begin
  showActivityDialog('Loading Teams','Please wait');
  showNewForm('TfrmTeams');
  fgActivityDialog.Hide;
end;

procedure TfrmMenu.FormActivate(Sender: TObject);
begin
  fgActivityDialog.Hide;
end;

procedure TfrmMenu.FormCreate(Sender: TObject);
var
    Style: TFMXObject;
begin
    {$IFDEF MSWINDOWS}
        Style := TStyleStreaming.LoadFromResource(HInstance, 'OrangeStyle', RT_RCDATA);
    {$ENDIF}

    {$IFDEF Android}
        Style := TStyleStreaming.LoadFromResource(HInstance, 'OrangeStyle', RT_RCDATA);
    {$ENDIF}
    {$IFDEF iOS}
        Style := TStyleStreaming.LoadFromResource(HInstance, 'OrangeStyle', RT_RCDATA);
    {$ENDIF}
    if Style<> nil then
        TStyleManager.SetStyle(Style);
end;

procedure TfrmMenu.FormDeactivate(Sender: TObject);
begin
  fgActivityDialog.Hide;
end;

procedure TfrmMenu.FormResize(Sender: TObject);
begin
  if (self.Height < 460) then
  begin
    imgEvents.Margins.Top := 0;
    imgFriends.Margins.Top := 0;
    imgTeams.Margins.Top := 0;
    imgNotifications.Margins.Top := 0;
    imgSports.Margins.Top := 0;
    imgProfile.Margins.Top := 0;
    lblEvents.Visible := false;
    lblTeams.Visible := false;
    lblNotifications.Visible := false;
    lblFriends.Visible := false;
    lblSports.Visible := false;
    lblProfile.Visible := false;
  end
  else
  begin
    imgEvents.Margins.Top := 15;
    imgFriends.Margins.Top := 15;
    imgTeams.Margins.Top := 15;
    imgNotifications.Margins.Top := 15;
    imgSports.Margins.Top := 15;
    imgProfile.Margins.Top := 15;
    lblEvents.Visible := true;
    lblTeams.Visible := true;
    lblNotifications.Visible := true;
    lblFriends.Visible := true;
    lblSports.Visible := true;
    lblProfile.Visible := true;
  end;
end;

procedure TfrmMenu.showActivityDialog(Title, Mesg: String);
begin
  fgActivityDialog.Title := title;
  fgActivityDialog.Message := Mesg;
  fgActivityDialog.Show;
end;

initialization
RegisterFMXClasses([TfrmMenu]);


end.
