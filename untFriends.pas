unit untFriends;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListView.Types, FMX.ListView, untDataModule,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components;

type
  TfrmFriends = class(TfrmBase)
    lvFriends: TListView;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFriends: TfrmFriends;

implementation
uses
  untMainForm;

{$R *.fmx}
procedure TfrmFriends.FormShow(Sender: TObject);
var
  sResult : String;
begin
  inherited;
  with dmdDataModule do
  begin
    // Open up the data.
    rdsaFriends.ClearDataSet;
    fdmFriends.Close;
    respFriends.Content.Empty;
    reqFriends.ClearBody;
    reqFriends.Params.ParameterByName('id').Value := memberId;
    reqFriends.Params.ParameterByName('signature').Value := signature('getFriends');
    reqFriends.Params.ParameterByName('key').Value := getApiKey;
    reqFriends.Execute;
    sResult := getResultString(respFriends.Content);
    if (sResult = 'OK') then
    begin
        rdsaFriends.Response := respFriends;
        fdmFriends.Open;
    end;
  end;
end;

initialization
RegisterFMXClasses([TfrmFriends]);

end.
