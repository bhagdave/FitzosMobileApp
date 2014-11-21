object dmdEvent: TdmdEvent
  OldCreateOrder = False
  Height = 321
  Width = 883
  object restAPI: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    BaseURL = 'http://www.reach-your-peak.com/api'
    Params = <>
    HandleRedirects = True
    Left = 32
    Top = 16
  end
  object rdsaEvent: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmEvent
    FieldDefs = <>
    Response = respAllEventData
    RootElement = 'Result.event'
    Left = 96
    Top = 112
  end
  object fdmEvent: TFDMemTable
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
      end
      item
        Name = 'content'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'date'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'published'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'date_added'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'last_modified'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'image'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'type'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'sub_type'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'public'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'team_id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'time'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'member_id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'location'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'end_time'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'sport_id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'end_date'
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
        Name = 'isOwner'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'isAttendee'
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
    object fdmEventisOwner: TWideStringField
      FieldName = 'isOwner'
      Size = 255
    end
    object fdmEventisAttendee: TWideStringField
      FieldName = 'isAttendee'
      Size = 255
    end
  end
  object rdsaAttending: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmAttending
    FieldDefs = <>
    Response = respAllEventData
    RootElement = 'Result.attending'
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
  object rdsaWall: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmWall
    FieldDefs = <>
    Response = respAllEventData
    RootElement = 'Result.wall'
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
    AutoUpdate = False
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
    AutoUpdate = False
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
  object reqAllEventData: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'id'
        Value = '21'
      end
      item
        name = 'member_id'
        Value = '9'
      end>
    Resource = 'r/events/getAllEventData'
    Response = respAllEventData
    SynchronizedEvents = False
    Left = 104
    Top = 8
  end
  object respAllEventData: TRESTResponse
    ContentType = 'text/html'
    Left = 104
    Top = 64
  end
  object reqEventInvites: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'member_id'
        Value = '11'
      end>
    Resource = 'r/events/getMemberInvites'
    Response = respEventInvites
    SynchronizedEvents = False
    Left = 704
    Top = 48
  end
  object respEventInvites: TRESTResponse
    ContentType = 'text/html'
    Left = 704
    Top = 104
  end
  object rdsaEventInvites: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmEventInvites
    FieldDefs = <>
    Response = respEventInvites
    RootElement = 'Result'
    Left = 704
    Top = 168
  end
  object fdmEventInvites: TFDMemTable
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
        Name = 'status'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'invite_sent'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'name'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'content'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'date'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'published'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'date_added'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'last_modified'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'image'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'type'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'sub_type'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'public'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'team_id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'time'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'location'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'end_time'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'sport_id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'end_date'
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
    Left = 696
    Top = 232
    object fdmEventInvitesid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmEventInvitesevent_id: TWideStringField
      FieldName = 'event_id'
      Size = 255
    end
    object fdmEventInvitesmember_id: TWideStringField
      FieldName = 'member_id'
      Size = 255
    end
    object fdmEventInvitesstatus: TWideStringField
      FieldName = 'status'
      Size = 255
    end
    object fdmEventInvitesinvite_sent: TWideStringField
      FieldName = 'invite_sent'
      Size = 255
    end
    object fdmEventInvitesname: TWideStringField
      FieldName = 'name'
      Size = 255
    end
    object fdmEventInvitescontent: TWideStringField
      FieldName = 'content'
      Size = 255
    end
    object fdmEventInvitesdate: TWideStringField
      FieldName = 'date'
      Size = 255
    end
    object fdmEventInvitespublished: TWideStringField
      FieldName = 'published'
      Size = 255
    end
    object fdmEventInvitesdate_added: TWideStringField
      FieldName = 'date_added'
      Size = 255
    end
    object fdmEventInviteslast_modified: TWideStringField
      FieldName = 'last_modified'
      Size = 255
    end
    object fdmEventInvitesimage: TWideStringField
      FieldName = 'image'
      Size = 255
    end
    object fdmEventInvitestype: TWideStringField
      FieldName = 'type'
      Size = 255
    end
    object fdmEventInvitessub_type: TWideStringField
      FieldName = 'sub_type'
      Size = 255
    end
    object fdmEventInvitespublic: TWideStringField
      FieldName = 'public'
      Size = 255
    end
    object fdmEventInvitesteam_id: TWideStringField
      FieldName = 'team_id'
      Size = 255
    end
    object fdmEventInvitestime: TWideStringField
      FieldName = 'time'
      Size = 255
    end
    object fdmEventInviteslocation: TWideStringField
      FieldName = 'location'
      Size = 255
    end
    object fdmEventInvitesend_time: TWideStringField
      FieldName = 'end_time'
      Size = 255
    end
    object fdmEventInvitessport_id: TWideStringField
      FieldName = 'sport_id'
      Size = 255
    end
    object fdmEventInvitesend_date: TWideStringField
      FieldName = 'end_date'
      Size = 255
    end
  end
  object reqUpcomingEvents: TRESTRequest
    Client = restAPI
    Params = <>
    Resource = 'r/events/getUpcomingEvents'
    Response = respUpcomingEvents
    SynchronizedEvents = False
    Left = 784
    Top = 56
  end
  object respUpcomingEvents: TRESTResponse
    ContentType = 'text/html'
    Left = 792
    Top = 112
  end
  object rdsaUpcomingEvents: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmUpcomingEvents
    FieldDefs = <>
    Response = respUpcomingEvents
    RootElement = 'Result'
    Left = 792
    Top = 184
  end
  object fdmUpcomingEvents: TFDMemTable
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
      end
      item
        Name = 'sport'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'location'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'time'
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
    Left = 792
    Top = 248
    object fdmUpcomingEventsid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmUpcomingEventsname: TWideStringField
      FieldName = 'name'
      Size = 255
    end
    object fdmUpcomingEventssport: TWideStringField
      FieldName = 'sport'
      Size = 255
    end
    object fdmUpcomingEventslocation: TWideStringField
      FieldName = 'location'
      Size = 255
    end
    object fdmUpcomingEventstime: TWideStringField
      FieldName = 'time'
      Size = 255
    end
  end
end
