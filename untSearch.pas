unit untSearch;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit;

type
  TfrmSearch = class(TfrmBase)
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation



{$R *.fmx}
procedure TfrmSearch.FormActivate(Sender: TObject);
begin
  inherited;
  edtSearch.Text := id;
  // do the search!!

end;

initialization
RegisterFMXClasses([TfrmSearch]);

end.
