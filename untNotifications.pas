unit untNotifications;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, untDataModule, FMX.Layouts,
  FMX.ListView.Types, FMX.ListView, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, Fmx.Bind.Grid, Data.Bind.Grid, FMX.Grid,System.JSON;

type
  TfrmNotifications = class(TfrmBase)
    lvNotifications: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure FormShow(Sender: TObject);
    procedure lvNotificationsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNotifications: TfrmNotifications;

implementation

{$R *.fmx}
uses
  untMainForm;

procedure TfrmNotifications.FormActivate(Sender: TObject);
begin
  inherited;
  formShow(Sender);
end;

procedure TfrmNotifications.FormShow(Sender: TObject);
var
  sResult : String;
begin
  inherited;
  with dmdDataModule do
  begin
    // Open up the data.
    rdsaNotifications.ClearDataSet;
    cdsNotifications.Close;
    respNotifications.Content.Empty;
    reqNotifications.ClearBody;
    reqNotifications.Params.ParameterByName('id').Value := memberId;
    reqNotifications.Params.ParameterByName('signature').Value := signature('getMemberNotifications');
    reqNotifications.Params.ParameterByName('key').Value := getApiKey;
    reqNotifications.Execute;
    sResult := getResultString(respNotifications.Content);
    if (sResult = 'OK') then
    begin
        rdsaNotifications.Response := respNotifications;
        cdsNotifications.Open;
    end;
  end;
end;

procedure TfrmNotifications.lvNotificationsItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  inherited;
  // how do I get the item id being clicked...
  showNewForm('TfrmNotification');
end;

initialization
RegisterFMXClasses([TfrmNotifications]);

end.
