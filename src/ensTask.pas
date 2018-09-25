unit ensTask;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, utils, settings, childForm, main,
  ActnList, ToolWin, ComCtrls, DBGridEhGrouping, GridsEh, DBGridEh, DB, FIBDataSet, pFIBDataSet, ExtCtrls, Menus,
  StdCtrls, ImgList, Buttons, DBAccess, Uni, MemDS, UniProvider, InterBaseUniProvider, dbUtils, ensTaskEditor,
  MemTableDataEh, MemTableEh, filter, EhLibUniDAC, dbFind, JvExComCtrls, JvComCtrls, JvDBTreeView, ensFolder;

type
  TFEnsTask = class(TChildForm)
    ActionList: TActionList;
    AClose: TAction;
    AGridOptions: TAction;
    ToolBar: TToolBar;
    dbgEnsTask: TDBGridEh;
    dsoEnsTask: TDataSource;
    pmGrid: TPopupMenu;
    MenuItem1: TMenuItem;
    ARefresh: TAction;
    ToolButton7: TToolButton;
    StatusBar: TStatusBar;
    AAdd: TAction;
    ADel: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton6: TToolButton;
    dsEnsTask: TUniQuery;
    dsEnsTaskPK: TIntegerField;
    dsEnsTaskIS_ACTIVE: TSmallintField;
    dsEnsTaskDESCRIPTION: TWideStringField;
    dsEnsTaskMINUTES: TWideStringField;
    dsEnsTaskHOURS: TWideStringField;
    dsEnsTaskDAYS: TWideStringField;
    dsEnsTaskMONTHS: TWideStringField;
    dsEnsTaskDOW: TWideStringField;
    dsEnsTaskLOG: TWideStringField;
    AEdit: TAction;
    ToolButton3: TToolButton;
    qInsertTask: TUniSQL;
    dsGenTaskId: TUniQuery;
    dsGenTaskIdPK: TLargeintField;
    qUpdateTask: TUniSQL;
    AFilter: TAction;
    AClearFilter: TAction;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    dsEnsTaskPROCESS_NAME: TWideStringField;
    dsEnsTaskPARAMETRES: TWideStringField;
    dsEnsTaskONLY_ONE_COPY: TWideStringField;
    pEnsFolders: TPanel;
    Splitter1: TSplitter;
    tvEnsFolders: TJvDBTreeView;
    dsEnsFolders: TUniQuery;
    dsoEnsFolders: TDataSource;
    dsEnsFoldersNAME: TWideStringField;
    dsEnsFoldersPARENT_PK: TIntegerField;
    dsEnsFoldersICON_INDEX: TIntegerField;
    ilTree: TImageList;
    dsEnsFoldersPK: TIntegerField;
    AAddFolder: TAction;
    AEditFolder: TAction;
    ADelFolder: TAction;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    pmTree: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    dsEnsTaskFOLDER_PK: TIntegerField;
    AMoveFolder: TAction;
    N4: TMenuItem;
    dsEnsTaskEXEC_TIMEOUT: TIntegerField;
    dsEnsTaskSEND_ON_TIMEOUT: TWideStringField;
    dsEnsTaskSEND_ADDRS: TWideStringField;
    dsEnsTaskTIMEOUT_ACTION: TWideStringField;
    AExportToExcel: TAction;
    AExportToCsv: TAction;
    Excel1: TMenuItem;
    csv1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure ACloseExecute(Sender: TObject);
    procedure AGridOptionsExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ARefreshExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AAddUpdate(Sender: TObject);
    procedure AAddExecute(Sender: TObject);
    procedure ADelUpdate(Sender: TObject);
    procedure ADelExecute(Sender: TObject);
    procedure dbgEnsTaskKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AEditExecute(Sender: TObject);
    procedure dbgEnsTaskSortMarkingChanged(Sender: TObject);
    procedure AFilterExecute(Sender: TObject);
    procedure AClearFilterExecute(Sender: TObject);
    procedure AClearFilterUpdate(Sender: TObject);
    procedure dbgEnsTaskApplyFilter(Sender: TObject);
    procedure dbgEnsTaskFillSTFilterListValues(Sender: TCustomDBGridEh; Column: TColumnEh; Items: TStrings;
      var Processed: Boolean);
    procedure dbgEnsTaskDblClick(Sender: TObject);
    procedure dsEnsTaskBeforePost(DataSet: TDataSet);
    procedure tvEnsFoldersEditing(Sender: TObject; Node: TTreeNode; var AllowEdit: Boolean);
    procedure tvEnsFoldersChange(Sender: TObject; Node: TTreeNode);
    procedure tvEnsFoldersDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure tvEnsFoldersStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure tvEnsFoldersEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure AAddFolderUpdate(Sender: TObject);
    procedure AAddFolderExecute(Sender: TObject);
    procedure dsEnsFoldersBeforeDelete(DataSet: TDataSet);
    procedure dsEnsFoldersAfterPost(DataSet: TDataSet);
    procedure AEditFolderExecute(Sender: TObject);
    procedure ADelFolderExecute(Sender: TObject);
    procedure AMoveFolderExecute(Sender: TObject);
    procedure AExportToExcelExecute(Sender: TObject);
    procedure AExportToCsvExecute(Sender: TObject);
  private
    ddNode: TTreeNode;
    isShowing: boolean;
    treeCanRefresh: boolean;
    FDBConnect: TUniConnection;
    FUpdateTrans: TUniTransaction;
    FFilter: TfFilter;
    dsFind: TUniQuery;
    procedure ApplyFilter;
    procedure ClearFilter;
    procedure Connect;
    procedure ReopenTree;
    procedure LoadData(DefSort: boolean = false);
    procedure SetMode(Value: TOpenMode); override;
    function DeleteTask(Pk: integer; var err: string): boolean;
    procedure ApplyEnsTaskEditorData(FEnsTaskEditor: TFEnsTaskEditor);
    function GetOrderClause: string;
    procedure LostConnect(Connection: TObject; ErrorMessage: string);
    procedure Find(AContinue: boolean = false);
  public
    procedure OnEnsTaskEditorClose(Sender: TObject; var Action: TCloseAction);
  end;

implementation

{$R *.dfm}

procedure TFEnsTask.AAddExecute(Sender: TObject);
var
  FEnsTaskEditor: TFEnsTaskEditor;

begin
  if Mode = omView then exit;
  // открытие формы создания задачи ens
  FEnsTaskEditor := TFEnsTaskEditor.Create(Self, cftEditor, omAdd, Null, FMain.OnChildFormClose);
  FEnsTaskEditor.OnClose := OnEnsTaskEditorClose;
  FEnsTaskEditor.dsEnsFolders.Connection := FDBConnect;
  FEnsTaskEditor.dsEnsFolders.Open;
  FEnsTaskEditor.Caption := 'Новая задача ENS';
  FEnsTaskEditor.chbIsActive.Checked := true;
  FEnsTaskEditor.chbOnlyOneCopy.Checked := true;
  FEnsTaskEditor.edProcessName.Text := 'python';
  FEnsTaskEditor.edHours.Text := '*';
  FEnsTaskEditor.edMinutes.Text := '*';
  FEnsTaskEditor.edDays.Text := '*';
  FEnsTaskEditor.edMonths.Text := '*';
  FEnsTaskEditor.edDow.Text := '*';
  FEnsTaskEditor.cbTimeoutAction.ItemIndex := 0;
  FEnsTaskEditor.RegisterForm;
end;

procedure TFEnsTask.AAddFolderExecute(Sender: TObject);
var
  ffolder: TFEditEnsFolder;
  err: string;
  
begin
  ffolder := TFEditEnsFolder.Create(Self);
  try
    ffolder.Caption := 'Новая папка';
    ffolder.dsEnsFolders.Connection := FDBConnect;
    ffolder.dsEnsFolders.Open;
    ffolder.lctFolder.KeyValue := dsEnsFoldersPK.AsVariant;

    if ffolder.ShowModal = mrOk then
    begin
      if ConnectionsList.ExecSQL('insert into ENS_TASK_FOLDER (NAME, PARENT_PK) values (''' +
        iif(Trim(ffolder.edName.Text) = '', 'null', Trim(ffolder.edName.Text)) + ''', ' +
        iif(ffolder.dsEnsFoldersPK.IsNull, 'null', ffolder.dsEnsFoldersPK.AsString) + ')', FSettings.EnsConnect, err) then
        ReopenTree
      else
        Application.MessageBox(pchar('Не удалось создать папку!'#13#10 + err), 'Ошибка', MB_OK + MB_ICONERROR);
    end;
  finally
    ffolder.Free;
  end;
end;

procedure TFEnsTask.AAddFolderUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := dsEnsFolders.Active and (Mode = omEdit);
  if TAction(Sender).Enabled and (TAction(Sender) <> AAddFolder) then
    TAction(Sender).Enabled := (not dsEnsFolders.IsEmpty) and (dsEnsFoldersPK.AsInteger <> 0);
end;

procedure TFEnsTask.AAddUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := dsEnsTask.Active and (Mode = omEdit);
end;

procedure TFEnsTask.AClearFilterExecute(Sender: TObject);
begin
  ClearFilter;
end;

procedure TFEnsTask.AClearFilterUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := dsEnsTask.Active and dsEnsTask.Filtered;
end;

procedure TFEnsTask.ACloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFEnsTask.ADelExecute(Sender: TObject);
var
  err: string;

begin
  if Application.MessageBox(pchar('Удалить задачу "' + dsEnsTaskPK.AsString + ' : ' + dsEnsTaskDESCRIPTION.AsString + '"?'),
    'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

  if DeleteTask(dsEnsTaskPK.AsInteger, err) then
    LoadData
  else
    Application.MessageBox(pchar('Ошибка удаления задачи!'#13#10 + err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFEnsTask.ADelFolderExecute(Sender: TObject);
var
  err: string;
  
begin
  if dsEnsFolders.IsEmpty or (dsEnsFoldersPK.AsInteger = 0) then exit;

  if (Application.MessageBox(pchar('Удалить папку <' + dsEnsFoldersNAME.AsString + '>? Все дочерние папки будут перенесены в корень'),
    'Подтверждение', MB_YESNO + MB_ICONQUESTION) = ID_YES) then
  begin
    if ConnectionsList.ExecSQL('delete from ENS_TASK_FOLDER where PK = ' + dsEnsFoldersPK.AsString, FSettings.EnsConnect, err) then
      ReopenTree
    else
      Application.MessageBox(pchar('Ошибка удаления папки!'#13#10 + err), 'Ошибка', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFEnsTask.ADelUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := dsEnsTask.Active and (not dsEnsTask.IsEmpty) and (Mode = omEdit);
end;

procedure TFEnsTask.AEditExecute(Sender: TObject);
var
  FEnsTaskEditor: TFEnsTaskEditor;
  m: TOpenMode;

begin
  if (not dsEnsTask.Active) or dsEnsTask.IsEmpty then exit;

  if Mode = omView then m := omView
  else m := omEdit;

  // открытие формы редактирования задачи ens
  FEnsTaskEditor := TFEnsTaskEditor.Create(Self, cftEditor, m, dsEnsTaskPK.AsVariant, FMain.OnChildFormClose);
  FEnsTaskEditor.OnClose := OnEnsTaskEditorClose;
  FEnsTaskEditor.dsEnsFolders.Connection := FDBConnect;
  FEnsTaskEditor.dsEnsFolders.Open;
  FEnsTaskEditor.Caption := 'Редактирование задачи ENS';
  FEnsTaskEditor.edPk.Text := dsEnsTaskPK.AsString;
  FEnsTaskEditor.chbIsActive.Checked := dsEnsTaskIS_ACTIVE.AsInteger = 1;
  FEnsTaskEditor.chbOnlyOneCopy.Checked := dsEnsTaskONLY_ONE_COPY.AsString = '1';
  FEnsTaskEditor.edProcessName.Text := dsEnsTaskPROCESS_NAME.AsString;
  FEnsTaskEditor.edParametres.Text := dsEnsTaskPARAMETRES.AsString;
  FEnsTaskEditor.edDescription.Text := dsEnsTaskDESCRIPTION.AsString;
  FEnsTaskEditor.edLogFile.Text := dsEnsTaskLOG.AsString;
  FEnsTaskEditor.edHours.Text := dsEnsTaskHOURS.AsString;
  FEnsTaskEditor.edMinutes.Text := dsEnsTaskMINUTES.AsString;
  FEnsTaskEditor.edDays.Text := dsEnsTaskDAYS.AsString;
  FEnsTaskEditor.edMonths.Text := dsEnsTaskMONTHS.AsString;
  FEnsTaskEditor.edDow.Text := dsEnsTaskDOW.AsString;
  FEnsTaskEditor.lctFolder.KeyValue := dsEnsTaskFOLDER_PK.AsVariant;
  FEnsTaskEditor.edExecTimeout.Value := dsEnsTaskEXEC_TIMEOUT.AsVariant;
  FEnsTaskEditor.cbTimeoutAction.ItemIndex := dsEnsTaskTIMEOUT_ACTION.AsInteger;
  FEnsTaskEditor.chbSendOnTimeout.Checked := dsEnsTaskSEND_ON_TIMEOUT.AsString = '1';
  FEnsTaskEditor.mSendAddrs.Text := dsEnsTaskSEND_ADDRS.AsString;
  FEnsTaskEditor.RegisterForm;
end;

procedure TFEnsTask.AEditFolderExecute(Sender: TObject);
var
  ffolder: TFEditEnsFolder;
  err: string;

begin
  if dsEnsFolders.IsEmpty or (dsEnsFoldersPK.AsInteger = 0) then exit;
  
  ffolder := TFEditEnsFolder.Create(Self);
  try
    ffolder.Caption := 'Папка <' + dsEnsFoldersNAME.AsString + '>';
    ffolder.dsEnsFolders.Connection := FDBConnect;
    ffolder.dsEnsFolders.Open;
    ffolder.edName.Text := dsEnsFoldersNAME.AsString;
    ffolder.lctFolder.KeyValue := dsEnsFoldersPARENT_PK.AsVariant;

    if ffolder.ShowModal = mrOk then
    begin
      if ConnectionsList.ExecSQL('update ENS_TASK_FOLDER set NAME = ''' + iif(Trim(ffolder.edName.Text) = '', 'null', Trim(ffolder.edName.Text)) +
        ''', PARENT_PK = ' + iif(ffolder.dsEnsFoldersPK.IsNull, 'null', ffolder.dsEnsFoldersPK.AsString) + ' where PK = ' + dsEnsFoldersPK.AsString,
        FSettings.EnsConnect, err) then ReopenTree
      else
        Application.MessageBox(pchar('Не удалось сохранить изменения!'#13#10 + err), 'Ошибка', MB_OK + MB_ICONERROR);
    end;
  finally
    ffolder.Free;
  end;
end;

procedure TFEnsTask.AExportToCsvExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToCsv(TDBGridEh(ActiveControl), Caption);
end;

procedure TFEnsTask.AExportToExcelExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToExcel(TDBGridEh(ActiveControl), Caption);
end;

procedure TFEnsTask.AFilterExecute(Sender: TObject);
begin
  ApplyFilter;  
end;

procedure TFEnsTask.AGridOptionsExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FSettings.GridParamsDialog(TDBGridEh(ActiveControl), ClassName);
end;

procedure TFEnsTask.AMoveFolderExecute(Sender: TObject);
begin
  Application.MessageBox('Просто перетащите папку мышкой в нужную. Чтобы вынести в корень, переместите в папку <не привязано>',
    'Информация', MB_OK + MB_ICONINFORMATION);
end;

procedure TFEnsTask.ApplyFilter;
var
  s: string;

begin
  if (not dsEnsTask.Active) then exit;

  if Assigned(dbgEnsTask.SelectedField) then
    s := dbgEnsTask.SelectedField.FieldName + ' = ''' + dbgEnsTask.SelectedField.AsString + '''';

  FFilter.Execute(dbgEnsTask, false, s);
end;

procedure TFEnsTask.ApplyEnsTaskEditorData(FEnsTaskEditor: TFEnsTaskEditor);
var
  err: string;
  res: boolean;

begin
  if (not FEnsTaskEditor.Success) then exit;

  res := false;
  case FEnsTaskEditor.Mode of
    omAdd:
    begin
      // создание новой задачи
      try
        if dsGenTaskId.Active then dsGenTaskId.Close;
        dsGenTaskId.Open;

        qInsertTask.ParamByName('PK').Value := dsGenTaskIdPK.AsVariant;

        if FEnsTaskEditor.edProcessName.Text <> '' then
          qInsertTask.ParamByName('PROCESS_NAME').AsString := FEnsTaskEditor.edProcessName.Text
        else
          qInsertTask.ParamByName('PROCESS_NAME').Clear;

        if FEnsTaskEditor.edParametres.Text <> '' then
          qInsertTask.ParamByName('PARAMETRES').AsString := FEnsTaskEditor.edParametres.Text
        else
          qInsertTask.ParamByName('PARAMETRES').Clear;

        if FEnsTaskEditor.edDescription.Text <> '' then
          qInsertTask.ParamByName('DESCRIPTION').AsString := FEnsTaskEditor.edDescription.Text
        else
          qInsertTask.ParamByName('DESCRIPTION').Clear;

        if FEnsTaskEditor.edMinutes.Text <> '' then
          qInsertTask.ParamByName('MINUTES').AsString := FEnsTaskEditor.edMinutes.Text
        else
          qInsertTask.ParamByName('MINUTES').Clear;

        if FEnsTaskEditor.edHours.Text <> '' then
          qInsertTask.ParamByName('HOURS').AsString := FEnsTaskEditor.edHours.Text
        else
          qInsertTask.ParamByName('HOURS').Clear;

        if FEnsTaskEditor.edDays.Text <> '' then
          qInsertTask.ParamByName('DAYS').AsString := FEnsTaskEditor.edDays.Text
        else
          qInsertTask.ParamByName('DAYS').Clear;

        if FEnsTaskEditor.edMonths.Text <> '' then
          qInsertTask.ParamByName('MONTHS').AsString := FEnsTaskEditor.edMonths.Text
        else
          qInsertTask.ParamByName('MONTHS').Clear;

        if FEnsTaskEditor.edDow.Text <> '' then
          qInsertTask.ParamByName('DOW').AsString := FEnsTaskEditor.edDow.Text
        else
          qInsertTask.ParamByName('DOW').Clear;

        if FEnsTaskEditor.edLogFile.Text <> '' then
          qInsertTask.ParamByName('LOG').AsString := FEnsTaskEditor.edLogFile.Text
        else
          qInsertTask.ParamByName('LOG').Clear;

        if FEnsTaskEditor.mSendAddrs.Text <> '' then
          qInsertTask.ParamByName('SEND_ADDRS').AsString := FEnsTaskEditor.mSendAddrs.Text
        else
          qInsertTask.ParamByName('SEND_ADDRS').Clear;

        qInsertTask.ParamByName('IS_ACTIVE').Value := iif(FEnsTaskEditor.chbIsActive.Checked, 1, 0);
        qInsertTask.ParamByName('ONLY_ONE_COPY').Value := iif(FEnsTaskEditor.chbOnlyOneCopy.Checked, '1', '0');
        qInsertTask.ParamByName('FOLDER_PK').Value := FEnsTaskEditor.lctFolder.KeyValue;
        qInsertTask.ParamByName('EXEC_TIMEOUT').Value := FEnsTaskEditor.edExecTimeout.Value;
        qInsertTask.ParamByName('TIMEOUT_ACTION').Value := FEnsTaskEditor.cbTimeoutAction.ItemIndex;
        qInsertTask.ParamByName('SEND_ON_TIMEOUT').Value := iif(FEnsTaskEditor.chbSendOnTimeout.Checked, '1', '0');

        qInsertTask.Execute;
        res := true;
      except
        on e: Exception do
        begin
          err := e.Message;
          FEnsTaskEditor.Success := false;
        end;
      end;

      dsGenTaskId.Close;
    end;
    omEdit:
    begin
      // сохранение изменений в задаче
      try
        qUpdateTask.ParamByName('PK').Value := FEnsTaskEditor.Properties.PK;

        if FEnsTaskEditor.edProcessName.Text <> '' then
          qUpdateTask.ParamByName('PROCESS_NAME').AsString := FEnsTaskEditor.edProcessName.Text
        else
          qUpdateTask.ParamByName('PROCESS_NAME').Clear;

        if FEnsTaskEditor.edParametres.Text <> '' then
          qUpdateTask.ParamByName('PARAMETRES').AsString := FEnsTaskEditor.edParametres.Text
        else
          qUpdateTask.ParamByName('PARAMETRES').Clear;

        if FEnsTaskEditor.edDescription.Text <> '' then
          qUpdateTask.ParamByName('DESCRIPTION').AsString := FEnsTaskEditor.edDescription.Text
        else
          qUpdateTask.ParamByName('DESCRIPTION').Clear;

        if FEnsTaskEditor.edLogFile.Text <> '' then
          qUpdateTask.ParamByName('LOG').AsString := FEnsTaskEditor.edLogFile.Text
        else
          qUpdateTask.ParamByName('LOG').Clear;
          
        if FEnsTaskEditor.edMinutes.Text <> '' then
          qUpdateTask.ParamByName('MINUTES').AsString := FEnsTaskEditor.edMinutes.Text
        else
          qUpdateTask.ParamByName('MINUTES').Clear;

        if FEnsTaskEditor.edHours.Text <> '' then
          qUpdateTask.ParamByName('HOURS').AsString := FEnsTaskEditor.edHours.Text
        else
          qUpdateTask.ParamByName('HOURS').Clear;

        if FEnsTaskEditor.edDays.Text <> '' then
          qUpdateTask.ParamByName('DAYS').AsString := FEnsTaskEditor.edDays.Text
        else
          qUpdateTask.ParamByName('DAYS').Clear;

        if FEnsTaskEditor.edMonths.Text <> '' then
          qUpdateTask.ParamByName('MONTHS').AsString := FEnsTaskEditor.edMonths.Text
        else
          qUpdateTask.ParamByName('MONTHS').Clear;

        if FEnsTaskEditor.edDow.Text <> '' then
          qUpdateTask.ParamByName('DOW').AsString := FEnsTaskEditor.edDow.Text
        else
          qUpdateTask.ParamByName('DOW').Clear;

        if FEnsTaskEditor.mSendAddrs.Text <> '' then
          qUpdateTask.ParamByName('SEND_ADDRS').AsString := FEnsTaskEditor.mSendAddrs.Text
        else
          qUpdateTask.ParamByName('SEND_ADDRS').Clear;

        qUpdateTask.ParamByName('IS_ACTIVE').Value := iif(FEnsTaskEditor.chbIsActive.Checked, 1, 0);
        qUpdateTask.ParamByName('ONLY_ONE_COPY').Value := iif(FEnsTaskEditor.chbOnlyOneCopy.Checked, '1', '0');
        qUpdateTask.ParamByName('FOLDER_PK').Value := FEnsTaskEditor.lctFolder.KeyValue;
        qUpdateTask.ParamByName('EXEC_TIMEOUT').Value := FEnsTaskEditor.edExecTimeout.Value;
        qUpdateTask.ParamByName('TIMEOUT_ACTION').Value := FEnsTaskEditor.cbTimeoutAction.ItemIndex;
        qUpdateTask.ParamByName('SEND_ON_TIMEOUT').Value := iif(FEnsTaskEditor.chbSendOnTimeout.Checked, '1', '0');

        qUpdateTask.Execute;
        res := true;
      except
        on e: Exception do
        begin
          err := e.Message;
          FEnsTaskEditor.Success := false;
        end;
      end;
    end;
    else exit;
  end;

  if res then LoadData
  else Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFEnsTask.ARefreshExecute(Sender: TObject);
begin
  ReopenTree;
  //LoadData;
end;

procedure TFEnsTask.ClearFilter;
var
  i: integer;

begin
  dbgEnsTask.ClearFilter;

  for i := 0 to dbgEnsTask.Columns.Count - 1 do
  begin
    dbgEnsTask.Columns[i].STFilter.ExpressionStr := '';
    dbgEnsTask.Columns[i].Title.Font.Style := FSettings.GridOptions.TitleFont.Style;
    dbgEnsTask.Columns[i].Title.Font.Color := FSettings.GridOptions.TitleFont.Color;
  end;

  dsEnsTask.Filtered := false;
  dsEnsTask.Filter := '';
end;

procedure TFEnsTask.Connect;
var
  err: string;
  ds: TUniQuery;
  c: TConnection;

begin
  if (FSettings.EnsConnect = -1) then
  begin
    Application.MessageBox('Внимание! Подключение к БД ENS не задано! Зайдите в настройки и задайте БД ENS', 'Ошибка', MB_OK + MB_ICONERROR);
    exit;
  end;

  c := FSettings.ConnByIndex[FSettings.EnsConnect];
  if (c.Server <> stFirebird) then
  begin
    Application.MessageBox('Внимание! Подключение к БД ENS задано неверно. Возможна работа только с серверами Firebird',
      'Ошибка', MB_OK + MB_ICONERROR);
    exit;
  end;

  Screen.Cursor := crSQLWait;
  try
    ds := TUniQuery.Create(Self);
    try
      FDBConnect := ConnectionsList.InitConnection(FSettings.EnsConnect);
      if FDBConnect.Name = '' then FDBConnect.Name := 'ENSConnect' + GenRandString(4, 6);
      FUpdateTrans.DefaultConnection := FDBConnect;
      FUpdateTrans.SpecificOptions.Assign(FDBConnect.SpecificOptions);
      FMain.ConnectChecker.Add(FDBConnect, LostConnect, CHECK_CONN_INTERVAL, CHECK_CONN_QUERY, FDBConnect.Connected);
      dsEnsFolders.Connection := FDBConnect;
      dsEnsFolders.UpdateTransaction := FUpdateTrans;
      dsEnsTask.Connection := FDBConnect;
      dsEnsTask.UpdateTransaction := FUpdateTrans;
      dsGenTaskId.Connection := FDBConnect;
      qInsertTask.Connection := FDBConnect;
      qUpdateTask.Connection := FDBConnect;

      // проверим, что мы в подходящей БД
      ds.Connection := FDBConnect;
      ds.SQL.Text := 'select count(*) from RDB$RELATIONS where RDB$RELATION_NAME = ''ENS_TASK'' and RDB$RELATION_TYPE = 0';
      ds.Open;
      if (not ds.Active) or ds.IsEmpty or ds.Fields.Fields[0].Value = 0 then
      begin
        FDBConnect.Close;
        raise Exception.Create('Подключение "' + c.Alias + '" не является базой данных ENS!');
      end;
    except
      on e: Exception do
      begin
        if Pos('user name and password', e.Message) > 0 then err := ProhibMes[0]
        else if Pos('I/O error', e.Message) > 0 then err := Format(ProhibMes[1], [iif(c.Host <> '', c.Host + ':', '') + c.DataBase])
        else if Pos('network request', e.Message) > 0 then err := Format(ProhibMes[2], [c.Host])
        else if (Pos('SQL error', e.Message) > 0) or (Pos('Parameter', e.Message) > 0) then err := Format(ProhibMes[3], [e.Message])
        else err := Format(ProhibMes[3], [e.Message]);

        Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
      end;
    end;
  finally
    if ds.Active then ds.Close;
    ds.Free;
    Screen.Cursor := crDefault;
  end;
end;

procedure TFEnsTask.dbgEnsTaskApplyFilter(Sender: TObject);
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

procedure TFEnsTask.dbgEnsTaskDblClick(Sender: TObject);
begin
  AEditExecute(AEdit);
end;

procedure TFEnsTask.dbgEnsTaskFillSTFilterListValues(Sender: TCustomDBGridEh; Column: TColumnEh; Items: TStrings;
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

procedure TFEnsTask.dbgEnsTaskKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_DELETE: if (ssCtrl in Shift) and ADel.Enabled then ADelExecute(ADel);
    VK_INSERT: if AAdd.Enabled then AAddExecute(AAdd);
    VK_RETURN: if (ssShift in Shift) and AEdit.Enabled then AEditExecute(AEdit);
    VK_F3: Find(true);
    else
      if (ssCtrl in Shift) and ((Key = Ord('F')) or (Key = Ord('f')) or (Key = Ord('А')) or (Key = Ord('а'))) then
        Find;
  end;
end;

procedure TFEnsTask.dbgEnsTaskSortMarkingChanged(Sender: TObject);
begin
  if (not dsEnsTask.Active) then exit;
  LoadData;
end;

function TFEnsTask.DeleteTask(Pk: integer; var err: string): boolean;
begin
  result := false;
  err := '';
  if (not Assigned(FDBConnect)) or (not FDBConnect.Connected) then exit;

  result := ConnectionsList.ExecSQL('delete from ENS_TASK where PK = ' + IntToStr(Pk), FSettings.EnsConnect, err);
end;

procedure TFEnsTask.dsEnsFoldersAfterPost(DataSet: TDataSet);
begin
  treeCanRefresh := true;
end;

procedure TFEnsTask.dsEnsFoldersBeforeDelete(DataSet: TDataSet);
begin
  if dsEnsFoldersPK.AsVariant = 0 then
    raise Exception.Create('Данный элемент нельзя удалить!');
end;

procedure TFEnsTask.dsEnsTaskBeforePost(DataSet: TDataSet);
begin
  if Application.MessageBox(pchar('Задача "' + dsEnsTaskPK.AsString + ':' + dsEnsTaskDESCRIPTION.AsString + '" была изменена! Сохранить изменения?'),
    'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then DataSet.Cancel;
end;

procedure TFEnsTask.Find(AContinue: boolean);
var
  FindOptions: TFindOptions;
  col: TColumnEh;
  defCol, sql, str: string;
  bmf, bmt: TBookmark;
  res: boolean;
  
begin
  res := false;
  
  if (not AContinue) or (DBFindDialog.cbFindText.Text = '') then
  begin
    // если новый, то показать диалог
    // будем выставлять по-умолчанию колонку с параметрами (где имя скрипта) - это наиболее актуально для поиска
    //if Assigned(dbgEnsTask.SelectedField) then col := dbgEnsTask.FindFieldColumn(dbgEnsTask.SelectedField.FieldName);
    col := dbgEnsTask.FindFieldColumn('PARAMETRES');
    if Assigned(col) then defCol := col.Title.Caption;
    if DBFindDialog.ShowDialog(dbgEnsTask, defCol) <> mrOk then exit;
  end;

  FindOptions := [];
  if DBFindDialog.chbMatchCase.Checked then FindOptions := [foMatchCase];
  if DBFindDialog.chbToExistence.Checked then FindOptions := FindOptions + [foToExistence];
  if DBFindDialog.rbWholeString.Checked then FindOptions := FindOptions + [foWholeString];
  if DBFindDialog.rbAnyWord.Checked then FindOptions := FindOptions + [foAnyWord];
  if DBFindDialog.rbAllWords.Checked then FindOptions := FindOptions + [foAllWords];

  // сначала найдем все папки, в которых есть подходящие записи
  if not Assigned(dsFind) or not dsFind.Active or not AContinue then
  begin
    if Assigned(dsFind) then
    begin
      dsFind.Close;
      FreeAndNil(dsFind);
    end;

    sql := 'select distinct coalesce(FOLDER_PK, 0) FOLDER_PK from ENS_TASK';
//    str := DBFindDialog.cbFindText.Text;
//
//    if (DBFindDialog.SelectedField <> '*') and (DBFindDialog.SelectedField <> '') then
//    begin
//      sql := sql + ' where ';
//
//      if foMatchCase in FindOptions then
//        sql := sql + DBFindDialog.SelectedField
//      else begin
//        sql := sql + 'lower(' + DBFindDialog.SelectedField + ')';
//        str := AnsiLowerCase(str);
//      end;
//
//      if foToExistence in FindOptions then sql := sql + ' like ''%' + str + '%'''
//      else sql := sql + ' = ''' + str + '''';
//    end;

    dsFind := ConnectionsList.GetDataSet(FSettings.EnsConnect, qtUserDefined, sql);
    dsFind.Open;
    dsFind.First;
  end else
    if dsFind.Eof then dsFind.First;

  // потом будем пробегаться по дереву, становиться на нужные папки, при этом будет подгружаться табличка по этой папке
  // и мы стандартно ищем по гриду
  bmf := dsEnsFolders.GetBookmark;
  bmt := dsEnsFolders.GetBookmark;
  try
    while not dsFind.Eof do
    begin
      if (dsEnsFoldersPK.AsInteger <> dsFind.FieldByName('FOLDER_PK').AsInteger) or (not AContinue) then
        if not dsEnsFolders.Locate('PK', dsFind.FieldByName('FOLDER_PK').Value, []) then
        begin
          dsFind.Next;
          continue;
        end;

      res := FindInGrid(dbgEnsTask, DBFindDialog.cbFindText.Text, DBFindDialog.SelectedField, FindOptions, AContinue, true);
      if res then break;
      dsFind.Next;
    end;
  finally
    if (not res) then
    begin
      if dsEnsFolders.BookmarkValid(bmf) then dsEnsFolders.GotoBookmark(bmf);
      if dsEnsTask.BookmarkValid(bmt) then dsEnsTask.GotoBookmark(bmt);
      Application.MessageBox('Ничего не найдено!', 'Поиск', MB_OK + MB_ICONINFORMATION);
    end;
  end;
end;

procedure TFEnsTask.FormActivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, true);
  FMain.CheckFormButton(Tag);
end;

procedure TFEnsTask.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (dsEnsTask.State in [dsEdit, dsInsert]) then
  begin
    case Application.MessageBox('Есть несохраненные изменения! Сохранить?', 'Предупреждение', MB_YESNOCANCEL + MB_ICONQUESTION) of
      ID_YES:
      begin
        if (dsEnsTask.State in [dsEdit, dsInsert]) then dsEnsTask.Post;
      end;
      ID_NO:
      begin
        if (dsEnsTask.State in [dsEdit, dsInsert]) then dsEnsTask.Cancel;
      end;
      ID_CANCEL:
      begin
        Action := caNone;
        exit;
      end;
    end;
  end;

  Action := caFree;
  FSettings.ChildMaximized := WindowState = wsMaximized;
end;

procedure TFEnsTask.FormCreate(Sender: TObject);
begin
  FFilter := TfFilter.Create(Self);
  FUpdateTrans := TUniTransaction.Create(Self);
  Connect;
end;

procedure TFEnsTask.FormDeactivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, false);
end;

procedure TFEnsTask.FormDestroy(Sender: TObject);
begin
  FMain.ConnectChecker.Delete(FMain.ConnectChecker.FindItem(FDBConnect.Name));
  FSettings.EnsFolderWidth := pEnsFolders.Width;

  dsEnsTask.Close;
  dsEnsFolders.Close;
  if Assigned(dsFind) then
  begin
    dsFind.Close;
    dsFind.Free;
  end;
  FDBConnect.Close;
  FUpdateTrans.Free;
  FFilter.Free;
end;

procedure TFEnsTask.FormShow(Sender: TObject);
begin
  isShowing := true;
  pEnsFolders.Width := FSettings.EnsFolderWidth;
  ReopenTree;
  //LoadData(true);
  isShowing := false;
end;

function TFEnsTask.GetOrderClause: string;
var
  i: integer;
  SortFieldName: string;
  SortDirect: TSortMarkerEh;
  direct: string;

begin
  result := '';

  for i := 0 to dbgEnsTask.SortMarkedColumns.Count - 1 do
  begin
    SortFieldName := dbgEnsTask.SortMarkedColumns.Items[i].FieldName;
    SortDirect := dbgEnsTask.SortMarkedColumns.Items[i].Title.SortMarker;

    if (SortFieldName <> '') and (SortDirect <> smNoneEh) then
    begin
      case SortDirect of
        smNoneEh: direct := '';
        smDownEh: direct := 'desc';
        smUpEh: direct := 'asc';
      end;

      if result = '' then result := SortFieldName + ' ' + direct
      else result := result + ', ' + SortFieldName + ' ' + direct;
    end;
  end;
end;

procedure TFEnsTask.LoadData(DefSort: boolean);
var
  pk: Variant;
  col: TColumnEh;

begin
  if (not Assigned(FDBConnect)) or (not FDBConnect.Connected) or (not dsEnsFolders.Active) then exit;

  Screen.Cursor := crSQLWait;
  try
    pk := Null;

    if dsEnsTask.Active then
    begin
      if not dsEnsTask.IsEmpty then pk := dsEnsTaskPK.AsVariant;
      dsEnsTask.Close;
    end;

    if dsEnsFolders.IsEmpty then
      dsEnsTask.ParamByName('FOLDER_PK').Clear
    else
      dsEnsTask.ParamByName('FOLDER_PK').Value := dsEnsFoldersPK.AsVariant;
      
    if DefSort then dsEnsTask.SetOrderBy('PK desc')
    else dsEnsTask.SetOrderBy(GetOrderClause);
    dsEnsTask.Open;
  finally
    if dsEnsTask.Active then
    begin
      if not VarIsNull(pk) then dsEnsTask.Locate('PK', pk, [])
      else dsEnsTask.First;

      if DefSort then
      begin
        col := FindColumnByFieldName(dbgEnsTask, 'PK');
        if Assigned(col) then col.Title.SortMarker := smDownEh;
      end;
    end;

    Screen.Cursor := crDefault;
  end;
end;

procedure TFEnsTask.LostConnect(Connection: TObject; ErrorMessage: string);
begin
  Application.MessageBox(pchar('Соединение Задач ENS было разорвано! Ошибка:'#13#10 + ErrorMessage), pchar(Application.Title), MB_OK + MB_ICONERROR);
  Close;  
end;

procedure TFEnsTask.OnEnsTaskEditorClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if TFEnsTaskEditor(Sender).Success then ApplyEnsTaskEditorData(TFEnsTaskEditor(Sender));
end;

procedure TFEnsTask.ReopenTree;
var
  id: variant;
  e: boolean;
  n: TTreeNode;

begin
  treeCanRefresh := false;
  id := dsEnsFoldersPK.AsVariant;
  if Assigned(tvEnsFolders.Selected) then e := tvEnsFolders.Selected.Expanded;

  dsEnsFolders.Close;
  dsEnsFolders.Open;

  if not VarIsNull(id) and (id <> 0) then
  begin
    n := tvEnsFolders.SelectNode(id);
    if Assigned(n) then n.Expanded := e;
  end;
end;

procedure TFEnsTask.SetMode(Value: TOpenMode);
begin
  if Value = omAdd then Value := omEdit;
  inherited SetMode(Value);

  case FMode of
    omAdd, omEdit:
    begin
      dbgEnsTask.AllowedOperations := [alopUpdateEh];
      StatusBar.Panels[0].Text := 'Read/Write';
    end;
    omView:
    begin
      dbgEnsTask.AllowedOperations := [];
      tvEnsFolders.ReadOnly := true;
      StatusBar.Panels[0].Text := 'Read Only';
    end;
  end;
end;

procedure TFEnsTask.tvEnsFoldersChange(Sender: TObject; Node: TTreeNode);
begin
  if treeCanRefresh then ReopenTree;
  LoadData(isShowing); 
end;

procedure TFEnsTask.tvEnsFoldersDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
var
  destNode: TTreeNode;

begin
  Accept := Assigned(ddNode) and (ddNode <> tvEnsFolders.Items.GetFirstNode);
  destNode := tvEnsFolders.GetNodeAt(X, Y);
  Accept := Assigned(destNode) and (destNode <> ddNode); //and (destNode <> tvEnsFolders.Items.GetFirstNode); - так будем отвязывать папки
end;

procedure TFEnsTask.tvEnsFoldersEditing(Sender: TObject; Node: TTreeNode; var AllowEdit: Boolean);
begin
  AllowEdit := Node <> tvEnsFolders.Items.GetFirstNode;
end;

procedure TFEnsTask.tvEnsFoldersEndDrag(Sender, Target: TObject; X, Y: Integer);
begin
  // сохраняет он изменения сам - дюже умный :) Надо тока тягаемый узел очистить 
  ddNode := nil;
  ReopenTree;
end;

procedure TFEnsTask.tvEnsFoldersStartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  ddNode := tvEnsFolders.Selected;
end;

end.
