unit URelatoriosAbastecimentosPeriodo;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  RLReport,
  Vcl.Imaging.pngimage,
  Data.DB,
  UdtmRelatoriosAbastecimentosPeriodo;

type
  TfrmRelatorioAbastecimento = class(TForm)
    rlAbastecimentos: TRLReport;
    bndTitulo: TRLBand;
    lbltitulo: TRLLabel;
    pnlLogo: TRLPanel;
    imgLogo: TRLImage;
    grpAbastecimento: TRLGroup;
    dtsAbastecimentos: TDataSource;
    bndDataAbastecimento: TRLBand;
    lblDataAbastecimento: TRLLabel;
    txtDataAbastecimento: TRLDBText;
    grpTanqueCombustivel: TRLGroup;
    bndTanqueCombustivel: TRLBand;
    lblTanqueCombustivel: TRLLabel;
    txtTanqueCombustivel: TRLDBText;
    bndTotalAbastecimento: TRLBand;
    bndDadosRelatorio: TRLBand;
    lblCliente: TRLLabel;
    lblBomba: TRLLabel;
    lblQuantidade: TRLLabel;
    lblValor: TRLLabel;
    lblTotal: TRLLabel;
    lblImposto: TRLLabel;
    bndDetalhesAbastecimento: TRLBand;
    memCliente: TRLDBMemo;
    txtBomba: TRLDBText;
    txtQuantidade: TRLDBText;
    txtImposto: TRLDBText;
    txtValor: TRLDBText;
    txtTotal: TRLDBText;
    lblTotalAbastecimento: TRLLabel;
    bndTotalGeral: TRLBand;
    lblTotalGeral: TRLLabel;
    lblVlrTotalGeral: TRLLabel;
    lblQtdTotalGeral: TRLLabel;
    lblQtdTotalAbast: TRLLabel;
    lblVlrTotalAbast: TRLLabel;
    bndRodape: TRLBand;
    RLSystemInfo1: TRLSystemInfo;
    lblDataRodape: TRLLabel;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel1: TRLLabel;
    bndEspacamentoCabecalho: TRLBand;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rlAbastecimentosBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure grpTanqueCombustivelBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure bndDetalhesAbastecimentoBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure bndTotalAbastecimentoBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure bndTotalGeralBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure bndTituloBeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    DataIni, DataFim: string;
    QtdTotalAbast, VlrTotalAbast: Double;
    QtdTotalGeral, VlrTotalGeral: Double;
  public
    constructor Create(AOwner :TComponent; pDataIni, pDataFim: string);
  end;

var
  frmRelatorioAbastecimento: TfrmRelatorioAbastecimento;

implementation

{$R *.dfm}

constructor TfrmRelatorioAbastecimento.Create(AOwner: TComponent; pDataIni, pDataFim: string);
begin
  inherited Create(AOwner);
  Self.DataIni:=pDataIni;
  Self.DataFim:=pDataFim;
end;

procedure TfrmRelatorioAbastecimento.FormCreate(Sender: TObject);
begin
  dtmRelatorioAbastecimento:=TdtmRelatorioAbastecimento.Create(Self);
end;

procedure TfrmRelatorioAbastecimento.rlAbastecimentosBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  dtsAbastecimentos.DataSet.Close;
  dtmRelatorioAbastecimento.qryAbastecimentos.ParamByName('data_ini').AsString:=DataIni;
  dtmRelatorioAbastecimento.qryAbastecimentos.ParamByName('data_fim').AsString:=DataFim;
  dtsAbastecimentos.DataSet.Open;
  PrintIt:=(not dtsAbastecimentos.DataSet.IsEmpty);
  QtdTotalGeral:=0.00;
  VlrTotalGeral:=0.00;

  if not PrintIt then
  begin
    Application.MessageBox('Nenhum Registro Encontrado para o período informado. Verifique!!!','Informação',MB_OK+MB_ICONINFORMATION);
    rlAbastecimentos.ClosePreview;
    Exit;
  end;
end;

procedure TfrmRelatorioAbastecimento.grpTanqueCombustivelBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  QtdTotalAbast:=0.00;
  VlrTotalAbast:=0.00;
end;

procedure TfrmRelatorioAbastecimento.bndDetalhesAbastecimentoBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  QtdTotalAbast:=QtdTotalAbast+dtsAbastecimentos.DataSet.FieldByName('qtd_litro').AsFloat;
  VlrTotalAbast:=VlrTotalAbast+dtsAbastecimentos.DataSet.FieldByName('total_abastecimento').AsFloat;
  QtdTotalGeral:=QtdTotalGeral+dtsAbastecimentos.DataSet.FieldByName('qtd_litro').AsFloat;
  VlrTotalGeral:=VlrTotalGeral+dtsAbastecimentos.DataSet.FieldByName('total_abastecimento').AsFloat;
end;

procedure TfrmRelatorioAbastecimento.bndTituloBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  lbltitulo.Caption:='ABASTECIMENTOS '+DataIni+' A '+DataFim;
end;

procedure TfrmRelatorioAbastecimento.bndTotalAbastecimentoBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  lblQtdTotalAbast.Caption:=FormatFloat(',0.0000',QtdTotalAbast);
  lblVlrTotalAbast.Caption:=FormatFloat(',0.0000',VlrTotalAbast);
end;

procedure TfrmRelatorioAbastecimento.bndTotalGeralBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  lblQtdTotalGeral.Caption:=FormatFloat(',0.0000',QtdTotalGeral);
  lblVlrTotalGeral.Caption:=FormatFloat(',0.0000',VlrTotalGeral);
end;

procedure TfrmRelatorioAbastecimento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dtmRelatorioAbastecimento.qryAbastecimentos.Close;
  rlAbastecimentos.ClosePreview;
  Action:=caFree;
  frmRelatorioAbastecimento:=nil;
end;

end.
