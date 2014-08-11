unit untSearch;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, untDataModule, FMX.ListView.Types,
  FMX.ListView, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components;

type
  TfrmSearch = class(TfrmBase)
    lvResults: TListView;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure FormActivate(Sender: TObject);
    procedure lvResultsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses
  untMainForm;



{$R *.fmx}
procedure TfrmSearch.FormActivate(Sender: TObject);
var
  sResult : String;
begin
  inherited;
  edtSearch.Text := id;
  // do the search!!
  with dmdDataModule do
  begin
    rdsaMembers.ClearDataSet;
    respSearch.Content.Empty;
//    reqSearch.Params.Clear;
    reqSearch.ClearBody;
    reqSearch.Params.ParameterByName('criteria[name]').Value := id;
    reqSearch.Params.ParameterByName('id').Value := memberId;
    reqSearch.Execute;
    sResult := getResultString(respSearch.Content);
    if (sResult = 'OK') then
    begin
      try
        rdsaMembers.UpdateDataSet;
        fdmSearchNames.Open;
      except on E: Exception do
      end;
    end;
  end;
end;

procedure TfrmSearch.lvResultsItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  LValue : TValue;
begin
  inherited;

  LValue := GetSelectedValue(lvResults);
  showNewFormWithId('TfrmFriend',lValue.ToString);
end;
initialization
RegisterFMXClasses([TfrmSearch]);

end.
