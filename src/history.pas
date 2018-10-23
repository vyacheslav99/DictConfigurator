unit history;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, utils, settings, childForm, main,
  ActnList, ToolWin, ComCtrls, DBGridEhGrouping, GridsEh, DBGridEh, DB, FIBDataSet, pFIBDataSet, ExtCtrls, Menus,
  StdCtrls, ImgList, Buttons, MemDS, dbUtils, MemTableDataEh, MemTableEh, dbFind, EhLibFIB;

type
  TFHistory = class(TChildForm)
    ActionList: TActionList;
    AClose: TAction;
    AGridOptions: TAction;
    dbgHistory: TDBGridEh;
    dsoHistory: TDataSource;
    pmGrid: TPopupMenu;
    MenuItem1: TMenuItem;
    StatusBar: TStatusBar;
    dsHistory: TpFIBDataSet;
    dsHistoryDATE_ADD: TFIBDateTimeField;
    dsHistoryACTION_: TFIBStringField;
    dsHistoryREF_DESCRIPTOR: TFIBStringField;
    dsHistoryTITLE: TFIBStringField;
    dsHistoryUSER_PK: TFIBIntegerField;
    dsHistoryLOGIN: TFIBStringField;
    dsHistoryNAME: TFIBStringField;
    dsHistoryACTION_DETAIL: TFIBStringField;
    dsHistoryPK: TFIBIntegerField;
    AExportToExcel: TAction;
    AExportToCsv: TAction;
    Excel1: TMenuItem;
    csv1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure ACloseExecute(Sender: TObject);
    procedure AGridOptionsExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgHistoryKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgHistoryApplyFilter(Sender: TObject);
    procedure dbgHistoryFillSTFilterListValues(Sender: TCustomDBGridEh; Column: TColumnEh; Items: TStrings; var Processed: Boolean);
    procedure AExportToExcelExecute(Sender: TObject);
    procedure AExportToCsvExecute(Sender: TObject);
  private
    procedure SetMode(Value: TOpenMode); override;
    procedure SetProperties(Value: TNodeDictInfo); override;
    procedure Find(AContinue: boolean = false);
    procedure LoadHistory(ObjType: integer; ObjID, FGuid: string);
  public
  end;

implementation

{$R *.dfm}

procedure TFHistory.ACloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFHistory.AExportToCsvExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToCsv(TDBGridEh(ActiveControl), Caption);
end;

procedure TFHistory.AExportToExcelExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToExcel(TDBGridEh(ActiveControl), Caption);
end;

procedure TFHistory.AGridOptionsExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FSettings.GridParamsDialog(TDBGridEh(ActiveControl), ClassName);
end;

procedure TFHistory.dbgHistoryApplyFilter(Sender: TObject);
var
  i: integer;

begin
  if (TDBGridEh(Sender).DataSource = nil) or (TDBGridEh(Sender).DataSource.DataSet = nil) then exit;
  if not TDBGridEh(Sender).DataSource.DataSet.Active then exit;
  if TDBGridEh(Sender).DataSource.DataSet.RecordCount = 0 then exit;

  try
    TDBGridEh(Sender).DefaultApplyFilter;
  except
    TDBGridEh(Sender).DataSource.DataSet.Filtered := false;
    TDBGridEh(Sender).ClearFilter;
  end;

  if TDBGridEh(Sender).DataSource.DataSet.Filter = '' then
  begin
    TDBGridEh(Sender).DataSource.DataSet.Filtered := false;
    TDBGridEh(Sender).ClearFilter;
  end;

  for i := 0 to TDBGridEh(Sender).Columns.Count - 1 do
  begin
    if TDBGridEh(Sender).Columns[i].STFilter.ExpressionStr <> '' then
    begin
      TDBGridEh(Sender).Columns[i].Title.Font.Style := [fsBold];
      TDBGridEh(Sender).Columns[i].Title.Font.Color := clBlue;
    end else
    begin
      TDBGridEh(Sender).Columns[i].Title.Font.Style := FSettings.GridOptions.TitleFont.Style;
      TDBGridEh(Sender).Columns[i].Title.Font.Color := FSettings.GridOptions.TitleFont.Color;
    end;
  end;
end;

procedure TFHistory.dbgHistoryFillSTFilterListValues(Sender: TCustomDBGridEh; Column: TColumnEh; Items: TStrings; var Processed: Boolean);
begin
  if TDBGridEh(Sender).DataSource.DataSet.FieldByName(Column.FieldName).Lookup then
  begin
    Column.STFilter.DataField := TDBGridEh(Sender).DataSource.DataSet.FieldByName(Column.FieldName).KeyFields;
    Column.STFilter.ListField := Column.FieldName;
    Column.STFilter.KeyField := TDBGridEh(Sender).DataSource.DataSet.FieldByName(Column.FieldName).KeyFields;
  end else
    Column.STFilter.DataField := Column.FieldName;

  Column.STFilter.ListSource := TDBGridEh(Sender).DataSource;
end;

procedure TFHistory.dbgHistoryKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F3: Find(true);
    else
      if (ssCtrl in Shift) and ((Key = Ord('F')) or (Key = Ord('f')) or (Key = Ord('А')) or (Key = Ord('а'))) then
        Find;
  end;
end;

procedure TFHistory.Find(AContinue: boolean);
var
  FindOptions: TFindOptions;
  col: TColumnEh;
  defCol: string;

begin
  if (not AContinue) or (DBFindDialog.cbFindText.Text = '') then
  begin
    // если новый, то показать диалог
    if Assigned(dbgHistory.SelectedField) then col := dbgHistory.FindFieldColumn(dbgHistory.SelectedField.FieldName);
    if Assigned(col) then defCol := col.Title.Caption;
    if DBFindDialog.ShowDialog(dbgHistory, defCol) <> mrOk then exit;
  end;

  FindOptions := [];
  if DBFindDialog.chbMatchCase.Checked then FindOptions := [foMatchCase];
  if DBFindDialog.chbToExistence.Checked then FindOptions := FindOptions + [foToExistence];
  if DBFindDialog.rbWholeString.Checked then FindOptions := FindOptions + [foWholeString];
  if DBFindDialog.rbAnyWord.Checked then FindOptions := FindOptions + [foAnyWord];
  if DBFindDialog.rbAllWords.Checked then FindOptions := FindOptions + [foAllWords];

  FindInGrid(dbgHistory, DBFindDialog.cbFindText.Text, DBFindDialog.SelectedField, FindOptions, AContinue);
end;

procedure TFHistory.FormActivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, true);
  FMain.CheckFormButton(Tag);
end;

procedure TFHistory.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FSettings.ChildMaximized := WindowState = wsMaximized;
end;

procedure TFHistory.FormDeactivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, false);
end;

procedure TFHistory.FormDestroy(Sender: TObject);
begin
  dsHistory.Close;
end;

procedure TFHistory.LoadHistory(ObjType: integer; ObjID, FGuid: string);
const
  sql_template = 'select distinct l.DATE_ADD, ' +
    'case l.ACTION_ when 0 then ''Создан'' when 1 then ''Изменен'' when 2 then ''Накат скрипта (пересоздан)'' when 3 then ''Удален'' end ACTION_, ' +
    'l.REF_DESCRIPTOR, o.PK, {title_field}, l.USER_PK, u.LOGIN, u.NAME, l.ACTION_DETAIL ' +
    'from DCFG_REF_LOG l ' +
    'left join USERS u on u.PK = l.USER_PK ' +
    'left join {object_join_const} ' +
    'where l.OBJ_TYPE = :OBJ_TYPE and (l.REF_DESCRIPTOR = :DESCRIPTOR or l.GUID = :GUID) ' +
    'order by l.DATE_ADD desc';

  fldr_title_field = 'o.NAME TITLE';
  fldr_join_const = 'DYNAMIC_FORM_FOLDER o on o.NAME = l.REF_DESCRIPTOR';

  ref_title_field = 'o.TITLE';
  ref_join_const = 'DYNAMIC_FORM_REFERENCE o on o.DESCRIPTOR_ = l.REF_DESCRIPTOR';

  form_title_field = 'o.TITLE';
  form_join_const = 'DYNAMIC_FORM o on (o.ALIAS_FORM = l.REF_DESCRIPTOR or o.TITLE = l.REF_DESCRIPTOR)';

  wz_title_field = 'o.NAME TITLE';
  wz_join_const = 'WIZARD_SCENS o on o.DESCRIPTOR_ = l.REF_DESCRIPTOR';

var
  sql, title, join: string;

begin
  if dsHistory.Active then dsHistory.Close;

  case ObjType of
    0: // папка
    begin
      title := fldr_title_field;
      join := fldr_join_const;
    end;
    1: // справочник
    begin
      title := ref_title_field;
      join := ref_join_const;
    end;
    2: // форма
    begin
      title := form_title_field;
      join := form_join_const;
    end;
    3: // сценарий
    begin
      title := wz_title_field;
      join := wz_join_const;
    end;
    else raise Exception.Create(Format('Указан неверный тип объекта (%s)! Укажите число в диапазоне 0-3', [VarToStr(ObjType)]));
  end;

  sql := StringReplace(sql_template, '{title_field}', title, []);
  sql := StringReplace(sql, '{object_join_const}', join, []);
  dsHistory.SQLs.SelectSQL.Text := sql;
  dsHistory.ParamByName('OBJ_TYPE').Value := ObjType;
  dsHistory.ParamByName('DESCRIPTOR').Value := ObjID;
  dsHistory.ParamByName('GUID').Value := FGuid;

  Screen.Cursor := crSQLWait;
  try
    dsHistory.Open;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFHistory.SetMode(Value: TOpenMode);
begin
  if Value = omAdd then Value := omView;
  inherited SetMode(Value);
  Caption := 'История';
end;

procedure TFHistory.SetProperties(Value: TNodeDictInfo);
var
  id, s: string;

begin
  inherited SetProperties(Value);

  case Properties.ObjType of
    cotFolder:
    begin
      id := VarToStr(Properties.Title);
      s := 'папки';
    end;
    cotDict:
    begin
      id := VarToStr(Properties.Descriptor);
      s := 'справочника';
    end;
    cotForm:
    begin
      if not VarIsNull(Properties.Descriptor) then id := VarToStr(Properties.Descriptor)
      else id := VarToStr(Properties.Title);
      s := 'формы';
    end;
    cotWizard:
    begin
      id := VarToStr(Properties.Descriptor);
      s := 'сценария';
    end;
    else exit;
  end;

  Caption := GenCaption('История ' + s, '', Properties.PK, VarToStr(Properties.Descriptor), VarToStr(Properties.Title), FSettings.TreeShowDescriptor);
  LoadHistory(Ord(Properties.ObjType), id, VarToStr(Properties.Guid));
end;

end.
