unit untProfile;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Layouts, FMX.ListBox, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerStream,
  FMX.Objects, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.MediaLibrary.Actions, untDataModule, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  FMX.EditBox, FMX.NumberBox, FMX.Controls.Presentation, FGX.ProgressDialog,
  FMX.AndroidLike.Toast;

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
    lblLocation: TLabel;
    vsbScroller: TVertScrollBox;
    layDetails: TLayout;
    IdHTTPImage: TIdHTTP;
    IdIOHandlerStream1: TIdIOHandlerStream;
    ActionList1: TActionList;
    TakePhotoFromLibraryAction1: TTakePhotoFromLibraryAction;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    fgActivityDialog: TfgActivityDialog;
    saveMessage: TToast;
    LinkFillControlToField1: TLinkFillControlToField;
    edtLocation: TEdit;
    LinkControlToField2: TLinkControlToField;
    procedure btnBackClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure TakePhotoFromLibraryAction1DidFinishTaking(Image: TBitmap);
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  IdMultipartFormData, untJsonFunctions,untFormRegistry, FMX.Styles;

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
begin
try
  fgActivityDialog.Title := 'Saving profile';
  fgActivityDialog.Message := 'Please wait!';
  fgActivityDialog.Show();
  with dmdDataModule do
  begin
      reqUpdateProfile.Params.AddItem('key',sessionkey);
      reqUpdateProfile.Params.AddItem('age',edtAge.Text);
      reqUpdateProfile.Params.AddItem('location',edtLocation.Text);
      reqUpdateProfile.Params.AddItem('id',memberId);
      reqUpdateProfile.Execute;
  end;
  fgActivityDialog.Hide();
  saveMessage.Now('Profile Saved');
except on E: Exception do
  begin
    saveMessage.Now('Failed to save profile please try later');
    fgActivityDialog.Hide();
  end;
end;
end;

procedure TfrmProfile.FormActivate(Sender: TObject);
var
  sResult : String;
begin
  fgActivityDialog.Title := 'Loading profile';
  fgActivityDialog.message := 'Please Wait';
  fgActivityDialog.Show();
  with dmdDataModule do
  begin
    // Open up the data.
    rdsaProfile.Dataset := fdmProfile;
    respProfile.Content.Empty;
    rdsaProfile.ClearDataSet;
    fdmProfile.Close;
    reqProfile.ClearBody;
    reqProfile.Params.ParameterByName('id').Value := memberId;
    reqProfile.Params.ParameterByName('signature').Value := signature('getAthlete');
    reqProfile.Params.ParameterByName('key').Value := sessionkey;
    reqProfile.Execute;
    sResult := getResultString(respProfile.Content);
    if (sResult = 'OK') then
    begin
        rdsaProfile.UpdateDataSet;
        fdmProfile.Open;
    end;
  end;
  fgActivityDialog.hide;
end;

procedure TfrmProfile.FormCreate(Sender: TObject);
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

procedure TfrmProfile.FormDeactivate(Sender: TObject);
begin
  fgActivityDialog.Hide;
end;

procedure TfrmProfile.loadPicture(sUrl : String);
//var
//  m : TMemoryStream;
begin
//try
//    if sUrl <> '' then
//    begin
//     sURL := 'http://www.reach-your-peak.com/' + sURL;
//      M := TMemoryStream.Create();
//     IdHTTPImage.Get(sURL,M);
//     M.Seek(0,0);
//     imgProfile.Bitmap.LoadFromStream(M);
//     imgProfile.Visible := true;
//     m.DisposeOf;
//    end;
//  except on E: Exception do
//  end;
end;

procedure TfrmProfile.setupCheckBoxes;
begin
//    cbStatus.IsChecked    := dmdDataModule.fdmProfileshow_status.AsString = 'yes';
//    cbProgress.IsChecked  := dmdDataModule.fdmProfileshow_progress.AsString = 'yes';
//    cbleague.IsChecked    := dmdDataModule.fdmProfileshow_tables.AsString = 'yes';
//    cbSearch.IsChecked    := dmdDataModule.fdmProfilesearch.AsString = 'yes';
//    cbMessaging.IsChecked := dmdDataModule.fdmProfilemessage.AsString = 'yes';
end;

procedure TfrmProfile.TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
begin
//  imgProfile.Bitmap.Assign(Image);
end;

procedure TfrmProfile.TakePhotoFromLibraryAction1DidFinishTaking(
  Image: TBitmap);
begin
//  imgProfile.Bitmap.Assign(Image);
end;

initialization
RegisterFMXClasses([TfrmProfile]);


end.
