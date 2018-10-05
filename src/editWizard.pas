unit editWizard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, settings, utils,
  ExtCtrls, DB, FIBDataSet, pFIBDataSet, DBGridEh, Mask, DBCtrlsEh, DBLookupEh, DBGridEhGrouping, GridsEh, main, MemTableDataEh,
  MemTableEh, FIBQuery, pFIBQuery, Math, Menus, ActnList, groupedit, stateEditor, crossEditor, slotEditor, slotValEditor,
  childForm, jsonReader, dbUtils, ToolWin, ComCtrls;

type
  TFEditWizard = class(TChildForm)
    GroupBox1: TGroupBox;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    Bevel1: TBevel;
    Label3: TLabel;
    edName: TEdit;
    Label2: TLabel;
    edPk: TEdit;
    Label4: TLabel;
    edDescriptor: TEdit;
    Label6: TLabel;
    dbgWizardStates: TDBGridEh;
    dsWizardScen: TpFIBDataSet;
    dsWizardStates: TpFIBDataSet;
    dsoWizardStates: TDataSource;
    sbAddState: TSpeedButton;
    sbDelState: TSpeedButton;
    sbEditState: TSpeedButton;
    mtWizardStates: TMemTableEh;
    mtWizardStatesCHANGED: TBooleanField;
    mtWizardStatesPK: TIntegerField;
    qEditState: TpFIBQuery;
    Label7: TLabel;
    sbAddCross: TSpeedButton;
    sbEditCross: TSpeedButton;
    sbDelCross: TSpeedButton;
    dbgStatesCross: TDBGridEh;
    dsStatesCross: TpFIBDataSet;
    mtStatesCross: TMemTableEh;
    dsoStatesCross: TDataSource;
    mtStatesCrossPK: TIntegerField;
    dsStateForms: TpFIBDataSet;
    mtStatesCrossCHANGED: TBooleanField;
    qEditStateCross: TpFIBQuery;
    ActionList: TActionList;
    ASave: TAction;
    dsWizardScenPK: TFIBIntegerField;
    dsWizardScenNAME: TFIBStringField;
    dsWizardScenSCEN_TYPE: TFIBStringField;
    dsWizardScenREF_PK: TFIBIntegerField;
    dsWizardScenDESCRIPTOR_: TFIBStringField;
    Label11: TLabel;
    lcbDict: TDBLookupComboboxEh;
    dsDicts: TpFIBDataSet;
    dsDictsPK: TFIBIntegerField;
    dsDictsNAME: TFIBStringField;
    dsoDicts: TDataSource;
    Label1: TLabel;
    cbScenType: TComboBox;
    dsWizardStatesPK: TFIBIntegerField;
    dsWizardStatesFORM_PK: TFIBIntegerField;
    dsWizardStatesFIELD_JSON: TFIBMemoField;
    dsWizardStatesACTION_: TFIBStringField;
    dsWizardStatesDESCRIPTOR_: TFIBStringField;
    dsWizardStatesFULL_SCREEN: TFIBIntegerField;
    dsWizardStatesSAFE_CLOSE: TFIBIntegerField;
    dsWizardStatesREF_PK: TFIBIntegerField;
    dsWizardStatesREF_DESCRIPTOR: TFIBStringField;
    dsWizardStatesREF_TITLE: TFIBStringField;
    dsStateFormsPK: TFIBIntegerField;
    dsStateFormsTITLE: TFIBStringField;
    dsStateFormsWIDTH: TFIBIntegerField;
    dsStateFormsHEIGHT: TFIBIntegerField;
    dsStateFormsALIAS_FORM: TFIBStringField;
    mtWizardStatesFORM_PK: TIntegerField;
    mtWizardStatesFORM_TITLE: TStringField;
    mtWizardStatesFORM_WIDTH: TIntegerField;
    mtWizardStatesFORM_HEIGHT: TIntegerField;
    mtWizardStatesACTION_: TStringField;
    mtWizardStatesFIELD_JSON: TStringField;
    mtWizardStatesDESCRIPTOR_: TStringField;
    mtWizardStatesFULL_SCREEN: TIntegerField;
    mtWizardStatesSAFE_CLOSE: TIntegerField;
    mtWizardStatesREF_PK: TIntegerField;
    mtWizardStatesREF_DESCRIPTOR: TStringField;
    mtWizardStatesREF_TITLE: TStringField;
    dsStatesCrossPK: TFIBIntegerField;
    dsStatesCrossPK_PREW: TFIBIntegerField;
    dsStatesCrossPK_NEXT: TFIBIntegerField;
    dsStatesCrossNAME: TFIBStringField;
    dsStatesCrossADD_BUTTON: TFIBIntegerField;
    dsStatesCrossBUTTON_ORDER: TFIBIntegerField;
    dsStatesCrossNEED_CLOSE: TFIBSmallIntField;
    dsStatesCrossSHOW_IN_VIEW: TFIBSmallIntField;
    dsStatesCrossHOT_KEY: TFIBStringField;
    mtStatesCrossPK_PREW: TIntegerField;
    mtStatesCrossPK_NEXT: TIntegerField;
    mtStatesCrossNAME: TStringField;
    mtStatesCrossADD_BUTTON: TIntegerField;
    mtStatesCrossBUTTON_ORDER: TIntegerField;
    mtStatesCrossNEED_CLOSE: TSmallintField;
    mtStatesCrossSHOW_IN_VIEW: TSmallintField;
    mtStatesCrossHOT_KEY: TStringField;
    Label5: TLabel;
    sbAddScenSlot: TSpeedButton;
    sbEditScenSlot: TSpeedButton;
    sbDelScenSlot: TSpeedButton;
    dbgScenSlots: TDBGridEh;
    dsScenSlots: TpFIBDataSet;
    mtScenSlots: TMemTableEh;
    dsoScenSlots: TDataSource;
    Label8: TLabel;
    sbAddScenSlotVal: TSpeedButton;
    sbEditScenSlotVal: TSpeedButton;
    sbDelScenSlotVal: TSpeedButton;
    dbgScenSlotVal: TDBGridEh;
    mtScenSlotVal: TMemTableEh;
    dsoScenSlotVal: TDataSource;
    dsScenSlotVal: TpFIBDataSet;
    Label9: TLabel;
    sbAddStateSlot: TSpeedButton;
    sbEditStateSlot: TSpeedButton;
    sbDelStateSlot: TSpeedButton;
    dbgStateSlots: TDBGridEh;
    Label10: TLabel;
    sbAddStateSlotVal: TSpeedButton;
    sbEditStateSlotVal: TSpeedButton;
    sbDelStateSlotVal: TSpeedButton;
    dbgStateSlotVal: TDBGridEh;
    dsScenSlotsPK: TFIBIntegerField;
    dsScenSlotsNAME: TFIBStringField;
    dsScenSlotsSLOT_TYPE: TFIBStringField;
    dsScenSlotsMAIN_SLOT: TFIBIntegerField;
    mtScenSlotsNAME: TStringField;
    mtScenSlotsSLOT_TYPE: TStringField;
    mtScenSlotsMAIN_SLOT: TIntegerField;
    dsScenSlotValPK: TFIBIntegerField;
    dsScenSlotValSLOT_PK: TFIBIntegerField;
    dsScenSlotValCROSS_PK: TFIBIntegerField;
    dsScenSlotValSLOT_VALUE: TFIBStringField;
    mtScenSlotValSLOT_PK: TIntegerField;
    mtScenSlotValCROSS_PK: TIntegerField;
    mtScenSlotValSLOT_VALUE: TStringField;
    dsStateSlots: TpFIBDataSet;
    FIBIntegerField1: TFIBIntegerField;
    FIBStringField1: TFIBStringField;
    FIBStringField2: TFIBStringField;
    FIBIntegerField2: TFIBIntegerField;
    mtStateSlots: TMemTableEh;
    dsoStateSlots: TDataSource;
    dsStateSlotVal: TpFIBDataSet;
    FIBIntegerField3: TFIBIntegerField;
    FIBIntegerField4: TFIBIntegerField;
    FIBIntegerField5: TFIBIntegerField;
    FIBStringField3: TFIBStringField;
    mtStateSlotVal: TMemTableEh;
    dsoStateSlotVal: TDataSource;
    mtScenSlotsPK: TIntegerField;
    mtScenSlotValPK: TIntegerField;
    mtStateSlotsPK: TIntegerField;
    mtStateSlotValPK: TIntegerField;
    mtScenSlotsCHANGED: TBooleanField;
    mtScenSlotValCHANGED: TBooleanField;
    mtStateSlotsNAME: TStringField;
    mtStateSlotsSLOT_TYPE: TStringField;
    mtStateSlotsMAIN_SLOT: TIntegerField;
    mtStateSlotsCHANGED: TBooleanField;
    mtStateSlotValSLOT_PK: TIntegerField;
    mtStateSlotValCROSS_PK: TIntegerField;
    mtStateSlotValSLOT_VALUE: TStringField;
    mtStateSlotValCHANGED: TBooleanField;
    dsScenSlotsSCEN_PK: TFIBIntegerField;
    mtScenSlotsSCEN_PK: TIntegerField;
    dsStateSlotsSATE_PK: TFIBIntegerField;
    mtStateSlotsSATE_PK: TIntegerField;
    qEditSlot: TpFIBQuery;
    qEditSlotVal: TpFIBQuery;
    sbGenStateSQL: TSpeedButton;
    pmStateGrid: TPopupMenu;
    AOpenDict: TAction;
    dsWizardStatesPARENT_REFERENCE_PK: TFIBIntegerField;
    dsWizardStatesFOLDER_PK: TFIBIntegerField;
    dsWizardStatesREF_LOGIN: TFIBStringField;
    dsWizardStatesFORM_LOGIN: TFIBStringField;
    mtWizardStatesPARENT_REFERENCE_PK: TIntegerField;
    mtWizardStatesFOLDER_PK: TIntegerField;
    mtWizardStatesREF_LOGIN: TStringField;
    mtWizardStatesFORM_LOGIN: TStringField;
    AOpenForm: TAction;
    AGenStateSQL: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    dsWizardScenNO_MES: TFIBStringField;
    Label12: TLabel;
    edNoMes: TEdit;
    AGridOptions: TAction;
    pmGrid: TPopupMenu;
    MenuItem1: TMenuItem;
    ToolBar1: TToolBar;
    tbRefresh: TToolButton;
    btnRefresh: TBitBtn;
    tbGenSQL: TToolButton;
    ToolButton1: TToolButton;
    tbSave: TToolButton;
    dsWizardStatesMAY_DOUBLE: TFIBIntegerField;
    mtWizardStatesMAY_DOUBLE: TIntegerField;
    tbJumpToTree: TToolButton;
    AExportToExcel: TAction;
    AExportToCsv: TAction;
    Excel1: TMenuItem;
    csv1: TMenuItem;
    dsWizardStatesFORM_WIDTH: TFIBIntegerField;
    dsWizardStatesFORM_HEIGHT: TFIBIntegerField;
    dsWizardScenGUID: TFIBStringField;
    dsWizardStatesGUID: TFIBStringField;
    mtWizardStatesGUID: TStringField;
    dsScenSlotsGUID: TFIBStringField;
    mtScenSlotsGUID: TStringField;
    dsStateSlotsGUID: TFIBStringField;
    mtStateSlotsGUID: TStringField;
    dsScenSlotValGUID: TFIBStringField;
    mtScenSlotValGUID: TStringField;
    dsStateSlotValGUID: TFIBStringField;
    mtStateSlotValGUID: TStringField;
    dsStatesCrossGUID: TFIBStringField;
    mtStatesCrossGUID: TStringField;
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbAddStateClick(Sender: TObject);
    procedure sbDelStateClick(Sender: TObject);
    procedure sbEditStateClick(Sender: TObject);
    procedure mtWizardStatesBeforePost(DataSet: TDataSet);
    procedure dbgWizardStatesGetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure mtWizardStatesAfterInsert(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure mtWizardStatesBeforeDelete(DataSet: TDataSet);
    procedure sbAddCrossClick(Sender: TObject);
    procedure sbEditCrossClick(Sender: TObject);
    procedure sbDelCrossClick(Sender: TObject);
    procedure mtStatesCrossAfterInsert(DataSet: TDataSet);
    procedure mtStatesCrossBeforeDelete(DataSet: TDataSet);
    procedure mtStatesCrossBeforePost(DataSet: TDataSet);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgWizardStatesDblClick(Sender: TObject);
    procedure dbgStatesCrossDblClick(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure dbgWizardStatesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgStatesCrossKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mtWizardStatesAfterScroll(DataSet: TDataSet);
    procedure mtScenSlotsAfterScroll(DataSet: TDataSet);
    procedure mtStateSlotsAfterScroll(DataSet: TDataSet);
    procedure mtScenSlotsAfterInsert(DataSet: TDataSet);
    procedure mtScenSlotsBeforeDelete(DataSet: TDataSet);
    procedure mtScenSlotsBeforePost(DataSet: TDataSet);
    procedure mtScenSlotValBeforeDelete(DataSet: TDataSet);
    procedure mtScenSlotValAfterInsert(DataSet: TDataSet);
    procedure mtStateSlotValAfterInsert(DataSet: TDataSet);
    procedure sbAddScenSlotClick(Sender: TObject);
    procedure sbEditScenSlotClick(Sender: TObject);
    procedure sbDelScenSlotClick(Sender: TObject);
    procedure sbAddScenSlotValClick(Sender: TObject);
    procedure sbEditScenSlotValClick(Sender: TObject);
    procedure sbDelScenSlotValClick(Sender: TObject);
    procedure sbAddStateSlotClick(Sender: TObject);
    procedure sbEditStateSlotClick(Sender: TObject);
    procedure sbDelStateSlotClick(Sender: TObject);
    procedure sbAddStateSlotValClick(Sender: TObject);
    procedure sbEditStateSlotValClick(Sender: TObject);
    procedure sbDelStateSlotValClick(Sender: TObject);
    procedure dbgScenSlotsDblClick(Sender: TObject);
    procedure dbgScenSlotsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgStateSlotsDblClick(Sender: TObject);
    procedure dbgStateSlotsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgScenSlotValDblClick(Sender: TObject);
    procedure dbgScenSlotValKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgStateSlotValDblClick(Sender: TObject);
    procedure dbgStateSlotValKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbGenStateSQLClick(Sender: TObject);
    procedure AOpenDictExecute(Sender: TObject);
    procedure AOpenFormExecute(Sender: TObject);
    procedure AGenStateSQLExecute(Sender: TObject);
    procedure AGridOptionsExecute(Sender: TObject);
    procedure dbgWizardStatesColumns5EditButtonClick(Sender: TObject; var Handled: Boolean);
    procedure tbRefreshClick(Sender: TObject);
    procedure tbGenSQLClick(Sender: TObject);
    procedure tbJumpToTreeClick(Sender: TObject);
    procedure AExportToExcelExecute(Sender: TObject);
    procedure AExportToCsvExecute(Sender: TObject);
  private
    DeletedStates: TStringList;
    DeletedCross: TStringList;
    DeletedSlots: TStringList;
    DeletedSlotVals: TStringList;
    IsLoadingGrid: boolean;
    function SaveData: boolean;
    procedure SaveGridData;
    procedure SaveSlots(MemTable: TMemTableEh; DelList: TStringList);
    procedure SaveSlotVals(MemTable: TMemTableEh; DelList: TStringList);
    procedure SetMode(Value: TOpenMode); override;
    procedure SetProperties(Value: TNodeDictInfo); override;
    procedure LoadGridData;
    procedure LoadStateCross;
    procedure LoadSlots(DataSet: TpFIBDataSet; MemTable: TMemTableEh);
    procedure LoadSlotVals(DataSet: TpFIBDataSet; MemTable: TMemTableEh);
    procedure LoadLookups;
    procedure AutoIncOrder;
    procedure ApplyCrossEditorData(FCrossEditor: TFCrossEditor);
    procedure ApplyStateEditorData(FStateEditor: TFStateEditor);
    procedure ApplySlotEditorData(FSlotEditor: TFSlotEditor);
    procedure ApplySlotValEditorData(FSlotValEditor: TFSlotValEditor);
    procedure ApplyJsonEditorData(FJsonReader: TFJsonReader);
    procedure GroupEdit(Grid: TDBGridEh);
    function OpenJsonEditor(Field: TField; StatusText: string): TFJsonReader;
    procedure _Reload;
    function gcsScen(Script, Vars: TStringList): boolean;
    function gcsStates(Script, Vars, Cache: TStringList): boolean;
    function gcsStateCross(Script, Vars, Cache, StateCache: TStringList): boolean;
    function gcsSlots(Script, Vars, Deleted, Cache, StateCache: TStringList; Data: TMemTableEh): boolean;
    function gcsSlotVals(Script, Vars, Deleted, SlotCache, CrossCache: TStringList; Data: TMemTableEh): boolean;
    function GenChangesSQL(Script, Vars: TStringList): boolean; override;
  public
    procedure OnCrossEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure OnStateEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure OnSlotEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure OnSlotValEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure OnJsonEditorClose(Sender: TObject; var Action: TCloseAction);
    function GetShortCaption: string; override;
  end;

implementation

{$R *.dfm}

uses scriptEditor;

procedure TFEditWizard.ApplySlotEditorData(FSlotEditor: TFSlotEditor);
var
  mt: TMemTableEh;

begin
  if FSlotEditor.IsScenSlot then mt := mtScenSlots
  else mt := mtStateSlots;

  mt.DisableControls;
  try
    if FSlotEditor.Mode = omAdd then mt.Append
    else begin
      if mt.BookmarkValid(FSlotEditor.EditingRec) then
      begin
        mt.GotoBookmark(FSlotEditor.EditingRec);
        mt.Edit;
      end else
      begin
        if Application.MessageBox('Редактируемая запись была удалена! Восстановить?', 'Подтверждение',
          MB_YESNO + MB_ICONWARNING) = ID_YES then
        begin
          mt.Append;
        end else exit;
      end;
    end;

    if FSlotEditor.edName.Text = '' then mt.FieldByName('NAME').Clear
    else mt.FieldByName('NAME').AsString := FSlotEditor.edName.Text;
    if FSlotEditor.cbType.ItemIndex = -1 then mt.FieldByName('SLOT_TYPE').Clear
    else mt.FieldByName('SLOT_TYPE').AsString := FSlotEditor.cbType.Text;
    mt.FieldByName('MAIN_SLOT').AsInteger := iif(FSlotEditor.chbMainSlot.Checked, 1, 0);
    mt.Post;
  finally
    mt.EnableControls;
  end;
end;

procedure TFEditWizard.ApplySlotValEditorData(FSlotValEditor: TFSlotValEditor);
var
  mt: TMemTableEh;

begin
  if FSlotValEditor.IsScenSlot then mt := mtScenSlotVal
  else mt := mtStateSlotVal;

  mt.DisableControls;
  try
    if FSlotValEditor.Mode = omAdd then mt.Append
    else begin
      if mt.BookmarkValid(FSlotValEditor.EditingRec) then
      begin
        mt.GotoBookmark(FSlotValEditor.EditingRec);
        mt.Edit;
      end else
      begin
        if Application.MessageBox('Редактируемая запись была удалена! Восстановить?', 'Подтверждение',
          MB_YESNO + MB_ICONWARNING) = ID_YES then
        begin
          mt.Append;
        end else exit;
      end;
    end;

    mt.FieldByName('CROSS_PK').AsVariant := FSlotValEditor.edCross.Value;
    if FSlotValEditor.edSlotValue.Text = '' then mt.FieldByName('SLOT_VALUE').Clear
    else mt.FieldByName('SLOT_VALUE').AsString := FSlotValEditor.edSlotValue.Text;
    mt.Post;
  finally
    mt.EnableControls;
  end;
end;

procedure TFEditWizard.ApplyStateEditorData(FStateEditor: TFStateEditor);
begin
  mtWizardStates.DisableControls;
  try
    if FStateEditor.Mode = omAdd then mtWizardStates.Append
    else begin
      if mtWizardStates.BookmarkValid(FStateEditor.EditingRec) then
      begin
        mtWizardStates.GotoBookmark(FStateEditor.EditingRec);
        mtWizardStates.Edit;
      end else
      begin
        if Application.MessageBox('Редактируемая запись была удалена! Восстановить?', 'Подтверждение',
          MB_YESNO + MB_ICONWARNING) = ID_YES then
        begin
          mtWizardStates.Append;
        end else exit;
      end;
    end;

    mtWizardStates.FieldByName('FORM_PK').Value := FStateEditor.lcbForm.KeyValue;
    mtWizardStates.FieldByName('FORM_WIDTH').Value := FStateEditor.edFormWidth.Value;
    mtWizardStates.FieldByName('FORM_HEIGHT').Value := FStateEditor.edFormHeight.Value;
    if FStateEditor.mFieldJson.Text = '' then mtWizardStatesFIELD_JSON.Clear
    else mtWizardStatesFIELD_JSON.AsString := FStateEditor.mFieldJson.Text;
    if FStateEditor.cbAction.ItemIndex = -1 then mtWizardStatesACTION_.Clear
    else mtWizardStatesACTION_.AsString := FStateEditor.cbAction.Text;
    if FStateEditor.edDescriptor.Text = '' then mtWizardStatesDESCRIPTOR_.Clear
    else mtWizardStatesDESCRIPTOR_.AsString := FStateEditor.edDescriptor.Text;
    mtWizardStatesFULL_SCREEN.AsInteger := iif(FStateEditor.chbFullScreen.Checked, 1, 0);
    mtWizardStatesSAFE_CLOSE.AsInteger := iif(FStateEditor.chbSafeClose.Checked, 1, 0);
    mtWizardStatesMAY_DOUBLE.AsInteger := iif(FStateEditor.chbMayDouble.Checked, 1, 0);
    mtWizardStates.Post;
  finally
    mtWizardStates.EnableControls;
  end;
end;

procedure TFEditWizard.AExportToCsvExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToCsv(TDBGridEh(ActiveControl), edName.Text);
end;

procedure TFEditWizard.AExportToExcelExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToExcel(TDBGridEh(ActiveControl), edName.Text);
end;

procedure TFEditWizard.AGenStateSQLExecute(Sender: TObject);
begin
  sbGenStateSQLClick(Sender);
end;

procedure TFEditWizard.AGridOptionsExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FSettings.GridParamsDialog(TDBGridEh(ActiveControl), ClassName);
end;

procedure TFEditWizard.AOpenDictExecute(Sender: TObject);
var
  d: TNodeDictInfo;
  
begin
  if (not mtWizardStates.Active) or mtWizardStates.IsEmpty or mtWizardStatesREF_PK.IsNull then exit;

  d := AssignNodeData(cotDict);
  d.PK := mtWizardStatesREF_PK.AsVariant;
  d.Descriptor := mtWizardStatesREF_DESCRIPTOR.AsVariant;
  d.Title := mtWizardStatesREF_TITLE.AsVariant;
  d.ParentDictPK := mtWizardStatesPARENT_REFERENCE_PK.AsVariant;
  d.FolderPK := mtWizardStatesFOLDER_PK.AsVariant;
  d.Login := mtWizardStatesREF_LOGIN.AsVariant;

  FMain.EditDict(d);
end;

procedure TFEditWizard.AOpenFormExecute(Sender: TObject);
var
  d: TNodeDictInfo;
  
begin
  if (not mtWizardStates.Active) or mtWizardStates.IsEmpty or mtWizardStatesFORM_PK.IsNull then exit;

  d := AssignNodeData(cotForm);
  d.PK := mtWizardStatesFORM_PK.AsVariant;
  d.Title := mtWizardStatesFORM_TITLE.AsVariant;
  d.ParentDictPK := mtWizardStatesREF_PK.AsVariant;
  d.Login := mtWizardStatesFORM_LOGIN.AsVariant;

  FMain.EditForm(d);
end;

procedure TFEditWizard.ApplyCrossEditorData(FCrossEditor: TFCrossEditor);
begin
  mtStatesCross.DisableControls;
  try
    if FCrossEditor.Mode = omAdd then mtStatesCross.Append
    else begin
      if mtStatesCross.BookmarkValid(FCrossEditor.EditingRec) then
      begin
        mtStatesCross.GotoBookmark(FCrossEditor.EditingRec);
        mtStatesCross.Edit;
      end else
      begin
        if Application.MessageBox('Редактируемая запись была удалена! Восстановить?', 'Подтверждение',
          MB_YESNO + MB_ICONWARNING) = ID_YES then
        begin
          mtStatesCross.Append;
        end else exit;
      end;
    end;

    if FCrossEditor.edName.Text = '' then mtStatesCrossNAME.Clear
    else mtStatesCrossNAME.AsString := FCrossEditor.edName.Text;
    mtStatesCrossPK_NEXT.AsVariant := FCrossEditor.edNextState.Value;
    mtStatesCrossBUTTON_ORDER.AsVariant := FCrossEditor.edButtonOrder.Value;
    mtStatesCrossNEED_CLOSE.AsInteger := iif(FCrossEditor.chbNeedClose.Checked, 1, 0);
    mtStatesCrossSHOW_IN_VIEW.AsInteger := iif(FCrossEditor.chbShowInView.Checked, 1, 0);
    mtStatesCrossADD_BUTTON.AsInteger := iif(FCrossEditor.chbAddButton.Checked, 1, 0);
    if FCrossEditor.edHotKey.Text = '' then mtStatesCrossHOT_KEY.Clear
    else mtStatesCrossHOT_KEY.AsString := FCrossEditor.edHotKey.Text;
    mtStatesCross.Post;
  finally
    mtStatesCross.EnableControls;
  end;
end;

procedure TFEditWizard.ApplyJsonEditorData(FJsonReader: TFJsonReader);
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

procedure TFEditWizard.ASaveExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then btnSaveClick(btnSave);
end;

procedure TFEditWizard.AutoIncOrder;
begin
  mtStatesCrossBUTTON_ORDER.Tag := mtStatesCrossBUTTON_ORDER.Tag + 1;
end;

procedure TFEditWizard.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFEditWizard.btnSaveClick(Sender: TObject);
var
  FScript: TFScriptEditor;

begin
  if Mode = omView then exit;

  if FSettings.ConfirmSave and
    (Application.MessageBox('Сохранить изменения Сценария в базу данных?', 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES) then exit;

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

procedure TFEditWizard.dbgWizardStatesColumns5EditButtonClick(Sender: TObject; var Handled: Boolean);
{var
  col: TColumnEh;}

begin
 { col := FindColumnByFieldName(dbgWizardStates, 'FIELD_JSON');
  OpenJsonEditor(mtWizardStatesFIELD_JSON, 'Состояние: ' + mtWizardStatesDESCRIPTOR_.AsString + '  ' + mtWizardStatesFORM_TITLE.AsString +
    ' : ' + col.Title.Hint); }
end;

procedure TFEditWizard.dbgWizardStatesDblClick(Sender: TObject);
begin
  sbEditStateClick(sbEditState);
end;

procedure TFEditWizard.dbgWizardStatesGetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  if TDBGridEh(Sender).DataSource.DataSet.FieldByName('CHANGED').AsBoolean then
  begin
    if TDBGridEh(Sender).DataSource.DataSet.FieldByName('PK').IsNull then Background := FSettings.GridOptions.NewRowColor
    else Background := FSettings.GridOptions.ChangedRowColor;
  end {else Background := clWindow};
end;

procedure TFEditWizard.dbgWizardStatesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddStateClick(sbAddState);
    VK_RETURN: if ssShift in Shift then sbEditStateClick(sbEditState);
    else
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
  end;
end;

procedure TFEditWizard.dbgScenSlotsDblClick(Sender: TObject);
begin
  sbEditScenSlotClick(sbEditScenSlot);
end;

procedure TFEditWizard.dbgScenSlotsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddScenSlotClick(sbAddScenSlot);
    VK_RETURN: if ssShift in Shift then sbEditScenSlotClick(sbEditScenSlot);
    else
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
  end;
end;

procedure TFEditWizard.dbgScenSlotValDblClick(Sender: TObject);
begin
  sbEditScenSlotValClick(sbEditScenSlotVal);
end;

procedure TFEditWizard.dbgScenSlotValKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddScenSlotValClick(sbAddScenSlotVal);
    VK_RETURN: if ssShift in Shift then sbEditScenSlotValClick(sbEditScenSlotVal);
    else
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
  end;
end;

procedure TFEditWizard.dbgStatesCrossDblClick(Sender: TObject);
begin
  sbEditCrossClick(sbEditCross);
end;

procedure TFEditWizard.dbgStatesCrossKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddCrossClick(sbAddCross);
    VK_RETURN: if ssShift in Shift then sbEditCrossClick(sbEditCross);
    else
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
  end;
end;

procedure TFEditWizard.dbgStateSlotsDblClick(Sender: TObject);
begin
  sbEditStateSlotClick(sbEditStateSlot);
end;

procedure TFEditWizard.dbgStateSlotsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddStateSlotClick(sbAddStateSlot);
    VK_RETURN: if ssShift in Shift then sbEditStateSlotClick(sbEditStateSlot);
    else
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
  end;
end;

procedure TFEditWizard.dbgStateSlotValDblClick(Sender: TObject);
begin
  sbEditStateSlotValClick(sbEditStateSlotVal);
end;

procedure TFEditWizard.dbgStateSlotValKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddStateSlotValClick(sbAddStateSlotVal);
    VK_RETURN: if ssShift in Shift then sbEditStateSlotValClick(sbEditStateSlotVal);
    else
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
  end;
end;

procedure TFEditWizard.FormActivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, true);
  FMain.CheckFormButton(Tag);
end;

procedure TFEditWizard.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FSettings.ChildMaximized := WindowState = wsMaximized;
end;

procedure TFEditWizard.FormCreate(Sender: TObject);
begin
  DeletedStates := TStringList.Create;
  DeletedCross := TStringList.Create;
  DeletedSlots := TStringList.Create;
  DeletedSlotVals := TStringList.Create;
end;

procedure TFEditWizard.FormDeactivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, false);
end;

procedure TFEditWizard.FormDestroy(Sender: TObject);
begin
  DeletedStates.Free;
  DeletedCross.Free;
  DeletedSlots.Free;
  DeletedSlotVals.Free;
end;

function TFEditWizard.gcsScen(Script, Vars: TStringList): boolean;
var
  sl: TStringList;

begin
  sl := TStringList.Create;
  result := false;

  try
    gcsCheckOption(sl, dsWizardScenNAME, Trim(edName.Text), true);
    gcsCheckOption(sl, dsWizardScenSCEN_TYPE, cbScenType.Text, true);
    gcsCheckOption(sl, dsWizardScenREF_PK, lcbDict.KeyValue, false, true, true);
    gcsCheckOption(sl, dsWizardScenDESCRIPTOR_, Trim(edDescriptor.Text), true);
    gcsCheckOption(sl, dsWizardScenNO_MES, Trim(edNoMes.Text), true);

    result := gcsGenUpdateSQL(Script, sl, 'WIZARD_SCENS', 'PK', ':SCEN_PK', [], '/* WIZARD_SCENS */');
  finally
    sl.Free;
  end;
end;

function TFEditWizard.gcsSlots(Script, Vars, Deleted, Cache, StateCache: TStringList; Data: TMemTableEh): boolean;
var
  bm: TBookmark;
  sl: TStringList;
  n: integer;

begin
  result := false;
  sl := TStringList.Create;

  try
    // удаление
    result := gcsGenDeleteSQL(Script, Deleted, 'WIZARD_SATES_SLOTS', 'PK');

    bm := Data.GetBookmark;
    Data.DisableControls;

    // добавление
    Data.First;
    while not Data.Eof do
    begin
      if Data.FieldByName('CHANGED').AsBoolean and Data.FieldByName('PK').IsNull then
      begin
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* WIZARD_SATES_SLOTS */');
        end;

        if Data.Fields.FindField('SATE_PK') <> nil then
          sl.Add(gcsGenParentParam(Script, Vars, StateCache, Data.FieldByName('SATE_PK').Value, 'STATE_PK', 'PK', 'WIZARD_SATES'))
        else
          sl.Add('null');
        sl.Add(VariantToDBStr(Data.FieldByName('NAME').Value, true));
        sl.Add(VariantToDBStr(Data.FieldByName('SLOT_TYPE').Value, true));
        sl.Add(VariantToDBStr(Data.FieldByName('MAIN_SLOT').Value, false));
        if Data.Fields.FindField('SCEN_PK') <> nil then
          sl.Add(':SCEN_PK')
        else
          sl.Add('null');
        sl.Add(VariantToDBStr(Data.FieldByName('ORDER_BY').Value, false));
        sl.Add(VariantToDBStr(Data.FieldByName('GUID').Value, true));

        n := Cache.Add(Data.FieldByName('GUID').AsString);
        Vars.Add('declare variable SLOT_PK' + IntToStr(n) + ' integer;');

        gcsGenInsertSQL(Script, sl, 'WIZARD_SATES_SLOTS', 'SATE_PK, NAME, SLOT_TYPE, MAIN_SLOT, SCEN_PK, ORDER_BY, GUID', ['PK'], [':SLOT_PK' + IntToStr(n)]);

        result := true;
      end;
      Data.Next;
    end;

    // обновление
    Data.First;
    while not Data.Eof do
    begin
      if Data.FieldByName('CHANGED').AsBoolean and (not Data.FieldByName('PK').IsNull) then
      begin
        if Data.FieldByName('GUID').IsNull then raise Exception.Create(GUID_WARNING);
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* WIZARD_SATES_SLOTS */');
        end;

        if Data.Fields.FindField('SATE_PK') <> nil then
          sl.Add(gcsGenParentParam(Script, Vars, StateCache, Data.FieldByName('SATE_PK').Value, 'STATE_PK', 'PK', 'WIZARD_SATES', 'SATE_PK = '))
        else
          sl.Add('SATE_PK = null');
        sl.Add('NAME = ' + VariantToDBStr(Data.FieldByName('NAME').Value, true));
        sl.Add('SLOT_TYPE = ' + VariantToDBStr(Data.FieldByName('SLOT_TYPE').Value, true));
        sl.Add('MAIN_SLOT = ' + VariantToDBStr(Data.FieldByName('MAIN_SLOT').Value, false));
        if Data.Fields.FindField('SCEN_PK') <> nil then
          sl.Add('SCEN_PK = :SCEN_PK')
        else
          sl.Add('SCEN_PK = null');
        sl.Add('ORDER_BY = ' + VariantToDBStr(Data.FieldByName('ORDER_BY').Value, false));

        result := gcsGenUpdateSQL(Script, sl, 'WIZARD_SATES_SLOTS', 'GUID', VariantToDBStr(Data.FieldByName('GUID').Value, true), []);
      end;
      Data.Next;
    end;
  finally
    sl.Free;
    if Data.BookmarkValid(bm) then
    begin
      Data.GotoBookmark(bm);
      Data.FreeBookmark(bm);
    end;
    Data.EnableControls;
  end;
end;

function TFEditWizard.gcsSlotVals(Script, Vars, Deleted, SlotCache, CrossCache: TStringList; Data: TMemTableEh): boolean;
var
  bm: TBookmark;
  sl: TStringList;

begin
  result := false;
  sl := TStringList.Create;

  try
    // удаление
    result := gcsGenDeleteSQL(Script, Deleted, 'WIZARD_SC_SLOT_VAL', 'PK');

    bm := Data.GetBookmark;
    Data.DisableControls;

    // добавление
    Data.First;
    while not Data.Eof do
    begin
      if Data.FieldByName('CHANGED').AsBoolean and Data.FieldByName('PK').IsNull then
      begin
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* WIZARD_SC_SLOT_VAL */');
        end;

        sl.Add(gcsGenParentParam(Script, Vars, SlotCache, Data.FieldByName('SLOT_PK').Value, 'SLOT_PK', 'PK', 'WIZARD_SATES_SLOTS'));
        sl.Add(gcsGenParentParam(Script, Vars, CrossCache, Data.FieldByName('CROSS_PK').Value, 'CROSS_PK', 'PK', 'WIZARD_SATES_CROSS'));
        sl.Add(VariantToDBStr(Data.FieldByName('SLOT_VALUE').Value, true));
        sl.Add(VariantToDBStr(Data.FieldByName('GUID').Value, true));

        gcsGenInsertSQL(Script, sl, 'WIZARD_SC_SLOT_VAL', 'SLOT_PK, CROSS_PK, SLOT_VALUE, GUID', [], []);
        result := true;
      end;
      Data.Next;
    end;

    // обновление
    Data.First;
    while not Data.Eof do
    begin
      if Data.FieldByName('CHANGED').AsBoolean and (not Data.FieldByName('PK').IsNull) then
      begin
        if Data.FieldByName('GUID').IsNull then raise Exception.Create(GUID_WARNING);
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* WIZARD_SC_SLOT_VAL */');
        end;

        sl.Add(gcsGenParentParam(Script, Vars, SlotCache, Data.FieldByName('SLOT_PK').Value, 'SLOT_PK', 'PK', 'WIZARD_SATES_SLOTS', 'SLOT_PK = '));
        sl.Add(gcsGenParentParam(Script, Vars, CrossCache, Data.FieldByName('CROSS_PK').Value, 'CROSS_PK', 'PK', 'WIZARD_SATES_CROSS', 'CROSS_PK = '));
        sl.Add('SLOT_VALUE = ' + VariantToDBStr(Data.FieldByName('SLOT_VALUE').Value, true));

        result := gcsGenUpdateSQL(Script, sl, 'WIZARD_SC_SLOT_VAL', 'GUID', VariantToDBStr(Data.FieldByName('GUID').Value, true), []);
      end;
      Data.Next;
    end;
  finally
    sl.Free;
    if Data.BookmarkValid(bm) then
    begin
      Data.GotoBookmark(bm);
      Data.FreeBookmark(bm);
    end;
    Data.EnableControls;
  end;
end;

function TFEditWizard.gcsStateCross(Script, Vars, Cache, StateCache: TStringList): boolean;
var
  bm: TBookmark;
  sl: TStringList;
  n: integer;

begin
  result := false;
  sl := TStringList.Create;

  try
    // удаление
    result := gcsGenDeleteSQL(Script, DeletedCross, 'WIZARD_SATES_CROSS', 'PK');

    bm := mtStatesCross.GetBookmark;
    mtStatesCross.DisableControls;

    // добавление
    mtStatesCross.First;
    while not mtStatesCross.Eof do
    begin
      if mtStatesCrossCHANGED.AsBoolean and mtStatesCrossPK.IsNull then
      begin
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* WIZARD_SATES_CROSS */');
        end;

        sl.Add(gcsGenParentParam(Script, Vars, StateCache, mtStatesCrossPK_PREW.AsVariant, 'STATE_PK', 'PK', 'WIZARD_SATES'));
        sl.Add(gcsGenParentParam(Script, Vars, StateCache, mtStatesCrossPK_NEXT.AsVariant, 'STATE_PK', 'PK', 'WIZARD_SATES'));
        sl.Add(VariantToDBStr(mtStatesCrossNAME.AsVariant, true));
        sl.Add(VariantToDBStr(mtStatesCrossADD_BUTTON.AsVariant, false));
        sl.Add(VariantToDBStr(mtStatesCrossBUTTON_ORDER.AsVariant, false));
        sl.Add(VariantToDBStr(mtStatesCrossNEED_CLOSE.AsVariant, false));
        sl.Add(VariantToDBStr(mtStatesCrossSHOW_IN_VIEW.AsVariant, false));
        sl.Add(VariantToDBStr(mtStatesCrossHOT_KEY.AsVariant, true));
        sl.Add(VariantToDBStr(mtStatesCrossGUID.AsVariant, true));

        n := Cache.Add(mtStatesCrossGUID.AsString);
        Vars.Add('declare variable CROSS_PK' + IntToStr(n) + ' integer;');

        gcsGenInsertSQL(Script, sl, 'WIZARD_SATES_CROSS', 'PK_PREW, PK_NEXT, NAME, ADD_BUTTON, BUTTON_ORDER, NEED_CLOSE, SHOW_IN_VIEW, HOT_KEY, GUID',
          ['PK'], [':CROSS_PK' + IntToStr(n)]);

        result := true;
      end;
      mtStatesCross.Next;
    end;

    // обновление
    mtStatesCross.First;
    while not mtStatesCross.Eof do
    begin
      if mtStatesCrossCHANGED.AsBoolean and (not mtStatesCrossPK.IsNull) then
      begin
        if mtStatesCrossGUID.IsNull then raise Exception.Create(GUID_WARNING);
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* WIZARD_SATES_CROSS */');
        end;

        sl.Add(gcsGenParentParam(Script, Vars, StateCache, mtStatesCrossPK_PREW.AsVariant, 'STATE_PK', 'PK', 'WIZARD_SATES', 'PK_PREW = '));
        sl.Add(gcsGenParentParam(Script, Vars, StateCache, mtStatesCrossPK_NEXT.AsVariant, 'STATE_PK', 'PK', 'WIZARD_SATES', 'PK_NEXT = '));
        sl.Add('NAME = ' + VariantToDBStr(mtStatesCrossNAME.AsVariant, true));
        sl.Add('ADD_BUTTON = ' + VariantToDBStr(mtStatesCrossADD_BUTTON.AsVariant, false));
        sl.Add('BUTTON_ORDER = ' + VariantToDBStr(mtStatesCrossBUTTON_ORDER.AsVariant, false));
        sl.Add('NEED_CLOSE = ' + VariantToDBStr(mtStatesCrossNEED_CLOSE.AsVariant, false));
        sl.Add('SHOW_IN_VIEW = ' + VariantToDBStr(mtStatesCrossSHOW_IN_VIEW.AsVariant, false));
        sl.Add('HOT_KEY = ' + VariantToDBStr(mtStatesCrossHOT_KEY.AsVariant, true));

        result := gcsGenUpdateSQL(Script, sl, 'WIZARD_SATES_CROSS', 'GUID', VariantToDBStr(mtStatesCrossGUID.AsVariant, true), []);
      end;
      mtStatesCross.Next;
    end;
  finally
    sl.Free;
    if mtStatesCross.BookmarkValid(bm) then
    begin
      mtStatesCross.GotoBookmark(bm);
      mtStatesCross.FreeBookmark(bm);
    end;
    mtStatesCross.EnableControls;
  end;
end;

function TFEditWizard.gcsStates(Script, Vars, Cache: TStringList): boolean;
var
  bm: TBookmark;
  sl: TStringList;
  n: integer;

begin
  result := false;
  sl := TStringList.Create;

  try
    // удаление
    result := gcsGenDeleteSQL(Script, DeletedStates, 'WIZARD_SATES', 'PK');

    bm := mtWizardStates.GetBookmark;
    mtWizardStates.DisableControls;

    // добавление
    mtWizardStates.First;
    while not mtWizardStates.Eof do
    begin
      if mtWizardStatesCHANGED.AsBoolean and mtWizardStatesPK.IsNull then
      begin
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* WIZARD_SATES */');
        end;

        sl.Add(':SCEN_PK');
        sl.Add(gcsGenParentParam(Script, Vars, TStringList.Create, mtWizardStatesFORM_PK.AsVariant, 'FORM_PK', 'PK', 'DYNAMIC_FORM'));
        sl.Add(VariantToDBStr(mtWizardStatesFIELD_JSON.AsVariant, true));
        sl.Add(VariantToDBStr(mtWizardStatesACTION_.AsVariant, true));
        sl.Add(VariantToDBStr(mtWizardStatesDESCRIPTOR_.AsVariant, true));
        sl.Add(VariantToDBStr(mtWizardStatesFULL_SCREEN.AsVariant, false));
        sl.Add(VariantToDBStr(mtWizardStatesSAFE_CLOSE.AsVariant, false));
        sl.Add(VariantToDBStr(mtWizardStatesMAY_DOUBLE.AsVariant, false));
        sl.Add(VariantToDBStr(mtWizardStatesGUID.AsVariant, true));

        n := Cache.Add(mtWizardStatesGUID.AsString);
        Vars.Add('declare variable STATE_PK' + IntToStr(n) + ' integer;');

        gcsGenInsertSQL(Script, sl, 'WIZARD_SATES', 'SCEN_PK, FORM_PK, FIELD_JSON, ACTION_, DESCRIPTOR_, FULL_SCREEN, SAFE_CLOSE, MAY_DOUBLE, GUID',
          ['PK'], [':STATE_PK' + IntToStr(n)]);

        result := true;
      end;
      mtWizardStates.Next;
    end;

    // обновление
    mtWizardStates.First;
    while not mtWizardStates.Eof do
    begin
      if mtWizardStatesCHANGED.AsBoolean and (not mtWizardStatesPK.IsNull) then
      begin
        if mtWizardStatesGUID.IsNull then raise Exception.Create(GUID_WARNING);
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* WIZARD_SATES */');
        end;

        sl.Add(gcsGenParentParam(Script, Vars, TStringList.Create, mtWizardStatesFORM_PK.AsVariant, 'FORM_PK', 'PK', 'DYNAMIC_FORM', 'FORM_PK = '));
        sl.Add('FIELD_JSON = ' + VariantToDBStr(mtWizardStatesFIELD_JSON.AsVariant, true));
        sl.Add('ACTION_ = ' + VariantToDBStr(mtWizardStatesACTION_.AsVariant, true));
        sl.Add('DESCRIPTOR_ = ' + VariantToDBStr(mtWizardStatesDESCRIPTOR_.AsVariant, true));
        sl.Add('FULL_SCREEN = ' + VariantToDBStr(mtWizardStatesFULL_SCREEN.AsVariant, false));
        sl.Add('SAFE_CLOSE = ' + VariantToDBStr(mtWizardStatesSAFE_CLOSE.AsVariant, false));
        sl.Add('MAY_DOUBLE = ' + VariantToDBStr(mtWizardStatesMAY_DOUBLE.AsVariant, false));

        result := gcsGenUpdateSQL(Script, sl, 'WIZARD_SATES', 'GUID', VariantToDBStr(mtWizardStatesGUID.AsVariant, true), []);
      end;
      mtWizardStates.Next;
    end;
  finally
    sl.Free;
    if mtWizardStates.BookmarkValid(bm) then
    begin
      mtWizardStates.GotoBookmark(bm);
      mtWizardStates.FreeBookmark(bm);
    end;
    mtWizardStates.EnableControls;
  end;
end;

function TFEditWizard.GenChangesSQL(Script, Vars: TStringList): boolean;
var
  stateCache, crossCache, slotCache: TStringList;

begin
  result := false;
  stateCache := TStringList.Create;
  crossCache := TStringList.Create;
  slotCache := TStringList.Create;

  try
    Vars.Add('declare variable SCEN_PK integer;');
    Script.Add('  select PK from WIZARD_SCENS where GUID = ''' + dsWizardScenGUID.AsString + ''' into :SCEN_PK;');

    result := gcsScen(Script, Vars);
    if gcsStates(Script, Vars, stateCache) then result := true;
    if gcsStateCross(Script, Vars, crossCache, stateCache) then result := true;
    if gcsSlots(Script, Vars, DeletedSlots, slotCache, stateCache, mtScenSlots) then result := true;
    if gcsSlots(Script, Vars, DeletedSlots, slotCache, stateCache, mtStateSlots) then result := true;
    if gcsSlotVals(Script, Vars, DeletedSlotVals, slotCache, crossCache, mtScenSlotVal) then result := true;
    if gcsSlotVals(Script, Vars, DeletedSlotVals, slotCache, crossCache, mtStateSlotVal) then result := true;
  finally
    stateCache.Free;
    crossCache.Free;
    slotCache.Free;
  end;
end;

function TFEditWizard.GetShortCaption: string;
begin
  if Mode = omAdd then
    result := Caption
  else
    result := iif(edName.Text = '', lcbDict.Text, edName.Text) + iif(edDescriptor.Text <> '', ' : ' + edDescriptor.Text, '');
end;

procedure TFEditWizard.GroupEdit(Grid: TDBGridEh);
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

procedure TFEditWizard.LoadGridData;
var
  i: integer;

begin
  mtWizardStates.DisableControls;
  try
    IsLoadingGrid := true;
    if mtWizardStates.Active then
    begin
      mtWizardStates.EmptyTable;
      mtWizardStates.Close;
    end;
    mtWizardStates.CreateDataSet;

    if not VarIsNull(Properties.PK) then
    begin
      dsWizardStates.Close;
      dsWizardStates.ParamByName('PK').Value := Properties.PK;
      dsWizardStates.Open;
      dsWizardStates.First;

      while not dsWizardStates.Eof do
      begin
        mtWizardStates.Append;
        mtWizardStatesCHANGED.AsBoolean := false;
        for i := 0 to dsWizardStates.FieldCount - 1 do
          mtWizardStates.FieldByName(dsWizardStates.Fields.Fields[i].FieldName).Value := dsWizardStates.Fields.Fields[i].Value;

        mtWizardStates.Post;
        dsWizardStates.Next;
      end;
      dsWizardStates.Close;
      mtWizardStates.First;
    end;
  finally
    IsLoadingGrid := false;
    mtWizardStates.EnableControls;
  end;
end;

procedure TFEditWizard.LoadSlots(DataSet: TpFIBDataSet; MemTable: TMemTableEh);
var
  i: integer;

begin
  MemTable.DisableControls;
  try
    IsLoadingGrid := true;
    if MemTable.Active then
    begin
      MemTable.EmptyTable;
      MemTable.Close;
    end;
    MemTable.CreateDataSet;

    if not VarIsNull(Properties.PK) then
    begin
      DataSet.Close;
      DataSet.ParamByName('PK').Value := Properties.PK;
      DataSet.Open;
      DataSet.First;

      while not DataSet.Eof do
      begin
        MemTable.Append;
        MemTable.FieldByName('CHANGED').AsBoolean := false;
        for i := 0 to DataSet.FieldCount - 1 do
          MemTable.FieldByName(DataSet.Fields.Fields[i].FieldName).Value := DataSet.Fields.Fields[i].Value;

        MemTable.Post;
        DataSet.Next;
      end;
      DataSet.Close;
      MemTable.First;

      if MemTable = mtStateSlots then
      begin
        if (not mtWizardStates.Active) or mtWizardStates.IsEmpty or mtWizardStatesPK.IsNull then
          MemTable.Filter := 'SATE_PK is null'
        else
          MemTable.Filter := 'SATE_PK=' + mtWizardStatesPK.AsString;

        MemTable.Filtered := true;
      end;
    end;
  finally
    IsLoadingGrid := false;
    MemTable.EnableControls;
  end;
end;

procedure TFEditWizard.LoadSlotVals(DataSet: TpFIBDataSet; MemTable: TMemTableEh);
var
  i: integer;
  fmt: TMemTableEh;
  
begin
  MemTable.DisableControls;
  try
    IsLoadingGrid := true;
    if MemTable.Active then
    begin
      MemTable.EmptyTable;
      MemTable.Close;
    end;
    MemTable.CreateDataSet;

    if not VarIsNull(Properties.PK) then
    begin
      DataSet.Close;
      DataSet.ParamByName('PK').Value := Properties.PK;
      DataSet.Open;
      DataSet.First;

      while not DataSet.Eof do
      begin
        MemTable.Append;
        MemTable.FieldByName('CHANGED').AsBoolean := false;
        for i := 0 to DataSet.FieldCount - 1 do
          MemTable.FieldByName(DataSet.Fields.Fields[i].FieldName).Value := DataSet.Fields.Fields[i].Value;

        MemTable.Post;
        DataSet.Next;
      end;
      DataSet.Close;
      MemTable.First;

      if MemTable = mtScenSlotVal then fmt := mtScenSlots
      else fmt := mtStateSlots;
      
      if (not fmt.Active) or fmt.IsEmpty or fmt.FieldByName('PK').IsNull then
        MemTable.Filter := 'SLOT_PK is null'
      else
        MemTable.Filter := 'SLOT_PK=' + fmt.FieldByName('PK').AsString;

      MemTable.Filtered := true;
    end;
  finally
    IsLoadingGrid := false;
    MemTable.EnableControls;
  end;
end;

procedure TFEditWizard.LoadStateCross;
var
  i: integer;

begin
  mtStatesCross.DisableControls;
  try
    IsLoadingGrid := true;
    if mtStatesCross.Active then
    begin
      mtStatesCross.EmptyTable;
      mtStatesCross.Close;
    end;
    mtStatesCross.CreateDataSet;

    if not VarIsNull(Properties.PK) then
    begin
      dsStatesCross.Close;
      dsStatesCross.ParamByName('PK').Value := Properties.PK;
      dsStatesCross.Open;
      dsStatesCross.First;

      while not dsStatesCross.Eof do
      begin
        mtStatesCross.Append;
        mtStatesCrossCHANGED.AsBoolean := false;
        for i := 0 to dsStatesCross.FieldCount - 1 do
          mtStatesCross.FieldByName(dsStatesCross.Fields.Fields[i].FieldName).Value := dsStatesCross.Fields.Fields[i].Value;

        mtStatesCross.Post;
        mtStatesCrossBUTTON_ORDER.Tag := Max(mtStatesCrossBUTTON_ORDER.AsInteger, mtStatesCrossBUTTON_ORDER.Tag);
        dsStatesCross.Next;
      end;
      dsStatesCross.Close;
      mtStatesCross.First;

      if (not mtWizardStates.Active) or mtWizardStates.IsEmpty or mtWizardStatesPK.IsNull then
        mtStatesCross.Filter := 'PK_PREW is null'
      else
        mtStatesCross.Filter := 'PK_PREW=' + mtWizardStatesPK.AsString;

      mtStatesCross.Filtered := true;
    end;
  finally
    IsLoadingGrid := false;
    mtStatesCross.EnableControls;
  end;
end;

procedure TFEditWizard.LoadLookups;
begin
  dsDicts.Close;
  dsDicts.Open;
  dsStateForms.Close;
  dsStateForms.Open;
end;

procedure TFEditWizard.mtWizardStatesAfterInsert(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    //mtWizardStatesACTION_.AsString := 'add';
    mtWizardStatesFULL_SCREEN.AsInteger := 0;
    mtWizardStatesSAFE_CLOSE.AsInteger := 0;
    mtWizardStatesMAY_DOUBLE.AsInteger := 0;
  end;
end;

procedure TFEditWizard.mtWizardStatesAfterScroll(DataSet: TDataSet);
begin
  // в mtStatesCross (кнопки состояния) залиты данные по всем WizardStates, тут надо только фильтровать их
  if mtStatesCross.Active then
  begin
    if mtStatesCross.State in [dsEdit, dsInsert] then mtStatesCross.Post;

    if (not mtWizardStates.Active) or mtWizardStates.IsEmpty or mtWizardStatesPK.IsNull then
      mtStatesCross.Filter := 'PK_PREW is null'
    else
      mtStatesCross.Filter := 'PK_PREW=' + mtWizardStatesPK.AsString;

    mtStatesCross.Filtered := true;
  end;

  // тоже самое для mtStateSlots (слоты состояния)
  if mtStateSlots.Active then
  begin
    if mtStateSlots.State in [dsEdit, dsInsert] then mtStateSlots.Post;

    if (not mtWizardStates.Active) or mtWizardStates.IsEmpty or mtWizardStatesPK.IsNull then
      mtStateSlots.Filter := 'SATE_PK is null'
    else
      mtStateSlots.Filter := 'SATE_PK=' + mtWizardStatesPK.AsString;

    mtStateSlots.Filtered := true;
    mtStateSlotsAfterScroll(mtStateSlots);
  end;
end;

procedure TFEditWizard.mtWizardStatesBeforeDelete(DataSet: TDataSet);
begin
  if mtWizardStatesPK.AsString <> '' then DeletedStates.Add(mtWizardStatesPK.AsString);
end;

procedure TFEditWizard.mtWizardStatesBeforePost(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    //if mtWizardStatesFORM_PK.IsNull then raise Exception.Create('Не все обязательные поля заполнены!');
    mtWizardStatesCHANGED.AsBoolean := true;
    if mtWizardStatesGUID.IsNull then mtWizardStatesGUID.AsString := CreateGuid;
  end;
end;

procedure TFEditWizard.mtScenSlotsAfterInsert(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    if DataSet = mtScenSlots then DataSet.FieldByName('SCEN_PK').Value := Properties.PK
    else begin
      if mtWizardStates.Active and (not mtWizardStates.IsEmpty) then
        DataSet.FieldByName('SATE_PK').Value := mtWizardStates.FieldByName('PK').Value;
    end;
    DataSet.FieldByName('SLOT_TYPE').AsString := 'in';
    DataSet.FieldByName('MAIN_SLOT').AsInteger := 0;
  end;
end;

procedure TFEditWizard.mtScenSlotsAfterScroll(DataSet: TDataSet);
begin
  // в mtScenSlotVal (значения слота сценария) залиты данные по всем слотам сценария, надо их фильтровать
  if mtScenSlotVal.Active then
  begin
    if mtScenSlotVal.State in [dsEdit, dsInsert] then mtScenSlotVal.Post;

    if (not mtScenSlots.Active) or mtScenSlots.IsEmpty or mtScenSlotsPK.IsNull then
      mtScenSlotVal.Filter := 'SLOT_PK is null'
    else
      mtScenSlotVal.Filter := 'SLOT_PK=' + mtScenSlotsPK.AsString;

    mtScenSlotVal.Filtered := true;
  end;
end;

procedure TFEditWizard.mtScenSlotsBeforeDelete(DataSet: TDataSet);
begin
  if DataSet.FieldByName('PK').AsString <> '' then DeletedSlots.Add(DataSet.FieldByName('PK').AsString);
end;

procedure TFEditWizard.mtScenSlotsBeforePost(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    DataSet.FieldByName('CHANGED').AsBoolean := true;
    if DataSet.FieldByName('GUID').IsNull then DataSet.FieldByName('GUID').AsString := CreateGuid;
  end;
end;

procedure TFEditWizard.mtScenSlotValAfterInsert(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    if mtScenSlots.Active and (not mtScenSlots.IsEmpty) then
      mtScenSlotVal.FieldByName('SLOT_PK').Value := mtScenSlots.FieldByName('PK').Value;
  end;
end;

procedure TFEditWizard.mtScenSlotValBeforeDelete(DataSet: TDataSet);
begin
  if DataSet.FieldByName('PK').AsString <> '' then DeletedSlotVals.Add(DataSet.FieldByName('PK').AsString);
end;

procedure TFEditWizard.mtStatesCrossAfterInsert(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    AutoIncOrder;
    if mtWizardStates.Active and (not mtWizardStates.IsEmpty) then
      mtStatesCross.FieldByName('PK_PREW').Value := mtWizardStates.FieldByName('PK').Value;
    mtStatesCrossBUTTON_ORDER.AsInteger := mtStatesCrossBUTTON_ORDER.Tag;
    mtStatesCrossADD_BUTTON.AsInteger := 1;
    mtStatesCrossNEED_CLOSE.AsInteger := 1;
    mtStatesCrossSHOW_IN_VIEW.AsInteger := 1;
  end;
end;

procedure TFEditWizard.mtStatesCrossBeforeDelete(DataSet: TDataSet);
begin
  if mtStatesCrossPK.AsString <> '' then DeletedCross.Add(mtStatesCrossPK.AsString);
end;

procedure TFEditWizard.mtStatesCrossBeforePost(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    if mtStatesCrossPK_PREW.IsNull then raise Exception.Create('Не все обязательные поля заполнены!');
    mtStatesCrossCHANGED.AsBoolean := true;
    if mtStatesCrossGUID.IsNull then mtStatesCrossGUID.AsString := CreateGuid;
  end;
end;

procedure TFEditWizard.mtStateSlotsAfterScroll(DataSet: TDataSet);
begin
  // в mtStateSlotVal (значения слота состояния) залиты данные по всем слотам состояния в сценарии, надо их фильтровать
  if mtStateSlotVal.Active then
  begin
    if mtStateSlotVal.State in [dsEdit, dsInsert] then mtStateSlotVal.Post;

    if (not mtStateSlots.Active) or mtStateSlots.IsEmpty or mtStateSlotsPK.IsNull then
      mtStateSlotVal.Filter := 'SLOT_PK is null'
    else
      mtStateSlotVal.Filter := 'SLOT_PK=' + mtStateSlotsPK.AsString;

    mtStateSlotVal.Filtered := true;
  end;
end;

procedure TFEditWizard.mtStateSlotValAfterInsert(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    if mtStateSlots.Active and (not mtStateSlots.IsEmpty) then
      mtStateSlotVal.FieldByName('SLOT_PK').Value := mtStateSlots.FieldByName('PK').Value;
  end;
end;

procedure TFEditWizard.OnSlotEditorClose(Sender: TObject; var Action: TCloseAction);
var
  mt: TMemTableEh;

begin
  if TFSlotEditor(Sender).IsScenSlot then mt := mtScenSlots
  else mt := mtStateSlots;

  Action := caFree;
  if TFSlotEditor(Sender).Success then
  begin
    if mt.State in [dsEdit, dsInsert] then
    begin
      case Application.MessageBox(pchar('Невозможно сохранить данные, пока таблица слотов в режиме редактирования! Сначала нужно сохранить ' +
        'или отменить изменения в таблице. Сохранить изменения [YES], оменить [NO], или отложить сохранение формы [CANCEL] ' +
        '(сохранить эти данные можно будет позже)?'), 'Подтверждение', MB_YESNOCANCEL + MB_ICONQUESTION) of
        ID_YES: mt.Post;
        ID_NO: mt.Cancel;
        ID_CANCEL:
        begin
          TFSlotEditor(Sender).Success := false;
          Action := caNone;
        end;
      end;
    end;

    if Action <> caNone then ApplySlotEditorData(TFSlotEditor(Sender));
  end;
end;

procedure TFEditWizard.OnSlotValEditorClose(Sender: TObject; var Action: TCloseAction);
var
  mt: TMemTableEh;

begin
  if TFSlotValEditor(Sender).IsScenSlot then mt := mtScenSlotVal
  else mt := mtStateSlotVal;

  Action := caFree;
  if TFSlotValEditor(Sender).Success then
  begin
    if mt.State in [dsEdit, dsInsert] then
    begin
      case Application.MessageBox(pchar('Невозможно сохранить данные, пока таблица значений в режиме редактирования! Сначала нужно сохранить ' +
        'или отменить изменения в таблице. Сохранить изменения [YES], оменить [NO], или отложить сохранение формы [CANCEL] ' +
        '(сохранить эти данные можно будет позже)?'), 'Подтверждение', MB_YESNOCANCEL + MB_ICONQUESTION) of
        ID_YES: mt.Post;
        ID_NO: mt.Cancel;
        ID_CANCEL:
        begin
          TFSlotValEditor(Sender).Success := false;
          Action := caNone;
        end;
      end;
    end;

    if Action <> caNone then ApplySlotValEditorData(TFSlotValEditor(Sender));
  end;
end;

procedure TFEditWizard.OnStateEditorClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if TFStateEditor(Sender).Success then
  begin
    if mtWizardStates.State in [dsEdit, dsInsert] then
    begin
      case Application.MessageBox(pchar('Невозможно сохранить данные, пока таблица состояний в режиме редактирования! Сначала нужно сохранить ' +
        'или отменить изменения в таблице. Сохранить изменения [YES], оменить [NO], или отложить сохранение формы [CANCEL] ' +
        '(сохранить эти данные можно будет позже)?'), 'Подтверждение', MB_YESNOCANCEL + MB_ICONQUESTION) of
        ID_YES: mtWizardStates.Post;
        ID_NO: mtWizardStates.Cancel;
        ID_CANCEL:
        begin
          TFStateEditor(Sender).Success := false;
          Action := caNone;
        end;
      end;
    end;

    if Action <> caNone then ApplyStateEditorData(TFStateEditor(Sender));
  end;
end;

function TFEditWizard.OpenJsonEditor(Field: TField; StatusText: string): TFJsonReader;
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
  result.ASaveToField.Visible := m = omEdit;
  result.StatusBar.Panels[1].Text := StatusText;
  result.LoadText(Field.AsString);
  result.RegisterForm;
end;

procedure TFEditWizard.OnCrossEditorClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if TFCrossEditor(Sender).Success then
  begin
    if mtStatesCross.State in [dsEdit, dsInsert] then
    begin
      case Application.MessageBox(pchar('Невозможно сохранить данные, пока таблица кнопок в режиме редактирования! Сначала нужно сохранить ' +
        'или отменить изменения в таблице. Сохранить изменения [YES], оменить [NO], или отложить сохранение формы [CANCEL] ' +
        '(сохранить эти данные можно будет позже)?'), 'Подтверждение', MB_YESNOCANCEL + MB_ICONQUESTION) of
        ID_YES: mtStatesCross.Post;
        ID_NO: mtStatesCross.Cancel;
        ID_CANCEL:
        begin
          TFCrossEditor(Sender).Success := false;
          Action := caNone;
        end;
      end;
    end;

    if Action <> caNone then ApplyCrossEditorData(TFCrossEditor(Sender));
  end;
end;

procedure TFEditWizard.OnJsonEditorClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if TFJsonReader(Sender).Success then ApplyJsonEditorData(TFJsonReader(Sender));
end;

function TFEditWizard.SaveData: boolean;
var
  err: string;

begin
  if Trim(edDescriptor.Text) = '' then
  begin
    result := false;
    Application.MessageBox('Дескриптор сценария не может быть пустым!', 'Ошибка', MB_OK + MB_ICONERROR);
    exit;
  end;

  case Mode of
    omAdd:
    begin
      result := FMain.ExecSQL('insert into WIZARD_SCENS (NAME, SCEN_TYPE, REF_PK, DESCRIPTOR_, NO_MES, GUID) values (' +
        VariantToDBStr(Trim(edName.Text), true) + ', ' + VariantToDBStr(cbScenType.Text, true) + ', ' +
        VariantToDBStr(lcbDict.KeyValue, false, true, true) + ', ' + VariantToDBStr(Trim(edDescriptor.Text), true) + ', ' +
        VariantToDBStr(Trim(edNoMes.Text), true) + ', ' + VariantToDBStr(Properties.Guid, true) + ') returning (PK)', 'PK', Properties.PK, err);
      FMain.AddToRefLog(Properties.ObjType, iif(Trim(edDescriptor.Text) = '', edName.Text, edDescriptor.Text), VarToStr(Properties.Guid), rltCreate);
    end;
    omEdit:
    begin
      result := FMain.ExecSQL('update WIZARD_SCENS set NAME = ' + VariantToDBStr(Trim(edName.Text), true) +
        ', SCEN_TYPE = ' + VariantToDBStr(cbScenType.Text, true) + ', REF_PK = ' + VariantToDBStr(lcbDict.KeyValue, false, true, true) +
        ', DESCRIPTOR_ = ' + VariantToDBStr(Trim(edDescriptor.Text), true) + ', NO_MES = ' + VariantToDBStr(Trim(edNoMes.Text), true) +
        ', GUID = ' + VariantToDBStr(Properties.Guid, true) + ' where PK = ' + VarToStr(Properties.PK), err);
      FMain.AddToRefLog(Properties.ObjType, iif(Trim(edDescriptor.Text) = '', edName.Text, edDescriptor.Text), VarToStr(Properties.Guid), rltUpdate,
        iif(Trim(edDescriptor.Text) = '', 'PK ' + VarToStr(Properties.PK), ''));
    end
    else result := false;
  end;

  if (err <> '') then Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);

  if result then
  begin
    SetPropValues(Properties.PK, iif(Trim(edDescriptor.Text) = '', Null, Trim(edDescriptor.Text)),
      iif(Trim(edName.Text) = '', Null, Trim(edName.Text)), lcbDict.KeyValue, Properties.FolderPK, Properties.Login,
      Properties.ObjType, Properties.Guid);
    SaveGridData;
  end;
end;

procedure TFEditWizard.SaveGridData;
var
  err: string;

begin
  if mtWizardStates.State in [dsEdit, dsInsert] then mtWizardStates.Post;
  if mtStatesCross.State in [dsEdit, dsInsert] then mtStatesCross.Post;

  if Mode = omView then exit;

  // удаление состояний
  if DeletedStates.Count > 0 then
  begin
    if not FMain.ExecSQL('delete from WIZARD_SATES where PK in (' + TextToString(DeletedStates.Text) + ')', err) then
    begin
      Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;
    DeletedStates.Clear;
  end;

  // вставка/обновление состояний
  try
    mtWizardStates.First;
    while not mtWizardStates.Eof do
    begin
      if mtWizardStatesCHANGED.AsBoolean then
      begin
        qEditState.Close;
        qEditState.ParamByName('PK').Value := mtWizardStates.FieldByName('PK').Value;
        qEditState.ParamByName('SCEN_PK').Value := Properties.PK;
        qEditState.ParamByName('FORM_PK').Value := mtWizardStates.FieldByName('FORM_PK').Value;
        qEditState.ParamByName('FIELD_JSON').Value := mtWizardStates.FieldByName('FIELD_JSON').Value;
        qEditState.ParamByName('ACTION_').Value := mtWizardStates.FieldByName('ACTION_').Value;
        qEditState.ParamByName('DESCRIPTOR_').Value := mtWizardStates.FieldByName('DESCRIPTOR_').Value;
        qEditState.ParamByName('FULL_SCREEN').Value := mtWizardStates.FieldByName('FULL_SCREEN').Value;
        qEditState.ParamByName('SAFE_CLOSE').Value := mtWizardStates.FieldByName('SAFE_CLOSE').Value;
        qEditState.ParamByName('MAY_DOUBLE').Value := mtWizardStates.FieldByName('MAY_DOUBLE').Value;
        qEditState.ParamByName('GUID').Value := mtWizardStates.FieldByName('GUID').Value;
        qEditState.ExecQuery;
        FMain.Transact.CommitRetaining;

        if not mtWizardStatesFORM_PK.IsNull then
          if not FMain.ExecSQL('update DYNAMIC_FORM set WIDTH = ' +
            VariantToDBStr(mtWizardStates.FieldByName('FORM_WIDTH').Value, false) + ', HEIGHT = ' +
            VariantToDBStr(mtWizardStates.FieldByName('FORM_HEIGHT').Value, false) + ' where PK = ' +
            mtWizardStatesFORM_PK.AsString, err) then raise Exception.Create(err);
      end;
      mtWizardStates.Next;
    end;
  except
    on E: Exception do Application.MessageBox(pchar(E.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;

  // удаление кнопок визардов
  if DeletedCross.Count > 0 then
  begin
    if not FMain.ExecSQL('delete from WIZARD_SATES_CROSS where PK in (' + TextToString(DeletedCross.Text) + ')', err) then
    begin
      Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;
    DeletedCross.Clear;
  end;

  // вставка/обновление кнопок визардов
  try
    mtStatesCross.DisableControls;
    mtStatesCross.Filtered := false;
    mtStatesCross.First;
    while not mtStatesCross.Eof do
    begin
      if mtStatesCrossCHANGED.AsBoolean then
      begin
        qEditStateCross.Close;
        qEditStateCross.ParamByName('PK').Value := mtStatesCross.FieldByName('PK').Value;
        qEditStateCross.ParamByName('PK_PREW').Value := mtStatesCross.FieldByName('PK_PREW').Value;
        qEditStateCross.ParamByName('PK_NEXT').Value := mtStatesCross.FieldByName('PK_NEXT').Value;
        qEditStateCross.ParamByName('NAME').Value := mtStatesCross.FieldByName('NAME').Value;
        qEditStateCross.ParamByName('ADD_BUTTON').Value := mtStatesCross.FieldByName('ADD_BUTTON').Value;
        qEditStateCross.ParamByName('BUTTON_ORDER').Value := mtStatesCross.FieldByName('BUTTON_ORDER').Value;
        qEditStateCross.ParamByName('NEED_CLOSE').Value := mtStatesCross.FieldByName('NEED_CLOSE').Value;
        qEditStateCross.ParamByName('SHOW_IN_VIEW').Value := mtStatesCross.FieldByName('SHOW_IN_VIEW').Value;
        qEditStateCross.ParamByName('HOT_KEY').Value := mtStatesCross.FieldByName('HOT_KEY').Value;
        qEditStateCross.ParamByName('GUID').Value := mtStatesCross.FieldByName('GUID').Value;
        qEditStateCross.ExecQuery;
        FMain.Transact.CommitRetaining;
      end;
      mtStatesCross.Next;
    end;
  except
    on E: Exception do Application.MessageBox(pchar(E.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;
  mtStatesCross.EnableControls;
  mtStatesCross.Filtered := true;

  // сохраняем слоты сценария (и их значения)
  SaveSlots(mtScenSlots, DeletedSlots);
  SaveSlotVals(mtScenSlotVal, DeletedSlotVals);
  // сохраняем слоты состояний (и их значения)
  SaveSlots(mtStateSlots, DeletedSlots);
  SaveSlotVals(mtStateSlotVal, DeletedSlotVals);
end;

procedure TFEditWizard.SaveSlots(MemTable: TMemTableEh; DelList: TStringList);
var
  err: string;
  f: boolean;

begin
  if MemTable.State in [dsEdit, dsInsert] then MemTable.Post;

  if Mode = omView then exit;

  // удаление слотов
  if DelList.Count > 0 then
  begin
    if not FMain.ExecSQL('delete from WIZARD_SATES_SLOTS where PK in (' + TextToString(DelList.Text) + ')', err) then
    begin
      Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;
    DelList.Clear;
  end;

  // вставка/обновление слотов
  f := MemTable.Filtered;
  try
    MemTable.DisableControls;
    MemTable.Filtered := false;
    MemTable.First;
    while not MemTable.Eof do
    begin
      if MemTable.FieldByName('CHANGED').AsBoolean then
      begin
        qEditSlot.Close;
        qEditSlot.ParamByName('PK').Value := MemTable.FieldByName('PK').Value;
        qEditSlot.ParamByName('GUID').Value := MemTable.FieldByName('GUID').Value;
        if MemTable.Fields.FindField('SATE_PK') <> nil then
          qEditSlot.ParamByName('SATE_PK').Value := MemTable.FieldByName('SATE_PK').Value
        else
          qEditSlot.ParamByName('SATE_PK').Clear;
        qEditSlot.ParamByName('NAME').Value := MemTable.FieldByName('NAME').Value;
        qEditSlot.ParamByName('SLOT_TYPE').Value := MemTable.FieldByName('SLOT_TYPE').Value;
        qEditSlot.ParamByName('MAIN_SLOT').Value := MemTable.FieldByName('MAIN_SLOT').Value;
        if MemTable.Fields.FindField('SCEN_PK') <> nil then
          qEditSlot.ParamByName('SCEN_PK').Value := MemTable.FieldByName('SCEN_PK').Value
        else
          qEditSlot.ParamByName('SCEN_PK').Clear;

        qEditSlot.ExecQuery;
        FMain.Transact.CommitRetaining;
      end;
      MemTable.Next;
    end;
  except
    on E: Exception do Application.MessageBox(pchar(E.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;
  MemTable.EnableControls;
  MemTable.Filtered := f;
end;

procedure TFEditWizard.SaveSlotVals(MemTable: TMemTableEh; DelList: TStringList);
var
  err: string;
  
begin
  if MemTable.State in [dsEdit, dsInsert] then MemTable.Post;

  if Mode = omView then exit;

  // удаление значений слотов
  if DelList.Count > 0 then
  begin
    if not FMain.ExecSQL('delete from WIZARD_SC_SLOT_VAL where PK in (' + TextToString(DelList.Text) + ')', err) then
    begin
      Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;
    DelList.Clear;
  end;

  // вставка/обновление значений слотов
  try
    MemTable.DisableControls;
    MemTable.Filtered := false;
    MemTable.First;
    while not MemTable.Eof do
    begin
      if MemTable.FieldByName('CHANGED').AsBoolean then
      begin
        qEditSlotVal.Close;
        qEditSlotVal.ParamByName('PK').Value := MemTable.FieldByName('PK').Value;
        qEditSlotVal.ParamByName('SLOT_PK').Value := MemTable.FieldByName('SLOT_PK').Value;
        qEditSlotVal.ParamByName('CROSS_PK').Value := MemTable.FieldByName('CROSS_PK').Value;
        qEditSlotVal.ParamByName('SLOT_VALUE').Value := MemTable.FieldByName('SLOT_VALUE').Value;
        qEditSlotVal.ParamByName('GUID').Value := MemTable.FieldByName('GUID').Value;
        qEditSlotVal.ExecQuery;
        FMain.Transact.CommitRetaining;
      end;
      MemTable.Next;
    end;
  except
    on E: Exception do Application.MessageBox(pchar(E.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;
  MemTable.EnableControls;
  MemTable.Filtered := true;
end;

procedure TFEditWizard.sbDelScenSlotClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (not mtScenSlots.Active) or mtScenSlots.IsEmpty then exit;

  if dbgScenSlots.SelectedRows.Count > 1 then
  begin
    if Application.MessageBox(pchar('Удалить все отмеченные слоты (' + IntToStr(dbgScenSlots.SelectedRows.Count) + ')?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    dbgScenSlots.SelectedRows.Delete;
  end else
  begin
    if Application.MessageBox(pchar('Удалить слот "' + mtScenSlotsNAME.AsString + '"?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    mtScenSlots.Delete;
  end;
end;

procedure TFEditWizard.sbDelScenSlotValClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (not mtScenSlotVal.Active) or mtScenSlotVal.IsEmpty then exit;

  if dbgScenSlotVal.SelectedRows.Count > 1 then
  begin
    if Application.MessageBox(pchar('Удалить все отмеченные значения слота (' + IntToStr(dbgScenSlotVal.SelectedRows.Count) + ')?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    dbgScenSlotVal.SelectedRows.Delete;
  end else
  begin
    if Application.MessageBox(pchar('Удалить значение слота?'), 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;
    mtScenSlotVal.Delete;
  end;
end;

procedure TFEditWizard.sbDelStateClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (not mtWizardStates.Active) or mtWizardStates.IsEmpty then exit;

  if dbgWizardStates.SelectedRows.Count > 1 then
  begin
    if Application.MessageBox(pchar('Удалить все отмеченные состояния (' + IntToStr(dbgWizardStates.SelectedRows.Count) + ')?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    dbgWizardStates.SelectedRows.Delete;
  end else
  begin
    if Application.MessageBox(pchar('Удалить состояние "' + mtWizardStatesPK.AsString + '"?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    mtWizardStates.Delete;
  end;
end;

procedure TFEditWizard.sbDelStateSlotClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (not mtStateSlots.Active) or mtStateSlots.IsEmpty then exit;

  if dbgStateSlots.SelectedRows.Count > 1 then
  begin
    if Application.MessageBox(pchar('Удалить все отмеченные слоты (' + IntToStr(dbgStateSlots.SelectedRows.Count) + ')?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    dbgStateSlots.SelectedRows.Delete;
  end else
  begin
    if Application.MessageBox(pchar('Удалить слот "' + mtStateSlotsNAME.AsString + '"?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    mtStateSlots.Delete;
  end;
end;

procedure TFEditWizard.sbDelStateSlotValClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (not mtStateSlotVal.Active) or mtStateSlotVal.IsEmpty then exit;

  if dbgStateSlotVal.SelectedRows.Count > 1 then
  begin
    if Application.MessageBox(pchar('Удалить все отмеченные значения слота (' + IntToStr(dbgStateSlotVal.SelectedRows.Count) + ')?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    dbgStateSlotVal.SelectedRows.Delete;
  end else
  begin
    if Application.MessageBox(pchar('Удалить значение слота?'), 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;
    mtStateSlotVal.Delete;
  end;
end;

procedure TFEditWizard.sbDelCrossClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (not mtStatesCross.Active) or mtStatesCross.IsEmpty then exit;

  if dbgStatesCross.SelectedRows.Count > 1 then
  begin
    if Application.MessageBox(pchar('Удалить все отмеченные кнопки (' + IntToStr(dbgStatesCross.SelectedRows.Count) + ')?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    dbgStatesCross.SelectedRows.Delete;
  end else
  begin
    if Application.MessageBox(pchar('Удалить кнопку "' + mtStatesCrossNAME.AsString + '"?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    mtStatesCross.Delete;
  end;
end;

procedure TFEditWizard.sbEditScenSlotClick(Sender: TObject);
var
  FSlotEditor: TFSlotEditor;
  m: TOpenMode;

begin
  if mtScenSlots.IsEmpty then exit;

  if Mode = omView then m := omView
  else m := omEdit;

  if dbgScenSlots.SelectedRows.Count > 1 then
  begin
    GroupEdit(dbgScenSlots);
    exit;
  end;

  // открытие формы редактирования слота
  if FMain.SetFocusOpenedWindow(mtScenSlotsPK.AsInteger, TFSlotEditor.ClassName) then exit;
  FSlotEditor := TFSlotEditor.Create(Self, cftEditor, m, mtScenSlotsPK.AsVariant, FMain.OnChildFormClose);
  FSlotEditor.OnClose := OnSlotEditorClose;
  FSlotEditor.EditingRec := mtScenSlots.GetBookmark;
  FSlotEditor.IsScenSlot := true;
  FSlotEditor.Caption := 'Редактирование слота сценария';
  FSlotEditor.edPk.Text := mtScenSlotsPK.AsString;
  FSlotEditor.edName.Text := mtScenSlotsNAME.AsString;
  if mtScenSlotsSLOT_TYPE.IsNull then FSlotEditor.cbType.ItemIndex := -1
  else FSlotEditor.cbType.ItemIndex := FSlotEditor.cbType.Items.IndexOf(mtScenSlotsSLOT_TYPE.AsString);
  FSlotEditor.chbMainSlot.Checked := mtScenSlotsMAIN_SLOT.AsInteger = 1;
  FSlotEditor.RegisterForm;
end;

procedure TFEditWizard.sbEditScenSlotValClick(Sender: TObject);
var
  FSlotValEditor: TFSlotValEditor;
  m: TOpenMode;

begin
  if mtScenSlotVal.IsEmpty then exit;

  if Mode = omView then m := omView
  else m := omEdit;

  if dbgScenSlotVal.SelectedRows.Count > 1 then
  begin
    GroupEdit(dbgScenSlotVal);
    exit;
  end;

  // открытие формы редактирования значения слота
  if FMain.SetFocusOpenedWindow(mtScenSlotValPK.AsInteger, TFSlotValEditor.ClassName) then exit;
  FSlotValEditor := TFSlotValEditor.Create(Self, cftEditor, m, mtScenSlotValPK.AsVariant, FMain.OnChildFormClose);
  FSlotValEditor.OnClose := OnSlotValEditorClose;
  FSlotValEditor.EditingRec := mtScenSlotVal.GetBookmark;
  FSlotValEditor.IsScenSlot := true;
  FSlotValEditor.Caption := 'Редактировать значение слота';
  FSlotValEditor.edPk.Text := mtScenSlotValPK.AsString;
  FSlotValEditor.edCross.Value := mtScenSlotValCROSS_PK.AsVariant;
  FSlotValEditor.edSlotValue.Text := mtScenSlotValSLOT_VALUE.AsString;
  FSlotValEditor.RegisterForm;
end;

procedure TFEditWizard.sbEditStateClick(Sender: TObject);
var
  FStateEditor: TFStateEditor;
  m: TOpenMode;

begin
  if mtWizardStates.IsEmpty then exit;

  if Mode = omView then m := omView
  else m := omEdit;

  if dbgWizardStates.SelectedRows.Count > 1 then
  begin
    GroupEdit(dbgWizardStates);
    exit;
  end;

  // открытие формы редактирования состояния сценария
  if FMain.SetFocusOpenedWindow(mtWizardStatesPK.AsInteger, TFStateEditor.ClassName) then exit;
  FStateEditor := TFStateEditor.Create(Self, cftEditor, m, mtWizardStatesPK.AsVariant, FMain.OnChildFormClose);
  FStateEditor.OnClose := OnStateEditorClose;
  FStateEditor.dsoForm.DataSet := dsStateForms;
  FStateEditor.EditingRec := mtWizardStates.GetBookmark;
  FStateEditor.Caption := 'Редактирование состояния сценария';
  FStateEditor.edPk.Text := mtWizardStatesPK.AsString;
  FStateEditor.edDescriptor.Text := mtWizardStatesDESCRIPTOR_.AsString;
  FStateEditor.lcbForm.KeyValue := mtWizardStates.FieldByName('FORM_PK').Value;
  FStateEditor.edFormWidth.Value := mtWizardStatesFORM_WIDTH.AsVariant;
  FStateEditor.edFormHeight.Value := mtWizardStatesFORM_HEIGHT.AsVariant;
  if mtWizardStatesACTION_.IsNull then FStateEditor.cbAction.ItemIndex := -1
  else FStateEditor.cbAction.ItemIndex := FStateEditor.cbAction.Items.IndexOf(mtWizardStatesACTION_.AsString);
  FStateEditor.chbFullScreen.Checked := mtWizardStatesFULL_SCREEN.AsInteger = 1;
  FStateEditor.chbSafeClose.Checked := mtWizardStatesSAFE_CLOSE.AsInteger = 1;
  FStateEditor.chbMayDouble.Checked := mtWizardStatesMAY_DOUBLE.AsInteger = 1;
  FStateEditor.mFieldJson.Text := mtWizardStatesFIELD_JSON.AsString;
  FStateEditor.RegisterForm;
end;

procedure TFEditWizard.sbEditStateSlotClick(Sender: TObject);
var
  FSlotEditor: TFSlotEditor;
  m: TOpenMode;

begin
  if mtStateSlots.IsEmpty then exit;

  if Mode = omView then m := omView
  else m := omEdit;

  if dbgStateSlots.SelectedRows.Count > 1 then
  begin
    GroupEdit(dbgStateSlots);
    exit;
  end;

  // открытие формы редактирования слота
  if FMain.SetFocusOpenedWindow(mtStateSlotsPK.AsInteger, TFSlotEditor.ClassName) then exit;
  FSlotEditor := TFSlotEditor.Create(Self, cftEditor, m, mtStateSlotsPK.AsVariant, FMain.OnChildFormClose);
  FSlotEditor.OnClose := OnSlotEditorClose;
  FSlotEditor.EditingRec := mtStateSlots.GetBookmark;
  FSlotEditor.IsScenSlot := false;
  FSlotEditor.Caption := 'Редактирование слота состояния';
  FSlotEditor.edPk.Text := mtStateSlotsPK.AsString;
  FSlotEditor.edName.Text := mtStateSlotsNAME.AsString;
  if mtStateSlotsSLOT_TYPE.IsNull then FSlotEditor.cbType.ItemIndex := -1
  else FSlotEditor.cbType.ItemIndex := FSlotEditor.cbType.Items.IndexOf(mtStateSlotsSLOT_TYPE.AsString);
  FSlotEditor.chbMainSlot.Checked := mtStateSlotsMAIN_SLOT.AsInteger = 1;
  FSlotEditor.RegisterForm;
end;

procedure TFEditWizard.sbEditStateSlotValClick(Sender: TObject);
var
  FSlotValEditor: TFSlotValEditor;
  m: TOpenMode;

begin
  if mtStateSlotVal.IsEmpty then exit;

  if Mode = omView then m := omView
  else m := omEdit;

  if dbgStateSlotVal.SelectedRows.Count > 1 then
  begin
    GroupEdit(dbgStateSlotVal);
    exit;
  end;

  // открытие формы редактирования значения слота
  if FMain.SetFocusOpenedWindow(mtStateSlotValPK.AsInteger, TFSlotValEditor.ClassName) then exit;
  FSlotValEditor := TFSlotValEditor.Create(Self, cftEditor, m, mtStateSlotValPK.AsVariant, FMain.OnChildFormClose);
  FSlotValEditor.OnClose := OnSlotValEditorClose;
  FSlotValEditor.EditingRec := mtStateSlotVal.GetBookmark;
  FSlotValEditor.IsScenSlot := false;
  FSlotValEditor.Caption := 'Редактировать значение слота';
  FSlotValEditor.edPk.Text := mtStateSlotValPK.AsString;
  FSlotValEditor.edCross.Value := mtStateSlotValCROSS_PK.AsVariant;
  FSlotValEditor.edSlotValue.Text := mtStateSlotValSLOT_VALUE.AsString;
  FSlotValEditor.RegisterForm;
end;

procedure TFEditWizard.sbGenStateSQLClick(Sender: TObject);
var
  sl: TStringList;
  i: integer;
  bm: TBookmark;

begin
  if (not mtWizardStates.Active) or mtWizardStates.IsEmpty then exit;

  sl := TStringList.Create;
  try
    if dbgWizardStates.SelectedRows.Count = 0 then
      sl.Add(mtWizardStatesPK.AsString)
    else begin
      bm := mtWizardStates.GetBookmark;
      for i := 0 to dbgWizardStates.SelectedRows.Count - 1 do
      begin
        if mtWizardStates.BookmarkValid(TBookmark(dbgWizardStates.SelectedRows.Items[i])) then
        begin
          mtWizardStates.GotoBookmark(TBookmark(dbgWizardStates.SelectedRows.Items[i]));
          sl.Add(mtWizardStatesPK.AsString);
        end;
      end;
    end;

    FMain.SetSaveDialogToSQL;
    if FMain.SaveDialog.Execute then FMain.SaveToSQL(Properties, sl, FMain.SaveDialog.FileName);
  finally
    sl.Free;
    dbgWizardStates.SelectedRows.Clear;
    if mtWizardStates.BookmarkValid(bm) then mtWizardStates.GotoBookmark(bm);
  end;
end;

procedure TFEditWizard.sbEditCrossClick(Sender: TObject);
var
  FCrossEditor: TFCrossEditor;
  m: TOpenMode;

begin
  if mtStatesCross.IsEmpty then exit;

  if Mode = omView then m := omView
  else m := omEdit;

  if dbgStatesCross.SelectedRows.Count > 1 then
  begin
    GroupEdit(dbgStatesCross);
    exit;
  end;

  // открытие формы редактирования кнопки
  if FMain.SetFocusOpenedWindow(mtStatesCrossPK.AsInteger, TFCrossEditor.ClassName) then exit;
  FCrossEditor := TFCrossEditor.Create(Self, cftEditor, m, mtStatesCrossPK.AsVariant, FMain.OnChildFormClose);
  FCrossEditor.OnClose := OnCrossEditorClose;
  FCrossEditor.EditingRec := mtStatesCross.GetBookmark;
  FCrossEditor.Caption := 'Редактирование кнопки';
  FCrossEditor.edPk.Text := mtStatesCrossPK.AsString;
  FCrossEditor.edName.Text := mtStatesCrossNAME.AsString;
  FCrossEditor.edNextState.Value := mtStatesCrossPK_NEXT.AsVariant;
  FCrossEditor.edButtonOrder.Value := mtStatesCrossBUTTON_ORDER.AsVariant;
  FCrossEditor.chbNeedClose.Checked := mtStatesCrossNEED_CLOSE.AsInteger = 1;
  FCrossEditor.chbShowInView.Checked := mtStatesCrossSHOW_IN_VIEW.AsInteger = 1;
  FCrossEditor.chbAddButton.Checked := mtStatesCrossADD_BUTTON.AsInteger = 1;
  FCrossEditor.edHotKey.Text := mtStatesCrossHOT_KEY.AsString;
  FCrossEditor.RegisterForm;
end;

procedure TFEditWizard.sbAddScenSlotClick(Sender: TObject);
var
  FSlotEditor: TFSlotEditor;

begin
  if Mode = omView then exit;

  // открытие формы редактирования слота
  FSlotEditor := TFSlotEditor.Create(Self, cftEditor, omAdd, Null, FMain.OnChildFormClose);
  FSlotEditor.OnClose := OnSlotEditorClose;
  FSlotEditor.EditingRec := nil;
  FSlotEditor.IsScenSlot := true;
  FSlotEditor.Caption := 'Новый слот сценария';
  FSlotEditor.edPk.Text := '';
  FSlotEditor.edName.Text := '';
  FSlotEditor.cbType.ItemIndex := 0;
  FSlotEditor.chbMainSlot.Checked := false;
  FSlotEditor.RegisterForm;
end;

procedure TFEditWizard.sbAddScenSlotValClick(Sender: TObject);
var
  FSlotValEditor: TFSlotValEditor;

begin
  if Mode = omView then exit;
  if (not mtScenSlots.Active) or mtScenSlots.IsEmpty then exit;
  if mtScenSlotsPK.IsNull then
  begin
    Application.MessageBox('Перед тем как добавлять значение слота, сохраните этот слот в БД!', 'Ошибка',
      MB_OK + MB_ICONERROR);
    exit;
  end;

  // открытие формы редактирования значения слота
  FSlotValEditor := TFSlotValEditor.Create(Self, cftEditor, omAdd, Null, FMain.OnChildFormClose);
  FSlotValEditor.OnClose := OnSlotValEditorClose;
  FSlotValEditor.EditingRec := nil;
  FSlotValEditor.IsScenSlot := true;
  FSlotValEditor.Caption := 'Новое значение слота';
  FSlotValEditor.edPk.Text := '';
  FSlotValEditor.edCross.Value := Null;
  FSlotValEditor.edSlotValue.Text := '';
  FSlotValEditor.RegisterForm;
end;

procedure TFEditWizard.sbAddStateClick(Sender: TObject);
var
  FStateEditor: TFStateEditor;

begin
  if Mode = omView then exit;
  // открытие формы редактирования состояния сценария
  FStateEditor := TFStateEditor.Create(Self, cftEditor, omAdd, Null, FMain.OnChildFormClose);
  FStateEditor.OnClose := OnStateEditorClose;
  FStateEditor.dsoForm.DataSet := dsStateForms;
  FStateEditor.EditingRec := nil;
  FStateEditor.Caption := 'Новое состояние';
  FStateEditor.edPk.Text := '';
  FStateEditor.edDescriptor.Text := '';
  FStateEditor.lcbForm.KeyValue := Null;
  FStateEditor.edFormWidth.Value := Null;
  FStateEditor.edFormHeight.Value := Null;
  FStateEditor.cbAction.ItemIndex := -1;
  FStateEditor.chbFullScreen.Checked := false;
  FStateEditor.chbSafeClose.Checked := false;
  FStateEditor.chbMayDouble.Checked := false;
  FStateEditor.mFieldJson.Clear;
  FStateEditor.RegisterForm;
end;

procedure TFEditWizard.sbAddStateSlotClick(Sender: TObject);
var
  FSlotEditor: TFSlotEditor;

begin
  if Mode = omView then exit;
  if (not mtWizardStates.Active) or mtWizardStates.IsEmpty then exit;
  if mtWizardStatesPK.IsNull then
  begin
    Application.MessageBox('Перед тем как добавлять слот состояния, сохраните это состояние сценария в БД!', 'Ошибка',
      MB_OK + MB_ICONERROR);
    exit;
  end;

  // открытие формы редактирования слота
  FSlotEditor := TFSlotEditor.Create(Self, cftEditor, omAdd, Null, FMain.OnChildFormClose);
  FSlotEditor.OnClose := OnSlotEditorClose;
  FSlotEditor.EditingRec := nil;
  FSlotEditor.IsScenSlot := false;
  FSlotEditor.Caption := 'Новый слот состояния';
  FSlotEditor.edPk.Text := '';
  FSlotEditor.edName.Text := '';
  FSlotEditor.cbType.ItemIndex := 0;
  FSlotEditor.chbMainSlot.Checked := false;
  FSlotEditor.RegisterForm;
end;

procedure TFEditWizard.sbAddStateSlotValClick(Sender: TObject);
var
  FSlotValEditor: TFSlotValEditor;

begin
  if Mode = omView then exit;
  if (not mtStateSlots.Active) or mtStateSlots.IsEmpty then exit;
  if mtStateSlotsPK.IsNull then
  begin
    Application.MessageBox('Перед тем как добавлять значение слота, сохраните этот слот в БД!', 'Ошибка',
      MB_OK + MB_ICONERROR);
    exit;
  end;

  // открытие формы редактирования значения слота
  FSlotValEditor := TFSlotValEditor.Create(Self, cftEditor, omAdd, Null, FMain.OnChildFormClose);
  FSlotValEditor.OnClose := OnSlotValEditorClose;
  FSlotValEditor.EditingRec := nil;
  FSlotValEditor.IsScenSlot := false;
  FSlotValEditor.Caption := 'Новое значение слота';
  FSlotValEditor.edPk.Text := '';
  FSlotValEditor.edCross.Value := Null;
  FSlotValEditor.edSlotValue.Text := '';
  FSlotValEditor.RegisterForm;
end;

procedure TFEditWizard.sbAddCrossClick(Sender: TObject);
var
  FCrossEditor: TFCrossEditor;

begin
  if Mode = omView then exit;
  if (not mtWizardStates.Active) or mtWizardStates.IsEmpty then exit;
  if mtWizardStatesPK.IsNull then
  begin
    Application.MessageBox('Перед тем как добавлять кнопку, сохраните это состояние сценария в БД!', 'Ошибка',
      MB_OK + MB_ICONERROR);
    exit;
  end;
  
  // открытие формы редактирования кнопки
  AutoIncOrder;
  FCrossEditor := TFCrossEditor.Create(Self, cftEditor, omAdd, Null, FMain.OnChildFormClose);
  FCrossEditor.OnClose := OnCrossEditorClose;
  FCrossEditor.EditingRec := nil;
  FCrossEditor.Caption := 'Новая кнопка';
  FCrossEditor.edPk.Text := '';
  FCrossEditor.edName.Text := '';
  FCrossEditor.edButtonOrder.Value := mtStatesCrossBUTTON_ORDER.Tag;
  FCrossEditor.chbNeedClose.Checked := true;
  FCrossEditor.chbShowInView.Checked := true;
  FCrossEditor.chbAddButton.Checked := true;
  FCrossEditor.edHotKey.Text := '';
  FCrossEditor.RegisterForm;
end;

procedure TFEditWizard.SetProperties(Value: TNodeDictInfo);
begin
  inherited SetProperties(Value);

  if Mode <> omAdd then
  begin
    dsWizardScen.Close;
    dsWizardScen.ParamByName('PK').Value := Properties.PK;
    dsWizardScen.Open;
    if dsWizardScen.IsEmpty then
      raise Exception.Create('Не найден сценарий с PK ' + VarToStr(Properties.PK) + ' (дескриптор ' + VarToStr(Properties.Descriptor) +
        ')! Возможно он был пересоздан и его PK поменялся.');
    Properties.Guid := dsWizardScenGUID.AsVariant;
    edPk.Text := VarToStr(Properties.PK);
    edPk.Text := VarToStr(Properties.PK);
    edDescriptor.Text := VarToStr(Properties.Descriptor);
    edName.Text := VarToStr(Properties.Title);
    Caption := GenCaption('Сценарий', iif(Mode = omEdit, 'редактирование', 'просмотр'), edPk.Text, edDescriptor.Text, edName.Text,
      FSettings.TreeShowDescriptor);
    lcbDict.KeyValue := dsWizardScenREF_PK.Value;
    cbScenType.ItemIndex := cbScenType.Items.IndexOf(dsWizardScenSCEN_TYPE.AsString);
    edNoMes.Text := dsWizardScenNO_MES.AsString;
  end;
  LoadLookups;
  LoadGridData;
  LoadStateCross;
  LoadSlots(dsScenSlots, mtScenSlots);
  LoadSlotVals(dsScenSlotVal, mtScenSlotVal);
  LoadSlots(dsStateSlots, mtStateSlots);
  LoadSlotVals(dsStateSlotVal, mtStateSlotVal);
end;

procedure TFEditWizard.tbGenSQLClick(Sender: TObject);
begin
  FMain.SetSaveDialogToSQL;
  if FMain.SaveDialog.Execute then FMain.SaveToSQL(Properties, FMain.SaveDialog.FileName);
end;

procedure TFEditWizard.tbJumpToTreeClick(Sender: TObject);
begin
  if Mode = omAdd then exit;
  FMain.JumpToNode(cotWizard, Properties.PK);
end;

procedure TFEditWizard.tbRefreshClick(Sender: TObject);
begin
  if (Mode = omView) or (Application.MessageBox('При перезагрузке данных сценария все несохраненные изменения будут потеряны! Продолжить?',
    'Подтверждение', MB_YESNO + MB_ICONQUESTION) = ID_YES) then _Reload;
end;

procedure TFEditWizard._Reload;
begin
  if Mode = omAdd then Mode := omEdit;
  Properties := Properties;
end;

procedure TFEditWizard.SetMode(Value: TOpenMode);
begin
  inherited SetMode(Value);
  
  case FMode of
    omAdd:
    begin
      btnSave.Enabled := true;
      tbSave.Enabled := true;
      tbGenSQL.Enabled := false;
      btnRefresh.Enabled := false;
      tbRefresh.Enabled := false;
      Caption := 'Новый сценарий';
      edDescriptor.ReadOnly := false;
      edDescriptor.Color := clWindow;
      edName.ReadOnly := false;
      edName.Color := clWindow;
      lcbDict.ReadOnly := false;
      lcbDict.Color := clWindow;
      edNoMes.ReadOnly := false;
      edNoMes.Color := clWindow;
      cbScenType.Enabled := true;
      dbgWizardStates.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      sbAddState.Enabled := true;
      sbEditState.Enabled := true;
      sbDelState.Enabled := true;
      dbgStatesCross.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      sbAddCross.Enabled := true;
      sbEditCross.Enabled := true;
      sbDelCross.Enabled := true;
      dbgScenSlots.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      sbAddScenSlot.Enabled := true;
      sbEditScenSlot.Enabled := true;
      sbDelScenSlot.Enabled := true;
      dbgScenSlotVal.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      sbAddScenSlotVal.Enabled := true;
      sbEditScenSlotVal.Enabled := true;
      sbDelScenSlotVal.Enabled := true;
      dbgStateSlots.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      sbAddStateSlot.Enabled := true;
      sbEditStateSlot.Enabled := true;
      sbDelStateSlot.Enabled := true;
      dbgStateSlotVal.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      sbAddStateSlotVal.Enabled := true;
      sbEditStateSlotVal.Enabled := true;
      sbDelStateSlotVal.Enabled := true;
    end;
    omEdit:
    begin
      btnSave.Enabled := true;
      tbSave.Enabled := true;
      tbGenSQL.Enabled := true;
      btnRefresh.Enabled := true;
      tbRefresh.Enabled := true;
      Caption := 'Редактирование сценария';
      edDescriptor.ReadOnly := false;
      edDescriptor.Color := clWindow;
      edName.ReadOnly := false;
      edName.Color := clWindow;
      lcbDict.ReadOnly := false;
      lcbDict.Color := clWindow;
      edNoMes.ReadOnly := false;
      edNoMes.Color := clWindow;
      cbScenType.Enabled := true;
      dbgWizardStates.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      sbAddState.Enabled := true;
      sbEditState.Enabled := true;
      sbDelState.Enabled := true;
      dbgStatesCross.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      sbAddCross.Enabled := true;
      sbEditCross.Enabled := true;
      sbDelCross.Enabled := true;
      dbgScenSlots.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      sbAddScenSlot.Enabled := true;
      sbEditScenSlot.Enabled := true;
      sbDelScenSlot.Enabled := true;
      dbgScenSlotVal.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      sbAddScenSlotVal.Enabled := true;
      sbEditScenSlotVal.Enabled := true;
      sbDelScenSlotVal.Enabled := true;
      dbgStateSlots.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      sbAddStateSlot.Enabled := true;
      sbEditStateSlot.Enabled := true;
      sbDelStateSlot.Enabled := true;
      dbgStateSlotVal.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      sbAddStateSlotVal.Enabled := true;
      sbEditStateSlotVal.Enabled := true;
      sbDelStateSlotVal.Enabled := true;
    end;
    omView:
    begin
      btnSave.Enabled := false;
      tbSave.Enabled := false;
      tbGenSQL.Enabled := true;
      btnRefresh.Enabled := true;
      tbRefresh.Enabled := true;
      Caption := 'Свойства сценария';
      edDescriptor.ReadOnly := true;
      edDescriptor.Color := clBtnFace;
      edName.ReadOnly := true;
      edName.Color := clBtnFace;
      lcbDict.ReadOnly := true;
      lcbDict.Color := clBtnFace;
      edNoMes.ReadOnly := true;
      edNoMes.Color := clBtnFace;
      cbScenType.Enabled := false;
      dbgWizardStates.AllowedOperations := [];
      sbAddState.Enabled := false;
      sbEditState.Enabled := false;
      sbDelState.Enabled := false;
      dbgStatesCross.AllowedOperations := [];
      sbAddCross.Enabled := false;
      sbEditCross.Enabled := false;
      sbDelCross.Enabled := false;
      dbgScenSlots.AllowedOperations := [];
      sbAddScenSlot.Enabled := false;
      sbEditScenSlot.Enabled := false;
      sbDelScenSlot.Enabled := false;
      dbgScenSlotVal.AllowedOperations := [];
      sbAddScenSlotVal.Enabled := false;
      sbEditScenSlotVal.Enabled := false;
      sbDelScenSlotVal.Enabled := false;
      dbgStateSlots.AllowedOperations := [];
      sbAddStateSlot.Enabled := false;
      sbEditStateSlot.Enabled := false;
      sbDelStateSlot.Enabled := false;
      dbgStateSlotVal.AllowedOperations := [];
      sbAddStateSlotVal.Enabled := false;
      sbEditStateSlotVal.Enabled := false;
      sbDelStateSlotVal.Enabled := false;
    end;
  end;
end;

end.
