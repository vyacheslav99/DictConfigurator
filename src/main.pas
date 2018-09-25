unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, settings, utils, fib, FIBDatabase,
  pFIBDatabase, ComCtrls, ActnList, ImgList, pFIBErrorHandler, ExtCtrls, JvExComCtrls, JvDBTreeView, DB, FIBDataSet,
  pFIBDataSet, Menus, StdCtrls, JvComCtrls, WDGradient, DBGridEhGrouping, GridsEh, DBGridEh, ToolWin, FIBQuery, pFIBQuery,
  DBAccess, Uni, UniProvider, PostgreSQLUniProvider, OracleUniProvider, MySQLUniProvider, InterBaseUniProvider, dbUtils,
  ShellAPI, find, JvComponentBase, JvTabBar, IniFiles, updates, childForm, MemTableDataEh, MemTableEh, Registry, hintView,
  AppEvnts, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdFTP, JvDBGridExport,
  DBGrids, XLSExportComp, CryptUtils;

type
  TFMain = class(TForm)
    Database: TpFIBDatabase;
    Transact: TpFIBTransaction;
    StatusBar: TStatusBar;
    ActionList: TActionList;
    ASettings: TAction;
    ilMain: TImageList;
    ilTree: TImageList;
    pTree: TPanel;
    Splitter1: TSplitter;
    Panel1: TPanel;
    pcDictTree: TPageControl;
    tsOnFolder: TTabSheet;
    tsOnlyDict: TTabSheet;
    dsTreeFolder: TpFIBDataSet;
    AExit: TAction;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    AReconnect: TAction;
    N5: TMenuItem;
    chbGetOnlyUser: TCheckBox;
    AExpandAll: TAction;
    ACollapseAll: TAction;
    pmTree: TPopupMenu;
    N6: TMenuItem;
    N7: TMenuItem;
    Bevel1: TBevel;
    Label1: TLabel;
    tvMain: TJvTreeView;
    dsTreeFolderPK: TFIBIntegerField;
    dsTreeFolderNAME: TFIBStringField;
    dsTreeFolderPARENT_FOLDER_PK: TFIBIntegerField;
    dsTreeDict: TpFIBDataSet;
    dsTreeDictPK: TFIBIntegerField;
    dsTreeDictDESCRIPTOR_: TFIBStringField;
    dsTreeDictTITLE: TFIBStringField;
    dsTreeDictNAME: TFIBStringField;
    dsTreeDictPARENT_REFERENCE_PK: TFIBIntegerField;
    dsTreeDictFOLDER_PK: TFIBIntegerField;
    dsTreeDictLOGIN: TFIBStringField;
    tvDict: TJvTreeView;
    dsTreeDict2: TpFIBDataSet;
    dsTreeDict2PK: TFIBIntegerField;
    dsTreeDict2DESCRIPTOR_: TFIBStringField;
    dsTreeDict2TITLE: TFIBStringField;
    dsTreeDict2NAME: TFIBStringField;
    dsTreeDict2PARENT_REFERENCE_PK: TFIBIntegerField;
    dsTreeDict2FOLDER_PK: TFIBIntegerField;
    dsTreeDict2LOGIN: TFIBStringField;
    tsForm: TTabSheet;
    tvForm: TJvTreeView;
    dsTreeForm: TpFIBDataSet;
    dsTreeFormPK: TFIBIntegerField;
    dsTreeFormTITLE: TFIBStringField;
    dsTreeFormALIAS_FORM: TFIBStringField;
    dsTreeFormLOGIN: TFIBStringField;
    dsTreeFormNAME: TFIBStringField;
    dsFormInfo: TpFIBDataSet;
    dsFormInfoPK: TFIBIntegerField;
    dsFormInfoTITLE: TFIBStringField;
    dsFormInfoALIAS_FORM: TFIBStringField;
    dsFormInfoCREATE_: TFIBDateTimeField;
    dsFormInfoMODIFY: TFIBDateTimeField;
    dsFormInfoWIDTH: TFIBIntegerField;
    dsFormInfoHEIGHT: TFIBIntegerField;
    dsFormReference: TpFIBDataSet;
    dsFormInfoUSER_NAME: TFIBStringField;
    dsFormReferencePK: TFIBIntegerField;
    dsFormReferenceDESCRIPTOR_: TFIBStringField;
    dsFormReferenceTITLE: TFIBStringField;
    dsFormReferenceOWNER_USER_PK: TFIBIntegerField;
    dsFormReferenceLOGIN: TFIBStringField;
    dsFormReferenceUSERNAME: TFIBStringField;
    dsFormReferenceFOLDER_PK: TFIBIntegerField;
    dsFormReferenceFOLDER_NAME: TFIBStringField;
    dsFormReferenceFORM_TYPE: TFIBIntegerField;
    dsFormWizard: TpFIBDataSet;
    dsFormWizardPK: TFIBIntegerField;
    dsFormWizardNAME: TFIBStringField;
    dsFormWizardSCEN_TYPE: TFIBStringField;
    dsFormWizardDESCRIPTOR_: TFIBStringField;
    dsFormWizardREF_PK: TFIBIntegerField;
    dsFormWizardREF_DESCRIPTOR: TFIBStringField;
    dsFormWizardREF_TITLE: TFIBStringField;
    tsWizard: TTabSheet;
    dsFolderFolders: TpFIBDataSet;
    dsFolderFoldersPK: TFIBIntegerField;
    dsFolderFoldersNAME: TFIBStringField;
    dsFolderReference: TpFIBDataSet;
    dsFolderReferencePK: TFIBIntegerField;
    dsFolderReferenceDESCRIPTOR_: TFIBStringField;
    dsFolderReferenceTITLE: TFIBStringField;
    dsFolderReferenceOWNER_USER_PK: TFIBIntegerField;
    dsFolderReferenceLOGIN: TFIBStringField;
    dsFolderReferenceUSERNAME: TFIBStringField;
    dsDictInfo: TpFIBDataSet;
    dsDictInfoPK: TFIBIntegerField;
    dsDictInfoDESCRIPTOR_: TFIBStringField;
    dsDictInfoTITLE: TFIBStringField;
    dsDictInfoCREATE_: TFIBDateTimeField;
    dsDictInfoMODIFY: TFIBDateTimeField;
    dsDictInfoBASE_DESCRIPTOR: TFIBStringField;
    dsDictInfoOWNER_USER_PK: TFIBIntegerField;
    dsDictInfoLOGIN: TFIBStringField;
    dsDictInfoUSERNAME: TFIBStringField;
    dsDictInfoPARENT_REFERENCE_PK: TFIBIntegerField;
    dsDictInfoPARENT_DESCRIPTOR: TFIBStringField;
    dsDictInfoPARENT_TITLE: TFIBStringField;
    dsDictInfoFOLDER_PK: TFIBIntegerField;
    dsDictInfoFOLDER_NAME: TFIBStringField;
    dsDictInfoMAIN_FORM_PK: TFIBIntegerField;
    dsDictInfoMAIN_FORM_ALIAS: TFIBStringField;
    dsDictInfoMAIN_FORM_TITLE: TFIBStringField;
    dsDictInfoSTART_FORM_PK: TFIBIntegerField;
    dsDictInfoSTART_FORM_ALIAS: TFIBStringField;
    dsDictInfoSTART_FORM_TITLE: TFIBStringField;
    dsDictInfoGROUP_EDIT_FORM_PK: TFIBIntegerField;
    dsDictInfoGROUP_FORM_ALIAS: TFIBStringField;
    dsDictInfoGROUP_FORM_TITLE: TFIBStringField;
    dsDictReference: TpFIBDataSet;
    dsDictReferencePK: TFIBIntegerField;
    dsDictReferenceDESCRIPTOR_: TFIBStringField;
    dsDictReferenceTITLE: TFIBStringField;
    dsDictReferenceOWNER_USER_PK: TFIBIntegerField;
    dsDictReferenceLOGIN: TFIBStringField;
    dsDictReferenceUSERNAME: TFIBStringField;
    dsDictWizard: TpFIBDataSet;
    dsDictWizardPK: TFIBIntegerField;
    dsDictWizardNAME: TFIBStringField;
    dsDictWizardSCEN_TYPE: TFIBStringField;
    dsDictWizardDESCRIPTOR_: TFIBStringField;
    tvWizard: TJvTreeView;
    ilPages: TImageList;
    dsTreeWizard: TpFIBDataSet;
    dsWizardInfo: TpFIBDataSet;
    dsWizardInfoPK: TFIBIntegerField;
    dsWizardInfoNAME: TFIBStringField;
    dsWizardInfoSCEN_TYPE: TFIBStringField;
    dsWizardInfoDESCRIPTOR_: TFIBStringField;
    dsWizardInfoREF_PK: TFIBIntegerField;
    dsWizardInfoREF_DESCRIPTOR: TFIBStringField;
    dsWizardInfoREF_TITLE: TFIBStringField;
    dsWizardInfoOWNER_USER_PK: TFIBIntegerField;
    dsWizardInfoLOGIN: TFIBStringField;
    dsWizardInfoUSERNAME: TFIBStringField;
    dsWizardForm: TpFIBDataSet;
    dsWizardFormFORM_PK: TFIBIntegerField;
    dsWizardFormTITLE: TFIBStringField;
    dsWizardFormALIAS_FORM: TFIBStringField;
    dsTreeWizardPK: TFIBIntegerField;
    dsTreeWizardNAME: TFIBStringField;
    dsTreeWizardSCEN_TYPE: TFIBStringField;
    dsTreeWizardDESCRIPTOR_: TFIBStringField;
    dsTreeWizardREF_PK: TFIBIntegerField;
    dsTreeWizardLOGIN: TFIBStringField;
    dsTreeWizardTITLE: TFIBStringField;
    dsPortalUser: TpFIBDataSet;
    AAddNode: TAction;
    AEditNode: TAction;
    ADelNode: TAction;
    N8: TMenuItem;
    mmiAddNode: TMenuItem;
    N10: TMenuItem;
    mmiDelNode: TMenuItem;
    N12: TMenuItem;
    pmiAddNode: TMenuItem;
    N14: TMenuItem;
    pmiDelNode: TMenuItem;
    N16: TMenuItem;
    AUserInfo: TAction;
    dsTreeFolderTITLE: TFIBStringField;
    AAddChildNode: TAction;
    N19: TMenuItem;
    N9: TMenuItem;
    N22: TMenuItem;
    AViewNode: TAction;
    N11: TMenuItem;
    N15: TMenuItem;
    AGenSQL: TAction;
    SaveDialog: TSaveDialog;
    SQL1: TMenuItem;
    N13: TMenuItem;
    N18: TMenuItem;
    SQL2: TMenuItem;
    AOpenInBrowser: TAction;
    N20: TMenuItem;
    N21: TMenuItem;
    tmrAutoUpdate: TTimer;
    ACheckUpdates: TAction;
    N23: TMenuItem;
    AAbout: TAction;
    N24: TMenuItem;
    ADisconnect: TAction;
    N26: TMenuItem;
    N17: TMenuItem;
    dsFormReferencePARENT_REFERENCE_PK: TFIBIntegerField;
    dsFolderReferencePARENT_REFERENCE_PK: TFIBIntegerField;
    dsFolderReferenceFOLDER_PK: TFIBIntegerField;
    dsDictReferencePARENT_REFERENCE_PK: TFIBIntegerField;
    dsDictReferenceFOLDER_PK: TFIBIntegerField;
    dsFormWizardLOGIN: TFIBStringField;
    dsDictWizardREF_PK: TFIBIntegerField;
    dsDictWizardLOGIN: TFIBStringField;
    dsFolderFoldersPARENT_FOLDER_PK: TFIBIntegerField;
    dsWizardFormLOGIN: TFIBStringField;
    AFind: TAction;
    AFindNext: TAction;
    N25: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    cbFilter: TComboBox;
    WindowBar: TJvTabBar;
    WindowBarPainter: TJvModernTabBarPainter;
    ANextWindow: TAction;
    APrewWindow: TAction;
    ACopyObject: TAction;
    N32: TMenuItem;
    N33: TMenuItem;
    miWindow: TMenuItem;
    N34: TMenuItem;
    ACloseAll: TAction;
    N35: TMenuItem;
    AMinimizeAll: TAction;
    ARestoreAll: TAction;
    AMaximizeAll: TAction;
    N36: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    N40: TMenuItem;
    lbMainTreeMessage: TLabel;
    lbDictTreeMessage: TLabel;
    lbFormTreeMessage: TLabel;
    lbWizardTreeMessage: TLabel;
    AGenBranchSQL: TAction;
    N39: TMenuItem;
    N41: TMenuItem;
    ARefreshTree: TAction;
    N42: TMenuItem;
    N43: TMenuItem;
    ACloseChildForm: TAction;
    AChangeOwner: TAction;
    N46: TMenuItem;
    N47: TMenuItem;
    AAddGrantOnConfigDict: TAction;
    N48: TMenuItem;
    N49: TMenuItem;
    N50: TMenuItem;
    N51: TMenuItem;
    ADelGrantOnConfigDict: TAction;
    N52: TMenuItem;
    N53: TMenuItem;
    N54: TMenuItem;
    dsWizardFormREF_PK: TFIBIntegerField;
    dsWizardFormREF_DESCRIPTOR: TFIBStringField;
    dsWizardFormREF_TITLE: TFIBStringField;
    AOpenUsers: TAction;
    N55: TMenuItem;
    AOpenGroups: TAction;
    N56: TMenuItem;
    Splitter2: TSplitter;
    dbgObjectInfo: TDBGridEh;
    dsoObjectInfo: TDataSource;
    mtObjectInfo: TMemTableEh;
    mtObjectInfoNAME: TStringField;
    mtObjectInfoVALUE: TStringField;
    tmrOpen: TTimer;
    AMinimize: TAction;
    ARestore: TAction;
    AMaximize: TAction;
    mtObjectInfoPK: TIntegerField;
    mtObjectInfoTYPE: TIntegerField;
    AJsonReader: TAction;
    N57: TMenuItem;
    ADelBranch: TAction;
    N58: TMenuItem;
    N59: TMenuItem;
    miShowHint: TMenuItem;
    AppEvents: TApplicationEvents;
    ATaskSheduler: TAction;
    N60: TMenuItem;
    DBTask: TpFIBDatabase;
    TransTask: TpFIBTransaction;
    AFindByObject: TAction;
    N61: TMenuItem;
    tsHistory: TTabSheet;
    tvHistory: TJvTreeView;
    qSaveHistory: TpFIBQuery;
    dsTreeHistory: TpFIBDataSet;
    dsTreeHistoryOBJ_PK: TFIBIntegerField;
    dsTreeHistoryOBJ_TYPE: TFIBIntegerField;
    dsTreeHistoryTYPE_: TFIBStringField;
    dsTreeHistoryUSER_PK: TFIBIntegerField;
    ALikeObject: TAction;
    ADislikeObject: TAction;
    AClearHistory: TAction;
    N63: TMenuItem;
    N64: TMenuItem;
    N65: TMenuItem;
    N66: TMenuItem;
    N67: TMenuItem;
    N68: TMenuItem;
    dsTreeHistoryLASTDATE: TFIBDateTimeField;
    AHelp: TAction;
    N69: TMenuItem;
    dsTreeHistoryOBJ_NAME: TFIBStringField;
    ACrStat: TAction;
    N70: TMenuItem;
    AEnsTask: TAction;
    ENS1: TMenuItem;
    N71: TMenuItem;
    dsPortalUserPK: TFIBIntegerField;
    dsPortalUserLOGIN: TFIBStringField;
    dsPortalUserNAME: TFIBStringField;
    dsPortalUserEMAIL: TFIBStringField;
    dsPortalUserDEVELOPER: TFIBStringField;
    dsPortalUserMODERATOR: TFIBStringField;
    dsPortalUserISACTIVE: TFIBStringField;
    dsPortalUserROLE_PK: TFIBIntegerField;
    dsPortalUserROLE_NAME: TFIBStringField;
    dsPortalUserISOPINION: TFIBStringField;
    dsPortalUserI_BOSS: TFIBStringField;
    dsPortalUserI_MODERATOR: TFIBStringField;
    dsPortalUserISCONTENDER: TFIBStringField;
    dsPortalUserHOLIDAY: TFIBStringField;
    dsPortalUserCODE_1C: TFIBStringField;
    dsPortalUserBRANCH_PK: TFIBIntegerField;
    dsPortalUserBRANCH_NAME: TFIBStringField;
    dsPortalUserUNIT_PK: TFIBIntegerField;
    dsPortalUserUNIT_NAME: TFIBStringField;
    dsPortalUserDEPARTMENT: TFIBStringField;
    dsPortalUserOFFICE: TFIBStringField;
    dsPortalUserCHAPTER: TFIBStringField;
    dsPortalUserSECTOR: TFIBStringField;
    dsFolderInfo: TpFIBDataSet;
    dsFolderInfoPK: TFIBIntegerField;
    dsFolderInfoNAME: TFIBStringField;
    dsFolderInfoPARENT_FOLDER_PK: TFIBIntegerField;
    dsFolderInfoPARENT_NAME: TFIBStringField;
    AGroupAction: TAction;
    N72: TMenuItem;
    N73: TMenuItem;
    N74: TMenuItem;
    ACopyRefLink: TAction;
    N75: TMenuItem;
    N76: TMenuItem;
    N77: TMenuItem;
    FTPClient: TIdFTP;
    dsGetUpdate: TpFIBDataSet;
    dsGetUpdatePK: TFIBIntegerField;
    dsGetUpdateNAME: TFIBStringField;
    dsGetUpdateFILE_NAME: TFIBStringField;
    dsGetUpdateVERSTR: TFIBStringField;
    dsGetUpdateDESCR: TFIBStringField;
    dsGetUpdateFILE_DATA: TFIBBlobField;
    DBUpdate: TpFIBDatabase;
    TransUpdate: TpFIBTransaction;
    dsGetUpdateDATE_UPDATE: TFIBDateTimeField;
    dsGetHelp: TpFIBDataSet;
    dsGetHelpHELP_FILE: TFIBBlobField;
    AGenBranchWizardSQL: TAction;
    N79: TMenuItem;
    N80: TMenuItem;
    AGenDictWizardsSQL: TAction;
    N29: TMenuItem;
    N30: TMenuItem;
    AHistory: TAction;
    N31: TMenuItem;
    N44: TMenuItem;
    ADumpObjects: TAction;
    N45: TMenuItem;
    N62: TMenuItem;
    N78: TMenuItem;
    CtrlF1: TMenuItem;
    N81: TMenuItem;
    N82: TMenuItem;
    N83: TMenuItem;
    N84: TMenuItem;
    N85: TMenuItem;
    tmrEndSession: TTimer;
    DBGridCSVExport: TJvDBGridCSVExport;
    dsGetUpdateFILE_SIZE: TFIBIntegerField;
    dsGetUpdateMD5: TFIBStringField;
    AGenPermissionsSQL: TAction;
    N86: TMenuItem;
    N87: TMenuItem;
    dsObjectsList: TpFIBDataSet;
    tmrLoadDbObjects: TTimer;
    dsObjectsListNAME: TFIBStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DatabaseAfterConnect(Sender: TObject);
    procedure DatabaseAfterDisconnect(Sender: TObject);
    procedure ASettingsExecute(Sender: TObject);
    procedure AExitExecute(Sender: TObject);
    procedure AReconnectExecute(Sender: TObject);
    procedure chbGetOnlyUserClick(Sender: TObject);
    procedure AExpandAllExecute(Sender: TObject);
    procedure ACollapseAllExecute(Sender: TObject);
    procedure tvMainExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
    procedure tvMainDeletion(Sender: TObject; Node: TTreeNode);
    procedure tvMainCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure tvMainChange(Sender: TObject; Node: TTreeNode);
    procedure pcDictTreeChange(Sender: TObject);
    procedure dsPortalUserAfterClose(DataSet: TDataSet);
    procedure AAddNodeExecute(Sender: TObject);
    procedure AAddNodeUpdate(Sender: TObject);
    procedure AEditNodeExecute(Sender: TObject);
    procedure ADelNodeExecute(Sender: TObject);
    procedure AEditNodeUpdate(Sender: TObject);
    procedure AUserInfoExecute(Sender: TObject);
    procedure tvMainDblClick(Sender: TObject);
    procedure AViewNodeExecute(Sender: TObject);
    procedure AGenSQLExecute(Sender: TObject);
    procedure AOpenInBrowserExecute(Sender: TObject);
    procedure tmrAutoUpdateTimer(Sender: TObject);
    procedure ACheckUpdatesExecute(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
    procedure FormResize(Sender: TObject);
    procedure AAboutExecute(Sender: TObject);
    procedure ADisconnectExecute(Sender: TObject);
    procedure AFindExecute(Sender: TObject);
    procedure cbFilterKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure WindowBarTabSelected(Sender: TObject; Item: TJvTabBarItem);
    procedure ANextWindowUpdate(Sender: TObject);
    procedure ANextWindowExecute(Sender: TObject);
    procedure ACopyObjectExecute(Sender: TObject);
    procedure ACloseAllUpdate(Sender: TObject);
    procedure ACloseAllExecute(Sender: TObject);
    procedure AMinimizeAllExecute(Sender: TObject);
    procedure AGenBranchSQLUpdate(Sender: TObject);
    procedure AGenBranchSQLExecute(Sender: TObject);
    procedure ARefreshTreeExecute(Sender: TObject);
    procedure ACloseChildFormExecute(Sender: TObject);
    procedure AChangeOwnerExecute(Sender: TObject);
    procedure AAddGrantOnConfigDictUpdate(Sender: TObject);
    procedure AAddGrantOnConfigDictExecute(Sender: TObject);
    procedure ADelGrantOnConfigDictExecute(Sender: TObject);
    procedure AOpenUsersExecute(Sender: TObject);
    procedure tmrOpenTimer(Sender: TObject);
    procedure AMinimizeExecute(Sender: TObject);
    procedure ADelBranchExecute(Sender: TObject);
    procedure miShowHintClick(Sender: TObject);
    procedure AppEventsHint(Sender: TObject);
    procedure AFindByObjectExecute(Sender: TObject);
    procedure ALikeObjectExecute(Sender: TObject);
    procedure ADislikeObjectUpdate(Sender: TObject);
    procedure ADislikeObjectExecute(Sender: TObject);
    procedure AClearHistoryExecute(Sender: TObject);
    procedure AHelpExecute(Sender: TObject);
    procedure tvMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBTaskAfterConnect(Sender: TObject);
    procedure DBTaskBeforeDisconnect(Sender: TObject);
    procedure AGroupActionExecute(Sender: TObject);
    procedure ACopyRefLinkExecute(Sender: TObject);
    procedure AGenBranchWizardSQLExecute(Sender: TObject);
    procedure AGenDictWizardsSQLExecute(Sender: TObject);
    procedure AHistoryExecute(Sender: TObject);
    procedure ADumpObjectsExecute(Sender: TObject);
    procedure tmrEndSessionTimer(Sender: TObject);
    procedure AppEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure AGenPermissionsSQLExecute(Sender: TObject);
    procedure tmrLoadDbObjectsTimer(Sender: TObject);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  private
    ForcedTerminate: boolean;
    DenyLoadTree: boolean;
    OpenedFormCount: integer;
    ChildForms: array of TChildForm;
    NoLoadInfo: boolean;
    IsAdmin: boolean;
    IsDeveloper: boolean;
    IsActive: boolean;
    AvailableUpdate: boolean;
    AskUpdate: boolean;
    CollapseAfterFind: boolean;
    Filtered: boolean;
    FHint: TFHint;
    FNoHistory: boolean;
    // работа с немодальными дочерними формами
    procedure ClearChildForms;
    procedure AddFormButton(FormIndex: integer; FCaption, FHint: string; ImageIndex: integer);
    procedure AddWindowMenuItem(FormIndex: integer; FCaption, FHint: string; ImageIndex: integer);
    function GetButtonIndex(FormIndex: integer): integer;
    function GetMenuIndex(FormIndex: integer): integer;
    function GetCheckedFormIndex: integer;
    procedure WindowMenuClick(Sender: TObject);
    procedure ChangeFormMenuCaption(FormIndex: integer; NewCaption, NewHint: string);
    function FindChildForm(FormType: TChildFormType; Mode: TOpenMode; Pk, Descriptor: Variant): integer; overload;
    function FindChildForm(ObjType: TConfObjectType; Pk: Variant): integer; overload;
    // всяко-разно
    procedure SaveWndState;
    function GetCurrentTreeView: TJvTreeView;
    function GetTreeView(Page: TTabSheet): TJvTreeView;
    procedure ShowUserInfo;
    function SelObjectDialog: integer;
    procedure CheckUpdates(Warn: boolean);
    function GetUpdateInfoNet: TUpdateInfo;
    function GetUpdateInfoDB(FromVer: string): TUpdateInfo;
    function CompareNodeData(Str: string; Data: TNodeDictInfo; Options: TFindOptions): boolean;
    procedure Find(AContinue: boolean = false);
    procedure FindByObjectDB;
    function FindInNodes(StartNode: TTreeNode; CheckCurrent: boolean; Str: string; Options: TFindOptions; ShowMsg: boolean = true): boolean;
    function FindInChildNodes(ParentNode: TTreeNode; Str: string; Options: TFindOptions): boolean;
    procedure TvSelectNode(Node: TTreeNode);
    procedure SelectNode(tv: TJvTreeView; PK: Variant);
    procedure Filter(NoReload: boolean);
    procedure CleanFilter(NoReload: boolean);
    procedure DoFilter(tv: TJvTreeView);
    procedure FilterNodes(StartNode: TTreeNode; Str: string; Options: TFindOptions);
    function FilterChildNodes(ParentNode: TTreeNode; Str: string; Options: TFindOptions): boolean;
    procedure UpdateFilterHistory;
    procedure SaveTreePositions;
    procedure RestoreTreePositions;
    procedure SaveSession;
    procedure LoadSession;
    procedure SetGridsOptions;
    procedure SaveGridsParams;
    procedure GetChildRefList(ParentPk: integer; RefList: TStringList);
    procedure SetPages(NoReload: boolean);
    function GetHistoryParent(HistType: THistoryType): TTreeNode;
    procedure WMForcedTerminate(var Msg: TMessage); message U_WM_FORCED_TERMINATE;
    function GetRefLink(DictInfo: TNodeDictInfo): string;
    // загрузка данных
    procedure Connect;
    procedure ConnectToUpdate;
    procedure OpenConfiguration;
    procedure CloseConfiguration;
    procedure LostConnect(Connection: TObject; ErrorMessage: string);
    procedure LoadObjectList(List: TStringList);
    //function NodeMatchFilterValue(NodePk: integer; NodeText, FilterStr: string; IsFolder: boolean): boolean;
    procedure ReopenTree(TreeCanFocus: boolean = true);
    procedure AddSubnodesDict(TreeView: TJvTreeView; AddChild: boolean; Parent: TTreeNode; ds: TpFIBDataSet; ImageShift: integer;
      IsFolder: boolean);
    procedure AddSubnodesForm(TreeView: TJvTreeView; Parent: TTreeNode; ds: TpFIBDataSet);
    procedure AddSubnodesWizard(TreeView: TJvTreeView; Parent: TTreeNode; ds: TpFIBDataSet);
    procedure AddSubnodesHist(TreeView: TJvTreeView; Parent: TTreeNode; ds: TpFIBDataSet; ObjType: TConfObjectType; HistType: THistoryType);
    procedure LoadChildNodes(TreeView: TJvTreeView; Parent: TTreeNode);
    procedure LoadChildNodes2(TreeView: TJvTreeView; Parent: TTreeNode);
    procedure LoadHistory(TreeView: TJvTreeView);
    procedure LoadHistoryItems(Node: TTreeNode; HistType: THistoryType; ParentPk: Variant; Order: string);
    procedure LoadObjectInfo(NodeData: TNodeDictInfo);
    // редактирование (и просмотр) данных
    procedure AddTreeNode(TreeView: TJvTreeView; ParentNode: TTreeNode);
    procedure EditTreeNode(Node: TTreeNode);
    procedure DelTreeNode(Node: TTreeNode; Recursive: boolean = false);
    procedure ViewTreeNode(Node: TTreeNode);
    procedure ChangeObjectOwner(Node: TTreeNode);
    procedure CreateFolder(ParentData: TNodeDictInfo);
    procedure CreateDict(ParentData: TNodeDictInfo);
    procedure CreateForm;
    procedure CreateLikedFolder;
    procedure EditFolder(Data: TNodeDictInfo);
    procedure EditLikedFolder(Data: TNodeDictInfo);
    procedure DelFolder(Data: TNodeDictInfo);
    function DelFolderFull(Data: TNodeDictInfo; Ask: boolean = true): boolean;
    procedure DelDict(Data: TNodeDictInfo);
    procedure DelForm(Data: TNodeDictInfo);
    procedure DelLikedFolder(Data: TNodeDictInfo);
    procedure ViewFolder(Data: TNodeDictInfo);
    procedure ViewDict(Data: TNodeDictInfo);
    procedure ViewForm(Data: TNodeDictInfo);
    procedure ChangeDictOwner(Data: TNodeDictInfo);
    procedure ChangeFormOwner(Data: TNodeDictInfo);
    procedure AddGrantOnConfigDict(Data: TNodeDictInfo);
    procedure DelGrantOnConfigDict(Data: TNodeDictInfo);
    procedure AddToHistory(Data: TNodeDictInfo; HistType: THistoryType);
    procedure DelFromHistory(Data: TNodeDictInfo; HistType: THistoryType);
    procedure ClearHistory(HistType: THistoryType);
    // инструменты
    procedure OpenInstrument(InstrType: TChildFormType; InstrName: string);
    // генерация скриптов объектов
    // основные
    procedure GenBranchSQL(FolderPK: integer; Script, Folders: TStringList);
    procedure GenBranchWizardSQL(FolderPK: integer; Script, Wizards: TStringList);
    procedure GenFolderSQL(Pk: integer; Script, Folders: TStringList; IsMain: boolean = true);
    procedure GenDictSQL(Pk: integer; Script, Folders: TStringList; IsMain: boolean = true);
    procedure GenFormSQL(Pk: integer; Script: TStringList; IsMain: boolean = true; SimpleMode: boolean = false);
    procedure GenWizardOnDictSQL(RefPk: integer; Script, Wizards: TStringList);
    procedure GenWizardSQL(Pk: integer; Script: TStringList);
    procedure GenWizardStatesSQL(Pk: integer; StatesPk: string; Script: TStringList);
    procedure GenDictPermissionsSQL(Pk: integer; Script: TStringList);
    // вспомогательные (вызываются только из основных)
    procedure GenDictAllFieldsSQL(Pk: integer; Script: TStringList);
    procedure GenObjectTreeSQL(Pk: integer; Script: TStringList; IsMain: boolean = true);
    procedure GenFieldGroupSQL(Pk: integer; Script: TStringList; IsMain: boolean = true);
    procedure GenFieldSQL(Pk: integer; Script: TStringList; IsMain: boolean = true);
    procedure GenTreeIndexSQL(PkEl, PkRef: integer; Script: TStringList; IsMain: boolean = true);
    procedure GenChartGroupSQL(Pk: integer; Script: TStringList; IsMain: boolean = true);
    procedure GenChartSQL(Pk: integer; Script: TStringList; IsMain: boolean = true);
    procedure GenFilterConfigSQL(Pk: integer; Script: TStringList; IsMain: boolean = true);
    procedure GenFilterGroupSQL(Pk: integer; Script: TStringList; IsMain: boolean = true);
    procedure GenPostFilterSQL(Pk: integer; Script: TStringList; IsMain: boolean = true);
    procedure GenOtherEventSQL(Pk: integer; Script: TStringList; IsMain: boolean = true);
    procedure GenPermTmpSQL(Pk: integer; Script: TStringList; IsMain: boolean = true);
    procedure GenPermSQL(Pk: integer; TableName: string; Script: TStringList; IsMain: boolean = true);
    procedure GenWizardStateSQL(Pk: integer; Script: TStringList; IsMain: boolean = true);
    procedure GenWizardStateCrossSQL(Pk: integer; Script: TStringList);
    procedure GenWizardSlotSQL(Pk: integer; Script: TStringList; IsScen: boolean; IsMain: boolean = true);
    procedure GetObjectTreeList(FormPk: integer; ParentPk: Variant; ObjectList: TStringList);
    procedure GetDictAllFormsPK(RefPk: integer; PkList: TStringList);
    // методы мастера выгрузки объектов
    // копирование объекта
    procedure CopyObject(Node: TTreeNode);
    function CopyFolder(ObjPk: integer; var ErrorMessage: string): boolean;
    function CopyDict(ObjPk: integer; ParentRefPk: Variant; DictList, FormList, FieldsList, ObjectList, PermTmpList, ChartGroupList: TStringList;
      IsMain: boolean; var ErrorMessage: string): boolean;
    function CopyForm(ObjPk: integer; var ErrorMessage: string): boolean;
    function CopyWizard(ObjPk: integer; var ErrorMessage: string): boolean;
    // доп. методы для копирования объектов
    function CopyFormInternal(FormPk: integer; SimpleMode: boolean; FieldsList, ObjectList, GroupsList, FilterGroups: TStringList): Variant;
    procedure CopyPermsInternal(RefPk, NewRefPk: integer; TableName: string; PermTmpList: TStringList);
    procedure CopyChartsInternal(RefPk, NewRefPk: integer; FieldsList, ChartGroupList: TStringList);
    procedure CopyDictAllFields(RefPk: integer; FormList, FieldsList, ObjectList, GroupsList, FilterGroups: TStringList);
    procedure CopyFormFields(FormPk, NewFormPk: integer; BindObjects: boolean; FieldsList, ObjectList, GroupsList, FilterGroups: TStringList);
    procedure CopyWizardSlotsInternal(Pk, NewPk: integer; PkField: string; CrossList: TStringList);
    procedure OpenRef(Data: TNodeDictInfo);
    procedure OpenChildRef(ParentPk: integer);
  public
    ConnectChecker: TConnectChecker;
    DbObjectList: TStringList;
    // редактирование (и просмотр) данных
    function CheckGrants(Act: TGrantAction; Data: TNodeDictInfo; var Err: string): boolean;
    function CheckGrantsDepth(Act: TGrantAction; Data: TNodeDictInfo; var Err: string): boolean;
    function CreateWizard: TChildForm;
    procedure EditDict(Data: TNodeDictInfo);
    procedure EditForm(Data: TNodeDictInfo);
    procedure EditWizard(Data: TNodeDictInfo);
    function DelWizard(Data: TNodeDictInfo): boolean;
    procedure ViewWizard(Data: TNodeDictInfo);
    // выполнение sql
    function ExecSQL(SQL: string; var Err: string): boolean; overload;
    function ExecSQL(SQL, ParamName: string; var ParamValue: Variant; var Err: string): boolean; overload;
    function OpenSQL(SQL: string; Params: string = ''): TpFIBDataSet;
    // выгрузка объектов
    procedure SaveToSQL(Node: TTreeNode; FileName: string; Target: integer = 0); overload;
    procedure SaveToSQL(Data: TNodeDictInfo; FileName: string; Target: integer = 0; AddScen: boolean = false); overload;
    procedure SaveToSQL(Data: TNodeDictInfo; PkList: TStringList; FileName: string); overload;
    procedure SaveBranchToSQL(Node: TTreeNode; FileName: string); overload;
    procedure SaveBranchToSQL(Data: TNodeDictInfo; FileName: string); overload;
    procedure SaveBranchWizardToSQL(Node: TTreeNode; FileName: string); overload;
    procedure SaveBranchWizardToSQL(Data: TNodeDictInfo; FileName: string); overload;
    procedure WriteSQLHeader(Data: TNodeDictInfo; Rule: integer; Target: integer; Script: TStringList);
    procedure WriteSQLFooter(Data: TNodeDictInfo; Rule: integer; Target: integer; Script: TStringList);
    // методы мастера выгрузки объектов
    procedure ShowDumpObjectsMaster(Data: TNodeDictInfo);
    // прочее
    function SelUserDialog(var UserPk: Variant; SQLQuery: string; Title: string = ''; Msg: string = ''): boolean;
    function SelGroupDialog(var GroupPk: Variant; SQLQuery: string): boolean;
    function SelDictDialog(var DictPk: Variant; SQLQuery: string): boolean;
    function SelLikedFolderDialog(var Pk: Variant; SQLQuery: string): boolean;
    procedure OpenDictInBrowser(DictInfo: TNodeDictInfo);
    procedure CopyRefLinkToClip(DictInfo: TNodeDictInfo);
    procedure ActivateActions(ActList: TActionList; Value: boolean);
    function AddToRefLog(ObjType: TConfObjectType; Descriptor: string; Action: TRefLogType; Text: string = ''): boolean;
    procedure JumpToNode(ObjType: TConfObjectType; ObjKey: Variant);
    procedure ShowObjectHistory(Data: TNodeDictInfo);
    // работа с немодальными дочерними формами
    procedure RegisterChildForm(Form: TChildForm);
    procedure OnChildFormClose(Index: integer; CanRefresh: boolean);
    procedure CheckFormButton(FormIndex: integer);
    function SetFocusOpenedWindow(Pk: integer; FormClass: string): boolean;
    procedure ChangeFormButtonCaption(FormIndex: integer; NewCaption, NewHint: string);
    procedure GridKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    function GetChildCount: integer;
    procedure ExportToExcel(Grid: TDBGridEh; FileName: string);
    procedure ExportToCsv(Grid: TDBGridEh; FileName: string);
    procedure SetSaveDialogToSQL;
  end;

var
  FMain: TFMain;

implementation

{$R *.dfm}

uses UserInfo, connect, selObject, editFolder, editForm, editDict, editWizard, objectEditor, fieldEditor, groupEditor,
  chartEditor, chartGroupEditor, stateEditor, slotValEditor, slotEditor, crossEditor, selUser, users, groups, fmEditForm,
  jsonReader, filterConfigEditor, task, refList, crStat, ensTask, ensTaskEditor, groupAction, dbFind, history, dumpObjects;

procedure TFMain.AAboutExecute(Sender: TObject);
begin
  Application.MessageBox(pchar('Конфигуратор справочников портала'#13#10#13#10'Версия: ' + GetVersion(Application.ExeName)),
    'О программе', MB_OK + MB_ICONINFORMATION);
end;

procedure TFMain.AAddGrantOnConfigDictExecute(Sender: TObject);
begin
  if not GetCurrentTreeView.Focused then exit;
  AddGrantOnConfigDict(TNodeDictInfo(GetCurrentTreeView.Selected.Data));
end;

procedure TFMain.AAddGrantOnConfigDictUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Database.Connected and Assigned(GetCurrentTreeView.Selected) and
    (TNodeDictInfo(GetCurrentTreeView.Selected.Data).ObjType = cotDict);
end;

procedure TFMain.AAddNodeExecute(Sender: TObject);
begin
  if not GetCurrentTreeView.Focused then exit;
  if Sender = AAddNode then AddTreeNode(GetCurrentTreeView, nil)
  else if Sender = AAddChildNode then AddTreeNode(GetCurrentTreeView, GetCurrentTreeView.Selected)
  else exit;
end;

procedure TFMain.AAddNodeUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Database.Connected;
  if TAction(Sender).Enabled and ((Sender = AAddChildNode) or (Sender = AFindByObject)) then
    TAction(Sender).Enabled := (GetCurrentTreeView = tvMain) or (GetCurrentTreeView = tvDict) or (GetCurrentTreeView = tvHistory);
end;

procedure TFMain.AChangeOwnerExecute(Sender: TObject);
begin
  if not GetCurrentTreeView.Focused then exit;
  ChangeObjectOwner(GetCurrentTreeView.Selected);
end;

procedure TFMain.ACheckUpdatesExecute(Sender: TObject);
begin
  CheckUpdates(true);
end;

procedure TFMain.AClearHistoryExecute(Sender: TObject);
begin
  if (not GetCurrentTreeView.Focused) or (GetCurrentTreeView <> tvHistory) then exit;
  ClearHistory(htHistory);
end;

procedure TFMain.ACloseAllExecute(Sender: TObject);
begin
  if Application.MessageBox('Закрыть все дочерние окна? Все несохраненные изменения будут потеряны!', 'Подтверждение',
    MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

  ClearChildForms;
end;

procedure TFMain.ACloseAllUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := OpenedFormCount > 0;
end;

procedure TFMain.ACloseChildFormExecute(Sender: TObject);
var
  idx: integer;

begin
  idx := GetCheckedFormIndex;
  if (idx > -1) and (idx < Length(ChildForms)) and Assigned(ChildForms[idx]) then ChildForms[idx].Close;
end;

procedure TFMain.ACollapseAllExecute(Sender: TObject);
begin
  GetCurrentTreeView.FullCollapse;
end;

procedure TFMain.ADumpObjectsExecute(Sender: TObject);
begin
  if (not Assigned(GetCurrentTreeView.Selected)) or (not Assigned(GetCurrentTreeView.Selected.Data)) or
    (TNodeDictInfo(GetCurrentTreeView.Selected.Data).ObjType = cotNone) then exit;

  ShowDumpObjectsMaster(TNodeDictInfo(GetCurrentTreeView.Selected.Data));
end;

procedure TFMain.ACopyObjectExecute(Sender: TObject);
begin
  CopyObject(GetCurrentTreeView.Selected);
end;

procedure TFMain.ACopyRefLinkExecute(Sender: TObject);
var
  Node: TTreeNode;

begin
  if not Database.Connected then exit;

  Node := GetCurrentTreeView.Selected;

  if (not Assigned(Node)) or (not Assigned(Node.Data)) then
  begin
    Application.MessageBox('Не выбран узел!', 'Сообщение', MB_OK + MB_ICONINFORMATION);
    exit;
  end;

  if TNodeDictInfo(Node.Data).ObjType = cotDict then CopyRefLinkToClip(TNodeDictInfo(Node.Data));
end;

procedure TFMain.ActivateActions(ActList: TActionList; Value: boolean);
var
  i: integer;
  
begin
  if not Assigned(ActList) then exit;

  for i := 0 to ActList.ActionCount - 1 do
    TAction(ActList.Actions[i]).Enabled := Value;
end;

procedure TFMain.AddFormButton(FormIndex: integer; FCaption, FHint: string; ImageIndex: integer);
var
  b: boolean;
  item: TJvTabBarItem;

begin
  b := false;
  while Label1.Canvas.TextWidth(FCaption) > 240 do
  begin
    b := true;
    FCaption := Copy(FCaption, 1, Length(FCaption) - 1);
  end;
  if b then FCaption := FCaption + '...';

  item := WindowBar.AddTab(FCaption);
  item.Hint := FHint;
  item.Tag := FormIndex;
  item.ImageIndex := ImageIndex;
  AddWindowMenuItem(FormIndex, FCaption, FHint, ImageIndex);
  WindowBar.SelectedTab := item;
end;

procedure TFMain.AddGrantOnConfigDict(Data: TNodeDictInfo);
var
  err: string;
  res: boolean;
  pk: Variant;

begin
  if Data.ObjType <> cotDict then exit;

  // сначала права
  res := CheckGrants(gaRights, Data, err);

  if res then
  begin
    if not SelUserDialog(pk, 'select u.PK, u.LOGIN, u.NAME from USERS u where (u.ISACTIVE = ''1'') order by u.NAME') then exit;

    if VarIsNull(pk) then
    begin
      res := false;
      err := 'Не выбран пользователь!';
    end else
    begin
      res := ExecSQL('update or insert into DYNAMIC_FORM_REF_USER (REF_PK, USER_PK) values (' + VarToStr(TNodeDictInfo(Data).PK) + ', ' +
        VarToStr(pk) + ') matching (REF_PK, USER_PK)', err);
      if res then AddToRefLog(Data.ObjType, Data.Descriptor, rltUpdate, 'Добавление прав на конфигурацию. Полюзователь ' + VarToStr(pk));
    end;
  end;

  if not res then Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFMain.AddSubnodesDict(TreeView: TJvTreeView; AddChild: boolean; Parent: TTreeNode; ds: TpFIBDataSet; ImageShift: integer;
  IsFolder: boolean);
var
  n, n1: TTreeNode;
  obj: TNodeDictInfo;
  title: string;

begin
  if (not ds.Active) then exit;

  // фильтрация будет выполняться по полностью загруженному дереву, по такой же логике, как поиск, так что тут ничего делать не надо
  // функция фильра будет вызываться отдельно после загрузки дерева или вобще независимо от нее
  ds.First;
  while not ds.Eof do
  begin
    if FSettings.TreeShowDescriptor then title := ds.FieldByName('NAME').AsString
    else title := ds.FieldByName('TITLE').AsString;
    if AddChild then n := TreeView.Items.AddChild(Parent, title)
    else n := TreeView.Items.Add(Parent, title);
    n.ImageIndex := 0 + ImageShift;
    n.SelectedIndex := 4 + ImageShift;
    n1 := TreeView.Items.AddChild(n, '(Загрузка...)');
    n1.ImageIndex := -1;
    n1.SelectedIndex := -1;
    obj := AssignNodeData(cotNone);
    obj.PK := ds.FieldByName('PK').Value;
    if IsFolder then
    begin
      obj.ObjType := cotFolder;
      obj.Descriptor := Null;
      obj.Title := ds.FieldByName('NAME').Value;
      obj.ParentDictPK := Null;
      obj.FolderPK := ds.FieldByName('PARENT_FOLDER_PK').Value;
      obj.Login := Null;
    end else
    begin
      obj.ObjType := cotDict;
      obj.Descriptor := ds.FieldByName('DESCRIPTOR_').Value;
      obj.Title := ds.FieldByName('TITLE').Value;
      obj.ParentDictPK := ds.FieldByName('PARENT_REFERENCE_PK').Value;
      obj.FolderPK := ds.FieldByName('FOLDER_PK').Value;
      obj.Login := ds.FieldByName('LOGIN').Value;
    end;
    n.Data := pointer(obj);
    ds.Next;
  end;
end;

procedure TFMain.AddSubnodesForm(TreeView: TJvTreeView; Parent: TTreeNode; ds: TpFIBDataSet);
var
  n: TTreeNode;
  obj: TNodeDictInfo;
  title: string;

begin
  if (not ds.Active) then exit;

  // закомментировано, т.к. теперь единый механизм фильтрации
 { if cbFilter.Text = '' then
  begin
    cbFilter.Color := clWindow;
    ds.Filter := '';
    ds.Filtered := false;
  end else
  begin
    cbFilter.Color := RGB(255, 164, 164);
    ds.Filter := 'lower(NAME) like ''%' + AnsiLowerCase(cbFilter.Text) + '%''';
    ds.Filtered := true;
  end; }

  ds.First;
  while not ds.Eof do
  begin
    if FSettings.TreeShowDescriptor then title := ds.FieldByName('NAME').AsString
    else title := ds.FieldByName('TITLE').AsString;
    n := TreeView.Items.Add(Parent, title);
    n.ImageIndex := 2;
    n.SelectedIndex := 6;
    obj := AssignNodeData(cotForm);
    obj.PK := ds.FieldByName('PK').Value;
    obj.Descriptor := ds.FieldByName('ALIAS_FORM').Value;
    obj.Title := ds.FieldByName('TITLE').Value;
    obj.ParentDictPK := Null;
    obj.FolderPK := Null;
    obj.Login := ds.FieldByName('LOGIN').Value;
    n.Data := pointer(obj);
    ds.Next;
  end;
end;

procedure TFMain.AddSubnodesHist(TreeView: TJvTreeView; Parent: TTreeNode; ds: TpFIBDataSet; ObjType: TConfObjectType; HistType: THistoryType);
var
  n, n1: TTreeNode;
  obj: TNodeDictInfo;
  title: string;
  ImageShift, idx: integer;
  descrField, titleField: string;

begin
  if (not ds.Active) then exit;

  descrField := 'NAME';
  titleField := 'TITLE';
  case ObjType of
    cotFolder: ImageShift := 0;
    cotDict: ImageShift := 1;
    cotForm: ImageShift := 2;
    cotWizard:
    begin
      ImageShift := 3;
      descrField := 'TITLE';
      titleField := 'NAME';
    end;
    cotLikedFolder:
    begin
      ImageShift := 8;
      descrField := 'OBJ_NAME';
      titleField := 'OBJ_NAME';
    end;
  end;

  ds.First;
  while not ds.Eof do
  begin
    if FSettings.TreeShowDescriptor then title := ds.FieldByName(descrField).AsString
    else title := ds.FieldByName(titleField).AsString;
    n := TreeView.Items.AddChild(Parent, title);
    n.ImageIndex := 0 + ImageShift;
    if ObjType = cotLikedFolder then n.SelectedIndex := 0 + ImageShift
    else n.SelectedIndex := 4 + ImageShift;
    if (HistType = htLiked) and (ObjType in [cotFolder, cotDict, cotLikedFolder]) then
    begin
      n1 := TreeView.Items.AddChild(n, '(Загрузка...)');
      n1.ImageIndex := -1;
      n1.SelectedIndex := -1;
    end;

    obj := AssignNodeData(ObjType);
    obj.PK := ds.FieldByName('PK').Value;
    if ds.FieldExist('DESCRIPTOR_', idx) then obj.Descriptor := ds.FieldByName('DESCRIPTOR_').Value
    else if ds.FieldExist('ALIAS_FORM', idx) then obj.Descriptor := ds.FieldByName('ALIAS_FORM').Value;

    case ObjType of
      cotFolder, cotWizard: obj.Title := ds.FieldByName('NAME').Value;
      cotDict, cotForm: obj.Title := ds.FieldByName('TITLE').Value;
      cotLikedFolder: obj.Title := ds.FieldByName('OBJ_NAME').Value;
    end;

    if ds.FieldExist('PARENT_REFERENCE_PK', idx) then obj.ParentDictPK := ds.FieldByName('PARENT_REFERENCE_PK').Value
    else if ds.FieldExist('REF_PK', idx) then obj.ParentDictPK := ds.FieldByName('REF_PK').Value;

    if ds.FieldExist('PARENT_FOLDER_PK', idx) then obj.FolderPK := ds.FieldByName('PARENT_FOLDER_PK').Value
    else if ds.FieldExist('FOLDER_PK', idx) then obj.FolderPK := ds.FieldByName('FOLDER_PK').Value;

    if ds.FieldExist('LOGIN', idx) then obj.Login := ds.FieldByName('LOGIN').Value;

    n.Data := pointer(obj);
    ds.Next;
  end;
end;

procedure TFMain.AddSubnodesWizard(TreeView: TJvTreeView; Parent: TTreeNode; ds: TpFIBDataSet);
var
  n: TTreeNode;
  obj: TNodeDictInfo;
  title: string;

begin
  if (not ds.Active) then exit;

  // закомментировано, т.к. теперь единый механизм фильтрации
 { if cbFilter.Text = '' then
  begin
    cbFilter.Color := clWindow;
    ds.Filter := '';
    ds.Filtered := false;
  end else
  begin
    cbFilter.Color := RGB(255, 164, 164);
    ds.Filter := 'lower(TITLE) like ''%' + AnsiLowerCase(cbFilter.Text) + '%''';
    ds.Filtered := true;
  end; }

  ds.First;
  while not ds.Eof do
  begin
    if FSettings.TreeShowDescriptor then title := ds.FieldByName('TITLE').AsString
    else title := ds.FieldByName('NAME').AsString;
    n := TreeView.Items.Add(Parent, title);
    n.ImageIndex := 3;
    n.SelectedIndex := 7;
    obj := AssignNodeData(cotWizard);
    obj.PK := ds.FieldByName('PK').Value;
    obj.Descriptor := ds.FieldByName('DESCRIPTOR_').Value;
    obj.Title := ds.FieldByName('NAME').Value;
    obj.ParentDictPK := ds.FieldByName('REF_PK').Value;
    obj.FolderPK := Null;
    obj.Login := ds.FieldByName('LOGIN').Value;
    n.Data := pointer(obj);
    ds.Next;
  end;
end;

procedure TFMain.AddToHistory(Data: TNodeDictInfo; HistType: THistoryType);
var
  //err: string;
  u: Variant;
  ImageShift: integer;
  n: TTreeNode;
  Parent: TTreeNode;
  obj: TNodeDictInfo;
  pk: Variant;

begin
  if (not Assigned(Data)) or (Data.ObjType = cotNone) or (Data.ObjType = cotLikedFolder) then exit;
  if (HistType = htHistory) and ((not FSettings.RememberHistory) or FNoHistory) then exit;

  pk := Null;
  if HistType = htLiked then
    if not SelLikedFolderDialog(pk, 'select OBJ_PK PK, OBJ_NAME NAME from DCFG_HISTORY where OBJ_TYPE = ' + IntToStr(Ord(cotLikedFolder)) +
      ' and TYPE_ = ' + IntToStr(Ord(HistType)) + ' and USER_PK = ' + dsPortalUserPK.AsString + ' order by OBJ_NAME') then exit;

  qSaveHistory.Close;
  qSaveHistory.ParamByName('OBJ_PK').Value := Data.PK;
  qSaveHistory.ParamByName('OBJ_TYPE').Value := Ord(Data.ObjType);
  qSaveHistory.ParamByName('TYPE_').Value := Ord(HistType);
  qSaveHistory.ParamByName('USER_PK').Value := dsPortalUserPK.Value;
  qSaveHistory.ParamByName('OBJ_NAME').Value := Data.Title;
  qSaveHistory.ParamByName('PARENT_PK').Value := pk;
  try
    qSaveHistory.ExecQuery;
    Transact.CommitRetaining;
  except
    exit;
  end;

  if tsHistory.TabVisible then
  begin
    if HistType = htLiked then
    begin
      // при обновлении избранного перезальем дерево целиком
      if Assigned(tvHistory.Selected) and (tvHistory.Selected.AbsoluteIndex <> 0) and Assigned(tvHistory.Selected.Data) then
        u := TNodeDictInfo(tvHistory.Selected.Data).PK;

      NoLoadInfo := true;
      try
        tvHistory.Visible := false;
        tvHistory.Items.Clear;
        LoadHistory(tvHistory);
      finally
        SelectNode(tvHistory, u);
        tvHistory.Visible := true;
        NoLoadInfo := false;
      end;
    end else
    begin
      // при обновлении истории просто добавим узел
      case Data.ObjType of
        cotFolder: ImageShift := 0;
        cotDict: ImageShift := 1;
        cotForm: ImageShift := 2;
        cotWizard: ImageShift := 3;
      end;

      Parent := GetHistoryParent(htHistory);
      if not Assigned(Parent) then exit;
      n := tvHistory.Items.AddChildFirst(Parent, VarToStr(Data.Title));
      n.ImageIndex := 0 + ImageShift;
      n.SelectedIndex := 4 + ImageShift;
      obj := AssignNodeData(Data.ObjType);
      obj.Assign(Data);
      n.Data := pointer(obj);
    end;
  end;
end;

function TFMain.AddToRefLog(ObjType: TConfObjectType; Descriptor: string; Action: TRefLogType; Text: string): boolean;
var
  err: string;
  
begin
  result := ExecSQL('insert into DCFG_REF_LOG (OBJ_TYPE, REF_DESCRIPTOR, ACTION_, USER_PK, ACTION_DETAIL) values (' +
    IntToStr(Ord(ObjType)) + ', ' + iif(Trim(Descriptor) = '', 'null', '''' + Trim(Descriptor) + '''') + ', ' +
    IntToStr(Ord(Action)) + ', ' + dsPortalUserPK.AsString + ', ' + iif(Trim(Text) = '', 'null', '''' + Trim(Text) + '''') + ')', err);
end;

procedure TFMain.AddTreeNode(TreeView: TJvTreeView; ParentNode: TTreeNode);
var
  d: TNodeDictInfo;

begin
  if not Database.Connected then exit;
  {if Assigned(ParentNode) and (not Assigned(ParentNode.Data)) then
  begin
    Application.MessageBox('Неверный родительский узел!', 'Сообщение', MB_OK + MB_ICONINFORMATION);
    exit;
  end;}

  if Assigned(ParentNode) and Assigned(ParentNode.Data) then d := TNodeDictInfo(ParentNode.Data)
  else begin
    if TreeView = tvHistory then d := AssignNodeData(cotLikedFolder)
    else d := AssignNodeData(cotFolder);
  end;

  if (TreeView = tvMain) or (TreeView = tvHistory) then
  begin
    case d.ObjType of
      cotFolder, cotNone:
      begin
        case SelObjectDialog of
          0: CreateFolder(d);
          1: CreateDict(d);
        end;
      end;
      cotLikedFolder: CreateLikedFolder;
      else CreateDict(d);
    end;
  end
  else if TreeView = tvDict then CreateDict(d)
  else if TreeView = tvForm then CreateForm
  else if TreeView = tvWizard then CreateWizard;
end;

procedure TFMain.AddWindowMenuItem(FormIndex: integer; FCaption, FHint: string; ImageIndex: integer);
var
  mi: TMenuItem;

begin
  mi := TMenuItem.Create(Self);
  mi.Name := 'miWindow' + IntToStr(FormIndex);
  miWindow.Add(mi);
  mi.Tag := FormIndex;
  mi.Caption := FCaption;
  mi.Hint := FHint;
  mi.AutoCheck := true;
  mi.RadioItem := true;
  mi.Checked := true;
  //mi.ImageIndex := ImageIndex; - не надо, а то чекбокса не видно
  mi.OnClick := WindowMenuClick;
end;

procedure TFMain.ADelBranchExecute(Sender: TObject);
begin
  if not GetCurrentTreeView.Focused then exit;
  DelTreeNode(GetCurrentTreeView.Selected, true);
end;

procedure TFMain.ADelGrantOnConfigDictExecute(Sender: TObject);
begin
  if not GetCurrentTreeView.Focused then exit;
  DelGrantOnConfigDict(TNodeDictInfo(GetCurrentTreeView.Selected.Data));
end;

procedure TFMain.ADelNodeExecute(Sender: TObject);
begin
  if not GetCurrentTreeView.Focused then exit;
  DelTreeNode(GetCurrentTreeView.Selected);
end;

procedure TFMain.ADisconnectExecute(Sender: TObject);
begin
  if FSettings.ConfirmCloseChild and (OpenedFormCount > 0) and
    (Application.MessageBox('При отключении все открытые окна будут ЗАКРЫТЫ БЕЗ СОХРАНЕНИЯ изменений! Продолжить?',
    'Подтверждение', MB_YESNO + MB_ICONWARNING) <> ID_YES) then exit;

  CloseConfiguration;
end;

procedure TFMain.ADislikeObjectExecute(Sender: TObject);
var
  ht: THistoryType;
  
begin
  if (not GetCurrentTreeView.Focused) or (GetCurrentTreeView <> tvHistory) or
    (not Assigned(GetCurrentTreeView.Selected)) or (not Assigned(GetCurrentTreeView.Selected.Data)) then exit;

  if Assigned(GetCurrentTreeView.Selected.Parent) and Assigned(GetCurrentTreeView.Selected.Parent.Data) and
    (TNodeDictInfo(GetCurrentTreeView.Selected.Parent.Data).Descriptor = '$HISTORY') then
    ht := htHistory
  else
    ht := htLiked;

  DelFromHistory(TNodeDictInfo(GetCurrentTreeView.Selected.Data), ht);
end;

procedure TFMain.ADislikeObjectUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Database.Connected and (GetCurrentTreeView.Items.Count > 0) and
    (GetCurrentTreeView = tvHistory);
end;

procedure TFMain.AEditNodeExecute(Sender: TObject);
begin
  if not GetCurrentTreeView.Focused then exit;
  EditTreeNode(GetCurrentTreeView.Selected);
end;

procedure TFMain.AEditNodeUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Database.Connected and (GetCurrentTreeView.Items.Count > 0);

  if TAction(Sender).Enabled and (Sender = AChangeOwner) then
  begin
    TAction(Sender).Enabled := Assigned(GetCurrentTreeView.Selected) and
      (TNodeDictInfo(GetCurrentTreeView.Selected.Data).ObjType in [cotDict, cotForm]);
  end;

{  if TAction(Sender).Enabled and (Sender = ALikeObject) then
    TAction(Sender).Enabled := GetCurrentTreeView <> tvHistory;
}
  if (Sender = ALikeObject) then
  begin
    if (GetCurrentTreeView = tvHistory) then
      TAction(Sender).Caption := 'Переместить в избранном'
    else
      TAction(Sender).Caption := 'Добавить в избранное';
  end;
end;

procedure TFMain.AExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TFMain.AExpandAllExecute(Sender: TObject);
begin
  GetCurrentTreeView.FullExpand;
end;

procedure TFMain.AFindByObjectExecute(Sender: TObject);
begin
  FindByObjectDB;
end;

procedure TFMain.AFindExecute(Sender: TObject);
begin
  Find(Sender = AFindNext);
end;

procedure TFMain.AGenBranchSQLExecute(Sender: TObject);
begin
  SetSaveDialogToSQL;
  if SaveDialog.Execute then SaveBranchToSQL(GetCurrentTreeView.Selected, SaveDialog.FileName);
end;

procedure TFMain.AGenBranchSQLUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := {(GetCurrentTreeView = tvMain) and}
    Assigned(GetCurrentTreeView.Selected) and (TNodeDictInfo(GetCurrentTreeView.Selected.Data).ObjType = cotFolder);
end;

procedure TFMain.AGenBranchWizardSQLExecute(Sender: TObject);
begin
  SetSaveDialogToSQL;
  if SaveDialog.Execute then SaveBranchWizardToSQL(GetCurrentTreeView.Selected, SaveDialog.FileName);
end;

procedure TFMain.AGenDictWizardsSQLExecute(Sender: TObject);
begin
  if (not Assigned(GetCurrentTreeView.Selected)) or (not Assigned(GetCurrentTreeView.Selected.Data)) or
    (TNodeDictInfo(GetCurrentTreeView.Selected.Data).ObjType <> cotDict) then exit;

  SetSaveDialogToSQL;
  if SaveDialog.Execute then SaveToSQL(GetCurrentTreeView.Selected, SaveDialog.FileName, 1);
end;

procedure TFMain.AGenPermissionsSQLExecute(Sender: TObject);
begin
  if (not Assigned(GetCurrentTreeView.Selected)) or (not Assigned(GetCurrentTreeView.Selected.Data)) or
    (TNodeDictInfo(GetCurrentTreeView.Selected.Data).ObjType <> cotDict) then exit;

  SetSaveDialogToSQL;
  if SaveDialog.Execute then SaveToSQL(GetCurrentTreeView.Selected, SaveDialog.FileName, 2);
end;

procedure TFMain.AGenSQLExecute(Sender: TObject);
begin
  if (not Assigned(GetCurrentTreeView.Selected)) or (not Assigned(GetCurrentTreeView.Selected.Data)) or
    (TNodeDictInfo(GetCurrentTreeView.Selected.Data).ObjType = cotNone) then exit;

  // предупреждение для справочников
  if (TNodeDictInfo(GetCurrentTreeView.Selected.Data).ObjType = cotDict) and
    (Application.MessageBox(pchar('Внимание!!! Вместе с выбранным справочником в скрипт попадут ВСЕ ЕГО ДОЧЕРНИЕ И РОДИТЕЛЬСКИЕ справочники! ' +
      'А так же будут УДАЛЕНЫ ВСЕ ПРИВЯЗАННЫЕ СЦЕНАРИИ, которые нужно будет выгрузить и перенакатить отдельным скриптом!'#13#10 + 'Вам оно нужно???'),
      'Предупреждение', MB_YESNO + MB_ICONWARNING) <> ID_YES) then exit;

  SetSaveDialogToSQL;
  if SaveDialog.Execute then SaveToSQL(GetCurrentTreeView.Selected, SaveDialog.FileName);
end;

procedure TFMain.AGroupActionExecute(Sender: TObject);
var
  ga: TFGroupAction;
  Node: TTreeNode;

begin
  Node := GetCurrentTreeView.Selected;
  if (not Assigned(Node)) or (not Assigned(Node.Data)) or (TNodeDictInfo(Node.Data).ObjType <> cotFolder) then exit;

  ga := TFGroupAction.Create(Self);
  try
    ga.FolderPk := TNodeDictInfo(Node.Data).PK;
    ga.Caption := 'Мастер групповых операций - Папка ' + VarToStr(TNodeDictInfo(Node.Data).PK) + ' : ' +
      VarToStr(TNodeDictInfo(Node.Data).Title);
    ga.ShowModal;
    if ga.CanRefresh then ReopenTree;
  finally
    ga.Free;
  end;
end;

procedure TFMain.AHelpExecute(Sender: TObject);
var
  s, err: string;

begin
  err := '';
  if FSettings.UpdateFromDb then
  begin
    s := ExtractFilePath(Application.ExeName) + FSettings.HelpFile;
    try
      try
        ConnectToUpdate;
        dsGetHelp.Close;
        dsGetHelp.Open;
        if not dsGetHelp.IsEmpty then dsGetHelpHELP_FILE.SaveToFile(s);
      except
        on e: Exception do
          err := #13#10'Не удалось скачать файл справки!'#13#10 + e.Message;
      end;
    finally
      dsGetHelp.Close;
      DBUpdate.Close;
    end;
  end else
  begin
    s := FSettings.UpdatePath;
    if s[Length(s)] <> '\' then s := s + '\';
    s := s + FSettings.HelpFile;
  end;

  if FileExists(s) or (Pos(LowerCase('ftp://'), s) > 0) then
    ShellExecute(Application.Handle, 'open', pchar(s), nil, nil, SW_SHOWNORMAL)
  else
    Application.MessageBox(pchar('Не найден файл справки "' + s + '"' + err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFMain.AHistoryExecute(Sender: TObject);
begin
  if (not Assigned(GetCurrentTreeView.Selected)) or (not Assigned(GetCurrentTreeView.Selected.Data)) or
    (TNodeDictInfo(GetCurrentTreeView.Selected.Data).ObjType = cotNone) then exit;

  ShowObjectHistory(TNodeDictInfo(GetCurrentTreeView.Selected.Data));
end;

procedure TFMain.ALikeObjectExecute(Sender: TObject);
begin
  if (not GetCurrentTreeView.Focused) or {(GetCurrentTreeView = tvHistory) or}
    (not Assigned(GetCurrentTreeView.Selected)) or (not Assigned(GetCurrentTreeView.Selected.Data)) then exit;

  AddToHistory(TNodeDictInfo(GetCurrentTreeView.Selected.Data), htLiked);
end;

procedure TFMain.AMinimizeExecute(Sender: TObject);
var
  idx: integer;

begin
  idx := GetCheckedFormIndex;
  if (idx > -1) and (idx < Length(ChildForms)) and Assigned(ChildForms[idx]) then
  begin
    if TAction(Sender) = AMinimize then ChildForms[idx].WindowState := wsMinimized
    else if TAction(Sender) = AMaximize then ChildForms[idx].WindowState := wsMaximized
    else if TAction(Sender) = ARestore then ChildForms[idx].WindowState := wsNormal;
  end;
end;

procedure TFMain.AMinimizeAllExecute(Sender: TObject);
var
  i: integer;

begin
  for i := 0 to Length(ChildForms) - 1 do
    if Assigned(ChildForms[i]) then
    begin
      if TAction(Sender) = AMinimizeAll then ChildForms[i].WindowState := wsMinimized
      else if TAction(Sender) = AMaximizeAll then ChildForms[i].WindowState := wsMaximized
      else if TAction(Sender) = ARestoreAll then ChildForms[i].WindowState := wsNormal;
    end;
end;

procedure TFMain.ANextWindowExecute(Sender: TObject);
begin
  if (not TAction(Sender).Enabled) or (WindowBar.Tabs.Count <= 0) then exit;

  if Sender = ANextWindow then
  begin
    WindowBar.SelectedTab := WindowBar.SelectedTab.GetNextVisible;
    if WindowBar.SelectedTab = nil then
      WindowBar.SelectedTab := WindowBar.Tabs.Items[0];
  end else if Sender = APrewWindow then
  begin
    WindowBar.SelectedTab := WindowBar.SelectedTab.GetPreviousVisible;
    if WindowBar.SelectedTab = nil then
      WindowBar.SelectedTab := WindowBar.Tabs.Items[WindowBar.Tabs.Count - 1];
  end;
end;

procedure TFMain.ANextWindowUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := WindowBar.Tabs.Count > 0;
end;

procedure TFMain.AOpenInBrowserExecute(Sender: TObject);
var
  Node: TTreeNode;

begin
  if not Database.Connected then exit;

  Node := GetCurrentTreeView.Selected;

  if (not Assigned(Node)) or (not Assigned(Node.Data)) then
  begin
    Application.MessageBox('Не выбран узел!', 'Сообщение', MB_OK + MB_ICONINFORMATION);
    exit;
  end;

  if TNodeDictInfo(Node.Data).ObjType = cotDict then OpenDictInBrowser(TNodeDictInfo(Node.Data));
end;

procedure TFMain.AOpenUsersExecute(Sender: TObject);
begin
  OpenInstrument(TChildFormType(TAction(Sender).Tag), TAction(Sender).Caption);
end;

procedure TFMain.AppEventsHint(Sender: TObject);
begin
  if Trim(Application.Hint) <> '' then FHint.reHintText.Text := Application.Hint;
end;

procedure TFMain.AppEventsMessage(var Msg: tagMSG; var Handled: Boolean);
begin
  if (Msg.message = WM_MOUSEMOVE) and Database.Connected then
  begin
    tmrEndSession.Enabled := false;
    tmrEndSession.Enabled := true;
  end;

  Handled := false;
end;

procedure TFMain.AReconnectExecute(Sender: TObject);
begin
  if FSettings.ConfirmCloseChild and (OpenedFormCount > 0) and
    (Application.MessageBox('При переподключении все открытые окна будут ЗАКРЫТЫ БЕЗ СОХРАНЕНИЯ изменений! Продолжить?',
    'Подтверждение', MB_YESNO + MB_ICONWARNING) <> ID_YES) then exit;

  CloseConfiguration;
  OpenConfiguration;
end;

procedure TFMain.ARefreshTreeExecute(Sender: TObject);
begin
  ReopenTree(false);
end;

procedure TFMain.ASettingsExecute(Sender: TObject);
var
  oldts: boolean;

begin
  oldts := FSettings.TreeShowDescriptor;
  if FSettings.ShowModal = mrOk then
  begin
    tmrAutoUpdate.Enabled := false;
    tmrAutoUpdate.Interval := FSettings.UpdateInterval;
    tmrAutoUpdate.Enabled := FSettings.CheckUpdates;

    SetPages(false);
    
    if (oldts <> FSettings.TreeShowDescriptor) {and
      (Application.MessageBox('Для изменения вида отображения нужно перезагрузить деревья. Выполнить сейчас?', 'Подтверждение',
        MB_YESNO + MB_ICONQUESTION) = ID_YES)} then ReopenTree;

    if FSettings.GridOptsChanged then SetGridsOptions;
  end;
end;

procedure TFMain.AUserInfoExecute(Sender: TObject);
begin
  ShowUserInfo;
end;

procedure TFMain.AViewNodeExecute(Sender: TObject);
begin
  if not GetCurrentTreeView.Focused then exit;
  ViewTreeNode(GetCurrentTreeView.Selected);
end;

procedure TFMain.chbGetOnlyUserClick(Sender: TObject);
begin
  ReopenTree;
end;

procedure TFMain.CheckFormButton(FormIndex: integer);
var
  idx: integer;

begin
  idx := GetButtonIndex(FormIndex);
  if idx < 0 then exit;
  WindowBar.SelectedTab := WindowBar.Tabs.Items[idx];
end;

function TFMain.CheckGrants(Act: TGrantAction; Data: TNodeDictInfo; var Err: string): boolean;
var
  ds: TpFIBDataSet;
  sql: string;

begin
  case Act of
    //gaRights: result := IsActive and (IsAdmin or IsDeveloper); // понижаем права - данное действие разрешено админу или владельцу
    gaRights, gaDel: result := IsActive and (IsAdmin or IsDeveloper) and
      (IsAdmin or (VarToStr(Data.Login) = '') or (LowerCase(VarToStr(Data.Login)) = LowerCase(FSettings.PortalUser)));
    gaEdit:
    begin
      result := IsActive and (IsAdmin or IsDeveloper) and
        (IsAdmin or (VarToStr(Data.Login) = '') or (LowerCase(VarToStr(Data.Login)) = LowerCase(FSettings.PortalUser)));

      if (not result) and IsActive and (Data.ObjType in [cotDict, cotForm, cotWizard]) then
      begin
        // проверим по таблице прав юзера на справочник
        case Data.ObjType of
          cotDict:
            sql := 'select * from DYNAMIC_FORM_REF_USER where REF_PK = ' + VarToStr(Data.PK) + ' and USER_PK = ' + dsPortalUserPK.AsString;
          cotForm:
            sql := 'select * from DYNAMIC_FORM_REF_USER where REF_PK = (select first 1 PK from DYNAMIC_FORM_REFERENCE where MAIN_FORM_PK = ' +
              VarToStr(Data.PK) + ') and USER_PK = ' + dsPortalUserPK.AsString;
          cotWizard:
            sql := 'select * from DYNAMIC_FORM_REF_USER where REF_PK = ' + VarToStr(Data.ParentDictPK) + ' and USER_PK = ' + dsPortalUserPK.AsString;
        end;

        try
          ds := OpenSQL(sql);
        except
        end;
        result := ds.Active and (not ds.IsEmpty);
        ds.Close;
        ds.Free;
      end;
    end;
    gaAdd: result := IsActive and (IsAdmin or IsDeveloper);
    gaView: result := IsActive;
    gaOpenInstr: result := IsActive and IsAdmin;
    gaViewInstr: result := IsActive and (IsAdmin or IsDeveloper);
    else result := false;
  end;

  if not result then
  begin
    Err := 'Действие запрещено: пользователь ' + FSettings.PortalUser;
    if not IsActive then Err := Err + ' заблокирован!'
    else if (Act = gaOpenInstr) and (not IsAdmin) then Err := Err + ' не является Администратором'
    else if (not IsAdmin) and (not IsDeveloper) then Err := Err + ' не является Администратором или Разработчиком!'
    else Err := Err + ' не является владельцем объекта или Администратором!';
  end;
end;

function TFMain.CheckGrantsDepth(Act: TGrantAction; Data: TNodeDictInfo; var Err: string): boolean;
var
  ds: TpFIBDataSet;
  sl, slFolder, slRef: TStringList;
  idx, i: integer;
  d: TNodeDictInfo;

begin
  // проверка прав на все объекты папки рекурсивно. Если есть хоть один с запретом - результат ОТКАЗ
  Err := '';
  result := false;
  if Data.ObjType <> cotFolder then raise Exception.Create('Проверяемый объект не является папкой!');

  // сначала права на саму папку
  result := CheckGrants(Act, Data, err);
  if not result then exit;

  // выберем вложенные папки и главные справочники папки
  d := AssignNodeData(cotDict);
  sl := TStringList.Create;
  slFolder := TStringList.Create;
  slRef := TStringList.Create;
  try
    ds := OpenSQL('select 1 TYPE_, f.PK, null LOGIN from DYNAMIC_FORM_FOLDER f where f.PARENT_FOLDER_PK = ' + IntToStr(Data.PK) +
      ' union all select 2 TYPE_, r.PK, u.LOGIN from DYNAMIC_FORM_REFERENCE r ' +
      'left join USERS u on u.PK = r.OWNER_USER_PK ' +
      'where r.FOLDER_PK = ' + IntToStr(Data.PK) + ' and r.PARENT_REFERENCE_PK is null');

    ds.First;
    while not ds.Eof do
    begin
      if ds.FieldByName('TYPE_').AsInteger = 1 then slFolder.Add(ds.FieldByName('PK').AsString)
      else if ds.FieldByName('TYPE_').AsInteger = 2 then
      begin
        slRef.Add(ds.FieldByName('PK').AsString + '=' + ds.FieldByName('LOGIN').AsString);
        sl.Add(ds.FieldByName('PK').AsString);
        GetChildRefList(ds.FieldByName('PK').AsInteger, sl);
      end;

      ds.Next;
    end;

    // проверим все вложенные справочники
    d.ObjType := cotDict;
    for i := 0 to slRef.Count - 1 do
    begin
      d.PK := StrToInt(slRef.Names[i]);
      d.Login := slRef.Values[slRef.Names[i]];

      result := CheckGrants(Act, d, err);
      if not result then
      begin
        err := 'Недостаточно прав на один из вложенных справочников: (PK: ' + VarToStr(d.PK) + ')'#13#10 + err;
        exit;
      end;
    end;

    // теперь пройдемся по вложенным папкам
    d.ObjType := cotFolder;
    d.Login := Null;
    for i := 0 to slFolder.Count - 1 do
    begin
      d.PK := StrToInt(slFolder.Strings[i]);
      result := CheckGrantsDepth(Act, d, Err);
      if not result then exit;
    end;
  finally
    d.Free;
    sl.Free;
    slFolder.Free;
    slRef.Free;
    ds.Close;
    ds.Free;
  end;
end;

procedure TFMain.CheckUpdates(Warn: boolean);
var
  uInfo: TUpdateInfo;
  cver, err: string;
  cv, rv: integer;
  tmp_fn, old_fn, new_fn: string;
  FUpdates: TFUpdates;
  i: integer;


begin
  AvailableUpdate := false;
  cver := GetVersion(Application.ExeName);

  try
    try
      if FSettings.UpdateFromDb then uInfo := GetUpdateInfoDB(cver)
      else uInfo := GetUpdateInfoNet;

      if uInfo.IsEmpty then
      begin
        if Warn then Application.MessageBox('Ничего нового...', 'Информация', MB_OK + MB_ICONINFORMATION);
        exit;
      end;

      if FSettings.UpdateFromDb then
        AvailableUpdate := true
      else begin
        for i := 1 to WordCountEx(cver, ['.'], []) do
        begin
          cv := StrToInt(ExtractWordEx(i, cver, ['.'], []));
          rv := StrToInt(ExtractWordEx(i, uInfo.Version, ['.'], []));
          if rv > cv then
          begin
            AvailableUpdate := true;
            break;
          end;
        end;
      end;

      if not AvailableUpdate then
      begin
        if Warn then Application.MessageBox('Ничего нового...', 'Обновление', MB_OK + MB_ICONINFORMATION);
        exit;
      end;

      // есть обновления, надо спрсить
      if (not Warn) and (not AskUpdate) then exit;
      AskUpdate := false;

      FUpdates := TFUpdates.Create(self);
      try
        FUpdates.lbCurVersion.Caption := cver;
        FUpdates.lbAvailVersion.Caption := uInfo.Version;
        FUpdates.lbDate.Caption := DateTimeToStr(uInfo.Date);
        FUpdates.lbFileSize.Caption := BytesToStr(uInfo.FileSize);
        FUpdates.reDescr.Text := uInfo.Description;
        //FlashWindow(Handle, true);
        if FUpdates.ShowModal <> mrOk then exit;
      finally
        FUpdates.Free;
      end;

      // поехало обновление:
      // 1. закачать файл
      Screen.Cursor := crHourGlass;
      tmp_fn := GetTempDir + '\' + ChangeFileExt(uInfo.FileName, '.tmp');
      if FileExists(tmp_fn) then DeleteFile(tmp_fn);
      if FSettings.UpdateFromDb then dsGetUpdateFILE_DATA.SaveToFile(tmp_fn)
      else if not CopyFile(uInfo.SourceFile, tmp_fn, err) then raise Exception.Create(err);
      if AnsiLowerCase(GetFileCheckSum(tmp_fn)) <> AnsiLowerCase(uInfo.MD5) then
        raise Exception.Create('Файл был поврежден в процессе загрузки!');

      // 2. обновиться
      if FileExists(tmp_fn) then
      begin
        //Application.MessageBox('Для обновления требуется перезапуск.', 'Обновление', MB_OK + MB_ICONINFORMATION);
        old_fn := Application.ExeName + '.old';  // ChangeFileExt(Application.ExeName, '.old');
        // new_fn := Application.ExeName - так остается возможность переименования файла приложения
        new_fn := ExtractFilePath(Application.ExeName) + uInfo.FileName;
        if FileExists(old_fn) then DeleteFile(old_fn);

        if not RenameFile(Application.ExeName, old_fn) then
          raise Exception.Create('Файловая операция не удалась: ' + SysErrorMessage(GetLastError));

        if not CopyFile(tmp_fn, new_fn, err) then
          raise Exception.Create('Файловая операция не удалась: ' + err);

        if FileExists(tmp_fn) then DeleteFile(tmp_fn);
        ForcedTerminate := true;
        ShellExecute(Handle, 'open', pchar('"' + new_fn + '"'), '', '', SW_SHOWNORMAL);
        Close;
      end else
        Application.MessageBox('При обновлении пропал скачанный файл новой версии, возможно он был удален антивирусной программой', 'Ошибка', MB_OK + MB_ICONERROR);
    except
      on e: Exception do
        if Warn then
          Application.MessageBox(pchar('Ошибка загрузки обновления:'#13#10 + e.Message), 'Ошибка', MB_OK + MB_ICONERROR);
    end;
  finally
    if FSettings.UpdateFromDb and DBUpdate.Connected then
    begin
      dsGetUpdate.Close;
      DBUpdate.Close;
    end else
      if DirectoryExists(GetTempDir + '\DictConfigurator\') then
        DeleteDir(GetTempDir + '\DictConfigurator\', err);
    Screen.Cursor := crDefault;
    StatusBar.Repaint;
  end;
end;

procedure TFMain.CloseConfiguration;
begin
  tmrEndSession.Enabled := false;
  SaveTreePositions;
  SaveSession;
  DenyLoadTree := true;
  NoLoadInfo := true;
  ClearChildForms;
  ConnectChecker.Stop;
  ConnectionsList.ClearConnections;
  tvMain.Items.Clear;
  tvDict.Items.Clear;
  tvForm.Items.Clear;
  tvWizard.Items.Clear;
  tvHistory.Items.Clear;
  if mtObjectInfo.Active then
  begin
    mtObjectInfo.EmptyTable;
    mtObjectInfo.Close;
  end;

  Database.Close;

  FSettings.ActivateConnectControls(not Database.Connected);
end;

procedure TFMain.cbFilterKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: Filter(false);
    VK_ESCAPE: CleanFilter(false);
  end;
end;

procedure TFMain.ChangeDictOwner(Data: TNodeDictInfo);
var
  err: string;
  res: boolean;
  pk: Variant;

begin
  if Data.ObjType <> cotDict then exit;

  // сначала права
  res := CheckGrants(gaRights, Data, err);

  if res then
  begin
    if not SelUserDialog(pk, 'select u.PK, u.LOGIN, u.NAME from USERS u join ROLES r on r.PK = u.ROLE_PK ' +
      'where (u.ISACTIVE = ''1'') and (u.DEVELOPER = ''1'' or lower(r.NAME) = ''admin'' or lower(r.NAME) = ''developer'') order by u.NAME') then exit;

    if VarIsNull(pk) then
    begin
      res := false;
      err := 'Не выбран новый пользователь!';
    end else
    begin
      // меняем владельца справочника
      res := ExecSQL('update DYNAMIC_FORM_REFERENCE set OWNER_USER_PK = ' + VarToStr(pk) + ' where PK = ' +
        VarToStr(TNodeDictInfo(Data).PK), err);
      // меняем владельца главной формы
      if res then res := ExecSQL('update DYNAMIC_FORM set OWNER_USER_PK = ' + VarToStr(pk) + ' where PK = (' +
        'select MAIN_FORM_PK from DYNAMIC_FORM_REFERENCE where PK = ' + VarToStr(TNodeDictInfo(Data).PK) + ')', err);
      if res then res := ExecSQL('update DYNAMIC_FORM set OWNER_USER_PK = ' + VarToStr(pk) +
        ' where PK = (select START_FORM_PK from DYNAMIC_FORM_REFERENCE where PK = ' + VarToStr(TNodeDictInfo(Data).PK) +
        ' and START_FORM_PK <> -1)', err);
      if res then res := FMain.ExecSQL('update DYNAMIC_FORM set OWNER_USER_PK = ' + VarToStr(pk) +
        ' where PK = (select GROUP_EDIT_FORM_PK from DYNAMIC_FORM_REFERENCE where PK = ' + VarToStr(TNodeDictInfo(Data).PK) +
        ' and GROUP_EDIT_FORM_PK <> -1)', err);
      // владельца объектови полей менять не будем - пусть будет видно, кто их создавал
      if res then AddToRefLog(Data.ObjType, Data.Descriptor, rltUpdate, 'Смена владельца. Старый владелец ' + Data.Login);
    end;
  end;

  if res then ReopenTree
  else Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFMain.ChangeFormButtonCaption(FormIndex: integer; NewCaption, NewHint: string);
var
  i: integer;

begin
  i := GetButtonIndex(FormIndex);
  if i = -1 then exit;

  WindowBar.Tabs.Items[i].Caption := NewCaption;
  WindowBar.Tabs.Items[i].Hint := NewHint;
  ChangeFormMenuCaption(FormIndex, NewCaption, NewHint);
end;

procedure TFMain.ChangeFormMenuCaption(FormIndex: integer; NewCaption, NewHint: string);
var
  i: integer;

begin
  i := GetMenuIndex(FormIndex);
  if i = -1 then exit;

  miWindow.Items[i].Caption := NewCaption;
  miWindow.Items[i].Hint := NewHint;
end;

procedure TFMain.ChangeFormOwner(Data: TNodeDictInfo);
var
  err: string;
  res: boolean;
  pk: Variant;

begin
  if Data.ObjType <> cotForm then exit;

  // сначала права
  res := CheckGrants(gaRights, Data, err);

  if res then
  begin
    if not SelUserDialog(pk, 'select u.PK, u.LOGIN, u.NAME from USERS u join ROLES r on r.PK = u.ROLE_PK ' +
      'where (u.ISACTIVE = ''1'') and (u.DEVELOPER = ''1'' or lower(r.NAME) = ''admin'' or lower(r.NAME) = ''developer'') order by u.NAME') then exit;

    if VarIsNull(pk) then
    begin
      res := false;
      err := 'Не выбран новый пользователь!';
    end else
    begin
      // меняем владельца главной формы
      res := ExecSQL('update DYNAMIC_FORM set OWNER_USER_PK = ' + VarToStr(pk) + ' where PK = ' +
        VarToStr(TNodeDictInfo(Data).PK), err);
      // владельца объектов и полей менять не будем - пусть будет видно, кто их создавал
      if res then AddToRefLog(Data.ObjType, iif(not VarIsNull(Data.Descriptor), Data.Descriptor, Data.Title), rltUpdate,
        'PK ' + IntToStr(Data.PK) + '. Смена владельца. Старый владелец ' + Data.Login);
    end;
  end;

  if res then ReopenTree
  else Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFMain.ChangeObjectOwner(Node: TTreeNode);
begin
  if not Database.Connected then exit;
  if (not Assigned(Node)) or (not Assigned(Node.Data)) then
  begin
    Application.MessageBox('Не выбран узел!', 'Сообщение', MB_OK + MB_ICONINFORMATION);
    exit;
  end;

  case TNodeDictInfo(Node.Data).ObjType of
    cotDict: ChangeDictOwner(TNodeDictInfo(Node.Data));
    cotForm: ChangeFormOwner(TNodeDictInfo(Node.Data));
  end;
end;

function TFMain.CompareNodeData(Str: string; Data: TNodeDictInfo; Options: TFindOptions): boolean;
var
  strFinding, pk, descr, title: string;
  s, s1: string;
  i, j: integer;

begin
  result := false;

  pk := VarToStr(Data.PK);
  if foMatchCase in Options then
  begin
    strFinding := Str;
    descr := VarToStr(Data.Descriptor);
    title := VarToStr(Data.Title);
  end else
  begin
    strFinding := AnsiLowerCase(Str);
    descr := AnsiLowerCase(VarToStr(Data.Descriptor));
    title := AnsiLowerCase(VarToStr(Data.Title));
  end;

  if foToExistence in Options then
  begin
    // по вхождению
    strFinding := StringReplace(strFinding, #13#10, #4, [rfReplaceAll]);
    title := StringReplace(title, #13#10, #4, [rfReplaceAll]);
    if foAnyWord in Options then
    begin
      for i := 1 to WordCountEx(strFinding, FIND_WORD_DELIMS, []) do
      begin
        s := ExtractWordEx(i, strFinding, FIND_WORD_DELIMS, []);
        result := (Pos(s, pk) > 0) or (Pos(s, descr) > 0);
        if not result then
          for j := 1 to WordCountEx(title, FIND_WORD_DELIMS, []) do
          begin
            s1 := ExtractWordEx(j, title, FIND_WORD_DELIMS, []);
            result := s = s1;
            if result then break;
          end;

        if result then break;
      end;
    end else if foAllWords in Options then
    begin
      for i := 1 to WordCountEx(strFinding, FIND_WORD_DELIMS, []) do
      begin
        s := ExtractWordEx(i, strFinding, FIND_WORD_DELIMS, []);
        result := (Pos(s, pk) > 0) or (Pos(s, descr) > 0);
        if not result then
          for j := 1 to WordCountEx(title, FIND_WORD_DELIMS, []) do
          begin
            s1 := ExtractWordEx(j, title, FIND_WORD_DELIMS, []);
            result := s = s1;
            if result then break;
          end;

        if not result then break;
      end;
    end else {if foWholeString in Options then} // эту опцию можно не указывать - и так понятно
      result := (Pos(strFinding, pk) > 0) or (Pos(strFinding, descr) > 0) or (Pos(strFinding, title) > 0);
  end else
    // полное совпадение
    result := (strFinding = pk) or (strFinding = descr) or (strFinding = title);
end;

procedure TFMain.ShowDumpObjectsMaster(Data: TNodeDictInfo);
var
  fdmp: TFDumpObjects;

begin
  try
    fdmp := TFDumpObjects.Create(Self);
    fdmp.Item := Data;
    fdmp.ShowModal;
  finally
    fdmp.Free;
  end;
end;

procedure TFMain.Connect;
var
  s, err: string;
  c: TConnection;
  fc: TFConnect;
  ds: TpFIBDataSet;

begin
  ClearChildForms;
  ConnectChecker.Stop;
  ConnectionsList.ClearConnections;
  DenyLoadTree := false;
  IsAdmin := false;
  IsDeveloper := false;
  IsActive := false;
  if Database.Connected then CloseConfiguration;

  fc := TFConnect.Create(self);
  try
    if fc.ShowModal <> mrOk then exit;
    c := FSettings.GetCurrentConnection;
    c.UserName := fc.edUser.Text;
    c.Pass := fc.edPass.Text;
    c.Role := fc.edRole.Text;
    c.Encoding := fc.cbCharset.Text;
    c.SQLDialect := StrToInt(fc.cbSQLDialect.Items[fc.cbSQLDialect.ItemIndex]);

    if (c.DataBase = '') then
    begin
      Application.MessageBox('Внимание! Подключение к БД не настроено. Задать параметры подключения можно в настройках программы.',
        'Предупреждение', MB_OK + MB_ICONWARNING);
      exit;
    end;

    if c.Host <> '' then
    begin
      if c.Port = 3050 then s := c.Host
      else s := c.Host + '/' + IntToStr(c.Port);
      s := s + ':';
    end;
    Database.DBName := s + c.DataBase;
    Database.ConnectParams.UserName := c.UserName;
    Database.ConnectParams.Password := c.Pass;
    Database.ConnectParams.RoleName := c.Role;
    Database.ConnectParams.CharSet := c.Encoding;
    Database.SQLDialect := c.SQLDialect;

    try
      Database.Open;
      // проверим, что мы в подходящей БД
      try
        ds := OpenSQL('select count(*) from RDB$RELATIONS where RDB$RELATION_NAME containing ''DYNAMIC_FORM'' and RDB$RELATION_TYPE = 0');
        if (not ds.Active) or ds.IsEmpty or ds.Fields.Fields[0].Value < 14 then
          raise Exception.Create('Подключение "' + c.Alias + '" не является базой данных портала!');
      finally
        ds.Close;
        ds.Free;
      end;

      Caption := Application.Title + ' : ' + c.Alias + ' [' + FSettings.cbServer.Items[Ord(c.Server)] + ':' + c.Host + ':' + c.DataBase + ']';
      dsPortalUser.Close;
      dsPortalUser.ParamByName('LOGIN').AsString := FSettings.PortalUser;
      dsPortalUser.Open;
      if dsPortalUser.IsEmpty then raise Exception.Create('Пользователь "' + FSettings.PortalUser + '" не зарегистрирован!');

      IsAdmin := AnsiLowerCase(dsPortalUserROLE_NAME.AsString) = 'admin';
      IsDeveloper := (dsPortalUserDEVELOPER.AsString = '1') or (AnsiLowerCase(dsPortalUserROLE_NAME.AsString) = 'developer');
      IsActive := dsPortalUserISACTIVE.AsString = '1';
      StatusBar.Panels[1].Text := FSettings.PortalUser;
      StatusBar.Panels[2].Text := dsPortalUserNAME.AsString;
    except
      on e: Exception do
      begin
        if Database.Connected then Database.Close;
        if Pos('user name and password', e.Message) > 0 then err := ProhibMes[0]
        else if Pos('I/O error', e.Message) > 0 then err := Format(ProhibMes[1], [Database.DBName])
        else if Pos('network request', e.Message) > 0 then err := Format(ProhibMes[2], [ExtractWordEx(1, Database.DBName, [':'], [])])
        else if (Pos('SQL error', e.Message) > 0) or (Pos('Parameter', e.Message) > 0) then err := Format(ProhibMes[3], [e.Message])
        else err := Format(ProhibMes[3], [e.Message]);

        Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
      end;
    end;
  finally
    fc.Free;
    FSettings.ActivateConnectControls(not Database.Connected);
    ConnectChecker.Active := Database.Connected;
  end;
end;

procedure TFMain.ConnectToUpdate;
var
  s, err: string;
  c: TConnection;
  ds: TpFIBDataSet;

begin
  if DBUpdate.Connected then DBUpdate.Close;

  Screen.Cursor := crSQLWait;
  try
    c := FSettings.ConnByIndex[FSettings.UpdateConnect];
    if (c.DataBase = '') then raise Exception.Create('Подключение к БД не настроено!');
    if (c.Server <> stFirebird) then raise Exception.Create('Подключение к БД задано неверно! Возможна работа только с серверами Firebird');

    if c.Host <> '' then
    begin
      if c.Port = 3050 then s := c.Host
      else s := c.Host + '/' + IntToStr(c.Port);
      s := s + ':';
    end;

    DBUpdate.DBName := s + c.DataBase;
    DBUpdate.ConnectParams.UserName := c.UserName;
    DBUpdate.ConnectParams.Password := c.Pass;
    DBUpdate.ConnectParams.RoleName := c.Role;
    DBUpdate.ConnectParams.CharSet := c.Encoding;
    DBUpdate.SQLDialect := c.SQLDialect;

    try
      DBUpdate.Open;
      // проверим, что мы в подходящей БД
      try
        ds := TpFIBDataSet.Create(Self);
        ds.Database := DBUpdate;
        ds.SQLs.SelectSQL.Text := 'select count(*) from RDB$RELATIONS where RDB$RELATION_NAME = ''DCFG_UPDATE'' and RDB$RELATION_TYPE = 0';
        ds.Open;
        if (not ds.Active) or ds.IsEmpty or ds.Fields.Fields[0].Value = 0 then
        begin
          DBUpdate.Close;
          raise Exception.Create('Подключение "' + c.Alias + '" не поддерживает возможность обновляться!');
        end;
      finally
        ds.Close;
        ds.Free;
      end;
    except
      on e: Exception do
      begin
        if Pos('user name and password', e.Message) > 0 then err := ProhibMes[0]
        else if Pos('I/O error', e.Message) > 0 then err := Format(ProhibMes[1], [DBUpdate.DBName])
        else if Pos('network request', e.Message) > 0 then err := Format(ProhibMes[2], [ExtractWordEx(1, DBUpdate.DBName, [':'], [])])
        else if (Pos('SQL error', e.Message) > 0) or (Pos('Parameter', e.Message) > 0) then err := Format(ProhibMes[3], [e.Message])
        else err := Format(ProhibMes[3], [e.Message]);

        raise Exception.Create(err);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFMain.CopyChartsInternal(RefPk, NewRefPk: integer; FieldsList, ChartGroupList: TStringList);
var
  ds: TpFIBDataSet;
  err: string;

begin
  try
    ds := OpenSQL('select PK, X_FIELD_PK, Y_FIELD_PK, GROUP_FUNCTION, SERIES_DIF, TITLE, CHART_TYPE, ORDER_, ' +
      'X_AXIS_ROTATE, ADDITIONAL_FIELD, ADDITIONAL_FIELD_ROTATE, Y_TITLE, GROUP_PK, GROUP_ORDER from DYNAMIC_FORM_CHARTS ' +
      'where REFERENC_PK = ' + IntToStr(RefPk));

    ds.First;
    while not ds.Eof do
    begin
      if not ExecSQL('insert into DYNAMIC_FORM_CHARTS (REFERENC_PK, X_FIELD_PK, Y_FIELD_PK, GROUP_FUNCTION, SERIES_DIF, TITLE, ' +
        'CHART_TYPE, ORDER_, X_AXIS_ROTATE, ADDITIONAL_FIELD, ADDITIONAL_FIELD_ROTATE, Y_TITLE, GROUP_PK, GROUP_ORDER) values (' +
        IntToStr(NewRefPk) + ', ' + VariantToDBStr(FieldsList.Values[ds.FieldByName('X_FIELD_PK').AsString], true) + ', ' +
        VariantToDBStr(FieldsList.Values[ds.FieldByName('Y_FIELD_PK').AsString], true) + ', ' +
        VariantToDBStr(ds.FieldByName('GROUP_FUNCTION').Value, true) + ', ' +
        VariantToDBStr(FieldsList.Values[ds.FieldByName('SERIES_DIF').AsString], true) + ', ' +
        VariantToDBStr(ReplaceQuote(ds.FieldByName('TITLE').AsString), true) + ', ' + VariantToDBStr(ds.FieldByName('CHART_TYPE').Value, true) +
        ', ' + VariantToDBStr(ReplaceQuote(ds.FieldByName('ORDER_').AsString), true) + ', ' +
        VariantToDBStr(ds.FieldByName('X_AXIS_ROTATE').Value, false) + ', ' +
        VariantToDBStr(ReplaceQuote(ds.FieldByName('ADDITIONAL_FIELD').AsString), true) + ', ' +
        VariantToDBStr(ds.FieldByName('ADDITIONAL_FIELD_ROTATE').Value, false) + ', ' +
        VariantToDBStr(ReplaceQuote(ds.FieldByName('Y_TITLE').AsString), true) + ', ' +
        VariantToDBStr(ChartGroupList.Values[ds.FieldByName('GROUP_PK').AsString], true) + ', ' +
        VariantToDBStr(ds.FieldByName('GROUP_ORDER').Value, false) + ')', err) then
        raise Exception.Create(err);

      ds.Next;
    end;
  finally
    ds.Close;
    ds.Free;
  end;
end;

function TFMain.CopyDict(ObjPk: integer; ParentRefPk: Variant; DictList, FormList, FieldsList, ObjectList, PermTmpList,
  ChartGroupList: TStringList; IsMain: boolean; var ErrorMessage: string): boolean;
var
  ds: TpFIBDataSet;
  mainFrmPk: Variant;
  startFrmPk: Variant;
  grEditFrmPk: Variant;
  refPk, tmpVar: Variant;
  d: TNodeDictInfo;
  grList: TStringList;
  fgrList: TStringList;
  fltrConfList: TStringList;

begin
  result := false;
  d := AssignNodeData(cotDict);
  if not CheckGrants(gaAdd, d, ErrorMessage) then exit;
  grList := TStringList.Create;
  fgrList := TStringList.Create;
  fltrConfList := TStringList.Create;

  try
    try
      ds := OpenSQL('select PK, TITLE, ORDER_BY, DESCRIPTOR_, MAIN_FORM_PK, START_FORM_PK, BASE_DESCRIPTOR, FOLDER_PK, ' +
        'PARENT_ID_FIELD, ID_FIELD, EXPAND_REF, COLLAPSE_FILTER, SHOW_CHILD_REF, GROUPING, CON_ORIENT, BRIEF_NOTE, EDITABLE, ' +
        'SET_DISTINCT, REF_SIZE, GROUP_EDIT_FORM_PK, SHOW_ONLY_ADMIN, INSERT_COUNT, EXPAND_TREE, USE_MEM, COUNT_ON_PAGE, ' +
        'DEFERRED_IMPORTS, AUTOSAVEINTERVAL, SKIP_DUPLICATES, SHOW_FILTER_BOUND, CHECK_SELECT from DYNAMIC_FORM_REFERENCE where ' +
        'PK = ' + IntToStr(ObjPk));

      if ds.IsEmpty then
      begin
        ErrorMessage := 'Справочник с PK ' + IntToStr(ObjPk) + ' не найден в базе данных!';
        exit;
      end;

      // формы: главная, стартовая, группового редактирования
      mainFrmPk := CopyFormInternal(ds.FieldByName('MAIN_FORM_PK').AsInteger, false, FieldsList, ObjectList, grList, fgrList);
      FormList.Values[ds.FieldByName('MAIN_FORM_PK').AsString] := VarToStr(mainFrmPk);
      if not ds.FieldByName('START_FORM_PK').IsNull then
      begin
        startFrmPk := CopyFormInternal(ds.FieldByName('START_FORM_PK').AsInteger, false, FieldsList, ObjectList, grList, fgrList);
        FormList.Values[ds.FieldByName('START_FORM_PK').AsString] := VarToStr(startFrmPk);
      end;
      if not ds.FieldByName('GROUP_EDIT_FORM_PK').IsNull then
      begin
        grEditFrmPk := CopyFormInternal(ds.FieldByName('GROUP_EDIT_FORM_PK').AsInteger, false, FieldsList, ObjectList, grList, fgrList);
        FormList.Values[ds.FieldByName('GROUP_EDIT_FORM_PK').AsString] := VarToStr(grEditFrmPk);
      end;

      // справочник
      result := ExecSQL('insert into DYNAMIC_FORM_REFERENCE (OWNER_USER_PK, TITLE, ORDER_BY, DESCRIPTOR_, PARENT_REFERENCE_PK, MAIN_FORM_PK, ' +
        'START_FORM_PK, BASE_DESCRIPTOR, FOLDER_PK, PARENT_ID_FIELD, ID_FIELD, EXPAND_REF, COLLAPSE_FILTER, SHOW_CHILD_REF, GROUPING, CON_ORIENT, ' +
        'BRIEF_NOTE, EDITABLE, SET_DISTINCT, REF_SIZE, GROUP_EDIT_FORM_PK, SHOW_ONLY_ADMIN, INSERT_COUNT, EXPAND_TREE, USE_MEM, ' +
        'COUNT_ON_PAGE, DEFERRED_IMPORTS, AUTOSAVEINTERVAL, SKIP_DUPLICATES, SHOW_FILTER_BOUND, CHECK_SELECT) values (' +
        VariantToDBStr(dsPortalUserPK.Value, false) + ', ''' + ReplaceQuote(ds.FieldByName('TITLE').AsString) + ' - копия'', ' +
        VariantToDBStr(ReplaceQuote(ds.FieldByName('ORDER_BY').AsString), true) + ', ''' + ds.FieldByName('DESCRIPTOR_').AsString +
        '_COPY'', ' + VariantToDBStr(ParentRefPk, false) + ', ' + VariantToDBStr(mainFrmPk, false) + ', ' + VariantToDBStr(startFrmPk, false) +
        ', ''' + ds.FieldByName('BASE_DESCRIPTOR').AsString + ''', ' + VariantToDBStr(ds.FieldByName('FOLDER_PK').Value, false) + ', ' +
        VariantToDBStr(ds.FieldByName('PARENT_ID_FIELD').Value, true) + ', ' + VariantToDBStr(ds.FieldByName('ID_FIELD').Value, true) + ', ' +
        VariantToDBStr(ds.FieldByName('EXPAND_REF').Value, true) + ', ' + VariantToDBStr(ds.FieldByName('COLLAPSE_FILTER').Value, true) + ', ' +
        VariantToDBStr(ds.FieldByName('SHOW_CHILD_REF').Value, true) + ', ' +
        VariantToDBStr(ReplaceQuote(ds.FieldByName('GROUPING').AsString), true) + ', ' + VariantToDBStr(ds.FieldByName('CON_ORIENT').Value, false) +
        ', ' + VariantToDBStr(ds.FieldByName('BRIEF_NOTE').Value, false) + ', ' + VariantToDBStr(ds.FieldByName('EDITABLE').Value, false) +
        ', ''' + ds.FieldByName('SET_DISTINCT').AsString + ''', ' + VariantToDBStr(ds.FieldByName('REF_SIZE').Value, false) + ', ' +
        VariantToDBStr(grEditFrmPk, false) + ', ' + VariantToDBStr(ds.FieldByName('SHOW_ONLY_ADMIN').Value, false) + ', ' +
        VariantToDBStr(ds.FieldByName('INSERT_COUNT').Value, false) + ', ' + VariantToDBStr(ds.FieldByName('EXPAND_TREE').Value, false) + ', ' +
        VariantToDBStr(ds.FieldByName('USE_MEM').Value, false) + ', ' + VariantToDBStr(ds.FieldByName('COUNT_ON_PAGE').Value, false) + ', ' +
        VariantToDBStr(ds.FieldByName('DEFERRED_IMPORTS').Value, false) + ', ' + VariantToDBStr(ds.FieldByName('AUTOSAVEINTERVAL').Value, false) +
        ', ' + VariantToDBStr(ds.FieldByName('SKIP_DUPLICATES').Value, true) + ', ' +
        VariantToDBStr(ds.FieldByName('SHOW_FILTER_BOUND').Value, true) + ', ' + VariantToDBStr(ds.FieldByName('CHECK_SELECT').Value, false) +
        ') returning (PK)', 'PK', refPk, ErrorMessage);

      if not result then exit;
      DictList.Values[IntToStr(ObjPk)] := VarToStr(refPk);
      d := AssignNodeData(cotDict);
      d.PK := refPk;
      d.Descriptor := ds.FieldByName('DESCRIPTOR_').AsString + '_COPY';
      d.Title := ds.FieldByName('TITLE').AsString + ' - копия';
      d.ParentDictPK := ParentRefPk;
      d.FolderPK := ds.FieldByName('FOLDER_PK').Value;
      d.Login := FSettings.PortalUser;

      // все используемые шаблоны прав
      ds.Close;
      FreeAndNil(ds);
      ds := OpenSQL('select distinct t.PK_TMP, tmp.TEXT_TEMPLATE from ( ' +
        'select ADD_ PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK and ADD_ is not null and ADD_ <> 0 and ADD_ <> 1 ' +
        'union select EDIT_ PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK and EDIT_ is not null and EDIT_ <> 0 and EDIT_ <> 1 ' +
        'union select DEL_ PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK and DEL_ is not null and DEL_ <> 0 and DEL_ <> 1 ' +
        'union select VIEW_REF PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK and VIEW_REF is not null and VIEW_REF <> 0 and VIEW_REF <> 1 ' +
        'union select CONFIG_ PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK and CONFIG_ is not null and CONFIG_ <> 0 and CONFIG_ <> 1 ' +
        'union select VIEW_ PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK and VIEW_ is not null and VIEW_ <> 0 and VIEW_ <> 1 ' +
        'union select EXPORT PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK and EXPORT is not null and EXPORT <> 0 and EXPORT <> 1 ' +
        'union select IMPORT PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK and IMPORT is not null and IMPORT <> 0 and IMPORT <> 1 ' +
        'union select FILTRING PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK and FILTRING is not null and FILTRING <> 0 and FILTRING <> 1 ' +
        'union select GRID_SAVE PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK and GRID_SAVE is not null and GRID_SAVE <> 0 and GRID_SAVE <> 1 ' +
        'union select ADD_ PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK and ADD_ is not null and ADD_ <> 0 and ADD_ <> 1 ' +
        'union select EDIT_ PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK and EDIT_ is not null and EDIT_ <> 0 and EDIT_ <> 1 ' +
        'union select DEL_ PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK and DEL_ is not null and DEL_ <> 0 and DEL_ <> 1 ' +
        'union select VIEW_REF PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK and VIEW_REF is not null and VIEW_REF <> 0 and VIEW_REF <> 1 ' +
        'union select CONFIG_ PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK and CONFIG_ is not null and CONFIG_ <> 0 and CONFIG_ <> 1 ' +
        'union select VIEW_ PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK and VIEW_ is not null and VIEW_ <> 0 and VIEW_ <> 1 ' +
        'union select EXPORT PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK and EXPORT is not null and EXPORT <> 0 and EXPORT <> 1 ' +
        'union select IMPORT PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK and IMPORT is not null and IMPORT <> 0 and IMPORT <> 1 ' +
        'union select FILTRING PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK and FILTRING is not null and FILTRING <> 0 and FILTRING <> 1 ' +
        'union select GRID_SAVE PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK and GRID_SAVE is not null and GRID_SAVE <> 0 and GRID_SAVE <> 1) ' +
        'as t join DYNAMIC_FORM_PERM_TMP tmp on tmp.PK = t.PK_TMP', 'PK=' + IntToStr(ObjPk));

      ds.First;
      while not ds.Eof do
      begin
        result := ExecSQL('insert into DYNAMIC_FORM_PERM_TMP (TEXT_TEMPLATE) values (' +
          VariantToDBStr(ReplaceQuote(ds.FieldByName('TEXT_TEMPLATE').AsString), true) + ') returning (PK)', 'PK', tmpVar, ErrorMessage);

        if not result then exit;
        PermTmpList.Values[ds.FieldByName('PK_TMP').AsString] := VarToStr(tmpVar);
        ds.Next;
      end;

      // права ролей, права должностей
      CopyPermsInternal(ObjPk, refPk, 'DYNAMIC_FORM_PERMISSIONS', PermTmpList);
      CopyPermsInternal(ObjPk, refPk, 'DYNAMIC_FORM_PERM_RANKS', PermTmpList);

      // конфигурации фильтров
      ds.Close;
      FreeAndNil(ds);
      ds := OpenSQL('select PK, NAME, FILTER_VALUE from DYNAMIC_FORM_FILTER_CONFIG where REF_PK = ' + IntToStr(ObjPk));
      ds.First;
      while not ds.Eof do
      begin
        result := ExecSQL('insert into DYNAMIC_FORM_FILTER_CONFIG (NAME, REF_PK, FILTER_VALUE) values (''' +
          ReplaceQuote(ds.FieldByName('NAME').AsString) + ''', ' + VariantToDBStr(refPk, false) + ', ' +
          VariantToDBStr(ReplaceQuote(ds.FieldByName('FILTER_VALUE').AsString), true) + ') returning PK', 'PK', tmpVar, ErrorMessage);

        if not result then exit;
        fltrConfList.Values[ds.FieldByName('PK').AsString] := VarToStr(tmpVar);
        ds.Next;
      end;

      // привязка конфигураций фильтров к должностям
      ds.Close;
      FreeAndNil(ds);
      ds := OpenSQL('select p.POST_PK, p.FILTER_CONFIG_PK from DYNAMIC_FROM_POST_FILTER p join DYNAMIC_FORM_FILTER_CONFIG c on c.PK = p.FILTER_CONFIG_PK ' +
        'where c.REF_PK = ' + IntToStr(ObjPk));
      ds.First;
      while not ds.Eof do
      begin
        result := ExecSQL('insert into DYNAMIC_FROM_POST_FILTER (POST_PK, FILTER_CONFIG_PK) values (' +
          VariantToDBStr(ds.FieldByName('POST_PK').Value, false) + ', ' +
          VariantToDBStr(fltrConfList.Values[ds.FieldByName('FILTER_CONFIG_PK').AsString], false) + ')', ErrorMessage);

        if not result then exit;
        ds.Next;
      end;

      // группы графиков
      ds.Close;
      FreeAndNil(ds);
      ds := OpenSQL('select PK, TITLE, ORIENTATION from DYNAMIC_FORM_CHART_GROUPS where REFERENCE_PK = ' + IntToStr(ObjPk));
      ds.First;
      while not ds.Eof do
      begin
        result := ExecSQL('insert into DYNAMIC_FORM_CHART_GROUPS (REFERENCE_PK, TITLE, ORIENTATION) values (' +
          VariantToDBStr(refPk, false) + ', ' + VariantToDBStr(ReplaceQuote(ds.FieldByName('TITLE').AsString), true) + ', ' +
          VariantToDBStr(ds.FieldByName('ORIENTATION').Value, true) + ') returning (PK)', 'PK', tmpVar, ErrorMessage);

        if not result then exit;
        ChartGroupList.Values[ds.FieldByName('PK').AsString] := VarToStr(tmpVar);
        ds.Next;
      end;

      // доп. кнопки (пункты меню)
      ds.Close;
      FreeAndNil(ds);
      ds := OpenSQL('select ID_EV, ID_DF_REFERENCE, TITLE_EV, EVENT_REFERENCE, POSITION_EV, IMAGE_NAME_EV, VIEW_TO_MENU, CLASS_NAME, IS_VIZARD, ' +
        'ALIAS_DF, LINK_METHOD from DYNAMIC_FORM_OTHER_EVENT where ID_DF_REFERENCE = ' + IntToStr(ObjPk));
      ds.First;
      while not ds.Eof do
      begin
        result := ExecSQL('insert into DYNAMIC_FORM_OTHER_EVENT (ID_DF_REFERENCE, TITLE_EV, EVENT_REFERENCE, POSITION_EV, IMAGE_NAME_EV, VIEW_TO_MENU, ' +
          'CLASS_NAME, IS_VIZARD, ALIAS_DF, LINK_METHOD) values (' + VariantToDBStr(refPk, false) + ', ' +
          VariantToDBStr(ReplaceQuote(ds.FieldByName('TITLE_EV').AsString), true) + ', ' + VariantToDBStr(ds.FieldByName('EVENT_REFERENCE').Value, false) + ', ' +
          VariantToDBStr(ds.FieldByName('POSITION_EV').Value, false) + ', ' + VariantToDBStr(ds.FieldByName('IMAGE_NAME_EV').Value, true) + ', ' +
          VariantToDBStr(ds.FieldByName('VIEW_TO_MENU').Value, false) + ', ' + VariantToDBStr(ds.FieldByName('CLASS_NAME').Value, true) + ', ' +
          VariantToDBStr(ds.FieldByName('IS_VIZARD').Value, false) + ', ' + VariantToDBStr(ds.FieldByName('ALIAS_DF').Value, true) + ', ' +
          VariantToDBStr(ds.FieldByName('LINK_METHOD').Value, true) + ')', ErrorMessage);

        if not result then exit;
        ds.Next;
      end;

      // DYNAMIC_FORM_TREE_INDEX
      ds.Close;
      FreeAndNil(ds);
      ds := OpenSQL('select ELEMENT_ID, LEFT_NUM, RIGHT_NUM, LVL from DYNAMIC_FORM_TREE_INDEX where REFERENCE_ID = ' + IntToStr(ObjPk) +
        ' order by ELEMENT_ID');
      ds.First;
      while not ds.Eof do
      begin
        result := ExecSQL('insert into DYNAMIC_FORM_TREE_INDEX (ELEMENT_ID, REFERENCE_ID, LEFT_NUM, RIGHT_NUM, LVL) values (' +
          ds.FieldByName('ELEMENT_ID').AsString + ', ' + VariantToDBStr(refPk, false) + ', ' +
          VariantToDBStr(ds.FieldByName('LEFT_NUM').Value, false) + ', ' + VariantToDBStr(ds.FieldByName('RIGHT_NUM').Value, false) + ', ' +
          VariantToDBStr(ds.FieldByName('LVL').Value, false) + ')', ErrorMessage);

        if not result then exit;
        ds.Next;
      end;

      // дочерние справочники
      ds.Close;
      FreeAndNil(ds);
      ds := OpenSQL('select PK from DYNAMIC_FORM_REFERENCE where PARENT_REFERENCE_PK = ' + IntToStr(ObjPk) + ' order by PK');
      ds.First;
      while not ds.Eof do
      begin
        result := CopyDict(ds.FieldByName('PK').AsInteger, refPk, DictList, FormList, FieldsList, ObjectList, PermTmpList,
          ChartGroupList, false, ErrorMessage);
        if not result then exit;
        ds.Next;
      end;

      if IsMain then
      begin
        // копируем все поля всех форм справочника и его дочерних справочников
        CopyDictAllFields(ObjPk, FormList, FieldsList, ObjectList, grList, fgrList);
        
        // графики - их надо делать всей кучей у всех, т.к. они могут ссылаться на поля и группы др. справочника
        // 1. главного справочника
        CopyChartsInternal(ObjPk, refPk, FieldsList, ChartGroupList);

        // 2. дочерних справочников
        ds.First;
        while not ds.Eof do
        begin
          if DictList.Values[ds.FieldByName('PK').AsString] <> '' then
            CopyChartsInternal(ds.FieldByName('PK').AsInteger, StrToInt(DictList.Values[ds.FieldByName('PK').AsString]), FieldsList, ChartGroupList);
          ds.Next;
        end;

        // теперь открываем все созданные справочники: дочерние, потом главный (чтоб в самом верху оказался)
        OpenChildRef(refPk);
        OpenRef(d);
      end;
      result := true;
    finally
      grList.Free;
      fgrList.Free;
      fltrConfList.Free;
      if Assigned(ds) then
      begin
        ds.Close;
        ds.Free;
      end;

      if Assigned(d) then d.Free;
    end;
  except
    on e: Exception do
    begin
      ErrorMessage := e.Message;
      result := false;
    end;
  end;
end;

procedure TFMain.CopyDictAllFields(RefPk: integer; FormList, FieldsList, ObjectList, GroupsList, FilterGroups: TStringList);
var
  ds: TpFIBDataSet;
  
begin
  try
    ds := OpenSQL('select PK, MAIN_FORM_PK, START_FORM_PK, GROUP_EDIT_FORM_PK from DYNAMIC_FORM_REFERENCE where PK = ' + IntToStr(RefPk));
    if ds.IsEmpty then raise Exception.Create('Не найден справочник с PK ' + IntToStr(RefPk) + ' в базе данных!');

    // главная
    if (not ds.FieldByName('MAIN_FORM_PK').IsNull) and (FormList.Values[ds.FieldByName('MAIN_FORM_PK').AsString] <> '') then
      CopyFormFields(ds.FieldByName('MAIN_FORM_PK').AsInteger, StrToInt(FormList.Values[ds.FieldByName('MAIN_FORM_PK').AsString]),
        true, FieldsList, ObjectList, GroupsList, FilterGroups);

    // стартовая
    if (not ds.FieldByName('START_FORM_PK').IsNull) and (FormList.Values[ds.FieldByName('START_FORM_PK').AsString] <> '') then
      CopyFormFields(ds.FieldByName('START_FORM_PK').AsInteger, StrToInt(FormList.Values[ds.FieldByName('START_FORM_PK').AsString]),
        true, FieldsList, ObjectList, GroupsList, FilterGroups);

    // группового редактирования
    if (not ds.FieldByName('GROUP_EDIT_FORM_PK').IsNull) and (FormList.Values[ds.FieldByName('GROUP_EDIT_FORM_PK').AsString] <> '') then
      CopyFormFields(ds.FieldByName('GROUP_EDIT_FORM_PK').AsInteger, StrToInt(FormList.Values[ds.FieldByName('GROUP_EDIT_FORM_PK').AsString]),
        true, FieldsList, ObjectList, GroupsList, FilterGroups);

    // формы дочерних справочников
    ds.Close;
    FreeAndNil(ds);
    ds := OpenSQL('select PK from DYNAMIC_FORM_REFERENCE where PARENT_REFERENCE_PK = ' + IntToStr(RefPk) + ' order by PK');
    ds.First;
    while not ds.Eof do
    begin
      CopyDictAllFields(ds.FieldByName('PK').AsInteger, FormList, FieldsList, ObjectList, GroupsList, FilterGroups);
      ds.Next;
    end;
  finally
    if Assigned(ds) then
    begin
      ds.Close;
      ds.Free;
    end;
  end;
end;

function TFMain.CopyFolder(ObjPk: integer; var ErrorMessage: string): boolean;
var
  ds: TpFIBDataSet;
  fFolder: TFEditFolder;
  d: TNodeDictInfo;

begin
  result := false;
  d := AssignNodeData(cotFolder);
  if not CheckGrants(gaAdd, d, ErrorMessage) then exit;

  try
    try
      ds := OpenSQL('select PK, NAME, PARENT_FOLDER_PK from DYNAMIC_FORM_FOLDER where PK = ' + IntToStr(ObjPk));
    except
      on e: Exception do
      begin
        ErrorMessage := e.Message;
        exit;
      end;
    end;

    if ds.IsEmpty then
    begin
      ErrorMessage := 'Папка с PK ' + IntToStr(ObjPk) + ' не найдена в базе данных!';
      exit;
    end;

    d.Title := ds.FieldByName('NAME').Value;
    d.FolderPK := ds.FieldByName('PARENT_FOLDER_PK').Value;
    fFolder := TFEditFolder.Create(Self, cftFolder, omAdd, Null, OnChildFormClose);
    fFolder.Properties := d;
    RegisterChildForm(fFolder);
    //fFolder.Show;
    result := true;
  finally
    ds.Close;
    ds.Free;
    if Assigned(d) then d.Free;
  end;
end;

function TFMain.CopyForm(ObjPk: integer; var ErrorMessage: string): boolean;
var
  ds: TpFIBDataSet;
  fForm: TFEditForm;
  d: TNodeDictInfo;
  slf, slo, slg, slgf: TStringList;
  frmPk: Variant;

begin
  result := false;
  d := AssignNodeData(cotForm);
  if not CheckGrants(gaAdd, d, ErrorMessage) then exit;

  slf := TStringList.Create;
  slo := TStringList.Create;
  slg := TStringList.Create;
  slgf := TStringList.Create;
  try
    try
      frmPk := CopyFormInternal(ObjPk, true, slf, slo, slg, slgf);
      if VarIsNull(frmPk) then raise Exception.Create('Не удалось скопировать форму!');
      ds := OpenSQL('select PK, TITLE, ALIAS_FORM from DYNAMIC_FORM where PK = ' + VarToStr(frmPk));
      if ds.IsEmpty then raise Exception.Create('Не удалось скопировать форму!');

      fForm := TFEditForm.Create(Self, cftForm, omEdit, frmPk, OnChildFormClose);
      d := AssignNodeData(cotForm);
      d.PK := frmPk;
      d.Descriptor := ds.FieldByName('ALIAS_FORM').Value;
      d.Title := ds.FieldByName('TITLE').Value;
      d.Login := FSettings.PortalUser;
      fForm.Properties := d;
      RegisterChildForm(fForm);
      //fForm.Show;
      result := true;
      ReopenTree(false);
    except
      on e: Exception do ErrorMessage := e.Message;
    end;
  finally
    slf.Free;
    slo.Free;
    slg.Free;
    slgf.Free;
    if Assigned(ds) then
    begin
      ds.Close;
      ds.Free;
    end;
    if Assigned(d) then d.Free;
  end;
end;

procedure TFMain.CopyFormFields(FormPk, NewFormPk: integer; BindObjects: boolean; FieldsList, ObjectList, GroupsList, FilterGroups: TStringList);
var
  ds: TpFIBDataSet;
  err: string;
  tmpVar: Variant;

begin
  try
    ds := OpenSQL('select PK, GROUP_PK, GROUP_COLUMN, OBJECT_PK, ORDER_, TITLE, DESCRIPTION, TYPE_NAME, FIELD_NAME, ' +
      'STYLE_EXTERNAL, STYLE, PARAMETERS, IS_VISIBLE, GRID_VISIBLE, GRID_ORDER, GRID_WIDTH, EDITABLE, ADD_EDITABLE, ' +
      'EXCEL_EXPORT, IS_VISIBLE_ADD, FILTER_ORDER, IS_FILTER, SHOW_IN_START_FORM, STYLE_COLUMN, EDIT_IN_TABLE, SHOW_IN_GROUP_EDIT, ' +
      'EXCEL_IMPORT, MATCH, LOCKED, FILTER_GROUP from DYNAMIC_FORM_FIELD where FORM_PK = ' + IntToStr(FormPk));

    ds.First;
    while not ds.Eof do
    begin
      if not ExecSQL('insert into DYNAMIC_FORM_FIELD (OWNER_USER_PK, GROUP_PK, GROUP_COLUMN, OBJECT_PK, ORDER_, TITLE, DESCRIPTION, TYPE_NAME, ' +
        'FIELD_NAME, STYLE_EXTERNAL, STYLE, PARAMETERS, IS_VISIBLE, FORM_PK, GRID_VISIBLE, GRID_ORDER, GRID_WIDTH, EDITABLE, ADD_EDITABLE, ' +
        'EXCEL_EXPORT, IS_VISIBLE_ADD, FILTER_ORDER, IS_FILTER, SHOW_IN_START_FORM, STYLE_COLUMN, EDIT_IN_TABLE, SHOW_IN_GROUP_EDIT, ' +
        'EXCEL_IMPORT, MATCH, LOCKED, FILTER_GROUP) values (' + VariantToDBStr(dsPortalUserPK.Value, false) + ', ' +
        VariantToDBStr(GroupsList.Values[ds.FieldByName('GROUP_PK').AsString], false) + ', ' + ds.FieldByName('GROUP_COLUMN').AsString + ', ' +
        iif(BindObjects, VariantToDBStr(ObjectList.Values[ds.FieldByName('OBJECT_PK').AsString], false), 'null') + ', ' +
        ds.FieldByName('ORDER_').AsString + ', ''' + ReplaceQuote(ds.FieldByName('TITLE').AsString) + ''', ''' +
        ReplaceQuote(ds.FieldByName('DESCRIPTION').AsString) + ''', ''' + ds.FieldByName('TYPE_NAME').AsString + ''', ''' +
        ds.FieldByName('FIELD_NAME').AsString + ''', ''' + ReplaceQuote(ds.FieldByName('STYLE_EXTERNAL').AsString) + ''', ''' +
        ReplaceQuote(ds.FieldByName('STYLE').AsString) + ''', ''' + ReplaceQuote(ds.FieldByName('PARAMETERS').AsString) + ''', ' +
        ds.FieldByName('IS_VISIBLE').AsString + ', ' + IntToStr(NewFormPk) + ', ' + ds.FieldByName('GRID_VISIBLE').AsString + ', ' +
        ds.FieldByName('GRID_ORDER').AsString + ', ' + VariantToDBStr(ds.FieldByName('GRID_WIDTH').Value, false) + ', ' +
        ds.FieldByName('EDITABLE').AsString + ', ' + ds.FieldByName('ADD_EDITABLE').AsString + ', ' + ds.FieldByName('EXCEL_EXPORT').AsString +
        ', ' + ds.FieldByName('IS_VISIBLE_ADD').AsString + ', ' + VariantToDBStr(ds.FieldByName('FILTER_ORDER').Value, false) + ', ' +
        VariantToDBStr(ds.FieldByName('IS_FILTER').Value, false) + ', ' + ds.FieldByName('SHOW_IN_START_FORM').AsString + ', ' +
        VariantToDBStr(ReplaceQuote(ds.FieldByName('STYLE_COLUMN').AsString), true) + ', ' +
        VariantToDBStr(ds.FieldByName('EDIT_IN_TABLE').Value, false) + ', ' + ds.FieldByName('SHOW_IN_GROUP_EDIT').AsString + ', ' +
        VariantToDBStr(ds.FieldByName('EXCEL_IMPORT').Value, false) + ', ' + VariantToDBStr(ds.FieldByName('MATCH').Value, false) + ', ' +
        VariantToDBStr(ds.FieldByName('LOCKED').Value, false) + ', ' +
        VariantToDBStr(FilterGroups.Values[ds.FieldByName('FILTER_GROUP').AsString], false) + ') returning (PK)', 'PK', tmpVar, err) then
        raise Exception.Create(err);

      FieldsList.Values[ds.FieldByName('PK').AsString] := VarToStr(tmpVar);
      ds.Next;
    end;
  finally
    if Assigned(ds) then
    begin
      ds.Close;
      ds.Free;
    end;
  end;
end;

function TFMain.CopyFormInternal(FormPk: integer; SimpleMode: boolean; FieldsList, ObjectList, GroupsList, FilterGroups: TStringList): Variant;
var
  ds: TpFIBDataSet;
  err: string;
  alias, title: string;
  tmpVar: Variant;
  objOrders: TStringList;
  i: integer;
  
begin
  result := Null;

  objOrders := TStringList.Create;
  try
    ds := OpenSQL('select PK, TITLE, WIDTH, HEIGHT, ALIAS_FORM, LEFT_ALIGN, LABEL_WIDTH from DYNAMIC_FORM where PK = ' + IntToStr(FormPk));
    if ds.IsEmpty then raise Exception.Create('Форма с PK ' + IntToStr(FormPk) + ' не найдена в базе данных!');

    // сама форма
    if (not ds.FieldByName('ALIAS_FORM').IsNull) and (ds.FieldByName('ALIAS_FORM').AsString <> '') then
      alias := ds.FieldByName('ALIAS_FORM').AsString + '_COPY';

    if SimpleMode then
      title := ds.FieldByName('TITLE').AsString + ' - копия'
    else
      title := ds.FieldByName('TITLE').AsString;

    if not ExecSQL('insert into DYNAMIC_FORM (OWNER_USER_PK, TITLE, WIDTH, HEIGHT, ALIAS_FORM, LEFT_ALIGN, LABEL_WIDTH) values (' +
      VariantToDBStr(dsPortalUserPK.Value, false) + ', ''' + ReplaceQuote(title) + ''', ' +
      VariantToDBStr(ds.FieldByName('WIDTH').Value, false) + ', ' + VariantToDBStr(ds.FieldByName('HEIGHT').Value, false) +
      ', ' + VariantToDBStr(alias, true) + ', ' + VariantToDBStr(ds.FieldByName('LEFT_ALIGN').Value, false) + ', ' +
      VariantToDBStr(ds.FieldByName('LABEL_WIDTH').Value, false) + ') returning (PK)', 'PK', result, err) then
      raise Exception.Create(err);

    // объекты
    if not SimpleMode then
    begin
      ds.Close;
      FreeAndNil(ds);
      ds := OpenSQL('select PK, JOIN_PARENT_PK from DYNAMIC_FORM_OBJECT_TREE where FORM_PK = ' + IntToStr(FormPk) + ' and ' +
        '(JOIN_PARENT_PK is null or JOIN_PARENT_PK not in (select PK from DYNAMIC_FORM_OBJECT_TREE where FORM_PK = ' + IntToStr(FormPk) + '))');
      ds.First;
      while not ds.Eof do
      begin
        GetObjectTreeList(FormPk, ds.FieldByName('JOIN_PARENT_PK').Value, objOrders);
        ds.Next;
      end;

      for i := 0 to objOrders.Count - 1 do
      begin
        ds.Close;
        FreeAndNil(ds);
        ds := OpenSQL('select PK, TITLE, NAME, OBJECT_TYPE, JOIN_PARENT_PK, IS_MULTI_JOIN, JOIN_FIELDS, PARAMETERS, DELETED, ' +
          'INNER_JOIN from DYNAMIC_FORM_OBJECT_TREE where PK = ' + objOrders.Strings[i]);

        ds.First;
        while not ds.Eof do
        begin
          if not ExecSQL('insert into DYNAMIC_FORM_OBJECT_TREE (OWNER_USER_PK, TITLE, NAME, OBJECT_TYPE, FORM_PK, JOIN_PARENT_PK, ' +
            'IS_MULTI_JOIN, JOIN_FIELDS, PARAMETERS, DELETED, INNER_JOIN) values (' + VariantToDBStr(dsPortalUserPK.Value, false) + ', ' +
            VariantToDBStr(ReplaceQuote(ds.FieldByName('TITLE').AsString), true) + ', ''' + ds.FieldByName('NAME').AsString + ''', ''' +
            ds.FieldByName('OBJECT_TYPE').AsString + ''', ' + VariantToDBStr(result, false) + ', ' +
            VariantToDBStr(ObjectList.Values[ds.FieldByName('JOIN_PARENT_PK').AsString], false) + ', ''' + ds.FieldByName('IS_MULTI_JOIN').AsString +
            ''', ' + VariantToDBStr(ReplaceQuote(ds.FieldByName('JOIN_FIELDS').AsString), true) + ', ' +
            VariantToDBStr(ReplaceQuote(ds.FieldByName('PARAMETERS').AsString), true) + ', ''' + ds.FieldByName('DELETED').AsString + ''', ' +
            VariantToDBStr(ds.FieldByName('INNER_JOIN').Value, false) + ') returning (PK)', 'PK', tmpVar, err) then
            raise Exception.Create(err);

          ObjectList.Values[ds.FieldByName('PK').AsString] := VarToStr(tmpVar);
          ds.Next;
        end;
      end;
    end;

    // группы полей
    ds.Close;
    FreeAndNil(ds);
    ds := OpenSQL('select PK, PARENT_PK, ORDER_, TITLE, DESCRIPTION, COUNT_COLUMN, STYLE_EXTERNAL, STYLE_INTERNAL, IS_VISIBLE, ' +
      'COLUMN_, STYLE_COLUMNS, ADD_VISIBLE, COLLAPSED, LEFT_ALIGN, LABEL_WIDTH from DYNAMIC_FORM_FIELD_GROUP where FORM_PK = ' + IntToStr(FormPk));

    ds.First;
    while not ds.Eof do
    begin
      if not ExecSQL('insert into DYNAMIC_FORM_FIELD_GROUP (PARENT_PK, OWNER_USER_PK, FORM_PK, ORDER_, TITLE, DESCRIPTION, COUNT_COLUMN, ' +
        'STYLE_EXTERNAL, STYLE_INTERNAL, IS_VISIBLE, COLUMN_, STYLE_COLUMNS, ADD_VISIBLE, COLLAPSED, LEFT_ALIGN, LABEL_WIDTH) ' +
        'values (' + VariantToDBStr(GroupsList.Values[ds.FieldByName('PARENT_PK').AsString], false) + ', ' +
        VariantToDBStr(dsPortalUserPK.Value, false) + ', ' + VariantToDBStr(result, false) + ', ' + ds.FieldByName('ORDER_').AsString + ', ''' +
        ReplaceQuote(ds.FieldByName('TITLE').AsString) + ''', ' + VariantToDBStr(ReplaceQuote(ds.FieldByName('DESCRIPTION').AsString), true) +
        ', ' + ds.FieldByName('COUNT_COLUMN').AsString + ', ''' + ReplaceQuote(ds.FieldByName('STYLE_EXTERNAL').AsString) + ''', ''' +
        ReplaceQuote(ds.FieldByName('STYLE_INTERNAL').AsString) + ''', ''' + ds.FieldByName('IS_VISIBLE').AsString + ''', ' +
        ds.FieldByName('COLUMN_').AsString + ', ''' + ReplaceQuote(ds.FieldByName('STYLE_COLUMNS').AsString) + ''', ' +
        VariantToDBStr(ds.FieldByName('ADD_VISIBLE').Value, false) + ', ' + VariantToDBStr(ds.FieldByName('COLLAPSED').Value, false) + ', ' +
        VariantToDBStr(ds.FieldByName('LEFT_ALIGN').Value, false) + ', ' + VariantToDBStr(ds.FieldByName('LABEL_WIDTH').Value, false) +
        ') returning (PK)', 'PK', tmpVar, err) then
        raise Exception.Create(err);

      GroupsList.Values[ds.FieldByName('PK').AsString] := VarToStr(tmpVar);
      ds.Next;
    end;

    // группы фильтров
    ds.Close;
    FreeAndNil(ds);
    ds := OpenSQL('select PK, TITLE, ORDER_, COLLAPSED from DYNAMIC_FORM_FILTER_GROUP where FORM_PK = ' + IntToStr(FormPk));

    ds.First;
    while not ds.Eof do
    begin
      if not ExecSQL('insert into DYNAMIC_FORM_FILTER_GROUP (FORM_PK, TITLE, ORDER_, COLLAPSED, OWNER_USER_PK) values (' +
        VariantToDBStr(result, false) + ', ''' + ReplaceQuote(ds.FieldByName('TITLE').AsString) + ''', ' + ds.FieldByName('ORDER_').AsString +
        ', ''' + ds.FieldByName('COLLAPSED').AsString + ''', ' + VariantToDBStr(dsPortalUserPK.Value, false) +
        ') returning (PK)', 'PK', tmpVar, err) then raise Exception.Create(err);

      FilterGroups.Values[ds.FieldByName('PK').AsString] := VarToStr(tmpVar);
      ds.Next;
    end;

    // поля
    if SimpleMode then CopyFormFields(FormPk, result, false, FieldsList, ObjectList, GroupsList, FilterGroups);
  finally
    objOrders.Free;
    if Assigned(ds) then
    begin
      ds.Close;
      ds.Free;
    end;
  end;
end;

procedure TFMain.CopyObject(Node: TTreeNode);
var
  s, err: string;
  res: boolean;
  sld, slfm, slf, slo, slp, slc: TStringList;
  
begin
  if not Database.Connected then exit;
  if (not Assigned(Node)) or (not Assigned(Node.Data)) then
  begin
    Application.MessageBox('Не выбран узел!', 'Сообщение', MB_OK + MB_ICONINFORMATION);
    exit;
  end;

  case TNodeDictInfo(Node.Data).ObjType of
    cotFolder: s := 'папку';
    cotDict: s := 'справочник';
    cotForm: s := 'форму';
    cotWizard: s := 'сценарий';
    else exit;
  end;

  if (TNodeDictInfo(Node.Data).ObjType <> cotFolder) and (Application.MessageBox(pchar('Хотите скопировать ' + s + ' ' +
    VarToStr(TNodeDictInfo(Node.Data).Title) + '?'), 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES) then exit;

  case TNodeDictInfo(Node.Data).ObjType of
    cotFolder: res := CopyFolder(TNodeDictInfo(Node.Data).PK, err);
    cotDict:
    begin
      try
        sld := TStringList.Create;
        slfm := TStringList.Create;
        slf := TStringList.Create;
        slo := TStringList.Create;
        slp := TStringList.Create;
        slc := TStringList.Create;
        slp.Add('0=0');
        slp.Add('1=1');
        res := CopyDict(TNodeDictInfo(Node.Data).PK, TNodeDictInfo(Node.Data).ParentDictPK, sld, slfm, slf, slo, slp, slc, true, err);
      finally
        sld.Free;
        slfm.Free;
        slf.Free;
        slo.Free;
        slp.Free;
        slc.Free;
      end;
      if res then ReopenTree(false);
    end;
    cotForm: res := CopyForm(TNodeDictInfo(Node.Data).PK, err);
    cotWizard: res := CopyWizard(TNodeDictInfo(Node.Data).PK, err);
    else begin
      res := false;
      err := 'Не определен тип объекта';
    end;
  end;

  if not res then
    Application.MessageBox(pchar('Не удалось скопировать ' + s + ' ' + VarToStr(TNodeDictInfo(Node.Data).Title) + '!'#13#10 + err),
      'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFMain.CopyPermsInternal(RefPk, NewRefPk: integer; TableName: string; PermTmpList: TStringList);
var
  ds: TpFIBDataSet;
  err: string;

begin
  try
    ds := OpenSQL('select PK, ROLE_PK, ADD_, EDIT_, DEL_, VIEW_REF, CONFIG_, VIEW_, EXPORT, IMPORT, FILTRING, GRID_SAVE from ' + TableName +
      ' where REFERENCE_PK = ' + IntToStr(RefPk));

    ds.First;
    while not ds.Eof do
    begin
      if (TableName = 'DYNAMIC_FORM_PERMISSIONS') and (ds.FieldByName('ROLE_PK').AsInteger = 5) then
      begin
        ds.Next;
        continue;
      end;

      if not ExecSQL('insert into ' + TableName + ' (REFERENCE_PK, ROLE_PK, ADD_, EDIT_, DEL_, VIEW_REF, CONFIG_, VIEW_, ' +
        'EXPORT, IMPORT, FILTRING, GRID_SAVE) values (' + IntToStr(NewRefPk) + ', ' + VariantToDBStr(ds.FieldByName('ROLE_PK').Value, false) +
        ', ' + VariantToDBStr(PermTmpList.Values[ds.FieldByName('ADD_').AsString], false) + ', ' +
        VariantToDBStr(PermTmpList.Values[ds.FieldByName('EDIT_').AsString], false) + ', ' +
        VariantToDBStr(PermTmpList.Values[ds.FieldByName('DEL_').AsString], false) + ', ' +
        VariantToDBStr(PermTmpList.Values[ds.FieldByName('VIEW_REF').AsString], false) + ', ' +
        VariantToDBStr(PermTmpList.Values[ds.FieldByName('CONFIG_').AsString], false) + ', ' +
        VariantToDBStr(PermTmpList.Values[ds.FieldByName('VIEW_').AsString], false) + ', ' +
        VariantToDBStr(PermTmpList.Values[ds.FieldByName('EXPORT').AsString], false) + ', ' +
        VariantToDBStr(PermTmpList.Values[ds.FieldByName('IMPORT').AsString], false) + ', ' +
        VariantToDBStr(PermTmpList.Values[ds.FieldByName('FILTRING').AsString], false) + ', ' +
        VariantToDBStr(PermTmpList.Values[ds.FieldByName('GRID_SAVE').AsString], false) + ')', err) then
        raise Exception.Create(err);

      ds.Next;
    end;
  finally
    ds.Close;
    ds.Free;
  end;
end;

procedure TFMain.CopyRefLinkToClip(DictInfo: TNodeDictInfo);
var
  url: string;

begin
  url := GetRefLink(DictInfo);

  if url <> '' then
  begin
    CopyToClipboard(url);
    Application.MessageBox('Ссылка скопирована!', 'Сообщение', MB_OK + MB_ICONINFORMATION);
  end else
    Application.MessageBox('Для текущего подключения не задан url портала! Его можно указать в настройках подключений.',
      'Ошибка', MB_OK + MB_ICONERROR);
end;

function TFMain.CopyWizard(ObjPk: integer; var ErrorMessage: string): boolean;
var
  ds, ds2: TpFIBDataSet;
  scenPk, tmpVar: Variant;
  d: TNodeDictInfo;
  fWizard: TFEditWizard;
  wdescr, wname: string;
  StateList, CrossList: TStringList;

begin
  result := false;
  d := AssignNodeData(cotWizard);
  if not CheckGrants(gaAdd, d, ErrorMessage) then exit;

  StateList := TStringList.Create;
  StateList.Add('0=0');
  CrossList := TStringList.Create;
  try
    try
      ds := OpenSQL('select PK, NAME, SCEN_TYPE, REF_PK, DESCRIPTOR_, NO_MES from WIZARD_SCENS where PK = ' + IntToStr(ObjPk));

      if ds.IsEmpty then
      begin
        ErrorMessage := 'Сценарий с PK ' + IntToStr(ObjPk) + ' не найден в базе данных!';
        exit;
      end;

      // сам визард
      if (not ds.FieldByName('NAME').IsNull) and (ds.FieldByName('NAME').AsString <> '') then
        wname := ds.FieldByName('NAME').AsString + ' - копия';

      if (not ds.FieldByName('DESCRIPTOR_').IsNull) and (ds.FieldByName('DESCRIPTOR_').AsString <> '') then
        wdescr := ds.FieldByName('DESCRIPTOR_').AsString + '_COPY';

      result := ExecSQL('insert into WIZARD_SCENS (NAME, SCEN_TYPE, REF_PK, DESCRIPTOR_, NO_MES) values (' +
        VariantToDBStr(ReplaceQuote(wname), true) + ', ' + VariantToDBStr(ds.FieldByName('SCEN_TYPE').Value, true) + ', ' +
        VariantToDBStr(ds.FieldByName('REF_PK').Value, false) + ', ' +  VariantToDBStr(wdescr, true) + ', ' +
        VariantToDBStr(ds.FieldByName('NO_MES').Value, true) + ') returning (PK)', 'PK', scenPk, ErrorMessage);

      if not result then exit;
      d.PK := scenPk;
      d.Descriptor := wdescr;
      d.Title := ReplaceQuote(wname);
      d.ParentDictPK := ds.FieldByName('REF_PK').Value;
      d.Login := FSettings.PortalUser;

      // состояния сценария
      ds.Close;
      FreeAndNil(ds);
      ds := OpenSQL('select PK, SCEN_PK, FORM_PK, FIELD_JSON, ACTION_, DESCRIPTOR_, FULL_SCREEN, MAY_DOUBLE from WIZARD_SATES where SCEN_PK = ' +
        IntToStr(ObjPk));

      ds.First;
      while not ds.Eof do
      begin
        result := ExecSQL('insert into WIZARD_SATES (SCEN_PK, FORM_PK, FIELD_JSON, ACTION_, DESCRIPTOR_, FULL_SCREEN, MAY_DOUBLE) values (' +
          VarToStr(scenPk) + ', ' + VariantToDBStr(ds.FieldByName('FORM_PK').Value, false) + ', ' +
          VariantToDBStr(ReplaceQuote(ds.FieldByName('FIELD_JSON').AsString), true) + ', ' + VariantToDBStr(ds.FieldByName('ACTION_').Value, true) +
          ', ' + VariantToDBStr(ds.FieldByName('DESCRIPTOR_').Value, true) + ', ' + VariantToDBStr(ds.FieldByName('FULL_SCREEN').Value, false) +
          ', ' + VariantToDBStr(ds.FieldByName('MAY_DOUBLE').Value, false) + ') returning (PK)', 'PK', tmpVar, ErrorMessage);

        if not result then exit;
        StateList.Values[ds.FieldByName('PK').AsString] := VarToStr(tmpVar);
        ds.Next;
      end;

      // кнопки
      ds.First;
      while not ds.Eof do
      begin
        ds2 := OpenSQL('select PK, PK_PREW, PK_NEXT, NAME, ADD_BUTTON, BUTTON_ORDER, NEED_CLOSE, SHOW_IN_VIEW, HOT_KEY ' +
          'from WIZARD_SATES_CROSS where PK_PREW = ' + ds.FieldByName('PK').AsString);

        ds2.First;
        while not ds2.Eof do
        begin
          result := ExecSQL('insert into WIZARD_SATES_CROSS (PK_PREW, PK_NEXT, NAME, ADD_BUTTON, BUTTON_ORDER, NEED_CLOSE, SHOW_IN_VIEW, HOT_KEY) ' +
            'values (' + VariantToDBStr(StateList.Values[ds2.FieldByName('PK_PREW').AsString], false) + ', ' +
            VariantToDBStr(StateList.Values[ds2.FieldByName('PK_NEXT').AsString], false) + ', ' +
            VariantToDBStr(ReplaceQuote(ds2.FieldByName('NAME').AsString), true) + ', ' +
            VariantToDBStr(ds2.FieldByName('ADD_BUTTON').Value, false) + ', ' + VariantToDBStr(ds2.FieldByName('BUTTON_ORDER').Value, false) + ', ' +
            VariantToDBStr(ds2.FieldByName('NEED_CLOSE').Value, false) + ', ' + VariantToDBStr(ds2.FieldByName('SHOW_IN_VIEW').Value, false) + ', ' +
            VariantToDBStr(ReplaceQuote(ds2.FieldByName('HOT_KEY').AsString), true) + ') returning (PK)', 'PK', tmpVar, ErrorMessage);

          if not result then exit;
          CrossList.Values[ds2.FieldByName('PK').AsString] := VarToStr(tmpVar);
          ds2.Next;
        end;
        ds2.Close;
        FreeAndNil(ds2);
        ds.Next;
      end;

      // слоты сценария
      CopyWizardSlotsInternal(ObjPk, scenPk, 'SCEN_PK', CrossList);

      // слоты состояния
      ds.First;
      while not ds.Eof do
      begin
        if (not ds.FieldByName('PK').IsNull) and (StateList.Values[ds.FieldByName('PK').AsString] <> '') then
          CopyWizardSlotsInternal(ds.FieldByName('PK').AsInteger, StrToInt(StateList.Values[ds.FieldByName('PK').AsString]), 'SATE_PK', CrossList);
        ds.Next;
      end;

      fWizard := TFEditWizard.Create(Self, cftWizard, omEdit, d.PK, OnChildFormClose);
      fWizard.Properties := d;
      RegisterChildForm(fWizard);
      //fWizard.Show;
      result := true;
      ReopenTree(false);
    finally
      if Assigned(d) then d.Free;

      StateList.Free;
      CrossList.Free;
      if Assigned(ds) then
      begin
        ds.Close;
        ds.Free;
      end;

      if Assigned(ds2) then
      begin
        ds2.Close;
        ds2.Free;
      end;
    end;
  except
    on e: Exception do
    begin
      ErrorMessage := e.Message;
      result := false;
    end;
  end;
end;

procedure TFMain.CopyWizardSlotsInternal(Pk, NewPk: integer; PkField: string; CrossList: TStringList);
var
  ds, ds2: TpFIBDataSet;
  err: string;
  slotPk: Variant;
  state, scen: string;

begin
  try
    if PkField = 'SATE_PK' then
    begin
      state := IntToStr(NewPk);
      scen := 'null';
    end else
    begin
      state := 'null';
      scen := IntToStr(NewPk);
    end;

    ds := OpenSQL('select PK, SATE_PK, NAME, SLOT_TYPE, MAIN_SLOT, SCEN_PK from WIZARD_SATES_SLOTS where ' + PkField + ' = ' + IntToStr(Pk));
    ds.First;
    while not ds.Eof do
    begin
      if not ExecSQL('insert into WIZARD_SATES_SLOTS (SATE_PK, NAME, SLOT_TYPE, MAIN_SLOT, SCEN_PK) values (' + state + ', ' +
        VariantToDBStr(ReplaceQuote(ds.FieldByName('NAME').AsString), true) + ', ' + VariantToDBStr(ds.FieldByName('SLOT_TYPE').Value, true) +
        ', ' + VariantToDBStr(ds.FieldByName('MAIN_SLOT').Value, false) + ', ' + scen + ') returning (PK)', 'PK', slotPk, err)
        then raise Exception.Create(err);

      // значения слота
      ds2 := OpenSQL('select PK, SLOT_PK, CROSS_PK, SLOT_VALUE from WIZARD_SC_SLOT_VAL where SLOT_PK = ' + ds.FieldByName('PK').AsString);
      ds2.First;
      while not ds2.Eof do
      begin
        if not ExecSQL('insert into WIZARD_SC_SLOT_VAL (SLOT_PK, CROSS_PK, SLOT_VALUE) values (' + VarToStr(slotPk) + ', ' +
          VariantToDBStr(CrossList.Values[ds2.FieldByName('CROSS_PK').AsString], false) + ', ' +
          VariantToDBStr(ReplaceQuote(ds2.FieldByName('SLOT_VALUE').AsString), true) + ')', err)
          then raise Exception.Create(err);

        ds2.Next;
      end;
      ds2.Close;
      FreeAndNil(ds2);
      ds.Next;
    end;
  finally
    ds.Close;
    ds.Free;

    if Assigned(ds2) then
    begin
      ds2.Close;
      ds2.Free;
    end;
  end;
end;

procedure TFMain.CreateDict(ParentData: TNodeDictInfo);
var
  err: string;
  fDict: TFEditDict;
  d: TNodeDictInfo;

begin
  // проверка прав
  if CheckGrants(gaAdd, ParentData, err) then
  begin
    d := AssignNodeData(cotDict);
    try
      if ParentData.ObjType = cotFolder then d.FolderPK := ParentData.PK
      else begin
        d.FolderPK := ParentData.FolderPK;
        d.ParentDictPK := ParentData.PK;
      end;
      fDict := TFEditDict.Create(Self, cftDict, omAdd, Null, OnChildFormClose);
      fDict.Properties := d;
      RegisterChildForm(fDict);
    finally
      d.Free;
    end;
    //fDict.Show; метод Show у MDI Child окна срабатывает автоматом сразу при создании (Create)
  end else
    Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFMain.CreateFolder(ParentData: TNodeDictInfo);
var
  err: string;
  fFolder: TFEditFolder;
  d: TNodeDictInfo;

begin
  // проверка прав
  if CheckGrants(gaAdd, ParentData, err) then
  begin
    d := AssignNodeData(cotFolder);
    try
      d.FolderPK := ParentData.PK;
      fFolder := TFEditFolder.Create(Self, cftFolder, omAdd, Null, OnChildFormClose);
      fFolder.Properties := d;
      RegisterChildForm(fFolder);
    finally
      d.Free;
    end;
    //fFolder.Show;
  end else
    Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFMain.CreateForm;
var
  err: string;
  fForm: TFEditForm;
  d: TNodeDictInfo;

begin
  // проверка прав
  if CheckGrants(gaAdd, nil, err) then
  begin
    fForm := TFEditForm.Create(Self, cftForm, omAdd, Null, OnChildFormClose);
    d := AssignNodeData(cotForm);
    try
      fForm.Mode := omAdd;
      fForm.Properties := d;
      RegisterChildForm(fForm);
      //fForm.Show;
    finally
      d.Free;
    end;
  end else
    Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFMain.CreateLikedFolder;
var
  name, err: string;
  
begin
  name := Trim(InputBox('Новый раздел избранного', 'Введите имя раздела', ''));
  if name = '' then exit;

  if not ExecSQL('insert into DCFG_HISTORY (OBJ_PK, OBJ_TYPE, TYPE_, USER_PK, OBJ_NAME) values (gen_id(GEN_DCFG_HISTORY_ID, 1), ' +
    IntToStr(Ord(cotLikedFolder)) + ', ' + IntToStr(Ord(htLiked)) + ', ' + dsPortalUserPK.AsString + ', ''' + name + ''')', err) then
    Application.MessageBox(pchar('Не удалось добавить раздел в избранное! Ошибка:'#13#10 + err), 'Ошибка', MB_OK + MB_ICONERROR)
  else begin
    if tsHistory.TabVisible then
    begin
      NoLoadInfo := true;
      try
        tvHistory.Visible := false;
        tvHistory.Items.Clear;
        LoadHistory(tvHistory);
      finally
        tvHistory.Visible := true;
        NoLoadInfo := false;
      end;
    end;
  end;
end;

procedure TFMain.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

function TFMain.CreateWizard: TChildForm;
var
  err: string;
  d: TNodeDictInfo;

begin
  // проверка прав
  result := nil;
  if CheckGrants(gaAdd, nil, err) then
  begin
    result := TFEditWizard.Create(Self, cftWizard, omAdd, Null, OnChildFormClose);
    d := AssignNodeData(cotWizard);
    try
      result.Properties := d;
      RegisterChildForm(result);
      //fWizard.Show;
    finally
      d.Free;
    end;
  end else
    Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFMain.DatabaseAfterConnect(Sender: TObject);
begin
  StatusBar.Panels[0].Text := 'Подключено';
end;

procedure TFMain.DatabaseAfterDisconnect(Sender: TObject);
begin
  StatusBar.Panels[0].Text := 'Отключено';
  StatusBar.Panels[3].Text := '';
  Caption := Application.Title;
end;

procedure TFMain.DBTaskAfterConnect(Sender: TObject);
var
  c: TConnectionItem;

begin
  c := ConnectChecker.ItemByName(TpFIBDatabase(Sender).Name);

  if Assigned(c) then
    c.Active := true
  else
    c := ConnectChecker.Add(Sender, LostConnect, CHECK_CONN_INTERVAL, CHECK_CONN_QUERY, true);
end;

procedure TFMain.DBTaskBeforeDisconnect(Sender: TObject);
begin
  ConnectChecker.Delete(ConnectChecker.FindItem(TpFIBDatabase(Sender).Name));
end;

procedure TFMain.GridKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_F12) and (ssShift in Shift) and (ssCtrl in Shift) then TDBGridEh(Sender).OptimizeAllColsWidth;
end;

procedure TFMain.JumpToNode(ObjType: TConfObjectType; ObjKey: Variant);
var
  tv: TJvTreeView;
  s: string;
  
begin
  case ObjType of
    cotFolder:
    begin
      s := 'папок';
      if tsOnFolder.TabVisible then
      begin
        if pcDictTree.ActivePage <> tsOnFolder then pcDictTree.ActivePage := tsOnFolder;
        tv := tvMain;
      end;
    end;
    cotDict:
    begin
      s := 'справочников';
      if tsOnFolder.TabVisible then
      begin
        if pcDictTree.ActivePage <> tsOnFolder then pcDictTree.ActivePage := tsOnFolder;
        tv := tvMain;
      end else if tsOnlyDict.TabVisible then
      begin
        if pcDictTree.ActivePage <> tsOnlyDict then pcDictTree.ActivePage := tsOnlyDict;
        tv := tvDict;
      end;
    end;
    cotForm:
    begin
      s := 'форм';
      if tsForm.TabVisible then
      begin
        if pcDictTree.ActivePage <> tsForm then pcDictTree.ActivePage := tsForm;
        tv := tvForm;
      end;
    end;
    cotWizard:
    begin
      s := 'сценариев';
      if tsWizard.TabVisible then
      begin
        if pcDictTree.ActivePage <> tsWizard then pcDictTree.ActivePage := tsWizard;
        tv := tvWizard;
      end;
    end;
  end;

  if not Assigned(tv) then
  begin
    Application.MessageBox(pchar('Отключен показ вкладок ' + s + ' - некуда переместиться!'), 'Сообщение', MB_OK + MB_ICONWARNING);
    exit;
  end;

  tv.Selected := tv.Items.GetFirstNode;
  SelectNode(tv, ObjKey);
end;

procedure TFMain.DelDict(Data: TNodeDictInfo);
var
  err: string;
  res: boolean;

begin
  if VarIsNull(Data.PK) then
  begin
    Application.MessageBox(pchar('Нечего удалять!'), 'Ошибка', MB_OK + MB_ICONERROR);
    exit;
  end;

  if Application.MessageBox(pchar('Удалить справочник "' + VarToStr(Data.Title) + '"?'), 'Подтверждение',
    MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

  // сначала права
  res := CheckGrants(gaDel, Data, err);
  // все, что привязано к реф удаляется или отвязывается каскадно
  if res then res := ExecSQL('delete from DYNAMIC_FORM_REFERENCE where PK = ' + IntToStr(Data.PK), err);
  if res then ExecSQL('delete from DCFG_HISTORY where OBJ_PK = ' + IntToStr(Data.PK) + ' and OBJ_TYPE = ' +
    IntToStr(Ord(Data.ObjType)), err);
  if res then AddToRefLog(Data.ObjType, Data.Descriptor, rltDelete);
  if res then ReopenTree
  else Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFMain.DelFolder(Data: TNodeDictInfo);
var
  err: string;
  res: boolean;

begin
  if VarIsNull(Data.PK) then
  begin
    Application.MessageBox(pchar('Нечего удалять!'), 'Ошибка', MB_OK + MB_ICONERROR);
    exit;
  end;

  if Application.MessageBox(pchar('Удалить папку "' + VarToStr(Data.Title) + '"?'), 'Подтверждение',
    MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

  // сначала права: на саму папку и на содержащиеся в ней объекты, которыми ты не являешься владельцем
  //res := CheckGrants(gaDel, Data, err);
  res := CheckGrantsDepth(gaDel, Data, err);

  // надо отвязать вложенные папки (привязанные справочники отвязываются каскадно по ключу)
  if res then res := ExecSQL('update DYNAMIC_FORM_FOLDER set PARENT_FOLDER_PK = null where PARENT_FOLDER_PK = ' + IntToStr(Data.PK), err);
  if res then res := ExecSQL('delete from DYNAMIC_FORM_FOLDER where PK = ' + IntToStr(Data.PK), err);
  if res then ExecSQL('delete from DCFG_HISTORY where OBJ_PK = ' + IntToStr(Data.PK) + ' and OBJ_TYPE = ' +
    IntToStr(Ord(Data.ObjType)), err);
  if res then AddToRefLog(Data.ObjType, Data.Title, rltDelete, 'PK ' + IntToStr(Data.PK));
  if res then ReopenTree
  else Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

function TFMain.DelFolderFull(Data: TNodeDictInfo; Ask: boolean): boolean;
var
  ds: TpFIBDataSet;
  sl, slFolder, slRef: TStringList;
  idx, i: integer;
  d: TNodeDictInfo;
  err: string;

begin
  result := false;
  if VarIsNull(Data.PK) then
  begin
    Application.MessageBox(pchar('Нечего удалять!'), 'Ошибка', MB_OK + MB_ICONERROR);
    exit;
  end;

  if Ask and (Application.MessageBox(pchar('Удалить папку "' + VarToStr(Data.Title) + '" И ВСЕ ЕЕ СОДЕРЖИМОЕ?'), 'Подтверждение',
    MB_YESNO + MB_ICONQUESTION) <> ID_YES) then exit;

  // сначала права
  if not CheckGrants(gaDel, Data, err) then
  begin
    Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
    exit;
  end;

  // выберем вложенные папки и главные справочники папки
  d := AssignNodeData(cotDict);
  sl := TStringList.Create;
  slFolder := TStringList.Create;
  slRef := TStringList.Create;
  try
    ds := OpenSQL('select 1 TYPE_, f.PK, null LOGIN, f.NAME DESCRIPTOR_ from DYNAMIC_FORM_FOLDER f where f.PARENT_FOLDER_PK = ' + IntToStr(Data.PK) +
      ' union all select 2 TYPE_, r.PK, u.LOGIN, r.DESCRIPTOR_ from DYNAMIC_FORM_REFERENCE r ' +
      'left join USERS u on u.PK = r.OWNER_USER_PK ' +
      'where r.FOLDER_PK = ' + IntToStr(Data.PK) + ' and r.PARENT_REFERENCE_PK is null');

    ds.First;
    while not ds.Eof do
    begin
      if ds.FieldByName('TYPE_').AsInteger = 1 then slFolder.Add(ds.FieldByName('PK').AsString + '=' + ds.FieldByName('DESCRIPTOR_').AsString)
      else if ds.FieldByName('TYPE_').AsInteger = 2 then
      begin
        slRef.Add(ds.FieldByName('PK').AsString + '=' + ds.FieldByName('LOGIN').AsString + '/' + ds.FieldByName('DESCRIPTOR_').AsString);
        sl.Add(ds.FieldByName('PK').AsString);
        GetChildRefList(ds.FieldByName('PK').AsInteger, sl);
      end;

      ds.Next;
    end;

    idx := FindChildForm(Data.ObjType, Data.PK);

    // закроем окно объекта, если оно открыто (для 1 уровня вложенности не делаем - оно закроется из метода, вызвавшего этот)
    if (not Ask) and (idx <> -1) then ChildForms[idx].Close;

    // надо проверить наличие открытых окон вложенных справочников и позакрывать их тоже
    for i := 0 to sl.Count - 1 do
    begin
      idx := FindChildForm(cotDict, StrToInt(sl.Strings[i]));
      if idx <> -1 then ChildForms[idx].Close;
    end;

    // удаление - сначала все вложенные справочники
    d.ObjType := cotDict;
    for i := 0 to slRef.Count - 1 do
    begin
      d.PK := StrToInt(slRef.Names[i]);
      d.Login := ExtractWordEx(1, slRef.Values[slRef.Names[i]], ['/'], []);
      d.Descriptor := ExtractWordEx(2, slRef.Values[slRef.Names[i]], ['/'], []);

      // проверим права
      if not CheckGrants(gaDel, d, err) then
      begin
        Application.MessageBox(pchar('Недостаточно прав на один из вложенных объектов: (PK: ' + VarToStr(d.PK) + ')'#13#10 + err),
          'Ошибка', MB_OK + MB_ICONERROR);
        exit;
      end;

      // все, что привязано к реф удаляется или отвязывается каскадно
      if not ExecSQL('delete from DYNAMIC_FORM_REFERENCE where PK = ' + IntToStr(d.PK), err) then
      begin
        Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
        exit;
      end;
      ExecSQL('delete from DCFG_HISTORY where OBJ_PK = ' + IntToStr(d.PK) + ' and OBJ_TYPE = ' + IntToStr(Ord(d.ObjType)), err);
      AddToRefLog(d.ObjType, d.Descriptor, rltDelete);
    end;

    // удаление - теперь вложенные папки
    d.ObjType := cotFolder;
    d.Login := Null;
    d.Descriptor := Null;
    for i := 0 to slFolder.Count - 1 do
    begin
      d.PK := StrToInt(slFolder.Names[i]);
      d.Title := slFolder.Values[slFolder.Names[i]];
      if not DelFolderFull(d, false) then exit;
    end;

    // теперь удалить саму эту папку
    // на всякий случай надо отвязать вложенные папки (хотя они уже удалены до этого)
    ExecSQL('update DYNAMIC_FORM_FOLDER set PARENT_FOLDER_PK = null where PARENT_FOLDER_PK = ' + IntToStr(Data.PK), err);
    result := ExecSQL('delete from DYNAMIC_FORM_FOLDER where PK = ' + IntToStr(Data.PK), err);
    if result then ExecSQL('delete from DCFG_HISTORY where OBJ_PK = ' + IntToStr(Data.PK) + ' and OBJ_TYPE = ' + IntToStr(Ord(Data.ObjType)), err);
    if result then AddToRefLog(Data.ObjType, Data.Title, rltDelete, 'PK ' + IntToStr(Data.PK));
    if not result then Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
  finally
    d.Free;
    sl.Free;
    slFolder.Free;
    slRef.Free;
    ds.Close;
    ds.Free;
    if result and Ask then ReopenTree;
  end;
end;

procedure TFMain.DelForm(Data: TNodeDictInfo);
var
  err: string;
  res: boolean;

begin
  if VarIsNull(Data.PK) then
  begin
    Application.MessageBox(pchar('Нечего удалять!'), 'Ошибка', MB_OK + MB_ICONERROR);
    exit;
  end;

  if Application.MessageBox(pchar('Удалить форму "' + VarToStr(Data.Title) + '"?'), 'Подтверждение',
    MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

  // сначала права
  res := CheckGrants(gaDel, Data, err);
  // отвязываем стартовую и групповую формы (главная форма отвязывается каскадно по ключу, визарды удаляются каскадно)
  if res then res := ExecSQL('update DYNAMIC_FORM_REFERENCE set START_FORM_PK = null where START_FORM_PK = ' + IntToStr(Data.PK), err);
  if res then res := ExecSQL('update DYNAMIC_FORM_REFERENCE set GROUP_EDIT_FORM_PK = null where GROUP_EDIT_FORM_PK = ' + IntToStr(Data.PK), err);
  if res then res := ExecSQL('delete from DYNAMIC_FORM where PK = ' + IntToStr(Data.PK), err);
  if res then ExecSQL('delete from DCFG_HISTORY where OBJ_PK = ' + IntToStr(Data.PK) + ' and OBJ_TYPE = ' +
    IntToStr(Ord(Data.ObjType)), err);
  if res then AddToRefLog(Data.ObjType, iif(not VarIsNull(Data.Descriptor), data.Descriptor, Data.Title), rltDelete, 'PK ' + IntToStr(Data.PK));
  if res then ReopenTree
  else Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFMain.DelFromHistory(Data: TNodeDictInfo; HistType: THistoryType);
var
  err: string;

begin
  if (not Assigned(Data)) or (Data.ObjType = cotNone) then exit;

  if not ExecSQL('delete from DCFG_HISTORY where OBJ_PK = ' + VarToStr(Data.PK) + ' and OBJ_TYPE = ' +
    IntToStr(Ord(Data.ObjType)) + ' and TYPE_ = ''' + IntToStr(Ord(HistType)) + ''' and USER_PK = ' +
    dsPortalUserPK.AsString, err) then exit;

  if tsHistory.TabVisible then
  begin
    NoLoadInfo := true;
    try
      tvHistory.Visible := false;
      tvHistory.Items.Clear;
      LoadHistory(tvHistory);
    finally
      tvHistory.Visible := true;
      NoLoadInfo := false;
    end;
  end;
end;

procedure TFMain.DelGrantOnConfigDict(Data: TNodeDictInfo);
var
  err: string;
  res: boolean;
  pk: Variant;

begin
  if Data.ObjType <> cotDict then exit;

  // сначала права
  res := CheckGrants(gaRights, Data, err);

  if res then
  begin
    if not SelUserDialog(pk, 'select u.PK, u.LOGIN, u.NAME from DYNAMIC_FORM_REF_USER r join USERS u on u.PK = r.USER_PK ' +
      'where r.REF_PK = ' + VarToStr(TNodeDictInfo(Data).PK) + ' order by u.NAME') then exit;

    if VarIsNull(pk) then
    begin
      res := false;
      err := 'Не выбран пользователь!';
    end else
    begin
      res := ExecSQL('delete from DYNAMIC_FORM_REF_USER where REF_PK = ' + VarToStr(TNodeDictInfo(Data).PK) +
        ' and USER_PK = ' + VarToStr(pk), err);
      if res then AddToRefLog(Data.ObjType, Data.Descriptor, rltUpdate, 'Удаление прав на конфигурацию. Полюзователь ' + VarToStr(pk));
    end;
  end;

  if not res then Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFMain.DelLikedFolder(Data: TNodeDictInfo);
var
  err: string;

begin
  if VarIsNull(Data.PK) then
  begin
    Application.MessageBox(pchar('Нечего удалять!'), 'Ошибка', MB_OK + MB_ICONERROR);
    exit;
  end;

  if (Application.MessageBox(pchar('Удалить раздел избранного "' + VarToStr(Data.Title) +
    '"? Все вложенные объекты будут перемещены в корневую ветку избранного'), 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES) then exit;

  if not ExecSQL('delete from DCFG_HISTORY where OBJ_PK = ' + VarToStr(Data.PK) + ' and OBJ_TYPE = ' + IntToStr(Ord(cotLikedFolder)) +
    ' and TYPE_ = ' + IntToStr(Ord(htLiked)) + ' and USER_PK = ' + dsPortalUserPK.AsString, err) then
    Application.MessageBox(pchar('Не удалось переименовать раздел избранного! Ошибка:'#13#10 + err), 'Ошибка', MB_OK + MB_ICONERROR)
  else begin
    if tsHistory.TabVisible then
    begin
      NoLoadInfo := true;
      try
        tvHistory.Visible := false;
        tvHistory.Items.Clear;
        LoadHistory(tvHistory);
      finally
        tvHistory.Visible := true;
        NoLoadInfo := false;
      end;
    end;
  end;
end;

procedure TFMain.DelTreeNode(Node: TTreeNode; Recursive: boolean);
var
  idx, i: integer;
  sl: TStringList;
  ot: TConfObjectType;
  pNode: TTreeNode;
  
begin
  if not Database.Connected then exit;
  if (not Assigned(Node)) or (not Assigned(Node.Data)) then
  begin
    Application.MessageBox('Не выбран узел!', 'Сообщение', MB_OK + MB_ICONINFORMATION);
    exit;
  end;

  // встанем на предыдущий узел, чтоб не потеряться в дереве после удаления
  pNode := Node.getPrevSibling;
  if not Assigned(pNode) then pNode := Node.GetPrevVisible;
  TvSelectNode(pNode);
  
  sl := TStringList.Create;
  try
    ot := TNodeDictInfo(Node.Data).ObjType;
    idx := FindChildForm(ot, TNodeDictInfo(Node.Data).PK);

    if (ot = cotDict) and (not VarIsNull(TNodeDictInfo(Node.Data).PK)) then
      GetChildRefList(TNodeDictInfo(Node.Data).PK, sl);

    case TNodeDictInfo(Node.Data).ObjType of
      cotFolder:
        if Recursive then DelFolderFull(TNodeDictInfo(Node.Data))
        else DelFolder(TNodeDictInfo(Node.Data));
      cotDict: DelDict(TNodeDictInfo(Node.Data));
      cotForm: DelForm(TNodeDictInfo(Node.Data));
      cotWizard: DelWizard(TNodeDictInfo(Node.Data));
      cotLikedFolder: DelLikedFolder(TNodeDictInfo(Node.Data));
    end;

    // закроем окно объекта, если оно открыто
    if idx <> -1 then ChildForms[idx].Close;
    // если это справочник - надо проверить наличие открытых окон дочерних справочников и позакрывать их тоже
    for i := 0 to sl.Count - 1 do
    begin
      idx := FindChildForm(ot, StrToInt(sl.Strings[i]));
      if idx <> -1 then ChildForms[idx].Close;
    end;
  finally
    sl.Free;
  end;
end;

function TFMain.DelWizard(Data: TNodeDictInfo): boolean;
var
  err: string;

begin
  result := false;
  if VarIsNull(Data.PK) then
  begin
    Application.MessageBox(pchar('Нечего удалять!'), 'Ошибка', MB_OK + MB_ICONERROR);
    exit;
  end;

  if Application.MessageBox(pchar('Удалить сценарий "' + VarToStr(Data.Title) + '"?'), 'Подтверждение',
    MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

  // сначала права
  result := CheckGrants(gaDel, Data, err);
  // все, что привязано к визарду удаляется или отвязывается каскадно
  if result then result := ExecSQL('delete from WIZARD_SCENS where PK = ' + IntToStr(Data.PK), err);
  if result then ExecSQL('delete from DCFG_HISTORY where OBJ_PK = ' + IntToStr(Data.PK) + ' and OBJ_TYPE = ' +
    IntToStr(Ord(Data.ObjType)), err);
  if result then AddToRefLog(cotWizard, iif(not VarIsNull(Data.Descriptor), Data.Descriptor, Data.Title), rltDelete, 'PK ' + VarToStr(Data.PK));
  if result then ReopenTree
  else Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFMain.DoFilter(tv: TJvTreeView);
var
  Node: TTreeNode;
  
begin
  if not Assigned(tv) then exit;

  // начинаем всегда с первой ноды
  Node := tv.Items.GetFirstNode;
  if not Assigned(Node) then exit;

  // пробегаемся по всем узлам
  try
    TJvTreeView(Node.TreeView).OnChange := nil;
    Node.TreeView.Visible := false;
    Application.ProcessMessages;
    FilterNodes(Node, cbFilter.Text, [foToExistence, foWholeString]);
  finally
    TJvTreeView(Node.TreeView).OnChange := tvMainChange;
    Node.TreeView.Visible := true;
    TvSelectNode(Node);
  end;
end;

procedure TFMain.dsPortalUserAfterClose(DataSet: TDataSet);
begin
  StatusBar.Panels[1].Text := '';
  StatusBar.Panels[2].Text := '';
end;

procedure TFMain.EditDict(Data: TNodeDictInfo);
var
  err: string;
  fDict: TFEditDict;

begin
  // проверка прав
  if CheckGrants(gaEdit, Data, err) then
  begin
    if SetFocusOpenedWindow(Data.PK, TFEditDict.ClassName) then exit;
    fDict := TFEditDict.Create(Self, cftDict, omEdit, Null, OnChildFormClose);
    try
      fDict.Properties := Data;
      RegisterChildForm(fDict);
      //fDict.Show;
      AddToHistory(Data, htHistory);
    except
      on e: Exception do
      begin
        fDict.Free;
        raise;
      end;
    end;
  end else
  begin
    //Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
    ViewDict(Data);
  end;
end;

procedure TFMain.EditFolder(Data: TNodeDictInfo);
var
  err: string;
  fFolder: TFEditFolder;

begin
  // проверка прав
  if CheckGrants(gaEdit, Data, err) then
  begin
    if SetFocusOpenedWindow(Data.PK, TFEditFolder.ClassName) then exit;
    fFolder := TFEditFolder.Create(Self, cftFolder, omEdit, Data.PK, OnChildFormClose);
    fFolder.Properties := Data;
    RegisterChildForm(fFolder);
    //fFolder.Show;
    AddToHistory(Data, htHistory);
  end else
  begin
    //Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
    ViewFolder(Data);
  end;
end;

procedure TFMain.EditForm(Data: TNodeDictInfo);
var
  err: string;
  fForm: TFEditForm;

begin
  // проверка прав
  if CheckGrants(gaEdit, Data, err) then
  begin
    if SetFocusOpenedWindow(Data.PK, TFEditForm.ClassName) then exit;
    fForm := TFEditForm.Create(Self, cftForm, omEdit, Data.PK, OnChildFormClose);
    fForm.Properties := Data;
    RegisterChildForm(fForm);
    //fForm.Show;
    AddToHistory(Data, htHistory);
  end else
  begin
    //Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
    ViewForm(Data);
  end;
end;

procedure TFMain.EditLikedFolder(Data: TNodeDictInfo);
var
  name, err: string;

begin
  name := Trim(InputBox('Переименование раздела избранного', 'Введите имя раздела', VarToStr(Data.Title)));
  if (name = '') or (name = Data.Title) then exit;

  if not ExecSQL('update DCFG_HISTORY set OBJ_NAME = ''' + name + ''' where OBJ_PK = ' + VarToStr(Data.PK) +
    ' and OBJ_TYPE = ' + IntToStr(Ord(cotLikedFolder)) + ' and TYPE_ = ' + IntToStr(Ord(htLiked)) + ' and USER_PK = ' +
    dsPortalUserPK.AsString, err) then
    Application.MessageBox(pchar('Не удалось переименовать раздел избранного! Ошибка:'#13#10 + err), 'Ошибка', MB_OK + MB_ICONERROR)
  else begin
    if tsHistory.TabVisible then
    begin
      NoLoadInfo := true;
      try
        tvHistory.Visible := false;
        tvHistory.Items.Clear;
        LoadHistory(tvHistory);
      finally
        tvHistory.Visible := true;
        NoLoadInfo := false;
      end;
    end;
  end;
end;

procedure TFMain.EditTreeNode(Node: TTreeNode);
begin
  if not Database.Connected then exit;
  if (not Assigned(Node)) or (not Assigned(Node.Data)) then
  begin
    Application.MessageBox('Не выбран узел!', 'Сообщение', MB_OK + MB_ICONINFORMATION);
    exit;
  end;

  case TNodeDictInfo(Node.Data).ObjType of
    cotFolder: EditFolder(TNodeDictInfo(Node.Data));
    cotDict: EditDict(TNodeDictInfo(Node.Data));
    cotForm: EditForm(TNodeDictInfo(Node.Data));
    cotWizard: EditWizard(TNodeDictInfo(Node.Data));
    cotLikedFolder: EditLikedFolder(TNodeDictInfo(Node.Data));
  end;
end;

procedure TFMain.EditWizard(Data: TNodeDictInfo);
var
  err: string;
  fWizard: TFEditWizard;

begin
  // проверка прав
  if CheckGrants(gaEdit, Data, err) then
  begin
    if SetFocusOpenedWindow(Data.PK, TFEditWizard.ClassName) then exit;
    fWizard := TFEditWizard.Create(Self, cftWizard, omEdit, Data.PK, OnChildFormClose);
    fWizard.Properties := Data;
    RegisterChildForm(fWizard);
    //fWizard.Show;
    AddToHistory(Data, htHistory);
  end else
  begin
    //Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
    ViewWizard(Data);
  end;
end;

function TFMain.ExecSQL(SQL, ParamName: string; var ParamValue: Variant; var Err: string): boolean;
var
  q: TpFIBQuery;
  idx: integer;

begin
  result := false;
  try
    q := TpFIBQuery.Create(self);
    q.Database := Database;
    q.ParamCheck := true;
    q.SQL.Text := SQL;
    try
      q.ExecQuery;
      if q.FieldExist(ParamName, idx) then ParamValue := q.FieldByName(ParamName).Value;
      Transact.CommitRetaining;
      result := true;
    except
      on e: Exception do
      begin
        Transact.RollbackRetaining;
        Err := e.Message;
      end;
    end;
  finally
    q.Close;
    q.Free;
  end;
end;

procedure TFMain.ExportToCsv(Grid: TDBGridEh; FileName: string);
var
  grid_: TDBGrid;

begin
  if not Assigned(Grid) then exit;

  SaveDialog.FileName := FileName;
  SaveDialog.Filter := 'Текстовый файл (*.txt)|*.txt|Файл CSV (.csv)|*.csv';
  SaveDialog.DefaultExt := 'csv';

  if not SaveDialog.Execute then exit;

  grid_ := TDBGrid.Create(Self);
  Screen.Cursor := crHourGlass;
  Grid.DataSource.DataSet.DisableControls;

  try
    CopyGrid(Grid, grid_);
    DBGridCSVExport.Separator := FSettings.CSVExpSeparator;
    DBGridCSVExport.ShowColumnName := FSettings.CSVExpShowCaption;
    DBGridCSVExport.QuoteEveryTime := FSettings.CSVExpQuoted;
    DBGridCSVExport.Grid := grid_;
    DBGridCSVExport.FileName := SaveDialog.FileName;
    DBGridCSVExport.ExportGrid;
  finally
    grid_.Free;
    Grid.DataSource.DataSet.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

procedure TFMain.ExportToExcel(Grid: TDBGridEh; FileName{, SheetName}: string);
var
  grid_: TDBGrid;
  XLSExp: TXLSExportDBGrid;
  XLSExpFile: TXLSExportFile;

begin
  if not Assigned(Grid) then exit;

  SaveDialog.FileName := FileName;
  SaveDialog.Filter := 'Microsoft Excel 97/2000/XP (.xls)|*.xls';
  SaveDialog.DefaultExt := 'xls';

  if not SaveDialog.Execute then exit;

  grid_ := TDBGrid.Create(Self);
  Screen.Cursor := crHourGlass;
  Grid.DataSource.DataSet.DisableControls;
  XLSExp := TXLSExportDBGrid.Create(self);
  XLSExpFile := TXLSExportFile.Create(self);

  try
    CopyGrid(Grid, grid_);
//    if SheetName = '' then SheetName := 'Лист 1';
//    XLSExpFile.Workbook.Sheets.Item[0].Name := SheetName;
    XLSExp.Options := [eoptVisibleOnly];
    XLSExp.XLSExportFile := XLSExpFile;
    XLSExp.DBGrid := grid_;
    XLSExp.ExportData(0, 0, 0);
    XLSExpFile.SaveToFile(SaveDialog.FileName);
  finally
    XLSExp.Free;
    XLSExpFile.Free;
    grid_.Free;
    Grid.DataSource.DataSet.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

function TFMain.ExecSQL(SQL: string; var Err: string): boolean;
var
  q: TpFIBQuery;

begin
  result := false;
  try
    q := TpFIBQuery.Create(self);
    q.Database := Database;
    q.SQL.Text := SQL;
    try
      q.ExecQuery;
      Transact.CommitRetaining;
      result := true;
    except
      on e: Exception do
      begin
        Transact.RollbackRetaining;
        Err := e.Message;
      end;
    end;
  finally
    q.Close;
    q.Free;
  end;
end;

procedure TFMain.Filter(NoReload: boolean);
begin
  if (cbFilter.Text = '') then
  begin
    CleanFilter(false);
    exit;
  end;

  cbFilter.Color := RGB(255, 164, 164);

  if Filtered and (not NoReload) then
  begin
    Filtered := false;
    ReopenTree;
  end;

  Filtered := true;
  UpdateFilterHistory;

  DoFilter(tvMain);
  DoFilter(tvDict);
  DoFilter(tvForm);
  DoFilter(tvWizard);
 // DoFilter(tvHistory);
end;

function TFMain.FilterChildNodes(ParentNode: TTreeNode; Str: string; Options: TFindOptions): boolean;
var
  Node, nextNode: TTreeNode;
  f, cf: boolean;

begin
  result := false;
  if not Assigned(ParentNode) then exit;

  ParentNode.Expand(false);
  Node := ParentNode.getFirstChild;

  // перебираем все дочерние узлы, сверяем текущий и его деток - всегда
  // если ни у него, ни у деток ничего не найдено - текущий удаляется, иначе остается
  // результат True, если хотя бы у одного из узлов или его деток что-то было найдено
  while Assigned(Node) do
  begin
    nextNode := ParentNode.GetNextChild(Node);

    f := Assigned(Node.Data) and CompareNodeData(Str, TNodeDictInfo(Node.Data), Options);
    cf := FilterChildNodes(Node, Str, Options);

    if f or cf then result := true;
    if (not f) and (not cf) then Node.Delete;

    Node := nextNode;
  end;

  ParentNode.Collapse(false);
end;

procedure TFMain.FilterNodes(StartNode: TTreeNode; Str: string; Options: TFindOptions);
var
  Node, nextNode: TTreeNode;
  f, cf: boolean;
  
begin
  if not Assigned(StartNode) then exit;
  Node := StartNode;

  // перебираем все узлы, начиная от переданного, и если у текущего и у его деток нет совпадений - удаляем его
  while Assigned(Node) do
  begin
    nextNode := Node.getNextSibling;

    f := Assigned(Node.Data) and CompareNodeData(Str, TNodeDictInfo(Node.Data), Options);
    cf := FilterChildNodes(Node, Str, Options);

    if (not f) and (not cf) then Node.Delete;

    Node := nextNode;
  end;
end;

procedure TFMain.Find(AContinue: boolean);
var
  tv: TJvTreeView;
  Node: TTreeNode;
  FindStr: string;
  FindOptions: TFindOptions;
  res: boolean;

begin
  if (not AContinue) or (FindDialog.cbFindText.Text = '') then
  begin
    // если новый, то показать диалог
    FindDialog.Caption := 'Поиск по дереву';
    if FindDialog.ShowModal <> mrOk then exit;
  end;

  FindStr := FindDialog.cbFindText.Text;
  FindOptions := [];
  if FindDialog.chbMatchCase.Checked then FindOptions := [foMatchCase];
  if FindDialog.chbToExistence.Checked then FindOptions := FindOptions + [foToExistence];
  if FindDialog.rbWholeString.Checked then FindOptions := FindOptions + [foWholeString];
  if FindDialog.rbAnyWord.Checked then FindOptions := FindOptions + [foAnyWord];
  if FindDialog.rbAllWords.Checked then FindOptions := FindOptions + [foAllWords];

  // ну а поиск собственно всегда будем вести от текущей ноды
  tv := GetCurrentTreeView;
  if not Assigned(tv) then exit;

  if Assigned(tv.Selected) then Node := tv.Selected
  else Node := tv.Items.GetFirstNode;

  if not Assigned(Node) then
  begin
    Application.MessageBox('Негде искать!', 'Поиск', MB_OK + MB_ICONINFORMATION);
    exit;
  end;

  // пробегаемся по всем узлам, начиная от текущего
  try
    Node.TreeView.Visible := false;
    Application.ProcessMessages;
    CollapseAfterFind := true;
    res := FindInNodes(Node, Node.AbsoluteIndex = 0, FindStr, FindOptions);
  finally
    CollapseAfterFind := false;
    Node.TreeView.Visible := true;
    if not res then TvSelectNode(Node);
  end;
end;

procedure TFMain.FindByObjectDB;
var
  FindStr: string;
  FindOptions: TFindOptions;
  res: boolean;
  FRefList: TFRefList;

begin
  if (GetCurrentTreeView <> tvMain) and (GetCurrentTreeView <> tvDict) and (GetCurrentTreeView <> tvHistory) then exit;

  FindDialog.Caption := 'Поиск по объекту БД';
  if FindDialog.ShowModal <> mrOk then exit;

  FindStr := FindDialog.cbFindText.Text;
  FindOptions := [];
  if FindDialog.chbMatchCase.Checked then FindOptions := [foMatchCase];
  if FindDialog.chbToExistence.Checked then FindOptions := FindOptions + [foToExistence];
  if FindDialog.rbWholeString.Checked then FindOptions := FindOptions + [foWholeString];
  if FindDialog.rbAnyWord.Checked then FindOptions := FindOptions + [foAnyWord];
  if FindDialog.rbAllWords.Checked then FindOptions := FindOptions + [foAllWords];

  FRefList := TFRefList.Create(Self);
  try
    if FRefList.Execute(FindStr, FindOptions) and FRefList.dsRefList.Active and (not FRefList.dsRefList.IsEmpty) then
    begin
      // Хотят Открыть все найденные справочники
      if FRefList.OpenAll then
      begin
        FRefList.dsRefList.First;
        while not FRefList.dsRefList.Eof do
        begin
          TvSelectNode(GetCurrentTreeView.Items.GetFirstNode);
          SelectNode(GetCurrentTreeView, FRefList.dsRefListDESCRIPTOR_.AsString);
          if Assigned(GetCurrentTreeView.Selected) and Assigned(GetCurrentTreeView.Selected.Data) and
            (TNodeDictInfo(GetCurrentTreeView.Selected.Data).Descriptor = FRefList.dsRefListDESCRIPTOR_.AsString) then
            EditTreeNode(GetCurrentTreeView.Selected);

          FRefList.dsRefList.Next;
        end;
      end else
      begin
        TvSelectNode(GetCurrentTreeView.Items.GetFirstNode);
        SelectNode(GetCurrentTreeView, FRefList.dsRefListDESCRIPTOR_.AsString);
      end;
    end;
  finally
    FRefList.Free;
  end;
end;

function TFMain.FindChildForm(ObjType: TConfObjectType; Pk: Variant): integer;
var
  i: integer;

begin
  result := -1;
  if VarIsNull(Pk) then exit;

  for i := 0 to Length(ChildForms) - 1 do
    if Assigned(ChildForms[i]) and (ChildForms[i].Properties.ObjType = ObjType) and
      ((ChildForms[i].Properties.PK = Pk){ or (ChildForms[i].Properties.Descriptor = Descriptor)}) then
    begin
      result := i;
      break;
    end;
end;

function TFMain.FindChildForm(FormType: TChildFormType; Mode: TOpenMode; Pk, Descriptor: Variant): integer;
var
  i: integer;

begin
  result := -1;

  for i := 0 to Length(ChildForms) - 1 do
    if Assigned(ChildForms[i]) and (ChildForms[i].FormType = FormType) and (ChildForms[i].Mode = Mode) and
      ((ChildForms[i].Properties.PK = Pk) and (ChildForms[i].Properties.Descriptor = Descriptor)) then
    begin
      result := i;
      break;
    end;
end;

function TFMain.FindInChildNodes(ParentNode: TTreeNode; Str: string; Options: TFindOptions): boolean;
var
  Node: TTreeNode;

begin
  result := false;
  if not Assigned(ParentNode) then exit;

  ParentNode.Expand(false);
  Node := ParentNode.getFirstChild;

  // переберем дочек, поищем у них
  while Assigned(Node) do
  begin
    // смотрим текущий узел - если совпало, завершаем поиск
    if Assigned(Node.Data) then
      if CompareNodeData(Str, TNodeDictInfo(Node.Data), Options) then
      begin
        TvSelectNode(Node);
        result := true;
        exit;
      end;

    // сразу переберем дочерние узлы (рекурсивно) - если там нашлось, завершаем
    result := FindInChildNodes(Node, Str, Options);
    if result then break;

    Node := ParentNode.GetNextChild(Node);
  end;

  if (not result) and CollapseAfterFind then ParentNode.Collapse(false);
end;

function TFMain.FindInNodes(StartNode: TTreeNode; CheckCurrent: boolean; Str: string; Options: TFindOptions; ShowMsg: boolean): boolean;
var
  Node: TTreeNode;

begin
  result := false;
  if not Assigned(StartNode) then
  begin
    if ShowMsg then Application.MessageBox('Поиск неожиданно прервался!', 'Поиск', MB_OK + MB_ICONINFORMATION);
    exit;
  end;

  if CheckCurrent then Node := StartNode
  else begin
    // сразу переберем дочерние узлы (рекурсивно) - если там нашлось, завершаем
    result := FindInChildNodes(StartNode, Str, Options);
    if result then exit;
    Node := StartNode.getNextSibling;
  end;

  // переберем братьев, поищем у них
  while Assigned(Node) do
  begin
    // смотрим текущий узел - если совпало, завершаем поиск
    if Assigned(Node.Data) then
      if CompareNodeData(Str, TNodeDictInfo(Node.Data), Options) then
      begin
        TvSelectNode(Node);
        result := true;
        exit;
      end;

    // переберем дочерние узлы (рекурсивно) - если там нашлось, завершаем
    result := FindInChildNodes(Node, Str, Options);
    if result then exit;

    Node := Node.getNextSibling;
  end;

  // ничего не нашли...
  if Assigned(StartNode.Parent) and (StartNode.Parent.getNextSibling <> nil) then
    //Тогда, если у узла есть родитель, то надо продолжить поиск, начиная со следующего брата родителя
    result := FindInNodes(StartNode.Parent.getNextSibling, true, Str, Options, ShowMsg)
  else begin
    // значит добрались до конца, надо спросить и начать сначала
    if ShowMsg and (Application.MessageBox('Поиск завершен! Начать с начала?', 'Поиск', MB_YESNO + MB_ICONQUESTION) = ID_YES) then
      result := FindInNodes(TJvTreeView(StartNode.TreeView).Items.GetFirstNode, true, Str, Options, ShowMsg)
    else
      result := false;
  end;
end;

procedure TFMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
  
begin
  Action := caFree;

  if not ForcedTerminate then
  begin
    if FSettings.ConfirmExit and
      (Application.MessageBox(pchar('Завершить работу программы?'), 'Выход', MB_YESNO + MB_ICONQUESTION) = ID_NO) then
    begin
      Action := caNone;
      exit;
    end;

    if FSettings.ConfirmCloseChild and (OpenedFormCount > 0) and
      (Application.MessageBox(pchar('Все открытые окна будут ЗАКРЫТЫ БЕЗ СОХРАНЕНИЯ изменений! Выходим?'), 'Подтверждение',
        MB_YESNO + MB_ICONQUESTION) = ID_NO) then
    begin
      Action := caNone;
      exit;
    end;
  end;
  
  FSettings.ShowOnlyUser := chbGetOnlyUser.Checked;
  FSettings.CurrPage := pcDictTree.ActivePageIndex;
  for i := 0 to Length(ChildForms) - 1 do
  begin
    if Assigned(ChildForms[i]) then FSettings.ChildMaximized := ChildForms[i].WindowState = wsMaximized;
    if Assigned(ChildForms[i]) and (ChildForms[i].WindowState = wsMaximized) then break;
  end;

  SaveWndState;
  SaveTreePositions;
  SaveSession;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  DbObjectList := TStringList.Create;
  tmrEndSession.Interval := 75 * 60 * 1000; // 1 час 15 мин
  WindowBar.Tabs.Clear;
  ConnectionsList := TConnectManager.Create(Self);
  ConnectChecker := TConnectChecker.Create;
  ConnectChecker.Add(Database, LostConnect, CHECK_CONN_INTERVAL, CHECK_CONN_QUERY, false);
  Database.DBName := '';
  Database.ConnectParams.UserName := '';
  Database.ConnectParams.Password := '';
  Database.ConnectParams.RoleName := '';
  Database.ConnectParams.CharSet := '';
  FSettings := TFSettings.Create(self);
  cbFilter.Items.AddStrings(FSettings.FilterHist);
  FindDialog := TFindDialog.Create(self);
  FindDialog.cbFindText.Items.AddStrings(FSettings.FindHist);
  FindDialog.chbMatchCase.Checked := FSettings.FindMatchCase;
  FindDialog.chbToExistence.Checked := FSettings.FindToExistence;
  FindDialog.rbWholeString.Checked := FSettings.FindWholeString;
  FindDialog.rbAnyWord.Checked := FSettings.FindAnyWord;
  FindDialog.rbAllWords.Checked := FSettings.FindAllWords;
  DBFindDialog := TDBFindDialog.Create(self);
  DBFindDialog.cbFindText.Items.AddStrings(FSettings.DbFindHist);
  DBFindDialog.chbMatchCase.Checked := FSettings.DbFindMatchCase;
  DBFindDialog.chbToExistence.Checked := FSettings.DBFindToExistence;
  DBFindDialog.rbWholeString.Checked := FSettings.DbFindWholeString;
  DBFindDialog.rbAnyWord.Checked := FSettings.DbFindAnyWord;
  DBFindDialog.rbAllWords.Checked := FSettings.DbFindAllWords;
  chbGetOnlyUser.Checked := FSettings.ShowOnlyUser;
  NoLoadInfo := false;
  AvailableUpdate := false;
  AskUpdate := true;
  ForcedTerminate := false;
  SetGridsOptions;
  FHint := TFHint.Create(Self);
  SetPages(true);
//  OpenConfiguration;
end;

procedure TFMain.FormDestroy(Sender: TObject);
begin
  SaveGridsParams;
  ClearChildForms;
  ConnectChecker.Free;
  if Database.Connected then Database.Close;
  ConnectionsList.Free;
  FHint.Free;
  FSettings.FilterHist.Clear;
  FSettings.FilterHist.AddStrings(cbFilter.Items);
  FSettings.FindHist.Clear;
  FSettings.FindHist.AddStrings(FindDialog.cbFindText.Items);
  FSettings.FindMatchCase := FindDialog.chbMatchCase.Checked;
  FSettings.FindToExistence := FindDialog.chbToExistence.Checked;
  FSettings.FindWholeString := FindDialog.rbWholeString.Checked;
  FSettings.FindAnyWord := FindDialog.rbAnyWord.Checked;
  FSettings.FindAllWords := FindDialog.rbAllWords.Checked;
  FindDialog.Free;
  FSettings.DbFindHist.Clear;
  FSettings.DbFindHist.AddStrings(DBFindDialog.cbFindText.Items);
  FSettings.DbFindMatchCase := DBFindDialog.chbMatchCase.Checked;
  FSettings.DbFindToExistence := DBFindDialog.chbToExistence.Checked;
  FSettings.DbFindWholeString := DBFindDialog.rbWholeString.Checked;
  FSettings.DbFindAnyWord := DBFindDialog.rbAnyWord.Checked;
  FSettings.DbFindAllWords := DBFindDialog.rbAllWords.Checked;
  DBFindDialog.Free;
  FSettings.Free;
  DbObjectList.Free;
end;

procedure TFMain.FormResize(Sender: TObject);
begin
  StatusBar.Panels[2].Width := StatusBar.Width - (StatusBar.Panels[0].Width + StatusBar.Panels[1].Width + StatusBar.Panels[3].Width) - 35;
end;

procedure TFMain.FormShow(Sender: TObject);
begin
  Top := FSettings.WTop;
  Left := FSettings.WLeft;
  Width := FSettings.WWidth;
  Height := FSettings.WHeight;
  if FSettings.WMaximized then
    WindowState := wsMaximized
  else
    WindowState := wsNormal;

  if cbFilter.Items.Count > 0 then
    cbFilter.Style := csDropDown
  else
    cbFilter.Style := csSimple;

  pTree.Width := FSettings.pTreeWidth;
  dbgObjectInfo.Height := FSettings.ObjectInfoHeight;
  pcDictTree.ActivePageIndex := FSettings.CurrPage;
 // RestoreTreePositions;
 // if FSettings.RestoreSession then LoadSession;
  tmrAutoUpdate.Enabled := FSettings.CheckUpdates;
  tmrOpen.Enabled := true;

  FHint.Left := FSettings.FHintLeft;
  FHint.Top := FSettings.FHintTop;
  FHint.Width := FSettings.FHintWidth;
  FHint.Height := FSettings.FHintHeight;
  if FSettings.FHintVisible then FHint.Show;
end;

procedure TFMain.CleanFilter(NoReload: boolean);
begin
  if not Filtered then exit;
  cbFilter.Text := '';
  cbFilter.Color := clWindow;
  Filtered := false;
  if not NoReload then ReopenTree(true);
end;

procedure TFMain.ClearChildForms;
var
  i: integer;

begin
  // кнопки в общем-то автоматом удаляться при закрытии окна
  WindowBar.Tabs.Clear;

  // пункты меню тоже
  {for i := 0 to miWindow.Count - 1 do
    if Pos('miWindow', miWindow.Items[i].Name) > 0 then
      miWindow.Remove(miWindow.Items[i]);}

  for i := 0 to Length(ChildForms) - 1 do
    if Assigned(ChildForms[i]) then FreeAndNil(ChildForms[i]);

  SetLength(ChildForms, 0);
  OpenedFormCount := 0;
end;

procedure TFMain.ClearHistory(HistType: THistoryType);
var
  err: string;

begin
  if not ExecSQL('delete from DCFG_HISTORY where TYPE_ = ''' + IntToStr(Ord(HistType)) + ''' and USER_PK = ' +
    dsPortalUserPK.AsString, err) then exit;

  if tsHistory.TabVisible then
  begin
    NoLoadInfo := true;
    try
      tvHistory.Visible := false;
      tvHistory.Items.Clear;
      LoadHistory(tvHistory);
    finally
      tvHistory.Visible := true;
      NoLoadInfo := false;
    end;
  end;
end;

procedure TFMain.GenBranchSQL(FolderPK: integer; Script, Folders: TStringList);
var
  ds: TpFIBDataSet;

begin
  // выберем вложенные папки и главные справочники папки
  try
    ds := OpenSQL('select 1 TYPE_, PK from DYNAMIC_FORM_FOLDER where PARENT_FOLDER_PK = ' + IntToStr(FolderPK) +
      ' union all select 2 TYPE_, PK from DYNAMIC_FORM_REFERENCE where FOLDER_PK = ' + IntToStr(FolderPK) + ' and PARENT_REFERENCE_PK is null');

    // если папка пустая - выгрузим ее саму
    if ds.IsEmpty then GenFolderSQL(FolderPK, Script, Folders);

    // пробежимся по всем пивязанным к папке справочникам, не имеющим родительского справочника и выгрузим их. Они подтянут за собой все остальное
    ds.First;
    while not ds.Eof do
    begin
      if ds.FieldByName('TYPE_').AsInteger = 2 then GenDictSQL(ds.FieldByName('PK').AsInteger, Script, Folders);
      ds.Next;
    end;

    // теперь надо пройтись по всем вложенным папкам и повторить все эти действия для них (рекурсивно)
    ds.First;
    while not ds.Eof do
    begin
      if ds.FieldByName('TYPE_').AsInteger = 1 then GenBranchSQL(ds.FieldByName('PK').AsInteger, Script, Folders);
      ds.Next;
    end;
  finally
    ds.Close;
    ds.Free;
  end;
end;

procedure TFMain.GenBranchWizardSQL(FolderPK: integer; Script, Wizards: TStringList);
var
  ds: TpFIBDataSet;

begin
  // выберем вложенные папки и главные справочники папки
  try
    ds := OpenSQL('select 1 TYPE_, PK from DYNAMIC_FORM_FOLDER where PARENT_FOLDER_PK = ' + IntToStr(FolderPK) +
      ' union all select 2 TYPE_, PK from DYNAMIC_FORM_REFERENCE where FOLDER_PK = ' + IntToStr(FolderPK) + ' and PARENT_REFERENCE_PK is null');

    // если папка пустая - уходим
    if ds.IsEmpty then exit;

    // пробежимся по всем пивязанным к папке справочникам, не имеющим родительского справочника и выгрузим их сценарии. Они подтянут за собой все остальное
    ds.First;
    while not ds.Eof do
    begin
      if ds.FieldByName('TYPE_').AsInteger = 2 then GenWizardOnDictSQL(ds.FieldByName('PK').AsInteger, Script, Wizards);
      ds.Next;
    end;

    // теперь надо пройтись по всем вложенным папкам и повторить все эти действия для них (рекурсивно)
    ds.First;
    while not ds.Eof do
    begin
      if ds.FieldByName('TYPE_').AsInteger = 1 then GenBranchWizardSQL(ds.FieldByName('PK').AsInteger, Script, Wizards);
      ds.Next;
    end;
  finally
    ds.Close;
    ds.Free;
  end;
end;

procedure TFMain.GenChartGroupSQL(Pk: integer; Script: TStringList; IsMain: boolean);
var
  ds1: TpFIBDataSet;

begin
  try
    ds1 := OpenSQL('select PK, REFERENCE_PK, TITLE, ORIENTATION from DYNAMIC_FORM_CHART_GROUPS where PK = ' + IntToStr(Pk));
    if ds1.IsEmpty then exit;

    if IsMain then Script.Add('/* DYNAMIC_FORM_CHART_GROUPS */');
    Script.Add('execute block');
    Script.Add('as');
    Script.Add('declare variable PK integer;');
    Script.Add('declare variable FK_REF integer;');
    Script.Add('declare variable PARAMS blob sub_type 1 segment size 80;');
    Script.Add('begin');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_REFERENCE'' into :PARAMS;');
    Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName('REFERENCE_PK').Value, false) +
      ', null) returning_values :FK_REF;');
    Script.Add('  insert into DYNAMIC_FORM_CHART_GROUPS (REFERENCE_PK, TITLE, ORIENTATION) values (:FK_REF, ' +
      VariantToDBStr(ReplaceQuote(ds1.FieldByName('TITLE').AsString), true) + ', ' +
      VariantToDBStr(ds1.FieldByName('ORIENTATION').Value, true) + ') returning PK into :PK;');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_CHART_GROUPS'' into :PARAMS;');
    Script.Add('  PARAMS = PARAMS || ''' + ds1.FieldByName('PK').AsString + ''' || '':'' || :PK || '','';');
    Script.Add('  update or insert into TMP_VAR (VAR_NAME, VALUE_) values (''DYNAMIC_FORM_CHART_GROUPS'', :PARAMS) matching (VAR_NAME);');
    Script.Add('end^');
    Script.Add('');
  finally
    ds1.Close;
    ds1.Free;
  end;
end;

procedure TFMain.GenChartSQL(Pk: integer; Script: TStringList; IsMain: boolean);
var
  ds1: TpFIBDataSet;

begin
  try
    ds1 := OpenSQL('select PK, REFERENC_PK, X_FIELD_PK, Y_FIELD_PK, GROUP_FUNCTION, SERIES_DIF, TITLE, CHART_TYPE, ORDER_, ' +
      'X_AXIS_ROTATE, ADDITIONAL_FIELD, ADDITIONAL_FIELD_ROTATE, Y_TITLE, GROUP_PK, GROUP_ORDER from DYNAMIC_FORM_CHARTS ' +
      'where PK = ' + IntToStr(Pk));
    if ds1.IsEmpty then exit;

    if IsMain then Script.Add('/* DYNAMIC_FORM_CHARTS */');
    Script.Add('execute block');
    Script.Add('as');
    Script.Add('declare variable FK_REF integer;');
    Script.Add('declare variable FK_X integer;');
    Script.Add('declare variable FK_Y integer;');
    Script.Add('declare variable FK_DIF integer;');
    Script.Add('declare variable FK_GROUP integer;');
    Script.Add('declare variable PARAMS blob sub_type 1 segment size 80;');
    Script.Add('begin');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_REFERENCE'' into :PARAMS;');
    Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName('REFERENC_PK').Value, false) +
      ', null) returning_values :FK_REF;');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_FIELD'' into :PARAMS;');
    Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName('X_FIELD_PK').Value, false) +
      ', null) returning_values :FK_X;');
    Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName('Y_FIELD_PK').Value, false) +
      ', null) returning_values :FK_Y;');
    Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName('SERIES_DIF').Value, false) +
      ', null) returning_values :FK_DIF;');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_CHART_GROUPS'' into :PARAMS;');
    Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName('GROUP_PK').Value, false) +
      ', null) returning_values :FK_GROUP;');
    Script.Add('  insert into DYNAMIC_FORM_CHARTS (REFERENC_PK, X_FIELD_PK, Y_FIELD_PK, GROUP_FUNCTION, SERIES_DIF, TITLE, CHART_TYPE, ORDER_, ' +
      'X_AXIS_ROTATE, ADDITIONAL_FIELD, ADDITIONAL_FIELD_ROTATE, Y_TITLE, GROUP_PK, GROUP_ORDER) values (:FK_REF, :FK_X, :FK_Y, ' +
      VariantToDBStr(ds1.FieldByName('GROUP_FUNCTION').Value, true) + ', :FK_DIF, ' +
      VariantToDBStr(ReplaceQuote(ds1.FieldByName('TITLE').AsString), true) + ', ' + VariantToDBStr(ds1.FieldByName('CHART_TYPE').Value, true) +
      ', ' + VariantToDBStr(ReplaceQuote(ds1.FieldByName('ORDER_').AsString), true) + ', ' +
      VariantToDBStr(ds1.FieldByName('X_AXIS_ROTATE').Value, false) + ', ' +
      VariantToDBStr(ReplaceQuote(ds1.FieldByName('ADDITIONAL_FIELD').AsString), true) + ', ' +
      VariantToDBStr(ds1.FieldByName('ADDITIONAL_FIELD_ROTATE').Value, false) + ', ' +
      VariantToDBStr(ReplaceQuote(ds1.FieldByName('Y_TITLE').AsString), true) + ', :FK_GROUP, ' +
      VariantToDBStr(ds1.FieldByName('GROUP_ORDER').Value, false) + ');');
    Script.Add('end^');
    Script.Add('');
  finally
    ds1.Close;
    ds1.Free;
  end;
end;

procedure TFMain.GenDictAllFieldsSQL(Pk: integer; Script: TStringList);
var
  ds1, ds2: TpFIBDataSet;

begin
  try
    ds1 := OpenSQL('select PK, MAIN_FORM_PK, START_FORM_PK, GROUP_EDIT_FORM_PK from DYNAMIC_FORM_REFERENCE where PK = ' + IntToStr(Pk));
    if ds1.IsEmpty then exit;

    // главная
    if not ds1.FieldByName('MAIN_FORM_PK').IsNull then
    begin
      ds2 := OpenSQL('select PK from DYNAMIC_FORM_FIELD where FORM_PK = ' + ds1.FieldByName('MAIN_FORM_PK').AsString + ' order by PK');
      ds2.First;
      while not ds2.Eof do
      begin
        GenFieldSQL(ds2.FieldByName('PK').AsInteger, Script, ds2.RecNo = 1);
        ds2.Next;
      end;
      ds2.Close;
      FreeAndNil(ds2);
    end;

    // стартовая
    if not ds1.FieldByName('START_FORM_PK').IsNull then
    begin
      ds2 := OpenSQL('select PK from DYNAMIC_FORM_FIELD where FORM_PK = ' + ds1.FieldByName('START_FORM_PK').AsString + ' order by PK');
      ds2.First;
      while not ds2.Eof do
      begin
        GenFieldSQL(ds2.FieldByName('PK').AsInteger, Script, ds2.RecNo = 1);
        ds2.Next;
      end;
      ds2.Close;
      FreeAndNil(ds2);
    end;

    // группового редактирования
    if not ds1.FieldByName('GROUP_EDIT_FORM_PK').IsNull then
    begin
      ds2 := OpenSQL('select PK from DYNAMIC_FORM_FIELD where FORM_PK = ' + ds1.FieldByName('GROUP_EDIT_FORM_PK').AsString + ' order by PK');
      ds2.First;
      while not ds2.Eof do
      begin
        GenFieldSQL(ds2.FieldByName('PK').AsInteger, Script, ds2.RecNo = 1);
        ds2.Next;
      end;
      ds2.Close;
      FreeAndNil(ds2);
    end;

    // дочерние справочники
    ds1.Close;
    FreeAndNil(ds1);
    ds1 := OpenSQL('select PK from DYNAMIC_FORM_REFERENCE where PARENT_REFERENCE_PK = ' + IntToStr(Pk) + ' order by PK');
    ds1.First;
    while not ds1.Eof do
    begin
      GenDictAllFieldsSQL(ds1.FieldByName('PK').AsInteger, Script);
      ds1.Next;
    end;
  finally
    if Assigned(ds1) then
    begin
      ds1.Close;
      ds1.Free;
    end;
    if Assigned(ds2) then
    begin
      ds2.Close;
      ds2.Free;
    end;
  end;
end;

procedure TFMain.GenDictPermissionsSQL(Pk: integer; Script: TStringList);
var
  ds1: TpFIBDataSet;

begin
  try
    ds1 := OpenSQL('select PK, DESCRIPTOR_ from DYNAMIC_FORM_REFERENCE where PK = ' + IntToStr(Pk));
    if ds1.IsEmpty then exit;

    // справочник
    Script.Add('/* DYNAMIC_FORM_REFERENCE */');
    Script.Add('execute block');
    Script.Add('as');
    Script.Add('declare variable PK integer;');
    Script.Add('declare variable PARAMS blob sub_type 1 segment size 80;');
    Script.Add('begin');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select PK from DYNAMIC_FORM_REFERENCE where DESCRIPTOR_ = ''' + ds1.FieldByName('DESCRIPTOR_').AsString + ''' into :PK;');
    Script.Add('  PARAMS = PARAMS || ''' + ds1.FieldByName('PK').AsString + ''' || '':'' || :PK || '','';');
    Script.Add('  update or insert into TMP_VAR (VAR_NAME, VALUE_) values (''DYNAMIC_FORM_REFERENCE'', :PARAMS) matching (VAR_NAME);');
    Script.Add('  insert into DCFG_REF_LOG (OBJ_TYPE, REF_DESCRIPTOR, ACTION_, USER_PK, ACTION_DETAIL) values (1, ''' + ds1.FieldByName('DESCRIPTOR_').AsString +
      ''', 1, ' + dsPortalUserPK.AsString + ', ''Перенакат всех прав справочника'');');
    Script.Add('  delete from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK;');
    Script.Add('  delete from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK;');
    Script.Add('end^');
    Script.Add('');
    ds1.Close;
    FreeAndNil(ds1);

    // привязанные объекты
    // все шаблоны всех справочников ветки DYNAMIC_FORM_PERM_TMP
    ds1 := OpenSQL('select distinct PK_TMP from ( ' +
      'select ADD_ PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK and ADD_ is not null and ADD_ <> 0 and ADD_ <> 1 ' +
      'union select EDIT_ PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK and EDIT_ is not null and EDIT_ <> 0 and EDIT_ <> 1 ' +
      'union select DEL_ PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK and DEL_ is not null and DEL_ <> 0 and DEL_ <> 1 ' +
      'union select VIEW_REF PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK and VIEW_REF is not null and VIEW_REF <> 0 and VIEW_REF <> 1 ' +
      'union select CONFIG_ PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK and CONFIG_ is not null and CONFIG_ <> 0 and CONFIG_ <> 1 ' +
      'union select VIEW_ PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK and VIEW_ is not null and VIEW_ <> 0 and VIEW_ <> 1 ' +
      'union select EXPORT PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK and EXPORT is not null and EXPORT <> 0 and EXPORT <> 1 ' +
      'union select IMPORT PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK and IMPORT is not null and IMPORT <> 0 and IMPORT <> 1 ' +
      'union select FILTRING PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK and FILTRING is not null and FILTRING <> 0 and FILTRING <> 1 ' +
      'union select GRID_SAVE PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = :PK and GRID_SAVE is not null and GRID_SAVE <> 0 and GRID_SAVE <> 1 ' +
      'union select ADD_ PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK and ADD_ is not null and ADD_ <> 0 and ADD_ <> 1 ' +
      'union select EDIT_ PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK and EDIT_ is not null and EDIT_ <> 0 and EDIT_ <> 1 ' +
      'union select DEL_ PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK and DEL_ is not null and DEL_ <> 0 and DEL_ <> 1 ' +
      'union select VIEW_REF PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK and VIEW_REF is not null and VIEW_REF <> 0 and VIEW_REF <> 1 ' +
      'union select CONFIG_ PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK and CONFIG_ is not null and CONFIG_ <> 0 and CONFIG_ <> 1 ' +
      'union select VIEW_ PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK and VIEW_ is not null and VIEW_ <> 0 and VIEW_ <> 1 ' +
      'union select EXPORT PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK and EXPORT is not null and EXPORT <> 0 and EXPORT <> 1 ' +
      'union select IMPORT PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK and IMPORT is not null and IMPORT <> 0 and IMPORT <> 1 ' +
      'union select FILTRING PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK and FILTRING is not null and FILTRING <> 0 and FILTRING <> 1 ' +
      'union select GRID_SAVE PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = :PK and GRID_SAVE is not null and GRID_SAVE <> 0 and GRID_SAVE <> 1)',
      'PK=' + IntToStr(Pk));

    ds1.First;
    while not ds1.Eof do
    begin
      GenPermTmpSQL(ds1.FieldByName('PK_TMP').AsInteger, Script, ds1.RecNo = 1);
      ds1.Next;
    end;
    ds1.Close;
    FreeAndNil(ds1);

    // DYNAMIC_FORM_PERMISSIONS
    ds1 := OpenSQL('select PK from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = ' + IntToStr(Pk) + ' and ROLE_PK <> 5');
    ds1.First;
    while not ds1.Eof do
    begin
      GenPermSQL(ds1.FieldByName('PK').AsInteger, 'DYNAMIC_FORM_PERMISSIONS', Script, ds1.RecNo = 1);
      ds1.Next;
    end;
    ds1.Close;
    FreeAndNil(ds1);

    // DYNAMIC_FORM_PERM_RANKS
    ds1 := OpenSQL('select PK from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = ' + IntToStr(Pk));
    ds1.First;
    while not ds1.Eof do
    begin
      GenPermSQL(ds1.FieldByName('PK').AsInteger, 'DYNAMIC_FORM_PERM_RANKS', Script, ds1.RecNo = 1);
      ds1.Next;
    end;
    ds1.Close;
    FreeAndNil(ds1);
  finally
    if Assigned(ds1) then
    begin
      ds1.Close;
      ds1.Free;
    end;
  end;
end;

procedure TFMain.GetDictAllFormsPK(RefPk: integer; PkList: TStringList);
var
  ds1: TpFIBDataSet;


begin
  try
    ds1 := OpenSQL('select PK, MAIN_FORM_PK, START_FORM_PK, GROUP_EDIT_FORM_PK from DYNAMIC_FORM_REFERENCE where PK = ' + IntToStr(RefPk));
    if ds1.IsEmpty then exit;

    // главная
    if not ds1.FieldByName('MAIN_FORM_PK').IsNull then PkList.Add(ds1.FieldByName('MAIN_FORM_PK').AsString);
    // стартовая
    if not ds1.FieldByName('START_FORM_PK').IsNull then PkList.Add(ds1.FieldByName('START_FORM_PK').AsString);
    // группового редактирования
    if not ds1.FieldByName('GROUP_EDIT_FORM_PK').IsNull then PkList.Add(ds1.FieldByName('GROUP_EDIT_FORM_PK').AsString);

    // дочерние справочники
    ds1.Close;
    FreeAndNil(ds1);
    ds1 := OpenSQL('select PK from DYNAMIC_FORM_REFERENCE where PARENT_REFERENCE_PK = ' + IntToStr(RefPk) + ' order by PK');
    ds1.First;
    while not ds1.Eof do
    begin
      GetDictAllFormsPK(ds1.FieldByName('PK').AsInteger, PkList);
      ds1.Next;
    end;
  finally
    if Assigned(ds1) then
    begin
      ds1.Close;
      ds1.Free;
    end;
  end;
end;

procedure TFMain.GenDictSQL(Pk: integer; Script, Folders: TStringList; IsMain: boolean);
var
  ds1, ds2: TpFIBDataSet;
  fpkList: TStringList;

begin
  fpkList := TStringList.Create;
  try
    ds1 := OpenSQL('select PK, OWNER_USER_PK, TITLE, CREATE_, ORDER_BY, DESCRIPTOR_, PARENT_REFERENCE_PK, MAIN_FORM_PK, START_FORM_PK, ' +
      'BASE_DESCRIPTOR, FOLDER_PK, PARENT_ID_FIELD, ID_FIELD, EXPAND_REF, COLLAPSE_FILTER, SHOW_CHILD_REF, GROUPING, CON_ORIENT, ' +
      'BRIEF_NOTE, EDITABLE, SET_DISTINCT, REF_SIZE, GROUP_EDIT_FORM_PK, SHOW_ONLY_ADMIN, INSERT_COUNT, EXPAND_TREE, USE_MEM, ' +
      'COUNT_ON_PAGE, DEFERRED_IMPORTS, AUTOSAVEINTERVAL, SKIP_DUPLICATES, SHOW_FILTER_BOUND, CHECK_SELECT from DYNAMIC_FORM_REFERENCE where ' +
      'PK = ' + IntToStr(Pk));
    if ds1.IsEmpty then exit;

    if IsMain then
    begin
      // если это первый раз и есть родительский справочник - надо выгрузить его, а он за собой потянет дочерние
      if not ds1.FieldByName('PARENT_REFERENCE_PK').IsNull then
      begin
        GenDictSQL(ds1.FieldByName('PARENT_REFERENCE_PK').AsInteger, Script, Folders);
        exit;
      end else
      begin
        // очистка
        Script.Add('/* deleting dict */');
        Script.Add('delete from DYNAMIC_FORM_REFERENCE where DESCRIPTOR_ = ''' + ds1.FieldByName('DESCRIPTOR_').AsString + '''^');
        Script.Add('commit^');
        Script.Add('');
      end;
    end;

    // выгрузим формы
    if not ds1.FieldByName('MAIN_FORM_PK').IsNull then GenFormSQL(ds1.FieldByName('MAIN_FORM_PK').AsInteger, Script);
    if not ds1.FieldByName('START_FORM_PK').IsNull then GenFormSQL(ds1.FieldByName('START_FORM_PK').AsInteger, Script);
    if not ds1.FieldByName('GROUP_EDIT_FORM_PK').IsNull then GenFormSQL(ds1.FieldByName('GROUP_EDIT_FORM_PK').AsInteger, Script);

    // выгрузим папки
    if not ds1.FieldByName('FOLDER_PK').IsNull then GenFolderSQL(ds1.FieldByName('FOLDER_PK').AsInteger, Script, Folders);

    // документ
    if not ds1.FieldByName('BRIEF_NOTE').IsNull then
      ds2 := OpenSQL('select PK, CONTENT from DYNAMIC_FORM_DOCUMENT where PK = ' + ds1.FieldByName('BRIEF_NOTE').AsString);

    // справочник
    Script.Add('/* DYNAMIC_FORM_REFERENCE */');
    Script.Add('execute block');
    Script.Add('as');
    Script.Add('declare variable PK integer;');
    Script.Add('declare variable FK_PARENT integer;');
    Script.Add('declare variable FK_MAIN_FORM integer;');
    Script.Add('declare variable FK_START_FORM integer;');
    Script.Add('declare variable FK_GROUP_FORM integer;');
    Script.Add('declare variable FK_FOLDER integer;');
    Script.Add('declare variable pDYNAMIC_FORM_REFERENCE blob sub_type 1 segment size 80;');
    Script.Add('declare variable PARAMS blob sub_type 1 segment size 80;');
    Script.Add('begin');
    Script.Add('  pDYNAMIC_FORM_REFERENCE = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_REFERENCE'' into :pDYNAMIC_FORM_REFERENCE;');
    Script.Add('  execute procedure DICT_GET_INT (pDYNAMIC_FORM_REFERENCE, ' + VariantToDBStr(ds1.FieldByName('PARENT_REFERENCE_PK').Value, false) +
      ', null) returning_values :FK_PARENT;');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM'' into :PARAMS;');
    Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName('MAIN_FORM_PK').Value, false) +
      ', null) returning_values :FK_MAIN_FORM;');
    Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName('START_FORM_PK').Value, false) +
      ', null) returning_values :FK_START_FORM;');
    Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName('GROUP_EDIT_FORM_PK').Value, false) +
      ', null) returning_values :FK_GROUP_FORM;');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_FOLDER'' into :PARAMS;');
    Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName('FOLDER_PK').Value, false) +
      ', null) returning_values :FK_FOLDER;');

    if Assigned(ds2) and ds2.Active and (not ds2.IsEmpty) then
    begin
      Script.Add('  if (not exists(select PK from DYNAMIC_FORM_DOCUMENT where PK = ' + ds2.FieldByName('PK').AsString + ')) then');
      Script.Add('    insert into DYNAMIC_FORM_DOCUMENT (PK, CONTENT) values (' + ds2.FieldByName('PK').AsString + ', ''' +
        ReplaceQuote(ds2.FieldByName('CONTENT').AsString) + ''');');
    end;

    Script.Add('  if (exists(select PK from DYNAMIC_FORM_REFERENCE where DESCRIPTOR_ = ''' + ds1.FieldByName('DESCRIPTOR_').AsString + ''')) then');
    Script.Add('  begin');
    Script.Add('    select PK from DYNAMIC_FORM_REFERENCE where DESCRIPTOR_ = ''' + ds1.FieldByName('DESCRIPTOR_').AsString + ''' into :PK;');
    Script.Add('    update DYNAMIC_FORM_REFERENCE set OWNER_USER_PK = ' + ds1.FieldByName('OWNER_USER_PK').AsString + ', TITLE = ''' +
      ReplaceQuote(ds1.FieldByName('TITLE').AsString) + ''', MODIFY = current_timestamp, ORDER_BY = ' +
      VariantToDBStr(ReplaceQuote(ds1.FieldByName('ORDER_BY').AsString), true) +
      ', PARENT_REFERENCE_PK = :FK_PARENT, MAIN_FORM_PK = :FK_MAIN_FORM, START_FORM_PK = :FK_START_FORM, BASE_DESCRIPTOR = ''' +
      ds1.FieldByName('BASE_DESCRIPTOR').AsString + ''', FOLDER_PK = :FK_FOLDER, PARENT_ID_FIELD = ' +
      VariantToDBStr(ds1.FieldByName('PARENT_ID_FIELD').Value, true) + ', ID_FIELD = ' +
      VariantToDBStr(ds1.FieldByName('ID_FIELD').Value, true) + ', EXPAND_REF = ' + VariantToDBStr(ds1.FieldByName('EXPAND_REF').Value, true) +
      ', COLLAPSE_FILTER = ' + VariantToDBStr(ds1.FieldByName('COLLAPSE_FILTER').Value, true) + ', SHOW_CHILD_REF = ' +
      VariantToDBStr(ds1.FieldByName('SHOW_CHILD_REF').Value, true) + ', GROUPING = ' +
      VariantToDBStr(ReplaceQuote(ds1.FieldByName('GROUPING').AsString), true) + ', CON_ORIENT = ' +
      VariantToDBStr(ds1.FieldByName('CON_ORIENT').Value, false) + ', BRIEF_NOTE = ' +
      VariantToDBStr(ds1.FieldByName('BRIEF_NOTE').Value, false) + ', EDITABLE = ' + VariantToDBStr(ds1.FieldByName('EDITABLE').Value, false) +
      ', SET_DISTINCT = ''' + ds1.FieldByName('SET_DISTINCT').AsString + ''', REF_SIZE = ' +
      VariantToDBStr(ds1.FieldByName('REF_SIZE').Value, false) + ', GROUP_EDIT_FORM_PK = :FK_GROUP_FORM, SHOW_ONLY_ADMIN = ' +
      VariantToDBStr(ds1.FieldByName('SHOW_ONLY_ADMIN').Value, false) + ', INSERT_COUNT = ' +
      VariantToDBStr(ds1.FieldByName('INSERT_COUNT').Value, false) + ', EXPAND_TREE = ' +
      VariantToDBStr(ds1.FieldByName('EXPAND_TREE').Value, false) + ', USE_MEM = ' + VariantToDBStr(ds1.FieldByName('USE_MEM').Value, false) +
      ', COUNT_ON_PAGE = ' + VariantToDBStr(ds1.FieldByName('COUNT_ON_PAGE').Value, false) + ', DEFERRED_IMPORTS = ' +
      VariantToDBStr(ds1.FieldByName('DEFERRED_IMPORTS').Value, false) + ', AUTOSAVEINTERVAL = ' +
      VariantToDBStr(ds1.FieldByName('AUTOSAVEINTERVAL').Value, false) + ', SKIP_DUPLICATES = ' +
      VariantToDBStr(ds1.FieldByName('SKIP_DUPLICATES').Value, true) + ', SHOW_FILTER_BOUND = ' +
      VariantToDBStr(ds1.FieldByName('SHOW_FILTER_BOUND').Value, true) + ', CHECK_SELECT = ' +
      VariantToDBStr(ds1.FieldByName('CHECK_SELECT').Value, false) + ' where DESCRIPTOR_ = ''' + ds1.FieldByName('DESCRIPTOR_').AsString + ''';');
    Script.Add('  end else');
    Script.Add('    insert into DYNAMIC_FORM_REFERENCE (OWNER_USER_PK, TITLE, CREATE_, ORDER_BY, DESCRIPTOR_, PARENT_REFERENCE_PK, MAIN_FORM_PK, ' +
      'START_FORM_PK, BASE_DESCRIPTOR, FOLDER_PK, PARENT_ID_FIELD, ID_FIELD, EXPAND_REF, COLLAPSE_FILTER, SHOW_CHILD_REF, GROUPING, CON_ORIENT, ' +
      'BRIEF_NOTE, EDITABLE, SET_DISTINCT, REF_SIZE, GROUP_EDIT_FORM_PK, SHOW_ONLY_ADMIN, INSERT_COUNT, EXPAND_TREE, USE_MEM, ' +
      'COUNT_ON_PAGE, DEFERRED_IMPORTS, AUTOSAVEINTERVAL, SKIP_DUPLICATES, SHOW_FILTER_BOUND, CHECK_SELECT) values (' +
      ds1.FieldByName('OWNER_USER_PK').AsString + ', ''' + ReplaceQuote(ds1.FieldByName('TITLE').AsString) + ''', ' +
      VariantToDBStr(ds1.FieldByName('CREATE_').AsString, true) + ', ' +
      VariantToDBStr(ReplaceQuote(ds1.FieldByName('ORDER_BY').AsString), true) + ', ''' + ds1.FieldByName('DESCRIPTOR_').AsString +
      ''', :FK_PARENT, :FK_MAIN_FORM, :FK_START_FORM, ''' + ds1.FieldByName('BASE_DESCRIPTOR').AsString + ''', :FK_FOLDER, ' +
      VariantToDBStr(ds1.FieldByName('PARENT_ID_FIELD').Value, true) + ', ' + VariantToDBStr(ds1.FieldByName('ID_FIELD').Value, true) + ', ' +
      VariantToDBStr(ds1.FieldByName('EXPAND_REF').Value, true) + ', ' + VariantToDBStr(ds1.FieldByName('COLLAPSE_FILTER').Value, true) + ', ' +
      VariantToDBStr(ds1.FieldByName('SHOW_CHILD_REF').Value, true) + ', ' +
      VariantToDBStr(ReplaceQuote(ds1.FieldByName('GROUPING').AsString), true) + ', ' + VariantToDBStr(ds1.FieldByName('CON_ORIENT').Value, false) +
      ', ' + VariantToDBStr(ds1.FieldByName('BRIEF_NOTE').Value, false) + ', ' + VariantToDBStr(ds1.FieldByName('EDITABLE').Value, false) + ', ''' +
      ds1.FieldByName('SET_DISTINCT').AsString + ''', ' + VariantToDBStr(ds1.FieldByName('REF_SIZE').Value, false) + ', :FK_GROUP_FORM, ' +
      VariantToDBStr(ds1.FieldByName('SHOW_ONLY_ADMIN').Value, false) + ', ' + VariantToDBStr(ds1.FieldByName('INSERT_COUNT').Value, false) +
      ', ' + VariantToDBStr(ds1.FieldByName('EXPAND_TREE').Value, false) + ', ' + VariantToDBStr(ds1.FieldByName('USE_MEM').Value, false) + ', ' +
      VariantToDBStr(ds1.FieldByName('COUNT_ON_PAGE').Value, false) + ', ' + VariantToDBStr(ds1.FieldByName('DEFERRED_IMPORTS').Value, false) +
      ', ' + VariantToDBStr(ds1.FieldByName('AUTOSAVEINTERVAL').Value, false) + ', ' +
      VariantToDBStr(ds1.FieldByName('SKIP_DUPLICATES').Value, true) + ', ' + VariantToDBStr(ds1.FieldByName('SHOW_FILTER_BOUND').Value, true) +
      ', ' + VariantToDBStr(ds1.FieldByName('CHECK_SELECT').Value, false) + ') returning PK into :PK;');
    Script.Add('  pDYNAMIC_FORM_REFERENCE = pDYNAMIC_FORM_REFERENCE || ''' + ds1.FieldByName('PK').AsString + ''' || '':'' || :PK || '','';');
    Script.Add('  update or insert into TMP_VAR (VAR_NAME, VALUE_) values (''DYNAMIC_FORM_REFERENCE'', :pDYNAMIC_FORM_REFERENCE) matching (VAR_NAME);');
    Script.Add('  insert into DCFG_REF_LOG (OBJ_TYPE, REF_DESCRIPTOR, ACTION_, USER_PK) values (1, ''' + ds1.FieldByName('DESCRIPTOR_').AsString +
      ''', 2, ' + dsPortalUserPK.AsString + ');');
    Script.Add('end^');
    Script.Add('');
    ds1.Close;
    FreeAndNil(ds1);

    // привязанные объекты
    // все шаблоны всех справочников ветки DYNAMIC_FORM_PERM_TMP
    if IsMain then
    begin
      ds1 := OpenSQL('select distinct PK_TMP from ( ' +
        'select ADD_ PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK in (select PK from DYNAMIC_FORM_REFERENCE where PK = :PK or PARENT_REFERENCE_PK = :PK) and ADD_ is not null and ADD_ <> 0 and ADD_ <> 1 ' +
        'union select EDIT_ PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK in (select PK from DYNAMIC_FORM_REFERENCE where PK = :PK or PARENT_REFERENCE_PK = :PK) and EDIT_ is not null and EDIT_ <> 0 and EDIT_ <> 1 ' +
        'union select DEL_ PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK in (select PK from DYNAMIC_FORM_REFERENCE where PK = :PK or PARENT_REFERENCE_PK = :PK) and DEL_ is not null and DEL_ <> 0 and DEL_ <> 1 ' +
        'union select VIEW_REF PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK in (select PK from DYNAMIC_FORM_REFERENCE where PK = :PK or PARENT_REFERENCE_PK = :PK) and VIEW_REF is not null and VIEW_REF <> 0 and VIEW_REF <> 1 ' +
        'union select CONFIG_ PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK in (select PK from DYNAMIC_FORM_REFERENCE where PK = :PK or PARENT_REFERENCE_PK = :PK) and CONFIG_ is not null and CONFIG_ <> 0 and CONFIG_ <> 1 ' +
        'union select VIEW_ PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK in (select PK from DYNAMIC_FORM_REFERENCE where PK = :PK or PARENT_REFERENCE_PK = :PK) and VIEW_ is not null and VIEW_ <> 0 and VIEW_ <> 1 ' +
        'union select EXPORT PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK in (select PK from DYNAMIC_FORM_REFERENCE where PK = :PK or PARENT_REFERENCE_PK = :PK) and EXPORT is not null and EXPORT <> 0 and EXPORT <> 1 ' +
        'union select IMPORT PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK in (select PK from DYNAMIC_FORM_REFERENCE where PK = :PK or PARENT_REFERENCE_PK = :PK) and IMPORT is not null and IMPORT <> 0 and IMPORT <> 1 ' +
        'union select FILTRING PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK in (select PK from DYNAMIC_FORM_REFERENCE where PK = :PK or PARENT_REFERENCE_PK = :PK) and FILTRING is not null and FILTRING <> 0 and FILTRING <> 1 ' +
        'union select GRID_SAVE PK_TMP from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK in (select PK from DYNAMIC_FORM_REFERENCE where PK = :PK or PARENT_REFERENCE_PK = :PK) and GRID_SAVE is not null and GRID_SAVE <> 0 and GRID_SAVE <> 1 ' +
        'union select ADD_ PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK in (select PK from DYNAMIC_FORM_REFERENCE where PK = :PK or PARENT_REFERENCE_PK = :PK) and ADD_ is not null and ADD_ <> 0 and ADD_ <> 1 ' +
        'union select EDIT_ PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK in (select PK from DYNAMIC_FORM_REFERENCE where PK = :PK or PARENT_REFERENCE_PK = :PK) and EDIT_ is not null and EDIT_ <> 0 and EDIT_ <> 1 ' +
        'union select DEL_ PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK in (select PK from DYNAMIC_FORM_REFERENCE where PK = :PK or PARENT_REFERENCE_PK = :PK) and DEL_ is not null and DEL_ <> 0 and DEL_ <> 1 ' +
        'union select VIEW_REF PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK in (select PK from DYNAMIC_FORM_REFERENCE where PK = :PK or PARENT_REFERENCE_PK = :PK) and VIEW_REF is not null and VIEW_REF <> 0 and VIEW_REF <> 1 ' +
        'union select CONFIG_ PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK in (select PK from DYNAMIC_FORM_REFERENCE where PK = :PK or PARENT_REFERENCE_PK = :PK) and CONFIG_ is not null and CONFIG_ <> 0 and CONFIG_ <> 1 ' +
        'union select VIEW_ PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK in (select PK from DYNAMIC_FORM_REFERENCE where PK = :PK or PARENT_REFERENCE_PK = :PK) and VIEW_ is not null and VIEW_ <> 0 and VIEW_ <> 1 ' +
        'union select EXPORT PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK in (select PK from DYNAMIC_FORM_REFERENCE where PK = :PK or PARENT_REFERENCE_PK = :PK) and EXPORT is not null and EXPORT <> 0 and EXPORT <> 1 ' +
        'union select IMPORT PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK in (select PK from DYNAMIC_FORM_REFERENCE where PK = :PK or PARENT_REFERENCE_PK = :PK) and IMPORT is not null and IMPORT <> 0 and IMPORT <> 1 ' +
        'union select FILTRING PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK in (select PK from DYNAMIC_FORM_REFERENCE where PK = :PK or PARENT_REFERENCE_PK = :PK) and FILTRING is not null and FILTRING <> 0 and FILTRING <> 1 ' +
        'union select GRID_SAVE PK_TMP from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK in (select PK from DYNAMIC_FORM_REFERENCE where PK = :PK or PARENT_REFERENCE_PK = :PK) and GRID_SAVE is not null and GRID_SAVE <> 0 and GRID_SAVE <> 1)',
        'PK=' + IntToStr(Pk));

      ds1.First;
      while not ds1.Eof do
      begin
        GenPermTmpSQL(ds1.FieldByName('PK_TMP').AsInteger, Script, ds1.RecNo = 1);
        ds1.Next;
      end;
      ds1.Close;
      FreeAndNil(ds1);

      // все шаблоны полей всех справочников и форм
      GetDictAllFormsPK(Pk, fpkList);
      if fpkList.Count > 0 then
      begin
        ds1 := OpenSQL(StringReplace('select distinct PK_TMP from ( ' +
          'select GRID_VISIBLE PK_TMP from DYNAMIC_FORM_FIELD where FORM_PK in ({pk_list}) ' +
          'union select EDITABLE PK_TMP from DYNAMIC_FORM_FIELD where FORM_PK in ({pk_list}) ' +
          'union select ADD_EDITABLE PK_TMP from DYNAMIC_FORM_FIELD where FORM_PK in ({pk_list}) ' +
          'union select IS_VISIBLE_ADD PK_TMP from DYNAMIC_FORM_FIELD where FORM_PK in ({pk_list}) ' +
          'union select EDIT_IN_TABLE PK_TMP from DYNAMIC_FORM_FIELD where FORM_PK in ({pk_list}) ' +
          'union select IS_VISIBLE PK_TMP from DYNAMIC_FORM_FIELD where FORM_PK in ({pk_list})) ' +
          'where PK_TMP is not null and PK_TMP not in (0, 1)', '{pk_list}', TextToString(fpkList.Text), [rfReplaceAll]));

        ds1.First;
        while not ds1.Eof do
        begin
          GenPermTmpSQL(ds1.FieldByName('PK_TMP').AsInteger, Script, False);
          ds1.Next;
        end;
        ds1.Close;
        FreeAndNil(ds1);
      end;
    end;

    // DYNAMIC_FORM_PERMISSIONS
    ds1 := OpenSQL('select PK from DYNAMIC_FORM_PERMISSIONS where REFERENCE_PK = ' + IntToStr(Pk) + ' and ROLE_PK <> 5');
    ds1.First;
    while not ds1.Eof do
    begin
      GenPermSQL(ds1.FieldByName('PK').AsInteger, 'DYNAMIC_FORM_PERMISSIONS', Script, ds1.RecNo = 1);
      ds1.Next;
    end;
    ds1.Close;
    FreeAndNil(ds1);

    // DYNAMIC_FORM_PERM_RANKS
    ds1 := OpenSQL('select PK from DYNAMIC_FORM_PERM_RANKS where REFERENCE_PK = ' + IntToStr(Pk));
    ds1.First;
    while not ds1.Eof do
    begin
      GenPermSQL(ds1.FieldByName('PK').AsInteger, 'DYNAMIC_FORM_PERM_RANKS', Script, ds1.RecNo = 1);
      ds1.Next;
    end;
    ds1.Close;
    FreeAndNil(ds1);

    // DYNAMIC_FORM_FILTER_CONFIG
    ds1 := OpenSQL('select PK from DYNAMIC_FORM_FILTER_CONFIG where REF_PK = ' + IntToStr(Pk));
    ds1.First;
    while not ds1.Eof do
    begin
      GenFilterConfigSQL(ds1.FieldByName('PK').AsInteger, Script, ds1.RecNo = 1);
      ds1.Next;
    end;
    ds1.Close;
    FreeAndNil(ds1);

    // DYNAMIC_FROM_POST_FILTER
    ds1 := OpenSQL('select p.PK from DYNAMIC_FROM_POST_FILTER p join DYNAMIC_FORM_FILTER_CONFIG c on c.PK = p.FILTER_CONFIG_PK ' +
      'where c.REF_PK = ' + IntToStr(Pk));
    ds1.First;
    while not ds1.Eof do
    begin
      GenPostFilterSQL(ds1.FieldByName('PK').AsInteger, Script, ds1.RecNo = 1);
      ds1.Next;
    end;
    ds1.Close;
    FreeAndNil(ds1);

    // DYNAMIC_FORM_CHART_GROUPS
    ds1 := OpenSQL('select PK from DYNAMIC_FORM_CHART_GROUPS where REFERENCE_PK = ' + IntToStr(Pk));
    ds1.First;
    while not ds1.Eof do
    begin
      GenChartGroupSQL(ds1.FieldByName('PK').AsInteger, Script, ds1.RecNo = 1);
      ds1.Next;
    end;
    ds1.Close;
    FreeAndNil(ds1);

    // DYNAMIC_FORM_OTHER_EVENT
    ds1 := OpenSQL('select ID_EV from DYNAMIC_FORM_OTHER_EVENT where ID_DF_REFERENCE = ' + IntToStr(Pk));
    ds1.First;
    while not ds1.Eof do
    begin
      GenOtherEventSQL(ds1.FieldByName('ID_EV').AsInteger, Script, ds1.RecNo = 1);
      ds1.Next;
    end;
    ds1.Close;
    FreeAndNil(ds1);

    // DYNAMIC_FORM_TREE_INDEX
    ds1 := OpenSQL('select ELEMENT_ID from DYNAMIC_FORM_TREE_INDEX where REFERENCE_ID = ' + IntToStr(Pk) + ' order by ELEMENT_ID');
    ds1.First;
    while not ds1.Eof do
    begin
      GenTreeIndexSQL(ds1.FieldByName('ELEMENT_ID').AsInteger, Pk, Script, ds1.RecNo = 1);
      ds1.Next;
    end;
    ds1.Close;
    FreeAndNil(ds1);

    // дочерние справочники
    ds1 := OpenSQL('select PK from DYNAMIC_FORM_REFERENCE where PARENT_REFERENCE_PK = ' + IntToStr(Pk) + ' order by PK');
    ds1.First;
    while not ds1.Eof do
    begin
      GenDictSQL(ds1.FieldByName('PK').AsInteger, Script, Folders, false);
      ds1.Next;
    end;
    ds1.Close;
    FreeAndNil(ds1);

    // все поля форм справочника, рекурсивно с дочерними. Так надо, потому что поля надо выгрузить в конце после того, как будут залиты все объекты
    if IsMain then
    begin
      GenDictAllFieldsSQL(Pk, Script);

      // DYNAMIC_FORM_CHARTS - главный
      ds1 := OpenSQL('select PK from DYNAMIC_FORM_CHARTS where REFERENC_PK = ' + IntToStr(Pk));
      ds1.First;
      while not ds1.Eof do
      begin
        GenChartSQL(ds1.FieldByName('PK').AsInteger, Script, ds1.RecNo = 1);
        ds1.Next;
      end;
      ds1.Close;
      FreeAndNil(ds1);

      // DYNAMIC_FORM_CHARTS - дочерние
      ds1 := OpenSQL('select PK from DYNAMIC_FORM_CHARTS where REFERENC_PK in (' +
        'select PK from DYNAMIC_FORM_REFERENCE where PARENT_REFERENCE_PK = ' + IntToStr(Pk) + ') order by REFERENC_PK');

      ds1.First;
      while not ds1.Eof do
      begin
        GenChartSQL(ds1.FieldByName('PK').AsInteger, Script, false);
        ds1.Next;
      end;
      ds1.Close;
      FreeAndNil(ds1);
    end;
  finally
    fpkList.Free;
    if Assigned(ds1) then
    begin
      ds1.Close;
      ds1.Free;
    end;
    if Assigned(ds2) then
    begin
      ds2.Close;
      ds2.Free;
    end;
  end;
end;

procedure TFMain.GenFieldGroupSQL(Pk: integer; Script: TStringList; IsMain: boolean);
var
  ds1: TpFIBDataSet;

begin
  try
    ds1 := OpenSQL('select PK, PARENT_PK, OWNER_USER_PK, FORM_PK, ORDER_, TITLE, DESCRIPTION, COUNT_COLUMN, STYLE_EXTERNAL, STYLE_INTERNAL, ' +
      'CREATE_, IS_VISIBLE, COLUMN_, STYLE_COLUMNS, ADD_VISIBLE, COLLAPSED, LEFT_ALIGN, LABEL_WIDTH from DYNAMIC_FORM_FIELD_GROUP ' +
      'where PK = ' + IntToStr(Pk));
    if ds1.IsEmpty then exit;

    if IsMain then Script.Add('/* DYNAMIC_FORM_FIELD_GROUP */');
    Script.Add('execute block');
    Script.Add('as');
    Script.Add('declare variable PK integer;');
    Script.Add('declare variable FK_FORM integer;');
    Script.Add('declare variable FK_GROUP integer;');
    Script.Add('declare variable pDYNAMIC_FORM_FIELD_GROUP blob sub_type 1 segment size 80;');
    Script.Add('declare variable pDYNAMIC_FORM blob sub_type 1 segment size 80;');
    Script.Add('begin');
    Script.Add('  pDYNAMIC_FORM_FIELD_GROUP = '''';');
    Script.Add('  pDYNAMIC_FORM = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_FIELD_GROUP'' into :pDYNAMIC_FORM_FIELD_GROUP;');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM'' into :pDYNAMIC_FORM;');
    Script.Add('  execute procedure DICT_GET_INT (pDYNAMIC_FORM, ' + VariantToDBStr(ds1.FieldByName('FORM_PK').Value, false) +
      ', null) returning_values :FK_FORM;');
    Script.Add('  execute procedure DICT_GET_INT (pDYNAMIC_FORM_FIELD_GROUP, ' + VariantToDBStr(ds1.FieldByName('PARENT_PK').Value, false) +
      ', null) returning_values :FK_GROUP;');
    Script.Add('  insert into DYNAMIC_FORM_FIELD_GROUP (PARENT_PK, OWNER_USER_PK, FORM_PK, ORDER_, TITLE, DESCRIPTION, COUNT_COLUMN, ' +
      'STYLE_EXTERNAL, STYLE_INTERNAL, CREATE_, IS_VISIBLE, COLUMN_, STYLE_COLUMNS, ADD_VISIBLE, COLLAPSED, LEFT_ALIGN, LABEL_WIDTH) ' +
      'values (' + ':FK_GROUP, ' + ds1.FieldByName('OWNER_USER_PK').AsString + ', :FK_FORM, ' + ds1.FieldByName('ORDER_').AsString +
      ', ''' + ReplaceQuote(ds1.FieldByName('TITLE').AsString) + ''', ' +
      VariantToDBStr(ReplaceQuote(ds1.FieldByName('DESCRIPTION').AsString), true) + ', ' + ds1.FieldByName('COUNT_COLUMN').AsString + ', ''' +
      ReplaceQuote(ds1.FieldByName('STYLE_EXTERNAL').AsString) + ''', ''' + ReplaceQuote(ds1.FieldByName('STYLE_INTERNAL').AsString) +
      ''', ' + VariantToDBStr(ReplaceQuote(ds1.FieldByName('CREATE_').AsString), true) + ', ''' + ds1.FieldByName('IS_VISIBLE').AsString + ''', ' +
      ds1.FieldByName('COLUMN_').AsString + ', ''' + ReplaceQuote(ds1.FieldByName('STYLE_COLUMNS').AsString) + ''', ' +
      VariantToDBStr(ds1.FieldByName('ADD_VISIBLE').Value, false) + ', ' + VariantToDBStr(ds1.FieldByName('COLLAPSED').Value, false) + ', ' +
      VariantToDBStr(ds1.FieldByName('LEFT_ALIGN').Value, false) + ', ' + VariantToDBStr(ds1.FieldByName('LABEL_WIDTH').Value, false) +
      ') returning PK into :PK;');
    Script.Add('  pDYNAMIC_FORM_FIELD_GROUP = pDYNAMIC_FORM_FIELD_GROUP || ''' + ds1.FieldByName('PK').AsString + ''' || '':'' || :PK || '','';');
    Script.Add('  update or insert into TMP_VAR (VAR_NAME, VALUE_) values (''DYNAMIC_FORM_FIELD_GROUP'', :pDYNAMIC_FORM_FIELD_GROUP) ' +
      'matching (VAR_NAME);');
    Script.Add('end^');
    Script.Add('');
  finally
    ds1.Close;
    ds1.Free;
  end;
end;

procedure TFMain.GenFieldSQL(Pk: integer; Script: TStringList; IsMain: boolean);
const
  tmp_fields: array [0..5] of string = ('IS_VISIBLE', 'GRID_VISIBLE', 'EDITABLE', 'ADD_EDITABLE', 'IS_VISIBLE_ADD', 'EDIT_IN_TABLE');

var
  i: integer;
  ds1: TpFIBDataSet;

begin
  try
    ds1 := OpenSQL('select PK, OWNER_USER_PK, GROUP_PK, GROUP_COLUMN, OBJECT_PK, ORDER_, TITLE, DESCRIPTION, TYPE_NAME, FIELD_NAME, ' +
      'STYLE_EXTERNAL, STYLE, PARAMETERS, CREATE_, FORM_PK, GRID_ORDER, GRID_WIDTH, EXCEL_EXPORT, FILTER_ORDER, IS_FILTER, SHOW_IN_START_FORM, ' +
      'STYLE_COLUMN, SHOW_IN_GROUP_EDIT, EXCEL_IMPORT, MATCH, LOCKED, FILTER_GROUP, IS_VISIBLE, GRID_VISIBLE, EDITABLE, ' +
      'ADD_EDITABLE, IS_VISIBLE_ADD, EDIT_IN_TABLE from DYNAMIC_FORM_FIELD where PK = ' + IntToStr(Pk));
    if ds1.IsEmpty then exit;

    if IsMain then Script.Add('/* DYNAMIC_FORM_FIELD */');
    Script.Add('execute block');
    Script.Add('as');
    Script.Add('declare variable PK integer;');
    Script.Add('declare variable FK_FORM integer;');
    Script.Add('declare variable FK_GROUP integer;');
    Script.Add('declare variable FK_OBJECT integer;');
    Script.Add('declare variable FK_FILTER_GROUP integer;');
    for i := 0 to Length(tmp_fields) - 1 do Script.Add('declare variable FK_TMP_' + tmp_fields[i] + ' integer;');
    Script.Add('declare variable pDYNAMIC_FORM_FIELD blob sub_type 1 segment size 80;');
    Script.Add('declare variable PARAMS blob sub_type 1 segment size 80;');
    Script.Add('begin');
    Script.Add('  pDYNAMIC_FORM_FIELD = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_FIELD'' into :pDYNAMIC_FORM_FIELD;');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM'' into :PARAMS;');
    Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName('FORM_PK').Value, false) +
      ', null) returning_values :FK_FORM;');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_FIELD_GROUP'' into :PARAMS;');
    Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName('GROUP_PK').Value, false) +
      ', null) returning_values :FK_GROUP;');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_OBJECT_TREE'' into :PARAMS;');
    Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName('OBJECT_PK').Value, false) +
      ', null) returning_values :FK_OBJECT;');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_FILTER_GROUP'' into :PARAMS;');
    Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName('FILTER_GROUP').Value, false) +
      ', null) returning_values :FK_FILTER_GROUP;');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_PERM_TMP'' into :PARAMS;');

    for i := 0 to Length(tmp_fields) - 1 do
      if (ds1.FieldByName(tmp_fields[i]).AsInteger <> 0) and (ds1.FieldByName(tmp_fields[i]).AsInteger <> 1) then
        Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName(tmp_fields[i]).Value, false) +
          ', null) returning_values :FK_TMP_' + tmp_fields[i] + ';')
      else
        Script.Add('  FK_TMP_' + tmp_fields[i] + ' = ' + ds1.FieldByName(tmp_fields[i]).AsString + ';');

    Script.Add('  insert into DYNAMIC_FORM_FIELD (OWNER_USER_PK, GROUP_PK, GROUP_COLUMN, OBJECT_PK, ORDER_, TITLE, DESCRIPTION, TYPE_NAME, ' +
      'FIELD_NAME, STYLE_EXTERNAL, STYLE, PARAMETERS, CREATE_, IS_VISIBLE, FORM_PK, GRID_VISIBLE, GRID_ORDER, GRID_WIDTH, EDITABLE, ADD_EDITABLE, ' +
      'EXCEL_EXPORT, IS_VISIBLE_ADD, FILTER_ORDER, IS_FILTER, SHOW_IN_START_FORM, STYLE_COLUMN, EDIT_IN_TABLE, SHOW_IN_GROUP_EDIT, ' +
      'EXCEL_IMPORT, MATCH, LOCKED, FILTER_GROUP) values (' + ds1.FieldByName('OWNER_USER_PK').AsString + ', :FK_GROUP, ' +
      ds1.FieldByName('GROUP_COLUMN').AsString + ', :FK_OBJECT, ' + ds1.FieldByName('ORDER_').AsString + ', ''' +
      ReplaceQuote(ds1.FieldByName('TITLE').AsString) + ''', ''' + ReplaceQuote(ds1.FieldByName('DESCRIPTION').AsString) + ''', ''' +
      ds1.FieldByName('TYPE_NAME').AsString + ''', ''' + ds1.FieldByName('FIELD_NAME').AsString + ''', ''' +
      ReplaceQuote(ds1.FieldByName('STYLE_EXTERNAL').AsString) + ''', ''' + ReplaceQuote(ds1.FieldByName('STYLE').AsString) + ''', ''' +
      ReplaceQuote(ds1.FieldByName('PARAMETERS').AsString) + ''', ' + VariantToDBStr(ds1.FieldByName('CREATE_').AsString, true) +
      ', :FK_TMP_IS_VISIBLE, :FK_FORM, :FK_TMP_GRID_VISIBLE, ' + ds1.FieldByName('GRID_ORDER').AsString + ', ' +
      VariantToDBStr(ds1.FieldByName('GRID_WIDTH').Value, false) + ', :FK_TMP_EDITABLE, :FK_TMP_ADD_EDITABLE, ' + ds1.FieldByName('EXCEL_EXPORT').AsString +
      ', :FK_TMP_IS_VISIBLE_ADD, ' + VariantToDBStr(ds1.FieldByName('FILTER_ORDER').Value, false) + ', ' +
      VariantToDBStr(ds1.FieldByName('IS_FILTER').Value, false) + ', ' + ds1.FieldByName('SHOW_IN_START_FORM').AsString + ', ' +
      VariantToDBStr(ReplaceQuote(ds1.FieldByName('STYLE_COLUMN').AsString), true) + ', :FK_TMP_EDIT_IN_TABLE, ' +
      ds1.FieldByName('SHOW_IN_GROUP_EDIT').AsString + ', ' + VariantToDBStr(ds1.FieldByName('EXCEL_IMPORT').Value, false) + ', ' +
      VariantToDBStr(ds1.FieldByName('MATCH').Value, false) + ', ' + VariantToDBStr(ds1.FieldByName('LOCKED').Value, false) +
      ', :FK_FILTER_GROUP) returning PK into :PK;');
    Script.Add('  pDYNAMIC_FORM_FIELD = pDYNAMIC_FORM_FIELD || ''' + ds1.FieldByName('PK').AsString + ''' || '':'' || :PK || '','';');
    Script.Add('  update or insert into TMP_VAR (VAR_NAME, VALUE_) values (''DYNAMIC_FORM_FIELD'', :pDYNAMIC_FORM_FIELD) matching (VAR_NAME);');
    Script.Add('end^');
    Script.Add('');
  finally
    ds1.Close;
    ds1.Free;
  end;
end;

procedure TFMain.GenFilterConfigSQL(Pk: integer; Script: TStringList; IsMain: boolean);
var
  ds1: TpFIBDataSet;

begin
  try
    ds1 := OpenSQL('select PK, NAME, REF_PK, FILTER_VALUE from DYNAMIC_FORM_FILTER_CONFIG where PK = ' + IntToStr(Pk));
    if ds1.IsEmpty then exit;

    if IsMain then Script.Add('/* DYNAMIC_FORM_FILTER_CONFIG */');
    Script.Add('execute block');
    Script.Add('as');
    Script.Add('declare variable FK integer;');
    Script.Add('declare variable PK integer;');
    Script.Add('declare variable PARAMS blob sub_type 1 segment size 80;');
    Script.Add('begin');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_REFERENCE'' into :PARAMS;');
    Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName('REF_PK').Value, false) +
      ', null) returning_values :FK;');
    Script.Add('  insert into DYNAMIC_FORM_FILTER_CONFIG (NAME, REF_PK, FILTER_VALUE) values (''' + ReplaceQuote(ds1.FieldByName('NAME').AsString) +
      ''', :FK, ' + VariantToDBStr(ReplaceQuote(ds1.FieldByName('FILTER_VALUE').AsString), true) + ') returning PK into :PK;');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_FILTER_CONFIG'' into :PARAMS;');
    Script.Add('  PARAMS = PARAMS || ''' + ds1.FieldByName('PK').AsString + ''' || '':'' || :PK || '','';');
    Script.Add('  update or insert into TMP_VAR (VAR_NAME, VALUE_) values (''DYNAMIC_FORM_FILTER_CONFIG'', :PARAMS) matching (VAR_NAME);');
    Script.Add('end^');
    Script.Add('');
  finally
    ds1.Close;
    ds1.Free;
  end;
end;

procedure TFMain.GenFilterGroupSQL(Pk: integer; Script: TStringList; IsMain: boolean);
var
  ds1: TpFIBDataSet;

begin
  try
    ds1 := OpenSQL('select PK, FORM_PK, TITLE, ORDER_, COLLAPSED, OWNER_USER_PK, CREATE_ from DYNAMIC_FORM_FILTER_GROUP where PK = ' + IntToStr(Pk));
    if ds1.IsEmpty then exit;

    if IsMain then Script.Add('/* DYNAMIC_FORM_FILTER_GROUP */');
    Script.Add('execute block');
    Script.Add('as');
    Script.Add('declare variable PK integer;');
    Script.Add('declare variable FK_FORM integer;');
    Script.Add('declare variable pDYNAMIC_FORM blob sub_type 1 segment size 80;');
    Script.Add('declare variable PARAMS blob sub_type 1 segment size 80;');
    Script.Add('begin');
    Script.Add('  pDYNAMIC_FORM = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM'' into :pDYNAMIC_FORM;');
    Script.Add('  execute procedure DICT_GET_INT (pDYNAMIC_FORM, ' + VariantToDBStr(ds1.FieldByName('FORM_PK').Value, false) +
      ', null) returning_values :FK_FORM;');
    Script.Add('  insert into DYNAMIC_FORM_FILTER_GROUP (FORM_PK, TITLE, ORDER_, COLLAPSED, OWNER_USER_PK, CREATE_, MODIFY) values (' +
      ':FK_FORM, ''' + ReplaceQuote(ds1.FieldByName('TITLE').AsString) + ''', ' + ds1.FieldByName('ORDER_').AsString + ', ''' +
      ds1.FieldByName('COLLAPSED').AsString + ''', ' + ds1.FieldByName('OWNER_USER_PK').AsString + ', ' +
      VariantToDBStr(ds1.FieldByName('CREATE_').AsString, true) + ', current_timestamp) returning PK into :PK;');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_FILTER_GROUP'' into :PARAMS;');
    Script.Add('  PARAMS = PARAMS || ''' + ds1.FieldByName('PK').AsString + ''' || '':'' || :PK || '','';');
    Script.Add('  update or insert into TMP_VAR (VAR_NAME, VALUE_) values (''DYNAMIC_FORM_FILTER_GROUP'', :PARAMS) matching (VAR_NAME);');
    Script.Add('end^');
    Script.Add('');
  finally
    ds1.Close;
    ds1.Free;
  end;
end;

procedure TFMain.GenFolderSQL(Pk: integer; Script, Folders: TStringList; IsMain: boolean);
var
  ds1: TpFIBDataSet;

begin
  // выгружаем саму папку
  try
    ds1 := OpenSQL('select PK, NAME, PARENT_FOLDER_PK from DYNAMIC_FORM_FOLDER where PK = ' + IntToStr(Pk));
    if ds1.IsEmpty then exit;

    // если первый раз и есть родительская папка - выгружаем сначала ее
    if IsMain then
    begin
      if (not ds1.FieldByName('PARENT_FOLDER_PK').IsNull) then
      begin
        GenFolderSQL(ds1.FieldByName('PARENT_FOLDER_PK').AsInteger, Script, Folders);
        //exit;
      end else Script.Add('/* DYNAMIC_FORM_FOLDER */');
    end;

    // т.к. папки выгружаются всей веткой, по каждому справочнику, они могут по нескольку раз попадать в скрипт
    if Folders.IndexOf(IntToStr(Pk)) > -1 then exit;
    Folders.Add(IntToStr(Pk));

    Script.Add('execute block');
    Script.Add('as');
    Script.Add('declare variable PK integer;');
    Script.Add('declare variable FK integer;');
    Script.Add('declare variable PARAMS blob sub_type 1 segment size 80;');
    Script.Add('begin');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_FOLDER'' into :PARAMS;');
    Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName('PARENT_FOLDER_PK').Value, false) +
      ', null) returning_values :FK;');
    Script.Add('  if (exists(select PK from DYNAMIC_FORM_FOLDER where NAME = ''' + ReplaceQuote(ds1.FieldByName('NAME').AsString) + ''' ' +
      'and PARENT_FOLDER_PK ' + iif(ds1.FieldByName('PARENT_FOLDER_PK').IsNull, 'is null', '= :FK') + ')) then');
    Script.Add('    select first 1 PK from DYNAMIC_FORM_FOLDER where NAME = ''' + ReplaceQuote(ds1.FieldByName('NAME').AsString) + ''' ' +
      'and PARENT_FOLDER_PK ' + iif(ds1.FieldByName('PARENT_FOLDER_PK').IsNull, 'is null', '= :FK') + ' into :PK;');
    Script.Add('  else');
    Script.Add('    insert into DYNAMIC_FORM_FOLDER (NAME, PARENT_FOLDER_PK) values (''' + ReplaceQuote(ds1.FieldByName('NAME').AsString) +
      ''', :FK) returning PK into :PK;');
    Script.Add('  PARAMS = PARAMS || ''' + ds1.FieldByName('PK').AsString + ''' || '':'' || :PK || '','';');
    Script.Add('  update or insert into TMP_VAR (VAR_NAME, VALUE_) values (''DYNAMIC_FORM_FOLDER'', :PARAMS) matching (VAR_NAME);');
    Script.Add('  insert into DCFG_REF_LOG (OBJ_TYPE, REF_DESCRIPTOR, ACTION_, USER_PK, ACTION_DETAIL) values (0, ''' +
      ReplaceQuote(ds1.FieldByName('NAME').AsString) + ''', 2, ' + dsPortalUserPK.AsString + ', ''PK '' || :PK);');
    Script.Add('end^');
    Script.Add('');
    ds1.Close;
    FreeAndNil(ds1);

    // теперь дочерние папки
    {ds1 := OpenSQL('select PK from DYNAMIC_FORM_FOLDER where PARENT_FOLDER_PK = ' + IntToStr(Pk) + ' order by PK');
    ds1.First;
    while not ds1.Eof do
    begin
      GenFolderSQL(ds1.FieldByName('PK').AsInteger, Script, Folders, false);
      ds1.Next;
    end;}
  finally
    if Assigned(ds1) then
    begin
      ds1.Close;
      ds1.Free;
    end;
  end;
end;

procedure TFMain.GenFormSQL(Pk: integer; Script: TStringList; IsMain: boolean; SimpleMode: boolean);
var
  ds1: TpFIBDataSet;
  ObjList: TStringList;
  i: integer;

begin
  // выгружаем форму
  try
    ds1 := OpenSQL('select PK, OWNER_USER_PK, CREATE_, TITLE, WIDTH, HEIGHT, ALIAS_FORM, LEFT_ALIGN, LABEL_WIDTH from DYNAMIC_FORM where PK = ' +
      IntToStr(Pk));
    if ds1.IsEmpty then exit;

    if SimpleMode and (not ds1.FieldByName('ALIAS_FORM').IsNull) then
    begin
      Script.Add('/* deleting form */');
      Script.Add('delete from DYNAMIC_FORM where ALIAS_FORM = ''' + ds1.FieldByName('ALIAS_FORM').AsString + '''^');
      Script.Add('commit^');
      Script.Add('');
    end;

    if IsMain then Script.Add('/* DYNAMIC_FORM */');
    Script.Add('execute block');
    Script.Add('as');
    Script.Add('declare variable PK integer;');
    Script.Add('declare variable PARAMS blob sub_type 1 segment size 80;');
    Script.Add('begin');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM'' into :PARAMS;');
    Script.Add('  insert into DYNAMIC_FORM (OWNER_USER_PK, CREATE_, TITLE, WIDTH, HEIGHT, ALIAS_FORM, LEFT_ALIGN, LABEL_WIDTH) values (' +
      VariantToDBStr(ds1.FieldByName('OWNER_USER_PK').Value, false) + ', ' + VariantToDBStr(ds1.FieldByName('CREATE_').AsString, true) + ', ''' +
      ReplaceQuote(ds1.FieldByName('TITLE').AsString) + ''', ' + VariantToDBStr(ds1.FieldByName('WIDTH').Value, false) + ', ' +
      VariantToDBStr(ds1.FieldByName('HEIGHT').Value, false) + ', ' + VariantToDBStr(ds1.FieldByName('ALIAS_FORM').Value, true) + ', ' +
      VariantToDBStr(ds1.FieldByName('LEFT_ALIGN').Value, false) + ', ' + VariantToDBStr(ds1.FieldByName('LABEL_WIDTH').Value, false) +
      ') returning PK into :PK;');
    Script.Add('  PARAMS = PARAMS || ''' + ds1.FieldByName('PK').AsString + ''' || '':'' || :PK || '','';');
    Script.Add('  update or insert into TMP_VAR (VAR_NAME, VALUE_) values (''DYNAMIC_FORM'', :PARAMS) matching (VAR_NAME);');

    if SimpleMode then
    begin
      Script.Add('  delete from DYNAMIC_FORM_FIELD where FORM_PK = :PK;');
      Script.Add('  delete from DYNAMIC_FORM_FIELD_GROUP where FORM_PK = :PK;');
      Script.Add('  delete from DYNAMIC_FORM_OBJECT_TREE where FORM_PK = :PK;');
      Script.Add('  insert into DCFG_REF_LOG (OBJ_TYPE, REF_DESCRIPTOR, ACTION_, USER_PK, ACTION_DETAIL) values (2, ''' +
        iif(ds1.FieldByName('ALIAS_FORM').IsNull, ReplaceQuote(ds1.FieldByName('TITLE').AsString), ds1.FieldByName('ALIAS_FORM').AsString) +
        ''', 2, ' + dsPortalUserPK.AsString + ', ''PK '' || :PK);');
    end;

    Script.Add('end^');
    Script.Add('');
    ds1.Close;
    FreeAndNil(ds1);

    // выгрузка связанных с формой объектов
    // объекты БД DYNAMIC_FORM_OBJECT_TREE
    ObjList := TStringList.Create;
    try
      //ds1 := OpenSQL('select PK from DYNAMIC_FORM_OBJECT_TREE where FORM_PK = ' + IntToStr(Pk) + ' order by JOIN_PARENT_PK, PK');
      ds1 := OpenSQL('select PK, JOIN_PARENT_PK from DYNAMIC_FORM_OBJECT_TREE where FORM_PK = ' + IntToStr(Pk) + ' and ' +
        '(JOIN_PARENT_PK is null or JOIN_PARENT_PK not in (select PK from DYNAMIC_FORM_OBJECT_TREE where FORM_PK = ' + IntToStr(Pk) + '))');

      ds1.First;
      while not ds1.Eof do
      begin
        GetObjectTreeList(Pk, ds1.FieldByName('JOIN_PARENT_PK').Value, ObjList);
        ds1.Next;
      end;
      ds1.Close;
      FreeAndNil(ds1);

      for i := 0 to ObjList.Count - 1 do GenObjectTreeSQL(StrToInt(ObjList.Strings[i]), Script, i = 0);
    finally
      ObjList.Free;
    end;

    // группы полей DYNAMIC_FORM_FIELD_GROUP
    ds1 := OpenSQL('select PK from DYNAMIC_FORM_FIELD_GROUP where FORM_PK = ' + IntToStr(Pk) + ' order by PK');
    ds1.First;
    while not ds1.Eof do
    begin
      GenFieldGroupSQL(ds1.FieldByName('PK').AsInteger, Script, ds1.RecNo = 1);
      ds1.Next;
    end;
    ds1.Close;
    FreeAndNil(ds1);

    // группы фильтров DYNAMIC_FORM_FILTER_GROUP
    ds1 := OpenSQL('select PK from DYNAMIC_FORM_FILTER_GROUP where FORM_PK = ' + IntToStr(Pk) + ' order by PK');
    ds1.First;
    while not ds1.Eof do
    begin
      GenFilterGroupSQL(ds1.FieldByName('PK').AsInteger, Script, ds1.RecNo = 1);
      ds1.Next;
    end;
    ds1.Close;
    FreeAndNil(ds1);

    // поля DYNAMIC_FORM_FIELD - выгружаем только в режиме выгрузки одиночной формы. В остальных случаях поля будут залиты при выгрузке справочника
    if SimpleMode then
    begin
      ds1 := OpenSQL('select PK from DYNAMIC_FORM_FIELD where FORM_PK = ' + IntToStr(Pk) + ' order by PK');
      ds1.First;
      while not ds1.Eof do
      begin
        GenFieldSQL(ds1.FieldByName('PK').AsInteger, Script, ds1.RecNo = 1);
        ds1.Next;
      end;
      ds1.Close;
      FreeAndNil(ds1);
    end;
  finally
    if Assigned(ds1) then
    begin
      ds1.Close;
      ds1.Free;
    end;
  end;
end;

procedure TFMain.GenObjectTreeSQL(Pk: integer; Script: TStringList; IsMain: boolean);
var
  ds1: TpFIBDataSet;

begin
  try
    ds1 := OpenSQL('select PK, OWNER_USER_PK, TITLE, CREATE_, NAME, OBJECT_TYPE, FORM_PK, JOIN_PARENT_PK, IS_MULTI_JOIN, JOIN_FIELDS, ' +
      'PARAMETERS, DELETED, INNER_JOIN from DYNAMIC_FORM_OBJECT_TREE where PK = ' + IntToStr(Pk));
    if ds1.IsEmpty then exit;

    if IsMain then Script.Add('/* DYNAMIC_FORM_OBJECT_TREE */');
    Script.Add('execute block');
    Script.Add('as');
    Script.Add('declare variable PK integer;');
    Script.Add('declare variable FK_FORM integer;');
    Script.Add('declare variable FK_OBJECT integer;');
    Script.Add('declare variable pDYNAMIC_FORM_OBJECT_TREE blob sub_type 1 segment size 80;');
    Script.Add('declare variable pDYNAMIC_FORM blob sub_type 1 segment size 80;');
    Script.Add('begin');
    Script.Add('  pDYNAMIC_FORM_OBJECT_TREE = '''';');
    Script.Add('  pDYNAMIC_FORM = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_OBJECT_TREE'' into :pDYNAMIC_FORM_OBJECT_TREE;');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM'' into :pDYNAMIC_FORM;');
    Script.Add('  execute procedure DICT_GET_INT (pDYNAMIC_FORM, ' + VariantToDBStr(ds1.FieldByName('FORM_PK').Value, false) +
      ', null) returning_values :FK_FORM;');
    Script.Add('  execute procedure DICT_GET_INT (pDYNAMIC_FORM_OBJECT_TREE, ' + VariantToDBStr(ds1.FieldByName('JOIN_PARENT_PK').Value, false) +
      ', null) returning_values :FK_OBJECT;');
    Script.Add('  insert into DYNAMIC_FORM_OBJECT_TREE (OWNER_USER_PK, TITLE, CREATE_, NAME, OBJECT_TYPE, FORM_PK, JOIN_PARENT_PK, ' +
      'IS_MULTI_JOIN, JOIN_FIELDS, PARAMETERS, DELETED, INNER_JOIN) values (' + ds1.FieldByName('OWNER_USER_PK').AsString + ', ' +
      VariantToDBStr(ReplaceQuote(ds1.FieldByName('TITLE').AsString), true) + ', ' + VariantToDBStr(ds1.FieldByName('CREATE_').AsString, true) +
      ', ''' + ds1.FieldByName('NAME').AsString + ''', ''' + ds1.FieldByName('OBJECT_TYPE').AsString + ''', :FK_FORM, :FK_OBJECT, ''' +
      ds1.FieldByName('IS_MULTI_JOIN').AsString + ''', ' + VariantToDBStr(ReplaceQuote(ds1.FieldByName('JOIN_FIELDS').AsString), true) + ', ' +
      VariantToDBStr(ReplaceQuote(ds1.FieldByName('PARAMETERS').AsString), true) + ', ''' + ds1.FieldByName('DELETED').AsString + ''', ' +
      VariantToDBStr(ds1.FieldByName('INNER_JOIN').Value, false) + ') returning PK into :PK;');
    Script.Add('  pDYNAMIC_FORM_OBJECT_TREE = pDYNAMIC_FORM_OBJECT_TREE || ''' + ds1.FieldByName('PK').AsString + ''' || '':'' || :PK || '','';');
    Script.Add('  update or insert into TMP_VAR (VAR_NAME, VALUE_) values (''DYNAMIC_FORM_OBJECT_TREE'', :pDYNAMIC_FORM_OBJECT_TREE) ' +
      'matching (VAR_NAME);');
    Script.Add('end^');
    Script.Add('');
  finally
    ds1.Close;
    ds1.Free;
  end;
end;

procedure TFMain.GenOtherEventSQL(Pk: integer; Script: TStringList; IsMain: boolean);
var
  ds1, ds2: TpFIBDataSet;
  refDescr, wizardDescr: string;

begin
  try
    ds1 := OpenSQL('select ID_EV, ID_DF_REFERENCE, TITLE_EV, EVENT_REFERENCE, POSITION_EV, IMAGE_NAME_EV, VIEW_TO_MENU, CLASS_NAME, IS_VIZARD, ' +
      'ALIAS_DF, LINK_METHOD from DYNAMIC_FORM_OTHER_EVENT where ID_EV = ' + IntToStr(Pk));
    if ds1.IsEmpty then exit;

    // получение refDescr
    refDescr := 'null';
    if not ds1.FieldByName('EVENT_REFERENCE').IsNull then
    begin
      ds2 := OpenSQL('select DESCRIPTOR_ from DYNAMIC_FORM_REFERENCE where PK = ' + ds1.FieldByName('EVENT_REFERENCE').AsString);
      if not ds2.IsEmpty and not ds2.FieldByName('DESCRIPTOR_').IsNull then
        refDescr := '(select PK from DYNAMIC_FORM_REFERENCE where DESCRIPTOR_ = ' + VariantToDBStr(ds2.FieldByName('DESCRIPTOR_').Value, true) + ')';
      ds2.Free;
    end;

    // получение wizardDescr
    wizardDescr := 'null';
    if not ds1.FieldByName('IS_VIZARD').IsNull then
    begin
      ds2 := OpenSQL('select DESCRIPTOR_ from WIZARD_SCENS where PK = ' + ds1.FieldByName('IS_VIZARD').AsString);
      if not ds2.IsEmpty and not ds2.FieldByName('DESCRIPTOR_').IsNull then
        wizardDescr := '(select PK from WIZARD_SCENS where DESCRIPTOR_ = ' + VariantToDBStr(ds2.FieldByName('DESCRIPTOR_').Value, true) + ')';
      ds2.Free;
    end;

    if IsMain then Script.Add('/* DYNAMIC_FORM_OTHER_EVENT */');
    Script.Add('execute block');
    Script.Add('as');
    Script.Add('declare variable FK_REF integer;');
    Script.Add('declare variable PARAMS blob sub_type 1 segment size 80;');
    Script.Add('begin');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_REFERENCE'' into :PARAMS;');
    Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName('ID_DF_REFERENCE').Value, false) + ', null) returning_values :FK_REF;');
    Script.Add('  insert into DYNAMIC_FORM_OTHER_EVENT (ID_DF_REFERENCE, TITLE_EV, EVENT_REFERENCE, POSITION_EV, IMAGE_NAME_EV, VIEW_TO_MENU, CLASS_NAME, IS_VIZARD, ' +
      'ALIAS_DF, LINK_METHOD) values (:FK_REF, ' + VariantToDBStr(ReplaceQuote(ds1.FieldByName('TITLE_EV').AsString), true) + ', ' + refDescr + ', ' +
      VariantToDBStr(ds1.FieldByName('POSITION_EV').Value, false) + ', ' + VariantToDBStr(ds1.FieldByName('IMAGE_NAME_EV').AsString, true) + ', ' +
      VariantToDBStr(ds1.FieldByName('VIEW_TO_MENU').Value, false) + ', ' + VariantToDBStr(ds1.FieldByName('CLASS_NAME').AsString, true) + ', ' +
      wizardDescr + ', ' + VariantToDBStr(ds1.FieldByName('ALIAS_DF').AsString, true) + ', ' + VariantToDBStr(ds1.FieldByName('LINK_METHOD').AsString, true) + ');');
    Script.Add('end^');
    Script.Add('');
  finally
    ds1.Close;
    ds1.Free;
  end;
end;

procedure TFMain.GenPermSQL(Pk: integer; TableName: string; Script: TStringList; IsMain: boolean);
var
  i: integer;
  ds1: TpFIBDataSet;

begin
  try
    ds1 := OpenSQL('select PK, REFERENCE_PK, ROLE_PK, ADD_, EDIT_, DEL_, VIEW_REF, CONFIG_, VIEW_, EXPORT, IMPORT, FILTRING, GRID_SAVE from ' +
      TableName + ' where PK = ' + IntToStr(Pk));
    if ds1.IsEmpty then exit;

    if IsMain then Script.Add('/* ' + TableName + ' */');
    Script.Add('execute block');
    Script.Add('as');
    Script.Add('declare variable FK_REF integer;');
    for i := 0 to 9 do Script.Add('declare variable FK' + IntToStr(i) + ' integer;');
    Script.Add('declare variable PARAMS blob sub_type 1 segment size 80;');
    Script.Add('begin');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_REFERENCE'' into :PARAMS;');
    Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName('REFERENCE_PK').Value, false) +
      ', null) returning_values :FK_REF;');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_PERM_TMP'' into :PARAMS;');

    for i := 0 to 9 do
      if (ds1.Fields.Fields[i+3].AsInteger <> 0) and (ds1.Fields.Fields[i+3].AsInteger <> 1) then
        Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.Fields.Fields[i+3].Value, false) +
          ', null) returning_values :FK' + IntToStr(i) + ';');

    Script.Add('  insert into ' + TableName + ' (REFERENCE_PK, ROLE_PK, ADD_, EDIT_, DEL_, VIEW_REF, CONFIG_, VIEW_, EXPORT, IMPORT, FILTRING, GRID_SAVE) ' +
      'values (:FK_REF, ' + VariantToDBStr(ds1.FieldByName('ROLE_PK').Value, false) + ', ' +
      iif((ds1.FieldByName('ADD_').AsInteger = 0) or (ds1.FieldByName('ADD_').AsInteger = 1), VariantToDBStr(ds1.FieldByName('ADD_').Value, false),
      ':FK0') + ', ' + iif((ds1.FieldByName('EDIT_').AsInteger = 0) or (ds1.FieldByName('EDIT_').AsInteger = 1),
      VariantToDBStr(ds1.FieldByName('EDIT_').Value, false), ':FK1') + ', ' + iif((ds1.FieldByName('DEL_').AsInteger = 0) or
      (ds1.FieldByName('DEL_').AsInteger = 1), VariantToDBStr(ds1.FieldByName('DEL_').Value, false), ':FK2') + ', ' +
      iif((ds1.FieldByName('VIEW_REF').AsInteger = 0) or (ds1.FieldByName('VIEW_REF').AsInteger = 1),
      VariantToDBStr(ds1.FieldByName('VIEW_REF').Value, false), ':FK3') + ', ' + iif((ds1.FieldByName('CONFIG_').AsInteger = 0) or
      (ds1.FieldByName('CONFIG_').AsInteger = 1), VariantToDBStr(ds1.FieldByName('CONFIG_').Value, false), ':FK4') + ', ' +
      iif((ds1.FieldByName('VIEW_').AsInteger = 0) or (ds1.FieldByName('VIEW_').AsInteger = 1),
      VariantToDBStr(ds1.FieldByName('VIEW_').Value, false), ':FK5') + ', ' + iif((ds1.FieldByName('EXPORT').AsInteger = 0) or
      (ds1.FieldByName('EXPORT').AsInteger = 1), VariantToDBStr(ds1.FieldByName('EXPORT').Value, false), ':FK6') + ', ' +
      iif((ds1.FieldByName('IMPORT').AsInteger = 0) or (ds1.FieldByName('IMPORT').AsInteger = 1),
      VariantToDBStr(ds1.FieldByName('IMPORT').Value, false), ':FK7') + ', ' + iif((ds1.FieldByName('FILTRING').AsInteger = 0) or
      (ds1.FieldByName('FILTRING').AsInteger = 1), VariantToDBStr(ds1.FieldByName('FILTRING').Value, false), ':FK8') + ', ' +
      iif((ds1.FieldByName('GRID_SAVE').AsInteger = 0) or (ds1.FieldByName('GRID_SAVE').AsInteger = 1),
      VariantToDBStr(ds1.FieldByName('GRID_SAVE').Value, false), ':FK9') + ');');
    Script.Add('end^');
    Script.Add('');
  finally
    ds1.Close;
    ds1.Free;
  end;
end;

procedure TFMain.GenPermTmpSQL(Pk: integer; Script: TStringList; IsMain: boolean);
var
  ds1: TpFIBDataSet;

begin
  try
    ds1 := OpenSQL('select PK, TEXT_TEMPLATE from DYNAMIC_FORM_PERM_TMP where PK = ' + IntToStr(Pk));
    if ds1.IsEmpty then exit;

    if IsMain then Script.Add('/* DYNAMIC_FORM_PERM_TMP */');
    Script.Add('execute block');
    Script.Add('as');
    Script.Add('declare variable PK integer;');
    Script.Add('declare variable PARAMS blob sub_type 1 segment size 80;');
    Script.Add('begin');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_PERM_TMP'' into :PARAMS;');
    Script.Add('  insert into DYNAMIC_FORM_PERM_TMP (TEXT_TEMPLATE) values (' +
      VariantToDBStr(ReplaceQuote(ds1.FieldByName('TEXT_TEMPLATE').AsString), true) + ') returning PK into :PK;');
    Script.Add('  PARAMS = PARAMS || ''' + ds1.FieldByName('PK').AsString + ''' || '':'' || :PK || '','';');
    Script.Add('  update or insert into TMP_VAR (VAR_NAME, VALUE_) values (''DYNAMIC_FORM_PERM_TMP'', :PARAMS) matching (VAR_NAME);');
    Script.Add('end^');
    Script.Add('');
  finally
    ds1.Close;
    ds1.Free;
  end;
end;

procedure TFMain.GenPostFilterSQL(Pk: integer; Script: TStringList; IsMain: boolean);
var
  ds1: TpFIBDataSet;

begin
  try
    ds1 := OpenSQL('select POST_PK, FILTER_CONFIG_PK from DYNAMIC_FROM_POST_FILTER where PK = ' + IntToStr(Pk));
    if ds1.IsEmpty then exit;

    if IsMain then Script.Add('/* DYNAMIC_FROM_POST_FILTER */');
    Script.Add('execute block');
    Script.Add('as');
    Script.Add('declare variable FK integer;');
    Script.Add('declare variable PARAMS blob sub_type 1 segment size 80;');
    Script.Add('begin');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_FILTER_CONFIG'' into :PARAMS;');
    Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName('FILTER_CONFIG_PK').Value, false) +
      ', null) returning_values :FK;');
    Script.Add('  insert into DYNAMIC_FROM_POST_FILTER (POST_PK, FILTER_CONFIG_PK) values (' +
      VariantToDBStr(ds1.FieldByName('POST_PK').Value, false) + ', :FK);');
    Script.Add('end^');
    Script.Add('');
  finally
    ds1.Close;
    ds1.Free;
  end;
end;

procedure TFMain.GenTreeIndexSQL(PkEl, PkRef: integer; Script: TStringList; IsMain: boolean);
var
  ds1: TpFIBDataSet;

begin
  try
    ds1 := OpenSQL('select ELEMENT_ID, REFERENCE_ID, LEFT_NUM, RIGHT_NUM, LVL from DYNAMIC_FORM_TREE_INDEX where ELEMENT_ID = ' + IntToStr(PkEl) +
      ' and REFERENCE_ID = ' + IntToStr(PkRef));
    if ds1.IsEmpty then exit;

    if IsMain then Script.Add('/* DYNAMIC_FORM_TREE_INDEX */');
    Script.Add('execute block');
    Script.Add('as');
    Script.Add('declare variable FK integer;');
    Script.Add('declare variable PARAMS blob sub_type 1 segment size 80;');
    Script.Add('begin');
    Script.Add('  PARAMS = '''';');
    Script.Add('  select VALUE_ from TMP_VAR where VAR_NAME = ''DYNAMIC_FORM_REFERENCE'' into :PARAMS;');
    Script.Add('  execute procedure DICT_GET_INT (PARAMS, ' + VariantToDBStr(ds1.FieldByName('REFERENCE_ID').Value, false) +
      ', null) returning_values :FK;');
    Script.Add('  insert into DYNAMIC_FORM_TREE_INDEX (ELEMENT_ID, REFERENCE_ID, LEFT_NUM, RIGHT_NUM, LVL) values (' +
      ds1.FieldByName('ELEMENT_ID').AsString + ', :FK, ' + VariantToDBStr(ds1.FieldByName('LEFT_NUM').Value, false) + ', ' +
      VariantToDBStr(ds1.FieldByName('RIGHT_NUM').Value, false) + ', ' + VariantToDBStr(ds1.FieldByName('LVL').Value, false) + ');');
    Script.Add('end^');
    Script.Add('');
  finally
    ds1.Close;
    ds1.Free;
  end;
end;

procedure TFMain.GenWizardOnDictSQL(RefPk: integer; Script, Wizards: TStringList);
var
  ds1: TpFIBDataSet;

begin
  try
    // все сценарии переданного справочника (пока только те, что навешаны на сам справочник, но если надо будет, добавлю те, в которых задействованы формы справочника)
    ds1 := OpenSQL('select TYPE_, PK from (' +
      'select 0 TYPE_, PK from WIZARD_SCENS where REF_PK = :REF_PK ' +
      '/*union select 1 TYPE_, s.PK from WIZARD_SATES st ' +
      'join WIZARD_SCENS s on s.PK = st.SCEN_PK ' +
      'join DYNAMIC_FORM_REFERENCE r on r.MAIN_FORM_PK = st.FORM_PK ' +
      'where r.PK = :REF_PK*/) order by TYPE_, PK', 'REF_PK=' + IntToStr(RefPk));

    ds1.First;
    while not ds1.Eof do
    begin
      if Wizards.IndexOf(ds1.FieldByName('PK').AsString) = -1 then
      begin
        Wizards.Add(ds1.FieldByName('PK').AsString);
        GenWizardSQL(ds1.FieldByName('PK').AsInteger, Script);
      end;
      ds1.Next;
    end;
    ds1.Close;
    ds1.Free;

    // а теперь пройдемся по дочерним справочникам
    ds1 := OpenSQL('select PK from DYNAMIC_FORM_REFERENCE where PARENT_REFERENCE_PK = ' + IntToStr(RefPk) + ' order by PK');
    ds1.First;
    while not ds1.Eof do
    begin
      GenWizardOnDictSQL(ds1.FieldByName('PK').AsInteger, Script, Wizards);
      ds1.Next;
    end;
  finally
    if Assigned(ds1) then
    begin
      ds1.Close;
      ds1.Free;
    end;
  end;
end;

procedure TFMain.GenWizardSlotSQL(Pk: integer; Script: TStringList; IsScen: boolean; IsMain: boolean);
var
  ds1, ds2: TpFIBDataSet;
  state, scen: string;
  
begin
  try
    if IsScen then
    begin
      ds1 := OpenSQL('select ws.PK, ws.SATE_PK, ws.NAME, ws.SLOT_TYPE, ws.MAIN_SLOT, ws.SCEN_PK, wsc.DESCRIPTOR_ from WIZARD_SATES_SLOTS ws ' +
        'join WIZARD_SCENS wsc on ws.SCEN_PK = wsc.PK where ws.PK = ' + IntToStr(Pk));
      if ds1.IsEmpty then exit;

      Script.Add('/* WIZARD_SATES_SLOTS, слоты сценария */');

      state := 'null';
      scen := '(select PK from WIZARD_SCENS where DESCRIPTOR_ = ''' + ds1.FieldByName('DESCRIPTOR_').AsString + ''')';
    end else
    begin
      // слоты состояний
      ds1 := OpenSQL('select PK, SATE_PK, NAME, SLOT_TYPE, MAIN_SLOT, SCEN_PK from WIZARD_SATES_SLOTS where PK = ' + IntToStr(Pk));
      if ds1.IsEmpty then exit;

      Script.Add('/* WIZARD_SATES_SLOTS, слоты состояний */');

      state := '(select NEW_PK from TMP_WIZARD_VAR where TABLE_NAME = ''WIZARD_SATES'' and OLD_PK = ' + ds1.FieldByName('SATE_PK').AsString + ')';
      scen := 'null';
    end;

    Script.Add('execute block');
    Script.Add('as');
    Script.Add('declare variable PK integer;');
    Script.Add('begin');
    Script.Add('  insert into WIZARD_SATES_SLOTS (SATE_PK, NAME, SLOT_TYPE, MAIN_SLOT, SCEN_PK) values (' + state + ', ' +
      VariantToDBStr(ReplaceQuote(ds1.FieldByName('NAME').AsString), true) + ', ' + VariantToDBStr(ds1.FieldByName('SLOT_TYPE').Value, true) +
      ', ' + VariantToDBStr(ds1.FieldByName('MAIN_SLOT').Value, false) + ', ' + scen + ') returning PK into :PK;');
    Script.Add('  update or insert into TMP_WIZARD_VAR (TABLE_NAME, OLD_PK, NEW_PK) values (''WIZARD_SATES_SLOTS'', ' +
      ds1.FieldByName('PK').AsString + ', :PK) matching (TABLE_NAME, OLD_PK);');

    // WIZARD_SC_SLOT_VAL
    ds2 := OpenSQL('select PK, SLOT_PK, CROSS_PK, SLOT_VALUE from WIZARD_SC_SLOT_VAL where SLOT_PK = ' + IntToStr(Pk));
    ds2.First;
    while not ds2.Eof do
    begin
      Script.Add('');
      Script.Add('  /* WIZARD_SC_SLOT_VAL */');
      Script.Add('  insert into WIZARD_SC_SLOT_VAL (SLOT_PK, CROSS_PK, SLOT_VALUE) values (:PK, ' +
        iif(ds2.FieldByName('CROSS_PK').IsNull, 'null', '(select NEW_PK from TMP_WIZARD_VAR where TABLE_NAME = ''WIZARD_SATES_CROSS'' and OLD_PK = ' +
        ds2.FieldByName('CROSS_PK').AsString + ')') + ', ' + VariantToDBStr(ReplaceQuote(ds2.FieldByName('SLOT_VALUE').AsString), true) + ');');

      ds2.Next;
    end;

    Script.Add('end^');
    Script.Add('');
  finally
    ds1.Close;
    ds1.Free;
    ds2.Close;
    ds2.Free;
  end;
end;

procedure TFMain.GenWizardSQL(Pk: integer; Script: TStringList);
var
  ds1, ds2, ds3: TpFIBDataSet;

begin
  try
    ds1 := OpenSQL('select s.PK, s.NAME, s.SCEN_TYPE, s.REF_PK, s.DESCRIPTOR_, s.NO_MES, r.DESCRIPTOR_ REF_DESCR from WIZARD_SCENS s ' +
      'join DYNAMIC_FORM_REFERENCE r on r.PK = s.REF_PK where s.PK = ' + IntToStr(Pk));
    if ds1.IsEmpty then exit;

    if not ds1.FieldByName('DESCRIPTOR_').IsNull then
    begin
      Script.Add('/* deleteing wizard */');
      Script.Add('delete from WIZARD_SCENS where DESCRIPTOR_ = ''' + ds1.FieldByName('DESCRIPTOR_').AsString + '''^');
      Script.Add('commit^');
      Script.Add('');
    end else
    begin
      Application.MessageBox(pchar('Сценарий "' + ds1.FieldByName('NAME').AsString + '" (PK '+ ds1.FieldByName('PK').AsString + ') ' +
        'имеет пустое поле DESCRIPTOR_! Сгенерить корректный скрипт для него невозможно.'), 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;

    Script.Add('/* WIZARD_SCENS */');

    // WIZARD_SCENS
    Script.Add('insert into WIZARD_SCENS (NAME, SCEN_TYPE, REF_PK, DESCRIPTOR_, NO_MES) values (' +
      VariantToDBStr(ReplaceQuote(ds1.FieldByName('NAME').AsString), true) + ', ' + VariantToDBStr(ds1.FieldByName('SCEN_TYPE').Value, true) +
      ', (select PK from DYNAMIC_FORM_REFERENCE where DESCRIPTOR_ = ''' + ds1.FieldByName('REF_DESCR').AsString + '''), ' +
      VariantToDBStr(ds1.FieldByName('DESCRIPTOR_').Value, true) + ', ' + VariantToDBStr(ds1.FieldByName('NO_MES').Value, true) + ')^');
      Script.Add('insert into DCFG_REF_LOG (OBJ_TYPE, REF_DESCRIPTOR, ACTION_, USER_PK) values (3, ' +
        VariantToDBStr(ds1.FieldByName('DESCRIPTOR_').Value, true) + ', 2, ' + dsPortalUserPK.AsString + ')^');
    Script.Add('');

    // WIZARD_SATES
    ds2 := OpenSQL('select PK from WIZARD_SATES where SCEN_PK = ' + ds1.FieldByName('PK').AsString);
    ds2.First;
    while not ds2.Eof do
    begin
      GenWizardStateSQL(ds2.FieldByName('PK').AsInteger, Script, ds2.RecNo = 1);
      ds2.Next;
    end;

    // WIZARD_SATES_CROSS
    ds2.First;
    while not(ds2.Eof) do
    begin
      GenWizardStateCrossSQL(ds2.FieldByName('PK').AsInteger, Script);
      ds2.Next;
    end;

    // WIZARD_SATES_SLOTS, слоты состояний
    ds2.First;
    while not(ds2.Eof) do
    begin
      ds3 := OpenSQL('select PK from WIZARD_SATES_SLOTS where SATE_PK = ' + ds2.FieldByName('PK').AsString);
      ds3.First;
      while not(ds3.Eof) do
      begin
        GenWizardSlotSQL(ds3.FieldByName('PK').AsInteger, Script, false, ds3.RecNo = 1);
        ds3.Next;
      end;
      ds3.Close;
      FreeAndNil(ds3);

      ds2.Next;
    end;
    ds2.Close;
    FreeAndNil(ds2);

    // WIZARD_SATES_SLOTS, слоты сценария
    ds2 := OpenSQL('select PK from WIZARD_SATES_SLOTS where SCEN_PK = ' + ds1.FieldByName('PK').AsString);
    ds2.First;
    while not ds2.Eof do
    begin
      GenWizardSlotSQL(ds2.FieldByName('PK').AsInteger, Script, true, ds2.RecNo = 1);
      ds2.Next;
    end;
  finally
    if Assigned(ds1) then
    begin
      ds1.Close;
      ds1.Free;
    end;
    if Assigned(ds2) then
    begin
      ds2.Close;
      ds2.Free;
    end;
    if Assigned(ds3) then
    begin
      ds3.Close;
      ds3.Free;
    end;
  end;
end;

procedure TFMain.GenWizardStateCrossSQL(Pk: integer; Script: TStringList);
var
  ds1: TpFIBDataSet;
  s: string;

begin
  try
    ds1 := OpenSQL('select PK, PK_PREW, PK_NEXT, NAME, ADD_BUTTON, BUTTON_ORDER, NEED_CLOSE, SHOW_IN_VIEW, HOT_KEY ' +
      'from WIZARD_SATES_CROSS where PK_PREW = ' + IntToStr(Pk));
    if ds1.IsEmpty then exit;

    Script.Add('/* WIZARD_SATES_CROSS */');

    ds1.First;
    while not ds1.Eof do
    begin
      if ds1.FieldByName('PK_NEXT').IsNull then s := 'null'
      else if ds1.FieldByName('PK_NEXT').AsInteger = 0 then s := ds1.FieldByName('PK_NEXT').AsString
      else s := '(select NEW_PK from TMP_WIZARD_VAR where TABLE_NAME = ''WIZARD_SATES'' and OLD_PK = ' + ds1.FieldByName('PK_NEXT').AsString + ')';

      Script.Add('execute block');
      Script.Add('as');
      Script.Add('declare variable PK integer;');
      Script.Add('begin');
      Script.Add('  insert into WIZARD_SATES_CROSS (PK_PREW, PK_NEXT, NAME, ADD_BUTTON, BUTTON_ORDER, NEED_CLOSE, SHOW_IN_VIEW, HOT_KEY) ' +
        'values ((select NEW_PK from TMP_WIZARD_VAR where TABLE_NAME = ''WIZARD_SATES'' and OLD_PK = ' + ds1.FieldByName('PK_PREW').AsString +
        '), ' + s + ', ' + VariantToDBStr(ReplaceQuote(ds1.FieldByName('NAME').AsString), true) + ', ' +
        VariantToDBStr(ds1.FieldByName('ADD_BUTTON').Value, false) + ', ' + VariantToDBStr(ds1.FieldByName('BUTTON_ORDER').Value, false) + ', ' +
        VariantToDBStr(ds1.FieldByName('NEED_CLOSE').Value, false) + ', ' + VariantToDBStr(ds1.FieldByName('SHOW_IN_VIEW').Value, false) + ', ' +
        VariantToDBStr(ReplaceQuote(ds1.FieldByName('HOT_KEY').AsString), true) + ') returning PK into :PK;');
      Script.Add('  update or insert into TMP_WIZARD_VAR (TABLE_NAME, OLD_PK, NEW_PK) values (''WIZARD_SATES_CROSS'', ' +
        ds1.FieldByName('PK').AsString + ', :PK) matching (TABLE_NAME, OLD_PK);');
      Script.Add('end^');
      Script.Add('');

      ds1.Next;
    end;
  finally
    ds1.Close;
    ds1.Free;
  end;
end;

procedure TFMain.GenWizardStateSQL(Pk: integer; Script: TStringList; IsMain: boolean);
var
  ds1: TpFIBDataSet;
  formSql: string;
    
begin
  try
    ds1 := OpenSQL('select st.PK, st.SCEN_PK, st.FORM_PK, f.ALIAS_FORM, f.TITLE, st.FIELD_JSON, st.ACTION_, st.DESCRIPTOR_, ' +
      'st.FULL_SCREEN, st.MAY_DOUBLE, s.DESCRIPTOR_ SCEN_DESCR, r.DESCRIPTOR_ REF_DESCR from WIZARD_SATES st ' +
      'join WIZARD_SCENS s on s.PK = st.SCEN_PK ' +
      'left join DYNAMIC_FORM_REFERENCE r on r.MAIN_FORM_PK = st.FORM_PK ' +
      'left join DYNAMIC_FORM f on f.PK = st.FORM_PK where st.PK = ' + IntToStr(Pk));
    if ds1.IsEmpty then exit;

    if ds1.FieldByName('REF_DESCR').IsNull then
    begin
      formSql := '(select PK from DYNAMIC_FORM where ALIAS_FORM = ''' + ds1.FieldByName('ALIAS_FORM').AsString + ''')';

      // тут надо предупредить, если алиас формы отсутсвует
      if ds1.FieldByName('ALIAS_FORM').AsString = '' then
      begin
        Application.MessageBox(pchar('Форма состояния "' + ds1.FieldByName('TITLE').AsString + '" (PK '+ ds1.FieldByName('PK').AsString + ') ' +
          'не привязана к справочнику и имеет пустое поле ALIAS_FORM! Состояние выгружено без привязки к форме, т.к. определить форму невозможно.'),
          'Предупреждение', MB_OK + MB_ICONWARNING);
      end;
    end else
      formSql := '(select MAIN_FORM_PK from DYNAMIC_FORM_REFERENCE where DESCRIPTOR_ = ''' + ds1.FieldByName('REF_DESCR').AsString + ''')';

    if IsMain then Script.Add('/* WIZARD_SATES */');
    Script.Add('execute block');
    Script.Add('as');
    Script.Add('declare variable PK integer;');
    Script.Add('begin');
    Script.Add('  insert into WIZARD_SATES (SCEN_PK, FORM_PK, FIELD_JSON, ACTION_, DESCRIPTOR_, FULL_SCREEN, MAY_DOUBLE) values (' +
      '(select PK from WIZARD_SCENS where DESCRIPTOR_ = ''' + ds1.FieldByName('SCEN_DESCR').AsString + '''), ' + formSql + ', ' +
      VariantToDBStr(ReplaceQuote(ds1.FieldByName('FIELD_JSON').AsString), true) + ', ' + VariantToDBStr(ds1.FieldByName('ACTION_').Value, true) +
      ', ' + VariantToDBStr(ds1.FieldByName('DESCRIPTOR_').Value, true) + ', ' + VariantToDBStr(ds1.FieldByName('FULL_SCREEN').Value, false) +
      ', ' + VariantToDBStr(ds1.FieldByName('MAY_DOUBLE').Value, false) + ') returning PK into :PK;');
    Script.Add('  update or insert into TMP_WIZARD_VAR (TABLE_NAME, OLD_PK, NEW_PK) values (''WIZARD_SATES'', ' + ds1.FieldByName('PK').AsString +
      ', :PK) matching (TABLE_NAME, OLD_PK);');
    Script.Add('end^');
    Script.Add('');
  finally
    ds1.Close;
    ds1.Free;
  end;
end;

procedure TFMain.GenWizardStatesSQL(Pk: integer; StatesPk: string; Script: TStringList);
var
  ds1, ds2: TpFIBDataSet;

begin
  // выгрузка отдельных состояний сценария
  if Trim(StatesPk) = '' then exit;
  
  try
    // WIZARD_SATES
    ds1 := OpenSQL('select st.PK, s.DESCRIPTOR_, s.NAME from WIZARD_SATES st join WIZARD_SCENS s on s.PK = st.SCEN_PK where st.SCEN_PK = ' +
      IntToStr(Pk) + ' and st.PK in (' + StatesPk + ')');
      
    ds1.First;
    if ds1.FieldByName('DESCRIPTOR_').IsNull then
    begin
      Application.MessageBox(pchar('Сценарий "' + ds1.FieldByName('NAME').AsString + '" (PK '+ ds1.FieldByName('PK').AsString + ') ' +
        'имеет пустое поле DESCRIPTOR_! Сгенерить корректный скрипт для него невозможно.'), 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;

    Script.Add('insert into DCFG_REF_LOG (OBJ_TYPE, REF_DESCRIPTOR, ACTION_, USER_PK) values (3, ' +
        VariantToDBStr(ds1.FieldByName('DESCRIPTOR_').Value, true) + ', 2, ' + dsPortalUserPK.AsString + ')^');
    Script.Add('');
    
    while not ds1.Eof do
    begin
      GenWizardStateSQL(ds1.FieldByName('PK').AsInteger, Script, ds1.RecNo = 1);
      ds1.Next;
    end;

    // WIZARD_SATES_CROSS
    ds1.First;
    while not(ds1.Eof) do
    begin
      GenWizardStateCrossSQL(ds1.FieldByName('PK').AsInteger, Script);
      ds1.Next;
    end;

    // WIZARD_SATES_SLOTS, слоты состояний
    ds1.First;
    while not(ds1.Eof) do
    begin
      ds2 := OpenSQL('select PK from WIZARD_SATES_SLOTS where SATE_PK = ' + ds1.FieldByName('PK').AsString);
      ds2.First;
      while not(ds2.Eof) do
      begin
        GenWizardSlotSQL(ds2.FieldByName('PK').AsInteger, Script, false, ds2.RecNo = 1);
        ds2.Next;
      end;
      ds2.Close;
      FreeAndNil(ds2);

      ds1.Next;
    end;
    ds1.Close;
    FreeAndNil(ds1);
  finally
    if Assigned(ds1) then
    begin
      ds1.Close;
      ds1.Free;
    end;
    if Assigned(ds2) then
    begin
      ds2.Close;
      ds2.Free;
    end;
  end;
end;

function TFMain.GetCheckedFormIndex: integer;
begin
  if Assigned(WindowBar.SelectedTab) then
    result := WindowBar.SelectedTab.Tag
  else
    result := -1;
end;

function TFMain.GetChildCount: integer;
begin
  result := OpenedFormCount;
end;

procedure TFMain.GetChildRefList(ParentPk: integer; RefList: TStringList);
var
  ds: TpFIBDataSet;
  
begin
  if VarIsNull(ParentPk) then exit;

  try
    try
      ds := OpenSQL('select PK from DYNAMIC_FORM_REFERENCE where PARENT_REFERENCE_PK = ' + VarToStr(ParentPk));
      ds.First;
      while not ds.Eof do
      begin
        RefList.Add(ds.FieldByName('PK').AsString);
        GetChildRefList(ds.FieldByName('PK').Value, RefList);
        ds.Next;
      end;
    except
    end;
  finally
    if Assigned(ds) then
    begin
      ds.Close;
      ds.Free;
    end;
  end;
end;

function TFMain.GetCurrentTreeView: TJvTreeView;
begin
  if pcDictTree.ActivePage = tsOnFolder then result := tvMain
  else if pcDictTree.ActivePage = tsOnlyDict then result := tvDict
  else if pcDictTree.ActivePage = tsForm then result := tvForm
  else if pcDictTree.ActivePage = tsWizard then result := tvWizard
  else if pcDictTree.ActivePage = tsHistory then result := tvHistory
  else result := nil;
end;

function TFMain.GetHistoryParent(HistType: THistoryType): TTreeNode;
begin
  result := tvHistory.Items.GetFirstNode;
  while Assigned(result) and Assigned(result.Data) do
  begin
    if ((TNodeDictInfo(result.Data).Descriptor = '$LIKED') and (HistType = htLiked)) or
      ((TNodeDictInfo(result.Data).Descriptor = '$HISTORY') and (HistType = htHistory)) then
      break
    else
      result := result.getNextSibling;
  end;
end;

function TFMain.GetMenuIndex(FormIndex: integer): integer;
var
  i: integer;

begin
  result := -1;
  for i := 0 to miWindow.Count - 1 do
    if (Pos('miWindow', miWindow.Items[i].Name) > 0) and (miWindow.Items[i].Tag = FormIndex) then
    begin
      result := i;
      break;
    end;
end;

procedure TFMain.GetObjectTreeList(FormPk: integer; ParentPk: Variant; ObjectList: TStringList);
var
  ds: TpFIBDataSet;
  jpk: string;
  
begin
  try
    if VarIsNull(ParentPk) then jpk := 'is null'
    else jpk := '= ' + VarToStr(ParentPk);
    ds := OpenSQL('select PK from DYNAMIC_FORM_OBJECT_TREE where FORM_PK = ' + IntToStr(FormPk) + ' and JOIN_PARENT_PK ' + jpk + ' order by PK');
    ds.First;
    while not ds.Eof do
    begin
      ObjectList.Add(ds.FieldByName('PK').AsString);
      GetObjectTreeList(FormPk, ds.FieldByName('PK').AsVariant, ObjectList);
      ds.Next;
    end;
  finally
    ds.Close;
    ds.Free;
  end;
end;

function TFMain.GetRefLink(DictInfo: TNodeDictInfo): string;
var
  url: string;

begin
  // пример ссылки, тут с позиционированием на конкретную запись:
  // https://rao.corp.tander.ru/#referenceDescriptor=GM_RP_REGISTER&whereParams={"fields":[{"name":"GM_RP_REGISTER.PK","value":" =${pack[''PK'']}","bound":" AND ","caseSens":false,"innerBound":[]}]}&refTitle=Рационализаторские предложения КРС ГМ

  result := '';
  url := Trim(FSettings.GetCurrentConnection.PortalUrl);
  if url = '' then exit;
  if LowerCase(Copy(url, 1, 4)) <> 'http' then url := 'https://' + url;
  if url[Length(url)] <> '/' then url := url + '/';
  result := Format('%s#referenceDescriptor=%s&refTitle=%s', [url, VarToStr(DictInfo.Descriptor), VarToStr(DictInfo.Title)]);
end;

function TFMain.GetTreeView(Page: TTabSheet): TJvTreeView;
begin
  if Page = tsOnFolder then result := tvMain
  else if Page = tsOnlyDict then result := tvDict
  else if Page = tsForm then result := tvForm
  else if Page = tsWizard then result := tvWizard
  else if Page = tsHistory then result := tvHistory
  else result := nil;
end;

function TFMain.GetUpdateInfoDB(FromVer: string): TUpdateInfo;
begin
  Result.IsEmpty := true;
  ConnectToUpdate;
  dsGetUpdate.Close;
  dsGetUpdate.ParamByName('VERSTR').AsString := FromVer;
  dsGetUpdate.Open;

  if not dsGetUpdate.IsEmpty then
  begin
    Result.IsEmpty := false;
    result.FileName := dsGetUpdateFILE_NAME.AsString;
    result.Version := dsGetUpdateVERSTR.AsString;
    result.Date := dsGetUpdateDATE_UPDATE.AsDateTime;
    result.FileSize := dsGetUpdateFILE_SIZE.AsInteger;
    result.MD5 := dsGetUpdateMD5.AsString;
    result.Description := dsGetUpdateDESCR.AsString;
  end;
end;

function TFMain.GetUpdateInfoNet: TUpdateInfo;
var
  updPath, cfgFn, err: string;
  ftp_host, ftp_dir, ftp_temp: string;
  NetCanClose: boolean;
  i: integer;
  sr: TSearchRec;
  si: integer;
  sl: TStringList;
  updIni: TIniFile;

begin
  Result.IsEmpty := true;
  updPath := FSettings.UpdatePath;

  if Trim(updPath) = '' then raise Exception.Create('Не задан путь поиска обновлений!');
  if updPath[Length(updPath)] <> '\' then updPath := updPath + '\';

  if (Length(updPath) > 1) and (updPath[1] = '\') and (updPath[2] = '\') then
  begin
    // это сеть - пробуем залезть в сеть...
    si := FindFirst(updPath + '*', faAnyFile, sr);
    if si <> 0 then
    begin
      // если не получилось, надо открывать коннект
      NetCanClose := NetCompConnect(updPath, FSettings.NetUser, FSettings.NetPass, false, err);
      if not NetCanClose then raise Exception.Create('Не удалось подключиться к сети! Ошибка: ' + err);
    end else
      FindClose(sr);
  end else
  if Pos(LowerCase('ftp://'), updPath) > 0 then
  begin
    // это ftp-шник, коннектимся и закачиваем все содержимое во временную папку
    ftp_temp := GetTempDir + '\DictConfigurator\';
    ftp_dir := '';
    ftp_host := StringReplace(updPath, 'ftp://', '', [rfIgnoreCase]);
    i := Pos('/', ftp_host);
    if i <= 0 then i := Pos('\', ftp_host);
    if i > 0 then
    begin
      ftp_dir := Copy(ftp_host, i + 1, Length(ftp_host));
      ftp_host := Copy(ftp_host, 1, i - 1);
    end;

    DeleteDir(ftp_temp, err);
    ForceDirectories(ftp_temp);

    if FTPClient.Connected then FTPClient.Disconnect;
    FTPClient.Host := ftp_host;
    FTPClient.Username := FSettings.NetUser;
    FTPClient.Password := FSettings.NetPass;
    try
      sl := TStringList.Create;
      try
        FTPClient.Connect;
        FTPClient.ChangeDir(ftp_dir);
        FTPClient.List(sl, '', false);
        for i := 0 to sl.Count - 1 do
          FTPClient.Get(sl.Strings[i], ftp_temp + sl.Strings[i], true);
      except
        on e: Exception do
          raise Exception.Create('Ошибка ftp-сервера ' + ftp_host + ': ' + e.Message);
      end;
      updPath := ftp_temp;
    finally
      sl.Free;
      if FTPClient.Connected then FTPClient.Disconnect;
    end;
  end;

  cfgFn := updPath + 'update.ini';
  if (not FileExists(cfgFn)) then
    raise Exception.Create('Задан неверный путь поиска обновлений: "' + FSettings.UpdatePath + '"!');

  updIni := TIniFile.Create(cfgFn);
  try
    sl := TStringList.Create;
    if (not updIni.SectionExists('MAIN')) or (not updIni.SectionExists('FILES')) or
      (updIni.ReadString('MAIN', 'CS', '') <> UPDATESKEY) then
      raise Exception.Create('Задан неверный путь поиска обновлений: "' + FSettings.UpdatePath + '"!');

    Result.IsEmpty := false;
    result.FileName := updIni.ReadString('FILES', 'Executable', '');
    result.SourceFile := updPath + result.FileName;
    result.Version := updIni.ReadString('MAIN', 'Version', '0.0.0.0');
    result.Date := StrToDateTime(updIni.ReadString('MAIN', 'Date', '01.01.1900'));
    result.FileSize := updIni.ReadInteger('MAIN', 'FileSize', 0);
    result.MD5 := updIni.ReadString('MAIN', 'MD5', '');

    updIni.ReadSection('DESCR', sl);
    for i := 0 to sl.Count - 1 do
      if i = 0 then result.Description := updIni.ReadString('DESCR', sl.Strings[i], '')
      else result.Description := result.Description + #13#10 + updIni.ReadString('DESCR', sl.Strings[i], '');
  finally
    sl.Free;
    updIni.Free;
  end;
end;

function TFMain.GetButtonIndex(FormIndex: integer): integer;
var
  i: integer;

begin
  result := -1;
  for i := 0 to WindowBar.Tabs.Count - 1 do
    if WindowBar.Tabs.Items[i].Tag = FormIndex then
    begin
      result := i;
      break;
    end;
end;

procedure TFMain.LoadChildNodes(TreeView: TJvTreeView; Parent: TTreeNode);
begin
  dsTreeFolder.Close;
  dsTreeDict.Close;
  if (not Assigned(Parent.Data)) then exit;

  if TNodeDictInfo(Parent.Data).ObjType = cotFolder then
  begin
    // если это папка - грузим подпапки, потом грузим справочники этой папки
    dsTreeFolder.ParamByName('PARENT_FOLDER_PK').Value := TNodeDictInfo(Parent.Data).PK;
    dsTreeFolder.Open;
    AddSubnodesDict(TreeView, true, Parent, dsTreeFolder, 0, true);
    dsTreeFolder.Close;

    dsTreeDict.ParamByName('BYFOLDER').Value := 1;
    dsTreeDict.ParamByName('FOLDER_PK').Value := TNodeDictInfo(Parent.Data).PK;
    dsTreeDict.ParamByName('PARENT_REFERENCE_PK').Clear;
    dsTreeDict.Open;
    AddSubnodesDict(TreeView, true, Parent, dsTreeDict, 1, false);
    dsTreeDict.Close;
  end else if TNodeDictInfo(Parent.Data).ObjType = cotLikedFolder then
  begin
    // это папка истории - надо загрузить вложенные в нее объекты
    LoadHistoryItems(Parent, htLiked, TNodeDictInfo(Parent.Data).PK, 'OBJ_NAME nulls last');
  end else
  begin
    // если это справочник - грузим только его дочерние справочники
    dsTreeDict.ParamByName('BYFOLDER').Value := 0;
    dsTreeDict.ParamByName('FOLDER_PK').Clear;
    dsTreeDict.ParamByName('PARENT_REFERENCE_PK').Value := TNodeDictInfo(Parent.Data).PK;
    dsTreeDict.Open;
    AddSubnodesDict(TreeView, true, Parent, dsTreeDict, 1, false);
    dsTreeDict.Close;
  end;
end;

procedure TFMain.LoadChildNodes2(TreeView: TJvTreeView; Parent: TTreeNode);
begin
  dsTreeDict2.Close;
  if (not Assigned(Parent.Data)) then exit;

  // грузим дочерние справочники
  dsTreeDict2.ParamByName('PARENT_REFERENCE_PK').Value := TNodeDictInfo(Parent.Data).PK;
  dsTreeDict2.Open;
  AddSubnodesDict(TreeView, true, Parent, dsTreeDict2, 1, false);
  dsTreeDict2.Close;
end;

procedure TFMain.LoadHistory(TreeView: TJvTreeView);
var
  i, img: integer;
  ht: THistoryType;
  n: TTreeNode;
  title, {sql, err,} order, code: string;
  //ds: TpFIBDataSet;
  obj: TNodeDictInfo;

begin
  for i := 0 to 1 do
  begin
    ht := THistoryType(i);

    if dsTreeHistory.Active then dsTreeHistory.Close;

    if ht = htLiked then
    begin
      code := '$LIKED';
      title := 'Избранное';
      img := 8;
      order := 'OBJ_NAME nulls last';
    end else
    begin
      code := '$HISTORY';
      title := 'История';
      img := 9;
      order := 'LASTDATE desc';
    end;

    n := TreeView.Items.Add(nil, title);
    n.ImageIndex := img;
    n.SelectedIndex := img;
    obj := AssignNodeData(cotNone);
    obj.Descriptor := code;
    n.Data := pointer(obj);

    LoadHistoryItems(n, ht, Null, order);
    if ht = htLiked then n.Expand(false);
  end;
end;

procedure TFMain.LoadHistoryItems(Node: TTreeNode; HistType: THistoryType; ParentPk: Variant; Order: string);
var
  sql, err: string;
  ds: TpFIBDataSet;
  
begin
  dsTreeHistory.SQLs.SelectSQL.Text := 'select OBJ_PK, OBJ_TYPE, TYPE_, USER_PK, LASTDATE, OBJ_NAME from DCFG_HISTORY ' +
    'where USER_PK = :USER_PK and TYPE_ = :TYPE and PARENT_PK = :PARENT_PK order by ' + Order;

  dsTreeHistory.ParamByName('PARENT_PK').Value := ParentPk;
  dsTreeHistory.ParamByName('USER_PK').Value := dsPortalUserPK.AsVariant;
  dsTreeHistory.ParamByName('TYPE').Value := Ord(HistType);

  try
    dsTreeHistory.Open;
    dsTreeHistory.First;
    while not dsTreeHistory.Eof do
    begin
      try
        case TConfObjectType(dsTreeHistoryOBJ_TYPE.AsInteger) of
          cotFolder: sql := 'select PK, NAME, NAME TITLE, PARENT_FOLDER_PK from DYNAMIC_FORM_FOLDER where PK = :PK';
          cotDict: sql := 'select r.PK, r.DESCRIPTOR_, r.TITLE, r.TITLE ||  '' ['' || r.DESCRIPTOR_ || '']'' NAME, ' +
            'r.PARENT_REFERENCE_PK, r.FOLDER_PK, u.LOGIN from DYNAMIC_FORM_REFERENCE r ' +
            'left join USERS u on u.PK = r.OWNER_USER_PK ' +
            'where r.PK = :PK';
          cotForm: sql := 'select f.PK, f.TITLE, f.ALIAS_FORM, u.LOGIN, ' +
            '(case when f.ALIAS_FORM is null then f.TITLE else f.TITLE ||  '' ['' || f.ALIAS_FORM || '']'' end) NAME ' +
            'from DYNAMIC_FORM f ' +
            'left join USERS u on u.PK = f.OWNER_USER_PK ' +
            'where f.PK = :PK';
          cotWizard: sql := 'select w.PK, w.NAME, w.SCEN_TYPE, w.DESCRIPTOR_, w.REF_PK, u.LOGIN, ' +
            '(case when w.DESCRIPTOR_ is null then w.NAME else w.NAME ||  '' ['' || w.DESCRIPTOR_ || '']'' end) TITLE ' +
            'from WIZARD_SCENS w ' +
            'join DYNAMIC_FORM_REFERENCE r on r.PK = w.REF_PK ' +
            'left join USERS u on u.PK = r.OWNER_USER_PK ' +
            'where w.PK = :PK';
          cotLikedFolder: sql := 'select OBJ_PK PK, OBJ_TYPE, TYPE_, USER_PK, LASTDATE, OBJ_NAME from DCFG_HISTORY ' +
            'where OBJ_PK = :PK and OBJ_TYPE = ' + IntToStr(Ord(cotLikedFolder)) + ' and TYPE_ = ' + IntToStr(Ord(htLiked)) +
            ' and USER_PK = ' + dsPortalUserPK.AsString;
          else sql := '';
        end;

        ds := OpenSQL(sql, 'PK=' + dsTreeHistoryOBJ_PK.AsString);
        if ds.Active and (not ds.IsEmpty) then
          AddSubnodesHist(tvHistory, Node, ds, TConfObjectType(dsTreeHistoryOBJ_TYPE.AsInteger), HistType)
        else if TConfObjectType(dsTreeHistoryOBJ_TYPE.AsInteger) <> cotLikedFolder then
          ExecSQL('delete from DCFG_HISTORY where OBJ_PK = ' + dsTreeHistoryOBJ_PK.AsString + ' and OBJ_TYPE = ' +
            dsTreeHistoryOBJ_TYPE.AsString, err);
      except
      end;

      if Assigned(ds) then
      begin
        ds.Close;
        ds.Free;
      end;

      dsTreeHistory.Next;
    end;
  except
  end;

  {if dsTreeHistory.Active then} dsTreeHistory.Close;
end;

procedure TFMain.LoadObjectInfo(NodeData: TNodeDictInfo);

  procedure _addParam(name: string; value: Variant);
  begin
    if VarIsNull(value) then exit;
    mtObjectInfo.Append;
    mtObjectInfoNAME.AsString := name;
    mtObjectInfoVALUE.AsVariant := value;
    mtObjectInfo.Post;
  end;

begin
  if mtObjectInfo.Active then
  begin
    mtObjectInfo.EmptyTable;
    mtObjectInfo.Close;
  end;

  if NoLoadInfo then exit;

  mtObjectInfo.CreateDataSet;
  _addParam('Объект', GetConfObjectTypeStr(NodeData.ObjType));
  _addParam('PK', NodeData.PK);
  _addParam('Дескриптор', NodeData.Descriptor);
  _addParam('Название', NodeData.Title);
  _addParam('Владелец', NodeData.Login);

  case NodeData.ObjType of
    cotFolder:
    begin
      dsFolderInfo.Close;
      dsFolderInfo.ParamByName('PK').Value := NodeData.PK;
      dsFolderInfo.Open;

      if not dsFolderInfo.IsEmpty then
        _addParam('Папка', iif(dsFolderInfoPARENT_FOLDER_PK.IsNull, '',
          dsFolderInfoPARENT_FOLDER_PK.AsString + ' : ' + dsFolderInfoPARENT_NAME.AsString));

      dsFolderFolders.Close;
      dsFolderFolders.ParamByName('PK').Value := NodeData.PK;
      dsFolderFolders.Open;
      _addParam('Папок', dsFolderFolders.RecordCount);

      dsFolderReference.Close;
      dsFolderReference.ParamByName('PK').Value := NodeData.PK;
      dsFolderReference.Open;
      _addParam('Справочников', dsFolderReference.RecordCount);

      dsFolderInfo.Close;
      dsFolderFolders.Close;
      dsFolderReference.Close;
    end;
    cotDict:
    begin
      dsDictInfo.Close;
      dsDictInfo.ParamByName('PK').Value := NodeData.PK;
      dsDictInfo.Open;

      if not dsDictInfo.IsEmpty then
      begin
        _addParam('ФИО', dsDictInfoUSERNAME.AsVariant);
        _addParam('База данных', dsDictInfoBASE_DESCRIPTOR.AsVariant);
        _addParam('Создан', dsDictInfoCREATE_.AsVariant);
        _addParam('Изменен', dsDictInfoMODIFY.AsVariant);
        if not dsDictInfoPARENT_REFERENCE_PK.IsNull then
          _addParam('Род. справочник', dsDictInfoPARENT_REFERENCE_PK.AsString + ' : ' + dsDictInfoPARENT_DESCRIPTOR.AsString + ' : ' +
            dsDictInfoPARENT_TITLE.AsString);
        if not dsDictInfoFOLDER_PK.IsNull then
          _addParam('Папка', dsDictInfoFOLDER_PK.AsString + ' : ' + dsDictInfoFOLDER_NAME.AsString);
        _addParam('Главная форма', dsDictInfoMAIN_FORM_PK.AsString + iif(dsDictInfoMAIN_FORM_ALIAS.IsNull, '', ' : ' +
          dsDictInfoMAIN_FORM_ALIAS.AsString) + ' : ' + dsDictInfoMAIN_FORM_TITLE.AsString);
        if not dsDictInfoSTART_FORM_PK.IsNull then
          _addParam('Стартовая форма', dsDictInfoSTART_FORM_PK.AsString + iif(dsDictInfoSTART_FORM_ALIAS.IsNull, '', ' : ' +
            dsDictInfoSTART_FORM_ALIAS.AsString) + ' : ' + dsDictInfoSTART_FORM_TITLE.AsString);
        if not dsDictInfoGROUP_EDIT_FORM_PK.IsNull then
          _addParam('Форма Гр. редакт.', dsDictInfoGROUP_EDIT_FORM_PK.AsString + iif(dsDictInfoGROUP_FORM_ALIAS.IsNull, '', ' : ' +
            dsDictInfoGROUP_FORM_ALIAS.AsString) + ' : ' + dsDictInfoGROUP_FORM_TITLE.AsString);
      end;

      dsDictReference.Close;
      dsDictReference.ParamByName('PK').Value := NodeData.PK;
      dsDictReference.Open;
      _addParam('Дочерн. справочников', dsDictReference.RecordCount);

      dsDictWizard.Close;
      dsDictWizard.ParamByName('PK').Value := NodeData.PK;
      dsDictWizard.Open;
      dsDictWizard.First;
      while not dsDictWizard.Eof do
      begin
        _addParam('Визард', dsDictWizardPK.AsString + iif(dsDictWizardDESCRIPTOR_.IsNull, '', ' : ' + dsDictWizardDESCRIPTOR_.AsString) + ' : ' +
          dsDictWizardNAME.AsString);
        //mtObjectInfoPK.AsVariant := dsDictWizardPK.AsVariant;
        //mtObjectInfoTYPE.AsInteger := Ord(cftWizard);
        dsDictWizard.Next;
      end;

      dsDictInfo.Close;
      dsDictReference.Close;
      dsDictWizard.Close;
    end;
    cotForm:
    begin
      dsFormInfo.Close;
      dsFormInfo.ParamByName('PK').Value := NodeData.PK;
      dsFormInfo.Open;

      if not dsFormInfo.IsEmpty then
      begin
        _addParam('ФИО', dsFormInfoUSER_NAME.AsVariant);
        _addParam('Создана', dsFormInfoCREATE_.AsVariant);
        _addParam('Изменена', dsFormInfoMODIFY.AsVariant);
      end;

      dsFormReference.Close;
      dsFormReference.ParamByName('FORM_PK').Value := NodeData.PK;
      dsFormReference.Open;
      dsFormReference.First;
      while not dsFormReference.Eof do
      begin
        _addParam('Справочник', dsFormReferencePK.AsString + ' : ' + dsFormReferenceDESCRIPTOR_.AsString + ' : ' + dsFormReferenceTITLE.AsString);
        //mtObjectInfoPK.AsVariant := dsFormReferencePK.AsVariant;
        //mtObjectInfoTYPE.AsInteger := Ord(cftDict);
        dsFormReference.Next;
      end;

      dsFormWizard.Close;
      dsFormWizard.ParamByName('FORM_PK').Value := NodeData.PK;
      dsFormWizard.Open;
      dsFormWizard.First;
      while not dsFormWizard.Eof do
      begin
        _addParam('Визард', dsFormWizardPK.AsString + iif(dsFormWizardDESCRIPTOR_.IsNull, '', ' : ' + dsFormWizardDESCRIPTOR_.AsString) + ' : ' +
          dsFormWizardNAME.AsString);
        //mtObjectInfoPK.AsVariant := dsFormWizardPK.AsVariant;
        //mtObjectInfoTYPE.AsInteger := Ord(cftWizard);
        dsFormWizard.Next;
      end;

      dsFormInfo.Close;
      dsFormReference.Close;
      dsFormWizard.Close;
    end;
    cotWizard:
    begin
      dsWizardInfo.Close;
      dsWizardInfo.ParamByName('PK').Value := NodeData.PK;
      dsWizardInfo.Open;

      if not dsWizardInfo.IsEmpty then
      begin
        _addParam('ФИО', dsWizardInfoUSERNAME.AsVariant);
        _addParam('Тип', dsWizardInfoSCEN_TYPE.AsVariant);
        if not dsWizardInfoREF_PK.IsNull then
        begin
          _addParam('Справочник', dsWizardInfoREF_PK.AsString + ' : ' + dsWizardInfoREF_DESCRIPTOR.AsString + ' : ' + dsWizardInfoREF_TITLE.AsString);
          //mtObjectInfoPK.AsVariant := dsWizardInfoREF_PK.AsVariant;
          //mtObjectInfoTYPE.AsInteger := Ord(cftDict);
        end;
      end;

      dsWizardForm.Close;
      dsWizardForm.ParamByName('PK').Value := NodeData.PK;
      dsWizardForm.Open;
      dsWizardForm.First;
      while not dsWizardForm.Eof do
      begin
        _addParam('Форма', dsWizardFormFORM_PK.AsString + iif(dsWizardFormALIAS_FORM.IsNull, '', ' : ' + dsWizardFormALIAS_FORM.AsString) + ' : ' +
          dsWizardFormTITLE.AsString);
        dsWizardForm.Next;
      end;

      dsWizardInfo.Close;
      dsWizardForm.Close;
    end;
  end;

  mtObjectInfo.First;
end;

procedure TFMain.LoadObjectList(List: TStringList);
begin
  Screen.Cursor := crAppStart;
  try
    List.Clear;
    if not Database.Connected then exit;
    if dsObjectsList.Active then dsObjectsList.Close;
    dsObjectsList.Open;

    dsObjectsList.First;
    while not dsObjectsList.Eof do
    begin
      List.Add(dsObjectsListNAME.AsString);
      dsObjectsList.Next;
      Application.ProcessMessages;
    end;
  except
  end;
  Screen.Cursor := crDefault;
end;

procedure TFMain.LoadSession;
var
  reg: TRegistry;
  regKey: string;
  sl: TStringList;
  i: integer;
  ownForm: integer;
  // параметры окна
  cls: string;
  frmType, ownFrmType: TChildFormType;
  mode, ownMode: TOpenMode;
  d, od: TNodeDictInfo;
  
begin
  // восстановление открытых окон
  if not Database.Connected then exit;
  regKey := REG_KEY_SESSION + '\' + IntToStr(FSettings.CurrConnect);

  sl := TStringList.Create;
  reg := TRegistry.Create(KEY_ALL_ACCESS);
  FNoHistory := true;
  try
    try
      reg.RootKey := PARAM_ROOT_KEY;
      if reg.OpenKey(regKey, false) then
      begin
        reg.GetKeyNames(sl);
        reg.CloseKey;
        for i := 0 to sl.Count - 1 do
        try
          if reg.OpenKey(regKey + '\' + sl.Strings[i], false) then
          begin
            // сначала грузим параметры окна
            d := AssignNodeData(cotNone);
            cls := ReadRegValueStr(reg, 'ClassName', '');
            frmType := TChildFormType(ReadRegValueInt(reg, 'FormType', -1));
            mode := TOpenMode(ReadRegValueInt(reg, 'Mode', 0));
            d.ObjType := TConfObjectType(ReadRegValueInt(reg, 'ObjType', 4));
            d.PK := ReadRegValueInt(reg, 'PK', -MAXSHORT);
            if d.PK = -MAXSHORT then d.PK := Null;
            d.Descriptor := ReadRegValueStr(reg, 'Descriptor', '');
            if d.Descriptor = '' then d.Descriptor := Null;
            d.Title := ReadRegValueStr(reg, 'Title', '');
            if d.Title = '' then d.Title := Null;
            d.ParentDictPK := ReadRegValueInt(reg, 'ParentDictPK', -MAXSHORT);
            if d.ParentDictPK = -MAXSHORT then d.ParentDictPK := Null;
            d.FolderPK := ReadRegValueInt(reg, 'FolderPK', -MAXSHORT);
            if d.FolderPK = -MAXSHORT then d.FolderPK := Null;
            d.Login := ReadRegValueStr(reg, 'Login', '');
            if d.Login = '' then d.Login := Null;

            // параметры окна владельца
            od := AssignNodeData(cotNone);
            ownFrmType := TChildFormType(ReadRegValueInt(reg, 'OwnerFormType', -1));
            ownMode := TOpenMode(ReadRegValueInt(reg, 'OwnerMode', 0));
            od.PK := ReadRegValueInt(reg, 'OwnerPK', -MAXSHORT);
            if od.PK = -MAXSHORT then od.PK := Null;
            od.Descriptor := ReadRegValueStr(reg, 'OwnerDescriptor', '');
            if od.Descriptor = '' then od.Descriptor := Null;

            // открываем окно (окна создания объектов открывать не будем - только существующих)
            case frmType of
              cftFolder:
              begin
                case mode of
                  {omAdd:
                  begin
                    d.PK := d.FolderPK;
                    d.FolderPK := Null;
                    CreateFolder(d);
                  end;}
                  omEdit: EditFolder(d);
                  omView: ViewFolder(d);
                end;
              end;
              cftDict:
              begin
                case mode of
                 { omAdd:
                  begin
                    d.PK := d.ParentDictPK;
                    d.ParentDictPK := Null;
                    d.Descriptor := Null;
                    d.Title := Null;
                    CreateDict(d);
                  end;}
                  omEdit: EditDict(d);
                  omView: ViewDict(d);
                end;
              end;
              cftForm:
              begin
                case mode of
                  //omAdd: CreateForm;
                  omEdit: EditForm(d);
                  omView: ViewForm(d);
                end;
              end;
              cftWizard:
              begin
                case mode of
                  //omAdd: CreateWizard;
                  omEdit: EditWizard(d);
                  omView: ViewWizard(d);
                end;
              end;
              cftEditor:
              begin
                ownForm := FindChildForm(ownFrmType, ownMode, od.PK, od.Descriptor);
                if ownForm = -1 then continue;

                if cls = TFObjectEditor.ClassName then
                begin
                  case mode of
                    //omAdd: TFEditDict(ChildForms[ownForm]).sbAddObjectClick(TFEditDict(ChildForms[ownForm]).sbAddObject);
                    omEdit:
                      if TFEditDict(ChildForms[ownForm]).mtObjectTree.Locate('PK', d.PK, []) then
                        TFEditDict(ChildForms[ownForm]).sbEditObjectClick(TFEditDict(ChildForms[ownForm]).sbEditObject);
                  end;
                end else

                if cls = TFFieldEditor.ClassName then
                begin
                  // не сработает если парент - фрейм формы
                  case ownFrmType of
                    cftDict:
                      case mode of
                        //omAdd: TFEditDict(ChildForms[ownForm]).sbAddFieldClick(TFEditDict(ChildForms[ownForm]).sbAddField);
                        omEdit:
                          if TFEditDict(ChildForms[ownForm]).mtFormFields.Locate('PK', d.PK, []) then
                            TFEditDict(ChildForms[ownForm]).sbEditFieldClick(TFEditDict(ChildForms[ownForm]).sbEditField);
                      end;
                    cftForm:
                      case mode of
                        //omAdd: TFEditForm(ChildForms[ownForm]).sbAddClick(TFEditForm(ChildForms[ownForm]).sbAdd);
                        omEdit:
                          if TFEditForm(ChildForms[ownForm]).mtFormFields.Locate('PK', d.PK, []) then
                            TFEditForm(ChildForms[ownForm]).sbEditClick(TFEditForm(ChildForms[ownForm]).sbEdit);
                      end;
                  end;
                end else

                if cls = TFGroupEditor.ClassName then
                begin
                  // не сработает если парент - фрейм формы
                  case ownFrmType of
                    cftDict:
                      case mode of
                        //omAdd: TFEditDict(ChildForms[ownForm]).sbAddGroupClick(TFEditDict(ChildForms[ownForm]).sbAddGroup);
                        omEdit:
                        if TFEditDict(ChildForms[ownForm]).mtGroups.Locate('PK', d.PK, []) then
                          TFEditDict(ChildForms[ownForm]).sbEditGroupClick(TFEditDict(ChildForms[ownForm]).sbEditGroup);
                      end;
                    cftForm:
                      case mode of
                        //omAdd: TFEditForm(ChildForms[ownForm]).sbAddGroupClick(TFEditForm(ChildForms[ownForm]).sbAddGroup);
                        omEdit:
                        if TFEditForm(ChildForms[ownForm]).mtGroups.Locate('PK', d.PK, []) then
                          TFEditForm(ChildForms[ownForm]).sbEditGroupClick(TFEditForm(ChildForms[ownForm]).sbEditGroup);
                      end;
                  end;
                end else

                if cls = TFChartEditor.ClassName then
                begin
                  case mode of
                    //omAdd: TFEditDict(ChildForms[ownForm]).sbAddChartClick(TFEditDict(ChildForms[ownForm]).sbAddChart);
                    omEdit:
                      if TFEditDict(ChildForms[ownForm]).mtChart.Locate('PK', d.PK, []) then
                        TFEditDict(ChildForms[ownForm]).sbEditChartClick(TFEditDict(ChildForms[ownForm]).sbEditChart);
                  end;
                end else

                if cls = TFChartGroupEditor.ClassName then
                begin
                  case mode of
                    //omAdd: TFEditDict(ChildForms[ownForm]).sbAddChartGroupClick(TFEditDict(ChildForms[ownForm]).sbAddChartGroup);
                    omEdit:
                      if TFEditDict(ChildForms[ownForm]).mtChartGroup.Locate('PK', d.PK, []) then
                        TFEditDict(ChildForms[ownForm]).sbEditChartGroupClick(TFEditDict(ChildForms[ownForm]).sbEditChartGroup);
                  end;
                end else

                if cls = TFStateEditor.ClassName then
                begin
                  case mode of
                    //omAdd: TFEditWizard(ChildForms[ownForm]).sbAddStateClick(TFEditWizard(ChildForms[ownForm]).sbAddState);
                    omEdit:
                      if TFEditWizard(ChildForms[ownForm]).mtWizardStates.Locate('PK', d.PK, []) then
                        TFEditWizard(ChildForms[ownForm]).sbEditStateClick(TFEditWizard(ChildForms[ownForm]).sbEditState);
                  end;
                end else

                if cls = TFCrossEditor.ClassName then
                begin
                  case mode of
                   // omAdd: TFEditWizard(ChildForms[ownForm]).sbAddCrossClick(TFEditWizard(ChildForms[ownForm]).sbAddCross);
                    omEdit:
                      if TFEditWizard(ChildForms[ownForm]).mtStatesCross.Locate('PK', d.PK, []) then
                        TFEditWizard(ChildForms[ownForm]).sbEditCrossClick(TFEditWizard(ChildForms[ownForm]).sbEditCross);
                  end;
                end else

                if cls = TFSlotEditor.ClassName then
                begin
                  // не делал, т.к. надо еще схранять признак слот СЦЕНАРИЯ ИЛИ СОСТОЯНИЯ
                end else

                if cls = TFSlotValEditor.ClassName then
                begin
                  // не делал, т.к. надо еще схранять признак значение слота СЦЕНАРИЯ ИЛИ СОСТОЯНИЯ
                end;

                if cls = TFJsonReader.ClassName then
                begin
                  // восстанавливать не вижу смысла. Да и сложностей там много - форма может быть открыта для любого поля любого датасета
                end else

                if cls = TFFilterConfigEditor.ClassName then
                begin
                  case mode of
                    //omAdd: TFEditDict(ChildForms[ownForm]).sbAddFilterConfigClick(TFEditDict(ChildForms[ownForm]).sbAddFilterConfig);
                    omEdit:
                      if TFEditDict(ChildForms[ownForm]).mtFilterConfig.Locate('PK', d.PK, []) then
                        TFEditDict(ChildForms[ownForm]).sbEditFilterConfigClick(TFEditDict(ChildForms[ownForm]).sbEditFilterConfig);
                  end;
                end else

                if cls = TFEnsTaskEditor.ClassName then
                begin
                  case mode of
                    //omAdd: TFEditDict(ChildForms[ownForm]).sbAddObjectClick(TFEditDict(ChildForms[ownForm]).sbAddObject);
                    omEdit:
                      if TFEnsTask(ChildForms[ownForm]).dsEnsTask.Locate('PK', d.PK, []) then
                        TFEnsTask(ChildForms[ownForm]).AEditExecute(TFEnsTask(ChildForms[ownForm]).AEdit);
                  end;
                end;
              end;
              cftPreview:
              begin
                // не сработает если парент - фрейм формы
                ownForm := FindChildForm(ownFrmType, ownMode, od.PK, od.Descriptor);
                if ownForm = -1 then continue;

                case ownFrmType of
                  cftDict: TFEditDict(ChildForms[ownForm]).btnPreviewFormClick(TFEditDict(ChildForms[ownForm]).btnPreviewForm);
                  cftForm: TFEditForm(ChildForms[ownForm]).btnPreviewFormClick(TFEditForm(ChildForms[ownForm]).btnPreviewForm);
                end;
              end;
              cftInstrUsers: OpenInstrument(frmType, AOpenUsers.Caption);
              cftInstrGroups: OpenInstrument(frmType, AOpenGroups.Caption);
              cftInstrJson: OpenInstrument(frmType, AJsonReader.Caption);
              cftInstrTask: OpenInstrument(frmType, ATaskSheduler.Caption);
              cftInstrEns: OpenInstrument(frmType, AEnsTask.Caption);
              cftInstrCrStat: OpenInstrument(frmType, ACrStat.Caption);
              cftInstrHistory: ShowObjectHistory(d);
            end;

            d.Free;
            od.Free;
            reg.CloseKey;
          end;
        except
          // без сообщений
        end;
      end;
    except
      // без сообщений
    end;
  finally
    FNoHistory := false;
    sl.Free;
    reg.Free;
  end;
end;

procedure TFMain.LostConnect(Connection: TObject; ErrorMessage: string);
var
  i: integer;
  c: TConnection;

begin
  if (Connection = Database) then
  begin
    c := FSettings.GetCurrentConnection;
    CloseConfiguration;

    Application.MessageBox(pchar('Потеряно соединение с базой данных ' + c.Alias + ' [' + FSettings.cbServer.Items[Ord(c.Server)] +
      ':' + c.Host + ':' + c.DataBase + ']! Ошибка:'#13#10 + ErrorMessage), pchar(Application.Title), MB_OK + MB_ICONERROR);
  end;

  if (Connection = DBTask) then
  begin
    i := FindChildForm(cftInstrTask, omEdit, 0, Null);
    if i <> -1 then
    begin
      FreeAndNil(ChildForms[i]);
      Application.MessageBox(pchar('Соединение Планировщика задач было разорвано! Ошибка:'#13#10 + ErrorMessage),
        pchar(Application.Title), MB_OK + MB_ICONERROR);
    end;
  end;

  if (Connection = DBUpdate) then ;
end;

procedure TFMain.miShowHintClick(Sender: TObject);
begin
  if FHint.Visible then
  begin
    FHint.Close;
    TMenuItem(Sender).Checked := false;
  end else
  begin
    FHint.Show;
    TMenuItem(Sender).Checked := true;
  end;
end;

//function TFMain.NodeMatchFilterValue(NodePk: integer; NodeText, FilterStr: string; IsFolder: boolean): boolean;
//var
//  ds: TpFIBDataSet;
//
//begin
//  result := true;
//  if Trim(FilterStr) = '' then exit;
//
//  FilterStr := AnsiLowerCase(FilterStr);
//  NodeText := AnsiLowerCase(NodeText);
//  result := Pos(FilterStr, NodeText) > 0;
//  if result then exit;
//
//  Screen.Cursor := crHourGlass;
//  try
//    if IsFolder then
//      ds := OpenSQL('select PK from DYNAMIC_FORM_FOLDER where PARENT_FOLDER_PK = ' + IntToStr(NodePk) + ' and ' +
//        ' lower(NAME) like ''%' + FilterStr + '%'' ' +
//        'union all select PK from DYNAMIC_FORM_REFERENCE where FOLDER_PK = ' + IntToStr(NodePk) + ' and (lower(TITLE) like ''%' +
//        FilterStr + '%'' or lower(DESCRIPTOR_) like ''%' + FilterStr + '%'')')
//    else
//      ds := OpenSQL('select PK from DYNAMIC_FORM_REFERENCE where PARENT_REFERENCE_PK = ' + IntToStr(NodePk) +
//        ' and (lower(TITLE) like ''%' + FilterStr + '%'' or lower(DESCRIPTOR_) like ''%' + FilterStr + '%'')');
//
//    result := not ds.IsEmpty;
//    if result then exit;
//
//    // не совпало - переберем дочерние узлы
//    ds.Close;
//    FreeAndNil(ds);
//    if IsFolder then
//      ds := OpenSQL('select 1 IS_FOLDER, PK, NAME from DYNAMIC_FORM_FOLDER where PARENT_FOLDER_PK = ' + IntToStr(NodePk) +
//        ' union all select 0 IS_FOLDER, PK, TITLE ||  '' ['' || DESCRIPTOR_ || '']'' NAME from DYNAMIC_FORM_REFERENCE where FOLDER_PK = ' +
//        IntToStr(NodePk))
//    else
//      ds := OpenSQL('select 0 IS_FOLDER, PK, TITLE ||  '' ['' || DESCRIPTOR_ || '']'' NAME from DYNAMIC_FORM_REFERENCE ' +
//        'where PARENT_REFERENCE_PK = ' + IntToStr(NodePk));
//
//    ds.First;
//    while not ds.Eof do
//    begin
//      result := NodeMatchFilterValue(ds.FieldByName('PK').AsInteger, ds.FieldByName('NAME').AsString, FilterStr,
//        ds.FieldByName('IS_FOLDER').AsInteger = 1);
//        
//      if result then exit;
//      ds.Next;
//    end;
//  finally
//    ds.Close;
//    ds.Free;
//    Screen.Cursor := crDefault;
//  end;
//end;

procedure TFMain.OnChildFormClose(Index: integer; CanRefresh: boolean);
var
  idx, n, pi: integer;
  mi: TMenuItem;

begin
  if (Index < 0) or (Index >= Length(ChildForms)) then exit;
  if Assigned(ChildForms[Index]) then pi := ChildForms[Index].GetParentIndex
  else pi := -1;
  
  idx := GetButtonIndex(Index);
  if idx >= 0 then WindowBar.Tabs.Delete(idx);
  if (pi > -1) and (pi < Length(ChildForms)) and Assigned(ChildForms[pi]) then
  begin
    n := GetButtonIndex(pi);
    if n >= 0 then WindowBar.SelectedTab := WindowBar.Tabs.Items[n];
  end;

  idx := GetMenuIndex(Index);
  if (idx >= 0) and (idx < miWindow.Count) then
  begin
    mi := miWindow.Items[idx];
    miWindow.Remove(mi);
    mi.Free;
  end;

  if (Index >= 0) and (Index < Length(ChildForms)) then ChildForms[Index] := nil;
  
  Dec(OpenedFormCount);
  if OpenedFormCount < 0 then OpenedFormCount := 0;
  if CanRefresh then ReopenTree;
end;

procedure TFMain.OpenChildRef(ParentPk: integer);
var
  ds: TpFIBDataSet;
  d: TNodeDictInfo;

begin
  try
    d := AssignNodeData(cotDict);
    ds := OpenSQL('select PK, DESCRIPTOR_, TITLE, FOLDER_PK from DYNAMIC_FORM_REFERENCE where PARENT_REFERENCE_PK = ' +
      IntToStr(ParentPk) + ' order by PK');
      
    ds.First;
    while not ds.Eof do
    begin
      d.PK := ds.FieldByName('PK').Value;
      d.Descriptor := ds.FieldByName('DESCRIPTOR_').Value;
      d.Title := ds.FieldByName('TITLE').Value;
      d.ParentDictPK := ParentPk;
      d.FolderPK := ds.FieldByName('FOLDER_PK').Value;
      d.Login := FSettings.PortalUser;
      OpenRef(d);
      OpenChildRef(d.PK);
      ds.Next;
    end;
  finally
    d.Free;
    ds.Close;
    ds.Free;
  end;
end;

procedure TFMain.OpenConfiguration;
begin
  Connect;
  ReopenTree;
  RestoreTreePositions;
  if FSettings.RestoreSession then LoadSession;
  tmrEndSession.Enabled := true;
  tmrLoadDbObjects.Enabled := true;
end;

procedure TFMain.OpenDictInBrowser(DictInfo: TNodeDictInfo);
var
  url: string;

begin
  url := GetRefLink(DictInfo);

  if url <> '' then
    ShellExecute(0, 'open', pchar(url), nil, nil, SW_SHOWNORMAL)
  else
    Application.MessageBox('Для текущего подключения не задан url портала! Его можно указать в настройках подключений.',
      'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFMain.OpenRef(Data: TNodeDictInfo);
var
  fDict: TFEditDict;

begin
  fDict := TFEditDict.Create(Self, cftDict, omEdit, Data.PK, OnChildFormClose);
  fDict.Properties := Data;
  RegisterChildForm(fDict);
  //fDict.Show;
end;

function TFMain.OpenSQL(SQL: string; Params: string): TpFIBDataSet;
var
  sl: TStringList;
  i: integer;

begin
  sl := TStringList.Create;
  try
    result := TpFIBDataSet.Create(Self);
    result.Database := Database;
    result.SQLs.SelectSQL.Text := SQL;
    sl.Text := Params;
    for i := 0 to sl.Count - 1 do result.ParamByName(sl.Names[i]).Value := sl.Values[sl.Names[i]];
    result.Open;
  finally
    sl.Free;
  end;
end;

procedure TFMain.OpenInstrument(InstrType: TChildFormType; InstrName: string);
var
  err: string;
  fForm: TChildForm;
  d: TNodeDictInfo;
  mode: TOpenMode;
  
begin
  // проверка прав
  d := AssignNodeData(cotNone);
  try
    if CheckGrants(gaOpenInstr, d, err) then mode := omEdit
    else if CheckGrants(gaViewInstr, d, err) then mode := omView
    else begin
      Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;

    case InstrType of
      cftInstrUsers:
      begin
        if SetFocusOpenedWindow(0, TFUsers.ClassName) then exit;
        fForm := TFUsers.Create(Self, InstrType, mode, 0, OnChildFormClose);
        fForm.Caption := InstrName;
      end;
      cftInstrGroups:
      begin
        if SetFocusOpenedWindow(0, TFGroups.ClassName) then exit;
        fForm := TFGroups.Create(Self, InstrType, mode, 0, OnChildFormClose);
        fForm.Caption := InstrName;
      end;
      cftInstrJson:
      begin
        if SetFocusOpenedWindow(0, TFJsonReader.ClassName) then exit;
        fForm := TFJsonReader.Create(Self, InstrType, omEdit, 0, OnChildFormClose);
        fForm.Caption := InstrName;
      end;
      cftInstrTask:
      begin
        if SetFocusOpenedWindow(0, TFTask.ClassName) then exit;
        fForm := TFTask.Create(Self, InstrType, omEdit, 0, OnChildFormClose);
        fForm.Caption := InstrName;
      end;
      cftInstrEns:
      begin
        if SetFocusOpenedWindow(0, TFEnsTask.ClassName) then exit;
        fForm := TFEnsTask.Create(Self, InstrType, omEdit, 0, OnChildFormClose);
        fForm.Caption := InstrName;
      end;
      cftInstrCrStat:
      begin
        if SetFocusOpenedWindow(0, TFCrStat.ClassName) then exit;
        fForm := TFCrStat.Create(Self, InstrType, omEdit, 0, OnChildFormClose);
        fForm.Caption := InstrName;
      end;
      else exit;
    end;

    RegisterChildForm(fForm);
    //fForm.Show;
  finally
    d.Free;
  end;
end;

procedure TFMain.pcDictTreeChange(Sender: TObject);
begin
  if pcDictTree.ActivePage = tsOnFolder then tvMainChange(tvMain, tvMain.Selected)
  else if pcDictTree.ActivePage = tsOnlyDict then tvMainChange(tvDict, tvDict.Selected)
  else if pcDictTree.ActivePage = tsForm then tvMainChange(tvForm, tvForm.Selected)
  else if pcDictTree.ActivePage = tsWizard then tvMainChange(tvWizard, tvWizard.Selected)
  else if pcDictTree.ActivePage = tsHistory then tvMainChange(tvHistory, tvHistory.Selected);
end;

procedure TFMain.RegisterChildForm(Form: TChildForm);
var
  i, idx: integer;

begin
  idx := -1;
  for i := 0 to Length(ChildForms) - 1 do
    if not Assigned(ChildForms[i]) then
    begin
      idx := i;
      break;
    end;

  if idx = -1 then
  begin
    SetLength(ChildForms, Length(ChildForms) + 1);
    idx := High(ChildForms);
  end;
  ChildForms[idx] := Form;
  Form.Tag := idx;
  Inc(OpenedFormCount);
  AddFormButton(Form.Tag, Form.GetShortCaption, Form.Caption, Form.GetCapImage);
end;

procedure TFMain.ReopenTree(TreeCanFocus: boolean);
var
  pkMain, pkDict, pkForm, pkWizard, pkHist: variant;

begin
  if DenyLoadTree then exit;
  NoLoadInfo := true;
  try
    pkMain := Null;
    pkDict := Null;
    pkForm := Null;
    pkWizard := Null;
    pkHist := Null;
    if Assigned(tvMain.Selected) and (tvMain.Selected.AbsoluteIndex <> 0) and Assigned(tvMain.Selected.Data) then
      pkMain := TNodeDictInfo(tvMain.Selected.Data).PK;
    if Assigned(tvDict.Selected) and (tvDict.Selected.AbsoluteIndex <> 0) and Assigned(tvDict.Selected.Data) then
      pkDict := TNodeDictInfo(tvDict.Selected.Data).PK;
    if Assigned(tvForm.Selected) and (tvForm.Selected.AbsoluteIndex <> 0) and Assigned(tvForm.Selected.Data) then
      pkForm := TNodeDictInfo(tvForm.Selected.Data).PK;
    if Assigned(tvWizard.Selected) and (tvWizard.Selected.AbsoluteIndex <> 0) and Assigned(tvWizard.Selected.Data) then
      pkWizard := TNodeDictInfo(tvWizard.Selected.Data).PK;
    if Assigned(tvHistory.Selected) and (tvHistory.Selected.AbsoluteIndex <> 0) and Assigned(tvHistory.Selected.Data) then
      pkHist := TNodeDictInfo(tvHistory.Selected.Data).PK;

    tvMain.Visible := false;
    tvDict.Visible := false;
    tvForm.Visible := false;
    tvWizard.Visible := false;
    tvHistory.Visible := false;

    tvMain.Items.Clear;
    tvDict.Items.Clear;
    tvForm.Items.Clear;
    tvWizard.Items.Clear;
    tvHistory.Items.Clear;
    dsTreeFolder.Close;
    dsTreeDict.Close;
    dsTreeDict2.Close;
    dsTreeForm.Close;
    dsTreeWizard.Close;
    dsTreeHistory.Close;
    if not Database.Connected then exit;

    if chbGetOnlyUser.Checked then
    begin
      dsTreeDict.ParamByName('SHOW_ALL').AsInteger := 0;
      dsTreeDict.ParamByName('LOGIN').AsString := LowerCase(FSettings.PortalUser);
      dsTreeDict2.ParamByName('SHOW_ALL').AsInteger := 0;
      dsTreeDict2.ParamByName('LOGIN').AsString := LowerCase(FSettings.PortalUser);
      dsTreeForm.ParamByName('SHOW_ALL').AsInteger := 0;
      dsTreeForm.ParamByName('LOGIN').AsString := LowerCase(FSettings.PortalUser);
      dsTreeWizard.ParamByName('SHOW_ALL').AsInteger := 0;
      dsTreeWizard.ParamByName('LOGIN').AsString := LowerCase(FSettings.PortalUser);
    end else
    begin
      dsTreeDict.ParamByName('SHOW_ALL').AsInteger := 1;
      dsTreeDict.ParamByName('LOGIN').Clear;
      dsTreeDict2.ParamByName('SHOW_ALL').AsInteger := 1;
      dsTreeDict2.ParamByName('LOGIN').Clear;
      dsTreeForm.ParamByName('SHOW_ALL').AsInteger := 1;
      dsTreeForm.ParamByName('LOGIN').Clear;
      dsTreeWizard.ParamByName('SHOW_ALL').AsInteger := 1;
      dsTreeWizard.ParamByName('LOGIN').Clear;
    end;

    dsTreeFolder.ParamByName('PARENT_FOLDER_PK').Clear;
    dsTreeDict.ParamByName('BYFOLDER').Clear;
    dsTreeDict.ParamByName('FOLDER_PK').Clear;
    dsTreeDict.ParamByName('PARENT_REFERENCE_PK').Clear;
    dsTreeDict2.ParamByName('PARENT_REFERENCE_PK').Clear;

    if tsOnFolder.TabVisible then
    begin
      dsTreeFolder.Open;
      AddSubnodesDict(tvMain, false, nil, dsTreeFolder, 0, true);
      dsTreeFolder.Close;
      dsTreeDict.Open;
      AddSubnodesDict(tvMain, false, nil, dsTreeDict, 1, false);
      dsTreeDict.Close;
    end;
    if tsOnlyDict.TabVisible then
    begin
      dsTreeDict2.Open;
      AddSubnodesDict(tvDict, false, nil, dsTreeDict2, 1, false);
      dsTreeDict2.Close;
    end;
    if tsForm.TabVisible then
    begin
      dsTreeForm.Open;
      AddSubnodesForm(tvForm, nil, dsTreeForm);
      dsTreeForm.Close;
    end;
    if tsWizard.TabVisible then
    begin
      dsTreeWizard.Open;
      AddSubnodesWizard(tvWizard, nil, dsTreeWizard);
      dsTreeWizard.Close;
    end;
    if tsHistory.TabVisible then LoadHistory(tvHistory);
    if Filtered then Filter(true);
  finally
    SelectNode(tvMain, pkMain);
    SelectNode(tvDict, pkDict);
    SelectNode(tvForm, pkForm);
    SelectNode(tvWizard, pkWizard);
    SelectNode(tvHistory, pkHist);

    tvMain.Visible := true;
    tvDict.Visible := true;
    tvForm.Visible := true;
    tvWizard.Visible := true;
    tvHistory.Visible := true;

    if TreeCanFocus then
      try
        GetCurrentTreeView.SetFocus;
      except
      end;

    NoLoadInfo := false;
    //StatusBar.Panels[3].Text := MillisecondsToTimeStr(GetTickCount - tick);
  end;
end;

procedure TFMain.RestoreTreePositions;
begin
  if not FSettings.TreeRestorePos then exit;

  try
    tvMain.Visible := false;
    tvDict.Visible := false;
    tvForm.Visible := false;
    tvWizard.Visible := false;
    tvHistory.Visible := false;

    SelectNode(tvMain, FSettings.MainTreeId);
    SelectNode(tvDict, FSettings.DictTreeId);
    SelectNode(tvForm, FSettings.FormTreeId);
    SelectNode(tvWizard, FSettings.WizardTreeId);
    //SelectNode(tvHistory, FSettings.HistoryTreeId);
    TvSelectNode(tvHistory.Items.GetFirstNode);
  finally
    tvMain.Visible := true;
    tvDict.Visible := true;
    tvForm.Visible := true;
    tvWizard.Visible := true;
    tvHistory.Visible := true;

    pcDictTreeChange(pcDictTree);
  end;
end;

procedure TFMain.SaveToSQL(Node: TTreeNode; FileName: string; Target: integer = 0);
begin
  if not Database.Connected then exit;
  if (not Assigned(Node)) or (not Assigned(Node.Data)) then
  begin
    Application.MessageBox('Не выбран узел!', 'Сообщение', MB_OK + MB_ICONINFORMATION);
    exit;
  end;

  SaveToSQL(TNodeDictInfo(Node.Data), FileName, Target);
end;

procedure TFMain.SaveBranchToSQL(Node: TTreeNode; FileName: string);
begin
  if not Database.Connected then exit;
  if (not Assigned(Node)) or (not Assigned(Node.Data)) then
  begin
    Application.MessageBox('Не выбран узел!', 'Сообщение', MB_OK + MB_ICONINFORMATION);
    exit;
  end;

  if TNodeDictInfo(Node.Data).ObjType <> cotFolder then exit;

  SaveBranchToSQL(TNodeDictInfo(Node.Data), FileName);
end;

procedure TFMain.SaveBranchToSQL(Data: TNodeDictInfo; FileName: string);
var
  sl, slf: TStringList;

begin
  if not Database.Connected then exit;
  if VarIsNull(Data.PK) then raise Exception.Create('Отсутствует PK узла!');
  if Data.ObjType <> cotFolder then exit;

  sl := TStringList.Create;
  slf := TStringList.Create;
  try
    WriteSQLHeader(Data, 0, 0, sl);
    GenBranchSQL(Data.PK, sl, slf);
    WriteSQLFooter(Data, 0, 0, sl);
    sl.SaveToFile(FileName);
  finally
    sl.Free;
    slf.Free;
  end;
end;

procedure TFMain.SaveBranchWizardToSQL(Node: TTreeNode; FileName: string);
begin
  if not Database.Connected then exit;
  if (not Assigned(Node)) or (not Assigned(Node.Data)) then
  begin
    Application.MessageBox('Не выбран узел!', 'Сообщение', MB_OK + MB_ICONINFORMATION);
    exit;
  end;

  if TNodeDictInfo(Node.Data).ObjType <> cotFolder then exit;

  SaveBranchWizardToSQL(TNodeDictInfo(Node.Data), FileName);
end;

procedure TFMain.SaveBranchWizardToSQL(Data: TNodeDictInfo; FileName: string);
var
  sl, slw: TStringList;

begin
  if not Database.Connected then exit;
  if VarIsNull(Data.PK) then raise Exception.Create('Отсутствует PK узла!');
  if Data.ObjType <> cotFolder then exit;

  sl := TStringList.Create;
  slw := TStringList.Create;
  try
    WriteSQLHeader(Data, 0, 1, sl);
    GenBranchWizardSQL(Data.PK, sl, slw);
    WriteSQLHeader(Data, 0, 1, sl);
    sl.SaveToFile(FileName);
  finally
    sl.Free;
    slw.Free;
  end;
end;

procedure TFMain.SaveGridsParams;
var
  i: integer;

begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TDBGridEh then FSettings.SaveGridParams(TDBGridEh(Components[i]), ClassName);
end;

procedure TFMain.SaveSession;
var
  i: integer;
  regKey: string;
  reg: TRegistry;
  
begin
  // сохранение открытых окон
  if not Database.Connected then exit;
  regKey := REG_KEY_SESSION + '\' + IntToStr(FSettings.CurrConnect);
  DeleteRegKey(PARAM_ROOT_KEY, regKey);

  reg := TRegistry.Create(KEY_ALL_ACCESS);
  try
    reg.RootKey := PARAM_ROOT_KEY;

    for i := 0 to Length(ChildForms) - 1 do
      if Assigned(ChildForms[i]) and reg.OpenKey(regKey + '\Window' + IntToStr(i), true) then
      begin
        reg.WriteString('ClassName', ChildForms[i].ClassName);
        reg.WriteInteger('FormType', Ord(ChildForms[i].FormType));
        reg.WriteInteger('Mode', Ord(ChildForms[i].Mode));
        reg.WriteInteger('ObjType', Ord(ChildForms[i].Properties.ObjType));
        if not VarIsNull(ChildForms[i].Properties.PK) then reg.WriteInteger('PK', ChildForms[i].Properties.PK);
        if not VarIsNull(ChildForms[i].Properties.Descriptor) then reg.WriteString('Descriptor', ChildForms[i].Properties.Descriptor);
        if not VarIsNull(ChildForms[i].Properties.Title) then reg.WriteString('Title', ChildForms[i].Properties.Title);
        if not VarIsNull(ChildForms[i].Properties.ParentDictPK) then reg.WriteInteger('ParentDictPK', ChildForms[i].Properties.ParentDictPK);
        if not VarIsNull(ChildForms[i].Properties.FolderPK) then reg.WriteInteger('FolderPK', ChildForms[i].Properties.FolderPK);
        if not VarIsNull(ChildForms[i].Properties.Login) then reg.WriteString('Login', ChildForms[i].Properties.Login);
        if (ChildForms[i].FormType in [cftEditor, cftPreview]) and Assigned(ChildForms[i].Owner) and (not (ChildForms[i].Owner is TfrmEditForm)) then
        begin
          reg.WriteInteger('OwnerFormType', Ord(TChildForm(ChildForms[i].Owner).FormType));
          reg.WriteInteger('OwnerMode', Ord(TChildForm(ChildForms[i].Owner).Mode));
          if not VarIsNull(TChildForm(ChildForms[i].Owner).Properties.PK) then
            reg.WriteInteger('OwnerPK', TChildForm(ChildForms[i].Owner).Properties.PK);
          if not VarIsNull(TChildForm(ChildForms[i].Owner).Properties.Descriptor) then
            reg.WriteString('OwnerDescriptor', TChildForm(ChildForms[i].Owner).Properties.Descriptor);
        end;
        reg.CloseKey;
      end;
  except
    // без сообщений
  end;

  if Assigned(reg) then reg.Free;
end;

procedure TFMain.SaveToSQL(Data: TNodeDictInfo; FileName: string; Target: integer = 0; AddScen: boolean = false);
var
  sl, slf, slw: TStringList;

begin
//  Target: Флаг работает только когда выгружаемый объект - справочник.
//    0 - выгрузить стандартно сам справочник
//    1 - выгрузить все сценарии справочника
//    2 - выгрузить только права на справочник

  if not Database.Connected then exit;
  if VarIsNull(Data.PK) then raise Exception.Create('Отсутствует PK узла!');

  sl := TStringList.Create;
  slf := TStringList.Create;
  slw := TStringList.Create;

  try
    WriteSQLHeader(Data, 0, Target, sl);
    case Data.ObjType of
      cotFolder: GenFolderSQL(Data.PK, sl, slf);
      cotDict:
        case Target of
          0:
          begin
            GenDictSQL(Data.PK, sl, slf);
            if AddScen then
            begin
              GenWizardOnDictSQL(Data.PK, slw, slf);
              if slw.Count > 0 then
              begin
                sl.Add('delete from TMP_WIZARD_VAR^');
                sl.Add('');
                sl.AddStrings(slw);
                sl.Add('delete from TMP_WIZARD_VAR^');
              end;
            end;
          end;
          1: GenWizardOnDictSQL(Data.PK, sl, slf);
          2: GenDictPermissionsSQL(Data.PK, sl);
        end;
      cotForm: GenFormSQL(Data.PK, sl, true, true);
      cotWizard: GenWizardSQL(Data.PK, sl);
      else exit;
    end;

    WriteSQLFooter(Data, 0, Target, sl);
    sl.SaveToFile(FileName);
  finally
    sl.Free;
    slf.Free;
    slw.Free;
  end;
end;

procedure TFMain.SaveTreePositions;
begin
  if Assigned(tvMain.Selected) and (tvMain.Selected.AbsoluteIndex <> 0) and Assigned(tvMain.Selected.Data) then
    if TNodeDictInfo(tvMain.Selected.Data).ObjType = cotFolder then
      FSettings.MainTreeId := TNodeDictInfo(tvMain.Selected.Data).Title
    else
      FSettings.MainTreeId := TNodeDictInfo(tvMain.Selected.Data).Descriptor;

  if Assigned(tvDict.Selected) and (tvDict.Selected.AbsoluteIndex <> 0) and Assigned(tvDict.Selected.Data) then
    FSettings.DictTreeId := TNodeDictInfo(tvDict.Selected.Data).Descriptor;

  if Assigned(tvForm.Selected) and (tvForm.Selected.AbsoluteIndex <> 0) and Assigned(tvForm.Selected.Data) then
    if (VarToStr(TNodeDictInfo(tvForm.Selected.Data).Title) = '') then
      FSettings.FormTreeId := TNodeDictInfo(tvForm.Selected.Data).PK
    else
      FSettings.FormTreeId := TNodeDictInfo(tvForm.Selected.Data).Title;

  if Assigned(tvWizard.Selected) and (tvWizard.Selected.AbsoluteIndex <> 0) and Assigned(tvWizard.Selected.Data) then
    if (VarToStr(TNodeDictInfo(tvWizard.Selected.Data).Title) = '') then
      FSettings.WizardTreeId := TNodeDictInfo(tvWizard.Selected.Data).PK
    else
      FSettings.WizardTreeId := TNodeDictInfo(tvWizard.Selected.Data).Title;
end;

procedure TFMain.SaveWndState;
begin
  FSettings.WMaximized := WindowState = wsMaximized;
  if not FSettings.WMaximized then
  begin
    FSettings.WTop := Top;
    FSettings.WLeft := Left;
    FSettings.WWidth := Width;
    FSettings.WHeight := Height;
  end;

  FSettings.pTreeWidth := pTree.Width;
  FSettings.ObjectInfoHeight := dbgObjectInfo.Height;

  FSettings.FHintLeft := FHint.Left;
  FSettings.FHintTop := FHint.Top;
  FSettings.FHintWidth := FHint.Width;
  FSettings.FHintHeight := FHint.Height;
  FSettings.FHintVisible := FHint.Visible;
end;

function TFMain.SelDictDialog(var DictPk: Variant; SQLQuery: string): boolean;
var
  fSel: TFSelUser;
  col: TColumnEh;

begin
  DictPk := Null;
  fsel := TFSelUser.Create(Self);
  try
    fsel.Caption := 'Справочники';
    fsel.lbQuery.Caption := 'Выбери справочник';

    fsel.lcbUsers.DropDownBox.Columns.Clear;
    col := fsel.lcbUsers.DropDownBox.Columns.Add;
    col.FieldName := 'PK';
    col.Width := 50;
    col := fsel.lcbUsers.DropDownBox.Columns.Add;
    col.FieldName := 'DESCRIPTOR_';
    col.Width := 120;
    col := fsel.lcbUsers.DropDownBox.Columns.Add;
    col.FieldName := 'NAME';
    col.Width := 200;

    fsel.LoadData(SQLQuery);
    result := fsel.ShowModal = mrOk;
    if result then DictPk := fsel.lcbUsers.KeyValue;
  finally
    fsel.Free;
  end;
end;

procedure TFMain.SelectNode(tv: TJvTreeView; PK: Variant);
var
  nd: TTreeNode;
  r: boolean;

begin
  if VarIsNull(PK) then exit;
  if not Assigned(tv) then exit;

  if Assigned(tv.Selected) then nd := tv.Selected
  else nd := tv.Items.GetFirstNode;

  if not Assigned(nd) then exit;

  CollapseAfterFind := true;
  try
    tv.Visible := false;
    r := FindInNodes(nd, true, VarToStr(PK), [], false);
    if not r then TvSelectNode(nd);
  finally
    CollapseAfterFind := false;
    tv.Visible := true;
  end;
end;

function TFMain.SelGroupDialog(var GroupPk: Variant; SQLQuery: string): boolean;
var
  fSel: TFSelUser;

begin
  GroupPk := Null;
  fsel := TFSelUser.Create(Self);
  try
    fsel.Caption := 'Группы портала';
    fsel.lbQuery.Caption := 'Выбери группу';
    fsel.lcbUsers.DropDownBox.Columns.Clear;
    fsel.LoadData(SQLQuery);
    result := fsel.ShowModal = mrOk;
    if result then GroupPk := fsel.lcbUsers.KeyValue;
  finally
    fsel.Free;
  end;
end;

function TFMain.SelLikedFolderDialog(var Pk: Variant; SQLQuery: string): boolean;
var
  fSel: TFSelUser;

begin
  Pk := Null;
  fsel := TFSelUser.Create(Self);
  try
    fsel.Caption := 'Разделы избранного';
    fsel.lbQuery.Caption := 'Выбери раздел, в который надо поместить объект';
    fsel.lcbUsers.DropDownBox.Columns.Clear;
    fsel.LoadData(SQLQuery);
    fsel.lcbUsers.KeyValue := Null;
    result := fsel.ShowModal = mrOk;
    if result then Pk := fsel.lcbUsers.KeyValue;
  finally
    fsel.Free;
  end;
end;

function TFMain.SelObjectDialog: integer;
var
  fSel: TFSelObject;

begin
  result := -1;
  fsel := TFSelObject.Create(self);
  try
    if fsel.ShowModal = mrOk then result := fsel.cbObject.ItemIndex;
  finally
    fsel.Free;
  end;
end;

function TFMain.SelUserDialog(var UserPk: Variant; SQLQuery: string; Title: string; Msg: string): boolean;
var
  fSel: TFSelUser;

begin
  UserPk := Null;
  fsel := TFSelUser.Create(Self);
  try
    if Title <> '' then fsel.Caption := Title;
    if Msg <> '' then fsel.lbQuery.Caption := Msg;
    fsel.LoadData(SQLQuery);
    result := fsel.ShowModal = mrOk;
    if result then UserPk := fsel.lcbUsers.KeyValue;
  finally
    fsel.Free;
  end;
end;

function TFMain.SetFocusOpenedWindow(Pk: integer; FormClass: string): boolean;
var
  i: integer;

begin
  result := false;

  for i := 0 to Length(ChildForms) - 1 do
  begin
    if Assigned(ChildForms[i]) and (ChildForms[i].ClassName = FormClass) and (ChildForms[i].GetObjectPK = Pk) then
    begin
      result := true;
      CheckFormButton(i);
      break;
    end;
  end;
end;

procedure TFMain.SetGridsOptions;
var
  i: integer;

begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TDBGridEh then
    begin
      FSettings.GridOptions.AssignTo(TDBGridEh(Components[i]));
      FSettings.LoadGridParams(TDBGridEh(Components[i]), ClassName);
      TDBGridEh(Components[i]).OnKeyUp := GridKeyUp;
    end;

  for i := 0 to Length(ChildForms) - 1 do
    if Assigned(ChildForms[i]) then ChildForms[i].SetGridsOptions(FSettings.GridOptions);
end;

procedure TFMain.SetPages(NoReload: boolean);
var
  i: integer;
  tv: TJvTreeView;
  canreload: boolean;
  ts: TTabSheet;
  changed: boolean;
  
begin
  if (not FSettings.mtMainPages.Active) or FSettings.mtMainPages.IsEmpty then exit;
  canreload := false;
  changed := false;

  for i := 0 to pcDictTree.PageCount - 1 do
  begin
    if FSettings.mtMainPages.Locate('NAME', pcDictTree.Pages[i].Name, [loCaseInsensitive]) then
    begin
      ts := pcDictTree.Pages[i];
      ts.Caption := FSettings.mtMainPagesCAPTION.AsString;
      pcDictTree.Pages[FSettings.mtMainPages.RecNo - 1].PageIndex := i;
      ts.PageIndex := FSettings.mtMainPages.RecNo - 1;
      if ts.TabVisible <> FSettings.mtMainPagesIS_VISIBLE.AsBoolean then
      begin
        ts.TabVisible := FSettings.mtMainPagesIS_VISIBLE.AsBoolean;

        if NoReload then continue;
        tv := GetTreeView(ts);

        if ts.TabVisible then canreload := true
        else if Assigned(tv) then
        begin
          NoLoadInfo := true;
          tv.Items.Clear;
          NoLoadInfo := false;
        end;
      end;
    end else
    begin
      // если не нашли, строка была каким-то чудом удалена, надо ее восстановить
      ts := pcDictTree.Pages[i];
      FSettings.mtMainPages.Append;
      FSettings.mtMainPagesCAPTION.AsString := ts.Caption;
      FSettings.mtMainPagesIS_VISIBLE.AsBoolean := ts.TabVisible;
      FSettings.mtMainPagesNAME.AsString := ts.Name;
      FSettings.mtMainPages.Post;
      FSettings.mtMainPages.MoveRecord(FSettings.mtMainPages.RecNo - 1, ts.PageIndex, 1, false);
      changed := true;
    end;
  end;
  FSettings.mtMainPages.First;

  if changed then FSettings.GetPagesFromControls;
  if canreload then ReopenTree;
end;

procedure TFMain.SetSaveDialogToSQL;
begin
  SaveDialog.Filter := 'Файлы SQL (*.sql)|*.sql|Текстовые файлы (*.txt)|*.txt|Все файлы (*.*)|*.*';
  SaveDialog.DefaultExt := 'sql';
end;

procedure TFMain.ShowObjectHistory(Data: TNodeDictInfo);
var
  err: string;
  fh: TFHistory;

begin
  // проверка прав
  if CheckGrants(gaOpenInstr, Data, err) then
  begin
    if SetFocusOpenedWindow(Data.PK, TFHistory.ClassName) then exit;
    fh := TFHistory.Create(Self, cftInstrHistory, omEdit, Data.PK, OnChildFormClose);
    fh.Properties := Data;
    RegisterChildForm(fh);
    //fh.Show;
  end else
    Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFMain.ShowUserInfo;
var
  ui: TFUserInfo;

begin
  if not dsPortalUser.Active then exit;
  ui := TFUserInfo.Create(self);
  ui.edPk.Text := dsPortalUserPK.AsString;
  ui.edLogin.Text := dsPortalUserLOGIN.AsString;
  ui.edName.Text := dsPortalUserNAME.AsString;
  ui.edBranch.Text := dsPortalUserBRANCH_PK.AsString + ' : ' + dsPortalUserBRANCH_NAME.AsString;
  ui.edRole.Text := dsPortalUserROLE_PK.AsString + ' : ' + dsPortalUserROLE_NAME.AsString;
  ui.edUnit.Text := dsPortalUserUNIT_PK.AsString + ' : ' + dsPortalUserUNIT_NAME.AsString;
  ui.edDepartment.Text := dsPortalUserDEPARTMENT.AsString;
  ui.edOffice.Text := dsPortalUserOFFICE.AsString;
  ui.edChapter.Text := dsPortalUserCHAPTER.AsString;
  ui.edSector.Text := dsPortalUserSECTOR.AsString;
  ui.edEmail.Text := dsPortalUserEMAIL.AsString;
  ui.edCode1C.Text := dsPortalUserCODE_1C.AsString;
  ui.Developer := dsPortalUserDEVELOPER.AsString = '1';
  ui.Moderator := dsPortalUserMODERATOR.AsString = '1';
  ui.IsActive := dsPortalUserISACTIVE.AsString = '1';
  ui.Holiday := dsPortalUserHOLIDAY.AsString = '1';
  ui.ShowModal;
end;

procedure TFMain.StatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
var
  ico: TIcon;

begin
  if Panel.Index <> 4 then exit;
  StatusBar.Canvas.FillRect(Rect);
  if AvailableUpdate then
    ilMain.Draw(StatusBar.Canvas, Rect.Left, Rect.Top, 12)
  else begin
    ico := TIcon.Create;
    DrawIcon(StatusBar.Canvas.Handle, Rect.Left, Rect.Top, ico.Handle);
  end;
end;

procedure TFMain.tmrAutoUpdateTimer(Sender: TObject);
begin
  tmrAutoUpdate.Enabled := false;
  tmrAutoUpdate.Interval := FSettings.UpdateInterval;
  try
    CheckUpdates(false);
  except
  end;
  tmrAutoUpdate.Enabled := FSettings.CheckUpdates;
end;

procedure TFMain.tmrEndSessionTimer(Sender: TObject);
begin
  CloseConfiguration;
  OpenConfiguration;
end;

procedure TFMain.tmrLoadDbObjectsTimer(Sender: TObject);
begin
  tmrLoadDbObjects.Enabled := false;
  LoadObjectList(DbObjectList);
end;

procedure TFMain.tmrOpenTimer(Sender: TObject);
begin
  tmrOpen.Enabled := false;
  OpenConfiguration;
end;

procedure TFMain.tvMainChange(Sender: TObject; Node: TTreeNode);
begin
  if TJvTreeView(Sender).Visible and Assigned(Node) and Assigned(Node.Data) then LoadObjectInfo(TNodeDictInfo(Node.Data));
end;

procedure TFMain.tvMainCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Node = Sender.Selected then
    Sender.Canvas.Font.Color := clFuchsia
  else
    Sender.Canvas.Font.Color := clWindowText;

  if (not chbGetOnlyUser.Checked) and (Assigned(Node) and Assigned(Node.Data) and
    (LowerCase(VarToStr(TNodeDictInfo(Node.Data).Login)) = LowerCase(FSettings.PortalUser))) then
    Sender.Canvas.Font.Style := Sender.Canvas.Font.Style + [fsBold];

  if chbGetOnlyUser.Checked and ((Sender = tvMain) or (Sender = tvDict)) and
    Assigned(Node) and Assigned(Node.Data) and
    (LowerCase(VarToStr(TNodeDictInfo(Node.Data).Login)) <> LowerCase(FSettings.PortalUser)) and
    (TNodeDictInfo(Node.Data).ObjType = cotDict) then
    Sender.Canvas.Font.Style := Sender.Canvas.Font.Style + [fsItalic];
end;

procedure TFMain.tvMainDblClick(Sender: TObject);
begin
  if Assigned(GetCurrentTreeView.Selected) and
    (not (TNodeDictInfo(GetCurrentTreeView.Selected.Data).ObjType in [cotFolder, cotLikedFolder])) then
    AEditNodeExecute(AEditNode);
end;

procedure TFMain.tvMainDeletion(Sender: TObject; Node: TTreeNode);
begin
  if Assigned(Node) and Assigned(Node.Data) then TNodeDictInfo(Node.Data).Free;
end;

procedure TFMain.tvMainExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
var
  fNode: TTreeNode;

begin
  fNode := Node.getFirstChild;
  if Assigned(fNode) then
    if fNode.ImageIndex = -1 then
    begin
      fNode.Delete;
      if (Sender = tvMain) or (Sender = tvHistory) then LoadChildNodes(TJvTreeView(Node.TreeView), Node)
      else LoadChildNodes2(TJvTreeView(Node.TreeView), Node);
    end;
end;

procedure TFMain.tvMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F3: if AFindNext.Enabled then AFindExecute(AFindNext);
    else
      if (ssCtrl in Shift) and ((Key = Ord('F')) or (Key = Ord('f')) or (Key = Ord('А')) or (Key = Ord('а'))) and
        AFind.Enabled then AFindExecute(AFind); 
  end;
end;

procedure TFMain.TvSelectNode(Node: TTreeNode);
begin
  if not Assigned(Node) then exit;

  Node.TreeView.Visible := true;
  try
    TJvTreeView(Node.TreeView).ClearSelection;
    TJvTreeView(Node.TreeView).Select(Node);
    TJvTreeView(Node.TreeView).SelectItem(Node);

    TJvTreeView(Node.TreeView).SetFocus;
  except
  end;
end;

procedure TFMain.UpdateFilterHistory;
var
  i: integer;
  str: string;
  exist: boolean;

begin
  exist := false;
  str := Trim(cbFilter.Text);
  if str = '' then exit;
  for i := 0 to cbFilter.Items.Count - 1 do
    if cbFilter.Items.Strings[i] = str then
    begin
      exist := true;
      break;
    end;

  if not exist then cbFilter.Items.Insert(0, str);

  if cbFilter.Items.Count > 0 then
    cbFilter.Style := csDropDown
  else
    cbFilter.Style := csSimple;
end;

procedure TFMain.ViewDict(Data: TNodeDictInfo);
var
  err: string;
  fDict: TFEditDict;

begin
  // проверка прав
  if CheckGrants(gaView, Data, err) then
  begin
    if SetFocusOpenedWindow(Data.PK, TFEditDict.ClassName) then exit;
    fDict := TFEditDict.Create(Self, cftDict, omView, Data.PK, OnChildFormClose);
    fDict.Properties := Data;
    RegisterChildForm(fDict);
    //fDict.Show;
  end else
    Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFMain.ViewFolder(Data: TNodeDictInfo);
var
  err: string;
  fFolder: TFEditFolder;

begin
  // проверка прав
  if CheckGrants(gaView, Data, err) then
  begin
    if SetFocusOpenedWindow(Data.PK, TFEditFolder.ClassName) then exit;
    fFolder := TFEditFolder.Create(Self, cftFolder, omView, Data.PK, OnChildFormClose);
    fFolder.Properties := Data;
    RegisterChildForm(fFolder);
    //fFolder.Show;
  end else
    Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFMain.ViewForm(Data: TNodeDictInfo);
var
  err: string;
  fForm: TFEditForm;

begin
  // проверка прав
  if CheckGrants(gaView, Data, err) then
  begin
    if SetFocusOpenedWindow(Data.PK, TFEditForm.ClassName) then exit;
    fForm := TFEditForm.Create(Self, cftForm, omView, Data.PK, OnChildFormClose);
    fForm.Properties := Data;
    RegisterChildForm(fForm);
    //fForm.Show;
  end else
    Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFMain.ViewTreeNode(Node: TTreeNode);
begin
  if not Database.Connected then exit;
  if (not Assigned(Node)) or (not Assigned(Node.Data)) then
  begin
    Application.MessageBox('Не выбран узел!', 'Сообщение', MB_OK + MB_ICONINFORMATION);
    exit;
  end;

  case TNodeDictInfo(Node.Data).ObjType of
    cotFolder: ViewFolder(TNodeDictInfo(Node.Data));
    cotDict: ViewDict(TNodeDictInfo(Node.Data));
    cotForm: ViewForm(TNodeDictInfo(Node.Data));
    cotWizard: ViewWizard(TNodeDictInfo(Node.Data));
  end;
end;

procedure TFMain.ViewWizard(Data: TNodeDictInfo);
var
  err: string;
  fWizard: TFEditWizard;

begin
  // проверка прав
  if CheckGrants(gaView, Data, err) then
  begin
    if SetFocusOpenedWindow(Data.PK, TFEditWizard.ClassName) then exit;
    fWizard := TFEditWizard.Create(Self, cftWizard, omView, Data.PK, OnChildFormClose);
    fWizard.Properties := Data;
    RegisterChildForm(fWizard);
    //fWizard.Show;
  end else
    Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFMain.WindowBarTabSelected(Sender: TObject; Item: TJvTabBarItem);
var
  idx: integer;

begin
  if not Assigned(Item) then
  begin
    //for idx := 0 to miWindow.Count - 1 do miWindow.Items[idx].Checked := false; - будем оставлять выделенным последнее окно
    exit;
  end;

  if (Item.Tag >= 0) and (Item.Tag < Length(ChildForms)) then
  begin
    if ChildForms[Item.Tag].WindowState = wsMinimized then ShowWindow(ChildForms[Item.Tag].Handle, SW_RESTORE);
    ChildForms[Item.Tag].BringToFront;
    ChildForms[Item.Tag].SetFocus;
    idx := GetMenuIndex(Item.Tag);
    if (idx >= 0) and (idx < miWindow.Count) then miWindow.Items[idx].Checked := true;
  end;
end;

procedure TFMain.WindowMenuClick(Sender: TObject);
begin
  if (TMenuItem(Sender).Tag >= 0) and (TMenuItem(Sender).Tag < Length(ChildForms)) then
  begin
    if ChildForms[TMenuItem(Sender).Tag].WindowState = wsMinimized then ShowWindow(ChildForms[TMenuItem(Sender).Tag].Handle, SW_RESTORE);
    ChildForms[TMenuItem(Sender).Tag].BringToFront;
    ChildForms[TMenuItem(Sender).Tag].SetFocus;
  end;
end;

procedure TFMain.WMForcedTerminate(var Msg: TMessage);
begin
  ForcedTerminate := true;
  Close;
end;

procedure TFMain.WriteSQLFooter(Data: TNodeDictInfo; Rule: integer; Target: integer; Script: TStringList);
begin
  if Rule = 0 then
  begin
    if (Data.ObjType = cotWizard) or (Target = 1) then Script.Add('delete from TMP_WIZARD_VAR^')
    else Script.Add('delete from TMP_VAR^');
  end else
    Script.Add('end^');

  Script.Add('');
  Script.Add('commit^');
end;

procedure TFMain.WriteSQLHeader(Data: TNodeDictInfo; Rule: integer; Target: integer; Script: TStringList);
var
  descr, ot, r: string;

begin
  case Data.ObjType of
    cotFolder: ot := 'Папка';
    cotDict: ot := 'Справочник';
    cotForm: ot := 'Форма';
    cotWizard: ot := 'Сценарий';
    else ot := '<Неожиданный тип объекта>';
  end;

  case Rule of
    0: r := 'Создание (пересоздание)';
    1: r := 'Обновление';
    2: r := 'Удаление';
  end;

  descr := ot + ' - ' + VarToStr(Data.PK) + iif(VarIsNull(Data.Descriptor), '', ' : ' + Data.Descriptor) + ' : ' + VarToStr(Data.Title);

  Script.Add('/*');
  Script.Add('  Script generated by Dict Configurator, Ver.: ' + GetVersion(Application.ExeName));
  Script.Add('');
  Script.Add('  Объект:      ' + descr);
  Script.Add('  Правило:     ' + r);
  Script.Add('*/');
  Script.Add('');
  Script.Add('set term ^ ;');
  Script.Add('');

  if Rule = 0 then
  begin
    if (Data.ObjType = cotWizard) or (Target = 1) then Script.Add('delete from TMP_WIZARD_VAR^')
    else Script.Add('delete from TMP_VAR^');
    Script.Add('');
  end else
  begin
    Script.Add('execute block');
    Script.Add('as');
  end;
end;

procedure TFMain.SaveToSQL(Data: TNodeDictInfo; PkList: TStringList; FileName: string);
var
  sl: TStringList;

begin
  // выгрузка отдельных состояний сценария визардов
  if not Database.Connected then exit;
  if VarIsNull(Data.PK) then raise Exception.Create('Отсутствует PK узла!');
  if Data.ObjType <> cotWizard then raise Exception.Create('Данная возможность поддерживается только для Сценариев!');

  sl := TStringList.Create;
  try
    WriteSQLHeader(Data, 0, 1, sl);
    GenWizardStatesSQL(Data.PK, TextToString(PkList.Text), sl);
    WriteSQLFooter(Data, 0, 1, sl);
    sl.SaveToFile(FileName);
  finally
    sl.Free;
  end;
end;

end.
