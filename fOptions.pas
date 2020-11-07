{
     Autor:       Delphi-AG Okengymnasiums 2007, weiterbearbeitet von Marco Hetzel

     File:        fOptions.pas

     Source:      http://delphi-lernen.de

     Contact:     Tetris@delphi-lernen.de

     Copyright:   2007-2008 Delphi-AG und Marco Hetzel

}
unit fOptions;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  jpeg, Windows,
{$ELSE}
  LCLIntf, LCLType, LMessages,
{$ENDIF}
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons, {MPlayer,} ImgList;

type
  TKeyCodeType = Array[0..74] of Word;

  TFrmOptions = class(TForm)
    BtnSave: TButton;
    BtnCancel: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    CbSize: TComboBox;
    TabSheet3: TTabSheet;
    Button2: TButton;
    Button3: TButton;
    Panel1: TPanel;
    TabSheet4: TTabSheet;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    TabSheet5: TTabSheet;
    CmBMoveLeft: TComboBox;
    Label18: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    CmbMoveRight: TComboBox;
    CmbTurnLeft: TComboBox;
    CmbTurnRight: TComboBox;
    CmbMoveOneDown: TComboBox;
    CmbMoveDown: TComboBox;
    CmbPause: TComboBox;
    lblLevel: TLabel;
    UdLevelSelected: TUpDown;
    Label8: TLabel;
    Label27: TLabel;
    Label21: TLabel;
    Label2: TLabel;
    lblVersion: TLabel;
    lblURL: TLabel;
    CbSaveEndScreen: TCheckBox;
    TabSheet6: TTabSheet;
    Button1: TButton;
    OpenSound: TOpenDialog;
    Label3: TLabel;
    EdSoundDown: TEdit;
    BitBtnPlayDown: TBitBtn;
    Label4: TLabel;
    EdSoundDrop: TEdit;
    BitBtnPlayDrop: TBitBtn;
    Label6: TLabel;
    EdSoundMove: TEdit;
    BitBtnPlayMove: TBitBtn;
    Label11: TLabel;
    EdSoundTurn: TEdit;
    BitBtnPlayTurn: TBitBtn;
    Label28: TLabel;
    EdSoundGameOver: TEdit;
    BitBtnPlayOver: TBitBtn;
    Label29: TLabel;
    EdSoundLoop: TEdit;
    BitBtnPlayLoop: TBitBtn;
    BitBtnNoDown: TBitBtn;
    BitBtnOpenDown: TBitBtn;
    BitBtnNoDrop: TBitBtn;
    BitBtnOpenDrop: TBitBtn;
    BitBtnNoMove: TBitBtn;
    BitBtnOpenMove: TBitBtn;
    BitBtnNoTurn: TBitBtn;
    BitBtnOpenTurn: TBitBtn;
    BitBtnNoOver: TBitBtn;
    BitBtnOpenOver: TBitBtn;
    BitBtnNoLoop: TBitBtn;
    BitBtnOpenLoop: TBitBtn;
    // todo: MediaPlayer Ersatz finden
    //MediaPlayer: TMediaPlayer;
    Label5: TLabel;
    EdSoundError: TEdit;
    BitBtnPlayError: TBitBtn;
    BitBtnNoError: TBitBtn;
    BitBtnOpenError: TBitBtn;
    TabSheet2: TTabSheet;
    PageControl2: TPageControl;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    Label10: TLabel;
    // todo: Ersatz finden
    //ColorBoxGrid: TColorBox;
    //ColorBoxBgCol: TColorBox;
    Label9: TLabel;
    // todo: Ersatz finden
    //GroupBox1: TGroupBox;
    //ColorBox1: TColorBox;
    //ColorBox2: TColorBox;
    //ColorBox3: TColorBox;
    //ColorBox4: TColorBox;
    //ColorBox5: TColorBox;
    //ColorBox6: TColorBox;
    //ColorBox7: TColorBox;
    Button4: TButton;
    RbOldStyle: TRadioButton;
    RadioButton2: TRadioButton;
    Label7: TLabel;
    Label30: TLabel;
    CbSelectTemplate: TComboBox;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    ImgPreview: TImage;
    lblAutorName: TLabel;
    lblDate: TLabel;
    BtnStartUpdate: TButton;
    CkbNoSounds: TCheckBox;
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ColorBoxBgColChange(Sender: TObject);
    procedure UdLevelSelectedClick(Sender: TObject; Button: TUDBtnType);
    procedure lblURLMouseLeave(Sender: TObject);
    procedure lblURLMouseEnter(Sender: TObject);
    procedure lblURLClick(Sender: TObject);
    procedure BitBtnOpenDownClick(Sender: TObject);
    procedure BitBtnNoDownClick(Sender: TObject);
    procedure BitBtnPlayDownClick(Sender: TObject);
    procedure BitBtnOpenDropClick(Sender: TObject);
    procedure BitBtnNoDropClick(Sender: TObject);
    procedure BitBtnPlayDropClick(Sender: TObject);
    procedure BitBtnOpenMoveClick(Sender: TObject);
    procedure BitBtnNoMoveClick(Sender: TObject);
    procedure BitBtnPlayMoveClick(Sender: TObject);
    procedure BitBtnOpenTurnClick(Sender: TObject);
    procedure BitBtnNoTurnClick(Sender: TObject);
    procedure BitBtnPlayTurnClick(Sender: TObject);
    procedure BitBtnOpenOverClick(Sender: TObject);
    procedure BitBtnNoOverClick(Sender: TObject);
    procedure BitBtnPlayOverClick(Sender: TObject);
    procedure BitBtnOpenLoopClick(Sender: TObject);
    procedure BitBtnNoLoopClick(Sender: TObject);
    procedure BitBtnPlayLoopClick(Sender: TObject);
    procedure BitBtnOpenErrorClick(Sender: TObject);
    procedure BitBtnNoErrorClick(Sender: TObject);
    procedure BitBtnPlayErrorClick(Sender: TObject);
    procedure CbSelectTemplateChange(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure BtnStartUpdateClick(Sender: TObject);
    procedure CkbNoSoundsClick(Sender: TObject);
  private
    { Private-Deklarationen }
    fKeyCodes        : TKeyCodeType;
    fKeyNames        : Array[0..74] of String;
    fInvalidTemplate : Boolean;

    Procedure UseThisSettings;
    procedure SaveIni;
    Procedure LoadIni;
  public


    procedure InitKeyArrays;
    Function MoveLeft:Word;
    Function MoveRight:Word;
    Function TurnLeft:Word;
    Function TurnRight:Word;
    Function OneDown:Word;
    Function Down:Word;
    Function Pause:Word;

    { Public-Deklarationen }
  end;

var
  FrmOptions: TFrmOptions;

implementation

uses
{$IFnDEF FPC}
  ShellAPI,
{$ELSE}
{$ENDIF}
  mGame, MainUnit, fSplashScreen, IniFiles, uHighscore,
  mmsystem, uPlaySound, UrlMon;

{$R *.dfm}




//######################## InitKeyArrays #######################################

procedure TFrmOptions.InitKeyArrays;
var
  i:Integer;  
begin
  fKeyCodes[0]:=8;
  fKeyNames[0]:='Rücktaste';
  fKeyCodes[1]:=13;
  fKeyNames[1]:='Enter';
  fKeyCodes[2]:=16;
  fKeyNames[2]:='Umschalt';
  fKeyCodes[3]:=17;
  fKeyNames[3]:='Strg';
  fKeyCodes[4]:=18;
  fKeyNames[4]:='Alt';
  fKeyCodes[5]:=20;
  fKeyNames[5]:='Feststelltaste';
  fKeyCodes[6]:=27;
  fKeyNames[6]:='Esc';
  fKeyCodes[7]:=32;
  fKeyNames[7]:='Leertaste';
  fKeyCodes[8]:=33;
  fKeyNames[8]:='Bild Hoch';
  fKeyCodes[9]:=34;
  fKeyNames[9]:='Bild Runter';
  fKeyCodes[10]:=35;
  fKeyNames[10]:='Ende';
  fKeyCodes[11]:=36;
  fKeyNames[11]:='Pos 1';
  fKeyCodes[12]:=37;
  fKeyNames[12]:='Pfeil Links';
  fKeyCodes[13]:=38;
  fKeyNames[13]:='Pfeil Hoch';
  fKeyCodes[14]:=39;
  fKeyNames[14]:='Pfeil Rechts';
  fKeyCodes[15]:=40;
  fKeyNames[15]:='Pfeil Runter';
  fKeyCodes[16]:=45;
  fKeyNames[16]:='Einfg';
  fKeyCodes[17]:=46;
  fKeyNames[17]:='Entf';
  for i := 1 to 10 do
  begin
    fKeyCodes[17+i]:=47+i;
    fKeyNames[17+i]:=Chr(47+i);
  end;
  for i := 1 to 26 do
  begin
    fKeyCodes[28+i]:=64+i;
    fKeyNames[28+i]:=chr(64+i);
  end;
  for i := 1 to 12 do
  begin
    fKeyCodes[53+i]:=111+i;
    fKeyNames[53+i]:='F'+IntToStr(i);
  end;
  fKeyCodes[66]:=186;
  fKeyNames[66]:='Ü';
  fKeyCodes[67]:=187;
  fKeyNames[67]:='+';
  fKeyCodes[68]:=188;
  fKeyNames[68]:='Komma';
  fKeyCodes[69]:=189;
  fKeyNames[69]:='Minus';
  fKeyCodes[70]:=190;
  fKeyNames[70]:='Punkt';
  fKeyCodes[71]:=191;
  fKeyNames[71]:='#';
  fKeyCodes[72]:=192;
  fKeyNames[72]:='Ö';
  fKeyCodes[73]:=220;
  fKeyNames[73]:='Circumflex';
  fKeyCodes[74]:=222;
  fKeyNames[74]:='Ä';

  CmBMoveLeft.Clear;
  for i := 0 to High(fKeyNames) do
    CmBMoveLeft.Items.Add(fKeyNames[i]);
  CmbMoveRight.Items:=CmBMoveLeft.Items;
  CmbTurnLeft.Items:=CmBMoveLeft.Items;
  CmbTurnRight.Items:=CmBMoveLeft.Items;
  CmbMoveOneDown.Items:=CmBMoveLeft.Items;
  CmbMoveDown.Items:=CmBMoveLeft.Items;
  CmbPause.Items:=CmBMoveLeft.Items;
end;


procedure TFrmOptions.lblURLClick(Sender: TObject);
begin
  OpenURL('http://delphi-lernen.de/tetris'); { *Konvertiert von ShellExecute* }
end;

procedure TFrmOptions.lblURLMouseEnter(Sender: TObject);
begin
  lblURL.Font.Style:=[fsBold,fsUnderline];
end;

procedure TFrmOptions.lblURLMouseLeave(Sender: TObject);
begin
  lblURL.Font.Style:=[fsBold];
end;

//######################## UdLevelSelectedClick ################################

procedure TFrmOptions.UdLevelSelectedClick(Sender: TObject; Button: TUDBtnType);
begin
  LblLevel.Caption:= 'Level: '+IntToStr(UdLevelSelected.Position);
end;

                                                                                
//######################## UseThisSettings #####################################

Procedure TFrmOptions.UseThisSettings;
var
  Colors:TColorArray;
  i: Integer;
begin
  Colors[0] := clRed;
  Colors[1] := clGreen;
  Colors[2] := clBlue;
  Colors[3] := clLime;
  Colors[4] := clYellow;
  Colors[5] := clNavy;
  Colors[6] := clPurple;
  Game.Colors:=Colors;
  Game.BackgroundColor:=clWhite; //ColorBoxBgCol.Selected;
  Game.GridColor:=clSilver; //ColorBoxGrid.Selected;
end;


//######################## SaveIni #############################################

procedure TFrmOptions.SaveIni;                  // TODO: Template Laden/Speichern
var                                             // TODO: Template: default gridcolor
  IniFile: TIniFile;
  i: Integer;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0))+'settings.ini');
  try
    with IniFile do
    begin
      WriteInteger('MAIN','Size',CbSize.ItemIndex);          
      WriteInteger('MAIN','Level',UdLevelSelected.Position); 
      WriteBool('MAIN','SaveEndScreen',CbSaveEndScreen.Checked);

      // todo: Ersatz finden
      WriteInteger('MAIN','BgColor',clWhite); // ColorBoxBgCol.Selected);
      WriteInteger('MAIN','GridColor',clSilver); // ColorBoxGrid.Selected);
      
      if CmBMoveLeft.Text='' then     // "Installation"
      begin
        WriteInteger('MAIN','MoveLeft',12);
        WriteInteger('MAIN','MoveRight',14);
        WriteInteger('MAIN','TurnLeft',13);
        WriteInteger('MAIN','TurnRight',15);
        WriteInteger('MAIN','MoveOneDown',7);
        WriteInteger('MAIN','MoveDown',1);
        WriteInteger('MAIN','Pause',44);
        if DirectoryExists(ExtractFilePath(ParamStr(0))+'sounds') then
        begin
          WriteString('SOUNDS','Down',ExtractFilePath(ParamStr(0))+EdSoundDown.Text);
          WriteString('SOUNDS','Drop',ExtractFilePath(ParamStr(0))+EdSoundDrop.Text);
          WriteString('SOUNDS','Move',ExtractFilePath(ParamStr(0))+EdSoundMove.Text);
          WriteString('SOUNDS','Turn',ExtractFilePath(ParamStr(0))+EdSoundTurn.Text);
          WriteString('SOUNDS','GameOver',ExtractFilePath(ParamStr(0))+EdSoundGameOver.Text);
          WriteString('SOUNDS','Loop',ExtractFilePath(ParamStr(0))+EdSoundLoop.Text);
          WriteString('SOUNDS','Error',ExtractFilePath(ParamStr(0))+EdSoundError.Text);
        end;
      end
      else
      begin
        WriteInteger('MAIN','MoveLeft',CmBMoveLeft.ItemIndex);
        WriteInteger('MAIN','MoveRight',CmbMoveRight.ItemIndex);
        WriteInteger('MAIN','TurnLeft',CmbTurnLeft.ItemIndex);
        WriteInteger('MAIN','TurnRight',CmbTurnRight.ItemIndex);
        WriteInteger('MAIN','MoveOneDown',CmbMoveOneDown.ItemIndex);
        WriteInteger('MAIN','MoveDown',CmbMoveDown.ItemIndex);
        WriteInteger('MAIN','Pause',CmbPause.ItemIndex);
        
        WriteString('SOUNDS','Down',Sounds.Down);
        WriteString('SOUNDS','Drop',Sounds.Drop);
        WriteString('SOUNDS','Move',Sounds.Move);
        WriteString('SOUNDS','Turn',Sounds.Turn);
        WriteString('SOUNDS','GameOver',Sounds.GameOver);
        WriteString('SOUNDS','Loop',Sounds.Loop);
        WriteString('SOUNDS','Error',Sounds.Error);
      end;

      WriteString('MAIN','VInfo',APP_VERSIONSTR);

      // todo: Ersatz finden
      {
      for i := 0 to 6 do
        with TColorBox(FindComponent('ColorBox'+IntToStr(i+1))) do
          WriteInteger('MAIN','Color'+IntToStr(i),Selected);
          }
    end;
  finally
    FreeAndNil(IniFile);
  end;
end; 


//######################## BtnCancelClick ######################################

Procedure TFrmOptions.LoadIni;
var
  IniFile: TIniFile;
  i: Integer;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0))+'settings.ini');
  try
    CbSize.ItemIndex:=IniFile.ReadInteger('MAIN','Size',1);                 
    UdLevelSelected.Position:=IniFile.ReadInteger('MAIN','Level',0);
    CbSaveEndScreen.Checked:=IniFile.ReadBool('MAIN','SaveEndScreen',false);

    // todo: Ersatz finden
    //ColorBoxBgCol.Selected:=IniFile.ReadInteger('MAIN','BgColor',clWhite);
    //ColorBoxGrid.Selected:=IniFile.ReadInteger('MAIN','GridColor',clSilver);

    CmBMoveLeft.ItemIndex:=IniFile.ReadInteger('MAIN','MoveLeft',12);
    CmbMoveRight.ItemIndex:=IniFile.ReadInteger('MAIN','MoveRight',14);
    CmbTurnLeft.ItemIndex:=IniFile.ReadInteger('MAIN','TurnLeft',13);
    CmbTurnRight.ItemIndex:=IniFile.ReadInteger('MAIN','TurnRight',15);
    CmbMoveOneDown.ItemIndex:=IniFile.ReadInteger('MAIN','MoveOneDown',7);
    CmbMoveDown.ItemIndex:=IniFile.ReadInteger('MAIN','MoveDown',1);
    CmbPause.ItemIndex:=IniFile.ReadInteger('MAIN','Pause',44);

    Sounds.Down:=IniFile.ReadString('SOUNDS','Down','');
    EdSoundDown.Text:=ExtractFileName(Sounds.Down);
    Sounds.Drop:=IniFile.ReadString('SOUNDS','Drop','');
    EdSoundDrop.Text:=ExtractFileName(Sounds.Drop);
    Sounds.Move:=IniFile.ReadString('SOUNDS','Move','');
    EdSoundMove.Text:=ExtractFileName(Sounds.Move);
    Sounds.Turn:=IniFile.ReadString('SOUNDS','Turn','');
    EdSoundTurn.Text:=ExtractFileName(Sounds.Turn);
    Sounds.GameOver:=IniFile.ReadString('SOUNDS','GameOver','');
    EdSoundGameOver.Text:=ExtractFileName(Sounds.GameOver);
    Sounds.Loop:=IniFile.ReadString('SOUNDS','Loop','');
    EdSoundLoop.Text:=ExtractFileName(Sounds.Loop);
    Sounds.Error:=IniFile.ReadString('SOUNDS','Error','');
    EdSoundError.Text:=ExtractFileName(Sounds.Error);

    LblLevel.Caption:= 'Level: '+IntToStr(UdLevelSelected.Position);

    // todo: Ersatz finden
    {
    for i := 0 to 6 do
      with TColorBox(FindComponent('ColorBox'+IntToStr(i+1))) do
        Selected:=IniFile.ReadInteger('MAIN','Color'+IntToStr(i),Selected);
        }
  finally
    FreeAndNil(IniFile);
  end;
end;


//######################## BtnCancelClick ######################################

procedure TFrmOptions.BitBtnNoDownClick(Sender: TObject);
begin
  Sounds.Down:='';
  EdSoundDown.Text:='';
end;

procedure TFrmOptions.BitBtnNoDropClick(Sender: TObject);
begin
  Sounds.Drop:='';
  EdSoundDrop.Text:='';
end;

procedure TFrmOptions.BitBtnNoErrorClick(Sender: TObject);
begin
  Sounds.Error:='';
  EdSoundError.Text:='';
end;

procedure TFrmOptions.BitBtnNoMoveClick(Sender: TObject);
begin
  Sounds.Move:='';
  EdSoundMove.Text:='';
end;

procedure TFrmOptions.BitBtnNoLoopClick(Sender: TObject);
begin
  Sounds.Loop:='';
  EdSoundLoop.Text:='';
end;

procedure TFrmOptions.BitBtnNoOverClick(Sender: TObject);
begin
  Sounds.GameOver:='';
  EdSoundGameOver.Text:='';
end;

procedure TFrmOptions.BitBtnNoTurnClick(Sender: TObject);
begin
  Sounds.Turn:='';
  EdSoundTurn.Text:='';
end;

procedure TFrmOptions.BitBtnOpenDownClick(Sender: TObject);
begin
  if OpenSound.Execute then
    if FileExists(OpenSound.FileName) then
    begin
      Sounds.Down:=OpenSound.FileName;
      EdSoundDown.Text:=ExtractFileName(OpenSound.FileName);
    end
    else
      Application.MessageBox('Konnte Datei nicht finden!',
                             'Fehler!',MB_OK+MB_ICONERROR);
end;

procedure TFrmOptions.BitBtnOpenDropClick(Sender: TObject);
begin
  if OpenSound.Execute then
    if FileExists(OpenSound.FileName) then
    begin
      Sounds.Drop:=OpenSound.FileName;
      EdSoundDrop.Text:=ExtractFileName(OpenSound.FileName);
    end
    else
      Application.MessageBox('Konnte Datei nicht finden!',
                             'Fehler!',MB_OK+MB_ICONERROR);
end;

procedure TFrmOptions.BitBtnOpenErrorClick(Sender: TObject);
begin
  if OpenSound.Execute then
    if FileExists(OpenSound.FileName) then
    begin
      Sounds.Error:=OpenSound.FileName;
      EdSoundError.Text:=ExtractFileName(OpenSound.FileName);
    end
    else
      Application.MessageBox('Konnte Datei nicht finden!',
                             'Fehler!',MB_OK+MB_ICONERROR);
end;

procedure TFrmOptions.BitBtnOpenMoveClick(Sender: TObject);
begin
  if OpenSound.Execute then
    if FileExists(OpenSound.FileName) then
    begin
      Sounds.Move:=OpenSound.FileName;
      EdSoundMove.Text:=ExtractFileName(OpenSound.FileName);
    end
    else
      Application.MessageBox('Konnte Datei nicht finden!',
                             'Fehler!',MB_OK+MB_ICONERROR);
end;

procedure TFrmOptions.BitBtnOpenLoopClick(Sender: TObject);
begin
  if OpenSound.Execute then
    if FileExists(OpenSound.FileName) then
    begin
      Sounds.Loop:=OpenSound.FileName;
      EdSoundLoop.Text:=ExtractFileName(OpenSound.FileName);
    end
    else
      Application.MessageBox('Konnte Datei nicht finden!',
                             'Fehler!',MB_OK+MB_ICONERROR);
end;

procedure TFrmOptions.BitBtnOpenOverClick(Sender: TObject);
begin
  if OpenSound.Execute then
    if FileExists(OpenSound.FileName) then
    begin
      Sounds.GameOver:=OpenSound.FileName;
      EdSoundGameOver.Text:=ExtractFileName(OpenSound.FileName);
    end
    else
      Application.MessageBox('Konnte Datei nicht finden!',
                             'Fehler!',MB_OK+MB_ICONERROR);
end;

procedure TFrmOptions.BitBtnOpenTurnClick(Sender: TObject);
begin
  if OpenSound.Execute then
    if FileExists(OpenSound.FileName) then
    begin
      Sounds.Turn:=OpenSound.FileName;
      EdSoundTurn.Text:=ExtractFileName(OpenSound.FileName);
    end
    else
      Application.MessageBox('Konnte Datei nicht finden!',
                             'Fehler!',MB_OK+MB_ICONERROR);
end;

procedure TFrmOptions.BitBtnPlayDownClick(Sender: TObject);
begin
  SndDown;
end;

procedure TFrmOptions.BitBtnPlayDropClick(Sender: TObject);
begin
  SndDrop;
end;

procedure TFrmOptions.BitBtnPlayErrorClick(Sender: TObject);
begin
  SndError;
end;

procedure TFrmOptions.BitBtnPlayMoveClick(Sender: TObject);
begin
  SndMove;
end;

procedure TFrmOptions.BitBtnPlayLoopClick(Sender: TObject);
begin
  if FileExists(Sounds.Loop) then
    sndPlaySound(PChar(Sounds.Loop),SND_ASYNC);
end;

procedure TFrmOptions.BitBtnPlayOverClick(Sender: TObject);
begin
  SndGameOver;
end;

procedure TFrmOptions.BitBtnPlayTurnClick(Sender: TObject);
begin
  SndTurn;
end;

procedure TFrmOptions.BtnCancelClick(Sender: TObject);
var
  IniFile: TIniFile;
begin
 // if not FileExists(ExtractFilePath(ParamStr(0))+'settings.ini') then
 //   BtnSave.Click;

  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0))+'settings.ini');
  try
    if IniFile.ReadString('MAIN','VInfo','')<>APP_VERSIONSTR then
    begin
      SaveIni; // Defaultwerte speichern
      LoadIni; // Neu Laden
    end
    else
      LoadIni;
  finally
    FreeAndNil(IniFile);
  end;

  UseThisSettings;

  if not FrmSplashScreen.Timer.Enabled then
    Mainform.Show;
  Hide;
end;


//######################## BtnSaveClick ########################################

procedure TFrmOptions.BtnSaveClick(Sender: TObject);
begin
  SaveIni;

  UseThisSettings;

  FrmSplashScreen.FormHide(Sender);
  Game.Repaint;
      
  if not FrmSplashScreen.Timer.Enabled then
  begin
    Mainform.Show;
    // MainForm zentrieren:
    //MainForm.Left:=(MainForm.Width+Screen.Width) DIV 2;
    //MainForm.Top:=(MainForm.Height+Screen.Height) DIV 2;
  end;
  Hide;
end;


//######################## Button1Click ########################################

procedure TFrmOptions.BtnStartUpdateClick(Sender: TObject);
var
  res              : HRESULT;
  FileName         : String;                                  // TODO: UPDATE!!
  ini              : TIniFile;
  VersionNumOnline : Integer;
  Descr: TStringList;
  s: String;
  i: Integer;
  NO_ERROR : HResult;
begin
  FileName := ExtractFilePath(ParamStr(0))+'update.tmp';
  res := URLDownloadToFile(nil,'http://delphi-lernen.de/downloads/update/tetris.ini',PChar(FileName),0,nil);
  NO_ERROR := 0;
  if res = NO_ERROR then
  begin
    ini := TIniFile.Create(FileName);

    VersionNumOnline := Ini.ReadInteger('MAIN','VersionNum',0);

    if APP_VERSIONNUM < VersionNumOnline then
    begin
      Descr := TStringList.Create;

      ini.ReadSection('Description',Descr);
      s:='Eine neue Version ist verfügbar!'+#13+#13+'Beschreibung:'+#13;
      s:=s + #13 + 'Version:' + Ini.ReadString('Main','VersionStr','');
      for i := 0 to Descr.Count - 1 do
        s:=s + #13 + Ini.ReadString('Description',Descr.Strings[i],'');
      s:=s +#13+#13+ 'Wollen Sie zur ''Tetris!''-Website?'+#13;

      if Application.MessageBox(PChar(s),'Versionsinformation',
                       MB_YESNO + MB_ICONINFORMATION)= ID_YES then
        OpenURL('http://delphi-lernen.de/tetris'); { *Konvertiert von ShellExecute* }

      Descr.Free;
    end;    

    ini.Free;
  end
  else
    Application.MessageBox('Momentan kann nicht auf Update überprüft werden!','Fehler!',MB_OK+MB_ICONERROR);   
end;


//######################## Button1Click ########################################

procedure TFrmOptions.Button1Click(Sender: TObject);
begin
  HighScore.Show(Mainform.ImgBildFlaeche);
  BtnCancel.Click;
end;


//######################## Button2Click ########################################

procedure TFrmOptions.Button2Click(Sender: TObject);
begin
   OpenDocument(PChar(Application.exename)); { *Konvertiert von ShellExecute* }
  FrmSplashScreen.Close;
end;


//######################## Button3Click ########################################

procedure TFrmOptions.Button3Click(Sender: TObject);
var
i:integer;
begin
  MessageBox(0,'Denken Sie sich eine Zahl aus ...','1. Schritt',MB_OK);
  MessageBox(0,'... nochmal soviel dazu ...','2. Schritt',MB_OK);
  i:=2*Round(Random(50))+50;
  MessageBox(0,PChar('... jetzt '+IntToStr(i)+' dazu ...'),'3. Schritt',MB_OK);
  MessageBox(0,'... das Ergebnis halbieren ...','4. Schritt',MB_OK);
  MessageBox(0,'... die gedachte Zahl abziehen ...','letzter Schritt',MB_OK);
  MessageBox(0,PChar('Das Ergebnis ist '+IntToStr(i div 2)+' !!!'),'3. Schritt',
    MB_OK);
end;


//######################## ColorBoxBgColChange #################################

procedure TFrmOptions.CbSelectTemplateChange(Sender: TObject);
var
  TemplateIni : TIniFile;
  path : String;
  imgName : String;
  ImgNum  : Integer;
  jpg     : TJPEGImage;
  i    : Integer;
  bitmap : TBitmap;
begin
  path:=ExtractFilePath(ParamStr(0))+'templates\'+CbSelectTemplate.Text+'\';

  if not FileExists(path+CbSelectTemplate.Text+'.ini') then
    fInvalidTemplate:=true
  else
    fInvalidTemplate:=false;
                 
  if not fInvalidTemplate then
    try
      TemplateIni := TIniFile.Create(path+CbSelectTemplate.Text+'.ini');
      try
        with TemplateIni do
        begin
          lblAutorName.Caption := ReadString('MAIN','AutorName','No Information found!');
          lblDate.Caption := ReadString('MAIN','Date','No Information found!');
          ImgName := ReadString('MAIN','ImgName','');
          ImgNum := ReadInteger('MAIN','ImgNum',1);
          if (ImgName = '') or (ImgNum = 0) then
            fInvalidTemplate := true
          else
          begin
            i:=0;
            Game.TemplateItems.Clear;
            while FileExists(Path+ImgName+IntToStr(i)+'.jpg') do
            begin
              jpg := TJPEGImage.Create;
              try
                jpg.LoadFromFile(path+ImgName+IntToStr(i)+'.jpg');
                bitmap := TBitmap.Create;
                try
                  bitmap.Assign(jpg);
                  Game.TemplateItems.Add(bitmap,nil);
                finally
                  bitmap.Free;
                end;
              finally
                jpg.Free;
              end;
              Inc(i);
            end;
            Game.TemplateItems.Draw(ImgPreview.Canvas,0,0,0);
            if ImgNum < Game.TemplateItems.Count then
               Game.TemplateItems.Draw(ImgPreview.Canvas,30,0,ImgNum)
            else
              fInvalidTemplate:=true;
            ImgPreview.Refresh;
          end;
        end;
      finally
        TemplateIni.Free;
      end;
    except
      Application.MessageBox('Template inkompatibel!','Fehler',MB_OK+MB_ICONERROR);
    end
  else
    Application.MessageBox('Template inkompatibel!','Fehler',MB_OK+MB_ICONERROR);
end;


//######################## CkbNoSoundsClick ####################################

procedure TFrmOptions.CkbNoSoundsClick(Sender: TObject);
begin
  noSounds:=CkbNoSounds.Checked;
end;


//######################## ColorBoxBgColChange #################################

procedure TFrmOptions.ColorBoxBgColChange(Sender: TObject);
var
  i:Integer;
begin
  // todo: Ersatz finden
  {
  for i := 1 to 7 do
    if TColorBox(FindComponent('ColorBox'+IntToStr(i))).Selected = ColorBoxBgCol.Selected then
      ColorBoxBgCol.Selected:=clWhite;
  }
end;


//######################## FormClose ###########################################

procedure TFrmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BtnCancel.Click;
  Action:=caNone;
  // todo: Ersatz finden
  //player:=nil;
end;


//######################## FormCreate ##########################################

procedure TFrmOptions.FormCreate(Sender: TObject);

  procedure ReadTemplateNames;
  var
    SearchRec: TSearchRec;
  begin
    FindFirst(ExtractFilePath(ParamStr(0))+'templates\*', faAnyFile ,SearchRec);
    repeat
      if (SearchRec.Name<>'.') AND (SearchRec.Name<>'..') then
        if (SearchRec.Attr and faDirectory <> 0) then
          CbSelectTemplate.Items.Add(SearchRec.Name);
    until FindNext(SearchRec) <> 0;
  end;

begin
  if DirectoryExists(ExtractFilePath(ParamStr(0))+'templates\') then
    ReadTemplateNames;
  InitKeyArrays;
  BtnCancel.Click;
  lblVersion.Caption:=APP_VERSIONSTR;
  // todo: Ersatz finden
  //player:=MediaPlayer;
end;


//######################## MoveLeft ############################################

Function TFrmOptions.MoveLeft:Word;
begin
  result:=fKeyCodes[CmBMoveLeft.ItemIndex];
end;


//######################## MoveRight ###########################################

Function TFrmOptions.MoveRight:Word;
begin
  result:=fKeyCodes[CmbMoveRight.ItemIndex];
end;


//######################## TurnLeft ############################################

Function TFrmOptions.TurnLeft:Word;
begin
  result:=fKeyCodes[CmbTurnLeft.ItemIndex];
end;


//######################## TurnRight ###########################################

Function TFrmOptions.TurnRight:Word;
begin
  result:=fKeyCodes[CmbTurnRight.ItemIndex];
end;


//######################## OneDown #############################################

Function TFrmOptions.OneDown:Word;
begin
  result:=fKeyCodes[CmbMoveOneDown.ItemIndex];
end;


//######################## Down ################################################

Function TFrmOptions.Down:Word;
begin
  result:=fKeyCodes[CmbMoveDown.ItemIndex];
end;


//######################## Pause ###############################################

Function TFrmOptions.Pause:Word;
begin
  result:=fKeyCodes[CmbPause.ItemIndex];
end;


procedure TFrmOptions.RadioButton2Click(Sender: TObject);
var
  Msg: String;
begin
  if CbSelectTemplate.Items.Count>0 then
  begin
    PageControl2.ActivePageIndex := 2;
    CbSelectTemplate.ItemIndex:=0;
    CbSelectTemplateChange(Sender);
  end
  else
  begin
    RbOldStyle.Checked := true;
    Msg:='Es sind keine Templates vorhanden!' +#13+
         'Lassen Sie das Programm nach Updates suchen!' +#13+#13+
         'Jetzt nach Updates suchen?';
    if Application.MessageBox(PChar(Msg),'Fehler!',MB_YESNO+MB_ICONERROR)=ID_YES then
      BtnStartUpdate.Click;
  end;  
end;

end.
