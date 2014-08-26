unit untMenuForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Objects, untDataModule;

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
    procedure btnEventsClick(Sender: TObject);
    procedure btnFriendsClick(Sender: TObject);
    procedure btnNotificationsClick(Sender: TObject);
    procedure btnProfileClick(Sender: TObject);
    procedure btnSportsClick(Sender: TObject);
    procedure btnTeamsClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses
  untFormRegistry,FMX.Styles;

{$R *.fmx}

procedure TfrmMenu.btnEventsClick(Sender: TObject);
begin
  shownewForm('TFrmEvents');
end;

procedure TfrmMenu.btnFriendsClick(Sender: TObject);
begin
  lblFriends.Text := 'Loading...';
  showNewForm('TfrmFriends');
end;

procedure TfrmMenu.btnNotificationsClick(Sender: TObject);
begin
  showNewForm('TfrmNotifications');
end;

procedure TfrmMenu.btnProfileClick(Sender: TObject);
begin
  showNewFormWithId('TfrmProfile',dmdDataModule.memberId);
end;

procedure TfrmMenu.btnSportsClick(Sender: TObject);
begin
  showNewForm('TfrmSports');
end;

procedure TfrmMenu.btnTeamsClick(Sender: TObject);
begin
  showNewForm('TfrmTeams');
end;

procedure TfrmMenu.FormActivate(Sender: TObject);
begin
  lblFriends.Text := 'Friends';
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

initialization
RegisterFMXClasses([TfrmMenu]);


end.
