unit untFriends;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListView.Types, FMX.ListView, untDataModule,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, FGX.ProgressDialog,
  FMX.Notification, FMX.AndroidLike.Toast;

type
  TfrmFriends = class(TfrmBase)
    lvFriends: TListView;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    btnRequests: TSpeedButton;
    pnlRequests: TPanel;
    barRequests: TToolBar;
    lblFriendRequests: TLabel;
    lvRequests: TListView;
    BindSourceDB1: TBindSourceDB;
    LinkFillControlToField: TLinkFillControlToField;
    tmrRemove: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure lvFriendsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvRequestsDeleteItem(Sender: TObject; AIndex: Integer);
    procedure btnRequestsClick(Sender: TObject);
    procedure lvRequestsButtonClick(const Sender: TObject;
      const AItem: TListViewItem; const AObject: TListItemSimpleControl);
    procedure tmrRemoveTimer(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
    procedure friendsLoaded;
    procedure loadRequests;
    procedure requestsLoaded;
    procedure threadTerminated(Sender : TObject);
  public
    { Public declarations }
  end;


implementation
uses
  untJsonFunctions,untFormRegistry,Rest.Client;

var
  myThread : TRESTExecutionThread;


{$R *.fmx}

procedure TfrmFriends.btnRequestsClick(Sender: TObject);
begin
  inherited;
  pnlRequests.Visible := not pnlRequests.Visible;
end;

procedure TfrmFriends.FormActivate(Sender: TObject);
begin
  inherited;
  showActivityDialog('Loading friends','Please wait');
  if connected then
  begin
    with dmdDataModule do
    begin
      // Open up the data.
      rdsaFriends.ClearDataSet;
      fdmFriends.Close;
      respFriends.Content.Empty;
      reqFriends.ClearBody;
      reqFriends.Params.ParameterByName('id').Value := memberId;
      reqFriends.Params.ParameterByName('signature').Value := signature('getFriends');
      reqFriends.Params.ParameterByName('key').Value := getApiKey;
      myThread := reqFriends.ExecuteAsync(friendsLoaded);
      myThread.OnTerminate := threadTerminated;
    end;
  end
  else
  begin
    showmessage('No internet connection at the moment');
    close;
  end;
end;

procedure TfrmFriends.FormDeactivate(Sender: TObject);
begin
  inherited;
  fgActivityDialog.Hide;
end;

procedure TfrmFriends.friendsLoaded;
var
  sResult : String;
begin
    sResult := getResultString(dmdDataModule.respFriends.Content);
    if (sResult = 'OK') then
    begin
        lvFriends.Visible := false;
        lvFriends.BeginUpdate;
        dmdDataModule.rdsaFriends.Response := dmdDataModule.respFriends;
        dmdDataModule.rdsaFriends.UpdateDataSet;
        if dmdDataModule.fdmFriends.RecordCount > 0 then
          dmdDataModule.fdmFriends.Open;
        lvFriends.EndUpdate;
        lvFriends.Visible := true;
    end;
    loadRequests();
end;

procedure TfrmFriends.loadRequests;
begin
  with dmdDataModule do
  begin
    fdmFriendRequests.Close;
//    respFriendRequests.Content.Empty;
//    reqFriendRequests.ClearBody;
    reqFriendRequests.Params.ParameterByName('member_id').Value := memberId;
    reqFriendRequests.ExecuteAsync(requestsLoaded);
  end;
end;

procedure TfrmFriends.lvFriendsItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  LValue : TValue;
begin
  inherited;
  LValue := GetSelectedValue(lvFriends);
  showActivityDialog('Creating friend page','Please wait');
  showNewFormWithId('TfrmFriend',lValue.ToString);
end;

procedure TfrmFriends.lvRequestsButtonClick(const Sender: TObject;
  const AItem: TListViewItem; const AObject: TListItemSimpleControl);
var
  LValue : TValue;
begin
  inherited;
    if connected then
    begin
      LValue := GetSelectedValue(lvRequests);
      tmrRemove.Tag := aItem.index;
      tmrRemove.Enabled := true;
      with dmdDatamodule do
      begin
  //      fdmFriendRequests.close;
        reqGeneric.Params.Clear;
        reqGeneric.Resource := 'r/members/acceptFriendRequest';
        reqGeneric.Params.addItem('id',lValue.ToString);
        reqGeneric.Execute;
        saveMessage.Now('Friend accepted');
      end;
    end
    else
    begin
      showmessage('No internet connection at the moment');
    end;
end;

procedure TfrmFriends.lvRequestsDeleteItem(Sender: TObject; AIndex: Integer);
var
  LValue : TValue;
begin
  inherited;
  if connected then
  begin
    showActivityDialog('Deleting request','Please wait');
    LValue := GetSelectedValue(lvRequests);
    tmrRemove.Tag := aindex;
    tmrRemove.Enabled := true;
    with dmdDatamodule do
    begin
      reqGeneric.Params.Clear;
      reqGeneric.Resource := 'r/members/declineFriendRequest';
      reqGeneric.Params.addItem('id',lValue.ToString);
      reqGeneric.Execute;
      saveMessage.Now('Friend request declined');
    end;
    fgActivityDialog.Hide;
  end
  else
  begin
    showmessage('No internet connection at the moment!');
  end;
end;

procedure TfrmFriends.requestsLoaded;
var
  sResult : String;
begin
  sResult := getResultString(dmdDataModule.respFriendRequests.Content);
  if (sResult = 'OK') then
  begin
    btnRequests.Visible := true;
    dmdDataModule.rdsaFriendRequests.UpdateDataSet;
    dmdDataModule.fdmFriendRequests.Open;
  end
  else
  begin
    pnlRequests.Visible := false;
    btnRequests.Visible := false;
  end;
  fgActivityDialog.Hide;
end;

procedure TfrmFriends.threadTerminated(Sender: TObject);
begin
  myThread := nil;
end;

procedure TfrmFriends.tmrRemoveTimer(Sender: TObject);
begin
  inherited;
  tmrRemove.Enabled := false;
  loadRequests();
end;

initialization
RegisterFMXClasses([TfrmFriends]);

end.
