object dtmUsuario: TdtmUsuario
  OldCreateOrder = False
  Height = 150
  Width = 215
  object qryUser: TFDQuery
    Connection = dtmConection.ABCConnection
    SQL.Strings = (
      'select'
      '  id_usuario,'
      '  login,'
      '  senha,'
      '  email'
      'from'
      '  abc_usuario'
      'where'
      '  abc_usuario.login = '#39'%s'#39' and'
      '  abc_usuario.senha = '#39'%s'#39)
    Left = 80
    Top = 36
  end
end
