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
    procedure lblEventsClick(Sender: TObject);
    procedure lblTeamsClick(Sender: TObject);
    procedure lblNotificationsClick(Sender: TObject);
    procedure lblFriendsClick(Sender: TObject);
    procedure lblSportsClick(Sender: TObject);
    procedure lblProfileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses
  untFormRegistry;

{$R *.fmx}

procedure TfrmMenu.lblEventsClick(Sender: TObject);
begin
  shownewForm('TFrmEvents');
end;

procedure TfrmMenu.lblFriendsClick(Sender: TObject);
begin
    showNewForm('TfrmFriends');
end;

procedure TfrmMenu.lblNotificationsClick(Sender: TObject);
begin
    showNewForm('TfrmNotifications');
end;

procedure TfrmMenu.lblProfileClick(Sender: TObject);
begin
  showNewFormWithId('TfrmProfile',dmdDataModule.memberId);
end;

procedure TfrmMenu.lblSportsClick(Sender: TObject);
begin
  showNewForm('TfrmSports');
end;

procedure TfrmMenu.lblTeamsClick(Sender: TObject);
begin
    showNewForm('TfrmTeams');
end;

initialization
RegisterFMXClasses([TfrmMenu]);


end.
