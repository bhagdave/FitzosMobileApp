object dmdDataModule: TdmdDataModule
  OldCreateOrder = False
  Height = 420
  Width = 560
  object restAPI: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    BaseURL = 'http://beta.fitzos.com/api'
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
      end
      item
        name = 'key'
      end>
    Resource = 'openSession'
    Response = respOpenSession
    SynchronizedEvents = False
    Left = 32
    Top = 72
  end
  object respOpenSession: TRESTResponse
    RootElement = 'Result'
    Left = 32
    Top = 128
  end
  object reqLogin: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'signature'
      end
      item
        name = 'username'
      end
      item
        name = 'password'
      end
      item
        name = 'key'
      end>
    Resource = 'login'
    Response = respLogin
    SynchronizedEvents = False
    Left = 120
    Top = 72
  end
  object respLogin: TRESTResponse
    RootElement = 'Status'
    Left = 120
    Top = 128
  end
  object reqNotifications: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'signature'
      end
      item
        name = 'key'
      end
      item
        name = 'id'
      end>
    Resource = 'index/notifications/getMemberNotifications'
    Response = respNotifications
    SynchronizedEvents = False
    Left = 200
    Top = 72
  end
  object respNotifications: TRESTResponse
    Left = 200
    Top = 128
  end
  object rdsaNotifications: TRESTResponseDataSetAdapter
    Dataset = tblNotifications
    FieldDefs = <>
    Response = respNotifications
    Left = 200
    Top = 184
  end
  object tblNotifications: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 192
    Top = 240
  end
end
