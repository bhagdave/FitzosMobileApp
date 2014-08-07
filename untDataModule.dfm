object dmdDataModule: TdmdDataModule
  OldCreateOrder = False
  Height = 635
  Width = 1021
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
        Value = '9'
      end>
    Resource = 'notifications/getMemberNotifications'
    Response = respNotifications
    SynchronizedEvents = False
    OnHTTPProtocolError = reqNotificationsHTTPProtocolError
    Left = 200
    Top = 72
  end
  object respNotifications: TRESTResponse
    ContentType = 'text/html'
    Left = 200
    Top = 128
  end
  object rdsaNotifications: TRESTResponseDataSetAdapter
    Active = True
    AutoUpdate = False
    Dataset = fdmNotifications
    FieldDefs = <>
    Response = respNotifications
    RootElement = 'Result'
    Left = 200
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
    Left = 288
    Top = 72
  end
  object respMember: TRESTResponse
    ContentType = 'text/html'
    Left = 288
    Top = 128
  end
  object rdsaMember: TRESTResponseDataSetAdapter
    Active = True
    Dataset = fdmMember
    FieldDefs = <>
    Response = respMember
    RootElement = 'Result'
    Left = 296
    Top = 192
  end
  object reqGeneric: TRESTRequest
    Client = restAPI
    Params = <>
    Response = respGeneric
    SynchronizedEvents = False
    Left = 416
    Top = 81
  end
  object respGeneric: TRESTResponse
    Left = 416
    Top = 136
  end
  object rdsaGeneric: TRESTResponseDataSetAdapter
    Dataset = fdmGeneric
    FieldDefs = <>
    Response = respGeneric
    RootElement = 'Result'
    Left = 416
    Top = 192
  end
  object reqTeam: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'id'
        Value = '7'
      end
      item
        name = 'signature'
      end
      item
        name = 'key'
      end>
    Resource = 'teams/getTeam'
    Response = respTeam
    SynchronizedEvents = False
    Left = 544
    Top = 81
  end
  object respTeam: TRESTResponse
    ContentType = 'text/html'
    Left = 544
    Top = 136
  end
  object rdsaTeam: TRESTResponseDataSetAdapter
    Active = True
    Dataset = fdmTeam
    FieldDefs = <>
    Response = respTeam
    RootElement = 'Result'
    Left = 544
    Top = 192
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
    Left = 672
    Top = 89
  end
  object respMemberTeams: TRESTResponse
    ContentType = 'text/html'
    Left = 672
    Top = 144
  end
  object rdsaMemberTeams: TRESTResponseDataSetAdapter
    Active = True
    Dataset = fdmMemberTeams
    FieldDefs = <>
    Response = respMemberTeams
    RootElement = 'Result'
    Left = 672
    Top = 200
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
    Left = 672
    Top = 256
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
    Left = 680
    Top = 320
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
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 200
    Top = 256
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
    Left = 416
    Top = 248
  end
  object reqTeamMembers: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'id'
        Value = '7'
      end
      item
        name = 'signature'
      end
      item
        name = 'key'
      end>
    Resource = 'teams/getTeamMembers'
    Response = respTeamMembers
    SynchronizedEvents = False
    Left = 48
    Top = 361
  end
  object respTeamMembers: TRESTResponse
    ContentType = 'text/html'
    Left = 48
    Top = 416
  end
  object rdsaTeamMembers: TRESTResponseDataSetAdapter
    Active = True
    Dataset = fdmTeamMembers
    FieldDefs = <>
    Response = respTeamMembers
    RootElement = 'Result'
    Left = 48
    Top = 472
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
    Left = 48
    Top = 536
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
    Left = 56
    Top = 584
  end
  object reqTeamEvents: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'id'
        Value = '21'
      end
      item
        name = 'signature'
      end
      item
        name = 'key'
      end>
    Resource = 'teams/getTeamEvents'
    Response = respTeamEvents
    SynchronizedEvents = False
    Left = 168
    Top = 361
  end
  object respTeamEvents: TRESTResponse
    ContentType = 'text/html'
    Left = 168
    Top = 416
  end
  object rdsaTeamEvents: TRESTResponseDataSetAdapter
    Active = True
    Dataset = fdmTeamEvents
    FieldDefs = <>
    Response = respTeamEvents
    RootElement = 'Result'
    Left = 168
    Top = 472
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
    Left = 168
    Top = 536
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
    Left = 168
    Top = 584
  end
  object reqTeamWall: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'id'
        Value = '28'
      end
      item
        name = 'signature'
      end
      item
        name = 'key'
      end>
    Resource = 'teams/getTeamWall'
    Response = respTeamWall
    SynchronizedEvents = False
    Left = 264
    Top = 369
  end
  object respTeamWall: TRESTResponse
    ContentType = 'text/html'
    Left = 264
    Top = 424
  end
  object rdsaTeamWall: TRESTResponseDataSetAdapter
    Active = True
    Dataset = fdmTeamWall
    FieldDefs = <>
    Response = respTeamWall
    RootElement = 'Result'
    Left = 264
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
    Left = 264
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
    Left = 264
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
    Left = 296
    Top = 248
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
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 536
    Top = 240
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
  end
  object dsTeam: TBindSourceDB
    DataSet = fdmTeam
    ScopeMappings = <>
    Left = 536
    Top = 304
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
    Left = 480
    Top = 360
  end
  object respEvents: TRESTResponse
    ContentType = 'text/html'
    Left = 480
    Top = 408
  end
  object rdsaEvents: TRESTResponseDataSetAdapter
    Active = True
    Dataset = fdmEvents
    FieldDefs = <>
    Response = respEvents
    RootElement = 'Result'
    Left = 480
    Top = 464
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
    Left = 480
    Top = 512
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
    Left = 472
    Top = 560
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
    Left = 576
    Top = 384
  end
  object respMemberSports: TRESTResponse
    ContentType = 'text/html'
    Left = 584
    Top = 440
  end
  object rdsaMemberSports: TRESTResponseDataSetAdapter
    Active = True
    Dataset = fdmMemberSports
    FieldDefs = <>
    Response = respMemberSports
    RootElement = 'Result'
    Left = 584
    Top = 496
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
    Left = 584
    Top = 552
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
    Top = 400
  end
  object respCreateTeam: TRESTResponse
    Left = 680
    Top = 456
  end
  object dsMemberSports: TBindSourceDB
    DataSet = fdmMemberSports
    ScopeMappings = <>
    Left = 584
    Top = 600
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
    Left = 760
    Top = 88
  end
  object respProfile: TRESTResponse
    ContentType = 'text/html'
    Left = 768
    Top = 152
  end
  object rdsaProfile: TRESTResponseDataSetAdapter
    Active = True
    Dataset = fdmProfile
    FieldDefs = <>
    Response = respProfile
    RootElement = 'Result'
    Left = 768
    Top = 216
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
    Left = 768
    Top = 272
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
    Left = 760
    Top = 320
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
    Left = 792
    Top = 408
  end
  object respUpdateProfile: TRESTResponse
    Left = 792
    Top = 472
  end
  object reqSearch: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'criteria'
        Value = 'name=dave'
      end
      item
        name = 'id'
        Value = '9'
      end>
    Resource = 'r/search/getSearchResults'
    Response = respSearch
    SynchronizedEvents = False
    Left = 840
    Top = 96
  end
  object respSearch: TRESTResponse
    ContentType = 'text/html'
    Left = 840
    Top = 144
  end
  object rdsaMembers: TRESTResponseDataSetAdapter
    FieldDefs = <>
    Response = respSearch
    RootElement = 'Result'
    NestedElementsDepth = 1
    NestedElements = True
    Left = 840
    Top = 200
  end
end
