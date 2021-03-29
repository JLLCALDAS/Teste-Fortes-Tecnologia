unit UdtmCadastroUsuario;

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
  classeCommon,
  dtmConections;

type
  TdtmCadastroUsuario = class(TDataModule)
    qryUsuario: TFDQuery;
    qryUsuarioID_USUARIO: TIntegerField;
    qryUsuarioLOGIN: TStringField;
    qryUsuarioSENHA: TStringField;
    qryUsuarioEMAIL: TStringField;
    procedure qryUsuarioBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmCadastroUsuario: TdtmCadastroUsuario;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdtmCadastroUsuario.qryUsuarioBeforePost(DataSet: TDataSet);
var
  Md5: Tmd5;
begin
  try
    Md5:=Tmd5.Create;
    qryUsuario.FieldByName('senha').AsString:=Md5.Encript(qryUsuario.FieldByName('senha').AsString);
  finally
    Md5.Free;
  end;
end;

end.
