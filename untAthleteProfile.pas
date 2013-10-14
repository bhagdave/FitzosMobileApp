unit untAthleteProfile;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, IPPeerClient, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Data.DB, Datasnap.DBClient,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.DBScope;

type
  TfrmAthleteProfile = class(TForm)
    pnlProfile: TPanel;
    lblCaption: TLabel;
    edtAge: TEdit;
    gbGender: TGroupBox;
    btnMale: TRadioButton;
    btnFemale: TRadioButton;
    edtLocation: TEdit;
    edtNickName: TEdit;
    restServer: TRESTClient;
    openSession: TRESTRequest;
    restData: TRESTResponse;
    restAdapter: TRESTResponseDataSetAdapter;
    cdsAthlete: TClientDataSet;
    getAthlete: TRESTRequest;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.fmx}

end.
