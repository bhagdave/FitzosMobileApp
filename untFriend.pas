unit untFriend;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit;

type
  TfrmFriend = class(TfrmBase)
    lblDebug: TLabel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFriend: TfrmFriend;

implementation

{$R *.fmx}
procedure TfrmFriend.FormActivate(Sender: TObject);
begin
  inherited;
  lblDebug.Text := id;
end;

initialization
RegisterFMXClasses([TfrmFriend]);

end.
