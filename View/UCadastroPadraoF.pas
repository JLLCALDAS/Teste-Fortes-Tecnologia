unit UCadastroPadraoF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ToolWin, Vcl.ComCtrls, Vcl.Clipbrd,
  System.ImageList, Vcl.ImgList, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, dtmConections, classeCommon, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Buttons;

type
  TfrmCadastroPadrao = class(TForm)
    imgBotoes: TImageList;
    tbrPadrao: TToolBar;
    btnIncluir: TToolButton;
    btnAlterar: TToolButton;
    btnExcluir: TToolButton;
    btnSalvar: TToolButton;
    btnCancelar: TToolButton;
    btnImprimir: TToolButton;
    btnPrimeiro: TToolButton;
    btnAnterior: TToolButton;
    btnProximo: TToolButton;
    btnUltimo: TToolButton;
    btnSair: TToolButton;
    imgBotoesDesabilitado: TImageList;
    pnlPadrao: TPanel;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    pgcPadrao: TPageControl;
    tshTabela: TTabSheet;
    tshRegistro: TTabSheet;
    imPadrao: TImageList;
    pnlPesquisa: TPanel;
    grdTabela: TDBGrid;
    pnlOpcoes: TPanel;
    lblQtdRegistros: TLabel;
    lblRegistros: TLabel;
    lblCampo: TLabel;
    cmbCampo: TComboBox;
    lblLocalizar: TLabel;
    edtLocalizar: TMaskEdit;
    ToolButton1: TToolButton;
    dtsPadrao: TDataSource;
    btnFiltrar: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbCampoChange(Sender: TObject);
    procedure grdTabelaDblClick(Sender: TObject);
    procedure dtsPadraoDataChange(Sender: TObject; Field: TField);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure Operacao(Sender: TObject); virtual;
    procedure edtLocalizarChange(Sender: TObject);
    procedure edtLocalizarKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocalizarKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnFiltrarClick(Sender: TObject);
  private
    Funcoes: TFuncoes;
    procedure HabilitarBotoes;
    procedure Filtrar;
  protected
    TemRelatorio: boolean;
    OperacaoAnterior: TTipoOperacao;
    CampoFiltroSelecionado: string;
    FRecarregarRegistroAposSalvar: boolean;
    procedure ExecutarOperacao(Operacao: TTipoOperacao); virtual;
    function ValidarOperacao(Operacao: TTipoOperacao): boolean; virtual;
    procedure HabilitarDSets(SomLeitura: boolean); virtual;
    procedure HabilitarDSetDetalhes(DSet: TDataSet; SomLeitura: boolean); virtual;
    function RecarregarRegistro(DataSet: TFDQuery): boolean; virtual;
  public
    { Public declarations }
  end;

var
  frmCadastroPadrao: TfrmCadastroPadrao;

implementation

{$R *.dfm}

procedure TfrmCadastroPadrao.FormCreate(Sender: TObject);
begin
  FRecarregarRegistroAposSalvar:=True;
  OperacaoAnterior:=toNenhuma;
  TemRelatorio:=False;
end;

procedure TfrmCadastroPadrao.FormShow(Sender: TObject);
var
  i: integer;
begin
  Funcoes:=TFuncoes.Create;

  pgcPadrao.ActivePage:=tshTabela;

  dtsPadrao.DataSet.Open;
  HabilitarBotoes;
  cmbCampo.Items.Clear;
  for i:=0 to Pred(grdTabela.FieldCount) do
    cmbCampo.Items.Append(grdTabela.Columns[i].Title.Caption);
  if cmbCampo.Items.Count>0 then
    cmbCampo.ItemIndex:=0;
  if (pgcPadrao.ActivePage=tshTabela) and (pnlPesquisa.Visible) then
    edtLocalizar.SetFocus;
end;

procedure TfrmCadastroPadrao.grdTabelaDblClick(Sender: TObject);
begin
  pgcPadrao.ActivePage:=tshRegistro;
end;

procedure TfrmCadastroPadrao.btnFiltrarClick(Sender: TObject);
begin
  Filtrar;
end;

procedure TfrmCadastroPadrao.cmbCampoChange(Sender: TObject);
var
  Campo: string;
begin
  edtLocalizar.EditMask:='';
  edtLocalizar.Clear;
  CampoFiltroSelecionado:=cmbCampo.Text;
  Campo:=Funcoes.ObterNomeCampoGrid(grdTabela,cmbCampo.Items[cmbCampo.ItemIndex]);
  if (Campo<>'') and (dtsPadrao.DataSet.FieldByName(Campo).EditMask<>'') then
    edtLocalizar.EditMask:=dtsPadrao.DataSet.FieldByName(Campo).EditMask;
  edtLocalizar.SetFocus;
end;

procedure TfrmCadastroPadrao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    Self.Perform(WM_NEXTDLGCTL,0,0);
end;

procedure TfrmCadastroPadrao.dtsPadraoDataChange(Sender: TObject; Field: TField);
begin
  with dtsPadrao.DataSet do
  begin
    HabilitarBotoes;
    if Active then
      lblQtdRegistros.Caption:=IntToStr(RecordCount);
  end;
end;

procedure TfrmCadastroPadrao.edtLocalizarChange(Sender: TObject);
var
  Campo, Valor: string;
  p: integer;
begin
  try
    if btnFiltrar.Down then
      Filtrar
    else if (cmbCampo.ItemIndex>=0) and (edtLocalizar.Text<>'') then
    begin
      Campo:=Funcoes.ObterNomeCampoGrid(grdTabela,cmbCampo.Items[cmbCampo.ItemIndex]);
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
      dtsPadrao.DataSet.Locate(Campo,Valor,[loCaseInsensitive,loPartialKey]);
    end;
  except
  end;
end;

procedure TfrmCadastroPadrao.edtLocalizarKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Campo: string;
  PodeColar: boolean;
  i: integer;
begin
  inherited;
  if (ssCtrl in Shift) and (Char(Key) in ['v','V']) and (Clipboard.AsText<>'') then
  begin
    Campo:=Funcoes.ObterNomeCampoGrid(grdTabela,cmbCampo.Items[cmbCampo.ItemIndex]);
    if dtsPadrao.DataSet.FieldByName(Campo).DataType in [ftSmallint,ftInteger,ftLargeint,ftWord,ftFloat,ftCurrency,ftBCD,ftFMTBcd] then
    begin
      PodeColar:=True;
      for i:=1 to Length(Clipboard.AsText) do
      begin
        if dtsPadrao.DataSet.FieldByName(Campo).DataType in [ftSmallint,ftInteger,ftLargeint,ftWord] then
          PodeColar:=(Clipboard.AsText[i] in ['0'..'9',#8])
        else
          PodeColar:=(Clipboard.AsText[i] in ['0'..'9',',',#8]);
        if not PodeColar then
          Break;
      end;
      if PodeColar then
      begin
        edtLocalizar.Text:=Clipboard.AsText;
        edtLocalizar.SelStart:=Length(Clipboard.AsText);
      end;
    end;
  end;
end;

procedure TfrmCadastroPadrao.edtLocalizarKeyPress(Sender: TObject; var Key: Char);
var
  Campo: string;
begin
  inherited;
  if dtsPadrao.DataSet.State=dsBrowse then
    if Key=#13 then
    begin
      if tshRegistro.TabVisible then
      begin
        pgcPadrao.ActivePage:=tshRegistro;
        pgcPadrao.OnChange(pgcPadrao);
        Operacao(btnAlterar);
      end;
    end
    else
    begin
      Campo:=Funcoes.ObterNomeCampoGrid(grdTabela,cmbCampo.Items[cmbCampo.ItemIndex]);
      if Campo<>'' then
        case dtsPadrao.DataSet.FieldByName(Campo).DataType of
          ftSmallint, ftInteger, ftLargeint, ftWord:
            if not (Key in ['0'..'9',#8]) then
              Key:=#0;
          ftFloat, ftCurrency, ftBCD, ftFMTBcd:
            if not (Key in ['0'..'9',',',#8]) then
              Key:=#0;
        end;
    end;
end;

procedure TfrmCadastroPadrao.Filtrar;
var
  Campo, Valor: string;
  p1, p2: integer;
  i: integer;
begin
  if dtsPadrao.DataSet.State in [dsInsert, dsEdit] then
    Exit;

  if (cmbCampo.ItemIndex>=0) and (edtLocalizar.Text<>'') and (btnFiltrar.Down) then
  begin
    Campo:=Funcoes.ObterNomeCampoGrid(grdTabela,cmbCampo.Items[cmbCampo.ItemIndex]);
    Valor:=UpperCase(edtLocalizar.Text);
    case dtsPadrao.DataSet.FieldByName(Campo).DataType of
      ftString, ftWideString:
      begin
        TFDQuery(dtsPadrao.DataSet).FilterOptions:=[foCaseInsensitive];
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

          dtsPadrao.DataSet.Filter:='Substring('+Campo+', '+IntToStr(p1)+', '+IntToStr(p2-p1+1)+') = '+QuotedStr(Copy(Valor,p1,p2-p1+1));
        end
        else
          dtsPadrao.DataSet.Filter:=Campo+' like '+QuotedStr('%'+Valor+'%');
      end;
      ftDate, ftDateTime, ftTimeStamp:
      begin
        TFDQuery(dtsPadrao.DataSet).FilterOptions:=[];
        dtsPadrao.DataSet.Filter:=Campo+' = '+QuotedStr(Valor);
      end;
      else
      begin
        TFDQuery(dtsPadrao.DataSet).FilterOptions:=[];
        dtsPadrao.DataSet.Filter:=Campo+' = '+Valor;
      end;
    end;
    dtsPadrao.DataSet.Filtered:=True;
  end
  else
    dtsPadrao.DataSet.Filtered:=False;
end;

procedure TfrmCadastroPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if dtsPadrao.DataSet.State in [dsInsert,dsEdit] then
  begin
    if Application.MessageBox('Cancelar alterações?','Confirmação',MB_ICONQUESTION+MB_YESNO)=mrNo then
    begin
      Action:=caNone;
      Exit;
    end;
    dtsPadrao.DataSet.Cancel;
  end
  else
    dtsPadrao.DataSet.Close;
  frmCadastroPadrao:=nil;
end;

procedure TfrmCadastroPadrao.FormDestroy(Sender: TObject);
begin
  if Funcoes<>nil then
    FreeAndNil(Funcoes);
end;

procedure TfrmCadastroPadrao.HabilitarBotoes;
begin
  btnIncluir.Enabled:=(dtsPadrao.DataSet.Active) and (dtsPadrao.DataSet.State=dsBrowse);
  btnAlterar.Enabled:=(dtsPadrao.DataSet.Active) and (not dtsPadrao.DataSet.IsEmpty) and (dtsPadrao.DataSet.State=dsBrowse);
  btnExcluir.Enabled:=(dtsPadrao.DataSet.Active) and (not dtsPadrao.DataSet.IsEmpty) and (dtsPadrao.DataSet.State=dsBrowse);
  btnSalvar.Enabled:=(dtsPadrao.DataSet.Active) and (not dtsPadrao.DataSet.IsEmpty) and (dtsPadrao.DataSet.State in [dsInsert,dsEdit]);
  btnCancelar.Enabled:=(dtsPadrao.DataSet.Active) and (not dtsPadrao.DataSet.IsEmpty) and (dtsPadrao.DataSet.State in [dsInsert,dsEdit]);
  btnPrimeiro.Enabled:=(dtsPadrao.DataSet.Active) and (not dtsPadrao.DataSet.IsEmpty) and (dtsPadrao.DataSet.State=dsBrowse);
  btnAnterior.Enabled:=(dtsPadrao.DataSet.Active) and (not dtsPadrao.DataSet.IsEmpty) and (dtsPadrao.DataSet.State=dsBrowse);
  btnProximo.Enabled:=(dtsPadrao.DataSet.Active) and (not dtsPadrao.DataSet.IsEmpty) and (dtsPadrao.DataSet.State=dsBrowse);
  btnUltimo.Enabled:=(dtsPadrao.DataSet.Active) and (not dtsPadrao.DataSet.IsEmpty) and (dtsPadrao.DataSet.State=dsBrowse);
  btnImprimir.Enabled:=(dtsPadrao.DataSet.Active) and (not dtsPadrao.DataSet.IsEmpty) and (dtsPadrao.DataSet.State=dsBrowse) and (TemRelatorio);
end;

function TfrmCadastroPadrao.ValidarOperacao(Operacao: TTipoOperacao): boolean;
begin
  Result:=True;
end;

procedure TfrmCadastroPadrao.ExecutarOperacao(Operacao: TTipoOperacao);
var
  i: integer;
  DSet: TDataSet;
  CursorAnterior: TCursor;
  ControleAtual: TWinControl;
begin
  ControleAtual:=Self.ActiveControl;
  try
    if Operacao=toAjuda then
      Screen.Cursor:=crHourGlass
    else
      Screen.Cursor:=crSQLWait;
    case Operacao of
      toIncluir:
      begin
        pgcPadrao.ActivePage:=tshRegistro;
        dtsPadrao.DataSet.Append;
      end;
      toAlterar:
      begin
         dtsPadrao.DataSet.Edit;
        if pgcPadrao.ActivePage=tshTabela then
          pgcPadrao.ActivePage:=tshRegistro
        else if Assigned(pgcPadrao.OnChange) then
        begin
          pgcPadrao.OnChange(pgcPadrao);
          if pgcPadrao.ActivePage=tshTabela then
            pgcPadrao.ActivePage:=tshRegistro;
        end;
      end;
      toExcluir:
      begin
        if Application.MessageBox('Confirma a exclusão do registro atual?','Confirmação',MB_ICONQUESTION+MB_YESNO+MB_DEFBUTTON2)=mrNo then
          Abort;
        if ValidarOperacao(toExcluir) then
        begin
          dtsPadrao.DataSet.Delete;

          if TFDQuery(dtsPadrao.DataSet).ChangeCount>0 then
          begin
            if TFDQuery(dtsPadrao.DataSet).ApplyUpdates(0)>0 then
            begin
              Application.MessageBox('Problemas com o processo de exclusão! Não foi possível realizar o mesmo, verifique suas dependências!','Atenção',MB_ICONERROR);
              Abort;
            end;
          end;

          for i:=0 to Pred(Self.ComponentCount) do
            if Self.Components[i] is TDataSource then
            begin
              DSet:=TDataSource(Self.Components[i]).DataSet;
              if (DSet<>nil) and (TFDQuery(DSet).ChangeCount>0) then
                if TFDQuery(DSet).ApplyUpdates(0)>0 then
                begin
                  Application.MessageBox('Problemas com o processo de exclusão! Não foi possível realizar o mesmo, verifique suas dependências!','Atenção',MB_ICONERROR);
                  Abort;
                end;
            end;

        end;
        HabilitarDSets(True);
      end;
      toSalvar:
      begin
        if Application.MessageBox('Gravar alterações?','Confirmação',MB_ICONQUESTION+MB_YESNO)=mrNo then
          Abort;

        if not ValidarOperacao(toSalvar) then
          Abort;

        Perform(WM_NEXTDLGCTL,0,0);
        for i:=0 to Pred(dtsPadrao.DataSet.FieldCount) do
          if dtsPadrao.DataSet.Fields[i] is TDataSetField then
          begin
            DSet:=TDataSet(dtsPadrao.DataSet.Fields[i]);
            if DSet.State in [dsInsert,dsEdit] then
              DSet.Post;
          end;

        for i:=0 to Pred(Self.ComponentCount) do
          if Self.Components[i] is TDataSource then
          begin
            DSet:=TDataSource(Self.Components[i]).DataSet;
            if (DSet<>nil) and (DSet.State in [dsInsert,dsEdit]) then
              if DSet<>dtsPadrao.DataSet then
                DSet.Post;
          end;

        if dtsPadrao.DataSet.State in [dsInsert,dsEdit] then
          dtsPadrao.DataSet.Post;

        if TFDQuery(dtsPadrao.DataSet).ChangeCount>0 then
        begin
          if TFDQuery(dtsPadrao.DataSet).ApplyUpdates(0)>0 then
          begin
            Application.MessageBox('Problemas com o processo de gravação! Verifique as informações inseridas e tente novamente!','Atenção',MB_ICONERROR);
            dtsPadrao.DataSet.Edit;
            Abort;
          end;
        end;

        for i:=0 to Pred(Self.ComponentCount) do
          if Self.Components[i] is TDataSource then
          begin
            DSet:=TDataSource(Self.Components[i]).DataSet;
            if (DSet<>nil) and (TFDQuery(DSet).ChangeCount>0) then
              if TFDQuery(DSet).ApplyUpdates(0)>0 then
              begin
                Application.MessageBox('Problemas com o processo de gravação! Verifique as informações inseridas e tente novamente!','Atenção',MB_ICONERROR);
                dtsPadrao.DataSet.Edit;
                TFDQuery(DSet).Edit;
                Abort;
              end;
          end;

        if FRecarregarRegistroAposSalvar then
          RecarregarRegistro(TFDQuery(dtsPadrao.DataSet));

        HabilitarDSets(True);
        dtsPadrao.DataSet.Tag:=dtsPadrao.DataSet.Tag+1;
      end;
      toCancelar:
      begin
        if Application.MessageBox('Cancelar alterações?','Confirmação',MB_ICONQUESTION+MB_YESNO)=mrNo then
          Abort;
        if dtsPadrao.DataSet.State in [dsInsert,dsEdit] then
          dtsPadrao.DataSet.Cancel;
        for i:=0 to Pred(Self.ComponentCount) do
          if Self.Components[i] is TDataSource then
          begin
            DSet:=TDataSource(Self.Components[i]).DataSet;
            if (DSet<>nil) and (DSet.State in [dsInsert,dsEdit]) then
              DSet.Cancel;
          end;

        if TFDQuery(dtsPadrao.DataSet).ChangeCount>0 then
          TFDQuery(dtsPadrao.DataSet).CancelUpdates;
        for i:=0 to Pred(Self.ComponentCount) do
          if Self.Components[i] is TDataSource then
          begin
            DSet:=TDataSource(Self.Components[i]).DataSet;
            if (DSet<>nil) and (TFDQuery(DSet).ChangeCount>0) then
              TFDQuery(DSet).CancelUpdates;
          end;

        HabilitarDSets(True);
      end;
      toPrimeiro:
      begin
        dtsPadrao.DataSet.First;
        HabilitarDSets(True);
      end;
      toAnterior:
      begin
        dtsPadrao.DataSet.Prior;
        HabilitarDSets(True);
      end;
      toProximo:
      begin
        dtsPadrao.DataSet.Next;
        HabilitarDSets(True);
      end;
      toUltimo:
      begin
        dtsPadrao.DataSet.Last;
        HabilitarDSets(True);
      end;
      toSair:
        Self.Close;
    end;
  finally
    if (Screen.Cursor=crHourGlass) or (Screen.Cursor=crSQLWait) then
      Screen.Cursor:=CursorAnterior;
  end;
  OperacaoAnterior:=Operacao;
end;

procedure TfrmCadastroPadrao.HabilitarDSetDetalhes(DSet: TDataSet; SomLeitura: boolean);
var
  i: integer;
begin
  if DSet<>nil then
    with TFDQuery(DSet) do
    begin
      for i:=0 to Pred(FieldCount) do
        if Fields[i] is TDataSetField then
          HabilitarDSetDetalhes(TDataSetField(Fields[i]).NestedDataSet,SomLeitura);
    end;
end;

procedure TfrmCadastroPadrao.HabilitarDSets(SomLeitura: boolean);
var
  i: integer;
  DSet: TDataSet;
begin
  HabilitarDSetDetalhes(dtsPadrao.DataSet,SomLeitura);
  for i:=0 to Pred(Self.ComponentCount) do
    if Self.Components[i] is TDataSource then
    begin
      DSet:=TDataSource(Self.Components[i]).DataSet;
      if (DSet<>nil) and (DSet.State in [dsInsert,dsEdit]) then
        HabilitarDSetDetalhes(DSet,SomLeitura);
    end;
end;

procedure TfrmCadastroPadrao.Operacao(Sender: TObject);
var
  ASender: TObject;
begin
  ASender:=Sender;
  if (not TWinControl(ASender).Enabled) or (not TWinControl(ASender).Visible) then
    Exit;
  if ASender=btnIncluir then
    ExecutarOperacao(toIncluir)
  else if ASender=btnAlterar then
    ExecutarOperacao(toAlterar)
  else if ASender=btnExcluir then
    ExecutarOperacao(toExcluir)
  else if ASender=btnSalvar then
    ExecutarOperacao(toSalvar)
  else if ASender=btnCancelar then
    ExecutarOperacao(toCancelar)
  else if ASender=btnPrimeiro then
    ExecutarOperacao(toPrimeiro)
  else if ASender=btnAnterior then
    ExecutarOperacao(toAnterior)
  else if ASender=btnProximo then
    ExecutarOperacao(toProximo)
  else if ASender=btnUltimo then
    ExecutarOperacao(toUltimo)
  else if ASender=btnImprimir then
    ExecutarOperacao(toImprimir)
  else if ASender=btnSair then
    ExecutarOperacao(toSair);
end;

function TfrmCadastroPadrao.RecarregarRegistro(DataSet: TFDQuery): boolean;
var
  Valores: array of Variant;
  IndexFieldNames: string;
begin
  Result:=False;
  try
    IndexFieldNames:=DataSet.IndexFieldNames;
    DataSet.IndexFieldNames:='';
    DataSet.Refresh;
  finally
    DataSet.IndexFieldNames:=IndexFieldNames;
  end;
  Result:=True;
end;

end.
