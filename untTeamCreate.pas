unit untTeamCreate;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListBox, FMX.Layouts, untDataModule,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, FMX.Memo;

type
  TfrmTeamCreate = class(TfrmBase)
    pnlLayout: TGridPanelLayout;
    lblName: TLabel;
    edtName: TEdit;
    lblSport: TLabel;
    cboSport: TComboBox;
    cbActive: TCheckBox;
    cbPublic: TCheckBox;
    btnSave: TButton;
    pnlCheckBoxes: TGridPanelLayout;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    ToolBar1: TToolBar;
    lblDescription: TLabel;
    memContents: TMemo;
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
  untMainForm, untJsonFunctions,untFormRegistry;
{$R *.fmx}
procedure TfrmTeamCreate.addParams;
var
  sPublic : String;
  sActive : String;
  sSport  : String;
  lValue : TValue;
begin
  if cbPublic.IsChecked then
    sPublic := 'yes'
  else
    sPublic := 'no';
  if cbActive.IsChecked then
    sActive := 'yes'
  else
    sActive := 'no';
  lValue := GetSelectedValue(cboSport);
  sSport := lValue.ToString;
  dmdDataModule.reqCreateTeam.Params.Clear;
  dmdDataModule.reqCreateTeam.Params.AddItem('name',edtName.Text);
  dmdDataModule.reqCreateTeam.Params.AddItem('content',memContents.Lines.GetText);
  dmdDataModule.reqCreateTeam.Params.AddItem('public', sPublic);
  dmdDataModule.reqCreateTeam.Params.AddItem('active', sActive);
  dmdDataModule.reqCreateTeam.Params.AddItem('owner',dmdDataModule.memberId);
  dmdDataModule.reqCreateTeam.Params.AddItem('sport_id',sSport);
end;

procedure TfrmTeamCreate.btnSaveClick(Sender: TObject);
begin
  inherited;
  addParams;
  dmdDataModule.reqCreateTeam.Execute;
  showmessage('Team created!');
  close;
end;

procedure TfrmTeamCreate.FormActivate(Sender: TObject);
begin
  inherited;
  getSports;
end;

procedure TfrmTeamCreate.getSports;
var
  sResult : String;
begin
  with dmdDataModule do
  begin
    // Open up the data.
    rdsaMemberSports.ClearDataSet;
    fdmMemberSports.Close;
    respMemberSports.Content.Empty;
    reqMemberSports.ClearBody;
    reqMemberSports.Params.ParameterByName('id').Value := dmdDataModule.memberId;
    reqMemberSports.Execute;
    sResult := getResultString(respMemberSports.Content);
    if (sResult = 'OK') then
    begin
        rdsaMemberSports.Response := respMemberSports;
        fdmMemberSports.Open;
    end;
  end;
end;

initialization
RegisterFMXClasses([TfrmTeamCreate]);

end.
