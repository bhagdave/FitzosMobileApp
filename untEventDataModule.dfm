object dmdEvent: TdmdEvent
  OldCreateOrder = False
  Height = 321
  Width = 834
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
  object reqWall: TRESTRequest
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
    Resource = 'events/getWall'
    Response = respWall
    SynchronizedEvents = False
    Left = 232
    Top = 24
  end
  object respWall: TRESTResponse
    ContentType = 'text/html'
    Left = 240
    Top = 80
  end
  object rdsaWall: TRESTResponseDataSetAdapter
    Active = True
    Dataset = fdmWall
    FieldDefs = <>
    Response = respWall
    RootElement = 'Result'
    Left = 240
    Top = 136
  end
  object fdmWall: TFDMemTable
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
        Name = 'message'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'image'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'date'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'deleted'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'member_id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'first_name'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'last_name'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'memberId'
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
    Left = 240
    Top = 192
    object fdmWallid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmWallevent_id: TWideStringField
      FieldName = 'event_id'
      Size = 255
    end
    object fdmWallmessage: TWideStringField
      FieldName = 'message'
      Size = 255
    end
    object fdmWallimage: TWideStringField
      FieldName = 'image'
      Size = 255
    end
    object fdmWalldate: TWideStringField
      FieldName = 'date'
      Size = 255
    end
    object fdmWalldeleted: TWideStringField
      FieldName = 'deleted'
      Size = 255
    end
    object fdmWallmember_id: TWideStringField
      FieldName = 'member_id'
      Size = 255
    end
    object fdmWallfirst_name: TWideStringField
      FieldName = 'first_name'
      Size = 255
    end
    object fdmWalllast_name: TWideStringField
      FieldName = 'last_name'
      Size = 255
    end
    object fdmWallmemberId: TWideStringField
      FieldName = 'memberId'
      Size = 255
    end
  end
  object fdmGeneric: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 308
    Top = 192
  end
  object rdsaGeneric: TRESTResponseDataSetAdapter
    Dataset = fdmGeneric
    FieldDefs = <>
    Response = respGeneric
    RootElement = 'Result'
    Left = 308
    Top = 136
  end
  object respGeneric: TRESTResponse
    Left = 308
    Top = 80
  end
  object reqGeneric: TRESTRequest
    Client = restAPI
    Params = <>
    Response = respGeneric
    SynchronizedEvents = False
    Left = 308
    Top = 25
  end
  object reqCreateEvent: TRESTRequest
    Client = restAPI
    Method = rmPOST
    Params = <>
    Resource = 'rest/events'
    Response = respCreateEvent
    SynchronizedEvents = False
    Left = 384
    Top = 32
  end
  object respCreateEvent: TRESTResponse
    Left = 384
    Top = 88
  end
  object reqTeams: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'id'
        Value = '9'
      end>
    Resource = 'teams/getMembersTeams'
    Response = respTeams
    SynchronizedEvents = False
    Left = 456
    Top = 32
  end
  object respTeams: TRESTResponse
    ContentType = 'text/html'
    Left = 456
    Top = 88
  end
  object rdsaTeams: TRESTResponseDataSetAdapter
    Active = True
    Dataset = fdmTeams
    FieldDefs = <>
    Response = respTeams
    RootElement = 'Result'
    Left = 456
    Top = 144
  end
  object fdmTeams: TFDMemTable
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
    Left = 456
    Top = 192
    object fdmTeamsid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmTeamsname: TWideStringField
      FieldName = 'name'
      Size = 255
    end
  end
  object reqSports: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'id'
        Value = '9'
      end>
    Resource = 'members/getSports'
    Response = respSports
    SynchronizedEvents = False
    Left = 528
    Top = 40
  end
  object respSports: TRESTResponse
    ContentType = 'text/html'
    Left = 528
    Top = 96
  end
  object rdsaSports: TRESTResponseDataSetAdapter
    Active = True
    Dataset = fdmSports
    FieldDefs = <>
    Response = respSports
    RootElement = 'Result'
    Left = 528
    Top = 152
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
    Left = 528
    Top = 200
    object fdmSportsid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmSportsname: TWideStringField
      FieldName = 'sport'
      Size = 255
    end
  end
  object dsTeams: TBindSourceDB
    DataSet = fdmTeams
    ScopeMappings = <>
    Left = 448
    Top = 248
  end
  object dsSports: TBindSourceDB
    DataSet = fdmSports
    ScopeMappings = <>
    Left = 528
    Top = 248
  end
  object reqUpdateEvent: TRESTRequest
    Client = restAPI
    Params = <>
    Resource = 'r/events/updateEvent'
    Response = respUpdateEvent
    SynchronizedEvents = False
    Left = 616
    Top = 56
  end
  object respUpdateEvent: TRESTResponse
    Left = 608
    Top = 112
  end
end
