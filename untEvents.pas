unit untEvents;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListView.Types, FMX.ListView, untDataModule,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components;

type
  TfrmEvents = class(TfrmBase)
    lvEvents: TListView;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEvents: TfrmEvents;

implementation

uses
  untMainForm;
{$R *.fmx}
{ TfrmEvents }

procedure TfrmEvents.FormActivate(Sender: TObject);
var
  sResult : String;
begin
  inherited;
  with dmdDataModule do
  begin
    // Open up the data.
    rdsaEvents.ClearDataSet;
    fdmEvents.Close;
    respEvents.Content.Empty;
    reqEvents.ClearBody;
    reqEvents.Params.ParameterByName('id').Value := memberId;
    reqEvents.Params.ParameterByName('signature').Value := signature('getEventsForMember');
    reqEvents.Params.ParameterByName('key').Value := getApiKey;
    reqEvents.Execute;
    sResult := getResultString(respEvents.Content);
    if (sResult = 'OK') then
    begin
        rdsaEvents.Response := respEvents;
        fdmEvents.Open;
    end;
  end;
end;

initialization
RegisterFMXClasses([TfrmEvents]);

end.
