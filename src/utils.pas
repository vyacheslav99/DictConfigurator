unit utils;

interface

uses
  Windows, SysUtils, Classes, Registry, ShellAPI, IniFiles, ShlObj, ActiveX, ComObj, Variants, Math,
  Graphics, StrUtils, TlHelp32, StdCtrls, DBGridEh, GridsEh, Messages, Clipbrd, DB, Forms;

const
  U_WM_FORCED_TERMINATE = WM_USER + $132;
  
  // ключи реестра для хранения настроек
  PARAM_ROOT_KEY = HKEY_CURRENT_USER;
  PARAM_REG_KEY = 'Software\DictConfigurator';
  REG_KEY_WINDOW = PARAM_REG_KEY + '\Window';
  REG_KEY_CONFIG = PARAM_REG_KEY + '\Config';
  REG_KEY_CONNECT = PARAM_REG_KEY + '\Connection';
  REG_KEY_FIND = PARAM_REG_KEY + '\Find';
  REG_KEY_DB_FIND = PARAM_REG_KEY + '\DbFind';
  REG_KEY_FIND_HIST = REG_KEY_FIND + '\History';
  REG_KEY_DB_FIND_HIST = REG_KEY_DB_FIND + '\History';
  REG_KEY_FILTER = PARAM_REG_KEY + '\Filter';
  REG_KEY_FILTER_HIST = REG_KEY_FILTER + '\History';
  REG_KEY_GRID = REG_KEY_CONFIG + '\Grid';
  REG_KEY_SESSION = PARAM_REG_KEY + '\Session';
  REG_KEY_FORMS = PARAM_REG_KEY + '\Forms';
  REG_KEY_FDMP_OBJ = REG_KEY_FORMS + '\FDmpObjects';

  {$I keys.inc}

  PATH_DELIM = '•';

  FIND_WORD_DELIMS = [#0..#34, #40..#47, #58..#63, #91..#93, #123..#127, #130, #132, #133, #139, #145..#152, #155, #160,
    #164, #166, #171..#173, #177, #183, #187];

  ProhibMes: array [0..3] of string = (
    'Неверные имя пользователя или пароль!',
    'База данных ''%s'' не существует.',
    'Сервер ''%s'' не отвечает.',
    'При подключении произошла ошибка.'#13#10#13#10'%s');

  FBENCODINGS = 'ASCII,BIG_5,CP943C,CYRL,DOS437,DOS850,DOS852,DOS857,DOS860,DOS861,DOS863,DOS865,EUCJ_0208,GB_2312,GBK,' +
    'ISO8859_1,ISO8859_2,KSC_5601,NEXT,NONE,OCTETS,SJIS_0208,TIS620,UNICODE_FSS,UTF8,WIN1250,WIN1251,WIN1252,WIN1253,WIN1254';
  MYENCODINGS = 'armscii8,ascii,big5,binary,cp1250,cp1251,cp1256,cp1257,cp850,cp852,cp866,cp932,dec8,eucjmps,euckr,gb2312,' +
    'gbk,greek,hebrew,hp8,keybcs2,koi8r,koi8u,latin1,latin2,latin5,latin7,macce,macroman,sjis,swe7,tis620,ujis,utf8';
  PGENCODINGS = 'SQL_ASCII,UTF8,LATIN1,LATIN2,LATIN3,LATIN4,LATIN5,LATIN6,LATIN7,LATIN8,LATIN9,ISO-8859-5,ISO-8859-6,' +
    'ISO-8859-7,ISO-8859-8,WIN866,WIN1250,WIN1251,WIN1256,WIN1257,KOI8';

  DBDESC_FB = 'firebird';
  {DBDESC_ORA = 'oracle';
  DBDESC_ORA_RAN = 'oracleRan';
  DBDESC_PG_AM = 'PostgreSQL_Antimonopoly';
  DBDESC_PG_RAO = 'PostgreSQL_rao';
  DBDESC_FB_ENS = 'ens';}
  DEF_DBDESCRIPTORS = DBDESC_FB + #13#10'oracle'#13#10'ens';

  GUID_WARNING = 'Невозможно собрать скрипт изменений, так как некоторые объекты конфигурации не имеют GUID! '#13#10 +
    'Чтобы можно было пользоваться данной возможностью, сначала необходимо выгрузить полный скрипт создания конфигурации '#13#10 +
    'и накатить его на ВСЕ базы данных (в том числе и на ту, откуда он был выгружен).';

type
  TFindOption = (foMatchCase, foToExistence, foWholeString, foAnyWord, foAllWords);
  TFindOptions = set of TFindOption;
  TServerType = (stFirebird, stOracle, stPostgreSQL, stMySQL);
  TGrantAction = (gaAdd, gaEdit, gaDel, gaView, gaRights, gaOpenInstr, gaViewInstr);
  TOpenMode = (omAdd, omEdit, omView);
  TChildWindowState = (cwsNormal, cwsMaximized, cwsKeep);
  THistoryType = (htLiked, htHistory);
  TRefLogType = (rltCreate, rltUpdate, rltRecreate, rltDelete);
  TConnectionType = (ctUndefined, ctDev, ctTest, ctProd);

  TConnection = record
    AlwaysPromptPass: boolean;
    AllowLogin: boolean;
    PortalDescriptor: string;
    PortalUrl: string;
    Server: TServerType;
    Alias: string;
    Host: string;
    Port: integer;
    DataBase: string;
    UserName: string;
    Pass: string;
    Role: string;
    Encoding: string;
    SQLDialect: integer;
    ConnType: TConnectionType;
  end;

  TConnections = array of TConnection;

  TConfObjectType = (cotFolder, cotDict, cotForm, cotWizard, cotNone, cotLikedFolder);

  TNodeDictInfo = class
    PK: Variant;
    Descriptor: Variant;
    Title: Variant;
    ParentDictPK: Variant;
    FolderPK: Variant;
    Login: Variant;
    ObjType: TConfObjectType;
    Guid: Variant;
    procedure Assign(Source: TObject);
    function IsEqual(Source: TObject): boolean;
  end;

  TGridParams = class
  public
    Flat: boolean;
    Font: TFont;
    RowColor: TColor;
    EvenRowColor: TColor;
    NewRowColor: TColor;
    ChangedRowColor: TColor;
    RowAutoAlignment: boolean;
    RowAlignment: TAlignment;
    RowLayout: TTextLayout;
    RowHeight: integer;
    RowLines: boolean;
    ColLines: boolean;
    ExtendVertLines: boolean;
    FrozenCols: integer;
    TitleFont: TFont;
    TitleColor: TColor;
    TitleHeight: integer;
    TitleAlignment: TAlignment;
    constructor Create;
    destructor Destroy; override;
    procedure AssignTo(Grid: TDBGridEh);
    procedure Assign(Source: TObject);
  end;

  TUpdateInfo = record
    IsEmpty: boolean;
    Version: string;
    FileName: string;
    Date: TDateTime;
    Description: string;
    FileSize: integer;
    MD5: string;
    SourceFile: string; 
  end;

function AssignNodeData(ObjType: TConfObjectType): TNodeDictInfo;
function iif(Switch: boolean; iftrue: variant; iffalse: variant): variant;
function GetVersion(FileName: string): string;
function GetCurrUserName: string;
function GetTempDir: string;
function ProcessExists(ExeFile: string): Cardinal;
function ProcessTerminate(PrID: Cardinal): boolean;
function ExecCallBackFunc(hwnd: Cardinal; lParam: LPARAM): boolean; stdcall;

// ini files
function ReadIniValue(IniFile, Section, Param, default: string): string;
function WriteIniValue(IniFile, Section, Param, Value: string): boolean;
function DeleteIniKey(IniFile, Section, Param: string): boolean;
function DeleteIniSection(IniFile, Section: string): boolean;
function CopyIniSection(FileFrom, FileTo, Section: string; var ErrMessage: string): boolean;
procedure ReadIniSections(IniFile: string; SL: TStringList);
procedure DeleteIniSecStartWith(FileName, SecStartWith: string);
procedure RenameIniSection(FileName, OldName, NewName: string);

// registry
function ReadRegValueStr(RootKey: HKEY; Key, Param, default: string): string; overload;
function ReadRegValueStr(Reg: Tregistry; Param, default: string): string; overload;
function WriteRegValueStr(RootKey: HKEY; Key, Param, Value: string; CanCreate: boolean): boolean; overload;
function WriteRegValueStr(Reg: Tregistry; Param, Value: string): boolean; overload;
function ReadRegValueInt(RootKey: HKEY; Key, Param: string; default: integer): integer; overload;
function ReadRegValueInt(Reg: Tregistry; Param: string; default: integer): integer; overload;
function WriteRegValueInt(RootKey: HKEY; Key, Param: string; Value: integer; CanCreate: boolean): boolean; overload;
function WriteRegValueInt(Reg: Tregistry; Param: string; Value: integer): boolean; overload;
function ReadRegValueBool(RootKey: HKEY; Key, Param: string; default: boolean): boolean; overload;
function ReadRegValueBool(Reg: Tregistry; Param: string; default: boolean): boolean; overload;
function WriteRegValueBool(RootKey: HKEY; Key, Param: string; Value: boolean; CanCreate: boolean): boolean; overload;
function WriteRegValueBool(Reg: Tregistry; Param: string; Value: boolean): boolean; overload;
function ReadRegValueDateTime(RootKey: HKEY; Key, Param: string; default: TDateTime): TDateTime; overload;
function ReadRegValueDateTime(Reg: Tregistry; Param: string; default: TDateTime): TDateTime; overload;
function WriteRegValueDateTime(RootKey: HKEY; Key, Param: string; Value: TDateTime; CanCreate: boolean): boolean; overload;
function WriteRegValueDateTime(Reg: Tregistry; Param: string; Value: TDateTime): boolean; overload;
procedure ReadRegValueFont(Reg: Tregistry; Param: string; var Dest: TFont);
function WriteRegValueFont(Reg: Tregistry; Param: string; Value: TFont): boolean;
function DeleteRegParam(RootKey: HKEY; Key, Param: string): boolean;
function DeleteRegKey(RootKey: HKEY; Key: string): boolean;
procedure ReadRegKeys(RootKey: HKEY; Key: string; SL: TStringList);
procedure ReadRegValueNames(RootKey: HKEY; Key: string; SL: TStringList);
procedure ClearRegKey(RootKey: HKEY; Key: string; DeleteSubKeys: boolean);
function RegistryRootKeyToString(RootKey: HKEY): string;
function RegKeyExists(RootKey: HKEY; Key: string): boolean;
procedure RegMoveKey(RootKey: HKEY; OldKey, NewKey: string; Delete: boolean);

function CopyFile(SourceFile, DestFile: string; var ErrMsg: string): boolean;
function DeleteDir(Directory: string; var ErrMsg: string): boolean;
function ExtractWordEx(n: integer; s: string; WordDelims: TSysCharSet; IgnoreBlockChars: TSysCharSet): string;
function WordCountEx(s: string; WordDelims: TSysCharSet; IgnoreBlockChars: TSysCharSet): integer;
function GetFontStyle(style: string): TFontStyles;
function FontStyleAsString(fstyle: TFontStyles): string;
function FloatToDBStr(value: double; FormatStr: string = ''): string;
function VariantToDBStr(value: variant; QuotedString: boolean; EmptyStrToNull: boolean = true; ZeroToNull: boolean = false;
  QuoteSymb: char = ''''): string;
function ReplaceQuote(Str: string): string;
function FormatNum(num: double): string; overload;
function FormatNum(num: integer): string; overload;
function GenRandString(genrule, vlength: integer): string;
function AnsiToDos(AnsiStr: string): string;
function TextToString(Text: string; Decorator: string = ''; Delimiter: string = ','): string;
function ArrayToString(arr: array of string; Decorator: string = ''; Delimiter: string = ','): string;
function SplitLongString(str: string; Delim: char; sz: integer): TStringList;
procedure SplitPathByHost(var Path: string; var Host: string);
function FindInArray(Arr: array of string; str: string): integer;
function FindInStrings(Strings: TStringList; str: string; Opts: TFindOptions): integer;
function PyUnicodeToAnsi(UniStr: string): string;
function PyAnsiToUnicode(AnsiStr: string): string;
function NetCompConnect(Addr, Usr, Pass: string; CanClose: boolean; var Err: string): boolean;
function GenCaption(Prefix, Postfix, Pk, Descriptor, Title: string; ShowDescr: boolean): string;
function MillisecondsToTimeStr(ms: Cardinal): string;
function GetConfObjectTypeStr(ObjectType: TConfObjectType): string;
procedure SplitFieldName(FieldName: string; var ObjName: string; var FldName: string);
function CompareStrings(StrWhere, StrWhat: string; Options: TFindOptions): boolean;
procedure CopyToClipboard(str: string);
procedure SafeFreeAndNil(Obj: TObject);
function FindInGrid(Grid: TDBGridEh; FindStr, FieldName: string; FindOptions: TFindOptions; AContinue: boolean = false;
  NoEndQuery: boolean = false): boolean;
function SlCustomSort(List: TStringList; Index1, Index2: integer): integer;
function BytesToStr(b: int64): string;
function CreateGuid(NoDash: boolean = false): string;

var
  DWndHandle: Cardinal;

implementation

const
  AnsiCharTable: array[0..72] of string = ('\', '/', '"', '<', '>', #13#10, #9, 'А', 'Б', 'В', 'Г', 'Д', 'Е', 'Ё', 'Ж',
    'З', 'И', 'Й', 'К', 'Л', 'М', 'Н', 'О', 'П', 'Р', 'С', 'Т', 'У', 'Ф', 'Х', 'Ц', 'Ч', 'Ш', 'Щ', 'Ъ', 'Ы', 'Ь', 'Э',
    'Ю', 'Я', 'а', 'б', 'в', 'г', 'д', 'е', 'ё', 'ж', 'з', 'и', 'й', 'к', 'л', 'м', 'н', 'о', 'п', 'р', 'с', 'т', 'у',
    'ф', 'х', 'ц', 'ч', 'ш', 'щ', 'ъ', 'ы', 'ь', 'э', 'ю', 'я');
  UniCharTable: array[0..72] of string = ('\\', '\/', '\"', '\u003c', '\u003e', '\n', '\t', '\u0410', '\u0411', '\u0412',
    '\u0413', '\u0414', '\u0415', '\u0401', '\u0416', '\u0417', '\u0418', '\u0419', '\u041a', '\u041b', '\u041c', '\u041d',
    '\u041e', '\u041f', '\u0420', '\u0421', '\u0422', '\u0423', '\u0424', '\u0425', '\u0426', '\u0427', '\u0428', '\u0429',
    '\u042a', '\u042b', '\u042c', '\u042d', '\u042e', '\u042f', '\u0430', '\u0431', '\u0432', '\u0433', '\u0434', '\u0435',
    '\u0451', '\u0436', '\u0437', '\u0438', '\u0439', '\u043a', '\u043b', '\u043c', '\u043d', '\u043e', '\u043f', '\u0440',
    '\u0441', '\u0442', '\u0443', '\u0444', '\u0445', '\u0446', '\u0447', '\u0448', '\u0449', '\u044a', '\u044b', '\u044c',
    '\u044d', '\u044e', '\u044f');

function AssignNodeData(ObjType: TConfObjectType): TNodeDictInfo;
begin
  result := TNodeDictInfo.Create;
  result.PK := Null;
  result.Descriptor := Null;
  result.Title := Null;
  result.ParentDictPK := Null;
  result.FolderPK := Null;
  result.Login := Null;
  result.ObjType := ObjType;
  result.Guid := CreateGuid;
end;

function iif(Switch: boolean; iftrue: variant; iffalse: variant): variant;
begin
  if Switch then
    result := iftrue
  else
    result := iffalse;
end;

function GetVersion(FileName: string): string;
var
  Info: Pointer;
  InfoSize: DWORD;
  FileInfo: PVSFixedFileInfo;
  FileInfoSize: DWORD;
  Tmp: DWORD;
  Major1, Major2, Minor1, Minor2: Integer;

begin
  result := '';
  Major1 := 0;
  Major2 := 0;
  Minor1 := 0;
  Minor2 := 0;

  InfoSize := GetFileVersionInfoSize(PChar(FileName), Tmp);

  if InfoSize = 0 then result := ''
  else begin
    GetMem(Info, InfoSize);
    try
      GetFileVersionInfo(PChar(FileName), 0, InfoSize, Info);
      VerQueryValue(Info, '\', Pointer(FileInfo), FileInfoSize);
      Major1 := FileInfo.dwFileVersionMS shr 16;
      Major2 := FileInfo.dwFileVersionMS and $FFFF;
      Minor1 := FileInfo.dwFileVersionLS shr 16;
      Minor2 := FileInfo.dwFileVersionLS and $FFFF;
    finally
      FreeMem(Info, FileInfoSize);
    end;
  end;

  result := IntToStr(Major1) + '.' + IntToStr(Major2) + '.' + IntToStr(Minor1) + '.' + IntToStr(Minor2);
end;

function GetCurrUserName: string;
var
  buff: array [0..255] of char;
  n: Cardinal;

begin
  //GetEnvironmentVariable(pchar('USERNAME'), buff, SizeOf(buff));
  n := SizeOf(buff);
  GetUserName(buff, n);
  result := string(buff);
end;

function GetTempDir: string;
var
  buff: array [0..255] of char;

begin
  GetEnvironmentVariable(pchar('TEMP'), buff, SizeOf(buff));
  result := string(buff);
  if (Length(result) > 0) and (result[Length(result)] = '\') then Delete(result, Length(result), 1);
end;

function ProcessExists(ExeFile: string): Cardinal;
var
  hSnapshot: Cardinal;
  pe32: TProcessEntry32;
  fn: string;
  currPid: Cardinal;
  
begin
  result := 0;
  currPid := GetCurrentProcessId;
  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, GetCurrentProcessId);
  pe32.dwSize := SizeOf(TProcessEntry32);

  if Process32First(hSnapshot, pe32) then
    repeat
      fn := string(pe32.szExeFile);
      if (pe32.th32ProcessID <> currPid) and (AnsiLowerCase(fn) = AnsiLowerCase(ExeFile)) then
      begin
        result := pe32.th32ProcessID;
        break;
      end;
    until not Process32Next(hSnapshot, pe32);

  CloseHandle(hSnapshot);
end;

function ProcessTerminate(PrID: Cardinal): boolean;
var
  hProcess: THandle;

begin
  result := false;
  hProcess := OpenProcess(PROCESS_TERMINATE, false, PrID);
  if hProcess = 0 then exit;
  result := TerminateProcess(hProcess, DWORD(-1));
  CloseHandle(hProcess);
end;

function ExecCallBackFunc(hwnd: Cardinal; lParam: LPARAM): boolean; stdcall;
var
  pid: Cardinal;
  buff: array [0..255] of char;
  n, i: integer;
  clsName: string;

begin
  // Каллбэк функция для EnumWindows, которая вызывается для каждого окна в системе (хэндл окна передается сюда через 1 параметр):
  // проверяет, принадлежит ли окно интересующему меня процессу и является ли экземпляром MainForm.
  // Функция вызывается для каждого окна в системе, перечисляемых EnumWindows.
  // Параметр № 2 (lParam) - PID интересующего меня процесса - я передаю его сам через EnumWindows (там можно передавать 1
  // параметр, который будет передан в таком же виде в каллбэк функцию через lParam).
  // Если окно - искомое окно, сохраняю его Handle в глобальной переменной, которую потом использую.
  // Возвращаемый результат:
  // если result := True - EnumWindows продолжит поиск дальше (т.е. переходит к след. окну в списке),
  // если False - остановится. Как только находим нужное окно - прерываем поиск (возвращаем False).

  clsName := '';
  DWndHandle := 0;
  GetWindowThreadProcessId(hwnd, pid);

  n := GetClassName(hwnd, buff, 256);
  for i := 0 to n - 1 do
  begin
    if buff[i] = #0 then break;
    clsName := clsName + buff[i];
  end;

  result := not ((lParam = pid) and (clsName = 'TFMain'));
  if not result then DWndHandle := hwnd;
end;

function ReadIniValue(IniFile, Section, Param, default: string): string;
var
  f: TIniFile;

begin
  result := default;
  if not FileExists(IniFile) then exit;
  f := TIniFile.Create(IniFile);
  try
    result := f.ReadString(Section, Param, default);
  except
  end;
  f.Free;
end;

function WriteIniValue(IniFile, Section, Param, Value: string): boolean;
var
  f: TIniFile;

begin
  result := false;
  if not FileExists(IniFile) then exit;
  f := TIniFile.Create(IniFile);
  try
    f.WriteString(Section, Param, Value);
    result := true;
  except
  end;
  f.Free;
end;

function DeleteIniKey(IniFile, Section, Param: string): boolean;
var
  f: TIniFile;

begin
  result := false;
  if not FileExists(IniFile) then exit;
  f := TIniFile.Create(IniFile);
  try
    f.DeleteKey(Section, Param);
    result := true;
  except
  end;
  f.Free;
end;

function DeleteIniSection(IniFile, Section: string): boolean;
var
  f: TIniFile;

begin
  result := false;
  if not FileExists(IniFile) then exit;
  f := TIniFile.Create(IniFile);
  try
    f.EraseSection(Section);
    result := true;
  except
  end;
  f.Free;
end;

function CopyIniSection(FileFrom, FileTo, Section: string; var ErrMessage: string): boolean;
var
  fSrc, fDest: TIniFile;
  i: integer;
  sl: TStringList;

begin
  result := false;
  ErrMessage := '';
  fSrc := TIniFile.Create(FileFrom);
  fDest := TIniFile.Create(FileTo);
  sl := TStringList.Create;

  try
    fDest.EraseSection(Section);
    fSrc.ReadSection(Section, sl);
    for i := 0 to sl.Count - 1 do
      fDest.WriteString(Section, sl.Strings[i], fSrc.ReadString(Section, sl.Strings[i], ''));
    result := true;
  except
    on e: Exception do ErrMessage := e.Message;
  end;

  sl.Free;
  fSrc.Free;
  fDest.Free;
end;

procedure ReadIniSections(IniFile: string; SL: TStringList);
var
  f: TIniFile;

begin
  if not Assigned(SL) then exit;
  SL.Clear;
  f := TIniFile.Create(IniFile);
  try
    f.ReadSections(SL);
  except
  end;
  f.Free;
end;

procedure DeleteIniSecStartWith(FileName, SecStartWith: string);
var
  sl: TStringList;
  i: integer;

begin
  sl := TStringList.Create;
  try
    ReadIniSections(FileName, sl);
    for i := 0 to sl.Count - 1 do
      if (Pos(SecStartWith, sl.Strings[i]) = 1) then DeleteIniSection(FileName, sl.Strings[i]);
  finally
    sl.Free;
  end;
end;

procedure RenameIniSection(FileName, OldName, NewName: string);
var
  f: TIniFile;
  sl: TStringList;
  i: integer;
  
begin
  if not FileExists(FileName) then exit;

  sl := TStringList.Create;
  f := TIniFile.Create(FileName);
  try
    if f.SectionExists(OldName) then
    begin
      f.ReadSectionValues(OldName, sl);
      for i := 0 to sl.Count - 1 do
        f.WriteString(NewName, sl.Names[i], sl.Values[sl.Names[i]]);

      f.EraseSection(OldName);
    end;
  finally
    sl.Free;
    f.Free;
  end;
end;

function ReadRegValueStr(RootKey: HKEY; Key, Param, default: string): string;
var
  reg: TRegistry;

begin
  result := default;
  reg := TRegistry.Create(KEY_READ);
  reg.RootKey := RootKey;

  try
    if reg.OpenKey(Key, False) and reg.ValueExists(Param) then result := reg.ReadString(Param);
  except
  end;

  reg.CloseKey;
  reg.Free;
end;

function ReadRegValueStr(Reg: Tregistry; Param, default: string): string;
begin
  result := default;
  try
    if Reg.ValueExists(Param) then result := Reg.ReadString(Param);
  except
  end;
end;

function WriteRegValueStr(RootKey: HKEY; Key, Param, Value: string; CanCreate: boolean): boolean;
var
  reg: TRegistry;

begin
  result := false;
  reg := TRegistry.Create(KEY_ALL_ACCESS);
  try
    reg.RootKey := RootKey;
    //reg.LazyWrite := false;
    if reg.OpenKey(Key, CanCreate) then
    begin
      reg.WriteString(Param, Value);
      result := true;
    end;
  except
  end;
  reg.CloseKey;
  reg.Free;
end;

function WriteRegValueStr(Reg: Tregistry; Param, Value: string): boolean;
begin
  result := false;
  try
    Reg.WriteString(Param, Value);
    result := true;
  except
  end;
end;

function ReadRegValueInt(RootKey: HKEY; Key, Param: string; default: integer): integer;
var
  reg: TRegistry;

begin
  result := default;
  reg := TRegistry.Create(KEY_READ);
  reg.RootKey := RootKey;

  try
    if reg.OpenKey(Key, False) and reg.ValueExists(Param) then result := reg.ReadInteger(Param);
  except
  end;

  reg.CloseKey;
  reg.Free;
end;

function ReadRegValueInt(Reg: Tregistry; Param: string; default: integer): integer;
begin
  result := default;
  try
    if Reg.ValueExists(Param) then result := Reg.ReadInteger(Param);
  except
  end;
end;

function WriteRegValueInt(RootKey: HKEY; Key, Param: string; Value: integer; CanCreate: boolean): boolean;
var
  reg: TRegistry;

begin
  result := false;
  reg := TRegistry.Create(KEY_ALL_ACCESS);
  try
    reg.RootKey := RootKey;
    //reg.LazyWrite := false;
    if reg.OpenKey(Key, CanCreate) then
    begin
      reg.WriteInteger(Param, Value);
      result := true;
    end;
  except
  end;
  reg.CloseKey;
  reg.Free;
end;

function WriteRegValueInt(Reg: Tregistry; Param: string; Value: integer): boolean; overload;
begin
  result := false;
  try
    Reg.WriteInteger(Param, Value);
    result := true;
  except
  end;
end;

function ReadRegValueBool(RootKey: HKEY; Key, Param: string; default: boolean): boolean;
var
  reg: TRegistry;

begin
  result := default;
  reg := TRegistry.Create(KEY_READ);
  reg.RootKey := RootKey;

  try
    if reg.OpenKey(Key, False) and reg.ValueExists(Param) then result := reg.ReadBool(Param);
  except
  end;

  reg.CloseKey;
  reg.Free;
end;

function ReadRegValueBool(Reg: Tregistry; Param: string; default: boolean): boolean;
begin
  result := default;
  try
    if Reg.ValueExists(Param) then result := Reg.ReadBool(Param);
  except
  end;
end;

function WriteRegValueBool(RootKey: HKEY; Key, Param: string; Value: boolean; CanCreate: boolean): boolean;
var
  reg: TRegistry;

begin
  result := false;
  reg := TRegistry.Create(KEY_ALL_ACCESS);
  try
    reg.RootKey := RootKey;
    //reg.LazyWrite := false;
    if reg.OpenKey(Key, CanCreate) then
    begin
      reg.WriteBool(Param, Value);
      result := true;
    end;
  except
  end;
  reg.CloseKey;
  reg.Free;
end;

function WriteRegValueBool(Reg: Tregistry; Param: string; Value: boolean): boolean; overload;
begin
  result := false;
  try
    Reg.WriteBool(Param, Value);
    result := true;
  except
  end;
end;

function ReadRegValueDateTime(RootKey: HKEY; Key, Param: string; default: TDateTime): TDateTime; overload;
var
  reg: TRegistry;

begin
  result := default;
  reg := TRegistry.Create(KEY_READ);
  reg.RootKey := RootKey;

  try
    if reg.OpenKey(Key, False) and reg.ValueExists(Param) then result := reg.ReadDateTime(Param);
  except
  end;

  reg.CloseKey;
  reg.Free;
end;

function ReadRegValueDateTime(Reg: Tregistry; Param: string; default: TDateTime): TDateTime; overload;
begin
  result := default;
  try
    if Reg.ValueExists(Param) then result := Reg.ReadDateTime(Param);
  except
  end;
end;

function WriteRegValueDateTime(RootKey: HKEY; Key, Param: string; Value: TDateTime; CanCreate: boolean): boolean; overload;
var
  reg: TRegistry;

begin
  result := false;
  reg := TRegistry.Create(KEY_ALL_ACCESS);
  try
    reg.RootKey := RootKey;
    //reg.LazyWrite := false;
    if reg.OpenKey(Key, CanCreate) then
    begin
      reg.WriteDateTime(Param, Value);
      result := true;
    end;
  except
  end;
  reg.CloseKey;
  reg.Free;
end;

function WriteRegValueDateTime(Reg: Tregistry; Param: string; Value: TDateTime): boolean; overload;
begin
  result := false;
  try
    Reg.WriteDateTime(Param, Value);
    result := true;
  except
  end;
end;

procedure ReadRegValueFont(Reg: Tregistry; Param: string; var Dest: TFont);
begin
  try
    if Reg.ValueExists(Param + '.Charset') then Dest.Charset := Reg.ReadInteger(Param + '.Charset');
    if Reg.ValueExists(Param + '.Color') then Dest.Color := Reg.ReadInteger(Param + '.Color');
    if Reg.ValueExists(Param + '.Height') then Dest.Height := Reg.ReadInteger(Param + '.Height');
    if Reg.ValueExists(Param + '.Name') then Dest.Name := Reg.ReadString(Param + '.Name');
    if Reg.ValueExists(Param + '.Orientation') then Dest.Orientation := Reg.ReadInteger(Param + '.Orientation');
    if Reg.ValueExists(Param + '.Pitch') then Dest.Pitch := TFontPitch(Reg.ReadInteger(Param + '.Pitch'));
    if Reg.ValueExists(Param + '.Size') then Dest.Size := Reg.ReadInteger(Param + '.Size');
    if Reg.ValueExists(Param + '.Style') then Dest.Style := GetFontStyle(Reg.ReadString(Param + '.Style'));
  except
  end;
end;

function WriteRegValueFont(Reg: Tregistry; Param: string; Value: TFont): boolean;
begin
  result := false;
  try
    Reg.WriteInteger(Param + '.Charset', Value.Charset);
    Reg.WriteInteger(Param + '.Color', Value.Color);
    Reg.WriteInteger(Param + '.Height', Value.Height);
    Reg.WriteString(Param + '.Name', Value.Name);
    Reg.WriteInteger(Param + '.Orientation', Value.Orientation);
    Reg.WriteInteger(Param + '.Pitch', Ord(Value.Pitch));
    Reg.WriteInteger(Param + '.Size', Value.Size);
    Reg.WriteString(Param + '.Style', FontStyleAsString(Value.Style));
    result := true;
  except
  end;
end;

function DeleteRegParam(RootKey: HKEY; Key, Param: string): boolean;
var
  reg: TRegistry;

begin
  result := true;
  reg := TRegistry.Create(KEY_ALL_ACCESS);
  try
    reg.RootKey := RootKey;
    //reg.LazyWrite := false;
    if reg.OpenKey(Key, false) and reg.ValueExists(Param) then
    begin
      result := reg.DeleteValue(Param);
    end;
  except
    result := false;
  end;
  reg.CloseKey;
  reg.Free;
end;

function DeleteRegKey(RootKey: HKEY; Key: string): boolean;
var
  reg: TRegistry;

begin
  result := true;
  reg := TRegistry.Create(KEY_ALL_ACCESS);
  try
    reg.RootKey := RootKey;
    //reg.LazyWrite := false;
    if reg.KeyExists(Key) then result := reg.DeleteKey(Key)
    else result := true;
  except
    result := false;
  end;
  reg.CloseKey;
  reg.Free;
end;

procedure ReadRegKeys(RootKey: HKEY; Key: string; SL: TStringList);
var
  reg: TRegistry;

begin
  reg := TRegistry.Create(KEY_READ);
  reg.RootKey := RootKey;

  try
    if reg.OpenKey(Key, False) then reg.GetKeyNames(SL);
  except
  end;

  reg.CloseKey;
  reg.Free;
end;

procedure ReadRegValueNames(RootKey: HKEY; Key: string; SL: TStringList);
var
  reg: TRegistry;

begin
  reg := TRegistry.Create(KEY_READ);
  reg.RootKey := RootKey;

  try
    if reg.OpenKey(Key, False) then reg.GetValueNames(SL);
  except
  end;

  reg.CloseKey;
  reg.Free;
end;

procedure ClearRegKey(RootKey: HKEY; Key: string; DeleteSubKeys: boolean);
var
  reg: TRegistry;
  sl: TStringList;
  i: integer;

begin
  sl := TStringList.Create;
  reg := TRegistry.Create(KEY_ALL_ACCESS);
  reg.RootKey := RootKey;

  try
    if reg.OpenKey(Key, False) then
    begin
      reg.GetValueNames(sl);
      for i := 0 to sl.Count - 1 do
        if reg.ValueExists(sl.Strings[i]) then reg.DeleteValue(sl.Strings[i]);

      if DeleteSubKeys then
      begin
        sl.Clear;
        reg.GetKeyNames(sl);
        for i := 0 to sl.Count - 1 do
          if reg.KeyExists(sl.Strings[i]) then reg.DeleteKey(sl.Strings[i]);
      end;
    end;
  except
  end;

  reg.CloseKey;
  reg.Free;
  sl.Free;
end;

function RegistryRootKeyToString(RootKey: HKEY): string;
begin
  case RootKey of
    HKEY_CLASSES_ROOT: result := 'HKEY_CLASSES_ROOT';
    HKEY_CURRENT_USER: result := 'HKEY_CURRENT_USER';
    HKEY_LOCAL_MACHINE: result := 'HKEY_LOCAL_MACHINE';
    HKEY_USERS: result := 'HKEY_USERS';
    HKEY_PERFORMANCE_DATA: result := 'HKEY_PERFORMANCE_DATA';
    HKEY_CURRENT_CONFIG: result := 'HKEY_CURRENT_CONFIG';
    HKEY_DYN_DATA: result := 'HKEY_DYN_DATA';
    else result := '';
  end;
end;

function RegKeyExists(RootKey: HKEY; Key: string): boolean;
var
  reg: TRegistry;

begin
  reg := TRegistry.Create(KEY_READ);
  try
    reg.RootKey := RootKey;
    result := reg.KeyExists(Key);
  finally
    reg.Free;
  end;
end;

procedure RegMoveKey(RootKey: HKEY; OldKey, NewKey: string; Delete: boolean);
var
  reg: TRegistry;

begin
  reg := TRegistry.Create(KEY_ALL_ACCESS);
  try
    reg.RootKey := RootKey;
    if reg.KeyExists(OldKey) then reg.MoveKey(OldKey, NewKey, Delete);
  finally
    reg.Free;
  end;
end;

function CopyFile(SourceFile, DestFile: string; var ErrMsg: string): boolean;
var
  fsrc, fdest: TFileStream;
  //buff: array[0..1023] of byte;
  //rCount: integer;

begin
  result := False;
  if not FileExists(SourceFile) then
  begin
    ErrMsg := 'Не найден файл источник "' + SourceFile + '"!';
    exit;
  end;
  if not DirectoryExists(ExtractFileDir(DestFile)) then
  begin
    ErrMsg := 'Папка назначения "' + ExtractFileDir(DestFile) + '" не существует!';
    exit;
  end;

  try
    try
      fsrc := TFileStream.Create(SourceFile, fmOpenRead);
      if FileExists(DestFile) then
        fdest := TFileStream.Create(DestFile, fmOpenWrite)
      else
        fdest := TFileStream.Create(DestFile, fmCreate);

      fsrc.Seek(0, soFromBeginning);
      {while fsrc.Position < fsrc.Size do
      begin
        rCount := fsrc.Read(buff, SizeOf(buff));
        fdest.Write(buff, rCount);
      end;}
      fdest.CopyFrom(fsrc, fsrc.Size);
      result := fdest.Size = fsrc.Size;
    finally
      if Assigned(fsrc) then fsrc.Free;
      if Assigned(fdest) then fdest.Free;
    end;
  except
    on e: EAccessViolation do
    begin
      ErrMsg := SysErrorMessage(GetLastError);
      result := False;
    end;
    on e: Exception do
    begin
      ErrMsg := e.Message;
      result := False;
    end;
  end;
end;

function DeleteDir(Directory: string; var ErrMsg: string): boolean;
var
  sr: TSearchRec;
  si: integer;

begin
  result := true;
  ErrMsg := '';
  if not DirectoryExists(Directory) then exit;

  si := FindFirst(Directory + '\*', faAnyFile, sr);
  while si = 0 do
  begin
    if (sr.Name = '.') or (sr.Name = '..') then
    begin
      si := FindNext(sr);
      continue;
    end;
    if (sr.Attr and faDirectory) = faDirectory then
    begin
      result := DeleteDir(Directory + '\' + sr.Name, ErrMsg);
      if not result then break;
    end else
    begin
      SetFileAttributes(pchar(Directory + '\' + sr.Name), faArchive);
      result := DeleteFile(Directory + '\' + sr.Name);
      if not result then
      begin
        ErrMsg := SysErrorMessage(GetLastError);
        break;
      end;
    end;
    si := FindNext(sr);
  end;
  FindClose(sr);

  if not result then exit;
  result := RemoveDir(Directory);
  if not result then
    ErrMsg := SysErrorMessage(GetLastError);
end;

function ExtractWordEx(n: integer; s: string; WordDelims: TSysCharSet; IgnoreBlockChars: TSysCharSet): string;
var
  CurrBlChar: char;
  iblock: boolean;
  i: integer;
  wn: integer;

begin
  result := '';
  iblock := false;
  CurrBlChar := #0;
  wn := 1;

  for i := 1 to Length(s) do
  begin
    if (iblock) then
    begin
      if (s[i] = CurrBlChar) then
      begin
        iblock := false;
        CurrBlChar := #0;
      end;
      if (wn = n) then result := result + s[i];
      continue;
    end;
    if (s[i] in IgnoreBlockChars) then
    begin
      iblock := true;
      CurrBlChar := s[i];
      if (wn = n) then result := result + s[i];
      continue;
    end;
    if (s[i] in WordDelims) then
    begin
      Inc(wn);
      if (wn > n) then exit;
    end else
      if (wn = n) then result := result + s[i];
  end;
end;

function WordCountEx(s: string; WordDelims: TSysCharSet; IgnoreBlockChars: TSysCharSet): integer;
var
  CurrBlChar: char;
  iblock: boolean;
  i: integer;

begin
  if (s = '') then result := 0
  else result := 1;
  iblock := false;
  CurrBlChar := #0;

  for i := 1 to Length(s) do
  begin
    if (iblock) then
    begin
      if (s[i] = CurrBlChar) then
      begin
        iblock := false;
        CurrBlChar := #0;
      end;
      continue;
    end;
    if (s[i] in IgnoreBlockChars) then
    begin
      iblock := true;
      CurrBlChar := s[i];
      continue;
    end;
    if ((s[i] in WordDelims) and (i < Length(s))) then Inc(result);
  end;
end;

function GetFontStyle(style: string): TFontStyles;
var
  i: integer;
  s: string;

begin
  result := [];
  for i := 0 to WordCountEx(style, [','], []) do
  begin
    s := LowerCase(Trim(ExtractWordEx(i, style, [','], [])));
    if (s = 'fsbold') then result := result + [fsBold];
    if (s = 'fsitalic') then result := result + [fsItalic];
    if (s = 'fsunderline') then result := result + [fsUnderline];
    if (s = 'fsstrikeout') then result := result + [fsStrikeOut];
  end;
end;

function FontStyleAsString(fstyle: TFontStyles): string;
begin
  result := '';
  if (fsBold in fstyle) then
    if (result = '') then result := 'fsBold'
    else result := result + ',fsBold';
  if (fsItalic in fstyle) then
    if (result = '') then result := 'fsItalic'
    else result := result + ',fsItalic';
  if (fsUnderline in fstyle) then
    if (result = '') then result := 'fsUnderline'
    else result := result + ',fsUnderline';
  if (fsStrikeOut in fstyle) then
    if (result = '') then result := 'fsStrikeOut'
    else result := result + ',fsStrikeOut';
end;

function FloatToDBStr(value: double; FormatStr: string): string;
begin
  if FormatStr = '' then result := FloatToStr(value)
  else result := Format(FormatStr, [value]);
  result := StringReplace(result, ',', '.', [rfReplaceAll]);
end;

function VariantToDBStr(value: variant; QuotedString: boolean; EmptyStrToNull: boolean; ZeroToNull: boolean; QuoteSymb: char): string;
begin
  if VarIsNull(value) then result := 'null'
  else if VarIsFloat(value) then result := FloatToDBStr(value)
  else if VarIsNumeric(value) then result := VarToStr(value)
  else if QuotedString then result := QuoteSymb + VarToStr(value) + QuoteSymb
  else result := VarToStr(value);
  if ((result = '') or ((result = QuoteSymb + QuoteSymb) and QuotedString)) and EmptyStrToNull then result := 'null';
  if (VarIsFloat(value) or VarIsNumeric(value)) and (result = '0') and ZeroToNull then result := 'null';
end;

function ReplaceQuote(Str: string): string;
begin
  result := StringReplace(Str, '''', '''||ascii_char(39)||''', [rfReplaceAll]);
end;

function FormatNum(num: double): string; overload;
var
  idx: integer;
  fr: string;

begin
  result := Format('%.2f', [num]);
  fr := ExtractWordEx(2, result, [',', '.'], []);
  result := ExtractWordEx(1, result, [',', '.'], []);
  idx := Length(result) - 2;
  while (idx > 1) do
  begin
    Insert(' ', result, idx);
    idx := idx - 3;
  end;
  result := result + ',' + fr;
end;

function FormatNum(num: integer): string; overload;
var
  idx: integer;

begin
  result := IntToStr(num);
  idx := Length(result) - 2;
  while (idx > 1) do
  begin
    Insert(' ', result, idx);
    idx := idx - 3;
  end;
end;

function GenRandString(genrule, vlength: integer): string;
var
  i: integer;
  c: byte;
  symbs: set of byte;

begin
  result := '';
  symbs := [];
  if genrule > 6 then genrule := 6;

  case genrule of
    0: symbs := symbs + [48..57];                           //цифры 0..9
    1: symbs := symbs + [65..90, 97..122];                  //буквы A..Z, a..z
    2: symbs := symbs + [65..90];                           //буквы A..Z
    3: symbs := symbs + [97..122];                          //буквы a..z
    4: symbs := symbs + [48..57, 65..90];                   //цифры + буквы A..Z
    5: symbs := symbs + [48..57, 97..122];                  //цифры + буквы a..z
    6: symbs := symbs + [48..57, 65..90, 97..122];          //цифры + буквы A..Z, a..z
  end;
  if symbs = [] then exit;

  Randomize;
  for i := 1 to vlength do
  begin
    c := Random(123);
    while not (c in symbs) do c := Random(123);
    result := result + chr(c);
  end;
end;

function AnsiToDos(AnsiStr: string): string;
begin
  SetLength(result, Length(AnsiStr));
  AnsiToOem(pchar(AnsiStr), pchar(result));
end;

function TextToString(Text: string; Decorator: string; Delimiter: string): string;
var
  i: integer;
  f: boolean;

begin
  result := StringReplace(Text, #13#10, Delimiter, [rfReplaceAll]);
  if (result <> '') then
  begin
    if Pos(Delimiter, result) = 1 then
      result := StringReplace(result, Delimiter, '', []);

    f := false;
    for i := 1 to Length(Delimiter) do
      if result[Length(result) - Length(Delimiter) + i] <> Delimiter[i] then
      begin
        break;
        f := false;
      end else
        f := true;

    if f then Delete(result, Length(result) - Length(Delimiter) + 1, Length(Delimiter));

    if Decorator <> '' then
      result := Decorator + StringReplace(result, Delimiter, Decorator + Delimiter + Decorator, [rfReplaceAll]) + Decorator;
  end;
end;

function ArrayToString(arr: array of string; Decorator: string = ''; Delimiter: string = ','): string;
var
  i: integer;

begin
  result := '';

  for i := 0 to Length(arr) - 1 do
  begin
    if i = 0 then result := Decorator + arr[i] + Decorator
    else result := result + Delimiter + Decorator + arr[i] + Decorator;
  end;
end;

function SplitLongString(str: string; Delim: char; sz: integer): TStringList;
var
  i: integer;
  sb: string;
  avg_sz, c: integer;

begin
  result := TStringList.Create;
  c := WordCountEx(str, [Delim], []);
  avg_sz := Round(Length(str) / c);
  for i := 1 to c do
  begin
    if (Length(sb) + avg_sz) >= sz then
    begin
      result.Add(sb);
      sb := '';
    end;
    if sb = '' then sb := ExtractWordEx(i, str, [Delim], [])
    else sb := sb + Delim + ExtractWordEx(i, str, [Delim], []);
  end;
  if sb <> '' then result.Add(sb);
end;

procedure SplitPathByHost(var Path, Host: string);
var
  i: integer;

begin
  Host := '';
  if (Length(Path) >= 2) and (Path[1] = '\') and (Path[2] = '\') then
  begin
    for i := 3 to Length(Path) do
    begin
      if Path[i] = '\' then break;
      Host := Host + Path[i];
    end;

    Delete(Path, 1, Length(Host) + 2);
  end;
end;

function FindInArray(Arr: array of string; str: string): integer;
var
  i: integer;

begin
  result := -1;
  for i := 0 to Length(Arr) - 1 do
    if Arr[i] = str then
    begin
      result := i;
      break;
    end;
end;

function FindInStrings(Strings: TStringList; str: string; Opts: TFindOptions): integer;
var
  i: integer;
  s: string;

begin
  result := -1;
  if not (foMatchCase in Opts) then
    str := AnsiLowerCase(str);

  for i := 0 to Strings.Count - 1 do
  begin
    if foMatchCase in Opts then s := Strings.Strings[i]
    else s := AnsiLowerCase(Strings.Strings[i]);

    if (s = str) or ((foToExistence in Opts) and (Pos(str, s) > 0)) then
    begin
      result := i;
      break;
    end;
  end;
end;

function PyUnicodeToAnsi(UniStr: string): string;
var
  i, idx: integer;
  s: string;

begin
  result := '';

  i := 1;
  while i <= Length(UniStr) do
  begin
    if UniStr[i] = '\' then
    begin
      s := Copy(UniStr, i, 6);
      idx := FindInArray(UniCharTable, s);
      if idx = -1 then
      begin
        s := Copy(UniStr, i, 2);
        idx := FindInArray(UniCharTable, s);
      end;

      if idx = -1 then
      begin
        s := UniStr[i];
        result := result + UniStr[i];
      end else
        result := result + AnsiCharTable[idx];

      Inc(i, Length(s));
    end else
    begin
      result := result + UniStr[i];
      Inc(i);
    end;
  end;
end;

function PyAnsiToUnicode(AnsiStr: string): string;
var
  i: integer;

begin
  result := AnsiStr;
  for i := 0 to Length(AnsiCharTable) - 1 do
    result := StringReplace(result, AnsiCharTable[i], UniCharTable[i], [rfReplaceAll]);
end;

function NetCompConnect(Addr, Usr, Pass: string; CanClose: boolean; var Err: string): boolean;
var
  sl: TStringList;
  netCompName: string;
  netRes: TNetResourceA;
  tn: integer;

begin
  result := false;
  Err := '';

  if (Length(Addr) > 1) and (Addr[1] = '\') and (Addr[2] = '\') then
  begin
    sl := TStringList.Create;
    try
      sl.Text := StringReplace(Addr, '\', #13#10, [rfReplaceAll]);
      netCompName := '\\' + sl.Strings[2] + iif(sl.Count > 3, '\' + sl.Strings[3], '');
    finally
      sl.Free;
    end;
    //if Addr[Length(Addr)] = '\' then Delete(Addr, Length(Addr), 1);

    // коннектимся к машине
    if CanClose then
    begin
      WNetCancelConnection2(pchar(netCompName), 0, false);
      result := true;
    end else
    begin
      netRes.dwType := RESOURCETYPE_DISK;
      netRes.lpRemoteName := pchar(netCompName);
      tn := WNetAddConnection2(netRes, pchar(Pass), pchar(Usr), CONNECT_TEMPORARY);

      {if tn = 1219 then
      begin
        WNetCancelConnection2(pchar(netCompName), 0, false);
        tn := WNetAddConnection2(netRes, pchar(Pass), pchar(Usr), CONNECT_TEMPORARY);
      end; }

      result := (tn = NO_ERROR) or (tn = 1219);
      if not result then Err := SysErrorMessage(tn);
    end;
  end else
    Err := 'Неверный сетевой путь';
end;

function GenCaption(Prefix, Postfix, Pk, Descriptor, Title: string; ShowDescr: boolean): string;
var
  str: string;
  
begin
  result := '';
  str := iif(Pk = '', '', Pk + ' : ') + iif(ShowDescr, iif(Descriptor = '', '', Descriptor + ' : '), '') + iif(Title = '', '', Title);

  if Prefix = '' then result := str
  else begin
    if str = '' then result := Prefix
    else result := Prefix + ' - ' + str;
  end;

  if Postfix <> '' then
  begin
    if result = '' then result := Postfix
    else result := result + ' - ' + Postfix;
  end;
end;

function MillisecondsToTimeStr(ms: Cardinal): string;
var
  hh, mm, ss, sss: integer;

begin
  sss := ms div 1000;
  ss := (sss mod 3600) mod 60;
  mm := (sss mod 3600) div 60;
  hh := sss div 3600;
  result := Format('%2.2d:%2.2d:%2.2d', [hh, mm, ss]);
end;

function GetConfObjectTypeStr(ObjectType: TConfObjectType): string;
begin
  case ObjectType of
    cotFolder: result := 'Папка';
    cotDict: result := 'Справочник';
    cotForm: result := 'Форма';
    cotWizard: result := 'Сценарий';
    cotNone: result := 'Неизвестно';
    else result := '';
  end;
end;

procedure SplitFieldName(FieldName: string; var ObjName: string; var FldName: string);
begin
  ObjName := '';
  FldName := '';

  if WordCountEx(FieldName, ['.'], []) > 1 then
  begin
    if WordCountEx(FieldName, ['.'], []) = 2 then
    begin
      ObjName := ExtractWordEx(1, FieldName, ['.'], []);
      FldName := ExtractWordEx(2, FieldName, ['.'], []);
    end else
    begin
      ObjName := ExtractWordEx(1, FieldName, ['.'], []) + '.' + ExtractWordEx(2, FieldName, ['.'], []);
      FldName := ExtractWordEx(3, FieldName, ['.'], []);
    end;
  end else
    FldName := FieldName;
end;

function CompareStrings(StrWhere, StrWhat: string; Options: TFindOptions): boolean;
var
  s1, s2: string;
  i, j: integer;
  
begin
  result := false;

  if not (foMatchCase in Options) then
  begin
    StrWhere := AnsiLowerCase(StrWhere);
    StrWhat := AnsiLowerCase(StrWhat);
  end;

  if foToExistence in Options then
  begin
    // по вхождению
    StrWhere := StringReplace(StrWhere, #13#10, #4, [rfReplaceAll]);
    StrWhat := StringReplace(StrWhat, #13#10, #4, [rfReplaceAll]);
    if foAnyWord in Options then
    begin
      for i := 1 to WordCountEx(StrWhere, FIND_WORD_DELIMS, []) do
      begin
        s1 := ExtractWordEx(i, StrWhere, FIND_WORD_DELIMS, []);

        for j := 1 to WordCountEx(StrWhat, FIND_WORD_DELIMS, []) do
        begin
          s2 := ExtractWordEx(j, StrWhat, FIND_WORD_DELIMS, []);
          result := s1 = s2;
          if result then break;
        end;

        if result then break;
      end;
    end else if foAllWords in Options then
    begin
      for i := 1 to WordCountEx(StrWhat, FIND_WORD_DELIMS, []) do
      begin
        s1 := ExtractWordEx(i, StrWhat, FIND_WORD_DELIMS, []);

        for j := 1 to WordCountEx(StrWhere, FIND_WORD_DELIMS, []) do
        begin
          s2 := ExtractWordEx(j, StrWhere, FIND_WORD_DELIMS, []);
          result := (s1 = s2);
          if result then break;
        end;

        if not result then break;
      end;
    end else {if foWholeString in Options then} // эту опцию можно не указывать - и так понятно
      result := Pos(StrWhat, StrWhere) > 0;
  end else
    // полное совпадение
    result := StrWhere = StrWhat;
end;

procedure CopyToClipboard(str: string);
var
  Clip: TClipboard;
  kk: HKL;
  
begin
  if str = '' then exit;

  Clip := TClipboard.Create;
  try
    kk := GetKeyboardLayout(0);
    ActivateKeyboardLayout(LoadKeyboardLayout('00000419', KLF_ACTIVATE), 0);
    Clip.AsText := str;
    //Clip.SetTextBuf(pchar(str));
  finally
    ActivateKeyboardLayout(kk, 0);
    Clip.Free;
  end;
end;

procedure SafeFreeAndNil(Obj: TObject);
begin
  try
    if Assigned(Obj) then FreeAndNil(Obj);
  except
    Obj := nil;
  end;
end;

function FindInGrid(Grid: TDBGridEh; FindStr, FieldName: string; FindOptions: TFindOptions; AContinue: boolean = false;
  NoEndQuery: boolean = false): boolean;

  function _get_find_str(col: TColumnEh; field: TField): string;
  begin
    if (col.PickList.Count > 0) then
      result := col.PickList.Strings[col.KeyList.IndexOf(field.AsString)]
    else if field.Lookup then
    begin
      if field.LookupDataSet.Locate(field.LookupKeyFields, field.AsString, []) then
        result := field.LookupDataSet.FieldByName(field.LookupResultField).AsString;
    end else
      result := field.AsString;
  end;

var
  i: integer;
  asf: TDataSetNotifyEvent;
  inAll: boolean;
  bm: TBookmark;
  DataSet: TDataSet;
  Column: TColumnEh;

begin
  if FindStr = '' then
  begin
    Application.MessageBox('Нечего искать! Введите хотя бы 1 символ для поиска', 'Поиск', MB_OK + MB_ICONEXCLAMATION);
    exit;
  end;

  if (not Assigned(Grid)) or (not Assigned(Grid.DataSource)) or (not Assigned(Grid.DataSource.DataSet)) then
  begin
    Application.MessageBox('Негде искать! Не привязан источник данных для поиска', 'Поиск', MB_OK + MB_ICONEXCLAMATION);
    exit;
  end;

  result := false;
  DataSet := Grid.DataSource.DataSet;
  bm := DataSet.GetBookmark;
  asf := DataSet.AfterScroll;
  DataSet.AfterScroll := nil;
  DataSet.DisableControls;
  inAll := (FieldName = '*') or (FieldName = '');

  try
    // ищем от текущей позици курсора
    if AContinue then DataSet.Next;
    if DataSet.Eof then
    begin
      if NoEndQuery or (Application.MessageBox('Поиск завершен! Начать с начала?', 'Поиск', MB_YESNO + MB_ICONQUESTION) <> ID_YES) then exit;
      DataSet.First;
    end;

    if not inAll then
    begin
      Column := Grid.FindFieldColumn(FieldName);
      if not Assigned(Column) then
      begin
        Application.MessageBox('Ошибка! Не удалось найти поле для поиска', 'Поиск', MB_OK + MB_ICONERROR);
        exit;
      end;
    end;

    while not DataSet.Eof do
    begin
      if inAll then
      begin
        for i := 0 to Grid.Columns.Count - 1 do
        begin
          if not Assigned(DataSet.FieldByName(Grid.Columns.Items[i].FieldName)) then continue;
          result := CompareStrings(_get_find_str(Grid.Columns.Items[i], DataSet.FieldByName(Grid.Columns.Items[i].FieldName)), FindStr, FindOptions);
          if result then break;
        end;
      end else
        if Assigned(DataSet.FieldByName(Column.FieldName)) then
          result := CompareStrings(_get_find_str(Column, DataSet.FieldByName(Column.FieldName)), FindStr, FindOptions);

      if result then break;
      DataSet.Next;

      if DataSet.Eof then
      begin
        if NoEndQuery or (Application.MessageBox('Поиск завершен! Начать с начала?', 'Поиск', MB_YESNO + MB_ICONQUESTION) <> ID_YES) then exit;
        DataSet.First;
      end;
    end;
  finally
    if (not result) and DataSet.BookmarkValid(bm) then DataSet.GotoBookmark(bm);
    DataSet.AfterScroll := asf;
    DataSet.EnableControls;
    if Assigned(DataSet.AfterScroll) then DataSet.AfterScroll(DataSet);
  end;
end;

function SlCustomSort(List: TStringList; Index1, Index2: integer): integer;
var
  i1, i2 : integer;

begin
 i1 := StrToIntDef(List.Strings[Index1], 0);
 i2 := StrToIntDef(List.Strings[Index2], 0);
 result := i1 - i2;
end;

{ TGridParams }

procedure TGridParams.Assign(Source: TObject);
begin
  // Source - экземпляр TGridParams !!!
  if (not Assigned(Source)) or (not (Source is TGridParams)) then exit;

  Flat := TGridParams(Source).Flat;
  Font.Assign(TGridParams(Source).Font);
  RowColor := TGridParams(Source).RowColor;
  EvenRowColor := TGridParams(Source).EvenRowColor;
  NewRowColor := TGridParams(Source).NewRowColor;
  ChangedRowColor := TGridParams(Source).ChangedRowColor;
  RowAutoAlignment := TGridParams(Source).RowAutoAlignment;
  RowAlignment := TGridParams(Source).RowAlignment;
  RowLayout := TGridParams(Source).RowLayout;
  RowHeight := TGridParams(Source).RowHeight;
  RowLines := TGridParams(Source).RowLines;
  ColLines := TGridParams(Source).ColLines;
  ExtendVertLines := TGridParams(Source).ExtendVertLines;
  FrozenCols := TGridParams(Source).FrozenCols;
  TitleFont.Assign(TGridParams(Source).TitleFont);
  TitleColor := TGridParams(Source).TitleColor;
  TitleHeight := TGridParams(Source).TitleHeight;
  TitleAlignment := TGridParams(Source).TitleAlignment;
end;

procedure TGridParams.AssignTo(Grid: TDBGridEh);
var
  i: integer;
  
begin
  if not Assigned(Grid) then exit;
  Grid.Flat := Flat;
  Grid.Font.Assign(Font);
  Grid.Color := RowColor;
  Grid.EvenRowColor := EvenRowColor;
  Grid.RowHeight := RowHeight;
  if RowLines then Grid.Options := Grid.Options + [dgRowLines]
  else Grid.Options := Grid.Options - [dgRowLines];
  if ColLines then Grid.Options := Grid.Options + [dgColLines]
  else Grid.Options := Grid.Options - [dgColLines];
  if ExtendVertLines then Grid.OptionsEh := Grid.OptionsEh + [dghExtendVertLines]
  else Grid.OptionsEh := Grid.OptionsEh - [dghExtendVertLines];
  Grid.FrozenCols := FrozenCols;
  Grid.TitleFont.Assign(TitleFont);
  Grid.TitleHeight := TitleHeight;

  for i := 0 to Grid.Columns.Count - 1 do
  begin
    if not RowAutoAlignment then Grid.Columns.Items[i].Alignment := RowAlignment;
    Grid.Columns.Items[i].Layout := RowLayout;
    Grid.Columns.Items[i].Title.Color := TitleColor;
    Grid.Columns.Items[i].Title.Alignment := TitleAlignment;
  end;
end;

constructor TGridParams.Create;
begin
  inherited Create;
  Flat := false;
  Font := TFont.Create;
  RowColor := clWindow;
  EvenRowColor := clWindow;
  NewRowColor := RGB(255, 255, 190);
  ChangedRowColor := RGB(255, 210, 255);
  RowAutoAlignment := true;
  RowAlignment := taLeftJustify;
  RowLayout := tlTop;
  RowHeight := 0;
  RowLines := true;
  ColLines := true;
  ExtendVertLines := true;
  FrozenCols := 0;
  TitleFont := TFont.Create;
  TitleColor := clBtnFace;
  TitleHeight := 0;
  TitleAlignment := taLeftJustify;
end;

destructor TGridParams.Destroy;
begin
  Font.Free;
  TitleFont.Free;
  inherited Destroy;
end;

{ TNodeDictInfo }

procedure TNodeDictInfo.Assign(Source: TObject);
begin
  // Source - экземпляр TNodeDictInfo !!!
  if (not Assigned(Source)) or (not (Source is TNodeDictInfo)) then exit;

  PK := TNodeDictInfo(Source).PK;
  Descriptor := TNodeDictInfo(Source).Descriptor;
  Title := TNodeDictInfo(Source).Title;
  ParentDictPK := TNodeDictInfo(Source).ParentDictPK;
  FolderPK := TNodeDictInfo(Source).FolderPK;
  Login := TNodeDictInfo(Source).Login;
  ObjType := TNodeDictInfo(Source).ObjType;
  Guid := TNodeDictInfo(Source).Guid;
end;

function TNodeDictInfo.IsEqual(Source: TObject): boolean;
begin
  result := false;
  // Source - экземпляр TNodeDictInfo !!!
  if (not Assigned(Source)) or (not (Source is TNodeDictInfo)) then exit;

  result := (TNodeDictInfo(Source).ObjType = ObjType) and (TNodeDictInfo(Source).PK = PK) and
    (TNodeDictInfo(Source).Descriptor = Descriptor) and (TNodeDictInfo(Source).Title = Title) and
    (TNodeDictInfo(Source).ParentDictPK = ParentDictPK) and (TNodeDictInfo(Source).FolderPK = FolderPK) and
    (TNodeDictInfo(Source).Login = Login) and (TNodeDictInfo(Source).Guid = Guid);
end;

function BytesToStr(b: int64): string;
const
  GB = 1024 * 1024 * 1024;
  MB = 1024 * 1024;
  KB = 1024;

begin
  if b div GB > 0 then
    result := Format('%.2f Гб', [b / GB])
  else if b div MB > 0 then
     Result := Format('%.2f Мб', [b / MB])
   else if b div KB > 0 then
     Result := Format('%.2f Кб', [b / KB])
   else
     Result := IntToStr(b) + ' б';
end;

function CreateGuid(NoDash: boolean = false): string;
var
  ID: TGUID;

begin
  Result := '';
  if CoCreateGuid(ID) = S_OK then
    Result := StringReplace(StringReplace(GUIDToString(ID), '{', '', [rfReplaceAll]), '}', '', [rfReplaceAll]);

  if NoDash then result := StringReplace(result, '-', '', [rfReplaceAll]);
end;

end.
