object dtmRelatorioAbastecimento: TdtmRelatorioAbastecimento
  OldCreateOrder = False
  Height = 203
  Width = 306
  object qryAbastecimentos: TFDQuery
    Connection = dtmConection.ABCConnection
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
      '  abc_abastecimento.total_abastecimento'
      'from'
      '  abc_abastecimento'
      '  inner join abc_cliente on'
      '    abc_cliente.id_cliente = abc_abastecimento.id_cliente'
      '  inner join abc_bombas on'
      '    abc_bombas.id_bomba = abc_abastecimento.id_bomba'
      '  inner join abc_tanquecombustivel on'
      
        '    abc_tanquecombustivel.id_tanquecombustivel = abc_bombas.id_t' +
        'anquecombustivel'
      'where'
      
        '  abc_abastecimento.data_abastecimento between :data_ini and :da' +
        'ta_fim')
    Left = 136
    Top = 88
    ParamData = <
      item
        Name = 'DATA_INI'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DATA_FIM'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object qryAbastecimentosID_ABASTECIMENTO: TIntegerField
      FieldName = 'ID_ABASTECIMENTO'
      Origin = 'ID_ABASTECIMENTO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryAbastecimentosID_CLIENTE: TIntegerField
      FieldName = 'ID_CLIENTE'
      Origin = 'ID_CLIENTE'
      Required = True
    end
    object qryAbastecimentosDSC_CLIENTE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DSC_CLIENTE'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object qryAbastecimentosID_BOMBA: TIntegerField
      FieldName = 'ID_BOMBA'
      Origin = 'ID_BOMBA'
      Required = True
    end
    object qryAbastecimentosDSC_BOMBA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DSC_BOMBA'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object qryAbastecimentosID_TANQUECOMBUSTIVEL: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ID_TANQUECOMBUSTIVEL'
      Origin = 'ID_TANQUECOMBUSTIVEL'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryAbastecimentosDSC_TANQUECOMBUSTIVEL: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DSC_TANQUECOMBUSTIVEL'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object qryAbastecimentosDATA_ABASTECIMENTO: TSQLTimeStampField
      FieldName = 'DATA_ABASTECIMENTO'
      Origin = 'DATA_ABASTECIMENTO'
    end
    object qryAbastecimentosIMPOSTO_ABASTECIMENTO: TFMTBCDField
      FieldName = 'IMPOSTO_ABASTECIMENTO'
      Origin = 'IMPOSTO_ABASTECIMENTO'
      DisplayFormat = ',0.00'
      Precision = 18
      Size = 2
    end
    object qryAbastecimentosQTD_LITRO: TBCDField
      FieldName = 'QTD_LITRO'
      Origin = 'QTD_LITRO'
      DisplayFormat = ',0.0000'
      Precision = 18
    end
    object qryAbastecimentosVLR_LITRO: TBCDField
      FieldName = 'VLR_LITRO'
      Origin = 'VLR_LITRO'
      DisplayFormat = ',0.0000'
      Precision = 18
    end
    object qryAbastecimentosTOTAL_ABASTECIMENTO: TFMTBCDField
      FieldName = 'TOTAL_ABASTECIMENTO'
      Origin = 'TOTAL_ABASTECIMENTO'
      DisplayFormat = ',0.00'
      Precision = 18
      Size = 2
    end
  end
end
