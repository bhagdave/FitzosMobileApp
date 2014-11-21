unit untNotifications;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, untDataModule, FMX.Layouts,
  FMX.ListView.Types, FMX.ListView, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, Fmx.Bind.Grid, Data.Bind.Grid, FMX.Grid,System.JSON,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  FGX.ProgressDialog, FMX.Notification, FMX.AndroidLike.Toast;

type
  TfrmNotifications = class(TfrmBase)
    lvNotifications: TListView;
    BindingsList1: TBindingsList;
    LinkFillControlToField: TLinkFillControlToField;
    procedure lvNotificationsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure notificationsLoaded;
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}
uses
  untJsonFunctions,untFormRegistry;

procedure TfrmNotifications.FormActivate(Sender: TObject);
begin
  inherited;
  with dmdDataModule do
  begin
    // Open up the data.
    rdsaNotifications.ClearDataSet;
//    rdsaNotifications.Response := nil;
    fdmNotifications.Close;
    fdmNotifications.Active := false;
    respNotifications.Content.Empty;
    reqNotifications.ClearBody;
    reqNotifications.Params.ParameterByName('id').Value := memberId;
    reqNotifications.Params.ParameterByName('signature').Value := signature('getMemberNotifications');
    reqNotifications.Params.ParameterByName('key').Value := getApiKey;
    reqNotifications.ExecuteAsync(notificationsLoaded);
  end;
end;

procedure TfrmNotifications.lvNotificationsItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  LValue : TValue;
begin
  inherited;
  LValue := GetSelectedValue(lvNotifications);
  showNewFormWithId('TfrmNotification',lValue.ToString);
//  showNewForm('TfrmNotification');
end;

procedure TfrmNotifications.notificationsLoaded;
var
  sResult : String;
begin
    sResult := getResultString(dmdDataModule.respNotifications.Content);
    if (sResult = 'OK') then
    begin
//      rdsaNotifications.Response := respNotifications;
      dmdDataModule.rdsaNotifications.UpdateDataSet;
      dmdDataModule.fdmNotifications.Open;
    end;
end;

initialization
RegisterFMXClasses([TfrmNotifications]);

end.
