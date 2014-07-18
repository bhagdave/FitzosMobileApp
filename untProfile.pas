unit untProfile;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Layouts, FMX.ListBox;

type
  TfrmProfile = class(TForm)
    StyleBook1: TStyleBook;
    barTop: TToolBar;
    lblTitle: TLabel;
    barBottom: TToolBar;
    btnSave: TButton;
    btnBack: TButton;
    grdLayout: TGridPanelLayout;
    lblAge: TLabel;
    edtAge: TEdit;
    lblGender: TLabel;
    cboGender: TComboBox;
    lblLocation: TLabel;
    edtLocation: TEdit;
    lblNickname: TLabel;
    edtNickname: TEdit;
    lblUnits: TLabel;
    cboUnits: TComboBox;
    lblHeight: TLabel;
    edtHeight: TEdit;
    lblWeight: TLabel;
    edtWeight: TEdit;
    lblBodyFat: TLabel;
    edtBodyFat: TNumberBox;
    lblOptions: TLabel;
    cbStatus: TCheckBox;
    cbProgress: TCheckBox;
    cbLeague: TCheckBox;
    cbSearch: TCheckBox;
    cbMessaging: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}
initialization
RegisterFMXClasses([TfrmProfile]);

end.
