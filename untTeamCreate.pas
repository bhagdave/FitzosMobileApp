unit untTeamCreate;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListBox, FMX.Layouts;

type
  TfrmTeamCreate = class(TfrmBase)
    GridPanelLayout1: TGridPanelLayout;
    lblName: TLabel;
    edtName: TEdit;
    lblSport: TLabel;
    cboSport: TComboBox;
    cbActive: TCheckBox;
    cbPublic: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.fmx}
initialization
RegisterFMXClasses([TfrmTeamCreate]);

end.
