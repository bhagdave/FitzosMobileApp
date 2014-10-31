unit untDataModule;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope,IdHashMessageDigest,idHash,System.JSON,
  REST.Response.Adapter, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.Bind.DBScope, FireDAC.UI.Intf, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Stan.ExprFuncs, FireDAC.Comp.UI,System.IOUtils,
  FireDAC.DApt, FireDAC.Phys.SQLiteDef;

type
  TdmdDataModule = class(TDataModule)
    restAPI: TRESTClient;
    reqOpenSession: TRESTRequest;
    respOpenSession: TRESTResponse;
    reqLogin: TRESTRequest;
    respLogin: TRESTResponse;
    reqNotifications: TRESTRequest;
    respNotifications: TRESTResponse;
    rdsaNotifications: TRESTResponseDataSetAdapter;
    reqMember: TRESTRequest;
    respMember: TRESTResponse;
    rdsaMember: TRESTResponseDataSetAdapter;
    reqGeneric: TRESTRequest;
    respGeneric: TRESTResponse;
    rdsaGeneric: TRESTResponseDataSetAdapter;
    rdsaTeam: TRESTResponseDataSetAdapter;
    reqMemberTeams: TRESTRequest;
    respMemberTeams: TRESTResponse;
    rdsaMemberTeams: TRESTResponseDataSetAdapter;
    fdmMemberTeams: TFDMemTable;
    fdmMemberTeamsid: TWideStringField;
    fdmMemberTeamsname: TWideStringField;
    dsMemberTeams: TBindSourceDB;
    fdmNotifications: TFDMemTable;
    dsNotifications: TBindSourceDB;
    fdmGeneric: TFDMemTable;
    rdsaTeamMembers: TRESTResponseDataSetAdapter;
    fdmTeamMembers: TFDMemTable;
    fdmTeamMembersid: TWideStringField;
    fdmTeamMembersmember_id: TWideStringField;
    fdmTeamMembersteam_id: TWideStringField;
    fdmTeamMembersstatus: TWideStringField;
    fdmTeamMembersrequested_date: TWideStringField;
    fdmTeamMembersinvited_date: TWideStringField;
    fdmTeamMembersapproved_date: TWideStringField;
    fdmTeamMembersremoved_date: TWideStringField;
    fdmTeamMembersleft_date: TWideStringField;
    fdmTeamMembersactive: TWideStringField;
    fdmTeamMembersfirst_name: TWideStringField;
    fdmTeamMemberslast_name: TWideStringField;
    fdmTeamMemberslanguage: TWideStringField;
    fdmTeamMemberssalt: TWideStringField;
    fdmTeamMembersemail: TWideStringField;
    fdmTeamMemberspassword: TWideStringField;
    fdmTeamMembersimage: TWideStringField;
    dsTeamMembers: TBindSourceDB;
    rdsaTeamEvents: TRESTResponseDataSetAdapter;
    fdmTeamEvents: TFDMemTable;
    fdmTeamEventsid: TWideStringField;
    fdmTeamEventsname: TWideStringField;
    fdmTeamEventscontent: TWideStringField;
    fdmTeamEventsdate: TWideStringField;
    fdmTeamEventspublished: TWideStringField;
    fdmTeamEventsdate_added: TWideStringField;
    fdmTeamEventslast_modified: TWideStringField;
    fdmTeamEventsimage: TWideStringField;
    fdmTeamEventstype: TWideStringField;
    fdmTeamEventssub_type: TWideStringField;
    fdmTeamEventspublic: TWideStringField;
    fdmTeamEventsteam_id: TWideStringField;
    fdmTeamEventstime: TWideStringField;
    fdmTeamEventsmember_id: TWideStringField;
    fdmTeamEventslocation: TWideStringField;
    fdmTeamEventsend_time: TWideStringField;
    fdmTeamEventssport_id: TWideStringField;
    fdmTeamEventsend_date: TWideStringField;
    dsTeamEvents: TBindSourceDB;
    rdsaTeamWall: TRESTResponseDataSetAdapter;
    fdmTeamWall: TFDMemTable;
    fdmTeamWallid: TWideStringField;
    fdmTeamWallteam_id: TWideStringField;
    fdmTeamWallmessage: TWideStringField;
    fdmTeamWallimage: TWideStringField;
    fdmTeamWalldate: TWideStringField;
    fdmTeamWalldeleted: TWideStringField;
    fdmTeamWallmember_id: TWideStringField;
    fdmTeamWallfirst_name: TWideStringField;
    fdmTeamWalllast_name: TWideStringField;
    fdmTeamWallmemberId: TWideStringField;
    dsTeamWall: TBindSourceDB;
    fdmMember: TFDMemTable;
    fdmTeam: TFDMemTable;
    fdmMemberid: TWideStringField;
    fdmMemberactive: TWideStringField;
    fdmMemberfirst_name: TWideStringField;
    fdmMemberlast_name: TWideStringField;
    fdmMemberlanguage: TWideStringField;
    fdmMembersalt: TWideStringField;
    fdmMemberemail: TWideStringField;
    fdmMemberimage: TWideStringField;
    dsTeam: TBindSourceDB;
    reqFriends: TRESTRequest;
    respFriends: TRESTResponse;
    rdsaFriends: TRESTResponseDataSetAdapter;
    fdmFriends: TFDMemTable;
    fdmFriendsid: TWideStringField;
    fdmFriendsactive: TWideStringField;
    fdmFriendsfirst_name: TWideStringField;
    fdmFriendslast_name: TWideStringField;
    fdmFriendslanguage: TWideStringField;
    fdmFriendssalt: TWideStringField;
    fdmFriendsemail: TWideStringField;
    fdmFriendspassword: TWideStringField;
    fdmFriendsimage: TWideStringField;
    dsFriends: TBindSourceDB;
    reqEvents: TRESTRequest;
    respEvents: TRESTResponse;
    rdsaEvents: TRESTResponseDataSetAdapter;
    fdmEvents: TFDMemTable;
    fdmEventsid: TWideStringField;
    fdmEventsname: TWideStringField;
    fdmEventscontent: TWideStringField;
    fdmEventsdate: TWideStringField;
    fdmEventspublished: TWideStringField;
    fdmEventsdate_added: TWideStringField;
    fdmEventslast_modified: TWideStringField;
    fdmEventsimage: TWideStringField;
    fdmEventstype: TWideStringField;
    fdmEventssub_type: TWideStringField;
    fdmEventspublic: TWideStringField;
    fdmEventsteam_id: TWideStringField;
    fdmEventstime: TWideStringField;
    fdmEventsmember_id: TWideStringField;
    fdmEventslocation: TWideStringField;
    fdmEventsend_time: TWideStringField;
    fdmEventssport_id: TWideStringField;
    fdmEventsend_date: TWideStringField;
    dsEvents: TBindSourceDB;
    reqMemberSports: TRESTRequest;
    respMemberSports: TRESTResponse;
    rdsaMemberSports: TRESTResponseDataSetAdapter;
    fdmMemberSports: TFDMemTable;
    fdmMemberSportsid: TWideStringField;
    fdmMemberSportssport: TWideStringField;
    fdmMemberSportsfrom_date: TWideStringField;
    fdmMemberSportsto_date: TWideStringField;
    reqCreateTeam: TRESTRequest;
    respCreateTeam: TRESTResponse;
    dsMemberSports: TBindSourceDB;
    reqProfile: TRESTRequest;
    respProfile: TRESTResponse;
    rdsaProfile: TRESTResponseDataSetAdapter;
    fdmProfile: TFDMemTable;
    fdmProfileid: TWideStringField;
    fdmProfiledob: TWideStringField;
    fdmProfilegender: TWideStringField;
    fdmProfilename: TWideStringField;
    fdmProfilezip: TWideStringField;
    fdmProfilecountry: TWideStringField;
    fdmProfilelanguage: TWideStringField;
    fdmProfilenickname: TWideStringField;
    fdmProfileheight: TWideStringField;
    fdmProfileweight: TWideStringField;
    fdmProfilebmi: TWideStringField;
    fdmProfilebody_fat_percentage: TWideStringField;
    fdmProfileunits: TWideStringField;
    fdmProfileactivity: TWideStringField;
    fdmProfilelocation: TWideStringField;
    fdmProfileimage: TWideStringField;
    fdmProfileshow_status: TWideStringField;
    fdmProfileshow_progress: TWideStringField;
    fdmProfilefind_trainer: TWideStringField;
    fdmProfileshow_tables: TWideStringField;
    fdmProfilesearch: TWideStringField;
    fdmProfilemessage: TWideStringField;
    fdmProfilemember_id: TWideStringField;
    fdmProfileage: TWideStringField;
    dsProfile: TBindSourceDB;
    reqUpdateProfile: TRESTRequest;
    respUpdateProfile: TRESTResponse;
    reqSearch: TRESTRequest;
    respSearch: TRESTResponse;
    rdsaMembers: TRESTResponseDataSetAdapter;
    fdmSearchNames: TFDMemTable;
    fdmSearchNamesid: TWideStringField;
    fdmSearchNamesactive: TWideStringField;
    fdmSearchNamesfirst_name: TWideStringField;
    fdmSearchNameslast_name: TWideStringField;
    fdmSearchNamesemail: TWideStringField;
    fdmSearchNamesimage: TWideStringField;
    dsSearchNames: TBindSourceDB;
    reqSports: TRESTRequest;
    respSports: TRESTResponse;
    rdsaSports: TRESTResponseDataSetAdapter;
    fdmSports: TFDMemTable;
    fdmSportsid: TWideStringField;
    fdmSportsname: TWideStringField;
    dsSports: TBindSourceDB;
    reqAllTeamData: TRESTRequest;
    respAllTeamData: TRESTResponse;
    fdmNotificationsid: TWideStringField;
    fdmNotificationsfrom_table: TWideStringField;
    fdmNotificationsfrom_key: TWideStringField;
    fdmNotificationsto_table: TWideStringField;
    fdmNotificationsto_key: TWideStringField;
    fdmNotificationsnotification: TWideStringField;
    fdmNotificationsparent_id: TWideStringField;
    fdmNotificationspublished: TWideStringField;
    fdmNotificationsdate_added: TWideStringField;
    fdmNotificationsimage: TWideStringField;
    fdmNotificationsread: TWideStringField;
    fdmNotificationstype: TWideStringField;
    fdmNotificationsFrom: TWideStringField;
    fdmTeamid: TWideStringField;
    fdmTeamname: TWideStringField;
    fdmTeamcontent: TWideStringField;
    fdmTeamdate: TWideStringField;
    fdmTeamactive: TWideStringField;
    fdmTeamdate_added: TWideStringField;
    fdmTeamlast_modified: TWideStringField;
    fdmTeamimage: TWideStringField;
    fdmTeamowner: TWideStringField;
    fdmTeampublic: TWideStringField;
    fdmTeamsport_id: TWideStringField;
    fdmTeamisOwner: TWideStringField;
    rdsaFriendsToInvite: TRESTResponseDataSetAdapter;
    fdmFriendsToInvite: TFDMemTable;
    fdmFriendsToInviteid: TWideStringField;
    fdmFriendsToInvitefirst_name: TWideStringField;
    reqFriendRequests: TRESTRequest;
    respFriendRequests: TRESTResponse;
    rdsaFriendRequests: TRESTResponseDataSetAdapter;
    fdmFriendRequests: TFDMemTable;
    fdmFriendRequestsfriend_id: TWideStringField;
    fdmFriendRequestsfirst_name: TWideStringField;
    fdmFriendRequestslast_name: TWideStringField;
    fdmFriendRequestsimage: TWideStringField;
    reqTeamInvites: TRESTRequest;
    respTeamInvites: TRESTResponse;
    rdsaTeamInvites: TRESTResponseDataSetAdapter;
    fdmTeamInvites: TFDMemTable;
    fdmTeamInvitesid: TWideStringField;
    fdmTeamInvitesteam_id: TWideStringField;
    fdmTeamInvitesmember_id: TWideStringField;
    fdmTeamInvitesstatus: TWideStringField;
    fdmTeamInvitesinvite_sent: TWideStringField;
    fdmTeamInvitesname: TWideStringField;
    fdmTeamInvitescontent: TWideStringField;
    fdmTeamInvitesdate: TWideStringField;
    fdmTeamInvitesactive: TWideStringField;
    fdmTeamInvitesdate_added: TWideStringField;
    fdmTeamInviteslast_modified: TWideStringField;
    fdmTeamInvitesimage: TWideStringField;
    fdmTeamInvitesowner: TWideStringField;
    fdmTeamInvitespublic: TWideStringField;
    fdmTeamInvitessport_id: TWideStringField;
    reqPublicTeams: TRESTRequest;
    respPublicTeams: TRESTResponse;
    rdsaPublicTeams: TRESTResponseDataSetAdapter;
    fdmPublicTeams: TFDMemTable;
    fdmPublicTeamsid: TWideStringField;
    fdmPublicTeamsname: TWideStringField;
    fdmPublicTeamscontent: TWideStringField;
    fdmPublicTeamsdate: TWideStringField;
    fdmPublicTeamsactive: TWideStringField;
    fdmPublicTeamsdate_added: TWideStringField;
    fdmPublicTeamslast_modified: TWideStringField;
    fdmPublicTeamsimage: TWideStringField;
    fdmPublicTeamsowner: TWideStringField;
    fdmPublicTeamspublic: TWideStringField;
    fdmPublicTeamssport_id: TWideStringField;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    fdConnection: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    fdLogin: TFDTable;
    fdLoginlogin: TStringField;
    fdLoginpassword: TStringField;
    fdLoginsalt: TStringField;
    fdLogintype: TStringField;
    procedure fdConnectionBeforeConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sSessionKey : String;
    sMemberSalt : String;
    sMemberType : String;
    fLoggedIn   : Boolean;
  public
    { Public declarations }
    function openSession : Boolean;
    function checkLogin : Boolean;
    function md5(input: String) : String;
    function getApiKey() : String;
    function signature(method: String): String;
    property sessionKey : String  read sSessionKey;
    property memberId : String read sMemberSalt;
    property memberType : String read sMemberType;
    property loggedIn : Boolean read fLoggedIn;
  end;

var
  dmdDataModule: TdmdDataModule;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}
uses
  FMX.Dialogs;

{ TdmdDataModule }
const
  API_NAME = 'mobile';
  API_KEY  = 'eu47rh485u3485';
  API_COMBINED = 'eu47rh485u3485mobile';

function TdmdDataModule.checkLogin: Boolean;
var
  lJSONObject : TJSONObject;
  lResult,lStatus,lItem  : TJsonValue;
begin
  result := false;
    try
      lJSONObject := TJSONObject.Create();
      lJSONObject.Parse(TEncoding.ASCII.GetBytes(respLogin.Content),0);
      lResult := lJSONObject.Get('Result').JsonValue;
      lStatus := lJSONObject.Get('Status').JsonValue;
      if (lStatus.Value = 'OK') then
      begin
        lItem := TJSONObject(lResult).Get('salt').JsonValue;
        sMemberSalt := lItem.Value;
        lItem := TJSONObject(lResult).Get('type').JsonValue;
        sMemberType := lItem.Value;
        result := true;
        // store shit in the database mannn!
        fdConnection.Connected := true;
        fdLogin.Open();
        fdLogin.Insert;
        fdLogin.FieldByName('login').AsString := dmdDataModule.reqLogin.Params.ParameterByName('username').ToString;
        fdLogin.FieldByName('password').AsString := dmdDataModule.reqLogin.Params.ParameterByName('password').ToString;
        fdLogin.FieldByName('salt').AsString := sMemberSalt;
        fdLogin.FieldByName('type').AsString := sMemberType;
        fdLogin.Post;
        fdLogin.Close;
        fdConnection.Connected := false;
      end
      else
        result := false;
    finally
      lJSONObject.Free;
    end;
end;

procedure TdmdDataModule.DataModuleCreate(Sender: TObject);
begin
  fLoggedIn := false;
  fdConnection.Connected := true;
  fdLogin.Open;
  if fdLogin.RecordCount > 0 then
  begin
    sMemberSalt := fdLogin.FieldByName('salt').AsString;
    sMemberType := fdLogin.FieldByName('type').AsString;
    if sMemberSalt <> '' then
      fLoggedIn := true;
  end;
  fdLogin.Close;
end;

procedure TdmdDataModule.DataModuleDestroy(Sender: TObject);
begin
  fdConnection.Connected := false;
end;

procedure TdmdDataModule.fdConnectionBeforeConnect(Sender: TObject);
begin
  {$IF DEFINED(iOS) or DEFINED(ANDROID)}
  FDConnection.Params.Values['Database'] :=
      TPath.Combine(TPath.GetDocumentsPath, 'RYP.sqlite');
  {$ENDIF}
end;

function TdmdDataModule.getApiKey: String;
begin
  result := API_KEY;
end;

function TdmdDataModule.md5(input: String): String;
var
  idmd5 : TIdHashMessageDigest5;
begin
  idmd5 := TIdHashMessageDigest5.Create;
  try
    result := idmd5.HashStringAsHex(input);
  finally
    idmd5.Free;
  end;
end;

function TdmdDataModule.openSession: Boolean;
var
  lJSONObject : TJSONObject;
  lResult,lStatus  : TJsonValue;
begin
    reqOpenSession.Params.ParameterByName('key').Value  :=  self.md5(API_COMBINED);
    reqOpenSession.Params.ParameterByName('name').Value :=  API_NAME;
    reqOpenSession.Execute;
    try
      lJSONObject := TJSONObject.Create();
      lJSONObject.Parse(TEncoding.ASCII.GetBytes(respOpenSession.Content),0);
      lResult := lJSONObject.Get('Result').JsonValue;
      lStatus := lJSONObject.Get('Status').JsonValue;
      if (lStatus.Value = 'OK') then
      begin
        sSessionKey := lResult.Value;
        openSession := true;
      end
      else
        openSession := false;
    finally
      lJSONObject.Free;
    end;
end;

function TdmdDataModule.signature(method: String): String;
begin
  result := self.md5(API_NAME + API_KEY + method);
end;

end.
