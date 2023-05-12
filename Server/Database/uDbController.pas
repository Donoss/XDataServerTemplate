unit uDbController;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Phys, FireDAC.Comp.Client;

type
  TDbController = class(TDataModule)
    FDManager: TFDManager;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    class var FInstance: TDBController;

    function IsConnectionDefined: Boolean;
    function GetConnectionDefName: String;
    function GetDriverName: string;

  public
    { Public declarations }
    class function Shared: TDbController;
    class destructor Destroy;

    function GetConnection: TFDConnection;
    function GetQuery: TFDQuery;

    procedure ReturnConnectionToPool( AConnection: TFDCustomConnection ); overload;
    procedure ReturnConnectionToPool( AQuery: TFDQuery ); overload;

  end;

implementation

uses
  uServerSettings;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDbController }

procedure TDbController.DataModuleCreate(Sender: TObject);
begin
  FDManager.Active := True;
end;

class destructor TDbController.Destroy;
begin
   if Assigned( FInstance ) then
  begin
    FInstance.Free;
  end;
end;

function TDbController.GetConnection: TFDConnection;
var
  LParams: TStringList;
begin
  if not IsConnectionDefined then
  begin
    LParams := TStringList.Create;
    try
      TServerSettings.Shared.LoadConnectionParams( LParams);

      FDManager.AddConnectionDef(
        self.GetConnectionDefName,
        self.GetDriverName,
        LParams,
        False);
    finally
      LParams.Free;
    end;

  end;

  Result := TFDConnection.Create( nil );
  Result.LoginPrompt := False;
  Result.ConnectionDefName := self.GetConnectionDefName;
end;

function TDbController.GetConnectionDefName: String;
begin
  Result := TServerSettings.Shared.ConnectionDefName;
end;

function TDbController.GetDriverName: string;
begin
  Result := TServerSettings.Shared.DriverName;
end;

function TDbController.GetQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := GetConnection;
end;

function TDbController.IsConnectionDefined: Boolean;
begin
  Result := FDManager.ConnectionDefs.FindConnectionDef(self.GetConnectionDefName) <> nil;
end;

procedure TDbController.ReturnConnectionToPool(AQuery: TFDQuery);
var
  LCon: TFDCustomConnection;
begin
  LCon := AQuery.Connection;

  AQuery.Free;
  ReturnConnectionToPool( LCon );

end;

procedure TDbController.ReturnConnectionToPool(AConnection: TFDCustomConnection);
begin
  AConnection.Free;
end;

class function TDbController.Shared: TDbController;
begin
  if not Assigned( FInstance ) then
  begin
    FInstance := TDbController.Create(nil);
  end;
  Result := FInstance;

end;

end.