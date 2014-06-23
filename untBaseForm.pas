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
    lblCaption: TLabel;
    StyleBook1: TStyleBook;
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
  untMainForm;

procedure TfrmBase.btnEventsClick(Sender: TObject);
begin
    showNewForm('TfrmEvents');
end;

procedure TfrmBase.btnFriendsClick(Sender: TObject);
begin
    showNewForm('TfrmFriends');
end;

procedure TfrmBase.btnNotificationsClick(Sender: TObject);
begin
    showNewForm('TfrmNotifications');
end;

procedure TfrmBase.btnTeamsClick(Sender: TObject);
begin
    showNewForm('TfrmTeams');
end;

end.
