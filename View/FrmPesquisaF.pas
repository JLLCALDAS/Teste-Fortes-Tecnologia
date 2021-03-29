unit FrmPesquisaF;

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
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  classeCommon,
  dtmConections;

type
  TfrmPesquisa = class(TForm)
    pnlPesquisa: TPanel;
    lblCampo: TLabel;
    lblLocalizar: TLabel;
    pnlOpcoes: TPanel;
    lblQtdRegistros: TLabel;
    lblRegistros: TLabel;
    cmbCampo: TComboBox;
    edtLocalizar: TMaskEdit;
    grdPesquisar: TDBGrid;
    qryPesquisar: TFDQuery;
    dtsPesquisar: TDataSource;
    pnlConfirmar: TPanel;
    btnOk: TBitBtn;
    btnCancelar: TBitBtn;
    btnFiltrar: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure cmbCampoChange(Sender: TObject);
    procedure dtsPesquisarDataChange(Sender: TObject; Field: TField);
    procedure edtLocalizarChange(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Funcoes: TFuncoes;
    FConfirm: boolean;
    CommandSql: string;
    Titulo: string;
    procedure Montargrid(CamposGrid: array of string; FieldsGrid: array of string);
    procedure Filtrar;
  protected
    CampoFiltroSelecionado: string;
  public
    function Pesquisar(Sender: TForm): boolean overload; virtual;
    function Pesquisar(Sender: TForm; Sql: string; CamposGrid, FieldsGrid, FieldsRetorno: array of string; CamposRetorno: array of TComponent; TituloPesquisa: string): boolean overload; virtual;
  end;

var
  frmPesquisa: TfrmPesquisa;

implementation

{$R *.dfm}

procedure TfrmPesquisa.FormShow(Sender: TObject);
var
  i: integer;
begin
  frmPesquisa.Caption:=Titulo;
  qryPesquisar.SQL.Text:=CommandSql;
  cmbCampo.Items.Clear;
  if cmbCampo.Items.Count>0 then
    cmbCampo.ItemIndex:=0;
  dtsPesquisar.DataSet.Open;
  for i:=0 to Pred(grdPesquisar.FieldCount) do
    cmbCampo.Items.Append(grdPesquisar.Columns[i].Title.Caption);
  edtLocalizar.SetFocus;
  cmbCampo.ItemIndex:=0;
end;

procedure TfrmPesquisa.btnFiltrarClick(Sender: TObject);
begin
  Filtrar;
end;

procedure TfrmPesquisa.btnOkClick(Sender: TObject);
begin
  FConfirm:=True;
  if FConfirm then
    ModalResult:=mrOk;
end;

procedure TfrmPesquisa.cmbCampoChange(Sender: TObject);
var
  Campo: string;
begin
  edtLocalizar.EditMask:='';
  edtLocalizar.Clear;
  CampoFiltroSelecionado:=cmbCampo.Text;
  Campo:=Funcoes.ObterNomeCampoGrid(grdPesquisar,cmbCampo.Items[cmbCampo.ItemIndex]);
  if (Campo<>'') and (dtsPesquisar.DataSet.FieldByName(Campo).EditMask<>'') then
    edtLocalizar.EditMask:=dtsPesquisar.DataSet.FieldByName(Campo).EditMask;
  edtLocalizar.SetFocus;
end;

procedure TfrmPesquisa.dtsPesquisarDataChange(Sender: TObject; Field: TField);
begin
  with dtsPesquisar.DataSet do
  begin
    if Active then
      lblQtdRegistros.Caption:=IntToStr(RecordCount);
  end;
end;

procedure TfrmPesquisa.edtLocalizarChange(Sender: TObject);
var
  Campo, Valor: string;
  p: integer;
begin
  try
    if btnFiltrar.Down then
      Filtrar
    else if (cmbCampo.ItemIndex>=0) and (edtLocalizar.Text<>'') then
    begin
      Campo:=Funcoes.ObterNomeCampoGrid(grdPesquisar,cmbCampo.Items[cmbCampo.ItemIndex]);
      if edtLocalizar.IsMasked then
      begin
        p:=Pos('_',edtLocalizar.EditText);
        if p>0 then
          Valor:=Copy(edtLocalizar.Text,1,p-1)
        else
          Valor:=edtLocalizar.Text;
      end
      else
        Valor:=edtLocalizar.Text;
      dtsPesquisar.DataSet.Locate(Campo,Valor,[loCaseInsensitive,loPartialKey]);
    end;
  except
  end;
end;

procedure TfrmPesquisa.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPesquisa.Montargrid(CamposGrid: array of string; FieldsGrid: array of string);
var
  i: integer;
begin
  for i:=Low(CamposGrid) to High(CamposGrid) do
    grdPesquisar.Columns.Add;
  for i:=0 to Pred(grdPesquisar.Columns.Count) do
  begin
    grdPesquisar.Columns[i].FieldName:=FieldsGrid[i];
    grdPesquisar.Columns[i].Title.Caption:=CamposGrid[i];
  end;
end;

procedure TfrmPesquisa.Filtrar;
var
  Campo, Valor: string;
  p1, p2: integer;
  i: integer;
begin
  if dtsPesquisar.DataSet.State in [dsInsert, dsEdit] then
    Exit;

  if (cmbCampo.ItemIndex>=0) and (edtLocalizar.Text<>'') and (btnFiltrar.Down)then
  begin
    Campo:=Funcoes.ObterNomeCampoGrid(grdPesquisar,cmbCampo.Items[cmbCampo.ItemIndex]);
    Valor:=UpperCase(edtLocalizar.Text);
    case dtsPesquisar.DataSet.FieldByName(Campo).DataType of
      ftString, ftWideString:
      begin
        TFDQuery(dtsPesquisar.DataSet).FilterOptions:=[foCaseInsensitive];
        if edtLocalizar.IsMasked then
        begin
          Valor:=edtLocalizar.EditText;

          p1:=1;
          p2:=Length(Valor);

          if Pos('_',Valor)>0 then
          begin
            if Valor[p1]='_' then
              for i:=1 to Length(Valor) do
                if Valor[i] in ['0'..'9'] then
                begin
                  p1:=i;
                  Break;
                end;

            if Valor[p2]='_' then
              for i:=Length(Valor) downto 1 do
                if Valor[i] in ['0'..'9'] then
                begin
                  p2:=i;
                  Break;
                end;
          end;

          dtsPesquisar.DataSet.Filter:='Substring('+Campo+', '+IntToStr(p1)+', '+IntToStr(p2-p1+1)+') = '+QuotedStr(Copy(Valor,p1,p2-p1+1));
        end
        else
          dtsPesquisar.DataSet.Filter:=Campo+' like '+QuotedStr('%'+Valor+'%');
      end;
      ftDate, ftDateTime, ftTimeStamp:
      begin
        TFDQuery(dtsPesquisar.DataSet).FilterOptions:=[];
        dtsPesquisar.DataSet.Filter:=Campo+' = '+QuotedStr(Valor);
      end;
      else
      begin
        TFDQuery(dtsPesquisar.DataSet).FilterOptions:=[];
        dtsPesquisar.DataSet.Filter:=Campo+' = '+Valor;
      end;
    end;
    dtsPesquisar.DataSet.Filtered:=True;
  end
  else
    dtsPesquisar.DataSet.Filtered:=False;
end;

procedure TfrmPesquisa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult=mrNone then
    ModalResult:=mrCancel;
  Action:=caFree;
end;

function TfrmPesquisa.Pesquisar(Sender: TForm): boolean;
begin
  ShowModal;
  Result:=(ModalResult=mrOk);
end;

function TfrmPesquisa.Pesquisar(Sender: TForm; Sql: string; CamposGrid, FieldsGrid, FieldsRetorno: array of string; CamposRetorno: array of TComponent; TituloPesquisa: string): boolean;
var
  i: integer;
  Campo: TComponent;
begin
  Montargrid(CamposGrid, FieldsGrid);
  Self.CommandSql:=Sql;
  Self.Titulo:=TituloPesquisa;
  if Pesquisar(Sender) then
  begin
    for i:=Low(FieldsRetorno) to High(FieldsRetorno) do
      TField(CamposRetorno[i]).Value:=qryPesquisar.FieldByName(FieldsRetorno[i]).Value;
  end;
end;

end.
