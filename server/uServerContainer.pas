unit uServerContainer;

interface

uses
  System.SysUtils, System.Classes, Sparkle.HttpServer.Module,
  Sparkle.HttpServer.Context, Sparkle.Comp.Server,
  Sparkle.Comp.HttpSysDispatcher, Aurelius.Drivers.Interfaces,
  Aurelius.Comp.Connection, XData.Comp.ConnectionPool, XData.Server.Module,
  XData.Comp.Server;

type
  TServerContainer = class(TDataModule)
    Dispatcher: TSparkleHttpSysDispatcher;
    XDataServer: TXDataServer;
  private
    class var FInstance: TServerContainer;
    function GetIsServiceRunning: Boolean;
    function GetBaseUrl: string;

  public
    class function Shared: TServerContainer;
    class destructor Destroy;

    procedure StartServer;
    procedure StopServer;

    property IsServiceRunning: Boolean read GetIsServiceRunning;
    property BaseUrl: string read GetBaseUrl;

  end;



implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TServerContainer }

class destructor TServerContainer.Destroy;
begin
  FInstance.Free;
end;

function TServerContainer.GetBaseUrl: string;
begin
  Result := XDataServer.BaseUrl;
end;

function TServerContainer.GetIsServiceRunning: Boolean;
begin
  Result := Dispatcher.Active;
end;

class function TServerContainer.Shared: TServerContainer;
begin
 if not Assigned ( FInstance ) then
 begin
   FInstance := TserverContainer.Create(nil);
 end;

 Result := FInstance;
end;

procedure TServerContainer.StartServer;
begin
  if not IsServiceRunning then
  begin
    //  TODO: Set Config

    Dispatcher.Start;
  end;

end;

procedure TServerContainer.StopServer;
begin
  if IsServiceRunning then
  begin
    Dispatcher.Stop;
  end;

end;

end.
