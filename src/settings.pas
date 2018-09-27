unit settings;

interface

uses
  SysUtils, Windows, Messages, Variants, Classes, Graphics, Controls, Forms, Dialogs, ImgList, StdCtrls, Buttons, ComCtrls,
  Mask, ExtCtrls, WDGradient, Registry, utils, CryptUtils, FIBDatabase, pFIBDatabase, Db, Spin, UniProvider,
  PostgreSQLUniProvider, OracleUniProvider, MySQLUniProvider, DBAccess, Uni, DBGridEh, GridsEh, MemTableDataEh,
  MemTableEh, DBGridEhGrouping;

type
  TFSettings = class(TForm)
    pCaption: TWDGradientPanel;
    pGeneral: TPanel;
    Bevel1: TBevel;
    btnReset: TBitBtn;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    ilSetTree: TImageList;
    pNone: TPanel;
    lblPartDescr: TLabel;
    tvPartition: TTreeView;
    chbConfirmExit: TCheckBox;
    pConnection: TPanel;
    OpenDialog: TOpenDialog;
    dbTest: TpFIBDatabase;
    transTest: TpFIBTransaction;
    btnCheckConnect: TBitBtn;
    Label1: TLabel;
    edHost: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edDataBase: TEdit;
    btnSelectFile: TSpeedButton;
    Label8: TLabel;
    edUser: TEdit;
    Label17: TLabel;
    Label9: TLabel;
    edPass: TEdit;
    Label20: TLabel;
    cbSQLDialect: TComboBox;
    Label21: TLabel;
    edRole: TEdit;
    edPort: TSpinEdit;
    Label4: TLabel;
    edPortalUser: TEdit;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label5: TLabel;
    cbConnection: TComboBox;
    btnAdd: TSpeedButton;
    btnRename: TSpeedButton;
    btnDel: TSpeedButton;
    Label6: TLabel;
    cbServer: TComboBox;
    chbTreeShowDescriptor: TCheckBox;
    cbCharset: TComboBox;
    chbAlwaysPromptPass: TCheckBox;
    Label7: TLabel;
    cbPortalDescriptor: TComboBox;
    PgProvider: TPostgreSQLUniProvider;
    SqlConn: TUniConnection;
    Label10: TLabel;
    edPortalUrl: TEdit;
    chbConfirmSave: TCheckBox;
    chbCheckUpdates: TCheckBox;
    lbUpdatePath: TLabel;
    edUpdatePath: TEdit;
    GroupBox1: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    edNetUser: TEdit;
    edNetPass: TEdit;
    Label13: TLabel;
    cbMainDescriptor: TComboBox;
    chbTreeRestorePos: TCheckBox;
    chbConfirmCloseChild: TCheckBox;
    Label14: TLabel;
    cbChildWindowState: TComboBox;
    pGrid: TPanel;
    chbGridFlat: TCheckBox;
    FontDialog: TFontDialog;
    btnGridFont: TBitBtn;
    Label15: TLabel;
    cbGridRowColor: TColorBox;
    Label16: TLabel;
    cbGridEvenRowColor: TColorBox;
    Label18: TLabel;
    GroupBox2: TGroupBox;
    Label19: TLabel;
    cbGridRowAlignment: TComboBox;
    Label22: TLabel;
    cbGridRowLayout: TComboBox;
    Label23: TLabel;
    edGridRowHeight: TSpinEdit;
    chbGridColLines: TCheckBox;
    chbGridRowLines: TCheckBox;
    chbGridExtendVertLines: TCheckBox;
    Label24: TLabel;
    edGridFrozenCols: TSpinEdit;
    Bevel4: TBevel;
    Label25: TLabel;
    Label26: TLabel;
    btnGridTitleFont: TBitBtn;
    Label27: TLabel;
    cbGridTitleColor: TColorBox;
    Label28: TLabel;
    edGridTitleHeight: TSpinEdit;
    Label29: TLabel;
    cbGridTitleAlignment: TComboBox;
    btnGridResetSettings: TButton;
    Label30: TLabel;
    cbGridNewRowColor: TColorBox;
    Label31: TLabel;
    cbGridChangedRowColor: TColorBox;
    Label32: TLabel;
    Bevel5: TBevel;
    btnDelDbDescr: TSpeedButton;
    chbGridRowAutoAlignment: TCheckBox;
    btnColumnResetSettings: TButton;
    chbSaveColumns: TCheckBox;
    chbRestoreSession: TCheckBox;
    cbShedulerConnect: TComboBox;
    Label33: TLabel;
    pIface: TPanel;
    chbRememberHistory: TCheckBox;
    mtMainPages: TMemTableEh;
    mtMainPagesCAPTION: TStringField;
    mtMainPagesIS_VISIBLE: TBooleanField;
    mtMainPagesNAME: TStringField;
    dsoMainPages: TDataSource;
    dbgMainPages: TDBGridEh;
    Label34: TLabel;
    Label35: TLabel;
    cbEnsConnect: TComboBox;
    cbUpdateConnect: TComboBox;
    Label36: TLabel;
    cbTreeCacheConnect: TComboBox;
    chbShowOnLogin: TCheckBox;
    chbSelSqlAddTitle: TCheckBox;
    Label37: TLabel;
    cbConnectionType: TComboBox;
    btnClearTreeCacheConn: TSpeedButton;
    chbShowScriptForm: TCheckBox;
    procedure tvPartitionCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure tvPartitionChange(Sender: TObject; Node: TTreeNode);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnCheckConnectClick(Sender: TObject);
    procedure btnSelectFileClick(Sender: TObject);
    procedure cbConnectionChange(Sender: TObject);
    procedure edHostChange(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnRenameClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure cbServerChange(Sender: TObject);
    procedure chbCheckUpdatesClick(Sender: TObject);
    procedure btnGridFontClick(Sender: TObject);
    procedure btnGridTitleFontClick(Sender: TObject);
    procedure btnGridResetSettingsClick(Sender: TObject);
    procedure chbGridFlatClick(Sender: TObject);
    procedure edGridRowHeightChange(Sender: TObject);
    procedure btnDelDbDescrClick(Sender: TObject);
    procedure chbGridRowAutoAlignmentClick(Sender: TObject);
    procedure btnColumnResetSettingsClick(Sender: TObject);
    procedure btnClearTreeCacheConnClick(Sender: TObject);
  private
    DefGridOptions: TGridParams;
    r_ok: boolean;
    FConnections: TConnections;
    cChanging: boolean;
    FDbDescriptors: TStringList;
    FUpdateInterval: Cardinal;
    FMainPages: TStringList;
    procedure ResetColumnOptions;
    procedure ResetGridOptions;
    procedure ResetSettings;
    procedure SaveToRegistry;
    procedure LoadFromRegistry;
    procedure SetDefault;
    procedure SetToControls;
    procedure GetFromControls;
    procedure SetGridToControls;
    procedure ChangePartControls(nodeID: integer);
    function TestConnect(var ErrMsg: string): boolean;
    function TestConnectNoFB(var ErrMsg: string): boolean;
    function GetConnection(Index: integer): TConnection; overload;
    function GetConnection(Name: string): TConnection; overload;
    function GetConnByDbDescr(DbDescr: string): TConnection;
    function GetConnIndexByDbDescr(DbDescr: string): integer;
    procedure AddConnection;
    procedure EditConnection;
    procedure DelConnection;
    function GetDbDescriptors: string;
    procedure SetDbDescriptors(Value: string);
    function GetUpdateInterval: Cardinal;
    procedure DelDbDescr;
    procedure SetPagesToControls;
  public
    GridOptsChanged: boolean;
    //основные настройки программы
    ConfirmExit: boolean;
    ConfirmCloseChild: boolean;
    ConfirmSave: boolean;
    ShowScriptForm: boolean;
    ShowOnlyUser: boolean;
    PortalUser: string;
    TreeShowDescriptor: boolean;
    TreeRestorePos: boolean;
    CheckUpdates: boolean;
    UpdatePath: string;
    UpdateFromDb: boolean;
    NetUser: string;
    NetPass: string;
    MainDescriptor: string;
    MaxFindHist: integer;
    ChildWindowState: TChildWindowState;
    GridOptions: TGridParams;
    GridSaveColumns: boolean;
    RestoreSession: boolean;
    ShedulerConnect: integer;
    EnsConnect: integer;
    UpdateConnect: integer;
    TreeCacheConnect: string;
    RememberHistory: boolean;
    SelSqlAddTitle: boolean;
    CSVExpSeparator: string;
    CSVExpShowCaption: boolean;
    CSVExpQuoted: boolean;
    // разные настройки, к-рые нельзя менять (они сохраняются автоматически)
    WLeft: integer;
    WTop: integer;
    WWidth: integer;
    WHeight: integer;
    WMaximized: boolean;
    pTreeWidth: integer;
    CurrPage: integer;
    MainTreeId: variant;
    DictTreeId: variant;
    FormTreeId: variant;
    WizardTreeId: variant;
    HistoryTreeId: variant;
    FilterHist: TStringList;
    FindHist: TStringList;
    FindMatchCase: boolean;
    FindToExistence: boolean;
    FindWholeString: boolean;
    FindAnyWord: boolean;
    FindAllWords: boolean;
    DbFindHist: TStringList;
    DbFindMatchCase: boolean;
    DbFindToExistence: boolean;
    DbFindWholeString: boolean;
    DbFindAnyWord: boolean;
    DbFindAllWords: boolean;
    ChildMaximized: boolean;
    TmplCCreateAsList: boolean;
    ObjectInfoHeight: integer;
    FHintLeft: integer;
    FHintTop: integer;
    FHintWidth: integer;
    FHintHeight: integer;
    FHintVisible: boolean;
    FShedulerShowClosed: boolean;
    FShedulerPHeight: integer;
    HelpFile: string;
    EnsDefLogPath: string;
    EnsDefScriptPath: string;
    EnsFolderWidth: integer;
    // опции мастера выгрузки скриптов
    CmpScriptFile: string;
    CmpType: integer;
    CmpRefOptions: boolean;
    CmpDbObjects: boolean;
    CmpMainForm: boolean;
    CmpStartForm: boolean;
    CmpGrEditForm: boolean;
    CmpRankPermissions: boolean;
    CmpRankPermRecreate: boolean;
    CmpRolePermissions: boolean;
    CmpRolePermRecreate: boolean;
    CmpFilterConfig: boolean;
    CmpFilterConfigBind: boolean;
    CmpFilterGroup: boolean;
    CmpCharts: boolean;
    CmpChartGroups: boolean;
    CmpOtherEvents: boolean;
    CmpWizards: boolean;
    CmpFolders: boolean;
    CmpFormParams: boolean;
    CmpFormFields: boolean;
    CmpFormFieldGroups: boolean;
    CmpStFormParams: boolean;
    CmpStFormFields: boolean;
    CmpStFormFieldGroups: boolean;
    CmpGrFormParams: boolean;
    CmpGrFormFields: boolean;
    CmpGrFormFieldGroups: boolean;
    CmpScenParams: boolean;
    CmpScenStates: boolean;
    CmpFolderParams: boolean;
    // подключение
    CurrConnect: integer;
    procedure ActivateConnectControls(Active: boolean);
    procedure GetPagesFromControls;
    function GetCurrentConnection: TConnection;
    procedure SaveGridParams(Grid: TDBGridEh; FormName: string);
    procedure LoadGridParams(Grid: TDBGridEh; FormName: string);
    procedure GridParamsDialog(Grid: TDBGridEh; FormName: string);
    procedure FillDopConnectList(ConnCtrl: TComboBox);
    property ConnByIndex[Index: integer]: TConnection read GetConnection;
    property ConnByName[Name: string]: TConnection read GetConnection;
    property ConnByDbDescr[DbDescr: string]: TConnection read GetConnByDbDescr;
    property ConnIndexByDbDescr[DbDescr: string]: integer read GetConnIndexByDbDescr;
    property DbDescriptors: string read GetDbDescriptors;
    property UpdateInterval: Cardinal read GetUpdateInterval write FUpdateInterval;
  end;

var
  FSettings: TFSettings;

implementation

{$R *.dfm}

uses dbUtils, gridsettings;

const
  MAIN_PAGES = 'tsOnFolder=По папкам|1,tsOnlyDict=Справочники|1,tsForm=Формы|1,tsWizard=Сценарии|1,tsHistory=Избранное|1';
  
{ TFSettings }

procedure TFSettings.ActivateConnectControls(Active: boolean);
begin
  btnAdd.Enabled := Active;
  btnRename.Enabled := Active;
  btnDel.Enabled := Active;
  cbServer.Enabled := Active;
  edHost.Enabled := Active;
  edPort.Enabled := Active;
  edDataBase.Enabled := Active;
  btnSelectFile.Enabled := Active;
  edUser.Enabled := Active;
  edPass.Enabled := Active;
  edRole.Enabled := Active;
  cbCharset.Enabled := Active;
  cbSQLDialect.Enabled := Active;
  btnCheckConnect.Enabled := Active;
  chbAlwaysPromptPass.Enabled := Active;
  chbShowOnLogin.Enabled := Active;
  cbPortalDescriptor.Enabled := Active;
  cbMainDescriptor.Enabled := Active;
  btnDelDbDescr.Enabled := Active;
end;

procedure TFSettings.AddConnection;
var
  s: string;

begin
  s := InputBox('Новое подключение', 'Введите имя подключения', '');
  if (s = '') then exit;
  if (cbConnection.Items.IndexOf(s) > -1) then
  begin
    Application.MessageBox(pchar('Подключение "' + s + '" уже есть в списке.'), 'Ошибка', MB_OK + MB_ICONERROR);
    exit;
  end;

  SetLength(FConnections, Length(FConnections) + 1);
  FConnections[High(FConnections)].AlwaysPromptPass := false;
  FConnections[High(FConnections)].AllowLogin := false;
  FConnections[High(FConnections)].Alias := s;
  FConnections[High(FConnections)].Server := stFirebird;
  FConnections[High(FConnections)].Port := 3050;
  FConnections[High(FConnections)].SQLDialect := 3;
  FConnections[High(FConnections)].ConnType := ctDev;
  cbConnection.Items.Add(s);
  cbConnection.ItemIndex := cbConnection.Items.Count - 1;
  cbConnectionChange(cbConnection);
  FillDopConnectList(cbShedulerConnect);
  FillDopConnectList(cbEnsConnect);
  FillDopConnectList(cbUpdateConnect);
end;

procedure TFSettings.btnAddClick(Sender: TObject);
begin
  AddConnection;
end;

procedure TFSettings.btnClearTreeCacheConnClick(Sender: TObject);
begin
  cbTreeCacheConnect.ItemIndex := -1;
end;

procedure TFSettings.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFSettings.btnColumnResetSettingsClick(Sender: TObject);
begin
  ResetColumnOptions;
end;

procedure TFSettings.btnCheckConnectClick(Sender: TObject);
var
  err: string;
  r: boolean;

begin
  r := TestConnect(err);

  if r then
    Application.MessageBox('Соединение установлено.', 'Проверка подключения', MB_OK + MB_ICONINFORMATION)
  else
    Application.MessageBox(pchar('Не удалось подключиться! Ошибка:'#13#10 + err), 'Проверка подключения', MB_OK + MB_ICONERROR);
end;

procedure TFSettings.btnDelClick(Sender: TObject);
begin
  DelConnection;
end;

procedure TFSettings.btnDelDbDescrClick(Sender: TObject);
begin
  DelDbDescr;
end;

procedure TFSettings.btnGridFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(GridOptions.Font);
  if FontDialog.Execute then
  begin
    GridOptions.Font.Assign(FontDialog.Font);
    GridOptsChanged := true;
  end;
end;

procedure TFSettings.btnGridResetSettingsClick(Sender: TObject);
begin
  ResetGridOptions;
end;

procedure TFSettings.btnRenameClick(Sender: TObject);
begin
  EditConnection;
end;

procedure TFSettings.btnResetClick(Sender: TObject);
begin
  ResetSettings;
end;

procedure TFSettings.btnSaveClick(Sender: TObject);
begin
  r_ok := true;
  Close;
end;

procedure TFSettings.btnSelectFileClick(Sender: TObject);
var
  path, host: string;

begin
  if OpenDialog.Execute then
  begin
    path := OpenDialog.FileName;
    SplitPathByHost(path, host);
    if host = '' then host := 'localhost';
    edHost.Text := host;
    edDataBase.Text := path;
    edHostChange(edHost);
  end;
end;

procedure TFSettings.btnGridTitleFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(GridOptions.TitleFont);
  if FontDialog.Execute then
  begin
    GridOptions.TitleFont.Assign(FontDialog.Font);
    GridOptsChanged := true;
  end;
end;

procedure TFSettings.cbConnectionChange(Sender: TObject);
begin
  cChanging := true;
  try
    SetDbDescriptors(cbPortalDescriptor.Text);
    if (cbConnection.ItemIndex = -1) or (Length(FConnections) <= cbConnection.ItemIndex) then
    begin
      cbServer.ItemIndex := -1;
      chbAlwaysPromptPass.Checked := false;
      chbShowOnLogin.Checked := false;
      edHost.Text := '';
      edPort.Value := 1025;
      edDataBase.Text := '';
      edUser.Text := '';
      edPass.Text := '';
      edRole.Text := '';
      cbCharset.ItemIndex := -1;
      cbSQLDialect.ItemIndex := 1;
      cbPortalDescriptor.Text := '';
      edPortalUrl.Text := '';
      cbConnectionType.ItemIndex := 0;
    end else
    begin
      chbAlwaysPromptPass.Checked := FConnections[cbConnection.ItemIndex].AlwaysPromptPass;
      chbShowOnLogin.Checked := FConnections[cbConnection.ItemIndex].AllowLogin;
      cbServer.ItemIndex := Ord(FConnections[cbConnection.ItemIndex].Server);
      edHost.Text := FConnections[cbConnection.ItemIndex].Host;
      edPort.Value := FConnections[cbConnection.ItemIndex].Port;
      edDataBase.Text := FConnections[cbConnection.ItemIndex].DataBase;
      edUser.Text := FConnections[cbConnection.ItemIndex].UserName;
      edPass.Text := FConnections[cbConnection.ItemIndex].Pass;
      edRole.Text := FConnections[cbConnection.ItemIndex].Role;
      cbCharset.Text := FConnections[cbConnection.ItemIndex].Encoding;
      cbSQLDialect.ItemIndex := cbSQLDialect.Items.IndexOf(IntToStr(FConnections[cbConnection.ItemIndex].SQLDialect));
      cbPortalDescriptor.Text := FConnections[cbConnection.ItemIndex].PortalDescriptor;
      edPortalUrl.Text := FConnections[cbConnection.ItemIndex].PortalUrl;
      cbConnectionType.ItemIndex := Ord(FConnections[cbConnection.ItemIndex].ConnType);
    end;
    cbServerChange(cbServer);
  finally
    cChanging := false;
  end;
end;

procedure TFSettings.cbServerChange(Sender: TObject);
begin
  case TServerType(cbServer.ItemIndex) of
    stFirebird: cbCharset.Items.Text := StringReplace(FBENCODINGS, ',', #13#10, [rfReplaceAll]);
    stOracle: cbCharset.Items.Text := '';
    stPostgreSQL: cbCharset.Items.Text := StringReplace(PGENCODINGS, ',', #13#10, [rfReplaceAll]);
    stMySQL: cbCharset.Items.Text := StringReplace(MYENCODINGS, ',', #13#10, [rfReplaceAll]);
  end;
  if cbConnection.ItemIndex > -1 then
    cbCharset.ItemIndex := cbCharset.Items.IndexOf(FConnections[cbConnection.ItemIndex].Encoding);

  if edHost.Text = '' then
  begin
    case TServerType(cbServer.ItemIndex) of
      stFirebird: edPort.Value := 3050;
      stOracle: edPort.Value := 1521;
      stPostgreSQL: edPort.Value := 5432;
      stMySQL: edPort.Value := 3306;
    end;
  end;

  edHostChange(cbServer);
end;

procedure TFSettings.ChangePartControls(nodeID: integer);
begin
  pCaption.Caption := tvPartition.Selected.Text;
  lblPartDescr.Caption := 'Выберите раздел';
  pNone.Visible := false;
  pGeneral.Visible := false;
  pConnection.Visible := false;
  pGrid.Visible := false;
  pIface.Visible := false;
  case nodeID of
    0: pGeneral.Visible := true;
    1: pConnection.Visible := true;
    2: pGrid.Visible := true;
    3: pIface.Visible := true;
    else pNone.Visible := true;
  end;
end;

procedure TFSettings.chbCheckUpdatesClick(Sender: TObject);
begin
 { дизэйблить не надо, так как можно еще вручную проверять
  edUpdatePath.Enabled := chbCheckUpdates.Checked;
  lbUpdatePath.Enabled := chbCheckUpdates.Checked;
  Label11.Enabled := chbCheckUpdates.Checked;
  edNetUser.Enabled := chbCheckUpdates.Checked;
  Label12.Enabled := chbCheckUpdates.Checked;
  edNetPass.Enabled := chbCheckUpdates.Checked; }
end;

procedure TFSettings.chbGridFlatClick(Sender: TObject);
begin
  GridOptsChanged := true;
end;

procedure TFSettings.chbGridRowAutoAlignmentClick(Sender: TObject);
begin
  cbGridRowAlignment.Enabled := not chbGridRowAutoAlignment.Checked;
  GridOptsChanged := true;
end;

procedure TFSettings.DelConnection;
var
  i: integer;

begin
  if Application.MessageBox(pchar('Удалить подключение "' + cbConnection.Text + '"?'), 'Подтверждение',
    MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

//  if (cbConnection.ItemIndex = CurrConnect) then
//  begin
//    Application.MessageBox('Невозможно удалить текущее подключение! Сначала нужно разорвать соединение с БД.', 'Ошибка', MB_OK + MB_ICONERROR);
//    exit;
//  end;

  if cbConnection.ItemIndex < CurrConnect then Dec(CurrConnect);

  if cbConnection.ItemIndex < Length(FConnections) - 1 then
    for i := cbConnection.ItemIndex + 1 to Length(FConnections) - 1 do FConnections[i-1] := FConnections[i];

  SetLength(FConnections, Length(FConnections) - 1);
  cbConnection.Items.Delete(cbConnection.ItemIndex);
  cbConnection.ItemIndex := CurrConnect;
  cbConnectionChange(cbConnection);
  FillDopConnectList(cbShedulerConnect);
  FillDopConnectList(cbEnsConnect);
  FillDopConnectList(cbUpdateConnect);
end;

procedure TFSettings.DelDbDescr;
begin
  if (cbPortalDescriptor.Text <> '') and (cbPortalDescriptor.Items.IndexOf(cbPortalDescriptor.Text) > -1) then
  begin
    FDbDescriptors.Delete(FDbDescriptors.IndexOf(cbPortalDescriptor.Text));
    cbPortalDescriptor.Items.Delete(cbPortalDescriptor.Items.IndexOf(cbPortalDescriptor.Text));
    cbPortalDescriptor.Text := '';
    edHostChange(cbPortalDescriptor);
  end;
end;

procedure TFSettings.edGridRowHeightChange(Sender: TObject);
begin
  GridOptsChanged := true;
end;

procedure TFSettings.edHostChange(Sender: TObject);
begin
  if cChanging or (cbConnection.ItemIndex < 0) then exit;
  FConnections[cbConnection.ItemIndex].PortalDescriptor := cbPortalDescriptor.Text;
  FConnections[cbConnection.ItemIndex].PortalUrl := edPortalUrl.Text;
  FConnections[cbConnection.ItemIndex].AlwaysPromptPass := chbAlwaysPromptPass.Checked;
  FConnections[cbConnection.ItemIndex].AllowLogin := chbShowOnLogin.Checked;
  FConnections[cbConnection.ItemIndex].Server := TServerType(cbServer.ItemIndex);
  FConnections[cbConnection.ItemIndex].Host := edHost.Text;
  FConnections[cbConnection.ItemIndex].Port := edPort.Value;
  FConnections[cbConnection.ItemIndex].DataBase := edDataBase.Text;
  FConnections[cbConnection.ItemIndex].UserName := edUser.Text;
  FConnections[cbConnection.ItemIndex].Pass := edPass.Text;
  FConnections[cbConnection.ItemIndex].Role := edRole.Text;
  FConnections[cbConnection.ItemIndex].Encoding := cbCharset.Text;
  FConnections[cbConnection.ItemIndex].SQLDialect := StrToInt(cbSQLDialect.Items[cbSQLDialect.ItemIndex]);
  FConnections[cbConnection.ItemIndex].ConnType := TConnectionType(cbConnectionType.ItemIndex);
end;

procedure TFSettings.EditConnection;
var
  s: string;
  currIdx, idx: integer;

begin
  currIdx := cbConnection.ItemIndex;
  s := InputBox('Переименовать подключение', 'Введите имя подключения', cbConnection.Text);
  if (s = cbConnection.Text) then exit;
  idx := cbConnection.Items.IndexOf(s);
  if (idx > -1) and (idx <> currIdx) then
  begin
    Application.MessageBox(pchar('Подключение "' + s + '" уже есть в списке.'), 'Ошибка', MB_OK + MB_ICONERROR);
    exit;
  end;

  FConnections[currIdx].Alias := s;
  cbConnection.Items.Strings[currIdx] := s;
  cbConnection.ItemIndex := currIdx;
  cbConnectionChange(cbConnection);
  FillDopConnectList(cbShedulerConnect);
  FillDopConnectList(cbEnsConnect);
  FillDopConnectList(cbUpdateConnect);
end;

procedure TFSettings.FillDopConnectList(ConnCtrl: TComboBox);
var
  i: integer;

begin
  if not Assigned(ConnCtrl) then exit;
  i := ConnCtrl.ItemIndex;
  ConnCtrl.Items.Clear;
  ConnCtrl.Items.AddStrings(cbConnection.Items);
  if i < ConnCtrl.Items.Count then ConnCtrl.ItemIndex := i;
end;

procedure TFSettings.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if r_ok then
  begin
    ModalResult := mrOk;
    GetFromControls;
    SaveToRegistry;
  end else
  begin
    ModalResult := mrCancel;
    SetPagesToControls;
  end;

  Action := caHide;
end;

procedure TFSettings.FormCreate(Sender: TObject);
begin
  cChanging := false;
  SetLength(FConnections, 0);
  FDbDescriptors := TStringList.Create;
  FindHist := TStringList.Create;
  FilterHist := TStringList.Create;
  DbFindHist := TStringList.Create;
  GridOptions := TGridParams.Create;
  DefGridOptions := TGridParams.Create;
  FMainPages := TStringList.Create;
  LoadFromRegistry;
end;

procedure TFSettings.FormDestroy(Sender: TObject);
begin
  SaveToRegistry;
  SetLength(FConnections, 0);
  FDbDescriptors.Free;
  FindHist.Free;
  DbFindHist.Free;
  FilterHist.Free;
  GridOptions.Free;
  DefGridOptions.Free;
  FMainPages.Free;
end;

procedure TFSettings.FormShow(Sender: TObject);
begin
  r_ok := false;
  tvPartition.FullExpand;
  SetToControls;
  GridOptsChanged := false;
end;

function TFSettings.GetConnection(Index: integer): TConnection;
begin
  if (Index < 0) or (Length(FConnections) <= Index) then exit;
  result := FConnections[Index];
end;

function TFSettings.GetConnByDbDescr(DbDescr: string): TConnection;
var
  i: integer;

begin
  if Trim(DbDescr) = '' then exit;

  // если указан main, то всегда возвращаем текущее подключение
  if AnsiLowerCase(DbDescr) = AnsiLowerCase(MainDescriptor) then
  begin
    result := GetCurrentConnection;
    exit;
  end;

  for i := 0 to Length(FConnections) - 1 do
    // берем соединение по дескриптору портала такого же типа (разраб, тест, бой), как текущее активное, или первое попавшееся, если у текущего тип не определен
    if (AnsiLowerCase(DbDescr) = AnsiLowerCase(FConnections[i].PortalDescriptor)) and
      ((GetCurrentConnection.ConnType = FConnections[i].ConnType) or (GetCurrentConnection.ConnType = ctUndefined)) then
    begin
      result := FConnections[i];
      exit;
    end;

  for i := 0 to Length(FConnections) - 1 do
    // Если соответсвующего типа подключения не нашлось - берем первое подходящее, у которого тип не определен
    if (AnsiLowerCase(DbDescr) = AnsiLowerCase(FConnections[i].PortalDescriptor)) and (FConnections[i].ConnType = ctUndefined) then
    begin
      result := FConnections[i];
      exit;
    end;
end;

function TFSettings.GetConnection(Name: string): TConnection;
var
  i: integer;

begin
  for i := 0 to Length(FConnections) - 1 do
    if AnsiLowerCase(Name) = AnsiLowerCase(FConnections[i].Alias) then
    begin
      result := FConnections[i];
      exit;
    end;
end;

function TFSettings.GetConnIndexByDbDescr(DbDescr: string): integer;
var
  i: integer;

begin
  result := -1;
  if Trim(DbDescr) = '' then exit;

  // если указан main, то всегда возвращаем текущее подключение
  if AnsiLowerCase(DbDescr) = AnsiLowerCase(MainDescriptor) then
  begin
    result := CurrConnect;
    exit;
  end;

  for i := 0 to Length(FConnections) - 1 do
    if (AnsiLowerCase(DbDescr) = AnsiLowerCase(FConnections[i].PortalDescriptor)) and
      ((GetCurrentConnection.ConnType = FConnections[i].ConnType) or (GetCurrentConnection.ConnType = ctUndefined)) then
    begin
      result := i;
      exit;
    end;

  for i := 0 to Length(FConnections) - 1 do
    if (AnsiLowerCase(DbDescr) = AnsiLowerCase(FConnections[i].PortalDescriptor)) and (FConnections[i].ConnType = ctUndefined) then
    begin
      result := i;
      exit;
    end;
end;

function TFSettings.GetCurrentConnection: TConnection;
begin
  result := GetConnection(CurrConnect);
end;

function TFSettings.GetDbDescriptors: string;
begin
  result := FDbDescriptors.Text;
end;

procedure TFSettings.GetFromControls;
begin
  ConfirmExit := chbConfirmExit.Checked;
  ConfirmCloseChild := chbConfirmCloseChild.Checked;
  ConfirmSave := chbConfirmSave.Checked;
  ShowScriptForm := chbShowScriptForm.Checked;
  //PortalUser := edPortalUser.Text;
  //CurrConnect := cbConnection.ItemIndex;
  SetDbDescriptors(cbPortalDescriptor.Text);
  TreeShowDescriptor := chbTreeShowDescriptor.Checked;
  TreeRestorePos := chbTreeRestorePos.Checked;
  CheckUpdates := chbCheckUpdates.Checked;
  UpdatePath := edUpdatePath.Text;
  NetUser := edNetUser.Text;
  NetPass := edNetPass.Text;
  MainDescriptor := cbMainDescriptor.Text;
  ChildWindowState := TChildWindowState(cbChildWindowState.ItemIndex);
  GridSaveColumns := chbSaveColumns.Checked;
  RestoreSession := chbRestoreSession.Checked;
  ShedulerConnect := cbShedulerConnect.ItemIndex;
  EnsConnect := cbEnsConnect.ItemIndex;
  UpdateConnect := cbUpdateConnect.ItemIndex;
  TreeCacheConnect := cbTreeCacheConnect.Text;
  RememberHistory := chbRememberHistory.Checked;
  SelSqlAddTitle := chbSelSqlAddTitle.Checked;
  // грид
  GridOptions.Flat := chbGridFlat.Checked;
  GridOptions.RowLines := chbGridRowLines.Checked;
  GridOptions.ColLines := chbGridColLines.Checked;
  GridOptions.ExtendVertLines := chbGridExtendVertLines.Checked;
  GridOptions.RowHeight := edGridRowHeight.Value;
  GridOptions.FrozenCols := edGridFrozenCols.Value;
  GridOptions.RowColor := cbGridRowColor.Selected;
  GridOptions.EvenRowColor := cbGridEvenRowColor.Selected;
  GridOptions.NewRowColor := cbGridNewRowColor.Selected;
  GridOptions.ChangedRowColor := cbGridChangedRowColor.Selected;
  GridOptions.RowAutoAlignment := chbGridRowAutoAlignment.Checked;
  GridOptions.RowAlignment := TAlignment(cbGridRowAlignment.ItemIndex);
  GridOptions.RowLayout := TTextLayout(cbGridRowLayout.ItemIndex);
  GridOptions.TitleColor := cbGridTitleColor.Selected;
  GridOptions.TitleHeight := edGridTitleHeight.Value;
  GridOptions.TitleAlignment := TAlignment(cbGridTitleAlignment.ItemIndex);
  //
  GetPagesFromControls;
end;

function TFSettings.GetUpdateInterval: Cardinal;
begin
  result := FUpdateInterval * 60 * 1000;
end;

procedure TFSettings.GridParamsDialog(Grid: TDBGridEh; FormName: string);
var
  FGridSettings: TFGridSettings;

begin
  if (not Assigned(Grid)) or (Trim(FormName) = '') then exit;

  FGridSettings := TFGridSettings.Create(Self);
  try
    case FGridSettings.ShowSettingsDialog(Grid) of
      rSave: SaveGridParams(Grid, FormName);
      rCancel: FGridSettings.CancelChanges;
      {rReset:
      begin
        DeleteRegKey(PARAM_ROOT_KEY, REG_KEY_GRID + '\' + FormName + '\' + Grid.Name);
        SetDefaultGridParams(Grid);
      end;}
    end;
  finally
    FGridSettings.Free;
  end;
end;

procedure TFSettings.LoadFromRegistry;
var
  reg: TRegistry;
  sl: TStringList;
  i: integer;
  
begin
  SetDefault;
  sl := TStringList.Create;
  reg := TRegistry.Create(KEY_READ);
  try
    try
      reg.RootKey := PARAM_ROOT_KEY;

      if reg.OpenKey(REG_KEY_WINDOW, false) then
      begin
        WWidth := ReadRegValueInt(reg, 'mainwidth', 1250);
        WHeight := ReadRegValueInt(reg, 'mainheight', 750);
        WLeft := ReadRegValueInt(reg, 'mainleft', Round(Screen.Width / 2) - Round(WWidth / 2));
        WTop := ReadRegValueInt(reg, 'maintop', Round(Screen.Height / 2) - Round(WHeight / 2));
        WMaximized := ReadRegValueBool(reg, 'mainmaximized', false);
        pTreeWidth := ReadRegValueInt(reg, 'pTreeWidth', 450);
        CurrPage := ReadRegValueInt(reg, 'CurrPage', 0);
        if reg.ValueExists('MainTreeId') then MainTreeId := ReadRegValueStr(reg, 'MainTreeId', '')
        else MainTreeId := Null;
        if reg.ValueExists('DictTreeId') then DictTreeId := ReadRegValueStr(reg, 'DictTreeId', '')
        else DictTreeId := Null;
        if reg.ValueExists('FormTreeId') then FormTreeId := ReadRegValueStr(reg, 'FormTreeId', '')
        else FormTreeId := Null;
        if reg.ValueExists('WizardTreeId') then WizardTreeId := ReadRegValueStr(reg, 'WizardTreeId', '')
        else WizardTreeId := Null;
        if reg.ValueExists('HistoryTreeId') then HistoryTreeId := ReadRegValueStr(reg, 'HistoryTreeId', '')
        else HistoryTreeId := Null;
        ChildMaximized := ReadRegValueBool(reg, 'ChildMaximized', false);
        ObjectInfoHeight := ReadRegValueInt(reg, 'ObjectInfoHeight', 230);
        FHintWidth := ReadRegValueInt(reg, 'FHintWidth', 550);
        FHintHeight := ReadRegValueInt(reg, 'FHintHeight', 100);
        FHintLeft := ReadRegValueInt(reg, 'FHintLeft', Screen.Width - FHintWidth - 35);
        FHintTop := ReadRegValueInt(reg, 'FHintTop', Screen.Height - FHintHeight - 165);
        FHintVisible := ReadRegValueBool(reg, 'FHintVisible', false);
        FShedulerShowClosed := ReadRegValueBool(reg, 'FShedulerShowClosed', false);
        FShedulerPHeight := ReadRegValueInt(reg, 'FShedulerPHeight', 200);
        HelpFile := ReadRegValueStr(reg, 'HelpFile', 'help.odt');
        EnsFolderWidth := ReadRegValueInt(reg, 'EnsFolderWidth', 250);
        //EnsDefLogPath := ReadRegValueStr(reg, 'EnsDefLogPath', '/var/log/ens_scripts/');
        //EnsDefScriptPath := ReadRegValueStr(reg, 'EnsDefScriptPath', '/home/martin/projects/ens_scripts/');
        reg.CloseKey;
      end;

      if reg.OpenKey(REG_KEY_CONFIG, false) then
      begin
        ConfirmExit := ReadRegValueBool(reg, 'ConfirmExit', true);
        ConfirmCloseChild := ReadRegValueBool(reg, 'ConfirmCloseChild', true);
        ConfirmSave := ReadRegValueBool(reg, 'ConfirmSave', true);
        ShowScriptForm := ReadRegValueBool(reg, 'ShowScriptForm', true);
        ShowOnlyUser := ReadRegValueBool(reg, 'ShowOnlyUser', true);
        FUpdateInterval := ReadRegValueInt(reg, 'UpdateInterval', 30);
        CheckUpdates := ReadRegValueBool(reg, 'CheckUpdates', true);
        UpdatePath := ReadRegValueStr(reg, 'UpdatePath', '\\rao\abc\DictConfigurator');
        UpdateFromDb := ReadRegValueBool(reg, 'UpdateFromDb', true);
        NetUser := ReadRegValueStr(reg, 'NetUser', GetCurrUserName);
        NetPass := BytesSToStr(ReadRegValueStr(reg, 'NetPass', ''), true);
        if NetPass <> '' then
        try
          NetPass := DecAES(NetPass, PASSCRYPTKEY, 0);
        except
          on e: Exception do NetPass := '';
        end;
        //PortalUser := ReadRegValueStr(reg, 'PortalUser', GetCurrUserName);
        CurrConnect := ReadRegValueInt(reg, 'CurrConnect', -1);
        TreeShowDescriptor := ReadRegValueBool(reg, 'TreeShowDescriptor', false);
        TreeRestorePos := ReadRegValueBool(reg, 'TreeRestorePos', true);
        FDbDescriptors.Text := StringReplace(ReadRegValueStr(reg, 'DbDescriptors', DEF_DBDESCRIPTORS), ',', #13#10, [rfReplaceAll]);
        MainDescriptor := ReadRegValueStr(reg, 'MainDescriptor', 'firebird');
        MaxFindHist := ReadRegValueInt(reg, 'MaxFindHist', 20);
        try
          ChildWindowState := TChildWindowState(ReadRegValueInt(reg, 'ChildWindowState', Ord(cwsKeep)));
        except
        end;
        GridSaveColumns := ReadRegValueBool(reg, 'GridSaveColumns', true);
        RestoreSession := ReadRegValueBool(reg, 'RestoreSession', true);
        TmplCCreateAsList := ReadRegValueBool(reg, 'TmplCCreateAsList', true);
        ShedulerConnect := ReadRegValueInt(reg, 'ShedulerConnect', -1);
        EnsConnect := ReadRegValueInt(reg, 'EnsConnect', -1);
        UpdateConnect := ReadRegValueInt(reg, 'UpdateConnect', -1);
        TreeCacheConnect := ReadRegValueStr(reg, 'TreeCacheConnect', '');
        FMainPages.Text := StringReplace(ReadRegValueStr(reg, 'MainPages', MAIN_PAGES), ',', #13#10, [rfReplaceAll]);
        SetPagesToControls;
        RememberHistory := ReadRegValueBool(reg, 'RememberHistory', true);
        SelSqlAddTitle := ReadRegValueBool(reg, 'SelSqlAddTitle', true);
        reg.CloseKey;
      end;

      if reg.OpenKey(REG_KEY_GRID, false) then
      begin
        GridOptions.Flat := ReadRegValueBool(reg, 'Flat', GridOptions.Flat);
        ReadRegValueFont(reg, 'Font', GridOptions.Font);
        GridOptions.RowColor := ReadRegValueInt(reg, 'RowColor', GridOptions.RowColor);
        GridOptions.EvenRowColor := ReadRegValueInt(reg, 'EvenRowColor', GridOptions.EvenRowColor);
        GridOptions.NewRowColor := ReadRegValueInt(reg, 'NewRowColor', GridOptions.NewRowColor);
        GridOptions.ChangedRowColor := ReadRegValueInt(reg, 'ChangedRowColor', GridOptions.ChangedRowColor);
        GridOptions.RowAutoAlignment := ReadRegValueBool(reg, 'RowAutoAlignment', GridOptions.RowAutoAlignment);
        GridOptions.RowAlignment := TAlignment(ReadRegValueInt(reg, 'RowAlignment', Ord(GridOptions.RowAlignment)));
        GridOptions.RowLayout := TTextLayout(ReadRegValueInt(reg, 'RowLayout', Ord(GridOptions.RowLayout)));
        GridOptions.RowHeight := ReadRegValueInt(reg, 'RowHeight', GridOptions.RowHeight);
        GridOptions.RowLines := ReadRegValueBool(reg, 'RowLines', GridOptions.RowLines);
        GridOptions.ColLines := ReadRegValueBool(reg, 'ColLines', GridOptions.ColLines);
        GridOptions.ExtendVertLines := ReadRegValueBool(reg, 'ExtendVertLines', GridOptions.ExtendVertLines);
        GridOptions.FrozenCols := ReadRegValueInt(reg, 'FrozenCols', GridOptions.FrozenCols);
        ReadRegValueFont(reg, 'TitleFont', GridOptions.TitleFont);
        GridOptions.TitleColor := ReadRegValueInt(reg, 'TitleColor', GridOptions.TitleColor);
        GridOptions.TitleHeight := ReadRegValueInt(reg, 'TitleHeight', GridOptions.TitleHeight);
        GridOptions.TitleAlignment := TAlignment(ReadRegValueInt(reg, 'TitleAlignment', Ord(GridOptions.TitleAlignment)));
        CSVExpSeparator := ReadRegValueStr(reg, 'CSVExpSeparator', ';');
        CSVExpShowCaption := ReadRegValueBool(reg, 'CSVExpShowCaption', true);
        CSVExpQuoted := ReadRegValueBool(reg, 'CSVExpQuoted', true);
        reg.CloseKey;
      end;

      if reg.OpenKey(REG_KEY_CONNECT, false) then
      begin
        reg.GetKeyNames(sl);
        reg.CloseKey;
        sl.CustomSort(SlCustomSort);
        SetLength(FConnections, sl.Count);
        for i := 0 to sl.Count - 1 do
          if reg.OpenKey(REG_KEY_CONNECT + '\' + sl.Strings[i], false) then
          begin
            FConnections[i].PortalDescriptor := ReadRegValueStr(reg, 'PortalDescriptor', '');
            FConnections[i].PortalUrl := ReadRegValueStr(reg, 'PortalUrl', '');
            FConnections[i].AlwaysPromptPass := ReadRegValueBool(reg, 'AlwaysPromptPass', false);
            FConnections[i].AllowLogin := ReadRegValueBool(reg, 'AllowLogin', false);
            FConnections[i].Alias := ReadRegValueStr(reg, 'Alias', '');
            FConnections[i].Server := TServerType(ReadRegValueInt(reg, 'Server', 0));
            FConnections[i].Host := ReadRegValueStr(reg, 'Host', '');
            FConnections[i].Port := ReadRegValueInt(reg, 'Port', 1025);
            FConnections[i].DataBase := ReadRegValueStr(reg, 'DataBase', '');
            FConnections[i].UserName := ReadRegValueStr(reg, 'UserName', '');
            FConnections[i].Pass := BytesSToStr(ReadRegValueStr(reg, 'Pass', ''), true);
            if FConnections[i].Pass <> '' then
            try
              FConnections[i].Pass := DecAES(FConnections[i].Pass, PASSCRYPTKEY, 0);
            except
              on e: Exception do FConnections[i].Pass := '';
            end;
            FConnections[i].Role := ReadRegValueStr(reg, 'Role', '');
            FConnections[i].Encoding := ReadRegValueStr(reg, 'Encoding', '');
            FConnections[i].SQLDialect := ReadRegValueInt(reg, 'SQLDialect', 3);
            FConnections[i].ConnType := TConnectionType(ReadRegValueInt(reg, 'Type', 0));
            reg.CloseKey;
          end;
      end;

      cbConnection.Items.Clear;
      cbShedulerConnect.Items.Clear;
      cbEnsConnect.Items.Clear;
      cbUpdateConnect.Items.Clear;
      for i := 0 to Length(FConnections) - 1 do cbConnection.Items.Add(FConnections[i].Alias);
      cbShedulerConnect.Items.AddStrings(cbConnection.Items);
      cbEnsConnect.Items.AddStrings(cbConnection.Items);
      cbUpdateConnect.Items.AddStrings(cbConnection.Items);

      if reg.OpenKey(REG_KEY_FIND, false) then
      begin
        FindMatchCase := ReadRegValueBool(reg, 'FindMatchCase', false);
        FindToExistence := ReadRegValueBool(reg, 'FindToExistence', true);
        FindWholeString := ReadRegValueBool(reg, 'FindWholeString', true);
        FindAnyWord := ReadRegValueBool(reg, 'FindAnyWord', false);
        FindAllWords := ReadRegValueBool(reg, 'FindAllWords', false);
        reg.CloseKey;
      end;

      if reg.OpenKey(REG_KEY_FIND_HIST, false) then
      begin
        sl.Clear;
        reg.GetValueNames(sl);
        for i := 0 to sl.Count - 1 do
        begin
          if i > MaxFindHist then break;
          FindHist.Add(ReadRegValueStr(reg, sl.Strings[i], ''));
        end;
        reg.CloseKey;
      end;

      if reg.OpenKey(REG_KEY_DB_FIND, false) then
      begin
        DbFindMatchCase := ReadRegValueBool(reg, 'MatchCase', false);
        DbFindToExistence := ReadRegValueBool(reg, 'ToExistence', true);
        DbFindWholeString := ReadRegValueBool(reg, 'WholeString', true);
        DbFindAnyWord := ReadRegValueBool(reg, 'AnyWord', false);
        DbFindAllWords := ReadRegValueBool(reg, 'AllWords', false);
        reg.CloseKey;
      end;

      if reg.OpenKey(REG_KEY_DB_FIND_HIST, false) then
      begin
        sl.Clear;
        reg.GetValueNames(sl);
        for i := 0 to sl.Count - 1 do
        begin
          if i > MaxFindHist then break;
          DbFindHist.Add(ReadRegValueStr(reg, sl.Strings[i], ''));
        end;
        reg.CloseKey;
      end;

      if reg.OpenKey(REG_KEY_FILTER_HIST, false) then
      begin
        sl.Clear;
        reg.GetValueNames(sl);
        for i := 0 to sl.Count - 1 do
        begin
          if i > MaxFindHist then break;
          FilterHist.Add(ReadRegValueStr(reg, sl.Strings[i], ''));
        end;
        reg.CloseKey;
      end;

      if reg.OpenKey(REG_KEY_FDMP_OBJ, false) then
      begin
        CmpScriptFile := ReadRegValueStr(reg, 'ScriptFile', '');
        CmpType := ReadRegValueInt(reg, 'Type', 1);
        CmpRefOptions := ReadRegValueBool(reg, 'RefOptions', false);
        CmpDbObjects := ReadRegValueBool(reg, 'DbObjects', false);
        CmpMainForm := ReadRegValueBool(reg, 'MainForm', false);
        CmpStartForm := ReadRegValueBool(reg, 'StartForm', false);
        CmpGrEditForm := ReadRegValueBool(reg, 'GrEditForm', false);
        CmpRankPermissions := ReadRegValueBool(reg, 'RankPermissions', false);
        CmpRankPermRecreate := ReadRegValueBool(reg, 'RankPermRecreate', false);
        CmpRolePermissions := ReadRegValueBool(reg, 'RolePermissions', false);
        CmpRolePermRecreate := ReadRegValueBool(reg, 'RolePermRecreate', false);
        CmpFilterConfig := ReadRegValueBool(reg, 'FilterConfig', false);
        CmpFilterConfigBind := ReadRegValueBool(reg, 'FilterConfigBind', false);
        CmpFilterGroup := ReadRegValueBool(reg, 'FilterGroup', false);
        CmpCharts := ReadRegValueBool(reg, 'Charts', false);
        CmpChartGroups := ReadRegValueBool(reg, 'ChartGroups', false);
        CmpOtherEvents := ReadRegValueBool(reg, 'OtherEvents', false);
        CmpWizards := ReadRegValueBool(reg, 'Wizards', false);
        CmpFolders := ReadRegValueBool(reg, 'Folders', false);
        CmpFormParams := ReadRegValueBool(reg, 'FormParams', false);
        CmpFormFields := ReadRegValueBool(reg, 'FormFields', false);
        CmpFormFieldGroups := ReadRegValueBool(reg, 'FormFieldGroups', false);
        CmpStFormParams := ReadRegValueBool(reg, 'StFormParams', false);
        CmpStFormFields := ReadRegValueBool(reg, 'StFormFields', false);
        CmpStFormFieldGroups := ReadRegValueBool(reg, 'StFormFieldGroups', false);
        CmpGrFormParams := ReadRegValueBool(reg, 'GrFormParams', false);
        CmpGrFormFields := ReadRegValueBool(reg, 'GrFormFields', false);
        CmpGrFormFieldGroups := ReadRegValueBool(reg, 'GrFormFieldGroups', false);
        CmpScenParams := ReadRegValueBool(reg, 'ScenParams', false);
        CmpScenStates := ReadRegValueBool(reg, 'ScenStates', false);
        CmpFolderParams := ReadRegValueBool(reg, 'FolderParams', false);
        reg.CloseKey;
      end;

    except
      on E: Exception do
      begin
        Application.MessageBox(pchar('Не удалось прочитать настройки программы! Установлены настройки по-умолчанию.'#13#10 +
          E.Message), 'Ошибка', MB_OK + MB_ICONERROR);
      end;
    end;
  finally
    sl.Free;
    reg.Free;
  end;
end;

procedure TFSettings.LoadGridParams(Grid: TDBGridEh; FormName: string);
var
  reg: TRegistry;
  i, n: integer;
  col: TColumnEh;
  sl: TStringList;
  keyName: string;
  order: array of string;
  b: boolean;

begin
  if not GridSaveColumns then exit;
  if not Assigned(Grid) then exit;
  if Trim(FormName) = '' then exit;
  keyName := REG_KEY_GRID + '\' + FormName + '\' + Grid.Name;

  b := false;
  sl := TStringList.Create;
  reg := TRegistry.Create(KEY_READ);
  try
    try
      reg.RootKey := PARAM_ROOT_KEY;

      if reg.OpenKey(keyName, false) then
      begin
        reg.GetKeyNames(sl);
        Grid.FrozenCols := ReadRegValueInt(reg, 'FrozenCols', Grid.FrozenCols);
        reg.CloseKey;

        // для установки верного порядка колонок, надо сначала их список упорядочить по индексам
        SetLength(order, sl.Count);        
        for i := 0 to sl.Count - 1 do
        begin
          if reg.OpenKey(keyName + '\' + sl.Strings[i], false) then
          begin
            n := ReadRegValueInt(reg, 'Index', -1);
            if n > -1 then order[n] := sl.Strings[i]
            else b := true;
            reg.CloseKey;
          end;
        end;

        // восстановим параметры по полям, у кого индексы сохранены
        for i := 0 to Length(order) - 1 do
        begin
          col := FindColumnByFieldName(Grid, order[i]);

          if Assigned(col) and reg.OpenKey(keyName + '\' + col.FieldName, false) then
          begin
            col.Index := ReadRegValueInt(reg, 'Index', col.Index);
            col.Width := ReadRegValueInt(reg, 'Width', col.Width);
            col.Title.Caption := ReadRegValueStr(reg, 'Caption', col.Title.Caption);
            col.Visible := ReadRegValueBool(reg, 'Visible', col.Visible);
            reg.CloseKey;
          end;
        end;

        // восстановим параметры по полям, у кого индексы почему-то отсутствовали в реестре
        if b then
          for i := 0 to sl.Count - 1 do
          begin
            if FindInArray(order, sl.Strings[i]) > -1 then continue;
            col := FindColumnByFieldName(Grid, sl.Strings[i]);

            if Assigned(col) and reg.OpenKey(keyName + '\' + col.FieldName, false) then
            begin
              col.Width := ReadRegValueInt(reg, 'Width', col.Width);
              col.Title.Caption := ReadRegValueStr(reg, 'Caption', col.Title.Caption);
              col.Visible := ReadRegValueBool(reg, 'Visible', col.Visible);
              reg.CloseKey;
            end;
          end;
      end;
    except
      on E: Exception do
      begin
        {Application.MessageBox(pchar('Не удалось прочитать настройки таблицы! Установлены настройки по-умолчанию.'#13#10 +
          E.Message), 'Ошибка', MB_OK + MB_ICONERROR);}
      end;
    end;
  finally
    SetLength(order, 0);
    sl.Free;
    reg.Free;
  end;
end;

procedure TFSettings.GetPagesFromControls;
begin
  if (not mtMainPages.Active) or mtMainPages.IsEmpty then exit;

  if mtMainPages.State in [dsEdit] then mtMainPages.Post;
  FMainPages.Clear;
  mtMainPages.First;
  while not mtMainPages.Eof do
  begin
    FMainPages.Add(mtMainPagesNAME.AsString + '=' + mtMainPagesCAPTION.AsString + '|' + iif(mtMainPagesIS_VISIBLE.AsBoolean, '1', '0'));
    mtMainPages.Next;
  end;
  mtMainPages.First;
end;

procedure TFSettings.ResetColumnOptions;
var
  reg: TRegistry;
  i: integer;
  sl: TStringList;
    
begin
  if Application.MessageBox('Настройки колонок всех таблиц будут сброшены. Продолжить?',
    'Сброс настроек', MB_YESNO + MB_ICONWARNING) = ID_NO then exit;

  sl := TStringList.Create;
  reg := TRegistry.Create(KEY_READ);
  try
    try
      reg.RootKey := PARAM_ROOT_KEY;

      if reg.OpenKey(REG_KEY_GRID, false) then
      begin
        reg.GetKeyNames(sl);
        reg.CloseKey;

        for i := 0 to sl.Count - 1 do DeleteRegKey(PARAM_ROOT_KEY, REG_KEY_GRID + '\' + sl.Strings[i]);
      end;
    except
    end;
  finally
    sl.Free;
    reg.Free;
  end;
end;

procedure TFSettings.ResetGridOptions;
begin
  if Application.MessageBox('Настройки таблиц будут сброшены. Продолжить?',
    'Сброс настроек', MB_YESNO + MB_ICONWARNING) = ID_NO then exit;

  GridOptsChanged := true;
  GridOptions.Assign(DefGridOptions);
  SetGridToControls;
end;

procedure TFSettings.ResetSettings;
begin
  if Application.MessageBox('В результате данной операции будут загружены стандартные настройки.'#13#10 +
    'Вы точно хотите сбросить все настройки?', 'Сброс настроек', MB_YESNO + MB_ICONWARNING) = ID_NO then exit;

  // все удалять нельзя - надо оставить список коннектов, поэтому удаляем выборочно
  //DeleteRegKey(PARAM_ROOT_KEY, PARAM_REG_KEY);
  DeleteRegKey(PARAM_ROOT_KEY, REG_KEY_WINDOW);
  DeleteRegKey(PARAM_ROOT_KEY, REG_KEY_CONFIG);
  DeleteRegKey(PARAM_ROOT_KEY, REG_KEY_FIND);
  DeleteRegKey(PARAM_ROOT_KEY, REG_KEY_FILTER);
  DeleteRegKey(PARAM_ROOT_KEY, REG_KEY_GRID);
  DeleteRegKey(PARAM_ROOT_KEY, REG_KEY_FORMS);
  ResetGridOptions;
  LoadFromRegistry;
  SetToControls;
  SaveToRegistry;
  r_ok := true;
  Application.MessageBox(pchar('Установлены стандартные настройки'), 'Сброс настроек', MB_OK + MB_ICONINFORMATION);
end;

procedure TFSettings.SaveGridParams(Grid: TDBGridEh; FormName: string);
var
  reg: TRegistry;
  i: integer;
  keyName: string;

begin
  if not Assigned(Grid) then exit;
  if Trim(FormName) = '' then exit;
  keyName := REG_KEY_GRID + '\' + FormName + '\' + Grid.Name;

  reg := TRegistry.Create(KEY_ALL_ACCESS);
  try
    reg.RootKey := PARAM_ROOT_KEY;

    if reg.OpenKey(keyName, true) then
    begin
      reg.WriteInteger('FrozenCols', Grid.FrozenCols);
      reg.CloseKey;
      
      for i := 0 to Grid.Columns.Count - 1 do
      begin
        if reg.OpenKey(keyName + '\' + Grid.Columns[i].FieldName, true) then
        begin
          reg.WriteInteger('Index', Grid.Columns[i].Index);
          reg.WriteInteger('Width', Grid.Columns[i].Width);
          reg.WriteString('Caption', Grid.Columns[i].Title.Caption);
          reg.WriteBool('Visible', Grid.Columns[i].Visible);
          reg.CloseKey;
        end;
      end;
      reg.CloseKey;
    end;
  except
    {on E: Exception do
      Application.MessageBox(pchar('Не удалось сохранить настройки таблицы!'#13#10 + E.Message), 'Ошибка', MB_OK + MB_ICONERROR);}
  end;

  if Assigned(reg) then reg.Free;
end;

procedure TFSettings.SaveToRegistry;
var
  reg: TRegistry;
  s: string;
  i: integer;

begin
  reg := TRegistry.Create(KEY_ALL_ACCESS);
  try
    reg.RootKey := PARAM_ROOT_KEY;
    //reg.LazyWrite := false;
    if reg.OpenKey(REG_KEY_WINDOW, true) then
    begin
      reg.WriteInteger('mainleft', WLeft);
      reg.WriteInteger('maintop', WTop);
      reg.WriteInteger('mainwidth', WWidth);
      reg.WriteInteger('mainheight', WHeight);
      reg.WriteBool('mainmaximized', WMaximized);
      reg.WriteInteger('pTreeWidth', pTreeWidth);
      reg.WriteInteger('CurrPage', CurrPage);
      if (not VarIsNull(MainTreeId)) then reg.WriteString('MainTreeId', MainTreeId)
      else reg.DeleteValue('MainTreeId');
      if (not VarIsNull(DictTreeId)) then reg.WriteString('DictTreeId', DictTreeId)
      else reg.DeleteValue('DictTreeId');
      if (not VarIsNull(FormTreeId)) then reg.WriteString('FormTreeId', FormTreeId)
      else reg.DeleteValue('FormTreeId');
      if (not VarIsNull(WizardTreeId)) then reg.WriteString('WizardTreeId', WizardTreeId)
      else reg.DeleteValue('WizardTreeId');
      if (not VarIsNull(HistoryTreeId)) then reg.WriteString('HistoryTreeId', HistoryTreeId)
      else reg.DeleteValue('HistoryTreeId');
      reg.WriteBool('ChildMaximized', ChildMaximized);
      reg.WriteInteger('ObjectInfoHeight', ObjectInfoHeight);
      reg.WriteInteger('FHintLeft', FHintLeft);
      reg.WriteInteger('FHintTop', FHintTop);
      reg.WriteInteger('FHintWidth', FHintWidth);
      reg.WriteInteger('FHintHeight', FHintHeight);
      reg.WriteBool('FHintVisible', FHintVisible);
      reg.WriteBool('FShedulerShowClosed', FShedulerShowClosed);
      reg.WriteInteger('FShedulerPHeight', FShedulerPHeight);
      reg.WriteString('HelpFile', HelpFile);
      reg.WriteString('EnsDefLogPath', EnsDefLogPath);
      reg.WriteString('EnsDefScriptPath', EnsDefScriptPath);
      reg.WriteInteger('EnsFolderWidth', EnsFolderWidth);
      reg.CloseKey;
    end;

    if reg.OpenKey(REG_KEY_CONFIG, true) then
    begin
      reg.WriteBool('ConfirmExit', ConfirmExit);
      reg.WriteBool('ConfirmCloseChild', ConfirmCloseChild);
      reg.WriteBool('ConfirmSave', ConfirmSave);
      reg.WriteBool('ShowScriptForm', ShowScriptForm);
      reg.WriteBool('ShowOnlyUser', ShowOnlyUser);
      reg.WriteInteger('UpdateInterval', FUpdateInterval);
      reg.WriteBool('CheckUpdates', CheckUpdates);
      reg.WriteString('UpdatePath', UpdatePath);
      reg.WriteBool('UpdateFromDb', UpdateFromDb);
      reg.WriteString('NetUser', NetUser);
      if NetPass <> '' then s := StrToBytesS(EncAES(NetPass, PASSCRYPTKEY, 0), true)
      else s := '';
      reg.WriteString('NetPass', s);
      reg.WriteString('PortalUser', PortalUser);
      reg.WriteInteger('CurrConnect', CurrConnect);
      reg.WriteBool('TreeShowDescriptor', TreeShowDescriptor);
      reg.WriteBool('TreeRestorePos', TreeRestorePos);
      reg.WriteString('DbDescriptors', TextToString(DbDescriptors));
      reg.WriteString('MainDescriptor', MainDescriptor);
      reg.WriteInteger('MaxFindHist', MaxFindHist);
      reg.WriteInteger('ChildWindowState', Ord(ChildWindowState));
      reg.WriteBool('GridSaveColumns', GridSaveColumns);
      reg.WriteBool('RestoreSession', RestoreSession);
      reg.WriteBool('TmplCCreateAsList', TmplCCreateAsList);
      reg.WriteInteger('ShedulerConnect', ShedulerConnect);
      reg.WriteInteger('EnsConnect', EnsConnect);
      reg.WriteInteger('UpdateConnect', UpdateConnect);
      reg.WriteString('TreeCacheConnect', TreeCacheConnect);
      reg.WriteString('MainPages', TextToString(FMainPages.Text));
      reg.WriteBool('RememberHistory', RememberHistory);
      reg.WriteBool('SelSqlAddTitle', SelSqlAddTitle);
      reg.CloseKey;
    end;

    if reg.OpenKey(REG_KEY_GRID, true) then
    begin
      reg.WriteBool('Flat', GridOptions.Flat);
      WriteRegValueFont(reg, 'Font', GridOptions.Font);
      reg.WriteInteger('RowColor', GridOptions.RowColor);
      reg.WriteInteger('EvenRowColor', GridOptions.EvenRowColor);
      reg.WriteInteger('NewRowColor', GridOptions.NewRowColor);
      reg.WriteInteger('ChangedRowColor', GridOptions.ChangedRowColor);
      reg.WriteBool('RowAutoAlignment', GridOptions.RowAutoAlignment);
      reg.WriteInteger('RowAlignment', Ord(GridOptions.RowAlignment));
      reg.WriteInteger('RowLayout', Ord(GridOptions.RowLayout));
      reg.WriteInteger('RowHeight', GridOptions.RowHeight);
      reg.WriteBool('RowLines', GridOptions.RowLines);
      reg.WriteBool('ColLines', GridOptions.ColLines);
      reg.WriteBool('ExtendVertLines', GridOptions.ExtendVertLines);
      reg.WriteInteger('FrozenCols', GridOptions.FrozenCols);
      WriteRegValueFont(reg, 'TitleFont', GridOptions.TitleFont);
      reg.WriteInteger('TitleColor', GridOptions.TitleColor);
      reg.WriteInteger('TitleHeight', GridOptions.TitleHeight);
      reg.WriteInteger('TitleAlignment', Ord(GridOptions.TitleAlignment));
      reg.WriteString('CSVExpSeparator', CSVExpSeparator);
      reg.WriteBool('CSVExpShowCaption', CSVExpShowCaption);
      reg.WriteBool('CSVExpQuoted', CSVExpQuoted);
      reg.CloseKey;
    end;

    DeleteRegKey(PARAM_ROOT_KEY, REG_KEY_CONNECT);
    for i := 0 to Length(FConnections) - 1 do
      if reg.OpenKey(REG_KEY_CONNECT + '\' + IntToStr(i), true) then
      begin
        reg.WriteString('PortalDescriptor', FConnections[i].PortalDescriptor);
        reg.WriteString('PortalUrl', FConnections[i].PortalUrl);
        reg.WriteBool('AlwaysPromptPass', FConnections[i].AlwaysPromptPass);
        reg.WriteBool('AllowLogin', FConnections[i].AllowLogin);
        reg.WriteString('Alias', FConnections[i].Alias);
        reg.WriteInteger('Server', Ord(FConnections[i].Server));
        reg.WriteString('Host', FConnections[i].Host);
        reg.WriteInteger('Port', FConnections[i].Port);
        reg.WriteString('DataBase', FConnections[i].DataBase);
        reg.WriteString('UserName', FConnections[i].UserName);
        if FConnections[i].Pass <> '' then s := StrToBytesS(EncAES(FConnections[i].Pass, PASSCRYPTKEY, 0), true)
        else s := '';
        reg.WriteString('Pass', s);
        reg.WriteString('Role', FConnections[i].Role);
        reg.WriteString('Encoding', FConnections[i].Encoding);
        reg.WriteInteger('SQLDialect', FConnections[i].SQLDialect);
        reg.WriteInteger('Type', Ord(FConnections[i].ConnType));
        reg.CloseKey;
      end;

    if reg.OpenKey(REG_KEY_FIND, true) then
    begin
      reg.WriteBool('FindMatchCase', FindMatchCase);
      reg.WriteBool('FindToExistence', FindToExistence);
      reg.WriteBool('FindWholeString', FindWholeString);
      reg.WriteBool('FindAnyWord', FindAnyWord);
      reg.WriteBool('FindAllWords', FindAllWords);
      reg.CloseKey;
    end;

    DeleteRegKey(PARAM_ROOT_KEY, REG_KEY_FIND_HIST);
    if reg.OpenKey(REG_KEY_FIND_HIST, true) then
    begin
      for i := 0 to FindHist.Count - 1 do
      begin
        if i > MaxFindHist then break;
        reg.WriteString(IntToStr(i), FindHist.Strings[i]);
      end;
      reg.CloseKey;
    end;

    if reg.OpenKey(REG_KEY_DB_FIND, true) then
    begin
      reg.WriteBool('MatchCase', DbFindMatchCase);
      reg.WriteBool('ToExistence', DbFindToExistence);
      reg.WriteBool('WholeString', DbFindWholeString);
      reg.WriteBool('AnyWord', DbFindAnyWord);
      reg.WriteBool('AllWords', DbFindAllWords);
      reg.CloseKey;
    end;

    DeleteRegKey(PARAM_ROOT_KEY, REG_KEY_DB_FIND_HIST);
    if reg.OpenKey(REG_KEY_DB_FIND_HIST, true) then
    begin
      for i := 0 to DbFindHist.Count - 1 do
      begin
        if i > MaxFindHist then break;
        reg.WriteString(IntToStr(i), DbFindHist.Strings[i]);
      end;
      reg.CloseKey;
    end;

    DeleteRegKey(PARAM_ROOT_KEY, REG_KEY_FILTER_HIST);
    if reg.OpenKey(REG_KEY_FILTER_HIST, true) then
    begin
      for i := 0 to FilterHist.Count - 1 do
      begin
        if i > MaxFindHist then break;
        reg.WriteString(IntToStr(i), FilterHist.Strings[i]);
      end;
      reg.CloseKey;
    end;

    if reg.OpenKey(REG_KEY_FDMP_OBJ, true) then
    begin
      reg.WriteString('ScriptFile', CmpScriptFile);
      reg.WriteInteger('Type', CmpType);
      reg.WriteBool('RefOptions', CmpRefOptions);
      reg.WriteBool('DbObjects', CmpDbObjects);
      reg.WriteBool('MainForm', CmpMainForm);
      reg.WriteBool('StartForm', CmpStartForm);
      reg.WriteBool('GrEditForm', CmpGrEditForm);
      reg.WriteBool('RankPermissions', CmpRankPermissions);
      reg.WriteBool('RankPermRecreate', CmpRankPermRecreate);
      reg.WriteBool('RolePermissions', CmpRolePermissions);
      reg.WriteBool('RolePermRecreate', CmpRolePermRecreate);
      reg.WriteBool('FilterConfig', CmpFilterConfig);
      reg.WriteBool('FilterConfigBind', CmpFilterConfigBind);
      reg.WriteBool('FilterGroup', CmpFilterGroup);
      reg.WriteBool('Charts', CmpCharts);
      reg.WriteBool('ChartGroups', CmpChartGroups);
      reg.WriteBool('OtherEvents', CmpOtherEvents);
      reg.WriteBool('Wizards', CmpWizards);
      reg.WriteBool('Folders', CmpFolders);
      reg.WriteBool('FormParams', CmpFormParams);
      reg.WriteBool('FormFields', CmpFormFields);
      reg.WriteBool('FormFieldGroups', CmpFormFieldGroups);
      reg.WriteBool('StFormParams', CmpStFormParams);
      reg.WriteBool('StFormFields', CmpStFormFields);
      reg.WriteBool('StFormFieldGroups', CmpStFormFieldGroups);
      reg.WriteBool('GrFormParams', CmpGrFormParams);
      reg.WriteBool('GrFormFields', CmpGrFormFields);
      reg.WriteBool('GrFormFieldGroups', CmpGrFormFieldGroups);
      reg.WriteBool('ScenParams', CmpScenParams);
      reg.WriteBool('ScenStates', CmpScenStates);
      reg.WriteBool('FolderParams', CmpFolderParams);
      reg.CloseKey;
    end;
  except
    on E: Exception do
      Application.MessageBox(pchar('Не удалось сохранить настройки программы!'#13#10 + E.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;

  if Assigned(reg) then reg.Free;
end;

procedure TFSettings.SetDbDescriptors(Value: string);
begin
  if (Trim(Value) <> '') and (FDbDescriptors.IndexOf(Value) = -1) then FDbDescriptors.Add(Value);
end;

procedure TFSettings.SetDefault;
begin
  WWidth := 1250;
  WHeight := 750;
  WLeft := Round(Screen.Width / 2) - Round(WWidth / 2);
  WTop := Round(Screen.Height / 2) - Round(WHeight / 2);
  WMaximized := false;
  pTreeWidth := 450;
  CurrPage := 0;
  MainTreeId := Null;
  DictTreeId := Null;
  FormTreeId := Null;
  WizardTreeId := Null;
  HistoryTreeId := Null;
  ConfirmExit := true;
  ConfirmCloseChild := true;
  ConfirmSave := true;
  ShowScriptForm := true;
  ShowOnlyUser := true;
  FUpdateInterval := 30;
  CheckUpdates := true;
  UpdatePath := '\\rao\abc\DictConfigurator';
  UpdateFromDb := true;
  NetUser := GetCurrUserName;
  NetPass := '';
  PortalUser := GetCurrUserName;
  CurrConnect := -1;
  TreeShowDescriptor := false;
  TreeRestorePos := true;
  FDbDescriptors.Text := DEF_DBDESCRIPTORS;
  MainDescriptor := 'firebird';
  MaxFindHist := 20;
  FindMatchCase := false;
  FindToExistence := true;
  FindWholeString := true;
  FindAnyWord := false;
  FindAllWords := false;
  DbFindMatchCase := false;
  DbFindToExistence := true;
  DbFindWholeString := true;
  DbFindAnyWord := false;
  DbFindAllWords := false;
  ChildWindowState := cwsKeep;
  ChildMaximized := false;
  TmplCCreateAsList := true;
  GridSaveColumns := true;
  ObjectInfoHeight := 230;
  RestoreSession := true;
  ShedulerConnect := -1;
  EnsConnect := -1;
  UpdateConnect := -1;
  TreeCacheConnect := '';
  RememberHistory := true;
  SelSqlAddTitle := true;
  CSVExpSeparator := ';';
  CSVExpShowCaption := true;
  CSVExpQuoted := true;
  FHintWidth := 550;
  FHintHeight := 100;
  FHintLeft := Screen.Width - FHintWidth - 35;
  FHintTop := Screen.Height - FHintHeight - 165;
  FHintVisible := false;
  FShedulerShowClosed := false;
  FShedulerPHeight := 200;
  FMainPages.Text := MAIN_PAGES;
  HelpFile := 'help.odt';
  EnsDefLogPath := '/var/log/ens_scripts/';
  EnsDefScriptPath := '/home/martin/projects/ens_scripts/';
  EnsFolderWidth := 250;
  CmpScriptFile := '';
  CmpType := 1;
  CmpRefOptions := false;
  CmpDbObjects := false;
  CmpMainForm := false;
  CmpStartForm := false;
  CmpGrEditForm := false;
  CmpRankPermissions := false;
  CmpRankPermRecreate := false;
  CmpRolePermissions := false;
  CmpRolePermRecreate := false;
  CmpFilterConfig := false;
  CmpFilterConfigBind := false;
  CmpFilterGroup := false;
  CmpCharts := false;
  CmpChartGroups := false;
  CmpOtherEvents := false;
  CmpWizards := false;
  CmpFolders := false;
  CmpFormParams := false;
  CmpFormFields := false;
  CmpFormFieldGroups := false;
  CmpStFormParams := false;
  CmpStFormFields := false;
  CmpStFormFieldGroups := false;
  CmpGrFormParams := false;
  CmpGrFormFields := false;
  CmpGrFormFieldGroups := false;
  CmpScenParams := false;
  CmpScenStates := false;
  CmpFolderParams := false;
end;

procedure TFSettings.SetGridToControls;
begin
  chbGridFlat.Checked := GridOptions.Flat;
  chbGridRowLines.Checked := GridOptions.RowLines;
  chbGridColLines.Checked := GridOptions.ColLines;
  chbGridExtendVertLines.Checked := GridOptions.ExtendVertLines;
  edGridRowHeight.Value := GridOptions.RowHeight;
  edGridFrozenCols.Value := GridOptions.FrozenCols;
  cbGridRowColor.Selected := GridOptions.RowColor;
  cbGridEvenRowColor.Selected := GridOptions.EvenRowColor;
  cbGridNewRowColor.Selected := GridOptions.NewRowColor;
  cbGridChangedRowColor.Selected := GridOptions.ChangedRowColor;
  chbGridRowAutoAlignment.Checked := GridOptions.RowAutoAlignment;
  chbGridRowAutoAlignmentClick(chbGridRowAutoAlignment);
  cbGridRowAlignment.ItemIndex := Ord(GridOptions.RowAlignment);
  cbGridRowLayout.ItemIndex := Ord(GridOptions.RowLayout);
  cbGridTitleColor.Selected := GridOptions.TitleColor;
  edGridTitleHeight.Value := GridOptions.TitleHeight;
  cbGridTitleAlignment.ItemIndex := Ord(GridOptions.TitleAlignment);
end;

procedure TFSettings.SetPagesToControls;
var
  i: integer;
  
begin
  if mtMainPages.Active then
  begin
    mtMainPages.EmptyTable;
    mtMainPages.Close;
  end;
  mtMainPages.CreateDataSet;

  for i := 0 to FMainPages.Count - 1 do
  begin
    mtMainPages.Append;
    mtMainPagesNAME.AsString := FMainPages.Names[i];
    mtMainPagesCAPTION.AsString := ExtractWordEx(1, FMainPages.Values[FMainPages.Names[i]], ['|'], []);
    mtMainPagesIS_VISIBLE.AsBoolean := ExtractWordEx(2, FMainPages.Values[FMainPages.Names[i]], ['|'], []) = '1';
    mtMainPages.Post;
  end;
  mtMainPages.First;
end;

procedure TFSettings.SetToControls;
begin
  chbConfirmExit.Checked := ConfirmExit;
  chbConfirmCloseChild.Checked := ConfirmCloseChild;
  chbConfirmSave.Checked := ConfirmSave;
  chbShowScriptForm.Checked := ShowScriptForm;
  edPortalUser.Text := PortalUser;
  cbConnection.ItemIndex := CurrConnect;
  cbPortalDescriptor.Items.Text := DbDescriptors;
  cbConnectionChange(cbConnection);
  chbTreeShowDescriptor.Checked := TreeShowDescriptor;
  chbTreeRestorePos.Checked := TreeRestorePos;
  chbCheckUpdates.Checked := CheckUpdates;
  chbCheckUpdatesClick(chbCheckUpdates);
  edUpdatePath.Text := UpdatePath;
  edNetUser.Text := NetUser;
  edNetPass.Text := NetPass;
  cbMainDescriptor.Items.Text := DbDescriptors;
  cbMainDescriptor.ItemIndex := cbMainDescriptor.Items.IndexOf(MainDescriptor);
  cbChildWindowState.ItemIndex := Ord(ChildWindowState);
  chbSaveColumns.Checked := GridSaveColumns;
  chbRestoreSession.Checked := RestoreSession;
  cbShedulerConnect.ItemIndex := ShedulerConnect;
  cbEnsConnect.ItemIndex := EnsConnect;
  cbUpdateConnect.ItemIndex := UpdateConnect;
  cbTreeCacheConnect.Items.Text := DbDescriptors;
  cbTreeCacheConnect.ItemIndex := cbTreeCacheConnect.Items.IndexOf(TreeCacheConnect);
  chbRememberHistory.Checked := RememberHistory;
  chbSelSqlAddTitle.Checked := SelSqlAddTitle;
  SetGridToControls;
  SetPagesToControls;
end;

function TFSettings.TestConnect(var ErrMsg: string): boolean;
var
  s: string;

begin
  ErrMsg := '';
  if cbServer.ItemIndex <> 0 then
  begin
    result := TestConnectNoFB(ErrMsg);
    exit;
  end;

  if dbTest.Connected then dbTest.Close;
  if edHost.Text <> '' then
  begin
    if edPort.Value = 3050 then s := edHost.Text
    else s := edHost.Text + '/' + IntToStr(edPort.Value);
    s := s + ':';
  end;
  dbTest.DBName := s + edDataBase.Text;
  dbTest.ConnectParams.UserName := edUser.Text;
  dbTest.ConnectParams.Password := Trim(edPass.Text);
  dbTest.ConnectParams.RoleName := edRole.Text;
  dbTest.ConnectParams.CharSet := cbCharset.Text;
  dbTest.SQLDialect := StrToInt(cbSQLDialect.Items[cbSQLDialect.ItemIndex]);

  try
    dbTest.Open;
  except
    on e: Exception do
    begin
      if Pos('user name and password', e.Message) > 0 then ErrMsg := ProhibMes[0]
      else if Pos('I/O error', e.Message) > 0 then ErrMsg := Format(ProhibMes[1], [dbTest.DBName])
      else if Pos('network request', e.Message) > 0 then ErrMsg := Format(ProhibMes[2], [ExtractWordEx(1, dbTest.DBName, [':'], [])])
      else if (Pos('SQL error', e.Message) > 0) or (Pos('Parameter', e.Message) > 0) then ErrMsg := Format(ProhibMes[3], [e.Message])
      else ErrMsg := Format(ProhibMes[3], [e.Message]);
    end;
  end;

  result := dbTest.Connected;
  dbTest.Close;
end;

function TFSettings.TestConnectNoFB(var ErrMsg: string): boolean;
begin
  result := false;
  ErrMsg := 'Подключение не настроено!';

  if SqlConn.Connected then SqlConn.Close;
  case cbServer.ItemIndex of
    1:
    begin
      SqlConn.ProviderName := 'Oracle';
      SqlConn.SpecificOptions.Values['Oracle.UseUnicode'] := 'True';
      //SqlConn.SpecificOptions.Values['Oracle.Schema'] := edRole.Text;
    end;
    2:
    begin
      SqlConn.ProviderName := 'PostgreSQL';
      SqlConn.SpecificOptions.Values['PostgreSQL.UseUnicode'] := 'True';
      SqlConn.SpecificOptions.Values['PostgreSQL.Charset'] := cbCharset.Text;
      //SqlConn.SpecificOptions.Values['PostgreSQL.Schema'] := edRole.Text;
    end;
    3:
    begin
      SqlConn.ProviderName := 'MySQL';
      SqlConn.SpecificOptions.Values['MySQL.UseUnicode'] := 'True';
      SqlConn.SpecificOptions.Values['MySQL.Charset'] := cbCharset.Text;
    end;
    else exit;
  end;
  ErrMsg := '';

  SqlConn.Server := edHost.Text;
  SqlConn.Port := edPort.Value;
  SqlConn.Database := edDataBase.Text;
  SqlConn.Username := edUser.Text;
  SqlConn.Password := edPass.Text;
  try
    SqlConn.Open;
  except
    on e: Exception do ErrMsg := Format(ProhibMes[3], [e.Message]);
  end;

  result := SqlConn.Connected;
  SqlConn.Close;
end;

procedure TFSettings.tvPartitionChange(Sender: TObject; Node: TTreeNode);
begin
  ChangePartControls(Node.AbsoluteIndex);
end;

procedure TFSettings.tvPartitionCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Node.HasChildren then
    Sender.Canvas.Font.Style := Sender.Canvas.Font.Style + [fsBold];

  if (cdsSelected in State) then
  begin
    Sender.Canvas.Font.Color := clMaroon;
    Sender.Canvas.Font.Style := Sender.Canvas.Font.Style + [fsBold];
  end;
end;

end.
