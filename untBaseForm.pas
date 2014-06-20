unit untBaseForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Objects, FMX.StdCtrls;

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
  public
    { Public declarations }
  end;

var
  frmBase: TfrmBase;

implementation

{$R *.fmx}
uses
  untEvents, untTeams, untNotifications, untFriends;

procedure TfrmBase.btnEventsClick(Sender: TObject);
var
  frmEvents : TfrmEvents;
begin
    frmEvents := TfrmEvents.Create(self);
    frmEvents.ShowModal(
      procedure(ModalResult: TModalResult)
      begin
        if ModalResult = mrOK then
        begin
        end;
      end);
    frmEvents.Free;
end;

procedure TfrmBase.btnFriendsClick(Sender: TObject);
var
  frmFriends : TfrmFriends;
begin
    frmFriends := TfrmFriends.Create(self);
    frmFriends.ShowModal(
      procedure(ModalResult: TModalResult)
      begin
        if ModalResult = mrOK then
        begin
        end;
      end);
    frmFriends.Free;
end;

procedure TfrmBase.btnNotificationsClick(Sender: TObject);
var
  frmNotifications : TfrmNotifications;
begin
    frmNotifications := TfrmNotifications.Create(self);
    frmNotifications.ShowModal(
      procedure(ModalResult: TModalResult)
      begin
        if ModalResult = mrOK then
        begin
        end;
      end);
    frmNotifications.Free;
end;

procedure TfrmBase.btnTeamsClick(Sender: TObject);
var
  frmTeams : TfrmTeams;
begin
    frmTeams := TfrmTeams.Create(self);
    frmTeams.ShowModal(
      procedure(ModalResult: TModalResult)
      begin
        if ModalResult = mrOK then
        begin
        end;
      end);
    frmTeams.Free;
end;

end.
