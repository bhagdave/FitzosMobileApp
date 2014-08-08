unit untBaseForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Objects, FMX.StdCtrls, untDataModule, Data.Bind.Components, System.RTTI;

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
    pnlCenter: TPanel;
    lblCaption: TLabel;
    StyleBook1: TStyleBook;
    procedure btnEventsClick(Sender: TObject);
    procedure btnTeamsClick(Sender: TObject);
    procedure btnNotificationsClick(Sender: TObject);
    procedure btnFriendsClick(Sender: TObject);
    procedure btnProfileClick(Sender: TObject);
    procedure imgAvatarClick(Sender: TObject);
    procedure edtSearchExit(Sender: TObject);
  private
    { Private declarations }
    fId : String;
    procedure setId(sId : String);
  public
    { Public declarations }
    function getSelectedValue(AObject : TObject): TValue;
    property Id : String read fId write setId;

  end;

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

procedure TfrmBase.btnProfileClick(Sender: TObject);
begin
  showNewFormWithId('TfrmProfile',dmdDataModule.memberId);
end;

procedure TfrmBase.btnTeamsClick(Sender: TObject);
begin
    showNewForm('TfrmTeams');
end;

procedure TfrmBase.edtSearchExit(Sender: TObject);
begin
  shownewFormwithId('TfrmSearch',edtSearch.Text);
end;

function TfrmBase.getSelectedValue(AObject: TObject): TValue;
var
  LEditor : IBindListEditorCommon;
begin
  LEditor := GetBindEditor(AObject, IBindListEditorCommon) as IBindListEditorCommon;
  Result := Leditor.SelectedValue;
end;

procedure TfrmBase.imgAvatarClick(Sender: TObject);
begin
//
end;

procedure TfrmBase.setId(sId: String);
begin
  fId := sId;
end;

end.
