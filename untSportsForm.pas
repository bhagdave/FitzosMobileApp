unit untSportsForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListView.Types, FMX.ListView, untDataModule,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, FMX.Layouts, FMX.ListBox,
  FMX.DateTimeCtrls, FMX.AndroidLike.Toast, FGX.ProgressDialog,
  FMX.Notification, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient;

type
  TfrmSports = class(TfrmBase)
    lvExistingSports: TListView;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    tbHeading: TToolBar;
    lblSports: TLabel;
    tbAddSport: TToolBar;
    lblAddSport: TLabel;
    pnlAdd: TGridPanelLayout;
    lblSport: TLabel;
    cboSport: TComboBox;
    lblDate: TLabel;
    edtDate: TDateEdit;
    btnAdd: TButton;
    LinkFillControlToField2: TLinkFillControlToField;
    btnAddSport: TButton;
    pnlAddSportForm: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure lvExistingSportsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnAddSportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}
uses
  untJsonFunctions,untFormRegistry;

procedure TfrmSports.btnAddClick(Sender: TObject);
var
  lValue : TValue;
begin
  inherited;
  lValue := getSelectedValue(cboSport);
  with dmdDataModule do
  begin
      rdsaGeneric.ClearDataSet;
      respGeneric.Content.Empty;
      reqGeneric.Params.Clear;
      reqGeneric.ClearBody;
      reqGeneric.Resource := 'r/members/addSport';
      reqGeneric.Params.addItem('member_id',memberId);
      reqGeneric.Params.addItem('sport_id',lValue.ToString);
      reqGeneric.Params.AddItem('from_date',DateToStr(edtDate.Date));
      reqGeneric.Params.addItem('signature',signature('addSport'));
      reqGeneric.Params.addItem('key',getApiKey);
      reqGeneric.Execute;
      self.FormActivate(nil);
  end;
end;

procedure TfrmSports.btnAddSportClick(Sender: TObject);
begin
  inherited;
  pnlAddSportForm.Visible := true;
  edtDate.Align := TAlignLayout.client;
end;

procedure TfrmSports.FormActivate(Sender: TObject);
var
  sResult : String;
begin
  with dmdDataModule do
  begin
    // get all sports
    reqSports.Execute;
    // Open up the data.
    rdsaMemberSports.Active := false;
    respMemberSports.Content.Empty;
    reqMemberSports.ClearBody;
    reqMemberSports.Params.ParameterByName('id').Value := memberId;
    reqMemberSports.Params.ParameterByName('signature').Value := signature('getSports');
    reqMemberSports.Params.ParameterByName('key').Value := getApiKey;
    reqMemberSports.Execute;
    sResult := getResultString(respMemberSports.Content);
    if (sResult = 'OK') then
    begin
        rdsaMemberSports.Response := respMemberSports;
        rdsaMemberSports.UpdateDataSet;
        fdmMemberSports.Open;
    end;
    pnlAddSportForm.Visible := false;
  end;
end;

procedure TfrmSports.lvExistingSportsItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  lValue : TValue;
begin
  inherited;
  lValue := getSelectedValue(lvExistingSports);
  showNewFormWithId('TfrmStats',LValue.ToString);
end;

initialization
RegisterFMXClasses([TfrmSports]);


end.
