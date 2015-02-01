unit untEvents;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListView.Types, FMX.ListView, untDataModule,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, FMX.TabControl, FMX.Notification,
  FGX.ProgressDialog, FMX.AndroidLike.Toast;

type
  TfrmEvents = class(TfrmBase)
    lvEvents: TListView;
    BindingsList1: TBindingsList;
    btnCreateEvent: TButton;
    BindSourceDB1: TBindSourceDB;
    LinkFillControlToField2: TLinkFillControlToField;
    AniIndicator1: TAniIndicator;
    tabEvents: TTabControl;
    tabMine: TTabItem;
    tabUpcoming: TTabItem;
    lvUpcoming: TListView;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField3: TLinkFillControlToField;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure lvEventsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnCreateEventClick(Sender: TObject);
    procedure lvInvitesDeleteItem(Sender: TObject; AIndex: Integer);
    procedure lvInvitesItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnRefreshClick(Sender: TObject);
    procedure lvUpcomingItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
   procedure threadTerminated(Sender : TObject);
   procedure eventsLoaded;
   procedure invitesLoaded;
   procedure loadInvites;
   procedure loadUpcoming();
   procedure getEvents();
  public
    { Public declarations }
    procedure refresh();override;
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
  showActivityDialog('Loading event creation','Please wait');
  showNewFormWithIdFromParent('TfrmEventCreation','',self);
  self.Deactivate;
end;

procedure TfrmEvents.btnRefreshClick(Sender: TObject);
begin
  inherited;
    showActivityDialog('Refreshing data','Please wait');
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
    loadUpcoming();
//    loadInvites();
end;

procedure TfrmEvents.FormActivate(Sender: TObject);
begin
  inherited;
  showActivityDialog('Loading all data','Please wait');
  getEvents();
end;

procedure TfrmEvents.FormDeactivate(Sender: TObject);
begin
  inherited;
  fgActivityDialog.Hide;
end;

procedure TfrmEvents.getEvents;
begin
  if connected then
  begin
    fgActivityDialog.Message := 'Loading events';
    with dmdDataModule do
    begin
      // Open up the data.
      rdsaEvents.ClearDataSet;
      fdmEvents.Close;
      respEvents.Content.Empty;
      reqEvents.ClearBody;
      reqEvents.Params.ParameterByName('id').Value := memberId;
      reqEvents.Params.ParameterByName('signature').Value := signature('getEventsForMember');
      reqEvents.Params.ParameterByName('key').Value := sessionkey;
      AniIndicator1.Visible := true;
      AniIndicator1.enabled := true;
      myThread := reqEvents.ExecuteAsync(eventsLoaded);
      mythread.OnTerminate := threadTerminated;
    end;
  end
  else
  begin
    fgActivityDialog.Hide;
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
  fgActivityDialog.Hide;
end;

procedure TfrmEvents.loadInvites;
begin
    fgActivityDialog.Message := 'Loading invites';
    // get the event invites.
    dmdEvent.reqEventInvites.Params.ParameterByName('member_id').Value := dmdDataModule.memberId;
    dmdEvent.reqEventInvites.Params.ParameterByName('key').Value := dmdDataModule.sessionkey;
    dmdEvent.reqEventInvites.ExecuteAsync(invitesLoaded);
end;

procedure TfrmEvents.loadUpcoming;
begin
  try
    fgActivityDialog.Message := 'Loading upcoming events';
    dmdEvent.rdsaUpcomingEvents.ClearDataSet;
    dmdEvent.fdmUpcomingEvents.Close;
    dmdEvent.respUpcomingEvents.Content.Empty;
    dmdEvent.reqUpcomingEvents.ClearBody;
    dmdEvent.reqUpcomingEvents.Params.AddItem('key',dmdDatamodule.sessionkey);
    dmdEvent.reqUpcomingEvents.Execute;
    dmdEvent.rdsaUpcomingEvents.UpdateDataSet;
    dmdEvent.fdmUpcomingEvents.Open;
  except on E: Exception do  begin
    fgActivityDialog.Hide;
    showmessage(e.Message);
  end;
  end;
end;

procedure TfrmEvents.lvEventsItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  LValue : TValue;
begin
  inherited;
//  showActivityDialog('Going to required event','Please wait');
  LValue := GetSelectedValue(lvEvents);
  showNewFormWithId('TfrmEvent',LValue.ToString);
end;

procedure TfrmEvents.lvInvitesDeleteItem(Sender: TObject; AIndex: Integer);
//var
//  LValue : TValue;
begin
//  inherited;
//    LValue := GetSelectedValue(lvInvites);
//    with dmdEvent do
//    begin
//      reqGeneric.Resource := 'r/events/declineInvite';
//      reqGeneric.Params.addItem('member_id',dmdDataModule.memberId);
//      reqGeneric.Params.AddItem('event',lValue.ToString);
//      reqGeneric.Params.addItem('signature',dmdDatamodule.signature('declineEvent'));
//      reqGeneric.Params.addItem('key',dmdDatamodule.sessionkey);
//      reqGeneric.Execute;
//      saveMessage.Now('Event invite declined');
//    end;
//    loadInvites;
end;

procedure TfrmEvents.lvInvitesItemClick(const Sender: TObject;
  const AItem: TListViewItem);
//var
//  lValue : TValue;
begin
//  showActivityDialog('Showing event','Please wait');
//  lValue := GetSelectedValue(lvInvites);
//  ShowNewFormWithIdFromParent('TfrmEvent',LValue.ToString,self);
end;

procedure TfrmEvents.lvUpcomingItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  lValue : TValue;
begin
  showActivityDialog('Showing event','Please wait');
  lValue := GetSelectedValue(lvUpcoming);
  ShowNewFormWithIdFromParent('TfrmEvent',LValue.ToString,self);
end;

procedure TfrmEvents.refresh;
begin
  inherited;
  getEvents();
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
