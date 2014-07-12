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
begin
  request.Params.AddItem('name',edtName.Text);
  request.Params.AddItem('content',memContent.Lines.GetText);
  request.Params.AddItem('date',DateToStr(edtDate.Date));
  request.Params.AddItem('published','value');
  request.Params.AddItem('type',cboType.Items[cboType.ItemIndex]);
  request.Params.AddItem('sub_type','value');
  request.Params.AddItem('public','value');
  request.Params.AddItem('team_id','value');
  request.Params.AddItem('member_id','value');
  request.Params.AddItem('time','value');
  request.Params.AddItem('location','value');
  request.Params.AddItem('end_time','value');
  request.Params.AddItem('end_date','value');
  request.Params.AddItem('sport_id','value');
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
begin
  inherited;
  if id <> '' then
  begin
    // Get data!
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
