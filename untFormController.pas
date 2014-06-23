unit untFormController;

interface

uses
  untBaseForm,System.Generics.Collections,SysUtils;

type
  TFormController = class
    private
      frmList : TList<TFrmBase>;
      function checkList(className : TClass):Integer;
    public
      function showForm(className : TClass): TFrmBase;
      constructor Create; overload;
      destructor Destroy; override;
  end;

implementation

{ TFormController }

function TFormController.checkList(className: TClass): Integer;
var
  i : integer;
begin
  result := 0;
  for i  := 0 to frmList.Count - 1 do
  begin
    if frmList[i].ClassType = className then
      result := i;
  end;
end;

constructor TFormController.Create;
begin
  frmList := TList<TfrmBase>.Create;
end;

destructor TFormController.Destroy;
var
  i : Integer;
begin
  // free everything in list....
  for i  := 0 to frmList.Count - 1 do
    tFrmBase(frmList[i]).Free;
  inherited;
end;

function TFormController.showForm(className : TClass): TFrmBase;
var
  tmpForm : tFrmBase;
  iForm   : Integer;
begin
  if className.InheritsFrom(tFrmBase) then
  begin
    // check if the form is in the list already...
    iForm := checkList(className);
    if (iForm = 0) then
    begin
      // if not create the form
      tmpForm := TfrmBase(className).Create(nil);
      // add to our collection
      frmList.Add(tmpForm);
    end
    else
    begin
      tmpForm := tFrmBase(frmList[iForm]);
    end;
    // show the form.
    tmpForm.Show();
  end
  else
  begin
    raise Exception.Create('Invalid class name in showForm:' + className.ClassName);
  end;
end;

end.
