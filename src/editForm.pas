unit editForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, settings, utils,
  ExtCtrls, DB, FIBDataSet, pFIBDataSet, DBGridEh, Mask, DBCtrlsEh, DBLookupEh, Spin, DBGridEhGrouping, GridsEh, main,
  MemTableDataEh, MemTableEh, FIBQuery, pFIBQuery, Math, groupEditor, fieldEditor, Menus, optControls, dbUtils, ActnList,
  groupedit, previewForm, childForm, json, jsonReader, ToolWin, ComCtrls, EhLibMTE;

type
  TFEditForm = class(TChildForm)
    GroupBox1: TGroupBox;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    Bevel1: TBevel;
    Label3: TLabel;
    edFormTitle: TEdit;
    Label2: TLabel;
    edFormPk: TEdit;
    Label4: TLabel;
    edFormAlias: TEdit;
    Label1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    dbgFormFields: TDBGridEh;
    edFormWidth: TDBNumberEditEh;
    edFormHeight: TDBNumberEditEh;
    dsForm: TpFIBDataSet;
    dsFormPK: TFIBIntegerField;
    dsFormTITLE: TFIBStringField;
    dsFormALIAS_FORM: TFIBStringField;
    dsFormCREATE_: TFIBDateTimeField;
    dsFormMODIFY: TFIBDateTimeField;
    dsFormWIDTH: TFIBIntegerField;
    dsFormHEIGHT: TFIBIntegerField;
    dsFormOWNER_USER_PK: TFIBIntegerField;
    dsFormFields: TpFIBDataSet;
    dsFormFieldsPK: TFIBIntegerField;
    dsFormFieldsOWNER_USER_PK: TFIBIntegerField;
    dsFormFieldsGROUP_COLUMN: TFIBIntegerField;
    dsFormFieldsORDER_: TFIBIntegerField;
    dsFormFieldsTITLE: TFIBStringField;
    dsFormFieldsDESCRIPTION: TFIBStringField;
    dsFormFieldsTYPE_NAME: TFIBStringField;
    dsFormFieldsFIELD_NAME: TFIBStringField;
    dsFormFieldsSTYLE_EXTERNAL: TFIBStringField;
    dsFormFieldsSTYLE: TFIBStringField;
    dsFormFieldsPARAMETERS: TFIBStringField;
    dsFormFieldsGRID_ORDER: TFIBSmallIntField;
    dsFormFieldsGRID_WIDTH: TFIBIntegerField;
    dsFormFieldsEDITABLE: TFIBIntegerField;
    dsFormFieldsADD_EDITABLE: TFIBIntegerField;
    dsFormFieldsEXCEL_EXPORT: TFIBIntegerField;
    dsFormFieldsFILTER_ORDER: TFIBIntegerField;
    dsFormFieldsIS_FILTER: TFIBSmallIntField;
    dsFormFieldsSHOW_IN_START_FORM: TFIBSmallIntField;
    dsFormFieldsSTYLE_COLUMN: TFIBStringField;
    dsFormFieldsSHOW_IN_GROUP_EDIT: TFIBIntegerField;
    dsFormFieldsEXCEL_IMPORT: TFIBIntegerField;
    dsFormFieldsMATCH: TFIBIntegerField;
    dsFormFieldsGROUP_PK: TFIBIntegerField;
    dsoFormFields: TDataSource;
    sbAdd: TSpeedButton;
    sbDel: TSpeedButton;
    sbEdit: TSpeedButton;
    mtFormFields: TMemTableEh;
    mtFormFieldsCHANGED: TBooleanField;
    mtFormFieldsPK: TIntegerField;
    mtFormFieldsOWNER_USER_PK: TIntegerField;
    mtFormFieldsGROUP_COLUMN: TIntegerField;
    mtFormFieldsORDER_: TIntegerField;
    mtFormFieldsTITLE: TStringField;
    mtFormFieldsDESCRIPTION: TStringField;
    mtFormFieldsTYPE_NAME: TStringField;
    mtFormFieldsFIELD_NAME: TStringField;
    mtFormFieldsSTYLE_EXTERNAL: TStringField;
    mtFormFieldsSTYLE: TStringField;
    mtFormFieldsPARAMETERS: TStringField;
    mtFormFieldsGRID_ORDER: TSmallintField;
    mtFormFieldsGRID_WIDTH: TIntegerField;
    mtFormFieldsEDITABLE: TIntegerField;
    mtFormFieldsADD_EDITABLE: TIntegerField;
    mtFormFieldsEXCEL_EXPORT: TIntegerField;
    mtFormFieldsFILTER_ORDER: TIntegerField;
    mtFormFieldsIS_FILTER: TSmallintField;
    mtFormFieldsSHOW_IN_START_FORM: TSmallintField;
    mtFormFieldsSTYLE_COLUMN: TStringField;
    mtFormFieldsSHOW_IN_GROUP_EDIT: TIntegerField;
    mtFormFieldsEXCEL_IMPORT: TIntegerField;
    mtFormFieldsMATCH: TIntegerField;
    mtFormFieldsGROUP_PK: TIntegerField;
    mtFormFieldsGROUP_TITLE: TStringField;
    qEditField: TpFIBQuery;
    Label7: TLabel;
    sbAddGroup: TSpeedButton;
    sbEditGroup: TSpeedButton;
    sbDelGroup: TSpeedButton;
    dbgGroups: TDBGridEh;
    dsGroups: TpFIBDataSet;
    mtGroups: TMemTableEh;
    dsoGroups: TDataSource;
    dsGroupsPK: TFIBIntegerField;
    dsGroupsPARENT_PK: TFIBIntegerField;
    dsGroupsOWNER_USER_PK: TFIBIntegerField;
    dsGroupsORDER_: TFIBIntegerField;
    dsGroupsTITLE: TFIBStringField;
    dsGroupsDESCRIPTION: TFIBStringField;
    dsGroupsCOUNT_COLUMN: TFIBIntegerField;
    dsGroupsSTYLE_EXTERNAL: TFIBStringField;
    dsGroupsSTYLE_INTERNAL: TFIBStringField;
    dsGroupsIS_VISIBLE: TFIBStringField;
    dsGroupsCOLUMN_: TFIBIntegerField;
    dsGroupsSTYLE_COLUMNS: TFIBStringField;
    dsGroupsADD_VISIBLE: TFIBIntegerField;
    dsGroupsCOLLAPSED: TFIBSmallIntField;
    mtGroupsPK: TIntegerField;
    mtGroupsPARENT_PK: TIntegerField;
    mtGroupsOWNER_USER_PK: TIntegerField;
    mtGroupsORDER_: TIntegerField;
    mtGroupsTITLE: TStringField;
    mtGroupsDESCRIPTION: TStringField;
    mtGroupsCOUNT_COLUMN: TIntegerField;
    mtGroupsSTYLE_EXTERNAL: TStringField;
    mtGroupsSTYLE_INTERNAL: TStringField;
    mtGroupsIS_VISIBLE: TStringField;
    mtGroupsCOLUMN_: TIntegerField;
    mtGroupsSTYLE_COLUMNS: TStringField;
    mtGroupsADD_VISIBLE: TIntegerField;
    mtGroupsCOLLAPSED: TSmallintField;
    dsFieldGroups: TpFIBDataSet;
    dsFieldGroupsPK: TFIBIntegerField;
    dsFieldGroupsTITLE: TFIBStringField;
    mtGroupsCHANGED: TBooleanField;
    qEditGroup: TpFIBQuery;
    dsGroupsCREATE_: TFIBDateTimeField;
    mtGroupsCREATE_: TDateTimeField;
    mtGroupsPARENT_TITLE: TStringField;
    dsFieldGroupsCOUNT_COLUMN: TFIBIntegerField;
    dsFormFieldsOBJECT_NAME: TFIBStringField;
    mtFormFieldsOBJECT_NAME: TStringField;
    ActionList: TActionList;
    ASave: TAction;
    btnPreviewForm: TButton;
    dsFormFieldsLOCKED: TFIBIntegerField;
    mtFormFieldsLOCKED: TIntegerField;
    chbLeftAlign: TCheckBox;
    dsFormLEFT_ALIGN: TFIBIntegerField;
    dsGroupsLEFT_ALIGN: TFIBIntegerField;
    mtGroupsLEFT_ALIGN: TIntegerField;
    AGridOptions: TAction;
    pmGrid: TPopupMenu;
    N1: TMenuItem;
    Label30: TLabel;
    edLabelWidth: TDBNumberEditEh;
    dsFormLABEL_WIDTH: TFIBIntegerField;
    dsGroupsLABEL_WIDTH: TFIBIntegerField;
    mtGroupsLABEL_WIDTH: TIntegerField;
    edCurrField: TEdit;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    tbRefresh: TToolButton;
    btnRefresh: TBitBtn;
    tbGenSQL: TToolButton;
    tbSave: TToolButton;
    dsFormFieldsFILTER_GROUP: TFIBIntegerField;
    mtFormFieldsFILTER_GROUP: TIntegerField;
    dsLFilterGroups: TpFIBDataSet;
    dsLFilterGroupsPK: TFIBIntegerField;
    dsLFilterGroupsTITLE: TFIBStringField;
    mtFormFieldsFILTER_GROUP_NAME: TStringField;
    tbJumpToTree: TToolButton;
    dsFormFieldsIS_VISIBLE: TFIBIntegerField;
    dsFormFieldsGRID_VISIBLE: TFIBIntegerField;
    dsFormFieldsIS_VISIBLE_ADD: TFIBIntegerField;
    dsFormFieldsEDIT_IN_TABLE: TFIBIntegerField;
    mtFormFieldsIS_VISIBLE: TIntegerField;
    mtFormFieldsGRID_VISIBLE: TIntegerField;
    mtFormFieldsIS_VISIBLE_ADD: TIntegerField;
    mtFormFieldsEDIT_IN_TABLE: TIntegerField;
    AExportToExcel: TAction;
    AExportToCsv: TAction;
    Excel1: TMenuItem;
    csv1: TMenuItem;
    dsFormGUID: TFIBStringField;
    dsFormFieldsGUID: TFIBStringField;
    dsGroupsGUID: TFIBStringField;
    mtFormFieldsGUID: TStringField;
    mtGroupsGUID: TStringField;
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbAddClick(Sender: TObject);
    procedure sbDelClick(Sender: TObject);
    procedure sbEditClick(Sender: TObject);
    procedure mtFormFieldsBeforePost(DataSet: TDataSet);
    procedure dbgFormFieldsGetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure mtFormFieldsAfterInsert(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure mtFormFieldsBeforeDelete(DataSet: TDataSet);
    procedure sbAddGroupClick(Sender: TObject);
    procedure sbEditGroupClick(Sender: TObject);
    procedure sbDelGroupClick(Sender: TObject);
    procedure mtGroupsAfterInsert(DataSet: TDataSet);
    procedure mtGroupsBeforeDelete(DataSet: TDataSet);
    procedure mtGroupsBeforePost(DataSet: TDataSet);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgFormFieldsDblClick(Sender: TObject);
    procedure dbgGroupsDblClick(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure dbgFormFieldsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgGroupsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPreviewFormClick(Sender: TObject);
    procedure AGridOptionsExecute(Sender: TObject);
    procedure mtFormFieldsAfterScroll(DataSet: TDataSet);
    procedure dbgFormFieldsColumns19EditButtonClick(Sender: TObject; var Handled: Boolean);
    procedure dbgGroupsColumns12EditButtonClick(Sender: TObject; var Handled: Boolean);
    procedure tbRefreshClick(Sender: TObject);
    procedure tbGenSQLClick(Sender: TObject);
    procedure dbgFormFieldsFillSTFilterListValues(Sender: TCustomDBGridEh; Column: TColumnEh; Items: TStrings;
      var Processed: Boolean);
    procedure tbJumpToTreeClick(Sender: TObject);
    procedure AExportToExcelExecute(Sender: TObject);
    procedure AExportToCsvExecute(Sender: TObject);
  private
    DeletedFields: TStringList;
    DeletedGroups: TStringList;
    IsLoadingGrid: boolean;
    function SaveData: boolean;
    procedure SaveGridData;
    procedure SetMode(Value: TOpenMode); override;
    procedure SetProperties(Value: TNodeDictInfo); override;
    procedure LoadGridData;
    procedure LoadGroups;
    procedure LoadLookups;
    procedure AutoIncFields;
    procedure AutoIncGroups;
    procedure LoadColumnStyles(dsDest: TMemTableEh; StylesStr: string);
    function GetColumnStyles(dsSrc: TMemTableEh): string;
    procedure LoadFieldTypeParams(OptList: TContainer; OptionsStr: string);
    function GetFieldTypeParams(OptList: TContainer): string;
    procedure ApplyGroupEditorData(FGroupEditor: TFGroupEditor);
    procedure ApplyFieldEditorData(FFieldEditor: TFFieldEditor);
    procedure ApplyJsonEditorData(FJsonReader: TFJsonReader);
    procedure GroupEdit(Grid: TDBGridEh);
    function OpenJsonEditor(Field: TField; StatusText: string): TFJsonReader;
    procedure _Reload;
    function gcsForm(Script, Vars: TStringList): boolean;
    function gcsGroups(Script, Vars, Cache: TStringList): boolean;
    function gcsFields(Script, Vars, GrCache, TmplCache, FGrCache: TStringList): boolean;
    function gcsTemplates(Script, Vars, Cache, PkList: TStringList): boolean;
    function GenChangesSQL(Script, Vars: TStringList): boolean; override;
  public
    procedure OnGroupEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure OnFieldEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure OnJsonEditorClose(Sender: TObject; var Action: TCloseAction);
    function GetShortCaption: string; override;
  end;

implementation

{$R *.dfm}

uses scriptEditor;

procedure TFEditForm.AExportToCsvExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToCsv(TDBGridEh(ActiveControl), edFormTitle.Text);
end;

procedure TFEditForm.AExportToExcelExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToExcel(TDBGridEh(ActiveControl), edFormTitle.Text);
end;

procedure TFEditForm.AGridOptionsExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FSettings.GridParamsDialog(TDBGridEh(ActiveControl), ClassName);
end;

procedure TFEditForm.ApplyFieldEditorData(FFieldEditor: TFFieldEditor);
begin
  mtFormFields.DisableControls;
  try
    if FFieldEditor.Mode = omAdd then mtFormFields.Append
    else begin
      if mtFormFields.BookmarkValid(FFieldEditor.EditingRec) then
      begin
        mtFormFields.GotoBookmark(FFieldEditor.EditingRec);
        mtFormFields.Edit;
      end else
      begin
        if Application.MessageBox('Редактируемая запись была удалена! Восстановить?', 'Подтверждение',
          MB_YESNO + MB_ICONWARNING) = ID_YES then
        begin
          mtFormFields.Append;
        end else exit;
      end;
    end;

    mtFormFieldsFIELD_NAME.AsString := FFieldEditor.cbFieldName.Text;
    mtFormFieldsTITLE.AsString := FFieldEditor.edTitle.Text;
    mtFormFieldsGROUP_PK.AsVariant := FFieldEditor.cbGroup.KeyValue;
    mtFormFieldsGROUP_COLUMN.AsInteger := FFieldEditor.edGroupColumn.Value;
    mtFormFieldsORDER_.AsInteger := FFieldEditor.edOrder.Value;
    mtFormFieldsGRID_VISIBLE.AsInteger := FFieldEditor.edGridVisible.Value;
    mtFormFieldsEDIT_IN_TABLE.AsInteger := FFieldEditor.edEditInTable.Value;
    mtFormFieldsGRID_ORDER.AsInteger := FFieldEditor.edGridOrder.Value;
    mtFormFieldsGRID_WIDTH.AsVariant := FFieldEditor.edGridWidth.Value;
    mtFormFieldsIS_VISIBLE.AsInteger := FFieldEditor.edIsVisible.Value;
    mtFormFieldsEDITABLE.AsInteger := FFieldEditor.edEditable.Value;
    mtFormFieldsIS_VISIBLE_ADD.AsInteger := FFieldEditor.edIsVisibleAdd.Value;
    mtFormFieldsADD_EDITABLE.AsInteger := FFieldEditor.edAddEditable.Value;
    mtFormFieldsSHOW_IN_START_FORM.AsInteger := iif(FFieldEditor.chbShowInStartForm.Checked, 1, 0);
    mtFormFieldsEXCEL_EXPORT.AsInteger := iif(FFieldEditor.chbExcelExport.Checked, 1, 0);
    mtFormFieldsEXCEL_IMPORT.AsInteger := iif(FFieldEditor.chbExcelImport.Checked, 1, 0);
    mtFormFieldsIS_FILTER.AsVariant := FFieldEditor.edIsFilter.Value;
    mtFormFieldsFILTER_ORDER.AsInteger := FFieldEditor.edFilterOrder.Value;
    mtFormFieldsFILTER_GROUP.AsVariant := FFieldEditor.cbFilterGroup.KeyValue;
    mtFormFieldsLOCKED.AsInteger := iif(FFieldEditor.chbLocked.Checked, 1, 0);
    mtFormFieldsSTYLE.AsString := FFieldEditor.mStyle.Text;
    mtFormFieldsSTYLE_EXTERNAL.AsString := FFieldEditor.mStyleExternal.Text;
    if FFieldEditor.mStyleColumn.Text = '' then mtFormFieldsSTYLE_COLUMN.Clear
    else mtFormFieldsSTYLE_COLUMN.AsString := FFieldEditor.mStyleColumn.Text;
    mtFormFieldsTYPE_NAME.AsString := FFieldEditor.cbTypeName.Items[FFieldEditor.cbTypeName.ItemIndex];
    mtFormFieldsPARAMETERS.AsString := GetFieldTypeParams(FFieldEditor.ParamControls);
    mtFormFields.Post;
  finally
    mtFormFields.EnableControls;
  end;
end;

procedure TFEditForm.ApplyGroupEditorData(FGroupEditor: TFGroupEditor);
begin
  mtGroups.DisableControls;
  try
    if FGroupEditor.Mode = omAdd then mtGroups.Append
    else begin
      if mtGroups.BookmarkValid(FGroupEditor.EditingRec) then
      begin
        mtGroups.GotoBookmark(FGroupEditor.EditingRec);
        mtGroups.Edit;
      end else
      begin
        if Application.MessageBox('Редактируемая запись была удалена! Восстановить?', 'Подтверждение',
          MB_YESNO + MB_ICONWARNING) = ID_YES then
        begin
          mtGroups.Append;
        end else exit;
      end;
    end;

    //mtGroupsCHANGED.AsBoolean := true;
    mtGroups.FieldByName('PARENT_PK').Value := FGroupEditor.cbParentGroup.KeyValue;
    mtGroupsOWNER_USER_PK.AsInteger := FMain.dsPortalUserPK.AsInteger;
    mtGroupsORDER_.AsInteger := FGroupEditor.edOrder.Value;
    mtGroupsTITLE.AsString := FGroupEditor.edTitle.Text;
    if FGroupEditor.mDescription.Text = '' then mtGroupsDESCRIPTION.Clear
    else mtGroupsDESCRIPTION.AsString := FGroupEditor.mDescription.Text;
    mtGroupsCOUNT_COLUMN.AsInteger := FGroupEditor.edCountColumn.Value;
    mtGroupsSTYLE_EXTERNAL.AsString := FGroupEditor.mStyleExternal.Text;
    mtGroupsSTYLE_INTERNAL.AsString := FGroupEditor.mStyleInternal.Text;
    mtGroupsIS_VISIBLE.AsString := iif(FGroupEditor.chbIsVisible.Checked, '1', '0');
    mtGroupsCOLUMN_.AsInteger := FGroupEditor.edColumn.Value;
    mtGroupsSTYLE_COLUMNS.AsString := GetColumnStyles(FGroupEditor.mtStyleColumns);
    mtGroupsADD_VISIBLE.AsInteger := iif(FGroupEditor.chbAddVisible.Checked, 1, 0);
    mtGroupsCOLLAPSED.AsInteger := iif(FGroupEditor.chbCollapsed.Checked, 1, 0);
    mtGroupsLEFT_ALIGN.AsInteger := iif(FGroupEditor.chbLeftAlign.Checked, 1, 0);
    mtGroupsLABEL_WIDTH.AsVariant := FGroupEditor.edLabelWidth.Value;
    if FGroupEditor.Mode = omAdd then mtGroupsCREATE_.AsDateTime := Now;
    mtGroups.Post;
  finally
    mtGroups.EnableControls;
  end;
end;

procedure TFEditForm.ApplyJsonEditorData(FJsonReader: TFJsonReader);
var
  ds: TMemTableEh;
  
begin
  if (not Assigned(FJsonReader.Field)) or (not Assigned(FJsonReader.Field.DataSet)) then exit;
  ds := TMemTableEh(FJsonReader.Field.DataSet);

  ds.DisableControls;
  try
    if ds.BookmarkValid(FJsonReader.EditingRec) then
    begin
      ds.GotoBookmark(FJsonReader.EditingRec);
      ds.Edit;
    end else
    begin
      Application.MessageBox('Редактируемая запись была удалена!', 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;

    FJsonReader.Field.AsString := FJsonReader.GetJsonString;
    ds.Post;
  finally
    ds.EnableControls;
  end;
end;

procedure TFEditForm.ASaveExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then btnSaveClick(btnSave);
end;

procedure TFEditForm.AutoIncFields;
begin
  mtFormFieldsORDER_.Tag := mtFormFieldsORDER_.Tag + 10;
  mtFormFieldsGRID_ORDER.Tag := mtFormFieldsGRID_ORDER.Tag + 10;
end;

procedure TFEditForm.AutoIncGroups;
begin
  mtFormFieldsORDER_.Tag := mtFormFieldsORDER_.Tag + 10;
end;

procedure TFEditForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFEditForm.btnPreviewFormClick(Sender: TObject);
var
  pf: TFPreviewForm;
  
begin
  if FMain.SetFocusOpenedWindow(dsFormPK.AsInteger, TFPreviewForm.ClassName) then exit;
  pf := TFPreviewForm.Create(Self, cftPreview, omView, dsFormPK.AsVariant, FMain.OnChildFormClose);
  pf.Caption := edFormTitle.Text + ' - просмотр';
  if pf.WindowState <> wsMaximized then
  begin
    if (not VarIsNull(edFormWidth.Value)) and (edFormWidth.Value > 0) then pf.Width := edFormWidth.Value
    else pf.Width := 600;
    if (not VarIsNull(edFormHeight.Value)) and (edFormHeight.Value > 0) then pf.Height := edFormHeight.Value
    else pf.Height := 500;
  end;
  pf.FieldsLeftAlign := chbLeftAlign.Checked;
  pf.RootLabelWidth := iif(VarIsNull(edLabelWidth.Value), 0, edLabelWidth.Value);
  pf.cbFormType.ItemIndex := 0;
  pf.cbFormTypeChange(pf.cbFormType);
  //pf.Show;
  FMain.RegisterChildForm(pf);
end;

procedure TFEditForm.btnSaveClick(Sender: TObject);
var
  FScript: TFScriptEditor;

begin
  if Mode = omView then exit;

  if FSettings.ConfirmSave and
    (Application.MessageBox('Сохранить изменения формы в базу данных?', 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES) then exit;

  if Mode = omEdit then FScript := PrepareScriptForm;

  Success := SaveData;
  if Success then
  begin
    Mode := omEdit;
    Properties := Properties;
    if CanRefresh then FMain.ChangeFormButtonCaption(Tag, GetShortCaption, Caption);
    if Assigned(FScript) and FSettings.ShowScriptForm then FScript.Show;
  end;
end;

procedure TFEditForm.dbgFormFieldsColumns19EditButtonClick(Sender: TObject; var Handled: Boolean);
var
  FJsonReader: TFJsonReader;
  col: TColumnEh;

begin
  col := FindColumnByFieldName(dbgFormFields, 'PARAMETERS');
  FJsonReader := OpenJsonEditor(mtFormFieldsPARAMETERS, 'Поле: ' + iif(mtFormFieldsOBJECT_NAME.IsNull, '', mtFormFieldsOBJECT_NAME.AsString + '.') +
    mtFormFieldsFIELD_NAME.AsString + '  ' + mtFormFieldsTITLE.AsString + '  ' + mtFormFieldsTYPE_NAME.AsString + ' : ' + col.Title.Hint);
end;

procedure TFEditForm.dbgFormFieldsDblClick(Sender: TObject);
begin
  sbEditClick(sbEdit);
end;

procedure TFEditForm.dbgFormFieldsFillSTFilterListValues(Sender: TCustomDBGridEh; Column: TColumnEh; Items: TStrings;
  var Processed: Boolean);
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

procedure TFEditForm.dbgFormFieldsGetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont;
  var Background: TColor; State: TGridDrawState);
begin
  if TDBGridEh(Sender).DataSource.DataSet.FieldByName('CHANGED').AsBoolean then
  begin
    if TDBGridEh(Sender).DataSource.DataSet.FieldByName('PK').IsNull then Background := FSettings.GridOptions.NewRowColor
    else Background := FSettings.GridOptions.ChangedRowColor;
  end {else Background := clWindow};
end;

procedure TFEditForm.dbgFormFieldsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddClick(sbAdd);
    VK_RETURN: if ssShift in Shift then sbEditClick(sbEdit);
    else
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
  end;
end;

procedure TFEditForm.dbgGroupsColumns12EditButtonClick(Sender: TObject; var Handled: Boolean);
var
  FJsonReader: TFJsonReader;
  col: TColumnEh;

begin
  col := FindColumnByFieldName(dbgGroups, 'STYLE_COLUMNS');
  FJsonReader := OpenJsonEditor(mtGroupsSTYLE_COLUMNS, 'Группа: ' + mtGroupsORDER_.AsString + '.' + mtGroupsTITLE.AsString + ' : ' + col.Title.Hint);
end;

procedure TFEditForm.dbgGroupsDblClick(Sender: TObject);
begin
  sbEditGroupClick(sbEditGroup);
end;

procedure TFEditForm.dbgGroupsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddGroupClick(sbAddGroup);
    VK_RETURN: if ssShift in Shift then sbEditGroupClick(sbEditGroup);
    else
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
  end;
end;

procedure TFEditForm.FormActivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, true);
  FMain.CheckFormButton(Tag);
end;

procedure TFEditForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FSettings.ChildMaximized := WindowState = wsMaximized;
end;

procedure TFEditForm.FormCreate(Sender: TObject);
var
  col: TColumnEh;

begin
  DeletedFields := TStringList.Create;
  DeletedGroups := TStringList.Create;
  col := FindColumnByFieldName(dbgFormFields, 'TYPE_NAME');
  if Assigned(col) then
  begin
    col.KeyList.Text := FIELDTYPES;
    col.PickList.Text := FIELDTYPES;
  end;
end;

procedure TFEditForm.FormDeactivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, false);
end;

procedure TFEditForm.FormDestroy(Sender: TObject);
begin
  DeletedFields.Free;
  DeletedGroups.Free;
end;

function TFEditForm.gcsFields(Script, Vars, GrCache, TmplCache, FGrCache: TStringList): boolean;
var
  bm: TBookmark;
  sl: TStringList;

begin
  result := false;
  sl := TStringList.Create;

  try
    bm := mtFormFields.GetBookmark;
    mtFormFields.DisableControls;

    // сначала надо все темплаты всех изменившихся полей выгрузить
    mtFormFields.First;
    while not mtFormFields.Eof do
    begin
      if mtFormFieldsCHANGED.AsBoolean then
      begin
        if (mtFormFieldsGRID_VISIBLE.AsInteger > 1) and (sl.IndexOf(mtFormFieldsGRID_VISIBLE.AsString) = -1) then
          sl.Add(mtFormFieldsGRID_VISIBLE.AsString);
        if (mtFormFieldsEDITABLE.AsInteger > 1) and (sl.IndexOf(mtFormFieldsEDITABLE.AsString) = -1) then
          sl.Add(mtFormFieldsEDITABLE.AsString);
        if (mtFormFieldsADD_EDITABLE.AsInteger > 1) and (sl.IndexOf(mtFormFieldsADD_EDITABLE.AsString) = -1) then
          sl.Add(mtFormFieldsADD_EDITABLE.AsString);
        if (mtFormFieldsIS_VISIBLE_ADD.AsInteger > 1) and (sl.IndexOf(mtFormFieldsIS_VISIBLE_ADD.AsString) = -1) then
          sl.Add(mtFormFieldsIS_VISIBLE_ADD.AsString);
        if (mtFormFieldsEDIT_IN_TABLE.AsInteger > 1) and (sl.IndexOf(mtFormFieldsEDIT_IN_TABLE.AsString) = -1) then
          sl.Add(mtFormFieldsEDIT_IN_TABLE.AsString);
        if (mtFormFieldsIS_VISIBLE.AsInteger > 1) and (sl.IndexOf(mtFormFieldsIS_VISIBLE.AsString) = -1) then
          sl.Add(mtFormFieldsIS_VISIBLE.AsString);
      end;
      mtFormFields.Next;
    end;

    gcsTemplates(Script, Vars, TmplCache, sl);

    // удаление
    result := gcsGenDeleteSQL(Script, DeletedFields, 'DYNAMIC_FORM_FIELD', 'PK');

    // добавление
    mtFormFields.First;
    while not mtFormFields.Eof do
    begin
      if mtFormFieldsCHANGED.AsBoolean and mtFormFieldsPK.IsNull then
      begin
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* DYNAMIC_FORM_FIELD */');
        end;

        sl.Add(VariantToDBStr(FMain.dsPortalUserPK.Value, false));
        sl.Add(gcsGenParentParam(Script, Vars, GrCache, mtFormFieldsGROUP_PK.AsVariant, 'GROUP_PK', 'PK', 'DYNAMIC_FORM_FIELD_GROUP'));
        sl.Add(VariantToDBStr(mtFormFieldsGROUP_COLUMN.AsVariant, false));
        sl.Add(VariantToDBStr(mtFormFieldsORDER_.AsVariant, false));
        sl.Add(VariantToDBStr(mtFormFieldsTITLE.AsVariant, true));
        sl.Add(VariantToDBStr(mtFormFieldsDESCRIPTION.AsVariant, true));
        sl.Add(VariantToDBStr(mtFormFieldsTYPE_NAME.AsVariant, true));
        sl.Add(VariantToDBStr(mtFormFieldsFIELD_NAME.AsVariant, true));
        sl.Add(VariantToDBStr(mtFormFieldsSTYLE_EXTERNAL.AsVariant, true));
        sl.Add(VariantToDBStr(mtFormFieldsSTYLE.AsVariant, true));
        sl.Add(VariantToDBStr(mtFormFieldsPARAMETERS.AsVariant, true));
        sl.Add(':FORM_PK');
        if mtFormFieldsGRID_VISIBLE.AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, mtFormFieldsGRID_VISIBLE.AsVariant, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(mtFormFieldsGRID_VISIBLE.AsVariant, false));
        sl.Add(VariantToDBStr(mtFormFieldsGRID_ORDER.AsVariant, false));
        sl.Add(VariantToDBStr(mtFormFieldsGRID_WIDTH.AsVariant, false));
        if mtFormFieldsEDITABLE.AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, mtFormFieldsEDITABLE.AsVariant, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(mtFormFieldsEDITABLE.AsVariant, false));
        if mtFormFieldsADD_EDITABLE.AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, mtFormFieldsADD_EDITABLE.AsVariant, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(mtFormFieldsADD_EDITABLE.AsVariant, false));
        sl.Add(VariantToDBStr(mtFormFieldsEXCEL_EXPORT.AsVariant, false));
        if mtFormFieldsIS_VISIBLE_ADD.AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, mtFormFieldsIS_VISIBLE_ADD.AsVariant, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(mtFormFieldsIS_VISIBLE_ADD.AsVariant, false));
        sl.Add(VariantToDBStr(mtFormFieldsFILTER_ORDER.AsVariant, false));
        sl.Add(VariantToDBStr(mtFormFieldsIS_FILTER.AsVariant, false));
        sl.Add(VariantToDBStr(mtFormFieldsSHOW_IN_START_FORM.AsVariant, false));
        sl.Add(VariantToDBStr(mtFormFieldsSTYLE_COLUMN.AsVariant, true));
        if mtFormFieldsEDIT_IN_TABLE.AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, mtFormFieldsEDIT_IN_TABLE.AsVariant, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(mtFormFieldsEDIT_IN_TABLE.AsVariant, false));
        sl.Add(VariantToDBStr(mtFormFieldsSHOW_IN_GROUP_EDIT.AsVariant, false));
        sl.Add(VariantToDBStr(mtFormFieldsEXCEL_IMPORT.AsVariant, false));
        sl.Add(VariantToDBStr(mtFormFieldsMATCH.AsVariant, false));
        sl.Add(VariantToDBStr(mtFormFieldsLOCKED.AsVariant, false));
        sl.Add(gcsGenParentParam(Script, Vars, FGrCache, mtFormFieldsFILTER_GROUP.AsVariant, 'FILTER_GROUP_PK', 'PK', 'DYNAMIC_FORM_FILTER_GROUP'));
        if mtFormFieldsIS_VISIBLE.AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, mtFormFieldsIS_VISIBLE.AsVariant, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(mtFormFieldsIS_VISIBLE.AsVariant, false));
        sl.Add(VariantToDBStr(mtFormFieldsGUID.AsVariant, true));

        gcsGenInsertSQL(Script, sl, 'DYNAMIC_FORM_FIELD', 'OWNER_USER_PK, GROUP_PK, GROUP_COLUMN, ORDER_, TITLE, DESCRIPTION, TYPE_NAME, ' +
          'FIELD_NAME, STYLE_EXTERNAL, STYLE, PARAMETERS, FORM_PK, GRID_VISIBLE, GRID_ORDER, GRID_WIDTH, EDITABLE, ADD_EDITABLE, EXCEL_EXPORT, ' +
          'IS_VISIBLE_ADD, FILTER_ORDER, IS_FILTER, SHOW_IN_START_FORM, STYLE_COLUMN, EDIT_IN_TABLE, SHOW_IN_GROUP_EDIT, EXCEL_IMPORT, MATCH, ' +
          'LOCKED, FILTER_GROUP, IS_VISIBLE, GUID', [], []);

        result := true;
      end;
      mtFormFields.Next;
    end;

    // обновление
    mtFormFields.First;
    while not mtFormFields.Eof do
    begin
      if mtFormFieldsCHANGED.AsBoolean and (not mtFormFieldsPK.IsNull) then
      begin
        if mtFormFieldsGUID.IsNull then raise Exception.Create(GUID_WARNING);
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* DYNAMIC_FORM_FIELD */');
        end;

        sl.Add(gcsGenParentParam(Script, Vars, GrCache, mtFormFieldsGROUP_PK.AsVariant, 'GROUP_PK', 'PK', 'DYNAMIC_FORM_FIELD_GROUP', 'GROUP_PK = '));
        sl.Add('GROUP_COLUMN = ' + VariantToDBStr(mtFormFieldsGROUP_COLUMN.AsVariant, false));
        sl.Add('ORDER_ = ' + VariantToDBStr(mtFormFieldsORDER_.AsVariant, false));
        sl.Add('TITLE = ' + VariantToDBStr(mtFormFieldsTITLE.AsVariant, true));
        sl.Add('DESCRIPTION = ' + VariantToDBStr(mtFormFieldsDESCRIPTION.AsVariant, true));
        sl.Add('TYPE_NAME = ' + VariantToDBStr(mtFormFieldsTYPE_NAME.AsVariant, true));
        sl.Add('FIELD_NAME = ' + VariantToDBStr(mtFormFieldsFIELD_NAME.AsVariant, true));
        sl.Add('STYLE_EXTERNAL = ' + VariantToDBStr(mtFormFieldsSTYLE_EXTERNAL.AsVariant, true));
        sl.Add('STYLE = ' + VariantToDBStr(mtFormFieldsSTYLE.AsVariant, true));
        sl.Add('PARAMETERS = ' + VariantToDBStr(mtFormFieldsPARAMETERS.AsVariant, true));
        if mtFormFieldsGRID_VISIBLE.AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, mtFormFieldsGRID_VISIBLE.AsVariant, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'GRID_VISIBLE = '))
        else
          sl.Add('GRID_VISIBLE = ' + VariantToDBStr(mtFormFieldsGRID_VISIBLE.AsVariant, false));
        sl.Add('GRID_ORDER = ' + VariantToDBStr(mtFormFieldsGRID_ORDER.AsVariant, false));
        sl.Add('GRID_WIDTH = ' + VariantToDBStr(mtFormFieldsGRID_WIDTH.AsVariant, false));
        if mtFormFieldsEDITABLE.AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, mtFormFieldsEDITABLE.AsVariant, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'EDITABLE = '))
        else
          sl.Add('EDITABLE = ' + VariantToDBStr(mtFormFieldsEDITABLE.AsVariant, false));
        if mtFormFieldsADD_EDITABLE.AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, mtFormFieldsADD_EDITABLE.AsVariant, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'ADD_EDITABLE = '))
        else
          sl.Add('ADD_EDITABLE = ' + VariantToDBStr(mtFormFieldsADD_EDITABLE.AsVariant, false));
        sl.Add('EXCEL_EXPORT = ' + VariantToDBStr(mtFormFieldsEXCEL_EXPORT.AsVariant, false));
        if mtFormFieldsIS_VISIBLE_ADD.AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, mtFormFieldsIS_VISIBLE_ADD.AsVariant, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'IS_VISIBLE_ADD = '))
        else
          sl.Add('IS_VISIBLE_ADD = ' + VariantToDBStr(mtFormFieldsIS_VISIBLE_ADD.AsVariant, false));
        sl.Add('FILTER_ORDER = ' + VariantToDBStr(mtFormFieldsFILTER_ORDER.AsVariant, false));
        sl.Add('IS_FILTER = ' + VariantToDBStr(mtFormFieldsIS_FILTER.AsVariant, false));
        sl.Add('SHOW_IN_START_FORM = ' + VariantToDBStr(mtFormFieldsSHOW_IN_START_FORM.AsVariant, false));
        sl.Add('STYLE_COLUMN = ' + VariantToDBStr(mtFormFieldsSTYLE_COLUMN.AsVariant, true));
        if mtFormFieldsEDIT_IN_TABLE.AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, mtFormFieldsEDIT_IN_TABLE.AsVariant, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'EDIT_IN_TABLE = '))
        else
          sl.Add('EDIT_IN_TABLE = ' + VariantToDBStr(mtFormFieldsEDIT_IN_TABLE.AsVariant, false));
        sl.Add('SHOW_IN_GROUP_EDIT = ' + VariantToDBStr(mtFormFieldsSHOW_IN_GROUP_EDIT.AsVariant, false));
        sl.Add('EXCEL_IMPORT = ' + VariantToDBStr(mtFormFieldsEXCEL_IMPORT.AsVariant, false));
        sl.Add('MATCH = ' + VariantToDBStr(mtFormFieldsMATCH.AsVariant, false));
        sl.Add('LOCKED = ' + VariantToDBStr(mtFormFieldsLOCKED.AsVariant, false));
        if mtFormFieldsIS_VISIBLE.AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, mtFormFieldsIS_VISIBLE.AsVariant, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'IS_VISIBLE = '))
        else
          sl.Add('IS_VISIBLE = ' + VariantToDBStr(mtFormFieldsIS_VISIBLE.AsVariant, false));
        sl.Add(gcsGenParentParam(Script, Vars, FGrCache, mtFormFieldsFILTER_GROUP.AsVariant, 'FILTER_GROUP_PK', 'PK', 'DYNAMIC_FORM_FILTER_GROUP', 'FILTER_GROUP = '));

        result := gcsGenUpdateSQL(Script, sl, 'DYNAMIC_FORM_FIELD', 'GUID', VariantToDBStr(mtFormFieldsGUID.AsVariant, true), []);
      end;
      mtFormFields.Next;
    end;
  finally
    sl.Free;
    if mtFormFields.BookmarkValid(bm) then
    begin
      mtFormFields.GotoBookmark(bm);
      mtFormFields.FreeBookmark(bm);
    end;
    mtFormFields.EnableControls;
  end;
end;

function TFEditForm.gcsForm(Script, Vars: TStringList): boolean;
var
  sl: TStringList;

begin
  sl := TStringList.Create;
  result := false;

  try
    gcsCheckOption(sl, dsFormALIAS_FORM, Trim(edFormAlias.Text), true);
    gcsCheckOption(sl, dsFormTITLE, Trim(edFormTitle.Text), true);
    gcsCheckOption(sl, dsFormWIDTH, edFormWidth.Value, false, true, true);
    gcsCheckOption(sl, dsFormHEIGHT, edFormHeight.Value, false, true, true);
    gcsCheckOption(sl, dsFormLEFT_ALIGN, iif(chbLeftAlign.Checked, 1, 0), false);
    gcsCheckOption(sl, dsFormLABEL_WIDTH, edLabelWidth.Value, false, true, true);

    result := gcsGenUpdateSQL(Script, sl, 'DYNAMIC_FORM', 'PK', ':FORM_PK', ['MODIFY = current_timestamp'], '/* DYNAMIC_FORM */');
  finally
    sl.Free;
  end;
end;

function TFEditForm.gcsGroups(Script, Vars, Cache: TStringList): boolean;
var
  bm: TBookmark;
  sl: TStringList;
  n: integer;

begin
  result := false;
  sl := TStringList.Create;

  try
    // удаление
    result := gcsGenDeleteSQL(Script, DeletedGroups, 'DYNAMIC_FORM_FIELD_GROUP', 'PK');

    bm := mtGroups.GetBookmark;
    mtGroups.DisableControls;

    // добавление
    mtGroups.First;
    while not mtGroups.Eof do
    begin
      if mtGroupsCHANGED.AsBoolean and mtGroupsPK.IsNull then
      begin
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* DYNAMIC_FORM_FIELD_GROUP */');
        end;

        sl.Add(gcsGenParentParam(Script, Vars, Cache, mtGroupsPARENT_PK.AsVariant, 'GROUP_PK', 'PK', 'DYNAMIC_FORM_FIELD_GROUP'));
        sl.Add(VariantToDBStr(FMain.dsPortalUserPK.Value, false));
        sl.Add(':FORM_PK');
        sl.Add(VariantToDBStr(mtGroupsORDER_.AsVariant, false));
        sl.Add(VariantToDBStr(mtGroupsTITLE.AsVariant, true));
        sl.Add(VariantToDBStr(mtGroupsDESCRIPTION.AsVariant, true));
        sl.Add(VariantToDBStr(mtGroupsCOUNT_COLUMN.AsVariant, false));
        sl.Add(VariantToDBStr(mtGroupsSTYLE_EXTERNAL.AsVariant, true));
        sl.Add(VariantToDBStr(mtGroupsSTYLE_INTERNAL.AsVariant, true));
        sl.Add(VariantToDBStr(mtGroupsIS_VISIBLE.AsVariant, true));
        sl.Add(VariantToDBStr(mtGroupsCOLUMN_.AsVariant, false));
        sl.Add(VariantToDBStr(mtGroupsSTYLE_COLUMNS.AsVariant, true));
        sl.Add(VariantToDBStr(mtGroupsADD_VISIBLE.AsVariant, false));
        sl.Add(VariantToDBStr(mtGroupsCOLLAPSED.AsVariant, false));
        sl.Add(VariantToDBStr(mtGroupsLEFT_ALIGN.AsVariant, false));
        sl.Add(VariantToDBStr(mtGroupsLABEL_WIDTH.AsVariant, false));
        sl.Add(VariantToDBStr(mtGroupsGUID.AsVariant, true));

        n := Cache.Add(mtGroupsGUID.AsString);
        Vars.Add('declare variable GROUP_PK' + IntToStr(n) + ' integer;');

        gcsGenInsertSQL(Script, sl, 'DYNAMIC_FORM_FIELD_GROUP', 'PARENT_PK, OWNER_USER_PK, FORM_PK, ORDER_, TITLE, DESCRIPTION, COUNT_COLUMN, STYLE_EXTERNAL, ' +
          'STYLE_INTERNAL, IS_VISIBLE, COLUMN_, STYLE_COLUMNS, ADD_VISIBLE, COLLAPSED, LEFT_ALIGN, LABEL_WIDTH, GUID', ['PK'], [':GROUP_PK' + IntToStr(n)]);

        result := true;
      end;
      mtGroups.Next;
    end;

    // обновление
    mtGroups.First;
    while not mtGroups.Eof do
    begin
      if mtGroupsCHANGED.AsBoolean and (not mtGroupsPK.IsNull) then
      begin
        if mtGroupsGUID.IsNull then raise Exception.Create(GUID_WARNING);
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* DYNAMIC_FORM_FIELD_GROUP */');
        end;

        sl.Add(gcsGenParentParam(Script, Vars, Cache, mtGroupsPARENT_PK.AsVariant, 'GROUP_PK', 'PK', 'DYNAMIC_FORM_FIELD_GROUP', 'PARENT_PK = '));
        sl.Add('ORDER_ = ' + VariantToDBStr(mtGroupsORDER_.AsVariant, false));
        sl.Add('TITLE = ' + VariantToDBStr(mtGroupsTITLE.AsVariant, true));
        sl.Add('DESCRIPTION = ' + VariantToDBStr(mtGroupsDESCRIPTION.AsVariant, true));
        sl.Add('COUNT_COLUMN = ' + VariantToDBStr(mtGroupsCOUNT_COLUMN.AsVariant, false));
        sl.Add('STYLE_EXTERNAL = ' + VariantToDBStr(mtGroupsSTYLE_EXTERNAL.AsVariant, true));
        sl.Add('STYLE_INTERNAL = ' + VariantToDBStr(mtGroupsSTYLE_INTERNAL.AsVariant, true));
        sl.Add('IS_VISIBLE = ' + VariantToDBStr(mtGroupsIS_VISIBLE.AsVariant, true));
        sl.Add('COLUMN_ = ' + VariantToDBStr(mtGroupsCOLUMN_.AsVariant, false));
        sl.Add('STYLE_COLUMNS = ' + VariantToDBStr(mtGroupsSTYLE_COLUMNS.AsVariant, true));
        sl.Add('ADD_VISIBLE = ' + VariantToDBStr(mtGroupsADD_VISIBLE.AsVariant, false));
        sl.Add('COLLAPSED = ' + VariantToDBStr(mtGroupsCOLLAPSED.AsVariant, false));
        sl.Add('LEFT_ALIGN = ' + VariantToDBStr(mtGroupsLEFT_ALIGN.AsVariant, false));
        sl.Add('LABEL_WIDTH = ' + VariantToDBStr(mtGroupsLABEL_WIDTH.AsVariant, false));

        result := gcsGenUpdateSQL(Script, sl, 'DYNAMIC_FORM_FIELD_GROUP', 'GUID', VariantToDBStr(mtGroupsGUID.AsVariant, true), []);
      end;
      mtGroups.Next;
    end;
  finally
    sl.Free;
    if mtGroups.BookmarkValid(bm) then
    begin
      mtGroups.GotoBookmark(bm);
      mtGroups.FreeBookmark(bm);
    end;
    mtGroups.EnableControls;
  end;
end;

function TFEditForm.gcsTemplates(Script, Vars, Cache, PkList: TStringList): boolean;
var
  ds: TpFIBDataSet;
  n: integer;

begin
  result := false;
  if PkList.Count = 0 then exit;

  try
    ds := FMain.OpenSQL('select GUID, TEXT_TEMPLATE from DYNAMIC_FORM_PERM_TMP where PK in (' + TextToString(PkList.Text) + ')');

    while not ds.Eof do
    begin
      if ds.FieldByName('GUID').IsNull then raise Exception.Create(GUID_WARNING);

      if not result then
      begin
        Script.Add('');
        Script.Add('  /* DYNAMIC_FORM_PERM_TMP */');
      end;

      if Cache.IndexOf(ds.FieldByName('GUID').AsString) = -1 then
      begin
        n := Cache.Add(ds.FieldByName('GUID').AsString);
        Vars.Add('declare variable TMPL_PK' + IntToStr(n) + ' integer;');
        Script.Add('');
        Script.Add('  select PK from DYNAMIC_FORM_PERM_TMP where GUID = ' + VariantToDBStr(ds.FieldByName('GUID').AsString, true) + ' into :TMPL_PK' + IntToStr(n) + ';');
        result := true;
      end;
      ds.Next;
    end;
  finally
    ds.Close;
    ds.Free;
  end;
end;

function TFEditForm.GenChangesSQL(Script, Vars: TStringList): boolean;
var
  grCache, tmplCache, filterGrCache: TStringList;

begin
  result := false;
  filterGrCache := TStringList.Create;
  grCache := TStringList.Create;
  tmplCache := TStringList.Create;

  try
    Vars.Add('declare variable FORM_PK integer;');
    Script.Add('  select PK from DYNAMIC_FORM where GUID = ''' + dsFormGUID.AsString + ''' into :FORM_PK;');

    result := gcsForm(Script, Vars);
    if gcsGroups(Script, Vars, grCache) then result := true;
    if gcsFields(Script, Vars, grCache, tmplCache, filterGrCache) then result := true;
  finally
    filterGrCache.Free;
    grCache.Free;
    tmplCache.Free;
  end;
end;

function TFEditForm.GetColumnStyles(dsSrc: TMemTableEh): string;
begin
  result := '';
  if dsSrc.IsEmpty then exit;

  dsSrc.DisableControls;
  try
    dsSrc.First;
    while not dsSrc.Eof do
    begin
      if result = '' then
        result := '"' + Trim(PyAnsiToUnicode(dsSrc.FieldByName('STYLE').AsString)) + '"'
      else
        result := result + ', "' + Trim(PyAnsiToUnicode(dsSrc.FieldByName('STYLE').AsString)) + '"';

      dsSrc.Next;
    end;
    result := '[' + result + ']';
  finally
    dsSrc.EnableControls;
  end;
end;

function TFEditForm.GetFieldTypeParams(OptList: TContainer): string;
var
  i: integer;

begin
  result := '';

  for i := 0 to OptList.Count - 1 do
  begin
    if result = '' then
      result := OptList.OptionRecByIndex[i].Expression
    else
      result := result + ', ' + OptList.OptionRecByIndex[i].Expression;
  end;
  result := '{' + result + '}';
end;

function TFEditForm.GetShortCaption: string;
begin
  if Mode = omAdd then
    result := Caption
  else
    result := edFormTitle.Text + iif(edFormAlias.Text <> '', ' : ' + edFormAlias.Text, '');
end;

procedure TFEditForm.GroupEdit(Grid: TDBGridEh);
var
  fGrEdit: TFGroupEdit;
  i, j: integer;
  data: TStringList;
  bm: TBookmark;
  DataSet: TMemTableEh;

begin
  if Mode = omView then exit;
  
  if (not Assigned(Grid)) or (not Assigned(Grid.DataSource)) or (not Assigned(Grid.DataSource.DataSet)) then exit;
  DataSet := TMemTableEh(Grid.DataSource.DataSet);

  if (not DataSet.Active) or DataSet.IsEmpty then exit;
  if Grid.SelectedRows.Count <= 1 then exit;

  fGrEdit := TFGroupEdit.Create(Self);
  bm := DataSet.GetBookmark;
  DataSet.DisableControls;
  try
    if fGrEdit.Execute(Grid) then
    begin
      data := fGrEdit.GetData;
      for i := 0 to Grid.SelectedRows.Count - 1 do
        if DataSet.BookmarkValid(TBookmark(Grid.SelectedRows.Items[i])) then
        begin
          DataSet.GotoBookmark(TBookmark(Grid.SelectedRows.Items[i]));
          DataSet.Edit;
          for j := 0 to data.Count - 1 do
            DataSet.FieldByName(data.Names[j]).AsString := data.Values[data.Names[j]];

          DataSet.Post;
        end;
    end;
  finally
    fGrEdit.Free;
    Grid.SelectedRows.Clear;
    if DataSet.BookmarkValid(bm) then DataSet.GotoBookmark(bm)
    else DataSet.First;
    DataSet.EnableControls;
  end;
end;

procedure TFEditForm.LoadColumnStyles(dsDest: TMemTableEh; StylesStr: string);
var
  json: TJson;

begin
  if dsDest.IsEmpty then exit;

  json := TJson.Create;
  dsDest.DisableControls;
  try
    json.Load(StylesStr);
    
    dsDest.First;
    while not dsDest.Eof do
    begin
      dsDest.Edit;
      dsDest.FieldByName('STYLE').AsString := json.ValueOf(dsDest.FieldByName('COLUMN_').AsInteger);
      dsDest.Post;
      dsDest.Next;
    end;
    dsDest.First;
  finally
    json.Free;
    dsDest.EnableControls;
  end;
end;

procedure TFEditForm.LoadFieldTypeParams(OptList: TContainer; OptionsStr: string);
var
  i: integer;
  opt: TOptionRecord;
  sl: TStringList;
  json: TJson;

begin
  sl := TStringList.Create;
  json := TJson.Create;
  try
    json.Load(OptionsStr);

    for i := 0 to json.KeyCount - 1 do
    begin
      opt := OptList.OptionRecByName[json.Keys[i]];
      try
        if Assigned(opt) then opt.Value := json.ValueOf(json.Keys[i]);
      except
        {on e: Exception do Application.MessageBox(pchar('Не удалось задать значение поля ' + opt.Name + '. Ошибка: ' + e.Message),
          'Ошибка', MB_OK + MB_ICONERROR);}
      end;
    end;

    // нужно в правильном порядке выставить опции, зависящие от BaseDescriptor (только те, которые меняются при его смене)
    sl.Text := OPT_baseDescriptor + FIELDTYPEDELIM + OPT_fkTable + FIELDTYPEDELIM + OPT_fkField + FIELDTYPEDELIM + OPT_displayField;
    for i := 0 to sl.Count - 1 do
    begin
      opt := OptList.OptionRecByName[sl.Strings[i]];
      if Assigned(opt) then
      begin
        try
          opt.Value := json.ValueOf(opt.Name);
          if Assigned(opt.OnOptChange) then opt.OnOptChange(opt);
        except
          {on e: Exception do Application.MessageBox(pchar('Не удалось задать значение поля ' + opt.Name + '. Ошибка: ' + e.Message),
            'Ошибка', MB_OK + MB_ICONERROR);}
        end;
      end;
    end;
  finally
    sl.Free;
    json.Free;
  end;
end;

procedure TFEditForm.LoadGridData;
var
  i: integer;

begin
  mtFormFields.DisableControls;
  try
    IsLoadingGrid := true;
    if mtFormFields.Active then
    begin
      mtFormFields.EmptyTable;
      mtFormFields.Close;
    end;
    mtFormFields.CreateDataSet;

    if not VarIsNull(Properties.PK) then
    begin
      dsFormFields.Close;
      dsFormFields.ParamByName('PK').Value := Properties.PK;
      dsFormFields.Open;
      dsFormFields.First;

      while not dsFormFields.Eof do
      begin
        mtFormFields.Append;
        mtFormFieldsCHANGED.AsBoolean := false;
        for i := 0 to dsFormFields.FieldCount - 1 do
          mtFormFields.FieldByName(dsFormFields.Fields.Fields[i].FieldName).Value := dsFormFields.Fields.Fields[i].Value;

        mtFormFields.Post;
        mtFormFieldsORDER_.Tag := Max(mtFormFieldsORDER_.AsInteger, mtFormFieldsORDER_.Tag);
        mtFormFieldsGRID_ORDER.Tag := Max(mtFormFieldsGRID_ORDER.AsInteger, mtFormFieldsGRID_ORDER.Tag);
        dsFormFields.Next;
      end;
      dsFormFields.Close;
      mtFormFields.First;
    end;
  finally
    IsLoadingGrid := false;
    mtFormFields.EnableControls;
  end;
end;

procedure TFEditForm.LoadGroups;
var
  i: integer;

begin
  mtGroups.DisableControls;
  try
    IsLoadingGrid := true;
    if mtGroups.Active then
    begin
      mtGroups.EmptyTable;
      mtGroups.Close;
    end;
    mtGroups.CreateDataSet;

    if not VarIsNull(Properties.PK) then
    begin
      dsGroups.Close;
      dsGroups.ParamByName('PK').Value := Properties.PK;
      dsGroups.Open;
      dsGroups.First;

      while not dsGroups.Eof do
      begin
        mtGroups.Append;
        mtGroupsCHANGED.AsBoolean := false;
        for i := 0 to dsGroups.FieldCount - 1 do
          mtGroups.FieldByName(dsGroups.Fields.Fields[i].FieldName).Value := dsGroups.Fields.Fields[i].Value;

        mtGroups.Post;
        mtGroupsORDER_.Tag := Max(mtGroupsORDER_.AsInteger, mtGroupsORDER_.Tag);
        dsGroups.Next;
      end;
      dsGroups.Close;
      mtGroups.First;
    end;
  finally
    IsLoadingGrid := false;
    mtGroups.EnableControls;
  end;
end;

procedure TFEditForm.LoadLookups;
begin
  dsFieldGroups.Close;
  dsFieldGroups.ParamByName('FORM_PK').Value := Properties.PK;
  dsFieldGroups.Open;
  dsLFilterGroups.Close;
  dsLFilterGroups.ParamByName('FORM_PK').Value := Properties.PK;
  dsLFilterGroups.Open;
end;

procedure TFEditForm.mtFormFieldsAfterInsert(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    AutoIncFields;
    mtFormFieldsOWNER_USER_PK.AsInteger := FMain.dsPortalUserPK.AsInteger;
    mtFormFieldsGROUP_COLUMN.AsInteger := 0;
    mtFormFieldsORDER_.AsInteger := mtFormFieldsORDER_.Tag;
    mtFormFieldsTYPE_NAME.AsString := 'text';
    mtFormFieldsIS_VISIBLE.AsInteger := 1;
    mtFormFieldsGRID_VISIBLE.AsInteger := 0;
    mtFormFieldsGRID_ORDER.AsInteger := mtFormFieldsGRID_ORDER.Tag;
    mtFormFieldsEDITABLE.AsInteger := 1;
    mtFormFieldsADD_EDITABLE.AsInteger := 1;
    mtFormFieldsEXCEL_EXPORT.AsInteger := 0;
    mtFormFieldsIS_VISIBLE_ADD.AsInteger := 1;
    mtFormFieldsFILTER_ORDER.AsInteger := 0;
    mtFormFieldsIS_FILTER.AsInteger := 0;
    mtFormFieldsSHOW_IN_START_FORM.AsInteger := 0;
    mtFormFieldsEDIT_IN_TABLE.AsInteger := 0;
    mtFormFieldsSHOW_IN_GROUP_EDIT.AsInteger := 0;
    mtFormFieldsEXCEL_IMPORT.AsInteger := 0;
    mtFormFieldsMATCH.AsInteger := 0;
    mtFormFieldsLOCKED.AsInteger := 0;
  end;
end;

procedure TFEditForm.mtFormFieldsAfterScroll(DataSet: TDataSet);
begin
  if mtFormFields.ControlsDisabled then exit;
  edCurrField.Text := iif(mtFormFieldsOBJECT_NAME.IsNull, '', mtFormFieldsOBJECT_NAME.AsString + '.') +
    mtFormFieldsFIELD_NAME.AsString + '  ' + mtFormFieldsTITLE.AsString + '  ' + mtFormFieldsTYPE_NAME.AsString;
end;

procedure TFEditForm.mtFormFieldsBeforeDelete(DataSet: TDataSet);
begin
  if mtFormFieldsPK.AsString <> '' then DeletedFields.Add(mtFormFieldsPK.AsString);
end;

procedure TFEditForm.mtFormFieldsBeforePost(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    if mtFormFieldsTITLE.IsNull or mtFormFieldsFIELD_NAME.IsNull or mtFormFieldsPARAMETERS.IsNull then
      raise Exception.Create('Не все обязательные поля заполнены!');

    mtFormFieldsCHANGED.AsBoolean := true;
    if mtFormFieldsGUID.IsNull then mtFormFieldsGUID.AsString := CreateGuid;
  end;
end;

procedure TFEditForm.mtGroupsAfterInsert(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    AutoIncGroups;
    mtGroupsOWNER_USER_PK.AsInteger := FMain.dsPortalUserPK.AsInteger;
    mtGroupsORDER_.AsInteger := mtFormFieldsORDER_.Tag;
    mtGroupsCOUNT_COLUMN.AsInteger := 1;
    mtGroupsIS_VISIBLE.AsString := '1';
    mtGroupsCOLUMN_.AsInteger := 0;
    mtGroupsADD_VISIBLE.AsInteger := 1;
    mtGroupsCOLLAPSED.AsInteger := 0;
    mtGroupsLEFT_ALIGN.AsInteger := 0;
    mtGroupsCREATE_.AsDateTime := Now;
  end;
end;

procedure TFEditForm.mtGroupsBeforeDelete(DataSet: TDataSet);
begin
  if mtGroupsPK.AsString <> '' then DeletedGroups.Add(mtGroupsPK.AsString);
end;

procedure TFEditForm.mtGroupsBeforePost(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    if mtGroupsTITLE.IsNull then raise Exception.Create('Не все обязательные поля заполнены!');
    mtGroupsCHANGED.AsBoolean := true;
    if mtGroupsGUID.IsNull then mtGroupsGUID.AsString := CreateGuid;
  end;
end;

procedure TFEditForm.OnFieldEditorClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if TFFieldEditor(Sender).Success then
  begin
    if mtFormFields.State in [dsEdit, dsInsert] then
    begin
      case Application.MessageBox(pchar('Невозможно сохранить данные, пока таблица полей в режиме редактирования! Сначала нужно сохранить ' +
        'или отменить изменения в таблице. Сохранить изменения [YES], оменить [NO], или отложить сохранение формы [CANCEL] ' +
        '(сохранить эти данные можно будет позже)?'), 'Подтверждение', MB_YESNOCANCEL + MB_ICONQUESTION) of
        ID_YES: mtFormFields.Post;
        ID_NO: mtFormFields.Cancel;
        ID_CANCEL:
        begin
          TFFieldEditor(Sender).Success := false;
          Action := caNone;
        end;
      end;
    end;

    if Action <> caNone then ApplyFieldEditorData(TFFieldEditor(Sender));
  end;
end;

procedure TFEditForm.OnGroupEditorClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if TFGroupEditor(Sender).Success then
  begin
    if mtGroups.State in [dsEdit, dsInsert] then
    begin
      case Application.MessageBox(pchar('Невозможно сохранить данные, пока таблица групп в режиме редактирования! Сначала нужно сохранить ' +
        'или отменить изменения в таблице. Сохранить изменения [YES], оменить [NO], или отложить сохранение формы [CANCEL] ' +
        '(сохранить эти данные можно будет позже)?'), 'Подтверждение', MB_YESNOCANCEL + MB_ICONQUESTION) of
        ID_YES: mtGroups.Post;
        ID_NO: mtGroups.Cancel;
        ID_CANCEL:
        begin
          TFGroupEditor(Sender).Success := false;
          Action := caNone;
        end;
      end;
    end;

    if Action <> caNone then ApplyGroupEditorData(TFGroupEditor(Sender));
  end;
end;

procedure TFEditForm.OnJsonEditorClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if TFJsonReader(Sender).Success then ApplyJsonEditorData(TFJsonReader(Sender));
end;

function TFEditForm.OpenJsonEditor(Field: TField; StatusText: string): TFJsonReader;
var
  ds: TMemTableEh;
  m: TOpenMode;

begin
  result := nil;
  if (not Assigned(Field)) or (not Assigned(Field.DataSet)) or Field.DataSet.IsEmpty then exit;

  if Mode = omView then m := omView
  else m := omEdit;

  ds := TMemTableEh(Field.DataSet);

  if FMain.SetFocusOpenedWindow(ds.FieldByName('PK').AsInteger, TFJsonReader.ClassName) then exit;
  result := TFJsonReader.Create(Self, cftEditor, m, ds.FieldByName('PK').AsVariant, FMain.OnChildFormClose);
  result.EditingRec := ds.GetBookmark;
  result.Field := Field;
  result.OnClose := OnJsonEditorClose;
  result.ASaveToField.Visible := true;
  result.StatusBar.Panels[1].Text := StatusText;
  result.LoadText(Field.AsString);
  result.RegisterForm;
end;

function TFEditForm.SaveData: boolean;
var
  err: string;

begin
  if Trim(edFormAlias.Text) = '' then
  begin
    result := false;
    Application.MessageBox('Дескриптор формы не может быть пустым!', 'Ошибка', MB_OK + MB_ICONERROR);
    exit;
  end;

  case Mode of
    omAdd:
    begin
      result := FMain.ExecSQL('insert into DYNAMIC_FORM (OWNER_USER_PK, TITLE, WIDTH, HEIGHT, ALIAS_FORM, LEFT_ALIGN, LABEL_WIDTH, GUID) values (' +
        VariantToDBStr(FMain.dsPortalUserPK.Value, false) + ', ' + VariantToDBStr(Trim(edFormTitle.Text), true) + ', ' +
        VariantToDBStr(edFormWidth.Value, false, true, true) + ', ' + VariantToDBStr(edFormHeight.Value, false, true, true) + ', ' +
        VariantToDBStr(Trim(edFormAlias.Text), true) + ', ' + iif(chbLeftAlign.Checked, '1', '0') + ', ' +
        VariantToDBStr(edLabelWidth.Value, false, true, true) + ', ' + VariantToDBStr(Properties.Guid, true) + ') returning (PK)', 'PK', Properties.PK, err);
      FMain.AddToRefLog(cotForm, iif(Trim(edFormAlias.Text) = '', edFormTitle.Text, edFormAlias.Text), Properties.Guid, rltCreate);
    end;
    omEdit:
    begin
      result := FMain.ExecSQL('update DYNAMIC_FORM set MODIFY = current_timestamp, TITLE = ' +
        VariantToDBStr(Trim(edFormTitle.Text), true) + ', WIDTH = ' + VariantToDBStr(edFormWidth.Value, false, true, true) +
        ', HEIGHT = ' + VariantToDBStr(edFormHeight.Value, false, true, true) + ', ALIAS_FORM = ' +
        VariantToDBStr(Trim(edFormAlias.Text), true) + ', LEFT_ALIGN = ' + iif(chbLeftAlign.Checked, '1', '0') +
        ', LABEL_WIDTH = ' + VariantToDBStr(edLabelWidth.Value, false, true, true) + ', GUID = ' + VariantToDBStr(Properties.Guid, true) +
        ' where PK = ' + VarToStr(Properties.PK), err);
      FMain.AddToRefLog(cotForm, iif(Trim(edFormAlias.Text) = '', edFormTitle.Text, edFormAlias.Text), Properties.Guid, rltUpdate,
        iif(Trim(edFormAlias.Text) = '', 'PK ' + VarToStr(Properties.PK), ''));
    end
    else result := false;
  end;

  if (err <> '') then Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);

  if result then
  begin
    SetPropValues(Properties.PK, iif(Trim(edFormAlias.Text) = '', Null, Trim(edFormAlias.Text)),
      iif(Trim(edFormTitle.Text) = '', Null, Trim(edFormTitle.Text)), Properties.ParentDictPK, Properties.FolderPK,
      Properties.Login, Properties.ObjType, Properties.Guid);
    SaveGridData;
  end;
end;

procedure TFEditForm.SaveGridData;
var
  err: string;

begin
  if mtFormFields.State in [dsEdit, dsInsert] then mtFormFields.Post;
  if mtGroups.State in [dsEdit, dsInsert] then mtGroups.Post;

  if Mode = omView then exit;

  // удаление полей
  if DeletedFields.Count > 0 then
  begin
    if not FMain.ExecSQL('delete from DYNAMIC_FORM_FIELD where PK in (' + TextToString(DeletedFields.Text) + ')', err) then
    begin
      Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;
    DeletedFields.Clear;
  end;

  // вставка/обновление
  try
    mtFormFields.First;
    while not mtFormFields.Eof do
    begin
      if mtFormFieldsCHANGED.AsBoolean then
      begin
        qEditField.Close;
        qEditField.ParamByName('PK').Value := mtFormFields.FieldByName('PK').Value;
        qEditField.ParamByName('OWNER_USER_PK').Value := mtFormFields.FieldByName('OWNER_USER_PK').Value;
        qEditField.ParamByName('GROUP_PK').Value := mtFormFields.FieldByName('GROUP_PK').Value;
        qEditField.ParamByName('GROUP_COLUMN').Value := mtFormFields.FieldByName('GROUP_COLUMN').Value;
        qEditField.ParamByName('ORDER_').Value := mtFormFields.FieldByName('ORDER_').Value;
        qEditField.ParamByName('TITLE').Value := mtFormFields.FieldByName('TITLE').Value;
        qEditField.ParamByName('DESCRIPTION').Value := mtFormFields.FieldByName('DESCRIPTION').AsString;
        qEditField.ParamByName('TYPE_NAME').Value := mtFormFields.FieldByName('TYPE_NAME').Value;
        qEditField.ParamByName('FIELD_NAME').Value := mtFormFields.FieldByName('FIELD_NAME').Value;
        qEditField.ParamByName('STYLE_EXTERNAL').Value := mtFormFields.FieldByName('STYLE_EXTERNAL').AsString;
        qEditField.ParamByName('STYLE').Value := mtFormFields.FieldByName('STYLE').AsString;
        qEditField.ParamByName('PARAMETERS').Value := mtFormFields.FieldByName('PARAMETERS').Value;
        qEditField.ParamByName('IS_VISIBLE').Value := mtFormFields.FieldByName('IS_VISIBLE').Value;
        qEditField.ParamByName('FORM_PK').Value := Properties.PK;
        qEditField.ParamByName('GRID_VISIBLE').Value := mtFormFields.FieldByName('GRID_VISIBLE').Value;
        qEditField.ParamByName('GRID_ORDER').Value := mtFormFields.FieldByName('GRID_ORDER').Value;
        qEditField.ParamByName('GRID_WIDTH').Value := mtFormFields.FieldByName('GRID_WIDTH').Value;
        qEditField.ParamByName('EDITABLE').Value := mtFormFields.FieldByName('EDITABLE').Value;
        qEditField.ParamByName('ADD_EDITABLE').Value := mtFormFields.FieldByName('ADD_EDITABLE').Value;
        qEditField.ParamByName('EXCEL_EXPORT').Value := mtFormFields.FieldByName('EXCEL_EXPORT').Value;
        qEditField.ParamByName('IS_VISIBLE_ADD').Value := mtFormFields.FieldByName('IS_VISIBLE_ADD').Value;
        qEditField.ParamByName('FILTER_ORDER').Value := mtFormFields.FieldByName('FILTER_ORDER').Value;
        qEditField.ParamByName('IS_FILTER').Value := mtFormFields.FieldByName('IS_FILTER').Value;
        qEditField.ParamByName('FILTER_GROUP').Value := mtFormFields.FieldByName('FILTER_GROUP').Value;
        qEditField.ParamByName('SHOW_IN_START_FORM').Value := mtFormFields.FieldByName('SHOW_IN_START_FORM').Value;
        qEditField.ParamByName('STYLE_COLUMN').Value := mtFormFields.FieldByName('STYLE_COLUMN').Value;
        qEditField.ParamByName('EDIT_IN_TABLE').Value := mtFormFields.FieldByName('EDIT_IN_TABLE').Value;
        qEditField.ParamByName('SHOW_IN_GROUP_EDIT').Value := mtFormFields.FieldByName('SHOW_IN_GROUP_EDIT').Value;
        qEditField.ParamByName('EXCEL_IMPORT').Value := mtFormFields.FieldByName('EXCEL_IMPORT').Value;
        qEditField.ParamByName('MATCH').Value := mtFormFields.FieldByName('MATCH').Value;
        qEditField.ParamByName('LOCKED').Value := mtFormFields.FieldByName('LOCKED').Value;
        qEditField.ParamByName('GUID').Value := mtFormFields.FieldByName('GUID').Value;
        qEditField.ExecQuery;
        FMain.Transact.CommitRetaining;
      end;
      mtFormFields.Next;
    end;
  except
    on E: Exception do Application.MessageBox(pchar(E.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;

  // удаление групп
  if DeletedGroups.Count > 0 then
  begin
    if not FMain.ExecSQL('delete from DYNAMIC_FORM_FIELD_GROUP where PK in (' + TextToString(DeletedGroups.Text) + ')', err) then
    begin
      Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;
    DeletedGroups.Clear;
  end;

  // вставка/обновление
  try
    mtGroups.First;
    while not mtGroups.Eof do
    begin
      if mtGroupsCHANGED.AsBoolean then
      begin
        qEditGroup.Close;
        qEditGroup.ParamByName('PK').Value := mtGroups.FieldByName('PK').Value;
        qEditGroup.ParamByName('PARENT_PK').Value := mtGroups.FieldByName('PARENT_PK').Value;
        qEditGroup.ParamByName('OWNER_USER_PK').Value := mtGroups.FieldByName('OWNER_USER_PK').Value;
        qEditGroup.ParamByName('FORM_PK').Value := Properties.PK;
        qEditGroup.ParamByName('ORDER_').Value := mtGroups.FieldByName('ORDER_').Value;
        qEditGroup.ParamByName('TITLE').Value := mtGroups.FieldByName('TITLE').AsString;
        qEditGroup.ParamByName('DESCRIPTION').Value := mtGroups.FieldByName('DESCRIPTION').Value;
        qEditGroup.ParamByName('COUNT_COLUMN').Value := mtGroups.FieldByName('COUNT_COLUMN').Value;
        qEditGroup.ParamByName('STYLE_EXTERNAL').Value := mtGroups.FieldByName('STYLE_EXTERNAL').AsString;
        qEditGroup.ParamByName('STYLE_INTERNAL').Value := mtGroups.FieldByName('STYLE_INTERNAL').AsString;
        qEditGroup.ParamByName('CREATE_').Value := mtGroups.FieldByName('CREATE_').Value;
        qEditGroup.ParamByName('MODIFY').AsDateTime := Now;
        qEditGroup.ParamByName('IS_VISIBLE').Value := mtGroups.FieldByName('IS_VISIBLE').Value;
        qEditGroup.ParamByName('COLUMN_').Value := mtGroups.FieldByName('COLUMN_').Value;
        qEditGroup.ParamByName('STYLE_COLUMNS').Value := mtGroups.FieldByName('STYLE_COLUMNS').AsString;
        qEditGroup.ParamByName('ADD_VISIBLE').Value := mtGroups.FieldByName('ADD_VISIBLE').Value;
        qEditGroup.ParamByName('COLLAPSED').Value := mtGroups.FieldByName('COLLAPSED').Value;
        qEditGroup.ParamByName('LEFT_ALIGN').Value := mtGroups.FieldByName('LEFT_ALIGN').Value;
        qEditGroup.ParamByName('LABEL_WIDTH').Value := mtGroups.FieldByName('LABEL_WIDTH').Value;
        qEditGroup.ParamByName('GUID').Value := mtGroups.FieldByName('GUID').Value;
        qEditGroup.ExecQuery;
        FMain.Transact.CommitRetaining;
      end;
      mtGroups.Next;
    end;
  except
    on E: Exception do Application.MessageBox(pchar(E.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFEditForm.sbDelClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (not mtFormFields.Active) or mtFormFields.IsEmpty then exit;

  if dbgFormFields.SelectedRows.Count > 1 then
  begin
    if Application.MessageBox(pchar('Удалить все отмеченные поля (' + IntToStr(dbgFormFields.SelectedRows.Count) + ')?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    dbgFormFields.SelectedRows.Delete;
  end else
  begin
    if Application.MessageBox(pchar('Удалить поле "' + mtFormFieldsTITLE.AsString + '"?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    mtFormFields.Delete;
  end;
end;

procedure TFEditForm.sbDelGroupClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (not mtGroups.Active) or mtGroups.IsEmpty then exit;

  if dbgGroups.SelectedRows.Count > 1 then
  begin
    if Application.MessageBox(pchar('Удалить все отмеченные группы (' + IntToStr(dbgGroups.SelectedRows.Count) + ')?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    dbgGroups.SelectedRows.Delete;
  end else
  begin
    if Application.MessageBox(pchar('Удалить группу "' + mtGroupsTITLE.AsString + '"?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    mtGroups.Delete;
  end;
end;

procedure TFEditForm.sbEditClick(Sender: TObject);
var
  FFieldEditor: TFFieldEditor;
  m: TOpenMode;

begin
  if mtFormFields.IsEmpty then exit;

  if Mode = omView then m := omView
  else m := omEdit;

  if dbgFormFields.SelectedRows.Count > 1 then
  begin
    GroupEdit(dbgFormFields);
    exit;
  end;

  // открытие формы редактирования поля
  if FMain.SetFocusOpenedWindow(mtFormFieldsPK.AsInteger, TFFieldEditor.ClassName) then exit;
  FFieldEditor := TFFieldEditor.Create(Self, cftEditor, m, mtFormFieldsPK.AsVariant, FMain.OnChildFormClose);
  FFieldEditor.OnClose := OnFieldEditorClose;
  FFieldEditor.dsoGroup.DataSet := dsFieldGroups;
  FFieldEditor.dsoFilterGroup.DataSet := dsLFilterGroups;
  FFieldEditor.EditingRec := mtFormFields.GetBookmark;
  FFieldEditor.Caption := 'Редактирование поля';
  FFieldEditor.edPk.Text := mtFormFieldsPK.AsString;
  FFieldEditor.cbFieldName.Style := csSimple;
  FFieldEditor.cbFieldName.Text := mtFormFieldsFIELD_NAME.AsString;
  FFieldEditor.edTitle.Text := mtFormFieldsTITLE.AsString;
  FFieldEditor.cbGroup.KeyValue := mtFormFields.FieldByName('GROUP_PK').Value;
  FFieldEditor.cbGroupChange(FFieldEditor.cbGroup);
  FFieldEditor.edGroupColumn.Value := mtFormFieldsGROUP_COLUMN.AsInteger;
  FFieldEditor.edGroupColumnChange(FFieldEditor.edGroupColumn);
  FFieldEditor.edOrder.Value := mtFormFieldsORDER_.AsInteger;
  FFieldEditor.edGridVisible.Value := mtFormFieldsGRID_VISIBLE.AsInteger;
  FFieldEditor.edEditInTable.Value := mtFormFieldsEDIT_IN_TABLE.AsInteger;
  FFieldEditor.edGridOrder.Value := mtFormFieldsGRID_ORDER.AsInteger;
  FFieldEditor.edGridWidth.Value := mtFormFields.FieldByName('GRID_WIDTH').Value;
  FFieldEditor.edIsVisible.Value := mtFormFieldsIS_VISIBLE.AsInteger;
  FFieldEditor.edEditable.Value := mtFormFieldsEDITABLE.AsInteger;
  FFieldEditor.edIsVisibleAdd.Value := mtFormFieldsIS_VISIBLE_ADD.AsInteger;
  FFieldEditor.edAddEditable.Value := mtFormFieldsADD_EDITABLE.AsInteger;
  FFieldEditor.chbShowInStartForm.Checked := mtFormFieldsSHOW_IN_START_FORM.AsInteger = 1;
  FFieldEditor.chbExcelExport.Checked := mtFormFieldsEXCEL_EXPORT.AsInteger = 1;
  FFieldEditor.chbExcelImport.Checked := mtFormFieldsEXCEL_IMPORT.AsInteger = 1;
  FFieldEditor.edIsFilter.Value := mtFormFields.FieldByName('IS_FILTER').Value;
  FFieldEditor.edFilterOrder.Value := mtFormFieldsFILTER_ORDER.AsInteger;
  FFieldEditor.cbFilterGroup.KeyValue := mtFormFieldsFILTER_GROUP.AsVariant;
  FFieldEditor.chbLocked.Checked := mtFormFieldsLOCKED.AsInteger = 1;
  FFieldEditor.mStyle.Text := mtFormFieldsSTYLE.AsString;
  FFieldEditor.mStyleExternal.Text := mtFormFieldsSTYLE_EXTERNAL.AsString;
  FFieldEditor.mStyleColumn.Text := mtFormFieldsSTYLE_COLUMN.AsString;
  FFieldEditor.cbTypeName.ItemIndex := FFieldEditor.cbTypeName.Items.IndexOf(mtFormFieldsTYPE_NAME.AsString);
  FFieldEditor.cbTypeNameChange(FFieldEditor.cbTypeName);
  LoadFieldTypeParams(FFieldEditor.ParamControls, mtFormFieldsPARAMETERS.AsString);
  FFieldEditor.RegisterForm;
end;

procedure TFEditForm.sbEditGroupClick(Sender: TObject);
var
  FGroupEditor: TFGroupEditor;
  m: TOpenMode;

begin
  if mtGroups.IsEmpty then exit;

  if Mode = omView then m := omView
  else m := omEdit;

  if dbgGroups.SelectedRows.Count > 1 then
  begin
    GroupEdit(dbgGroups);
    exit;
  end;

  // открытие формы редактирования группы
  if FMain.SetFocusOpenedWindow(mtGroupsPK.AsInteger, TFGroupEditor.ClassName) then exit;
  FGroupEditor := TFGroupEditor.Create(Self, cftEditor, m, mtGroupsPK.AsVariant, FMain.OnChildFormClose);
  FGroupEditor.OnClose := OnGroupEditorClose;
  FGroupEditor.dsoParentGroup.DataSet := dsFieldGroups;
  FGroupEditor.EditingRec := mtGroups.GetBookmark;
  FGroupEditor.Caption := 'Редактирование группы';
  FGroupEditor.edPk.Text := mtGroupsPK.AsString;
  FGroupEditor.edTitle.Text := mtGroupsTITLE.AsString;
  FGroupEditor.cbParentGroup.KeyValue := mtGroups.FieldByName('PARENT_PK').Value;
  FGroupEditor.cbParentGroupChange(FGroupEditor.cbParentGroup);
  FGroupEditor.edColumn.Value := mtGroupsCOLUMN_.AsInteger;
  FGroupEditor.edColumnChange(FGroupEditor.edColumn);
  FGroupEditor.edOrder.Value := mtGroupsORDER_.AsInteger;
  FGroupEditor.edCountColumn.Value := mtGroupsCOUNT_COLUMN.AsInteger;
  LoadColumnStyles(FGroupEditor.mtStyleColumns, mtGroupsSTYLE_COLUMNS.AsString);
  FGroupEditor.edCountColumnChange(FGroupEditor.edCountColumn);
  FGroupEditor.chbAddVisible.Checked := mtGroupsADD_VISIBLE.AsInteger = 1;
  FGroupEditor.chbIsVisible.Checked := mtGroupsIS_VISIBLE.AsString = '1';
  FGroupEditor.chbCollapsed.Checked := mtGroupsCOLLAPSED.AsInteger = 1;
  FGroupEditor.chbLeftAlign.Checked := mtGroupsLEFT_ALIGN.AsInteger = 1;
  FGroupEditor.edLabelWidth.Value := mtGroupsLABEL_WIDTH.AsInteger;
  FGroupEditor.mStyleExternal.Text := mtGroupsSTYLE_EXTERNAL.AsString;
  FGroupEditor.mStyleInternal.Text := mtGroupsSTYLE_INTERNAL.AsString;
  FGroupEditor.mDescription.Text := mtGroupsDESCRIPTION.AsString;
  FGroupEditor.RegisterForm;
end;

procedure TFEditForm.sbAddClick(Sender: TObject);
var
  FFieldEditor: TFFieldEditor;

begin
  if Mode = omView then exit;
  // открытие формы редактирования поля
  AutoIncFields;
  FFieldEditor := TFFieldEditor.Create(Self, cftEditor, omAdd, Null, FMain.OnChildFormClose);
  FFieldEditor.OnClose := OnFieldEditorClose;
  FFieldEditor.dsoGroup.DataSet := dsFieldGroups;
  FFieldEditor.dsoFilterGroup.DataSet := dsLFilterGroups;
  FFieldEditor.EditingRec := nil;
  FFieldEditor.Caption := 'Новое поле';
  FFieldEditor.edPk.Text := '';
  FFieldEditor.cbFieldName.Style := csSimple;
  FFieldEditor.cbFieldName.Text := '';
  FFieldEditor.edTitle.Text := '';
  FFieldEditor.cbGroup.KeyValue := Null;
  FFieldEditor.cbGroupChange(FFieldEditor.cbGroup);
  FFieldEditor.edGroupColumn.Value := 0;
  FFieldEditor.edGroupColumnChange(FFieldEditor.edGroupColumn);
  FFieldEditor.edOrder.Value := mtFormFieldsORDER_.Tag;
  FFieldEditor.edGridVisible.Value := 0;
  FFieldEditor.edEditInTable.Value := 0;
  FFieldEditor.edGridOrder.Value := mtFormFieldsGRID_ORDER.Tag;
  FFieldEditor.edGridWidth.Value := Null;
  FFieldEditor.edIsVisible.Value := 1;
  FFieldEditor.edEditable.Value := 1;
  FFieldEditor.edIsVisibleAdd.Value := 1;
  FFieldEditor.edAddEditable.Value := 1;
  FFieldEditor.chbShowInStartForm.Checked := false;
  FFieldEditor.chbExcelExport.Checked := false;
  FFieldEditor.chbExcelImport.Checked := false;
  FFieldEditor.edIsFilter.Value := 0;
  FFieldEditor.edFilterOrder.Value := 0;
  FFieldEditor.cbFilterGroup.KeyValue := Null;
  FFieldEditor.chbLocked.Checked := false;
  FFieldEditor.mStyle.Clear;
  FFieldEditor.mStyleExternal.Clear;
  FFieldEditor.mStyleColumn.Clear;
  FFieldEditor.cbTypeName.ItemIndex := 0;
  FFieldEditor.cbTypeNameChange(FFieldEditor.cbTypeName);
  FFieldEditor.RegisterForm;
end;

procedure TFEditForm.sbAddGroupClick(Sender: TObject);
var
  FGroupEditor: TFGroupEditor;

begin
  if Mode = omView then exit;
  // открытие формы редактирования группы
  AutoIncGroups;
  FGroupEditor := TFGroupEditor.Create(Self, cftEditor, omAdd, Null, FMain.OnChildFormClose);
  FGroupEditor.OnClose := OnGroupEditorClose;
  FGroupEditor.dsoParentGroup.DataSet := dsFieldGroups;
  FGroupEditor.EditingRec := nil;
  FGroupEditor.Caption := 'Новая группа';
  FGroupEditor.edPk.Text := '';
  FGroupEditor.edTitle.Text := '';
  FGroupEditor.cbParentGroup.KeyValue := Null;
  FGroupEditor.cbParentGroupChange(FGroupEditor.cbParentGroup);
  FGroupEditor.edColumn.Value := 0;
  FGroupEditor.edColumnChange(FGroupEditor.edColumn);
  FGroupEditor.edOrder.Value := mtFormFieldsORDER_.Tag;
  FGroupEditor.edCountColumn.Value := 1;
  FGroupEditor.edCountColumnChange(FGroupEditor.edCountColumn);
  FGroupEditor.chbAddVisible.Checked := true;
  FGroupEditor.chbIsVisible.Checked := true;
  FGroupEditor.chbCollapsed.Checked := false;
  FGroupEditor.chbLeftAlign.Checked := false;
  FGroupEditor.mStyleExternal.Clear;
  FGroupEditor.mStyleInternal.Clear;
  FGroupEditor.mDescription.Clear;
  FGroupEditor.RegisterForm;
end;

procedure TFEditForm.SetProperties(Value: TNodeDictInfo);
begin
  inherited SetProperties(Value);

  if Mode <> omAdd then
  begin
    dsForm.Close;
    dsForm.ParamByName('PK').Value := Properties.PK;
    dsForm.Open;
    if dsForm.IsEmpty then
      raise Exception.Create('Не найдена форма с PK ' + VarToStr(Properties.PK) + '! Возможно она была пересоздана и ее PK поменялся.');
    Properties.Guid := dsFormGUID.AsVariant;
    edFormPk.Text := VarToStr(Properties.PK);
    edFormAlias.Text := VarToStr(Properties.Descriptor);
    edFormTitle.Text := VarToStr(Properties.Title);
    Caption := GenCaption('Форма', iif(Mode = omEdit, 'редактирование', 'просмотр'), edFormPk.Text, edFormAlias.Text, edFormTitle.Text,
      FSettings.TreeShowDescriptor);
    edFormWidth.Value := dsFormWIDTH.Value;
    edFormHeight.Value := dsFormHEIGHT.Value;
    chbLeftAlign.Checked := dsFormLEFT_ALIGN.AsInteger = 1;
    edLabelWidth.Value := dsFormLABEL_WIDTH.Value;
  end;
  LoadLookups;
  LoadGridData;
  LoadGroups;
end;

procedure TFEditForm.tbGenSQLClick(Sender: TObject);
begin
  FMain.SetSaveDialogToSQL;
  if FMain.SaveDialog.Execute then FMain.SaveToSQL(Properties, FMain.SaveDialog.FileName);
end;

procedure TFEditForm.tbJumpToTreeClick(Sender: TObject);
begin
  if Mode = omAdd then exit;
  FMain.JumpToNode(cotForm, Properties.PK);
end;

procedure TFEditForm.tbRefreshClick(Sender: TObject);
begin
  if (Mode = omView) or (Application.MessageBox('При перезагрузке данных формы все несохраненные изменения будут потеряны! Продолжить?',
    'Подтверждение', MB_YESNO + MB_ICONQUESTION) = ID_YES) then _Reload;
end;

procedure TFEditForm._Reload;
begin
  if Mode = omAdd then Mode := omEdit;
  Properties := Properties;
end;

procedure TFEditForm.SetMode(Value: TOpenMode);
begin
  inherited SetMode(Value);
  
  case FMode of
    omAdd:
    begin
      btnSave.Enabled := true;
      tbSave.Enabled := true;
      tbGenSQL.Enabled := false;
      tbRefresh.Enabled := false;
      btnRefresh.Enabled := false;
      Caption := 'Новая форма';
      edFormAlias.ReadOnly := false;
      edFormAlias.Color := clWindow;
      edFormTitle.ReadOnly := false;
      edFormTitle.Color := clWindow;
      edFormWidth.ReadOnly := false;
      edFormWidth.Color := clWindow;
      edFormHeight.ReadOnly := false;
      edFormHeight.Color := clWindow;
      dbgFormFields.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      sbAdd.Enabled := true;
      sbEdit.Enabled := true;
      sbDel.Enabled := true;
      dbgGroups.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      sbAddGroup.Enabled := true;
      sbEditGroup.Enabled := true;
      sbDelGroup.Enabled := true;
      chbLeftAlign.Enabled := true;
      edLabelWidth.ReadOnly := false;
      edLabelWidth.Color := clWindow;
    end;
    omEdit:
    begin
      btnSave.Enabled := true;
      tbSave.Enabled := true;
      tbGenSQL.Enabled := true;
      tbRefresh.Enabled := true;
      btnRefresh.Enabled := true;
      Caption := 'Редактирование формы';
      edFormAlias.ReadOnly := false;
      edFormAlias.Color := clWindow;
      edFormTitle.ReadOnly := false;
      edFormTitle.Color := clWindow;
      edFormWidth.ReadOnly := false;
      edFormWidth.Color := clWindow;
      edFormHeight.ReadOnly := false;
      edFormHeight.Color := clWindow;
      dbgFormFields.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      sbAdd.Enabled := true;
      sbEdit.Enabled := true;
      sbDel.Enabled := true;
      dbgGroups.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      sbAddGroup.Enabled := true;
      sbEditGroup.Enabled := true;
      sbDelGroup.Enabled := true;
      chbLeftAlign.Enabled := true;
      edLabelWidth.ReadOnly := false;
      edLabelWidth.Color := clWindow;
    end;
    omView:
    begin
      btnSave.Enabled := false;
      tbSave.Enabled := false;
      tbGenSQL.Enabled := true;
      tbRefresh.Enabled := true;
      btnRefresh.Enabled := true;
      Caption := 'Свойства формы';
      edFormAlias.ReadOnly := true;
      edFormAlias.Color := clBtnFace;
      edFormTitle.ReadOnly := true;
      edFormTitle.Color := clBtnFace;
      edFormWidth.ReadOnly := true;
      edFormWidth.Color := clBtnFace;
      edFormHeight.ReadOnly := true;
      edFormHeight.Color := clBtnFace;
      dbgFormFields.AllowedOperations := [];
      sbAdd.Enabled := false;
      sbEdit.Enabled := false;
      sbDel.Enabled := false;
      dbgGroups.AllowedOperations := [];
      sbAddGroup.Enabled := false;
      sbEditGroup.Enabled := false;
      sbDelGroup.Enabled := false;
      chbLeftAlign.Enabled := false;
      edLabelWidth.ReadOnly := true;
      edLabelWidth.Color := clBtnFace;
    end;
  end;
end;

end.
