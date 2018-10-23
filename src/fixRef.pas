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
  if Application.MessageBox('��������� ��������� ����� ����������! ����������?', '��������������', MB_YESNO + MB_ICONWARNING) <> ID_YES then exit;
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
  ht = 'I. ����������� ����������� Oracle'#13#10 +
    '  � ��������� ������ � ������ �������� �� ����������� ��� ����� (����� ������������ �� �������):'#13#10 +
    '  1. � ������ �������� �� �����������.'#13#10 +
    '  2. � ����� "ID ����", "Parent_ID ����", "�����������".'#13#10 +
    '  3. � ����� ����������.'#13#10 +
    '  4. � Lookup-����� ������� ������� � �� Oracle.'#13#10 +
    '  5. � �������� ����.'#13#10 +
    '  6. � �������� - � ����� "��������� ����������" � "��������� ��� ������� �������� ����� �������".'#13#10 +
    #13#10 +
    'II. ����������� ������ � ������������'#13#10 +
    '  1. ������� �������� ������� �� �� �������� �������, ���� ���������� �� ����� �������� � ������������� �����������.'#13#10 +
    '  2. �� ����������� ��������� ������� ��, ������� ��� � ���� ������ (�������� ����� ������� � ����).'#13#10 +
    '  3. �� ����������� ��������� ����, ������� ��� � ��� �������� � ���� ������.'#13#10 +
    '  4. �� ����������� ��������� ����, ������ �� ��������� � �������� �� �����������.'#13#10 +
    '  5. �� ����� ����������, �����������, ID � Parent_ID ����� ������� ��� ����� ��������� ����.';

begin
  Application.MessageBox(pchar(ht), '�������� �������� �����������', MB_OK + MB_ICONINFORMATION);
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
