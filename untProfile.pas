unit untProfile;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Layouts, FMX.ListBox, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerStream,
  FMX.Objects, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.MediaLibrary.Actions, untDataModule, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components;

type
  TfrmProfile = class(TForm)
    StyleBook1: TStyleBook;
    barTop: TToolBar;
    lblTitle: TLabel;
    barBottom: TToolBar;
    btnSave: TButton;
    btnBack: TButton;
    grdLayout: TGridPanelLayout;
    lblAge: TLabel;
    edtAge: TEdit;
    lblGender: TLabel;
    cboGender: TComboBox;
    lblLocation: TLabel;
    edtLocation: TEdit;
    lblNickname: TLabel;
    edtNickname: TEdit;
    lblUnits: TLabel;
    cboUnits: TComboBox;
    lblHeight: TLabel;
    edtHeight: TEdit;
    lblWeight: TLabel;
    edtWeight: TEdit;
    lblBodyFat: TLabel;
    edtBodyFat: TNumberBox;
    lblOptions: TLabel;
    cbStatus: TCheckBox;
    cbProgress: TCheckBox;
    cbLeague: TCheckBox;
    cbSearch: TCheckBox;
    cbMessaging: TCheckBox;
    expOptions: TExpander;
    expImage: TExpander;
    vsbScroller: TVertScrollBox;
    layDetails: TLayout;
    IdHTTPImage: TIdHTTP;
    IdIOHandlerStream1: TIdIOHandlerStream;
    imgProfile: TImage;
    pnlImage: TGridPanelLayout;
    btnGetImage: TButton;
    ActionList1: TActionList;
    TakePhotoFromLibraryAction1: TTakePhotoFromLibraryAction;
    btnTakePhoto: TButton;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    LinkFillControlToField2: TLinkFillControlToField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    LinkPropertyToFieldText: TLinkPropertyToField;
    procedure btnBackClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure TakePhotoFromLibraryAction1DidFinishTaking(Image: TBitmap);
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses
  IdMultipartFormData, untMainForm;

{$R *.fmx}
procedure TfrmProfile.btnBackClick(Sender: TObject);
begin
  close;
end;

procedure TfrmProfile.btnSaveClick(Sender: TObject);
var
  mStream  : TMemoryStream;
  sStream  : TStringStream;
  multiStream: TIdMultiPartFormDataStream;
begin
  multiStream := TIdMultiPartFormDataStream.Create;
  mStream := TMemoryStream.Create();
  try
    imgProfile.Bitmap.SaveToStream(mStream);
    multiStream.AddFormField('file', 'image/jpeg', '', mStream, 'image1.jpg');
    multiStream.AddFormField('field2', 'value2');
    idhttpimage.Post('http://beta.fitzos.com/athlete/saveProfileImage/9', multiStream);
  finally
    multiStream.Free;
    mStream.Free;
  end;
end;

procedure TfrmProfile.FormActivate(Sender: TObject);
var
  sResult : String;
begin
  with dmdDataModule do
  begin
    // Open up the data.
    rdsaProfile.ClearDataSet;
    fdmProfile.Close;
    respProfile.Content.Empty;
    reqProfile.ClearBody;
    reqProfile.Params.ParameterByName('id').Value := memberId;
    reqProfile.Params.ParameterByName('signature').Value := signature('getAthlete');
    reqProfile.Params.ParameterByName('key').Value := getApiKey;
    reqProfile.Execute;
    sResult := getResultString(respProfile.Content);
    if (sResult = 'OK') then
    begin
        rdsaProfile.Response := respNotifications;
        fdmProfile.Open;
    end;
  end;
end;

procedure TfrmProfile.TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
begin
  imgProfile.Bitmap.Assign(Image);
end;

procedure TfrmProfile.TakePhotoFromLibraryAction1DidFinishTaking(
  Image: TBitmap);
begin
  imgProfile.Bitmap.Assign(Image);
end;

initialization
RegisterFMXClasses([TfrmProfile]);


end.
