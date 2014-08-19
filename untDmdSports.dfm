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
  object reqSportsStats: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'id'
        Value = '11'
      end
      item
        name = 'sport'
        Value = '26'
      end>
    Resource = 'r/athletes/getStatsForAthleteSport'
    Response = respSportsStats
    SynchronizedEvents = False
    Left = 232
    Top = 56
  end
  object respSportsStats: TRESTResponse
    ContentType = 'text/html'
    Left = 240
    Top = 128
  end
  object rdsaSportsStats: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmSportsStats
    FieldDefs = <>
    Response = respSportsStats
    RootElement = 'Result'
    Left = 248
    Top = 192
  end
  object fdmSportsStats: TFDMemTable
    Active = True
    OnCalcFields = fdmSportsStatsCalcFields
    FieldDefs = <
      item
        Name = 'statistic_name'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'statistic_value'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'date'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'formula'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'comment'
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
    Left = 256
    Top = 256
    object fdmSportsStatsstatistic_name: TWideStringField
      FieldName = 'statistic_name'
      Size = 255
    end
    object fdmSportsStatsstatistic_value: TWideStringField
      FieldName = 'statistic_value'
      Size = 255
    end
    object fdmSportsStatsdate: TWideStringField
      FieldName = 'date'
      Size = 255
    end
    object fdmSportsStatsformula: TWideStringField
      FieldName = 'formula'
      Size = 255
    end
    object fdmSportsStatscomment: TWideStringField
      FieldName = 'comment'
      Size = 255
    end
    object fdmSportsStatsstatistic_text: TStringField
      FieldKind = fkCalculated
      FieldName = 'statistic_text'
      Calculated = True
    end
  end
  object dsSportsStats: TBindSourceDB
    DataSet = fdmSportsStats
    ScopeMappings = <>
    Left = 256
    Top = 320
  end
  object reqStatsForSport: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'id'
        Value = '26'
      end>
    Resource = 'sports/getStatsForSport'
    Response = respStatsForSport
    SynchronizedEvents = False
    Left = 352
    Top = 72
  end
  object respStatsForSport: TRESTResponse
    ContentType = 'text/html'
    Left = 352
    Top = 128
  end
  object rdsaStatsForSports: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmStatsForSport
    FieldDefs = <>
    Response = respStatsForSport
    RootElement = 'Result'
    Left = 360
    Top = 192
  end
  object fdmStatsForSport: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'sport_id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'statistic_name'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'max_value'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'min_value'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'description'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'formula'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'position_id'
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
    Left = 360
    Top = 264
    object fdmStatsForSportid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmStatsForSportsport_id: TWideStringField
      FieldName = 'sport_id'
      Size = 255
    end
    object fdmStatsForSportstatistic_name: TWideStringField
      FieldName = 'statistic_name'
      Size = 255
    end
    object fdmStatsForSportmax_value: TWideStringField
      FieldName = 'max_value'
      Size = 255
    end
    object fdmStatsForSportmin_value: TWideStringField
      FieldName = 'min_value'
      Size = 255
    end
    object fdmStatsForSportdescription: TWideStringField
      FieldName = 'description'
      Size = 255
    end
    object fdmStatsForSportformula: TWideStringField
      FieldName = 'formula'
      Size = 255
    end
    object fdmStatsForSportposition_id: TWideStringField
      FieldName = 'position_id'
      Size = 255
    end
  end
end
