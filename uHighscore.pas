{
     Autor:       Delphi-AG Okengymnasiums 2007, weiterbearbeitet von Marco Hetzel

     File:        uHighscore.pas

     Source:      http://delphi-lernen.de

     Contact:     Tetris@delphi-lernen.de

     Copyright:   2007-2008 Delphi-AG und Marco Hetzel

}
unit uHighscore;

interface

uses
  Windows, ExtCtrls, SysUtils, Classes, DateUtils, Graphics, Forms;

type
  RHighscore = record
    name      : String[10];
    Points    : Integer;
    DateTime,
    UsedTime  : TDateTime;
    RowCount,
    Size,
    Level     : Integer;
  end;

  TLocalHighScore = Array[0..19] of RHighscore;

  THighScore = class(TObject)
  private
    fLocalHighScore : TLocalHighScore;
    fScore          : Integer;
    fRowCount       : Integer;
    fGameSize       : Byte;
     
    procedure LoadHighscore;
  public
    procedure Show(Image:TImage);
    procedure IncScore(Level: Integer);
    procedure IncScoreRow(Level: Integer);
    function GotHighscore(Image:TImage; AUsedTime : TDateTime;
      Rows, Size, Level: Integer):Boolean; 
    function SaveHighscore:boolean;

    function GetPreviousScore:Integer;
    procedure Init(GameSize:Integer);

    constructor Create;
  end;

var
  HighScore:THighScore; 

implementation

uses
   mGame, MainUnit, fOptions, Dialogs;

             


//######################## LoadHighscore (privat) ##############################

procedure THighScore.LoadHighscore;
var
  f:File of TLocalHighScore;
  FileName:String;
  i: Integer;

  function zweistellig(i:integer):String;
  var
    s:String;
  begin
    s:=IntToStr(i);
    if length(s)=1 then
      result:='0'+s
    else
      result:=s;    
  end;

begin
  FileName:=ExtractFilePath(ParamStr(0))+'highscore.dat';
  if FileExists(FileName) then
  begin
    try
      AssignFile(f,Filename);
      Reset(f);
      Read(f,fLocalHighScore);
      CloseFile(f);
    except
      Application.MessageBox('Fehler beim Laden des Highscores.',
                             'Fehler',MB_OK+MB_ICONERROR);
    end;
  end
  else
  begin
    // Default-Werte für die Highscores:
    fLocalHighScore[0].name:='Anna';
    fLocalHighScore[1].name:='Benedigt';
    fLocalHighScore[2].name:='Christina';
    fLocalHighScore[3].name:='Denis';
    fLocalHighScore[4].name:='Elvira';
    fLocalHighScore[5].name:='Frederik';
    fLocalHighScore[6].name:='Gabi';
    fLocalHighScore[7].name:='Hugo';
    fLocalHighScore[8].name:='Irmgard';
    fLocalHighScore[9].name:='Julian';
    fLocalHighScore[10].name:='Klara';
    fLocalHighScore[11].name:='Lorenz';
    fLocalHighScore[12].name:='Matilda';
    fLocalHighScore[13].name:='Norbert';
    fLocalHighScore[14].name:='Olga';
    fLocalHighScore[15].name:='Paul';
    fLocalHighScore[16].name:='Quendoline';
    fLocalHighScore[17].name:='Rüdiger';
    fLocalHighScore[18].name:='Stefanie';
    fLocalHighScore[19].name:='Tim';
    fLocalHighScore[0].Points:=100000;
    fLocalHighScore[1].Points:=90000;
    fLocalHighScore[2].Points:=80000;
    fLocalHighScore[3].Points:=70000;
    fLocalHighScore[4].Points:=60000;
    fLocalHighScore[5].Points:=50000;
    fLocalHighScore[6].Points:=30000;
    fLocalHighScore[7].Points:=25000;
    fLocalHighScore[8].Points:=20000;
    fLocalHighScore[9].Points:=15000;
    fLocalHighScore[10].Points:=10000;
    fLocalHighScore[11].Points:=7500;
    fLocalHighScore[12].Points:=5000;
    fLocalHighScore[13].Points:=2500;
    fLocalHighScore[14].Points:=1250;
    fLocalHighScore[15].Points:=800;
    fLocalHighScore[16].Points:=400;
    fLocalHighScore[17].Points:=200;
    fLocalHighScore[18].Points:=100;
    fLocalHighScore[19].Points:=50;
    for i := 0 to 19 do
      fLocalHighScore[i].DateTime:=StrToDateTime('27.07.2007 20:35');
    for i := 0 to 19 do
      fLocalHighScore[i].UsedTime:=StrToTime(zweistellig(19-i)+':'+
        zweistellig(random((10*(19-i)) mod 60))+':'+zweistellig(random(30)+30));
    for i := 0 to 19 do
      fLocalHighScore[i].RowCount:=(19-i)*7+random(30-i);
    for i := 0 to 19 do
      fLocalHighScore[i].Size:=1;   
    for i := 0 to 19 do     
      fLocalHighScore[i].Level:=19-i;
    if not SaveHighscore then
      Application.MessageBox('Fehler beim Speichern der Standard-Highscore-daten.',
                             'Fehler',MB_OK+MB_ICONERROR);
  end;
end;


//######################## SaveHighscore (privat) ##############################

function THighScore.SaveHighscore:boolean;
var
  f:File of TLocalHighScore;
  FileName:String;
begin
  try
    FileName:=ExtractFilePath(ParamStr(0))+'highscore.dat';
    if FileExists(FileName) then
      DeleteFile(FileName);
    AssignFile(f,Filename);
    Rewrite(f);
    Write(f,fLocalHighScore);
    CloseFile(f);
    result:=true;
  except
    result:=false;
  end;
end;


//######################## GotHighscore (public) ###############################

function THighScore.GotHighscore(Image:TImage; AUsedTime : TDateTime;
  Rows, Size, Level: Integer):Boolean;
var
  s:String;

  procedure SortHighscore;
  var
    i,k:Integer;
    p:Integer;
    n:String;
    d:TDateTime;
  begin
    for i := 0 to 18 do
      for k := i+1 to 19 do
        if fLocalHighScore[i].Points<fLocalHighScore[k].Points then
        begin
          n:=fLocalHighScore[i].Name;
          fLocalHighScore[i].Name:=fLocalHighScore[k].Name;
          fLocalHighScore[k].Name:=n;

          p:=fLocalHighScore[i].Points;
          fLocalHighScore[i].Points:=fLocalHighScore[k].Points;
          fLocalHighScore[k].Points:=p;

          d:=fLocalHighScore[i].DateTime;
          fLocalHighScore[i].DateTime:=fLocalHighScore[k].DateTime;
          fLocalHighScore[k].DateTime:=d;

          d:=fLocalHighScore[i].UsedTime;
          fLocalHighScore[i].UsedTime:=fLocalHighScore[k].UsedTime;
          fLocalHighScore[k].UsedTime:=d;

          p:=fLocalHighScore[i].RowCount;
          fLocalHighScore[i].RowCount:=fLocalHighScore[k].RowCount;
          fLocalHighScore[k].RowCount:=p;
          
          p:=fLocalHighScore[i].Size;
          fLocalHighScore[i].Size:=fLocalHighScore[k].Size;
          fLocalHighScore[k].Size:=p;  
          
          p:=fLocalHighScore[i].Level;
          fLocalHighScore[i].Level:=fLocalHighScore[k].Level;
          fLocalHighScore[k].Level:=p;
        end;
  end;

  function GetComputerName: String;
  var
    Len: DWORD;
  begin
    Len:=MAX_COMPUTERNAME_LENGTH+1;
    SetLength(Result,Len);
    if Windows.GetComputerName(PChar(Result), Len) then
      SetLength(Result,Len)
    else
      RaiseLastOSError;
  end;
          
label tryagain;
begin
  result:=false;
  if fLocalHighScore[19].Points<fScore then
  begin
    Application.MessageBox(PChar('Herzlichen Glückwunsch!'+#13
           +'Du hast den Highscore geknackt!'),'New Highscore!',MB_OK);
    tryagain:
    s:=InputBox('Game::Over!','Du hast '+IntToStr(fScore)+' Punkte!'+#13+'Dein Name:',s);
    if length(s)>10 then
    begin
        Application.MessageBox('Fehlerhafte Eingabe - bitte nur 10 Zeichen eingeben!',
                               'Fehler',MB_OK+MB_ICONERROR);
        goto tryagain;
    end
    else
    begin
      if s='' then
        s:=GetComputername;
      fLocalHighScore[19].Name:=s;
      fLocalHighScore[19].Points:=fScore;
      fLocalHighScore[19].DateTime:=Now;
      fLocalHighScore[19].UsedTime:=AUsedTime;
      fLocalHighScore[19].RowCount:=Rows;     
      fLocalHighScore[19].Size:=Size;   
      fLocalHighScore[19].Level:=Level;
      result:=true;
      SortHighscore;
      Show(Image);
    end;
  end
  else
    Application.MessageBox(PChar('Du hast '+
       IntToStr(fScore)+' Punkte!'),'Game::Over!',MB_OK+MB_ICONINFORMATION);
end;


//######################## IncScore (public) ###################################

procedure THighScore.IncScore(Level: Integer);
begin
  if fRowCount>0 then
    Dec(fRowCount);
  Case fGameSize of
    PG_SMALL:
    begin
      if Level<LEVEL_MAX div 4 then
        Inc(fScore)                
      else if Level<LEVEL_MAX div 2 then
        fScore:=fScore+2           
      else if Level<LEVEL_MAX*3 div 4 then
        fScore:=fScore+3
      else
        fScore:=fScore+4;
    end;
    PG_MEDIUM:
    begin
      if Level<LEVEL_MAX div 3 then
        Inc(fScore)                
      else if Level<LEVEL_MAX*2 div 3 then
        fScore:=fScore+2
      else
        fScore:=fScore+3;
    end;
    PG_LARGE:
    begin
      if Level<LEVEL_MAX div 2 then
        Inc(fScore)
      else
        fScore:=fScore+2;
    end;
    PG_ULTRALARGE:
    begin                          
      if Level>LEVEL_MAX div 2 then
        Inc(fScore);
    end;
  End;
end;


//######################## IncScoreRow (public) ################################

procedure THighScore.IncScoreRow(Level: Integer);
begin
  Inc(fRowCount);
  Case fGameSize of
    PG_SMALL:
      fScore:=fScore+50*fRowCount+25*Level;
    PG_MEDIUM:
      fScore:=fScore+32*fRowCount+15*Level;
    PG_LARGE:
      fScore:=fScore+16*fRowCount+5*Level;
    PG_ULTRALARGE:
      fScore:=fScore+10*fRowCount;
  End;
end;


//######################## GetPreviousScore (public) ###########################

function THighScore.GetPreviousScore:Integer;
begin
  result:=fScore;
end;


//######################## ShowHighscore (public) ##############################

procedure THighScore.Show(Image:TImage);
var
  i:integer;

  function invertcolor(color: TColor):TColor;
  begin
    Result := ColorToRGB(color) xor $00FFFFFF;
  end;

begin
  with Image.Canvas do
  begin
    // TODO: (V1.1) Highscore online anzeigen -> php und Online-Highscore!
    MainForm.ClientWidth:=650;
    MainForm.ClientHeight:=540;
    Rectangle(0,0,Screen.Width,Screen.Height);
    Font.Name:='Lucida Console';
    Font.Size:=8;
    Brush.Color:=Game.BackgroundColor;
    Pen.Color:=Game.GridColor;
    font.Color:=invertcolor(Game.BackgroundColor);
    TextOut(5,5,Format('%-10s   %8s  %-6s %-6s %-5s  %-5s     %-17s',['  Name','Punkte','Reihen','Größe','Level','Dauer','Datum     Uhrzeit']));
    for i := 0 to 19 do
      TextOut(5,25*i+40,Format('%2d %-10s %7d   %4d  %4d  %4d   %-8s  %-9s',
                                      [i+1,
                                      fLocalHighScore[i].name,
                                      fLocalHighScore[i].Points,
                                      fLocalHighScore[i].RowCount,
                                      fLocalHighScore[i].Size, 
                                      fLocalHighScore[i].Level,
                                      TimeToStr(fLocalHighScore[i].UsedTime),
                                      DateTimeToStr(fLocalHighScore[i].DateTime)]));
  end;
end;


//######################## Init (public) #######################################

procedure THighScore.Init(GameSize:Integer);
begin
  fScore:=0;
  fRowCount:=0;
  fGameSize:=GameSize;
end;


//######################## Create (public) #####################################

constructor THighScore.Create;
begin
  inherited Create;
  LoadHighscore;
end;



end.
