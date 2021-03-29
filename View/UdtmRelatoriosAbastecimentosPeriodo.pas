unit UdtmRelatoriosAbastecimentosPeriodo;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  dtmConections;

type
  TdtmRelatorioAbastecimento = class(TDataModule)
    qryAbastecimentos: TFDQuery;
    qryAbastecimentosID_ABASTECIMENTO: TIntegerField;
    qryAbastecimentosID_CLIENTE: TIntegerField;
    qryAbastecimentosDSC_CLIENTE: TStringField;
    qryAbastecimentosID_BOMBA: TIntegerField;
    qryAbastecimentosDSC_BOMBA: TStringField;
    qryAbastecimentosID_TANQUECOMBUSTIVEL: TIntegerField;
    qryAbastecimentosDSC_TANQUECOMBUSTIVEL: TStringField;
    qryAbastecimentosDATA_ABASTECIMENTO: TSQLTimeStampField;
    qryAbastecimentosIMPOSTO_ABASTECIMENTO: TFMTBCDField;
    qryAbastecimentosQTD_LITRO: TBCDField;
    qryAbastecimentosVLR_LITRO: TBCDField;
    qryAbastecimentosTOTAL_ABASTECIMENTO: TFMTBCDField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmRelatorioAbastecimento: TdtmRelatorioAbastecimento;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
