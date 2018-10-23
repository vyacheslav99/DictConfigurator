unit gridsettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Spin, GridsEh, DBGridEh;

type
  TDlgResult = (rSave, rCancel, rReset);
  
  TFGridSettings = class(TForm)
    Bevel1: TBevel;
    btnSave: TBitBtn;
    btnCancel: TBitBtn;
    lwVisibleFields: TListView;
    sbVisToHide: TSpeedButton;
    sbVisToHideAll: TSpeedButton;
    sbHideToVis: TSpeedButton;
    sbHideToVisAll: TSpeedButton;
    sbVisUp: TSpeedButton;
    sbVisDown: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    lwHidedFields: TListView;
    Bevel2: TBevel;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    edCaption: TEdit;
    edWidth: TSpinEdit;
    Label6: TLabel;
    btnReset: TBitBtn;
    Label1: TLabel;
    edFixed: TSpinEdit;
    Label5: TLabel;
    edHint: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lwVisibleFieldsChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure sbVisToHideClick(Sender: TObject);
    procedure sbVisToHideAllClick(Sender: TObject);
    procedure sbVisUpClick(Sender: TObject);
    procedure edCaptionChange(Sender: TObject);
    procedure edCaptionExit(Sender: TObject);
    procedure edWidthChange(Sender: TObject);
    procedure edFixedChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure lwVisibleFieldsDblClick(Sender: TObject);
    procedure lwHidedFieldsDblClick(Sender: TObject);
  private
    rslt: TDlgResult;
    FDBGrid: TDBGridEh;
    SrcDBGrid: TDBGridEh;
    floading: boolean;
    CurrColumn: TColumnEh;
    procedure LoadGrid;
    procedure LoadColSettings(Col: TColumnEh);
    procedure ChangeEnabled(AEnabled: boolean);
    function GetColByName(DBGrid: TDBGridEh; FieldName: string): TColumnEh; overload;
    function GetColByName(FieldName: string): TColumnEh; overload;
    function GetItemByName(lw: TListView; FieldName: string): TListItem;
    function RemoveItem(Index: integer; lwFrom: TListView; CanReload: boolean): boolean;
    procedure RemoveAllItems(lwFrom, lwTo: TListView);
    procedure MoveItem(lw: TListView; mUp: boolean);
    procedure ScrollListView(lw: TListView);
    procedure CopyGridParams(GridFrom, GridTo: TDBGridEh; CanCreateColumns: boolean);
  public
    function ShowSettingsDialog(DBGrid: TDBGridEh): TDlgResult;
    procedure CancelChanges;
  end;

implementation

{$R *.dfm}

procedure TFGridSettings.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFGridSettings.btnResetClick(Sender: TObject);
begin
  if Application.MessageBox('Сбросить настройки колонок таблицы?', 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;
  rslt := rReset;
  Close;
end;

procedure TFGridSettings.btnSaveClick(Sender: TObject);
begin
  rslt := rSave;
  Close;
end;

procedure TFGridSettings.CancelChanges;
begin
  CopyGridParams(SrcDBGrid, FDBGrid, false);
end;

procedure TFGridSettings.ChangeEnabled(AEnabled: boolean);
begin
  Label4.Enabled := AEnabled;
  edCaption.Enabled := AEnabled;
  Label6.Enabled := AEnabled;
  edWidth.Enabled := AEnabled;
  Label5.Enabled := AEnabled;
  edHint.Enabled := AEnabled;
end;

procedure TFGridSettings.CopyGridParams(GridFrom, GridTo: TDBGridEh; CanCreateColumns: boolean);
var
  i: integer;
  colFrom, colTo: TColumnEh;

begin
  if (not Assigned(GridFrom)) or (not Assigned(GridTo)) then exit;
  GridTo.FrozenCols := 0;
  
  // копируем колонки
  if CanCreateColumns then
    GridTo.Columns.Assign(GridFrom.Columns)
  else
    for i := 0 to GridFrom.Columns.Count - 1 do
    begin
      colFrom := GridFrom.Columns[i];
      colTo := GetColByName(GridTo, colFrom.FieldName);
      if (not Assigned(colTo)) or (not Assigned(colFrom)) then continue;
      colTo.Index := colFrom.Index;
      colTo.Visible := colFrom.Visible;
      colTo.Title.Caption := colFrom.Title.Caption;
      colTo.Width := colFrom.Width;
    end;

  // копируем свойства грида
  GridTo.FrozenCols := GridFrom.FrozenCols;
end;

procedure TFGridSettings.edCaptionChange(Sender: TObject);
begin
  if not Assigned(CurrColumn) then exit;
  CurrColumn.Title.Caption := edCaption.Text;
end;

procedure TFGridSettings.edCaptionExit(Sender: TObject);
begin
  LoadGrid;
end;

procedure TFGridSettings.edFixedChange(Sender: TObject);
begin
  FDBGrid.FrozenCols := edFixed.Value;
end;

procedure TFGridSettings.edWidthChange(Sender: TObject);
begin
  if not Assigned(CurrColumn) then exit;
  CurrColumn.Width := edWidth.Value;
end;

procedure TFGridSettings.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TFGridSettings.FormCreate(Sender: TObject);
begin
  SrcDBGrid := TDBGridEh.Create(nil);
end;

procedure TFGridSettings.FormDestroy(Sender: TObject);
begin
  SrcDBGrid.Free;
end;

procedure TFGridSettings.FormShow(Sender: TObject);
begin
  rslt := rCancel;
end;

function TFGridSettings.GetColByName(FieldName: string): TColumnEh;
var
  i: integer;

begin
  result := nil;
  for i := 0 to FDBGrid.Columns.Count - 1 do
  begin
    result := FDBGrid.Columns.Items[i];
    if AnsiUpperCase(result.FieldName) = AnsiUpperCase(FieldName) then exit
    else result := nil;
  end;
end;

function TFGridSettings.GetItemByName(lw: TListView; FieldName: string): TListItem;
var
  i: integer;

begin
  result := nil;
  if not Assigned(lw) then exit;
  for i := 0 to lw.Items.Count - 1 do
  begin
    result := lw.Items[i];
    if AnsiUpperCase(result.SubItems.Strings[0]) = AnsiUpperCase(FieldName) then exit
    else result := nil;
  end;
end;

function TFGridSettings.GetColByName(DBGrid: TDBGridEh; FieldName: string): TColumnEh;
var
  i: integer;

begin
  result := nil;
  if not Assigned(DBGrid) then exit;
  for i := 0 to DBGrid.Columns.Count - 1 do
  begin
    result := DBGrid.Columns.Items[i];
    if AnsiUpperCase(result.FieldName) = AnsiUpperCase(FieldName) then exit
    else result := nil;
  end;
end;

procedure TFGridSettings.LoadColSettings(Col: TColumnEh);
begin
  CurrColumn := nil;
  if not Assigned(Col) then
  begin
    ChangeEnabled(false);
    exit;
  end;
  ChangeEnabled(true);
  edCaption.Text := Col.Title.Caption;
  edHint.Text := Col.Title.Hint;
  GroupBox1.Caption := ' Свойства столбца [' + Col.FieldName + '] ';
  edWidth.Value := Col.Width;
  CurrColumn := Col;
end;

procedure TFGridSettings.LoadGrid;
var
  i, n: integer;
  col: TColumnEh;
  lw: TListView;

begin
  // сначала ставим общие свойства грида
  floading := true;
  ChangeEnabled(false);
  try
    lwVisibleFields.Clear;
    lwHidedFields.Clear;
    edFixed.MaxValue := FDBGrid.Columns.Count;
    edFixed.Value := FDBGrid.FrozenCols;

    // теперь проедемся по столбцам
    for i := 0 to FDBGrid.Columns.Count - 1 do
    begin
      col := FDBGrid.Columns.Items[i];
      if col.Visible then lw := lwVisibleFields
      else lw := lwHidedFields;
      lw.Items.AddItem(TListItem.Create(lw.Items), lw.Items.Count);
      n := lw.Items.Count - 1;
      lw.Items[n].SubItems.Add(col.FieldName);
      lw.Items[n].Caption := col.Title.Caption;
    end;
  finally
    floading := false;
    lwVisibleFields.Selected := lwVisibleFields.Items[0];
  end;
end;

procedure TFGridSettings.lwHidedFieldsDblClick(Sender: TObject);
begin
  sbHideToVis.Click;
end;

procedure TFGridSettings.lwVisibleFieldsChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  if floading then exit;
  LoadColSettings(GetColByName(Item.SubItems.Strings[0]));
end;

procedure TFGridSettings.lwVisibleFieldsDblClick(Sender: TObject);
begin
  sbVisToHide.Click;
end;

procedure TFGridSettings.MoveItem(lw: TListView; mUp: boolean);
var
  item: TListItem;
  col: TColumnEh;
  i: integer;

begin
  item := lw.Selected;
  if not Assigned(item) then exit;
  col := GetColByName(item.SubItems.Strings[0]);
  if not Assigned(col) then exit;
  i := col.Index;
  if mUp then i := i - 1
  else i := i + 1;
  if (i < 0) or (i >= FDBGrid.Columns.Count) then exit;
  col.Index := i;
  LoadGrid;
  item := GetItemByName(lw, col.FieldName);
  lw.Selected := item;
  ScrollListView(lw);
  lw.SetFocus;
end;

procedure TFGridSettings.RemoveAllItems(lwFrom, lwTo: TListView);
var
  i: integer;

begin
  for i := 0 to lwFrom.Items.Count - 1 do
    if not RemoveItem(i, lwFrom, false) then break;
    
  LoadGrid;
  lwTo.Selected := lwTo.Items[0];
  ScrollListView(lwTo);
  lwTo.SetFocus;
end;

function TFGridSettings.RemoveItem(Index: integer; lwFrom: TListView; CanReload: boolean): boolean;
var
  item: TListItem;
  col: TColumnEh;
  s: string;

begin
  result := true;
  if (Index >= lwFrom.Items.Count) or (Index < 0) then exit;
  item := lwFrom.Items[Index];
  col := GetColByName(item.SubItems.Strings[0]);
  if not Assigned(col) then exit;

  try
    col.Visible := lwFrom = lwHidedFields;
    col.Field.Visible := col.Visible;
  except
    on e: Exception do
    begin
      result := false;
      if Pos('Fixed', e.Message) > 0 then
      begin
        col.Visible := true;
        s := 'Количество зафиксированных столбцов должно быть меньше количества видимых.';
      end else
        s := e.Message;
      Application.MessageBox(pchar(s), 'Предупреждение', MB_OK + MB_ICONWARNING);
    end;
  end;
  
  if not CanReload then exit;
  LoadGrid;
  if lwFrom.Items.Count = 0 then exit;
  if (Index >= lwFrom.Items.Count) or (Index < 0) then Index := 0;
  lwFrom.Selected := lwFrom.Items[Index];
  ScrollListView(lwFrom);
  lwFrom.SetFocus;
end;

procedure TFGridSettings.sbVisToHideAllClick(Sender: TObject);
var
  lwFrom, lwTo: TListView;

begin
  if Sender = sbVisToHideAll then
  begin
    lwFrom := lwVisibleFields;
    lwTo := lwHidedFields;
  end else
  if Sender = sbHideToVisAll then
  begin
    lwFrom := lwHidedFields;
    lwTo := lwVisibleFields;
  end else exit;

  RemoveAllItems(lwFrom, lwTo);
end;

procedure TFGridSettings.sbVisToHideClick(Sender: TObject);
var
  lw: TListView;

begin
  if (Sender = sbVisToHide) then lw := lwVisibleFields
  else if (Sender = sbHideToVis) then lw := lwHidedFields
  else exit;

  if not Assigned(lw.Selected) then exit;
  RemoveItem(lw.Selected.Index, lw, true);
end;

procedure TFGridSettings.sbVisUpClick(Sender: TObject);
begin
  MoveItem(lwVisibleFields, Sender = sbVisUp);
end;

procedure TFGridSettings.ScrollListView(lw: TListView);
var
  X: integer;
  i: integer;

begin
  if not Assigned(lw.Selected) then exit;
  lw.Selected.MakeVisible(true);
  X := lw.Items[lw.ItemIndex].Top;
  X := Round(X / 200);
  if X = 0 then X := -1;
  for i := 0 to X do SendMessage(lw.Handle, WM_VSCROLL, SB_LINEDOWN, 0);
end;

function TFGridSettings.ShowSettingsDialog(DBGrid: TDBGridEh): TDlgResult;
begin
  FDBGrid := DBGrid;
  CopyGridParams(DBGrid, SrcDBGrid, true);
  LoadGrid;
  ShowModal;
  result := rslt;
end;

end.
