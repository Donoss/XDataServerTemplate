object ServerContainer: TServerContainer
  Height = 210
  Width = 431
  object Dispatcher: TSparkleHttpSysDispatcher
    Left = 72
    Top = 16
  end
  object XDataServer: TXDataServer
    BaseUrl = 'http://+:80/donoss'
    Dispatcher = Dispatcher
    EntitySetPermissions = <>
    SwaggerOptions.Enabled = True
    SwaggerUIOptions.Enabled = True
    SwaggerUIOptions.ShowFilter = True
    SwaggerUIOptions.DisplayOperationId = True
    SwaggerUIOptions.TryItOutEnabled = True
    Left = 216
    Top = 16
  end
end
