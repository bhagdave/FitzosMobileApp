unit untDmdSignup;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope;

type
  TdmdSignup = class(TDataModule)
    restAPI: TRESTClient;
    reqCheckExists: TRESTRequest;
    respCheckExists: TRESTResponse;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
