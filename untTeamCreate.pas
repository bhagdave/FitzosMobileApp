unit untTeamCreate;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListBox, FMX.Layouts, untDataModule,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, FMX.Memo, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, FMX.Controls.Presentation,
  FMX.Notification, FGX.ProgressDialog, FMX.AndroidLike.Toast;

type
  TfrmTeamCreate = class(TfrmBase)
    pnlLayout: TGridPanelLayout;
    lblName: TLabel;
    edtName: TEdit;
    lblSport: TLabel;
    cboSport: TComboBox;
    btnSave: TButton;
    BindingsList1: TBindingsList;
    ToolBar1: TToolBar;
    lblDescription: TLabel;
    memContents: TMemo;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure btnSaveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure getSports();
    procedure addParams();
  public
    { Public declarations }
  end;


implementation

uses
  untJsonFunctions,untFormRegistry;
{$R *.fmx}
procedure TfrmTeamCreate.addParams;
var
  sPublic : String;
  sActive : String;
  sSport  : String;
  lValue : TValue;
begin
  lValue := GetSelectedValue(cboSport);
  sSport := lValue.ToString;
  dmdDataModule.reqCreateTeam.Params.Clear;
  dmdDataModule.reqCreateTeam.Params.AddItem('name',edtName.Text);
  dmdDataModule.reqCreateTeam.Params.AddItem('content',memContents.Lines.GetText);
  dmdDataModule.reqCreateTeam.Params.AddItem('public', 'yes');
  dmdDataModule.reqCreateTeam.Params.AddItem('active', 'yes');
  dmdDataModule.reqCreateTeam.Params.AddItem('owner',dmdDataModule.memberId);
  dmdDataModule.reqCreateTeam.Params.AddItem('sport_id',sSport);
  dmdDataModule.reqCreateTeam.Params.AddItem('key',dmdDatamodule.sessionKey);
end;

procedure TfrmTeamCreate.btnSaveClick(Sender: TObject);
begin
  inherited;
  if connected then
  begin
    addParams;
    dmdDataModule.reqCreateTeam.Execute;
    showmessage('Team created!');
    close;
  end
  else
  begin
    showmessage('No internet connection at the moment');
  end;
end;

procedure TfrmTeamCreate.FormActivate(Sender: TObject);
begin
  inherited;
  if connected then
  begin
    getSports;
  end
  else
  begin
    showmessage('No internet connection at the moment');
  end;
end;

procedure TfrmTeamCreate.getSports;
var
  sResult : String;
begin
  with dmdDataModule do
  begin
    // Open up the data.
    rdsaSports.ClearDataSet;
    fdmSports.Close;
    respSports.Content.Empty;
    reqSports.ClearBody;
    reqSports.Params.ParameterByName('key').Value := dmdDataModule.sessionkey;
    reqSports.Execute;
    sResult := getResultString(respSports.Content);
    if (sResult = 'OK') then
    begin
        rdsaSports.Response := respSports;
        rdsaSports.UpdateDataSet;
        fdmSports.Open;
    end;
  end;
end;

initialization
RegisterFMXClasses([TfrmTeamCreate]);

end.
