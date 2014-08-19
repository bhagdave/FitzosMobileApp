object dmdSports: TdmdSports
  OldCreateOrder = False
  Height = 420
  Width = 653
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
  object dsMemberSports: TBindSourceDB
    DataSet = fdmMemberSports
    ScopeMappings = <>
    Left = 40
    Top = 308
  end
  object fdmMemberSports: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'sport'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'from_date'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'to_date'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 48
    Top = 260
    object fdmMemberSportsid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmMemberSportssport: TWideStringField
      FieldName = 'sport'
      Size = 255
    end
    object fdmMemberSportsfrom_date: TWideStringField
      FieldName = 'from_date'
      Size = 255
    end
    object fdmMemberSportsto_date: TWideStringField
      FieldName = 'to_date'
      Size = 255
    end
  end
  object rdsaMemberSports: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmMemberSports
    FieldDefs = <>
    Response = respMemberSports
    RootElement = 'Result'
    Left = 40
    Top = 204
  end
  object respMemberSports: TRESTResponse
    Left = 32
    Top = 148
  end
  object reqMemberSports: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'id'
        Value = '9'
      end
      item
        name = 'signature'
      end
      item
        name = 'key'
      end>
    Resource = 'members/getSports'
    Response = respMemberSports
    SynchronizedEvents = False
    Left = 32
    Top = 72
  end
  object dsSports: TBindSourceDB
    DataSet = fdmSports
    ScopeMappings = <>
    Left = 141
    Top = 308
  end
  object fdmSports: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'name'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 141
    Top = 252
    object fdmSportsid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmSportsname: TWideStringField
      FieldName = 'name'
      Size = 255
    end
  end
  object rdsaSports: TRESTResponseDataSetAdapter
    Active = True
    Dataset = fdmSports
    FieldDefs = <>
    Response = respSports
    RootElement = 'Result'
    Left = 133
    Top = 196
  end
  object respSports: TRESTResponse
    ContentType = 'text/html'
    Left = 125
    Top = 132
  end
  object reqSports: TRESTRequest
    Client = restAPI
    Params = <>
    Resource = 'rest/sports'
    Response = respSports
    SynchronizedEvents = False
    Left = 125
    Top = 68
  end
end
