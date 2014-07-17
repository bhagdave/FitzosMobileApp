unit untTeamCreate;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListBox, FMX.Layouts, untDataModule,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components;

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
    procedure btnSaveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure getSports();
  public
    { Public declarations }
  end;


implementation

uses
  untMainForm;
{$R *.fmx}
procedure TfrmTeamCreate.btnSaveClick(Sender: TObject);
begin
  inherited;
//
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
