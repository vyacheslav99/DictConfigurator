unit MD5Utils;

interface

uses Classes, SysUtils, MD5;

type
  TMD5Util = class
  private
    MD5Digest: TMD5Digest;
    MD5Context: TMD5Context;
    fInited: Boolean;
    fResult: string;
  public
    procedure NewString;
    procedure AddString(const aStr: string);
    procedure AddBuffer(aBuf: Pointer; aLen: Integer);
    function  GetResult: string;
    procedure AfterConstruction; override;
  end;

  // Считает контрольную сумму файла
  function CalcFileCheckSum(const aHandle: Integer; aSize: Integer; const aControlStr: string): string; overload;
  function CalcFileCheckSum(const aFileName, aControlStr: string): string; overload;
  // Дописываем контрольную сумму в конец файла
  function FileWriteCheckSum(const aHandle: Integer): string;
  // Проверяем контрольную сумму
  function FileCheckSumControl(const aHandle: Integer): Boolean;

const
  // используется только в dailymd/impstatmd
  cSecureMD5 = '-=+SeCuRiTyMaKeWeIgHt+=-';

implementation

const
  cErrorMsg = 'Функция вычисления суммы MD5 %s инициализирована.';
  cCheckSumLength = 32;
  cFileBlockSize = $400; //1'048'576

procedure TMD5Util.AfterConstruction;
begin
  fInited := False;
  fResult := EmptyStr;
end;

procedure TMD5Util.NewString;
var
  i: Integer;
begin
  if fInited then
    raise Exception.CreateFmt(cErrorMsg, ['уже']);
  for i := 0 to 15 do Byte(MD5Digest[i]) := i + 1;
  MD5Init(MD5Context);
  fInited := True;
end;

procedure TMD5Util.AddBuffer(aBuf: Pointer; aLen: Integer);
begin
  if not fInited then
    raise Exception.CreateFmt(cErrorMsg, ['не']);
  MD5UpdateBuffer(MD5Context, aBuf, aLen);
end;

procedure TMD5Util.AddString(const aStr: string);
begin
  if aStr <> '' then AddBuffer(PChar(aStr), Length(aStr));
end;

function TMD5Util.GetResult: string;
var
  i: Integer;
begin
  if fInited then begin
    MD5Final(MD5Digest, MD5Context);
    fResult := '';
    for i := 0 to 15 do fResult := fResult + IntToHex(Byte(MD5Digest[i]), 2);
    fInited := False;
  end;
  Result := fResult;
end;

function CalcFileCheckSum(const aHandle: Integer; aSize: Integer; const aControlStr: string): string;
var
  pp: Integer;
  pBuf: Pointer;
  md5: TMD5Util;
begin
  Result := '';
  if aHandle = 0 then Exit;
  GetMem(pBuf, cFileBlockSize);
  try
    md5 := TMD5Util.Create;
    try
      md5.NewString;
      FileSeek(aHandle, 0, soFromBeginning);
      while aSize > 0 do begin
        if aSize >= cFileBlockSize
          then pp := cFileBlockSize
          else pp := aSize;
        aSize := aSize - pp;
        FileRead(aHandle, pBuf^, pp);
        md5.AddBuffer(pBuf, pp);
      end;
      md5.AddString(aControlStr);
      Result := md5.GetResult;
    finally
      md5.Free;
    end;
  finally
    FreeMem(pBuf);
  end;
end;

function CalcFileCheckSum(const aFileName, aControlStr: string): string;
var
  sz: Integer;
begin
  if aFileName = '' then
    Result := StrMD5(aControlStr)
  else
    with TFileStream.Create(aFileName, fmOpenRead, fmShareDenyNone) do
      try
        sz := FileSeek(Handle, 0, soFromEnd);
        Result := CalcFileCheckSum(Handle, sz, aControlStr);
      finally
        Free();
      end;
end;

function FileWriteCheckSum(const aHandle: Integer): string;
var
  FileSize: Integer;
begin
  Result := '';
  if aHandle = 0 then Exit;
  FileSize := FileSeek(aHandle, 0, soFromEnd);
  Result := CalcFileCheckSum(aHandle, FileSize, '');
  if Result <> '' then FileWrite(aHandle, Result[1], cCheckSumLength);
end;

function FileCheckSumControl(const aHandle: Integer): Boolean;
var
  FileSize: Integer;
  ss: string;
  FChar: Char;
  n: Integer;
begin
  Result := False;
  if aHandle = 0 then Exit;
  FileSize := FileSeek(aHandle, 0, soFromEnd);
  if FileSize <= cCheckSumLength then Exit;
  { переместимся на первый печатный символ }
  n := 0;
  FileSeek(aHandle, -1, soFromEnd);
  FileRead(aHandle, FChar, 1);
  while Ord(FChar) <= 32 do begin
    Inc(n);
    { дошли до начала файла }
    if n > FileSize then begin
      Result := False;
      Exit;
    end;
    FileSeek(aHandle, -(1 + n), soFromEnd);
    FileRead(aHandle, FChar, 1);
  end;
  FileSize := FileSeek(aHandle, -(cCheckSumLength + n), soFromEnd);
  SetLength(ss, cCheckSumLength);
  FileRead(aHandle, ss[1], cCheckSumLength);
  Result := not LongBool(CompareText(ss, CalcFileCheckSum(aHandle, FileSize, '')));
end;

end.

