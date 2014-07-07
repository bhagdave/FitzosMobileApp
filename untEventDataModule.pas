unit untEventDataModule;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter;

type
  TdmdEvent = class(TDataModule)
    restAPI: TRESTClient;
    reqEvent: TRESTRequest;
    respEvent: TRESTResponse;
    rdsaEvent: TRESTResponseDataSetAdapter;
    fdmEvent: TFDMemTable;
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
    reqAttending: TRESTRequest;
    respAttending: TRESTResponse;
    rdsaAttending: TRESTResponseDataSetAdapter;
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
