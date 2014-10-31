unit untStatsForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListView.Types, FMX.ListView, untDMDSports,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, FMX.Layouts, FMX.ListBox, FMX.Memo,
  FMX.DateTimeCtrls, FMX.Notification, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient;

type
  TfrmStats = class(TfrmBase)
    lvStats: TListView;
    tbExisting: TToolBar;
    lblExisting: TLabel;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    btnAdd: TButton;
    pnlAddStat: TPanel;
    cboStats: TComboBox;
    pnlName: TGridPanelLayout;
    lblName: TLabel;
    edtName: TEdit;
    pnlDetails: TGridPanelLayout;
    lblValue: TLabel;
    edtValue: TEdit;
    lblComment: TLabel;
    memContent: TMemo;
    lblDate: TLabel;
    edtDate: TDateEdit;
    btnAddStat: TButton;
    LinkFillControlToField2: TLinkFillControlToField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    btnNewstat: TButton;
    procedure btnAddClick(Sender: TObject);
    procedure btnAddStatClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnNewstatClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  untDataModule, untJsonFunctions,untFormRegistry;

{$R *.fmx}
procedure TfrmStats.btnAddClick(Sender: TObject);
begin
  inherited;
  pnlAddStat.Visible := true;
end;

procedure TfrmStats.btnAddStatClick(Sender: TObject);
var
  sResult : String;
begin
  inherited;
  pnlAddStat.Visible := false;
  dmdSports.reqAddStat.Params.ParameterByName('source_id').Value := dmdDataModule.memberId;
  dmdSports.reqAddStat.Params.ParameterByName('sport_id').Value := id;
  if cboStats.Visible then
  begin
    dmdSports.reqAddStat.Params.ParameterByName('statistic_name').Value := cboStats.Selected.Text;
  end;
  dmdSports.reqAddStat.Execute;
  sResult := getResultString(dmdSports.respAddStat.Content);
  if sResult.Trim = 'OK' then
  begin
    self.FormActivate(nil);
  end
  else
  begin
    showmessage(dmdSports.respAddStat.Content);
  end;
end;

procedure TfrmStats.btnBackClick(Sender: TObject);
begin
  inherited;
  pnlAddStat.visible := false;
  close;
end;

procedure TfrmStats.btnNewstatClick(Sender: TObject);
begin
  inherited;
  pnlAddStat.Visible := true;
end;

procedure TfrmStats.FormActivate(Sender: TObject);
var
  sResult : String;
begin
  inherited;
  edtDate.Align := TAlignLayout.client;
  with dmdSports do
  begin
    rdsaStatsForSports.Active := false;
    respStatsForSport.Content.Empty;
    reqStatsForSport.ClearBody;
    reqStatsForSport.Params.ParameterByName('id').Value := Id;
//    reqStatsForSport.Params.ParameterByName('signature').Value := dmdDatamodule.signature('getSports');
//    reqStatsForSport.Params.ParameterByName('key').Value := dmdDataModule.getApiKey;
    reqStatsForSport.Execute;
    sResult := getResultString(respStatsForSport.Content);
    if (sResult = 'OK') then
    begin
        rdsaStatsForSports.Response := respStatsForSport;
        rdsaStatsForSports.UpdateDataSet;
        fdmStatsForSport.Open;
        pnlName.Visible := false;
        cboStats.Visible := true;
    end
    else
    begin
        pnlName.Visible := true;
        cboStats.Visible := false;
    end;

    rdsaSportsStats.Active := false;
    respSportsStats.Content.Empty;
    reqSportsStats.ClearBody;
    reqSportsStats.Params.ParameterByName('id').Value := dmdDataModule.memberId;
    reqSportsStats.Params.ParameterByName('sport').Value := Id;
//    reqSportsStats.Params.ParameterByName('signature').Value := dmdDatamodule.signature('getSports');
//    reqSportsStats.Params.ParameterByName('key').Value := dmdDataModule.getApiKey;
    reqSportsStats.Execute;
    sResult := getResultString(respSportsStats.Content);
    if (sResult = 'OK') then
    begin
        rdsaSportsStats.Response := respSportsStats;
        rdsaSportsStats.UpdateDataSet;
        fdmSportsStats.Open;
    end;
  end;
end;

initialization
RegisterFMXClasses([TfrmStats]);


end.
