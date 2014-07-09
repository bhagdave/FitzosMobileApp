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
    procedure btnPostWallClick(Sender: TObject);
  private
    { Private declarations }
    bOwner : Boolean;
    bAttending : Boolean;
    procedure getAttending;
    procedure getWall;
    procedure getOwner;
    procedure isAttending;
  public
    { Public declarations }
  end;

var
  frmEvent: TfrmEvent;

implementation

uses
  untMainForm, untDataModule;

{$R *.fmx}
procedure TfrmEvent.btnPostClick(Sender: TObject);
var
  sMessage : String;
begin
  inherited;
  sMessage := inputbox('Wall Message','Please enter your post','');
  if (sMessage <> '') then
  begin
    //
  end;
end;

procedure TfrmEvent.btnPostWallClick(Sender: TObject);
begin
  inherited;
//  if True then
//
end;

procedure TfrmEvent.FormActivate(Sender: TObject);
var
  sResult : String;
  sURL    : String;
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
      reqEvent.Execute;
      sResult := getResultString(respEvent.Content);
      if (sResult = 'OK') then
      begin
          rdsaEvent.Response := respEvent;
          fdmEvent.Open;
//          sURL := 'http://beta.fitzos.com/' + fdmMember.FieldByName('image').AsString;
//          loadPicture(sURL);
      end;
  end;
  getAttending();
  getWall();
  getOwner();
  if bOwner then
    btnEdit.Visible := true
  else
    btnEdit.Visible := false;
  isAttending();
  if bAttending then
    btnPost.Visible := true
  else
    btnPost.Visible := false;
end;

procedure TfrmEvent.getAttending;
var
  sResult : String;
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
      try
        reqAttending.Execute;
      except on E: Exception do
      end;
      sResult := getResultString(respAttending.Content);
      if (sResult = 'OK') then
      begin
          rdsaAttending.Response := respAttending;
          fdmAttending.Open;
      end;
  end;
end;

procedure TfrmEvent.getOwner;
var
  sResult : String;
begin
  // ok lets try and get some data
  with dmdDataModule do
  begin
    reqGeneric.Resource := 'r/events/isOwner';
    reqGeneric.Params.addItem('id',memberId);
    reqGeneric.Params.addItem('event',id);
    reqGeneric.Params.AddItem('signature',signature('isOwner'));
    reqGeneric.Params.AddItem('key',getAPIKey());
    reqGeneric.Execute;
    sResult := getResultString(respGeneric.Content);
      if (sResult = 'OK') then
      begin
        bOwner := getResultBoolean(respGeneric.Content,'Result');
      end;
  end;
end;

procedure TfrmEvent.getWall;
var
  sResult : String;
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
      try
        reqWall.Execute;
      except on E: Exception do
      end;
      sResult := getResultString(respWall.Content);
      if (sResult = 'OK') then
      begin
          rdsaWall.Response := respWall;
          fdmWall.Open;
      end;
  end;
end;

procedure TfrmEvent.isAttending;
var
  sResult : String;
begin
  // ok lets try and get some data
  with dmdDataModule do
  begin
    reqGeneric.Resource := 'r/events/isAttendee';
    reqGeneric.Params.addItem('id',memberId);
    reqGeneric.Params.addItem('event',id);
    reqGeneric.Params.AddItem('signature',signature('isOwner'));
    reqGeneric.Params.AddItem('key',getAPIKey());
    reqGeneric.Execute;
    sResult := getResultString(respGeneric.Content);
      if (sResult = 'OK') then
      begin
        bAttending := getResultBoolean(respGeneric.Content,'Result');
      end;
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

initialization
RegisterFMXClasses([TfrmEvent]);

end.
