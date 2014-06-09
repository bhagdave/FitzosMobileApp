object dmdDataModule: TdmdDataModule
  OldCreateOrder = False
  Height = 420
  Width = 560
  object restAPI: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    BaseURL = 'http://local.fitzos/api'
    ContentType = 'application/x-www-form-urlencoded'
    Params = <>
    HandleRedirects = True
    Left = 32
    Top = 16
  end
  object reqOpenSession: TRESTRequest
    Client = restAPI
    Method = rmPOST
    Params = <
      item
        name = 'name'
        Value = 'mobile'
      end
      item
        name = 'key'
        Value = 'eu47rh485u3485'
      end>
    Resource = 'openSession'
    Response = respOpenSession
    SynchronizedEvents = False
    Left = 32
    Top = 72
  end
  object respOpenSession: TRESTResponse
    ContentType = 'text/html'
    RootElement = 'Result'
    Left = 32
    Top = 128
  end
end
