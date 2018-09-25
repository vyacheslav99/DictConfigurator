unit find;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, StrUtils, ExtCtrls;

type
  TFindDialog = class(TForm)
    cbFindText: TComboBox;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    chbMatchCase: TCheckBox;
    chbToExistence: TCheckBox;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    Panel1: TPanel;
    rbAnyWord: TRadioButton;
    rbAllWords: TRadioButton;
    rbWholeString: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cbFindTextKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chbToExistenceClick(Sender: TObject);
  private
    fok: boolean;
    procedure UpdateFindHistory;
  public
  end;

var
  FindDialog: TFindDialog;

implementation

{$R *.dfm}

{ TFindDialog }

procedure TFindDialog.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFindDialog.btnOKClick(Sender: TObject);
begin
  fok := true;
  UpdateFindHistory;
  Close;
end;

procedure TFindDialog.cbFindTextKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then btnOKClick(Self);
  if Key = VK_ESCAPE then btnCancelClick(Self);
end;

procedure TFindDialog.chbToExistenceClick(Sender: TObject);
begin
  rbWholeString.Enabled := chbToExistence.Checked;
  rbAnyWord.Enabled := chbToExistence.Checked;
  rbAllWords.Enabled := chbToExistence.Checked;
end;

procedure TFindDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
  if fok then ModalResult := mrOk;
end;

procedure TFindDialog.FormCreate(Sender: TObject);
begin
  cbFindText.Style := csSimple;
end;

procedure TFindDialog.FormShow(Sender: TObject);
begin
  fok := false;
  chbToExistenceClick(chbToExistence);

  if cbFindText.Items.Count > 0 then
    cbFindText.Style := csDropDown
  else
    cbFindText.Style := csSimple;

  try
    cbFindText.SetFocus;
  except
  end;
end;

procedure TFindDialog.UpdateFindHistory;
var
  i: integer;
  str: string;
  exist: boolean;

begin
  exist := false;
  str := Trim(cbFindText.Text);
  if str = '' then exit;
  for i := 0 to cbFindText.Items.Count - 1 do
    if cbFindText.Items.Strings[i] = str then
    begin
      exist := true;
      break;
    end;

  if not exist then cbFindText.Items.Insert(0, str);
end;

end.
