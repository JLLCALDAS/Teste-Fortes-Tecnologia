unit UCadastroCliente;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.JSON,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  UCadastroPadraoF,
  Data.DB,
  System.ImageList,
  Vcl.ImgList,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.Buttons,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.ToolWin,
  Vcl.DBCtrls,
  REST.Types,
  REST.Client,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  UdtmCadastroCliente, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.DBScope;

type
  TfrmCadastroCliente = class(TfrmCadastroPadrao)
    lblCliente: TLabel;
    edtCliente: TDBEdit;
    lblDescricao: TLabel;
    edtDescricao: TDBEdit;
    lblCep: TLabel;
    lblCpfCnpj: TLabel;
    edtCpfCnpj: TDBEdit;
    lblLogradouro: TLabel;
    edtLogradouro: TDBEdit;
    lblNumero: TLabel;
    edtNumero: TDBEdit;
    lblComplemento: TLabel;
    edtComplemento: TDBEdit;
    lblCidade: TLabel;
    edtCidade: TDBEdit;
    lblUf: TLabel;
    edtUf: TDBEdit;
    rgpTipoPessoa: TDBRadioGroup;
    RESTIbge: TRESTClient;
    RESTRequestIbge: TRESTRequest;
    RESTResponseIbge: TRESTResponse;
    edtCep: TButtonedEdit;
    BindSourceCEP: TBindSourceDB;
    LinkControlToFieldCEP: TLinkControlToField;
    BindingsListCEP: TBindingsList;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rgpTipoPessoaClick(Sender: TObject);
    procedure edtCepRightButtonClick(Sender: TObject);
  private
    function LimparFormatacao(FieldValue: string): string;
  public
    { Public declarations }
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

{$R *.dfm}

procedure TfrmCadastroCliente.FormCreate(Sender: TObject);
begin
  dtmCliente:=TdtmCliente.Create(Self);
  inherited;
end;

procedure TfrmCadastroCliente.FormShow(Sender: TObject);
begin
  dtsPadrao.DataSet:=dtmCliente.qryCliente;
  inherited;
  RESTIbge.BaseURL:='https://api.postmon.com.br/v1';
  RESTRequestIbge.Method:=rmGET;
end;

function TfrmCadastroCliente.LimparFormatacao(FieldValue: string): string;
var
  vValue: string;
begin
  vValue:=StringReplace(FieldValue,'.','',[rfReplaceAll]);
  vValue:=StringReplace(FieldValue,'-','',[rfReplaceAll]);
  Result:=vValue;
end;

procedure TfrmCadastroCliente.rgpTipoPessoaClick(Sender: TObject);
begin
  inherited;
  dtsPadrao.DataSet.FieldByName('cpf_cnpj').EditMask:='999.999.999-99';
  if rgpTipoPessoa.ItemIndex=1 then
    dtsPadrao.DataSet.FieldByName('cpf_cnpj').EditMask:='99.999.999/9999-99';
end;

procedure TfrmCadastroCliente.edtCepRightButtonClick(Sender: TObject);
var
  json: TJSONObject;
  JsonCidadeInfo: TJSONObject;
  JsonEstadoInfo: TJSONObject;
  Logradouro: string;
begin
  RESTRequestIbge.Resource:='cep/'+LimparFormatacao(edtCep.Text);
  RESTRequestIbge.Execute;
  try
    json:=RESTResponseIbge.JSONValue as TJSONObject;
    JsonCidadeInfo:=json.Values['cidade_info'] as TJSONObject;
    JsonEstadoInfo:=json.Values['estado_info'] as TJSONObject;

    if json.Values['logradouro']<>nil then
      Logradouro:=json.Values['logradouro'].Value;
    dtsPadrao.DataSet.FieldByName('cep').AsString:=edtCep.Text;
    dtsPadrao.DataSet.FieldByName('logradouro').AsString:=Logradouro;
    dtsPadrao.DataSet.FieldByName('cidade').AsString:=json.Values['cidade'].Value;
    dtsPadrao.DataSet.FieldByName('sigla_uf').AsString:=json.Values['estado'].Value;
  finally
    RESTRequestIbge.ResetToDefaults;
  end;
end;

procedure TfrmCadastroCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:=caFree;
  frmCadastroCliente:=nil;
end;

end.
