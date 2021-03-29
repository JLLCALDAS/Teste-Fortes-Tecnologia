unit UCadastroUsuario;

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
  Vcl.Buttons,
  Vcl.ImgList,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.ToolWin,
  Vcl.DBCtrls,
  UdtmCadastroUsuario,
  UCadastroPadraoF;

type
  TfrmCadastroUsuario = class(TfrmCadastroPadrao)
    lblCodigo: TLabel;
    edtCodigo: TDBEdit;
    lblLogin: TLabel;
    edtLogin: TDBEdit;
    lblSenha: TLabel;
    edtSenha: TDBEdit;
    Label5: TLabel;
    edtEmail: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroUsuario: TfrmCadastroUsuario;

implementation

{$R *.dfm}

const
  SqlGrupo='select '+
           '  grupo.codigo, '+
           '  grupo.nome '+
           'from           ' +
           '  grupo ';

procedure TfrmCadastroUsuario.FormCreate(Sender: TObject);
begin
  dtmCadastroUsuario:=TdtmCadastroUsuario.Create(Self);
  inherited;
end;

procedure TfrmCadastroUsuario.FormShow(Sender: TObject);
begin
  dtsPadrao.DataSet:=dtmCadastroUsuario.qryUsuario;
  inherited;
end;

procedure TfrmCadastroUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:=caFree;
  frmCadastroUsuario:=nil;
end;

end.
