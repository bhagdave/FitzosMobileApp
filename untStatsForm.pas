unit untStatsForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListView.Types, FMX.ListView, untDMDSports,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, FMX.Layouts, FMX.ListBox, FMX.Memo,
  FMX.DateTimeCtrls;

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
    procedure btnAddClick(Sender: TObject);
    procedure btnAddStatClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  untMainForm, untDataModule;

{$R *.fmx}
procedure TfrmStats.btnAddClick(Sender: TObject);
begin
  inherited;
  pnlAddStat.Visible := true;
end;

procedure TfrmStats.btnAddStatClick(Sender: TObject);
begin
  inherited;
  pnlAddStat.Visible := false;
end;

initialization
RegisterFMXClasses([TfrmStats]);


end.
