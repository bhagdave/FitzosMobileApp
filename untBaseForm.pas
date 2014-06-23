unit untBaseForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Objects, FMX.StdCtrls,untIntFormController;

type
  TfrmBase = class(TForm)
    edtSearch: TEdit;
    btnProfile: TSpeedButton;
    imgAvatar: TImage;
    barTop: TToolBar;
    barBottom: TToolBar;
    pnlTop: TPanel;
    btnEvents: TCornerButton;
    btnTeams: TCornerButton;
    btnNotifications: TCornerButton;
    btnFriends: TCornerButton;
    imgSearch: TImage;
    pnlCenter: TPanel;
    procedure btnEventsClick(Sender: TObject);
    procedure btnTeamsClick(Sender: TObject);
    procedure btnNotificationsClick(Sender: TObject);
    procedure btnFriendsClick(Sender: TObject);
  private
    { Private declarations }
    formController : iFrmController;
  public
    { Public declarations }
    constructor create(ifc : iFrmController);
  end;

var
  frmBase: TfrmBase;

implementation

{$R *.fmx}
uses
  untEvents, untTeams, untNotifications, untFriends, untFormController;

procedure TfrmBase.btnEventsClick(Sender: TObject);
begin
  formController.showForm(TfrmEvents);
end;

procedure TfrmBase.btnFriendsClick(Sender: TObject);
begin
  formController.showForm(TfrmFriends);
end;

procedure TfrmBase.btnNotificationsClick(Sender: TObject);
begin
  formController.showForm(TfrmNotifications);
end;

procedure TfrmBase.btnTeamsClick(Sender: TObject);
begin
  formController.showForm(TfrmTeams);
end;

constructor TfrmBase.create(ifc: iFrmController);
begin
  formController := ifc;
end;

end.
