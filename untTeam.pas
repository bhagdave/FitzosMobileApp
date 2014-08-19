unit untTeam;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListView.Types, FMX.ListView, untDataModule,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.DBScope, FMX.Layouts;

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
    procedure FormActivate(Sender: TObject);
    procedure lvEventsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvMembersItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvWwallClick(Sender: TObject);
    procedure btnNewEventClick(Sender: TObject);
  private
    isOwner : Boolean;
    { Private declarations }
    procedure getTeamWall(sTeam : String);
    procedure getTeamMembers(sTeam : String);
    procedure getTeamEvents(sTeam : String);
    procedure getTeam(sTeam: String);
    procedure getTeamOwnership(sTeam : String);
  public
    { Public declarations }
  end;


implementation

uses
  untMainForm, untJsonFunctions,untFormRegistry;

{$R *.fmx}
procedure TfrmTeam.btnNewEventClick(Sender: TObject);
begin
  inherited;
  showNewForm('TfrmEventCreation');
end;

procedure TfrmTeam.FormActivate(Sender: TObject);
var
  sTeam : String;
begin
  inherited;
//  sTeam := dmdDataModule.fdmMemberTeamsid.AsString;
  sTeam := Id;
  getTeam(sTeam);
  getTeamWall(sTeam);
  getTeamMembers(sTeam);
  getTeamEvents(sTeam);
  getTeamOwnership(sTeam);
end;

procedure TfrmTeam.getTeam(sTeam: String);
var
  sResult : String;
begin
  with dmdDataModule do
  begin
      // Open up the data.
      rdsaTeam.ClearDataSet;
      fdmTeam.Close;
      respTeam.Content.Empty;
      reqTeam.ClearBody;
      reqTeam.Params.ParameterByName('id').Value := sTeam;
      reqTeam.Params.ParameterByName('signature').Value := signature('getTeamEvents');
      reqTeam.Params.ParameterByName('key').Value := getApiKey;
      reqTeam.Execute;
      sResult := getResultString(respTeam.Content);
      if (sResult = 'OK') then
      begin
          rdsaTeam.Response := respTeam;
          rdsaTeam.UpdateDataSet;
          fdmTeam.Open;
      end;
  end;
end;

procedure TfrmTeam.getTeamEvents(sTeam: String);
var
  sResult : String;
begin
  with dmdDataModule do
  begin
      // Open up the data.
      rdsaTeamEvents.ClearDataSet;
      fdmTeamEvents.Close;
      fdmTeamEvents.Active := false;
      fdmTeamEvents.FetchOnDemand := false;
      respTeamEvents.Content.Empty;
      reqTeamEvents.ClearBody;
      reqTeamEvents.Params.ParameterByName('id').Value := sTeam;
      reqTeamEvents.Params.ParameterByName('signature').Value := signature('getTeamEvents');
      reqTeamEvents.Params.ParameterByName('key').Value := getApiKey;
      reqTeamEvents.Execute;
      sResult := getResultString(respTeamEvents.Content);
      if (sResult = 'OK') then
      begin
          rdsaTeamEvents.Response := respTeamEvents;
          rdsaTeamEvents.UpdateDataSet;
          fdmTeamEvents.Open;
      end;
  end;
end;

procedure TfrmTeam.getTeamMembers(sTeam: String);
var
  sResult : String;
begin
  with dmdDataModule do
  begin
      // Open up the data.
      rdsaTeamMembers.ClearDataSet;
      fdmTeamMembers.Close;
      respTeamMembers.Content.Empty;
      reqTeamMembers.ClearBody;
      rdsaTeamMembers.Active := false;
      reqTeamMembers.Params.ParameterByName('id').Value := sTeam;
      reqTeamMembers.Params.ParameterByName('signature').Value := signature('getTeamMembers');
      reqTeamMembers.Params.ParameterByName('key').Value := getApiKey;
      reqTeamMembers.Execute;
      sResult := getResultString(respTeamMembers.Content);
      if (sResult = 'OK') then
      begin
          rdsaTeamMembers.Response := respTeamMembers;
          rdsaTeamMembers.UpdateDataSet;
          fdmTeamMembers.Open;
      end;
  end;
end;

procedure TfrmTeam.getTeamOwnership(sTeam : String);
var
  sResult : String;
begin
  with dmdDataModule do
  begin
      reqGeneric.Params.Clear;
      reqGeneric.Resource := 'r/teams/isOwner';
      reqGeneric.Params.addItem('user',memberId);
      reqGeneric.Params.addItem('team',id);
      reqGeneric.Params.AddItem('signature',signature('isOwner'));
      reqGeneric.Params.AddItem('key',getAPIKey());
      reqGeneric.Execute;
      sResult := getResultString(respGeneric.Content);
      if (sResult = 'OK') then
      begin
        isOwner := getResultBoolean(respGeneric.Content,'Result');
        btnNewEvent.Visible := isOwner;
        btnInvite.Visible := isOwner;
      end;
  end;
end;

procedure TfrmTeam.getTeamWall(sTeam: String);
var
  sResult : String;
begin
  with dmdDataModule do
  begin
      // Open up the data.
      rdsaTeamWall.ClearDataSet;
      fdmTeamWall.Close;
      respTeamWall.Content.Empty;
      reqTeamWall.ClearBody;
      reqTeamWall.Params.ParameterByName('id').Value := sTeam;
      reqTeamWall.Params.ParameterByName('signature').Value := signature('getTeamWall');
      reqTeamWall.Params.ParameterByName('key').Value := getApiKey;
      reqTeamWall.Execute;
      sResult := getResultString(respTeamWall.Content);
      if (sResult = 'OK') then
      begin
          rdsaTeamWall.Response := respTeamWall;
          rdsaTeamWall.UpdateDataSet;
          fdmTeamWall.Open;
      end;
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

initialization
RegisterFMXClasses([TfrmTeam]);

end.
