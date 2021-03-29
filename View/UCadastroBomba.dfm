inherited frmCadastroBomba: TfrmCadastroBomba
  Caption = 'Posto ABC - Cadastro Bomba'
  ClientHeight = 284
  ExplicitHeight = 323
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlPadrao: TPanel
    Height = 239
    ExplicitHeight = 239
    inherited pgcPadrao: TPageControl
      Height = 237
      ActivePage = tshRegistro
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
              FieldName = 'ID_BOMBA'
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
        object lblSigla: TLabel
          Left = 16
          Top = 96
          Width = 22
          Height = 13
          Caption = 'Sigla'
          FocusControl = edtSigla
        end
        object lblTanqueCombustivel: TLabel
          Left = 16
          Top = 136
          Width = 97
          Height = 13
          Caption = 'Tanque Combust'#237'vel'
        end
        object edtCodigo: TDBEdit
          Left = 16
          Top = 32
          Width = 134
          Height = 21
          DataField = 'ID_BOMBA'
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
        object edtSigla: TDBEdit
          Left = 16
          Top = 112
          Width = 56
          Height = 21
          DataField = 'SIGLA'
          DataSource = dtsPadrao
          TabOrder = 2
        end
        object edtDscTanqueCombustivel: TDBEdit
          Left = 78
          Top = 152
          Width = 488
          Height = 21
          DataField = 'DSC_TANQUECOMBUSTIVEL'
          DataSource = dtsPadrao
          ReadOnly = True
          TabOrder = 3
        end
        object edtTanqueCombustivel: TButtonedEdit
          Left = 16
          Top = 152
          Width = 56
          Height = 21
          Images = imPadrao
          RightButton.ImageIndex = 4
          RightButton.Visible = True
          TabOrder = 4
          OnRightButtonClick = edtTanqueCombustivelRightButtonClick
        end
      end
    end
  end
  inherited dtsPadrao: TDataSource
    DataSet = dtmCadastroBomba.qryBomba
  end
  object BindSourceTipoCombustivel: TBindSourceDB
    DataSource = dtsPadrao
    ScopeMappings = <>
    Left = 416
    Top = 152
  end
  object BindingsListBomba: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 420
    Top = 205
    object LinkControlToField1: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BindSourceTipoCombustivel
      FieldName = 'ID_TANQUECOMBUSTIVEL'
      Control = edtTanqueCombustivel
      Track = False
    end
  end
end
