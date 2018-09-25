unit copyRanks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, settings, utils, main, StdCtrls,
  Buttons, DB, FIBDataSet, pFIBDataSet, DBGridEh, Mask, DBCtrlsEh, DBLookupEh, ComCtrls, DBGridEhGrouping, GridsEh,
  Menus, ActnList, MemTableDataEh, MemTableEh;

type
  TFCopyRanks = class(TForm)
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    pcParams: TPageControl;
    tsMain: TTabSheet;
    tsMatching: TTabSheet;
    dsDict: TpFIBDataSet;
    dsoDict: TDataSource;
    Label1: TLabel;
    lcbDict: TDBLookupComboboxEh;
    dsDictPK: TFIBIntegerField;
    dsDictDESCRIPTOR_: TFIBStringField;
    dsDictTITLE: TFIBStringField;
    Label2: TLabel;
    cbTmplCopyMode: TComboBox;
    dsPermRanks: TpFIBDataSet;
    dsPermRanksPK: TFIBIntegerField;
    dsPermRanksROLE_PK: TFIBIntegerField;
    dsPermRanksROLE_NAME: TFIBStringField;
    dsPermRanksADD_: TFIBIntegerField;
    dsPermRanksEDIT_: TFIBIntegerField;
    dsPermRanksDEL_: TFIBIntegerField;
    dsPermRanksVIEW_REF: TFIBIntegerField;
    dsPermRanksCONFIG_: TFIBIntegerField;
    dsPermRanksVIEW_: TFIBIntegerField;
    dsPermRanksEXPORT: TFIBIntegerField;
    dsPermRanksIMPORT: TFIBIntegerField;
    dsoPermRanks: TDataSource;
    dsPermRoles: TpFIBDataSet;
    dsPermRolesPK: TFIBIntegerField;
    dsPermRolesROLE_PK: TFIBIntegerField;
    dsPermRolesROLE_NAME: TFIBStringField;
    dsPermRolesADD_: TFIBIntegerField;
    dsPermRolesEDIT_: TFIBIntegerField;
    dsPermRolesDEL_: TFIBIntegerField;
    dsPermRolesVIEW_REF: TFIBIntegerField;
    dsPermRolesCONFIG_: TFIBIntegerField;
    dsPermRolesVIEW_: TFIBIntegerField;
    dsPermRolesEXPORT: TFIBIntegerField;
    dsPermRolesIMPORT: TFIBIntegerField;
    dsoPermRoles: TDataSource;
    dbgPermissions: TDBGridEh;
    ActionList: TActionList;
    ASave: TAction;
    AGridOptions: TAction;
    pmGrid: TPopupMenu;
    N1: TMenuItem;
    AClose: TAction;
    mUnitFullPath: TMemo;
    Label3: TLabel;
    lbRankTmplName: TLabel;
    mTemplate: TMemo;
    dsRankFullPath: TpFIBDataSet;
    dsRankFullPathNEW_PARAM: TFIBStringField;
    dsTemplate: TpFIBDataSet;
    dsTemplateTEXT_TEMPLATE: TFIBStringField;
    dsDictNAME: TFIBStringField;
    dbgMatch: TDBGridEh;
    dsSourceFields: TpFIBDataSet;
    dsoFields: TDataSource;
    dsDictMAIN_FORM_PK: TFIBIntegerField;
    dsSourceFieldsPK: TFIBIntegerField;
    dsSourceFieldsOBJECT_PK: TFIBIntegerField;
    dsSourceFieldsFIELD_NAME: TFIBStringField;
    dsSourceFieldsOBJECT_NAME: TFIBStringField;
    dsSourceFieldsTITLE: TFIBStringField;
    dsSourceFieldsTYPE_NAME: TFIBStringField;
    dsSourceFieldsFULLNAME: TFIBStringField;
    mtFields: TMemTableEh;
    dsDestFields: TpFIBDataSet;
    dsDestFieldsPK: TFIBIntegerField;
    dsDestFieldsOBJECT_PK: TFIBIntegerField;
    dsDestFieldsFIELD_NAME: TFIBStringField;
    dsDestFieldsOBJECT_NAME: TFIBStringField;
    dsDestFieldsTITLE: TFIBStringField;
    dsDestFieldsTYPE_NAME: TFIBStringField;
    dsDestFieldsFULLNAME: TFIBStringField;
    mtFieldsPK_SRC: TIntegerField;
    mtFieldsPK_DEST: TIntegerField;
    mtFieldsNAME_DEST: TStringField;
    ASelectAll: TAction;
    AUnSelectAll: TAction;
    AInvertSelection: TAction;
    pmGrid2: TPopupMenu;
    MenuItem1: TMenuItem;
    CtrlX1: TMenuItem;
    N2: TMenuItem;
    Label4: TLabel;
    mtFieldsNAME_SRC: TStringField;
    Label5: TLabel;
    cbMatchObject: TComboBox;
    dsSourceObjects: TpFIBDataSet;
    dsDestObjects: TpFIBDataSet;
    mtObjects: TMemTableEh;
    dsoObjects: TDataSource;
    dsSourceObjectsPK: TFIBIntegerField;
    dsSourceObjectsOBJECT_TYPE: TFIBStringField;
    dsDestObjectsPK: TFIBIntegerField;
    dsDestObjectsOBJECT_TYPE: TFIBStringField;
    mtObjectsPK_SRC: TIntegerField;
    mtObjectsNAME_SRC: TStringField;
    mtObjectsPK_DEST: TIntegerField;
    mtObjectsNAME_DEST: TStringField;
    dsSourceObjectsFULLNAME: TFIBStringField;
    dsDestObjectsFULLNAME: TFIBStringField;
    Label6: TLabel;
    cbExistAction: TComboBox;
    Label7: TLabel;
    AExportToExcel: TAction;
    AExportToCsv: TAction;
    Excel1: TMenuItem;
    csv1: TMenuItem;
    dsPermRanksGRID_SAVE: TFIBIntegerField;
    dsPermRolesGRID_SAVE: TFIBIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure cbTmplCopyModeChange(Sender: TObject);
    procedure lcbDictChange(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure AGridOptionsExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ACloseExecute(Sender: TObject);
    procedure dbgPermissionsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dsPermRanksAfterScroll(DataSet: TDataSet);
    procedure dbgPermissionsColEnter(Sender: TObject);
    procedure dbgPermissionsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pcParamsChange(Sender: TObject);
    procedure ASelectAllExecute(Sender: TObject);
    procedure ASelectAllUpdate(Sender: TObject);
    procedure AUnSelectAllExecute(Sender: TObject);
    procedure AInvertSelectionExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbMatchObjectChange(Sender: TObject);
    procedure AExportToExcelExecute(Sender: TObject);
    procedure AExportToCsvExecute(Sender: TObject);
  private
    srcChanged: boolean;
    FIsRank: boolean;
    procedure SetIsRank(Value: boolean);
    procedure SetGridsOptions(Options: TGridParams);
    procedure SaveGridsParams;
    function GetRankFullPath(RankPk: integer): string;
    procedure LoadTemplate(Memo: TMemo; TmplPk: Variant);
    procedure LoadMatchData;
    procedure InvertSelection;
  public
    MainFormPK: Variant;
    function GetTemplateText(TmplPk: Variant): string;
    property IsRank: boolean read FIsRank write SetIsRank;
  end;

implementation

{$R *.dfm}

procedure TFCopyRanks.ACloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFCopyRanks.AExportToCsvExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToCsv(TDBGridEh(ActiveControl), Caption);
end;

procedure TFCopyRanks.AExportToExcelExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToExcel(TDBGridEh(ActiveControl), Caption);
end;

procedure TFCopyRanks.AGridOptionsExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FSettings.GridParamsDialog(TDBGridEh(ActiveControl), ClassName);
end;

procedure TFCopyRanks.AInvertSelectionExecute(Sender: TObject);
begin
  InvertSelection;
end;

procedure TFCopyRanks.ASaveExecute(Sender: TObject);
begin
  ModalResult := mrOk;
  Close;
end;

procedure TFCopyRanks.ASelectAllExecute(Sender: TObject);
begin
  dbgPermissions.SelectedRows.SelectAll;
end;

procedure TFCopyRanks.ASelectAllUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := dbgPermissions.DataSource.DataSet.Active and (not dbgPermissions.DataSource.DataSet.IsEmpty);
end;

procedure TFCopyRanks.AUnSelectAllExecute(Sender: TObject);
begin
  dbgPermissions.SelectedRows.Clear;
end;

procedure TFCopyRanks.cbMatchObjectChange(Sender: TObject);
begin
  srcChanged := true;
  LoadMatchData;
end;

procedure TFCopyRanks.cbTmplCopyModeChange(Sender: TObject);
begin
  tsMatching.TabVisible := cbTmplCopyMode.ItemIndex = 0;
end;

procedure TFCopyRanks.dbgPermissionsColEnter(Sender: TObject);
begin
  if (TDBGridEh(Sender).SelectedField.FieldName = 'ADD_') or (TDBGridEh(Sender).SelectedField.FieldName = 'EDIT_') or
    (TDBGridEh(Sender).SelectedField.FieldName = 'DEL_') or (TDBGridEh(Sender).SelectedField.FieldName = 'VIEW_REF') or
    (TDBGridEh(Sender).SelectedField.FieldName = 'VIEW_') or (TDBGridEh(Sender).SelectedField.FieldName = 'GRID_SAVE') then
  begin
    lbRankTmplName.Caption := 'Шаблон ' + TDBGridEh(Sender).SelectedField.FieldName;
    LoadTemplate(mTemplate, TDBGridEh(Sender).SelectedField.AsVariant);
  end else
  begin
    lbRankTmplName.Caption := 'Шаблон не выбран';
    mTemplate.Clear;
  end;
end;

procedure TFCopyRanks.dbgPermissionsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
    TDBGridEh(Sender).SelectedRows.SelectAll;
  if (ssCtrl in Shift) and ((Key = Ord('X')) or (Key = Ord('x')) or (Key = Ord('Ч')) or (Key = Ord('ч'))) then
    TDBGridEh(Sender).SelectedRows.Clear;
end;

procedure TFCopyRanks.dbgPermissionsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_F12) and (ssShift in Shift) and (ssCtrl in Shift) then TDBGridEh(Sender).OptimizeAllColsWidth;
end;

procedure TFCopyRanks.dsPermRanksAfterScroll(DataSet: TDataSet);
begin
  if (DataSet = dsPermRanks) and (not DataSet.FieldByName('ROLE_PK').IsNull) then
    mUnitFullPath.Text := GetRankFullPath(DataSet.FieldByName('ROLE_PK').AsInteger)
  else mUnitFullPath.Clear;

  if (dbgPermissions.SelectedField.FieldName = 'ADD_') or (dbgPermissions.SelectedField.FieldName = 'EDIT_') or
    (dbgPermissions.SelectedField.FieldName = 'DEL_') or (dbgPermissions.SelectedField.FieldName = 'VIEW_REF') or
    (dbgPermissions.SelectedField.FieldName = 'VIEW_') or (dbgPermissions.SelectedField.FieldName = 'GRID_SAVE') then
  begin
    lbRankTmplName.Caption := 'Шаблон ' + dbgPermissions.SelectedField.FieldName;
    LoadTemplate(mTemplate, dbgPermissions.SelectedField.AsVariant);
  end else
  begin
    lbRankTmplName.Caption := 'Шаблон не выбран';
    mTemplate.Clear;
  end;
end;

procedure TFCopyRanks.FormActivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, true);
end;

procedure TFCopyRanks.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    if dbgMatch.DataSource.DataSet.State in [dsEdit, dsInsert] then dbgMatch.DataSource.DataSet.Post;
  except
  end;
end;

procedure TFCopyRanks.FormCreate(Sender: TObject);
begin
  pcParams.ActivePageIndex := 0;
  mUnitFullPath.Clear;
  cbMatchObject.ItemIndex := 0;
  cbExistAction.ItemIndex := 0;
  dsDict.Open;
  cbTmplCopyMode.ItemIndex := 0;
  cbTmplCopyModeChange(cbTmplCopyMode);
  SetGridsOptions(FSettings.GridOptions);
end;

procedure TFCopyRanks.FormDeactivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, false);
end;

procedure TFCopyRanks.FormDestroy(Sender: TObject);
begin
  SaveGridsParams;
end;

function TFCopyRanks.GetRankFullPath(RankPk: integer): string;
begin
  result := '';

  dsRankFullPath.Close;
  try
    dsRankFullPath.ParamByName('PK').AsInteger := RankPk;
    dsRankFullPath.Open;
  except
  end;

  if not dsRankFullPath.Active then exit;
  result := dsRankFullPathNEW_PARAM.AsString;
  if dsRankFullPath.Active then dsRankFullPath.Close;
end;

function TFCopyRanks.GetTemplateText(TmplPk: Variant): string;
begin
  result := '';
  dsTemplate.Close;
  dsTemplate.ParamByName('PK').Value := TmplPk;
  dsTemplate.Open;
  if dsTemplate.Active and (not dsTemplate.IsEmpty) then result := PyUnicodeToAnsi(dsTemplateTEXT_TEMPLATE.AsString);
  dsTemplate.Close;
  if (result = '') then exit;

  // теперь замены
  case cbMatchObject.ItemIndex of
    0:
    begin
      if not mtObjects.Active then exit;
      mtObjects.First;
      while not mtObjects.Eof do
      begin
        if (not mtObjectsPK_DEST.IsNull) and dsSourceObjects.Locate('PK', mtObjectsPK_SRC.AsInteger, []) and
          dsDestObjects.Locate('PK', mtObjectsPK_DEST.AsInteger, []) then
          result := StringReplace(result, dsSourceObjectsFULLNAME.AsString, dsDestObjectsFULLNAME.AsString, [rfReplaceAll]);
        mtObjects.Next;
      end;
    end;
    1:
    begin
      if not mtFields.Active then exit;
      mtFields.First;
      while not mtFields.Eof do
      begin
        if (not mtFieldsPK_DEST.IsNull) and dsSourceFields.Locate('PK', mtFieldsPK_SRC.AsInteger, []) and
          dsDestFields.Locate('PK', mtFieldsPK_DEST.AsInteger, []) then
          result := StringReplace(result, dsSourceFieldsOBJECT_NAME.AsString + '.' + dsSourceFieldsFIELD_NAME.AsString,
            dsDestFieldsOBJECT_NAME.AsString + '.' + dsDestFieldsFIELD_NAME.AsString, [rfReplaceAll]);
        mtFields.Next;
      end;
    end;
  end;
end;

procedure TFCopyRanks.InvertSelection;
var
  pk: Variant;
  i: integer;
  sl: TStringList;
  ds: TpFIBDataSet;

begin
  ds := TpFIBDataSet(dbgPermissions.DataSource.DataSet);
  if (not ds.Active) or ds.IsEmpty then exit;

  sl := TStringList.Create;
  pk := ds.FieldByName('PK').AsVariant;
  ds.DisableControls;
  try
    for i := 0 to dbgPermissions.SelectedRows.Count - 1 do
      if ds.BookmarkValid(TBookmark(dbgPermissions.SelectedRows.Items[i])) then
      begin
        ds.GotoBookmark(TBookmark(dbgPermissions.SelectedRows.Items[i]));
        sl.Add(ds.FieldByName('PK').AsString);
      end;

    dbgPermissions.SelectedRows.Clear;
    ds.First;
    while not ds.Eof do
    begin
      if sl.IndexOf(ds.FieldByName('PK').AsString) = -1 then
        dbgPermissions.SelectedRows.AppendItem(ds.Bookmark);
      ds.Next;
    end;
  finally
    if not ds.Locate('PK', pk, []) then ds.First;
    ds.EnableControls;
    sl.Free;
  end;
end;

procedure TFCopyRanks.lcbDictChange(Sender: TObject);
begin
  srcChanged := true;
  dsPermRanks.Close;
  dsPermRoles.Close;

  if IsRank then
  begin
    dsPermRanks.ParamByName('REF_PK').Value := lcbDict.KeyValue;
    dsPermRanks.Open;
    dbgPermissions.DataSource := dsoPermRanks;
  end else
  begin
    dsPermRoles.ParamByName('REF_PK').Value := lcbDict.KeyValue;
    dsPermRoles.Open;
    dbgPermissions.DataSource := dsoPermRoles;
  end;
end;

procedure TFCopyRanks.LoadMatchData;
var
  dsDest, dsSrc: TpFIBDataSet;
  mt: TMemTableEh;
   
begin
  if not srcChanged then exit;
  
  srcChanged := false;
  if mtFields.Active then
  begin
    mtFields.EmptyTable;
    mtFields.Close;
  end;
  dsDestFields.Close;
  dsSourceFields.Close;

  if mtObjects.Active then
  begin
    mtObjects.EmptyTable;
    mtObjects.Close;
  end;
  dsDestObjects.Close;
  dsSourceObjects.Close;

  if not tsMatching.TabVisible then exit;

  case cbMatchObject.ItemIndex of
    0:
    begin
      dsDest := dsDestObjects;
      dsSrc := dsSourceObjects;
      mt := mtObjects;
      dbgMatch.DataSource := dsoObjects;
    end;
    1:
    begin
      dsDest := dsDestFields;
      dsSrc := dsSourceFields;
      mt := mtFields;
      dbgMatch.DataSource := dsoFields;
    end;
  end;

  dsDest.ParamByName('FORM_PK').Value := MainFormPK;
  dsDest.Open;

  if dsDict.Locate('PK', lcbDict.KeyValue, []) then
  begin
    dsSrc.ParamByName('FORM_PK').Value := dsDictMAIN_FORM_PK.AsVariant;
    dsSrc.Open;
  end;

  mt.CreateDataSet;
  if dsSrc.Active then
  begin
    dsSrc.First;
    while not dsSrc.Eof do
    begin
      mt.Append;
      mt.FieldByName('PK_SRC').AsVariant := dsSrc.FieldByName('PK').AsVariant;
      mt.FieldByName('NAME_SRC').AsVariant := dsSrc.FieldByName('FULLNAME').AsVariant;
      mt.Post;
      dsSrc.Next;
    end;
    mt.First;
  end;
end;

procedure TFCopyRanks.LoadTemplate(Memo: TMemo; TmplPk: Variant);
begin
  Memo.Clear;
  dsTemplate.Close;
  dsTemplate.ParamByName('PK').Value := TmplPk;
  dsTemplate.Open;
  if dsTemplate.Active and (not dsTemplate.IsEmpty) then Memo.Text := PyUnicodeToAnsi(dsTemplateTEXT_TEMPLATE.AsString);
  dsTemplate.Close;
end;

procedure TFCopyRanks.pcParamsChange(Sender: TObject);
begin
  if pcParams.ActivePage = tsMatching then LoadMatchData;
end;

procedure TFCopyRanks.SaveGridsParams;
var
  i: integer;

begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TDBGridEh then FSettings.SaveGridParams(TDBGridEh(Components[i]), ClassName);
end;

procedure TFCopyRanks.SetGridsOptions(Options: TGridParams);
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

procedure TFCopyRanks.SetIsRank(Value: boolean);
begin
  FIsRank := Value;
  lcbDictChange(lcbDict);
end;

end.
