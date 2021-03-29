unit UdtmCadastroCliente;

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
  TdtmCliente = class(TDataModule)
    qryCliente: TFDQuery;
    qryClienteID_CLIENTE: TIntegerField;
    qryClienteNOME: TStringField;
    qryClienteCEP: TStringField;
    qryClienteTIPO_PESSOA: TStringField;
    qryClienteCPF_CNPJ: TStringField;
    qryClienteLOGRADOURO: TStringField;
    qryClienteNUMERO: TStringField;
    qryClienteCOMPLEMENTO: TStringField;
    qryClienteCIDADE: TStringField;
    qryClienteSIGLA_UF: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmCliente: TdtmCliente;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
