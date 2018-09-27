unit json;

interface

uses
  Windows, SysUtils, Classes, Variants, StrUtils;

type
  TJsonDataType = (jdtDict, jdtList, jdtStr, jdtInt, jdtBool, jdtFloat, jdtDate, jdtNull);
  TJsonList = array of string;
  TJson = class;
  TJsonArray = array of TJson;

  TDictElem = record
    Key: string;
    Value: string;
  end;

  TDict = array of TDictElem;

  TJson = class
  private
    FParent: TJson;
    SourceString: string;
    FDataType: TJsonDataType;
    FKey: string;
    FIndex: integer;
    FValue: Variant;
    FKeys: TJsonList; // массив FKeys не соответсвует массиву FValues! Он просто для хранения списка ключей
    FValues: TJsonArray;
    FLevel: integer;
    function FindInArray(Arr: array of string; str: string): integer;
    function PyUnicodeToAnsi(UniStr: string): string;
    function PyAnsiToUnicode(AnsiStr: string): string;
    function IndexOfKey(_key: string): integer;
    function ObjectOfKey(_key: string): TJson;
    function ValuesToStr(Formatted: boolean; NoSpaces: boolean = false): string;
    function ExtractInternalStr(Source, Pattern: string): string;
    function SplitToDict(DictStr: string): TDict;
    function SplitToList(ListStr: string): TJsonList;
    function ExtractParam(n: integer; s: string): string;
    function ParamCount(s: string): integer;
    procedure DeleteKey(_Key: string);
    function GetIndent: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function Parent: TJson;
    procedure Assign(Source: TObject);
    procedure Load(JsonStr: string);
    function SaveToString(Formatted: boolean = false; NoSpaces: boolean = false): string;
    procedure LoadFromFile(FileName: string);
    procedure SaveToFile(FileName: string);
    function DataType: TJsonDataType;
    function Key: string;
    function Index: integer;
    function Value: Variant;
    function AsString: string;
    function AsInteger: integer;
    function AsFloat: Double;
    function AsDateTime: TDateTime;
    function AsBoolean: boolean;
    function ValueType(_Key: string): TJsonDataType; overload;
    function ValueType(_Index: integer): TJsonDataType; overload;
    function ValueOf(_Key: string): Variant; overload;
    function ValueOf(_Index: integer): Variant; overload;
    function AsObject(_Key: string): TJson; overload;
    function AsObject(_Index: integer): TJson; overload;
    function Keys: TJsonList;
    function Count: integer;
    function KeyCount: integer;
    function IsNull: boolean;
    function KeyExists(_Key: string): boolean;
    procedure SetValue(_value: Variant); overload;
    procedure SetValue(_type: TJsonDataType; _value: Variant); overload;
    function Add(_type: TJsonDataType; _value: Variant; _Key: string = ''): TJson;
    procedure Del(_Index: integer); overload;
    procedure Del(_Key: string); overload;
  end;

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

{ TJson }

function TJson.Add(_type: TJsonDataType; _value: Variant; _Key: string): TJson;
begin
  _Key := Trim(_Key);
  case FDataType of
    jdtNull, jdtStr, jdtInt, jdtBool, jdtFloat, jdtDate: raise Exception.Create('Данный узел не может содержать дочерние узлы!');
    jdtDict: if (_Key = '') then raise Exception.Create('Невозможно добавить узел к объекту Dict: не указан ключ!');
    jdtList: ;
  end;

  result := TJson.Create;
  result.FParent := Self;
  result.FDataType := _type;

  if FDataType = jdtDict then
  begin
    SetLength(FKeys, Length(FKeys) + 1);
    FKeys[High(FKeys)] := _Key;
    result.FKey := _Key;
  end;

  SetLength(FValues, Length(FValues) + 1);
  FValues[High(FValues)] := result;
  result.FIndex := High(FValues);
  result.FLevel := FLevel + 1;

  if _type in [jdtStr, jdtInt, jdtBool, jdtFloat, jdtDate] then result.SetValue(_value);
end;

function TJson.AsBoolean: boolean;
begin
  try
    result := FValue;
   // result := StrToBool(VarToStr(FValue));
  except
    result := false;
  end;
end;

function TJson.AsDateTime: TDateTime;
begin
  try
    result := VarToDateTime(FValue);
  except
    result := MinDateTime;
  end;
end;

function TJson.AsFloat: Double;
begin
  try
    result := FValue;
  except
    result := 0.0;
  end;
end;

function TJson.AsInteger: integer;
begin
  try
    result := FValue;
  except
    result := 0;
  end;
end;

function TJson.AsObject(_Index: integer): TJson;
begin
  result := nil;
  if (_Index > -1) and (_Index < Length(FValues)) then result := FValues[_Index]; 
end;

procedure TJson.Assign(Source: TObject);
var
  i: integer;
  
begin
  // Source - экземпляр TJson
  if (not Assigned(Source)) or (not (Source is TJson)) then exit;

  Clear;
  SourceString := TJson(Source).SourceString;
  FKey := TJson(Source).FKey;
  FIndex := TJson(Source).FIndex;
  FValue := TJson(Source).FValue;
  FDataType := TJson(Source).DataType;

  SetLength(FKeys, Length(TJson(Source).FKeys));
  for i := 0 to Length(TJson(Source).FKeys) - 1 do FKeys[i] := TJson(Source).FKeys[i];

  SetLength(FValues, TJson(Source).Count);
  for i := 0 to TJson(Source).Count - 1 do FValues[i].Assign(TJson(Source).FValues[i]);
end;

function TJson.AsString: string;
begin
  result := '';
  if not VarIsNull(FValue) then result := VarToStr(FValue);
  if FDataType = jdtBool then result := AnsiLowerCase(result);
  if FDataType = jdtFloat then result := StringReplace(result, ',', '.', []);
end;

function TJson.AsObject(_Key: string): TJson;
begin
  result := ObjectOfKey(_Key);
end;

procedure TJson.Clear;
var
  i: integer;

begin
  SourceString := '';
  FValue := Null;
  FDataType := jdtNull;
  SetLength(FKeys, 0);
  for i := 0 to Length(FValues) - 1 do FreeAndNil(FValues[i]);
  SetLength(FValues, 0);
end;

function TJson.Count: integer;
begin
  result := Length(FValues);
end;

constructor TJson.Create;
begin
  inherited Create;
  FIndex := -1;
  FKey := '';
  FLevel := 0;
  Clear;
end;

function TJson.DataType: TJsonDataType;
begin
  result := FDataType;
end;

procedure TJson.Del(_Index: integer);
var
  i: integer;
  k: string;
  
begin
  if (_Index < 0) or (_Index >= Length(FValues)) then exit;

  // удаление элемента
  k := FValues[_Index].FKey;
  FValues[_Index].Free;
  for i := _Index + 1 to Length(FValues) - 1 do
    FValues[i-1] := FValues[i];

  SetLength(FValues, Length(FValues) - 1);

  // если есть ключ - удалить и его
  if KeyExists(k) then DeleteKey(k);
end;

procedure TJson.Del(_Key: string);
var
  i, n: integer;

begin
  if not KeyExists(_Key) then exit;

  // сначала удалить элемент
  n := IndexOfKey(_Key);

  FValues[n].Free;
  for i := n + 1 to Length(FValues) - 1 do
    FValues[i-1] := FValues[i];

  SetLength(FValues, Length(FValues) - 1);

  // теперь удалить ключ из списка
  DeleteKey(_Key);
end;

procedure TJson.DeleteKey(_Key: string);
var
  i, j: integer;

begin
  for i := 0 to Length(FKeys) - 1 do
    if AnsiLowerCase(FKeys[i]) = AnsiLowerCase(_Key) then
    begin
      for j := i + 1 to Length(FKeys) - 1 do FKeys[j-1] := FKey[j];
      break;
    end;

  SetLength(FKeys, Length(FKeys) - 1);
end;

destructor TJson.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TJson.ExtractInternalStr(Source, Pattern: string): string;
var
  s, e: string;
  
begin
  result := Trim(Source);
  s := Pattern;
  
  if s = '{' then e := '}'
  else if s = '[' then e := ']'
  else if s = '(' then e := ')'
  else e := s;
  
  if (Length(result) > 0) and (result[1] = s) then Delete(result, 1, 1);
  if (Length(result) > 0) and (result[Length(result)] = e) then Delete(result, Length(result), 1);
end;

function TJson.ExtractParam(n: integer; s: string): string;
var
  BlockList: TStringList;
  i, j: integer;
  wn: integer;
  skipNext: boolean;

begin
  result := '';
  wn := 1;
  skipNext := false;
  BlockList := TStringList.Create;

  try
    for i := 1 to Length(s) do
    begin
      if skipNext then
      begin
        skipNext := false;
        if (wn = n) then result := result + s[i];
        continue;
      end;

      if s[i] = '\' then
      begin
        skipNext := true;
        if (wn = n) then result := result + s[i];
        continue;
      end;

      if (s[i] = '"') then
      begin
        if (BlockList.Count > 0) and (BlockList.Strings[BlockList.Count-1] = '"') then
          BlockList.Delete(BlockList.Count-1)
        else
          BlockList.Add(s[i]);

        if (wn = n) then result := result + s[i];
        continue;
      end;

      if (s[i] in ['{', '[']) then
      begin
        BlockList.Add(s[i]);
        if (wn = n) then result := result + s[i];
        continue;
      end;

      if (s[i] in ['}', ']']) then
      begin
        for j := BlockList.Count - 1 downto 0 do
          if ((s[i] = '}') and (BlockList[j] = '{')) or ((s[i] = ']') and (BlockList[j] = '[')) then
          begin
            BlockList.Delete(j);
            break;
          end;

        if (wn = n) then result := result + s[i];
        continue;
      end;

      if (BlockList.Count = 0) and (s[i] = ',') then
      begin
        Inc(wn);
        if (wn > n) then exit;
      end else
        if (wn = n) then result := result + s[i];
    end;
  finally
    BlockList.Free;
    //result := StringReplace(result, #4, '\"', [rfReplaceAll]);
  end;
end;

function TJson.FindInArray(Arr: array of string; str: string): integer;
var
  i: integer;

begin
  result := -1;
  for i := 0 to Length(Arr) - 1 do
    if AnsiLowerCase(Arr[i]) = AnsiLowerCase(str) then
    begin
      result := i;
      break;
    end;
end;

function TJson.GetIndent: string;
var
  i: integer;
  
begin
  result := '';
  for i := 0 to FLevel do result := result + '  ';
end;

function TJson.Index: integer;
begin
  result := FIndex;
end;

function TJson.IndexOfKey(_key: string): integer;
var
  i: integer;

begin
  result := -1;
  if _key = '' then exit;
  
  for i := 0 to Length(FValues) - 1 do
    if AnsiLowerCase(FValues[i].Key) = AnsiLowerCase(_key) then
    begin
      result := i;
      break;
    end;
end;

function TJson.IsNull: boolean;
begin
  result := FDataType = jdtNull;
end;

function TJson.Key: string;
begin
  result := FKey;
end;

function TJson.KeyCount: integer;
begin
  result := Length(FKeys);
end;

function TJson.KeyExists(_Key: string): boolean;
begin
  result := IndexOfKey(_Key) > -1;
end;

function TJson.Keys: TJsonList;
begin
  result := FKeys;
end;

procedure TJson.Load(JsonStr: string);
var
  d: TDict;
  l: TJsonList;
  i: integer;
  
begin
  Clear;

  SourceString := Trim(JsonStr);
  if SourceString = '' then exit;

  if SourceString[1] = '{' then FDataType := jdtDict
  else if SourceString[1] = '[' then FDataType := jdtList
  else if SourceString[1] = '"' then FDataType := jdtStr
  else if (AnsiLowerCase(SourceString) = 'true') or (AnsiLowerCase(SourceString) = 'false') then FDataType := jdtBool
  else if AnsiLowerCase(SourceString) = 'null' then FDataType := jdtNull
  else begin
    try
      FValue := StrToInt(SourceString);
      FDataType := jdtInt;
    except
      try
        FValue := StrToFloat(StringReplace(SourceString, '.', ',', []));
        FDataType := jdtFloat;
      except
        // ничего не делаем - объект остается пустым
        exit;
      end;
    end;
  end;

  case FDataType of
    jdtNull: ;
    jdtDict:
    begin
      d := SplitToDict(ExtractInternalStr(SourceString, '{'));
      SetLength(FKeys, Length(d));
      SetLength(FValues, Length(d));
      for i := 0 to Length(d) - 1 do
      begin
        FKeys[i] := ExtractInternalStr(d[i].Key, '"');
        FValues[i] := TJson.Create;
        FValues[i].FParent := Self;
        FValues[i].FKey := FKeys[i];
        FValues[i].FIndex := i;
        FValues[i].FLevel := FLevel + 1;
        FValues[i].Load(d[i].Value);
      end;
      SetLength(d, 0);
    end;
    jdtList:
    begin
      l := SplitToList(ExtractInternalStr(SourceString, '['));
      SetLength(FValues, Length(l));
      for i := 0 to Length(l) - 1 do
      begin
        FValues[i] := TJson.Create;
        FValues[i].FParent := Self;
        FValues[i].FIndex := i;
        FValues[i].FLevel := FLevel + 1;
        FValues[i].Load(l[i]);
      end;
      SetLength(l, 0);
    end;
    jdtStr: FValue := PyUnicodeToAnsi(ExtractInternalStr(SourceString, '"'));
    jdtInt, jdtFloat: ; // уже установлено
    jdtBool:
      if (AnsiLowerCase(SourceString) = 'true') then FValue := true
      else FValue := false;
    jdtDate: ; // этот тип автоматом не определяется
  end;
end;

procedure TJson.LoadFromFile(FileName: string);
var
  sl: TStringList;
  
begin
  sl := TStringList.Create;
  try
    sl.LoadFromFile(FileName);
    Load(sl.Text);
  finally
    sl.Free;
  end;
end;

function TJson.ObjectOfKey(_key: string): TJson;
var
  idx: integer;

begin
  result := nil;
  idx := IndexOfKey(_Key);
  if idx > -1 then result := FValues[idx];
end;

function TJson.PyAnsiToUnicode(AnsiStr: string): string;
var
  i: integer;

begin
  result := AnsiStr;
  for i := 0 to Length(AnsiCharTable) - 1 do
    result := StringReplace(result, AnsiCharTable[i], UniCharTable[i], [rfReplaceAll]);
end;

function TJson.PyUnicodeToAnsi(UniStr: string): string;
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

procedure TJson.SaveToFile(FileName: string);
var
  sl: TStringList;
  
begin
  sl := TStringList.Create;
  try
    sl.Text := SaveToString;
    sl.SaveToFile(FileName);
  finally
    sl.Free;
  end;
end;

function TJson.SaveToString(Formatted: boolean; NoSpaces: boolean): string;
var
  ind1, ind2: string;

begin
  result := '';
  if FKey <> '' then
  begin
    result := '"' + FKey + '":';
    if not NoSpaces then result := result + ' ';
  end;

  ind2 := '';
  if Formatted then ind1 := GetIndent
  else ind1 := '';

  if ind1 <> '' then
  begin
    ind2 := Copy(ind1, 1, Length(ind1) - 2);
    ind1 := #13#10 + ind1;
    ind2 := #13#10 + ind2;
  end;
  
  case FDataType of
    jdtNull: result := result + 'null';
    jdtDict: result := result + '{' + ind1 + ValuesToStr(Formatted, NoSpaces) + ind2 + '}';
    jdtList: result := result + '[' + ind1 + ValuesToStr(Formatted, NoSpaces) + ind2 + ']';
    jdtStr: result := result + '"' + PyAnsiToUnicode(AsString) + '"';
    jdtInt, jdtBool, jdtFloat, jdtDate: result := result + AsString;
  end;
end;

procedure TJson.SetValue(_type: TJsonDataType; _value: Variant);
begin
  if FDataType in [jdtDict, jdtList] then
    raise Exception.Create('Тип элемента "Dict" и "List" не может содержать простое значеие!');

  FDataType := _type;
  if VarIsNull(_value) and (_type <> jdtNull) then FDataType := jdtNull;
  FValue := _value;
end;

procedure TJson.SetValue(_value: Variant);
begin
  if FDataType in [jdtDict, jdtList] then
    raise Exception.Create('Тип элемента "Dict" и "List" не может содержать простое значеие!');

  FValue := _value;
end;

function TJson.SplitToDict(DictStr: string): TDict;
var
  i, q: integer;
  str: string;

begin
  SetLength(result, 0);
  DictStr := Trim(DictStr);

  for i := 1 to ParamCount(DictStr) do
  begin
    str := ExtractParam(i, DictStr);
    q := Pos(':', str);
    SetLength(result, Length(result) + 1);
    result[High(result)].Key := Trim(Copy(str, 1, q-1));
    result[High(result)].Value := Trim(Copy(str, q+1, Length(str)));
  end;
end;

function TJson.SplitToList(ListStr: string): TJsonList;
var
  i: integer;

begin
  SetLength(result, 0);
  ListStr := Trim(ListStr);

  for i := 1 to ParamCount(ListStr) do
  begin
    SetLength(result, Length(result) + 1);
    result[High(result)] := Trim(ExtractParam(i, ListStr));
  end;
end;

function TJson.ValueOf(_Key: string): Variant;
var
  obj: TJson;

begin
  result := Null;
  obj := ObjectOfKey(_Key);
  if Assigned(obj) then result := obj.Value;
end;

function TJson.Value: Variant;
begin
  result := FValue;
end;

function TJson.ValueOf(_Index: integer): Variant;
begin
  result := Null;
  if (_Index > -1) and (_Index < Length(FValues)) then result := FValues[_Index].Value;
end;

function TJson.ValuesToStr(Formatted: boolean; NoSpaces: boolean): string;
var
  i: integer;
  ind: string;
  
begin
  result := '';
  if NoSpaces then ind := ''
  else ind := ' ';

  if Formatted then
  begin
    ind := GetIndent;
    if ind <> '' then ind := #13#10 + ind;
  end;

  for i := 0 to Length(FValues) - 1 do
  begin
    if result = '' then result := FValues[i].SaveToString(Formatted, NoSpaces)
    else result := result + ',' + ind + FValues[i].SaveToString(Formatted, NoSpaces);
  end;
end;

function TJson.ValueType(_Key: string): TJsonDataType;
var
  obj: TJson;

begin
  result := jdtNull;
  obj := ObjectOfKey(_Key);
  if Assigned(obj) then result := obj.DataType;
end;

function TJson.ValueType(_Index: integer): TJsonDataType;
begin
  result := jdtNull;
  if (_Index > -1) and (_Index < Length(FValues)) then result := FValues[_Index].DataType;
end;

function TJson.ParamCount(s: string): integer;
var
  BlockList: TStringList;
  i, j: integer;
  skipNext: boolean;

begin
  if (s = '') then result := 0
  else result := 1;
  skipNext := false;
  BlockList := TStringList.Create;

  try
    for i := 1 to Length(s) do
    begin
      if skipNext then
      begin
        skipNext := false;
        continue;
      end;

      if s[i] = '\' then
      begin
        skipNext := true;
        continue;
      end;

      if (s[i] = '"') then
      begin
        if (BlockList.Count > 0) and (BlockList.Strings[BlockList.Count-1] = '"') then
          BlockList.Delete(BlockList.Count-1)
        else
          BlockList.Add(s[i]);
      end;

      if (s[i] in ['{', '[']) then BlockList.Add(s[i]);

      if (s[i] in ['}', ']']) then
      begin
        for j := BlockList.Count - 1 downto 0 do
          if ((s[i] = '}') and (BlockList[j] = '{')) or ((s[i] = ']') and (BlockList[j] = '[')) then
          begin
            BlockList.Delete(j);
            break;
          end;
      end;

      if (BlockList.Count = 0) and ((s[i] = ',') and (i < Length(s))) then Inc(result);
    end;
  finally
    BlockList.Free;
  end;
end;

function TJson.Parent: TJson;
begin
  result := FParent;
end;

end.
