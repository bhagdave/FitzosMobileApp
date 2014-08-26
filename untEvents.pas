unit untEvents;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListView.Types, FMX.ListView, untDataModule,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components;

type
  TfrmEvents = class(TfrmBase)
    lvEvents: TListView;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    btnCreateEvent: TButton;
    pnlWait: TPanel;
    lblMessage: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure lvEventsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnCreateEventClick(Sender: TObject);
  private
    { Private declarations }
   procedure threadTerminated(Sender : TObject);
   procedure eventsLoaded;
  public
    { Public declarations }
  end;


implementation

uses
  untJsonFunctions,untFormRegistry,Rest.Client;
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

procedure TfrmEvents.eventsLoaded;
var
  sResult : String;
begin
    sResult := getResultString(dmdDatamodule.respEvents.Content);
    if (sResult = 'OK') then
    begin
      try
        dmdDatamodule.rdsaEvents.UpdateDataSet;
        dmdDatamodule.fdmEvents.Open;
      except on E: Exception do
      end;
    end;
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

procedure TfrmEvents.lvEventsItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  LValue : TValue;
begin
  inherited;
  LValue := GetSelectedValue(lvEvents);
  showNewFormWithId('TfrmEvent',LValue.ToString);
end;

procedure TfrmEvents.threadTerminated(Sender: TObject);
begin
  myThread := nil;
end;

initialization
RegisterFMXClasses([TfrmEvents]);

end.
