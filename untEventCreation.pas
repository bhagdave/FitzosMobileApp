unit untEventCreation;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit;

type
  TfrmEventCreation = class(TfrmBase)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEventCreation: TfrmEventCreation;

implementation

{$R *.fmx}
initialization
RegisterFMXClasses([TfrmEventCreation]);

end.
