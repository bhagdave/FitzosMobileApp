unit untSportsForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListView.Types, FMX.ListView, untDataModule,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, FMX.Layouts, FMX.ListBox,
  FMX.DateTimeCtrls;

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
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}
uses
  untMainForm;

procedure TfrmSports.FormActivate(Sender: TObject);
var
  sResult : String;
begin
  with dmdDataModule do
  begin
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
  end;
end;

initialization
RegisterFMXClasses([TfrmSports]);


end.
