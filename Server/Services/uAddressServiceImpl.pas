unit uAddressServiceImpl;

interface

uses
  XData.Server.Module,
  XData.Service.Common,
  uAddressService,
  uProxyClasses,
  System.Generics.Collections;

type
  [ServiceImplementation]
  TAddressService = class(TInterfacedObject, IAddressService)

    function Echo( AText: String ): String;
    function Time: TDateTime;
    function UnixTime: Integer;
    function GetCustomers: TList<TCustomer>;

  end;

implementation
uses
  System.DateUtils;


{ TAddressService }

function TAddressService.Echo(AText: String): String;
begin
  Result := AText + AText;
end;

function TAddressService.GetCustomers: TList<TCustomer>;
var
  LCustomer: TCustomer;
  i: Integer;
begin
  Result := TList<TCustomer>.Create;
  for i := 0 to 9 do
  begin
    LCustomer := TCustomer.Create;
    LCustomer.FfirstName := 'Andy';
    LCustomer.FlastName := 'Norman';
    Result.Add( LCustomer );
  end;
end;

function TAddressService.Time: TDateTime;
begin
  Result := TDateTime.NowUTC;
end;

function TAddressService.UnixTime: Integer;
begin
  Result := DateTimeToUnix ( TDateTime.NowUTC );
end;

initialization
  RegisterServiceType(TAddressService);

end.
