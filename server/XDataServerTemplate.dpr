program XDataServerTemplate;

uses
  Vcl.Forms,
  uServerContainer in 'uServerContainer.pas' {ServerContainer: TDataModule},
  uFrmMain in 'uFrmMain.pas' {FrmMain},
  uAddressService in 'Services\uAddressService.pas',
  uAddressServiceImpl in 'Services\uAddressServiceImpl.pas',
  uProxyClasses in 'ProxyClasses\uProxyClasses.pas',
  uDbController in 'Database\uDbController.pas' {DbController: TDataModule},
  uServerSettings in 'Template\uServerSettings.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
