unit groups;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, utils, settings, childForm, main,
  ActnList, ToolWin, ComCtrls, DBGridEhGrouping, GridsEh, DBGridEh, DB, FIBDataSet, pFIBDataSet, ExtCtrls, Menus;

type
  TFGroups = class(TChildForm)
    ActionList: TActionList;
    AClose: TAction;
    AGridOptions: TAction;
    ToolBar: TToolBar;
    AAddGroup: TAction;
    ToolButton1: TToolButton;
    dbgUserGroups: TDBGridEh;
    ADelGroup: TAction;
    ToolButton3: TToolButton;
    dsGroups: TpFIBDataSet;
    dsGroupsPK: TFIBIntegerField;
    dsGroupsNAME: TFIBStringField;
    dsoGroups: TDataSource;
    dsGroupUsers: TpFIBDataSet;
    dsoGroupUsers: TDataSource;
    Splitter1: TSplitter;
    pmGrid: TPopupMenu;
    MenuItem1: TMenuItem;
    ToolButton4: TToolButton;
    ACommitChanges: TAction;
    ARollbackChanges: TAction;
    ARefresh: TAction;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    dbgUsers: TDBGridEh;
    dsGroupUsersPK: TFIBIntegerField;
    dsGroupUsersLOGIN: TFIBStringField;
    dsGroupUsersNAME: TFIBStringField;
    dsGroupUsersISACTIVE: TFIBStringField;
    dsGroupUsersROLE_PK: TFIBIntegerField;
    dsGroupUsersROLE_NAME: TFIBStringField;
    dsGroupUsersDEVELOPER: TFIBStringField;
    dsGroupUsersMODERATOR: TFIBStringField;
    ALinkUser: TAction;
    AUnlinkUser: TAction;
    dsGroupUsersGROUP_PK: TFIBIntegerField;
    ToolButton2: TToolButton;
    ToolButton9: TToolButton;
    StatusBar: TStatusBar;
    AExportToExcel: TAction;
    AExportToCsv: TAction;
    Excel1: TMenuItem;
    csv1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure ACloseExecute(Sender: TObject);
    procedure AGridOptionsExecute(Sender: TObject);
    procedure AAddGroupExecute(Sender: TObject);
    procedure ADelGroupExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ACommitChangesExecute(Sender: TObject);
    procedure ARollbackChangesExecute(Sender: TObject);
    procedure ARefreshExecute(Sender: TObject);
    procedure ADelGroupUpdate(Sender: TObject);
    procedure ACommitChangesUpdate(Sender: TObject);
    procedure dsGroupsEndScroll(DataSet: TDataSet);
    procedure dsGroupsAfterClose(DataSet: TDataSet);
    procedure ALinkUserExecute(Sender: TObject);
    procedure AUnlinkUserExecute(Sender: TObject);
    procedure AUnlinkUserUpdate(Sender: TObject);
    procedure AAddGroupUpdate(Sender: TObject);
    procedure AExportToExcelExecute(Sender: TObject);
    procedure AExportToCsvExecute(Sender: TObject);
  private
    procedure SetMode(Value: TOpenMode); override;
  public
  end;

implementation

{$R *.dfm}

procedure TFGroups.AAddGroupExecute(Sender: TObject);
begin
  if Mode <> omEdit then exit;
  dsGroups.Insert;
end;

procedure TFGroups.AAddGroupUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := dsGroups.Active and (Mode = omEdit);
end;

procedure TFGroups.ACloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFGroups.ACommitChangesExecute(Sender: TObject);
begin
  if Mode <> omEdit then exit;
  if Application.MessageBox('Подтвердить транзакцию?', 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

  FMain.Transact.CommitRetaining;
  dsGroups.ReopenLocate('PK');
  dsGroupsEndScroll(dsGroups);
end;

procedure TFGroups.ACommitChangesUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := dsGroups.HasUncommitedChanges and (Mode = omEdit);
end;

procedure TFGroups.ADelGroupExecute(Sender: TObject);
begin
  if Mode <> omEdit then exit;
  if Application.MessageBox(pchar('Удалить группу "' + dsGroupsNAME.AsString + '"?'), 'Подтверждение',
    MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

  dsGroups.Delete;
end;

procedure TFGroups.ADelGroupUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := dsGroups.Active and (not dsGroups.IsEmpty) and (Mode = omEdit);
end;

procedure TFGroups.AExportToCsvExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToCsv(TDBGridEh(ActiveControl), Caption);
end;

procedure TFGroups.AExportToExcelExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToExcel(TDBGridEh(ActiveControl), Caption);
end;

procedure TFGroups.AGridOptionsExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FSettings.GridParamsDialog(TDBGridEh(ActiveControl), ClassName);
end;

procedure TFGroups.ALinkUserExecute(Sender: TObject);
var
  err: string;
  res: boolean;
  pk: Variant;

begin
  if Mode <> omEdit then exit;
  if (not dsGroups.Active) or dsGroups.IsEmpty then exit;

  if not FMain.SelUserDialog(pk, 'select u.PK, u.LOGIN, u.NAME from USERS u where (u.ISACTIVE = ''1'') order by u.NAME') then exit;

  if VarIsNull(pk) then
  begin
    res := false;
    err := 'Не выбран пользователь!';
  end else
  begin
    res := FMain.ExecSQL('insert into USERS_USER_GROUPS (GROUP_PK, USER_PK) values (' + dsGroupsPK.AsString + ', ' + VarToStr(pk) + ')', err);
    if res then dsGroupsEndScroll(dsGroups);
  end;

  if not res then Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFGroups.ARefreshExecute(Sender: TObject);
begin
  dsGroups.ReopenLocate('PK');
  dsGroupsEndScroll(dsGroups);
end;

procedure TFGroups.ARollbackChangesExecute(Sender: TObject);
begin
  if Mode <> omEdit then exit;
  if Application.MessageBox('Откатить транзакцию?', 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

  FMain.Transact.RollbackRetaining;
  dsGroups.ReopenLocate('PK');
  dsGroupsEndScroll(dsGroups);
end;

procedure TFGroups.AUnlinkUserExecute(Sender: TObject);
var
  err: string;

begin
  if Mode <> omEdit then exit;
  if (not dsGroupUsers.Active) or dsGroupUsers.IsEmpty then exit;

  if Application.MessageBox(pchar('Отвязать пользователя "' + dsGroupUsersNAME.AsString + '" от группы "' + dsGroupsNAME.AsString + '"?'),
    'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

  if FMain.ExecSQL('delete from USERS_USER_GROUPS where GROUP_PK = ' + dsGroupUsersGROUP_PK.AsString + ' and USER_PK = ' +
    dsGroupUsersPK.AsString, err) then dsGroupsEndScroll(dsGroups)
  else
    Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFGroups.AUnlinkUserUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := dsGroupUsers.Active and (not dsGroupUsers.IsEmpty) and (Mode = omEdit);
end;

procedure TFGroups.dsGroupsAfterClose(DataSet: TDataSet);
begin
  dsGroupUsers.Close;
end;

procedure TFGroups.dsGroupsEndScroll(DataSet: TDataSet);
begin
  try
    dsGroupUsers.Close;
    if dsGroups.IsEmpty then exit;
    dsGroupUsers.ParamByName('PK').Value := dsGroupsPK.AsVariant;
    dsGroupUsers.Open;
  except

  end;
end;

procedure TFGroups.FormActivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, true);
  FMain.CheckFormButton(Tag);
end;

procedure TFGroups.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FSettings.ChildMaximized := WindowState = wsMaximized;
end;

procedure TFGroups.FormDeactivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, false);
end;

procedure TFGroups.FormShow(Sender: TObject);
begin
  Screen.Cursor := crSQLWait;
  try
    dsGroups.Open;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFGroups.SetMode(Value: TOpenMode);
begin
  if Value = omAdd then Value := omEdit;
  inherited SetMode(Value);

  case FMode of
    omAdd, omEdit:
    begin
      dbgUserGroups.AllowedOperations := [alopUpdateEh, alopDeleteEh, alopInsertEh, alopAppendEh];
      StatusBar.Panels[0].Text := 'Read/Write';
    end;
    omView:
    begin
      dbgUserGroups.AllowedOperations := [];
      StatusBar.Panels[0].Text := 'Read Only';
    end;
  end;
end;

end.
