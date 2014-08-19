unit untNotification;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit,untDataModule, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.DBScope;

type
  TfrmNotification = class(TfrmBase)
    lblNotification: TLabel;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    btnRead: TButton;
    lblFrom: TLabel;
    lblDate: TLabel;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    procedure FormShow(Sender: TObject);
    procedure btnReadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses
  untMainForm , untJsonFunctions;

{$R *.fmx}
procedure TfrmNotification.btnReadClick(Sender: TObject);
begin
  inherited;
  // ok we need to send a markedread call
  with dmdDataModule do
  begin
      rdsaGeneric.ClearDataSet;
      respGeneric.Content.Empty;
      reqGeneric.Params.Clear;
      reqGeneric.ClearBody;
      reqGeneric.Resource := 'notifications/markRead';
      reqGeneric.Params.addItem('id',fdmNotifications.FieldByName('id').AsString);
      reqGeneric.Params.addItem('signature',signature('markRead'));
      reqGeneric.Params.addItem('key',getApiKey);
      reqGeneric.Execute;
      btnRead.Enabled := false;
  end;
  close;
end;

procedure TfrmNotification.FormShow(Sender: TObject);
var
  sResult : String;
  sFrom   : String;
begin
  inherited;
  sFrom := 'From Administrator';
  // where did the message come from....
  // can we get to the correct record.
  dmdDataModule.fdmNotifications.Locate('id',ID,[]);
  if dmdDataModule.fdmNotifications.FieldByName('from_table').AsString = 'member' then
  begin
    // get the member
    // Open up the data.
    with dmdDataModule do
    begin
      // Open up the data.
      rdsaMember.ClearDataSet;
      fdmMember.Close;
      respMember.Content.Empty;
      reqMember.ClearBody;
      reqMember.Params.ParameterByName('id').Value := fdmNotifications.FieldByName('from_key').AsString;
      reqMember.Params.ParameterByName('signature').Value := signature('getMember');
      reqMember.Params.ParameterByName('key').Value := getApiKey;
      reqMember.Execute;
      sResult := getResultString(respMember.Content);
      if (sResult = 'OK') then
      begin
          rdsaMember.Response := respMember;
          fdmMember.Open;
          sFrom := 'The notification came from ' + fdmMember.FieldByName('first_name').AsString;
      end
      else
      begin
          showmessage(respMember.Content);
      end;
    end;
  end
  else if dmdDataModule.fdmNotifications.FieldByName('from_table').AsString = 'member' then
  begin
    // get the member
    // Open up the data.
    with dmdDataModule do
    begin
      // Open up the data.
      rdsaTeam.ClearDataSet;
      fdmTeam.Close;
      respTeam.Content.Empty;
      reqTeam.ClearBody;
      reqTeam.Params.ParameterByName('id').Value := fdmNotifications.FieldByName('from_key').AsString;
      reqTeam.Params.ParameterByName('signature').Value := signature('getTeam');
      reqTeam.Params.ParameterByName('key').Value := getApiKey;
      reqTeam.Execute;
      sResult := getResultString(respTeam.Content);
      if (sResult = 'OK') then
      begin
          rdsaTeam.Response := respTeam;
          fdmTeam.Open;
          sFrom := 'The notification came from the team ' + fdmTeam.FieldByName('name').AsString;
      end
      else
      begin
          showmessage(respMember.Content);
      end;
    end;
  end;
  lblFrom.text := sFrom;
end;

initialization
RegisterFMXClasses([TfrmNotification]);

end.
