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
var
  lJSONObject : TJSONObject;
  lJSONPair   : TJSONPair;
  lResult,lStatus,lItem  : TJsonValue;
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
    try
      lJSONObject := TJSONObject.Create();
      lJSONObject.Parse(TEncoding.ASCII.GetBytes(respNotifications.Content),0);
      lResult := lJSONObject.Get('Result').JsonValue;
      lStatus := lJSONObject.Get('Status').JsonValue;
      if (lStatus.Value = 'OK') then
      begin
        rdsaNotifications.Response := respNotifications;
        cdsNotifications.Open;
      end
      else
      begin
        showmessage(respNotifications.Content);
      end;
    finally
      lJSONObject.Free;
      lStatus.Free;
      lResult.Free;
    end;

    cdsNotifications.Open;
  end;
end;

initialization
RegisterFMXClasses([TfrmNotifications]);

end.
