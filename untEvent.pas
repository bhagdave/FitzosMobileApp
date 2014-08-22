unit untEvent;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, untEventDataModule, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.DBScope, FMX.ListView.Types,
  FMX.ListView;

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
    procedure FormActivate(Sender: TObject);
    procedure lvAttendingItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnPostClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
  private
    { Private declarations }
    bOwner : Boolean;
    bAttending : Boolean;
    procedure getAttending;
    procedure getWall;
    procedure getOwner;
    procedure isAttending;
    procedure postWallMessage(sMessage:String);
    procedure eventLoaded;
    procedure attendingLoaded;
    procedure wallLoaded;
    procedure ownerLoaded;
    procedure isAttendingLoaded;
    procedure eventThreadTerminated(Sender : TObject);
    procedure attendingThreadTerminated(Sender : TObject);
    procedure ownerThreadTerminated(Sender : TObject);
    procedure wallThreadTerminated(Sender : TObject);
    procedure postWallCompleted;
  public
    { Public declarations }
  end;

implementation

uses
  untDataModule, untJsonFunctions,untFormRegistry, Rest.client;
var
  eventThread : TRESTExecutionThread;
  attendingThread : TRESTExecutionThread;
  wallThread : TRESTExecutionThread;
  ownerThread : TRESTExecutionThread;
{$R *.fmx}
procedure TfrmEvent.attendingLoaded;
var
  sResult : String;
begin
  with dmdEvent do begin
      sResult := getResultString(respAttending.Content);
      if (sResult = 'OK') then
      begin
          rdsaAttending.Response := respAttending;
          rdsaAttending.UpdateDataSet;
          fdmAttending.Open;
      end;
  end;
end;

procedure TfrmEvent.attendingThreadTerminated(Sender: TObject);
begin
  attendingThread := nil;
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
  sMessage := inputbox('Wall Message','Please enter your post','');
  if (sMessage <> '') then
  begin
    postWallMessage(sMessage);
  end;
end;

procedure TfrmEvent.eventLoaded;
var
  sResult : String;
begin
  with dmdEvent do
  begin
      sResult := getResultString(respEvent.Content);
      if (sResult = 'OK') then
      begin
          rdsaEvent.Response := respEvent;
          rdsaEvent.UpdateDataSet;
          fdmEvent.Open;
      end;
  end;
end;

procedure TfrmEvent.eventThreadTerminated(Sender: TObject);
begin
  eventThread := nil;
end;

procedure TfrmEvent.FormActivate(Sender: TObject);
begin
  with dmdEvent do
  begin
      // Open up the data.
      rdsaEvent.ClearDataSet;
      fdmEvent.Close;
      respEvent.Content.Empty;
      reqEvent.ClearBody;
      reqEvent.Params.ParameterByName('id').Value := id;
      reqEvent.Params.ParameterByName('signature').Value := dmdDataModule.signature('getMember');
      reqEvent.Params.ParameterByName('key').Value := dmdDataModule.getApiKey;
      eventThread := reqEvent.ExecuteAsync(eventLoaded);
      eventThread.OnTerminate := eventThreadTerminated;
  end;
  getAttending();
  getWall();
  getOwner();
  if bOwner then
    btnEdit.Visible := true
  else
    btnEdit.Visible := false;
  isAttending();
end;

procedure TfrmEvent.getAttending;
begin
  with dmdEvent do
  begin
      // Open up the data.
      rdsaAttending.ClearDataSet;
      fdmAttending.Close;
      respAttending.Content.Empty;
      reqAttending.ClearBody;
      reqAttending.Params.ParameterByName('id').Value := id;
      reqAttending.Params.ParameterByName('signature').Value := dmdDataModule.signature('getMember');
      reqAttending.Params.ParameterByName('key').Value := dmdDataModule.getApiKey;
      attendingThread := reqAttending.ExecuteAsync(attendingLoaded);
      attendingThread.OnTerminate := attendingThreadTerminated;
  end;
end;

procedure TfrmEvent.getOwner;
begin
  // ok lets try and get some data
  with dmdDataModule do
  begin
    reqGeneric.Resource := 'r/events/isOwner';
    reqGeneric.Params.addItem('id',memberId);
    reqGeneric.Params.addItem('event',id);
    reqGeneric.Params.AddItem('signature',signature('isOwner'));
    reqGeneric.Params.AddItem('key',getAPIKey());
    ownerThread = reqGeneric.ExecuteAsync(ownerLoaded);
    ownerThread.OnTerminate := ownerThreadTerminated;
  end;
end;

procedure TfrmEvent.getWall;
begin
  with dmdEvent do
  begin
      // Open up the data.
      rdsaWall.ClearDataSet;
      fdmWall.Close;
      respWall.Content.Empty;
      reqWall.ClearBody;
      reqWall.Params.ParameterByName('id').Value := id;
      reqWall.Params.ParameterByName('signature').Value := dmdDataModule.signature('getMember');
      reqWall.Params.ParameterByName('key').Value := dmdDataModule.getApiKey;
      wallThread := reqWall.ExecuteAsync(wallLoaded);
      wallThread.OnTerminate := wallThreadTerminated;
  end;
end;

procedure TfrmEvent.isAttending;
begin
  // ok lets try and get some data
  with dmdDataModule do
  begin
    reqGeneric.Resource := 'r/events/isAttendee';
    reqGeneric.Params.addItem('id',memberId);
    reqGeneric.Params.addItem('event',id);
    reqGeneric.Params.AddItem('signature',signature('isOwner'));
    reqGeneric.Params.AddItem('key',getAPIKey());
    reqGeneric.ExecuteAsync(isAttendingLoaded);
  end;
end;

procedure TfrmEvent.isAttendingLoaded;
var
  sResult : String;
begin
  with dmdEvent do begin
    sResult := getResultString(respGeneric.Content);
    if (sResult = 'OK') then
    begin
       bAttending := getResultBoolean(respGeneric.Content,'Result');
    end;
  end;
  if bAttending then
    btnPost.Visible := true
  else
    btnPost.Visible := false;
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

procedure TfrmEvent.ownerLoaded;
var
  sResult : String;
begin
  with dmdEvent do begin
    sResult := getResultString(respGeneric.Content);
      if (sResult = 'OK') then
      begin
        bOwner := getResultBoolean(respGeneric.Content,'Result');
      end;
  end;
end;

procedure TfrmEvent.ownerThreadTerminated(Sender: TObject);
begin
  ownerThread := nil;
end;

procedure TfrmEvent.postWallCompleted;
var
  sResult : String;
begin
    sResult := getResultString(dmdDatamodule.respGeneric.Content);
    if (sResult = 'OK') then
    begin
      getWall();
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

procedure TfrmEvent.wallLoaded;
var
  sResult : String;
begin
  with dmdEvent do begin
      sResult := getResultString(respWall.Content);
      if (sResult = 'OK') then
      begin
          rdsaWall.Response := respWall;
          rdsaWall.UpdateDataSet;
          fdmWall.Open;
      end;
  end;
end;

procedure TfrmEvent.wallThreadTerminated(Sender: TObject);
begin
  wallThread := nil;
end;

initialization
RegisterFMXClasses([TfrmEvent]);

end.
