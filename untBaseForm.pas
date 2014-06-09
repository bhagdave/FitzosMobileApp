unit untBaseForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Objects, FMX.StdCtrls;

type
  TfrmBase = class(TForm)
    edtSearch: TEdit;
    btnProfile: TSpeedButton;
    imgAvatar: TImage;
    barTop: TToolBar;
    barBottom: TToolBar;
    pnlTop: TPanel;
    btnEvents: TCornerButton;
    btnTeams: TCornerButton;
    btnNotifications: TCornerButton;
    btnFriends: TCornerButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBase: TfrmBase;

implementation

{$R *.fmx}

end.
