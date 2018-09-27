unit task;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, utils, settings, childForm, main,
  ActnList, ToolWin, ComCtrls, DBGridEhGrouping, GridsEh, DBGridEh, DB, FIBDataSet, pFIBDataSet, ExtCtrls, Menus,
  StdCtrls, JvExStdCtrls, JvRichEdit, JvDBRichEdit, ImgList, filter, groupedit, EhLibFIB, MemTableDataEh, MemTableEh,
  Buttons, FIBQuery, pFIBQuery, dbFind;

type
  TFTask = class(TChildForm)
    ActionList: TActionList;
    AClose: TAction;
    AGridOptions: TAction;
    ToolBar: TToolBar;
    AAdd: TAction;
    ToolButton1: TToolButton;
    dbgTask: TDBGridEh;
    ADel: TAction;
    ToolButton3: TToolButton;
    dsTask: TpFIBDataSet;
    dsoTask: TDataSource;
    Splitter1: TSplitter;
    pmGrid: TPopupMenu;
    MenuItem1: TMenuItem;
    ToolButton4: TToolButton;
    ARefresh: TAction;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    dsTaskPK: TFIBIntegerField;
    dsTaskNAME: TFIBStringField;
    dsTaskDESCR: TFIBMemoField;
    dsTaskSTATUS: TFIBStringField;
    dsTaskDEADLINE: TFIBDateTimeField;
    dsTaskPROJECT: TFIBStringField;
    dsTaskTASK_NO: TFIBIntegerField;
    dsTaskDF_OBJECT: TFIBStringField;
    dsTaskDATE_ADD: TFIBDateTimeField;
    dsTaskUSER_PK: TFIBIntegerField;
    Panel1: TPanel;
    Label1: TLabel;
    reTaskDescr: TJvDBRichEdit;
    ilTaskStatus: TImageList;
    dsTaskUSER_NAME: TFIBStringField;
    AFilter: TAction;
    AResetFilter: TAction;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    AGroupEdit: TAction;
    ToolButton11: TToolButton;
    chbShowClosed: TCheckBox;
    dsTaskST: TStringField;
    sbSaveDescr: TSpeedButton;
    ASaveDescr: TAction;
    dsTaskPRIORITY: TFIBIntegerField;
    dsTaskTYPE_: TFIBIntegerField;
    StatusBar: TStatusBar;
    ToolButton2: TToolButton;
    ToolButton5: TToolButton;
    dsTaskDATE_END: TFIBDateTimeField;
    dsFindTask: TpFIBDataSet;
    dsFindTaskPK: TFIBIntegerField;
    qAddTask: TpFIBQuery;
    dsFindTaskSTATUS: TFIBStringField;
    qEditTaskDeadline: TpFIBQuery;
    AExportToExcel: TAction;
    AExportToCsv: TAction;
    Excel1: TMenuItem;
    csv1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure ACloseExecute(Sender: TObject);
    procedure AGridOptionsExecute(Sender: TObject);
    procedure AAddExecute(Sender: TObject);
    procedure ADelExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ARefreshExecute(Sender: TObject);
    procedure ADelUpdate(Sender: TObject);
    procedure AAddUpdate(Sender: TObject);
    procedure AFilterExecute(Sender: TObject);
    procedure AResetFilterExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AGroupEditExecute(Sender: TObject);
    procedure chbShowClosedClick(Sender: TObject);
    procedure dsTaskCalcFields(DataSet: TDataSet);
    procedure dsTaskAfterInsert(DataSet: TDataSet);
    procedure ASaveDescrUpdate(Sender: TObject);
    procedure ASaveDescrExecute(Sender: TObject);
    procedure dbgTaskFillSTFilterListValues(Sender: TCustomDBGridEh; Column: TColumnEh; Items: TStrings;
      var Processed: Boolean);
    procedure dbgTaskApplyFilter(Sender: TObject);
    procedure dbgTaskGetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure dbgTaskKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dsTaskAfterPost(DataSet: TDataSet);
    procedure AResetFilterUpdate(Sender: TObject);
    procedure AExportToExcelExecute(Sender: TObject);
    procedure AExportToCsvExecute(Sender: TObject);
  private
    FFilter: TfFilter;
    procedure Connect;
    procedure LoadData(ShowAll: boolean);
    procedure ImportNewTask;
    procedure SetMode(Value: TOpenMode); override;
    procedure ApplyFilter;
    procedure ClearFilter;
    procedure GroupEdit(Grid: TDBGridEh);
    procedure LoadStatistic;
    procedure Find(Grid: TDBGridEh; AContinue: boolean = false);
  public
  end;

implementation

{$R *.dfm}

procedure TFTask.AAddExecute(Sender: TObject);
begin
  if Mode <> omEdit then exit;
  dsTask.Append;
end;

procedure TFTask.AAddUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := dsTask.Active and (Mode = omEdit);
end;

procedure TFTask.ACloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFTask.ADelExecute(Sender: TObject);
begin
  if Mode <> omEdit then exit;

  if dbgTask.SelectedRows.Count > 1 then
  begin
    if Application.MessageBox(pchar('Удалить все отмеченные задачи (' + IntToStr(dbgTask.SelectedRows.Count) + ')?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    dbgTask.SelectedRows.Delete;
    FMain.TransTask.CommitRetaining;
  end else
  begin
    if Application.MessageBox(pchar('Удалить задачу "' + dsTaskNAME.AsString + '"?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    dsTask.Delete;
    FMain.TransTask.CommitRetaining;
  end;
end;

procedure TFTask.ADelUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := dsTask.Active and (not dsTask.IsEmpty) and (Mode = omEdit);
end;

procedure TFTask.AExportToCsvExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToCsv(TDBGridEh(ActiveControl), Caption);
end;

procedure TFTask.AExportToExcelExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToExcel(TDBGridEh(ActiveControl), Caption);
end;

procedure TFTask.AFilterExecute(Sender: TObject);
begin
  ApplyFilter;
end;

procedure TFTask.AGridOptionsExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FSettings.GridParamsDialog(TDBGridEh(ActiveControl), ClassName);
end;

procedure TFTask.AGroupEditExecute(Sender: TObject);
begin
  if Mode <> omEdit then exit;
  if dbgTask.SelectedRows.Count > 0 then GroupEdit(dbgTask);
end;

procedure TFTask.ApplyFilter;
var
  s: string;

begin
  if (not dsTask.Active) then exit;

  if Assigned(dbgTask.SelectedField) then
    s := dbgTask.SelectedField.FieldName + ' = ''' + dbgTask.SelectedField.AsString + '''';

  FFilter.Execute(dbgTask, false, s);
end;

procedure TFTask.ARefreshExecute(Sender: TObject);
begin
  ImportNewTask;
  LoadData(chbShowClosed.Checked);
end;

procedure TFTask.AResetFilterExecute(Sender: TObject);
begin
  ClearFilter;
end;

procedure TFTask.AResetFilterUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := dsTask.Active and dsTask.Filtered;
end;

procedure TFTask.ASaveDescrExecute(Sender: TObject);
begin
  if (not dsTask.Active) or dsTask.IsEmpty or (Mode <> omEdit) or (not (dsTask.State in [dsEdit, dsInsert])) then exit;
  dsTask.Post;
end;

procedure TFTask.ASaveDescrUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := dsTask.Active and (not dsTask.IsEmpty) and (Mode = omEdit) and
    (dsTask.State in [dsEdit, dsInsert]);
end;

procedure TFTask.chbShowClosedClick(Sender: TObject);
begin
  LoadData(chbShowClosed.Checked);
end;

procedure TFTask.ClearFilter;
var
  i: integer;

begin
  dbgTask.ClearFilter;
  for i := 0 to dbgTask.Columns.Count - 1 do
  begin
    dbgTask.Columns[i].STFilter.ExpressionStr := '';
    dbgTask.Columns[i].Title.Font.Style := FSettings.GridOptions.TitleFont.Style;
    dbgTask.Columns[i].Title.Font.Color := FSettings.GridOptions.TitleFont.Color;
  end;
  dsTask.Filtered := false;
  dsTask.Filter := '';
end;

procedure TFTask.Connect;
var
  s, err: string;
  c: TConnection;
  ds: TpFIBDataSet;

begin
  if FMain.DBTask.Connected then FMain.DBTask.Close;

  Screen.Cursor := crSQLWait;
  try
    c := FSettings.ConnByIndex[FSettings.ShedulerConnect];

    if (c.DataBase = '') then
    begin
      Application.MessageBox('Внимание! Подключение к БД не настроено.', 'Предупреждение', MB_OK + MB_ICONWARNING);
      exit;
    end;

    if (c.Server <> stFirebird) then
    begin
      Application.MessageBox('Внимание! Подключение к БД задано неверно. Возможна работа только с серверами Firebird.',
        'Предупреждение', MB_OK + MB_ICONWARNING);
      exit;
    end;

    if c.Host <> '' then
    begin
      if c.Port = 3050 then s := c.Host
      else s := c.Host + '/' + IntToStr(c.Port);
      s := s + ':';
    end;
    
    FMain.DBTask.DBName := s + c.DataBase;
    FMain.DBTask.ConnectParams.UserName := c.UserName;
    FMain.DBTask.ConnectParams.Password := c.Pass;
    FMain.DBTask.ConnectParams.RoleName := c.Role;
    FMain.DBTask.ConnectParams.CharSet := c.Encoding;
    FMain.DBTask.SQLDialect := c.SQLDialect;

    try
      FMain.DBTask.Open;
      // проверим, что мы в подходящей БД
      try
        ds := TpFIBDataSet.Create(Self);
        ds.Database := FMain.DBTask;
        ds.SQLs.SelectSQL.Text := 'select count(*) from RDB$RELATIONS where RDB$RELATION_NAME = ''DCFG_TASK'' and RDB$RELATION_TYPE = 0';
        ds.Open;
        if (not ds.Active) or ds.IsEmpty or ds.Fields.Fields[0].Value = 0 then
        begin
          FMain.DBTask.Close;
          raise Exception.Create('Подключение "' + c.Alias + '" не поддерживает работу планировщика задач!');
        end;
      finally
        ds.Close;
        ds.Free;
      end;
    except
      on e: Exception do
      begin
        if Pos('user name and password', e.Message) > 0 then err := ProhibMes[0]
        else if Pos('I/O error', e.Message) > 0 then err := Format(ProhibMes[1], [FMain.DBTask.DBName])
        else if Pos('network request', e.Message) > 0 then err := Format(ProhibMes[2], [ExtractWordEx(1, FMain.DBTask.DBName, [':'], [])])
        else if (Pos('SQL error', e.Message) > 0) or (Pos('Parameter', e.Message) > 0) then err := Format(ProhibMes[3], [e.Message])
        else err := Format(ProhibMes[3], [e.Message]);

        Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFTask.dbgTaskApplyFilter(Sender: TObject);
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

procedure TFTask.dbgTaskFillSTFilterListValues(Sender: TCustomDBGridEh; Column: TColumnEh; Items: TStrings;
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

procedure TFTask.dbgTaskGetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
begin
  if (dsTask.VisibleRecordCount = 0) or (dsTaskSTATUS.AsString = '2') or (dsTaskSTATUS.AsString = '3') then exit;
  
  case dsTaskPRIORITY.AsInteger of
    -4: Background := RGB(255, 170, 170);
    -3: Background := RGB(255, 195, 165);
    -2: Background := RGB(253, 219, 168);
    -1: Background := RGB(255, 255, 190);
    0: Background := {FSettings.GridOptions.RowColor;} RGB(170, 255, 170);
    1: Background := RGB(190, 255, 255);
    2: Background := RGB(205, 205, 255);
    3: Background := RGB(208, 208, 232);
    4: Background := RGB(215, 215, 215);
    {else Background := clWindow}//;
  end;

  case dsTaskSTATUS.AsInteger of
    0: AFont.Color := clWindowText;
    1: AFont.Color := clGreen;
    2: AFont.Color := clNavy;
    3: AFont.Color := clMaroon;
    4: AFont.Color := RGB(100, 100, 100);
    5: AFont.Color := clPurple;
    6: AFont.Color := clTeal;
    else AFont.Color := clWindowText;
  end;
end;

procedure TFTask.dbgTaskKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_DELETE: if (ssCtrl in Shift) and ADel.Enabled then ADelExecute(ADel);
    VK_INSERT: if AAdd.Enabled then AAddExecute(AAdd);
    VK_F3: Find(TDBGridEh(Sender), true);
    else begin
      if (ssCtrl in Shift) and ((Key = Ord('F')) or (Key = Ord('f')) or (Key = Ord('А')) or (Key = Ord('а'))) then
        Find(TDBGridEh(Sender));
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
    end;
  end;
end;

procedure TFTask.dsTaskAfterInsert(DataSet: TDataSet);
begin
  dsTaskUSER_PK.AsVariant := FMain.dsPortalUserPK.AsVariant;
  if dsTaskSTATUS.IsNull then dsTaskSTATUS.AsString := '0';
end;

procedure TFTask.dsTaskAfterPost(DataSet: TDataSet);
begin
  FMain.TransTask.CommitRetaining;
  LoadData(chbShowClosed.Checked);
end;

procedure TFTask.dsTaskCalcFields(DataSet: TDataSet);
begin
  dsTaskST.AsString := dsTaskSTATUS.AsString;
end;

procedure TFTask.Find(Grid: TDBGridEh; AContinue: boolean);
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

procedure TFTask.FormActivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, true);
  FMain.CheckFormButton(Tag);
end;

procedure TFTask.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (dsTask.State in [dsEdit, dsInsert]) then
  begin
    case Application.MessageBox('Есть несохраненные изменения! Сохранить?', 'Предупреждение', MB_YESNOCANCEL + MB_ICONQUESTION) of
      ID_YES:
      begin
        if (dsTask.State in [dsEdit, dsInsert]) then dsTask.Post;
      end;
      ID_NO:
      begin
        if (dsTask.State in [dsEdit, dsInsert]) then dsTask.Cancel;
      end;
      ID_CANCEL:
      begin
        Action := caNone;
        exit;
      end;
    end;
  end;

  Action := caFree;
  FSettings.FShedulerPHeight := Panel1.Height;
  FSettings.ChildMaximized := WindowState = wsMaximized;
end;

procedure TFTask.FormCreate(Sender: TObject);
begin
  FFilter := TfFilter.Create(Self);
  chbShowClosed.Checked := FSettings.FShedulerShowClosed;
  LoadStatistic;
  Connect;
end;

procedure TFTask.FormDeactivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, false);
end;

procedure TFTask.FormDestroy(Sender: TObject);
begin
  FSettings.FShedulerShowClosed := chbShowClosed.Checked;
  FFilter.Free;
  dsTask.Close;
  FMain.DBTask.Close;
end;

procedure TFTask.FormShow(Sender: TObject);
begin
  Panel1.Height := FSettings.FShedulerPHeight;
  if Panel1.Height < 1 then Panel1.Height := 200;
  ImportNewTask;
  LoadData(chbShowClosed.Checked);
end;

procedure TFTask.GroupEdit(Grid: TDBGridEh);
var
  fGrEdit: TFGroupEdit;
  i, j: integer;
  data: TStringList;
  bm: TBookmark;
  DataSet: TMemTableEh;

begin
  if (not Assigned(Grid)) or (not Assigned(Grid.DataSource)) or (not Assigned(Grid.DataSource.DataSet)) then exit;
  DataSet := TMemTableEh(Grid.DataSource.DataSet);

  if (not DataSet.Active) or DataSet.IsEmpty then exit;
  if Grid.SelectedRows.Count < 1 then exit;

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

procedure TFTask.ImportNewTask;
var
  ds: TpFIBDataSet;

begin
  try
    ds := FMain.OpenSQL('select cr.PK, cr.I_PK, p.NAME PROJECT_NAME, cr.CRNAME, cr.DESCRIPTION, w.DEADLINE from CR cr ' +
      'left join PROJECTS p on p.PK = cr.NEW_PROJECT ' +
      'left join I_RQ_WORK w on w.PK = cr.I_PK ' +
      'where cr.INITIATOR <> ' + FMain.dsPortalUserPK.AsString + ' and cr.EXECUTOR = ' + FMain.dsPortalUserPK.AsString +
      ' and cr.STATUS = 0');

    if (not Assigned(ds)) or (not ds.Active) then exit;

    ds.First;
    while not ds.Eof do
    begin
      dsFindTask.Close;
      dsFindTask.ParamByName('USER_PK').Value := FMain.dsPortalUserPK.AsVariant;
      dsFindTask.ParamByName('ID1').Value := ds.FieldByName('PK').AsVariant;
      dsFindTask.ParamByName('ID2').Value := ds.FieldByName('I_PK').AsVariant;

      try
        dsFindTask.Open;
      except
        ds.Next;
        continue;
      end;

      if dsFindTask.IsEmpty then
      begin
        qAddTask.ParamByName('USER_PK').Value := FMain.dsPortalUserPK.AsVariant;
        qAddTask.ParamByName('NAME').Value := ds.FieldByName('CRNAME').Value;
        qAddTask.ParamByName('DESCR').Value := ds.FieldByName('DESCRIPTION').Value;
        qAddTask.ParamByName('STATUS').Value := '0';
        qAddTask.ParamByName('PRIORITY').Value := -4;
        qAddTask.ParamByName('TYPE_').Value := 2;
        qAddTask.ParamByName('DEADLINE').Value := ds.FieldByName('DEADLINE').Value;
        qAddTask.ParamByName('PROJECT').Value := ds.FieldByName('PROJECT_NAME').Value;
        if ds.FieldByName('I_PK').IsNull then
          qAddTask.ParamByName('TASK_NO').Value := ds.FieldByName('PK').Value
        else
          qAddTask.ParamByName('TASK_NO').Value := ds.FieldByName('I_PK').Value;

        try
          qAddTask.ExecQuery;
          qAddTask.Transaction.CommitRetaining;
        except
          qAddTask.Transaction.RollbackRetaining;
        end;
      end else
      begin
        // незавершенным задачам надо обновить дэдлайн, а то его могут двигать периодически
        if (dsFindTaskSTATUS.AsString <> '2') and (dsFindTaskSTATUS.AsString <> '3') then
        begin
          qEditTaskDeadline.ParamByName('DEADLINE').Value := ds.FieldByName('DEADLINE').Value;
          qEditTaskDeadline.ParamByName('PK').Value := dsFindTaskPK.AsVariant;

          try
            qEditTaskDeadline.ExecQuery;
            qEditTaskDeadline.Transaction.CommitRetaining;
          except
            qEditTaskDeadline.Transaction.RollbackRetaining;
          end;
        end;
      end;

      ds.Next;
    end;
  finally
    dsFindTask.Close;
    if Assigned(ds) then
    begin
      ds.Close;
      ds.Free;
    end;
  end;
end;

procedure TFTask.LoadData(ShowAll: boolean);
const
  task_sql = 'select t.PK, t.NAME, t.DESCR, t.STATUS, t.PRIORITY, t.TYPE_, t.DEADLINE, t.PROJECT, t.TASK_NO, t.DF_OBJECT, ' +
    't.DATE_ADD, t.USER_PK, u.NAME USER_NAME, t.DATE_END ' +
    'from DCFG_TASK t ' +
    'join USERS u on u.PK = t.USER_PK ' +
    'where lower(u.LOGIN) = lower(:USER_NAME) %s ' +
    'order by t.PK desc';

var
  pk: Variant;

begin
  if not FMain.DBTask.Connected then exit;
  
  Screen.Cursor := crSQLWait;
  try
    pk := Null;
    
    if dsTask.Active then
    begin
      if not dsTask.IsEmpty then pk := dsTaskPK.AsVariant;
      dsTask.Close;
    end;

    if ShowAll then
      dsTask.SQLs.SelectSQL.Text := Format(task_sql, [''])
    else
      dsTask.SQLs.SelectSQL.Text := Format(task_sql, ['and t.STATUS in (''0'', ''1'', ''4'', ''5'', ''6'')']);

    dsTask.ParamByName('USER_NAME').AsString := FSettings.PortalUser;
    dsTask.Open;

    LoadStatistic;
  finally
    if dsTask.Active then
    begin
      if not VarIsNull(pk) then dsTask.Locate('PK', pk, [])
      else dsTask.First;
    end;

    Screen.Cursor := crDefault;
  end;
end;

procedure TFTask.LoadStatistic;
var
  ds: TpFIBDataSet;
  
begin
  StatusBar.Panels[1].Text := '';
  StatusBar.Panels[2].Text := '';
  StatusBar.Panels[3].Text := '';
  StatusBar.Panels[4].Text := '';
  StatusBar.Panels[5].Text := '';
  StatusBar.Panels[6].Text := '';

  if not FMain.DBTask.Connected then exit;

  ds := TpFIBDataSet.Create(Self);
  try
    ds.Database := FMain.DBTask;
    ds.SQLs.SelectSQL.Text :=
      'select (select count(t.PK) from DCFG_TASK t join USERS u on u.PK = t.USER_PK where u.LOGIN = :USER_NAME and t.STATUS = ''1'') ACTIVE_, ' +
      '(select count(t.PK) from DCFG_TASK t join USERS u on u.PK = t.USER_PK where u.LOGIN = :USER_NAME and t.STATUS = ''0'') QUEUED, ' +
      '(select count(t.PK) from DCFG_TASK t join USERS u on u.PK = t.USER_PK where u.LOGIN = :USER_NAME and t.STATUS in (''4'', ''5'', ''6'')) WAITING, ' +
      '(select count(t.PK) from DCFG_TASK t join USERS u on u.PK = t.USER_PK where u.LOGIN = :USER_NAME and t.STATUS not in (''2'', ''3'') and t.PRIORITY < 0) URGENT, ' +
      '(select count(t.PK) from DCFG_TASK t join USERS u on u.PK = t.USER_PK where u.LOGIN = :USER_NAME and t.STATUS = ''0'' and t.PRIORITY < 0) QUEUED_URGENT, ' +
      '(select count(t.PK) from DCFG_TASK t join USERS u on u.PK = t.USER_PK where u.LOGIN = :USER_NAME and t.STATUS in (''4'', ''5'', ''6'') and t.PRIORITY < 0) WAITING_URGENT ' +
      'from RDB$DATABASE';

    ds.ParamByName('USER_NAME').AsString := LowerCase(FSettings.PortalUser);
    ds.Open;
    if ds.Active and not ds.IsEmpty then
    begin
      StatusBar.Panels[1].Text := 'В работе: ' + ds.FieldByName('ACTIVE_').AsString;
      StatusBar.Panels[2].Text := 'В очереди: ' + ds.FieldByName('QUEUED').AsString;
      StatusBar.Panels[3].Text := 'Ожидает: ' + ds.FieldByName('WAITING').AsString;
      StatusBar.Panels[4].Text := 'Приоритетных: ' + ds.FieldByName('URGENT').AsString;
      StatusBar.Panels[5].Text := 'Приор. очередь: ' + ds.FieldByName('QUEUED_URGENT').AsString;
      StatusBar.Panels[6].Text := 'Приор. ожидает: ' + ds.FieldByName('WAITING_URGENT').AsString;
    end;
  finally
    ds.Close;
    ds.Free;
  end;
end;

procedure TFTask.SetMode(Value: TOpenMode);
begin
  if Value = omAdd then Value := omEdit;
  inherited SetMode(Value);

  case FMode of
    omAdd, omEdit:
    begin
      dbgTask.AllowedOperations := [alopUpdateEh];
      StatusBar.Panels[0].Text := 'Read/Write';
    end;
    omView:
    begin
      dbgTask.AllowedOperations := [];
      StatusBar.Panels[0].Text := 'Read Only';
    end;
  end;
end;

end.
