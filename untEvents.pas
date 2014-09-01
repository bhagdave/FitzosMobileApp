unit untEvents;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListView.Types, FMX.ListView, untDataModule,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TfrmEvents = class(TfrmBase)
    lvEvents: TListView;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    btnCreateEvent: TButton;
    pnlWait: TPanel;
    lblMessage: TLabel;
    btnInvites: TSpeedButton;
    pnlInvites: TPanel;
    barInvites: TToolBar;
    lblInvites: TLabel;
    lvInvites: TListView;
    BindSourceDB1: TBindSourceDB;
    LinkFillControlToField2: TLinkFillControlToField;
    procedure FormActivate(Sender: TObject);
    procedure lvEventsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnCreateEventClick(Sender: TObject);
    procedure btnInvitesClick(Sender: TObject);
    procedure lvInvitesDeleteItem(Sender: TObject; AIndex: Integer);
  private
    { Private declarations }
   procedure threadTerminated(Sender : TObject);
   procedure eventsLoaded;
   procedure invitesLoaded;
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
  pnlWait.Visible := true;
  showNewForm('TfrmEventCreation');
end;

procedure TfrmEvents.btnInvitesClick(Sender: TObject);
begin
  inherited;
  pnlInvites.Visible := not pnlInvites.Visible;
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
    // get the event invites.
    dmdEvent.reqEventInvites.Params.ParameterByName('member_id').Value := dmdDataModule.memberId;
    dmdEvent.reqEventInvites.ExecuteAsync(invitesLoaded);
end;

procedure TfrmEvents.FormActivate(Sender: TObject);
begin
  inherited;
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
    myThread := reqEvents.ExecuteAsync(eventsLoaded);
    mythread.OnTerminate := threadTerminated;
  end;
  pnlWait.Visible := false;
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
    btnInvites.Visible := true;
  end else
  begin
    btnInvites.Visible := false;
  end;
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
begin
  inherited;
  // ok send a message to the back end saying no...
end;

procedure TfrmEvents.threadTerminated(Sender: TObject);
begin
  myThread := nil;
end;

initialization
RegisterFMXClasses([TfrmEvents]);

end.
