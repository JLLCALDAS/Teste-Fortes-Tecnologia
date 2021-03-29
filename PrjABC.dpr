program PrjABC;

uses
  System.SysUtils,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  ULogin in 'ULogin.pas' {frmLogin},
  classeCommon in 'Commons\classeCommon.pas',
  dtmConections in 'Conections\dtmConections.pas' {dtmConection: TDataModule},
  UdtmUsuario in 'UdtmUsuario.pas' {dtmUsuario: TDataModule},
  UMenu in 'View\UMenu.pas' {frmMenu},
  UCadastroPadraoF in 'View\UCadastroPadraoF.pas' {frmCadastroPadrao},
  UCadastroCliente in 'View\UCadastroCliente.pas' {frmCadastroCliente},
  UdtmCadastroCliente in 'View\UdtmCadastroCliente.pas' {dtmCliente: TDataModule},
  UCadastroBomba in 'View\UCadastroBomba.pas' {frmCadastroBomba},
  UdtmCadastroBomba in 'View\UdtmCadastroBomba.pas' {dtmCadastroBomba: TDataModule},
  FrmPesquisaF in 'View\FrmPesquisaF.pas' {frmPesquisa},
  UCadastroTanqueCombustivel in 'View\UCadastroTanqueCombustivel.pas' {frmCadastroTanqueCombustivel},
  UdtmCadastroTanqueCombustivel in 'View\UdtmCadastroTanqueCombustivel.pas' {dtmCadastroTanqueCombustivel: TDataModule},
  UAbastecimento in 'View\UAbastecimento.pas' {frmAbastecimento},
  UdtmAbastecimento in 'View\UdtmAbastecimento.pas' {dtmAbastecimento: TDataModule},
  URelatoriosAbastecimentosPeriodo in 'View\URelatoriosAbastecimentosPeriodo.pas' {frmRelatorioAbastecimento},
  UdtmRelatoriosAbastecimentosPeriodo in 'View\UdtmRelatoriosAbastecimentosPeriodo.pas' {dtmRelatorioAbastecimento: TDataModule},
  UParametroRelAbastecimento in 'View\UParametroRelAbastecimento.pas' {frmParamRelAbastecimento},
  UdtmCadastroUsuario in 'View\UdtmCadastroUsuario.pas' {dtmCadastroUsuario: TDataModule},
  UCadastroUsuario in 'View\UCadastroUsuario.pas' {frmCadastroUsuario};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  frmLogin:=TfrmLogin.Create(Application);
  TStyleManager.TrySetStyle('Windows10');
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TdtmConection, dtmConection);
  Application.CreateForm(TdtmUsuario, dtmUsuario);
  if FrmLogin.ShowModal = mrOk then //Caso o retorno da tela seja Ok
  begin
    FreeAndNil(FrmLogin); //Libera o form de Login da memória
    Application.Run; //Roda a aplicação
  end
  else //Caso o retorno da tela de Login seja mrCancel então
    Application.Terminate; //Encerra a aplicação
end.
