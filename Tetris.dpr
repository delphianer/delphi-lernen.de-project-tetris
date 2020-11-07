program Tetris;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

uses
{$IFnDEF FPC}
{$ELSE}
  Interfaces,
{$ENDIF}
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  mGame in 'mGame.pas' {Game: TDataModule},
  fSplashScreen in 'fSplashScreen.pas' {FrmSplashScreen},
  fOptions in 'fOptions.pas' {FrmOptions},
  uHighscore in 'uHighscore.pas',
  uPlaySound in 'uPlaySound.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Tetris';
  Application.CreateForm(TFrmSplashScreen, FrmSplashScreen);
  Application.CreateForm(TGame, Game);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFrmOptions, FrmOptions);
  Application.Run;
end.
