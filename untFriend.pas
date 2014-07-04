unit untFriend;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, untDataModule, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP ;

type
  TfrmFriend = class(TfrmBase)
    lblDebug: TLabel;
    pnlMemberDetails: TPanel;
    lblName: TLabel;
    imgUser: TImage;
    IdHTTPImage: TIdHTTP;
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  lblDebug.Text := id;
  getMember();
//  getProfile();
end;

procedure TfrmFriend.FormShow(Sender: TObject);
//var
//  sURL : String;
begin
//  inherited;
//  sURL := 'http://www.stoneacre.co.uk/assets/images/fuel-and-go-pricing.jpg';
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
          lblDebug.Text := sURL;
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
    reqGeneric.Params.ParameterByName('id').Value := id;
    reqGeneric.Params.ParameterByName('signature').Value := signature('loadProfile');
    reqGeneric.Params.ParameterByName('key').Value := getAPIKey();
    reqGeneric.Execute;
    sResult := getResultString(respGeneric.Content);
      if (sResult = 'OK') then
      begin
          rdsaGeneric.Response := respGeneric;
          fdmGeneric.Open;
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
