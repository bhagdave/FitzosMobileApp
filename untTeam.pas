unit untTeam;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListView.Types, FMX.ListView, untDataModule,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.DBScope;

type
  TfrmTeam = class(TfrmBase)
    pnlTeam: TPanel;
    lblName: TLabel;
    lblContent: TLabel;
    lvMembers: TListView;
    lvEvents: TListView;
    lvWall: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    LinkListControlToField1: TLinkListControlToField;
    LinkListControlToField2: TLinkListControlToField;
    LinkListControlToField3: TLinkListControlToField;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure getTeamWall(sTeam : String);
    procedure getTeamMembers(sTeam : String);
    procedure getTeamEvents(sTeam : String);
  public
    { Public declarations }
  end;

var
  frmTeam: TfrmTeam;

implementation

uses
  untMainForm;

{$R *.fmx}
procedure TfrmTeam.FormShow(Sender: TObject);
var
  sTeam : String;
begin
  inherited;
  sTeam := dmdDataModule.fdmMemberTeamsid.AsString;
  getTeamWall(sTeam);
  getTeamMembers(sTeam);
  getTeamEvents(sTeam);
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
      reqTeamMembers.Params.ParameterByName('id').Value := sTeam;
      reqTeamMembers.Params.ParameterByName('signature').Value := signature('getTeamMembers');
      reqTeamMembers.Params.ParameterByName('key').Value := getApiKey;
      reqTeamMembers.Execute;
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
      reqTeamWall.Execute;
      sResult := getResultString(respTeamWall.Content);
      if (sResult = 'OK') then
      begin
          rdsaTeamWall.Response := respTeamWall;
          fdmTeamWall.Open;
      end;
  end;
end;

initialization
RegisterFMXClasses([TfrmTeam]);

end.
