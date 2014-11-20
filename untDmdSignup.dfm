object dmdSignup: TdmdSignup
  OldCreateOrder = False
  Height = 331
  Width = 368
  object restAPI: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    BaseURL = 'https://www.reach-your-peak.com/api'
    Params = <>
    HandleRedirects = True
    Left = 32
    Top = 16
  end
  object reqCheckExists: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'signature'
      end
      item
        name = 'key'
      end
      item
        name = 'data[email]'
        Value = 'dave_gill@blueyonder.co.uk'
      end>
    Resource = 'r/members/checkIfMemberExists'
    Response = respCheckExists
    SynchronizedEvents = False
    Left = 32
    Top = 80
  end
  object respCheckExists: TRESTResponse
    ContentType = 'text/html'
    Left = 40
    Top = 136
  end
  object reqCreateMember: TRESTRequest
    Client = restAPI
    Params = <
      item
        name = 'signature'
      end
      item
        name = 'key'
      end>
    Resource = 'r/members/createMember'
    Response = respCreateMember
    SynchronizedEvents = False
    Left = 144
    Top = 88
  end
  object respCreateMember: TRESTResponse
    Left = 152
    Top = 144
  end
end
