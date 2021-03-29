inherited frmCadastroTanqueCombustivel: TfrmCadastroTanqueCombustivel
  Caption = 'Posto ABC - Cadastro Tanque Combust'#237'vel'
  ClientHeight = 284
  ExplicitHeight = 323
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlPadrao: TPanel
    Height = 239
    ExplicitHeight = 239
    inherited pgcPadrao: TPageControl
      Height = 237
      ExplicitHeight = 237
      inherited tshTabela: TTabSheet
        ExplicitHeight = 208
        inherited pnlPesquisa: TPanel
          Top = 141
          ExplicitTop = 141
        end
        inherited grdTabela: TDBGrid
          Height = 141
          Columns = <
            item
              Expanded = False
              FieldName = 'ID_TANQUECOMBUSTIVEL'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCRICAO'
              Visible = True
            end>
        end
      end
      inherited tshRegistro: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 25
        ExplicitWidth = 597
        ExplicitHeight = 208
        object lblCodigo: TLabel
          Left = 16
          Top = 16
          Width = 33
          Height = 13
          Caption = 'C'#243'digo'
          FocusControl = edtCodigo
        end
        object lblDescricao: TLabel
          Left = 16
          Top = 56
          Width = 46
          Height = 13
          Caption = 'Descri'#231#227'o'
          FocusControl = edtDescricao
        end
        object edtCodigo: TDBEdit
          Left = 16
          Top = 32
          Width = 134
          Height = 21
          DataField = 'ID_TANQUECOMBUSTIVEL'
          DataSource = dtsPadrao
          ReadOnly = True
          TabOrder = 0
        end
        object edtDescricao: TDBEdit
          Left = 16
          Top = 72
          Width = 550
          Height = 21
          DataField = 'DESCRICAO'
          DataSource = dtsPadrao
          TabOrder = 1
        end
      end
    end
  end
  inherited dtsPadrao: TDataSource
    DataSet = dtmCadastroTanqueCombustivel.qryTanqueCombustivel
  end
end
