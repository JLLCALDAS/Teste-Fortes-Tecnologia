unit ULogin;

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
  Vcl.StdCtrls,
  Vcl.Mask,
  JvExMask,
  JvToolEdit,
  Vcl.Imaging.pngimage,
  Vcl.ExtCtrls,
  dtmConections,
  UdtmUsuario,
  UMenu;

type
  TfrmLogin = class(TForm)
    pblLogo: TPanel;
    imgLogo: TImage;
    pblDadosLogin: TPanel;
    lblUsuario: TLabel;
    lblSenha: TLabel;
    lblData: TLabel;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    btnEntrar: TButton;
    btnSair: TButton;
    edtData: TMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSairClick(Sender: TObject);
    procedure btnEntrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
var
  vCnx: boolean;
  vCredentials: boolean;
begin
  try
    vCnx:=dtmConection.VerificaConexao;
    if not vCnx then
      vCnx:=dtmConection.Conectar;
  except
    on E: Exception do
    Application.MessageBox(PChar('Erro ao tentar logar no sistema: '+e.Message),'Erro Conexão!!',MB_OK+MB_ICONERROR);
  end;

  try
    if vCnx then
      vCredentials:=dtmUsuario.Logon(edtUsuario.Text,edtSenha.Text);
    if not vCredentials then
      Application.MessageBox('Usuário ou Senha inválido. Verifique!!!','Atenção',mrOk+MB_ICONWARNING);
  except
    on E: Exception do
    Application.MessageBox(PChar('Erro ao logar no sistema: '+e.Message),'Erro Login!!')
  end;

  if vCredentials then
  begin
    if Assigned(frmMenu) then
    begin
      frmLogin.Hide;
      frmMenu.Show;
    end;
  end;
end;

procedure TfrmLogin.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
  frmLogin:=nil;
  Application.Terminate;
end;

procedure TfrmLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    Self.Perform(WM_NEXTDLGCTL,0,0);
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  ModalResult:=mrNone;
  edtdata.Text:=DateToStr(Now);
end;

end.
