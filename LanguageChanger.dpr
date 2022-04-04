program LanguageChanger;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Glossy');
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
