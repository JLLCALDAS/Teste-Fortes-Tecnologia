unit UAbastecimento;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  System.Rtti,
  System.Bindings.Outputs,
  Data.Bind.EngExt,
  Data.Bind.Components,
  Data.Bind.DBScope,
  Data.DB,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
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
  Vcl.Bind.DBEngExt,
  Vcl.Bind.Editors,
  UCadastroPadraoF,
  UdtmAbastecimento,
  FrmPesquisaF;


type
  TfrmAbastecimento = class(TfrmCadastroPadrao)
    lblCodigo: TLabel;
    edtCodigo: TDBEdit;
    lblCliente: TLabel;
    edtCliente: TDBEdit;
    lblBomba: TLabel;
    edtBomba: TDBEdit;
    lblCombustivel: TLabel;
    edtCodCombustivel: TDBEdit;
    edtCombustivel: TDBEdit;
    lblAbastecimento: TLabel;
    edtAbastecimento: TDBEdit;
    lblImposto: TLabel;
    edtImposto: TDBEdit;
    lblQuantidade: TLabel;
    edtQuantidade: TDBEdit;
    lblValorLitro: TLabel;
    edtValorLitro: TDBEdit;
    lblTotalAbastecimento: TLabel;
    edtTotalAbastecimento: TDBEdit;
    edtCodBomba: TButtonedEdit;
    edtCodCliente: TButtonedEdit;
    BindSourceAbastecimento: TBindSourceDB;
    LinkControlToFieldID_CLIENTE: TLinkControlToField;
    BindingsListAbastecimento: TBindingsList;
    LinkControlToFieldID_BOMBA: TLinkControlToField;
    lblTotalImposto: TLabel;
    edtTotalImposto: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodClienteRightButtonClick(Sender: TObject);
    procedure edtCodBombaRightButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FrmPesquisar: TfrmPesquisa;
  public
    { Public declarations }
  end;

var
  frmAbastecimento: TfrmAbastecimento;

implementation

{$R *.dfm}

const
  sqlCliente = 'select '+
               '  abc_cliente.id_cliente, '+
               '  abc_cliente.nome as dsc_cliente, '+
               '  abc_cliente.cpf_cnpj '+
               'from '+
               '  abc_cliente';
  SqlBomba = 'select '+
             '  abc_bombas.id_bomba, '+
             '  abc_bombas.descricao as dsc_bomba, '+
             '  abc_bombas.id_tanquecombustivel, '+
             '  abc_tanquecombustivel.descricao as dsc_tanquecombustivel '+
             'from '+
             '  abc_bombas '+
             '  inner join abc_tanquecombustivel on '+
             '    abc_tanquecombustivel.id_tanquecombustivel = abc_bombas.id_tanquecombustivel ';

procedure TfrmAbastecimento.FormCreate(Sender: TObject);
begin
  dtmAbastecimento:=TdtmAbastecimento.Create(Self);
  inherited;
end;

procedure TfrmAbastecimento.FormShow(Sender: TObject);
begin
  dtsPadrao.DataSet:=dtmAbastecimento.qryAbastecimento;
  inherited;
end;

procedure TfrmAbastecimento.edtCodClienteRightButtonClick(Sender: TObject);
begin
  inherited;
  try
    if dtsPadrao.DataSet.State in [dsInsert,dsEdit] then
    begin
      FrmPesquisar:=TfrmPesquisa.Create(Self);
      FrmPesquisar.Pesquisar(Self,sqlCliente,['Código','Descrição','CPF/CNPJ'],['id_cliente','dsc_cliente','cpf_cnpj'],['id_cliente','dsc_cliente'],[dtsPadrao.DataSet.FieldByName('id_cliente'),dtsPadrao.DataSet.FieldByName('dsc_cliente')],'Pesquisa de Clientes');
    end;
  finally
    FreeAndNil(FrmPesquisar);
  end;
end;

procedure TfrmAbastecimento.edtCodBombaRightButtonClick(Sender: TObject);
begin
  inherited;
  try
    if dtsPadrao.DataSet.State in [dsInsert,dsEdit] then
    begin
      FrmPesquisar:=TfrmPesquisa.Create(Self);
      FrmPesquisar.Pesquisar(Self,SqlBomba,['Bomba','Descrição','Tanque','Descrição'],['id_bomba','dsc_bomba','id_tanquecombustivel','dsc_tanquecombustivel'],['id_bomba','dsc_bomba','id_tanquecombustivel','dsc_tanquecombustivel'],[dtsPadrao.DataSet.FieldByName('id_bomba'),dtsPadrao.DataSet.FieldByName('dsc_bomba'),dtsPadrao.DataSet.FieldByName('id_tanquecombustivel'),dtsPadrao.DataSet.FieldByName('dsc_tanquecombustivel')],'Pesquisa de Bombas');
    end;
  finally
    FreeAndNil(FrmPesquisar);
  end;
end;

procedure TfrmAbastecimento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:=caFree;
  frmAbastecimento:=nil;
end;

end.
