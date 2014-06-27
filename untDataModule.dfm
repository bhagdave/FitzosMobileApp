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
    Dataset = cdsMember
    FieldDefs = <>
    Response = respMember
    RootElement = 'Result'
    Left = 296
    Top = 192
  end
  object cdsMember: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'JSONNull'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 296
    Top = 248
    Data = {
      580000009619E0BD0100000018000000010001000000030000005600084A534F
      4E4E756C6C02004A000000010005574944544802000200FE0101000A4348414E
      47455F4C4F4704008200030000000100000000000000040000000401}
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
    Dataset = cdsTeam
    FieldDefs = <>
    Response = respTeam
    RootElement = 'Result'
    Left = 544
    Top = 192
  end
  object cdsTeam: TClientDataSet
    Active = True
    Aggregates = <>
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
    Params = <>
    StoreDefs = True
    Left = 536
    Top = 248
    Data = {
      9E0100009619E0BD01000000180000000B000100000003000000660102696402
      004A000000010005574944544802000200FE01046E616D6502004A0000000100
      05574944544802000200FE0107636F6E74656E7402004A000000010005574944
      544802000200FE01046461746502004A000000010005574944544802000200FE
      010661637469766502004A000000010005574944544802000200FE010A646174
      655F616464656402004A000000010005574944544802000200FE010D6C617374
      5F6D6F64696669656402004A000000010005574944544802000200FE0105696D
      61676502004A000000010005574944544802000200FE01056F776E657202004A
      000000010005574944544802000200FE01067075626C696302004A0000000100
      05574944544802000200FE010873706F72745F696402004A0000000100055749
      44544802000200FE0101000A4348414E47455F4C4F4704008200030000000100
      000000000000040000000450540002003700140034006B00200046006F006F00
      7400650072007300060079006500730004003100300006007900650073000200
      3400}
    object cdsTeamid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object cdsTeamname: TWideStringField
      FieldName = 'name'
      Size = 255
    end
    object cdsTeamcontent: TWideStringField
      FieldName = 'content'
      Size = 255
    end
    object cdsTeamdate: TWideStringField
      FieldName = 'date'
      Size = 255
    end
    object cdsTeamactive: TWideStringField
      FieldName = 'active'
      Size = 255
    end
    object cdsTeamdate_added: TWideStringField
      FieldName = 'date_added'
      Size = 255
    end
    object cdsTeamlast_modified: TWideStringField
      FieldName = 'last_modified'
      Size = 255
    end
    object cdsTeamimage: TWideStringField
      FieldName = 'image'
      Size = 255
    end
    object cdsTeamowner: TWideStringField
      FieldName = 'owner'
      Size = 255
    end
    object cdsTeampublic: TWideStringField
      FieldName = 'public'
      Size = 255
    end
    object cdsTeamsport_id: TWideStringField
      FieldName = 'sport_id'
      Size = 255
    end
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
        Value = '28'
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
    Left = 808
    Top = 97
  end
  object respTeamMembers: TRESTResponse
    ContentType = 'text/html'
    Left = 808
    Top = 152
  end
  object rdsaTeamMembers: TRESTResponseDataSetAdapter
    Active = True
    Dataset = fdmTeamMembers
    FieldDefs = <>
    Response = respTeamMembers
    RootElement = 'Result'
    Left = 808
    Top = 208
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
    Left = 808
    Top = 272
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
end
