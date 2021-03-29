object dtmAbastecimento: TdtmAbastecimento
  OldCreateOrder = False
  Height = 150
  Width = 215
  object qryAbastecimento: TFDQuery
    Connection = dtmConection.ABCConnection
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint, uvGeneratorName]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.GeneratorName = 'GEN_ABASTECIMENTO'
    SQL.Strings = (
      'select'
      '  abc_abastecimento.id_abastecimento,'
      '  abc_abastecimento.id_cliente,'
      '  abc_cliente.nome as dsc_cliente,'
      '  abc_abastecimento.id_bomba,'
      '  abc_bombas.descricao as dsc_bomba,'
      '  abc_bombas.id_tanquecombustivel,'
      '  abc_tanquecombustivel.descricao as dsc_tanquecombustivel,'
      '  abc_abastecimento.data_abastecimento,'
      '  abc_abastecimento.imposto_abastecimento,'
      '  abc_abastecimento.qtd_litro,'
      '  abc_abastecimento.vlr_litro,'
      '  abc_abastecimento.total_abastecimento,'
      '  abc_abastecimento.total_imposto'
      'from'
      '  abc_abastecimento'
      '  inner join abc_cliente on'
      '    abc_cliente.id_cliente = abc_abastecimento.id_cliente'
      '  inner join abc_bombas on'
      '    abc_bombas.id_bomba = abc_abastecimento.id_bomba'
      '  inner join abc_tanquecombustivel on'
      
        '    abc_tanquecombustivel.id_tanquecombustivel = abc_bombas.id_t' +
        'anquecombustivel')
    Left = 88
    Top = 56
    object qryAbastecimentoID_ABASTECIMENTO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID_ABASTECIMENTO'
      Origin = 'ID_ABASTECIMENTO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryAbastecimentoID_CLIENTE: TIntegerField
      DisplayLabel = 'Cliente'
      FieldName = 'ID_CLIENTE'
      Origin = 'ID_CLIENTE'
      Required = True
    end
    object qryAbastecimentoDSC_CLIENTE: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DSC_CLIENTE'
      Origin = 'NOME'
      ProviderFlags = []
      Size = 50
    end
    object qryAbastecimentoID_BOMBA: TIntegerField
      DisplayLabel = 'Bomba'
      FieldName = 'ID_BOMBA'
      Origin = 'ID_BOMBA'
      Required = True
    end
    object qryAbastecimentoDSC_BOMBA: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DSC_BOMBA'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      Size = 50
    end
    object qryAbastecimentoID_TANQUECOMBUSTIVEL: TIntegerField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Combust'#237'vel'
      FieldName = 'ID_TANQUECOMBUSTIVEL'
      Origin = 'ID_TANQUECOMBUSTIVEL'
      ProviderFlags = []
    end
    object qryAbastecimentoDSC_TANQUECOMBUSTIVEL: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DSC_TANQUECOMBUSTIVEL'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      Size = 50
    end
    object qryAbastecimentoDATA_ABASTECIMENTO: TSQLTimeStampField
      DisplayLabel = 'Data Abastecimento'
      FieldName = 'DATA_ABASTECIMENTO'
      Origin = 'DATA_ABASTECIMENTO'
      EditMask = '99/!99/0000;1;_'
    end
    object qryAbastecimentoIMPOSTO_ABASTECIMENTO: TFMTBCDField
      DisplayLabel = 'Imposto (%)'
      FieldName = 'IMPOSTO_ABASTECIMENTO'
      Origin = 'IMPOSTO_ABASTECIMENTO'
      DisplayFormat = ',0.00'
      Precision = 18
      Size = 2
    end
    object qryAbastecimentoQTD_LITRO: TBCDField
      DisplayLabel = 'Quantidade (L)'
      FieldName = 'QTD_LITRO'
      Origin = 'QTD_LITRO'
      OnChange = qryAbastecimentoQTD_LITROChange
      DisplayFormat = ',0.0000'
      Precision = 18
    end
    object qryAbastecimentoVLR_LITRO: TBCDField
      DisplayLabel = 'Valor Litro'
      FieldName = 'VLR_LITRO'
      Origin = 'VLR_LITRO'
      OnChange = qryAbastecimentoVLR_LITROChange
      DisplayFormat = ',0.0000'
      Precision = 18
    end
    object qryAbastecimentoTOTAL_ABASTECIMENTO: TFMTBCDField
      DisplayLabel = 'Total Abastecimento'
      FieldName = 'TOTAL_ABASTECIMENTO'
      Origin = 'TOTAL_ABASTECIMENTO'
      OnChange = qryAbastecimentoTOTAL_ABASTECIMENTOChange
      DisplayFormat = ',0.00'
      Precision = 18
      Size = 2
    end
    object qryAbastecimentoTOTAL_IMPOSTO: TFMTBCDField
      DisplayLabel = 'Total c/ Imposto'
      FieldName = 'TOTAL_IMPOSTO'
      Origin = 'TOTAL_IMPOSTO'
      DisplayFormat = ',0.00'
      Precision = 18
      Size = 2
    end
  end
end
