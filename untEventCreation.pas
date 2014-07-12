unit untEventCreation;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untBaseForm, FMX.Objects, FMX.Edit, untEventDataModule, FMX.Layouts, FMX.Memo,
  FMX.DateTimeCtrls, FMX.ListBox;

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
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure getAttending;
    procedure getWall;
  public
    { Public declarations }
  end;


implementation

uses
  untMainForm, untDataModule;

{$R *.fmx}
procedure TfrmEventCreation.FormActivate(Sender: TObject);
begin
  inherited;
  if id <> '' then
  begin
    // Get data!
  end;
  edtDate.Align := TAlignLayout.client;
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
