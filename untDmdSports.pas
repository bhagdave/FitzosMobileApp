unit untDmdSports;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, REST.Client, REST.Response.Adapter,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.DBScope,
  Data.Bind.Components, Data.Bind.ObjectScope;

type
  TdmdSports = class(TDataModule)
    restAPI: TRESTClient;
    dsMemberSports: TBindSourceDB;
    fdmMemberSports: TFDMemTable;
    fdmMemberSportsid: TWideStringField;
    fdmMemberSportssport: TWideStringField;
    fdmMemberSportsfrom_date: TWideStringField;
    fdmMemberSportsto_date: TWideStringField;
    rdsaMemberSports: TRESTResponseDataSetAdapter;
    respMemberSports: TRESTResponse;
    reqMemberSports: TRESTRequest;
    dsSports: TBindSourceDB;
    fdmSports: TFDMemTable;
    fdmSportsid: TWideStringField;
    fdmSportsname: TWideStringField;
    rdsaSports: TRESTResponseDataSetAdapter;
    respSports: TRESTResponse;
    reqSports: TRESTRequest;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmdSports: TdmdSports;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
