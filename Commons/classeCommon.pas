unit classeCommon;

interface
  uses vcl.DBGrids, IdHashMessageDigest, Classes, SysUtils;

type
  TTipoOperacao = (toIncluir, toAlterar, toExcluir, toSalvar, toCancelar,
                   toEncerrar, toBuscar, toPrimeiro, toAnterior, toProximo,
                   toUltimo, toImprimir, toAjuda, toSair, toNenhuma);
  TLogin = class
    private
      login: string;
      senha: string;
      data_hora: string;
      email: string;
    public
      constructor createLogin;
      procedure setLogin(pLogin: string);
      function getLogin: string;
      procedure setSenha(pSenha: string);
      function getSenha: string;
      procedure setDataHora(pDataHora: string);
      function getDataHora: string;
      procedure setEmail(pEmail: string);
      function getEmail: string;
      destructor destroyLogin;
  end;

  Tmd5 = class
    private
      { Private declarations }
    public
      function Encript(str: string): string;
      function Decript(str: string): string;
  end;

  TFuncoes = class
    private
      {Private declarations}
    public
      function ObterNomeCampoGrid(Grid: TDBGrid; Campo: string): string;
  end;
implementation

{ Tmd5 }
function Tmd5.Decript(str: string): string;
var
  Md5: TIdHashMessageDigest5;
  vValue: string;
begin
  Md5:= TIdHashMessageDigest5.Create;
  //vValue:=Md5.(str);
  Result:=vValue;
end;

function Tmd5.Encript(str: string): string;
var
  Md5: TIdHashMessageDigest5;
  vValue: string;
begin
  try
    Md5:= TIdHashMessageDigest5.Create;
    vValue:=Md5.HashStringAsHex(str);
    Result:=vValue;
  finally
    FreeAndNil(Md5);
  end;
end;

{ TFuncoes }

function TFuncoes.ObterNomeCampoGrid(Grid: TDBGrid; Campo: string): string;
var
  i: integer;
begin
  Result:='';
  for i:=0 to Pred(Grid.Columns.Count) do
    if AnsiLowerCase(Grid.Columns[i].Title.Caption)=AnsiLowerCase(Campo) then
    begin
      Result:=Grid.Columns[i].FieldName;
      Break;
    end;
end;

{ TLogin }

constructor TLogin.createLogin;
begin
  login:='';
  senha:='';
  data_hora:='';
  email:='';
end;

destructor TLogin.destroyLogin;
begin

end;

function TLogin.getDataHora: string;
begin
  Result:=data_hora;
end;

function TLogin.getEmail: string;
begin
  Result:=email;
end;

function TLogin.getLogin: string;
begin
  Result:=login;
end;

function TLogin.getSenha: string;
begin
  Result:=senha;
end;

procedure TLogin.setDataHora(pDataHora: string);
begin
  data_hora:=pDataHora;
end;

procedure TLogin.setEmail(pEmail: string);
begin
  email:=pEmail;
end;

procedure TLogin.setLogin(pLogin: string);
begin
  login:=pLogin;
end;

procedure TLogin.setSenha(pSenha: string);
begin
  senha:=pSenha;
end;

end.
