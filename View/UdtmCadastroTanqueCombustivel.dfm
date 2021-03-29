object dtmCadastroTanqueCombustivel: TdtmCadastroTanqueCombustivel
  OldCreateOrder = False
  Height = 150
  Width = 215
  object qryTanqueCombustivel: TFDQuery
    Connection = dtmConection.ABCConnection
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint, uvGeneratorName]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.GeneratorName = 'GEN_TIPOCOMBUSTIVEL'
    SQL.Strings = (
      'select * from abc_tanquecombustivel')
    Left = 88
    Top = 56
    object qryTanqueCombustivelID_TIPOCOMBUSTIVEL: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID_TANQUECOMBUSTIVEL'
      Origin = 'ID_TANQUECOMBUSTIVEL'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryTanqueCombustivelDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 50
    end
  end
end
