inherited frmCadastroUsuario: TfrmCadastroUsuario
  Caption = 'Print Shop - Cadastro Usuario'
  ClientHeight = 281
  ExplicitHeight = 320
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlPadrao: TPanel
    Height = 236
    inherited pgcPadrao: TPageControl
      Height = 234
      ActivePage = tshRegistro
      inherited tshTabela: TTabSheet
        inherited pnlPesquisa: TPanel
          Top = 138
        end
        inherited grdTabela: TDBGrid
          Height = 138
          Columns = <
            item
              Expanded = False
              FieldName = 'ID_USUARIO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LOGIN'
              Width = 222
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EMAIL'
              Width = 266
              Visible = True
            end>
        end
      end
      inherited tshRegistro: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 25
        ExplicitWidth = 597
        ExplicitHeight = 302
        object lblCodigo: TLabel
          Left = 16
          Top = 16
          Width = 33
          Height = 13
          Caption = 'C'#243'digo'
          FocusControl = edtCodigo
        end
        object lblLogin: TLabel
          Left = 16
          Top = 58
          Width = 25
          Height = 13
          Caption = 'Login'
          FocusControl = edtLogin
        end
        object lblSenha: TLabel
          Left = 16
          Top = 102
          Width = 30
          Height = 13
          Caption = 'Senha'
          FocusControl = edtSenha
        end
        object Label5: TLabel
          Left = 16
          Top = 146
          Width = 28
          Height = 13
          Caption = 'E-mail'
          FocusControl = edtEmail
        end
        object edtCodigo: TDBEdit
          Left = 16
          Top = 35
          Width = 97
          Height = 21
          DataField = 'ID_USUARIO'
          DataSource = dtsPadrao
          ReadOnly = True
          TabOrder = 0
        end
        object edtLogin: TDBEdit
          Left = 16
          Top = 76
          Width = 224
          Height = 21
          DataField = 'login'
          DataSource = dtsPadrao
          TabOrder = 1
        end
        object edtSenha: TDBEdit
          Left = 16
          Top = 120
          Width = 224
          Height = 21
          DataField = 'senha'
          DataSource = dtsPadrao
          PasswordChar = '*'
          TabOrder = 2
        end
        object edtEmail: TDBEdit
          Left = 16
          Top = 164
          Width = 468
          Height = 21
          DataField = 'email'
          DataSource = dtsPadrao
          TabOrder = 3
        end
      end
    end
  end
  inherited imgBotoes: TImageList
    Left = 408
  end
  inherited imgBotoesDesabilitado: TImageList
    Left = 504
  end
  inherited imPadrao: TImageList
    Left = 336
  end
  inherited dtsPadrao: TDataSource
    DataSet = dtmCadastroUsuario.qryUsuario
  end
end
