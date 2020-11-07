{
     Autor:       Delphi-AG Okengymnasiums 2007, weiterbearbeitet von Marco Hetzel

     File:        MainUnit.pas

     Source:      http://delphi-lernen.de

     Contact:     Tetris@delphi-lernen.de

     Copyright:   2007-2008 Delphi-AG und Marco Hetzel

}
unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, Buttons;

  //{$DEFINE DEBUGMODE}

const
  APP_VERSIONNUM=1000;
  APP_VERSIONSTR='V1.0.0.0';
  APP_NAME = 'Tetris!';

{ detailierter Changelog:

0.9.0.0 Beta final ;-)

0.9.1.0:
- GameOver-Screenshot implementiert

0.9.1.1:
- Splashscreen bei Linux nichtmehr lila sondern Silber
- beim übernehmen der Optionen wird das Hauptfenster zentriert.

0.9.5.0:
- Sounds konfigurierbar
- Bug behoben, der das Weiterspielen nach einem Spiel erlaubte.

0.9.8.1
- Template auch im Vorschaufenster 

0.9.8.5
- Template im Vorschaufenster zentriert
- Vorschau unter Optionen verbessert
- Optionen->Grafik generell verbessert

0.9.9.0
- RePaint vollständig implementiert

1.0.0.0
- Update implementiert
- Standardmäßig Sounds deaktiviert

16.09.2007 V1.0.0.0 veröffentlicht!
 }
type
  TMainForm = class(TForm)
    PnlMenu: TPanel;
    ImgBildFlaeche: TImage;
    ImgPreview: TImage;
    SpBtnNewGame: TSpeedButton;
    SpBtnPause: TSpeedButton;
    SpBtnOptionen: TSpeedButton;
    SpBtnClose: TSpeedButton;
    LblPause: TLabel;
    SpeedButton1: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure BtnNewGameClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnPauseClick(Sender: TObject);
    procedure SpBtnOptionenClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  MainForm: TMainForm;

implementation

uses mGame, fSplashScreen, fOptions, uPlaySound;

{$R *.dfm}
    



//######################## BtnCloseClick #######################################

procedure TMainForm.BtnCloseClick(Sender: TObject);
begin  
  Close
end;


//######################## FormKeyDown #########################################

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not Game.isPause then
    if not Game.isLocked then
      if not Game.isOver then
        if Key = FrmOptions.Moveleft then
        begin
          if Game.MoveLeft then
            SndMove
          else
            SndError;
        end
        else if Key = FrmOptions.TurnLeft then
        begin
          if Game.TurnLeft then
            SndTurn
          else
            SndError;
        end
        else if Key = FrmOptions.MoveRight then
        begin
          if Game.MoveRight then
            SndMove
          else
            SndError;
        end
        else if Key = FrmOptions.TurnRight then
        begin
          if Game.TurnRight then
            SndTurn
          else
            SndError;
        end
        else if Key = FrmOptions.Down then
        begin
          Game.MoveDown;
          SndDrop;
        end
        else if Key = FrmOptions.OneDown then
        begin
          Game.MoveOneDown;
          SndDown;
        end
          {$IFDEF DEBUGMODE}
        else
          ShowMessage(IntToStr(Key));
          {$ELSE}
          ;
          {$ENDIF}
  if (Key = FrmOptions.Pause) and (not SpBtnNewGame.Enabled) then
    SpBtnPause.Click;
end;


//######################## BtnNewGameClick #####################################

procedure TMainForm.BtnNewGameClick(Sender: TObject);
begin
  FrmSplashScreen.FormHide(Sender);
  Game.NewGame(FrmOptions.UdLevelSelected.Position);
  SpBtnNewGame.Enabled:=false;
  SpBtnPause.Enabled:=true;
  SpBtnOptionen.Caption:='Spiel beenden';
end;


//######################## BtnPauseClick #######################################

procedure TMainForm.BtnPauseClick(Sender: TObject);
begin
  Game.DoPause(not Game.isPause);

  lblPause.Visible:=Game.isPause;
  ImgBildFlaeche.Visible:=not Game.isPause;
  SpBtnOptionen.Enabled:=not Game.isPause;

  if Game.isPause then
  begin
    SpBtnPause.Caption:='Weiter';
    SndLoopEnd;
  end
  else
  begin                         
    SndLoopStart;
    SpBtnPause.Caption:='Pause';
  end;

  if Game.isPause and (not SpBtnNewGame.Enabled) then
    LblPause.Left:=(ClientWidth+PnlMenu.Width-lblPause.Width) DIV 2;
end;


//######################## FormClose ###########################################

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not Game.isOver then 
  begin
    Game.DoPause(true);
    if Application.MessageBox('Willst du wirklich beenden?',
      'Wirklich beenden?',MB_YESNO+MB_ICONQUESTION)=ID_YES then
      FrmSplashScreen.Close
    else
    begin
      Action:=caNone;
      Game.DoPause(false);
    end;
  end
  else
    FrmSplashScreen.Close
end;


//######################## FormCreate ##########################################

procedure TMainForm.FormCreate(Sender: TObject);
begin
  DoubleBuffered:=true;
  randomize;
  Caption:=APP_NAME+' - '+APP_VERSIONSTR;
end;


//######################## FormResize ##########################################

procedure TMainForm.FormResize(Sender: TObject);
begin
  if not FrmSplashScreen.visible then
    Game.Repaint;
  if Game.isPause and (not SpBtnNewGame.Enabled) then
    LblPause.Left:=(ClientWidth+PnlMenu.Width-lblPause.Width) DIV 2;
end;


//######################## SpBtnOptionenClick ##################################

procedure TMainForm.SpBtnOptionenClick(Sender: TObject);
begin
  if SpBtnOptionen.Caption='Spiel beenden' then
  begin
    Game.DoPause(true);
    if Application.MessageBox('Willst du dieses Spiel wirklich schon beenden?','Achtung!',MB_YESNO+MB_ICONWARNING)=ID_YES then
    begin
      Game.DoPause(false);
      Game.Endgame;
    end
    else
      Game.DoPause(false);
  end
  else
  begin             
    FrmOptions.PageControl1.ActivePageIndex:=0;  
    FrmOptions.PageControl2.ActivePageIndex:=0;
    FrmOptions.Show;
    Hide;
  end;
end;


//######################## SpeedButton1Click ###################################

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
  Game.Debug;
end;

end.
