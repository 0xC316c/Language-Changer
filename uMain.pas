unit uMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.IniFiles,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    ApplyBtn: TButton;
    AboutBtn: TButton;
    UserNameLbl: TLabel;
    LanguageLbl: TLabel;
    LanguageCb: TComboBox;
    UserNameEdit: TEdit;

    procedure FormCreate(Sender: TObject);
    procedure ApplyBtnClick(Sender: TObject);
    procedure AboutBtnClick(Sender: TObject);
    procedure CbLanguageChange(Sender: TObject);
    procedure CbUsernameChange(Sender: TObject);
    procedure EditUsernameKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseEnter(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

TCustomResult = Record
    iCfgFileCount: Cardinal;
    sCfgFile: String;
  end;

const
  INI_FILE = 0;

var
  MainForm: TMainForm;
  iniFile: TIniFile;
  iCurLanguageIndex: Integer;
  sSectionName, sKeyName, sSectionLanguage, sKeyLanguage, sCurLanguage, sCurUserName: String;
  aCfgFiles: Array [INI_FILE..INI_FILE] of String = ('steam_emu.ini');

  LANG_INI: Array [0..17] of String = ('arabic','brazilian','czech','english','french','german','hungarian','italian','japanese','korean','polish','portuguese','russian','simplified chinese','spanish','thai','traditional chinese','turkish');
  CB_LANG: Array [0..17] of String = ('Arabic','Brazilian','Czech','English','French','German','Hungarian','Italian','Japanese','Korean','Polish','Portuguese','Russian','Simplified Chinese','Spanish','Thai','Traditional Chinese','Turkish');

implementation

{$R *.dfm}

procedure TMainForm.FormShow(Sender: TObject);
begin
  SetFocusedControl(LanguageCb);
end;

procedure TMainForm.FormMouseEnter(Sender: TObject);
begin
  ActiveControl := nil;
end;

procedure SetSectionsKeys(index: Integer);
begin
// Set section & key for Username
  case index of
    INI_FILE:
    begin
      sSectionName := 'Settings';
      sKeyName := 'Username';
    end;
  end;

  // Set section & key for language
  case index of
    INI_FILE:
    begin
      sSectionLanguage := 'Settings';
      sKeyLanguage := 'Language';
    end;
  end;
end;

procedure TMainForm.ApplyBtnClick(Sender: TObject);
begin
  sCurUserName := UserNameEdit.Text;
  iniFile.WriteString(sSectionName, sKeyName, sCurUserName);
  iCurLanguageIndex := MainForm.LanguageCb.ItemIndex;
  iniFile.WriteString(sSectionLanguage, sKeyLanguage, LANG_INI[iCurLanguageIndex]);
  ShowMessage('Applied Successfully!');
  MainForm.ApplyBtn.Enabled := True;
  SetFocusedControl(LanguageCb);
  //Application.Terminate;
end;

procedure TMainForm.AboutBtnClick(Sender: TObject);
begin
  ShowMessage('Game Language Changer by Darck Team' + #13#10
  + #13#10 +'Programmers: Jiva Newstone, Grim Reaper && PsYcHo_RaGE');
end;

procedure TMainForm.CbLanguageChange(Sender: TObject);
begin
  if (LanguageCb.ItemIndex <> iCurLanguageIndex) then
  begin
    MainForm.ApplyBtn.Enabled := True;
    MainForm.ApplyBtn.Caption := 'Apply';
  end;
end;

procedure TMainForm.CbUsernameChange(Sender: TObject);
begin
  if ((sCurUserName <> MainForm.UserNameEdit.Text) and (Length(MainForm.UserNameEdit.Text) >= 1)) then
  begin
    MainForm.ApplyBtn.Enabled := True;
    MainForm.ApplyBtn.Caption := 'Apply';
  end;
end;

procedure TMainForm.EditUsernameKeyPress(Sender: TObject; var Key: Char);
begin
  if ((key = #13) and (ApplyBtn.Enabled)) then
  ApplyBtnClick(nil);
end;

function GetLanguageIndex: Integer;
var
  i: Integer;
  sl: TStringList;
begin
  with MainForm do
  begin
    sl := TStringList.Create;
    try
      for i := Low(LANG_INI) to High(LANG_INI) do
      sl.Add(LANG_INI[i]);
      Result := sl.IndexOf(LowerCase(iniFile.ReadString(sSectionLanguage, sKeyLanguage, 'English')));
    finally
      sl.Free;
    end;
  end;
end;

function GetGroupIndex(sCfgFile: string): integer;
var
  i: Integer;
begin
  Result := -1;
  for i := Low(aCfgFiles) to High(aCfgFiles) do
  begin
    if (ExtractFileName(sCfgFile) = aCfgFiles[i]) then
    Exit(i);
  end;
end;

function GetCfgFile: TCustomResult;
var
  i: Integer;
  sCurCfgFile: String;
  aCurCfgFiles: Array of String;
begin
  Result.iCfgFileCount := 0;

  for i := Low(aCfgFiles) to High(aCfgFiles) do
  begin
    sCurCfgFile := ExtractFilePath(ParamStr(0))+aCfgFiles[I];
    if System.SysUtils.FileExists(sCurCfgFile) then
    begin
      Result.iCfgFileCount := Result.iCfgFileCount+1;
      SetLength(aCurCfgFiles, Result.iCfgFileCount);
      aCurCfgFiles[Result.iCfgFileCount -1] := sCurCfgFile;
    end;
  end;
  if Length(aCurCfgFiles) = 1 then
  Result.sCfgFile := aCurCfgFiles[0];
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  sCfgFile: String;
  i, iCfgFileCount, iGroupIndex: Integer;
begin
  iCfgFileCount := GetCfgFile.iCfgFileCount;
  sCfgFile := GetCfgFile.sCfgFile;

  case iCfgFileCount of
    0:
    begin
      Winapi.Windows.MessageBox(0, pChar('Language Changer was unable to find Configuration settings file.'), pChar('ERROR'), MB_OK or MB_ICONERROR);
      Application.Terminate;
    end;
    1:
    begin
    for i := Low(CB_LANG) to High(CB_LANG) do
    LanguageCb.Items.Add(CB_LANG[i]);
    iniFile := TIniFile.Create(sCfgFile);
    iGroupIndex := GetGroupIndex(sCfgFile);
    SetSectionsKeys(iGroupIndex);
    iCurLanguageIndex := GetLanguageIndex;
    LanguageCb.ItemIndex := iCurLanguageIndex;
    sCurUserName := iniFile.ReadString(sSectionName, sKeyName, 'Player');
    UserNameEdit.Text := sCurUserName;
    end;
  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if Assigned(iniFile) then
  iniFile.Free;
end;

end.
