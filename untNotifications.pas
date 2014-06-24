unit untNotifications;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, untDataModule, FMX.Layouts,
  FMX.ListView.Types, FMX.ListView, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, Fmx.Bind.Grid, Data.Bind.Grid, FMX.Grid;

type
  TfrmNotifications = class(TfrmBase)
    lvNotifications: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
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
  dmdDataModule.reqNotifications.Execute;
  dmdDataModule.cdsNotifications.Open;
end;

initialization
RegisterFMXClasses([TfrmNotifications]);

end.
