{
     Autor:       Delphi-AG Okengymnasiums 2007, weiterbearbeitet von Marco Hetzel

     File:        mGame.pas

     Source:      http://delphi-lernen.de

     Contact:     Tetris@delphi-lernen.de

     Copyright:   2007-2008 Delphi-AG und Marco Hetzel

}
unit mGame;

interface

uses
  SysUtils, Classes, ExtCtrls,  Windows, ImgList, Controls, Graphics;

const
  SIDELENGTH=30;

  PG_SMALL=1;   // PG=Playground
  PG_SWIDTH=7;
  PG_SHEIGHT=11; // = 77

  PG_MEDIUM=2;
  PG_MWIDTH=9;
  PG_MHEIGHT=17; // = 153

  PG_LARGE=3;
  PG_LWIDTH=11;
  PG_LHEIGHT=21; // = 231

  PG_ULTRALARGE=4;
  PG_ULWIDTH=29;
  PG_ULHEIGHT=22; // = 638

  OBJ_TREPPERECHTS = 0;
  OBJ_TREPPELINKS = 1;
  OBJ_L = 2;
  OBJ_LSPIEGEL = 3;
  OBJ_PODEST = 4;
  OBJ_STAB = 5;
  OBJ_QUADRAT = 6;

  LEVEL_MAX = 20;

  TIME_PER_ROUND = '00:02:30';
    
type
  RField = Record
    isObject    : boolean;
    Color       : TColor;
    TemplateNum : Integer;
    RePaint     : Boolean;
  end;

  RObject = Record
    Kind      : Byte;
    PosZero   : TPoint;
    Color     : TColor;
    Pos       : Array[1..4] of TPoint;   
    TemplateNum : Integer;  
  end;

  TColorArray = Array[0..6] of TColor;

  TPlayground = Array of Array of RField;

  TGame = class(TDataModule)
    GameTimer: TTimer;
    PlayTime: TTimer;
    TemplateItems: TImageList;
    procedure GameTimerTimer(Sender: TObject);
    procedure PlayTimeTimer(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    fNextObject      : RObject;
    fThisObject      : RObject;
    fPlayground      : TPlayground;
    fBackgroundColor,
    fGridColor       : TColor;
    fColor           : TColorArray;
    fisPause         : Boolean;
    fSize            : Byte;
    fLevel           : Byte;
    fImage           : TImage;
    fGameOver        : Boolean;   
    fPreviewImage    : TImage;
    fisLocked        : Boolean;
    fGameMode        : Byte;
    fRows            : Integer;
    fGameSeconds     : TDateTime;

    procedure NewNextObject;
    procedure UpdatePreview;
    procedure UpdateHighscore;
    procedure RepaintPreview;
    procedure SetObjColor(Color:TColorArray);
    procedure Lock;
    procedure Unlock;
    procedure IncLevel;
    procedure AddBottomRow;

    function GetRowHigh:Integer;  
    function GetObjColor:TColorArray;
    function MoveObject:Boolean;
  public
    property BackgroundColor : TColor read fBackgroundColor write fBackgroundColor;
    property GridColor       : TColor read fGridColor write fGridColor;
    property Colors          : TColorArray read GetObjColor write SetObjColor;
    property isPause         : Boolean read fisPause;
    property isOver      : boolean read fGameOver;

    procedure Init(Size: Byte; Image, PreviewImage: TImage;
      ABackgroundColor, AGridColor: TColor);
    procedure NewGame(StartLevel:Integer);
    procedure Repaint;
    procedure DoPause(pause:Boolean);
    procedure SetSize(NewSize:Byte);
    procedure Endgame;
    procedure MoveDown;
    procedure MoveOneDown;

    function MoveLeft:Boolean;
    function MoveRight:Boolean;
    function TurnLeft:Boolean;
    function TurnRight:Boolean;
                            
    function isLocked:Boolean;

    procedure Debug;
  
  end;

var
  Game: TGame;

implementation

uses
  Math, Types, Forms, MainUnit, Dialogs, uHighscore, 
  DateUtils, jpeg, fOptions, uPlaySound;

{$R *.dfm}


//################ NewNextObject (private) #####################################

procedure TGame.NewNextObject;
begin
  fNextObject.Kind := random(OBJ_QUADRAT+1);
  fNextObject.PosZero.X := (High(fPlayground) div 2)-1;
  fNextObject.PosZero.Y := 0;
  fNextObject.Color := fColor[random(7)];
  fNextObject.TemplateNum := random(TemplateItems.Count-1)+1;
  with fNextObject do
  begin
    case fNextObject.Kind of
      OBJ_TREPPERECHTS:
        begin
          Pos[1].X:=0+PosZero.X;
          Pos[1].Y:=0;
          Pos[2].X:=1+PosZero.X;
          Pos[2].Y:=0;
          Pos[3].X:=1+PosZero.X;
          Pos[3].Y:=1;
          Pos[4].X:=2+PosZero.X;
          Pos[4].Y:=1;
        end;
      OBJ_TREPPELINKS:
        begin
          Pos[1].X:=0+PosZero.X;
          Pos[1].Y:=1;
          Pos[2].X:=1+PosZero.X;
          Pos[2].Y:=0;
          Pos[3].X:=1+PosZero.X;
          Pos[3].Y:=1;
          Pos[4].X:=2+PosZero.X;
          Pos[4].Y:=0;
        end;
      OBJ_L:
        begin
          Pos[1].X:=0+PosZero.X;
          Pos[1].Y:=0;
          Pos[2].X:=0+PosZero.X;
          Pos[2].Y:=1;
          Pos[3].X:=0+PosZero.X;
          Pos[3].Y:=2;
          Pos[4].X:=1+PosZero.X;
          Pos[4].Y:=2;
        end;
      OBJ_LSPIEGEL:
        begin
          Pos[1].X:=1+PosZero.X;
          Pos[1].Y:=0;
          Pos[2].X:=1+PosZero.X;
          Pos[2].Y:=1;
          Pos[3].X:=1+PosZero.X;
          Pos[3].Y:=2;
          Pos[4].X:=0+PosZero.X;
          Pos[4].Y:=2;
        end;
      OBJ_PODEST:
        begin
          Pos[1].X:=0+PosZero.X;
          Pos[1].Y:=1;
          Pos[2].X:=1+PosZero.X;
          Pos[2].Y:=0;
          Pos[3].X:=1+PosZero.X;
          Pos[3].Y:=1;
          Pos[4].X:=2+PosZero.X;
          Pos[4].Y:=1;
        end;
      OBJ_STAB:
        begin
          Pos[1].X:=0+PosZero.X;
          Pos[1].Y:=0;
          Pos[2].X:=0+PosZero.X;
          Pos[2].Y:=1;
          Pos[3].X:=0+PosZero.X;
          Pos[3].Y:=2;
          Pos[4].X:=0+PosZero.X;
          Pos[4].Y:=3;
        end;
      OBJ_QUADRAT:
        begin
          Pos[1].X:=0+PosZero.X;
          Pos[1].Y:=0;
          Pos[2].X:=0+PosZero.X;
          Pos[2].Y:=1;
          Pos[3].X:=1+PosZero.X;
          Pos[3].Y:=0;
          Pos[4].X:=1+PosZero.X;
          Pos[4].Y:=1;
        end;
    end;  // of Case
  end;
  UpdatePreview;
end;


//################ PlayTimeTimer (private) #####################################

procedure TGame.PlayTimeTimer(Sender: TObject);

  function TimeForNextLevel(t:TDateTime):Boolean;
  var
    s1:String;
  begin
    s1:=TimeToStr(t);
    if s1 < TIME_PER_ROUND then
    begin
      if s1 = '00:00:00' then
        result:=true
      else
        result:=false;
    end
    else
      result:= TimeForNextLevel(t-StrToTime(TIME_PER_ROUND));
  end;
  
begin
  fGameSeconds:=IncSecond(fGameSeconds,1);
  UpdateHighscore; 
  if TimeForNextLevel(fGameSeconds) then
    IncLevel;
end;


//################ UpdatePreview (private) #####################################

procedure TGame.UpdatePreview;
var
  i, x, y:Integer;
  Img: TImage;
  Bmp: TBitmap;

  procedure paintRectangle(x,y:Integer; Col:TColor);
  var
    realP1, realP2:TPoint;
    realLengthOfSide:Integer;
  begin
    // 1. x-y in Sektionen Teilen
    realLengthOfSide:=25;
    realP1.X:=x*realLengthOfSide;
    realP1.Y:=y*realLengthOfSide;
    realP2.X:=(x+1)*realLengthOfSide;
    realP2.Y:=(y+1)*realLengthOfSide;
    // 2. Quadrate bzw. Rechtecke zeichnen
    with fPreviewImage.Canvas do
    begin
      Brush.Color:=Col;
      Pen.Width:=1;
      pen.Color:=fGridColor;
      Rectangle(realP1.X,realP1.Y,realP2.X,realP2.Y);
      fPreviewImage.Canvas.Brush.Color:=fBackgroundColor;
    end;
  end;

begin
  if FrmOptions.RbOldStyle.Checked then
  begin
    for x := 0 to 3 do
      for y := 3 to 6 do
        paintRectangle(x,y,BackgroundColor);
    if not isPause then
      for i := 1 to 4 do
        with fNextObject do
          paintRectangle(Pos[i].X-PosZero.X,Pos[i].Y-PosZero.Y+3,Color);
  end
  else
  begin
    for x := 0 to 3 do
      for y := 3 to 6 do
      begin
        Img := TImage.Create(Application);
        bmp := TBitmap.Create;
        Img.Width := TemplateItems.Width;
        Img.Height := TemplateItems.Height;
        bmp.Width := Img.Width;            
        bmp.Height := Img.Height;
        TemplateItems.Draw(bmp.Canvas, 0, 0, 0);
        Img.Canvas.StretchDraw(Rect(0,0,24,24),bmp); 
        Img.Width := 24;
        Img.Height := 24;
        Img.Picture.Graphic.Width := 24;
        Img.Picture.Graphic.Height := 24;

        fPreviewImage.Canvas.Draw(x*25,y*25,Img.Picture.Bitmap);
        Img.Free;
        bmp.Free;
      end;
    if not isPause then
      for i := 1 to 4 do
      begin
        Img := TImage.Create(Application);
        bmp := TBitmap.Create;
        Img.Width := TemplateItems.Width;
        Img.Height := TemplateItems.Height;
        bmp.Width := Img.Width;            
        bmp.Height := Img.Height;
        TemplateItems.Draw(bmp.Canvas, 0, 0, fNextObject.TemplateNum);
        Img.Canvas.StretchDraw(Rect(0,0,24,24),bmp); 
        Img.Picture.Graphic.Width := 24;
        Img.Picture.Graphic.Height := 24;
        Img.Width := 24;
        Img.Height := 24;

        with fNextObject do
          fPreviewImage.Canvas.Draw((Pos[i].X-PosZero.X)*25,
                                    (Pos[i].Y-PosZero.Y+3)*25,
                                    Img.Picture.Bitmap);
        Img.Free;
        bmp.Free;
      end;
  end;
end;


//################ UpdateHighscore (private) ###################################

procedure TGame.UpdateHighscore;
var
  s:String;
  w:Integer;

  function invertcolor(color: TColor):TColor;
  begin
    Result := ColorToRGB(color) xor $00FFFFFF;
  end;

begin
  fPreviewImage.Canvas.Font.Color:=invertcolor(BackgroundColor);
  with fPreviewImage.Canvas do
  begin
    s:=IntToStr(HighScore.GetPreviousScore);
    w:=TextWidth(s);
    TextOut(3,5,'Punkte:');
    TextOut(fPreviewImage.Width-w-3,5,s);
    s:=IntToStr(fLevel);
    w:=TextWidth(s);
    TextOut(3,21,'Level:');
    TextOut(fPreviewImage.Width-w-3,21,s);
    s:=IntToStr(fRows);
    w:=TextWidth(s);
    TextOut(3,37,'Reihen:');
    TextOut(fPreviewImage.Width-w-3,37,s);
    s:=TimeToStr(fGameSeconds);
    w:=TextWidth(s);
    TextOut(3,53,'Zeit:');
    TextOut(fPreviewImage.Width-w-3,53,s);
  end;
end;


//################ RepaintPreview (private) ####################################

procedure TGame.RepaintPreview;
begin             
  fPreviewImage.Canvas.Brush.Color:=fBackgroundColor;
  fPreviewImage.Canvas.Pen.Color:=fGridColor;
  fPreviewImage.Canvas.Rectangle(0,0,fPreviewImage.Width,fPreviewImage.Height);
  UpdatePreview;
  UpdateHighscore;
end;


//################ SetObjColor (private) #######################################

procedure TGame.SetObjColor(Color : TColorArray);
var
  i:Integer;
begin
  for i := 0 to 6 do
    fColor[i]:=Color[i];
end;


//################ Lock (private) ##############################################

procedure TGame.Lock;
begin              
  fisLocked:=true;
end;


//################ Unlock (private) ############################################

procedure TGame.Unlock;
begin
  fisLocked:=false;
end;


//################ IncLevel (private) ##########################################

procedure TGame.IncLevel;
begin
  Inc(fLevel);
  if fLevel<LEVEL_MAX then
  begin
    if fLevel<LEVEL_MAX div 2 then
      GameTimer.Interval:=1000 - fLevel*50
    else if fLevel<LEVEL_MAX then
      GameTimer.Interval:=500 - fLevel*25
  end;
 // ShowMessage(IntToStr(GetRowHigh));
  if (GetRowHigh < (High(fPlayground[0])-7)) and ((fLevel-1) mod 2 = 0) then
    AddBottomRow;
end;


//################ AddBottomRow (private) ######################################

procedure TGame.AddBottomRow;
var
  x, y:Integer;
begin
  // alles eins höher
  if fThisObject.PosZero.Y>0 then
  begin
    fThisObject.PosZero.Y:=fThisObject.PosZero.Y-1;
    for y := 1 to 4 do
      fThisObject.Pos[y].Y:=fThisObject.Pos[y].Y-1;
  end;
  for x:=0 to High(fPlayground) do
    for y:=1 to High(fPlayground[0]) do
    begin
      fPlayground[x,y-1].isObject:=fPlayground[x,y].isObject;
      fPlayground[x,y-1].Color:=fPlayground[x,y].Color;      
      fPlayground[x,y-1].TemplateNum:=fPlayground[x,y].TemplateNum;  
      fPlayground[x,y-1].RePaint:=fPlayground[x,y].RePaint;
    end;
  // Reihe unten einfügen
  for x := 0 to High(fPlayground) do
  begin
    if random(100) mod 2 = 0 then
    begin
      fPlayground[x,High(fPlayground[0])].isObject:=True;
      fPlayground[x,High(fPlayground[0])].Color:=fColor[random(Length(fColor))];
      fPlayground[x,High(fPlayground[0])].TemplateNum:=random(TemplateItems.Count-1)+1; 
      fPlayground[x,High(fPlayground[0])].RePaint:=true;
    end
    else
    begin
      fPlayground[x,High(fPlayground[0])].isObject:=False;
      fPlayground[x,High(fPlayground[0])].RePaint:=true;
    end;
  end;
  Repaint;
end;


//################ GetObjColor (private) #######################################

function TGame.GetRowHigh:Integer;
var
  x,y,h:Integer;
begin
  h:=High(fPlayground[0]);
  for x := 0 to High(fPlayground) do
    for y := 0 to High(fPlayground[0]) do
      if fPlayground[x,y].isObject then
        if y<h then
          h:=y;
  result:=High(fPlayground[0])-h+1;
end;


//################ GetObjColor (private) #######################################

function TGame.GetObjColor : TColorArray;
var
  i:Integer;
begin
  for i := 0 to 6 do
    result[i]:=fColor[i];
end;


//################ MoveObject (private) ########################################

function TGame.MoveObject:Boolean;
var
  i:Integer;
begin
  result:=true;
  with fThisObject do
  begin

    for i := 1 to 4 do  // sind wir schon am "Boden"?
      if Pos[i].Y=High(fPlayground[0]) then
        result:=false;

    if result then
      for i := 1 to 4 do  // ist unter uns ein anderes Objekt?
        if fPlayground[Pos[i].X][Pos[i].Y+1].isObject then
          result:=false;

    for i := 1 to 4 do
      if not Result then // Wenn nicht bewegbar:
      begin
        fPlayground[Pos[i].X][Pos[i].Y].isObject:=true;
        fPlayground[Pos[i].X][Pos[i].Y].Color:=fThisObject.Color;     
        fPlayground[Pos[i].X][Pos[i].Y].TemplateNum:=fThisObject.TemplateNum; 
      end
      else // ansonsten bewege:
        Inc(Pos[i].Y);

    if Result then
      Inc(fThisObject.PosZero.Y);
  end;
end;


//################## Init (public) #############################################

procedure TGame.Init(Size: Byte; Image, PreviewImage: TImage;
  ABackgroundColor, AGridColor: TColor);
begin
  fImage:=Image;
  fPreviewImage:=PreviewImage;
  fLevel:=0;

  fisPause:=true;
  fGameOver:=true;
  fBackgroundColor:=ABackgroundColor;
  fGridColor:=AGridColor;
                  
  SetSize(Size);

  fRows := 0;
  fGameMode:=0;
end;


//################## NewGame (public) ##########################################

procedure TGame.NewGame(StartLevel:Integer);
var
  i:Integer;
begin
  HighScore.Init(fSize);
  NewNextObject;
  PlayTime.Enabled:=true;
  fGameOver:=false;
  fThisObject.Kind:=fNextObject.Kind;
  fThisObject.Color:=fNextObject.Color;
  fThisObject.PosZero.X:=fNextObject.PosZero.X;
  fThisObject.PosZero.Y:=fNextObject.PosZero.Y;
  for i := 1 to 4 do
  begin
    fThisObject.Pos[i].X:=fNextObject.Pos[i].X;
    fThisObject.Pos[i].Y:=fNextObject.Pos[i].Y;
  end;                                         
  fThisObject.TemplateNum:=fNextObject.TemplateNum;
  NewNextObject;
  GameTimer.Enabled:=true;
  fisPause:=false;

  while fLevel<StartLevel do
    IncLevel;

  Repaint;
  RepaintPreview;
  SndLoopStart;
end;


//################## Repaint (public) ##########################################

procedure TGame.Repaint;
var
  i, x, y: Integer;

  procedure paintRectangle(x,y:Integer; Col:TColor);
  var
    realP1, realP2:TPoint;
    realLengthOfSide:Integer;

  begin
    // 1. x-y in Sektionen Teilen
    realLengthOfSide:=SIDELENGTH;
    //Floor(Min(fImage.Width / Length(fPlayground),
    //                            fImage.Height / Length(fPlayground[0])));
    realP1.X:=x*realLengthOfSide;
    realP1.Y:=y*realLengthOfSide;
    realP2.X:=(x+1)*realLengthOfSide;
    realP2.Y:=(y+1)*realLengthOfSide;
    // 2. Quadrate bzw. Rechtecke zeichnen
    with fImage.Canvas do
    begin
      Brush.Color:=Col;
      Pen.Width:=1;
      pen.Color:=fGridColor;
      Rectangle(realP1.X,realP1.Y,realP2.X,realP2.Y);
      fImage.Canvas.Brush.Color:=fBackgroundColor;
    end;
  end;

begin
  fImage.Canvas.Brush.Color:=fBackgroundColor;
  fImage.Canvas.Pen.Color:=fGridColor;
  fImage.Canvas.Rectangle(-1,-1,fImage.Width+1,fImage.Height+1);

  if FrmOptions.RbOldStyle.Checked then
  begin
    for x := 0 to High(fPlayground) do
      for y := 0 to High(fPlayground[0]) do
        if fPlayground[x,y].isObject then
          paintRectangle(x,y,fPlayground[x,y].Color)
        else
          paintRectangle(x,y,fBackgroundColor);
  //  if not isPause then
      for i := 1 to 4 do
      begin
        paintRectangle(fThisObject.Pos[i].X,fThisObject.Pos[i].Y,
          fThisObject.Color);
      end;
  end
  else
  begin 
    for x := 0 to High(fPlayground) do
      for y := 0 to High(fPlayground[0]) do
        if fPlayground[x,y].RePaint then
        begin
          if fPlayground[x,y].isObject then // TODO: (bis 1.0 final) Ausreichend testen! 
            TemplateItems.Draw(fImage.Canvas,x*SIDELENGTH,y*SIDELENGTH,fPlayground[x,y].TemplateNum)
          else
            TemplateItems.Draw(fImage.Canvas,x*SIDELENGTH,y*SIDELENGTH,0);
        end;
      for i := 1 to 4 do
      begin
        x:=fThisObject.Pos[i].X;
        y:=fThisObject.Pos[i].Y;
        TemplateItems.Draw(fImage.Canvas,x*SIDELENGTH,y*SIDELENGTH,fThisObject.TemplateNum);
      end;
  end;

  fImage.Picture.Graphic.Width:=fImage.Width;
  fImage.Picture.Graphic.Height:=fImage.Height;
end;


//################## DoPause (public) ##########################################

procedure TGame.DoPause(pause:Boolean);
begin
  fisPause:=pause;
  GameTimer.Enabled:=not pause;
  PlayTime.Enabled:=not pause;
end;


//################## SetSize (public) ##########################################

procedure TGame.SetSize(NewSize:Byte);
var
  i,x,y,
  Width,Height:Integer;
begin
  fSize:=NewSize;
  case NewSize of
    PG_SMALL:
      begin
        Width:=PG_SWIDTH;
        Height:=PG_SHEIGHT;
      end;
    PG_MEDIUM:
      begin
        Width:=PG_MWIDTH;
        Height:=PG_MHEIGHT;
      end;
    PG_LARGE:
      begin
        Width:=PG_LWIDTH;
        Height:=PG_LHEIGHT;
      end;
    else //PG_ULTRALARGE:
      begin
        Width:=PG_ULWIDTH;
        Height:=PG_ULHEIGHT;
      end;
  end;

  SetLength(fPlayground,Width);
  for i := 0 to High(fPlayground) do
    SetLength(fPlayground[i],Height);

  for x := 0 to High(fPlayground) do
    for y := 0 to High(fPlayground[0]) do
    begin
      fPlayground[x,y].isObject:=false;
      fPlayground[x,y].Color:=fBackgroundColor;
      fPlayground[x,y].TemplateNum:=0;
      fPlayground[x,y].RePaint:=true;
    end;

  // für den Anfang:
  fThisObject.Color:=fBackgroundColor;

  RepaintPreview;
end;


//################## Endgame (public) ##########################################

procedure TGame.Endgame;
var
  i:Integer;
  jpg : TJPEGImage;

  procedure DeleteRow(y_max:Integer);
  var
    x,y:Integer;
  begin
    for y :=y_max downto 1 do
      for x := 0 to High(fPlayground) do
      begin
        fPlayground[x,y].isObject:=fPlayground[x,y-1].isObject;
        fPlayground[x,y].Color:=fPlayground[x,y-1].Color;
        fPlayground[x,y-1].Color:=BackgroundColor;             
        fPlayground[x,y].TemplateNum:=fPlayground[x,y-1].TemplateNum;
        fPlayground[x,y-1].TemplateNum:=0;           
        fPlayground[x,y-1].RePaint:=True;            
        fPlayground[x,y].RePaint:=True;
      end;
  end;

  function getTimeString:String;
  var
    s:String;
  begin
    s:=DateTimeToStr(Now);     
    Delete(s,pos('.',s),1);
    Delete(s,pos('.',s),1);
    Delete(s,pos(' ',s),1);
    Delete(s,pos(':',s),1);
    Delete(s,pos(':',s),1);
    result:=s;
  end;

begin
  fGameOver:=true;
  SndLoopEnd;
  SndGameOver;
  fThisObject.Color:=BackgroundColor;
  fNextObject.Color:=BackgroundColor; 
  fThisObject.TemplateNum:=0;
  fNextObject.TemplateNum:=0;
  GameTimer.Enabled:=false;
  PlayTime.Enabled:=false;
  if frmOptions.CbSaveEndScreen.Checked then
  begin
    jpg := TJPEGImage.Create;
    try
      with fImage.Canvas do
      begin
        Font.Name:='Comic Sans MS';
        TextOut(5,5,'Powered by delphi-lernen.de!');
        TextOut(5,25,'Datum:'+DateTimeToStr(Now));
        TextOut(5,45,'Level:'+IntToStr(fLevel));
        TextOut(5,65,'Punkte:'+IntToStr(HighScore.GetPreviousScore));
      end;
      jpg.Assign(fImage.Picture.Bitmap);
      jpg.SaveToFile(ExtractFilePath(Application.ExeName)+'GameOver'+getTimeString+'.jpg');
    finally
      jpg.Free;
    end;
  end;
  MainForm.SpBtnNewGame.Enabled:=true;
  MainForm.SpBtnOptionen.Caption:='Optionen';
  Mainform.SpBtnPause.Enabled:=false;
  for i := High(fPlayground[0]) downto 0 do
  begin
    DeleteRow(High(fPlayground[0]));
    Sleep(33);
    Game.Repaint;
    Application.ProcessMessages;
  end;
  if HighScore.GotHighscore(fImage, fGameSeconds, fRows, fSize, fLevel) then
    if not HighScore.SaveHighscore then
      Application.MessageBox('Fehler beim Speichern der HighScore!','Fehler!',MB_OK+MB_ICONERROR);
  HighScore.Init(fSize);// alles auf 0 setzen!
  fGameSeconds:=StrToTime('00:00:00');
  fRows:=0;  
  RepaintPreview;
end;


//################## TimerTimer (public) #######################################

procedure TGame.GameTimerTimer(Sender: TObject);
var
  i, y: Integer;

  function RowComplete(y:Integer):Boolean;    // ##################
  var
    x: Integer;
  begin
    result:=true;
    for x := 0 to High(fPlayground) do
      if (not fPlayground[x,y].isObject) then
        result:=false;
  end;

  procedure DeleteRow(y_max:Integer);        // ##################
  var
    x,y:Integer;
  begin
    for y :=y_max downto 1 do
      for x := 0 to High(fPlayground) do
      begin
        fPlayground[x,y].isObject:=fPlayground[x,y-1].isObject;
        fPlayground[x,y].Color:=fPlayground[x,y-1].Color;
        fPlayground[x,y-1].Color:=BackgroundColor;
        fPlayground[x,y].TemplateNum:=fPlayground[x,y-1].TemplateNum;
        fPlayground[x,y-1].TemplateNum:=0;
        fPlayground[x,y-1].RePaint:=true; 
        fPlayground[x,y].RePaint:=true;
      end;
  end;

  function isGameOver:Boolean;               // ##################
  var
    x, y:Integer;

    function ObjAtPos(x,y:Integer):Boolean;
    var
      i:Integer;
    begin
      result:=false;
      for i := 1 to 4 do
        if (fThisObject.Pos[i].X=X) and (fThisObject.Pos[i].Y=Y) then
          result:=true;        
    end;

  begin
    result:=false;
    with fThisObject do
      for x := PosZero.X to PosZero.X+4 do
        for y := PosZero.Y to PosZero.Y+4 do
          if fPlayground[x,y].isObject and ObjAtPos(x,y) then
            result:=true;      
  end;

  function RowInOneColor(y:Integer):Boolean; // TODO: (V1.1) sollte wegfallen oder? 
  var
    x:Integer;
    col:TColor;

    function isDblColor:Boolean;
    var
      a,b:Integer;
    begin
      result:=false;
      for a := 0 to 5 do
        for b := a+1 to 6 do
          if fColor[a]=fColor[b] then
            result:=true;
    end;

  begin
    result:=true;
    if not isDblColor then
    begin
      col:=fPlayground[0,y].Color;
      for x := 1 to High(fPlayground) do
        if fPlayground[x,y].Color<>col then
          result:=false;
    end
    else
      result:=false;
  end;

begin                              // #################### Timer begin
  if not isLocked then
  begin
    lock;
    if not MoveObject then
    begin
      HighScore.IncScore(fLevel);
      fThisObject.Kind:=fNextObject.Kind;
      fThisObject.Color:=fNextObject.Color;  
      fThisObject.TemplateNum:=fNextObject.TemplateNum; 
      fThisObject.PosZero.X:=fNextObject.PosZero.X;
      fThisObject.PosZero.Y:=fNextObject.PosZero.Y;
      for i := 1 to 4 do
      begin
        fThisObject.Pos[i].X:=fNextObject.Pos[i].X;
        fThisObject.Pos[i].Y:=fNextObject.Pos[i].Y;
      end;
      for y := 0 to High(fPlayground[0]) do
        if RowComplete(y) then
        begin
          HighScore.IncScoreRow(fSize);
          Inc(fRows);
          DeleteRow(y);
          Repaint;
          Application.ProcessMessages;
          sleep(15);
        end;
      UpdateHighscore;

      if isGameOver then
        EndGame
      else
      begin
        NewNextObject;
        Repaint;
      end;

    end
    else
    begin
      Repaint;
      if Sender = GameTimer then
        SndDown;
    end;
    unlock;
  end;
end;


//################## MoveDown (public) #########################################

procedure TGame.MoveDown;
begin
  if not isLocked then
  begin
    Lock;  
    GameTimer.Enabled:=false;
    while MoveObject do
    begin
      Sleep(8);
      Repaint;
      Application.ProcessMessages;
    end;                
    GameTimer.Enabled:=true;
    UnLock;
    GameTimerTimer(self);
  end;
end;


//################## MoveOneDown (public) ######################################

procedure TGame.MoveOneDown;
begin
  if not isLocked then
  begin
    Lock;
    if not MoveObject then
      GameTimerTimer(self);
    Repaint;
    UnLock;
  end;
end;


//#################### MoveLeft (public) #######################################

function TGame.MoveLeft:Boolean;
var
  i: Integer;
begin
  if not isLocked then
  begin
    Lock;
    result:=true;
    with fThisObject do
    begin
      for i := 1 to 4 do  // sind wir schon am "linken Rand"?
        if Pos[i].X=0 then
          result:=false;

      if result then
        for i := 1 to 4 do  // ist links nebenan ein anderes Objekt?
          if fPlayground[Pos[i].X-1][Pos[i].Y].isObject then
            result:=false;

      if result then
      begin
        for i := 1 to 4 do
          Dec(Pos[i].X);
        Dec(PosZero.X);
      end;
    end;
    Repaint;
    UnLock;
  end
  else
    result:=false;
end;


//#################### MoveRight (public) ######################################

function TGame.MoveRight:Boolean;
var
  i: Integer;
begin
  if not isLocked then
  begin
    Lock;
    result:=true;
    with fThisObject do
    begin
      for i := 1 to 4 do  // sind wir schon am "linken Rand"?
        if Pos[i].X=High(fPlayground) then
          result:=false;

      if result then
        for i := 1 to 4 do  // ist links nebenan ein anderes Objekt?
          if fPlayground[Pos[i].X+1][Pos[i].Y].isObject then
            result:=false;

      if result then
      begin
        for i := 1 to 4 do
          Inc(Pos[i].X);
        Inc(fThisObject.PosZero.X);
      end;
    end;
    Repaint;
    Unlock;
  end
  else
    result:=false;
end;


//##################### TurnLeft (public) ######################################

function TGame.TurnLeft:Boolean;   
var
  i, k, p            : Integer;
  ThisObjectCopy,
  ThisObjectCopyCopy : Array[1..4,1..4] of Boolean;
  thisObjectObjectCopy: RObject;


  function hasFreeLine:Boolean;
  var
    v:Integer;
  begin
    result:=true;
    for v := 1 to 4 do
      if ThisObjectCopyCopy[1][v] then
        result:=false;
  end;

  procedure killFirstLine;
  var
    v,w:Integer;
  begin
    for v := 1 to 3 do
      for w := 1 to 4 do
        ThisObjectCopyCopy[v][w]:=ThisObjectCopyCopy[v+1][w];
    for w := 1 to 4 do // Y
        ThisObjectCopyCopy[4][w]:=false; // untere Zeile ist leer
  end;

begin     
  if not isLocked then
  begin
    Lock;
    result:=true;
    // Init all 2-D-Array: everything false ;-)
    for i := 1 to 4 do
      for k := 1 to 4 do
      begin
        ThisObjectCopy[i][k]:=false;
      end;

    // Set Object as Bool-Copy
    // Das Objekt als Wahrheitskopie erstellen
    with fThisObject do
      for i := 1 to 4 do
      begin
        ThisObjectCopy[Pos[i].Y-PosZero.Y+1][Pos[i].X-PosZero.X+1]:=true;
      end;

    // LeftTurn ;-)
    // nach Links drehen ;-)
    for i := 1 to 4 do
      for k := 1 to 4 do
        ThisObjectCopyCopy[k][i]:=ThisObjectCopy[i][5-k];
    // ThisObjectCopyCopy enthält die Info, wie das Objekt positionoiert ist,
    // wenn es gedreht wurde.

    // wenn erste Zeile "leer" ist, dann löschen:
    if hasFreeLine then
      killFirstLine;
    if hasFreeLine then // kann bei Stab, Würfel und den Ls sein
      killFirstLine;
    if hasFreeLine then // kann nur beim Stab sein
      killFirstLine;

    // Read Info:
    // Info auslesen :-D
    p:=1;
    for i := 1 to 4 do
      for k := 1 to 4 do
        if ThisObjectCopyCopy[k,i] then
        begin
          thisObjectObjectCopy.Pos[p].X:=fThisObject.PosZero.X+i-1;
          thisObjectObjectCopy.Pos[p].Y:=fThisObject.PosZero.Y+k-1;
          Inc(p);
        end;

    with thisObjectObjectCopy do
      for i := 1 to 4 do  // ist es am Rand?
        if (Pos[i].X<0) OR
           (Pos[i].Y<0) OR
           (Pos[i].X>High(fPlayground)) OR
           (Pos[i].Y>High(fPlayground[0])) then
          result:=false;

    if Result then
      with thisObjectObjectCopy do
        for i := 1 to 4 do  // ist links nebenan ein anderes Objekt?
          if fPlayground[Pos[i].X][Pos[i].Y].isObject then
            result:=false;

    // Gedrehte Daten übertragen
    if Result then
      for i := 1 to 4 do
      begin
        fThisObject.Pos[i].X:=thisObjectObjectCopy.Pos[i].X;
        fThisObject.Pos[i].Y:=thisObjectObjectCopy.Pos[i].Y;
      end;
    Repaint;
    Unlock;
  end
  else
    result:=false;
end;


//#################### TurnRight (public) ######################################

function TGame.TurnRight:Boolean;
var
  i, k, p            : Integer;
  ThisObjectCopy,
  ThisObjectCopyCopy : Array[1..4,1..4] of Boolean;
  thisObjectObjectCopy: RObject;


  function hasFreeLine:Boolean;
  var
    v:Integer;
  begin
    result:=true;
    for v := 1 to 4 do
      if ThisObjectCopyCopy[v][1] then
        result:=false;
  end;

  procedure killFirstLine;
  var
    v,w:Integer;
  begin
    for v := 1 to 4 do
      for w := 1 to 3 do
        ThisObjectCopyCopy[v][w]:=ThisObjectCopyCopy[v][w+1];
    for v := 1 to 4 do
        ThisObjectCopyCopy[v][4]:=false; // rechte Zeile ist leer
  end;

begin
  if not isLocked then
  begin
    Lock;
    result:=true;
  
    // Init all 2-D-Array: everything false ;-)
    for i := 1 to 4 do
      for k := 1 to 4 do
      begin
        ThisObjectCopy[i][k]:=false;
      end;

    // Set Object as Bool-Copy
    // Das Objekt als Wahrheitskopie erstellen
    with fThisObject do
      for i := 1 to 4 do
      begin
        ThisObjectCopy[Pos[i].Y-PosZero.Y+1][Pos[i].X-PosZero.X+1]:=true;
      end;

    // RightTurn ;-)
    // nach Rechts drehen ;-)
    for i := 1 to 4 do
      for k := 1 to 4 do
        ThisObjectCopyCopy[k][i]:=ThisObjectCopy[5-i][k];
    // ThisObjectCopyCopy enthält die Info, wie das Objekt positionoiert ist,
    // wenn es gedreht wurde.

    // wenn erste Zeile "leer" ist, dann löschen:
    if hasFreeLine then
      killFirstLine;
    if hasFreeLine then // kann bei Stab, Würfel und den Ls sein
      killFirstLine;
    if hasFreeLine then // kann nur beim Stab sein
      killFirstLine;     

    // Read Info:
    // Info auslesen :-D
    p:=1;
    for i := 1 to 4 do
      for k := 1 to 4 do
        if ThisObjectCopyCopy[k,i] then
        begin
          thisObjectObjectCopy.Pos[p].X:=fThisObject.PosZero.X+i-1;
          thisObjectObjectCopy.Pos[p].Y:=fThisObject.PosZero.Y+k-1;
          Inc(p);
        end;

    with thisObjectObjectCopy do
      for i := 1 to 4 do
        if (Pos[i].X<0) OR
           (Pos[i].Y<0) OR
           (Pos[i].X>High(fPlayground)) OR
           (Pos[i].Y>High(fPlayground[0])) then
          result:=false;

    if Result then
      with thisObjectObjectCopy do
        for i := 1 to 4 do
          if fPlayground[Pos[i].X][Pos[i].Y].isObject then
            result:=false;

    // Gedrehte Daten Übertragen
    if Result then
      for i := 1 to 4 do
      begin
        fThisObject.Pos[i].X:=thisObjectObjectCopy.Pos[i].X;
        fThisObject.Pos[i].Y:=thisObjectObjectCopy.Pos[i].Y;
      end;
    Repaint;
    Unlock;
  end
  else
    result:=false;
end;


//################ isLocked (private) ##########################################

function TGame.isLocked:Boolean;
begin
  result:=fisLocked;
end;


//################ isLocked (private) ##########################################

procedure TGame.DataModuleCreate(Sender: TObject);
begin
  HighScore:=THighScore.Create;
end;

procedure TGame.DataModuleDestroy(Sender: TObject);
begin
  HighScore.Destroy;
end;

procedure TGame.Debug;
begin
  AddBottomRow;
end;

end.
