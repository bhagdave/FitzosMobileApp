object dmdDataModule: TdmdDataModule
  OldCreateOrder = False
  Height = 807
  Width = 1021
  object restAPI: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    BaseURL = 'http://www.reach-your-peak.com/api'
    Params = <
      item
        Kind = pkHTTPHEADER
        name = 'Cache-Control'
        Value = 'no-cache'
      end>
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
    Left = 96
    Top = 72
  end
  object respLogin: TRESTResponse
    RootElement = 'Status'
    Left = 104
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
        Value = '9'
      end>
    Resource = 'notifications/getMemberNotifications'
    Response = respNotifications
    SynchronizedEvents = False
    OnHTTPProtocolError = reqNotificationsHTTPProtocolError
    Left = 176
    Top = 72
  end
  object respNotifications: TRESTResponse
    ContentType = 'text/html'
    Left = 176
    Top = 128
  end
  object rdsaNotifications: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmNotifications
    FieldDefs = <>
    Response = respNotifications
    RootElement = 'Result'
    Left = 176
    Top = 184
  end
  object reqMember: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'id'
        Value = '9'
      end
      item
        name = 'key'
      end
      item
        name = 'signature'
      end>
    Resource = 'members/getMember'
    Response = respMember
    SynchronizedEvents = False
    Left = 248
    Top = 72
  end
  object respMember: TRESTResponse
    ContentType = 'text/html'
    Left = 248
    Top = 128
  end
  object rdsaMember: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmMember
    FieldDefs = <>
    Response = respMember
    RootElement = 'Result'
    Left = 256
    Top = 176
  end
  object reqGeneric: TRESTRequest
    Client = restAPI
    Params = <>
    Response = respGeneric
    SynchronizedEvents = False
    Left = 320
    Top = 73
  end
  object respGeneric: TRESTResponse
    Left = 320
    Top = 120
  end
  object rdsaGeneric: TRESTResponseDataSetAdapter
    AutoUpdate = False
    Dataset = fdmGeneric
    FieldDefs = <>
    Response = respGeneric
    RootElement = 'Result'
    Left = 320
    Top = 168
  end
  object rdsaTeam: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmTeam
    FieldDefs = <>
    Response = respAllTeamData
    RootElement = 'Result.team'
    Left = 56
    Top = 488
  end
  object reqMemberTeams: TRESTRequest
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
    Resource = 'teams/getMembersTeams'
    Response = respMemberTeams
    SynchronizedEvents = False
    Left = 392
    Top = 73
  end
  object respMemberTeams: TRESTResponse
    ContentType = 'text/html'
    Left = 400
    Top = 120
  end
  object rdsaMemberTeams: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmMemberTeams
    FieldDefs = <>
    Response = respMemberTeams
    RootElement = 'Result'
    Left = 400
    Top = 168
  end
  object fdmMemberTeams: TFDMemTable
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
    Left = 400
    Top = 224
    object fdmMemberTeamsid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmMemberTeamsname: TWideStringField
      FieldName = 'name'
      Size = 255
    end
  end
  object dsMemberTeams: TBindSourceDB
    DataSet = fdmMemberTeams
    ScopeMappings = <>
    Left = 400
    Top = 272
  end
  object fdmNotifications: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'from_table'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'from_key'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'to_table'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'to_key'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'notification'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'parent_id'
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
        Name = 'image'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'read'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'type'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'From'
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
    Left = 176
    Top = 232
    object fdmNotificationsid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmNotificationsfrom_table: TWideStringField
      FieldName = 'from_table'
      Size = 255
    end
    object fdmNotificationsfrom_key: TWideStringField
      FieldName = 'from_key'
      Size = 255
    end
    object fdmNotificationsto_table: TWideStringField
      FieldName = 'to_table'
      Size = 255
    end
    object fdmNotificationsto_key: TWideStringField
      FieldName = 'to_key'
      Size = 255
    end
    object fdmNotificationsnotification: TWideStringField
      FieldName = 'notification'
      Size = 255
    end
    object fdmNotificationsparent_id: TWideStringField
      FieldName = 'parent_id'
      Size = 255
    end
    object fdmNotificationspublished: TWideStringField
      FieldName = 'published'
      Size = 255
    end
    object fdmNotificationsdate_added: TWideStringField
      FieldName = 'date_added'
      Size = 255
    end
    object fdmNotificationsimage: TWideStringField
      FieldName = 'image'
      Size = 255
    end
    object fdmNotificationsread: TWideStringField
      FieldName = 'read'
      Size = 255
    end
    object fdmNotificationstype: TWideStringField
      FieldName = 'type'
      Size = 255
    end
    object fdmNotificationsFrom: TWideStringField
      FieldName = 'From'
      Size = 255
    end
  end
  object dsNotifications: TBindSourceDB
    DataSet = fdmNotifications
    ScopeMappings = <>
    Left = 200
    Top = 312
  end
  object fdmGeneric: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 320
    Top = 216
  end
  object rdsaTeamMembers: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmTeamMembers
    FieldDefs = <>
    Response = respAllTeamData
    RootElement = 'Result.members'
    Left = 136
    Top = 480
  end
  object fdmTeamMembers: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'member_id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'team_id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'status'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'requested_date'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'invited_date'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'approved_date'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'removed_date'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'left_date'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'active'
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
        Name = 'language'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'salt'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'email'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'password'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'image'
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
    Left = 136
    Top = 544
    object fdmTeamMembersid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmTeamMembersmember_id: TWideStringField
      FieldName = 'member_id'
      Size = 255
    end
    object fdmTeamMembersteam_id: TWideStringField
      FieldName = 'team_id'
      Size = 255
    end
    object fdmTeamMembersstatus: TWideStringField
      FieldName = 'status'
      Size = 255
    end
    object fdmTeamMembersrequested_date: TWideStringField
      FieldName = 'requested_date'
      Size = 255
    end
    object fdmTeamMembersinvited_date: TWideStringField
      FieldName = 'invited_date'
      Size = 255
    end
    object fdmTeamMembersapproved_date: TWideStringField
      FieldName = 'approved_date'
      Size = 255
    end
    object fdmTeamMembersremoved_date: TWideStringField
      FieldName = 'removed_date'
      Size = 255
    end
    object fdmTeamMembersleft_date: TWideStringField
      FieldName = 'left_date'
      Size = 255
    end
    object fdmTeamMembersactive: TWideStringField
      FieldName = 'active'
      Size = 255
    end
    object fdmTeamMembersfirst_name: TWideStringField
      FieldName = 'first_name'
      Size = 255
    end
    object fdmTeamMemberslast_name: TWideStringField
      FieldName = 'last_name'
      Size = 255
    end
    object fdmTeamMemberslanguage: TWideStringField
      FieldName = 'language'
      Size = 255
    end
    object fdmTeamMemberssalt: TWideStringField
      FieldName = 'salt'
      Size = 255
    end
    object fdmTeamMembersemail: TWideStringField
      FieldName = 'email'
      Size = 255
    end
    object fdmTeamMemberspassword: TWideStringField
      FieldName = 'password'
      Size = 255
    end
    object fdmTeamMembersimage: TWideStringField
      FieldName = 'image'
      Size = 255
    end
  end
  object dsTeamMembers: TBindSourceDB
    DataSet = fdmTeamMembers
    ScopeMappings = <>
    Left = 144
    Top = 592
  end
  object rdsaTeamEvents: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmTeamEvents
    FieldDefs = <>
    Response = respAllTeamData
    RootElement = 'Result.events'
    Left = 224
    Top = 480
  end
  object fdmTeamEvents: TFDMemTable
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
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 216
    Top = 544
    object fdmTeamEventsid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmTeamEventsname: TWideStringField
      FieldName = 'name'
      Size = 255
    end
    object fdmTeamEventscontent: TWideStringField
      FieldName = 'content'
      Size = 255
    end
    object fdmTeamEventsdate: TWideStringField
      FieldName = 'date'
      Size = 255
    end
    object fdmTeamEventspublished: TWideStringField
      FieldName = 'published'
      Size = 255
    end
    object fdmTeamEventsdate_added: TWideStringField
      FieldName = 'date_added'
      Size = 255
    end
    object fdmTeamEventslast_modified: TWideStringField
      FieldName = 'last_modified'
      Size = 255
    end
    object fdmTeamEventsimage: TWideStringField
      FieldName = 'image'
      Size = 255
    end
    object fdmTeamEventstype: TWideStringField
      FieldName = 'type'
      Size = 255
    end
    object fdmTeamEventssub_type: TWideStringField
      FieldName = 'sub_type'
      Size = 255
    end
    object fdmTeamEventspublic: TWideStringField
      FieldName = 'public'
      Size = 255
    end
    object fdmTeamEventsteam_id: TWideStringField
      FieldName = 'team_id'
      Size = 255
    end
    object fdmTeamEventstime: TWideStringField
      FieldName = 'time'
      Size = 255
    end
    object fdmTeamEventsmember_id: TWideStringField
      FieldName = 'member_id'
      Size = 255
    end
    object fdmTeamEventslocation: TWideStringField
      FieldName = 'location'
      Size = 255
    end
    object fdmTeamEventsend_time: TWideStringField
      FieldName = 'end_time'
      Size = 255
    end
    object fdmTeamEventssport_id: TWideStringField
      FieldName = 'sport_id'
      Size = 255
    end
    object fdmTeamEventsend_date: TWideStringField
      FieldName = 'end_date'
      Size = 255
    end
  end
  object dsTeamEvents: TBindSourceDB
    DataSet = fdmTeamEvents
    ScopeMappings = <>
    Left = 216
    Top = 592
  end
  object rdsaTeamWall: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmTeamWall
    FieldDefs = <>
    Response = respAllTeamData
    RootElement = 'Result.wall'
    Left = 312
    Top = 480
  end
  object fdmTeamWall: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'team_id'
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
    Left = 312
    Top = 528
    object fdmTeamWallid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmTeamWallteam_id: TWideStringField
      FieldName = 'team_id'
      Size = 255
    end
    object fdmTeamWallmessage: TWideStringField
      FieldName = 'message'
      Size = 255
    end
    object fdmTeamWallimage: TWideStringField
      FieldName = 'image'
      Size = 255
    end
    object fdmTeamWalldate: TWideStringField
      FieldName = 'date'
      Size = 255
    end
    object fdmTeamWalldeleted: TWideStringField
      FieldName = 'deleted'
      Size = 255
    end
    object fdmTeamWallmember_id: TWideStringField
      FieldName = 'member_id'
      Size = 255
    end
    object fdmTeamWallfirst_name: TWideStringField
      FieldName = 'first_name'
      Size = 255
    end
    object fdmTeamWalllast_name: TWideStringField
      FieldName = 'last_name'
      Size = 255
    end
    object fdmTeamWallmemberId: TWideStringField
      FieldName = 'memberId'
      Size = 255
    end
  end
  object dsTeamWall: TBindSourceDB
    DataSet = fdmTeamWall
    ScopeMappings = <>
    Left = 312
    Top = 584
  end
  object fdmMember: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'active'
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
        Name = 'language'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'salt'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'email'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'image'
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
    Top = 224
    object fdmMemberid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmMemberactive: TWideStringField
      FieldName = 'active'
      Size = 255
    end
    object fdmMemberfirst_name: TWideStringField
      FieldName = 'first_name'
      Size = 255
    end
    object fdmMemberlast_name: TWideStringField
      FieldName = 'last_name'
      Size = 255
    end
    object fdmMemberlanguage: TWideStringField
      FieldName = 'language'
      Size = 255
    end
    object fdmMembersalt: TWideStringField
      FieldName = 'salt'
      Size = 255
    end
    object fdmMemberemail: TWideStringField
      FieldName = 'email'
      Size = 255
    end
    object fdmMemberimage: TWideStringField
      FieldName = 'image'
      Size = 255
    end
  end
  object fdmTeam: TFDMemTable
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
        Name = 'active'
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
        Name = 'owner'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'public'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'sport_id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'isOwner'
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
    Top = 536
    object fdmTeamid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmTeamname: TWideStringField
      FieldName = 'name'
      Size = 255
    end
    object fdmTeamcontent: TWideStringField
      FieldName = 'content'
      Size = 255
    end
    object fdmTeamdate: TWideStringField
      FieldName = 'date'
      Size = 255
    end
    object fdmTeamactive: TWideStringField
      FieldName = 'active'
      Size = 255
    end
    object fdmTeamdate_added: TWideStringField
      FieldName = 'date_added'
      Size = 255
    end
    object fdmTeamlast_modified: TWideStringField
      FieldName = 'last_modified'
      Size = 255
    end
    object fdmTeamimage: TWideStringField
      FieldName = 'image'
      Size = 255
    end
    object fdmTeamowner: TWideStringField
      FieldName = 'owner'
      Size = 255
    end
    object fdmTeampublic: TWideStringField
      FieldName = 'public'
      Size = 255
    end
    object fdmTeamsport_id: TWideStringField
      FieldName = 'sport_id'
      Size = 255
    end
    object fdmTeamisOwner: TWideStringField
      FieldName = 'isOwner'
      Size = 255
    end
  end
  object dsTeam: TBindSourceDB
    DataSet = fdmTeam
    ScopeMappings = <>
    Left = 48
    Top = 584
  end
  object reqFriends: TRESTRequest
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
    Resource = 'members/getFriends'
    Response = respFriends
    SynchronizedEvents = False
    Left = 384
    Top = 360
  end
  object respFriends: TRESTResponse
    ContentType = 'text/html'
    Left = 384
    Top = 416
  end
  object rdsaFriends: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmFriends
    FieldDefs = <>
    Response = respFriends
    RootElement = 'Result'
    Left = 392
    Top = 464
  end
  object fdmFriends: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'active'
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
        Name = 'language'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'salt'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'email'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'password'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'image'
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
    Left = 384
    Top = 512
    object fdmFriendsid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmFriendsactive: TWideStringField
      FieldName = 'active'
      Size = 255
    end
    object fdmFriendsfirst_name: TWideStringField
      FieldName = 'first_name'
      Size = 255
    end
    object fdmFriendslast_name: TWideStringField
      FieldName = 'last_name'
      Size = 255
    end
    object fdmFriendslanguage: TWideStringField
      FieldName = 'language'
      Size = 255
    end
    object fdmFriendssalt: TWideStringField
      FieldName = 'salt'
      Size = 255
    end
    object fdmFriendsemail: TWideStringField
      FieldName = 'email'
      Size = 255
    end
    object fdmFriendspassword: TWideStringField
      FieldName = 'password'
      Size = 255
    end
    object fdmFriendsimage: TWideStringField
      FieldName = 'image'
      Size = 255
    end
  end
  object dsFriends: TBindSourceDB
    DataSet = fdmFriends
    ScopeMappings = <>
    Left = 384
    Top = 560
  end
  object reqEvents: TRESTRequest
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
    Resource = 'events/getEventsForMember'
    Response = respEvents
    SynchronizedEvents = False
    Left = 952
    Top = 80
  end
  object respEvents: TRESTResponse
    ContentType = 'text/html'
    Left = 952
    Top = 128
  end
  object rdsaEvents: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmEvents
    FieldDefs = <>
    Response = respEvents
    RootElement = 'Result'
    Left = 952
    Top = 184
  end
  object fdmEvents: TFDMemTable
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
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 952
    Top = 232
    object fdmEventsid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmEventsname: TWideStringField
      FieldName = 'name'
      Size = 255
    end
    object fdmEventscontent: TWideStringField
      FieldName = 'content'
      Size = 255
    end
    object fdmEventsdate: TWideStringField
      FieldName = 'date'
      Size = 255
    end
    object fdmEventspublished: TWideStringField
      FieldName = 'published'
      Size = 255
    end
    object fdmEventsdate_added: TWideStringField
      FieldName = 'date_added'
      Size = 255
    end
    object fdmEventslast_modified: TWideStringField
      FieldName = 'last_modified'
      Size = 255
    end
    object fdmEventsimage: TWideStringField
      FieldName = 'image'
      Size = 255
    end
    object fdmEventstype: TWideStringField
      FieldName = 'type'
      Size = 255
    end
    object fdmEventssub_type: TWideStringField
      FieldName = 'sub_type'
      Size = 255
    end
    object fdmEventspublic: TWideStringField
      FieldName = 'public'
      Size = 255
    end
    object fdmEventsteam_id: TWideStringField
      FieldName = 'team_id'
      Size = 255
    end
    object fdmEventstime: TWideStringField
      FieldName = 'time'
      Size = 255
    end
    object fdmEventsmember_id: TWideStringField
      FieldName = 'member_id'
      Size = 255
    end
    object fdmEventslocation: TWideStringField
      FieldName = 'location'
      Size = 255
    end
    object fdmEventsend_time: TWideStringField
      FieldName = 'end_time'
      Size = 255
    end
    object fdmEventssport_id: TWideStringField
      FieldName = 'sport_id'
      Size = 255
    end
    object fdmEventsend_date: TWideStringField
      FieldName = 'end_date'
      Size = 255
    end
  end
  object dsEvents: TBindSourceDB
    DataSet = fdmEvents
    ScopeMappings = <>
    Left = 944
    Top = 280
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
    Left = 848
    Top = 72
  end
  object respMemberSports: TRESTResponse
    ContentType = 'text/html'
    Left = 856
    Top = 128
  end
  object rdsaMemberSports: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmMemberSports
    FieldDefs = <>
    Response = respMemberSports
    RootElement = 'Result'
    Left = 856
    Top = 184
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
    Left = 856
    Top = 240
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
  object reqCreateTeam: TRESTRequest
    Client = restAPI
    Method = rmPOST
    Params = <>
    Resource = 'rest/teams'
    Response = respCreateTeam
    SynchronizedEvents = False
    Left = 680
    Top = 80
  end
  object respCreateTeam: TRESTResponse
    Left = 680
    Top = 136
  end
  object dsMemberSports: TBindSourceDB
    DataSet = fdmMemberSports
    ScopeMappings = <>
    Left = 856
    Top = 288
  end
  object reqProfile: TRESTRequest
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
    Resource = 'athletes/getAthlete'
    Response = respProfile
    SynchronizedEvents = False
    Left = 480
    Top = 72
  end
  object respProfile: TRESTResponse
    ContentType = 'text/html'
    Left = 488
    Top = 120
  end
  object rdsaProfile: TRESTResponseDataSetAdapter
    Active = True
    Dataset = fdmProfile
    FieldDefs = <>
    Response = respProfile
    RootElement = 'Result'
    Left = 488
    Top = 168
  end
  object fdmProfile: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
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
        Name = 'member_id'
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
    Left = 488
    Top = 216
    object fdmProfileid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmProfiledob: TWideStringField
      FieldName = 'dob'
      Size = 255
    end
    object fdmProfilegender: TWideStringField
      FieldName = 'gender'
      Size = 255
    end
    object fdmProfilename: TWideStringField
      FieldName = 'name'
      Size = 255
    end
    object fdmProfilezip: TWideStringField
      FieldName = 'zip'
      Size = 255
    end
    object fdmProfilecountry: TWideStringField
      FieldName = 'country'
      Size = 255
    end
    object fdmProfilelanguage: TWideStringField
      FieldName = 'language'
      Size = 255
    end
    object fdmProfilenickname: TWideStringField
      FieldName = 'nickname'
      Size = 255
    end
    object fdmProfileheight: TWideStringField
      FieldName = 'height'
      Size = 255
    end
    object fdmProfileweight: TWideStringField
      FieldName = 'weight'
      Size = 255
    end
    object fdmProfilebmi: TWideStringField
      FieldName = 'bmi'
      Size = 255
    end
    object fdmProfilebody_fat_percentage: TWideStringField
      FieldName = 'body_fat_percentage'
      Size = 255
    end
    object fdmProfileunits: TWideStringField
      FieldName = 'units'
      Size = 255
    end
    object fdmProfileactivity: TWideStringField
      FieldName = 'activity'
      Size = 255
    end
    object fdmProfilelocation: TWideStringField
      FieldName = 'location'
      Size = 255
    end
    object fdmProfileimage: TWideStringField
      FieldName = 'image'
      Size = 255
    end
    object fdmProfileshow_status: TWideStringField
      FieldName = 'show_status'
      Size = 255
    end
    object fdmProfileshow_progress: TWideStringField
      FieldName = 'show_progress'
      Size = 255
    end
    object fdmProfilefind_trainer: TWideStringField
      FieldName = 'find_trainer'
      Size = 255
    end
    object fdmProfileshow_tables: TWideStringField
      FieldName = 'show_tables'
      Size = 255
    end
    object fdmProfilesearch: TWideStringField
      FieldName = 'search'
      Size = 255
    end
    object fdmProfilemessage: TWideStringField
      FieldName = 'message'
      Size = 255
    end
    object fdmProfilemember_id: TWideStringField
      FieldName = 'member_id'
      Size = 255
    end
    object fdmProfileage: TWideStringField
      FieldName = 'age'
      Size = 255
    end
  end
  object dsProfile: TBindSourceDB
    DataSet = fdmProfile
    ScopeMappings = <>
    Left = 488
    Top = 272
  end
  object reqUpdateProfile: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'file'
        ContentType = ctIMAGE_JPEG
      end>
    Response = respUpdateProfile
    SynchronizedEvents = False
    Left = 760
    Top = 80
  end
  object respUpdateProfile: TRESTResponse
    Left = 760
    Top = 144
  end
  object reqSearch: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'criteria[name]'
        Value = 'Ross'
      end
      item
        name = 'id'
        Value = '9'
      end>
    Resource = 'r/search/getSearchResults'
    Response = respSearch
    SynchronizedEvents = False
    Left = 552
    Top = 72
  end
  object respSearch: TRESTResponse
    ContentType = 'text/html'
    Left = 552
    Top = 128
  end
  object rdsaMembers: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmSearchNames
    FieldDefs = <>
    Response = respSearch
    RootElement = 'Result.names'
    NestedElementsDepth = 1
    NestedElements = True
    Left = 552
    Top = 176
  end
  object fdmSearchNames: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'active'
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
        Name = 'image'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'email'
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
    Left = 552
    Top = 224
    object fdmSearchNamesid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmSearchNamesactive: TWideStringField
      FieldName = 'active'
      Size = 255
    end
    object fdmSearchNamesfirst_name: TWideStringField
      FieldName = 'first_name'
      Size = 255
    end
    object fdmSearchNameslast_name: TWideStringField
      FieldName = 'last_name'
      Size = 255
    end
    object fdmSearchNamesemail: TWideStringField
      FieldName = 'email'
      Size = 255
    end
    object fdmSearchNamesimage: TWideStringField
      FieldName = 'image'
      Size = 255
    end
  end
  object dsSearchNames: TBindSourceDB
    DataSet = fdmSearchNames
    ScopeMappings = <>
    Left = 544
    Top = 272
  end
  object reqSports: TRESTRequest
    Client = restAPI
    Params = <>
    Resource = 'rest/sports'
    Response = respSports
    SynchronizedEvents = False
    Left = 616
    Top = 80
  end
  object respSports: TRESTResponse
    ContentType = 'text/html'
    Left = 616
    Top = 128
  end
  object rdsaSports: TRESTResponseDataSetAdapter
    Active = True
    Dataset = fdmSports
    FieldDefs = <>
    Response = respSports
    RootElement = 'Result'
    Left = 616
    Top = 176
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
    Left = 616
    Top = 224
    object fdmSportsid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmSportsname: TWideStringField
      FieldName = 'name'
      Size = 255
    end
  end
  object dsSports: TBindSourceDB
    DataSet = fdmSports
    ScopeMappings = <>
    Left = 616
    Top = 272
  end
  object reqAllTeamData: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'team'
        Value = '7'
      end
      item
        name = 'member_id'
        Value = '9'
      end>
    Resource = 'r/teams/getAllTeamData'
    Response = respAllTeamData
    SynchronizedEvents = False
    Left = 160
    Top = 376
  end
  object respAllTeamData: TRESTResponse
    ContentType = 'text/html'
    Left = 160
    Top = 424
  end
  object rdsaFriendsToInvite: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmFriendsToInvite
    FieldDefs = <>
    Response = respAllTeamData
    RootElement = 'Result.invites'
    Left = 48
    Top = 400
  end
  object fdmFriendsToInvite: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'first_name'
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
    Left = 40
    Top = 448
    object fdmFriendsToInviteid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmFriendsToInvitefirst_name: TWideStringField
      FieldName = 'first_name'
      Size = 255
    end
  end
  object reqFriendRequests: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'member_id'
        Value = '9'
      end>
    Resource = 'r/members/getFriendRequests'
    Response = respFriendRequests
    SynchronizedEvents = False
    Left = 464
    Top = 368
  end
  object respFriendRequests: TRESTResponse
    ContentType = 'text/html'
    Left = 456
    Top = 424
  end
  object rdsaFriendRequests: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmFriendRequests
    FieldDefs = <>
    Response = respFriendRequests
    RootElement = 'Result'
    Left = 464
    Top = 480
  end
  object fdmFriendRequests: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'friend_id'
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
        Name = 'image'
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
    Left = 472
    Top = 536
    object fdmFriendRequestsfriend_id: TWideStringField
      FieldName = 'friend_id'
      Size = 255
    end
    object fdmFriendRequestsfirst_name: TWideStringField
      FieldName = 'first_name'
      Size = 255
    end
    object fdmFriendRequestslast_name: TWideStringField
      FieldName = 'last_name'
      Size = 255
    end
    object fdmFriendRequestsimage: TWideStringField
      FieldName = 'image'
      Size = 255
    end
  end
  object reqTeamInvites: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'member_id'
        Value = '9'
      end>
    Resource = 'r/teams/getInvites'
    Response = respTeamInvites
    SynchronizedEvents = False
    Left = 568
    Top = 376
  end
  object respTeamInvites: TRESTResponse
    ContentType = 'text/html'
    Left = 568
    Top = 440
  end
  object rdsaTeamInvites: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmTeamInvites
    FieldDefs = <>
    Response = respTeamInvites
    RootElement = 'Result'
    Left = 568
    Top = 496
  end
  object fdmTeamInvites: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'team_id'
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
        Name = 'active'
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
        Name = 'owner'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'public'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'sport_id'
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
    Left = 568
    Top = 552
    object fdmTeamInvitesid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmTeamInvitesteam_id: TWideStringField
      FieldName = 'team_id'
      Size = 255
    end
    object fdmTeamInvitesmember_id: TWideStringField
      FieldName = 'member_id'
      Size = 255
    end
    object fdmTeamInvitesstatus: TWideStringField
      FieldName = 'status'
      Size = 255
    end
    object fdmTeamInvitesinvite_sent: TWideStringField
      FieldName = 'invite_sent'
      Size = 255
    end
    object fdmTeamInvitesname: TWideStringField
      FieldName = 'name'
      Size = 255
    end
    object fdmTeamInvitescontent: TWideStringField
      FieldName = 'content'
      Size = 255
    end
    object fdmTeamInvitesdate: TWideStringField
      FieldName = 'date'
      Size = 255
    end
    object fdmTeamInvitesactive: TWideStringField
      FieldName = 'active'
      Size = 255
    end
    object fdmTeamInvitesdate_added: TWideStringField
      FieldName = 'date_added'
      Size = 255
    end
    object fdmTeamInviteslast_modified: TWideStringField
      FieldName = 'last_modified'
      Size = 255
    end
    object fdmTeamInvitesimage: TWideStringField
      FieldName = 'image'
      Size = 255
    end
    object fdmTeamInvitesowner: TWideStringField
      FieldName = 'owner'
      Size = 255
    end
    object fdmTeamInvitespublic: TWideStringField
      FieldName = 'public'
      Size = 255
    end
    object fdmTeamInvitessport_id: TWideStringField
      FieldName = 'sport_id'
      Size = 255
    end
  end
  object reqPublicTeams: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'id'
        Value = '9'
      end>
    Resource = 'r/teams/getPublicTeams'
    Response = respPublicTeams
    SynchronizedEvents = False
    Left = 656
    Top = 384
  end
  object respPublicTeams: TRESTResponse
    ContentType = 'text/html'
    Left = 656
    Top = 440
  end
  object rdsaPublicTeams: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmPublicTeams
    FieldDefs = <>
    Response = respPublicTeams
    RootElement = 'Result'
    Left = 664
    Top = 504
  end
  object fdmPublicTeams: TFDMemTable
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
        Name = 'active'
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
        Name = 'owner'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'public'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'sport_id'
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
    Left = 664
    Top = 560
    object fdmPublicTeamsid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object fdmPublicTeamsname: TWideStringField
      FieldName = 'name'
      Size = 255
    end
    object fdmPublicTeamscontent: TWideStringField
      FieldName = 'content'
      Size = 255
    end
    object fdmPublicTeamsdate: TWideStringField
      FieldName = 'date'
      Size = 255
    end
    object fdmPublicTeamsactive: TWideStringField
      FieldName = 'active'
      Size = 255
    end
    object fdmPublicTeamsdate_added: TWideStringField
      FieldName = 'date_added'
      Size = 255
    end
    object fdmPublicTeamslast_modified: TWideStringField
      FieldName = 'last_modified'
      Size = 255
    end
    object fdmPublicTeamsimage: TWideStringField
      FieldName = 'image'
      Size = 255
    end
    object fdmPublicTeamsowner: TWideStringField
      FieldName = 'owner'
      Size = 255
    end
    object fdmPublicTeamspublic: TWideStringField
      FieldName = 'public'
      Size = 255
    end
    object fdmPublicTeamssport_id: TWideStringField
      FieldName = 'sport_id'
      Size = 255
    end
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 24
    Top = 256
  end
  object fdConnection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\dave\Documents\Embarcadero\Studio\Projects\Dev' +
        'Notes\devnotes.sqlite'
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    BeforeConnect = fdConnectionBeforeConnect
    Left = 24
    Top = 200
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 24
    Top = 320
  end
end
