unit UCadastroTanqueCombustivel;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  Data.DB,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ImgList,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.Buttons,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.ToolWin,
  Vcl.DBCtrls,
  UCadastroPadraoF,
  UdtmCadastroTanqueCombustivel;

type
  TfrmCadastroTanqueCombustivel = class(TfrmCadastroPadrao)
    lblCodigo: TLabel;
    edtCodigo: TDBEdit;
    lblDescricao: TLabel;
    edtDescricao: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroTanqueCombustivel: TfrmCadastroTanqueCombustivel;

implementation

{$R *.dfm}

procedure TfrmCadastroTanqueCombustivel.FormCreate(Sender: TObject);
begin
  dtmCadastroTanqueCombustivel:=TdtmCadastroTanqueCombustivel.Create(Self);
  inherited;
end;

procedure TfrmCadastroTanqueCombustivel.FormShow(Sender: TObject);
begin
  dtsPadrao.DataSet:=dtmCadastroTanqueCombustivel.qryTanqueCombustivel;
  inherited;
end;

procedure TfrmCadastroTanqueCombustivel.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:=caFree;
  frmCadastroTanqueCombustivel:=nil;
end;

end.
