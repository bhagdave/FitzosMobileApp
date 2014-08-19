unit untEventCreation;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, untEventDataModule, FMX.Layouts, FMX.Memo,
  FMX.DateTimeCtrls, FMX.ListBox,REST.Client, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

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
    cbPublished: TCheckBox;
    cboType: TComboBox;
    cboPrivacy: TComboBox;
    edtStartTime: TTimeEdit;
    lyoStartTime: TLayout;
    lblStartTime: TLabel;
    edtLocation: TEdit;
    cboTeam: TComboBox;
    cboSport: TComboBox;
    lyoEndDate: TLayout;
    edtEndDate: TDateEdit;
    lblEndDate: TLabel;
    lyoEndTime: TLayout;
    edtEndTime: TTimeEdit;
    lblEndTime: TLabel;
    expTimes: TExpander;
    expDetails: TExpander;
    expOptions: TExpander;
    btnNext: TButton;
    btnTimesNext: TButton;
    btnSubmit: TButton;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    LinkFillControlToField2: TLinkFillControlToField;
    BindSourceDB1: TBindSourceDB;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    LinkFillControlToField3: TLinkFillControlToField;
    LinkFillControlToField4: TLinkFillControlToField;
    LinkControlToField7: TLinkControlToField;
    LinkControlToField8: TLinkControlToField;
    lblTeam: TLabel;
    lblSport: TLabel;
    grdPanelEdits: TGridPanelLayout;
    lblName: TLabel;
    lblLocation: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnTimesNextClick(Sender: TObject);
    procedure btnSubmitClick(Sender: TObject);
  private
    { Private declarations }
    procedure getAttending;
    procedure getWall;
    procedure getSportsAndTeams;
    procedure addParams(request : TRestRequest);
    function validate : boolean;
    procedure clearOutFields();
  public
    { Public declarations }
  end;


implementation

uses
  untDataModule, untJsonFunctions,untFormRegistry;

{$R *.fmx}
procedure TfrmEventCreation.addParams(request: TRestRequest);
var
  sPublic, sSport, sTeam : String;
  lValue : TValue;
begin
  if cbPublished.IsChecked then
    sPublic := 'yes'
  else
    sPublic := 'no';
  lValue := GetSelectedValue(cboTeam);
  sTeam := lValue.ToString;
  lValue := GetSelectedValue(cboSport);
  sSport := lValue.ToString;
  request.Params.Clear;
  request.Params.AddItem('name',edtName.Text);
  request.Params.AddItem('content',memContent.Lines.GetText);
  request.Params.AddItem('date',DateToStr(edtDate.Date));
  request.Params.AddItem('published', sPublic);
  request.Params.AddItem('type',cboType.Selected.Text);
  request.Params.AddItem('public',cboPrivacy.Selected.Text);
  request.Params.AddItem('sub_type','FREE');
  request.Params.AddItem('team_id',sTeam);
  request.Params.AddItem('member_id',dmdDataModule.memberId);
  request.Params.AddItem('time',edtStartTime.Text);
  request.Params.AddItem('location',edtLocation.Text);
  request.Params.AddItem('end_time',edtEndTime.Text);
  request.Params.AddItem('end_date',DateToStr(edtEndDate.Date));
  request.Params.AddItem('sport_id',sSport);
end;

procedure TfrmEventCreation.btnNextClick(Sender: TObject);
begin
  inherited;
  if edtName.Text <> '' then
  begin
    expDetails.IsExpanded := false;
    expTimes.IsExpanded := true;
  end
  else
    showmessage('Please enter a name for the event');
end;

procedure TfrmEventCreation.btnSubmitClick(Sender: TObject);
begin
  inherited;
  // Validate..
  if validate then // true = invalid
  begin

  end
  else
  begin
    // if we have an id then updatre otherwise insert
    if id <> '' then
    begin
      // update
      addParams(dmdEvent.reqUpdateEvent);
      dmdEvent.reqUpdateEvent.Execute;
      showmessage('Event updated!');
      clearOutFields();
      formActivate(sender);
    end
    else
    begin
      // insert
      addParams(dmdEvent.reqCreateEvent);
      dmdEvent.reqCreateEvent.Execute;
      showmessage('Event created');
      close;
    end;
  end;

end;

procedure TfrmEventCreation.btnTimesNextClick(Sender: TObject);
begin
  inherited;
  expTimes.IsExpanded := false;
  expOptions.IsExpanded := true;
end;

procedure TfrmEventCreation.clearOutFields;
begin
  edtName.Text := '';
  edtLocation.Text := '';
  memContent.Lines.Clear;
end;

procedure TfrmEventCreation.FormActivate(Sender: TObject);
begin
  inherited;
  edtDate.Align := TAlignLayout.client;
  edtEndDate.Align := TAlignLayout.Client;
  getSportsAndTeams();
  if id <> '' then
  begin
    // Get data!
    with dmdEvent do
    begin
      rdsaEvent.ClearDataSet;
      fdmEvent.Close;
      respEvent.Content.Empty;
      reqEvent.ClearBody;
      reqEvent.Params.ParameterByName('id').Value := Id;
      reqEvent.Execute;
      edtDate.text := fdmEvent.FieldByName('date').AsString;
      edtEndDate.Text := fdmEvent.FieldByName('end_date').AsString;
    end;
  end
  else
  begin
    // just when inserting...
    edtDate.Data := '';
    edtEndDate.Data := '';
  end;
end;

procedure TfrmEventCreation.getAttending;
var
  sResult : String;
begin
  with dmdEvent do
  begin
      // Open up the data.
      rdsaAttending.ClearDataSet;
      fdmAttending.Close;
      respAttending.Content.Empty;
      reqAttending.ClearBody;
      reqAttending.Params.ParameterByName('id').Value := id;
      reqAttending.Params.ParameterByName('signature').Value := dmdDataModule.signature('getMember');
      reqAttending.Params.ParameterByName('key').Value := dmdDataModule.getApiKey;
      try
        reqAttending.Execute;
      except on E: Exception do
      end;
      sResult := getResultString(respAttending.Content);
      if (sResult = 'OK') then
      begin
          rdsaAttending.Response := respAttending;
          fdmAttending.Open;
      end;
  end;
end;

procedure TfrmEventCreation.getSportsAndTeams;
var
  sResult : String;
begin
  with dmdEvent do
  begin
    // Open up the data.
    rdsaSports.ClearDataSet;
    fdmSports.Close;
    respSports.Content.Empty;
    reqSports.ClearBody;
    reqSports.Params.ParameterByName('id').Value := dmdDataModule.memberId;
    reqSports.Execute;
    sResult := getResultString(respSports.Content);
    if (sResult = 'OK') then
    begin
        rdsaSports.Response := respSports;
        fdmSports.Open;
    end;
    // Open up the data.
    rdsaTeams.ClearDataSet;
    fdmTeams.Close;
    respTeams.Content.Empty;
    reqTeams.ClearBody;
    reqTeams.Params.ParameterByName('id').Value := dmdDataModule.memberId;
    reqTeams.Execute;
    sResult := getResultString(respTeams.Content);
    if (sResult = 'OK') then
    begin
        rdsaTeams.Response := respTeams;
        fdmTeams.Open;
    end;
  end;
end;

procedure TfrmEventCreation.getWall;
var
  sResult : String;
begin
  with dmdEvent do
  begin
      // Open up the data.
      rdsaWall.ClearDataSet;
      fdmWall.Close;
      respWall.Content.Empty;
      reqWall.ClearBody;
      reqWall.Params.ParameterByName('id').Value := id;
      reqWall.Params.ParameterByName('signature').Value := dmdDataModule.signature('getMember');
      reqWall.Params.ParameterByName('key').Value := dmdDataModule.getApiKey;
      try
        reqWall.Execute;
      except on E: Exception do
      end;
      sResult := getResultString(respWall.Content);
      if (sResult = 'OK') then
      begin
          rdsaWall.Response := respWall;
          fdmWall.Open;
      end;
  end;
end;

function TfrmEventCreation.validate: boolean;
var
  invalid : boolean;
  errors  : String;
begin
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
  if not(Assigned(cboSport.Selected)) then
  begin
    invalid := true;
    cboSport.SetFocus;
    errors := errors + 'Sport ';
  end;
  if not(Assigned(cboTeam.Selected)) then
  begin
    invalid := true;
    cboTeam.SetFocus;
    errors := errors + 'Team';
  end;
  if invalid then
    showmessage('Please complete the following fields ' + errors);
  result := invalid;
end;

initialization
RegisterFMXClasses([TfrmEventCreation]);

end.
