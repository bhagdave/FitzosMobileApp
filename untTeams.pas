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
    procedure btnBackClick(Sender: TObject);
  private
    { Private declarations }
    procedure teamsLoaded;
    procedure threadTerminated(Sender : TObject);
  public
    { Public declarations }
  end;

implementation

uses
  untJsonFunctions,untFormRegistry, Rest.Client;

var
  myThread : TRESTExecutionThread;


{$R *.fmx}
procedure TfrmTeams.btnBackClick(Sender: TObject);
begin
  close;
end;

procedure TfrmTeams.btnCreateClick(Sender: TObject);
begin
  inherited;
  showNewForm('TfrmTeamCreate');
end;

procedure TfrmTeams.FormActivate(Sender: TObject);
begin
  inherited;
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
    myThread := reqMemberTeams.ExecuteAsync(teamsLoaded);
    myThread.OnTerminate := threadTerminated;
  end;
end;

procedure TfrmTeams.lvTeamsItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  LValue : TValue;
  sTeam : String;
begin
  inherited;
  LValue := GetSelectedValue(lvTeams);
  sTeam := lValue.ToString;
  showNewFormWithId('TfrmTeam',sTeam);
end;

procedure TfrmTeams.teamsLoaded;
var
  sResult : String;
begin
    sResult := getResultString(dmdDataModule.respMemberTeams.Content);
    if (sResult = 'OK') then
    begin
        lvTeams.Visible := false;
        lvTeams.BeginUpdate;
        dmdDataModule.rdsaMemberTeams.Response := dmdDataModule.respMemberTeams;
        dmdDataModule.rdsaMemberTeams.UpdateDataSet;
        if dmdDataModule.fdmMemberTeams.RecordCount > 0 then
          dmdDataModule.fdmMemberTeams.Open;
        lvTeams.EndUpdate;
        lvTeams.Visible := true;
    end;
end;

procedure TfrmTeams.threadTerminated(Sender: TObject);
begin
  if myThread <> nil then
     myThread := nil;
end;

initialization
RegisterFMXClasses([TfrmTeams]);

end.
