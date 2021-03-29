unit UdtmUsuario;

interface

uses
  System.SysUtils,
  System.Classes,
  System.IniFiles,
  System.IOUtils,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  classeCommon,
  dtmConections;

type
  TdtmUsuario = class(TDataModule)
    qryUser: TFDQuery;
  private
    { Private declarations }
  public
    Login: TLogin;
    function Logon(user, pass: string): boolean;
  end;

var
  dtmUsuario: TdtmUsuario;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TdtmUsuario.Logon(user, pass: string): boolean;
var
  Md5: Tmd5;
  vPass: string;
  vCredentials: boolean;
  SqlOrigin: string;
begin
  try
    if dtmConection.VerificaConexao then
    begin
      SqlOrigin:=qryUser.SQL.Text;
      Md5:=Tmd5.Create;
      Login:=TLogin.createLogin;
      vPass:=Md5.Encript(pass);
      vCredentials:=False;
      if qryUser.Active then
        qryUser.Close;
      qryUser.SQL.Text:=Format(qryUser.SQL.Text,[user,vPass]);
      qryUser.Open;
      vCredentials:=(not qryUser.IsEmpty);
      if vCredentials then
      begin
        Login.setLogin(qryUser.FieldByName('login').AsString);
        Login.setDataHora(FormatDateTime('dd/mm/yyyy hh:mm',Now));
        Login.setEmail(qryUser.FieldByName('email').AsString);
      end;
      Result:=(vCredentials);
    end;
  finally
    qryUser.SQL.Text:=SqlOrigin;
    qryUser.Close;
    FreeAndNil(Md5);
  end;
end;

end.
