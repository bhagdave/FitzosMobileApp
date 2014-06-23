unit untFormController;

interface

uses
  untBaseForm,System.Generics.Collections,SysUtils,FMX.Dialogs,untIntFormController, fmx.forms;

type
  TFormController = class(TInterfacedobject, iFrmController)
    private
      frmList : TList<TFrmBase>;
      function checkList(className : TClass):Integer;
    public
      function showForm(className : TClass): TForm;
      constructor Create; overload;
      destructor Destroy; override;
  end;

implementation

{ TFormController }
uses
  RTTI;

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

function TFormController.showForm(className : TClass): TForm;
var
  tmpForm : tFrmBase;
  iForm   : Integer;
  c: TRttiContext;
  t: TRttiType;
begin
  if className.InheritsFrom(tFrmBase) then
  begin
    // check if the form is in the list already...
    iForm := checkList(className);
    if (iForm = 0) then
    begin
      try
        c := TRttiContext.Create;
        t := c.GetType(className);
        // if not create the form
        tmpForm := TfrmBase(t.AsInstance.MetaclassType).Create(nil);
        // add to our collection
        frmList.Add(tmpForm);
        c.Free;
      except on E: Exception do
        showmessage('We have bombed trying to create a form!');
      end;
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
