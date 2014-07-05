unit untFriend;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, untDataModule, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.DBScope ;

type
  TfrmFriend = class(TfrmBase)
    pnlMemberDetails: TPanel;
    lblName: TLabel;
    imgUser: TImage;
    IdHTTPImage: TIdHTTP;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldText: TLinkPropertyToField;
    lblGender: TLabel;
    lblNickname: TLabel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure getProfile();
    procedure getMember();
    procedure loadPicture(sURL : String);
  public
    { Public declarations }
  end;

var
  frmFriend: TfrmFriend;

implementation

uses
  untMainForm;

{$R *.fmx}


procedure TfrmFriend.FormActivate(Sender: TObject);
begin
  getMember();
  getProfile();
end;

procedure TfrmFriend.getMember;
var
  sResult : String;
  sURL    : String;
begin
  with dmdDataModule do
  begin
      // Open up the data.
      rdsaMember.ClearDataSet;
      fdmMember.Close;
      respMember.Content.Empty;
      reqMember.ClearBody;
      reqMember.Params.ParameterByName('id').Value := id;
      reqMember.Params.ParameterByName('signature').Value := signature('getMember');
      reqMember.Params.ParameterByName('key').Value := getApiKey;
      reqMember.Execute;
      sResult := getResultString(respMember.Content);
      if (sResult = 'OK') then
      begin
          rdsaMember.Response := respMember;
          fdmMember.Open;
          sURL := 'http://beta.fitzos.com/' + fdmMember.FieldByName('image').AsString;
          loadPicture(sURL);
      end;
  end;
end;

procedure TfrmFriend.getProfile;
var
  sResult : String;
begin
  // ok lets try and get some data
  with dmdDataModule do
  begin
    reqGeneric.Resource := 'athletes/loadProfile';
    reqGeneric.Params.addItem('id',id);
    reqGeneric.Params.AddItem('signature',signature('loadProfile'));
    reqGeneric.Params.AddItem('key',getAPIKey());
    reqGeneric.Execute;
    sResult := getResultString(respGeneric.Content);
      if (sResult = 'OK') then
      begin
          rdsaGeneric.Response := respGeneric;
          fdmGeneric.Open;
          lblGender.Text := fdmGeneric.FieldByName('gender').AsString;
          lblNickname.Text := fdmGeneric.FieldByName('nickname').AsString;
      end;
  end;
end;

procedure TfrmFriend.loadPicture(sURL : String);
var
    M: TMemoryStream;
begin
    M := TMemoryStream.Create();
    IdHTTPImage.Get(sURL,M);
    M.Seek(0,0);
    imgUser.Bitmap.LoadFromStream(M);
    m.DisposeOf;
end;

initialization
RegisterFMXClasses([TfrmFriend]);

end.
