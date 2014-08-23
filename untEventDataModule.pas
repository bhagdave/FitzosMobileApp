unit untEventDataModule;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, Data.Bind.DBScope;

type
  TdmdEvent = class(TDataModule)
    restAPI: TRESTClient;
    rdsaEvent: TRESTResponseDataSetAdapter;
    fdmEvent: TFDMemTable;
    rdsaAttending: TRESTResponseDataSetAdapter;
    fdmAttending: TFDMemTable;
    fdmAttendingid: TWideStringField;
    fdmAttendingevent_id: TWideStringField;
    fdmAttendingmember_id: TWideStringField;
    fdmAttendingpaid: TWideStringField;
    fdmAttendingcancelled: TWideStringField;
    fdmAttendingdob: TWideStringField;
    fdmAttendinggender: TWideStringField;
    fdmAttendingname: TWideStringField;
    fdmAttendingzip: TWideStringField;
    fdmAttendingcountry: TWideStringField;
    fdmAttendinglanguage: TWideStringField;
    fdmAttendingnickname: TWideStringField;
    fdmAttendingheight: TWideStringField;
    fdmAttendingweight: TWideStringField;
    fdmAttendingbmi: TWideStringField;
    fdmAttendingbody_fat_percentage: TWideStringField;
    fdmAttendingunits: TWideStringField;
    fdmAttendingactivity: TWideStringField;
    fdmAttendinglocation: TWideStringField;
    fdmAttendingimage: TWideStringField;
    fdmAttendingshow_status: TWideStringField;
    fdmAttendingshow_progress: TWideStringField;
    fdmAttendingfind_trainer: TWideStringField;
    fdmAttendingshow_tables: TWideStringField;
    fdmAttendingsearch: TWideStringField;
    fdmAttendingmessage: TWideStringField;
    fdmAttendingage: TWideStringField;
    rdsaWall: TRESTResponseDataSetAdapter;
    fdmWall: TFDMemTable;
    fdmWallid: TWideStringField;
    fdmWallevent_id: TWideStringField;
    fdmWallmessage: TWideStringField;
    fdmWallimage: TWideStringField;
    fdmWalldate: TWideStringField;
    fdmWalldeleted: TWideStringField;
    fdmWallmember_id: TWideStringField;
    fdmWallfirst_name: TWideStringField;
    fdmWalllast_name: TWideStringField;
    fdmWallmemberId: TWideStringField;
    fdmGeneric: TFDMemTable;
    rdsaGeneric: TRESTResponseDataSetAdapter;
    respGeneric: TRESTResponse;
    reqGeneric: TRESTRequest;
    reqCreateEvent: TRESTRequest;
    respCreateEvent: TRESTResponse;
    reqTeams: TRESTRequest;
    respTeams: TRESTResponse;
    rdsaTeams: TRESTResponseDataSetAdapter;
    fdmTeams: TFDMemTable;
    fdmTeamsid: TWideStringField;
    fdmTeamsname: TWideStringField;
    reqSports: TRESTRequest;
    respSports: TRESTResponse;
    rdsaSports: TRESTResponseDataSetAdapter;
    fdmSports: TFDMemTable;
    fdmSportsid: TWideStringField;
    fdmSportsname: TWideStringField;
    dsTeams: TBindSourceDB;
    dsSports: TBindSourceDB;
    reqUpdateEvent: TRESTRequest;
    respUpdateEvent: TRESTResponse;
    reqAllEventData: TRESTRequest;
    respAllEventData: TRESTResponse;
    fdmEventid: TWideStringField;
    fdmEventname: TWideStringField;
    fdmEventcontent: TWideStringField;
    fdmEventdate: TWideStringField;
    fdmEventpublished: TWideStringField;
    fdmEventdate_added: TWideStringField;
    fdmEventlast_modified: TWideStringField;
    fdmEventimage: TWideStringField;
    fdmEventtype: TWideStringField;
    fdmEventsub_type: TWideStringField;
    fdmEventpublic: TWideStringField;
    fdmEventteam_id: TWideStringField;
    fdmEventtime: TWideStringField;
    fdmEventmember_id: TWideStringField;
    fdmEventlocation: TWideStringField;
    fdmEventend_time: TWideStringField;
    fdmEventsport_id: TWideStringField;
    fdmEventend_date: TWideStringField;
    fdmEventfirst_name: TWideStringField;
    fdmEventlast_name: TWideStringField;
    fdmEventisOwner: TWideStringField;
    fdmEventisAttendee: TWideStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmdEvent: TdmdEvent;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
