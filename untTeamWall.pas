unit untTeamWall;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListView.Types, FMX.ListView, untDataModule,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components;

type
  TfrmTeamWall = class(TfrmBase)
    btnPost: TButton;
    lvWall: TListView;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure btnPostClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure getWall();
  public
    { Public declarations }
  end;

implementation

uses
  untMainForm, untJsonFunctions;

{$R *.fmx}
procedure TfrmTeamWall.btnPostClick(Sender: TObject);
var
  sPost : String;
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
end;

procedure TfrmTeamWall.FormActivate(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmTeamWall.getWall();
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
      reqTeamWall.Params.ParameterByName('id').Value := id;
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

initialization
RegisterFMXClasses([TfrmTeamWall]);

end.
