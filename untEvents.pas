unit untEvents;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListView.Types, FMX.ListView, untDataModule,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, FMX.TabControl;

type
  TfrmEvents = class(TfrmBase)
    lvEvents: TListView;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    btnCreateEvent: TButton;
    lvInvites: TListView;
    BindSourceDB1: TBindSourceDB;
    LinkFillControlToField2: TLinkFillControlToField;
    btnRefresh: TButton;
    AniIndicator1: TAniIndicator;
    tabEvents: TTabControl;
    tabMine: TTabItem;
    tabUpcoming: TTabItem;
    tabInvites: TTabItem;
    procedure lvEventsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnCreateEventClick(Sender: TObject);
    procedure lvInvitesDeleteItem(Sender: TObject; AIndex: Integer);
    procedure lvInvitesItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormShow(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
  private
    { Private declarations }
   procedure threadTerminated(Sender : TObject);
   procedure eventsLoaded;
   procedure invitesLoaded;
   procedure loadInvites;
   procedure getEvents();
  public
    { Public declarations }
  end;


implementation

uses
  untJsonFunctions,untFormRegistry,Rest.Client,untEventDataModule;
{$R *.fmx}

var
   myThread : TRESTExecutionThread;


{ TfrmEvents }

procedure TfrmEvents.btnCreateEventClick(Sender: TObject);
begin
  inherited;
  showNewFormWithId('TfrmEventCreation','');
end;

procedure TfrmEvents.btnRefreshClick(Sender: TObject);
begin
  inherited;
  getEvents();
end;

procedure TfrmEvents.eventsLoaded;
var
  sResult : String;
begin
    sResult := getResultString(dmdDatamodule.respEvents.Content);
    if (sResult = 'OK') then
    begin
        dmdDatamodule.rdsaEvents.UpdateDataSet;
        dmdDatamodule.fdmEvents.Open;
    end;
    loadInvites();
end;

procedure TfrmEvents.FormShow(Sender: TObject);
begin
  inherited;
  getEvents();
end;

procedure TfrmEvents.getEvents;
begin
  if connected then
  begin
    with dmdDataModule do
    begin
      // Open up the data.
      rdsaEvents.ClearDataSet;
      fdmEvents.Close;
      respEvents.Content.Empty;
      reqEvents.ClearBody;
      reqEvents.Params.ParameterByName('id').Value := memberId;
      reqEvents.Params.ParameterByName('signature').Value := signature('getEventsForMember');
      reqEvents.Params.ParameterByName('key').Value := getApiKey;
      AniIndicator1.Visible := true;
      AniIndicator1.enabled := true;
      myThread := reqEvents.ExecuteAsync(eventsLoaded);
      mythread.OnTerminate := threadTerminated;
    end;
  end
  else
  begin
    showmessage('No internet connection at the moment');
    close;
  end;
end;

procedure TfrmEvents.invitesLoaded;
var
  sStatus : String;
begin
  sStatus := getResultString(dmdEvent.respEventInvites.Content);
  if sStatus = 'OK' then
  begin
    dmdEvent.rdsaEventInvites.UpdateDataSet;
    dmdEvent.fdmEventInvites.Open;
  end else
  begin
  end;
end;

procedure TfrmEvents.loadInvites;
begin
    // get the event invites.
    dmdEvent.reqEventInvites.Params.ParameterByName('member_id').Value := dmdDataModule.memberId;
    dmdEvent.reqEventInvites.ExecuteAsync(invitesLoaded);
end;

procedure TfrmEvents.lvEventsItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  LValue : TValue;
begin
  inherited;
  LValue := GetSelectedValue(lvEvents);
  showNewFormWithId('TfrmEvent',LValue.ToString);
end;

procedure TfrmEvents.lvInvitesDeleteItem(Sender: TObject; AIndex: Integer);
var
  LValue : TValue;
begin
  inherited;
    LValue := GetSelectedValue(lvInvites);
    with dmdEvent do
    begin
      reqGeneric.Resource := 'r/events/declineInvite';
      reqGeneric.Params.addItem('member_id',dmdDataModule.memberId);
      reqGeneric.Params.AddItem('event',lValue.ToString);
      reqGeneric.Params.addItem('signature',dmdDatamodule.signature('declineEvent'));
      reqGeneric.Params.addItem('key',dmdDatamodule.getApiKey);
      reqGeneric.Execute;
    end;
    loadInvites;
end;

procedure TfrmEvents.lvInvitesItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  lValue : TValue;
begin
  lValue := GetSelectedValue(lvInvites);
  ShowNewFormWithId('TfrmEvent',LValue.ToString);
end;

procedure TfrmEvents.threadTerminated(Sender: TObject);
begin
  myThread := nil;
    AniIndicator1.Visible := false;
    AniIndicator1.enabled := false;
end;

initialization
RegisterFMXClasses([TfrmEvents]);

end.
