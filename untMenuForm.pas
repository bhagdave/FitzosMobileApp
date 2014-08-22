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
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses
  untFormRegistry;

{$R *.fmx}

procedure TfrmMenu.btnEventsClick(Sender: TObject);
begin
  shownewForm('TFrmEvents');
end;

procedure TfrmMenu.btnFriendsClick(Sender: TObject);
begin
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

initialization
RegisterFMXClasses([TfrmMenu]);


end.
