unit untTeamWall;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListView.Types, FMX.ListView, untDataModule,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient;

type
  TfrmTeamWall = class(TfrmBase)
    btnPost: TButton;
    lvWall: TListView;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure btnPostClick(Sender: TObject);
  private
    { Private declarations }
    procedure getWall();
    procedure teamLoaded();
  public
    { Public declarations }
  end;

implementation

uses
  untJsonFunctions,untFormRegistry;

{$R *.fmx}
procedure TfrmTeamWall.btnPostClick(Sender: TObject);
var
  sPost : String;
begin
  if connected then
  begin
    if InputQuery('Post','Please enter your message',sPost) and (sPost.Trim <> '') then
    begin
      with dmdDataModule do
      begin
        rdsaGeneric.ClearDataSet;
        respGeneric.Content.Empty;
        reqGeneric.Params.Clear;
        reqGeneric.ClearBody;
        reqGeneric.Resource := 'r/teams/addWallPost';
        reqGeneric.Params.addItem('team_id',ID);
        reqGeneric.Params.addItem('message',sPost);
        reqGeneric.Params.addItem('signature',signature('addWallPost'));
        reqGeneric.Params.addItem('member_id',memberId);
        reqGeneric.Params.addItem('key',getApiKey);
        reqGeneric.Execute;
        getWall();
      end;
    end;
  end
  else
  begin
    showmessage('No internet connection at the moment');
  end;
end;

procedure TfrmTeamWall.getWall();
var
  sResult : String;
begin
  with dmdDataModule do
  begin
      // Open up the data.
      rdsaTeam.ClearDataSet;
      fdmTeam.Close;
      respAllTeamData.Content.Empty;
      reqAllTeamData.ClearBody;
      reqAllTeamData.Params.ParameterByName('team').Value := ID;
      reqAllTeamData.Params.ParameterByName('member_id').Value := memberId;
//      reqAllTeamData.Params.ParameterByName('signature').Value := signature('getTeamWall');
//      reqAllTeamData.Params.ParameterByName('key').Value := getApiKey;
      reqAllTeamData.ExecuteAsync(teamLoaded);
  end;
end;

procedure TfrmTeamWall.teamLoaded;
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
      end;
  end;
end;

initialization
RegisterFMXClasses([TfrmTeamWall]);

end.
