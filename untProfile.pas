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
    btnSports: TButton;
    procedure btnBackClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure TakePhotoFromLibraryAction1DidFinishTaking(Image: TBitmap);
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
    procedure FormActivate(Sender: TObject);
    procedure btnSportsClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
    procedure setupCheckBoxes();
    procedure loadPicture(sUrl : String);
  public
    { Public declarations }
  end;

implementation
uses
  IdMultipartFormData, untMainForm;

{$R *.fmx}
procedure TfrmProfile.btnBackClick(Sender: TObject);
begin
  with dmdDatamodule do
  begin
   rdsaProfile.Dataset := nil;
  end;
  close;
end;

procedure TfrmProfile.btnSaveClick(Sender: TObject);
var
  mStream  : TMemoryStream;
  sStream  : TStringStream;
  multiStream: TIdMultiPartFormDataStream;
  Height, weight : Double;
  sNickName : String;
begin
//  sNickname := edtNickname.Text;
  multiStream := TIdMultiPartFormDataStream.Create;
  mStream := TMemoryStream.Create();
  try
    if not imgProfile.Bitmap.IsEmpty then
    begin
      imgProfile.Bitmap.SaveToStream(mStream);
      multiStream.AddFormField('file', 'image/jpeg', '', mStream, dmdDataModule.memberId + '.jpg');
    end;
    multiStream.AddFormField('id', dmdDataModule.memberId);
    multiStream.AddFormField('gender', cboGender.Selected.Text);
    if cboUnits.Selected.Text = 'Metric' then
    begin
      multiStream.AddFormField('height', edtHeight.Text);
      multiStream.AddFormField('weight', edtWeight.Text);
    end
    else
    begin
      weight := StrToFloat(edtWeight.Text) * 0.453592;
      height := StrToFloat(edtHeight.Text) * 2.54;
      multiStream.AddFormField('height', Format('%.2f',[height]));
      multiStream.AddFormField('weight', Format('%.2f',[weight]));
    end;
    multiStream.AddFormField('body_fat_percentage', FloatToStr(edtBodyFat.Value));
    multiStream.AddFormField('units', cboUnits.Selected.Text);
    multiStream.AddFormField('location', edtLocation.Text);
    if cbStatus.IsChecked then
      multiStream.AddFormField('show_status', 'Yes')
    else
      multiStream.AddFormField('show_status', 'No');
    if cbProgress.IsChecked then
      multiStream.AddFormField('show_progress', 'Yes')
    else
      multiStream.AddFormField('show_progress', 'No');
    if cbLeague.IsChecked then
      multiStream.AddFormField('show_tables', 'Yes')
    else
      multiStream.AddFormField('show_tables', 'No');
    if cbSearch.IsChecked then
      multiStream.AddFormField('search', 'Yes')
    else
      multiStream.AddFormField('search', 'No');
    if cbMessaging.IsChecked then
      multiStream.AddFormField('message', 'Yes')
    else
      multiStream.AddFormField('message', 'No');
    multiStream.AddFormField('age', edtAge.Text);
//    multiStream.AddFormField('nickname', edtNickname.Text);
    idhttpimage.Post('http://beta.fitzos.com/athlete/saveProfileImage/' + dmdDatamodule.memberId, multiStream);
  finally
    multiStream.Free;
    mStream.Free;
  end;
  close;
end;

procedure TfrmProfile.btnSportsClick(Sender: TObject);
begin
  showNewForm('TfrmSports');
end;

procedure TfrmProfile.FormActivate(Sender: TObject);
var
  sResult : String;
begin
  with dmdDataModule do
  begin
    // Open up the data.
    rdsaProfile.Active := false;
    rdsaProfile.Dataset := fdmProfile;
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
        setupCheckBoxes();
        loadPicture(fdmProfileimage.AsString);
    end;
  end;
end;

procedure TfrmProfile.FormDeactivate(Sender: TObject);
begin
  with dmdDatamodule do
  begin
   rdsaProfile.Dataset := nil;
  end;
end;

procedure TfrmProfile.loadPicture(sUrl : String);
var
  m : TMemoryStream;
begin
try
    if sUrl <> '' then
    begin
    showmessage(sUrl);
      M := TMemoryStream.Create();
     IdHTTPImage.Get(sURL,M);
     M.Seek(0,0);
     imgProfile.Bitmap.LoadFromStream(M);
     imgProfile.Visible := true;
     m.DisposeOf;
    end;
  except on E: Exception do
  end;
end;

procedure TfrmProfile.setupCheckBoxes;
begin
    cbStatus.IsChecked    := dmdDataModule.fdmProfileshow_status.AsString = 'yes';
    cbProgress.IsChecked  := dmdDataModule.fdmProfileshow_progress.AsString = 'yes';
    cbleague.IsChecked    := dmdDataModule.fdmProfileshow_tables.AsString = 'yes';
    cbSearch.IsChecked    := dmdDataModule.fdmProfilesearch.AsString = 'yes';
    cbMessaging.IsChecked := dmdDataModule.fdmProfilemessage.AsString = 'yes';
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
