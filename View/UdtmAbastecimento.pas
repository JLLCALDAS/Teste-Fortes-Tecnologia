unit UdtmAbastecimento;

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
  TdtmAbastecimento = class(TDataModule)
    qryAbastecimento: TFDQuery;
    qryAbastecimentoID_ABASTECIMENTO: TIntegerField;
    qryAbastecimentoID_CLIENTE: TIntegerField;
    qryAbastecimentoDSC_CLIENTE: TStringField;
    qryAbastecimentoID_BOMBA: TIntegerField;
    qryAbastecimentoDSC_BOMBA: TStringField;
    qryAbastecimentoDATA_ABASTECIMENTO: TSQLTimeStampField;
    qryAbastecimentoIMPOSTO_ABASTECIMENTO: TFMTBCDField;
    qryAbastecimentoQTD_LITRO: TBCDField;
    qryAbastecimentoVLR_LITRO: TBCDField;
    qryAbastecimentoTOTAL_ABASTECIMENTO: TFMTBCDField;
    qryAbastecimentoID_TANQUECOMBUSTIVEL: TIntegerField;
    qryAbastecimentoDSC_TANQUECOMBUSTIVEL: TStringField;
    qryAbastecimentoTOTAL_IMPOSTO: TFMTBCDField;
    procedure qryAbastecimentoQTD_LITROChange(Sender: TField);
    procedure qryAbastecimentoVLR_LITROChange(Sender: TField);
    procedure qryAbastecimentoTOTAL_ABASTECIMENTOChange(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmAbastecimento: TdtmAbastecimento;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdtmAbastecimento.qryAbastecimentoQTD_LITROChange(Sender: TField);
begin
  qryAbastecimento.FieldByName('total_abastecimento').AsFloat:=qryAbastecimento.FieldByName('qtd_litro').AsFloat * qryAbastecimento.FieldByName('vlr_litro').AsFloat;
end;

procedure TdtmAbastecimento.qryAbastecimentoTOTAL_ABASTECIMENTOChange(Sender: TField);
begin
  qryAbastecimento.FieldByName('total_imposto').AsFloat:=qryAbastecimento.FieldByName('total_abastecimento').AsFloat + (qryAbastecimento.FieldByName('total_abastecimento').AsFloat * (qryAbastecimento.FieldByName('imposto_abastecimento').AsFloat/100));
end;

procedure TdtmAbastecimento.qryAbastecimentoVLR_LITROChange(Sender: TField);
begin
  qryAbastecimento.FieldByName('total_abastecimento').AsFloat:=qryAbastecimento.FieldByName('qtd_litro').AsFloat * qryAbastecimento.FieldByName('vlr_litro').AsFloat;
end;

end.
