unit untTeam;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListView.Types, FMX.ListView, untDataModule,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.DBScope, FMX.Layouts,
  FMX.ListBox, Rest.client, Rest.Types;

type
  TfrmTeam = class(TfrmBase)
    lvEvents: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    vsbScroller: TVertScrollBox;
    lblEvents: TLabel;
    layTeam: TLayout;
    LinkFillControlToField: TLinkFillControlToField;
    expMembers: TExpander;
    lvMembers: TListView;
    expWall: TExpander;
    lvWwall: TListView;
    LinkFillControlToField1: TLinkFillControlToField;
    LinkFillControlToField2: TLinkFillControlToField;
    LinkPropertyToFieldText: TLinkPropertyToField;
    btnNewEvent: TButton;
    btnInvite: TButton;
    layInvites: TLayout;
    pnlInvites: TPanel;
    grdInvites: TGridPanelLayout;
    lblFriends: TLabel;
    lbFriends: TListBox;
    btnSend: TButton;
    btnCancel: TButton;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField3: TLinkFillControlToField;
    procedure FormActivate(Sender: TObject);
    procedure lvEventsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvMembersItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvWwallClick(Sender: TObject);
    procedure btnNewEventClick(Sender: TObject);
    procedure btnInviteClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
  private
    { Private declarations }
    procedure teamLoaded();
    procedure getTeam(sTeam: String);
  public
    { Public declarations }
  end;


implementation

uses
  untJsonFunctions,untFormRegistry,System.json;

{$R *.fmx}
procedure TfrmTeam.btnCancelClick(Sender: TObject);
begin
  inherited;
  layInvites.Visible := false;
  barBottom.Visible := true;
end;

procedure TfrmTeam.btnInviteClick(Sender: TObject);
begin
  inherited;
  layInvites.Visible := true;
  barBottom.Visible := false;
end;

procedure TfrmTeam.btnNewEventClick(Sender: TObject);
begin
  inherited;
  showNewForm('TfrmEventCreation');
end;

procedure TfrmTeam.btnSendClick(Sender: TObject);
var
  i : Integer;
  sParams : String;
  aParam: TRESTRequestParameter;
begin
  sParams := '[';
  for i := 0 to lbFriends.Items.Count - 1 do
  begin
    if lbFriends.Listitems[i].IsChecked then
    begin
      sParams := '"' + dmdDataModule.fdmFriendsToInvite.FieldByname('id').AsString + '"';
    end;
    dmdDataModule.fdmFriendsToInvite.next;
  end;
  if sParams <> '[' then
  begin
    aParam := dmdDataModule.reqAllTeamData.Params.AddItem();
    aParam.Value := TJSONObject.ParseJSONValue(sParams);
    aParam.ContentType := ctAPPLICATION_JSON;
  end;
end;

procedure TfrmTeam.FormActivate(Sender: TObject);
var
  sTeam : String;
begin
  inherited;
//  sTeam := dmdDataModule.fdmMemberTeamsid.AsString;
  sTeam := Id;
  getTeam(sTeam);
end;

procedure TfrmTeam.getTeam(sTeam: String);
begin
  with dmdDataModule do
  begin
      // Open up the data.
      rdsaTeam.ClearDataSet;
      fdmTeam.Close;
      respAllTeamData.Content.Empty;
      reqAllTeamData.ClearBody;
      reqAllTeamData.Params.ParameterByName('team').Value := sTeam;
      reqAllTeamData.Params.ParameterByName('member_id').Value := memberId;
//      reqAllTeamData.Params.ParameterByName('signature').Value := signature('getTeamWall');
//      reqAllTeamData.Params.ParameterByName('key').Value := getApiKey;
      reqAllTeamData.ExecuteAsync(teamLoaded);
  end;
end;

procedure TfrmTeam.lvEventsItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  LValue : TValue;
begin
  inherited;
  LValue := GetSelectedValue(lvEvents);
  showNewFormWithId('TfrmEvent',LValue.ToString);
end;

procedure TfrmTeam.lvMembersItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  LValue : TValue;
begin
  inherited;
  LValue := GetSelectedValue(lvMembers);
  showNewFormWithId('TfrmFriend',LValue.ToString);
end;

procedure TfrmTeam.lvWwallClick(Sender: TObject);
begin
  inherited;
  showNewFormWithId('TfrmTeamWall',id);
end;

procedure TfrmTeam.teamLoaded;
var
  sResult : String;
begin
  with dmdDataMOdule do
  begin
      sResult := getResultString(respAllTeamData.Content);
      if (sResult = 'OK') then
      begin
          rdsaTeam.UpdateDataSet;
          fdmTeam.Open;
          sResult := getResultElementAsString(respAllTeamData.Content,'members');
          if (sResult <> '[]') then
          begin
            rdsaTeamMembers.UpdateDataSet;
            fdmTeamMembers.Open;
          end else
          begin
            fdmTeamMembers.close;
          end;
          sResult := getResultElementAsString(respAllTeamData.Content,'wall');
          if (sResult <> '[]') then
          begin
            rdsaTeamWall.UpdateDataSet;
            fdmTeamWall.Open;
          end else
          begin
              fdmTeamWall.close;
          end;
          sResult := getResultElementAsString(respAllTeamData.Content,'events');
          if (sResult <> '[]') then
          begin
            rdsaTeamEvents.UpdateDataSet;
            fdmTeamWall.Open;
          end else
          begin
              fdmTeamEvents.close;
          end;
          sResult := getResultElementAsString(respAllTeamData.Content,'invites');
          if (sResult <> '[]') then
          begin
            rdsaFriendsToInvite.UpdateDataSet;
            fdmFriendsToInvite.Open;
          end else
          begin
              fdmFriendsToInvite.close;
          end;
          btnInvite.Visible := fdmTeam.FieldByName('isOwner').AsBoolean;
//          btnNewEvent.Visible := bOwner;
      end;
  end;
end;

initialization
RegisterFMXClasses([TfrmTeam]);

end.
