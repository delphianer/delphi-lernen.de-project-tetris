{
     Autor:       Delphi-AG Okengymnasiums 2007, weiterbearbeitet von Marco Hetzel

     File:        uPlaySound.pas

     Source:      http://delphi-lernen.de

     Contact:     Tetris@delphi-lernen.de

     Copyright:   2007-2008 Delphi-AG und Marco Hetzel

}
unit uPlaySound;

interface

uses
  Mplayer;

var
  Sounds : record
    Down,
    Drop,
    Move,
    Turn,
    GameOver,
    Loop,
    Error:String;
  end;
  player : TMediaPlayer;
  noSounds : Boolean = true;
                  
Procedure SndDown;
Procedure SndDrop;  
Procedure SndMove;
Procedure SndTurn; 
Procedure SndGameOver;   
Procedure SndError; 
Procedure SndLoopStart; 
Procedure SndLoopEnd;

implementation

uses
  mmsystem, SysUtils;


procedure closeFirst;
begin
  Case player.Mode of
   mpNotReady,
   mpStopped,
   mpPlaying,
   mpRecording,
   mpSeeking,
   mpPaused,
   mpOpen: player.Close;
  end;
end;


Procedure SndDown;
begin
  if FileExists(Sounds.Down) and not noSounds then
  begin
    closeFirst;
    player.FileName:=Sounds.Down;
    player.Open;
    player.Play;
  end;
end;

Procedure SndDrop;
begin
  if FileExists(Sounds.Drop) and not noSounds then
  begin
    closeFirst;
    player.FileName:=Sounds.Drop;
    player.Open;  
    player.Play;
  end;
end;

Procedure SndMove;
begin
  if FileExists(Sounds.Move) and not noSounds then
  begin
    closeFirst;
    player.FileName:=Sounds.Move;
    player.Open;  
    player.Play;
  end;
end;

Procedure SndTurn;
begin
  if FileExists(Sounds.Turn) and not noSounds then
  begin
    closeFirst;
    player.FileName:=Sounds.Turn;
    player.Open; 
    player.Play;
  end;
end;

Procedure SndGameOver;
begin
  if FileExists(Sounds.GameOver) and not noSounds then
  begin
    closeFirst;
    player.FileName:=Sounds.GameOver;
    player.Open;
    player.Play;
  end;
end;


Procedure SndError;   
begin
  if FileExists(Sounds.Error) and not noSounds  then
  begin
    closeFirst;
    player.FileName:=Sounds.Error;
    player.Open;
    player.Play;
  end;
end;


Procedure SndLoopStart;
begin         
  if FileExists(Sounds.Loop) and not noSounds  then
    sndPlaySound(PChar(Sounds.Loop),SND_ASYNC or SND_LOOP);
end;

Procedure SndLoopEnd;
begin
  sndPlaySound(nil, 0);
end;

end.
