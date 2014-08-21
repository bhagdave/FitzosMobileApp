unit untMenuForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Objects;

type
  TfrmMenu = class(TForm)
    GridPanelLayout1: TGridPanelLayout;
    btnEvents: TRectangle;
    lblEvents: TLabel;
    btnTeams: TRectangle;
    lblTeams: TLabel;
    procedure lblEventsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses
  untFormRegistry;

{$R *.fmx}

procedure TfrmMenu.lblEventsClick(Sender: TObject);
begin
  shownewForm('TFrmEvents');
end;

initialization
RegisterFMXClasses([TfrmMenu]);


end.
