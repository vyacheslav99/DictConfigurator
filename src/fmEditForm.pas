unit fmEditForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Math, Dialogs, DBGridEhGrouping, GridsEh,
  DBGridEh, Buttons, ExtCtrls, StdCtrls, Mask, DBCtrlsEh, MemTableDataEh, Db, FIBDataSet, MemTableEh, pFIBDataSet, main,
  settings, utils, groupEditor, fieldEditor, optControls, dbUtils, groupedit, previewForm, childForm, Menus, jsonReader,
  EhLibMTE, ActnList, tmplEditor;

type
  TfrmEditForm = class(TFrame)
    Label2: TLabel;
    edFormPk: TEdit;
    Label4: TLabel;
    edFormAlias: TEdit;
    Label3: TLabel;
    edFormTitle: TEdit;
    Label1: TLabel;
    edFormWidth: TDBNumberEditEh;
    Label5: TLabel;
    edFormHeight: TDBNumberEditEh;
    Bevel1: TBevel;
    Label6: TLabel;
    sbAddField: TSpeedButton;
    sbEditField: TSpeedButton;
    sbDelField: TSpeedButton;
    dbgFormFields: TDBGridEh;
    Label7: TLabel;
    sbAddGroup: TSpeedButton;
    sbEditGroup: TSpeedButton;
    sbDelGroup: TSpeedButton;
    dbgGroups: TDBGridEh;
    dsFieldGroups: TpFIBDataSet;
    dsFieldGroupsPK: TFIBIntegerField;
    dsFieldGroupsTITLE: TFIBStringField;
    dsFieldGroupsCOUNT_COLUMN: TFIBIntegerField;
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
    dsFormFieldsOBJECT_NAME: TFIBStringField;
    dsFormFieldsOBJECT_PK: TFIBIntegerField;
    mtFormFields: TMemTableEh;
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
    mtFormFieldsCHANGED: TBooleanField;
    mtFormFieldsOBJECT_NAME: TStringField;
    mtFormFieldsOBJECT_PK: TIntegerField;
    dsoFormFields: TDataSource;
    dsGroups: TpFIBDataSet;
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
    dsGroupsCREATE_: TFIBDateTimeField;
    mtGroups: TMemTableEh;
    mtGroupsPK: TIntegerField;
    mtGroupsPARENT_PK: TIntegerField;
    mtGroupsPARENT_TITLE: TStringField;
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
    mtGroupsCREATE_: TDateTimeField;
    mtGroupsCHANGED: TBooleanField;
    dsoGroups: TDataSource;
    btnPreviewForm: TButton;
    dsFormFieldsLOCKED: TFIBIntegerField;
    mtFormFieldsLOCKED: TIntegerField;
    chbLeftAlign: TCheckBox;
    dsGroupsLEFT_ALIGN: TFIBIntegerField;
    mtGroupsLEFT_ALIGN: TIntegerField;
    pmGrid: TPopupMenu;
    miGridOptions: TMenuItem;
    edLabelWidth: TDBNumberEditEh;
    Label30: TLabel;
    dsGroupsLABEL_WIDTH: TFIBIntegerField;
    mtGroupsLABEL_WIDTH: TIntegerField;
    edCurrField: TEdit;
    dsFormFieldsFILTER_GROUP: TFIBIntegerField;
    mtFormFieldsFILTER_GROUP: TIntegerField;
    dsLFilterGroups: TpFIBDataSet;
    dsLFilterGroupsPK: TFIBIntegerField;
    dsLFilterGroupsTITLE: TFIBStringField;
    mtFormFieldsFILTER_GROUP_NAME: TStringField;
    dsFormFieldsIS_VISIBLE: TFIBIntegerField;
    dsFormFieldsGRID_VISIBLE: TFIBIntegerField;
    dsFormFieldsIS_VISIBLE_ADD: TFIBIntegerField;
    dsFormFieldsEDIT_IN_TABLE: TFIBIntegerField;
    mtFormFieldsIS_VISIBLE: TIntegerField;
    mtFormFieldsGRID_VISIBLE: TIntegerField;
    mtFormFieldsIS_VISIBLE_ADD: TIntegerField;
    mtFormFieldsEDIT_IN_TABLE: TIntegerField;
    ActionList: TActionList;
    AGridOptions: TAction;
    AExportToExcel: TAction;
    AExportToCsv: TAction;
    Excel1: TMenuItem;
    csv1: TMenuItem;
    dsFormFieldsGUID: TFIBStringField;
    dsGroupsGUID: TFIBStringField;
    mtFormFieldsGUID: TStringField;
    mtGroupsGUID: TStringField;
    procedure mtFormFieldsAfterInsert(DataSet: TDataSet);
    procedure mtFormFieldsBeforeDelete(DataSet: TDataSet);
    procedure mtFormFieldsBeforePost(DataSet: TDataSet);
    procedure mtGroupsAfterInsert(DataSet: TDataSet);
    procedure mtGroupsBeforeDelete(DataSet: TDataSet);
    procedure mtGroupsBeforePost(DataSet: TDataSet);
    procedure dbgFormFieldsGetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure sbAddFieldClick(Sender: TObject);
    procedure sbEditFieldClick(Sender: TObject);
    procedure sbDelFieldClick(Sender: TObject);
    procedure dbgFormFieldsDblClick(Sender: TObject);
    procedure sbAddGroupClick(Sender: TObject);
    procedure sbEditGroupClick(Sender: TObject);
    procedure sbDelGroupClick(Sender: TObject);
    procedure dbgGroupsDblClick(Sender: TObject);
    procedure dbgFormFieldsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgGroupsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPreviewFormClick(Sender: TObject);
    procedure mtFormFieldsAfterScroll(DataSet: TDataSet);
    procedure dbgFormFieldsColumns19EditButtonClick(Sender: TObject; var Handled: Boolean);
    procedure dbgGroupsColumns12EditButtonClick(Sender: TObject; var Handled: Boolean);
    procedure dbgFormFieldsFillSTFilterListValues(Sender: TCustomDBGridEh; Column: TColumnEh; Items: TStrings;
      var Processed: Boolean);
    procedure AGridOptionsExecute(Sender: TObject);
    procedure AExportToExcelExecute(Sender: TObject);
    procedure AExportToCsvExecute(Sender: TObject);
    procedure dbgFormFieldsColumns6EditButtonClick(Sender: TObject; var Handled: Boolean);
  private
    FFormPk: Variant;
    FDictForm: TChildForm;
    IsLoadingGrid: boolean;
    procedure SaveGridsParams;
    procedure ApplyGroupEditorData(FGroupEditor: TFGroupEditor);
    procedure ApplyFieldEditorData(FFieldEditor: TFFieldEditor);
    procedure ApplyJsonEditorData(FJsonReader: TFJsonReader);
    procedure ApplyFieldTmplEditorData(FTmplEditor: TFTmplEditor);
    procedure SetFormPk(Value: Variant);
    procedure GroupEdit(Grid: TDBGridEh);
    function OpenJsonEditor(Field: TField; StatusText: string): TFJsonReader;
  public
    RequestProcParams: boolean;
    DeletedFields: TStringList;
    DeletedGroups: TStringList;
    FormGUID: string;
    constructor Create(ADictForm: TChildForm; AOwner: TComponent);
    destructor Destroy; override;
    procedure OnGroupEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure OnFieldEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure OnJsonEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure OnFieldTmplEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure LoadFormFields;
    procedure LoadFormGroups;
    procedure LoadLookups;
    procedure AutoIncFields;
    procedure SetGridsOptions(Options: TGridParams);
    property FormPk: Variant read FFormPk write SetFormPk;
  end;

implementation

uses editDict;

{$R *.dfm}

procedure TfrmEditForm.AExportToCsvExecute(Sender: TObject);
begin
  if Assigned(FDictForm.ActiveControl) and (FDictForm.ActiveControl is TDBGridEh) then
    FMain.ExportToCsv(TDBGridEh(FDictForm.ActiveControl), edFormTitle.Text);
end;

procedure TfrmEditForm.AExportToExcelExecute(Sender: TObject);
begin
  if Assigned(FDictForm.ActiveControl) and (FDictForm.ActiveControl is TDBGridEh) then
    FMain.ExportToExcel(TDBGridEh(FDictForm.ActiveControl), edFormTitle.Text);
end;

procedure TfrmEditForm.AGridOptionsExecute(Sender: TObject);
begin
  if Assigned(FDictForm.ActiveControl) and (FDictForm.ActiveControl is TDBGridEh) then
    FSettings.GridParamsDialog(TDBGridEh(FDictForm.ActiveControl), ClassName);
end;

procedure TfrmEditForm.ApplyFieldEditorData(FFieldEditor: TFFieldEditor);
var
  str, obj, fld: string;
  
begin
  mtFormFields.DisableControls;
  TFEditDict(FDictForm).mtObjectTree.DisableControls;
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

    if FFieldEditor.cbFieldName.ItemIndex = -1 then str := FFieldEditor.cbFieldName.Text
    else str := FFieldEditor.cbFieldName.Items[FFieldEditor.cbFieldName.ItemIndex];

    SplitFieldName(str, obj, fld);
    if obj <> '' then
    begin
      mtFormFieldsOBJECT_NAME.AsString := obj;
      mtFormFieldsFIELD_NAME.AsString := fld;
      if TFEditDict(FDictForm).mtObjectTree.Locate('NAME', mtFormFieldsOBJECT_NAME.AsString, [loCaseInsensitive]) then
        mtFormFields.FieldByName('OBJECT_PK').Value := TFEditDict(FDictForm).mtObjectTree.FieldByName('PK').Value
      else
        mtFormFields.FieldByName('OBJECT_PK').Clear;
    end else
    begin
      mtFormFieldsOBJECT_NAME.Clear;
      mtFormFieldsOBJECT_PK.Clear;
      mtFormFieldsFIELD_NAME.AsString := str;
    end;
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
    mtFormFieldsPARAMETERS.AsString := TFEditDict(FDictForm).GetFieldTypeParams(FFieldEditor.ParamControls);
    mtFormFields.Post;
  finally
    TFEditDict(FDictForm).mtObjectTree.First;
    TFEditDict(FDictForm).mtObjectTree.EnableControls;
    mtFormFields.EnableControls;
  end;
end;

procedure TfrmEditForm.ApplyFieldTmplEditorData(FTmplEditor: TFTmplEditor);
var
  p: string;
  pk: Variant;

begin
  mtFormFields.DisableControls;
  try
    if mtFormFields.BookmarkValid(FTmplEditor.EditingRec) then
      mtFormFields.GotoBookmark(FTmplEditor.EditingRec)
    else begin
      Application.MessageBox('Редактируемое поле не найдено в списке полей! Возможно оно было удалено!', 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;

    pk := TFEditDict(FDictForm).SaveTemplate(FTmplEditor.mTemplate.Text, FTmplEditor.GetObjectPK, FTmplEditor.Mode = omAdd, false);
    if pk <> mtFormFields.FieldByName(FTmplEditor.TmplField).Value then
    begin
      mtFormFields.Edit;
      mtFormFields.FieldByName(FTmplEditor.TmplField).Value := pk;
      mtFormFields.Post;
    end;
  finally
    mtFormFields.EnableControls;
  end;
end;

procedure TfrmEditForm.ApplyGroupEditorData(FGroupEditor: TFGroupEditor);
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
    mtGroupsSTYLE_COLUMNS.AsString := TFEditDict(FDictForm).GetColumnStyles(FGroupEditor.mtStyleColumns);
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

procedure TfrmEditForm.ApplyJsonEditorData(FJsonReader: TFJsonReader);
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

procedure TfrmEditForm.AutoIncFields;
begin
  mtFormFieldsORDER_.Tag := mtFormFieldsORDER_.Tag + 10;
end;

procedure TfrmEditForm.btnPreviewFormClick(Sender: TObject);
var
  pf: TFPreviewForm;
  
begin
  if FMain.SetFocusOpenedWindow(FFormPk, TFPreviewForm.ClassName) then exit;
  pf := TFPreviewForm.Create(FDictForm, cftPreview, omView, FFormPk, FMain.OnChildFormClose);
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

constructor TfrmEditForm.Create(ADictForm: TChildForm; AOwner: TComponent);
var
  col: TColumnEh;

begin
  inherited Create(AOwner);
  // FDictForm может быть только экземпляром TFEditDict !!!
  FDictForm := ADictForm;
  DeletedFields := TStringList.Create;
  DeletedGroups := TStringList.Create;
  col := FindColumnByFieldName(dbgFormFields, 'TYPE_NAME');
  if Assigned(col) then
  begin
    col.KeyList.Text := FIELDTYPES;
    col.PickList.Text := FIELDTYPES;
  end;
  SetGridsOptions(FSettings.GridOptions);
end;

procedure TfrmEditForm.dbgFormFieldsColumns19EditButtonClick(Sender: TObject; var Handled: Boolean);
var
  FJsonReader: TFJsonReader;
  col: TColumnEh;

begin
  col := FindColumnByFieldName(dbgFormFields, 'PARAMETERS');
  FJsonReader := OpenJsonEditor(mtFormFieldsPARAMETERS, 'Поле: ' + iif(mtFormFieldsOBJECT_NAME.IsNull, '', mtFormFieldsOBJECT_NAME.AsString + '.') +
    mtFormFieldsFIELD_NAME.AsString + '  ' + mtFormFieldsTITLE.AsString + '  ' + mtFormFieldsTYPE_NAME.AsString + ' : ' + col.Title.Hint);
end;

procedure TfrmEditForm.dbgFormFieldsColumns6EditButtonClick(Sender: TObject; var Handled: Boolean);
var
  field: TField;
  FTmplEditor: TFTmplEditor;
  m: TOpenMode;

begin
  // открытие формы редактирования шаблона прав
  field := dbgFormFields.SelectedField;
  if (not Assigned(field)) or mtFormFields.IsEmpty {or (field.FieldName <> 'GRID_VISIBLE' and field.FieldName <> 'EDIT_IN_TABLE' and
    field.FieldName <> 'IS_VISIBLE' and field.FieldName <> 'EDITABLE' and field.FieldName <> 'IS_VISIBLE_ADD' and field.FieldName <> 'ADD_EDITABLE')} then exit;

  if FDictForm.Mode = omView then m := omView
  else m := omEdit;

  if FMain.SetFocusOpenedWindow(field.AsInteger, TFTmplEditor.ClassName) then exit;
  FTmplEditor := TFTmplEditor.Create(FDictForm, cftEditor, m, field.AsVariant, FMain.OnChildFormClose);
  FTmplEditor.OnClose := OnFieldTmplEditorClose;
  FTmplEditor.EditingRec := mtFormFields.GetBookmark;
  FTmplEditor.Caption := 'Редактирование шаблона прав';

  FTmplEditor.FieldPK := mtFormFieldsPK.AsInteger;
  FTmplEditor.FieldName := mtFormFieldsFIELD_NAME.AsString;
  FTmplEditor.FieldTitle := mtFormFieldsTITLE.AsString;
  FTmplEditor.TmplField := field.FieldName;
  //FTmplEditor.sbEditTemplate.Enabled := field.FieldName = 'GRID_VISIBLE';
  TFEditDict(FDictForm).LoadTemplate(FTmplEditor.mTemplate, field.AsInteger);

  //FTmplEditor.Show; - это у mdi child происходит сразу при создании
  FTmplEditor.RegisterForm;
end;

procedure TfrmEditForm.dbgFormFieldsDblClick(Sender: TObject);
begin
  sbEditFieldClick(sbEditField);
end;

procedure TfrmEditForm.dbgFormFieldsFillSTFilterListValues(Sender: TCustomDBGridEh; Column: TColumnEh; Items: TStrings;
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

procedure TfrmEditForm.dbgFormFieldsGetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
begin
  if TDBGridEh(Sender).DataSource.DataSet.FieldByName('CHANGED').AsBoolean then
  begin
    if TDBGridEh(Sender).DataSource.DataSet.FieldByName('PK').IsNull then Background := FSettings.GridOptions.NewRowColor
    else Background := FSettings.GridOptions.ChangedRowColor;
  end {else Background := clWindow};
end;

procedure TfrmEditForm.dbgFormFieldsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddFieldClick(sbAddField);
    VK_RETURN: if ssShift in Shift then sbEditFieldClick(sbEditField);
    else
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
  end;
end;

procedure TfrmEditForm.dbgGroupsColumns12EditButtonClick(Sender: TObject; var Handled: Boolean);
var
  FJsonReader: TFJsonReader;
  col: TColumnEh;

begin
  col := FindColumnByFieldName(dbgGroups, 'STYLE_COLUMNS');
  FJsonReader := OpenJsonEditor(mtGroupsSTYLE_COLUMNS, 'Группа: ' + mtGroupsORDER_.AsString + '.' + mtGroupsTITLE.AsString + ' : ' + col.Title.Hint);
end;

procedure TfrmEditForm.dbgGroupsDblClick(Sender: TObject);
begin
  sbEditGroupClick(sbEditGroup);
end;

procedure TfrmEditForm.dbgGroupsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddGroupClick(sbAddGroup);
    VK_RETURN: if ssShift in Shift then sbEditGroupClick(sbEditGroup);
    else
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
  end;
end;

destructor TfrmEditForm.Destroy;
begin
  SaveGridsParams;
  DeletedFields.Free;
  DeletedGroups.Free;
  inherited Destroy;
end;

procedure TfrmEditForm.GroupEdit(Grid: TDBGridEh);
var
  fGrEdit: TFGroupEdit;
  i, j: integer;
  data: TStringList;
  bm: TBookmark;
  DataSet: TMemTableEh;

begin
  if FDictForm.Mode = omView then exit;

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

procedure TfrmEditForm.LoadFormFields;
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
    if VarIsNull(FFormPk) then exit;

    dsFormFields.Close;
    dsFormFields.ParamByName('FORM_PK').Value := FFormPk;
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
      dsFormFields.Next;
    end;
    dsFormFields.Close;
    mtFormFields.First;
  finally
    IsLoadingGrid := false;
    mtFormFields.EnableControls;
  end;
end;

procedure TfrmEditForm.LoadFormGroups;
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
    if VarIsNull(FFormPk) then exit;

    dsGroups.Close;
    dsGroups.ParamByName('FORM_PK').Value := FFormPk;
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
  finally
    IsLoadingGrid := false;
    mtGroups.EnableControls;
  end;
end;

procedure TfrmEditForm.LoadLookups;
begin
  dsFieldGroups.Close;
  dsFieldGroups.ParamByName('FORM_PK').Value := FFormPk;
  dsFieldGroups.Open;
  dsLFilterGroups.Close;
  dsLFilterGroups.ParamByName('FORM_PK').Value := FFormPk;
  dsLFilterGroups.Open;
end;

procedure TfrmEditForm.mtFormFieldsAfterInsert(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    //AutoIncFields;
    mtFormFieldsOWNER_USER_PK.AsInteger := FMain.dsPortalUserPK.AsInteger;
    {mtFormFieldsGROUP_COLUMN.AsInteger := 0;
    mtFormFieldsORDER_.AsInteger := mtFormFieldsORDER_.Tag;
    mtFormFieldsTYPE_NAME.AsString := 'text';
    mtFormFieldsIS_VISIBLE.AsString := '1';
    mtFormFieldsGRID_VISIBLE.AsString := '0';
    mtFormFieldsGRID_ORDER.AsInteger := 0;
    mtFormFieldsEDITABLE.AsInteger := 1;
    mtFormFieldsADD_EDITABLE.AsInteger := 1;
    mtFormFieldsEXCEL_EXPORT.AsInteger := 0;
    mtFormFieldsIS_VISIBLE_ADD.AsString := '1';
    mtFormFieldsFILTER_ORDER.AsInteger := 0;
    mtFormFieldsIS_FILTER.AsInteger := 0;
    mtFormFieldsSHOW_IN_START_FORM.AsInteger := 0;
    mtFormFieldsEDIT_IN_TABLE.AsString := '0';}
    mtFormFieldsSHOW_IN_GROUP_EDIT.AsInteger := 0;
    //mtFormFieldsEXCEL_IMPORT.AsInteger := 0;
    mtFormFieldsMATCH.AsInteger := 0;
    mtFormFieldsLOCKED.AsInteger := 0;
  end;
end;

procedure TfrmEditForm.mtFormFieldsAfterScroll(DataSet: TDataSet);
begin
  if mtFormFields.ControlsDisabled then exit;
  edCurrField.Text := iif(mtFormFieldsOBJECT_NAME.IsNull, '', mtFormFieldsOBJECT_NAME.AsString + '.') +
    mtFormFieldsFIELD_NAME.AsString + '  ' + mtFormFieldsTITLE.AsString + '  ' + mtFormFieldsTYPE_NAME.AsString;
end;

procedure TfrmEditForm.mtFormFieldsBeforeDelete(DataSet: TDataSet);
begin
  if mtFormFieldsPK.AsString <> '' then DeletedFields.Add(mtFormFieldsPK.AsString);
end;

procedure TfrmEditForm.mtFormFieldsBeforePost(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    if mtFormFieldsOBJECT_NAME.IsNull or mtFormFieldsTITLE.IsNull or mtFormFieldsFIELD_NAME.IsNull or mtFormFieldsPARAMETERS.IsNull then
      raise Exception.Create('Не все обязательные поля заполнены!');

    mtFormFieldsCHANGED.AsBoolean := true;
    if mtFormFieldsGUID.IsNull then mtFormFieldsGUID.AsString := CreateGuid;
  end;
end;

procedure TfrmEditForm.mtGroupsAfterInsert(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    AutoIncFields;
    mtGroupsOWNER_USER_PK.AsInteger := FMain.dsPortalUserPK.AsInteger;
    mtGroupsORDER_.AsInteger := mtFormFieldsORDER_.Tag;
    mtGroupsCOUNT_COLUMN.AsInteger := 1;
    mtGroupsIS_VISIBLE.AsInteger := 1;
    mtGroupsCOLUMN_.AsInteger := 0;
    mtGroupsADD_VISIBLE.AsInteger := 1;
    mtGroupsCOLLAPSED.AsInteger := 0;
    mtGroupsLEFT_ALIGN.AsInteger := 0;
    mtGroupsCREATE_.AsDateTime := Now;
  end;
end;

procedure TfrmEditForm.mtGroupsBeforeDelete(DataSet: TDataSet);
begin
  if mtGroupsPK.AsString <> '' then DeletedGroups.Add(mtGroupsPK.AsString);
end;

procedure TfrmEditForm.mtGroupsBeforePost(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    if mtGroupsTITLE.IsNull then raise Exception.Create('Не все обязательные поля заполнены!');
    mtGroupsCHANGED.AsBoolean := true;
    if mtGroupsGUID.IsNull then mtGroupsGUID.AsString := CreateGuid;
  end;
end;

procedure TfrmEditForm.OnFieldEditorClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfrmEditForm.OnFieldTmplEditorClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if TFTmplEditor(Sender).Success then
  begin
    if mtFormFields.State in [dsEdit, dsInsert] then
    begin
      case Application.MessageBox(pchar('Невозможно сохранить данные, пока таблица полей в режиме редактирования! Сначала нужно сохранить ' +
        'или отменить изменения в таблице. Сохранить изменения [YES], оменить [NO], или отложить сохранение шаблона [CANCEL] ' +
        '(сохранить эти данные можно будет позже)?'), 'Подтверждение', MB_YESNOCANCEL + MB_ICONQUESTION) of
        ID_YES: mtFormFields.Post;
        ID_NO: mtFormFields.Cancel;
        ID_CANCEL:
        begin
          TFTmplEditor(Sender).Success := false;
          Action := caNone;
        end;
      end;
    end;

    if Action <> caNone then ApplyFieldTmplEditorData(TFTmplEditor(Sender));
  end;
end;

procedure TfrmEditForm.OnGroupEditorClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfrmEditForm.OnJsonEditorClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if TFJsonReader(Sender).Success then ApplyJsonEditorData(TFJsonReader(Sender));
end;

function TfrmEditForm.OpenJsonEditor(Field: TField; StatusText: string): TFJsonReader;
var
  ds: TMemTableEh;
  m: TOpenMode;

begin
  result := nil;
  if (not Assigned(Field)) or (not Assigned(Field.DataSet)) or Field.DataSet.IsEmpty then exit;

  if FDictForm.Mode = omView then m := omView
  else m := omEdit;

  ds := TMemTableEh(Field.DataSet);

  if FMain.SetFocusOpenedWindow(ds.FieldByName('PK').AsInteger, TFJsonReader.ClassName) then exit;
  result := TFJsonReader.Create(FDictForm, cftEditor, m, ds.FieldByName('PK').AsVariant, FMain.OnChildFormClose);
  result.EditingRec := ds.GetBookmark;
  result.Field := Field;
  result.OnClose := OnJsonEditorClose;
  result.ASaveToField.Visible := true;
  result.StatusBar.Panels[1].Text := StatusText;
  result.LoadText(Field.AsString);
  result.RegisterForm;
end;

procedure TfrmEditForm.SaveGridsParams;
var
  i: integer;

begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TDBGridEh then FSettings.SaveGridParams(TDBGridEh(Components[i]), ClassName);
end;

procedure TfrmEditForm.sbAddFieldClick(Sender: TObject);
var
  FFieldEditor: TFFieldEditor;

begin
  if FDictForm.Mode = omView then exit;
  // открытие формы редактирования поля
  AutoIncFields;
  FFieldEditor := TFFieldEditor.Create(FDictForm, cftEditor, omAdd, Null, FMain.OnChildFormClose);
  FFieldEditor.OnClose := OnFieldEditorClose;
  FFieldEditor.dsoGroup.DataSet := dsFieldGroups;
  FFieldEditor.dsoFilterGroup.DataSet := dsLFilterGroups;
  FFieldEditor.BaseDescriptor := TFEditDict(FDictForm).cbDictBaseDescriptor.Text;
  //FFieldEditor.cbFieldName.ReadOnly := true;
  //FFieldEditor.cbFieldName.Color := clBtnFace;
  //FFieldEditor.cbFieldName.TabStop := false;
  FFieldEditor.EditingRec := nil;
  FFieldEditor.Caption := 'Новое поле';
  FFieldEditor.cbTypeName.ItemIndex := 0;
  FFieldEditor.cbTypeNameChange(FFieldEditor.cbTypeName);
  FFieldEditor.edPk.Text := '';
  FFieldEditor.edTitle.Text := '';
  FFieldEditor.cbFieldName.Style := csDropDown;
  FFieldEditor.cbFieldName.Items.Text := TFEditDict(FDictForm).GetNotInvolvedFields(mtFormFields, RequestProcParams);
  if FFieldEditor.cbFieldName.Items.Count > 0 then FFieldEditor.cbFieldName.ItemIndex := 0
  else FFieldEditor.cbFieldName.Text := '';
  FFieldEditor.cbFieldNameChange(FFieldEditor.cbFieldName);
  FFieldEditor.cbGroup.KeyValue := Null;
  FFieldEditor.cbGroupChange(FFieldEditor.cbGroup);
  FFieldEditor.edGroupColumn.Value := 0;
  FFieldEditor.edGroupColumnChange(FFieldEditor.edGroupColumn);
  FFieldEditor.edOrder.Value := mtFormFieldsORDER_.Tag;
  FFieldEditor.edGridVisible.Value := 0;
  FFieldEditor.edEditInTable.Value := 0;
  FFieldEditor.edGridOrder.Value := 0;
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
  FFieldEditor.RegisterForm;
end;

procedure TfrmEditForm.sbAddGroupClick(Sender: TObject);
var
  FGroupEditor: TFGroupEditor;

begin
  if FDictForm.Mode = omView then exit;
  // открытие формы редактирования группы
  AutoIncFields;
  FGroupEditor := TFGroupEditor.Create(FDictForm, cftEditor, omAdd, Null, FMain.OnChildFormClose);
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

procedure TfrmEditForm.sbDelFieldClick(Sender: TObject);
begin
  if FDictForm.Mode = omView then exit;
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

procedure TfrmEditForm.sbDelGroupClick(Sender: TObject);
begin
  if FDictForm.Mode = omView then exit;
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

procedure TfrmEditForm.sbEditFieldClick(Sender: TObject);
var
  FFieldEditor: TFFieldEditor;
  m: TOpenMode;

begin
  if mtFormFields.IsEmpty then exit;

  if FDictForm.Mode = omView then m := omView
  else m := omEdit;

  if dbgFormFields.SelectedRows.Count > 1 then
  begin
    GroupEdit(dbgFormFields);
    exit;
  end;

  // открытие формы редактирования поля
  if FMain.SetFocusOpenedWindow(mtFormFieldsPK.AsInteger, TFFieldEditor.ClassName) then exit;
  FFieldEditor := TFFieldEditor.Create(FDictForm, cftEditor, m, mtFormFieldsPK.AsVariant, FMain.OnChildFormClose);
  FFieldEditor.OnClose := OnFieldEditorClose;
  FFieldEditor.dsoGroup.DataSet := dsFieldGroups;
  FFieldEditor.dsoFilterGroup.DataSet := dsLFilterGroups;
  //FFieldEditor.cbFieldName.ReadOnly := true;
  //FFieldEditor.cbFieldName.Color := clBtnFace;
  //FFieldEditor.cbFieldName.TabStop := false;
  FFieldEditor.EditingRec := mtFormFields.GetBookmark;
  FFieldEditor.Caption := 'Редактирование поля';
  FFieldEditor.edPk.Text := mtFormFieldsPK.AsString;
  FFieldEditor.cbFieldName.Style := csDropDown;
  FFieldEditor.cbFieldName.Items.Text := TFEditDict(FDictForm).GetNotInvolvedFields(mtFormFields, RequestProcParams);
  FFieldEditor.cbFieldName.Text := mtFormFieldsOBJECT_NAME.AsString + '.' + mtFormFieldsFIELD_NAME.AsString;
  if FFieldEditor.cbFieldName.Text <> '' then FFieldEditor.cbFieldName.Items.Insert(0, FFieldEditor.cbFieldName.Text);
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
  TFEditDict(FDictForm).LoadFieldTypeParams(FFieldEditor.ParamControls, mtFormFieldsPARAMETERS.AsString);
  FFieldEditor.RegisterForm;
end;

procedure TfrmEditForm.sbEditGroupClick(Sender: TObject);
var
  FGroupEditor: TFGroupEditor;
  m: TOpenMode;

begin
  if mtGroups.IsEmpty then exit;

  if FDictForm.Mode = omView then m := omView
  else m := omEdit;

  if dbgGroups.SelectedRows.Count > 1 then
  begin
    GroupEdit(dbgGroups);
    exit;
  end;

  // открытие формы редактирования группы
  if FMain.SetFocusOpenedWindow(mtGroupsPK.AsInteger, TFGroupEditor.ClassName) then exit;
  FGroupEditor := TFGroupEditor.Create(FDictForm, cftEditor, m, mtGroupsPK.AsVariant, FMain.OnChildFormClose);
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
  TFEditDict(FDictForm).LoadColumnStyles(FGroupEditor.mtStyleColumns, mtGroupsSTYLE_COLUMNS.AsString);
  FGroupEditor.edCountColumnChange(FGroupEditor.edCountColumn);
  FGroupEditor.chbAddVisible.Checked := mtGroupsADD_VISIBLE.AsInteger = 1;
  FGroupEditor.chbIsVisible.Checked := mtGroupsIS_VISIBLE.AsString = '1';
  FGroupEditor.chbCollapsed.Checked := mtGroupsCOLLAPSED.AsInteger = 1;
  FGroupEditor.chbLeftAlign.Checked := mtGroupsLEFT_ALIGN.AsInteger = 1;
  FGroupEditor.mStyleExternal.Text := mtGroupsSTYLE_EXTERNAL.AsString;
  FGroupEditor.mStyleInternal.Text := mtGroupsSTYLE_INTERNAL.AsString;
  FGroupEditor.mDescription.Text := mtGroupsDESCRIPTION.AsString;
  FGroupEditor.RegisterForm;
end;

procedure TfrmEditForm.SetFormPk(Value: Variant);
begin
  FFormPk := Value;
  LoadLookups;
  LoadFormFields;
  LoadFormGroups;
end;

procedure TfrmEditForm.SetGridsOptions(Options: TGridParams);
var
  i: integer;

begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TDBGridEh then
    begin
      Options.AssignTo(TDBGridEh(Components[i]));
      FSettings.LoadGridParams(TDBGridEh(Components[i]), ClassName);
    end;
end;

end.
