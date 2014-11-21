unit untFriend;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, untDataModule, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.DBScope, FMX.Layouts, FMX.ListView.Types,
  FMX.ListView, FMX.Notification, FGX.ProgressDialog, FMX.AndroidLike.Toast ;

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
    lblAge: TLabel;
    grdLayout: TGridPanelLayout;
    lvSports: TListView;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField1: TLinkFillControlToField;
    BeFriend: TButton;
    procedure FormActivate(Sender: TObject);
    procedure BeFriendClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
    procedure getProfile();
    procedure getMember();
    procedure getMemberSports();
    procedure loadPicture(sURL : String);
    procedure checkIfFriends();
  public
    { Public declarations }
  end;


implementation

uses
  untJsonFunctions,untFormRegistry;

{$R *.fmx}


procedure TfrmFriend.BeFriendClick(Sender: TObject);
var
  sResult : String;
begin
  inherited;
  showActivityDialog('Making a friend','Please wait');
  if connected then
  begin
    with dmdDataModule do
    begin
      reqGeneric.Params.Clear;
      reqGeneric.Resource := 'r/members/setFriendRequest';
      reqGeneric.Params.addItem('to',id);
      reqGeneric.Params.addItem('from',memberId);
      reqGeneric.Params.AddItem('signature',signature('setFriendRequest'));
      reqGeneric.Params.AddItem('key',getAPIKey());
      reqGeneric.Execute;
      sResult := getResultString(respGeneric.Content);
        if (sResult = 'OK') then
        begin
          fgActivityDialog.Hide;
          showmessage('Friend request requested!');
          self.close;
        end
        else
        begin
          fgActivityDialog.Hide;
          showmessage('Friend request failed please try again later!');
        end;
    end;
  end
  else
  begin
    showmessage('No internet connection at the moment');
  end;
end;

procedure TfrmFriend.checkIfFriends;
var
  sResult : String;
  bFriends : Boolean;
begin
  with dmdDataModule do
  begin
    fgActivityDialog.Message := 'Checking to see if a friend';
    reqGeneric.Params.Clear;
    reqGeneric.Resource := 'r/members/isFriends';
    reqGeneric.Params.addItem('user',id);
    reqGeneric.Params.addItem('id',memberId);
    reqGeneric.Params.AddItem('signature',signature('loadProfile'));
    reqGeneric.Params.AddItem('key',getAPIKey());
    reqGeneric.Execute;
    sResult := getResultString(respGeneric.Content);
      if (sResult = 'OK') then
      begin
        bFriends := getResultBoolean(respGeneric.Content,'Result');
        if not(bFriends) then
          beFriend.Visible := true
        else
          beFriend.Visible := false;
      end;
  end;
end;

procedure TfrmFriend.FormActivate(Sender: TObject);
begin
  // clear out image man
  imgUser.Visible := false;
  if connected then
  begin
    showActivityDialog('Getting profile data','Please wait');
    getMember();
    getMemberSports();
    getProfile();
    checkIfFriends();
    fgActivityDialog.Hide;
  end
  else
  begin
    showmessage('No internet connection at the moment');
    close;
  end;
end;

procedure TfrmFriend.FormDeactivate(Sender: TObject);
begin
  inherited;
 fgActivityDialog.Hide;
end;

procedure TfrmFriend.getMember;
var
  sResult : String;
  sURL    : String;
begin
  fgActivityDialog.Message := 'Getting member details';
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
          rdsaMember.UpdateDataSet;
          fdmMember.Open;
          if fdmMember.FieldByName('image').AsString <> '' then
          begin
            sURL := 'https://www.reach-your-peak.com/' + fdmMember.FieldByName('image').AsString;
            loadPicture(sURL);
          end;
      end;
  end;
end;

procedure TfrmFriend.getMemberSports;
var
  sResult : String;
begin
  fgActivityDialog.Message := 'Getting member sports';
  with dmdDataModule do
  begin
      rdsaMemberSports.ClearDataSet;
      fdmMemberSports.Close;
      respMemberSports.Content.Empty;
      reqMemberSports.ClearBody;
      reqMemberSports.Params.ParameterByName('id').Value := id;
      reqMemberSports.Params.ParameterByName('signature').Value := signature('getSports');
      reqMemberSports.Params.ParameterByName('key').Value := getApiKey;
      reqMemberSports.Execute;
      sResult := getResultString(respMemberSports.Content);
      if (sResult = 'OK') then
      begin
          rdsaMemberSports.UpdateDataSet;
          fdmMemberSports.Open;
      end;
  end;
end;

procedure TfrmFriend.getProfile;
var
  sResult : String;
begin
  fgActivityDialog.Message := 'Getting user profile';
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
          rdsaGeneric.UpdateDataSet;
          fdmGeneric.Open;
          lblGender.Text := fdmGeneric.FieldByName('gender').AsString;
          lblAge.Text := fdmGeneric.FieldByName('age').AsString;
      end;
  end;
end;

procedure TfrmFriend.loadPicture(sURL : String);
var
    M: TMemoryStream;
begin
  fgActivityDialog.Message := 'Getting member picture';
  try
    if sUrl <> '' then
    begin
      M := TMemoryStream.Create();
     IdHTTPImage.Get(sURL,M);
     M.Seek(0,0);
     imgUser.Bitmap.LoadFromStream(M);
     imgUser.Visible := true;
     m.DisposeOf;
    end;
  except on E: Exception do
  end;
end;

initialization
RegisterFMXClasses([TfrmFriend]);

end.

