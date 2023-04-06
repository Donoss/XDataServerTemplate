unit uAddressServiceImp;

interface

uses
  XData.Server.Module,
  XData.Service.Common,
  uAddressService;

type
  [ServiceImplementation]
  TAddressService = class(TInterfacedObject, IAddressService)

    function Echo( AText: String ): String;
    function Time: TDateTime;
    function UnixTime: Integer;

  end;

implementation
uses
  System.DateUtils;


{ TAddressService }

function TAddressService.Echo(AText: String): String;
begin
  Result := AText + AText;
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
