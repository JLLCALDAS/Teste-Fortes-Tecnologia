unit UMenu;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  System.ImageList,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ActnMenus,
  Vcl.ImgList,
  Vcl.ActnList,
  Vcl.ToolWin,
  Vcl.ActnMan,
  Vcl.ActnCtrls,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.Menus,
  Vcl.Imaging.pngimage,
  Vcl.ExtCtrls,
  UdtmUsuario,
  UCadastroCliente,
  UCadastroTanqueCombustivel,
  UCadastroBomba,
  UAbastecimento,
  UParametroRelAbastecimento;

type
  TfrmMenu = class(TForm)
    actionMenu: TActionManager;
    actCliente: TAction;
    actBombas: TAction;
    actTanqueCombustivel: TAction;
    actAbastecimento: TAction;
    actMenu: TActionToolBar;
    imgMenu: TImageList;
    actSair: TAction;
    Image1: TImage;
    actRelAbastecimento: TAction;
    actRelatorios: TAction;
    procedure actClienteExecute(Sender: TObject);
    procedure actTanqueCombustivelExecute(Sender: TObject);
    procedure actBombasExecute(Sender: TObject);
    procedure actAbastecimentoExecute(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actRelAbastecimentoExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

{$R *.dfm}

procedure TfrmMenu.actClienteExecute(Sender: TObject);
begin
  if FrmCadastroCliente=nil then
    FrmCadastroCliente:=TFrmCadastroCliente.Create(Self);
  FrmCadastroCliente.Show;
end;

procedure TfrmMenu.actTanqueCombustivelExecute(Sender: TObject);
begin
  if frmCadastroTanqueCombustivel=nil then
    frmCadastroTanqueCombustivel:=TfrmCadastroTanqueCombustivel.Create(Self);
  frmCadastroTanqueCombustivel.Show;
end;

procedure TfrmMenu.actBombasExecute(Sender: TObject);
begin
  if frmCadastroBomba=nil then
    frmCadastroBomba:=TfrmCadastroBomba.Create(Self);
  frmCadastroBomba.Show;
end;

procedure TfrmMenu.actAbastecimentoExecute(Sender: TObject);
begin
  if frmAbastecimento=nil then
    frmAbastecimento:=TfrmAbastecimento.Create(Self);
  frmAbastecimento.Show;
end;

procedure TfrmMenu.actRelAbastecimentoExecute(Sender: TObject);
begin
  if frmParamRelAbastecimento=nil then
    frmParamRelAbastecimento:=TfrmParamRelAbastecimento.Create(Self);
  frmParamRelAbastecimento.Show;
end;

procedure TfrmMenu.actSairExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dtmUsuario.Login.destroyLogin;
  Application.Terminate;
end;

end.
