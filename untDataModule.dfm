object dmdDataModule: TdmdDataModule
  OldCreateOrder = False
  Height = 635
  Width = 1008
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
    Dataset = cdsNotifications
    FieldDefs = <>
    RootElement = 'Result'
    Left = 200
    Top = 184
  end
  object cdsNotifications: TClientDataSet
    Active = True
    Aggregates = <>
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
    Params = <>
    StoreDefs = True
    Left = 200
    Top = 248
    Data = {
      860200009619E0BD01000000180000000C0001000000030000008C0102696402
      004A000000010005574944544802000200FE010A66726F6D5F7461626C650200
      4A000000010005574944544802000200FE010866726F6D5F6B657902004A0000
      00010005574944544802000200FE0108746F5F7461626C6502004A0000000100
      05574944544802000200FE0106746F5F6B657902004A00000001000557494454
      4802000200FE010C6E6F74696669636174696F6E02004A000000010005574944
      544802000200FE0109706172656E745F696402004A0000000100055749445448
      02000200FE01097075626C697368656402004A00000001000557494454480200
      0200FE010A646174655F616464656402004A0000000100055749445448020002
      00FE0105696D61676502004A000000010005574944544802000200FE01047265
      616402004A000000010005574944544802000200FE01047479706502004A0000
      00010005574944544802000200FE0101000A4348414E47455F4C4F4704008200
      03000000010000000000000004000000040010440400390032000C006D006500
      6D006200650072000400310030000C006D0065006D0062006500720002003900
      940059006F0075002000680061007600650020006200650065006E0020006900
      6E0076006900740065006400200074006F002000740068006500200074006500
      61006D0020003C006100200068007200650066003D0027002F00740065006100
      6D002F0076006900650077002F003200380027003E0052005900500020004600
      6F0075006E0064006500720073003C002F0061003E0006007900650073002600
      32003000310034002D00300035002D00300037002000300030003A0030003000
      3A003000300002003000}
  end
  object reqMember: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'id'
        Value = '9'
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
    Dataset = cdsGeneric
    FieldDefs = <>
    Response = respGeneric
    Left = 416
    Top = 192
  end
  object cdsGeneric: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 408
    Top = 248
  end
end
