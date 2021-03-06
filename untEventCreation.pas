unit untEventCreation;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, untEventDataModule, FMX.Layouts, FMX.Memo,
  FMX.DateTimeCtrls, FMX.ListBox,REST.Client, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, FMX.Controls.Presentation,
  FGX.ProgressDialog, FMX.Notification, FMX.AndroidLike.Toast;

type
  TfrmEventCreation = class(TfrmBase)
    vsbDetails: TVertScrollBox;
    lyoEvent: TLayout;
    edtName: TEdit;
    memContent: TMemo;
    lblDescription: TLabel;
    edtDate: TDateEdit;
    lyoStartDate: TLayout;
    lblStartDate: TLabel;
    edtStartTime: TTimeEdit;
    lyoStartTime: TLayout;
    lblStartTime: TLabel;
    edtLocation: TEdit;
    cboTeam: TComboBox;
    btnSubmit: TButton;
    BindingsList1: TBindingsList;
    LinkFillControlToField2: TLinkFillControlToField;
    BindSourceDB1: TBindSourceDB;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField7: TLinkControlToField;
    LinkControlToField8: TLinkControlToField;
    lblTeam: TLabel;
    grdPanelEdits: TGridPanelLayout;
    lblName: TLabel;
    lblLocation: TLabel;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure btnSubmitClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure getSportsAndTeams;
    procedure addParams(request : TRestRequest);
    function validate : boolean;
    procedure sportsLoaded;
    procedure teamsLoaded;
    procedure eventLoaded;
    procedure saveCompleted;
  public
    { Public declarations }
  end;


implementation

uses
  untDataModule, untJsonFunctions,untFormRegistry;

{$R *.fmx}
{$R *.SmXhdpiPh.fmx ANDROID}

procedure TfrmEventCreation.addParams(request: TRestRequest);
var
  sPublic, sSport, sTeam : String;
  lValue : TValue;
begin
  lValue := GetSelectedValue(cboTeam);
  sTeam := lValue.ToString;
  request.Params.Clear;
  if id <> '' then
    request.Params.AddItem('id',id);
  request.Params.AddItem('key',dmdDataModule.sessionKey);
  request.Params.AddItem('name',edtName.Text);
  request.Params.AddItem('content',memContent.Lines.GetText);
  request.Params.AddItem('date',DateToStr(edtDate.Date));
  request.Params.AddItem('published', 'Yes');
  request.Params.AddItem('type','LIVE');
  request.Params.AddItem('public','PUBLIC');
  request.Params.AddItem('sub_type','FREE');
  request.Params.AddItem('team_id',sTeam);
  request.Params.AddItem('member_id',dmdDataModule.memberId);
  request.Params.AddItem('time',edtStartTime.Text);
  request.Params.AddItem('location',edtLocation.Text);
  request.Params.AddItem('sport_id',sSport);
end;

procedure TfrmEventCreation.btnSubmitClick(Sender: TObject);
begin
  inherited;
  if connected then
  begin
    if (assigned(parent)) then
    begin
      parent.Deactivate;
    end;
    // Validate..
    if validate then // true = invalid
    begin

    end
    else
    begin
      // if we have an id then updatre otherwise insert
      if id <> '' then
      begin
        showActivityDialog('Saving event details','Please wait');
        // update
        addParams(dmdEvent.reqUpdateEvent);
        dmdEvent.reqUpdateEvent.ExecuteAsync(saveCompleted);
  //      clearOutFields();
      end
      else
      begin
        // insert
        showActivityDialog('Saving event details','Please wait');
        addParams(dmdEvent.reqCreateEvent);
        dmdEvent.reqCreateEvent.ExecuteAsync(saveCompleted);
      end;
    end;
  end
  else
  begin
    showmessage('No internet connection at the moment');
  end;
end;

procedure TfrmEventCreation.eventLoaded;
begin
  with dmdEvent do begin
      rdsaEvent.UpdateDataSet;
      fdmEvent.Open;
      fgActivityDialog.Hide;
  end;
end;

procedure TfrmEventCreation.FormActivate(Sender: TObject);
begin
  inherited;
  showActivityDialog('Loading data','Please wait');
  edtDate.Align := TAlignLayout.client;
  if connected then
  begin
    getSportsAndTeams();
    if id <> '' then
    begin
      // change UI
      lblCaption.Text := 'Update Event';
      // Get data!
      with dmdEvent do
      begin
        rdsaEvent.ClearDataSet;
        fdmEvent.Close;
        respAllEventData.Content.Empty;
        reqAllEventData.ClearBody;
        reqAllEventData.Params.ParameterByName('id').Value := Id;
        reqAllEventData.Params.ParameterByName('key').Value := dmdDataModule.sessionKey;
        reqAllEventData.ExecuteAsync(eventLoaded);
      end;
    end
    else
    begin
      // just when inserting...
      dmdEvent.fdmEvent.insert;
      lblCaption.Text := 'Create Event';
      edtDate.Data := '';
      fgActivityDialog.Hide;
    end;
  end
  else
  begin
    fgActivityDialog.Hide;
    showmessage('No internet connection at the moment');
    close;
  end;
end;

procedure TfrmEventCreation.FormDeactivate(Sender: TObject);
begin
  inherited;
  fgActivityDialog.Hide;
  if Assigned(fParent) then
    TfrmBase(fParent).Activate;
end;

procedure TfrmEventCreation.getSportsAndTeams;
begin
  with dmdEvent do
  begin
    fgActivityDialog.Message := 'Loading sports and teams';
    // Open up the data.
    fdmSports.Close;
    reqSports.Params.ParameterByName('id').Value := dmdDataModule.memberId;
    reqSports.Params.ParameterByName('key').Value := dmdDataModule.sessionKey;
    reqSports.Execute();
    sportsLoaded;
    // Open up the data.
    fdmTeams.Close;
    reqTeams.Params.ParameterByName('id').Value := dmdDataModule.memberId;
    reqTeams.Params.ParameterByName('key').Value := dmdDataModule.sessionKey;
    reqTeams.Execute();
    teamsLoaded();
  end;
end;

procedure TfrmEventCreation.saveCompleted;
begin
  fgActivityDialog.Hide;
  if id <> '' then
  begin
    saveMessage.Now('Event saved!');
  end
  else
  begin
    saveMessage.Now('Event created');
    close;
    if (assigned(parent)) then
    begin
      parent.refresh;
    end;
  end;
end;

procedure TfrmEventCreation.sportsLoaded;
var
  sResult : String;
begin
  with dmdEvent do begin
    sResult := getResultString(respSports.Content);
    if (sResult = 'OK') then
    begin
        rdsaSports.Response := respSports;
        rdsaSports.UpdateDataSet;
        fdmSports.Open;
    end;
  end;
end;

procedure TfrmEventCreation.teamsLoaded;
var
  sResult : String;
begin
  with dmdEvent do begin
    sResult := getResultString(respTeams.Content);
    if (sResult = 'OK') then
    begin
        rdsaTeams.Response := respTeams;
        rdsaTeams.UpdateDataSet;
        fdmTeams.Open;
        cboTeam.ItemIndex := 0;
    end;
  end;

end;

function TfrmEventCreation.validate: boolean;
var
  invalid : boolean;
  errors  : String;
begin
  fgActivityDialog.Message := 'Validating event data';
  invalid := false;
  if not(edtName.Text <> '') then
  begin
    invalid := true;
    edtName.SetFocus;
    errors := 'Event Name ';
  end;
  if edtDate.date = 0 then
  begin
    invalid := true;
    edtDate.SetFocus;
    errors := errors + 'Event Date ';
  end;
  if not(Assigned(cboTeam.Selected)) then
  begin
    invalid := true;
    cboTeam.SetFocus;
    errors := errors + 'Team';
  end;
  fgActivityDialog.Hide;
  if invalid then
    showmessage('Please complete the following fields ' + errors);
  result := invalid;
end;

initialization
RegisterFMXClasses([TfrmEventCreation]);

end.

