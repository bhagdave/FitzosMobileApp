unit untFormRegistry;

interface
uses
  System.Classes;

  procedure showNewForm(ClassName : String);
  procedure showNewFormWithId(ClassName, sId : String);

var
  FormRegistry : TStringList;

  implementation
uses
  untBaseForm, System.SysUtils, fmx.types, fmx.forms;

procedure showNewForm(ClassName : String);
var ObjClass: TFmxObjectClass;
    NewForm: TCustomForm;
    idx : Integer;
begin
  ObjClass := TFmxObjectClass(GetClass(ClassName));
  if ObjClass <> nil then
  begin
    // is it in the list???
    idx := FormRegistry.IndexOf(ClassName);
    if idx > -1 then
    begin
      NewForm := FormRegistry.Objects[idx] as TCustomForm;
    end
    else
    begin
      NewForm := ObjClass.Create(Application) as TCustomForm;
      FormRegistry.AddObject(ClassName,NewForm);
    end;
    if Assigned(NewForm) then
      NewForm.Show;
  end
end;

procedure showNewFormWithId(ClassName,sId : String);
var ObjClass: TFmxObjectClass;
    NewForm: TCustomForm;
    idx : Integer;
begin
  ObjClass := TFmxObjectClass(GetClass(ClassName));
  if ObjClass <> nil then
  begin
    // is it in the list???
    idx := FormRegistry.IndexOf(ClassName);
    if idx > -1 then
    begin
      NewForm := FormRegistry.Objects[idx] as TCustomForm;
    end
    else
    begin
      NewForm := ObjClass.Create(Application) as TCustomForm;
      FormRegistry.AddObject(ClassName,NewForm);
    end;
    if Assigned(NewForm) then
    begin
      TfrmBase(NewForm).id := sId;
      NewForm.Show;
    end;
  end
end;
initialization
  FormRegistry := TStringList.Create;
  FormRegistry.Duplicates := dupIgnore;
  FormRegistry.Sorted := True;
finalization
  FormRegistry.free;

end.
