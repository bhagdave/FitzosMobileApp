unit untEventCreation;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, untEventDataModule, FMX.Layouts, FMX.Memo,
  FMX.DateTimeCtrls, FMX.ListBox,REST.Client;

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
    cboFee: TComboBox;
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
    procedure FormActivate(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnTimesNextClick(Sender: TObject);
    procedure btnSubmitClick(Sender: TObject);
  private
    { Private declarations }
    procedure getAttending;
    procedure getWall;
    procedure addParams(request : TRestRequest);
  public
    { Public declarations }
  end;


implementation

uses
  untMainForm, untDataModule;

{$R *.fmx}
procedure TfrmEventCreation.addParams(request: TRestRequest);
var
  sPublic : String;
begin
  if cbPublished.IsChecked then
    sPublic := 'yes'
  else
    sPublic := 'no';
  request.Params.AddItem('name',edtName.Text);
  request.Params.AddItem('content',memContent.Lines.GetText);
  request.Params.AddItem('date',DateToStr(edtDate.Date));
  request.Params.AddItem('published', sPublic);
  request.Params.AddItem('type',cboType.Selected.Text);
  request.Params.AddItem('sub_type',cboFee.Selected.Text);
  request.Params.AddItem('public','PUBLIC');
  request.Params.AddItem('team_id',IntToStr(cboTeam.Selected.Tag));
  request.Params.AddItem('member_id',dmdDataModule.memberId);
  request.Params.AddItem('time',edtStartTime.Text);
  request.Params.AddItem('location',edtLocation.Text);
  request.Params.AddItem('end_time',edtEndTime.Text);
  request.Params.AddItem('end_date',DateToStr(edtEndDate.Date));
  request.Params.AddItem('sport_id',IntToStr(cboSport.Selected.Tag));
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
// if we have an id then updatre otherwise insert
  if id <> '' then
  begin
    // update

  end
  else
  begin
    // insert
    addParams(dmdEvent.reqCreateEvent);
    dmdEvent.reqCreateEvent.Execute;
    showmessage(dmdEvent.respCreateEvent.Content);
  end;
end;

procedure TfrmEventCreation.btnTimesNextClick(Sender: TObject);
begin
  inherited;
  expTimes.IsExpanded := false;
  expOptions.IsExpanded := true;
end;

procedure TfrmEventCreation.FormActivate(Sender: TObject);
var
  sResult : String;
begin
  inherited;
  if id <> '' then
  begin
    // Get data!
  end;
    with dmdEvent do
    begin
      // Open up the data.
      rdsaSports.ClearDataSet;
      fdmSports.Close;
      respSports.Content.Empty;
      reqSports.ClearBody;
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
      reqTeams.Execute;
      sResult := getResultString(respTeams.Content);
      if (sResult = 'OK') then
      begin
          rdsaTeams.Response := respTeams;
          fdmTeams.Open;
      end;
    end;
  edtDate.Align := TAlignLayout.client;
  edtEndDate.Align := TAlignLayout.Client;
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

initialization
RegisterFMXClasses([TfrmEventCreation]);

end.
