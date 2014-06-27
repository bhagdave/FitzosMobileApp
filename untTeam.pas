unit untTeam;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, FMX.ListView.Types, FMX.ListView;

type
  TfrmTeam = class(TfrmBase)
    btnCreate: TButton;
    lvTeams: TListView;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTeam: TfrmTeam;

implementation

{$R *.fmx}
initialization
RegisterFMXClasses([TfrmTeam]);

end.
