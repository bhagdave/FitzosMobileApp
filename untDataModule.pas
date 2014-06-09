unit untDataModule;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope;

type
  TdmdDataModule = class(TDataModule)
    restAPI: TRESTClient;
    reqOpenSession: TRESTRequest;
    respOpenSession: TRESTResponse;
  private
    { Private declarations }
    sSessionKey : String;
  public
    { Public declarations }
    function openSession : Boolean;
    property sessionKey : String  read sSessionKey;
  end;

var
  dmdDataModule: TdmdDataModule;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TdmdDataModule }


function TdmdDataModule.openSession: Boolean;
begin
    reqOpenSession.Execute;
    sSessionKey := respOpenSession.Content;
    openSession := true;
end;

end.
