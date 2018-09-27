unit fixRef;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFFixReference = class(TForm)
    GroupBox1: TGroupBox;
    chbOracle: TCheckBox;
    chbObjects: TCheckBox;
    chbFields: TCheckBox;
    chbNoLinkFields: TCheckBox;
    mLog: TMemo;
    btnExec: TBitBtn;
    btnClose: TBitBtn;
    Label1: TLabel;
    btnHelp: TButton;
    chbUnlinkObject: TCheckBox;
    btnTest: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
  private
    OraEnabled: boolean;
    procedure SetDisabled(Value: boolean);
  public
    Disabled: boolean;
    procedure AddToLog(Str: string);
  end;

implementation

{$R *.dfm}

uses editDict;

procedure TFFixReference.AddToLog(Str: string);
begin
  if (Str = '') and (mLog.Text = '') then exit;
  mLog.Lines.Add(Str);
  Application.ProcessMessages;
end;

procedure TFFixReference.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFFixReference.btnExecClick(Sender: TObject);
begin
  if Application.MessageBox('Сделанные изменения будут необратимы! Продолжить?', 'Предупреждение', MB_YESNO + MB_ICONWARNING) <> ID_YES then exit;
  try
    SetDisabled(true);
    mLog.Clear;
    TFEditDict(Owner).ExecFix(Self);
  finally
    SetDisabled(false);
  end;
end;

procedure TFFixReference.btnHelpClick(Sender: TObject);
const
  ht = 'I. Исправления справочника Oracle'#13#10 +
    '  В следующих местах к именам объектов БД добавляется имя схемы (схема определяется по объекту):'#13#10 +
    '  1. К именам объектов БД справочника.'#13#10 +
    '  2. В полях "ID Поле", "Parent_ID Поле", "Группировка".'#13#10 +
    '  3. В полях сортировки.'#13#10 +
    '  4. В Lookup-полях которые смотрят в БД Oracle.'#13#10 +
    '  5. В шаблонах прав.'#13#10 +
    '  6. В графиках - в полях "Выражение сортировки" и "Выражение для подписи ключевых точек графика".'#13#10 +
    #13#10 +
    'II. Исправления ошибок в конфигурации'#13#10 +
    '  1. Отвязка главного объекта БД от внешнего объекта, если справочник не имеет привязки к родительскому справочнику.'#13#10 +
    '  2. Из справочника удаляются объекты БД, которых нет в базе данных (каскадно будут удалены и поля).'#13#10 +
    '  3. Из справочника удаляются поля, которых нет у его объектов в базе данных.'#13#10 +
    '  4. Из справочника удаляются поля, которе не привязаны к объектам БД справочника.'#13#10 +
    '  5. Из полей сортировки, группировки, ID и Parent_ID будут удалены все ранее удаленные поля.';

begin
  Application.MessageBox(pchar(ht), 'Описание процесса исправления', MB_OK + MB_ICONINFORMATION);
end;

procedure TFFixReference.btnTestClick(Sender: TObject);
begin
  try
    SetDisabled(true);
    mLog.Clear;
    TFEditDict(Owner).ExecFix(Self, true);
  finally
    SetDisabled(false);
  end;
end;

procedure TFFixReference.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Disabled then Action := caNone
  else Action := caFree;
end;

procedure TFFixReference.FormCreate(Sender: TObject);
begin
  Disabled := false;
end;

procedure TFFixReference.SetDisabled(Value: boolean);
begin
  Disabled := Value;
  if Disabled then
  begin
    OraEnabled := chbOracle.Enabled;
    chbOracle.Enabled := false;
  end else
    chbOracle.Enabled := OraEnabled;

  chbUnlinkObject.Enabled := not Disabled;
  chbObjects.Enabled := not Disabled;
  chbFields.Enabled := not Disabled;
  chbNoLinkFields.Enabled := not Disabled;
  btnExec.Enabled := not Disabled;
  btnClose.Enabled := not Disabled;
  btnHelp.Enabled := not Disabled;
  btnTest.Enabled := not Disabled;
end;

end.
