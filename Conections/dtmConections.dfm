object dtmConection: TdtmConection
  OldCreateOrder = False
  Height = 339
  Width = 238
  object ABCConnection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\DES\Documents\Embarcadero\Studio\Projects\Win3' +
        '2\TesteFortesTecnologia\DataBase\POSTO_ABC.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Server=localhost'
      'Port=3051'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    BeforeConnect = ABCConnectionBeforeConnect
    Left = 91
    Top = 52
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 87
    Top = 108
  end
  object FDGUIxErrorDialog1: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 87
    Top = 164
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    Left = 88
    Top = 220
  end
  object FDGUIxLoginDialog1: TFDGUIxLoginDialog
    Provider = 'Forms'
    Left = 87
    Top = 276
  end
end
