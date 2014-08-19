unit untStatsForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListView.Types, FMX.ListView, untDMDSports,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components;

type
  TfrmStats = class(TfrmBase)
    lvStats: TListView;
    tbExisting: TToolBar;
    lblExisting: TLabel;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    btnAdd: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  untMainForm, untDataModule;

{$R *.fmx}
initialization
RegisterFMXClasses([TfrmStats]);


end.
