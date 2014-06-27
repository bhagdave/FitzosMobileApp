unit untDataModule;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope,IdHashMessageDigest,idHash,System.JSON,
  REST.Response.Adapter, Data.DB, Datasnap.DBClient, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.Bind.DBScope;

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
    cdsMember: TClientDataSet;
    reqGeneric: TRESTRequest;
    respGeneric: TRESTResponse;
    rdsaGeneric: TRESTResponseDataSetAdapter;
    reqTeam: TRESTRequest;
    respTeam: TRESTResponse;
    rdsaTeam: TRESTResponseDataSetAdapter;
    cdsTeam: TClientDataSet;
    reqMemberTeams: TRESTRequest;
    respMemberTeams: TRESTResponse;
    rdsaMemberTeams: TRESTResponseDataSetAdapter;
    fdmMemberTeams: TFDMemTable;
    fdmMemberTeamsid: TWideStringField;
    fdmMemberTeamsname: TWideStringField;
    dsMemberTeams: TBindSourceDB;
    fdmNotifications: TFDMemTable;
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
    dsNotifications: TBindSourceDB;
    fdmGeneric: TFDMemTable;
    cdsTeamid: TWideStringField;
    cdsTeamname: TWideStringField;
    cdsTeamcontent: TWideStringField;
    cdsTeamdate: TWideStringField;
    cdsTeamactive: TWideStringField;
    cdsTeamdate_added: TWideStringField;
    cdsTeamlast_modified: TWideStringField;
    cdsTeamimage: TWideStringField;
    cdsTeamowner: TWideStringField;
    cdsTeampublic: TWideStringField;
    cdsTeamsport_id: TWideStringField;
    reqTeamMembers: TRESTRequest;
    respTeamMembers: TRESTResponse;
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
    reqTeamEvents: TRESTRequest;
    respTeamEvents: TRESTResponse;
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
    reqTeamWall: TRESTRequest;
    respTeamWall: TRESTResponse;
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
  private
    { Private declarations }
    sSessionKey : String;
    sMemberSalt : String;
    sMemberType : String;
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
  end;

var
  dmdDataModule: TdmdDataModule;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TdmdDataModule }
const
  API_NAME = 'mobile';
  API_KEY  = 'eu47rh485u3485';
  API_COMBINED = 'eu47rh485u3485mobile';

function TdmdDataModule.checkLogin: Boolean;
var
  lJSONObject : TJSONObject;
  lJSONPair   : TJSONPair;
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
      end
      else
        result := false;
    finally
      lJSONObject.Free;
      lStatus.Free;
      lResult.Free;
    end;
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
  lJSONPair   : TJSONPair;
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
      lResult.Free;
      lStatus.Free;
    end;
end;

function TdmdDataModule.signature(method: String): String;
begin
  result := self.md5(API_NAME + API_KEY + method);
end;

end.
