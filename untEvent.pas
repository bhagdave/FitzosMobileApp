unit untEvent;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, untEventDataModule, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.DBScope, FMX.ListView.Types,
  FMX.ListView, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  FMX.Notification;

type
  TfrmEvent = class(TfrmBase)
    lblContent: TLabel;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    lblDate: TLabel;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    expAttending: TExpander;
    lvAttending: TListView;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField1: TLinkFillControlToField;
    expWall: TExpander;
    lvWall: TListView;
    BindSourceDB3: TBindSourceDB;
    LinkFillControlToField2: TLinkFillControlToField;
    btnEdit: TButton;
    btnPost: TButton;
    btnAttend: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure lvAttendingItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnPostClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnAttendClick(Sender: TObject);
  private
    { Private declarations }
    bOwner : Boolean;
    bAttending : Boolean;
    procedure postWallMessage(sMessage:String);
    procedure eventLoaded;
    procedure eventThreadTerminated(Sender : TObject);
    procedure postWallCompleted;
    procedure getEventData;
  public
    { Public declarations }
  end;

implementation

uses
  untDataModule, untJsonFunctions,untFormRegistry, Rest.client, System.JSON;
var
  eventThread : TRESTExecutionThread;
{$R *.fmx}


procedure TfrmEvent.btnAttendClick(Sender: TObject);
begin
  inherited;
  if connected then
  begin
    with dmdEvent do
    begin
      reqGeneric.Resource := 'r/events/acceptInvite';
      reqGeneric.Params.addItem('member_id',dmdDataModule.memberId);
      reqGeneric.Params.AddItem('event',id);
      reqGeneric.Params.addItem('signature',dmdDatamodule.signature('declineEvent'));
      reqGeneric.Params.addItem('key',dmdDatamodule.getApiKey);
      reqGeneric.Execute;
      btnAttend.Visible := false;
      getEventData();
    end;
  end
  else
  begin
    self.showmessage('No internet connection at the moment!');
  end;
end;

procedure TfrmEvent.btnEditClick(Sender: TObject);
begin
  inherited;
  showNewFormWithId('TfrmEventCreation',id);
end;

procedure TfrmEvent.btnPostClick(Sender: TObject);
var
  sMessage : String;
begin
  inherited;
  if connected then
  begin
    sMessage := inputbox('Wall Message','Please enter your post','');
    if (sMessage <> '') then
    begin
      postWallMessage(sMessage);
    end;
  end
  else
  begin
    self.showmessage('No internet connection at the moment');
  end;
end;

procedure TfrmEvent.eventLoaded;
var
  sStatus,sResult : String;
begin
  with dmdEvent do
  begin
      sStatus := getResultString(respAllEventData.Content);
      if (sStatus = 'OK') then
      begin
          rdsaEvent.UpdateDataSet;
          fdmEvent.Open;
          sResult := getResultElementAsString(respAllEventData.Content,'attending');
          if (sResult <> '[]') then
          begin
            rdsaAttending.UpdateDataSet;
            fdmAttending.Open;
          end else
          begin
            fdmAttending.close;
          end;
          sResult := getResultElementAsString(respAllEventData.Content,'wall');
          if (sResult <> '[]') then
          begin
            rdsaWall.UpdateDataSet;
            fdmWall.Open;
          end else
          begin
              fdmWall.close;
          end;
          bOwner := fdmEvent.FieldByName('isOwner').AsString = 'Yes';
          bAttending := fdmEvent.FieldByName('isAttendee').AsString = 'Yes';
          btnEdit.Visible := bOwner;
          btnPost.Visible := bOwner or bAttending;
          btnAttend.Visible := not bAttending;
      end;
  end;
end;

procedure TfrmEvent.eventThreadTerminated(Sender: TObject);
begin
  eventThread := nil;
end;

procedure TfrmEvent.FormActivate(Sender: TObject);
begin
  if connected then
  begin
    getEventData();
  end
  else
  begin
    self.showmessage('No internet connection at the moment!');
    close;
  end;
end;



procedure TfrmEvent.getEventData;
begin
  with dmdEvent do
  begin
      // Open up the data.
      rdsaEvent.ClearDataSet;
      fdmEvent.Close;
      respAllEventData.Content.Empty;
      reqAllEventData.ClearBody;
      reqAllEventData.Params.ParameterByName('id').Value := id;
      reqAllEventData.Params.ParameterByName('member_id').Value := dmdDataModule.memberId;
//      reqAllEventData.Params.ParameterByName('signature').Value := dmdDataModule.signature('getAllEventData');
//      reqAllEventData.Params.ParameterByName('key').Value := dmdDataModule.getApiKey;
      eventThread := reqAllEventData.ExecuteAsync(eventLoaded);
      eventThread.OnTerminate := eventThreadTerminated;
  end;

end;

procedure TfrmEvent.lvAttendingItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  LValue : TValue;
begin
  inherited;
  LValue := GetSelectedValue(lvAttending);
  showNewFormWithId('TfrmFriend',lValue.ToString);
end;


procedure TfrmEvent.postWallCompleted;
var
  sResult : String;
begin
    sResult := getResultString(dmdDatamodule.respGeneric.Content);
    if (sResult = 'OK') then
    begin
      getEventData();
    end;
end;

procedure TfrmEvent.postWallMessage(sMessage: String);
begin
  with dmdDataModule do
  begin
    reqGeneric.Resource := 'r/events/addWallPostAPI';
    reqGeneric.Params.addItem('member_id',memberId);
    reqGeneric.Params.addItem('event_id',id);
    reqGeneric.Params.AddItem('message',sMessage);
    reqGeneric.Params.AddItem('signature',signature('isOwner'));
    reqGeneric.Params.AddItem('key',getAPIKey());
    reqGeneric.ExecuteAsync(postWallCompleted);
  end;
end;

initialization
RegisterFMXClasses([TfrmEvent]);

end.
