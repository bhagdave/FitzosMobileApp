object dmdEvent: TdmdEvent
  OldCreateOrder = False
  Height = 284
  Width = 404
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
  object reqEvent: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'id'
        Value = '17'
      end
      item
        name = 'signature'
      end
      item
        name = 'key'
      end>
    Resource = 'events/getEvent'
    Response = respEvent
    SynchronizedEvents = False
    Left = 96
    Top = 16
  end
  object respEvent: TRESTResponse
    Left = 96
    Top = 64
  end
  object rdsaEvent: TRESTResponseDataSetAdapter
    Dataset = fdmEvent
    FieldDefs = <>
    Response = respEvent
    RootElement = 'Result'
    Left = 96
    Top = 112
  end
  object fdmEvent: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 88
    Top = 160
    object fdmEventid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmEventname: TWideStringField
      FieldName = 'name'
      Size = 255
    end
    object fdmEventcontent: TWideStringField
      FieldName = 'content'
      Size = 255
    end
    object fdmEventdate: TWideStringField
      FieldName = 'date'
      Size = 255
    end
    object fdmEventpublished: TWideStringField
      FieldName = 'published'
      Size = 255
    end
    object fdmEventdate_added: TWideStringField
      FieldName = 'date_added'
      Size = 255
    end
    object fdmEventlast_modified: TWideStringField
      FieldName = 'last_modified'
      Size = 255
    end
    object fdmEventimage: TWideStringField
      FieldName = 'image'
      Size = 255
    end
    object fdmEventtype: TWideStringField
      FieldName = 'type'
      Size = 255
    end
    object fdmEventsub_type: TWideStringField
      FieldName = 'sub_type'
      Size = 255
    end
    object fdmEventpublic: TWideStringField
      FieldName = 'public'
      Size = 255
    end
    object fdmEventteam_id: TWideStringField
      FieldName = 'team_id'
      Size = 255
    end
    object fdmEventtime: TWideStringField
      FieldName = 'time'
      Size = 255
    end
    object fdmEventmember_id: TWideStringField
      FieldName = 'member_id'
      Size = 255
    end
    object fdmEventlocation: TWideStringField
      FieldName = 'location'
      Size = 255
    end
    object fdmEventend_time: TWideStringField
      FieldName = 'end_time'
      Size = 255
    end
    object fdmEventsport_id: TWideStringField
      FieldName = 'sport_id'
      Size = 255
    end
    object fdmEventend_date: TWideStringField
      FieldName = 'end_date'
      Size = 255
    end
    object fdmEventfirst_name: TWideStringField
      FieldName = 'first_name'
      Size = 255
    end
    object fdmEventlast_name: TWideStringField
      FieldName = 'last_name'
      Size = 255
    end
  end
  object reqAttending: TRESTRequest
    Client = restAPI
    Params = <>
    Response = respEvent
    SynchronizedEvents = False
    Left = 160
    Top = 24
  end
  object respAttending: TRESTResponse
    Left = 160
    Top = 72
  end
  object rdsaAttending: TRESTResponseDataSetAdapter
    FieldDefs = <>
    Left = 160
    Top = 128
  end
end
