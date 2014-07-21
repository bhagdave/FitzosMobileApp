unit untProfile;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Layouts, FMX.ListBox, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerStream,
  FMX.Objects, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.MediaLibrary.Actions, untDataModule;

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
    expSports: TExpander;
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
    procedure btnBackClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure TakePhotoFromLibraryAction1DidFinishTaking(Image: TBitmap);
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses
  IdMultipartFormData;

{$R *.fmx}
procedure TfrmProfile.btnBackClick(Sender: TObject);
begin
  close;
end;

procedure TfrmProfile.btnSaveClick(Sender: TObject);
var
  mStream  : TMemoryStream;
  sStream  : TStringStream;
begin
  mStream := TMemoryStream.Create();
  sStream := TStringStream.Create;
  imgProfile.Bitmap.SaveToStream(mStream);
  IdHTTPImage.Post('http://beta.fitzos.com/athlete/saveProfileImage/' + dmdDataModule.memberId,mStream,sStream);
  showmessage(sStream.DataString);
  sStream.Free;
  mStream.Free;
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
