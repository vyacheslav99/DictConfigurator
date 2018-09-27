// юнит обертка для различных алгоритмов шифрования данных

unit CryptUtils;

interface

uses
  SysUtils, Classes, {DES, RC6,} MD5, MD5Utils, AES;

// дополнительные методы
function StrToBytesS(s: string; HEX: boolean; Delim: char = #0): string;
function BytesSToStr(sBytes: string; HEX: boolean; Delim: char = #0): string;

//AES шифрование
procedure EncAESStream(Dest, Source: TStream; Key: string; KeySizeMode: byte);
procedure DecAESStream(Dest, Source: TStream; Key: string; KeySizeMode: byte);
function EncAES(Source, Key: string; KeySizeMode: byte): string;
function DecAES(Source, Key: string; KeySizeMode: byte): string;

// MD5
function GetMD5Hash(Buffer: Pointer; BufSize: Integer): string;
function GetMD5HashStr(Buffer: String): string;
function GetFileCheckSum(FileName: string): string;

implementation

const
  HEXDIGIT = 2;

function StrToBytesS(s: string; HEX: boolean; Delim: char): string;
var
  i: integer;
  b: byte;

begin
  result := '';
  if s = '' then exit;
  for i := 1 to Length(s) do
  begin
    b := Ord(s[i]);
    if HEX then
      if Delim = #0 then
        result := result + IntToHex(b, HEXDIGIT)
      else
        result := result + Delim + IntToHex(b, HEXDIGIT)
    else
      result := result + Delim + IntToStr(b);
  end;
end;

function BytesSToStr(sBytes: string; HEX: boolean; Delim: char): string;
var
  i: integer;
  s: string;

begin
  result := '';
  if sBytes = '' then exit;
  s := '';
  if HEX and (Delim = #0) then
  begin
    try
      i := 1;
      while i < Length(sBytes) do
      begin
        result := result + Chr(StrToInt('$' + Copy(sBytes, i, HEXDIGIT)));
        Inc(i, HEXDIGIT);
      end;
    except
      result := '';
    end;
  end else
  begin
    for i := 1 to Length(sBytes) do
    try
      if sBytes[i] = Delim then
      begin
        if s <> '' then
        begin
          if HEX then
            result := result + Chr(StrToInt('$' + s))
          else
            result := result + Chr(StrToInt(s));
          s := '';
        end;
        continue;
      end;
      s := s + sBytes[i];
    except
      result := '';
      exit;
    end;
    if s <> '' then
    try
      if HEX then
        result := result + Chr(StrToInt('$' + s))
      else
        result := result + Chr(StrToInt(s));
    except
      result := '';
    end;
  end;
end;

procedure EncAESStream(Dest, Source: TStream; Key: string; KeySizeMode: byte);
begin
  EncryptAESStream(Dest, Source, Key, TAESKeySize(KeySizeMode));
end;

procedure DecAESStream(Dest, Source: TStream; Key: string; KeySizeMode: byte);
begin
  DecryptAESStream(Dest, Source, Key, TAESKeySize(KeySizeMode));
end;

function EncAES(Source, Key: string; KeySizeMode: byte): string;
begin
  result := EncryptAES(Source, Key, TAESKeySize(KeySizeMode));
end;

function DecAES(Source, Key: string; KeySizeMode: byte): string;
begin
  result := DecryptAES(Source, Key, TAESKeySize(KeySizeMode));
end;

// MD5
function GetMD5Hash(Buffer: Pointer; BufSize: Integer): string;
begin
  result := GetMD5(Buffer, BufSize);
end;

function GetMD5HashStr(Buffer : String): string;
begin
  result := StrMD5(Buffer);
end;

function GetFileCheckSum(FileName: string): string;
begin
  result := CalcFileCheckSum(FileName, '');
end;

end.
