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
    reqSportsStats: TRESTRequest;
    respSportsStats: TRESTResponse;
    rdsaSportsStats: TRESTResponseDataSetAdapter;
    fdmSportsStats: TFDMemTable;
    fdmSportsStatsstatistic_name: TWideStringField;
    fdmSportsStatsstatistic_value: TWideStringField;
    fdmSportsStatsdate: TWideStringField;
    fdmSportsStatsformula: TWideStringField;
    fdmSportsStatscomment: TWideStringField;
    fdmSportsStatsstatistic_text: TStringField;
    dsSportsStats: TBindSourceDB;
    reqStatsForSport: TRESTRequest;
    respStatsForSport: TRESTResponse;
    rdsaStatsForSports: TRESTResponseDataSetAdapter;
    fdmStatsForSport: TFDMemTable;
    fdmStatsForSportid: TWideStringField;
    fdmStatsForSportsport_id: TWideStringField;
    fdmStatsForSportstatistic_name: TWideStringField;
    fdmStatsForSportmax_value: TWideStringField;
    fdmStatsForSportmin_value: TWideStringField;
    fdmStatsForSportdescription: TWideStringField;
    fdmStatsForSportformula: TWideStringField;
    fdmStatsForSportposition_id: TWideStringField;
    dsStatsForSport: TBindSourceDB;
    reqAddStat: TRESTRequest;
    respAddStat: TRESTResponse;
    procedure fdmSportsStatsCalcFields(DataSet: TDataSet);
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

procedure TdmdSports.fdmSportsStatsCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('statistic_text').AsString := DataSet.FieldByName('statistic_name').AsString + ' ' + dataset.FieldByName('statistic_value').AsString;
end;

end.
