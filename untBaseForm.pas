unit untBaseForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Objects, FMX.StdCtrls, untDataModule, Data.Bind.Components, System.RTTI,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient;

type
  TfrmBase = class(TForm)
    barBottom: TToolBar;
    pnlTop: TPanel;
    pnlCenter: TPanel;
    lblCaption: TLabel;
    StyleBook1: TStyleBook;
    btnBack: TButton;
    idTCPConnection: TIdTCPClient;
    procedure edtSearchExit(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fId : String;
    procedure setId(sId : String);
  protected
    function connected : boolean;
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

function TfrmBase.connected: boolean;
begin
  result := false;
  try
     IdTCPConnection.ReadTimeout := 2000;
     IdTCPConnection.ConnectTimeout := 2000;
     IdTCPConnection.port := 80;
     IdTCPConnection.host := 'www.reach-your-peak.com';
     IdTCPConnection.Connect;
     IdTCPConnection.Disconnect;
     result := true;
  except on E: Exception do
  begin
    result := false;
  end;
  end;
end;

procedure TfrmBase.edtSearchExit(Sender: TObject);
begin
//  shownewFormwithId('TfrmSearch',edtSearch.Text);
end;

procedure TfrmBase.FormCreate(Sender: TObject);
var
    Style: TFMXObject;
begin
    {$IFDEF MSWINDOWS}
        Style := TStyleStreaming.LoadFromResource(HInstance, 'OrangeStyle', RT_RCDATA);
    {$ENDIF}
    {$IFDEF Android}
        Style := TStyleStreaming.LoadFromResource(HInstance, 'OrangeStyle', RT_RCDATA);
    {$ENDIF}
    {$IFDEF iOS}
        Style := TStyleStreaming.LoadFromResource(HInstance, 'OrangeStyle', RT_RCDATA);
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

//

procedure TfrmBase.setId(sId: String);
begin
  fId := sId;
end;

end.
