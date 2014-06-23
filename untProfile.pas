unit untProfile;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs;

type
  TfrmProfile = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProfile: TfrmProfile;

implementation

{$R *.fmx}
initialization
RegisterFMXClasses([TfrmProfile]);

end.
