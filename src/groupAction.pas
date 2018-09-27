unit groupAction;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls,
  ActnList, Menus, settings, utils, main, DB, FIBDataSet, pFIBDataSet, DBGridEh, Mask, DBCtrlsEh, DBLookupEh,
  DBGridEhGrouping, GridsEh, MemTableDataEh, MemTableEh, dbUtils, selectRank, ImgList, FIBQuery, pFIBQuery, EhLibMTE;

type
  TFGroupAction = class(TForm)
    btnExec: TBitBtn;
    btnClose: TBitBtn;
    pcMain: TPageControl;
    tsAction: TTabSheet;
    cbAction: TComboBox;
    lbDescr: TLabel;
    Label3: TLabel;
    tsPermissions: TTabSheet;
    Label2: TLabel;
    ActionList: TActionList;
    AGridOptions: TAction;
    AClose: TAction;
    ASelectAll: TAction;
    AUnSelectAll: TAction;
    AInvertSelection: TAction;
    pmGrid: TPopupMenu;
    N1: TMenuItem;
    pmGrid2: TPopupMenu;
    MenuItem1: TMenuItem;
    CtrlX1: TMenuItem;
    N2: TMenuItem;
    dsDict: TpFIBDataSet;
    dsDictPK: TFIBIntegerField;
    dsDictDESCRIPTOR_: TFIBStringField;
    dsDictTITLE: TFIBStringField;
    dsDictNAME: TFIBStringField;
    dsDictMAIN_FORM_PK: TFIBIntegerField;
    dsoDict: TDataSource;
    dbgPermissions: TDBGridEh;
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
    dsRankFullPath: TpFIBDataSet;
    dsRankFullPathNEW_PARAM: TFIBStringField;
    dsTemplate: TpFIBDataSet;
    dsTemplateTEXT_TEMPLATE: TFIBStringField;
    sbAddPerm: TSpeedButton;
    sbDelPerm: TSpeedButton;
    Label7: TLabel;
    Label8: TLabel;
    mUnitFullPath: TMemo;
    lbRankTmplName: TLabel;
    mTemplate: TMemo;
    Label9: TLabel;
    Label4: TLabel;
    lcbDict: TDBLookupComboboxEh;
    Label5: TLabel;
    cbTmplCopyMode: TComboBox;
    Label6: TLabel;
    cbExistAction: TComboBox;
    chbReplaceMainObject: TCheckBox;
    dsRoles: TpFIBDataSet;
    mtPermRanks: TMemTableEh;
    mtPermRanksPK: TIntegerField;
    mtPermRanksROLE_PK: TIntegerField;
    mtPermRanksROLE_NAME: TStringField;
    mtPermRanksADD_: TIntegerField;
    mtPermRanksEDIT_: TIntegerField;
    mtPermRanksDEL_: TIntegerField;
    mtPermRanksVIEW_REF: TIntegerField;
    mtPermRanksCONFIG_: TIntegerField;
    mtPermRanksVIEW_: TIntegerField;
    mtPermRanksEXPORT: TIntegerField;
    mtPermRanksIMPORT: TIntegerField;
    mtPermRoles: TMemTableEh;
    mtPermRolesPK: TIntegerField;
    mtPermRolesROLE_PK: TIntegerField;
    mtPermRolesROLE_NAME: TStringField;
    mtPermRolesADD_: TIntegerField;
    mtPermRolesEDIT_: TIntegerField;
    mtPermRolesDEL_: TIntegerField;
    mtPermRolesVIEW_REF: TIntegerField;
    mtPermRolesCONFIG_: TIntegerField;
    mtPermRolesVIEW_: TIntegerField;
    mtPermRolesEXPORT: TIntegerField;
    mtPermRolesIMPORT: TIntegerField;
    sbClear: TSpeedButton;
    tsRefUsers: TTabSheet;
    dsDevelUsers: TpFIBDataSet;
    dsoDevelUsers: TDataSource;
    dsDevelUsersPK: TFIBIntegerField;
    dsDevelUsersLOGIN: TFIBStringField;
    dsDevelUsersNAME: TFIBStringField;
    dbgRefUsers: TDBGridEh;
    Label1: TLabel;
    sbAddRefUser: TSpeedButton;
    sbDelRefUser: TSpeedButton;
    sbClearRefList: TSpeedButton;
    mtRefUsers: TMemTableEh;
    dsoRefUsers: TDataSource;
    dsUsers: TpFIBDataSet;
    mtRefUsersPK: TIntegerField;
    dsUsersPK: TFIBIntegerField;
    dsUsersLOGIN: TFIBStringField;
    dsUsersNAME: TFIBStringField;
    dsUsersISACTIVE: TFIBStringField;
    dsUsersROLE_PK: TFIBIntegerField;
    dsUsersROLE_NAME: TFIBStringField;
    dsUsersDEVELOPER: TFIBStringField;
    dsUsersMODERATOR: TFIBStringField;
    dsUsersCODE_1C: TFIBStringField;
    dsUsersEMAIL: TFIBStringField;
    dsUsersSHORT_NAME: TFIBStringField;
    dsUsersLASTDATE: TFIBDateTimeField;
    dsUsersHOLIDAY: TFIBStringField;
    mtRefUsersLOGIN: TStringField;
    mtRefUsersNAME: TStringField;
    mtRefUsersACTION: TIntegerField;
    mtRefUsersROLE_PK: TIntegerField;
    mtRefUsersROLE_NAME: TStringField;
    mtRefUsersDEVELOPER: TStringField;
    mtRefUsersMODERATOR: TStringField;
    Label10: TLabel;
    tsChangeOwner: TTabSheet;
    tsChangeFolder: TTabSheet;
    lcbDevelUsers: TDBLookupComboboxEh;
    Label11: TLabel;
    dsFolders: TpFIBDataSet;
    dsFoldersPK: TFIBIntegerField;
    dsFoldersNAME: TFIBStringField;
    dsoFolders: TDataSource;
    Label12: TLabel;
    lcbFolder: TDBLookupComboboxEh;
    tsProgress: TTabSheet;
    Label13: TLabel;
    lbAction: TLabel;
    Label14: TLabel;
    lbObject: TLabel;
    lbProgress: TLabel;
    ProgressBar: TProgressBar;
    dbgLog: TDBGridEh;
    Label15: TLabel;
    mtLog: TMemTableEh;
    dsoLog: TDataSource;
    mtLogOBJECT_NAME: TStringField;
    mtLogSTATUS: TIntegerField;
    mtLogMESSAGE: TStringField;
    mtLogSTATUS_NAME: TIntegerField;
    ilLogStatus: TImageList;
    mtObjectList: TMemTableEh;
    mtObjectListPK: TIntegerField;
    mtObjectListTYPE: TIntegerField;
    mtObjectListDESCRIPTOR: TStringField;
    mtObjectListNAME: TStringField;
    mtObjectListFULLNAME: TStringField;
    mtLogACTION: TStringField;
    qEditPermRole: TpFIBQuery;
    qEditPermRank: TpFIBQuery;
    mtPermRanksREF_PK: TIntegerField;
    mtPermRolesREF_PK: TIntegerField;
    mtPermRanksREF_NAME: TStringField;
    mtPermRolesREF_NAME: TStringField;
    sbCopyPerms: TSpeedButton;
    mtObjectListLOGIN: TStringField;
    chbHideSuccess: TCheckBox;
    mtPermRanksACTION: TIntegerField;
    mtPermRolesACTION: TIntegerField;
    dsFoldersPARENT_PK: TFIBIntegerField;
    dsFoldersPARENT_NAME: TFIBStringField;
    chbMoveOnlyContent: TCheckBox;
    tsCopyRoles: TTabSheet;
    dsUnitStruct: TpFIBDataSet;
    dsUnitStructPK: TFIBIntegerField;
    dsUnitStructNAME: TFIBStringField;
    dsUnitStructDEPARTMENT: TFIBStringField;
    dsUnitStructOFFICE: TFIBStringField;
    dsUnitStructCHAPTER: TFIBStringField;
    dsUnitStructSECTOR: TFIBStringField;
    dsoUnitStruct: TDataSource;
    Label16: TLabel;
    lcbRank: TDBLookupComboboxEh;
    Label18: TLabel;
    mtSelectedRanks: TMemTableEh;
    mtSelectedRanksPK: TIntegerField;
    mtSelectedRanksNAME: TStringField;
    dsoSelectedRanks: TDataSource;
    dbgSelectedRanks: TDBGridEh;
    Label19: TLabel;
    sbAddRole: TSpeedButton;
    sbDelRole: TSpeedButton;
    sbClearRoles: TSpeedButton;
    Label20: TLabel;
    dsDictRoles: TpFIBDataSet;
    dsDictRolesPK: TFIBIntegerField;
    dsDictRolesADD_: TFIBIntegerField;
    dsDictRolesEDIT_: TFIBIntegerField;
    dsDictRolesDEL_: TFIBIntegerField;
    dsDictRolesVIEW_REF: TFIBIntegerField;
    dsDictRolesCONFIG_: TFIBIntegerField;
    dsDictRolesVIEW_: TFIBIntegerField;
    dsDictRolesEXPORT: TFIBIntegerField;
    dsDictRolesIMPORT: TFIBIntegerField;
    dsDictRolesFILTRING: TFIBIntegerField;
    dsRolesPK: TFIBIntegerField;
    dsRolesNAME: TFIBStringField;
    AExportToExcel: TAction;
    AExportToCsv: TAction;
    Excel1: TMenuItem;
    csv1: TMenuItem;
    dsPermRanksGRID_SAVE: TFIBIntegerField;
    mtPermRanksGRID_SAVE: TIntegerField;
    dsPermRolesGRID_SAVE: TFIBIntegerField;
    mtPermRolesGRID_SAVE: TIntegerField;
    dsDictRolesGRID_SAVE: TFIBIntegerField;
    procedure cbActionChange(Sender: TObject);
    procedure AGridOptionsExecute(Sender: TObject);
    procedure ACloseExecute(Sender: TObject);
    procedure ASelectAllExecute(Sender: TObject);
    procedure ASelectAllUpdate(Sender: TObject);
    procedure AUnSelectAllExecute(Sender: TObject);
    procedure AInvertSelectionExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgPermissionsColEnter(Sender: TObject);
    procedure dbgPermissionsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgPermissionsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mtPermRanksAfterScroll(DataSet: TDataSet);
    procedure sbAddPermClick(Sender: TObject);
    procedure mtPermRanksAfterInsert(DataSet: TDataSet);
    procedure mtPermRolesAfterInsert(DataSet: TDataSet);
    procedure sbDelPermClick(Sender: TObject);
    procedure sbClearClick(Sender: TObject);
    procedure sbAddRefUserClick(Sender: TObject);
    procedure sbDelRefUserClick(Sender: TObject);
    procedure sbClearRefListClick(Sender: TObject);
    procedure mtRefUsersAfterInsert(DataSet: TDataSet);
    procedure btnExecClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbCopyPermsClick(Sender: TObject);
    procedure lcbDictChange(Sender: TObject);
    procedure dbgLogColumns4EditButtons0Click(Sender: TObject; var Handled: Boolean);
    procedure chbHideSuccessClick(Sender: TObject);
    procedure sbAddRoleClick(Sender: TObject);
    procedure sbDelRoleClick(Sender: TObject);
    procedure sbClearRolesClick(Sender: TObject);
    procedure AExportToExcelExecute(Sender: TObject);
    procedure AExportToCsvExecute(Sender: TObject);
  private
    FRunning: boolean;
    CanStop: boolean;
    FFolderPk: Variant;
    procedure SetGridsOptions(Options: TGridParams);
    procedure SaveGridsParams;
    function GetRankFullPath(RankPk: integer): string;
    procedure LoadTemplate(Memo: TMemo; TmplPk: Variant);
    procedure InvertSelection;
    function GetTemplateText(TmplPk: Variant; NameToReplace, NameThanReplace: string): string;
    procedure LoadPermissions(Source: TpFIBDataSet; Dest: TMemTableEh);
    procedure SetProgress(Actn: integer; ObjName: string; Position: integer);
    procedure AddToLog(Status: integer; Actn, ObjName, Msg: string);
    procedure SetExecutionState(running: boolean);
    function LoadObjectList(type_: integer; var Err: string): boolean;
    function SaveTemplate(TmplText: string; TmplPk: Variant; Insert, ConvertToUni: boolean; var err: string): Variant;
    procedure SavePermissions(RefPk: Variant; RefName: string);
    // само выполнение изменений
    procedure ExecUpdatePerm(Actn: integer);
    procedure ExecUpdateRefUsers;
    procedure ExecChangeOwner;
    procedure ExecMoveToFolder;
    procedure ExecCopyRoleGrants;
    function CheckGrant(Act: TGrantAction; RefPk, RefUser, RefDescriptor, RefTitle: Variant; var Err: string): boolean;
    procedure SetFolderPk(Value: Variant);
  public
    CanRefresh: boolean;
    procedure Execute;
    property FolderPk: Variant read FFolderPk write SetFolderPk;
  end;

implementation

const
  ACTION_DESCR0 = 'Создание, копирование из справочника или удаление прав должностей всем справочникам папки';
  ACTION_DESCR1 = 'Создание, копирование из справочника или удаление прав ролей всем справочникам папки';
  ACTION_DESCR2 = 'Выдача или удаление прав на конфигурацию всех справочников папки выбранным пользователям';
  ACTION_DESCR3 = 'Замена владельца всех справочников (и их форм) папки на выбранного пользователя';
  ACTION_DESCR4 = 'Перемещение всех справочников и папок в выбранную папку. Структура папок при переносе сохраняется';
  ACTION_DESCR5 = 'Копирование прав должности всем указанным в списке должностям всем справочникам папки.';

{$R *.dfm}

procedure TFGroupAction.ACloseExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then Close;
end;

procedure TFGroupAction.AddToLog(Status: integer; Actn, ObjName, Msg: string);
begin
  mtLog.Append;
  mtLogACTION.AsString := Actn;
  mtLogOBJECT_NAME.AsString := ObjName;
  mtLogSTATUS.AsInteger := Status;
  mtLogSTATUS_NAME.AsInteger := Status;
  mtLogMESSAGE.AsString := Msg;
  mtLog.Post;
end;

procedure TFGroupAction.AExportToCsvExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToCsv(TDBGridEh(ActiveControl), Caption);
end;

procedure TFGroupAction.AExportToExcelExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToExcel(TDBGridEh(ActiveControl), Caption);
end;

procedure TFGroupAction.AGridOptionsExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FSettings.GridParamsDialog(TDBGridEh(ActiveControl), ClassName);
end;

procedure TFGroupAction.AInvertSelectionExecute(Sender: TObject);
begin
  InvertSelection;
end;

procedure TFGroupAction.ASelectAllExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    TDBGridEh(ActiveControl).SelectedRows.SelectAll;
end;

procedure TFGroupAction.ASelectAllUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := dbgPermissions.DataSource.DataSet.Active and (not dbgPermissions.DataSource.DataSet.IsEmpty);
end;

procedure TFGroupAction.AUnSelectAllExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    TDBGridEh(ActiveControl).SelectedRows.Clear;
end;

procedure TFGroupAction.btnCloseClick(Sender: TObject);
begin
  if FRunning then
  begin
    if Application.MessageBox('Прервать выполнение?', 'Подтверждение', MB_YESNO + MB_ICONQUESTION) = ID_YES then
    begin
      AddToLog(1, 'Текущая задача', '', 'Выполнение прервано пользователем');
      CanStop := true;
    end;
  end else
    Close;
end;

procedure TFGroupAction.btnExecClick(Sender: TObject);
begin
  Execute;
end;

procedure TFGroupAction.cbActionChange(Sender: TObject);
var
  col: TColumnEh;

begin
  tsPermissions.TabVisible := false;
  tsRefUsers.TabVisible := false;
  tsChangeOwner.TabVisible := false;
  tsChangeFolder.TabVisible := false;
  tsCopyRoles.TabVisible := false;

  case cbAction.ItemIndex of
    0:   // добавление прав должностей
    begin
      lbDescr.Caption := ACTION_DESCR0;
      tsPermissions.Caption := 'Параметры (права должностей)';
      tsPermissions.TabVisible := true;
      col := FindColumnByFieldName(dbgPermissions, 'ROLE_NAME');
      if Assigned(col) then col.TextEditing := false;
      dbgPermissions.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      dbgPermissions.DataSource := dsoPermRanks;
      lcbDictChange(lcbDict);
      btnExec.Enabled := true;
    end;
    1:   // добавление прав ролей
    begin
      lbDescr.Caption := ACTION_DESCR1;
      tsPermissions.Caption := 'Параметры (права ролей)';
      tsPermissions.TabVisible := true;
      col := FindColumnByFieldName(dbgPermissions, 'ROLE_NAME');
      if Assigned(col) then col.TextEditing := true;
      dbgPermissions.AllowedOperations := [alopInsertEh, alopAppendEh, alopUpdateEh, alopDeleteEh];
      dbgPermissions.DataSource := dsoPermRoles;
      lcbDictChange(lcbDict);
      dbgPermissionsColEnter(dbgPermissions);
      btnExec.Enabled := true;
    end;
    2:  // права на конфигурацию
    begin
      lbDescr.Caption := ACTION_DESCR2;
      tsRefUsers.Caption := 'Параметры (права на конфигурацию)';
      tsRefUsers.TabVisible := true;
      btnExec.Enabled := true;
    end;
    3:  // смена владельца
    begin
      lbDescr.Caption := ACTION_DESCR3;
      tsChangeOwner.Caption := 'Параметры (смена владельца)';
      tsChangeOwner.TabVisible := true;
      btnExec.Enabled := true;
    end;
    4:  // перепривязка к другой папке
    begin
      lbDescr.Caption := ACTION_DESCR4;
      tsChangeFolder.Caption := 'Параметры (привязка к папке)';
      tsChangeFolder.TabVisible := true;
      btnExec.Enabled := true;
    end;
    5: // копирование прав должности выбранным должностям всем справочникам в папке
    begin
      lbDescr.Caption := ACTION_DESCR5;
      tsCopyRoles.Caption := 'Параметры (копирование прав должности)';
      tsCopyRoles.TabVisible := true;
      btnExec.Enabled := true;
    end
    else begin
      lbDescr.Caption := '';
      btnExec.Enabled := false;
    end;
  end;
end;

procedure TFGroupAction.chbHideSuccessClick(Sender: TObject);
begin
  if chbHideSuccess.Checked then
  begin
    mtLog.Filter := 'STATUS <> ''0''';
    mtLog.Filtered := true;
  end else
  begin
    mtLog.Filter := '';
    mtLog.Filtered := false;
  end;
end;

function TFGroupAction.CheckGrant(Act: TGrantAction; RefPk, RefUser, RefDescriptor, RefTitle: Variant; var Err: string): boolean;
var
  d: TNodeDictInfo;

begin
  d := AssignNodeData(cotDict);
  try
    d.PK := RefPk;
    d.Descriptor := RefDescriptor;
    d.Title := RefTitle;
    d.Login := RefUser;
    result := FMain.CheckGrants(Act, d, Err);
  finally
    d.Free;
  end;
end;

procedure TFGroupAction.dbgLogColumns4EditButtons0Click(Sender: TObject; var Handled: Boolean);
var
  Flags: integer;
  Cap: string;

begin
  if mtLog.Active and (not mtLog.IsEmpty) and (not mtLogMESSAGE.IsNull) and (Trim(mtLogMESSAGE.AsString) <> '') then
  begin
    if mtLogSTATUS.AsInteger = 2 then
    begin
      Flags := MB_OK + MB_ICONERROR;
      Cap := 'Ошибка';
    end else
    begin
      Flags := MB_OK + MB_ICONEXCLAMATION;
      Cap := 'Сообщение';
    end;
    Application.MessageBox(pchar(mtLogMESSAGE.AsString), pchar(Cap), Flags);
  end;
end;

procedure TFGroupAction.dbgPermissionsColEnter(Sender: TObject);
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

procedure TFGroupAction.dbgPermissionsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then
    begin
      if (Sender = dbgPermissions) then sbAddPermClick(sbAddPerm)
      else if (Sender = dbgRefUsers) then sbAddRefUserClick(sbAddRefUser)
      else if (Sender = dbgSelectedRanks) then sbAddRoleClick(sbAddRole);
    end else
    begin
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
      if (ssCtrl in Shift) and ((Key = Ord('X')) or (Key = Ord('x')) or (Key = Ord('Ч')) or (Key = Ord('ч'))) then
        TDBGridEh(Sender).SelectedRows.Clear;
    end;
  end;
end;

procedure TFGroupAction.dbgPermissionsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_F12) and (ssShift in Shift) and (ssCtrl in Shift) then TDBGridEh(Sender).OptimizeAllColsWidth;
end;

procedure TFGroupAction.ExecChangeOwner;
var
  err: string;
  r: boolean;
  
begin
  SetProgress(3, 'Получение списка объектов папки', 0);
  if not LoadObjectList(0, err) then
  begin
    AddToLog(2, 'Получение списка объектов папки', '', err);
    exit;
  end;

  if VarIsNull(lcbDevelUsers.KeyValue) then
  begin
    AddToLog(2, 'Смена владельца', '', 'Не выбран новый владелец');
    exit;
  end;

  ProgressBar.Max := mtObjectList.RecordCount;

  mtObjectList.First;
  while not mtObjectList.Eof do
  begin
    if CanStop then exit;
    SetProgress(3, mtObjectListFULLNAME.AsString, mtObjectList.RecNo);

    if not CheckGrant(gaRights, mtObjectListPK.AsVariant, mtObjectListLOGIN.AsVariant, mtObjectListDESCRIPTOR.AsVariant,
      mtObjectListNAME.AsVariant, err) then
    begin
      AddToLog(2, 'Смена владельца', mtObjectListFULLNAME.AsString, 'Недостаточно прав! ' + err);
      mtObjectList.Next;
      continue;
    end;

    r := FMain.ExecSQL('update DYNAMIC_FORM_REFERENCE set OWNER_USER_PK = ' + VarToStr(lcbDevelUsers.KeyValue) +
      ' where PK = ' + mtObjectListPK.AsString, err);
    if r then r := FMain.ExecSQL('update DYNAMIC_FORM set OWNER_USER_PK = ' + VarToStr(lcbDevelUsers.KeyValue) +
      ' where PK = (select MAIN_FORM_PK from DYNAMIC_FORM_REFERENCE where PK = ' + mtObjectListPK.AsString + ')', err);
    if r then r := FMain.ExecSQL('update DYNAMIC_FORM set OWNER_USER_PK = ' + VarToStr(lcbDevelUsers.KeyValue) +
      ' where PK = (select START_FORM_PK from DYNAMIC_FORM_REFERENCE where PK = ' + mtObjectListPK.AsString +
      ' and START_FORM_PK <> -1)', err);
    if r then r := FMain.ExecSQL('update DYNAMIC_FORM set OWNER_USER_PK = ' + VarToStr(lcbDevelUsers.KeyValue) +
      ' where PK = (select GROUP_EDIT_FORM_PK from DYNAMIC_FORM_REFERENCE where PK = ' + mtObjectListPK.AsString +
      ' and GROUP_EDIT_FORM_PK <> -1)', err);
    // объекту не меняем, чтоб виднобыло изначального владельца
    {if r then r := FMain.ExecSQL('update DYNAMIC_FORM_OBJECT_TREE set OWNER_USER_PK = ' + VarToStr(lcbDevelUsers.KeyValue) +
      ' where FORM_PK = (select MAIN_FORM_PK from DYNAMIC_FORM_REFERENCE where PK = ' + mtObjectListPK.AsString + ')', err);}

    if r then
    begin
      AddToLog(0, 'Смена владельца', mtObjectListFULLNAME.AsString, '');
      FMain.AddToRefLog(cotDict, mtObjectListDESCRIPTOR.AsString, rltUpdate, 'Смена владельца. Старый владелец ' + mtObjectListLOGIN.AsString);
    end else
      AddToLog(2, 'Смена владельца', mtObjectListFULLNAME.AsString, err);

    mtObjectList.Next;
  end;

  SetProgress(3, 'Выполнено!', mtObjectList.RecNo);
  CanRefresh := true;
end;

procedure TFGroupAction.ExecCopyRoleGrants;
var
  err, sql: string;
  ds: TpFIBDataSet;
  
begin
  SetProgress(5, 'Получение списка объектов папки', 0);
  if not LoadObjectList(0, err) then
  begin
    AddToLog(2, 'Получение списка объектов папки', '', err);
    exit;
  end;

  ProgressBar.Max := mtObjectList.RecordCount;

  mtObjectList.First;
  while not mtObjectList.Eof do
  begin
    if CanStop then exit;
    SetProgress(5, mtObjectListFULLNAME.AsString, mtObjectList.RecNo);

    if not CheckGrant(gaEdit, mtObjectListPK.AsVariant, mtObjectListLOGIN.AsVariant, mtObjectListDESCRIPTOR.AsVariant,
      mtObjectListNAME.AsVariant, err) then
    begin
      AddToLog(2, 'Копирование прав должности', mtObjectListFULLNAME.AsString, 'Недостаточно прав! ' + err);
      mtObjectList.Next;
      continue;
    end;

    dsDictRoles.Close;
    dsDictRoles.ParamByName('REF_PK').Value := mtObjectListPK.AsVariant;
    dsDictRoles.ParamByName('ROLE_PK').Value := lcbRank.KeyValue;
    dsDictRoles.Open;
    dsDictRoles.First;

    if dsDictRoles.IsEmpty then
      AddToLog(1, 'Копирование прав должности', mtObjectListFULLNAME.AsString, 'В справочнике нет прав для исходной должности');

    while not dsDictRoles.Eof do
    begin
      mtSelectedRanks.First;
      while not mtSelectedRanks.Eof do
      begin
        if CanStop then exit;
        if mtSelectedRanksPK.IsNull then
        begin
          mtSelectedRanks.Next;
          continue;
        end;

        try
          ds := FMain.OpenSQL('select PK from DYNAMIC_FORM_PERM_RANKS where ROLE_PK = ' + mtSelectedRanksPK.AsString + 'and REFERENCE_PK = ' +
            mtObjectListPK.AsString);
        except
          on e: Exception do
          begin
            AddToLog(2, 'Копирование прав должности', mtObjectListFULLNAME.AsString, e.Message);
            mtSelectedRanks.Next;
            continue;
          end;
        end;

        if ds.Active and ds.IsEmpty then
        begin
          sql := 'insert into DYNAMIC_FORM_PERM_RANKS (REFERENCE_PK, ROLE_PK, ADD_, EDIT_, DEL_, VIEW_REF, CONFIG_, VIEW_, EXPORT, ' +
            'IMPORT, FILTRING, GRID_SAVE) values (' + mtObjectListPK.AsString + ', ' + mtSelectedRanksPK.AsString + ', ' + dsDictRolesADD_.AsString +
            ', ' + dsDictRolesEDIT_.AsString + ', ' + dsDictRolesDEL_.AsString + ', ' + dsDictRolesVIEW_REF.AsString + ', ' +
            dsDictRolesCONFIG_.AsString + ', ' + dsDictRolesVIEW_.AsString + ', ' + dsDictRolesEXPORT.AsString + ', ' +
            dsDictRolesIMPORT.AsString + ', ' + dsDictRolesFILTRING.AsString + ', ' + dsDictRolesGRID_SAVE.AsString + ')';

          if FMain.ExecSQL(sql, err) then
          begin
            AddToLog(0, 'Копирование прав должности', mtObjectListFULLNAME.AsString, '');
            FMain.AddToRefLog(cotDict, mtObjectListDESCRIPTOR.AsString, rltUpdate);
          end else
            AddToLog(2, 'Копирование прав должности', mtObjectListFULLNAME.AsString, err);
        end else
          AddToLog(1, 'Копирование прав должности', mtObjectListFULLNAME.AsString, 'В справочнике уже есть права для должности ' +
            mtSelectedRanksNAME.AsString);

        mtSelectedRanks.Next;
      end;
      dsDictRoles.Next;
    end;
    mtObjectList.Next;
  end;

  SetProgress(5, 'Выполнено!', mtObjectList.RecNo);
  CanRefresh := false;
end;

procedure TFGroupAction.ExecMoveToFolder;
var
  err: string;
  r: boolean;
  fpk: Variant;
  l: integer;
    
begin
  SetProgress(4, 'Получение списка объектов папки', 0);

  if chbMoveOnlyContent.Checked then l := 1
  else l := 2;

  if not LoadObjectList(l, err) then
  begin
    AddToLog(2, 'Получение списка объектов папки', '', err);
    exit;
  end;

  fpk := lcbFolder.KeyValue;
  if VarIsNull(fpk) then
  begin
    if Trim(lcbFolder.Text) <> '' then
    begin
      r := FMain.ExecSQL('insert into DYNAMIC_FORM_FOLDER (NAME) values (''' + Trim(lcbFolder.Text) + ''') returning (PK)',
        'PK', fpk, err);

      if (not r) then
      begin
        AddToLog(2, 'Перемещение в папку', Trim(lcbFolder.Text), 'Не удалось создать новую папку! ' + err);
        exit;
      end else
        FMain.AddToRefLog(cotFolder, lcbFolder.Text, rltCreate);
    end;
  end;

  ProgressBar.Max := mtObjectList.RecordCount;

  mtObjectList.First;
  while not mtObjectList.Eof do
  begin
    if CanStop then exit;
    SetProgress(4, mtObjectListFULLNAME.AsString, mtObjectList.RecNo);

    if not CheckGrant(gaEdit, mtObjectListPK.AsVariant, mtObjectListLOGIN.AsVariant, mtObjectListDESCRIPTOR.AsVariant,
      mtObjectListNAME.AsVariant, err) then
    begin
      AddToLog(2, 'Перемещение в папку', mtObjectListFULLNAME.AsString, 'Недостаточно прав! ' + err);
      mtObjectList.Next;
      continue;
    end;

    if mtObjectListTYPE.AsInteger = 0 then
      r := FMain.ExecSQL('update DYNAMIC_FORM_REFERENCE set FOLDER_PK = ' + iif(VarIsNull(fpk), 'null', VarToStr(fpk)) +
        ' where PK = ' + mtObjectListPK.AsString, err)
    else
      r := FMain.ExecSQL('update DYNAMIC_FORM_FOLDER set PARENT_FOLDER_PK = ' + iif(VarIsNull(fpk), 'null', VarToStr(fpk)) +
        ' where PK = ' + mtObjectListPK.AsString, err);

    if r then
    begin
      AddToLog(0, 'Перемещение в папку', mtObjectListFULLNAME.AsString, '');
      if mtObjectListTYPE.AsInteger = 0 then FMain.AddToRefLog(cotDict, mtObjectListDESCRIPTOR.AsString, rltUpdate)
      else FMain.AddToRefLog(cotFolder, mtObjectListNAME.AsString, rltUpdate, 'PK ' + mtObjectListPK.AsString);
    end else
      AddToLog(2, 'Перемещение в папку', mtObjectListFULLNAME.AsString, err);

    mtObjectList.Next;
  end;

  SetProgress(4, 'Выполнено!', mtObjectList.RecNo);
  CanRefresh := true;
end;

procedure TFGroupAction.ExecUpdatePerm(Actn: integer);
var
  err: string;
  
begin
  SetProgress(Actn, 'Получение списка объектов папки', 0);
  if not LoadObjectList(0, err) then
  begin
    AddToLog(2, 'Получение списка объектов папки', '', err);
    exit;
  end;

  ProgressBar.Max := mtObjectList.RecordCount;

  mtObjectList.First;
  while not mtObjectList.Eof do
  begin
    if CanStop then exit;
    SetProgress(Actn, mtObjectListFULLNAME.AsString, mtObjectList.RecNo);
    if CheckGrant(gaEdit, mtObjectListPK.AsVariant, mtObjectListLOGIN.AsVariant, mtObjectListDESCRIPTOR.AsVariant,
      mtObjectListNAME.AsVariant, err) then
    begin
      SavePermissions(mtObjectListPK.AsVariant, mtObjectListFULLNAME.AsString);
      FMain.AddToRefLog(cotDict, mtObjectListDESCRIPTOR.AsString, rltUpdate);
    end else
      AddToLog(2, 'Привязка/удаление прав', mtObjectListFULLNAME.AsString, 'Недостаточно прав! ' + err);
      
    mtObjectList.Next;
  end;

  SetProgress(Actn, 'Выполнено!', mtObjectList.RecNo);
end;

procedure TFGroupAction.ExecUpdateRefUsers;
var
  err, sql, s: string;
  
begin
  SetProgress(2, 'Получение списка объектов папки', 0);
  if not LoadObjectList(0, err) then
  begin
    AddToLog(2, 'Получение списка объектов папки', '', err);
    exit;
  end;

  ProgressBar.Max := mtObjectList.RecordCount;

  mtObjectList.First;
  while not mtObjectList.Eof do
  begin
    if CanStop then exit;
    SetProgress(2, mtObjectListFULLNAME.AsString, mtObjectList.RecNo);

    if not CheckGrant(gaRights, mtObjectListPK.AsVariant, mtObjectListLOGIN.AsVariant, mtObjectListDESCRIPTOR.AsVariant,
      mtObjectListNAME.AsVariant, err) then
    begin
      AddToLog(2, 'Выдача/удаление прав на конфигурацию', mtObjectListFULLNAME.AsString, 'Недостаточно прав! ' + err);
      mtObjectList.Next;
      continue;
    end;

    mtRefUsers.First;
    while not mtRefUsers.Eof do
    begin
      if CanStop then exit;
      if mtRefUsersPK.IsNull then
      begin
        mtRefUsers.Next;
        continue;
      end;

      if mtRefUsersACTION.AsInteger = 0 then
      begin
        s := 'Выдача прав на конфигурацию';
        sql := 'update or insert into DYNAMIC_FORM_REF_USER (REF_PK, USER_PK) values (' + mtObjectListPK.AsString + ', ' +
          mtRefUsersPK.AsString + ') matching (REF_PK, USER_PK)';
      end else
      begin
        s := 'Удаление прав на конфигурацию';
        sql := 'delete from DYNAMIC_FORM_REF_USER where REF_PK = ' + mtObjectListPK.AsString + ' and USER_PK = ' +
          mtRefUsersPK.AsString;
      end;

      if FMain.ExecSQL(sql, err) then
      begin
        AddToLog(0, s, mtObjectListFULLNAME.AsString, '');
        FMain.AddToRefLog(cotDict, mtObjectListDESCRIPTOR.AsString, rltUpdate, s + '. Пользователь ' + mtRefUsersLOGIN.AsString);
      end else
        AddToLog(2, s, mtObjectListFULLNAME.AsString, err);

      mtRefUsers.Next;
    end;
    mtObjectList.Next;
  end;

  SetProgress(2, 'Выполнено!', mtObjectList.RecNo);
  CanRefresh := FMain.chbGetOnlyUser.Checked;
end;

procedure TFGroupAction.Execute;
begin
  if FRunning then exit;

  try
    SetExecutionState(true);

    case cbAction.ItemIndex of
      0: ExecUpdatePerm(0);
      1: ExecUpdatePerm(1);
      2: ExecUpdateRefUsers;
      3: ExecChangeOwner;
      4: ExecMoveToFolder;
      5: ExecCopyRoleGrants;
    end;
  finally
    SetExecutionState(false);
  end;
end;

procedure TFGroupAction.FormActivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, true);
end;

procedure TFGroupAction.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FRunning then
  begin
    Action := caNone;
    btnCloseClick(btnClose);
  end;
end;

procedure TFGroupAction.FormCreate(Sender: TObject);
begin
  CanRefresh := false;
  pcMain.ActivePageIndex := 0;
  SetGridsOptions(FSettings.GridOptions);

  mUnitFullPath.Clear;
  cbExistAction.ItemIndex := 0;
  cbTmplCopyMode.ItemIndex := 0;
  chbReplaceMainObject.Checked := true;
  chbMoveOnlyContent.Checked := true;
  
  dsDict.Open;
  dsDevelUsers.Open;
  dsFolders.Open;
  dsUnitStruct.Open;
  mtPermRanks.CreateDataSet;
  mtPermRoles.CreateDataSet;
  mtRefUsers.CreateDataSet;
  mtSelectedRanks.CreateDataSet;
  mtLog.CreateDataSet;
  mtObjectList.CreateDataSet;

  cbAction.ItemIndex := -1;
  cbActionChange(cbAction);
  tsProgress.TabVisible := false;
end;

procedure TFGroupAction.FormDeactivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, false);
end;

procedure TFGroupAction.FormDestroy(Sender: TObject);
begin
  SaveGridsParams;
end;

function TFGroupAction.GetRankFullPath(RankPk: integer): string;
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

function TFGroupAction.GetTemplateText(TmplPk: Variant; NameToReplace, NameThanReplace: string): string;
begin
  result := '';
  dsTemplate.Close;
  dsTemplate.ParamByName('PK').Value := TmplPk;
  dsTemplate.Open;
  if dsTemplate.Active and (not dsTemplate.IsEmpty) then result := PyUnicodeToAnsi(dsTemplateTEXT_TEMPLATE.AsString);
  dsTemplate.Close;
  if (result = '') then exit;

  // теперь замены
  if chbReplaceMainObject.Checked then
    result := StringReplace(result, NameToReplace, NameThanReplace, [rfReplaceAll, rfIgnoreCase]);
end;

procedure TFGroupAction.InvertSelection;
var
  pk: Variant;
  i: integer;
  sl: TStringList;
  ds: TMemTableEh;
  Grid: TDBGridEh;

begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then Grid := TDBGridEh(ActiveControl)
  else exit;

  ds := TMemTableEh(Grid.DataSource.DataSet);
  if (not ds.Active) or ds.IsEmpty then exit;

  sl := TStringList.Create;
  pk := ds.FieldByName('PK').AsVariant;
  ds.DisableControls;
  try
    for i := 0 to Grid.SelectedRows.Count - 1 do
      if ds.BookmarkValid(TBookmark(Grid.SelectedRows.Items[i])) then
      begin
        ds.GotoBookmark(TBookmark(Grid.SelectedRows.Items[i]));
        sl.Add(ds.FieldByName('PK').AsString);
      end;

    Grid.SelectedRows.Clear;
    ds.First;
    while not ds.Eof do
    begin
      if sl.IndexOf(ds.FieldByName('PK').AsString) = -1 then
        Grid.SelectedRows.AppendItem(ds.Bookmark);
      ds.Next;
    end;
  finally
    ds.EnableControls;
    if not ds.Locate('PK', pk, []) then ds.First;
    sl.Free;
  end;
end;

procedure TFGroupAction.lcbDictChange(Sender: TObject);
begin
  sbCopyPerms.Enabled := lcbDict.KeyValue <> Null;
end;

function TFGroupAction.LoadObjectList(type_: integer; var Err: string): boolean;

  function AddReferenceByRef(RefPk: integer; var err: string): boolean;
  var
    ds: TpFIBDataSet;

  begin
    result := false;
    err := '';
    if CanStop then exit;

    try
      try
        // справочники справочника
        ds := FMain.OpenSQL('select r.PK, r.DESCRIPTOR_, r.TITLE, u.LOGIN from DYNAMIC_FORM_REFERENCE r ' +
          'left join USERS u on u.PK = r.OWNER_USER_PK ' +
          'where r.PARENT_REFERENCE_PK = :REF_PK',
          'REF_PK=' + IntToStr(RefPk));

        ds.First;

        while not ds.Eof do
        begin
          if CanStop then exit;
          
          if mtObjectList.Locate('PK', ds.FieldByName('PK').Value, []) then
            mtObjectList.Edit
          else
            mtObjectList.Append;

          mtObjectListPK.AsVariant := ds.FieldByName('PK').Value;
          mtObjectListLOGIN.AsVariant := ds.FieldByName('LOGIN').Value;
          mtObjectListTYPE.AsVariant := 0;
          mtObjectListDESCRIPTOR.AsVariant := ds.FieldByName('DESCRIPTOR_').Value;
          mtObjectListNAME.AsVariant := ds.FieldByName('TITLE').Value;
          mtObjectListFULLNAME.AsString := mtObjectListPK.AsString + ' : ' + mtObjectListDESCRIPTOR.AsString + ' : ' +
            mtObjectListNAME.AsString;

          mtObjectList.Post;

          // дочерние справочники
          result := AddReferenceByRef(ds.FieldByName('PK').AsInteger, err);
          if not result then exit;
          ds.Next;
        end;
        result := true;
      except
        on e: Exception do err := e.Message;
      end;
    finally
      if Assigned(ds) then
      begin
        if ds.Active then ds.Close;
        ds.Free;
      end;
    end;
  end;

  function AddReferenceByFolder(FldrPk: integer; Recursive: boolean; var err: string): boolean;
  var
    ds: TpFIBDataSet;

  begin
    result := false;
    err := '';
    if CanStop then exit;
    
    try
      try
        // справочники папки
        ds := FMain.OpenSQL('select r.PK, r.DESCRIPTOR_, r.TITLE, u.LOGIN from DYNAMIC_FORM_REFERENCE r ' +
          'left join USERS u on u.PK = r.OWNER_USER_PK ' +
          'where r.FOLDER_PK = :FOLDER_PK',
          'FOLDER_PK=' + IntToStr(FldrPk));

        ds.First;

        while not ds.Eof do
        begin
          if CanStop then exit;
          
          if mtObjectList.Locate('PK', ds.FieldByName('PK').Value, []) then
            mtObjectList.Edit
          else
            mtObjectList.Append;

          mtObjectListPK.AsVariant := ds.FieldByName('PK').Value;
          mtObjectListLOGIN.AsVariant := ds.FieldByName('LOGIN').Value;
          mtObjectListTYPE.AsVariant := 0;
          mtObjectListDESCRIPTOR.AsVariant := ds.FieldByName('DESCRIPTOR_').Value;
          mtObjectListNAME.AsVariant := ds.FieldByName('TITLE').Value;
          mtObjectListFULLNAME.AsString := mtObjectListPK.AsString + ' : ' + mtObjectListDESCRIPTOR.AsString + ' : ' +
            mtObjectListNAME.AsString;

          mtObjectList.Post;

          // дочерние справочники
          result := AddReferenceByRef(ds.FieldByName('PK').AsInteger, err);
          if not result then exit;
          ds.Next;
        end;

        ds.Close;
        FreeAndNil(ds);
        if CanStop then exit;
        
        // теперь дочерние папки
        if Recursive then
        begin
          ds := FMain.OpenSQL('select PK, NAME from DYNAMIC_FORM_FOLDER where PARENT_FOLDER_PK = :FOLDER_PK',
            'FOLDER_PK=' + IntToStr(FldrPk));

          ds.First;

          while not ds.Eof do
          begin
            if CanStop then exit;
            result := AddReferenceByFolder(ds.FieldByName('PK').AsInteger, Recursive, err);
            if not result then exit;
            ds.Next;
          end;
        end;

        result := true;
      except
        on e: Exception do err := e.Message;
      end;
    finally
      if Assigned(ds) then
      begin
        if ds.Active then ds.Close;
        ds.Free;
      end;
    end;
  end;

  function AddFolderByFolder(FldrPk: integer; Recursive: boolean; var err: string): boolean;
  var
    ds: TpFIBDataSet;

  begin
    result := false;
    err := '';
    if CanStop then exit;
    
    try
      try
        // папки папки
        ds := FMain.OpenSQL('select PK, NAME from DYNAMIC_FORM_FOLDER where PARENT_FOLDER_PK = :FOLDER_PK',
          'FOLDER_PK=' + IntToStr(FldrPk));

        ds.First;

        while not ds.Eof do
        begin
          if CanStop then exit;
          
          if mtObjectList.Locate('PK;TYPE', VarArrayOf([ds.FieldByName('PK').Value, 1]), []) then
            mtObjectList.Edit
          else
            mtObjectList.Append;

          mtObjectListPK.AsVariant := ds.FieldByName('PK').Value;
          mtObjectListTYPE.AsVariant := 1;
          mtObjectListNAME.AsVariant := ds.FieldByName('NAME').Value;
          mtObjectListFULLNAME.AsString := mtObjectListPK.AsString + ' : ' + mtObjectListNAME.AsString;
          
          mtObjectList.Post;
          ds.Next;
        end;

        ds.Close;
        FreeAndNil(ds);
        if CanStop then exit;
        
        // теперь дочерние папки
        if Recursive then
        begin
          ds := FMain.OpenSQL('select PK, NAME from DYNAMIC_FORM_FOLDER where PARENT_FOLDER_PK = :FOLDER_PK',
            'FOLDER_PK=' + IntToStr(FldrPk));

          ds.First;

          while not ds.Eof do
          begin
            if CanStop then exit;
            result := AddFolderByFolder(ds.FieldByName('PK').AsInteger, Recursive, err);
            if not result then exit;
            ds.Next;
          end;
        end;

        result := true;
      except
        on e: Exception do err := e.Message;
      end;
    finally
      if Assigned(ds) then
      begin
        if ds.Active then ds.Close;
        ds.Free;
      end;
    end;
  end;

  function AddFolder(FldrPk: integer; var err: string): boolean;
  var
    ds: TpFIBDataSet;

  begin
    result := false;
    err := '';
    if CanStop then exit;

    try
      try
        // папка
        ds := FMain.OpenSQL('select PK, NAME from DYNAMIC_FORM_FOLDER where PK = :FOLDER_PK', 'FOLDER_PK=' + IntToStr(FldrPk));
        ds.First;

        while not ds.Eof do
        begin
          if CanStop then exit;
          mtObjectList.Append;
          mtObjectListPK.AsVariant := ds.FieldByName('PK').Value;
          mtObjectListTYPE.AsVariant := 1;
          mtObjectListNAME.AsVariant := ds.FieldByName('NAME').Value;
          mtObjectListFULLNAME.AsString := mtObjectListPK.AsString + ' : ' + mtObjectListNAME.AsString;
          mtObjectList.Post;
          ds.Next;
        end;

        result := true;
      except
        on e: Exception do err := e.Message;
      end;
    finally
      if Assigned(ds) then
      begin
        if ds.Active then ds.Close;
        ds.Free;
      end;
    end;
  end;
  
begin
  result := false;
  Err := '';
  mtObjectList.EmptyTable;
  if CanStop then exit;
  
  case type_ of
    // все справочники, привязанные к папке, ко всем вложенным папкам и все дочерние справочники, не привязанные к папкам
    0: result := AddReferenceByFolder(FolderPk, true, Err);
    1:
    begin
      // все справочники, привязанные к этой папке и все их дочерние справочники, не привязанные к папке
      result := AddReferenceByFolder(FolderPk, false, Err);
      // все папки, непосредственно привязанные к этой папке
      if result then
        result := AddFolderByFolder(FolderPk, false, Err);
    end;
    // только указанная папка
    2: result := AddFolder(FolderPk, Err);
  end;
end;

procedure TFGroupAction.LoadPermissions(Source: TpFIBDataSet; Dest: TMemTableEh);
var
  i: integer;
  pk: Variant;

begin
  Source.Close;
  Source.ParamByName('REF_PK').Value := lcbDict.KeyValue;
  Source.Open;
  Source.First;

  Dest.DisableControls;
  try
    pk := Dest.FieldByName('PK').Value;
    
    while not Source.Eof do
    begin
      if Dest.Locate('ROLE_PK', Source.FieldByName('ROLE_PK').Value, []) then
        Dest.Edit
      else
        Dest.Append;

      Dest.FieldByName('REF_PK').Value := lcbDict.KeyValue;
      Dest.FieldByName('REF_NAME').Value := lcbDict.Text;
      for i := 0 to Source.Fields.Count - 1 do
        Dest.FieldByName(Source.Fields.Fields[i].FieldName).Value := Source.Fields.Fields[i].Value;

      Dest.Post;
      Source.Next;
    end;
  finally
    Dest.EnableControls;
    if not Dest.Locate('PK', pk, []) then Dest.First;
  end;
end;

procedure TFGroupAction.LoadTemplate(Memo: TMemo; TmplPk: Variant);
begin
  Memo.Clear;
  dsTemplate.Close;
  dsTemplate.ParamByName('PK').Value := TmplPk;
  dsTemplate.Open;
  if dsTemplate.Active and (not dsTemplate.IsEmpty) then Memo.Text := PyUnicodeToAnsi(dsTemplateTEXT_TEMPLATE.AsString);
  dsTemplate.Close;
end;

procedure TFGroupAction.mtPermRanksAfterInsert(DataSet: TDataSet);
begin
  mtPermRanksACTION.AsInteger := 0;
  mtPermRanksADD_.AsInteger := 0;
  mtPermRanksEDIT_.AsInteger := 0;
  mtPermRanksDEL_.AsInteger := 0;
  mtPermRanksVIEW_REF.AsInteger := 1;
  mtPermRanksCONFIG_.AsInteger := 0;
  mtPermRanksVIEW_.AsInteger := 1;
  mtPermRanksEXPORT.AsInteger := 0;
  mtPermRanksIMPORT.AsInteger := 0;
  mtPermRanksGRID_SAVE.AsInteger := 0;
end;

procedure TFGroupAction.mtPermRanksAfterScroll(DataSet: TDataSet);
begin
  if (DataSet = mtPermRanks) and (not DataSet.FieldByName('ROLE_PK').IsNull) then
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

procedure TFGroupAction.mtPermRolesAfterInsert(DataSet: TDataSet);
begin
  mtPermRolesACTION.AsInteger := 0;
  mtPermRolesADD_.AsInteger := 0;
  mtPermRolesEDIT_.AsInteger := 0;
  mtPermRolesDEL_.AsInteger := 0;
  mtPermRolesVIEW_REF.AsInteger := 1;
  mtPermRolesCONFIG_.AsInteger := 0;
  mtPermRolesVIEW_.AsInteger := 1;
  mtPermRolesEXPORT.AsInteger := 0;
  mtPermRolesIMPORT.AsInteger := 0;
  mtPermRolesGRID_SAVE.AsInteger := 0;
end;

procedure TFGroupAction.mtRefUsersAfterInsert(DataSet: TDataSet);
begin
  mtRefUsersACTION.AsInteger := 0;
end;

procedure TFGroupAction.SaveGridsParams;
var
  i: integer;

begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TDBGridEh then FSettings.SaveGridParams(TDBGridEh(Components[i]), ClassName);
end;

procedure TFGroupAction.SavePermissions(RefPk: Variant; RefName: string);

  function _permExists(Table: string; ref_pk, role_pk: string): boolean;
  var
    ds: TpFIBDataSet;

  begin
    try
      ds := FMain.OpenSQL('select PK from ' + Table + ' where REFERENCE_PK = ' + ref_pk + ' and ROLE_PK = ' + role_pk);
      result := ds.Active and (not ds.IsEmpty);
    except
      result := false;
    end;
    
    if Assigned(ds) then
    begin
      ds.Close;
      ds.Free;
    end;
  end;

  procedure _setParam(Query: TpFIBQuery; ParamName: string; FieldSrc: TField; keyList: TStringList; ConvToUni: boolean;
    NameToReplace, NameThanReplace: string);
  var
    tpk: Variant;
    err: string;

  begin
    err := '';

    if (cbTmplCopyMode.ItemIndex = 0) and (FieldSrc.Value <> 1) and (FieldSrc.Value <> 0) then
    begin
      tpk := keyList.Values[FieldSrc.AsString];
      if tpk = '' then tpk := SaveTemplate(GetTemplateText(FieldSrc.Value, NameToReplace, NameThanReplace), Null, true, ConvToUni, err);
      if (not VarIsNull(tpk)) then keyList.Values[FieldSrc.AsString] := VarToStr(tpk);
      Query.ParamByName(ParamName).Value := tpk;
      if err <> '' then AddToLog(2, 'Привязка шаблона ' + ParamName, RefName, err);
    end else
      Query.ParamByName(ParamName).Value := FieldSrc.Value;
  end;

  function _getMainObjectName(ref_pk: Variant; var err: string): string;
  var
    ds: TpFIBDataSet;

  begin
    result := '';
    if VarIsNull(ref_pk) then exit;

    try
      ds := FMain.OpenSQL('select first 1 o.NAME from DYNAMIC_FORM_REFERENCE r ' +
        'join DYNAMIC_FORM_OBJECT_TREE o on o.FORM_PK = r.MAIN_FORM_PK ' +
        'where r.PK = :REF_PK and (o.JOIN_PARENT_PK is null or (o.JOIN_PARENT_PK is not null and o.IS_MULTI_JOIN = ''1''))',
        'REF_PK=' + VarToStr(ref_pk));

      if ds.Active and (not ds.IsEmpty) then result := ds.Fields.Fields[0].AsString;
    except
      on e: Exception do err := e.Message;
    end;

    if Assigned(ds) then
    begin
      ds.Close;
      ds.Free;
    end;
  end;

var
  mt: TMemTableEh;
  q: TpFIBQuery;
  sl: TStringList;
  t, err: string;
  NameToReplace, NameThanReplace: string;

begin
  if VarIsNull(RefPk) then exit;
  if CanStop then exit;
    
  case cbAction.ItemIndex of
    0:
    begin
      q := qEditPermRank;
      mt := mtPermRanks;
      t := 'DYNAMIC_FORM_PERM_RANKS';
    end;
    1:
    begin
      q := qEditPermRole;
      mt := mtPermRoles;
      t := 'DYNAMIC_FORM_PERMISSIONS';
    end;
    else exit;
  end;

  if chbReplaceMainObject.Checked then NameThanReplace := _getMainObjectName(RefPk, err);
  if err <> '' then
  begin
    AddToLog(2, 'Определение главного объекта БД', RefName, err);
    err := '';
  end;

  sl := TStringList.Create;
  try
    if mt.State in [dsEdit, dsInsert] then mt.Post;
    mt.DisableControls;
    mt.First;
    while not mt.Eof do
    begin
      if CanStop then exit;
      if mt.FieldByName('ROLE_PK').IsNull then
      begin
        mt.Next;
        continue;
      end;

      // удаление прав
      if mt.FieldByName('ACTION').AsInteger = 1 then
      begin
        if not FMain.ExecSQL('delete from ' + t + ' where REFERENCE_PK = ' + VarToStr(RefPk) + ' and ROLE_PK = ' +
          mt.FieldByName('ROLE_PK').AsString, err) then
          AddToLog(2, 'Удаление прав', RefName, err)
        else
          AddToLog(0, 'Удаление прав', RefName, '');
      end else
      begin
        // добавление прав
        if chbReplaceMainObject.Checked then NameToReplace := _getMainObjectName(mt.FieldByName('REF_PK').Value, err);
        if err <> '' then
        begin
          AddToLog(2, 'Определение главного объекта БД', mt.FieldByName('REF_NAME').AsString, err);
          err := '';
        end;

        case cbExistAction.ItemIndex of
          0:  // пропускать
            if _permExists(t, VarToStr(RefPk), mt.FieldByName('ROLE_PK').AsString) then
            begin
              AddToLog(1, 'Привязка прав', RefName, 'Права для должности/роли ' + mt.FieldByName('ROLE_NAME').AsString + ' уже есть');
              mt.Next;
              Continue;
            end;
          1: ;  // заменять
        end;

        try
          q.Close;
          q.ParamByName('REFERENCE_PK').Value := RefPk;
          q.ParamByName('ROLE_PK').Value := mt.FieldByName('ROLE_PK').Value;

          _setParam(q, 'ADD_', mt.FieldByName('ADD_'), sl, false, NameToReplace, NameThanReplace);
          _setParam(q, 'EDIT_', mt.FieldByName('EDIT_'), sl, false, NameToReplace, NameThanReplace);
          _setParam(q, 'DEL_', mt.FieldByName('DEL_'), sl, false, NameToReplace, NameThanReplace);
          _setParam(q, 'VIEW_REF', mt.FieldByName('VIEW_REF'), sl, true, NameToReplace, NameThanReplace);
          _setParam(q, 'VIEW_', mt.FieldByName('VIEW_'), sl, true, NameToReplace, NameThanReplace);
          _setParam(q, 'EXPORT', mt.FieldByName('EXPORT'), sl, false, NameToReplace, NameThanReplace);
          _setParam(q, 'IMPORT', mt.FieldByName('IMPORT'), sl, false, NameToReplace, NameThanReplace);
          _setParam(q, 'CONFIG_', mt.FieldByName('CONFIG_'), sl, false, NameToReplace, NameThanReplace);
          _setParam(q, 'GRID_SAVE', mt.FieldByName('GRID_SAVE'), sl, false, NameToReplace, NameThanReplace);

          q.ExecQuery;
          FMain.Transact.CommitRetaining;
          AddToLog(0, 'Привязка прав', RefName, '');
        except
          on e: Exception do AddToLog(2, 'Привязка прав', RefName, e.Message);
        end;
      end;
      mt.Next;
    end;
  finally
    mt.EnableControls;
    mt.First;
    sl.Free;
  end;
end;

function TFGroupAction.SaveTemplate(TmplText: string; TmplPk: Variant; Insert, ConvertToUni: boolean; var err: string): Variant;
begin
  result := TmplPk;

  if ConvertToUni then
    TmplText := ReplaceQuote(StringReplace(PyAnsiToUnicode(TmplText), '\"', '"', [rfReplaceAll]))
  else
    TmplText := ReplaceQuote(TmplText);

  if VarIsNull(TmplPk) or (TmplPk = 1) or (TmplPk = 0) or Insert then
    FMain.ExecSQL('insert into DYNAMIC_FORM_PERM_TMP (TEXT_TEMPLATE) values (''' + TmplText + ''') returning (PK)', 'PK', result, err)
  else
    FMain.ExecSQL('update DYNAMIC_FORM_PERM_TMP set TEXT_TEMPLATE = ''' + TmplText + ''' where PK = ' + VarToStr(TmplPk), err);
end;

procedure TFGroupAction.sbAddPermClick(Sender: TObject);
var
  fSelRank: TFSelectRank;

begin
  if cbAction.ItemIndex = 1 then mtPermRoles.Append
  else begin
    fSelRank := TFSelectRank.Create(Self);
    try
      if fSelRank.ShowModal = mrOk then
      begin
        if not fSelRank.mtSelectedRanks.Active then exit;
        fSelRank.mtSelectedRanks.First;

        while not fSelRank.mtSelectedRanks.Eof do
        begin
          mtPermRanks.Append;
          mtPermRanksROLE_PK.AsInteger := fSelRank.mtSelectedRanksPK.AsInteger;
          mtPermRanksROLE_NAME.AsString := fSelRank.mtSelectedRanksNAME.AsString;
          mtPermRanks.Post;
          fSelRank.mtSelectedRanks.Next;
        end;
      end;
    finally
      fSelRank.Free;
    end;
  end;

  dbgPermissions.SetFocus;
end;

procedure TFGroupAction.sbAddRefUserClick(Sender: TObject);
begin
  mtRefUsers.Append;
end;

procedure TFGroupAction.sbAddRoleClick(Sender: TObject);
var
  fSelRank: TFSelectRank;

begin
  fSelRank := TFSelectRank.Create(Self);
  try
    if fSelRank.ShowModal = mrOk then
    begin
      if not fSelRank.mtSelectedRanks.Active then exit;
      fSelRank.mtSelectedRanks.First;

      while not fSelRank.mtSelectedRanks.Eof do
      begin
        mtSelectedRanks.Append;
        mtSelectedRanksPK.AsInteger := fSelRank.mtSelectedRanksPK.AsInteger;
        mtSelectedRanksNAME.AsString := fSelRank.mtSelectedRanksNAME.AsString;
        mtSelectedRanks.Post;
        fSelRank.mtSelectedRanks.Next;
      end;
    end;
  finally
    fSelRank.Free;
    dbgSelectedRanks.SetFocus;
  end;
end;

procedure TFGroupAction.sbClearClick(Sender: TObject);
var
  ds: TMemTableEh;

begin
  ds := TMemTableEh(dbgPermissions.DataSource.DataSet);
  if (not ds.Active) or ds.IsEmpty then exit;

  if Application.MessageBox(pchar('Очистить список?'), 'Подтверждение', MB_YESNO + MB_ICONQUESTION) = ID_YES then
    ds.EmptyTable;
end;

procedure TFGroupAction.sbClearRefListClick(Sender: TObject);
begin
  if (not mtRefUsers.Active) or mtRefUsers.IsEmpty then exit;

  if Application.MessageBox(pchar('Очистить список?'), 'Подтверждение', MB_YESNO + MB_ICONQUESTION) = ID_YES then
    mtRefUsers.EmptyTable;
end;

procedure TFGroupAction.sbClearRolesClick(Sender: TObject);
var
  ds: TMemTableEh;

begin
  ds := TMemTableEh(dbgSelectedRanks.DataSource.DataSet);
  if (not ds.Active) or ds.IsEmpty then exit;

  if Application.MessageBox(pchar('Очистить список?'), 'Подтверждение', MB_YESNO + MB_ICONQUESTION) = ID_YES then
    ds.EmptyTable;
end;

procedure TFGroupAction.sbCopyPermsClick(Sender: TObject);
begin
  if cbAction.ItemIndex = 0 then LoadPermissions(dsPermRanks, mtPermRanks)
  else LoadPermissions(dsPermRoles, mtPermRoles);
end;

procedure TFGroupAction.sbDelPermClick(Sender: TObject);
var
  ds: TMemTableEh;

begin
  ds := TMemTableEh(dbgPermissions.DataSource.DataSet);
  if (not ds.Active) or ds.IsEmpty then exit;

  if dbgPermissions.SelectedRows.Count > 0 then
  begin
    if Application.MessageBox(pchar('Убрать из списка ' + IntToStr(dbgPermissions.SelectedRows.Count) + ' выбранных записей?'),
      'Подтверждение', MB_YESNO + MB_ICONQUESTION) = ID_YES then
      dbgPermissions.SelectedRows.Delete;
  end else
  begin
    if Application.MessageBox(pchar('Убрать из списка ' + VarToStr(iif(cbAction.ItemIndex = 0, 'должность', 'роль')) + ' "' +
      ds.FieldByName('ROLE_NAME').AsString + '"?'), 'Подтверждение', MB_YESNO + MB_ICONQUESTION) = ID_YES then
      ds.Delete;
  end;
end;

procedure TFGroupAction.sbDelRefUserClick(Sender: TObject);
begin
  if (not mtRefUsers.Active) or mtRefUsers.IsEmpty then exit;

  if dbgRefUsers.SelectedRows.Count > 0 then
  begin
    if Application.MessageBox(pchar('Убрать из списка ' + IntToStr(dbgRefUsers.SelectedRows.Count) + ' выбранных записей?'),
      'Подтверждение', MB_YESNO + MB_ICONQUESTION) = ID_YES then
      dbgRefUsers.SelectedRows.Delete;
  end else
  begin
    if Application.MessageBox(pchar('Убрать из списка пользователя "' + mtRefUsersNAME.AsString + '"?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) = ID_YES then
      mtRefUsers.Delete;
  end;
end;

procedure TFGroupAction.sbDelRoleClick(Sender: TObject);
var
  ds: TMemTableEh;

begin
  ds := TMemTableEh(dbgSelectedRanks.DataSource.DataSet);
  if (not ds.Active) or ds.IsEmpty then exit;

  if dbgSelectedRanks.SelectedRows.Count > 0 then
  begin
    if Application.MessageBox(pchar('Убрать из списка ' + IntToStr(dbgSelectedRanks.SelectedRows.Count) + ' выбранных записей?'),
      'Подтверждение', MB_YESNO + MB_ICONQUESTION) = ID_YES then
      dbgSelectedRanks.SelectedRows.Delete;
  end else
  begin
    if Application.MessageBox(pchar('Убрать из списка должность "' + ds.FieldByName('NAME').AsString + '"?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) = ID_YES then
      ds.Delete;
  end;
end;

procedure TFGroupAction.SetExecutionState(running: boolean);
var
  i: integer;

begin
  FRunning := running;
  CanStop := false;

  if FRunning then
  begin
    mtLog.EmptyTable;
    btnExec.Enabled := false;
    btnClose.Caption := 'Прервать';
    SetProgress(-1, '', 0);
    tsProgress.TabVisible := true;
    pcMain.ActivePage := tsProgress;
  end else
  begin
    btnExec.Enabled := cbAction.ItemIndex > -1;
    btnClose.Caption := 'Закрыть';
    //SetProgress(-1, '', 0);
    if mtLog.Active then mtLog.First;
  end;

  for i := 0 to pcMain.PageCount - 1 do
    if pcMain.Pages[i] <> tsProgress then pcMain.Pages[i].Enabled := not FRunning;
end;

procedure TFGroupAction.SetFolderPk(Value: Variant);
begin
  if VarIsNull(Value) then raise Exception.Create('Не выбрана папка!');
  FFolderPk := Value;
end;

procedure TFGroupAction.SetGridsOptions(Options: TGridParams);
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

procedure TFGroupAction.SetProgress(Actn: integer; ObjName: string; Position: integer);
var
  Total: integer;

begin
  if ProgressBar.Max <= 0 then Total := 1
  else Total := ProgressBar.Max;
  
  case Actn of
    0: lbAction.Caption := 'Выдача/удаление прав должностям';
    1: lbAction.Caption := 'Выдача/удаление прав ролям';
    2: lbAction.Caption := 'Выдача/удаление прав на конфигурацию';
    3: lbAction.Caption := 'Смена владельца';
    4: lbAction.Caption := 'Перемещение в другую папку';
    5: lbAction.Caption := 'Копирование прав должности';
    else begin
      lbAction.Caption := '';
      lbObject.Caption := '';
      lbProgress.Caption := '';
      ProgressBar.Max := 100;
      ProgressBar.Position := 0;
      exit;
    end;
  end;

  lbObject.Caption := ObjName;
  lbProgress.Caption := IntToStr(Position) + ' / ' + IntToStr(Total) + ' (' + IntToStr(Round((Position / Total) * 100)) + '%)';
  ProgressBar.Position := Position;

  Application.ProcessMessages;
end;

end.
