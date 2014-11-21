unit untNotification;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit,untDataModule, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.DBScope, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, FMX.Notification, FGX.ProgressDialog,
  FMX.AndroidLike.Toast;

type
  TfrmNotification = class(TfrmBase)
    lblNotification: TLabel;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    btnRead: TButton;
    lblFrom: TLabel;
    lblDate: TLabel;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    procedure FormShow(Sender: TObject);
    procedure btnReadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses
  untJsonFunctions,untFormRegistry;

{$R *.fmx}
procedure TfrmNotification.btnReadClick(Sender: TObject);
begin
  inherited;
  // ok we need to send a markedread call
  with dmdDataModule do
  begin
      rdsaGeneric.ClearDataSet;
      respGeneric.Content.Empty;
      reqGeneric.Params.Clear;
      reqGeneric.ClearBody;
      reqGeneric.Resource := 'notifications/markRead';
      reqGeneric.Params.addItem('id',fdmNotifications.FieldByName('id').AsString);
      reqGeneric.Params.addItem('signature',signature('markRead'));
      reqGeneric.Params.addItem('key',getApiKey);
      reqGeneric.Execute;
      btnRead.Enabled := false;
      saveMessage.Now('Notification read');
  end;
  close;
end;

procedure TfrmNotification.FormShow(Sender: TObject);
var
  sFrom   : String;
begin
  inherited;
  sFrom := 'From Administrator';
  dmdDataModule.fdmNotifications.Locate('id',ID,[]);
  sFrom := 'The notification came from ' + dmdDataModule.fdmNotifications.FieldByName('from').AsString;
  lblFrom.text := sFrom;
end;

initialization
RegisterFMXClasses([TfrmNotification]);

end.
