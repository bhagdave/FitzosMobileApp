unit untBaseForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Objects, FMX.StdCtrls, untDataModule, Data.Bind.Components, System.RTTI;

type
  TfrmBase = class(TForm)
    barBottom: TToolBar;
    pnlTop: TPanel;
    pnlCenter: TPanel;
    lblCaption: TLabel;
    StyleBook1: TStyleBook;
    btnBack: TButton;
    procedure edtSearchExit(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fId : String;
    procedure setId(sId : String);
  public
    { Public declarations }
    function getSelectedValue(AObject : TObject): TValue;
    property Id : String read fId write setId;

  end;

implementation

{$R *.fmx}
uses
  untFormRegistry,FMX.Styles;

procedure TfrmBase.btnBackClick(Sender: TObject);
begin
  close;
end;

procedure TfrmBase.edtSearchExit(Sender: TObject);
begin
//  shownewFormwithId('TfrmSearch',edtSearch.Text);
end;

procedure TfrmBase.FormCreate(Sender: TObject);
var
    Style: TFMXObject;
begin
    {$IFDEF Android}
        Style := TStyleManager.LoadFromResource(HInstance, 'OrangeStyle', RT_RCDATA);
    {$ENDIF}
    {$IFDEF iOS}
        Style := TStyleManager.LoadFromResource(HInstance, 'OrangeStyle', RT_RCDATA);
    {$ENDIF}
    if Style<> nil then
        TStyleManager.SetStyle(Style);
end;

function TfrmBase.getSelectedValue(AObject: TObject): TValue;
var
  LEditor : IBindListEditorCommon;
begin
  LEditor := GetBindEditor(AObject, IBindListEditorCommon) as IBindListEditorCommon;
  Result := Leditor.SelectedValue;
end;

procedure TfrmBase.setId(sId: String);
begin
  fId := sId;
end;

end.
