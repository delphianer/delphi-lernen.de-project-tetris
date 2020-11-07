object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Tetris'
  ClientHeight = 547
  ClientWidth = 479
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Comic Sans MS'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 15
  object ImgBildFlaeche: TImage
    Left = 129
    Top = 0
    Width = 350
    Height = 547
    Align = alClient
    ExplicitLeft = 122
  end
  object LblPause: TLabel
    Left = 264
    Top = 98
    Width = 103
    Height = 56
    Caption = 'Pause'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object PnlMenu: TPanel
    Left = 0
    Top = 0
    Width = 129
    Height = 547
    Align = alLeft
    ParentColor = True
    TabOrder = 0
    ExplicitLeft = -6
    object ImgPreview: TImage
      Left = 11
      Top = 136
      Width = 100
      Height = 175
    end
    object SpBtnNewGame: TSpeedButton
      Left = 11
      Top = 14
      Width = 105
      Height = 22
      Cursor = crHandPoint
      Caption = 'Neues Spiel'
      Flat = True
      OnClick = BtnNewGameClick
    end
    object SpBtnPause: TSpeedButton
      Left = 11
      Top = 42
      Width = 105
      Height = 22
      Cursor = crHandPoint
      Caption = 'Pause'
      Enabled = False
      Flat = True
      OnClick = BtnPauseClick
    end
    object SpBtnOptionen: TSpeedButton
      Left = 11
      Top = 70
      Width = 105
      Height = 22
      Cursor = crHandPoint
      Caption = 'Optionen'
      Flat = True
      OnClick = SpBtnOptionenClick
    end
    object SpBtnClose: TSpeedButton
      Left = 11
      Top = 98
      Width = 105
      Height = 22
      Cursor = crHandPoint
      Caption = 'Beenden'
      Flat = True
      OnClick = BtnCloseClick
    end
    object SpeedButton1: TSpeedButton
      Left = 44
      Top = 118
      Width = 79
      Height = 22
      Caption = '<<DEBUG>>'
      Visible = False
      OnClick = SpeedButton1Click
    end
  end
end
