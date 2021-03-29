inherited frmAbastecimento: TfrmAbastecimento
  Caption = 'Posto ABC - Abastecimento'
  ClientHeight = 304
  ExplicitHeight = 343
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlPadrao: TPanel
    Height = 259
    ExplicitHeight = 259
    inherited pgcPadrao: TPageControl
      Height = 257
      ActivePage = tshRegistro
      ExplicitHeight = 257
      inherited tshTabela: TTabSheet
        ExplicitHeight = 228
        inherited pnlPesquisa: TPanel
          Top = 161
          ExplicitTop = 161
        end
        inherited grdTabela: TDBGrid
          Height = 161
          Columns = <
            item
              Expanded = False
              FieldName = 'ID_ABASTECIMENTO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ID_CLIENTE'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DSC_CLIENTE'
              Width = 255
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ID_BOMBA'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATA_ABASTECIMENTO'
              Width = 105
              Visible = True
            end>
        end
      end
      inherited tshRegistro: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 25
        ExplicitWidth = 597
        ExplicitHeight = 228
        object lblCodigo: TLabel
          Left = 16
          Top = 16
          Width = 33
          Height = 13
          Caption = 'C'#243'digo'
          FocusControl = edtCodigo
        end
        object lblCliente: TLabel
          Left = 16
          Top = 56
          Width = 33
          Height = 13
          Caption = 'Cliente'
        end
        object lblBomba: TLabel
          Left = 16
          Top = 96
          Width = 32
          Height = 13
          Caption = 'Bomba'
        end
        object lblCombustivel: TLabel
          Left = 16
          Top = 136
          Width = 58
          Height = 13
          Caption = 'Combust'#237'vel'
          FocusControl = edtCodCombustivel
        end
        object lblAbastecimento: TLabel
          Left = 16
          Top = 176
          Width = 26
          Height = 13
          Caption = 'Data '
          FocusControl = edtAbastecimento
        end
        object lblImposto: TLabel
          Left = 104
          Top = 176
          Width = 61
          Height = 13
          Caption = 'Imposto (%)'
          FocusControl = edtImposto
        end
        object lblQuantidade: TLabel
          Left = 192
          Top = 176
          Width = 72
          Height = 13
          Caption = 'Quantidade (L)'
          FocusControl = edtQuantidade
        end
        object lblValorLitro: TLabel
          Left = 280
          Top = 176
          Width = 48
          Height = 13
          Caption = 'Valor Litro'
          FocusControl = edtValorLitro
        end
        object lblTotalAbastecimento: TLabel
          Left = 368
          Top = 176
          Width = 24
          Height = 13
          Caption = 'Total'
          FocusControl = edtTotalAbastecimento
        end
        object lblTotalImposto: TLabel
          Left = 456
          Top = 176
          Width = 78
          Height = 13
          Caption = 'Total c/ Imposto'
          FocusControl = edtTotalImposto
        end
        object edtCodigo: TDBEdit
          Left = 16
          Top = 32
          Width = 77
          Height = 21
          DataField = 'ID_ABASTECIMENTO'
          DataSource = dtsPadrao
          ReadOnly = True
          TabOrder = 0
        end
        object edtCliente: TDBEdit
          Left = 99
          Top = 72
          Width = 467
          Height = 21
          DataField = 'DSC_CLIENTE'
          DataSource = dtsPadrao
          ReadOnly = True
          TabOrder = 2
        end
        object edtBomba: TDBEdit
          Left = 99
          Top = 112
          Width = 467
          Height = 21
          DataField = 'DSC_BOMBA'
          DataSource = dtsPadrao
          ReadOnly = True
          TabOrder = 4
        end
        object edtCodCombustivel: TDBEdit
          Left = 16
          Top = 152
          Width = 77
          Height = 21
          DataField = 'ID_TANQUECOMBUSTIVEL'
          DataSource = dtsPadrao
          ReadOnly = True
          TabOrder = 5
        end
        object edtCombustivel: TDBEdit
          Left = 99
          Top = 152
          Width = 467
          Height = 21
          DataField = 'DSC_TANQUECOMBUSTIVEL'
          DataSource = dtsPadrao
          ReadOnly = True
          TabOrder = 6
        end
        object edtAbastecimento: TDBEdit
          Left = 16
          Top = 192
          Width = 77
          Height = 21
          DataField = 'DATA_ABASTECIMENTO'
          DataSource = dtsPadrao
          TabOrder = 7
        end
        object edtImposto: TDBEdit
          Left = 104
          Top = 192
          Width = 77
          Height = 21
          DataField = 'IMPOSTO_ABASTECIMENTO'
          DataSource = dtsPadrao
          TabOrder = 8
        end
        object edtQuantidade: TDBEdit
          Left = 192
          Top = 192
          Width = 77
          Height = 21
          DataField = 'QTD_LITRO'
          DataSource = dtsPadrao
          TabOrder = 9
        end
        object edtValorLitro: TDBEdit
          Left = 280
          Top = 192
          Width = 77
          Height = 21
          DataField = 'VLR_LITRO'
          DataSource = dtsPadrao
          TabOrder = 10
        end
        object edtTotalAbastecimento: TDBEdit
          Left = 368
          Top = 192
          Width = 77
          Height = 21
          DataField = 'TOTAL_ABASTECIMENTO'
          DataSource = dtsPadrao
          ReadOnly = True
          TabOrder = 11
        end
        object edtCodBomba: TButtonedEdit
          Left = 16
          Top = 112
          Width = 77
          Height = 21
          Images = imPadrao
          RightButton.ImageIndex = 4
          RightButton.Visible = True
          TabOrder = 3
          Text = 'edtCodBomba'
          OnRightButtonClick = edtCodBombaRightButtonClick
        end
        object edtCodCliente: TButtonedEdit
          Left = 16
          Top = 72
          Width = 77
          Height = 21
          Images = imPadrao
          RightButton.ImageIndex = 4
          RightButton.Visible = True
          TabOrder = 1
          Text = 'ButtonedEdit1'
          OnRightButtonClick = edtCodClienteRightButtonClick
        end
        object edtTotalImposto: TDBEdit
          Left = 456
          Top = 192
          Width = 77
          Height = 21
          DataField = 'TOTAL_IMPOSTO'
          DataSource = dtsPadrao
          ReadOnly = True
          TabOrder = 12
        end
      end
    end
  end
  inherited dtsPadrao: TDataSource
    DataSet = dtmAbastecimento.qryAbastecimento
  end
  object BindSourceAbastecimento: TBindSourceDB
    DataSource = dtsPadrao
    ScopeMappings = <>
    Left = 517
    Top = 152
  end
  object BindingsListAbastecimento: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 516
    Top = 85
    object LinkControlToFieldID_CLIENTE: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BindSourceAbastecimento
      FieldName = 'ID_CLIENTE'
      Control = edtCodCliente
      Track = False
    end
    object LinkControlToFieldID_BOMBA: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = BindSourceAbastecimento
      FieldName = 'ID_BOMBA'
      Control = edtCodBomba
      Track = False
    end
  end
end
