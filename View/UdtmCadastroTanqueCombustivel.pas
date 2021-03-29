unit UdtmCadastroTanqueCombustivel;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  dtmConections;

type
  TdtmCadastroTanqueCombustivel = class(TDataModule)
    qryTanqueCombustivel: TFDQuery;
    qryTanqueCombustivelID_TIPOCOMBUSTIVEL: TIntegerField;
    qryTanqueCombustivelDESCRICAO: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmCadastroTanqueCombustivel: TdtmCadastroTanqueCombustivel;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
