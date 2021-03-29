unit UCadastroBomba;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  System.Rtti,
  System.Bindings.Outputs,
  Data.DB,
  Data.Bind.EngExt,
  Data.Bind.Components,
  Data.Bind.DBScope,
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
  Vcl.Bind.DBEngExt,
  Vcl.DBCtrls,
  Vcl.Bind.Editors,
  UCadastroPadraoF,
  UdtmCadastroBomba,
  FrmPesquisaF;

type
  TfrmCadastroBomba = class(TfrmCadastroPadrao)
    lblCodigo: TLabel;
    edtCodigo: TDBEdit;
    lblDescricao: TLabel;
    edtDescricao: TDBEdit;
    lblSigla: TLabel;
    edtSigla: TDBEdit;
    lblTanqueCombustivel: TLabel;
    edtDscTanqueCombustivel: TDBEdit;
    edtTanqueCombustivel: TButtonedEdit;
    BindSourceTipoCombustivel: TBindSourceDB;
    BindingsListBomba: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtTanqueCombustivelRightButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FrmPesquisar: TfrmPesquisa;
  public
    { Public declarations }
  end;

var
  frmCadastroBomba: TfrmCadastroBomba;

implementation

{$R *.dfm}

const
  SqlTipoCombustivel = 'select '+
                       '  abc_tanquecombustivel.id_tanquecombustivel, '+
                       '  abc_tanquecombustivel.descricao as dsc_tanquecombustivel '+
                       'from '+
                       '  abc_tanquecombustivel';

procedure TfrmCadastroBomba.FormCreate(Sender: TObject);
begin
  dtmCadastroBomba:=TdtmCadastroBomba.Create(Self);
  inherited;
end;

procedure TfrmCadastroBomba.FormShow(Sender: TObject);
begin
  dtsPadrao.DataSet:=dtmCadastroBomba.qryBomba;
  inherited;
end;

procedure TfrmCadastroBomba.edtTanqueCombustivelRightButtonClick(Sender: TObject);
begin
  inherited;
  try
    if dtsPadrao.DataSet.State in [dsInsert,dsEdit] then
    begin
      FrmPesquisar:=TfrmPesquisa.Create(Self);
      FrmPesquisar.Pesquisar(Self,SqlTipoCombustivel,['Código','Descrição'],['id_tanquecombustivel','dsc_tanquecombustivel'],['id_tanquecombustivel','dsc_tanquecombustivel'],[dtsPadrao.DataSet.FieldByName('id_tanquecombustivel'),dtsPadrao.DataSet.FieldByName('dsc_tanquecombustivel')],'Pesquisa Tanque de Combustível');
    end;
  finally
    FreeAndNil(FrmPesquisar);
  end;
end;

procedure TfrmCadastroBomba.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:=caFree;
  frmCadastroBomba:=nil;
end;

end.
