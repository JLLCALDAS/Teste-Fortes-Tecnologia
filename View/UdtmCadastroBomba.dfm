object dtmCadastroBomba: TdtmCadastroBomba
  OldCreateOrder = False
  Height = 150
  Width = 215
  object qryBomba: TFDQuery
    Connection = dtmConection.ABCConnection
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint, uvGeneratorName]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.GeneratorName = 'GEN_BOMBAS'
    SQL.Strings = (
      'select'
      '  abc_bombas.id_bomba,'
      '  abc_bombas.descricao,'
      '  abc_bombas.sigla,'
      '  abc_bombas.id_tanquecombustivel,'
      '  abc_tanquecombustivel.descricao as dsc_tanquecombustivel'
      'from'
      '  abc_bombas'
      '  inner join abc_tanquecombustivel on'
      
        '    abc_tanquecombustivel.id_tanquecombustivel = abc_bombas.id_t' +
        'anquecombustivel')
    Left = 88
    Top = 56
    object qryBombaID_BOMBA: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID_BOMBA'
      Origin = 'ID_BOMBA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryBombaDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 50
    end
    object qryBombaSIGLA: TStringField
      DisplayLabel = 'Sigla'
      FieldName = 'SIGLA'
      Origin = 'SIGLA'
      Required = True
      Size = 4
    end
    object qryBombaID_TANQUECOMBUSTIVEL: TIntegerField
      DisplayLabel = 'Tanque Combust'#237'vel'
      FieldName = 'ID_TANQUECOMBUSTIVEL'
      Origin = 'ID_TANQUECOMBUSTIVEL'
      Required = True
    end
    object qryBombaDSC_TANQUECOMBUSTIVEL: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DSC_TANQUECOMBUSTIVEL'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      Size = 50
    end
  end
end
