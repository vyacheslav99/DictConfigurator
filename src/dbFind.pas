unit dbFind;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ComCtrls,
  StrUtils, ExtCtrls, DBGridEh;

type
  TDBFindDialog = class(TForm)
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
    Label2: TLabel;
    cbColumnName: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cbFindTextKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chbToExistenceClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fok: boolean;
    FieldsList: TStringList;
    procedure UpdateFindHistory;
    procedure FillColumnList(Grid: TDBGridEh);
  public
    function SelectedField: string;
    function ShowDialog(Grid: TDBGridEh; DefColumn: string): TModalResult;
  end;

var
  DBFindDialog: TDBFindDialog;

implementation

{$R *.dfm}

{ TFindDialog }

procedure TDBFindDialog.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TDBFindDialog.btnOKClick(Sender: TObject);
begin
  fok := true;
  UpdateFindHistory;
  Close;
end;

procedure TDBFindDialog.cbFindTextKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then btnOKClick(Self);
  if Key = VK_ESCAPE then btnCancelClick(Self);
end;

procedure TDBFindDialog.chbToExistenceClick(Sender: TObject);
begin
  rbWholeString.Enabled := chbToExistence.Checked;
  rbAnyWord.Enabled := chbToExistence.Checked;
  rbAllWords.Enabled := chbToExistence.Checked;
end;

procedure TDBFindDialog.FillColumnList(Grid: TDBGridEh);
var
  i: integer;

begin
  FieldsList.Clear;
  cbColumnName.Items.Clear;

  FieldsList.Add('*');
  cbColumnName.Items.Add('(все)');

  for i := 0 to Grid.Columns.Count - 1 do
  begin
    FieldsList.Add(Grid.Columns[i].FieldName);
    cbColumnName.Items.Add(Grid.Columns[i].Title.Caption);
  end;
end;

procedure TDBFindDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
  if fok then ModalResult := mrOk;
end;

procedure TDBFindDialog.FormCreate(Sender: TObject);
begin
  cbFindText.Style := csSimple;
  FieldsList := TStringList.Create;
end;

procedure TDBFindDialog.FormDestroy(Sender: TObject);
begin
  FieldsList.Free;
end;

procedure TDBFindDialog.FormShow(Sender: TObject);
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

function TDBFindDialog.SelectedField: string;
begin
  result := FieldsList.Strings[cbColumnName.ItemIndex];
end;

function TDBFindDialog.ShowDialog(Grid: TDBGridEh; DefColumn: string): TModalResult;
begin
  if DefColumn = '' then DefColumn := '*';
  FillColumnList(Grid);
  cbColumnName.ItemIndex := cbColumnName.Items.IndexOf(DefColumn);
  result := ShowModal;
end;

procedure TDBFindDialog.UpdateFindHistory;
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
