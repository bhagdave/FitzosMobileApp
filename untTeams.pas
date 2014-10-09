unit untTeams;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListView.Types, FMX.ListView, untDataModule,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  Data.Bind.Controls, FMX.Layouts, Fmx.Bind.Navigator, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, FMX.Notification, FMX.TabControl;

type
  TfrmTeams = class(TfrmBase)
    btnCreate: TButton;
    lvTeams: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField: TLinkFillControlToField;
    btnInvites: TSpeedButton;
    pnlInvites: TPanel;
    barInvites: TToolBar;
    lblInvites: TLabel;
    lvInvites: TListView;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField1: TLinkFillControlToField;
    tmrRefresh: TTimer;
    tabTeams: TTabControl;
    tabmyTeams: TTabItem;
    tabPublicTeams: TTabItem;
    procedure btnCreateClick(Sender: TObject);
    procedure lvTeamsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormActivate(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure lvInvitesButtonClick(const Sender: TObject;
      const AItem: TListViewItem; const AObject: TListItemSimpleControl);
    procedure lvInvitesDeleteItem(Sender: TObject; AIndex: Integer);
    procedure btnInvitesClick(Sender: TObject);
    procedure tmrRefreshTimer(Sender: TObject);
  private
    { Private declarations }
    procedure teamsLoaded;
    procedure threadTerminated(Sender : TObject);
    procedure loadInvites();
    procedure invitesLoaded();
  public
    { Public declarations }
  end;

implementation

uses
  untJsonFunctions,untFormRegistry, Rest.Client;

var
  myThread : TRESTExecutionThread;


{$R *.fmx}
procedure TfrmTeams.btnBackClick(Sender: TObject);
begin
  close;
end;

procedure TfrmTeams.btnCreateClick(Sender: TObject);
begin
  inherited;
  showNewForm('TfrmTeamCreate');
end;

procedure TfrmTeams.btnInvitesClick(Sender: TObject);
begin
  inherited;
  pnlInvites.Visible := not pnlInvites.Visible;
end;

procedure TfrmTeams.FormActivate(Sender: TObject);
begin
  inherited;
  if connected then
  begin
    with dmdDataModule do
    begin
      // Open up the data.
      rdsaMemberTeams.ClearDataSet;
      fdmMemberTeams.Close;
      respMemberTeams.Content.Empty;
      reqMemberTeams.ClearBody;
      reqMemberTeams.Params.ParameterByName('id').Value := memberId;
      reqMemberTeams.Params.ParameterByName('signature').Value := signature('getMembersTeams');
      reqMemberTeams.Params.ParameterByName('key').Value := getApiKey;
      myThread := reqMemberTeams.ExecuteAsync(teamsLoaded);
      myThread.OnTerminate := threadTerminated;
    end;
  end
  else
  begin
    showmessage('No internet connection at the moment!');
    close;
  end;
end;

procedure TfrmTeams.invitesLoaded;
var
  sResult : String;
begin
    sResult := getResultString(dmdDataModule.respTeamInvites.Content);
    if (sResult = 'OK') then
    begin
      btnInvites.Visible := true;
      dmdDataModule.rdsaTeamInvites.UpdateDataSet;
      dmdDataModule.fdmTeamInvites.Open;
    end
    else
    begin
      btnInvites.Visible := false;
      pnlInvites.Visible := false;
    end;
end;

procedure TfrmTeams.loadInvites;
begin
  with dmdDataModule do
  begin
    // Open up the data.
    rdsaTeamInvites.ClearDataSet;
    fdmTeamInvites.Close;
    respTeamInvites.Content.Empty;
    reqTeamInvites.ClearBody;
    reqTeamInvites.Params.ParameterByName('member_id').Value := memberId;
    reqTeamInvites.ExecuteAsync(invitesLoaded);
  end;
end;

procedure TfrmTeams.lvInvitesButtonClick(const Sender: TObject;
  const AItem: TListViewItem; const AObject: TListItemSimpleControl);
var
  LValue : TValue;
begin
  inherited;
  if connected then
  begin
    LValue := GetSelectedValue(lvInvites);
    tmrRefresh.Tag := aItem.index;
    tmrRefresh.Enabled := true;
    with dmdDatamodule do
    begin
//      fdmFriendRequests.close;
      reqGeneric.Params.Clear;
      reqGeneric.Resource := 'r/teams/acceptTeamInvite';
      reqGeneric.Params.addItem('team',lValue.ToString);
      reqGeneric.Params.addItem('member_id',memberId);
      reqGeneric.Execute;
    end;
  end
  else
  begin
    showmessage('No internet connection at the moment');
  end;
end;

procedure TfrmTeams.lvInvitesDeleteItem(Sender: TObject; AIndex: Integer);
var
  LValue : TValue;
begin
  inherited;
  if connected then
  begin
    LValue := GetSelectedValue(lvInvites);
    tmrRefresh.Tag := aindex;
    tmrRefresh.Enabled := true;
    with dmdDatamodule do
    begin
//      fdmFriendRequests.close;
      reqGeneric.Params.Clear;
      reqGeneric.Resource := 'r/teams/declineTeamInvite';
      reqGeneric.Params.addItem('team',lValue.ToString);
      reqGeneric.Params.addItem('member_id',memberId);
      reqGeneric.Execute;
    end;
  end
  else
  begin
    showmessage('No internet connection at the moment');
  end;
end;

procedure TfrmTeams.lvTeamsItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  LValue : TValue;
  sTeam : String;
begin
  inherited;
  LValue := GetSelectedValue(lvTeams);
  sTeam := lValue.ToString;
  showNewFormWithId('TfrmTeam',sTeam);
end;

procedure TfrmTeams.teamsLoaded;
var
  sResult : String;
begin
    sResult := getResultString(dmdDataModule.respMemberTeams.Content);
    if (sResult = 'OK') then
    begin
        lvTeams.Visible := false;
        lvTeams.BeginUpdate;
        dmdDataModule.rdsaMemberTeams.Response := dmdDataModule.respMemberTeams;
        dmdDataModule.rdsaMemberTeams.UpdateDataSet;
        if dmdDataModule.fdmMemberTeams.RecordCount > 0 then
          dmdDataModule.fdmMemberTeams.Open;
        lvTeams.EndUpdate;
        lvTeams.Visible := true;
    end;
    loadInvites();
end;

procedure TfrmTeams.threadTerminated(Sender: TObject);
begin
  if myThread <> nil then
     myThread := nil;
end;

procedure TfrmTeams.tmrRefreshTimer(Sender: TObject);
begin
  inherited;
  tmrRefresh.Enabled := false;
  loadInvites();
end;

initialization
RegisterFMXClasses([TfrmTeams]);

end.
