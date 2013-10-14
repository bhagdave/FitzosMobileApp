unit untAthleteWelcome;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Ani,untAthleteProfile;

type
  TfrmAthleteWelcome = class(TForm)
    lblWelcome: TLabel;
    btnProfile: TButton;
    btnMessages: TButton;
    btnNews: TButton;
    btnSports: TButton;
    btnLeagues: TButton;
    btnAchievements: TButton;
    btnBadges: TButton;
    btnCalendar: TButton;
    btnEvents: TButton;
    pnlButtons: TPanel;
    pnlAnimation: TFloatAnimation;
    procedure FormCreate(Sender: TObject);
    procedure btnProfileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TfrmAthleteWelcome.btnProfileClick(Sender: TObject);
var
  frmProfile : TfrmAthleteProfile;
begin
  frmProfile := TfrmAthleteProfile.Create(self);
  frmProfile.Show;
  FreeAndNil(frmProfile);
end;

procedure TfrmAthleteWelcome.FormCreate(Sender: TObject);
begin
  self.pnlButtons.Position.X := screen.Size.Width;
  self.pnlButtons.Position.Y := 0;
  self.pnlButtons.Width := screen.Size.Width;
  self.pnlButtons.Height := screen.Size.Height;
  self.pnlAnimation.StartValue := screen.Size.Width;
  self.pnlAnimation.StopValue := 0;
  self.pnlAnimation.Start;

end;
end.
