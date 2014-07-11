unit untTeams;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListView.Types, FMX.ListView, untDataModule,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  Data.Bind.Controls, FMX.Layouts, Fmx.Bind.Navigator;

type
  TfrmTeams = class(TfrmBase)
    btnCreate: TButton;
    lvTeams: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField: TLinkFillControlToField;
    procedure btnCreateClick(Sender: TObject);
    procedure lvTeamsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  untMainForm;

{$R *.fmx}
procedure TfrmTeams.btnCreateClick(Sender: TObject);
begin
  inherited;
  showNewForm('TfrmTeamCreate');
end;

procedure TfrmTeams.FormActivate(Sender: TObject);
var
  sResult : String;
begin
  inherited;
  lvTeams.items.BeginUpdate;
  with dmdDataModule do
  begin
    // Open up the data.
    rdsaMemberTeams.ClearDataSet;
    fdmMemberTeams.Close;
    respMemberTeams.Content.Empty;
    reqMemberTeams.ClearBody;
    reqMemberTeams.Params.ParameterByName('id').Value := memberId;
    reqMemberTeams.Params.ParameterByName('signature').Value := signature('getMembersTeams');
    reqMemberTeams.Params.ParameterByName('key').Value := getApiKey;
    reqMemberTeams.Execute;
    sResult := getResultString(respMemberTeams.Content);
    if (sResult = 'OK') then
    begin
        rdsaMemberTeams.Response := respMemberTeams;
        fdmMemberTeams.Open;
    end
    else
    begin
        showmessage(respMemberTeams.Content);
    end;
  end;
    lvTeams.items.EndUpdate;
end;

procedure TfrmTeams.lvTeamsItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  LValue : TValue;
begin
  inherited;
  LValue := GetSelectedValue(lvTeams);
  showNewFormWithId('TfrmTeam',lValue.ToString);
end;

initialization
RegisterFMXClasses([TfrmTeams]);

end.
