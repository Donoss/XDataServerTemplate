unit uAddressService;

interface

uses
  XData.Service.Common;

type
  [ServiceContract]
  IAddressService = interface(IInvokable)
    ['{FA3A18B1-0444-429B-8C63-5ED027B0ADC8}']

    function Echo( AText: String ): String;
  end;

implementation

initialization
  RegisterServiceType(TypeInfo(IAddressService));

end.