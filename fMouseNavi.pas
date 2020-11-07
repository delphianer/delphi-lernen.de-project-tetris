unit fMouseNavi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls;

type
  TfrmMouseNavi = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    Timer1: TTimer;
    procedure SpeedButton1MouseEnter(Sender: TObject);
    procedure SpeedButton1MouseLeave(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private-Deklarationen }
    BtnIsSet: Boolean;
    Btn:TSpeedButton;
    OldPos, NewPos:TPoint;
    MoveMode: Boolean;
  public
    { Public-Deklarationen }
  end;

var
  frmMouseNavi: TfrmMouseNavi;

implementation

uses Types, mGame, MainUnit;

{$R *.dfm}

procedure TfrmMouseNavi.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  GetCursorPos(OldPos);
  MoveMode:=true;
end;

procedure TfrmMouseNavi.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if MoveMode then
  begin
    GetCursorPos(NewPos);
    Left:=Left+NewPos.X-OldPos.X;
    Top:=Top+NewPos.Y-OldPos.Y;
    OldPos.X:=NewPos.X;
    OldPos.Y:=NewPos.Y;
  end;
end;

procedure TfrmMouseNavi.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MoveMode:=false;
end;

procedure TfrmMouseNavi.SpeedButton1Click(Sender: TObject);
begin
  if not Game.isPause then
    if not Game.isLocked then
      Game.MoveLeft;
end;

procedure TfrmMouseNavi.SpeedButton1MouseEnter(Sender: TObject);
begin
  Btn:=TSpeedButton(Sender);
  BtnIsSet:=true;
end;

procedure TfrmMouseNavi.SpeedButton1MouseLeave(Sender: TObject);
begin
  TSpeedButton(Sender).Flat:=true;
  BtnIsSet:=false;
end;

procedure TfrmMouseNavi.SpeedButton2Click(Sender: TObject);
begin
  if not Game.isPause then
    if not Game.isLocked then
      Game.MoveRight;
end;

procedure TfrmMouseNavi.SpeedButton3Click(Sender: TObject);
begin
  if not Game.isPause then
    if not Game.isLocked then
      Game.TurnLeft;
end;

procedure TfrmMouseNavi.SpeedButton4Click(Sender: TObject);
begin
  if not Game.isPause then
    if not Game.isLocked then
      Game.TurnRight;
end;

procedure TfrmMouseNavi.SpeedButton5Click(Sender: TObject);
begin
  MainForm.SpBtnPause.Click;
end;

procedure TfrmMouseNavi.SpeedButton6Click(Sender: TObject);
begin
  if not Game.isPause then
    if not Game.isLocked then
      Game.MoveOneDown;
end;

procedure TfrmMouseNavi.SpeedButton7Click(Sender: TObject);
begin
  if not Game.isPause then
    if not Game.isLocked then
      Game.MoveDown;
end;

procedure TfrmMouseNavi.Timer1Timer(Sender: TObject);
begin
  if BtnIsSet then
    Btn.Flat:=not Btn.Flat;
end;

end.
