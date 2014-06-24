unit untNotifications;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, untDataModule, FMX.Layouts;

type
  TfrmNotifications = class(TfrmBase)
    vertScroller: TVertScrollBox;
    grdNotifications: TGridPanelLayout;
    lblNotification: TLabel;
    btnRead: TButton;
    btnView: TButton;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNotifications: TfrmNotifications;

implementation

{$R *.fmx}

procedure TfrmNotifications.FormShow(Sender: TObject);
begin
  inherited;
  // Open up the data.
  dmdDataModule.reqNotifications.Params.ParameterByName('id').Value := dmdDataModule.memberId;
  dmdDataModule.reqNotifications.Params.ParameterByName('signature').Value := dmdDataModule.signature('getMemberNotifications');
  dmdDataModule.reqNotifications.Params.ParameterByName('key').Value := dmdDatamodule.getApiKey;
  dmdDataModule.cdsNotifications.Open;
end;

initialization
RegisterFMXClasses([TfrmNotifications]);

end.
