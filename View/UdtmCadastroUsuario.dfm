object dtmCadastroUsuario: TdtmCadastroUsuario
  OldCreateOrder = False
  Height = 128
  Width = 304
  object qryUsuario: TFDQuery
    BeforePost = qryUsuarioBeforePost
    Connection = dtmConection.ABCConnection
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint, uvGeneratorName]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.GeneratorName = 'GEN_USUARIO'
    SQL.Strings = (
      'select'
      '  id_usuario,'
      '  login,'
      '  senha,'
      '  email'
      'from'
      '  abc_usuario')
    Left = 32
    Top = 16
    object qryUsuarioID_USUARIO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID_USUARIO'
      Origin = 'ID_USUARIO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryUsuarioLOGIN: TStringField
      DisplayLabel = 'Login'
      FieldName = 'LOGIN'
      Origin = 'LOGIN'
      Required = True
      Size = 8
    end
    object qryUsuarioSENHA: TStringField
      DisplayLabel = 'Senha'
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Required = True
      Size = 60
    end
    object qryUsuarioEMAIL: TStringField
      DisplayLabel = 'Email'
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 60
    end
  end
end
