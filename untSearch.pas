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
    procedure lvResultsClick(Sender: TObject);
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
  end;
end;

procedure TfrmSearch.lvResultsClick(Sender: TObject);
var
  LValue : TValue;
begin
  inherited;
  LValue := GetSelectedValue(lvResults);
  showNewFormWithId('TfrmFriend',lValue.ToString);
//  showNewForm('TfrmNotification');
end;

initialization
RegisterFMXClasses([TfrmSearch]);

end.
