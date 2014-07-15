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
    procedure FormActivate(Sender: TObject);
    procedure lvEventsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvMembersItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvWwallClick(Sender: TObject);
  private
    { Private declarations }
    procedure getTeamWall(sTeam : String);
    procedure getTeamMembers(sTeam : String);
    procedure getTeamEvents(sTeam : String);
    procedure getTeam(sTeam: String);
  public
    { Public declarations }
  end;


implementation

uses
  untMainForm;

{$R *.fmx}
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
      try
        reqTeamEvents.Execute;
      except on E: Exception do
        // we are empty.. ignore - Very Naughty I know.
      end;
      sResult := getResultString(respTeamEvents.Content);
      if (sResult = 'OK') then
      begin
          rdsaTeamEvents.Response := respTeamEvents;
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
      try
        reqTeamMembers.Execute;
      except on E: Exception do
      end;
      sResult := getResultString(respTeamMembers.Content);
      if (sResult = 'OK') then
      begin
          rdsaTeamMembers.Response := respTeamMembers;
          fdmTeamMembers.Open;
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
      try
        reqTeamWall.Execute;
      except on E: Exception do
      end;
      sResult := getResultString(respTeamWall.Content);
      if (sResult = 'OK') then
      begin
          rdsaTeamWall.Response := respTeamWall;
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
