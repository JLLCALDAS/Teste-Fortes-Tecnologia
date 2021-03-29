unit UdtmCadastroBomba;

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
  TdtmCadastroBomba = class(TDataModule)
    qryBomba: TFDQuery;
    qryBombaID_BOMBA: TIntegerField;
    qryBombaDESCRICAO: TStringField;
    qryBombaSIGLA: TStringField;
    qryBombaID_TANQUECOMBUSTIVEL: TIntegerField;
    qryBombaDSC_TANQUECOMBUSTIVEL: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmCadastroBomba: TdtmCadastroBomba;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
