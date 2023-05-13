unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, uServerContainer;

type
  TFrmMain = class(TForm)
    mmInfo: TMemo;
    btStart: TButton;
    btStop: TButton;
    procedure btStartClick(ASender: TObject);
    procedure btStopClick(ASender: TObject);
    procedure FormCreate(ASender: TObject);
  strict private
    procedure UpdateGUI;

  private
    function GetIsServiceRunning: Boolean;
    function GetBaseUrl: string;

  public
    property IsServiceRunning: Boolean read GetIsServiceRunning;
    property BaseUrl: string read GetBaseUrl;
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses

  uServerSettings;

resourcestring
  SServerStopped = 'Server stopped';
  SServerStartedAt = 'Server started at ';

{ TMainForm }

procedure TFrmMain.btStartClick(ASender: TObject);
begin
  TServerContainer.Shared.StartServer;
  UpdateGUI;
end;

procedure TFrmMain.btStopClick(ASender: TObject);
begin
  TServerContainer.Shared.StopServer;
  UpdateGUI;
end;

procedure TFrmMain.FormCreate(ASender: TObject);
begin
  UpdateGUI;
end;

function TFrmMain.GetBaseUrl: string;
begin
  Result := TServerContainer.Shared.BaseUrl;
end;

function TFrmMain.GetIsServiceRunning: Boolean;
begin
  Result := TServerContainer.Shared.IsServiceRunning;
end;

procedure TFrmMain.UpdateGUI;
const
  cHttp = 'http://+';
  cHttpLocalhost = 'http://localhost';
begin
  btStart.Enabled := not IsServiceRunning;
  btStop.Enabled := not btStart.Enabled;
  if IsServiceRunning then
    mmInfo.Lines.Add(SServerStartedAt + StringReplace(
      BaseUrl,
      cHttp, cHttpLocalhost, [rfIgnoreCase]))
  else
    mmInfo.Lines.Add(SServerStopped);
end;

end.
