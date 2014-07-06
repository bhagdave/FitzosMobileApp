unit untEvent;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, untEventDataModule, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.DBScope, untDataModule;

type
  TfrmEvent = class(TfrmBase)
    lblName: TLabel;
    lblContent: TLabel;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    lblDate: TLabel;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEvent: TfrmEvent;

implementation

uses
  untMainForm;

{$R *.fmx}
procedure TfrmEvent.FormActivate(Sender: TObject);
var
  sResult : String;
  sURL    : String;
begin
  with dmdEvent do
  begin
      // Open up the data.
      rdsaEvent.ClearDataSet;
      fdmEvent.Close;
      respEvent.Content.Empty;
      reqEvent.ClearBody;
      reqEvent.Params.ParameterByName('id').Value := id;
      reqEvent.Params.ParameterByName('signature').Value := dmdDataModule.signature('getMember');
      reqEvent.Params.ParameterByName('key').Value := dmdDataModule.getApiKey;
      reqEvent.Execute;
      sResult := getResultString(respEvent.Content);
      if (sResult = 'OK') then
      begin
          rdsaEvent.Response := respEvent;
          fdmEvent.Open;
//          sURL := 'http://beta.fitzos.com/' + fdmMember.FieldByName('image').AsString;
//          loadPicture(sURL);
      end;
  end;
end;

initialization
RegisterFMXClasses([TfrmEvent]);

end.
