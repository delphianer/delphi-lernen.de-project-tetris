{
     Autor:       Delphi-AG Okengymnasiums 2007, weiterbearbeitet von Marco Hetzel

     File:        fSplashScreen.pas

     Source:      http://delphi-lernen.de

     Contact:     Tetris@delphi-lernen.de

     Copyright:   2007-2008 Delphi-AG und Marco Hetzel

}
unit fSplashScreen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons;

type
  TFrmSplashScreen = class(TForm)
    Timer: TTimer;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LblVersion: TLabel;
    Label6: TLabel;
    procedure TimerTimer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label6MouseEnter(Sender: TObject);
    procedure Label6MouseLeave(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FrmSplashScreen: TFrmSplashScreen;

implementation

uses MainUnit, fOptions, mGame, ShellAPI;

{$R *.dfm}
          



//######################## FormCreate ##########################################

procedure TFrmSplashScreen.FormCreate(Sender: TObject);
begin
  if ParamCount>0 then
    if ParamStr(1)='-config' then

  Randomize;
  TransparentColor:=true;
  TransparentColorValue:=clBlue;
  LblVersion.Caption:=APP_VERSIONSTR;
  LblVersion.Left:=clientwidth-LblVersion.Width-53
end;  


//######################## FormDblClick ########################################

procedure TFrmSplashScreen.FormDblClick(Sender: TObject);
begin
  ProgressBar1.Position:=ProgressBar1.Max;
end;


//######################## FormHide ############################################

procedure TFrmSplashScreen.FormHide(Sender: TObject);
var
  w, h:Integer;

  function invertcolor(color: TColor):TColor;
  begin
    Result := ColorToRGB(color) xor $00FFFFFF;
  end;

label SelectNew;
begin
  SelectNew:
  case FrmOptions.CbSize.ItemIndex+1 of
    PG_SMALL:
      begin
        w:=PG_SWIDTH*SIDELENGTH;
        h:=PG_SHEIGHT*SIDELENGTH;
        if Screen.Width<w then
          Application.MessageBox('Die Auflösung ist zu klein, um ordnungsgemäß dargestellt werden zu können!',
                                 'Fehler!',MB_OK+MB_ICONERROR);
      end;
    PG_MEDIUM:
      begin
        w:=PG_MWIDTH*SIDELENGTH;
        h:=PG_MHEIGHT*SIDELENGTH;
        if Screen.Width<w then
        begin
          FrmOptions.CbSize.ItemIndex:=FrmOptions.CbSize.ItemIndex-1;
          goto SelectNew;
        end;
      end;
    PG_LARGE:
      begin
        w:=PG_LWIDTH*SIDELENGTH;
        h:=PG_LHEIGHT*SIDELENGTH;
        if Screen.Width<w then
        begin
          FrmOptions.CbSize.ItemIndex:=FrmOptions.CbSize.ItemIndex-1;
          goto SelectNew;
        end;
      end;
    else // PG_ULTRALARGE:
      begin
        w:=PG_ULWIDTH*SIDELENGTH;
        h:=PG_ULHEIGHT*SIDELENGTH;
        if Screen.Width<w then
        begin
          FrmOptions.CbSize.ItemIndex:=FrmOptions.CbSize.ItemIndex-1;
          goto SelectNew;
        end;
      end;
  end;
  
  with MainForm do
  begin
    Game.Init(FrmOptions.CbSize.ItemIndex+1,
      ImgBildFlaeche, ImgPreview,
      FrmOptions.ColorBoxBgCol.Selected,FrmOptions.ColorBoxGrid.Selected);
    ImgBildFlaeche.Canvas.Brush.Color:=Game.BackgroundColor;
    MainForm.Color:=Game.BackgroundColor;
    Mainform.Font.Color := invertcolor(Game.BackgroundColor);
    ClientWidth:=w+PnlMenu.Width;
    ClientHeight:=h;
    ImgBildFlaeche.Canvas.Rectangle(-1,-1,
                                    ImgBildFlaeche.Width+1,ImgBildFlaeche.Height+1);
  end;
end;


//######################## FormPaint ###########################################

procedure TFrmSplashScreen.FormPaint(Sender: TObject);
const
  MAX_WIDTH = 10;
  SPACE_BETWEEN = 2;
  X_LEFT = 8;   
  Y_TOP = 8; 
  X_RIGHT = 517;   
  Y_BOTTOM = 232;
var
  i:Integer;
  cols:Array[0..7] of TColor;
  
  procedure PaintRectangle(fgcol:TColor;xy:Integer);
  begin               
    Canvas.Pen.Color:=fgcol;
    Canvas.Rectangle(xy,xy,ClientWidth-xy,ClientHeight-xy);
  end;

  procedure paintFigure(Col:TColor;Position:TPoint;size:Integer);
  var
    r,a,b:Integer;

    procedure PaintRectangle2(bgCol:TColor;Pos:TPoint;S:Integer);
    begin
      Canvas.Brush.Color:=bgCol;
      Canvas.Rectangle(Pos.X,Pos.Y,Pos.X+S,Pos.Y+S);
    end;

  begin
    a:=0;
    b:=0;
    PaintRectangle2(Col,position,size);

    r:=random(2);
    if r=0 then
      Inc(a)
    else
      Inc(b);
    PaintRectangle2(Col,Point(position.X+a*size,position.Y+b*size),size);
    
    r:=random(2);
    if r=0 then
      Inc(a)
    else
      Inc(b);
    PaintRectangle2(Col,Point(position.X+a*size,position.Y+b*size),size);
    
    r:=random(2);
    if r=0 then
      Inc(a)
    else
      Inc(b);
    PaintRectangle2(Col,Point(position.X+a*size,position.Y+b*size),size);

  end;

begin
  cols[0]:=clred;  cols[1]:=clGreen;  cols[2]:=clNavy;  cols[3]:=clSkyBlue;
  cols[4]:=clNavy;  cols[5]:=clYellow;  cols[6]:=clLime;  cols[7]:=clFuchsia;
  Canvas.Brush.Color:=clBlue;
  Canvas.Pen.Width:=1;
  PaintRectangle(clBlue,0);
  Canvas.Pen.Width:=3;
  //PaintRectangle(clNavy,2);
  Canvas.Pen.Width:=1;
  //PaintRectangle(clRed,4);
  //PaintRectangle(clNavy,5);
  Canvas.Pen.Color:=clBlue;
  for i := 0 to 11 do
    paintFigure(cols[random(8)],
                Point(i*(4*MAX_WIDTH+SPACE_BETWEEN)+X_LEFT,Y_TOP),
                MAX_WIDTH);
  for i := 1 to 4 do
    paintFigure(cols[random(8)],
                Point(X_LEFT,i*(4*MAX_WIDTH+SPACE_BETWEEN)+Y_TOP),
                MAX_WIDTH);   
  for i := 0 to 4 do
    paintFigure(cols[random(8)],
                Point(X_RIGHT,i*(4*MAX_WIDTH+SPACE_BETWEEN)+Y_TOP),
                MAX_WIDTH);   
  for i := 0 to 12 do
    paintFigure(cols[random(8)],
                Point(i*(4*MAX_WIDTH+SPACE_BETWEEN)+X_LEFT,Y_BOTTOM),
                MAX_WIDTH);
  Canvas.Brush.Color:=clWhite;
  PaintRectangle(clRed,50);
end;


//######################## Label3Click ##########################################

procedure TFrmSplashScreen.Label3Click(Sender: TObject);
begin
  ShellExecute(0,'OPEN','http://delphi-lernen.de/tetris','','',SW_SHOWNORMAL);
end;


procedure TFrmSplashScreen.Label4Click(Sender: TObject);
begin

end;

//######################## Label6MouseEnter ##########################################

procedure TFrmSplashScreen.Label6MouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Style:=[fsBold,fsUnderline]
end;


//######################## Label6MouseLeave ##########################################

procedure TFrmSplashScreen.Label6MouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style:=[]
end;


//######################## TimerTimer ##########################################

procedure TFrmSplashScreen.TimerTimer(Sender: TObject);
begin
  if ProgressBar1.Position<ProgressBar1.Max then
    ProgressBar1.Position:=ProgressBar1.Position+1
  else
  begin
    Timer.Enabled:=false;
    Hide;
    MainForm.Show;
  end;
end;

end.
