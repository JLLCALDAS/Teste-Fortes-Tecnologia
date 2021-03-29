object dtmCliente: TdtmCliente
  OldCreateOrder = False
  Height = 150
  Width = 215
  object qryCliente: TFDQuery
    Connection = dtmConection.ABCConnection
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint, uvGeneratorName]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.GeneratorName = 'GEN_CLIENTE'
    SQL.Strings = (
      'select * from abc_cliente')
    Left = 88
    Top = 56
    object qryClienteID_CLIENTE: TIntegerField
      DisplayLabel = 'Cliente'
      FieldName = 'ID_CLIENTE'
      Origin = 'ID_CLIENTE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryClienteNOME: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 50
    end
    object qryClienteCEP: TStringField
      DisplayWidth = 10
      FieldName = 'CEP'
      Origin = 'CEP'
      Required = True
      EditMask = '00000\-999;1;_'
      Size = 10
    end
    object qryClienteTIPO_PESSOA: TStringField
      DisplayLabel = 'Tipo Pessoa'
      FieldName = 'TIPO_PESSOA'
      Origin = 'TIPO_PESSOA'
      Required = True
      Size = 1
    end
    object qryClienteCPF_CNPJ: TStringField
      DisplayLabel = 'CPF/CNPJ'
      FieldName = 'CPF_CNPJ'
      Origin = 'CPF_CNPJ'
      Required = True
      Size = 14
    end
    object qryClienteLOGRADOURO: TStringField
      DisplayLabel = 'Logradouro'
      FieldName = 'LOGRADOURO'
      Origin = 'LOGRADOURO'
      Required = True
      Size = 60
    end
    object qryClienteNUMERO: TStringField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Required = True
      Size = 10
    end
    object qryClienteCOMPLEMENTO: TStringField
      DisplayLabel = 'Complemento'
      FieldName = 'COMPLEMENTO'
      Origin = 'COMPLEMENTO'
      Required = True
      Size = 40
    end
    object qryClienteCIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Required = True
      Size = 40
    end
    object qryClienteSIGLA_UF: TStringField
      DisplayLabel = 'UF'
      FieldName = 'SIGLA_UF'
      Origin = 'SIGLA_UF'
      Required = True
      Size = 2
    end
  end
end
