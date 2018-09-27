unit users;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, childForm, main, settings, utils,
  DBGridEhGrouping, GridsEh, DBGridEh, DB, FIBDataSet, pFIBDataSet, ExtCtrls, EhLibFIB, WDGradient, StdCtrls, Mask,
  DBCtrlsEh, DBLookupEh, Buttons, ActnList, ComCtrls, filter, Menus, ToolWin, addRank, MemTableDataEh, MemTableEh, EhLibMTE,
  userEditor, dbFind;

type
  TFUsers = class(TChildForm)
    dbgUsers: TDBGridEh;
    dsUsers: TpFIBDataSet;
    dsoUsers: TDataSource;
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
    dsUsersATTR_NAME: TFIBStringField;
    dsUsersHOLIDAY: TFIBStringField;
    pInfo: TPanel;
    Splitter1: TSplitter;
    pFilters: TPanel;
    Splitter2: TSplitter;
    dbgUserGroups: TDBGridEh;
    dsUserGroups: TpFIBDataSet;
    dsoUserGroups: TDataSource;
    dsUserGroupsNAME: TFIBStringField;
    dbgUserRanks: TDBGridEh;
    dsUserRanks: TpFIBDataSet;
    dsoUserRanks: TDataSource;
    dsUserRanksMAIN_ROLE: TFIBStringField;
    dsUserRanksPK: TFIBIntegerField;
    dsUserRanksNAME: TFIBStringField;
    dsUserRanksBRANCH_PK: TFIBIntegerField;
    dsUserRanksBRANCH_NAME: TFIBStringField;
    dsUserRanksFULLNAME: TFIBStringField;
    dsUserRanksBOSS: TFIBIntegerField;
    dsUserRanksIS_CHIEF: TFIBStringField;
    Splitter3: TSplitter;
    dbgUserRefGrant: TDBGridEh;
    Splitter4: TSplitter;
    dsUserRefGrant: TpFIBDataSet;
    dsoUserRefGrant: TDataSource;
    pCaption: TWDGradientPanel;
    dsDepartment: TpFIBDataSet;
    dsDepartmentNAME: TFIBStringField;
    dsoDepartment: TDataSource;
    Label3: TLabel;
    lcbDepartment: TDBLookupComboboxEh;
    dsService: TpFIBDataSet;
    dsoService: TDataSource;
    Label4: TLabel;
    lcbService: TDBLookupComboboxEh;
    dsDivision: TpFIBDataSet;
    dsoDivision: TDataSource;
    Label5: TLabel;
    lcbDivision: TDBLookupComboboxEh;
    dsSector: TpFIBDataSet;
    dsoSector: TDataSource;
    Label6: TLabel;
    lcbSector: TDBLookupComboboxEh;
    Label8: TLabel;
    cbConcatStr: TComboBox;
    btnApplyFilter: TBitBtn;
    btnClearFilter: TBitBtn;
    chbUserMainRole: TCheckBox;
    ActionList: TActionList;
    AFilter: TAction;
    dsRank: TpFIBDataSet;
    dsoRank: TDataSource;
    Label1: TLabel;
    lcbRank: TDBLookupComboboxEh;
    Label2: TLabel;
    lcbGroup: TDBLookupComboboxEh;
    dsGroup: TpFIBDataSet;
    dsoGroup: TDataSource;
    dsRole: TpFIBDataSet;
    dsoRole: TDataSource;
    Label7: TLabel;
    lcbRole: TDBLookupComboboxEh;
    dsReference: TpFIBDataSet;
    dsoReference: TDataSource;
    Label9: TLabel;
    lcbReference: TDBLookupComboboxEh;
    dsReferencePK: TFIBIntegerField;
    dsReferenceDESCRIPTOR_: TFIBStringField;
    dsReferenceTITLE: TFIBStringField;
    dsRoleNAME: TFIBStringField;
    dsGroupNAME: TFIBStringField;
    dsRankNAME: TFIBStringField;
    dsSectorNAME: TFIBStringField;
    dsDivisionNAME: TFIBStringField;
    dsServiceNAME: TFIBStringField;
    AClearFilter: TAction;
    AClose: TAction;
    StatusBar: TStatusBar;
    btnClearFields: TBitBtn;
    ABaseFilter: TAction;
    AResetBaseFilter: TAction;
    pmUsers: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    dsUserGroupsPK: TFIBIntegerField;
    dsUserRanksDEPARTMENT: TFIBStringField;
    dsUserRanksOFFICE: TFIBStringField;
    dsUserRanksCHAPTER: TFIBStringField;
    dsUserRanksSECTOR: TFIBStringField;
    AGridOptions: TAction;
    pmGrid: TPopupMenu;
    MenuItem1: TMenuItem;
    ToolBar: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    AAddGroup: TAction;
    ToolButton5: TToolButton;
    ADelGroup: TAction;
    ToolButton6: TToolButton;
    AAddDict: TAction;
    ADelDict: TAction;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    AAddRank: TAction;
    ADelRank: TAction;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    dsUserRanksROLE_PK: TFIBIntegerField;
    dsUsersMANAGER: TFIBStringField;
    dsUsersBOSS: TFIBStringField;
    dsUsersDEP_DIRECTOR: TFIBStringField;
    ToolButton11: TToolButton;
    chbLoadBoss: TCheckBox;
    dsUserRefGrantPK: TFIBIntegerField;
    dsUserRefGrantDESCRIPTOR_: TFIBStringField;
    dsUserRefGrantTITLE: TFIBStringField;
    dsUserRefGrantBASE_DESCRIPTOR: TFIBStringField;
    dsUserRefGrantFOLDER_PK: TFIBIntegerField;
    dsUserRefGrantFOLDER_NAME: TFIBStringField;
    dsUserRefGrantOWNER_USER_PK: TFIBIntegerField;
    dsUserRefGrantLOGIN: TFIBStringField;
    dsUserRefGrantUSER_NAME: TFIBStringField;
    dsUserRefGrantROLE_PK: TFIBIntegerField;
    dsUserRefGrantROLE_NAME: TFIBStringField;
    dsUserRefGrantMAIN_ROLE: TFIBStringField;
    dsUserRefGrantVIEW_REF: TFIBIntegerField;
    dsUserRefGrantVIEW_: TFIBIntegerField;
    dsUserRefGrantADD_: TFIBIntegerField;
    dsUserRefGrantEDIT_: TFIBIntegerField;
    dsUserRefGrantDEL_: TFIBIntegerField;
    dsUserRefGrantCONFIG_: TFIBIntegerField;
    dsUserRefGrantEXPORT: TFIBIntegerField;
    dsUserRefGrantIMPORT: TFIBIntegerField;
    dsUserRefGrantTYPE_: TFIBIntegerField;
    mtUserRefGrant: TMemTableEh;
    mtUserRefGrantPK: TIntegerField;
    mtUserRefGrantDESCRIPTOR_: TStringField;
    mtUserRefGrantTITLE: TStringField;
    mtUserRefGrantBASE_DESCRIPTOR: TStringField;
    mtUserRefGrantFOLDER_PK: TIntegerField;
    mtUserRefGrantFOLDER_NAME: TStringField;
    mtUserRefGrantOWNER_USER_PK: TIntegerField;
    mtUserRefGrantLOGIN: TStringField;
    mtUserRefGrantUSER_NAME: TStringField;
    mtUserRefGrantROLE_PK: TIntegerField;
    mtUserRefGrantROLE_NAME: TStringField;
    mtUserRefGrantMAIN_ROLE: TStringField;
    mtUserRefGrantVIEW_REF: TIntegerField;
    mtUserRefGrantVIEW_: TIntegerField;
    mtUserRefGrantADD_: TIntegerField;
    mtUserRefGrantEDIT_: TIntegerField;
    mtUserRefGrantDEL_: TIntegerField;
    mtUserRefGrantCONFIG_: TIntegerField;
    mtUserRefGrantEXPORT: TIntegerField;
    mtUserRefGrantIMPORT: TIntegerField;
    mtUserRefGrantTYPE_: TIntegerField;
    AAddUser: TAction;
    AEditUser: TAction;
    ADelUser: TAction;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    N3: TMenuItem;
    Insert1: TMenuItem;
    ShiftEnter1: TMenuItem;
    CtrlDelete1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    Label10: TLabel;
    edRankPk: TDBNumberEditEh;
    AExportToExcel: TAction;
    AExportToCsv: TAction;
    Excel1: TMenuItem;
    csv1: TMenuItem;
    Label11: TLabel;
    lcbBranch: TDBLookupComboboxEh;
    dsBranch: TpFIBDataSet;
    dsoBranch: TDataSource;
    dsBranchPK: TFIBIntegerField;
    dsBranchFULLNAME: TFIBStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dsUsersEndScroll(DataSet: TDataSet);
    procedure DBGridFillSTFilterListValues(Sender: TCustomDBGridEh; Column: TColumnEh; Items: TStrings; var Processed: Boolean);
    procedure DBGridApplyFilter(Sender: TObject);
    procedure AFilterExecute(Sender: TObject);
    procedure btnApplyFilterClick(Sender: TObject);
    procedure btnClearFilterClick(Sender: TObject);
    procedure ACloseExecute(Sender: TObject);
    procedure dsUsersAfterOpen(DataSet: TDataSet);
    procedure btnClearFieldsClick(Sender: TObject);
    procedure dsUsersAfterClose(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ABaseFilterExecute(Sender: TObject);
    procedure AResetBaseFilterExecute(Sender: TObject);
    procedure AGridOptionsExecute(Sender: TObject);
    procedure AAddGroupExecute(Sender: TObject);
    procedure AAddGroupUpdate(Sender: TObject);
    procedure ADelGroupUpdate(Sender: TObject);
    procedure ADelGroupExecute(Sender: TObject);
    procedure AAddDictExecute(Sender: TObject);
    procedure ADelDictUpdate(Sender: TObject);
    procedure ADelDictExecute(Sender: TObject);
    procedure AAddRankExecute(Sender: TObject);
    procedure ADelRankUpdate(Sender: TObject);
    procedure ADelRankExecute(Sender: TObject);
    procedure AResetBaseFilterUpdate(Sender: TObject);
    procedure chbLoadBossClick(Sender: TObject);
    procedure AAddUserUpdate(Sender: TObject);
    procedure AAddUserExecute(Sender: TObject);
    procedure AEditUserExecute(Sender: TObject);
    procedure AEditUserUpdate(Sender: TObject);
    procedure ADelUserExecute(Sender: TObject);
    procedure dbgUsersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgUserRanksKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AExportToExcelExecute(Sender: TObject);
    procedure AExportToCsvExecute(Sender: TObject);
  private
    RecCount: integer;
    FFilter: TfFilter;
    procedure ApplyBaseFilter;
    procedure ClearBaseFilter;
    procedure ApplyExtendFilter;
    procedure ClearExtendFilter;
    procedure SetMode(Value: TOpenMode); override;
    function GetUsersSql(ShowBoss: boolean): string;
    procedure Find(Grid: TDBGridEh; AContinue: boolean = false);
  public
    procedure OnUserEditorClose(Sender: TObject; var Action: TCloseAction);
  end;

implementation

{$R *.dfm}

procedure TFUsers.AAddDictExecute(Sender: TObject);
var
  err: string;
  res: boolean;
  pk: Variant;

begin
  if Mode <> omEdit then exit;
  if (not dsUsers.Active) or dsUsers.IsEmpty then exit;

  if not FMain.SelDictDialog(pk, 'select PK, DESCRIPTOR_, TITLE NAME from DYNAMIC_FORM_REFERENCE order by TITLE') then exit;

  if VarIsNull(pk) then
  begin
    res := false;
    err := 'Не выбран справочник!';
  end else
  begin
    res := FMain.ExecSQL('insert into DYNAMIC_FORM_REF_USER (REF_PK, USER_PK) values (' + VarToStr(pk) + ', ' + dsUsersPK.AsString + ')', err);
    if res then dsUsersEndScroll(dsUsers);
  end;

  if not res then Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFUsers.AAddGroupExecute(Sender: TObject);
var
  err: string;
  res: boolean;
  pk: Variant;

begin
  if Mode <> omEdit then exit;
  if (not dsUsers.Active) or dsUsers.IsEmpty then exit;

  if not FMain.SelGroupDialog(pk, 'select PK, NAME from USER_GROUPS order by NAME') then exit;

  if VarIsNull(pk) then
  begin
    res := false;
    err := 'Не выбрана группа!';
  end else
  begin
    res := FMain.ExecSQL('insert into USERS_USER_GROUPS (GROUP_PK, USER_PK) values (' + VarToStr(pk) + ', ' + dsUsersPK.AsString + ')', err);
    if res then dsUsersEndScroll(dsUsers);
  end;

  if not res then Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFUsers.AAddGroupUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := dsUsers.Active and (not dsUsers.IsEmpty) and (Mode = omEdit);
end;

procedure TFUsers.AAddRankExecute(Sender: TObject);
var
  fsel: TFAddRank;
  err: string;
  res: boolean;

begin
  if Mode <> omEdit then exit;
  if (not dsUsers.Active) or dsUsers.IsEmpty then exit;

  fsel := TFAddRank.Create(Self);
  try
    res := fsel.ShowModal = mrOk;
    if res then
    begin
      if VarIsNull(fsel.lcbRank.KeyValue) then
      begin
        err := 'Не выбрана должность';
        res := false;
      end;
      if VarIsNull(fsel.lcbBranch.KeyValue) then
      begin
        err := 'Не выбрано подразделение';
        res := false;
      end;

      if res then
      try
        Screen.Cursor := crSQLWait;
        res := FMain.ExecSQL('insert into USER_ROLES (USER_PK, ROLE_PK, GEO_PK, MAIN_ROLE) values (' + dsUsersPK.AsString + ', ' +
          VarToStr(fsel.lcbRank.KeyValue) + ', ' + VarToStr(fsel.lcbBranch.KeyValue) + ', ''' + iif(fsel.chbMain.Checked, '1', '0') + ''')', err);
      finally
        Screen.Cursor := crDefault;
      end;

      if res then dsUsersEndScroll(dsUsers)
      else Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
    end;
  finally
    fsel.Free;
  end;
end;

procedure TFUsers.AAddUserExecute(Sender: TObject);
var
  FUserEditor: TFUserEditor;

begin
  if (not dsUsers.Active) or (Mode <> omEdit) then exit;

  // открытие формы редактирования пльзователя
  FUserEditor := TFUserEditor.Create(Self, cftEditor, omAdd, Null, FMain.OnChildFormClose);
  FUserEditor.OnClose := OnUserEditorClose;
  FUserEditor.Caption := 'Новый пользователь';
  FUserEditor.cbRole.ReadOnly := true;
  FUserEditor.cbRole.Color := clBtnFace;
  FUserEditor.cbRole.TabStop := false;
  FUserEditor.edShortName.ReadOnly := true;
  FUserEditor.edShortName.Color := clBtnFace;
  FUserEditor.cbRole.KeyValue := 7;
  FUserEditor.chbIsActive.Checked := true;
  FUserEditor.RegisterForm;
end;

procedure TFUsers.AAddUserUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := dsUsers.Active and (Mode = omEdit);
end;

procedure TFUsers.ABaseFilterExecute(Sender: TObject);
begin
  ApplyBaseFilter;         
end;

procedure TFUsers.ACloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFUsers.ADelDictExecute(Sender: TObject);
var
  err: string;

begin
  if Mode <> omEdit then exit;
  if (not mtUserRefGrant.Active) or mtUserRefGrant.IsEmpty or (mtUserRefGrantTYPE_.AsInteger <> 2) then exit;

  if Application.MessageBox(pchar('Забрать права на конфигурацию справочника "' + mtUserRefGrantTITLE.AsString +
    '" у пользователя "' + dsUsersNAME.AsString + '"?'), 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

  if FMain.ExecSQL('delete from DYNAMIC_FORM_REF_USER where REF_PK = ' + mtUserRefGrantPK.AsString + ' and USER_PK = ' +
    dsUsersPK.AsString, err) then dsUsersEndScroll(dsUsers)
  else
    Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFUsers.ADelDictUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := mtUserRefGrant.Active and (not mtUserRefGrant.IsEmpty) and (Mode = omEdit) and (mtUserRefGrantTYPE_.AsInteger = 2);
end;

procedure TFUsers.ADelGroupExecute(Sender: TObject);
var
  err: string;

begin
  if Mode <> omEdit then exit;
  if (not dsUserGroups.Active) or dsUserGroups.IsEmpty then exit;

  if Application.MessageBox(pchar('Отвязать группу "' + dsUserGroupsNAME.AsString + '" у пользователя "' + dsUsersNAME.AsString + '"?'),
    'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

  if FMain.ExecSQL('delete from USERS_USER_GROUPS where GROUP_PK = ' + dsUserGroupsPK.AsString + ' and USER_PK = ' +
    dsUsersPK.AsString, err) then dsUsersEndScroll(dsUsers)
  else
    Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFUsers.ADelGroupUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := dsUserGroups.Active and (not dsUserGroups.IsEmpty) and (Mode = omEdit);
end;

procedure TFUsers.ADelRankExecute(Sender: TObject);
var
  err: string;

begin
  if Mode <> omEdit then exit;
  if (not dsUserRanks.Active) or dsUserRanks.IsEmpty then exit;

  if Application.MessageBox(pchar('Отвязать должность "' + dsUserRanksNAME.AsString +
    '" у пользователя "' + dsUsersNAME.AsString + '"?'), 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

  Screen.Cursor := crSQLWait;
  try
    if FMain.ExecSQL('delete from USER_ROLES where PK = ' + dsUserRanksROLE_PK.AsString, err) then
      dsUsersEndScroll(dsUsers)
    else
      Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFUsers.ADelRankUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := dsUserRanks.Active and (not dsUserRanks.IsEmpty) and (Mode = omEdit);
end;

procedure TFUsers.ADelUserExecute(Sender: TObject);
var
  err: string;

begin
  if (not dsUsers.Active) or dsUsers.IsEmpty or (Mode <> omEdit) then exit;

  if Application.MessageBox(pchar('Удалить пользователя "' + dsUsersPK.AsString + ' : ' + dsUsersNAME.AsString + '"?'), 'Подтверждение',
    MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

  if not FMain.ExecSQL('delete from USERS where PK = ' + dsUsersPK.AsString, err) then
    Application.MessageBox(pchar('Ошибка удаления пользователя.'#13#10 + err), 'Ошибка', MB_OK + MB_ICONERROR)
  else
    AFilterExecute(AClearFilter);
end;

procedure TFUsers.AEditUserExecute(Sender: TObject);
var
  FUserEditor: TFUserEditor;
  m: TOpenMode;

begin
  if (not dsUsers.Active) or dsUsers.IsEmpty then exit;

  if Mode = omView then m := omView
  else m := omEdit;

  // открытие формы редактирования пльзователя
  if FMain.SetFocusOpenedWindow(dsUsersPK.AsInteger, TFUserEditor.ClassName) then exit;
  FUserEditor := TFUserEditor.Create(Self, cftEditor, m, dsUsersPK.AsVariant, FMain.OnChildFormClose);
  FUserEditor.OnClose := OnUserEditorClose;
  FUserEditor.Caption := 'Редактирование пользователя';
  FUserEditor.edPk.Text := dsUsersPK.AsString;
  FUserEditor.edLogin.Text := dsUsersLOGIN.AsString;
  FUserEditor.edName.Text := dsUsersNAME.AsString;
  FUserEditor.cbRole.KeyValue := dsUsersROLE_PK.AsVariant;
  FUserEditor.chbIsActive.Checked := dsUsersISACTIVE.AsString = '1';
  FUserEditor.chbDeveloper.Checked := dsUsersDEVELOPER.AsString = '1';
  FUserEditor.chbModerator.Checked := dsUsersMODERATOR.AsString = '1';
  FUserEditor.edCode1s.Text := dsUsersCODE_1C.AsString;
  FUserEditor.edShortName.Text := dsUsersSHORT_NAME.AsString;
  FUserEditor.edEmail.Text := dsUsersEMAIL.AsString;
  FUserEditor.chbHoliday.Checked := dsUsersHOLIDAY.AsString = '1';
  FUserEditor.RegisterForm;
end;

procedure TFUsers.AEditUserUpdate(Sender: TObject);
begin
  // в режиме рид онли форма будет открываться на просмотр
  TAction(Sender).Enabled := dsUsers.Active and (not dsUsers.IsEmpty);

  if (TAction(Sender) = AEditUser) and (Mode = omView) then
  begin
    TAction(Sender).Caption := 'Просмотреть';
    TAction(Sender).Hint := 'Просмотреть данные пользователя';
    TAction(Sender).ImageIndex := 8;
  end;
end;

procedure TFUsers.AExportToCsvExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToCsv(TDBGridEh(ActiveControl), Caption);
end;

procedure TFUsers.AExportToExcelExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToExcel(TDBGridEh(ActiveControl), Caption);
end;

procedure TFUsers.AFilterExecute(Sender: TObject);
begin
  if TAction(Sender) = AFilter then btnApplyFilterClick(btnApplyFilter)
  else btnClearFilterClick(btnClearFilter);
end;

procedure TFUsers.AGridOptionsExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FSettings.GridParamsDialog(TDBGridEh(ActiveControl), ClassName);
end;

procedure TFUsers.ApplyBaseFilter;
var
  s: string;

begin
  if (not dsUsers.Active) then exit;

  if Assigned(dbgUsers.SelectedField) then
    s := dbgUsers.SelectedField.FieldName + ' = ''' + dbgUsers.SelectedField.AsString + '''';
      
  FFilter.Execute(dbgUsers, false, s);
end;

procedure TFUsers.ApplyExtendFilter;
var
  pk: Variant;
  s, where, sqlRank, sqlGroups, sqlRoles, sqlRefers, str: string;
  i: integer;

begin
  dbgUsers.ClearFilter;
  for i := 0 to dbgUsers.Columns.Count - 1 do
  begin
    dbgUsers.Columns[i].STFilter.ExpressionStr := '';
    dbgUsers.Columns[i].Title.Font.Style := FSettings.GridOptions.TitleFont.Style;
    dbgUsers.Columns[i].Title.Font.Color := FSettings.GridOptions.TitleFont.Color;
  end;
  dsUsers.Filter := '';
  dsUsers.Filtered := false;

  s := 'where';
  sqlRank := 'select distinct ur.USER_PK from USER_ROLES ur ' +
    'left join UNIT_STRUCT us on us.PK = ur.ROLE_PK ' +
    'left join SELECT_PARENT_UNIT(us.PK) pus on 1=1 ' +
    'left join UNIT_STRUCT d on d.PK = pus.UNIT_PK ' +
    'left join UNIT_STRUCT o on o.PK = pus.OFFICE_PK ' +
    'left join UNIT_STRUCT c on c.PK = pus.CHAPTER_PK ' +
    'left join UNIT_STRUCT s on s.PK = pus.SECTOR_PK ' +
    'where ';

  if lcbDepartment.Text <> '' then str := 'd.NAME like ''%' + lcbDepartment.Text + '%''';
  if lcbService.Text <> '' then str := iif(str = '', '', str + ' ' + cbConcatStr.Text + ' ') + 'o.NAME like ''%' + lcbService.Text + '%''';
  if lcbDivision.Text <> '' then str := iif(str = '', '', str + ' ' + cbConcatStr.Text + ' ') + 'c.NAME like ''%' + lcbDivision.Text + '%''';
  if lcbSector.Text <> '' then str := iif(str = '', '', str + ' ' + cbConcatStr.Text + ' ') + 's.NAME like ''%' + lcbSector.Text + '%''';
  if lcbRank.Text <> '' then str := iif(str = '', '', str + ' ' + cbConcatStr.Text + ' ') + 'us.NAME like ''%' + lcbRank.Text + '%''';
  if not VarIsNull(edRankPk.Value) then str := iif(str = '', '', str + ' ' + cbConcatStr.Text + ' ') + 'us.PK = ' + edRankPk.Text;
  if not VarIsNull(lcbBranch.KeyValue) then str := iif(str = '', '', str + ' ' + cbConcatStr.Text + ' ') + 'ur.GEO_PK = ' + VarToStr(lcbBranch.KeyValue);
  if chbUserMainRole.Checked and (str <> '') then str := str + ' and ur.MAIN_ROLE = ''1''';

  if str = '' then sqlRank := ''
  else sqlRank := sqlRank + str;

  if lcbGroup.Text <> '' then
    sqlGroups := 'select distinct ug.USER_PK from USERS_USER_GROUPS ug join USER_GROUPS g on g.PK = ug.GROUP_PK where g.NAME = ''' +
      lcbGroup.Text + '''';

  if lcbRole.Text <> '' then
    sqlRoles := 'select distinct u1.PK from USERS u1 join ROLES r on r.PK = u1.ROLE_PK where r.NAME = ''' + lcbRole.Text + '''';

  if (lcbReference.Text <> '') and (not VarIsNull(lcbReference.KeyValue)) then
    sqlRefers := 'select distinct OWNER_USER_PK from DYNAMIC_FORM_REFERENCE where OWNER_USER_PK is not null and DESCRIPTOR_ = ''' +
      VarToStr(lcbReference.KeyValue) + '''';

  if sqlRank <> '' then where := s + ' u.PK in (' + sqlRank + ')';
  if sqlGroups <> '' then where := iif(where = '', s, where + ' ' + cbConcatStr.Text) + ' u.PK in (' + sqlGroups + ')';
  if sqlRoles <> '' then where := iif(where = '', s, where + ' ' + cbConcatStr.Text) + ' u.PK in (' + sqlRoles + ')';
  if sqlRefers <> '' then where := iif(where = '', s, where + ' ' + cbConcatStr.Text) + ' u.PK in (' + sqlRefers + ')';
  if where = '' then where := s + ' u.PK is null';

  pk := Null;
  if dsUsers.Active and (not dsUsers.IsEmpty) and (dsUsers.VisibleRecordCount > 0) then pk := dsUsersPK.AsVariant;

  dsUsers.Close;
  dsUsers.SQLs.SelectSQL.Text := Format(GetUsersSql(chbLoadBoss.Checked), [where]);
  try
    Screen.Cursor := crSQLWait;
    try
      dsUsers.Open;
    finally
      Screen.Cursor := crDefault;
    end;
  except
    dsUsers.Close;
    dsUsers.SQLs.SelectSQL.Text := Format(GetUsersSql(chbLoadBoss.Checked), ['']);
    dsUsers.Open;
  end;

  if not VarIsNull(pk) then dsUsers.Locate('PK', pk, []);

  //if dsUsers.Filter <> '' then dsUsers.Filtered := true;
  StatusBar.Panels[1].Text := 'Пользователей: ' + IntToStr(dsUsers.VisibleRecordCount) + ' / ' + IntToStr(RecCount);
end;

procedure TFUsers.AResetBaseFilterExecute(Sender: TObject);
begin
  ClearBaseFilter;
end;

procedure TFUsers.AResetBaseFilterUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := dsUsers.Active and dsUsers.Filtered;
end;

procedure TFUsers.btnApplyFilterClick(Sender: TObject);
begin
  ApplyExtendFilter;
end;

procedure TFUsers.btnClearFieldsClick(Sender: TObject);
begin
  lcbDepartment.KeyValue := Null;
  lcbService.KeyValue := Null;
  lcbDivision.KeyValue := Null;
  lcbSector.KeyValue := Null;
  lcbRank.KeyValue := Null;
  edRankPk.Value := Null;
  lcbGroup.KeyValue := Null;
  lcbRole.KeyValue := Null;
  lcbReference.KeyValue := Null;
  chbUserMainRole.Checked := false;
end;

procedure TFUsers.btnClearFilterClick(Sender: TObject);
begin
  ClearExtendFilter;
end;

procedure TFUsers.chbLoadBossClick(Sender: TObject);
begin
  AFilterExecute(AClearFilter);
end;

procedure TFUsers.ClearBaseFilter;
var
  i: integer;

begin
  dbgUsers.ClearFilter;
  for i := 0 to dbgUsers.Columns.Count - 1 do
  begin
    dbgUsers.Columns[i].STFilter.ExpressionStr := '';
    dbgUsers.Columns[i].Title.Font.Style := FSettings.GridOptions.TitleFont.Style;
    dbgUsers.Columns[i].Title.Font.Color := FSettings.GridOptions.TitleFont.Color;
  end;
  dsUsers.Filtered := false;
  dsUsers.Filter := '';
end;

procedure TFUsers.ClearExtendFilter;
var
  pk: Variant;

begin
  pk := Null;
  if dsUsers.Active and (not dsUsers.IsEmpty) and (dsUsers.VisibleRecordCount > 0) then pk := dsUsersPK.AsVariant;

  dsUsers.Close;
  dsUsers.SQLs.SelectSQL.Text := Format(GetUsersSql(chbLoadBoss.Checked), ['']);
  Screen.Cursor := crSQLWait;
  try
    dsUsers.Open;
    RecCount := dsUsers.RecordCount;
  finally
    Screen.Cursor := crDefault;
  end;

  if not VarIsNull(pk) then dsUsers.Locate('PK', pk, []);

  {dsUsers.Filtered := false;
  dsUsers.Filter := '';
  DBGridApplyFilter(dbgUsers);}
end;

procedure TFUsers.DBGridApplyFilter(Sender: TObject);
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

  StatusBar.Panels[1].Text := 'Пользователей: ' + IntToStr(dsUsers.VisibleRecordCount) + ' / ' + IntToStr(RecCount);
end;

procedure TFUsers.DBGridFillSTFilterListValues(Sender: TCustomDBGridEh; Column: TColumnEh; Items: TStrings; var Processed: Boolean);
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

procedure TFUsers.dbgUserRanksKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F3: Find(TDBGridEh(Sender), true);
    else
      if (ssCtrl in Shift) and ((Key = Ord('F')) or (Key = Ord('f')) or (Key = Ord('А')) or (Key = Ord('а'))) then
        Find(TDBGridEh(Sender));
  end;
end;

procedure TFUsers.dbgUsersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then AAddUserExecute(AAddUser);
    VK_RETURN: if ssShift in Shift then AEditUserExecute(AEditUser);
    VK_F3: Find(TDBGridEh(Sender), true);
    else
      if (ssCtrl in Shift) and ((Key = Ord('F')) or (Key = Ord('f')) or (Key = Ord('А')) or (Key = Ord('а'))) then
        Find(TDBGridEh(Sender));
  end;
end;

procedure TFUsers.dsUsersAfterClose(DataSet: TDataSet);
begin
  dsUserGroups.Close;
  dsUserRanks.Close;
  dsUserRefGrant.Close;
  if mtUserRefGrant.Active then mtUserRefGrant.EmptyTable;
  mtUserRefGrant.Close;
end;

procedure TFUsers.dsUsersAfterOpen(DataSet: TDataSet);
begin
  StatusBar.Panels[1].Text := 'Пользователей: ' + IntToStr(dsUsers.VisibleRecordCount) + ' / ' + IntToStr(dsUsers.RecordCount);
end;

procedure TFUsers.dsUsersEndScroll(DataSet: TDataSet);
var
  i: integer;

begin
  dsUserGroups.Close;
  dsUserRanks.Close;
  dsUserRefGrant.Close;
  if mtUserRefGrant.Active then mtUserRefGrant.EmptyTable;
  mtUserRefGrant.Close;

  if dsUsers.IsEmpty then exit;
  
  try
    dsUserGroups.ParamByName('USER_PK').Value := dsUsersPK.AsVariant;
    dsUserGroups.Open;
  except
  end;

  try
    dsUserRanks.ParamByName('USER_PK').Value := dsUsersPK.AsVariant;
    dsUserRanks.Open;
  except
  end;

  try
    dsUserRefGrant.ParamByName('USER_PK').Value := dsUsersPK.AsVariant;
    dsUserRefGrant.Open;
    mtUserRefGrant.CreateDataSet;

    dsUserRefGrant.First;
    while not dsUserRefGrant.Eof do
    begin
      mtUserRefGrant.Append;
      for i := 0 to mtUserRefGrant.FieldCount - 1 do
        mtUserRefGrant.Fields.Fields[i].Value := dsUserRefGrant.FieldByName(mtUserRefGrant.Fields.Fields[i].FieldName).Value;
      mtUserRefGrant.Post;
      dsUserRefGrant.Next;
    end;
    mtUserRefGrant.First;
  except
  end;
end;

procedure TFUsers.Find(Grid: TDBGridEh; AContinue: boolean);
var
  FindOptions: TFindOptions;
  col: TColumnEh;
  defCol: string;

begin
  if (not Assigned(Grid)) then exit;

  if (not AContinue) or (DBFindDialog.cbFindText.Text = '') then
  begin
    // если новый, то показать диалог
    if Assigned(Grid.SelectedField) then col := Grid.FindFieldColumn(Grid.SelectedField.FieldName);
    if Assigned(col) then defCol := col.Title.Caption;
    if DBFindDialog.ShowDialog(Grid, defCol) <> mrOk then exit;
  end;

  FindOptions := [];
  if DBFindDialog.chbMatchCase.Checked then FindOptions := [foMatchCase];
  if DBFindDialog.chbToExistence.Checked then FindOptions := FindOptions + [foToExistence];
  if DBFindDialog.rbWholeString.Checked then FindOptions := FindOptions + [foWholeString];
  if DBFindDialog.rbAnyWord.Checked then FindOptions := FindOptions + [foAnyWord];
  if DBFindDialog.rbAllWords.Checked then FindOptions := FindOptions + [foAllWords];

  FindInGrid(Grid, DBFindDialog.cbFindText.Text, DBFindDialog.SelectedField, FindOptions, AContinue);
end;

procedure TFUsers.FormActivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, true);
  FMain.CheckFormButton(Tag);
end;

procedure TFUsers.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FSettings.ChildMaximized := WindowState = wsMaximized;
end;

procedure TFUsers.FormCreate(Sender: TObject);
begin
  FFilter := TfFilter.Create(Self);
end;

procedure TFUsers.FormDeactivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, false);
end;

procedure TFUsers.FormDestroy(Sender: TObject);
begin
  FFilter.Free;
end;

procedure TFUsers.FormShow(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  try
    dsUsers.SQLs.SelectSQL.Text := Format(GetUsersSql(chbLoadBoss.Checked), ['']);
    dsUsers.Open;
    RecCount := dsUsers.RecordCount;
    // лукапы фильтров
    dsBranch.Open;
    dsDepartment.Open;
    dsService.Open;
    dsDivision.Open;
    dsSector.Open;
    dsRank.Open;
    dsGroup.Open;
    dsRole.Open;
    dsReference.Open;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TFUsers.GetUsersSql(ShowBoss: boolean): string;
const
  UsersBossSQL = 'select distinct u.PK, u.LOGIN, u.NAME, u.ISACTIVE, u.ROLE_PK, r.NAME ROLE_NAME, u.DEVELOPER, u.MODERATOR, ' +
    'u.CODE_1C, u.EMAIL, u.SHORT_NAME, u.LASTDATE, c.NAME ATTR_NAME, u.HOLIDAY, m.NAME MANAGER, b.NAME BOSS, du.NAME DEP_DIRECTOR ' +
    'from USERS u ' +
    'left join ROLES r on r.PK = u.ROLE_PK ' +
    'left join CR_ATTR c on c.PK = u.ACTIVEREASON ' +
    'left join GET_MANAGER(u.PK, null) m on 1=1 ' +
    'left join ISBOSS(u.PK) b on 1=1 ' +
    'left join GET_DIRECTOR_DEPARTAMENT(u.PK) d on 1=1 ' +
    'left join USERS du on du.PK = d.USER_BOSS ' +
    '%s'#13#10 +
    'order by u.NAME';

  UsersNoBossSQL = 'select distinct u.PK, u.LOGIN, u.NAME, u.ISACTIVE, u.ROLE_PK, r.NAME ROLE_NAME, u.DEVELOPER, u.MODERATOR, ' +
    'u.CODE_1C, u.EMAIL, u.SHORT_NAME, u.LASTDATE, c.NAME ATTR_NAME, u.HOLIDAY, null MANAGER, null BOSS, null DEP_DIRECTOR ' +
    'from USERS u ' +
    'left join ROLES r on r.PK = u.ROLE_PK ' +
    'left join CR_ATTR c on c.PK = u.ACTIVEREASON ' +
    '%s'#13#10 +
    'order by u.NAME';

begin
  if ShowBoss then result := UsersBossSQL
  else result := UsersNoBossSQL;
end;

procedure TFUsers.OnUserEditorClose(Sender: TObject; var Action: TCloseAction);
var
  sql, err, s: string;

begin
  Action := caFree;

  if TFUserEditor(Sender).Success then
  begin
    // проверки
    if Trim(TFUserEditor(Sender).edLogin.Text) = '' then s := 'Логин';
    if Trim(TFUserEditor(Sender).edName.Text) = '' then
    begin
      if s = '' then s := 'ФИО'
      else s := s + ', ФИО';
    end;

    if s <> '' then
    begin
      Application.MessageBox(pchar('Не заполнены обязательные поля: ' + s), 'Ошибка', MB_OK + MB_ICONERROR);
      TFUserEditor(Sender).Success := false;
      Action := caNone;
      exit;
    end;

    // сохраняем изменения
    sql := '';
    case TFUserEditor(Sender).Mode of
      omAdd: sql := 'insert into USERS (PK, LOGIN, NAME, EMAIL, DEVELOPER, MODERATOR, ISACTIVE, HOLIDAY, CODE_1C, SHORT_NAME) ' +
        'values (' + iif(Trim(TFUserEditor(Sender).edPk.Text) = '', 'null', Trim(TFUserEditor(Sender).edPk.Text)) + ', ''' +
        Trim(TFUserEditor(Sender).edLogin.Text) + ''', ''' + Trim(TFUserEditor(Sender).edName.Text) + ''', ' +
        iif(TFUserEditor(Sender).edEmail.Text = '', 'null', '''' + TFUserEditor(Sender).edEmail.Text + '''') + ', ''' +
        iif(TFUserEditor(Sender).chbDeveloper.Checked, '1', '0') + ''', ''' + iif(TFUserEditor(Sender).chbModerator.Checked, '1', '0') +
        ''', ''' + iif(TFUserEditor(Sender).chbIsActive.Checked, '1', '0') + ''', ''' + iif(TFUserEditor(Sender).chbHoliday.Checked, '1', '0') +
        ''', ' + iif(TFUserEditor(Sender).edCode1s.Text = '', 'null', '''' + TFUserEditor(Sender).edCode1s.Text + '''') + ', ' +
        iif(TFUserEditor(Sender).edShortName.Text = '', 'null', '''' + TFUserEditor(Sender).edShortName.Text + '''') + ')';
      omEdit: sql := 'update USERS set ' + iif(VarToStr(TFUserEditor(Sender).Properties.PK) <> Trim(TFUserEditor(Sender).edPk.Text),
        'PK = ' + Trim(TFUserEditor(Sender).edPk.Text) + ', ', '') + 'LOGIN = ''' + Trim(TFUserEditor(Sender).edLogin.Text) +
        ''', NAME = ''' + Trim(TFUserEditor(Sender).edName.Text) + ''', ROLE_PK = ' +
        iif(VarIsNull(TFUserEditor(Sender).cbRole.KeyValue), 'null', VarToStr(TFUserEditor(Sender).cbRole.KeyValue)) + ', EMAIL = ' +
        iif(TFUserEditor(Sender).edEmail.Text = '', 'null', '''' + TFUserEditor(Sender).edEmail.Text + '''') + ', DEVELOPER = ''' +
        iif(TFUserEditor(Sender).chbDeveloper.Checked, '1', '0') + ''', MODERATOR = ''' + iif(TFUserEditor(Sender).chbModerator.Checked, '1', '0') +
        ''', ISACTIVE = ''' + iif(TFUserEditor(Sender).chbIsActive.Checked, '1', '0') + ''', HOLIDAY = ''' +
        iif(TFUserEditor(Sender).chbHoliday.Checked, '1', '0') + ''', CODE_1C = ' + iif(TFUserEditor(Sender).edCode1s.Text = '', 'null', '''' +
        TFUserEditor(Sender).edCode1s.Text + '''') + ', SHORT_NAME = ' + iif(TFUserEditor(Sender).edShortName.Text = '', 'null', '''' +
        TFUserEditor(Sender).edShortName.Text + '''') + ' where PK = ' + VarToStr(TFUserEditor(Sender).Properties.PK);
      else exit;
    end;

    if not FMain.ExecSQL(sql, err) then
      Application.MessageBox(pchar('Ошибка ' + VarToStr(iif(TFUserEditor(Sender).Mode = omAdd, 'добавления', 'изменения')) +
        ' пользователя.'#13#10 + err), 'Ошибка', MB_OK + MB_ICONERROR)
    else
      AFilterExecute(AClearFilter);
  end;
end;

procedure TFUsers.SetMode(Value: TOpenMode);
begin
  if Value = omAdd then Value := omEdit;
  inherited SetMode(Value);

  case FMode of
    omAdd, omEdit:
    begin
      //dbgUserGroups.AllowedOperations := [alopUpdateEh, alopDeleteEh, alopInsertEh, alopAppendEh];
      StatusBar.Panels[0].Text := 'Read/Write';
    end;
    omView:
    begin
      //dbgUserGroups.AllowedOperations := [];
      StatusBar.Panels[0].Text := 'Read Only';
    end;
  end;
end;

end.
