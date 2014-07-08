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
    Params = <
      item
        name = 'key'
      end
      item
        name = 'signature'
      end
      item
        name = 'id'
        Value = '17'
      end>
    Resource = 'events/getMembersAttending'
    Response = respAttending
    SynchronizedEvents = False
    Left = 160
    Top = 24
  end
  object respAttending: TRESTResponse
    ContentType = 'text/html'
    Left = 160
    Top = 72
  end
  object rdsaAttending: TRESTResponseDataSetAdapter
    Active = True
    Dataset = fdmAttending
    FieldDefs = <>
    Response = respAttending
    RootElement = 'Result'
    Left = 160
    Top = 128
  end
  object fdmAttending: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'event_id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'member_id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'paid'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'cancelled'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'dob'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'gender'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'name'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'zip'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'country'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'language'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'nickname'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'height'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'weight'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'bmi'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'body_fat_percentage'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'units'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'activity'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'location'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'image'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'show_status'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'show_progress'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'find_trainer'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'show_tables'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'search'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'message'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'age'
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
    Left = 152
    Top = 176
    object fdmAttendingid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmAttendingevent_id: TWideStringField
      FieldName = 'event_id'
      Size = 255
    end
    object fdmAttendingmember_id: TWideStringField
      FieldName = 'member_id'
      Size = 255
    end
    object fdmAttendingpaid: TWideStringField
      FieldName = 'paid'
      Size = 255
    end
    object fdmAttendingcancelled: TWideStringField
      FieldName = 'cancelled'
      Size = 255
    end
    object fdmAttendingdob: TWideStringField
      FieldName = 'dob'
      Size = 255
    end
    object fdmAttendinggender: TWideStringField
      FieldName = 'gender'
      Size = 255
    end
    object fdmAttendingname: TWideStringField
      FieldName = 'name'
      Size = 255
    end
    object fdmAttendingzip: TWideStringField
      FieldName = 'zip'
      Size = 255
    end
    object fdmAttendingcountry: TWideStringField
      FieldName = 'country'
      Size = 255
    end
    object fdmAttendinglanguage: TWideStringField
      FieldName = 'language'
      Size = 255
    end
    object fdmAttendingnickname: TWideStringField
      FieldName = 'nickname'
      Size = 255
    end
    object fdmAttendingheight: TWideStringField
      FieldName = 'height'
      Size = 255
    end
    object fdmAttendingweight: TWideStringField
      FieldName = 'weight'
      Size = 255
    end
    object fdmAttendingbmi: TWideStringField
      FieldName = 'bmi'
      Size = 255
    end
    object fdmAttendingbody_fat_percentage: TWideStringField
      FieldName = 'body_fat_percentage'
      Size = 255
    end
    object fdmAttendingunits: TWideStringField
      FieldName = 'units'
      Size = 255
    end
    object fdmAttendingactivity: TWideStringField
      FieldName = 'activity'
      Size = 255
    end
    object fdmAttendinglocation: TWideStringField
      FieldName = 'location'
      Size = 255
    end
    object fdmAttendingimage: TWideStringField
      FieldName = 'image'
      Size = 255
    end
    object fdmAttendingshow_status: TWideStringField
      FieldName = 'show_status'
      Size = 255
    end
    object fdmAttendingshow_progress: TWideStringField
      FieldName = 'show_progress'
      Size = 255
    end
    object fdmAttendingfind_trainer: TWideStringField
      FieldName = 'find_trainer'
      Size = 255
    end
    object fdmAttendingshow_tables: TWideStringField
      FieldName = 'show_tables'
      Size = 255
    end
    object fdmAttendingsearch: TWideStringField
      FieldName = 'search'
      Size = 255
    end
    object fdmAttendingmessage: TWideStringField
      FieldName = 'message'
      Size = 255
    end
    object fdmAttendingage: TWideStringField
      FieldName = 'age'
      Size = 255
    end
  end
end
