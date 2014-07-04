unit uAsyncImageLoader;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  FMX.Objects, AnonThread, IdZLibCompressorBase, IdCompressorZLib;

type
  TAsyncImageLoader = class(TFrame)
    ProgressBar: TProgressBar;
    Image: TImage;
  private
    { Private declarations }
    M: TMemoryStream;
    Loaded: Boolean;
  public
    { Public declarations }
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    IdCompressorZLib: TIdCompressorZLib;
    IdHTTP: TIdHTTP;
    Timer: TTimer;
    Working: Boolean;
    LastURL: String;
    URL: String;
    Pooled: Boolean;
    procedure Get;
    procedure GetURL(URL: String);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure TimerTimer(Sender: TObject);
    procedure AddPool;
    procedure RemovePool;
  end;

implementation

{$R *.fmx}

constructor TAsyncImageLoader.Create(AOwner: TComponent) ;
begin
 inherited Create(AOwner);
 Pooled := True;
end;

destructor TAsyncImageLoader.Destroy;
begin
  if Loaded then
   begin
     RemovePool;
   end;

  inherited Destroy;
end;

procedure TAsyncImageLoader.AddPool;
begin
      IdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
      IdCompressorZLib := TIdCompressorZLib.Create(Self);

      IdHTTP := TIdHTTP.Create(Self);
      IdHTTP.IOHandler := IdSSLIOHandlerSocketOpenSSL;
      IdHTTP.Compressor := IdCompressorZLib;

      Timer := TTimer.Create(Self);
      Timer.Enabled := False;
      Timer.Interval := 33;
      Timer.OnTimer := TimerTimer;
      Loaded := True;
end;

procedure TAsyncImageLoader.RemovePool;
begin
    Timer.DisposeOf;
    IdHTTP.DisposeOf;
    IdCompressorZLib.DisposeOf;
    IdSSLIOHandlerSocketOpenSSL.DisposeOf;
    Loaded := False;
end;

procedure TAsyncImageLoader.Get;
begin
GetURL(URL);
end;

procedure TAsyncImageLoader.GetURL(URL: string);
var
FThread: TAnonymousThread<Boolean>;
begin
if (Working=False) AND (LastURL<>URL) AND (URL<>'') then
 begin
  Working := True;
  LastURL := URL;

  if (Loaded=False) then
   begin
    AddPool;
   end;

  M := TMemoryStream.Create;

  Image.Visible := False;
  ProgressBar.Visible := True;

  Timer.Enabled := True;

  FThread := TAnonymousThread<Boolean>.Create(
    function: Boolean
    begin
      // Runs in seperate thread
      try
        IdHTTP.Get(URL,M);
      except on E: Exception do begin  end;
      end;
      Result := True;
    end,
    procedure(AResult: Boolean)
    begin
      // Runs in main thread
      // process the result from above
       try
        M.Seek(0,0);
        Image.Bitmap.LoadFromStream(M);
        Timer.Enabled := False;
        ProgressBar.Visible := False;
        Image.Visible := True;
       except on E: Exception do begin  end;
       end;
       M.DisposeOf;
       if not Pooled then
         RemovePool;
       Working := False;
    end,
    procedure(AException: Exception)
    var
    II: Integer;
    begin
      // Runs in main thread
      // do something if there is an exception
       try
       except on E: Exception do begin  end;
       end;
       Timer.Enabled := False;
       ProgressBar.Visible := False;
       M.DisposeOf;
       Working := False;
    end,
    False);
 end;
end;

procedure TAsyncImageLoader.TimerTimer(Sender: TObject);
begin
if ProgressBar.Value=100 then
 begin
  ProgressBar.Value := 0;
 end
else
  ProgressBar.Value := ProgressBar.Value+10;
end;

end.
