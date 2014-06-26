unit untNotification;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit,untDataModule;

type
  TfrmNotification = class(TfrmBase)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNotification: TfrmNotification;

implementation

{$R *.fmx}
procedure TfrmNotification.FormShow(Sender: TObject);
begin
  inherited;
  // where did the message come from....
end;

initialization
RegisterFMXClasses([TfrmNotification]);

end.
