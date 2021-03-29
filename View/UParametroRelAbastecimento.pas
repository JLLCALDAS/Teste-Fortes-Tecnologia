unit UParametroRelAbastecimento;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.DateUtils,
  System.ImageList,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.ExtCtrls,
  Vcl.ImgList,
  URelatoriosAbastecimentosPeriodo;

type
  TfrmParamRelAbastecimento = class(TForm)
    pnlBotoes: TPanel;
    pnlPeriodo: TPanel;
    grbPeriodo: TGroupBox;
    edtDataInicial: TMaskEdit;
    edtDataFinal: TMaskEdit;
    lblPeriodoA: TLabel;
    btnVisualizar: TButton;
    btnCancelar: TButton;
    imgBotoes: TImageList;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnVisualizarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    function FormatarData(Data: string): string;
  public
    { Public declarations }
  end;

var
  frmParamRelAbastecimento: TfrmParamRelAbastecimento;

implementation

{$R *.dfm}

procedure TfrmParamRelAbastecimento.FormShow(Sender: TObject);
begin
  edtDataInicial.Text:=DateToStr(Now);
  edtDataFinal.Text:=DateToStr(IncMonth(Now));
end;

procedure TfrmParamRelAbastecimento.btnVisualizarClick(Sender: TObject);
begin
  frmRelatorioAbastecimento:=TfrmRelatorioAbastecimento.Create(Self,FormatarData(edtDataInicial.Text),FormatarData(edtDataFinal.Text));
  frmRelatorioAbastecimento.rlAbastecimentos.PreviewModal;
  frmRelatorioAbastecimento.Release;
end;

procedure TfrmParamRelAbastecimento.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

function TfrmParamRelAbastecimento.FormatarData(Data: string): string;
begin
  Result:=FormatDateTime('dd.mm.yyyy',StrToDateTime(Data));
end;

procedure TfrmParamRelAbastecimento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
  frmParamRelAbastecimento:=nil;
end;

end.
