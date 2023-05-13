unit uAddressService;

interface

uses
  System.Generics.Collections,
  uProxyClasses,
  XData.Service.Common;

type
  [ServiceContract]
  IAddressService = interface(IInvokable)
    ['{FA3A18B1-0444-429B-8C63-5ED027B0ADC8}']

    [HttpGet]
    function Echo( AText: String ): String;

    [HttpGet]
    function Time: TDateTime;

    [HttpGet]
    function UnixTime: Integer;

    [HttpGet]
    function GetCustomers: TList<TCustomer>;


  end;

implementation

initialization
  RegisterServiceType(TypeInfo(IAddressService));

end.
