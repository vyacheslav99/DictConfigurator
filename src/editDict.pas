unit editDict;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, settings, utils,
  main, ExtCtrls, DB, FIBDataSet, pFIBDataSet, DBGridEh, Mask, DBCtrlsEh, DBLookupEh, Spin, DBGridEhGrouping, GridsEh,
  MemTableDataEh, MemTableEh, FIBQuery, pFIBQuery, Math, groupEditor, fieldEditor, objectEditor, optControls, Menus,
  ComCtrls, DBAccess, Uni, UniProvider, PostgreSQLUniProvider, OracleUniProvider, MySQLUniProvider, InterBaseUniProvider,
  MemDS, dbUtils, fmEditForm, groupedit, selectRank, StrUtils, ActnList, chartEditor, previewForm, chartGroupEditor, childForm,
  tmplConstructor, copyRanks, fixRef, ToolWin, json, jsonReader, filterConfigEditor, eventEditor, filterGroupEditor, EhLibMTE,
  tmplEditor;

type
  TFEditDict = class(TChildForm)
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    dsForm: TpFIBDataSet;
    dsFormPK: TFIBIntegerField;
    dsFormTITLE: TFIBStringField;
    dsFormALIAS_FORM: TFIBStringField;
    dsFormCREATE_: TFIBDateTimeField;
    dsFormMODIFY: TFIBDateTimeField;
    dsFormWIDTH: TFIBIntegerField;
    dsFormHEIGHT: TFIBIntegerField;
    dsFormOWNER_USER_PK: TFIBIntegerField;
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
    dsoFormFields: TDataSource;
    mtFormFields: TMemTableEh;
    mtFormFieldsCHANGED: TBooleanField;
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
    qEditField: TpFIBQuery;
    dsGroups: TpFIBDataSet;
    mtGroups: TMemTableEh;
    dsoGroups: TDataSource;
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
    mtGroupsPK: TIntegerField;
    mtGroupsPARENT_PK: TIntegerField;
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
    dsFieldGroups: TpFIBDataSet;
    dsFieldGroupsPK: TFIBIntegerField;
    dsFieldGroupsTITLE: TFIBStringField;
    mtGroupsCHANGED: TBooleanField;
    qEditGroup: TpFIBQuery;
    dsGroupsCREATE_: TFIBDateTimeField;
    mtGroupsCREATE_: TDateTimeField;
    mtGroupsPARENT_TITLE: TStringField;
    dsFieldGroupsCOUNT_COLUMN: TFIBIntegerField;
    dsFormFieldsOBJECT_NAME: TFIBStringField;
    mtFormFieldsOBJECT_NAME: TStringField;
    pcMain: TPageControl;
    tsForm: TTabSheet;
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
    sbEditField: TSpeedButton;
    dbgFormFields: TDBGridEh;
    Label7: TLabel;
    sbAddGroup: TSpeedButton;
    sbEditGroup: TSpeedButton;
    sbDelGroup: TSpeedButton;
    dbgGroups: TDBGridEh;
    tsDict: TTabSheet;
    dsDict: TpFIBDataSet;
    dsObjectTree: TpFIBDataSet;
    dsDictPK: TFIBIntegerField;
    dsDictDESCRIPTOR_: TFIBStringField;
    dsDictTITLE: TFIBStringField;
    dsDictOWNER_USER_PK: TFIBIntegerField;
    dsDictCREATE_: TFIBDateTimeField;
    dsDictMODIFY: TFIBDateTimeField;
    dsDictORDER_BY: TFIBStringField;
    dsDictPARENT_REFERENCE_PK: TFIBIntegerField;
    dsDictMAIN_FORM_PK: TFIBIntegerField;
    dsDictSTART_FORM_PK: TFIBIntegerField;
    dsDictBASE_DESCRIPTOR: TFIBStringField;
    dsDictFOLDER_PK: TFIBIntegerField;
    dsDictPARENT_ID_FIELD: TFIBStringField;
    dsDictID_FIELD: TFIBStringField;
    dsDictEXPAND_REF: TFIBStringField;
    dsDictCOLLAPSE_FILTER: TFIBStringField;
    dsDictGROUPING: TFIBStringField;
    dsDictCON_ORIENT: TFIBSmallIntField;
    dsDictBRIEF_NOTE: TFIBIntegerField;
    dsDictEDITABLE: TFIBIntegerField;
    dsDictSET_DISTINCT: TFIBStringField;
    dsDictGROUP_EDIT_FORM_PK: TFIBIntegerField;
    dsDictSHOW_ONLY_ADMIN: TFIBSmallIntField;
    dsDictINSERT_COUNT: TFIBSmallIntField;
    dsDictEXPAND_TREE: TFIBIntegerField;
    dsDictUSE_MEM: TFIBIntegerField;
    dsDictCOUNT_ON_PAGE: TFIBIntegerField;
    dsDictDEFERRED_IMPORTS: TFIBSmallIntField;
    dsDictAUTOSAVEINTERVAL: TFIBIntegerField;
    dsDictSKIP_DUPLICATES: TFIBStringField;
    dsDictSHOW_FILTER_BOUND: TFIBStringField;
    Label8: TLabel;
    edDictPk: TEdit;
    Label9: TLabel;
    edDictDescriptor: TEdit;
    Label10: TLabel;
    edDictTitle: TEdit;
    dsParentDicts: TpFIBDataSet;
    dsParentDictsPK: TFIBIntegerField;
    dsParentDictsNAME: TFIBStringField;
    dsoParentDicts: TDataSource;
    lcbParentDict: TDBLookupComboboxEh;
    Label11: TLabel;
    Label12: TLabel;
    lcbFolder: TDBLookupComboboxEh;
    dsFolders: TpFIBDataSet;
    dsoFolders: TDataSource;
    dsFoldersPK: TFIBIntegerField;
    dsFoldersNAME: TFIBStringField;
    GroupBox1: TGroupBox;
    Label13: TLabel;
    cbDictBaseDescriptor: TComboBox;
    Label14: TLabel;
    dbgObjectTree: TDBGridEh;
    sbAddObject: TSpeedButton;
    sbEditObject: TSpeedButton;
    sbDelObject: TSpeedButton;
    dsoDictTreeFields: TDataSource;
    dsDictGroupingFields: TpFIBDataSet;
    dsoDictGroupingFields: TDataSource;
    dsDictGroupingFieldsFIELD_NAME: TFIBStringField;
    chbDictExpandRef: TCheckBox;
    chbDictCollapseFilter: TCheckBox;
    Label19: TLabel;
    cbDictConOrient: TComboBox;
    Label20: TLabel;
    edDictRefSize: TDBNumberEditEh;
    chbDictEditable: TCheckBox;
    chbDictSetDistinct: TCheckBox;
    chbDictShowOnlyAdmin: TCheckBox;
    Label21: TLabel;
    lcbDictDocument: TDBLookupComboboxEh;
    dsDocuments: TpFIBDataSet;
    dsoDocuments: TDataSource;
    dsDocumentsPK: TFIBIntegerField;
    chbDictUseMem: TCheckBox;
    Label23: TLabel;
    edDictCountOnPage: TDBNumberEditEh;
    chbDictDeferredImports: TCheckBox;
    Label22: TLabel;
    edDictAutosaveInterval: TDBNumberEditEh;
    chbDictSkipDuplicates: TCheckBox;
    Label24: TLabel;
    cbDictShowFilterBound: TComboBox;
    Label25: TLabel;
    sbAddSort: TSpeedButton;
    sbDelSort: TSpeedButton;
    dbgDictOrderBy: TDBGridEh;
    Label15: TLabel;
    Bevel2: TBevel;
    Label16: TLabel;
    lcbDictIdField: TDBLookupComboboxEh;
    Label17: TLabel;
    lcbDictParentIdField: TDBLookupComboboxEh;
    chbDictExpandTree: TCheckBox;
    Bevel3: TBevel;
    Label18: TLabel;
    lcbDictGrouping: TDBLookupComboboxEh;
    mtObjectTree: TMemTableEh;
    dsoObjectTree: TDataSource;
    dsObjectTreePK: TFIBIntegerField;
    dsObjectTreeOWNER_USER_PK: TFIBIntegerField;
    dsObjectTreeTITLE: TFIBStringField;
    dsObjectTreeNAME: TFIBStringField;
    dsObjectTreeOBJECT_TYPE: TFIBStringField;
    dsObjectTreeJOIN_PARENT_PK: TFIBIntegerField;
    dsObjectTreeIS_MULTI_JOIN: TFIBStringField;
    dsObjectTreeJOIN_FIELDS: TFIBStringField;
    dsObjectTreePARAMETERS: TFIBStringField;
    dsObjectTreeDELETED: TFIBIntegerField;
    dsObjectTreeINNER_JOIN: TFIBIntegerField;
    mtObjectTreePK: TIntegerField;
    mtObjectTreeTITLE: TStringField;
    mtObjectTreeNAME: TStringField;
    mtObjectTreeOBJECT_TYPE: TStringField;
    mtObjectTreeJOIN_PARENT_PK: TIntegerField;
    mtObjectTreeIS_MULTI_JOIN: TStringField;
    mtObjectTreeJOIN_FIELDS: TStringField;
    mtObjectTreePARAMETERS: TStringField;
    mtObjectTreeDELETED: TIntegerField;
    mtObjectTreeINNER_JOIN: TIntegerField;
    mtDictOrderBy: TMemTableEh;
    dsoDictOrderBy: TDataSource;
    mtDictOrderBySORT_TYPE: TStringField;
    mtDictOrderByFIELD: TStringField;
    mtDictOrderByFIELD_NAME: TStringField;
    dsOrderFields: TpFIBDataSet;
    tsPermRole: TTabSheet;
    tsFilterConfig: TTabSheet;
    tsGraph: TTabSheet;
    tsStartForm: TTabSheet;
    tsGroupEditForm: TTabSheet;
    dsJoinObjects: TpFIBDataSet;
    dsJoinObjectsPK: TFIBIntegerField;
    dsJoinObjectsNAME: TFIBStringField;
    mtObjectTreeJOIN_PARENT: TStringField;
    mtObjectTreeIS_MAIN: TBooleanField;
    dsTreeFieldsUni: TUniQuery;
    mtObjectTreeCHANGED: TBooleanField;
    mtObjectTreeOWNER_USER_PK: TIntegerField;
    mtDictOrderByORDER_: TIntegerField;
    sbAddField: TSpeedButton;
    sbDelField: TSpeedButton;
    dsJoinObjectsFORM_PK: TFIBIntegerField;
    dsJoinObjectsJOIN_PARENT_PK: TFIBIntegerField;
    qEditObject: TpFIBQuery;
    mtFormFieldsOBJECT_PK: TIntegerField;
    dsFormFieldsOBJECT_PK: TFIBIntegerField;
    pStartForm: TPanel;
    btnCreateStartForm: TButton;
    btnDelStartForm: TButton;
    dsStartForm: TpFIBDataSet;
    dsStartFormPK: TFIBIntegerField;
    dsStartFormTITLE: TFIBStringField;
    dsStartFormALIAS_FORM: TFIBStringField;
    dsStartFormCREATE_: TFIBDateTimeField;
    dsStartFormMODIFY: TFIBDateTimeField;
    dsStartFormWIDTH: TFIBIntegerField;
    dsStartFormHEIGHT: TFIBIntegerField;
    dsStartFormOWNER_USER_PK: TFIBIntegerField;
    dsJoinObjectsREF_PK: TFIBIntegerField;
    tsPermRank: TTabSheet;
    dsDictREF_SIZE: TFIBIntegerField;
    lbStartFormInfo: TLabel;
    mtInputParams: TMemTableEh;
    mtInputParamsNAME: TStringField;
    mtInputParamsTYPE: TStringField;
    mtInputParamsVALUE: TStringField;
    dsFieldsParams: TUniQuery;
    Panel1: TPanel;
    lbGrEditFormInfo: TLabel;
    btnCreateGrEditForm: TButton;
    btnDelGrEditForm: TButton;
    dsGrEditForm: TpFIBDataSet;
    dsGrEditFormPK: TFIBIntegerField;
    dsGrEditFormTITLE: TFIBStringField;
    dsGrEditFormALIAS_FORM: TFIBStringField;
    dsGrEditFormCREATE_: TFIBDateTimeField;
    dsGrEditFormMODIFY: TFIBDateTimeField;
    dsGrEditFormWIDTH: TFIBIntegerField;
    dsGrEditFormHEIGHT: TFIBIntegerField;
    dsGrEditFormOWNER_USER_PK: TFIBIntegerField;
    Label26: TLabel;
    sbAddPermRole: TSpeedButton;
    sbDelPermRole: TSpeedButton;
    dbgPermRoles: TDBGridEh;
    dsPermRoles: TpFIBDataSet;
    mtPermRoles: TMemTableEh;
    mtPermRolesCHANGED: TBooleanField;
    dsoPermRoles: TDataSource;
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
    mtPermRolesPK: TIntegerField;
    mtPermRolesROLE_PK: TIntegerField;
    mtPermRolesADD_: TIntegerField;
    mtPermRolesEDIT_: TIntegerField;
    mtPermRolesDEL_: TIntegerField;
    mtPermRolesVIEW_REF: TIntegerField;
    mtPermRolesCONFIG_: TIntegerField;
    mtPermRolesVIEW_: TIntegerField;
    mtPermRolesEXPORT: TIntegerField;
    mtPermRolesIMPORT: TIntegerField;
    dsRoles: TpFIBDataSet;
    dsRolesPK: TFIBIntegerField;
    dsRolesNAME: TFIBStringField;
    mtPermRolesROLE_NAME: TStringField;
    sbSaveRoleTemplate: TSpeedButton;
    mRoleTemplate: TMemo;
    dsTemplate: TpFIBDataSet;
    dsTemplateTEXT_TEMPLATE: TFIBStringField;
    qEditPermRole: TpFIBQuery;
    Label27: TLabel;
    sbAddPermRank: TSpeedButton;
    sbDelPermRank: TSpeedButton;
    dbgPermRanks: TDBGridEh;
    lbRankTmplName: TLabel;
    sbSaveRankTemplate: TSpeedButton;
    mRankTemplate: TMemo;
    dsPermRanks: TpFIBDataSet;
    mtPermRanks: TMemTableEh;
    mtPermRanksPK: TIntegerField;
    mtPermRanksROLE_PK: TIntegerField;
    mtPermRanksADD_: TIntegerField;
    mtPermRanksEDIT_: TIntegerField;
    mtPermRanksDEL_: TIntegerField;
    mtPermRanksVIEW_REF: TIntegerField;
    mtPermRanksCONFIG_: TIntegerField;
    mtPermRanksVIEW_: TIntegerField;
    mtPermRanksEXPORT: TIntegerField;
    mtPermRanksIMPORT: TIntegerField;
    mtPermRanksCHANGED: TBooleanField;
    dsoPermRanks: TDataSource;
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
    dsRankFullPath: TpFIBDataSet;
    mtPermRanksROLE_NAME: TStringField;
    qEditPermRank: TpFIBQuery;
    mUnitFullPath: TMemo;
    dsRankFullPathNEW_PARAM: TFIBStringField;
    sbGrEditPermRole: TSpeedButton;
    sbGrEditPermRank: TSpeedButton;
    ActionList: TActionList;
    ASave: TAction;
    sbAddAllFields: TSpeedButton;
    Label28: TLabel;
    sbAddChart: TSpeedButton;
    sbEditChart: TSpeedButton;
    sbDelChart: TSpeedButton;
    dbgChart: TDBGridEh;
    dsChart: TpFIBDataSet;
    mtChart: TMemTableEh;
    dsoChart: TDataSource;
    dsChartPK: TFIBIntegerField;
    dsChartX_FIELD_PK: TFIBIntegerField;
    dsChartX_FIELD_NAME: TFIBStringField;
    dsChartY_FIELD_PK: TFIBIntegerField;
    dsChartY_FIELD_NAME: TFIBStringField;
    dsChartGROUP_FUNCTION: TFIBStringField;
    dsChartSERIES_DIF: TFIBIntegerField;
    dsChartSD_FIELD_NAME: TFIBStringField;
    dsChartTITLE: TFIBStringField;
    dsChartCHART_TYPE: TFIBStringField;
    dsChartORDER_: TFIBStringField;
    dsChartX_AXIS_ROTATE: TFIBIntegerField;
    dsChartADDITIONAL_FIELD: TFIBStringField;
    dsChartADDITIONAL_FIELD_ROTATE: TFIBIntegerField;
    dsChartY_TITLE: TFIBStringField;
    mtChartPK: TIntegerField;
    mtChartX_FIELD_PK: TIntegerField;
    dsOrderFieldsPK: TFIBIntegerField;
    mtChartX_FIELD_NAME: TStringField;
    mtChartY_FIELD_PK: TIntegerField;
    mtChartY_FIELD_NAME: TStringField;
    mtChartGROUP_FUNCTION: TStringField;
    mtChartSERIES_DIF: TIntegerField;
    mtChartSD_FIELD_NAME: TStringField;
    mtChartTITLE: TStringField;
    mtChartCHART_TYPE: TStringField;
    mtChartORDER_: TStringField;
    mtChartX_AXIS_ROTATE: TIntegerField;
    mtChartADDITIONAL_FIELD: TStringField;
    mtChartADDITIONAL_FIELD_ROTATE: TIntegerField;
    mtChartY_TITLE: TStringField;
    mtChartCHANGED: TBooleanField;
    qEditChart: TpFIBQuery;
    btnPreviewForm: TButton;
    dsFormFieldsLOCKED: TFIBIntegerField;
    mtFormFieldsLOCKED: TIntegerField;
    Label29: TLabel;
    sbAddChartGroup: TSpeedButton;
    sbEditChartGroup: TSpeedButton;
    sbDelChartGroup: TSpeedButton;
    dbgChartGroup: TDBGridEh;
    dsChartGroup: TpFIBDataSet;
    mtChartGroup: TMemTableEh;
    dsoChartGroup: TDataSource;
    dsChartGroupPK: TFIBIntegerField;
    dsChartGroupTITLE: TFIBStringField;
    dsChartGroupORIENTATION: TFIBStringField;
    mtChartGroupPK: TIntegerField;
    mtChartGroupTITLE: TStringField;
    mtChartGroupORIENTATION: TStringField;
    mtChartGroupCHANGED: TBooleanField;
    qEditChartGroup: TpFIBQuery;
    dsChartGROUP_PK: TFIBIntegerField;
    dsChartGROUP_ORDER: TFIBIntegerField;
    mtChartGROUP_PK: TIntegerField;
    mtChartGROUP_ORDER: TIntegerField;
    dsChartGroups: TpFIBDataSet;
    dsChartGroupsPK: TFIBIntegerField;
    dsChartGroupsTITLE: TFIBStringField;
    mtChartGROUP_NAME: TStringField;
    sbUpdateRankTemplate: TSpeedButton;
    sbUpdateRoleTemplate: TSpeedButton;
    chbLeftAlign: TCheckBox;
    dsFormLEFT_ALIGN: TFIBIntegerField;
    dsGroupsLEFT_ALIGN: TFIBIntegerField;
    mtGroupsLEFT_ALIGN: TIntegerField;
    dsGrEditFormLEFT_ALIGN: TFIBIntegerField;
    dsStartFormLEFT_ALIGN: TFIBIntegerField;
    AGridOptions: TAction;
    pmGrid: TPopupMenu;
    N1: TMenuItem;
    Label30: TLabel;
    edLabelWidth: TDBNumberEditEh;
    dsFormLABEL_WIDTH: TFIBIntegerField;
    dsStartFormLABEL_WIDTH: TFIBIntegerField;
    dsGrEditFormLABEL_WIDTH: TFIBIntegerField;
    dsGroupsLABEL_WIDTH: TFIBIntegerField;
    mtGroupsLABEL_WIDTH: TIntegerField;
    dsOrderFieldsUni: TUniQuery;
    dsOrderFieldsFIELD_NAME: TFIBStringField;
    sbReCreateChildTableFields: TSpeedButton;
    sbEditRankTemplate: TSpeedButton;
    sbEditRoleTemplate: TSpeedButton;
    lbRoleTmplName: TLabel;
    tsDummy: TTabSheet;
    sbCopyPermRanks: TSpeedButton;
    sbCopyPermRoles: TSpeedButton;
    btnRefresh: TBitBtn;
    edCurrField: TEdit;
    chbCheckSelect: TCheckBox;
    dsDictCHECK_SELECT: TFIBIntegerField;
    dsFilterConfig: TpFIBDataSet;
    mtFilterConfig: TMemTableEh;
    dsoFilterConfig: TDataSource;
    dsFilterConfigPK: TFIBIntegerField;
    dsFilterConfigNAME: TFIBStringField;
    dsFilterConfigFILTER_VALUE: TFIBStringField;
    mtFilterConfigCHANGED: TBooleanField;
    mtFilterConfigPK: TIntegerField;
    mtFilterConfigNAME: TStringField;
    mtFilterConfigFILTER_VALUE: TStringField;
    Label31: TLabel;
    sbAddFilterConfig: TSpeedButton;
    sbEditFilterConfig: TSpeedButton;
    sbDelFilterConfig: TSpeedButton;
    dbgFilterConfig: TDBGridEh;
    qEditFilterConfig: TpFIBQuery;
    dsChartGroupsREFERENCE_PK: TFIBIntegerField;
    dsChartGroupsDESCRIPTOR_: TFIBStringField;
    dsChartGroupsREF_TITLE: TFIBStringField;
    tsWizard: TTabSheet;
    dsWizard: TpFIBDataSet;
    dsoWizard: TDataSource;
    dbgWizard: TDBGridEh;
    Label32: TLabel;
    sbAddWizard: TSpeedButton;
    sbEditWizard: TSpeedButton;
    sbDelWizard: TSpeedButton;
    sbRefreshWizardList: TSpeedButton;
    dsFoldersPARENT_PK: TFIBIntegerField;
    dsFoldersPARENT_NAME: TFIBStringField;
    pmRefLink: TPopupMenu;
    miPreviewRef: TMenuItem;
    miCopyRefLink: TMenuItem;
    tsOtherEvents: TTabSheet;
    Label33: TLabel;
    sbAddEvent: TSpeedButton;
    sbEditEvent: TSpeedButton;
    sbDelEvent: TSpeedButton;
    dbgOtherEvents: TDBGridEh;
    dsOtherEvents: TpFIBDataSet;
    mtOtherEvents: TMemTableEh;
    dsoOtherEvents: TDataSource;
    dsOtherEventsID_EV: TFIBIntegerField;
    dsOtherEventsID_DF_REFERENCE: TFIBIntegerField;
    dsOtherEventsTITLE_EV: TFIBStringField;
    dsOtherEventsEVENT_REFERENCE: TFIBIntegerField;
    dsOtherEventsPOSITION_EV: TFIBIntegerField;
    dsOtherEventsIMAGE_NAME_EV: TFIBStringField;
    dsOtherEventsVIEW_TO_MENU: TFIBSmallIntField;
    dsOtherEventsCLASS_NAME: TFIBStringField;
    dsOtherEventsIS_VIZARD: TFIBIntegerField;
    dsOtherEventsALIAS_DF: TFIBStringField;
    dsOtherEventsLINK_METHOD: TFIBStringField;
    mtOtherEventsID_EV: TIntegerField;
    mtOtherEventsTITLE_EV: TStringField;
    mtOtherEventsEVENT_REFERENCE: TIntegerField;
    dsEvtDicts: TpFIBDataSet;
    dsEvtDictsPK: TFIBIntegerField;
    dsEvtDictsDESCRIPTOR_: TFIBStringField;
    dsEvtDictsTITLE: TFIBStringField;
    mtOtherEventsEVT_REF_NAME: TStringField;
    mtOtherEventsPOSITION_EV: TIntegerField;
    mtOtherEventsIMAGE_NAME_EV: TStringField;
    mtOtherEventsVIEW_TO_MENU: TIntegerField;
    mtOtherEventsCLASS_NAME: TStringField;
    mtOtherEventsIS_VIZARD: TIntegerField;
    dsEvtWizards: TpFIBDataSet;
    dsEvtWizardsPK: TFIBIntegerField;
    dsEvtWizardsDESCRIPTOR_: TFIBStringField;
    dsEvtWizardsNAME: TFIBStringField;
    dsEvtWizardsSCEN_TYPE: TFIBStringField;
    dsEvtWizardsREF_PK: TFIBIntegerField;
    dsEvtWizardsREF_DESCR: TFIBStringField;
    dsEvtWizardsTITLE: TFIBStringField;
    mtOtherEventsWIZARD_NAME: TStringField;
    mtOtherEventsALIAS_DF: TStringField;
    dsEvtForms: TpFIBDataSet;
    dsEvtFormsPK: TFIBIntegerField;
    dsEvtFormsALIAS_FORM: TFIBStringField;
    dsEvtFormsTITLE: TFIBStringField;
    mtOtherEventsFORM_NAME: TStringField;
    mtOtherEventsLINK_METHOD: TStringField;
    mtOtherEventsCHANGED: TBooleanField;
    dsoEvtDicts: TDataSource;
    dsoEvtWizards: TDataSource;
    dsoEvtForms: TDataSource;
    qEditOtherEvent: TpFIBQuery;
    mtOtherEventsID_DF_REFERENCE: TIntegerField;
    ToolBar: TToolBar;
    tbGenSQL: TToolButton;
    tbLink: TToolButton;
    btnRecalcTree: TButton;
    ToolButton1: TToolButton;
    tbFix: TToolButton;
    ToolButton2: TToolButton;
    tbSave: TToolButton;
    tbRefresh: TToolButton;
    ToolButton3: TToolButton;
    tbBuildSelect: TToolButton;
    tsFilterGroups: TTabSheet;
    Label34: TLabel;
    sbAddFilterGroup: TSpeedButton;
    sbEditFilterGroup: TSpeedButton;
    sbDelFilterGroup: TSpeedButton;
    dbgFilterGroup: TDBGridEh;
    dsFilterGroup: TpFIBDataSet;
    mtFilterGroup: TMemTableEh;
    dsoFilterGroup: TDataSource;
    dsFilterGroupPK: TFIBIntegerField;
    dsFilterGroupTITLE: TFIBStringField;
    dsFilterGroupORDER_: TFIBIntegerField;
    dsFilterGroupCOLLAPSED: TFIBStringField;
    mtFilterGroupPK: TIntegerField;
    mtFilterGroupTITLE: TStringField;
    mtFilterGroupORDER_: TIntegerField;
    mtFilterGroupCOLLAPSED: TStringField;
    mtFilterGroupCHANGED: TBooleanField;
    qEditFilterGroup: TpFIBQuery;
    dsFormFieldsFILTER_GROUP: TFIBIntegerField;
    dsLFilterGroups: TpFIBDataSet;
    dsLFilterGroupsPK: TFIBIntegerField;
    dsLFilterGroupsTITLE: TFIBStringField;
    mtFormFieldsFILTER_GROUP: TIntegerField;
    mtFormFieldsFILTER_GROUP_NAME: TStringField;
    dsWizardTYPE_: TFIBIntegerField;
    dsWizardTYPE_NAME: TFIBStringField;
    dsWizardPK: TFIBIntegerField;
    dsWizardNAME: TFIBStringField;
    dsWizardSCEN_TYPE: TFIBStringField;
    dsWizardDESCRIPTOR_: TFIBStringField;
    dsWizardNO_MES: TFIBStringField;
    dsWizardREF_PK: TFIBIntegerField;
    dsWizardREF_DESCRIPTOR: TFIBStringField;
    dsWizardTITLE: TFIBStringField;
    mtDictOrderByNULLS: TStringField;
    tbJumpToTree: TToolButton;
    tbGenDictWizardsSQL: TToolButton;
    dsFormFieldsIS_VISIBLE: TFIBIntegerField;
    dsFormFieldsGRID_VISIBLE: TFIBIntegerField;
    dsFormFieldsEDITABLE: TFIBIntegerField;
    dsFormFieldsIS_VISIBLE_ADD: TFIBIntegerField;
    dsFormFieldsEDIT_IN_TABLE: TFIBIntegerField;
    mtFormFieldsIS_VISIBLE: TIntegerField;
    mtFormFieldsGRID_VISIBLE: TIntegerField;
    mtFormFieldsIS_VISIBLE_ADD: TIntegerField;
    mtFormFieldsEDIT_IN_TABLE: TIntegerField;
    dsPostFilter: TpFIBDataSet;
    mtPostFilter: TMemTableEh;
    dsoPostFilter: TDataSource;
    dsPostFilterPK: TFIBIntegerField;
    dsPostFilterFILTER_CONFIG_PK: TFIBIntegerField;
    dsPostFilterPOST_PK: TFIBIntegerField;
    dsPostFilterPOST_NAME: TFIBStringField;
    mtPostFilterPK: TIntegerField;
    mtPostFilterFILTER_CONFIG_PK: TIntegerField;
    mtPostFilterPOST_PK: TIntegerField;
    mtPostFilterPOST_NAME: TStringField;
    mtPostFilterCHANGED: TBooleanField;
    dbgPostFilter: TDBGridEh;
    Label35: TLabel;
    sbAddPostFilter: TSpeedButton;
    sbDelPostFilter: TSpeedButton;
    qAddPostFilter: TpFIBQuery;
    AExportToExcel: TAction;
    AExportToCsv: TAction;
    Excel1: TMenuItem;
    csv1: TMenuItem;
    dsPermRanksGRID_SAVE: TFIBIntegerField;
    dsPermRolesGRID_SAVE: TFIBIntegerField;
    mtPermRanksGRID_SAVE: TIntegerField;
    mtPermRolesGRID_SAVE: TIntegerField;
    dsDictGUID: TFIBStringField;
    dsFormGUID: TFIBStringField;
    dsStartFormGUID: TFIBStringField;
    dsGrEditFormGUID: TFIBStringField;
    dsChartGUID: TFIBStringField;
    dsChartGroupsGUID: TFIBStringField;
    dsPermRanksGUID: TFIBStringField;
    dsPermRolesGUID: TFIBStringField;
    dsObjectTreeGUID: TFIBStringField;
    dsFormFieldsGUID: TFIBStringField;
    dsGroupsGUID: TFIBStringField;
    dsChartGroupGUID: TFIBStringField;
    dsOtherEventsGUID: TFIBStringField;
    dsFilterGroupGUID: TFIBStringField;
    dsFilterConfigGUID: TFIBStringField;
    dsWizardGUID: TFIBStringField;
    mtChartGUID: TStringField;
    mtPermRanksGUID: TStringField;
    mtPermRolesGUID: TStringField;
    mtObjectTreeGUID: TStringField;
    mtFormFieldsGUID: TStringField;
    mtGroupsGUID: TStringField;
    mtChartGroupGUID: TStringField;
    mtFilterGroupGUID: TStringField;
    mtFilterConfigGUID: TStringField;
    mtOtherEventsGUID: TStringField;
    dsPostFilterGUID: TFIBStringField;
    mtPostFilterGUID: TStringField;
    procedure StdMemTableBeforePost(DataSet: TDataSet);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbAddFieldClick(Sender: TObject);
    procedure sbEditFieldClick(Sender: TObject);
    procedure sbDelFieldClick(Sender: TObject);
    procedure mtFormFieldsBeforePost(DataSet: TDataSet);
    procedure dbgFormFieldsGetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure mtFormFieldsAfterInsert(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure mtFormFieldsBeforeDelete(DataSet: TDataSet);
    procedure sbAddGroupClick(Sender: TObject);
    procedure sbEditGroupClick(Sender: TObject);
    procedure sbDelGroupClick(Sender: TObject);
    procedure mtGroupsAfterInsert(DataSet: TDataSet);
    procedure mtGroupsBeforeDelete(DataSet: TDataSet);
    procedure mtGroupsBeforePost(DataSet: TDataSet);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgFormFieldsDblClick(Sender: TObject);
    procedure dbgGroupsDblClick(Sender: TObject);
    procedure cbDictBaseDescriptorChange(Sender: TObject);
    procedure sbAddObjectClick(Sender: TObject);
    procedure sbEditObjectClick(Sender: TObject);
    procedure sbDelObjectClick(Sender: TObject);
    procedure dbgObjectTreeDblClick(Sender: TObject);
    procedure sbAddSortClick(Sender: TObject);
    procedure sbDelSortClick(Sender: TObject);
    procedure mtObjectTreeBeforeDelete(DataSet: TDataSet);
    procedure mtObjectTreeBeforePost(DataSet: TDataSet);
    procedure mtObjectTreeAfterDelete(DataSet: TDataSet);
    procedure mtObjectTreeAfterInsert(DataSet: TDataSet);
    procedure edDictTitleChange(Sender: TObject);
    procedure lcbParentDictChange(Sender: TObject);
    procedure btnCreateStartFormClick(Sender: TObject);
    procedure btnDelStartFormClick(Sender: TObject);
    procedure btnCreateGrEditFormClick(Sender: TObject);
    procedure btnDelGrEditFormClick(Sender: TObject);
    procedure mtPermRolesAfterInsert(DataSet: TDataSet);
    procedure mtPermRolesBeforeDelete(DataSet: TDataSet);
    procedure mtPermRolesBeforePost(DataSet: TDataSet);
    procedure sbAddPermRoleClick(Sender: TObject);
    procedure sbDelPermRoleClick(Sender: TObject);
    procedure dbgPermRolesColEnter(Sender: TObject);
    procedure mtPermRolesAfterScroll(DataSet: TDataSet);
    procedure sbSaveRoleTemplateClick(Sender: TObject);
    procedure sbAddPermRankClick(Sender: TObject);
    procedure sbDelPermRankClick(Sender: TObject);
    procedure mtPermRanksAfterInsert(DataSet: TDataSet);
    procedure mtPermRanksAfterScroll(DataSet: TDataSet);
    procedure mtPermRanksBeforeDelete(DataSet: TDataSet);
    procedure mtPermRanksBeforePost(DataSet: TDataSet);
    procedure sbSaveRankTemplateClick(Sender: TObject);
    procedure sbGrEditPermRoleClick(Sender: TObject);
    procedure sbGrEditPermRankClick(Sender: TObject);
    procedure dbgPermRanksKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ASaveExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure dbgObjectTreeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgFormFieldsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgGroupsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbAddAllFieldsClick(Sender: TObject);
    procedure sbAddChartClick(Sender: TObject);
    procedure sbEditChartClick(Sender: TObject);
    procedure sbDelChartClick(Sender: TObject);
    procedure mtChartBeforeDelete(DataSet: TDataSet);
    procedure mtChartBeforePost(DataSet: TDataSet);
    procedure dbgChartDblClick(Sender: TObject);
    procedure dbgChartKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mtFormFieldsAfterPost(DataSet: TDataSet);
    procedure btnPreviewFormClick(Sender: TObject);
    procedure mtChartGroupBeforeDelete(DataSet: TDataSet);
    procedure sbAddChartGroupClick(Sender: TObject);
    procedure sbEditChartGroupClick(Sender: TObject);
    procedure sbDelChartGroupClick(Sender: TObject);
    procedure dbgChartGroupDblClick(Sender: TObject);
    procedure dbgChartGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AGridOptionsExecute(Sender: TObject);
    procedure sbReCreateChildTableFieldsClick(Sender: TObject);
    procedure mtDictOrderByBeforeOpen(DataSet: TDataSet);
    procedure sbEditRankTemplateClick(Sender: TObject);
    procedure sbEditRoleTemplateClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure sbCopyPermRanksClick(Sender: TObject);
    procedure btnFixClick(Sender: TObject);
    procedure mtFormFieldsAfterScroll(DataSet: TDataSet);
    procedure dbgFormFieldsColumns19EditButtonClick(Sender: TObject; var Handled: Boolean);
    procedure dbgGroupsColumns12EditButtonClick(Sender: TObject; var Handled: Boolean);
    procedure dbgObjectTreeColumns9EditButtonClick(Sender: TObject; var Handled: Boolean);
    procedure dbgObjectTreeColumns8EditButtonClick(Sender: TObject; var Handled: Boolean);
    procedure mtFilterConfigBeforeDelete(DataSet: TDataSet);
    procedure dbgFilterConfigKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbAddFilterConfigClick(Sender: TObject);
    procedure sbEditFilterConfigClick(Sender: TObject);
    procedure sbDelFilterConfigClick(Sender: TObject);
    procedure dbgFilterConfigColumns2EditButtonClick(Sender: TObject; var Handled: Boolean);
    procedure sbAddWizardClick(Sender: TObject);
    procedure dbgWizardKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbEditWizardClick(Sender: TObject);
    procedure dbgWizardDblClick(Sender: TObject);
    procedure sbDelWizardClick(Sender: TObject);
    procedure sbRefreshWizardListClick(Sender: TObject);
    procedure miCopyRefLinkClick(Sender: TObject);
    procedure miPreviewRefClick(Sender: TObject);
    procedure sbAddEventClick(Sender: TObject);
    procedure sbEditEventClick(Sender: TObject);
    procedure sbDelEventClick(Sender: TObject);
    procedure dbgOtherEventsDblClick(Sender: TObject);
    procedure dbgOtherEventsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mtOtherEventsBeforeDelete(DataSet: TDataSet);
    procedure tbGenSQLClick(Sender: TObject);
    procedure tbFixClick(Sender: TObject);
    procedure tbRefreshClick(Sender: TObject);
    procedure btnRecalcTreeClick(Sender: TObject);
    procedure dbgFormFieldsFillSTFilterListValues(Sender: TCustomDBGridEh; Column: TColumnEh; Items: TStrings; var Processed: Boolean);
    procedure tbBuildSelectClick(Sender: TObject);
    procedure mtFilterGroupBeforeDelete(DataSet: TDataSet);
    procedure sbAddFilterGroupClick(Sender: TObject);
    procedure sbEditFilterGroupClick(Sender: TObject);
    procedure sbDelFilterGroupClick(Sender: TObject);
    procedure dbgFilterGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tbJumpToTreeClick(Sender: TObject);
    procedure tbGenDictWizardsSQLClick(Sender: TObject);
    procedure sbAddPostFilterClick(Sender: TObject);
    procedure mtPostFilterBeforeDelete(DataSet: TDataSet);
    procedure sbDelPostFilterClick(Sender: TObject);
    procedure dbgPostFilterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mtFilterConfigAfterScroll(DataSet: TDataSet);
    procedure AExportToExcelExecute(Sender: TObject);
    procedure AExportToCsvExecute(Sender: TObject);
    procedure dbgFormFieldsColumns6EditButtonClick(Sender: TObject; var Handled: Boolean);
  private
    DeletedFields: TStringList;
    DeletedGroups: TStringList;
    DeletedObjects: TStringList;
    DeletedPermRoles: TStringList;
    DeletedPermRanks: TStringList;
    DeletedCharts: TStringList;
    DeletedChartGroups: TStringList;
    DeletedFilterConfigs: TStringList;
    DeletedEvents: TStringList;
    DeletedFilterGroups: TStringList;
    DeletedPostFilters: TStringList;
    IsLoadingGrid: boolean;
    MainObjPk: Variant;
    StartForm: TfrmEditForm;
    GrEditForm: TfrmEditForm;
    OldParentRefPk: Variant;
    function GetObjectNames(getPk: boolean = false): string;
    function GetMainObjectName: string;
    function SaveData: boolean;
    procedure SaveGridData(MainFormPk, GrFormPk, StartFormPk: Variant);
    procedure SaveFields(FormPk: Integer; Fields: TMemTableEh; DelList: TStringList);
    procedure SaveGroups(FormPk: Integer; Groups: TMemTableEh; DelList: TStringList);
    procedure SavePermissions(dsSrc: TMemTableEh; SaveQuery: TpFIBQuery; DelList: TStringList);
    procedure AddChildRefField(OldParentPk: Variant);
    procedure SetMode(Value: TOpenMode); override;
    procedure SetProperties(Value: TNodeDictInfo); override;
    procedure LoadObjectTree;
    procedure LoadFormFields;
    procedure LoadFormGroups;
    procedure LoadLookups;
    procedure LoadPermRoles;
    procedure LoadPermRanks;
    procedure LoadChartGroups;
    procedure LoadCharts;
    procedure LoadFilterConfigs;
    procedure LoadPostFilters;
    procedure LoadOrders;
    procedure LoadOtherEvents;
    procedure LoadFilterGroups;
    procedure ReloadWizards;
    function GetOrders: string;
    procedure ChangeBaseDescriptor;
    procedure AutoIncFields;
    procedure AutoIncGroups;
    procedure AutoIncEvtPos;
    procedure AutoIncFilterGroup;
    procedure LoadJoinFields(dsDest: TMemTableEh; FieldsStr: string);
    function GetJoinFields(dsSrc: TMemTableEh): string;
    procedure LoadPrimaryKeys(dsDest: TMemTableEh; FieldsStr: string);
    function GetPrimaryKeys(dsSrc: TMemTableEh): string;
    procedure LoadInputParams(dsDest: TMemTableEh; ParamsStr: string; CanClear: boolean = true);
    function GetInputParams(dsSrc: TMemTableEh): string;
    procedure ApplyGroupEditorData(FGroupEditor: TFGroupEditor);
    procedure ApplyFieldEditorData(FFieldEditor: TFFieldEditor);
    procedure ApplyObjectEditorData(FObjectEditor: TFObjectEditor);
    procedure ApplyChartEditorData(FChartEditor: TFChartEditor);
    procedure ApplyChartGroupEditorData(FChartGroupEditor: TFChartGroupEditor);
    procedure ApplyJsonEditorData(FJsonReader: TFJsonReader);
    procedure ApplyFilterConfigEditorData(FFilterConfigEditor: TFFilterConfigEditor);
    procedure ApplyEventEditorData(FEventEditor: TFEventEditor);
    procedure ApplyFilterGroupEditorData(FFilterGroupEditor: TFFilterGroupEditor);
    procedure ApplyFieldTmplEditorData(FTmplEditor: TFTmplEditor);
    procedure ObjectTreeAfterChange;
    procedure SetSystemFieldsSQL(DataSet: TUniQuery; BaseDescriptor: string; AddInputParams: boolean = false);
    procedure InitStartForm;
    procedure AutoCreateStartForm;
    function CanStdStartForm: boolean;
    procedure PrepareStartForm;
    procedure CreateGrEditForm;
    procedure CheckGrEditFormFields;
    procedure CheckGrEditFormField;
    function GetRankFullPath(RankPk: integer): string;
    procedure GroupEdit(Grid: TDBGridEh);
    procedure FillFieldsList;
    procedure BuildTreeIndex;
    function NumerateTree(TreeConnIdx: integer; ParentId: Variant; n, Level: integer; IdField, ParentIdField: string): integer;
    procedure SetFrameGridOptions(Options: TGridParams); override;
    procedure UpdateChildTableFields;
    function ExtractParamValue(Params, ParamName: string): string;
    procedure CopyPermissions(isRank: boolean);
    procedure PrepareFix;
    function FixOracle(FormFix: TFFixReference; Test: boolean): boolean;
    procedure FixReference(FormFix: TFFixReference; Test: boolean);
    function ReplaceTemplateText(TmplPk: Variant; OldStr, NewStr: string): string;
    procedure _Save;
    procedure _Reload;
    function OpenJsonEditor(Field: TField; StatusText: string): TFJsonReader;
    function BuildSelectSQL: string;
    procedure LoadUserParams(UserID: integer; Strings: TStringList);
    procedure TemplateToUserParams(UserParams, Strings: TStringList);
    // генерация скрипта изменений
    function gcsMainForm(Script, Vars: TStringList): boolean;
    function gcsExtForm(Script, Vars: TStringList; ExtForm: TfrmEditForm; isStartForm: boolean): boolean;
    function gcsReference(Script, Vars: TStringList): boolean;
    function gcsDbObjects(Script, Vars, Cache: TStringList): boolean;
    function gcsGroups(Script, Vars, Deleted, Cache: TStringList; FormKeyParam: string; Data: TMemTableEh): boolean;
    function gcsFilterGroups(Script, Vars, Cache: TStringList): boolean;
    function gcsFields(Script, Vars, Deleted, ObjCache, GrCache, TmplCache, FGrCache: TStringList; FormKeyParam: string; Data: TMemTableEh): boolean;
    function gcsTemplates(Script, Vars, Cache, PkList: TStringList): boolean;
    function gcsPermissions(Script, Vars, Deleted, TmplCache: TStringList; Data: TMemTableEh): boolean;
    function gcsFilterConfigs(Script, Vars, Cache: TStringList): boolean;
    function gcsPostFilter(Script, Vars, FcfgCache: TStringList): boolean;
    function gcsChartGroups(Script, Vars, Cache: TStringList): boolean;
    function gcsCharts(Script, Vars, cgrCache, fldCache: TStringList): boolean;
    function gcsEvents(Script, Vars: TStringList): boolean;
    function GenChangesSQL(Script, Vars: TStringList): boolean; override;
  public
    procedure LoadTemplate(Memo: TMemo; TmplPk: integer); overload;
    function LoadTemplate(TmplPk: integer): string; overload;
    function SaveTemplate(TmplText: string; TmplPk: Variant; Insert, ConvertToUni: boolean): Variant;
    function GetNotInvolvedFields(Fields: TMemTableEh; AddProcParams: boolean = false): string;
    procedure LoadFieldTypeParams(OptList: TContainer; OptionsStr: string);
    function GetFieldTypeParams(OptList: TContainer): string;
    procedure LoadColumnStyles(dsDest: TMemTableEh; StylesStr: string);
    function GetColumnStyles(dsSrc: TMemTableEh): string;
    procedure OnGroupEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure OnFieldEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure OnObjectEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure OnChartEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure OnChartGroupEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure OnJsonEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure OnFilterConfigEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure OnEventEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure OnFilterGroupEditorClose(Sender: TObject; var Action: TCloseAction);
    procedure OnFieldTmplEditorClose(Sender: TObject; var Action: TCloseAction);
    function GetShortCaption: string; override;
    procedure ExecFix(FormFix: TFFixReference; Test: boolean = false);
    function GetObjectPkField(ObjectName: string): string;
  end;

implementation

{$R *.dfm}

uses field, editWizard, scriptEditor;

procedure TFEditDict.AExportToCsvExecute(Sender: TObject);
begin                               
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToCsv(TDBGridEh(ActiveControl), edDictTitle.Text);
end;

procedure TFEditDict.AExportToExcelExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToExcel(TDBGridEh(ActiveControl), edDictTitle.Text);
end;

procedure TFEditDict.AGridOptionsExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FSettings.GridParamsDialog(TDBGridEh(ActiveControl), ClassName);
end;

procedure TFEditDict.ApplyChartEditorData(FChartEditor: TFChartEditor);
begin
  mtChart.DisableControls;
  try
    if FChartEditor.Mode = omAdd then mtChart.Append
    else begin
      if mtChart.BookmarkValid(FChartEditor.EditingRec) then
      begin
        mtChart.GotoBookmark(FChartEditor.EditingRec);
        mtChart.Edit;
      end else
      begin
        if Application.MessageBox('Редактируемая запись была удалена! Восстановить?', 'Подтверждение',
          MB_YESNO + MB_ICONWARNING) = ID_YES then
        begin
          mtChart.Append;
        end else exit;
      end;
    end;

    if FChartEditor.edTitle.Text = '' then mtChartTITLE.Clear
    else mtChartTITLE.AsString := FChartEditor.edTitle.Text;
    if FChartEditor.cbChartType.ItemIndex = -1 then mtChartCHART_TYPE.Clear
    else mtChartCHART_TYPE.AsString := FChartEditor.cbChartType.Items.Strings[FChartEditor.cbChartType.ItemIndex];
    mtChart.FieldByName('GROUP_PK').Value := FChartEditor.lcbGroup.KeyValue;
    mtChart.FieldByName('GROUP_ORDER').Value := FChartEditor.edGroupOrder.Value;
    mtChart.FieldByName('X_FIELD_PK').Value := FChartEditor.lcbXField.KeyValue;
    mtChart.FieldByName('Y_FIELD_PK').Value := FChartEditor.lcbYField.KeyValue;
    mtChart.FieldByName('SERIES_DIF').Value := FChartEditor.lcbSDField.KeyValue;
    if FChartEditor.GruopFunction = '' then mtChartGROUP_FUNCTION.Clear
    else mtChartGROUP_FUNCTION.AsString := FChartEditor.GruopFunction;
    mtChart.FieldByName('X_AXIS_ROTATE').Value := FChartEditor.edXAxisRotate.Value;
    if FChartEditor.edOrder.Text = '' then mtChartORDER_.Clear
    else mtChartORDER_.AsString := FChartEditor.edOrder.Text;
    if FChartEditor.edYTitle.Text = '' then mtChartY_TITLE.Clear
    else mtChartY_TITLE.AsString := FChartEditor.edYTitle.Text;
    mtChart.FieldByName('ADDITIONAL_FIELD_ROTATE').Value := FChartEditor.edAdditionalFieldRotate.Value;
    if FChartEditor.mAdditionalField.Text = '' then mtChartADDITIONAL_FIELD.Clear
    else mtChartADDITIONAL_FIELD.AsString := FChartEditor.mAdditionalField.Text;
    mtChart.Post;
  finally
    mtChart.EnableControls;
  end;
end;

procedure TFEditDict.ApplyChartGroupEditorData(FChartGroupEditor: TFChartGroupEditor);
begin
  mtChartGroup.DisableControls;
  try
    if FChartGroupEditor.Mode = omAdd then mtChartGroup.Append
    else begin
      if mtChartGroup.BookmarkValid(FChartGroupEditor.EditingRec) then
      begin
        mtChartGroup.GotoBookmark(FChartGroupEditor.EditingRec);
        mtChartGroup.Edit;
      end else
      begin
        if Application.MessageBox('Редактируемая запись была удалена! Восстановить?', 'Подтверждение',
          MB_YESNO + MB_ICONWARNING) = ID_YES then
        begin
          mtChartGroup.Append;
        end else exit;
      end;
    end;

    if FChartGroupEditor.edTitle.Text = '' then mtChartGroupTITLE.Clear
    else mtChartGroupTITLE.AsString := FChartGroupEditor.edTitle.Text;
    if FChartGroupEditor.cbOrientation.ItemIndex = -1 then mtChartGroupORIENTATION.Clear
    else mtChartGroupORIENTATION.AsString := FChartGroupEditor.Orientations.Strings[FChartGroupEditor.cbOrientation.ItemIndex];
    mtChartGroup.Post;
  finally
    mtChartGroup.EnableControls;
  end;
end;

procedure TFEditDict.ApplyEventEditorData(FEventEditor: TFEventEditor);
begin
  mtOtherEvents.DisableControls;
  try
    if FEventEditor.Mode = omAdd then mtOtherEvents.Append
    else begin
      if mtOtherEvents.BookmarkValid(FEventEditor.EditingRec) then
      begin
        mtOtherEvents.GotoBookmark(FEventEditor.EditingRec);
        mtOtherEvents.Edit;
      end else
      begin
        if Application.MessageBox('Редактируемая запись была удалена! Восстановить?', 'Подтверждение',
          MB_YESNO + MB_ICONWARNING) = ID_YES then
        begin
          mtOtherEvents.Append;
        end else exit;
      end;
    end;

    if FEventEditor.edTitle.Text = '' then mtOtherEventsTITLE_EV.Clear
    else mtOtherEventsTITLE_EV.AsString := FEventEditor.edTitle.Text;
    if FEventEditor.edPosition.Value < 0 then mtOtherEventsPOSITION_EV.AsInteger := 0
    else mtOtherEventsPOSITION_EV.AsInteger := FEventEditor.edPosition.Value;
    mtOtherEventsVIEW_TO_MENU.AsInteger := FEventEditor.cbViewToMenu.ItemIndex;
    if Trim(FEventEditor.edImage.Text) = '' then mtOtherEventsIMAGE_NAME_EV.Clear
    else mtOtherEventsIMAGE_NAME_EV.AsString := Trim(FEventEditor.edImage.Text);
    if Trim(FEventEditor.edCssClassName.Text) = '' then mtOtherEventsCLASS_NAME.Clear
    else mtOtherEventsCLASS_NAME.AsString := Trim(FEventEditor.edCssClassName.Text);
    mtOtherEventsEVENT_REFERENCE.AsVariant := FEventEditor.lcbReference.KeyValue;
    mtOtherEventsIS_VIZARD.AsVariant := FEventEditor.lcbIsWizard.KeyValue;
    mtOtherEventsALIAS_DF.AsVariant := FEventEditor.lcbAliasForm.KeyValue;
    mtOtherEvents.Post;
  finally
    mtOtherEvents.EnableControls;
  end;
end;

procedure TFEditDict.ApplyFieldEditorData(FFieldEditor: TFFieldEditor);
var
  str, obj, fld: string;
  ds: TpFIBDataSet;
  
begin
  mtFormFields.DisableControls;
  mtObjectTree.DisableControls;
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

      if mtObjectTree.Locate('NAME', mtFormFieldsOBJECT_NAME.AsString, [loCaseInsensitive]) then
        mtFormFields.FieldByName('OBJECT_PK').Value := mtObjectTree.FieldByName('PK').Value
      else begin
        try
          // такой вариант не катит, надо искать среди всех объектов DYNAMIC_FORM_OBJECT_TREE по имени.
          // А все потому, что поле ChildTable на самом деле может ссылаться на любой объект, даже вобще никак не связанный со справочником
          {ds := FMain.OpenSQL('select o.PK from DYNAMIC_FORM_REFERENCE r join DYNAMIC_FORM_OBJECT_TREE o on o.FORM_PK = r.MAIN_FORM_PK ' +
            'where r.PARENT_REFERENCE_PK = :PK and o.NAME = :NAME', 'PK=' + dsDictPK.AsString + #13#10 + 'NAME=' +
            mtFormFieldsOBJECT_NAME.AsString); }

          ds := FMain.OpenSQL('select PK from DYNAMIC_FORM_OBJECT_TREE where NAME = :NAME', 'NAME=' + mtFormFieldsOBJECT_NAME.AsString);

          if ds.Active and (not ds.IsEmpty) then
            mtFormFields.FieldByName('OBJECT_PK').Value := ds.FieldByName('PK').Value
          else
            mtFormFields.FieldByName('OBJECT_PK').Clear;
        finally
          if ds.Active then ds.Close;
          ds.Free;
        end;
      end;
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
    mtFormFieldsSHOW_IN_GROUP_EDIT.AsInteger := iif(FFieldEditor.chbShowInGroupEdit.Checked, 1, 0);
    mtFormFieldsEXCEL_EXPORT.AsInteger := iif(FFieldEditor.chbExcelExport.Checked, 1, 0);
    mtFormFieldsEXCEL_IMPORT.AsInteger := iif(FFieldEditor.chbExcelImport.Checked, 1, 0);
    mtFormFieldsIS_FILTER.AsVariant := FFieldEditor.edIsFilter.Value;
    mtFormFieldsFILTER_ORDER.AsInteger := FFieldEditor.edFilterOrder.Value;
    mtFormFieldsFILTER_GROUP.AsVariant := FFieldEditor.cbFilterGroup.KeyValue;
    mtFormFieldsLOCKED.AsInteger := iif(FFieldEditor.chbLocked.Checked, 1, 0);
    mtFormFieldsSTYLE.AsString := FFieldEditor.mStyle.Text;
    mtFormFieldsSTYLE_EXTERNAL.AsString := FFieldEditor.mStyleExternal.Text;
    if FFieldEditor.mStyleColumn.Text = '' then mtFormFieldsSTYLE_COLUMN.Clear
    else mtFormFieldsSTYLE_COLUMN.AsVariant := FFieldEditor.mStyleColumn.Text;
    mtFormFieldsTYPE_NAME.AsString := FFieldEditor.cbTypeName.Items[FFieldEditor.cbTypeName.ItemIndex];
    mtFormFieldsPARAMETERS.AsString := GetFieldTypeParams(FFieldEditor.ParamControls);
    mtFormFields.Post;
  finally
    mtObjectTree.First;
    mtObjectTree.EnableControls;
    mtFormFields.EnableControls;
  end;
end;

procedure TFEditDict.ApplyFieldTmplEditorData(FTmplEditor: TFTmplEditor);
var
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

    pk := SaveTemplate(FTmplEditor.mTemplate.Text, FTmplEditor.GetObjectPK, FTmplEditor.Mode = omAdd, false {(FTmplEditor.TmplField = 'GRID_VISIBLE')});
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

procedure TFEditDict.ApplyFilterConfigEditorData(FFilterConfigEditor: TFFilterConfigEditor);
begin
  mtFilterConfig.DisableControls;
  try
    if FFilterConfigEditor.Mode = omAdd then mtFilterConfig.Append
    else begin
      if mtFilterConfig.BookmarkValid(FFilterConfigEditor.EditingRec) then
      begin
        mtFilterConfig.GotoBookmark(FFilterConfigEditor.EditingRec);
        mtFilterConfig.Edit;
      end else
      begin
        if Application.MessageBox('Редактируемая запись была удалена! Восстановить?', 'Подтверждение',
          MB_YESNO + MB_ICONWARNING) = ID_YES then
        begin
          mtFilterConfig.Append;
        end else exit;
      end;
    end;

    if FFilterConfigEditor.edTitle.Text = '' then mtFilterConfigNAME.Clear
    else mtFilterConfigNAME.AsString := FFilterConfigEditor.edTitle.Text;
    mtFilterConfigFILTER_VALUE.AsString := FFilterConfigEditor.Template;
    if (mtFilterConfig.State = dsInsert) and ((mtFilterConfigFILTER_VALUE.AsString = '') or (mtFilterConfigFILTER_VALUE.AsString = '{}')) then
      mtFilterConfig.Cancel
    else
      mtFilterConfig.Post;
  finally
    mtFilterConfig.EnableControls;
  end;
end;

procedure TFEditDict.ApplyFilterGroupEditorData(FFilterGroupEditor: TFFilterGroupEditor);
begin
  mtFilterGroup.DisableControls;
  try
    if FFilterGroupEditor.Mode = omAdd then mtFilterGroup.Append
    else begin
      if mtFilterGroup.BookmarkValid(FFilterGroupEditor.EditingRec) then
      begin
        mtFilterGroup.GotoBookmark(FFilterGroupEditor.EditingRec);
        mtFilterGroup.Edit;
      end else
      begin
        if Application.MessageBox('Редактируемая запись была удалена! Восстановить?', 'Подтверждение',
          MB_YESNO + MB_ICONWARNING) = ID_YES then
        begin
          mtFilterGroup.Append;
        end else exit;
      end;
    end;

    if Trim(FFilterGroupEditor.edTitle.Text) = '' then mtFilterGroupTITLE.Clear
    else mtFilterGroupTITLE.AsString := FFilterGroupEditor.edTitle.Text;
    if FFilterGroupEditor.edOrder.Value < 0 then mtFilterGroupORDER_.AsInteger := 0
    else mtFilterGroupORDER_.AsInteger := FFilterGroupEditor.edOrder.Value;
    mtFilterGroupCOLLAPSED.AsString := iif(FFilterGroupEditor.chbCollapsed.Checked, '1', '0');
    mtFilterGroup.Post;
    mtFilterGroupORDER_.Tag := mtFilterGroupORDER_.AsInteger;
  finally
    mtFilterGroup.EnableControls;
  end;
end;

procedure TFEditDict.ApplyGroupEditorData(FGroupEditor: TFGroupEditor);
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
    mtGroupsSTYLE_COLUMNS.AsString := GetColumnStyles(FGroupEditor.mtStyleColumns);
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

procedure TFEditDict.ApplyJsonEditorData(FJsonReader: TFJsonReader);
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

procedure TFEditDict.ApplyObjectEditorData(FObjectEditor: TFObjectEditor);
var
  p: string;

begin
  mtObjectTree.DisableControls;
  try
    if FObjectEditor.Mode = omAdd then mtObjectTree.Append
    else begin
      if mtObjectTree.BookmarkValid(FObjectEditor.EditingRec) then
      begin
        mtObjectTree.GotoBookmark(FObjectEditor.EditingRec);
        mtObjectTree.Edit;
      end else
      begin
        if Application.MessageBox('Редактируемая запись была удалена! Восстановить?', 'Подтверждение',
          MB_YESNO + MB_ICONWARNING) = ID_YES then
        begin
          mtObjectTree.Append;
        end else exit;
      end;
    end;

    if FObjectEditor.edTitle.Text = '' then mtObjectTreeTITLE.Clear
    else mtObjectTreeTITLE.AsString := FObjectEditor.edTitle.Text;
    mtObjectTreeNAME.AsString := FObjectEditor.lcbName.KeyValue;
    if FObjectEditor.edObjectType.Text = '' then mtObjectTreeOBJECT_TYPE.Clear
    else mtObjectTreeOBJECT_TYPE.AsString := FObjectEditor.edObjectType.Text;
    mtObjectTree.FieldByName('JOIN_PARENT_PK').Value := iif(FObjectEditor.lcbJoinParent.KeyValue = 0, Null, FObjectEditor.lcbJoinParent.KeyValue);
    mtObjectTreeIS_MULTI_JOIN.AsString := iif(FObjectEditor.chbIsMultiJoin.Checked, '1', '0');
    mtObjectTreeJOIN_FIELDS.AsString := GetJoinFields(FObjectEditor.mtJoinFields);
    if mtObjectTreeOBJECT_TYPE.AsString = 'PROC' then p := GetInputParams(FObjectEditor.mtInputParams)
    else p := GetPrimaryKeys(FObjectEditor.mtPrimaryKey);
    mtObjectTreePARAMETERS.AsString := p;
    mtObjectTreeDELETED.AsInteger := iif(FObjectEditor.chbDeleted.Checked, 1, 0);
    mtObjectTreeINNER_JOIN.AsInteger := iif(FObjectEditor.chbInnerJoin.Checked, 1, 0);
    mtObjectTree.Post;
  finally
    mtObjectTree.EnableControls;
  end;

  if FObjectEditor.Mode = omAdd then ObjectTreeAfterChange;
end;

procedure TFEditDict.ASaveExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then btnSaveClick(btnSave);
end;

procedure TFEditDict.AutoIncEvtPos;
begin
  mtOtherEventsPOSITION_EV.Tag := mtOtherEventsPOSITION_EV.Tag + 1;
end;

procedure TFEditDict.AutoIncFields;
begin
  mtFormFieldsORDER_.Tag := mtFormFieldsORDER_.Tag + 10;
  mtFormFieldsGRID_ORDER.Tag := mtFormFieldsGRID_ORDER.Tag + 10;
end;

procedure TFEditDict.AutoIncFilterGroup;
begin
  mtFilterGroupORDER_.Tag := mtFilterGroupORDER_.Tag + 1;
end;

procedure TFEditDict.AutoIncGroups;
begin
  mtFormFieldsORDER_.Tag := mtFormFieldsORDER_.Tag + 10;
end;

procedure TFEditDict.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFEditDict.btnCreateGrEditFormClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if not Assigned(GrEditForm) then CreateGrEditForm;
  btnCreateGrEditForm.Enabled := (Mode <> omView) and (not Assigned(GrEditForm));
  btnDelGrEditForm.Enabled := (Mode <> omView) and Assigned(GrEditForm);
end;

procedure TFEditDict.btnCreateStartFormClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if not Assigned(StartForm) then PrepareStartForm;
  btnCreateStartForm.Enabled := (Mode <> omView) and (not Assigned(StartForm));
  btnDelStartForm.Enabled := (Mode <> omView) and Assigned(StartForm);
end;

procedure TFEditDict.btnDelGrEditFormClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if Assigned(GrEditForm) then FreeAndNil(GrEditForm);
  btnCreateGrEditForm.Enabled := (Mode <> omView) and (not Assigned(GrEditForm));
  btnDelGrEditForm.Enabled := (Mode <> omView) and Assigned(GrEditForm);
end;

procedure TFEditDict.btnDelStartFormClick(Sender: TObject);
begin
  if Mode = omView then exit;

  if Assigned(StartForm) then
  begin
    mtObjectTree.DisableControls;
    try
      mtObjectTree.First;
      while not mtObjectTree.Eof do
      begin
        if mtObjectTreeOBJECT_TYPE.AsString = 'PROC' then
        begin
          LoadInputParams(mtInputParams, mtObjectTreePARAMETERS.AsString);
          mtInputParams.First;
          while not mtInputParams.Eof do
          begin
            if (mtInputParamsTYPE.AsString = PROCPARAM_user) then
            begin
              Application.MessageBox(pchar('Нельзя удалить стартовую форму, пока среди объектов справочника есть процедуры с пользовательским ' +
                'вводом параметров!'), 'Ошибка', MB_OK + MB_ICONERROR);
              exit;
            end;
            mtInputParams.Next;
          end;
        end;
        mtObjectTree.Next;
      end;
    finally
      mtObjectTree.First;
      mtObjectTree.EnableControls;
    end;

    FreeAndNil(StartForm);
  end;

  btnCreateStartForm.Enabled := (Mode <> omView) and (not Assigned(StartForm));
  btnDelStartForm.Enabled := (Mode <> omView) and Assigned(StartForm);
end;

procedure TFEditDict.btnFixClick(Sender: TObject);
begin
  if Mode = omEdit then PrepareFix;
end;

procedure TFEditDict.btnPreviewFormClick(Sender: TObject);
var
  pf: TFPreviewForm;
  
begin
  if FMain.SetFocusOpenedWindow(dsFormPK.AsInteger, TFPreviewForm.ClassName) then exit;
  pf := TFPreviewForm.Create(Self, cftPreview, omView, dsFormPK.AsVariant, FMain.OnChildFormClose);
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

procedure TFEditDict.btnRecalcTreeClick(Sender: TObject);
begin
  if Mode <> omEdit then exit;
  BuildTreeIndex;
end;

procedure TFEditDict.btnSaveClick(Sender: TObject);
var
  p: Variant;
  FScript: TFScriptEditor;

begin
  if Mode = omView then exit;

  if FSettings.ConfirmSave then
  begin
    case Mode of
      omAdd: if (Application.MessageBox('Сохранить изменения справочника в базу данных?', 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES) then exit;
      //omEdit: if not ShowScriptForm then exit;
      omEdit: if (Application.MessageBox('Сохранить изменения справочника в базу данных?', 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES) then exit;
    end;
  end;

  if Mode = omEdit then FScript := PrepareScriptForm;

  Success := SaveData;
  if Success then
  begin
    p := OldParentRefPk;
    Mode := omEdit;
    Properties := Properties;
    AddChildRefField(p);
    if CanRefresh then FMain.ChangeFormButtonCaption(Tag, GetShortCaption, Caption);

    if Assigned(FScript) and FSettings.ShowScriptForm then FScript.Show;
  end;
end;

function TFEditDict.BuildSelectSQL: string;

  function _genIdx(var n: integer): string;
  begin
    Inc(n);
    result := IntToStr(n);
  end;

var
  sl, sql, objects, fields, exFields, where, group, order, userParams: TStringList;
  i, idx, w, n: integer;
  userPk: Variant;
  fldId, objId, roleId, rankId, fltCfgId: Variant;
  mainObj, mainObjParams, mainPk: string;
  sel_opts: string;
  jo, tmpj: TJson;
  currTable, procParams, groupField, condition, oper, cond, s: string;
  mainJoin: boolean;
  isGrouped: boolean;
  mt: TMemTableEh;

begin
  // юзер, от имени которого будет генериться sql
  if not FMain.SelUserDialog(userPk, 'select PK, LOGIN, NAME from USERS where (ISACTIVE = ''1'') order by NAME', '',
    'Выбери, от чьего имени сформировать запрос') then exit;
    
  if VarIsNull(userPk) then
  begin
    Application.MessageBox('Не выбран пользователь!', 'Ошибка', MB_OK + MB_ICONERROR);
    exit;
  end;

  sl := TStringList.Create;
  sql := TStringList.Create;
  objects := TStringList.Create;
  fields := TStringList.Create;
  exFields := TStringList.Create;
  where := TStringList.Create;
  group := TStringList.Create;
  order := TStringList.Create;
  userParams := TStringList.Create;
  jo := TJson.Create;
  tmpj := nil;
  Screen.Cursor := crHourGlass;

  try
    LoadUserParams(userPk, userParams);

    mtObjectTree.DisableControls;
    if not mtObjectTree.IsEmpty then objId := mtObjectTreePK.AsInteger;
    mtFormFields.DisableControls;
    if not mtFormFields.IsEmpty then fldId := mtFormFieldsPK.AsInteger;
    mtDictOrderBy.DisableControls;
    if not mtPermRoles.IsEmpty then roleId := mtPermRolesPK.AsInteger;
    mtPermRoles.DisableControls;
    if not mtPermRanks.IsEmpty then rankId := mtPermRanksPK.AsInteger;
    mtPermRanks.DisableControls;
    if not mtFilterConfig.IsEmpty then fltCfgId := mtFilterConfigPK.AsInteger;
    mtFilterConfig.DisableControls;
    idx := 0;

    // параметры select
    sel_opts := ' /*first ' + iif(VarIsNull(edDictCountOnPage.Value), '50', VarToStr(edDictCountOnPage.Value)) + ' skip 0*/ ' +
      iif(chbDictSetDistinct.Checked, 'distinct', '');

    // параметры группировки
    isGrouped := not VarIsNull(lcbDictGrouping.KeyValue);
    groupField := StringReplace(lcbDictGrouping.Text, '/', '.', [rfReplaceAll]);

    // если есть группировка, надо уточнить, какой запрос генерить - с группировкой или без
    isGrouped := isGrouped and (Application.MessageBox('В настройках справочника присутсвует группировка по-умолчанию. Создать запрос с группировкой (Да) или обычный (Нет)?',
      pchar(Application.Title), MB_YESNO + MB_ICONQUESTION) = ID_YES);
      
    // анализируем список объектов БД (формируем выражение from, join-ы, в fields поля PK главного объекта, where для дочерних справочников)
    mtObjectTree.First;
    while not mtObjectTree.Eof do
    begin
      procParams := '';
      condition := '';
      mainJoin := false;

      currTable := mtObjectTreeNAME.AsString;
      jo.Load(PyUnicodeToAnsi(mtObjectTreePARAMETERS.AsString));
      
      if mtObjectTreeOBJECT_TYPE.AsString = 'PROC' then
      begin
        // разберемся с параметрами процедуры
        sl.Clear;
        tmpj := jo.AsObject('inputParams');
        for i := 0 to tmpj.Count - 1 do
        begin
          if tmpj.AsObject(i).ValueOf('type') = PROCPARAM_user then
            // если это ввод пользователя (из стартовой формы) - которую мы тут не станем открывать - заменяем на параметр sql
            sl.Add(':' + tmpj.AsObject(i).ValueOf('name') + _genIdx(idx))
          // в остальных случаях оставляем заданное значение - темплаты окружения портала будут заменены в итоговом запросе
          {else if tmpj.AsObject(i).ValueOf('type') = PROCPARAM_loginnedUser then
            // если значение берется из окружения - которого у нас тут нет - заменяем на параметр sql, но с названием переменной
            sl.Add(StringReplace(StringReplace(tmpj.AsObject(i).ValueOf('value'), '<?', ':', []), '?>', '', []))}
          else //if tmpj.AsObject(i).ValueOf('type') = PROCPARAM_insertValue then
            // иначе просто вставляем значение
            sl.Add(tmpj.AsObject(i).ValueOf('value'));
        end;
        if sl.Count > 0 then procParams := '(' + TextToString(sl.Text, '', ', ') + ')';
      end else
        // если не процедура, надо для главного объекта получить поля PK
        if mtObjectTreeIS_MAIN.AsBoolean then mainPk := VarToStr(jo.ValueOf('primaryKey'));

      if mtObjectTreeIS_MAIN.AsBoolean then
      begin
        // если это главный объект, надо сохранить его значение и параметры, и принудительно добавить в начало списка полей поля его PK
        mainObj := currTable;
        mainObjParams := procParams;
        for i := 1 to WordCountEx(mainPk, [';'], []) do
        begin
          if isGrouped then
            fields.Insert(i-1, 'null COL' + _genIdx(idx))
          else begin
            s := mainObj + '.' + ExtractWordEx(i, mainPk, [';'], []);
            fields.Insert(i-1, s + ' ' + StringReplace(s, '.', '_OG_', []));
          end;
        end;

        // надо посмотреть, если у главного объекта прописан родительский (у дочерних справочников), надо будет сформировать условие where
        mainJoin := not mtObjectTreeJOIN_PARENT.IsNull;
      end;

      if (not mtObjectTreeIS_MAIN.AsBoolean) or mainJoin then
      begin
        // по остальным объектам формируем конструкции join (по главному все то же, только в where)
        jo.Load(PyUnicodeToAnsi(mtObjectTreeJOIN_FIELDS.AsString));
        if not mainJoin then
        begin
          if mtObjectTreeINNER_JOIN.AsInteger = 1 then condition := 'join '
          else condition := 'left join ';
          condition := condition + currTable + procParams + ' on ';
        end;

        if jo.Count > 0 then
        begin
          // если условия присоединения прописаны (у процедуры они тоже могут быть) - формируем по ним
          for i := 0 to jo.Count - 1 do
          begin
            // опреатор сравнения левой и правой части условия присоединения
            if not VarIsNull(jo.AsObject(i).ValueOf(2)) then oper := ' ' + jo.AsObject(i).ValueOf(2) + ' '
            else oper := ' = ';

            condition := condition + iif(i=0, '', cond) + currTable + '.' + jo.AsObject(i).ValueOf(0) + oper;
            if (jo.AsObject(i).ValueType(1) in [jdtInt, jdtBool, jdtFloat, jdtDate, jdtNull]) or
              ((Length(jo.AsObject(i).AsObject(1).AsString) > 0) and (jo.AsObject(i).AsObject(1).AsString[1] = '''')) then
              // если задано выражение/константа, то прям так ее и добавляем
              condition := condition + jo.AsObject(i).AsObject(1).AsString
            else
              // значит задано поле - надо добавить <имя таблицы.имя поля>
              condition := condition + mtObjectTreeJOIN_PARENT.AsString + '.' + jo.AsObject(i).ValueOf(1);

            // выражение объедиенеия нескольких условий (работает для следующего условия)
            if not VarIsNull(jo.AsObject(i).ValueOf(3)) then cond := ' ' + jo.AsObject(i).ValueOf(3) + ' '
            else cond := ' and ';
          end;
        end else
          // иначе присоединяем всё
          condition := condition + '1 = 1';

        if mainJoin then where.Add('-- Условие открытия дочернего справочника'#13#10 + '  (' + condition + ') and')
        else objects.Add('  ' + condition);
      end;
      
      mtObjectTree.Next;
    end;

    // разбираемся с полями
    mtFormFields.First;
    while not mtFormFields.Eof do
    begin
      condition := '';

      // подписи к полям с русским названием поля, если это включено и у поля подпись не совпадает с именем поля
      if FSettings.SelSqlAddTitle and (Pos(LowerCase(mtFormFieldsFIELD_NAME.AsString), LowerCase(mtFormFieldsTITLE.AsString)) = 0) then
        s := ' /* ' + mtFormFieldsTITLE.AsString + ' */'
      else
        s := '';

      //SafeFreeAndNil(tmpj);
      jo.Load(PyUnicodeToAnsi(mtFormFieldsPARAMETERS.AsString));

      if mtFormFieldsTYPE_NAME.AsString = FIELDTYPE_ChildTable then
      begin
        // добавляется колонка с вложенным запросом на подсчет кол-ва строк в дочернем справочнике по условию его присоединения,
        // если у поля НЕ отмечена опция "не считать кол-во строк"
        if not jo.AsObject(OPT_notCount).AsBoolean then
        begin
          if isGrouped then
            fields.Add('null COL' + _genIdx(idx) + s)
          else begin
            tmpj := TJson.Create;
            tmpj.Load(jo.ValueOf(OPT_joinFields));
            if tmpj.Count > 0 then
            begin
              sl.Clear;
              for i := 0 to tmpj.Count - 1 do
              begin
                if not VarIsNull(tmpj.AsObject(i).ValueOf(2)) then oper := ' ' + tmpj.AsObject(i).ValueOf(2) + ' '
                else oper := ' = ';

                sl.Add(iif(i=0, '', cond) + mtFormFieldsOBJECT_NAME.AsString + '.' + tmpj.AsObject(i).ValueOf(0) + oper +
                  mainObj + '.' + tmpj.AsObject(i).ValueOf(1));

                if not VarIsNull(tmpj.AsObject(i).ValueOf(3)) then cond := ' ' + tmpj.AsObject(i).ValueOf(3) + ' '
                else cond := ' and ';
              end;
              fields.Add('(select count(1) from ' + mtFormFieldsOBJECT_NAME.AsString + ' where ' +
                StringReplace(sl.Text, #13#10, '', [rfReplaceAll]) + ') COUNT_ROWS' + _genIdx(idx) + s);
            end;
          end;
        end;
      end else
      if ((mtFormFieldsTYPE_NAME.AsString = FIELDTYPE_LookUp) or (mtFormFieldsTYPE_NAME.AsString = FIELDTYPE_MLookUpCreat)) and
        (jo.ValueOf(OPT_baseDescriptor) = cbDictBaseDescriptor.Text) then
      begin
        // такая обработка лукапов только если дескриптор БД поля и справочника одинаковые
        // в объекты присоединения добавляем join для лукапной таблицы
        currTable := jo.ValueOf(OPT_fkTable);
        if not jo.KeyExists(OPT_joinConst) then cond := 'left'
        else cond := Trim(jo.ValueOf(OPT_joinConst));
        oper := _genIdx(idx);
        objects.add('  ' + iif(cond = '', 'left', cond) + ' join ' + currTable + ' ' + currTable + oper + ' on ' + currTable +
          oper + '.' + jo.ValueOf(OPT_fkField) + ' = ' + mtFormFieldsOBJECT_NAME.AsString + '.' + mtFormFieldsFIELD_NAME.AsString);

        // добавляем поле так: отображаемое значение (из присоед. табл.) || ; || ключевое значение (из основной табл.)
        if isGrouped and (groupField <> mtFormFieldsOBJECT_NAME.AsString + '.' + mtFormFieldsFIELD_NAME.AsString) then
          // при включенной группировке, если это поле не поле группировки
          fields.Add('null COL' + _genIdx(idx) + s)
        else begin
          // если это поле группировки или ее нет вобще
          fields.add(currTable + oper + '.' + jo.ValueOf(OPT_displayField) + ' || '';'' || ' + mtFormFieldsOBJECT_NAME.AsString + '.' +
            mtFormFieldsFIELD_NAME.AsString + ' ' + mtFormFieldsFIELD_NAME.AsString + _genIdx(idx) + s);
          // перезаписать поле для group by сгенеренным для списка select, чтоб они совпадали
          if isGrouped then groupField := mtFormFieldsFIELD_NAME.AsString + IntToStr(idx);
        end;
      end else
      begin
        // все остальные типы - просто добавить поле в список полей
        if isGrouped then
        begin
          // при включенной группировке
          if groupField = mtFormFieldsOBJECT_NAME.AsString + '.' + mtFormFieldsFIELD_NAME.AsString then
          begin
            // если это поле группировки - добавляем по-нормальному
            fields.add(mtFormFieldsOBJECT_NAME.AsString + '.' + mtFormFieldsFIELD_NAME.AsString {+ ' COL' + _genIdx(idx)} + s);
            //groupField := 'COL' + IntToStr(idx);
          end else
          begin
            // если у поля настроена аггрегатная функция, добавляем с ее использованием
            if jo.KeyExists(OPT_summaryType) and (jo.ValueType(OPT_summaryType) = jdtStr) and (jo.AsObject(OPT_summaryType).AsString <> '') and
              (jo.AsObject(OPT_summaryType).AsString <> 'dif') then
            begin
              if jo.AsObject(OPT_summaryType).AsString = 'count_null' then
                condition := 'sum(case when ' + mtFormFieldsOBJECT_NAME.AsString + '.' + mtFormFieldsFIELD_NAME.AsString +
                  ' is null then 1 else 0 end)'
              else begin
                if jo.AsObject(OPT_summaryType).AsString = 'proc' then jo.AsObject(OPT_summaryType).SetValue('sum');
                if jo.AsObject(OPT_summaryType).AsString = 'proc_without_zero' then
                begin
                  // для данного типа в конец добавляется еще 1 поле (кроме самого этого поля с типом sum), такого вида
                  jo.AsObject(OPT_summaryType).SetValue('sum');
                  exFields.Add('sum(case when ' + mtFormFieldsOBJECT_NAME.AsString + '.' + mtFormFieldsFIELD_NAME.AsString +
                    ' is null then 1 else 0 end)');
                end;
                condition := jo.AsObject(OPT_summaryType).AsString + '(' + mtFormFieldsOBJECT_NAME.AsString + '.' + mtFormFieldsFIELD_NAME.AsString +
                ') COL' + _genIdx(idx);
              end;

              fields.add(condition + s);
            end else
              // иначе добавляем убого
              fields.Add('null COL' + _genIdx(idx) + s);
          end;
        end else
        begin
          if mtFormFieldsTYPE_NAME.AsString = FIELDTYPE_comboBox then
          begin
            // комбобоксу тут сгенерим case со списком ключевых и отображаемых значений, чтоб красиво показывать отображаемые значения в результате
            condition := 'case ' + mtFormFieldsOBJECT_NAME.AsString + '.' + mtFormFieldsFIELD_NAME.AsString;
            for i := 1 to WordCountEx(jo.ValueOf(OPT_fields), [';'], []) do
              condition := condition + ' when ''' + ExtractWordEx(i, jo.ValueOf(OPT_fields), [';'], []) + ''' then ''' +
                ExtractWordEx(i, jo.ValueOf(OPT_fields), [';'], []) + ';' + ExtractWordEx(i, jo.ValueOf(OPT_values), [';'], []) + '''';

            fields.add(condition + ' end ' + mtFormFieldsFIELD_NAME.AsString + _genIdx(idx) + s);
          end else
            fields.add(mtFormFieldsOBJECT_NAME.AsString + '.' + mtFormFieldsFIELD_NAME.AsString {+ ' COL' + _genIdx(idx)} + s);
        end;
      end;

      mtFormFields.Next;
    end;

    if isGrouped then
    begin
      // добавляем дополнительные поля
      fields.AddStrings(exFields);
      // при включенной группировке добавляем в конец еще 1 поле
      fields.add('count(1) COL' + _genIdx(idx));
    end;

    // разберемся с условием where.
    // роль filter добавляем всегда, and ко всем условиям
    if mtPermRoles.Locate('ROLE_NAME', 'filter', []) then
    begin
      if mtPermRolesVIEW_REF.AsInteger <> 1 then
      begin
        where.Add('-- Роль filter');
        if mtPermRolesVIEW_REF.IsNull or (mtPermRolesVIEW_REF.AsInteger = 0) then
          // если 0 (null) - запрет на открытие, добавляем так
          where.Add('(0 = 1) and')
        else begin
          // генерим условие
          cond := '';
          jo.Load(LoadTemplate(mtPermRolesVIEW_REF.AsInteger));
          for i := 0 to jo.Count - 1 do
          begin
            tmpj := jo.AsObject(i);
            s := Trim(tmpj.AsObject('value').AsString);
            n := LastDelimiter(' ', s);
            oper := Copy(s, 1, n - 1);
            if i = 0 then condition := oper
            else condition := condition + ' ' + cond + ' ' + oper;
            cond := Copy(s, n + 1, 3);
          end;
          where.Add('(' + condition + ') and');
        end;
      end;
    end;

    // теперь добавляем условия по роли и должностям выбранного пользователя
    w := -1;
    mt := nil;
    while true do
    begin
      if not Assigned(mt) then mt := mtPermRoles
      else mt := mtPermRanks;

      // права ролей и должностей пользователя соединяем через or, все они будут одиним блоком (), объединенным с остальными через and
      if mt = mtPermRanks then sl.Text := StringReplace(userParams.Values['LIST_RANK_PK'], ',', #13#10, [rfReplaceAll])
      else sl.Clear;
      mt.First;
      while not mt.Eof do
      begin
        // если это одна из должностей пользователя или его роль или роль filter - добавляем
        if ((mt = mtPermRanks) and (sl.IndexOf(mt.FieldByName('ROLE_PK').AsString) > -1)) or
          (userParams.Values['ROLE_PK'] = mt.FieldByName('ROLE_PK').AsString) then
        begin
          if (mt.FieldByName('VIEW_REF').AsInteger = 1) then
          begin
            // если 1 - разрешено все без условий, добавим так
            where.Add('-- ' + iif(mt = mtPermRoles, 'Роль ', 'Должность ') + mt.FieldByName('ROLE_PK').AsString + ':' +
              mt.FieldByName('ROLE_NAME').AsString + ' - без ограничений');
            if w = -1 then w := where.Add('((1 = 1) or')
            else where.Add('(1 = 1) or');
          end else
          begin
            // иначе смотрим шаблон
            if mt.FieldByName('VIEW_REF').IsNull or (mt.FieldByName('VIEW_REF').AsInteger = 0) then
            begin
              // если 0 (null) - запрет на открытие, добавляем так
              where.Add('-- Заблокировано для ' + iif(mt = mtPermRoles, 'роли ', 'должности ') + mt.FieldByName('ROLE_PK').AsString + ':' +
                mt.FieldByName('ROLE_NAME').AsString);
              if w = -1 then w := where.Add('((0 = 1) or')
              else where.Add('(0 = 1) or');
            end else
            begin
              // генерим условие
              cond := '';
              where.Add('-- ' + iif(mt = mtPermRoles, 'Роль ', 'Должность ') + mt.FieldByName('ROLE_PK').AsString + ':' +
                mt.FieldByName('ROLE_NAME').AsString);
              jo.Load(LoadTemplate(mt.FieldByName('VIEW_REF').AsInteger));
              for i := 0 to jo.Count - 1 do
              begin
                tmpj := jo.AsObject(i);
                s := Trim(tmpj.AsObject('value').AsString);
                n := LastDelimiter(' ', s);
                oper := Copy(s, 1, n - 1);
                if i = 0 then condition := oper
                else condition := condition + ' ' + cond + ' ' + oper;
                cond := Copy(s, n + 1, 3);
              end;
              if w = -1 then w := where.Add('(' + condition + ' or')
              else where.Add(condition + ' or');
            end;
          end;
        end;
        mt.Next;
      end;

      if mt = mtPermRanks then break;
    end;
    
    if w <> -1 then
    begin
      n := LastDelimiter(' ', where.Strings[where.Count-1]);
      where.Strings[where.Count-1] := Copy(where.Strings[where.Count-1], 1, n-1) + ') and';
    end else
    begin
      // если ни по ролям ни по должностям прав нет, надо добавить запретное условие
      where.Add('-- По ролям и должностям пользователя нет прав');
      where.Add('(0 = 1) and');
    end;

    // конфигурация фильтров "По умолчанию"
    if mtFilterConfig.Locate('NAME', 'По умолчанию', []) then
    begin
      where.Add('-- Конфигурация фильтров "По умолчанию"');
      // генерим условие
      cond := '';
      jo.Load(PyUnicodeToAnsi(mtFilterConfigFILTER_VALUE.AsString));
      for i := 0 to Length(jo.Keys) - 1 do
      begin
        tmpj := jo.AsObject(jo.Keys[i]);
        oper := Trim(tmpj.AsObject('value').AsString);
        oper := StringReplace(oper, '^_^', ' and ' + jo.Keys[i], []);
        if (Pos('=', oper) <> 1) and (Pos('<>', oper) <> 1) and (Pos('like', LowerCase(oper)) <> 1) and
          (Pos('not like', LowerCase(oper)) <> 1) and (Pos('starting', LowerCase(oper)) <> 1) and
          (Pos('in', LowerCase(oper)) <> 1) and (Pos('>', oper) <> 1) and ((Pos('<', oper) <> 1) or (Pos('<', oper) = Pos('<?', oper))) and
          (Pos('>=', oper) <> 1) and (Pos('<=', oper) <> 1) and (Pos('is null', LowerCase(oper)) <> 1) and
          (Pos('is not null', LowerCase(oper)) <> 1) and (Pos('not is null', LowerCase(oper)) <> 1) then
          oper := ' in (' + oper + ')';

        cond := Trim(tmpj.AsObject('bound').AsString);
        if i = 0 then condition := jo.Keys[i] + oper
        else condition := condition + ' ' + cond + ' ' + jo.Keys[i] + ' ' + oper;
      end;
      where.Add('(' + condition + ') and');
    end;

    // параметры стартовой формы (кроме параметров процедуры)
    if (not dsDictSTART_FORM_PK.IsNull) then
    begin
      w := -1;
      mtFormFields.First;
      while not mtFormFields.Eof do
      begin
        if mtFormFieldsSHOW_IN_START_FORM.AsInteger = 1 then
        begin
          if w = -1 then
          begin
            where.Add('-- Стартовая форма');
            w := where.Add('(' + mtFormFieldsOBJECT_NAME.AsString + '.' + mtFormFieldsFIELD_NAME.AsString + ' = :' +
              mtFormFieldsFIELD_NAME.AsString + _genIdx(idx) + ' and');
          end else
            where.Add(mtFormFieldsOBJECT_NAME.AsString + '.' + mtFormFieldsFIELD_NAME.AsString + ' = :' +
              mtFormFieldsFIELD_NAME.AsString + _genIdx(idx) + ' and');
        end;
        mtFormFields.Next;
      end;

      if w <> -1 then
      begin
        n := LastDelimiter(' ', where.Strings[where.Count-1]);
        where.Strings[where.Count-1] := Copy(where.Strings[where.Count-1], 1, n-1) + ') and';
      end;
    end;

    if where.Count > 0 then
    begin
      where.Strings[0] := 'where ' + where.Strings[0];
      for i := 1 to where.Count - 1 do where.Strings[i] := '  ' + where.Strings[i];
      // если в конце остался and или or надо его срезать
      n := PosEx('and', LowerCase(where.Strings[where.Count-1]), Length(where.Strings[where.Count-1]) - 3);
      if n < 1 then n := PosEx('or', LowerCase(where.Strings[where.Count-1]), Length(where.Strings[where.Count-1]) - 2);
      if n > 0 then where.Strings[where.Count-1] := Copy(where.Strings[where.Count-1], 1, n-1);
    end;

    // группировка, сортировка
    if isGrouped then
    begin
      group.Add(groupField);
      order.Add(groupField);
    end else
    begin
      mtDictOrderBy.First;
      while not mtDictOrderBy.Eof do
      begin
        order.Add(Trim(mtDictOrderByFIELD.AsString + ' ' + mtDictOrderBySORT_TYPE.AsString +
          iif(mtDictOrderByNULLS.AsString <> '', ' ' + mtDictOrderByNULLS.AsString, '')));
        mtDictOrderBy.Next;
      end;
    end;

    // ну а теберь соберем запрос
    sql.Add('select' + sel_opts);
    sql.AddStrings(SplitLongString(TextToString(fields.Text, '', ', '), ',', 120));
    for i := 1 to sql.Count - 1 do sql.Strings[i] := iif(i=1, '  ', ' ') + sql.Strings[i] + iif(i=sql.Count-1, '', ',');
    sql.Add('from ' + mainObj + mainObjParams);
    sql.AddStrings(objects);
    sql.AddStrings(where);
    if group.Count > 0 then sql.Add('group by ' + TextToString(group.Text, '', ', '));
    if order.Count > 0 then sql.Add('order by ' + TextToString(order.Text, '', ', '));
    // заменяем все параметры окружения на конкретные значения
    TemplateToUserParams(userParams, sql);
    result := sql.Text;
  finally
    sl.Free;
    sql.Free;
    objects.Free;
    fields.Free;
    exFields.Free;
    where.Free;
    group.Free;
    order.Free;
    userParams.Free;
    jo.Free;
    Screen.Cursor := crDefault;
    mtFormFields.Locate('PK', fldId, []);
    mtFormFields.EnableControls;
    mtObjectTree.Locate('PK', objId, []);
    mtObjectTree.EnableControls;
    mtDictOrderBy.First;
    mtDictOrderBy.EnableControls;
    mtPermRoles.Locate('PK', roleId, []);
    mtPermRoles.EnableControls;
    mtPermRanks.Locate('PK', rankId, []);
    mtPermRanks.EnableControls;
    mtFilterConfig.Locate('PK', fltCfgId, []);
    mtFilterConfig.EnableControls;
  end;
end;

procedure TFEditDict.BuildTreeIndex;
var
  err: string;
  n: integer;
  id, pid: string;
  tree_con: TConnection;
  tree_con_idx: integer;
  tree_tbl: string;

begin
  if (not dsDict.Active) or dsDict.IsEmpty then exit;
  if dsDictID_FIELD.IsNull or dsDictPARENT_ID_FIELD.IsNull then
    raise Exception.Create('Не задано одно из значений - "ID Поле" или "Parent_ID Поле"!');

  if FSettings.GetCurrentConnection.ConnType = ctUndefined then
    raise Exception.Create('Текущее активное подключение имеет неопределенный тип! Невозможно запустить пересчет дерева для подключений неопределеного типа! ' +
      'Сначала нужно задать типы подключений в настройках для текущего активного подключения, БД кэша дерева и БД справочника');

  tree_con_idx := FSettings.ConnIndexByDbDescr[FSettings.TreeCacheConnect];

  if (tree_con_idx = -1) then
  begin
    if (Application.MessageBox(pchar('Внимание! Подключение к БД для хранения кэша дерева не задано в настройках программы! ' +
      'Хотите пересчитать в установленной для справочника БД (' + cbDictBaseDescriptor.Text + ')?'), 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES) then exit;

    tree_con_idx := FSettings.ConnIndexByDbDescr[dsDictBASE_DESCRIPTOR.AsString];
  end;

  tree_con := FSettings.ConnByIndex[tree_con_idx];
  if tree_con.ConnType = ctUndefined then
    raise Exception.Create('Одно из подключений к БД имеет неопределенный тип! Невозможно запустить пересчет дерева для подключений неопределеного типа! ' +
      'Сначала нужно задать типы подключений в настройках для текущего активного подключения, БД кэша дерева и БД справочника');

  if (Application.MessageBox(pchar('Для перезаписи кэша дерева будет использована БД "' + tree_con.Alias + '" (host: ' + tree_con.Host + ', database: ' +
    tree_con.DataBase + ') Продолжаем?'), 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES) then exit;

  case tree_con.Server of
    stFirebird: tree_tbl := 'DYNAMIC_FORM_TREE_INDEX';
    stPostgreSQL: tree_tbl := 'main_dir.dynamic_form_tree_index';
    else raise Exception.Create('Указанная БД не поддерживает хранение кэша дерева! Задайте в настройках БД в поле "БД кэша дерева"');
  end;

  if WordCountEx(dsDictID_FIELD.AsString, ['.'], []) = 3 then
    id := ExtractWordEx(3, dsDictID_FIELD.AsString, ['.'], [])
  else
    id := ExtractWordEx(2, dsDictID_FIELD.AsString, ['.'], []);

  if WordCountEx(dsDictPARENT_ID_FIELD.AsString, ['.'], []) = 3 then
    pid := ExtractWordEx(3, dsDictPARENT_ID_FIELD.AsString, ['.'], [])
  else
    pid := ExtractWordEx(2, dsDictPARENT_ID_FIELD.AsString, ['.'], []);

  try
    Screen.Cursor := crHourGlass;

    if not ConnectionsList.ExecSQL(StringReplace('delete from {table} where REFERENCE_ID = ', '{table}', tree_tbl, []) + dsDictPK.AsString,
      tree_con_idx, err) then raise Exception.Create(err);

    if not ConnectionsList.ExecSQL(StringReplace('insert into {table} (ELEMENT_ID, REFERENCE_ID, LEFT_NUM, LVL) values (0, ', '{table}', tree_tbl, []) +
      dsDictPK.AsString + ', 0, 0)', tree_con_idx, err) then raise Exception.Create(err);

    n := NumerateTree(tree_con_idx, Null, 0, 0, id, pid) + 1;

    if not ConnectionsList.ExecSQL(StringReplace('update {table} set RIGHT_NUM = ', '{table}', tree_tbl, []) + IntToStr(n) + ' where ELEMENT_ID = 0 and REFERENCE_ID = ' +
      dsDictPK.AsString, tree_con_idx, err) then raise Exception.Create(err);

    Application.MessageBox(pchar('Дерево пересчитано успешно! Использованная БД: ' + tree_con.Alias), 'Сообщение', MB_OK + MB_ICONINFORMATION);
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TFEditDict.CanStdStartForm: boolean;
begin
  result := false;
  mtFormFields.DisableControls;
  try
    mtFormFields.First;

    while not mtFormFields.Eof do
    begin
      if mtFormFieldsSHOW_IN_START_FORM.AsInteger = 1 then
      begin
        result := true;
        break;
      end;
      mtFormFields.Next;
    end;
  finally
    mtFormFields.First;
    mtFormFields.EnableControls;
  end;
end;

procedure TFEditDict.cbDictBaseDescriptorChange(Sender: TObject);
begin
  ChangeBaseDescriptor;
end;

procedure TFEditDict.ChangeBaseDescriptor;
begin
  SetSystemFieldsSQL(dsTreeFieldsUni, cbDictBaseDescriptor.Text);
  try
    Screen.Cursor := crSQLWait;
    try
      dsTreeFieldsUni.Open;
    finally
      Screen.Cursor := crDefault;
    end;
  except
  end;

  if FMode <> omAdd then
  begin
    lcbDictIdField.KeyValue := dsDict.FieldByName('ID_FIELD').Value;
    lcbDictParentIdField.KeyValue := dsDict.FieldByName('PARENT_ID_FIELD').Value;
  end;
end;

procedure TFEditDict.CheckGrEditFormField;
begin
  if (not Assigned(GrEditForm)) or (mtFormFieldsSHOW_IN_GROUP_EDIT.AsInteger <> 1) or
    (GrEditForm.mtFormFields.Locate('OBJECT_NAME;FIELD_NAME', VarArrayOf([mtFormFieldsOBJECT_NAME.AsString,
    mtFormFieldsFIELD_NAME.AsString]), [loCaseInsensitive])) then exit;

  GrEditForm.AutoIncFields;
  GrEditForm.mtFormFields.Append;
  GrEditForm.mtFormFieldsTITLE.AsString := mtFormFieldsTITLE.AsString;
  GrEditForm.mtFormFieldsFIELD_NAME.AsString := mtFormFieldsFIELD_NAME.AsString;
  GrEditForm.mtFormFieldsOBJECT_PK.AsInteger := mtFormFieldsOBJECT_PK.AsInteger;
  GrEditForm.mtFormFieldsOBJECT_NAME.AsString := mtFormFieldsOBJECT_NAME.AsString;
  GrEditForm.mtFormFieldsOWNER_USER_PK.AsInteger := FMain.dsPortalUserPK.AsInteger;
  GrEditForm.mtFormFieldsGROUP_COLUMN.AsInteger := 0;
  GrEditForm.mtFormFieldsORDER_.AsInteger := GrEditForm.mtFormFieldsORDER_.Tag;
  GrEditForm.mtFormFieldsTYPE_NAME.AsString := mtFormFieldsTYPE_NAME.AsString;
  GrEditForm.mtFormFieldsIS_VISIBLE.AsInteger := 1;
  GrEditForm.mtFormFieldsGRID_VISIBLE.AsInteger := 0;
  GrEditForm.mtFormFieldsGRID_ORDER.AsInteger := 0;
  GrEditForm.mtFormFieldsEDITABLE.AsInteger := 1;
  GrEditForm.mtFormFieldsADD_EDITABLE.AsInteger := 1;
  GrEditForm.mtFormFieldsEXCEL_EXPORT.AsInteger := 0;
  GrEditForm.mtFormFieldsIS_VISIBLE_ADD.AsInteger := 1;
  GrEditForm.mtFormFieldsFILTER_ORDER.AsInteger := 0;
  GrEditForm.mtFormFieldsIS_FILTER.AsInteger := 0;
  GrEditForm.mtFormFieldsSHOW_IN_START_FORM.AsInteger := 0;
  GrEditForm.mtFormFieldsEDIT_IN_TABLE.AsInteger := 0;
  GrEditForm.mtFormFieldsSHOW_IN_GROUP_EDIT.AsInteger := 0;
  GrEditForm.mtFormFieldsEXCEL_IMPORT.AsInteger := 0;
  GrEditForm.mtFormFieldsMATCH.AsInteger := 0;
  GrEditForm.mtFormFieldsLOCKED.AsInteger := 0;
  GrEditForm.mtFormFieldsPARAMETERS.AsString := mtFormFieldsPARAMETERS.AsString;
  GrEditForm.mtFormFieldsSTYLE_EXTERNAL.AsString := mtFormFieldsSTYLE_EXTERNAL.AsString;
  GrEditForm.mtFormFieldsSTYLE.AsString := mtFormFieldsSTYLE.AsString;
  GrEditForm.mtFormFields.Post;
end;

procedure TFEditDict.CheckGrEditFormFields;
var
  bm: TBookmark;

begin
  if not Assigned(GrEditForm) then exit;

  bm := mtFormFields.GetBookmark;
  mtFormFields.DisableControls;
  try
    mtFormFields.First;
    while not mtFormFields.Eof do
    begin
      CheckGrEditFormField;
      mtFormFields.Next;
    end;
  finally
    if mtFormFields.BookmarkValid(bm) then
    begin
      mtFormFields.GotoBookmark(bm);
      mtFormFields.FreeBookmark(bm);
    end else
      mtFormFields.First;
    mtFormFields.EnableControls;
  end;
end;

function TFEditDict.gcsChartGroups(Script, Vars, Cache: TStringList): boolean;
var
  bm: TBookmark;
  sl: TStringList;
  n: integer;

begin
  result := false;
  sl := TStringList.Create;

  try
    // удаление
    result := gcsGenDeleteSQL(Script, DeletedChartGroups, 'DYNAMIC_FORM_CHART_GROUPS', 'PK');

    bm := mtChartGroup.GetBookmark;
    mtChartGroup.DisableControls;

    // добавление
    mtChartGroup.First;
    while not mtChartGroup.Eof do
    begin
      if mtChartGroupCHANGED.AsBoolean and mtChartGroupPK.IsNull then
      begin
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* DYNAMIC_FORM_CHART_GROUPS */');
        end;

        sl.Add(':REF_PK');
        sl.Add(VariantToDBStr(mtChartGroupTITLE.AsVariant, true));
        sl.Add(VariantToDBStr(mtChartGroupORIENTATION.AsVariant, true));
        sl.Add(VariantToDBStr(mtChartGroupGUID.AsVariant, true));

        n := Cache.Add(mtChartGroupGUID.AsString);
        Vars.Add('declare variable CHART_GROUP_PK' + IntToStr(n) + ' integer;');

        gcsGenInsertSQL(Script, sl, 'DYNAMIC_FORM_CHART_GROUPS', 'REFERENCE_PK, TITLE, ORIENTATION, GUID', ['PK'], [':CHART_GROUP_PK' + IntToStr(n)]);
        result := true;
      end;
      mtChartGroup.Next;
    end;

    // обновление
    mtChartGroup.First;
    while not mtChartGroup.Eof do
    begin
      if mtChartGroupCHANGED.AsBoolean and (not mtChartGroupPK.IsNull) then
      begin
        if mtChartGroupGUID.IsNull then raise Exception.Create(GUID_WARNING);
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* DYNAMIC_FORM_CHART_GROUPS */');
        end;

        sl.Add('TITLE = ' + VariantToDBStr(mtChartGroupTITLE.AsVariant, true));
        sl.Add('ORIENTATION = ' + VariantToDBStr(mtChartGroupORIENTATION.AsVariant, true));

        result := gcsGenUpdateSQL(Script, sl, 'DYNAMIC_FORM_CHART_GROUPS', 'GUID', VariantToDBStr(mtChartGroupGUID.AsVariant, true), []);
      end;
      mtChartGroup.Next;
    end;
  finally
    sl.Free;
    if mtChartGroup.BookmarkValid(bm) then
    begin
      mtChartGroup.GotoBookmark(bm);
      mtChartGroup.FreeBookmark(bm);
    end;
    mtChartGroup.EnableControls;
  end;
end;

function TFEditDict.gcsCharts(Script, Vars, cgrCache, fldCache: TStringList): boolean;
var
  bm: TBookmark;
  sl: TStringList;

begin
  result := false;
  sl := TStringList.Create;

  try
    // удаление
    result := gcsGenDeleteSQL(Script, DeletedCharts, 'DYNAMIC_FORM_CHARTS', 'PK');

    bm := mtChart.GetBookmark;
    mtChart.DisableControls;

    // добавление
    mtChart.First;
    while not mtChart.Eof do
    begin
      if mtChartCHANGED.AsBoolean and mtChartPK.IsNull then
      begin
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* DYNAMIC_FORM_CHARTS */');
        end;

        sl.Add(':REF_PK');
        sl.Add(gcsGenParentParam(Script, Vars, fldCache, mtChartX_FIELD_PK.AsVariant, 'FIELD_PK', 'PK', 'DYNAMIC_FORM_FIELD'));
        sl.Add(gcsGenParentParam(Script, Vars, fldCache, mtChartY_FIELD_PK.AsVariant, 'FIELD_PK', 'PK', 'DYNAMIC_FORM_FIELD'));
        sl.Add(VariantToDBStr(mtChartGROUP_FUNCTION.AsVariant, true));
        sl.Add(gcsGenParentParam(Script, Vars, fldCache, mtChartSERIES_DIF.AsVariant, 'FIELD_PK', 'PK', 'DYNAMIC_FORM_FIELD'));
        sl.Add(VariantToDBStr(mtChartTITLE.AsVariant, true));
        sl.Add(VariantToDBStr(mtChartCHART_TYPE.AsVariant, true));
        sl.Add(VariantToDBStr(mtChartORDER_.AsVariant, true));
        sl.Add(VariantToDBStr(mtChartX_AXIS_ROTATE.AsVariant, false));
        sl.Add(VariantToDBStr(mtChartADDITIONAL_FIELD.AsVariant, true));
        sl.Add(VariantToDBStr(mtChartADDITIONAL_FIELD_ROTATE.AsVariant, false));
        sl.Add(VariantToDBStr(mtChartY_TITLE.AsVariant, true));
        sl.Add(gcsGenParentParam(Script, Vars, cgrCache, mtChartGROUP_PK.AsVariant, 'CHART_GROUP_PK', 'PK', 'DYNAMIC_FORM_CHART_GROUPS'));
        sl.Add(VariantToDBStr(mtChartGROUP_ORDER.AsVariant, false));
        sl.Add(VariantToDBStr(mtChartGUID.AsVariant, true));

        gcsGenInsertSQL(Script, sl, 'DYNAMIC_FORM_CHARTS', 'REFERENC_PK, X_FIELD_PK, Y_FIELD_PK, GROUP_FUNCTION, SERIES_DIF, TITLE, CHART_TYPE, ORDER_, ' +
          'X_AXIS_ROTATE, ADDITIONAL_FIELD, ADDITIONAL_FIELD_ROTATE, Y_TITLE, GROUP_PK, GROUP_ORDER, GUID', [], []);

        result := true;
      end;
      mtChart.Next;
    end;

    // обновление
    mtChart.First;
    while not mtChart.Eof do
    begin
      if mtChartCHANGED.AsBoolean and (not mtChartPK.IsNull) then
      begin
        if mtChartGUID.IsNull then raise Exception.Create(GUID_WARNING);
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* DYNAMIC_FORM_CHARTS */');
        end;

        sl.Add(gcsGenParentParam(Script, Vars, fldCache, mtChartX_FIELD_PK.AsVariant, 'FIELD_PK', 'PK', 'DYNAMIC_FORM_FIELD', 'X_FIELD_PK = '));
        sl.Add(gcsGenParentParam(Script, Vars, fldCache, mtChartY_FIELD_PK.AsVariant, 'FIELD_PK', 'PK', 'DYNAMIC_FORM_FIELD', 'Y_FIELD_PK = '));
        sl.Add('GROUP_FUNCTION = ' + VariantToDBStr(mtChartGROUP_FUNCTION.AsVariant, true));
        sl.Add(gcsGenParentParam(Script, Vars, fldCache, mtChartSERIES_DIF.AsVariant, 'FIELD_PK', 'PK', 'DYNAMIC_FORM_FIELD', 'SERIES_DIF = '));
        sl.Add('TITLE = ' + VariantToDBStr(mtChartTITLE.AsVariant, true));
        sl.Add('CHART_TYPE = ' + VariantToDBStr(mtChartCHART_TYPE.AsVariant, true));
        sl.Add('ORDER_ = ' + VariantToDBStr(mtChartORDER_.AsVariant, true));
        sl.Add('X_AXIS_ROTATE = ' + VariantToDBStr(mtChartX_AXIS_ROTATE.AsVariant, false));
        sl.Add('ADDITIONAL_FIELD = ' + VariantToDBStr(mtChartADDITIONAL_FIELD.AsVariant, true));
        sl.Add('ADDITIONAL_FIELD_ROTATE = ' + VariantToDBStr(mtChartADDITIONAL_FIELD_ROTATE.AsVariant, false));
        sl.Add('Y_TITLE = ' + VariantToDBStr(mtChartY_TITLE.AsVariant, true));
        sl.Add(gcsGenParentParam(Script, Vars, cgrCache, mtChartGROUP_PK.AsVariant, 'CHART_GROUP_PK', 'PK', 'DYNAMIC_FORM_CHART_GROUPS', 'GROUP_PK = '));
        sl.Add('GROUP_ORDER = ' + VariantToDBStr(mtChartGROUP_ORDER.AsVariant, false));

        result := gcsGenUpdateSQL(Script, sl, 'DYNAMIC_FORM_CHARTS', 'GUID', VariantToDBStr(mtChartGUID.AsVariant, true), []);
      end;
      mtChart.Next;
    end;
  finally
    sl.Free;
    if mtChart.BookmarkValid(bm) then
    begin
      mtChart.GotoBookmark(bm);
      mtChart.FreeBookmark(bm);
    end;
    mtChart.EnableControls;
  end;
end;

procedure TFEditDict.CopyPermissions(isRank: boolean);

  procedure _copyTmpl(FieldDest, FieldSrc: TField; keyList: TStringList; frm: TFCopyRanks; ConvToUni: boolean);
  var
    tpk: Variant;

  begin
    tpk := keyList.Values[FieldSrc.AsString];
    if tpk = '' then tpk := SaveTemplate(frm.GetTemplateText(FieldSrc.Value), Null, true, ConvToUni);
    if (not VarIsNull(tpk)) then
    begin
      keyList.Values[FieldSrc.AsString] := VarToStr(tpk);
      FieldDest.Value := tpk;
    end;
  end;

var
  FCopy: TFCopyRanks;
  ds: TpFIBDataSet;
  mt: TMemTableEh;
  i: integer;
  sl: TStringList;

begin
  sl := TStringList.Create;
  FCopy := TFCopyRanks.Create(Self);
  try
    FCopy.MainFormPK := dsDictMAIN_FORM_PK.Value;
    FCopy.IsRank := isRank;
    if FCopy.ShowModal <> mrOk then exit;
    if VarIsNull(FCopy.lcbDict.KeyValue) or (FCopy.dbgPermissions.SelectedRows.Count = 0) then exit;

    ds := TpFIBDataSet(FCopy.dbgPermissions.DataSource.DataSet);
    if FCopy.IsRank then mt := mtPermRanks
    else mt := mtPermRoles;

    for i := 0 to FCopy.dbgPermissions.SelectedRows.Count - 1 do
      if ds.BookmarkValid(TBookmark(FCopy.dbgPermissions.SelectedRows.Items[i])) then
      begin
        ds.GotoBookmark(TBookmark(FCopy.dbgPermissions.SelectedRows.Items[i]));
        if mt.Locate('ROLE_PK', ds.FieldByName('ROLE_PK').Value, []) then
        begin
          case FCopy.cbExistAction.ItemIndex of
            0: continue;
            1: mt.Edit;
            else mt.Append;
          end;
        end else
          mt.Append;

        mt.FieldByName('ROLE_PK').Value := ds.FieldByName('ROLE_PK').Value;
        mt.FieldByName('ROLE_NAME').Value := ds.FieldByName('ROLE_NAME').Value;

        if (FCopy.cbTmplCopyMode.ItemIndex = 0) and (ds.FieldByName('ADD_').Value <> 1) and (ds.FieldByName('ADD_').Value <> 0) then
          _copyTmpl(mt.FieldByName('ADD_'), ds.FieldByName('ADD_'), sl, FCopy, false)
        else mt.FieldByName('ADD_').Value := ds.FieldByName('ADD_').Value;

        if (FCopy.cbTmplCopyMode.ItemIndex = 0) and (ds.FieldByName('EDIT_').Value <> 1) and (ds.FieldByName('EDIT_').Value <> 0) then
          _copyTmpl(mt.FieldByName('EDIT_'), ds.FieldByName('EDIT_'), sl, FCopy, false)
        else mt.FieldByName('EDIT_').Value := ds.FieldByName('EDIT_').Value;

        if (FCopy.cbTmplCopyMode.ItemIndex = 0) and (ds.FieldByName('DEL_').Value <> 1) and (ds.FieldByName('DEL_').Value <> 0) then
          _copyTmpl(mt.FieldByName('DEL_'), ds.FieldByName('DEL_'), sl, FCopy, false)
        else mt.FieldByName('DEL_').Value := ds.FieldByName('DEL_').Value;

        if (FCopy.cbTmplCopyMode.ItemIndex = 0) and (ds.FieldByName('VIEW_REF').Value <> 1) and (ds.FieldByName('VIEW_REF').Value <> 0) then
          _copyTmpl(mt.FieldByName('VIEW_REF'), ds.FieldByName('VIEW_REF'), sl, FCopy, true)
        else mt.FieldByName('VIEW_REF').Value := ds.FieldByName('VIEW_REF').Value;

        if (FCopy.cbTmplCopyMode.ItemIndex = 0) and (ds.FieldByName('VIEW_').Value <> 1) and (ds.FieldByName('VIEW_').Value <> 0) then
          _copyTmpl(mt.FieldByName('VIEW_'), ds.FieldByName('VIEW_'), sl, FCopy, true)
        else mt.FieldByName('VIEW_').Value := ds.FieldByName('VIEW_').Value;

        if (FCopy.cbTmplCopyMode.ItemIndex = 0) and (ds.FieldByName('EXPORT').Value <> 1) and (ds.FieldByName('EXPORT').Value <> 0) then
          _copyTmpl(mt.FieldByName('EXPORT'), ds.FieldByName('EXPORT'), sl, FCopy, false)
        else mt.FieldByName('EXPORT').Value := ds.FieldByName('EXPORT').Value;

        if (FCopy.cbTmplCopyMode.ItemIndex = 0) and (ds.FieldByName('IMPORT').Value <> 1) and (ds.FieldByName('IMPORT').Value <> 0) then
          _copyTmpl(mt.FieldByName('IMPORT'), ds.FieldByName('IMPORT'), sl, FCopy, false)
        else mt.FieldByName('IMPORT').Value := ds.FieldByName('IMPORT').Value;

        if (FCopy.cbTmplCopyMode.ItemIndex = 0) and (ds.FieldByName('GRID_SAVE').Value <> 1) and (ds.FieldByName('GRID_SAVE').Value <> 0) then
          _copyTmpl(mt.FieldByName('GRID_SAVE'), ds.FieldByName('GRID_SAVE'), sl, FCopy, false)
        else mt.FieldByName('GRID_SAVE').Value := ds.FieldByName('GRID_SAVE').Value;

        mt.Post;
      end;
  finally
    sl.Free;
    FCopy.Free;
  end;
end;

procedure TFEditDict.CreateGrEditForm;
begin
  if Mode = omAdd then exit;
  
  if not Assigned(GrEditForm) then GrEditForm := TfrmEditForm.Create(Self, tsGroupEditForm);
  GrEditForm.RequestProcParams := false;
  
  case FMode of
    omAdd, omEdit:
    begin
      GrEditForm.edFormAlias.ReadOnly := false;
      GrEditForm.edFormAlias.Color := clWindow;
      GrEditForm.edFormTitle.ReadOnly := false;
      GrEditForm.edFormTitle.Color := clWindow;
      GrEditForm.edFormWidth.ReadOnly := false;
      GrEditForm.edFormWidth.Color := clWindow;
      GrEditForm.edFormHeight.ReadOnly := false;
      GrEditForm.edFormHeight.Color := clWindow;
      GrEditForm.dbgFormFields.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      GrEditForm.sbAddField.Enabled := true;
      GrEditForm.sbEditField.Enabled := true;
      GrEditForm.sbDelField.Enabled := true;
      GrEditForm.dbgGroups.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      GrEditForm.sbAddGroup.Enabled := true;
      GrEditForm.sbEditGroup.Enabled := true;
      GrEditForm.sbDelGroup.Enabled := true;
      GrEditForm.chbLeftAlign.Enabled := true;
      GrEditForm.edLabelWidth.ReadOnly := false;
      GrEditForm.edLabelWidth.Color := clWindow;
    end;
    omView:
    begin
      GrEditForm.edFormAlias.ReadOnly := true;
      GrEditForm.edFormAlias.Color := clBtnFace;
      GrEditForm.edFormTitle.ReadOnly := true;
      GrEditForm.edFormTitle.Color := clBtnFace;
      GrEditForm.edFormWidth.ReadOnly := true;
      GrEditForm.edFormWidth.Color := clBtnFace;
      GrEditForm.edFormHeight.ReadOnly := true;
      GrEditForm.edFormHeight.Color := clBtnFace;
      GrEditForm.dbgFormFields.AllowedOperations := [];
      GrEditForm.sbAddField.Enabled := false;
      GrEditForm.sbEditField.Enabled := false;
      GrEditForm.sbDelField.Enabled := false;
      GrEditForm.dbgGroups.AllowedOperations := [];
      GrEditForm.sbAddGroup.Enabled := false;
      GrEditForm.sbEditGroup.Enabled := false;
      GrEditForm.sbDelGroup.Enabled := false;
      GrEditForm.chbLeftAlign.Enabled := false;
      GrEditForm.edLabelWidth.ReadOnly := true;
      GrEditForm.edLabelWidth.Color := clBtnFace;
    end;
  end;

  if dsGrEditForm.Active and (not dsGrEditForm.IsEmpty) then
  begin
    GrEditForm.edFormPk.Text := dsGrEditFormPK.AsString;
    GrEditForm.edFormAlias.Text := dsGrEditFormALIAS_FORM.AsString;
    GrEditForm.edFormTitle.Text := dsGrEditFormTITLE.AsString;
    GrEditForm.edFormWidth.Value := dsGrEditForm.FieldByName('WIDTH').Value;
    GrEditForm.edFormHeight.Value := dsGrEditForm.FieldByName('HEIGHT').Value;
    GrEditForm.chbLeftAlign.Checked := dsGrEditForm.FieldByName('LEFT_ALIGN').Value = 1;
    GrEditForm.edLabelWidth.Value := dsGrEditForm.FieldByName('LABEL_WIDTH').Value;
    GrEditForm.FormPk := dsGrEditForm.FieldByName('PK').Value;
    GrEditForm.FormGUID := iif(dsGrEditForm.FieldByName('GUID').IsNull, CreateGuid, dsGrEditForm.FieldByName('GUID').Value);
  end else
  begin
    GrEditForm.FormPk := Null;
    GrEditForm.FormGUID := CreateGuid;
    GrEditForm.edFormTitle.Text := 'Форма группового редактирования ' + dsDictTITLE.AsString;
  end;
  CheckGrEditFormFields;

  GrEditForm.Parent := tsGroupEditForm;
  GrEditForm.Align := alClient;
  GrEditForm.Visible := true;
end;

procedure TFEditDict.dbgChartDblClick(Sender: TObject);
begin
  sbEditChartClick(sbEditChart);
end;

procedure TFEditDict.dbgChartGroupDblClick(Sender: TObject);
begin
  sbEditChartGroupClick(sbEditChartGroup);
end;

procedure TFEditDict.dbgChartGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddChartGroupClick(sbAddChartGroup);
    VK_RETURN: if ssShift in Shift then sbEditChartGroupClick(sbEditChartGroup);
    else
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
  end;
end;

procedure TFEditDict.dbgChartKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddChartClick(sbAddChart);
    VK_RETURN: if ssShift in Shift then sbEditChartClick(sbEditChart);
    else
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
  end;
end;

procedure TFEditDict.dbgFilterConfigColumns2EditButtonClick(Sender: TObject; var Handled: Boolean);
var
  col: TColumnEh;

begin
  col := FindColumnByFieldName(dbgFilterConfig, 'FILTER_VALUE');
  OpenJsonEditor(mtFilterConfigFILTER_VALUE, 'Конфигурация фильтра: ' + mtFilterConfigNAME.AsString + ' : ' + col.Title.Hint);
end;

procedure TFEditDict.dbgFilterConfigKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddFilterConfigClick(sbAddFilterConfig);
    VK_RETURN: if ssShift in Shift then sbEditFilterConfigClick(sbEditFilterConfig);
    else
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
  end;
end;

procedure TFEditDict.dbgFilterGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddFilterGroupClick(sbAddFilterGroup);
    VK_RETURN: if ssShift in Shift then sbEditFilterGroupClick(sbEditFilterGroup);
    else
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
  end;
end;

procedure TFEditDict.dbgFormFieldsColumns19EditButtonClick(Sender: TObject; var Handled: Boolean);
var
  col: TColumnEh;

begin
  col := FindColumnByFieldName(dbgFormFields, 'PARAMETERS');
  OpenJsonEditor(mtFormFieldsPARAMETERS, 'Поле: ' + iif(mtFormFieldsOBJECT_NAME.IsNull, '', mtFormFieldsOBJECT_NAME.AsString + '.') +
    mtFormFieldsFIELD_NAME.AsString + '  ' + mtFormFieldsTITLE.AsString + '  ' + mtFormFieldsTYPE_NAME.AsString + ' : ' + col.Title.Hint);
end;

procedure TFEditDict.dbgFormFieldsColumns6EditButtonClick(Sender: TObject; var Handled: Boolean);
var
  field: TField;
  FTmplEditor: TFTmplEditor;
  m: TOpenMode;

begin
  // открытие формы редактирования шаблона прав
  field := dbgFormFields.SelectedField;
  if (not Assigned(field)) or mtFormFields.IsEmpty {or (field.FieldName <> 'GRID_VISIBLE' and field.FieldName <> 'EDIT_IN_TABLE' and
    field.FieldName <> 'IS_VISIBLE' and field.FieldName <> 'EDITABLE' and field.FieldName <> 'IS_VISIBLE_ADD' and field.FieldName <> 'ADD_EDITABLE')} then exit;

  if Mode = omView then m := omView
  else m := omEdit;

  if FMain.SetFocusOpenedWindow(field.AsInteger, TFTmplEditor.ClassName) then exit;
  FTmplEditor := TFTmplEditor.Create(Self, cftEditor, m, field.AsVariant, FMain.OnChildFormClose);
  FTmplEditor.OnClose := OnFieldTmplEditorClose;
  FTmplEditor.EditingRec := mtFormFields.GetBookmark;
  FTmplEditor.Caption := 'Редактирование шаблона прав';

  FTmplEditor.FieldPK := mtFormFieldsPK.AsInteger;
  FTmplEditor.FieldName := mtFormFieldsFIELD_NAME.AsString;
  FTmplEditor.FieldTitle := mtFormFieldsTITLE.AsString;
  FTmplEditor.TmplField := field.FieldName;
  //FTmplEditor.sbEditTemplate.Enabled := field.FieldName = 'GRID_VISIBLE';
  LoadTemplate(FTmplEditor.mTemplate, field.AsInteger);

  //FTmplEditor.Show; - это у mdi child происходит сразу при создании
  FTmplEditor.RegisterForm;
end;

procedure TFEditDict.dbgFormFieldsDblClick(Sender: TObject);
begin
  sbEditFieldClick(sbEditField);
end;

procedure TFEditDict.dbgFormFieldsFillSTFilterListValues(Sender: TCustomDBGridEh; Column: TColumnEh; Items: TStrings;
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

procedure TFEditDict.dbgFormFieldsGetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
var
  fldn: string;

begin
  if TDBGridEh(Sender).DataSource.DataSet.FieldByName('CHANGED').AsBoolean then
  begin
    if Assigned(TDBGridEh(Sender).DataSource.DataSet.FindField('PK')) then
      fldn := 'PK'
    else if Assigned(TDBGridEh(Sender).DataSource.DataSet.FindField('ID_EV')) then
      fldn := 'ID_EV'
    else exit;

    if TDBGridEh(Sender).DataSource.DataSet.FieldByName(fldn).IsNull then Background := FSettings.GridOptions.NewRowColor
    else Background := FSettings.GridOptions.ChangedRowColor;
  end {else Background := clWindow};
end;

procedure TFEditDict.dbgFormFieldsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddFieldClick(sbAddField);
    VK_RETURN: if ssShift in Shift then sbEditFieldClick(sbEditField);
    else
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
  end;
end;

procedure TFEditDict.dbgGroupsColumns12EditButtonClick(Sender: TObject; var Handled: Boolean);
var
  col: TColumnEh;

begin
  col := FindColumnByFieldName(dbgGroups, 'STYLE_COLUMNS');
  OpenJsonEditor(mtGroupsSTYLE_COLUMNS, 'Группа: ' + mtGroupsORDER_.AsString + '.' + mtGroupsTITLE.AsString + ' : ' + col.Title.Hint);
end;

procedure TFEditDict.dbgGroupsDblClick(Sender: TObject);
begin
  sbEditGroupClick(sbEditGroup);
end;

procedure TFEditDict.dbgGroupsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddGroupClick(sbAddGroup);
    VK_RETURN: if ssShift in Shift then sbEditGroupClick(sbEditGroup);
    else
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
  end;
end;

procedure TFEditDict.dbgObjectTreeColumns8EditButtonClick(Sender: TObject; var Handled: Boolean);
var
  col: TColumnEh;

begin
  col := FindColumnByFieldName(dbgObjectTree, 'JOIN_FIELDS');
  OpenJsonEditor(mtObjectTreeJOIN_FIELDS, 'Объект БД: ' + mtObjectTreeNAME.AsString + '  ' + mtObjectTreeOBJECT_TYPE.AsString +
    ' : ' + col.Title.Hint);
end;

procedure TFEditDict.dbgObjectTreeColumns9EditButtonClick(Sender: TObject; var Handled: Boolean);
var
  col: TColumnEh;

begin
  col := FindColumnByFieldName(dbgObjectTree, 'PARAMETERS');
  OpenJsonEditor(mtObjectTreePARAMETERS, 'Объект БД: ' + mtObjectTreeNAME.AsString + '  ' + mtObjectTreeOBJECT_TYPE.AsString +
    ' : ' + col.Title.Hint);
end;

procedure TFEditDict.dbgObjectTreeDblClick(Sender: TObject);
begin
  sbEditObjectClick(sbEditObject);
end;

procedure TFEditDict.dbgObjectTreeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddObjectClick(sbAddObject);
    VK_RETURN: if ssShift in Shift then sbEditObjectClick(sbEditObject);
  end;
end;

procedure TFEditDict.dbgOtherEventsDblClick(Sender: TObject);
begin
  sbEditEventClick(sbEditEvent);
end;

procedure TFEditDict.dbgOtherEventsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddEventClick(sbAddEvent);
    VK_RETURN: if ssShift in Shift then sbEditEventClick(sbEditEvent);
    else
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
  end;
end;

procedure TFEditDict.dbgPermRanksKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (Sender = dbgPermRanks) and (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddPermRankClick(sbAddPermRank);
    VK_RETURN:
      if ssShift in Shift then
      begin
        if Sender = dbgPermRanks then sbGrEditPermRankClick(sbGrEditPermRank);
        if Sender = dbgPermRoles then sbGrEditPermRoleClick(sbGrEditPermRole);
      end;
    else
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
  end;
end;

procedure TFEditDict.dbgPermRolesColEnter(Sender: TObject);
var
  m: TMemo;
  lb: TLabel;

begin
  if Sender = dbgPermRoles then
  begin
    m := mRoleTemplate;
    lb := lbRoleTmplName;
  end else
  if Sender = dbgPermRanks then
  begin
    m := mRankTemplate;
    lb := lbRankTmplName;
  end else exit;

  if (TDBGridEh(Sender).SelectedField.FieldName = 'ADD_') or (TDBGridEh(Sender).SelectedField.FieldName = 'EDIT_') or
    (TDBGridEh(Sender).SelectedField.FieldName = 'DEL_') or (TDBGridEh(Sender).SelectedField.FieldName = 'VIEW_REF') or
    (TDBGridEh(Sender).SelectedField.FieldName = 'VIEW_') or (TDBGridEh(Sender).SelectedField.FieldName = 'GRID_SAVE') then
  begin
    lb.Caption := 'Шаблон ' + TDBGridEh(Sender).SelectedField.FieldName;
    LoadTemplate(m, TDBGridEh(Sender).SelectedField.AsInteger);
  end else
  begin
    lb.Caption := 'Шаблон не выбран';
    m.Clear;
  end;
end;

procedure TFEditDict.dbgPostFilterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddPostFilterClick(sbAddPostFilter);
    else
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
  end;
end;

procedure TFEditDict.dbgWizardDblClick(Sender: TObject);
begin
  sbEditWizardClick(sbEditWizard);
end;

procedure TFEditDict.dbgWizardKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddWizardClick(sbAddWizard);
    VK_RETURN: if ssShift in Shift then sbEditWizardClick(sbEditWizard);
    VK_DELETE: if ssCtrl in Shift then sbDelWizardClick(sbDelWizard);
  end;
end;

procedure TFEditDict.edDictTitleChange(Sender: TObject);
begin
  edFormTitle.Text := 'Главная форма ' + edDictTitle.Text;
end;

function TFEditDict.ExtractParamValue(Params, ParamName: string): string;
var
  j: TJson;

begin
  result := '';

  j := TJson.Create;
  try
    j.Load(Params);
    result := j.ValueOf(ParamName);
  finally
    j.Free;
  end;
end;

procedure TFEditDict.FillFieldsList;
var
  FField: TFField;
  sl: TStringList;
  i: integer;

begin
  if Mode = omView then exit;

  sl := TStringList.Create;
  try
    if mtFormFields.State in [dsEdit, dsInsert] then mtFormFields.Post;
    sl.Text := GetNotInvolvedFields(mtFormFields);
    for i := 0 to sl.Count - 1 do
    begin
      // тут будем просто имитировать открытие формы добавления поля и ее сохранения
      AutoIncFields;
      FField := TFField.Create;
      FField.Parent := tsDummy;
      FField.Owner := Self;
      FField.BaseDescriptor := cbDictBaseDescriptor.Text;
      FField.EditingRec := nil;
      FField.Mode := omAdd;
      FField.Fields := mtFormFields;
      FField.Objects := mtObjectTree;
      FField.TypeName := FIELDTYPE_text;
      FField.CreateTypeFields;
      FField.Pk := Null;
      FField.Title := '';
      FField.FieldName := sl.Strings[i];
      FField.Title := FField.FieldName;
      FField.SetFieldParams;
      FField.Group := Null;
      FField.GroupColumn := 0;
      FField.Order := mtFormFieldsORDER_.Tag;
      FField.GridVisible := 1;
      FField.EditInTable := 0;
      FField.GridOrder := mtFormFieldsGRID_ORDER.Tag;
      FField.GridWidth := Null;
      FField.IsVisible := iif(chbDictEditable.Checked, 1, 0);
      FField.Editable := iif(chbDictEditable.Checked, 1, 0);
      FField.IsVisibleAdd := iif(chbDictEditable.Checked, 1, 0);
      FField.AddEditable := iif(chbDictEditable.Checked, 1, 0);
      FField.ShowInStartForm := false;
      FField.ShowInGroupEdit := false;
      FField.ExcelExport := false;
      FField.ExcelImport := false;
      FField.IsFilter := 0;
      FField.FilterOrder := 0;
      FField.FilterGroup := Null;
      FField.Locked := false;
      FField.Style := '';
      FField.StyleExternal := '';
      FField.StyleColumn := '';
      FField.Save;
      FField.Free;
    end;
  finally
    sl.Free;
  end;
end;

function TFEditDict.FixOracle(FormFix: TFFixReference; Test: boolean): boolean;
var
  con: TConnection;
  s, f: string;
  ds: TUniQuery;
  obj, oldObj, sl: TStringList;
  i, j, n: integer;
  mt: TMemTableEh;
  canSave: boolean;

begin
  result := false;
  con := FSettings.ConnByDbDescr[cbDictBaseDescriptor.Text];
  if con.Server <> stOracle then exit;

  FormFix.AddToLog('');
  FormFix.AddToLog('Проверка объектов Oracle...');

  // 1. исправляем объекты БД - добавим имя схемы
  if (not mtObjectTree.Active) or (mtObjectTree.IsEmpty) then exit;

  canSave := false;
  obj := TStringList.Create;
  oldObj := TStringList.Create;
  sl := TStringList.Create;
  try
    if mtObjectTree.State in [dsEdit, dsInsert] then mtObjectTree.Cancel;
    mtObjectTree.DisableControls;
    try
      mtObjectTree.First;
      while not mtObjectTree.Eof do
      begin
        oldObj.Add(mtObjectTreeNAME.AsString);
        if WordCountEx(mtObjectTreeNAME.AsString, ['.'], []) < 2 then
        begin
          // без имени схемы - надо исправлять
          if mtObjectTreeOBJECT_TYPE.AsString = 'TABLE' then
            ds := ConnectionsList.GetDataSet(cbDictBaseDescriptor.Text, qtUserDefined,
              'select t.OWNER, t.TABLE_NAME NAME from ALL_TABLES t ' +
              'where upper(t.OWNER) not like ''%SYS%'' and t.STATUS = ''VALID'' and t.TEMPORARY = ''N'' and t.DROPPED = ''NO'' ' +
              'and t.TABLE_NAME = :NAME order by t.OWNER desc')
          else
            ds := ConnectionsList.GetDataSet(cbDictBaseDescriptor.Text, qtUserDefined,
              'select v.OWNER, v.VIEW_NAME NAME from ALL_VIEWS v where upper(v.OWNER) not like ''%SYS%'' and v.VIEW_NAME = :NAME ' +
              'order by v.OWNER desc');

          ds.ParamByName('NAME').Value := mtObjectTreeNAME.AsString;
          ds.Open;

          if ds.IsEmpty then
          begin
            ds.Close;
            ds.Free;
            ds := ConnectionsList.GetDataSet(cbDictBaseDescriptor.Text, qtUserDefined,
              'select v.OWNER, v.VIEW_NAME NAME from ALL_VIEWS v where upper(v.OWNER) not like ''%SYS%'' and v.VIEW_NAME = :NAME ' +
              'order by v.OWNER desc');

            ds.ParamByName('NAME').Value := mtObjectTreeNAME.AsString;
            ds.Open;
          end;

          //ds.Last;
          s := mtObjectTreeNAME.AsString;
          if (not ds.IsEmpty) and (not ds.FieldByName('OWNER').IsNull) then
          begin
            if Test then
            begin
              result := true;
              s := ds.FieldByName('OWNER').AsString + '.' + mtObjectTreeNAME.AsString;
              FormFix.AddToLog('Oracle: Объект БД без имени схемы: ' + ds.FieldByName('NAME').AsString);
            end else
            begin
              canSave := true;
              mtObjectTree.Edit;
              mtObjectTreeNAME.AsString := ds.FieldByName('OWNER').AsString + '.' + mtObjectTreeNAME.AsString;
              mtObjectTree.Post;
              s := mtObjectTreeNAME.AsString;
              FormFix.AddToLog('Oracle: Исправлен объект БД: ' + ds.FieldByName('NAME').AsString + ' => ' + mtObjectTreeNAME.AsString);
            end;
          end;
          obj.Add(s);

          ds.Close;
          ds.Free;
        end else
          obj.Add(mtObjectTreeNAME.AsString);

        mtObjectTree.Next;
      end;
    finally
      mtObjectTree.First;
      mtObjectTree.EnableControls;
    end;
    if canSave then _Save;
    canSave := false;

    // 2. Исправляем ID Поле
    if (dsDictID_FIELD.AsString <> '') and (WordCountEx(dsDictID_FIELD.AsString, ['.'], []) < 3) then
    begin
      s := ExtractWordEx(1, dsDictID_FIELD.AsString, ['.'], []);
      f := ExtractWordEx(2, dsDictID_FIELD.AsString, ['.'], []);
      for i := 0 to oldObj.Count - 1 do
        if (AnsiLowerCase(s) = AnsiLowerCase(oldObj.Strings[i])) and (obj.Strings[i] <> oldObj.Strings[i]) then
        begin
          if Test then
            FormFix.AddToLog('Oracle: Исправить ID Поле: ' + dsDictID_FIELD.AsString)
          else begin
            canSave := true;
            lcbDictIdField.KeyValue := obj.Strings[i] + '.' + f;
            FormFix.AddToLog('Oracle: Исправлено ID Поле: ' + dsDictID_FIELD.AsString + ' => ' + lcbDictIdField.KeyValue);
          end;
          break;
        end;
    end;

    // 3. Исправляем Parent_ID Поле
    if (dsDictPARENT_ID_FIELD.AsString <> '') and (WordCountEx(dsDictPARENT_ID_FIELD.AsString, ['.'], []) < 3) then
    begin
      s := ExtractWordEx(1, dsDictPARENT_ID_FIELD.AsString, ['.'], []);
      f := ExtractWordEx(2, dsDictPARENT_ID_FIELD.AsString, ['.'], []);
      for i := 0 to oldObj.Count - 1 do
        if (AnsiLowerCase(s) = AnsiLowerCase(oldObj.Strings[i])) and (obj.Strings[i] <> oldObj.Strings[i]) then
        begin
          if Test then
            FormFix.AddToLog('Oracle: Исправить Parent_ID Поле: ' + dsDictPARENT_ID_FIELD.AsString)
          else begin
            canSave := true;
            lcbDictParentIdField.KeyValue := obj.Strings[i] + '.' + f;
            FormFix.AddToLog('Oracle: Исправлено Parent_ID Поле: ' + dsDictPARENT_ID_FIELD.AsString + ' => ' + lcbDictParentIdField.KeyValue);
          end;
          break;
        end;
    end;

    // 4. Исправляем поле Группировки
    if (dsDictGROUPING.AsString <> '') and (WordCountEx(dsDictGROUPING.AsString, ['.'], []) < 2) and
      (WordCountEx(dsDictGROUPING.AsString, ['/'], []) > 1) then
    begin
      s := ExtractWordEx(1, dsDictGROUPING.AsString, ['/'], []);
      f := ExtractWordEx(2, dsDictGROUPING.AsString, ['/'], []);
      for i := 0 to oldObj.Count - 1 do
        if (AnsiLowerCase(s) = AnsiLowerCase(oldObj.Strings[i])) and (obj.Strings[i] <> oldObj.Strings[i]) then
        begin
          if Test then
            FormFix.AddToLog('Oracle: Исправить поле Группировки: ' + dsDictGROUPING.AsString)
          else begin
            canSave := true;
            lcbDictGrouping.KeyValue := obj.Strings[i] + '/' + f;
            FormFix.AddToLog('Oracle: Исправлено поле Группировки: ' + dsDictGROUPING.AsString + ' => ' + lcbDictGrouping.KeyValue);
          end;
          break;
        end;
    end;

    // 5. Исправляем поля Сортировки
    if not mtDictOrderBy.IsEmpty then
    begin
      mtDictOrderBy.First;
      while not mtDictOrderBy.Eof do
      begin
        if mtDictOrderByFIELD_NAME.IsNull then
        begin
          s := ExtractWordEx(1, mtDictOrderByFIELD.AsString, ['.'], []);
          f := ExtractWordEx(2, mtDictOrderByFIELD.AsString, ['.'], []);
          for i := 0 to oldObj.Count - 1 do
            if (AnsiLowerCase(s) = AnsiLowerCase(oldObj.Strings[i])) and (obj.Strings[i] <> oldObj.Strings[i]) then
            begin
              if Test then
                FormFix.AddToLog('Oracle: Возможно надо исправить поле Сортировки: ' + s + '.' + f)
              else begin
                //canSave := true;
                //mtDictOrderBy.Edit;
                //mtDictOrderByFIELD.AsString := obj.Strings[i] + '.' + f;
                //mtDictOrderBy.Post;
                FormFix.AddToLog('Oracle: Возможно надо исправлено поле Сортировки: ' + s + '.' + f + ' => ' + mtDictOrderByFIELD.AsString);
              end;
              break;
            end;
        end;
        mtDictOrderBy.Next;
      end;
    end;

    // 6. Исправляем lookup и т.п. поля
    if mtFormFields.State in [dsEdit, dsInsert] then mtFormFields.Cancel;
    mtFormFields.DisableControls;
    try
      mtFormFields.First;
      while not mtFormFields.Eof do
      begin
        if (mtFormFieldsTYPE_NAME.AsString = FIELDTYPE_LookUp) or (mtFormFieldsTYPE_NAME.AsString = FIELDTYPE_CheckedLookUp) then
        begin
          s := ExtractParamValue(mtFormFieldsPARAMETERS.AsString, OPT_baseDescriptor);
          con := FSettings.ConnByDbDescr[s];
          if (s = '') or (con.Server <> stOracle) then
          begin
            mtFormFields.Next;
            continue;
          end;

          s := ExtractParamValue(mtFormFieldsPARAMETERS.AsString, OPT_fkTable);
          if (s <> '') and (WordCountEx(s, ['.'], []) < 2) then
          begin
            ds := ConnectionsList.GetDataSet(cbDictBaseDescriptor.Text, qtUserDefined,
              'select t.OWNER, t.TABLE_NAME NAME from ALL_TABLES t ' +
              'where upper(t.OWNER) not like ''%SYS%'' and t.STATUS = ''VALID'' and t.TEMPORARY = ''N'' and t.DROPPED = ''NO'' ' +
              'and t.TABLE_NAME = :NAME');

            ds.ParamByName('NAME').Value := s;
            ds.Open;

            if ds.IsEmpty then
            begin
              ds.Close;
              ds.Free;
              ds := ConnectionsList.GetDataSet(cbDictBaseDescriptor.Text, qtUserDefined,
                'select v.OWNER, v.VIEW_NAME NAME from ALL_VIEWS v where upper(v.OWNER) not like ''%SYS%'' and v.VIEW_NAME = :NAME');

              ds.ParamByName('NAME').Value := s;
              ds.Open;
            end;

            ds.Last;
            if (not ds.IsEmpty) and (not ds.FieldByName('OWNER').IsNull) then
            begin
              if Test then
                FormFix.AddToLog('Oracle: Исправить параметры Lookup поля: ' + mtFormFieldsFIELD_NAME.AsString)
              else begin
                canSave := true;
                f := ds.FieldByName('OWNER').AsString + '.' + ds.FieldByName('NAME').AsString;
                mtFormFields.Edit;
                mtFormFieldsPARAMETERS.AsString := StringReplace(mtFormFieldsPARAMETERS.AsString, s, f, [rfReplaceAll, rfIgnoreCase]);
                mtFormFields.Post;
                FormFix.AddToLog('Oracle: Исправлены параметры Lookup поля: ' + mtFormFieldsFIELD_NAME.AsString + ': ' + s + ' => ' + f);
              end;
            end;

            ds.Close;
            ds.Free;
          end;
        end;
        mtFormFields.Next;
      end;
    finally
      mtFormFields.First;
      mtFormFields.EnableControls;
    end;

    // 7. Исправляем шаблоны прав должностей и ролей
    n := 0;
    repeat
      if n = 0 then mt := mtPermRanks
      else mt := mtPermRoles;
      Inc(n);

      if mt.State in [dsEdit, dsInsert] then mt.Cancel;
      mt.DisableControls;
      try
        mt.First;
        while not mt.Eof do
        begin
          for i := 0 to mt.Fields.Count - 1 do
          begin
            if ((mt.Fields.Fields[i].FieldName = 'VIEW_REF') or (mt.Fields.Fields[i].FieldName = 'VIEW_')) and
              (mt.Fields.Fields[i].AsInteger > 1) then
            begin
              if sl.IndexOf(mt.Fields.Fields[i].AsString) > -1 then continue;
              sl.Add(mt.Fields.Fields[i].AsString);

              for j := 0 to oldObj.Count - 1 do
                if oldObj.Strings[j] <> obj.Strings[j] then
                begin
                  if Test then
                    FormFix.AddToLog('Oracle: Исправить шаблон: ' + mt.Fields.Fields[i].FieldName + ', PK ' + mt.Fields.Fields[i].AsString)
                  else begin
                    s := ReplaceTemplateText(mt.Fields.Fields[i].AsInteger, oldObj.Strings[j], obj.Strings[j]);
                    SaveTemplate(s, mt.Fields.Fields[i].AsInteger, false, true);
                    FormFix.AddToLog('Oracle: Исправлен шаблон: ' + mt.Fields.Fields[i].FieldName + ', PK ' + mt.Fields.Fields[i].AsString +
                      ': ' + oldObj.Strings[j] + ' => ' + obj.Strings[j]);
                  end;
                end;
            end;
          end;
          mt.Next;
        end;
      finally
        sl.Clear;
        mt.First;
        mt.EnableControls;
      end;
    until n > 1;

    // 8. исправляем имена объектов в графиках
    if mtChart.State in [dsEdit, dsInsert] then mtChart.Cancel;
    mtChart.DisableControls;
    try
      mtChart.First;
      while not mtChart.Eof do
      begin
        for i := 0 to oldObj.Count - 1 do
        begin
          if oldObj.Strings[i] <> obj.Strings[i] then
          begin
            if Test then
              FormFix.AddToLog('Oracle: Проверить настройки графика: ' + mtChartTITLE.AsString)
            else begin
              canSave := true;
              mtChart.Edit;
              mtChartORDER_.AsString := StringReplace(mtChartORDER_.AsString, oldObj.Strings[i], obj.Strings[i], [rfReplaceAll, rfIgnoreCase]);
              mtChartADDITIONAL_FIELD.AsString := StringReplace(mtChartADDITIONAL_FIELD.AsString, oldObj.Strings[i], obj.Strings[i],
                [rfReplaceAll, rfIgnoreCase]);
              mtChart.Post;
              FormFix.AddToLog('Oracle: Проверены настройки графика: ' + mtChartTITLE.AsString);
            end;
          end;
        end;
        mtChart.Next;
      end;
    finally
      mtChart.First;
      mtChart.EnableControls;
    end;
    if canSave then _Save;
  finally
    obj.Free;
    oldObj.Free;
    sl.Free;
  end;
end;

procedure TFEditDict.FixReference(FormFix: TFFixReference; Test: boolean);
var
  ds: TUniQuery;
  err, s: string;
  dsLog: TpFIBDataSet;
  canReload: boolean;

begin
  FormFix.AddToLog('');
  FormFix.AddToLog('Проверка конфигурации...');

  // 1. отвязка главного объекта БД от внешнего объекта, если справочник не имеет привязки к родительскому справочнику
  canReload := false;
  if FormFix.chbUnlinkObject.Checked then
  begin
    s := GetMainObjectName;
    mtObjectTree.DisableControls;
    try
      if mtObjectTree.Locate('NAME', s, []) then
        if (not mtObjectTreeJOIN_PARENT_PK.IsNull) and (dsDictPARENT_REFERENCE_PK.IsNull) then
        begin
          if Test then
            FormFix.AddToLog('Главный объект БД (' + mtObjectTreeNAME.AsString + ') привязан к внешнему объекту, PK ' +
              mtObjectTreeJOIN_PARENT_PK.AsString)
          else begin
            canReload := true;
            dsLog := FMain.OpenSQL('select NAME from DYNAMIC_FORM_OBJECT_TREE where PK = ' + mtObjectTreeJOIN_PARENT_PK.AsString);
            dsLog.First;
            if not dsLog.IsEmpty then
              FormFix.AddToLog('Главный объект БД (' + mtObjectTreeNAME.AsString + ') отвязан от объекта ' + mtObjectTreeJOIN_PARENT_PK.AsString +
                ' ' + dsLog.FieldByName('NAME').AsString)
            else
              FormFix.AddToLog('Главный объект БД (' + mtObjectTreeNAME.AsString + ') отвязан от объекта, PK ' +
                mtObjectTreeJOIN_PARENT_PK.AsString);

            mtObjectTree.Edit;
            mtObjectTreeJOIN_PARENT_PK.Clear;
            mtObjectTreeJOIN_FIELDS.AsString := '[]';
            mtObjectTree.Post;
            dsLog.Close;
            dsLog.Free;
          end;
        end;
    finally
      mtObjectTree.EnableControls;
    end;
  end;
  if canReload then _Save;
  canReload := false;

  // 2. удаление несуществующих объектов
  if FormFix.chbObjects.Checked then
  try
    ds := ConnectionsList.GetDataSet(cbDictBaseDescriptor.Text, qtProcedures);
    ds.Open;
    dsLog := FMain.OpenSQL('select t.PK, t.NAME from DYNAMIC_FORM_OBJECT_TREE t where t.FORM_PK = ' + dsDictMAIN_FORM_PK.AsString);
    dsLog.First;
    while not dsLog.Eof do
    begin
      if not ds.Locate('NAME', dsLog.FieldByName('NAME').AsString, [loCaseInsensitive]) then
      begin
        if Test then
          FormFix.AddToLog('Нужно удалить объект БД: ' + dsLog.FieldByName('NAME').AsString)
        else begin
          canReload := true;
          if FMain.ExecSQL('delete from DYNAMIC_FORM_OBJECT_TREE where PK = ' + dsLog.FieldByName('PK').AsString, err) then
            FormFix.AddToLog('Удален объект БД: ' + dsLog.FieldByName('NAME').AsString)
          else
            FormFix.AddToLog('ОШИБКА удаления объект БД: ' + dsLog.FieldByName('NAME').AsString);
        end;
      end;
      dsLog.Next;
    end;
  finally
    ds.Close;
    ds.Free;
    dsLog.Close;
    dsLog.Free;
  end;
  if canReload then _Reload;
  canReload := false;

  // 3. удаление несуществующих полей, а так же полей, не имеющих привязки к объектам БД
  try
    ds := TUniQuery.Create(Self);
    SetSystemFieldsSQL(ds, cbDictBaseDescriptor.Text);
    ds.Open;
    dsLog := FMain.OpenSQL('select f.PK, f.FIELD_NAME, o.NAME OBJECT_NAME, f.TYPE_NAME, f.OBJECT_PK from DYNAMIC_FORM_FIELD f ' +
      'left join DYNAMIC_FORM_OBJECT_TREE o on o.PK = f.OBJECT_PK ' +
      'where f.FORM_PK = ' + dsDictMAIN_FORM_PK.AsString);

    dsLog.First;
    while not dsLog.Eof do
    begin
      // для ChildTable проверка своя
      if dsLog.FieldByName('TYPE_NAME').AsString = FIELDTYPE_ChildTable then
      begin
        if (FormFix.chbNoLinkFields.Checked and (dsLog.FieldByName('OBJECT_PK').IsNull {or 
          (not mtObjectTree.Locate('NAME', dsLog.FieldByName('OBJECT_NAME').AsString, [loCaseInsensitive]))})) then
        begin
          if Test then
            FormFix.AddToLog('Нужно удалить поле: ' + dsLog.FieldByName('FIELD_NAME').AsString)
          else begin
            canReload := true;
            if FMain.ExecSQL('delete from DYNAMIC_FORM_FIELD where PK = ' + dsLog.FieldByName('PK').AsString, err) then
              FormFix.AddToLog('Удалено поле: ' + dsLog.FieldByName('FIELD_NAME').AsString)
            else
              FormFix.AddToLog('ОШИБКА удаления поля: ' + dsLog.FieldByName('FIELD_NAME').AsString);
          end;
        end;

        dsLog.Next;
        continue;
      end;

      // Остальные поля так
      if (FormFix.chbFields.Checked and (not ds.Locate('TABLE_NAME;FIELD_NAME', VarArrayOf([dsLog.FieldByName('OBJECT_NAME').AsString,
        dsLog.FieldByName('FIELD_NAME').AsString]), [loCaseInsensitive]))) or (FormFix.chbNoLinkFields.Checked and
        dsLog.FieldByName('OBJECT_NAME').IsNull) then
      begin
        if Test then
          FormFix.AddToLog('Нужно удалить поле: ' + dsLog.FieldByName('FIELD_NAME').AsString)
        else begin
          canReload := true;
          if FMain.ExecSQL('delete from DYNAMIC_FORM_FIELD where PK = ' + dsLog.FieldByName('PK').AsString, err) then
            FormFix.AddToLog('Удалено поле: ' + dsLog.FieldByName('FIELD_NAME').AsString)
          else
            FormFix.AddToLog('ОШИБКА удаления поля: ' + dsLog.FieldByName('FIELD_NAME').AsString);
        end;
      end;
      dsLog.Next;
    end;

    // 4. Удалить лишнее из сортировок
    mtDictOrderBy.DisableControls;
    mtDictOrderBy.First;
    while not mtDictOrderBy.Eof do
    begin
      if not ds.Locate('FULLNAME', mtDictOrderByFIELD.AsString, [loCaseInsensitive]) then
      begin
        if Test then
        begin
          FormFix.AddToLog('Проверь сортировку по полю: ' + mtDictOrderByFIELD.AsString);
          mtDictOrderBy.Next;
        end else
        begin
          //canReload := true;
          FormFix.AddToLog('Проверь сортировку по полю: ' + mtDictOrderByFIELD.AsString);
          //mtDictOrderBy.Delete;
          mtDictOrderBy.Next; //First;
        end;
      end else
        mtDictOrderBy.Next;
    end;
  finally
    dsLog.Close;
    dsLog.Free;
    ds.Close;
    ds.Free;
    mtDictOrderBy.First;
    mtDictOrderBy.EnableControls;
  end;

  if canReload then _Save;
end;

procedure TFEditDict.FormActivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, true);
  FMain.CheckFormButton(Tag);
end;

procedure TFEditDict.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FSettings.ChildMaximized := WindowState = wsMaximized;
end;

procedure TFEditDict.FormCreate(Sender: TObject);
var
  col: TColumnEh;

begin
  DeletedFields := TStringList.Create;
  DeletedGroups := TStringList.Create;
  DeletedObjects := TStringList.Create;
  DeletedPermRoles := TStringList.Create;
  DeletedPermRanks := TStringList.Create;
  DeletedCharts := TStringList.Create;
  DeletedChartGroups := TStringList.Create;
  DeletedFilterConfigs := TStringList.Create;
  DeletedEvents := TStringList.Create;
  DeletedFilterGroups := TStringList.Create;
  DeletedPostFilters := TStringList.Create;
  pcMain.ActivePage := tsDict;
  cbDictBaseDescriptor.Items.Text := FSettings.DbDescriptors;
  col := FindColumnByFieldName(dbgFormFields, 'TYPE_NAME');
  if Assigned(col) then
  begin
    col.KeyList.Text := FIELDTYPES;
    col.PickList.Text := FIELDTYPES;
  end;
end;

procedure TFEditDict.FormDeactivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, false);
end;

procedure TFEditDict.FormDestroy(Sender: TObject);
begin
  DeletedFields.Free;
  DeletedGroups.Free;
  DeletedObjects.Free;
  DeletedPermRoles.Free;
  DeletedPermRanks.Free;
  DeletedCharts.Free;
  DeletedChartGroups.Free;
  DeletedFilterConfigs.Free;
  DeletedEvents.Free;
  DeletedFilterGroups.Free;
  DeletedPostFilters.Free;
end;

procedure TFEditDict.FormResize(Sender: TObject);
begin
  // почему-то скачет lbRoleTemplateName при разворачивании формы, приходиться его подгонять таким вот методом
  lbRoleTmplName.Top := mRoleTemplate.Top - 19;
end;

function TFEditDict.gcsGroups(Script, Vars, Deleted, Cache: TStringList; FormKeyParam: string; Data: TMemTableEh): boolean;
var
  bm: TBookmark;
  sl: TStringList;
  n: integer;

begin
  result := false;
  sl := TStringList.Create;

  try
    // удаление
    result := gcsGenDeleteSQL(Script, Deleted, 'DYNAMIC_FORM_FIELD_GROUP', 'PK');

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
          Script.Add('  /* DYNAMIC_FORM_FIELD_GROUP */');
        end;

        sl.Add(gcsGenParentParam(Script, Vars, Cache, Data.FieldByName('PARENT_PK').Value, 'GROUP_PK', 'PK', 'DYNAMIC_FORM_FIELD_GROUP'));
        sl.Add(VariantToDBStr(FMain.dsPortalUserPK.Value, false));
        sl.Add(':' + FormKeyParam);
        sl.Add(VariantToDBStr(Data.FieldByName('ORDER_').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('TITLE').AsVariant, true));
        sl.Add(VariantToDBStr(Data.FieldByName('DESCRIPTION').AsVariant, true));
        sl.Add(VariantToDBStr(Data.FieldByName('COUNT_COLUMN').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('STYLE_EXTERNAL').AsVariant, true));
        sl.Add(VariantToDBStr(Data.FieldByName('STYLE_INTERNAL').AsVariant, true));
        sl.Add(VariantToDBStr(Data.FieldByName('IS_VISIBLE').AsVariant, true));
        sl.Add(VariantToDBStr(Data.FieldByName('COLUMN_').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('STYLE_COLUMNS').AsVariant, true));
        sl.Add(VariantToDBStr(Data.FieldByName('ADD_VISIBLE').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('COLLAPSED').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('LEFT_ALIGN').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('LABEL_WIDTH').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('GUID').AsVariant, true));

        n := Cache.Add(Data.FieldByName('GUID').AsString);
        Vars.Add('declare variable GROUP_PK' + IntToStr(n) + ' integer;');

        gcsGenInsertSQL(Script, sl, 'DYNAMIC_FORM_FIELD_GROUP', 'PARENT_PK, OWNER_USER_PK, FORM_PK, ORDER_, TITLE, DESCRIPTION, COUNT_COLUMN, STYLE_EXTERNAL, ' +
          'STYLE_INTERNAL, IS_VISIBLE, COLUMN_, STYLE_COLUMNS, ADD_VISIBLE, COLLAPSED, LEFT_ALIGN, LABEL_WIDTH, GUID', ['PK'], [':GROUP_PK' + IntToStr(n)]);

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
          Script.Add('  /* DYNAMIC_FORM_FIELD_GROUP */');
        end;

        sl.Add(gcsGenParentParam(Script, Vars, Cache, Data.FieldByName('PARENT_PK').Value, 'GROUP_PK', 'PK', 'DYNAMIC_FORM_FIELD_GROUP', 'PARENT_PK = '));
        sl.Add('ORDER_ = ' + VariantToDBStr(Data.FieldByName('ORDER_').AsVariant, false));
        sl.Add('TITLE = ' + VariantToDBStr(Data.FieldByName('TITLE').AsVariant, true));
        sl.Add('DESCRIPTION = ' + VariantToDBStr(Data.FieldByName('DESCRIPTION').AsVariant, true));
        sl.Add('COUNT_COLUMN = ' + VariantToDBStr(Data.FieldByName('COUNT_COLUMN').AsVariant, false));
        sl.Add('STYLE_EXTERNAL = ' + VariantToDBStr(Data.FieldByName('STYLE_EXTERNAL').AsVariant, true));
        sl.Add('STYLE_INTERNAL = ' + VariantToDBStr(Data.FieldByName('STYLE_INTERNAL').AsVariant, true));
        sl.Add('IS_VISIBLE = ' + VariantToDBStr(Data.FieldByName('IS_VISIBLE').AsVariant, true));
        sl.Add('COLUMN_ = ' + VariantToDBStr(Data.FieldByName('COLUMN_').AsVariant, false));
        sl.Add('STYLE_COLUMNS = ' + VariantToDBStr(Data.FieldByName('STYLE_COLUMNS').AsVariant, true));
        sl.Add('ADD_VISIBLE = ' + VariantToDBStr(Data.FieldByName('ADD_VISIBLE').AsVariant, false));
        sl.Add('COLLAPSED = ' + VariantToDBStr(Data.FieldByName('COLLAPSED').AsVariant, false));
        sl.Add('LEFT_ALIGN = ' + VariantToDBStr(Data.FieldByName('LEFT_ALIGN').AsVariant, false));
        sl.Add('LABEL_WIDTH = ' + VariantToDBStr(Data.FieldByName('LABEL_WIDTH').AsVariant, false));

        result := gcsGenUpdateSQL(Script, sl, 'DYNAMIC_FORM_FIELD_GROUP', 'GUID', VariantToDBStr(Data.FieldByName('GUID').AsVariant, true), []);
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

function TFEditDict.gcsFields(Script, Vars, Deleted, ObjCache, GrCache, TmplCache, FGrCache: TStringList; FormKeyParam: string; Data: TMemTableEh): boolean;
var
  bm: TBookmark;
  sl: TStringList;

begin
  result := false;
  sl := TStringList.Create;

  try
    bm := Data.GetBookmark;
    Data.DisableControls;

    // сначала надо все темплаты всех изменившихся полей выгрузить
    Data.First;
    while not Data.Eof do
    begin
      if Data.FieldByName('CHANGED').AsBoolean then
      begin
        if (Data.FieldByName('GRID_VISIBLE').AsInteger > 1) and (sl.IndexOf(Data.FieldByName('GRID_VISIBLE').AsString) = -1) then
          sl.Add(Data.FieldByName('GRID_VISIBLE').AsString);
        if (Data.FieldByName('EDITABLE').AsInteger > 1) and (sl.IndexOf(Data.FieldByName('EDITABLE').AsString) = -1) then
          sl.Add(Data.FieldByName('EDITABLE').AsString);
        if (Data.FieldByName('ADD_EDITABLE').AsInteger > 1) and (sl.IndexOf(Data.FieldByName('ADD_EDITABLE').AsString) = -1) then
          sl.Add(Data.FieldByName('ADD_EDITABLE').AsString);
        if (Data.FieldByName('IS_VISIBLE_ADD').AsInteger > 1) and (sl.IndexOf(Data.FieldByName('IS_VISIBLE_ADD').AsString) = -1) then
          sl.Add(Data.FieldByName('IS_VISIBLE_ADD').AsString);
        if (Data.FieldByName('EDIT_IN_TABLE').AsInteger > 1) and (sl.IndexOf(Data.FieldByName('EDIT_IN_TABLE').AsString) = -1) then
          sl.Add(Data.FieldByName('EDIT_IN_TABLE').AsString);
        if (Data.FieldByName('IS_VISIBLE').AsInteger > 1) and (sl.IndexOf(Data.FieldByName('IS_VISIBLE').AsString) = -1) then
          sl.Add(Data.FieldByName('IS_VISIBLE').AsString);
      end;
      Data.Next;
    end;

    gcsTemplates(Script, Vars, TmplCache, sl);

    // удаление
    result := gcsGenDeleteSQL(Script, Deleted, 'DYNAMIC_FORM_FIELD', 'PK');

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
          Script.Add('  /* DYNAMIC_FORM_FIELD */');
        end;

        sl.Add(VariantToDBStr(FMain.dsPortalUserPK.Value, false));
        sl.Add(gcsGenParentParam(Script, Vars, GrCache, Data.FieldByName('GROUP_PK').Value, 'GROUP_PK', 'PK', 'DYNAMIC_FORM_FIELD_GROUP'));
        sl.Add(VariantToDBStr(Data.FieldByName('GROUP_COLUMN').AsVariant, false));
        sl.Add(gcsGenParentParam(Script, Vars, ObjCache, Data.FieldByName('OBJECT_PK').Value, 'OBJECT_PK', 'PK', 'DYNAMIC_FORM_OBJECT_TREE'));
        sl.Add(VariantToDBStr(Data.FieldByName('ORDER_').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('TITLE').AsVariant, true));
        sl.Add(VariantToDBStr(Data.FieldByName('DESCRIPTION').AsVariant, true));
        sl.Add(VariantToDBStr(Data.FieldByName('TYPE_NAME').AsVariant, true));
        sl.Add(VariantToDBStr(Data.FieldByName('FIELD_NAME').AsVariant, true));
        sl.Add(VariantToDBStr(Data.FieldByName('STYLE_EXTERNAL').AsVariant, true));
        sl.Add(VariantToDBStr(Data.FieldByName('STYLE').AsVariant, true));
        sl.Add(VariantToDBStr(Data.FieldByName('PARAMETERS').AsVariant, true));
        sl.Add(':' + FormKeyParam);
        if Data.FieldByName('GRID_VISIBLE').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('GRID_VISIBLE').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(Data.FieldByName('GRID_VISIBLE').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('GRID_ORDER').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('GRID_WIDTH').AsVariant, false));
        if Data.FieldByName('EDITABLE').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('EDITABLE').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(Data.FieldByName('EDITABLE').AsVariant, false));
        if Data.FieldByName('ADD_EDITABLE').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('ADD_EDITABLE').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(Data.FieldByName('ADD_EDITABLE').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('EXCEL_EXPORT').AsVariant, false));
        if Data.FieldByName('IS_VISIBLE_ADD').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('IS_VISIBLE_ADD').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(Data.FieldByName('IS_VISIBLE_ADD').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('FILTER_ORDER').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('IS_FILTER').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('SHOW_IN_START_FORM').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('STYLE_COLUMN').AsVariant, true));
        if Data.FieldByName('EDIT_IN_TABLE').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('EDIT_IN_TABLE').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(Data.FieldByName('EDIT_IN_TABLE').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('SHOW_IN_GROUP_EDIT').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('EXCEL_IMPORT').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('MATCH').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('LOCKED').AsVariant, false));
        sl.Add(gcsGenParentParam(Script, Vars, FGrCache, Data.FieldByName('FILTER_GROUP').Value, 'FILTER_GROUP_PK', 'PK', 'DYNAMIC_FORM_FILTER_GROUP'));
        if Data.FieldByName('IS_VISIBLE').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('IS_VISIBLE').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(Data.FieldByName('IS_VISIBLE').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('GUID').AsVariant, true));

        gcsGenInsertSQL(Script, sl, 'DYNAMIC_FORM_FIELD', 'OWNER_USER_PK, GROUP_PK, GROUP_COLUMN, OBJECT_PK, ORDER_, TITLE, DESCRIPTION, TYPE_NAME, ' +
          'FIELD_NAME, STYLE_EXTERNAL, STYLE, PARAMETERS, FORM_PK, GRID_VISIBLE, GRID_ORDER, GRID_WIDTH, EDITABLE, ADD_EDITABLE, EXCEL_EXPORT, ' +
          'IS_VISIBLE_ADD, FILTER_ORDER, IS_FILTER, SHOW_IN_START_FORM, STYLE_COLUMN, EDIT_IN_TABLE, SHOW_IN_GROUP_EDIT, EXCEL_IMPORT, MATCH, ' +
          'LOCKED, FILTER_GROUP, IS_VISIBLE, GUID', [], []);

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
          Script.Add('  /* DYNAMIC_FORM_FIELD */');
        end;

        sl.Add(gcsGenParentParam(Script, Vars, ObjCache, Data.FieldByName('OBJECT_PK').Value, 'OBJECT_PK', 'PK', 'DYNAMIC_FORM_OBJECT_TREE', 'OBJECT_PK = '));
        sl.Add(gcsGenParentParam(Script, Vars, GrCache, Data.FieldByName('GROUP_PK').Value, 'GROUP_PK', 'PK', 'DYNAMIC_FORM_FIELD_GROUP', 'GROUP_PK = '));
        sl.Add('GROUP_COLUMN = ' + VariantToDBStr(Data.FieldByName('GROUP_COLUMN').AsVariant, false));
        sl.Add('ORDER_ = ' + VariantToDBStr(Data.FieldByName('ORDER_').AsVariant, false));
        sl.Add('TITLE = ' + VariantToDBStr(Data.FieldByName('TITLE').AsVariant, true));
        sl.Add('DESCRIPTION = ' + VariantToDBStr(Data.FieldByName('DESCRIPTION').AsVariant, true));
        sl.Add('TYPE_NAME = ' + VariantToDBStr(Data.FieldByName('TYPE_NAME').AsVariant, true));
        sl.Add('FIELD_NAME = ' + VariantToDBStr(Data.FieldByName('FIELD_NAME').AsVariant, true));
        sl.Add('STYLE_EXTERNAL = ' + VariantToDBStr(Data.FieldByName('STYLE_EXTERNAL').AsVariant, true));
        sl.Add('STYLE = ' + VariantToDBStr(Data.FieldByName('STYLE').AsVariant, true));
        sl.Add('PARAMETERS = ' + VariantToDBStr(Data.FieldByName('PARAMETERS').AsVariant, true));
        if Data.FieldByName('GRID_VISIBLE').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('GRID_VISIBLE').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'GRID_VISIBLE = '))
        else
          sl.Add('GRID_VISIBLE = ' + VariantToDBStr(Data.FieldByName('GRID_VISIBLE').AsVariant, false));
        sl.Add('GRID_ORDER = ' + VariantToDBStr(Data.FieldByName('GRID_ORDER').AsVariant, false));
        sl.Add('GRID_WIDTH = ' + VariantToDBStr(Data.FieldByName('GRID_WIDTH').AsVariant, false));
        if Data.FieldByName('EDITABLE').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('EDITABLE').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'EDITABLE = '))
        else
          sl.Add('EDITABLE = ' + VariantToDBStr(Data.FieldByName('EDITABLE').AsVariant, false));
        if Data.FieldByName('ADD_EDITABLE').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('ADD_EDITABLE').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'ADD_EDITABLE = '))
        else
          sl.Add('ADD_EDITABLE = ' + VariantToDBStr(Data.FieldByName('ADD_EDITABLE').AsVariant, false));
        sl.Add('EXCEL_EXPORT = ' + VariantToDBStr(Data.FieldByName('EXCEL_EXPORT').AsVariant, false));
        if Data.FieldByName('IS_VISIBLE_ADD').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('IS_VISIBLE_ADD').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'IS_VISIBLE_ADD = '))
        else
          sl.Add('IS_VISIBLE_ADD = ' + VariantToDBStr(Data.FieldByName('IS_VISIBLE_ADD').AsVariant, false));
        sl.Add('FILTER_ORDER = ' + VariantToDBStr(Data.FieldByName('FILTER_ORDER').AsVariant, false));
        sl.Add('IS_FILTER = ' + VariantToDBStr(Data.FieldByName('IS_FILTER').AsVariant, false));
        sl.Add('SHOW_IN_START_FORM = ' + VariantToDBStr(Data.FieldByName('SHOW_IN_START_FORM').AsVariant, false));
        sl.Add('STYLE_COLUMN = ' + VariantToDBStr(Data.FieldByName('STYLE_COLUMN').AsVariant, true));
        if Data.FieldByName('EDIT_IN_TABLE').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('EDIT_IN_TABLE').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'EDIT_IN_TABLE = '))
        else
          sl.Add('EDIT_IN_TABLE = ' + VariantToDBStr(Data.FieldByName('EDIT_IN_TABLE').AsVariant, false));
        sl.Add('SHOW_IN_GROUP_EDIT = ' + VariantToDBStr(Data.FieldByName('SHOW_IN_GROUP_EDIT').AsVariant, false));
        sl.Add('EXCEL_IMPORT = ' + VariantToDBStr(Data.FieldByName('EXCEL_IMPORT').AsVariant, false));
        sl.Add('MATCH = ' + VariantToDBStr(Data.FieldByName('MATCH').AsVariant, false));
        sl.Add('LOCKED = ' + VariantToDBStr(Data.FieldByName('LOCKED').AsVariant, false));
        if Data.FieldByName('IS_VISIBLE').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('IS_VISIBLE').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'IS_VISIBLE = '))
        else
          sl.Add('IS_VISIBLE = ' + VariantToDBStr(Data.FieldByName('IS_VISIBLE').AsVariant, false));
        sl.Add(gcsGenParentParam(Script, Vars, FGrCache, Data.FieldByName('FILTER_GROUP').Value, 'FILTER_GROUP_PK', 'PK', 'DYNAMIC_FORM_FILTER_GROUP', 'FILTER_GROUP = '));

        result := gcsGenUpdateSQL(Script, sl, 'DYNAMIC_FORM_FIELD', 'GUID', VariantToDBStr(Data.FieldByName('GUID').AsVariant, true), []);
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

function TFEditDict.gcsFilterConfigs(Script, Vars, Cache: TStringList): boolean;
var
  bm: TBookmark;
  sl: TStringList;
  n: integer;

begin
  result := false;
  sl := TStringList.Create;

  try
    // удаление
    result := gcsGenDeleteSQL(Script, DeletedFilterConfigs, 'DYNAMIC_FORM_FILTER_CONFIG', 'PK');

    bm := mtFilterConfig.GetBookmark;
    mtFilterConfig.DisableControls;

    // добавление
    mtFilterConfig.First;
    while not mtFilterConfig.Eof do
    begin
      if mtFilterConfigCHANGED.AsBoolean and mtFilterConfigPK.IsNull then
      begin
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* DYNAMIC_FORM_FILTER_CONFIG */');
        end;

        sl.Add(VariantToDBStr(mtFilterConfigNAME.AsVariant, true));
        sl.Add(':REF_PK');
        sl.Add(VariantToDBStr(mtFilterConfigFILTER_VALUE.AsVariant, true));
        sl.Add(VariantToDBStr(mtFilterConfigGUID.AsVariant, true));

        n := Cache.Add(mtFilterConfigGUID.AsString);
        Vars.Add('declare variable FILTER_CONF_PK' + IntToStr(n) + ' integer;');

        gcsGenInsertSQL(Script, sl, 'DYNAMIC_FORM_FILTER_CONFIG', 'NAME, REF_PK, FILTER_VALUE, GUID', ['PK'], [':FILTER_CONF_PK' + IntToStr(n)]);
        result := true;
      end;
      mtFilterConfig.Next;
    end;

    // обновление
    mtFilterConfig.First;
    while not mtFilterConfig.Eof do
    begin
      if mtFilterConfigCHANGED.AsBoolean and (not mtFilterConfigPK.IsNull) then
      begin
        if mtFilterConfigGUID.IsNull then raise Exception.Create(GUID_WARNING);
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* DYNAMIC_FORM_FILTER_CONFIG */');
        end;

        sl.Add('NAME = ' + VariantToDBStr(mtFilterConfigNAME.AsVariant, true));
        sl.Add('FILTER_VALUE = ' + VariantToDBStr(mtFilterConfigFILTER_VALUE.AsVariant, true));

        result := gcsGenUpdateSQL(Script, sl, 'DYNAMIC_FORM_FILTER_CONFIG', 'GUID', VariantToDBStr(mtFilterConfigGUID.AsVariant, true), []);
      end;
      mtFilterConfig.Next;
    end;
  finally
    sl.Free;
    if mtFilterConfig.BookmarkValid(bm) then
    begin
      mtFilterConfig.GotoBookmark(bm);
      mtFilterConfig.FreeBookmark(bm);
    end;
    mtFilterConfig.EnableControls;
  end;
end;

function TFEditDict.gcsFilterGroups(Script, Vars, Cache: TStringList): boolean;
var
  bm: TBookmark;
  sl: TStringList;
  n: integer;

begin
  result := false;
  sl := TStringList.Create;

  try
    // удаление
    result := gcsGenDeleteSQL(Script, DeletedFilterGroups, 'DYNAMIC_FORM_FILTER_GROUP', 'PK');

    bm := mtFilterGroup.GetBookmark;
    mtFilterGroup.DisableControls;

    // добавление
    mtFilterGroup.First;
    while not mtFilterGroup.Eof do
    begin
      if mtFilterGroupCHANGED.AsBoolean and mtFilterGroupPK.IsNull then
      begin
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* DYNAMIC_FORM_FILTER_GROUP */');
        end;

        sl.Add(':MAIN_FORM_PK');
        sl.Add(VariantToDBStr(mtFilterGroupTITLE.AsVariant, true));
        sl.Add(VariantToDBStr(mtFilterGroupORDER_.AsVariant, false));
        sl.Add(VariantToDBStr(mtFilterGroupCOLLAPSED.AsVariant, false));
        sl.Add(VariantToDBStr(FMain.dsPortalUserPK.Value, false));
        sl.Add(VariantToDBStr(mtFilterGroupGUID.AsVariant, true));

        n := Cache.Add(mtFilterGroupGUID.AsString);
        Vars.Add('declare variable FILTER_GROUP_PK' + IntToStr(n) + ' integer;');

        gcsGenInsertSQL(Script, sl, 'DYNAMIC_FORM_FILTER_GROUP', 'FORM_PK, TITLE, ORDER_, COLLAPSED, OWNER_USER_PK, GUID', ['PK'],
          [':FILTER_GROUP_PK' + IntToStr(n)]);

        result := true;
      end;
      mtFilterGroup.Next;
    end;

    // обновление
    mtFilterGroup.First;
    while not mtFilterGroup.Eof do
    begin
      if mtFilterGroupCHANGED.AsBoolean and (not mtFilterGroupPK.IsNull) then
      begin
        if mtFilterGroupGUID.IsNull then raise Exception.Create(GUID_WARNING);
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* DYNAMIC_FORM_FILTER_GROUP */');
        end;

        sl.Add('TITLE = ' + VariantToDBStr(mtFilterGroupTITLE.AsVariant, true));
        sl.Add('ORDER_ = ' + VariantToDBStr(mtFilterGroupORDER_.AsVariant, false));
        sl.Add('COLLAPSED = ' + VariantToDBStr(mtFilterGroupCOLLAPSED.AsVariant, false));

        result := gcsGenUpdateSQL(Script, sl, 'DYNAMIC_FORM_FILTER_GROUP', 'GUID', VariantToDBStr(mtFilterGroupGUID.AsVariant, true), []);
      end;
      mtFilterGroup.Next;
    end;
  finally
    sl.Free;
    if mtFilterGroup.BookmarkValid(bm) then
    begin
      mtFilterGroup.GotoBookmark(bm);
      mtFilterGroup.FreeBookmark(bm);
    end;
    mtFilterGroup.EnableControls;
  end;
end;

function TFEditDict.gcsMainForm(Script, Vars: TStringList): boolean;
var
  sl: TStringList;

begin
  sl := TStringList.Create;
  result := false;

  try
    gcsCheckOption(sl, dsFormALIAS_FORM, Trim(edFormAlias.Text), true);
    gcsCheckOption(sl, dsFormTITLE, Trim(edFormTitle.Text), true);
    gcsCheckOption(sl, dsFormWIDTH, edFormWidth.Value, false, true, true);
    gcsCheckOption(sl, dsFormHEIGHT, edFormHeight.Value, false, true, true);
    gcsCheckOption(sl, dsFormLEFT_ALIGN, iif(chbLeftAlign.Checked, 1, 0), false);
    gcsCheckOption(sl, dsFormLABEL_WIDTH, edLabelWidth.Value, false, true, true);

    result := gcsGenUpdateSQL(Script, sl, 'DYNAMIC_FORM', 'PK', ':MAIN_FORM_PK', ['MODIFY = current_timestamp'], '/* DYNAMIC_FORM - Main form */');
  finally
    sl.Free;
  end;
end;

function TFEditDict.gcsPermissions(Script, Vars, Deleted, TmplCache: TStringList; Data: TMemTableEh): boolean;
var
  bm: TBookmark;
  sl: TStringList;
  tableName: string;

begin
  result := false;
  sl := TStringList.Create;

  try
    bm := Data.GetBookmark;
    Data.DisableControls;

    if Data = mtPermRanks then tableName := 'DYNAMIC_FORM_PERM_RANKS'
    else tableName := 'DYNAMIC_FORM_PERMISSIONS';

    // сначала надо все темплаты всех изменившихся прав выгрузить
    Data.First;
    while not Data.Eof do
    begin
      if Data.FieldByName('CHANGED').AsBoolean then
      begin
        if (Data.FieldByName('ADD_').AsInteger > 1) and (sl.IndexOf(Data.FieldByName('ADD_').AsString) = -1) then
          sl.Add(Data.FieldByName('ADD_').AsString);
        if (Data.FieldByName('EDIT_').AsInteger > 1) and (sl.IndexOf(Data.FieldByName('EDIT_').AsString) = -1) then
          sl.Add(Data.FieldByName('EDIT_').AsString);
        if (Data.FieldByName('DEL_').AsInteger > 1) and (sl.IndexOf(Data.FieldByName('DEL_').AsString) = -1) then
          sl.Add(Data.FieldByName('DEL_').AsString);
        if (Data.FieldByName('VIEW_REF').AsInteger > 1) and (sl.IndexOf(Data.FieldByName('VIEW_REF').AsString) = -1) then
          sl.Add(Data.FieldByName('VIEW_REF').AsString);
        if (Data.FieldByName('CONFIG_').AsInteger > 1) and (sl.IndexOf(Data.FieldByName('CONFIG_').AsString) = -1) then
          sl.Add(Data.FieldByName('CONFIG_').AsString);
        if (Data.FieldByName('VIEW_').AsInteger > 1) and (sl.IndexOf(Data.FieldByName('VIEW_').AsString) = -1) then
          sl.Add(Data.FieldByName('VIEW_').AsString);
        if (Data.FieldByName('EXPORT').AsInteger > 1) and (sl.IndexOf(Data.FieldByName('EXPORT').AsString) = -1) then
          sl.Add(Data.FieldByName('EXPORT').AsString);
        if (Data.FieldByName('IMPORT').AsInteger > 1) and (sl.IndexOf(Data.FieldByName('IMPORT').AsString) = -1) then
          sl.Add(Data.FieldByName('IMPORT').AsString);
        if (Data.FieldByName('GRID_SAVE').AsInteger > 1) and (sl.IndexOf(Data.FieldByName('GRID_SAVE').AsString) = -1) then
          sl.Add(Data.FieldByName('GRID_SAVE').AsString);
      end;
      Data.Next;
    end;

    gcsTemplates(Script, Vars, TmplCache, sl);

    // удаление
    result := gcsGenDeleteSQL(Script, Deleted, tableName, 'PK');

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
          Script.Add('  /* ' + tableName + ' */');
        end;

        sl.Add(':REF_PK');
        sl.Add(VariantToDBStr(Data.FieldByName('ROLE_PK').AsVariant, false));
        if Data.FieldByName('ADD_').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('ADD_').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(Data.FieldByName('ADD_').AsVariant, false));
        if Data.FieldByName('EDIT_').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('EDIT_').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(Data.FieldByName('EDIT_').AsVariant, false));
        if Data.FieldByName('DEL_').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('DEL_').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(Data.FieldByName('DEL_').AsVariant, false));
        if Data.FieldByName('VIEW_REF').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('VIEW_REF').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(Data.FieldByName('VIEW_REF').AsVariant, false));
        if Data.FieldByName('CONFIG_').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('CONFIG_').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(Data.FieldByName('CONFIG_').AsVariant, false));
        if Data.FieldByName('VIEW_').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('VIEW_').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(Data.FieldByName('VIEW_').AsVariant, false));
        if Data.FieldByName('EXPORT').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('EXPORT').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(Data.FieldByName('EXPORT').AsVariant, false));
        if Data.FieldByName('IMPORT').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('IMPORT').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(Data.FieldByName('IMPORT').AsVariant, false));
        if Data.FieldByName('GRID_SAVE').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('GRID_SAVE').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP'))
        else
          sl.Add(VariantToDBStr(Data.FieldByName('GRID_SAVE').AsVariant, false));
        sl.Add(VariantToDBStr(Data.FieldByName('GUID').AsVariant, true));

        gcsGenInsertSQL(Script, sl, tableName, 'REFERENCE_PK, ROLE_PK, ADD_, EDIT_, DEL_, VIEW_REF, CONFIG_, VIEW_, EXPORT, IMPORT, FILTRING, GRID_SAVE, GUID',
          [], []);

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
          Script.Add('  /* ' + tableName + ' */');
        end;

        sl.Add('ROLE_PK = ' + VariantToDBStr(Data.FieldByName('ROLE_PK').AsVariant, false));
        if Data.FieldByName('ADD_').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('ADD_').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'ADD_ = '))
        else
          sl.Add('ADD_ = ' + VariantToDBStr(Data.FieldByName('ADD_').AsVariant, false));
        if Data.FieldByName('EDIT_').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('EDIT_').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'EDIT_ = '))
        else
          sl.Add('EDIT_ = ' + VariantToDBStr(Data.FieldByName('EDIT_').AsVariant, false));
        if Data.FieldByName('DEL_').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('DEL_').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'DEL_ = '))
        else
          sl.Add('DEL_ = ' + VariantToDBStr(Data.FieldByName('DEL_').AsVariant, false));
        if Data.FieldByName('VIEW_REF').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('VIEW_REF').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'VIEW_REF = '))
        else
          sl.Add('VIEW_REF = ' + VariantToDBStr(Data.FieldByName('VIEW_REF').AsVariant, false));
        if Data.FieldByName('CONFIG_').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('CONFIG_').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'CONFIG_ = '))
        else
          sl.Add('CONFIG_ = ' + VariantToDBStr(Data.FieldByName('CONFIG_').AsVariant, false));
        if Data.FieldByName('VIEW_').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('VIEW_').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'VIEW_ = '))
        else
          sl.Add('VIEW_ = ' + VariantToDBStr(Data.FieldByName('VIEW_').AsVariant, false));
        if Data.FieldByName('EXPORT').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('EXPORT').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'EXPORT = '))
        else
          sl.Add('EXPORT = ' + VariantToDBStr(Data.FieldByName('EXPORT').AsVariant, false));
        if Data.FieldByName('IMPORT').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('IMPORT').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'IMPORT = '))
        else
          sl.Add('IMPORT = ' + VariantToDBStr(Data.FieldByName('IMPORT').AsVariant, false));
        if Data.FieldByName('GRID_SAVE').AsInteger > 1 then
          sl.Add(gcsGenParentParam(Script, Vars, TmplCache, Data.FieldByName('GRID_SAVE').Value, 'TMPL_PK', 'PK', 'DYNAMIC_FORM_PERM_TMP', 'GRID_SAVE = '))
        else
          sl.Add('GRID_SAVE = ' + VariantToDBStr(Data.FieldByName('GRID_SAVE').AsVariant, false));

        result := gcsGenUpdateSQL(Script, sl, tableName, 'GUID', VariantToDBStr(Data.FieldByName('GUID').AsVariant, true), []);
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

function TFEditDict.gcsPostFilter(Script, Vars, FcfgCache: TStringList): boolean;
var
  bm: TBookmark;
  sl: TStringList;

begin
  result := false;
  sl := TStringList.Create;

  try
    // удаление
    result := gcsGenDeleteSQL(Script, DeletedPostFilters, 'DYNAMIC_FROM_POST_FILTER', 'PK');

    bm := mtPostFilter.GetBookmark;
    mtPostFilter.DisableControls;

    // добавление
    mtPostFilter.First;
    while not mtPostFilter.Eof do
    begin
      if mtPostFilterCHANGED.AsBoolean and mtPostFilterPK.IsNull then
      begin
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* DYNAMIC_FROM_POST_FILTER */');
        end;

        sl.Add(VariantToDBStr(mtPostFilterPOST_PK.AsVariant, false));
        sl.Add(gcsGenParentParam(Script, Vars, FcfgCache, mtPostFilterFILTER_CONFIG_PK.AsVariant, 'FILTER_CONF_PK', 'PK', 'DYNAMIC_FORM_FILTER_CONFIG'));
        sl.Add(VariantToDBStr(mtPostFilterGUID.AsVariant, true));

        gcsGenInsertSQL(Script, sl, 'DYNAMIC_FROM_POST_FILTER', 'POST_PK, FILTER_CONFIG_PK, GUID', [], []);
        result := true;
      end;
      mtPostFilter.Next;
    end;
  finally
    sl.Free;
    if mtPostFilter.BookmarkValid(bm) then
    begin
      mtPostFilter.GotoBookmark(bm);
      mtPostFilter.FreeBookmark(bm);
    end;
    mtPostFilter.EnableControls;
  end;
end;

function TFEditDict.gcsReference(Script, Vars: TStringList): boolean;
var
  sl: TStringList;
  i: integer;

begin
  sl := TStringList.Create;
  result := false;

  try
    if (Assigned(StartForm) and (dsDictSTART_FORM_PK.IsNull or (dsDictSTART_FORM_PK.AsInteger = -1))) or
      ((not Assigned(StartForm)) and ((not dsDictSTART_FORM_PK.IsNull) and (dsDictSTART_FORM_PK.AsInteger <> -1))) or
      (CanStdStartForm and (dsDictSTART_FORM_PK.AsInteger <> -1)) then
      sl.Add('START_FORM_PK = :START_FORM_PK');
    if (Assigned(GrEditForm) and dsDictGROUP_EDIT_FORM_PK.IsNull) or ((not Assigned(GrEditForm)) and (not dsDictGROUP_EDIT_FORM_PK.IsNull)) then
      sl.Add('GROUP_EDIT_FORM_PK = :GR_EDIT_FORM_PK');

    gcsCheckOption(sl, dsDictDESCRIPTOR_, Trim(edDictDescriptor.Text), true);
    gcsCheckOption(sl, dsDictTITLE, Trim(edDictTitle.Text), true);
    gcsCheckOption(sl, dsDictORDER_BY, Trim(GetOrders), true);
    gcsCheckOption(sl, dsDictPARENT_REFERENCE_PK, lcbParentDict.KeyValue, false, true, true);
    gcsCheckOption(sl, dsDictBASE_DESCRIPTOR, cbDictBaseDescriptor.Text, true);
    gcsCheckOption(sl, dsDictFOLDER_PK, lcbFolder.KeyValue, false, true, true);
    gcsCheckOption(sl, dsDictPARENT_ID_FIELD, lcbDictParentIdField.KeyValue, true);
    gcsCheckOption(sl, dsDictID_FIELD, lcbDictIdField.KeyValue, true);
    gcsCheckOption(sl, dsDictEXPAND_REF, iif(chbDictExpandRef.Checked, '1', '0'), true, false);
    gcsCheckOption(sl, dsDictCOLLAPSE_FILTER, iif(chbDictCollapseFilter.Checked, '1', '0'), true, false);
    gcsCheckOption(sl, dsDictGROUPING, lcbDictGrouping.KeyValue, true);
    gcsCheckOption(sl, dsDictCON_ORIENT, cbDictConOrient.ItemIndex, false);
    gcsCheckOption(sl, dsDictBRIEF_NOTE, lcbDictDocument.KeyValue, false, true, true);
    gcsCheckOption(sl, dsDictEDITABLE, iif(chbDictEditable.Checked, 1, 0), false);
    gcsCheckOption(sl, dsDictSET_DISTINCT, iif(chbDictSetDistinct.Checked, '1', '0'), true, false);
    gcsCheckOption(sl, dsDictREF_SIZE, edDictRefSize.Value, false, true, true);
    gcsCheckOption(sl, dsDictSHOW_ONLY_ADMIN, iif(chbDictShowOnlyAdmin.Checked, 1, 0), false);
    gcsCheckOption(sl, dsDictEXPAND_TREE, iif(chbDictExpandTree.Checked, 1, 0), false);
    gcsCheckOption(sl, dsDictUSE_MEM, iif(chbDictUseMem.Checked, 1, 0), false);
    gcsCheckOption(sl, dsDictCOUNT_ON_PAGE, edDictCountOnPage.Value, false, true, true);
    gcsCheckOption(sl, dsDictDEFERRED_IMPORTS, iif(chbDictDeferredImports.Checked, 1, 0), false);
    gcsCheckOption(sl, dsDictAUTOSAVEINTERVAL, edDictAutosaveInterval.Value, false, true, true);
    gcsCheckOption(sl, dsDictSKIP_DUPLICATES, iif(chbDictSkipDuplicates.Checked, '1', '0'), true, false);
    gcsCheckOption(sl, dsDictSHOW_FILTER_BOUND, iif(cbDictShowFilterBound.ItemIndex = 0, Null, cbDictShowFilterBound.Text), true);
    gcsCheckOption(sl, dsDictCHECK_SELECT, iif(chbCheckSelect.Checked, 1, 0), false);

    if sl.Count > 0 then
    begin
      // если в sl есть PARENT_REFERENCE_PK, надо заменить его на вытягивание этого PK по дескрипору родителя
      i := FindInStrings(sl, 'PARENT_REFERENCE_PK', [foToExistence]);
      if i > -1 then
        sl.Strings[i] := gcsGenParentParam(Script, Vars, TStringList.Create, lcbParentDict.KeyValue, 'PARENT_REFERENCE_PK', 'PK', 'DYNAMIC_FORM_REFERENCE',
          'PARENT_REFERENCE_PK = ');

      // если в sl есть FOLDER_PK, надо заменить его на вытягивание этого PK по имени папки
      i := FindInStrings(sl, 'FOLDER_PK', [foToExistence]);
      if i > -1 then
        sl.Strings[i] := gcsGenParentParam(Script, Vars, TStringList.Create, lcbFolder.KeyValue, 'FOLDER_PK', 'PK', 'DYNAMIC_FORM_FOLDER', 'FOLDER_PK = ');

      result := gcsGenUpdateSQL(Script, sl, 'DYNAMIC_FORM_REFERENCE', 'PK', ':REF_PK', ['MODIFY = current_timestamp'], '/* DYNAMIC_FORM_REFERENCE */');
    end;
  finally
    sl.Free;
  end;
end;

function TFEditDict.gcsTemplates(Script, Vars, Cache, PkList: TStringList): boolean;
var
  ds: TpFIBDataSet;
  n: integer;

begin
  result := false;
  if PkList.Count = 0 then exit;

  try
    ds := FMain.OpenSQL('select GUID, TEXT_TEMPLATE from DYNAMIC_FORM_PERM_TMP where PK in (' + TextToString(PkList.Text) + ')');

    while not ds.Eof do
    begin
      if ds.FieldByName('GUID').IsNull then raise Exception.Create(GUID_WARNING);

      if not result then
      begin
        Script.Add('');
        Script.Add('  /* DYNAMIC_FORM_PERM_TMP */');
      end;

      if Cache.IndexOf(ds.FieldByName('GUID').AsString) = -1 then
      begin
        n := Cache.Add(ds.FieldByName('GUID').AsString);
        Vars.Add('declare variable TMPL_PK' + IntToStr(n) + ' integer;');

        Script.Add('');
        Script.Add('  select PK from DYNAMIC_FORM_PERM_TMP where GUID = ' + VariantToDBStr(ds.FieldByName('GUID').AsString, true) + ' into :TMPL_PK' + IntToStr(n) + ';');
        Script.Add('  if (TMPL_PK' + IntToStr(n) + ' is null) then');
        Script.Add('    insert into DYNAMIC_FORM_PERM_TMP (GUID, TEXT_TEMPLATE)');
        Script.Add('    values (' + VariantToDBStr(ds.FieldByName('GUID').AsString, true) + ', ' + VariantToDBStr(ds.FieldByName('TEXT_TEMPLATE').AsString, true) + ')');
        Script.Add('    returning PK into :TMPL_PK' + IntToStr(n) + ';');
        Script.Add('  else');
        Script.Add('    update DYNAMIC_FORM_PERM_TMP set TEXT_TEMPLATE = ' + VariantToDBStr(ds.FieldByName('TEXT_TEMPLATE').AsString, true));
        Script.Add('    where GUID = ' + VariantToDBStr(ds.FieldByName('GUID').AsString, true) + ';');

        result := true;
      end;
      ds.Next;
    end;
  finally
    ds.Close;
    ds.Free;
  end;
end;

function TFEditDict.gcsDbObjects(Script, Vars, Cache: TStringList): boolean;
var
  bm: TBookmark;
  sl: TStringList;
  n: integer;

begin
  result := false;
  sl := TStringList.Create;

  try
    // удаление
    result := gcsGenDeleteSQL(Script, DeletedObjects, 'DYNAMIC_FORM_OBJECT_TREE', 'PK');

    bm := mtObjectTree.GetBookmark;
    mtObjectTree.DisableControls;

    // добавление
    mtObjectTree.First;
    while not mtObjectTree.Eof do
    begin
      if mtObjectTreeCHANGED.AsBoolean and mtObjectTreePK.IsNull then
      begin
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* DYNAMIC_FORM_OBJECT_TREE */');
        end;

        sl.Add(VariantToDBStr(FMain.dsPortalUserPK.Value, false));
        sl.Add(VariantToDBStr(mtObjectTreeTITLE.AsVariant, true));
        sl.Add(VariantToDBStr(mtObjectTreeNAME.AsVariant, true));
        sl.Add(VariantToDBStr(mtObjectTreeOBJECT_TYPE.AsVariant, true));
        sl.Add(':MAIN_FORM_PK');
        sl.Add(gcsGenParentParam(Script, Vars, Cache, mtObjectTreeJOIN_PARENT_PK.AsVariant, 'OBJECT_PK', 'PK', 'DYNAMIC_FORM_OBJECT_TREE'));
        sl.Add(VariantToDBStr(mtObjectTreeIS_MULTI_JOIN.AsVariant, true));
        sl.Add(VariantToDBStr(mtObjectTreeJOIN_FIELDS.AsVariant, true));
        sl.Add(VariantToDBStr(mtObjectTreePARAMETERS.AsVariant, true));
        sl.Add(VariantToDBStr(mtObjectTreeDELETED.AsVariant, false));
        sl.Add(VariantToDBStr(mtObjectTreeINNER_JOIN.AsVariant, false));
        sl.Add(VariantToDBStr(mtObjectTreeGUID.AsVariant, true));

        n := Cache.Add(mtObjectTreeGUID.AsString);
        Vars.Add('declare variable OBJECT_PK' + IntToStr(n) + ' integer;');

        gcsGenInsertSQL(Script, sl, 'DYNAMIC_FORM_OBJECT_TREE', 'OWNER_USER_PK, TITLE, NAME, OBJECT_TYPE, FORM_PK, JOIN_PARENT_PK, IS_MULTI_JOIN, JOIN_FIELDS, ' +
          'PARAMETERS, DELETED, INNER_JOIN, GUID', ['PK'], [':OBJECT_PK' + IntToStr(n)]);

        result := true;
      end;
      mtObjectTree.Next;
    end;

    // обновление
    mtObjectTree.First;
    while not mtObjectTree.Eof do
    begin
      if mtObjectTreeCHANGED.AsBoolean and (not mtObjectTreePK.IsNull) then
      begin
        if mtObjectTreeGUID.IsNull then raise Exception.Create(GUID_WARNING);
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* DYNAMIC_FORM_OBJECT_TREE */');
        end;

        sl.Add(gcsGenParentParam(Script, Vars, Cache, mtObjectTreeJOIN_PARENT_PK.AsVariant, 'OBJECT_PK', 'PK', 'DYNAMIC_FORM_OBJECT_TREE', 'JOIN_PARENT_PK = '));
        sl.Add('TITLE = ' + VariantToDBStr(mtObjectTreeTITLE.AsVariant, true));
        sl.Add('NAME = ' + VariantToDBStr(mtObjectTreeNAME.AsVariant, true));
        sl.Add('OBJECT_TYPE = ' + VariantToDBStr(mtObjectTreeOBJECT_TYPE.AsVariant, true));
        sl.Add('IS_MULTI_JOIN = ' + VariantToDBStr(mtObjectTreeIS_MULTI_JOIN.AsVariant, true));
        sl.Add('JOIN_FIELDS = ' + VariantToDBStr(mtObjectTreeJOIN_FIELDS.AsVariant, true));
        sl.Add('PARAMETERS = ' + VariantToDBStr(mtObjectTreePARAMETERS.AsVariant, true));
        sl.Add('DELETED = ' + VariantToDBStr(mtObjectTreeDELETED.AsVariant, false));
        sl.Add('INNER_JOIN = ' + VariantToDBStr(mtObjectTreeINNER_JOIN.AsVariant, false));

        result := gcsGenUpdateSQL(Script, sl, 'DYNAMIC_FORM_OBJECT_TREE', 'GUID', VariantToDBStr(mtObjectTreeGUID.AsVariant, true), []);
      end;
      mtObjectTree.Next;
    end;
  finally
    sl.Free;
    if mtObjectTree.BookmarkValid(bm) then
    begin
      mtObjectTree.GotoBookmark(bm);
      mtObjectTree.FreeBookmark(bm);
    end;
    mtObjectTree.EnableControls;
  end;
end;

function TFEditDict.gcsEvents(Script, Vars: TStringList): boolean;
var
  bm: TBookmark;
  sl, cache: TStringList;

begin
  result := false;
  sl := TStringList.Create;
  cache := TStringList.Create;

  try
    // удаление
    result := gcsGenDeleteSQL(Script, DeletedEvents, 'DYNAMIC_FORM_OTHER_EVENT', 'ID_EV');

    bm := mtOtherEvents.GetBookmark;
    mtOtherEvents.DisableControls;

    // добавление
    mtOtherEvents.First;
    while not mtOtherEvents.Eof do
    begin
      if mtOtherEventsCHANGED.AsBoolean and mtOtherEventsID_EV.IsNull then
      begin
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* DYNAMIC_FORM_OTHER_EVENT */');
        end;

        sl.Add(':REF_PK');
        sl.Add(VariantToDBStr(mtOtherEventsTITLE_EV.AsVariant, true));
        sl.Add(gcsGenParentParam(Script, Vars, cache, mtOtherEventsEVENT_REFERENCE.AsVariant, 'REF_PK', 'PK', 'DYNAMIC_FORM_REFERENCE'));
        sl.Add(VariantToDBStr(mtOtherEventsPOSITION_EV.AsVariant, false));
        sl.Add(VariantToDBStr(mtOtherEventsIMAGE_NAME_EV.AsVariant, true));
        sl.Add(VariantToDBStr(mtOtherEventsVIEW_TO_MENU.AsVariant, false));
        sl.Add(VariantToDBStr(mtOtherEventsCLASS_NAME.AsVariant, true));
        sl.Add(gcsGenParentParam(Script, Vars, cache, mtOtherEventsIS_VIZARD.AsVariant, 'SCEN_PK', 'PK', 'WIZARD_SCENS'));
        sl.Add(VariantToDBStr(mtOtherEventsALIAS_DF.AsVariant, true));
        sl.Add(VariantToDBStr(mtOtherEventsLINK_METHOD.AsVariant, true));
        sl.Add(VariantToDBStr(mtOtherEventsGUID.AsVariant, true));

        gcsGenInsertSQL(Script, sl, 'DYNAMIC_FORM_OTHER_EVENT', 'ID_DF_REFERENCE, TITLE_EV, EVENT_REFERENCE, POSITION_EV, IMAGE_NAME_EV, VIEW_TO_MENU, ' +
          'CLASS_NAME, IS_VIZARD, ALIAS_DF, LINK_METHOD, GUID', [], []);

        result := true;
      end;
      mtOtherEvents.Next;
    end;

    // обновление
    mtOtherEvents.First;
    while not mtOtherEvents.Eof do
    begin
      if mtOtherEventsCHANGED.AsBoolean and (not mtOtherEventsID_EV.IsNull) then
      begin
        if mtOtherEventsGUID.IsNull then raise Exception.Create(GUID_WARNING);
        sl.Clear;

        if not result then
        begin
          Script.Add('');
          Script.Add('  /* DYNAMIC_FORM_OTHER_EVENT */');
        end;

        sl.Add('TITLE_EV = ' + VariantToDBStr(mtOtherEventsTITLE_EV.AsVariant, true));
        sl.Add(gcsGenParentParam(Script, Vars, cache, mtOtherEventsEVENT_REFERENCE.AsVariant, 'REF_PK', 'PK', 'DYNAMIC_FORM_REFERENCE', 'EVENT_REFERENCE = '));
        sl.Add('POSITION_EV = ' + VariantToDBStr(mtOtherEventsPOSITION_EV.AsVariant, false));
        sl.Add('IMAGE_NAME_EV = ' + VariantToDBStr(mtOtherEventsIMAGE_NAME_EV.AsVariant, true));
        sl.Add('VIEW_TO_MENU = ' + VariantToDBStr(mtOtherEventsVIEW_TO_MENU.AsVariant, false));
        sl.Add('CLASS_NAME = ' + VariantToDBStr(mtOtherEventsCLASS_NAME.AsVariant, true));
        sl.Add(gcsGenParentParam(Script, Vars, cache, mtOtherEventsIS_VIZARD.AsVariant, 'SCEN_PK', 'PK', 'WIZARD_SCENS', 'IS_VIZARD = '));
        sl.Add('ALIAS_DF = ' + VariantToDBStr(mtOtherEventsALIAS_DF.AsVariant, true));
        sl.Add('LINK_METHOD = ' + VariantToDBStr(mtOtherEventsLINK_METHOD.AsVariant, true));

        result := gcsGenUpdateSQL(Script, sl, 'DYNAMIC_FORM_OTHER_EVENT', 'GUID', VariantToDBStr(mtOtherEventsGUID.AsVariant, true), []);
      end;
      mtOtherEvents.Next;
    end;
  finally
    sl.Free;
    cache.Free;
    
    if mtOtherEvents.BookmarkValid(bm) then
    begin
      mtOtherEvents.GotoBookmark(bm);
      mtOtherEvents.FreeBookmark(bm);
    end;
    mtOtherEvents.EnableControls;
  end;
end;

function TFEditDict.gcsExtForm(Script, Vars: TStringList; ExtForm: TfrmEditForm; isStartForm: boolean): boolean;
var
  sl: TStringList;
  comment, varName, keyFieldName: string;
  ds: TpFIBDataSet;

begin
  sl := TStringList.Create;
  result := false;

  if isStartForm then
  begin
    comment := '/* DYNAMIC_FORM - Start form */';
    varName := 'START_FORM_PK';
    keyFieldName := 'START_FORM_PK';
    ds := dsStartForm;
  end else
  begin
    comment := '/* DYNAMIC_FORM - Group edit form */';
    varName := 'GR_EDIT_FORM_PK';
    keyFieldName := 'GROUP_EDIT_FORM_PK';
    ds := dsGrEditForm;
  end;

  try
    if Assigned(ExtForm) then
    begin
      if dsDict.FieldByName(keyFieldName).IsNull or ((dsDict.FieldByName(keyFieldName).AsInteger = -1) and isStartForm) then
      begin
        // надо создать
        result := true;

        sl.Add(VariantToDBStr(FMain.dsPortalUserPK.Value, false));
        sl.Add(VariantToDBStr(Trim(ExtForm.edFormTitle.Text), true));
        sl.Add(VariantToDBStr(ExtForm.edFormWidth.Value, false, true, true));
        sl.Add(VariantToDBStr(ExtForm.edFormHeight.Value, false, true, true));
        sl.Add(VariantToDBStr(Trim(ExtForm.edFormAlias.Text), true));
        sl.Add(iif(ExtForm.chbLeftAlign.Checked, '1', '0'));
        sl.Add(VariantToDBStr(ExtForm.edLabelWidth.Value, false, true, true));
        sl.Add(VariantToDBStr(ExtForm.FormGUID, true));
        gcsGenInsertSQL(Script, sl, 'DYNAMIC_FORM', 'OWNER_USER_PK, TITLE, WIDTH, HEIGHT, ALIAS_FORM, LEFT_ALIGN, LABEL_WIDTH, GUID', ['PK'],
          [':' + varName], comment);
      end else
      begin
        // обновить
        gcsCheckOption(sl, ds.FieldByName('ALIAS_FORM'), Trim(ExtForm.edFormAlias.Text), true);
        gcsCheckOption(sl, ds.FieldByName('TITLE'), Trim(ExtForm.edFormTitle.Text), true);
        gcsCheckOption(sl, ds.FieldByName('WIDTH'), ExtForm.edFormWidth.Value, false, true, true);
        gcsCheckOption(sl, ds.FieldByName('HEIGHT'), ExtForm.edFormHeight.Value, false, true, true);
        gcsCheckOption(sl, ds.FieldByName('LEFT_ALIGN'), iif(ExtForm.chbLeftAlign.Checked, 1, 0), false);
        gcsCheckOption(sl, ds.FieldByName('LABEL_WIDTH'), ExtForm.edLabelWidth.Value, false, true, true);
        result := gcsGenUpdateSQL(Script, sl, 'DYNAMIC_FORM', 'PK', ':' + varName, ['MODIFY = current_timestamp'], comment);
      end;
    end else
    begin
      // удаляем
      if not dsDict.FieldByName(keyFieldName).IsNull then
      begin
        if (ds.FieldByName(keyFieldName).AsInteger <> -1) or (not isStartForm) then
        begin
          result := true;
          Script.Add('');
          Script.Add('  ' + comment);
          Script.Add('  delete from DYNAMIC_FORM where PK = :' + varName + ';');
          Script.Add('  ' + varName + ' = null;');
        end else
        begin
          if (not CanStdStartForm) and isStartForm then
          begin
            result := true;
            Script.Add('');
            Script.Add('  ' + varName + ' = null;');
          end;
        end;
      end else
      begin
        if CanStdStartForm and isStartForm then
        begin
          result := true;
          Script.Add('');
          Script.Add('  ' + varName + ' = -1;');
        end;
      end;
    end;
  finally
    sl.Free;
  end;
end;

function TFEditDict.GenChangesSQL(Script, Vars: TStringList): boolean;
var
  objCache, grCache, tmplCache, filterGrCache, filterCfgCache, grChartCache, fldCache: TStringList;

begin
  result := false;
  objCache := TStringList.Create;
  grCache := TStringList.Create;
  tmplCache := TStringList.Create;
  filterGrCache := TStringList.Create;
  filterCfgCache := TStringList.Create;
  grChartCache := TStringList.Create;
  fldCache := TStringList.Create;

  try
    Vars.Add('declare variable REF_PK integer;');
    Vars.Add('declare variable MAIN_FORM_PK integer;');
    Vars.Add('declare variable START_FORM_PK integer;');
    Vars.Add('declare variable GR_EDIT_FORM_PK integer;');
    Script.Add('  select PK, MAIN_FORM_PK, START_FORM_PK, GROUP_EDIT_FORM_PK from DYNAMIC_FORM_REFERENCE');
    Script.Add('  where DESCRIPTOR_ = ''' + dsDictDESCRIPTOR_.AsString + '''');
    Script.Add('  into :REF_PK, :MAIN_FORM_PK, :START_FORM_PK, :GR_EDIT_FORM_PK;');

    // главная форма
    result := gcsMainForm(Script, Vars);
    // стартовая форма (если есть)
    if gcsExtForm(Script, Vars, StartForm, true) then result := true;
    // форма группового редактирования (если есть)
    if gcsExtForm(Script, Vars, GrEditForm, false) then result := true;
    // референс
    if gcsReference(Script, Vars) then result := true;
    // объекты БД
    if gcsDbObjects(Script, Vars, objCache) then result := true;

    // группы главной формы
    if gcsGroups(Script, Vars, DeletedGroups, grCache, 'MAIN_FORM_PK', mtGroups) then result := true;
    // группы фильтров главной формы
    if gcsFilterGroups(Script, Vars, filterGrCache) then result := true;
    // поля главной формы
    if gcsFields(Script, Vars, DeletedFields, objCache, grCache, tmplCache, filterGrCache, 'MAIN_FORM_PK', mtFormFields) then result := true;

    if Assigned(StartForm) then
    begin
      // группы стартовой формы
      if gcsGroups(Script, Vars, StartForm.DeletedGroups, grCache, 'START_FORM_PK', StartForm.mtGroups) then result := true;
      // поля стартовой формы
      if gcsFields(Script, Vars, StartForm.DeletedFields, objCache, grCache, tmplCache, filterGrCache, 'START_FORM_PK', StartForm.mtFormFields) then result := true;
    end;

    if Assigned(GrEditForm) then
    begin
      // группы формы гр. редакт.
      if gcsGroups(Script, Vars, GrEditForm.DeletedGroups, grCache, 'GR_EDIT_FORM_PK', GrEditForm.mtGroups) then result := true;
      // поля формы гр. редакт.
      if gcsFields(Script, Vars, GrEditForm.DeletedFields, objCache, grCache, tmplCache, filterGrCache, 'GR_EDIT_FORM_PK', GrEditForm.mtFormFields) then result := true;
    end;

    // права должностей
    if gcsPermissions(Script, Vars, DeletedPermRanks, tmplCache, mtPermRanks) then result := true;
    // права ролей
    if gcsPermissions(Script, Vars, DeletedPermRoles, tmplCache, mtPermRoles) then result := true;
    // конфигурации фильтров
    if gcsFilterConfigs(Script, Vars, filterCfgCache) then result := true;
    // привязка конфигурации фильтров к должности
    if gcsPostFilter(Script, Vars, filterCfgCache) then result := true;
    // группы графиков
    if gcsChartGroups(Script, Vars, grChartCache) then result := true;
    // графики
    if gcsCharts(Script, Vars, grChartCache, fldCache) then result := true;
    // кнопки, пункты меню
    if gcsEvents(Script, Vars) then result := true;
  finally
    objCache.Free;
    grCache.Free;
    tmplCache.Free;
    filterGrCache.Free;
    filterCfgCache.Free;
    grChartCache.Free;
    fldCache.Free;
  end;
end;

function TFEditDict.GetColumnStyles(dsSrc: TMemTableEh): string;
begin
  result := '';
  if dsSrc.IsEmpty then exit;

  dsSrc.DisableControls;
  try
    dsSrc.First;
    while not dsSrc.Eof do
    begin
      if result = '' then
        result := '"' + Trim(PyAnsiToUnicode(dsSrc.FieldByName('STYLE').AsString)) + '"'
      else
        result := result + ', "' + Trim(PyAnsiToUnicode(dsSrc.FieldByName('STYLE').AsString)) + '"';

      dsSrc.Next;
    end;
    result := '[' + result + ']';
  finally
    dsSrc.EnableControls;
  end;
end;

function TFEditDict.GetFieldTypeParams(OptList: TContainer): string;
var
  i: integer;

begin
  result := '';

  for i := 0 to OptList.Count - 1 do
  begin
    if result = '' then
      result := OptList.OptionRecByIndex[i].Expression
    else
      result := result + ', ' + OptList.OptionRecByIndex[i].Expression;
  end;
  result := '{' + result + '}';
end;

function TFEditDict.GetInputParams(dsSrc: TMemTableEh): string;
var
  s: string;
  
begin
  result := '{}';
  if not dsSrc.Active then exit;

  dsSrc.DisableControls;
  try
    result := '{"inputParams": [';
    dsSrc.First;
    while not dsSrc.Eof do
    begin
      s := '{"type": "' + PyAnsiToUnicode(dsSrc.FieldByName('TYPE').AsString) + '", "name": "' +
        PyAnsiToUnicode(dsSrc.FieldByName('NAME').AsString) + '"';

      if (dsSrc.FieldByName('TYPE').AsString <> PROCPARAM_user) then
        s := s + ', "value": "' + PyAnsiToUnicode(dsSrc.FieldByName('VALUE').AsString) + '"}'
      else
        s := s + '}';

      if dsSrc.RecNo = 1 then result := result + s
      else result := result + ', ' + s;
      
      dsSrc.Next;
    end;
    result := result + ']}'
  finally
    dsSrc.EnableControls;
  end;
end;

function TFEditDict.GetJoinFields(dsSrc: TMemTableEh): string;
var
  rec: string;
  v: integer;

begin
  result := '';

  dsSrc.DisableControls;
  try
    dsSrc.First;
    while not dsSrc.Eof do
    begin
      try
        v := dsSrc.FieldByName('CHILD_FIELD').AsInteger;
        rec := dsSrc.FieldByName('CHILD_FIELD').AsString + ', ';
      except
        rec := '"' + PyAnsiToUnicode(dsSrc.FieldByName('CHILD_FIELD').AsString) + '", ';
      end;

      try
        v := dsSrc.FieldByName('PARENT_FIELD').AsInteger;
        rec := rec + dsSrc.FieldByName('PARENT_FIELD').AsString;
      except
        rec := rec + '"' + PyAnsiToUnicode(dsSrc.FieldByName('PARENT_FIELD').AsString) + '"';
      end;

      if ((not dsSrc.FieldByName('OPERATOR').IsNull) and (dsSrc.FieldByName('OPERATOR').AsString <> '')) or
         ((not dsSrc.FieldByName('CONDITION').IsNull) and dsSrc.FieldByName('CONDITION').AsBoolean) then
      begin
        if dsSrc.FieldByName('OPERATOR').AsString = '' then
          rec := rec + ', "="'
        else
          rec := rec + ', "' + PyAnsiToUnicode(dsSrc.FieldByName('OPERATOR').AsString) + '"';
          
        if (not dsSrc.FieldByName('CONDITION').IsNull) and dsSrc.FieldByName('CONDITION').AsBoolean then
          rec := rec + ', "OR"';
      end;

      if result = '' then result := '[' + rec + ']'
      else result := result + ', [' + rec + ']';

      dsSrc.Next;
    end;
    result := '[' + result + ']';
  finally
    dsSrc.EnableControls;
  end;
end;

function TFEditDict.GetMainObjectName: string;
begin
  result := '';
  if (not mtObjectTree.Active) or (mtObjectTree.IsEmpty) then exit;

  if mtObjectTree.State in [dsEdit, dsInsert] then mtObjectTree.Cancel;
  mtObjectTree.DisableControls;
  try
    mtObjectTree.First;
    while not mtObjectTree.Eof do
    begin
      if mtObjectTreeIS_MAIN.AsBoolean then
      begin
        result := mtObjectTreeNAME.AsString;
        break;
      end;
      mtObjectTree.Next;
    end;
  finally
    mtObjectTree.First;
    mtObjectTree.EnableControls;
  end;
end;

function TFEditDict.GetNotInvolvedFields(Fields: TMemTableEh; AddProcParams: boolean): string;
var
  bm: TBookmark;
  dsChildRef: TUniQuery;

begin
  result := '';

  try
    try
      Screen.Cursor := crSQLWait;
      // список полей всех объектов справочника
      if dsFieldsParams.Active then dsFieldsParams.Close;
      SetSystemFieldsSQL(dsFieldsParams, cbDictBaseDescriptor.Text, AddProcParams);
      dsFieldsParams.Open;

      if (not dsFieldsParams.Active) or dsFieldsParams.IsEmpty then exit;

      bm := Fields.GetBookmark;
      Fields.DisableControls;
      dsFieldsParams.First;
      while not dsFieldsParams.Eof do
      begin
        if not Fields.Locate('OBJECT_NAME;FIELD_NAME',
          VarArrayOf([dsFieldsParams.FieldByName('TABLE_NAME').Value, dsFieldsParams.FieldByName('FIELD_NAME').Value]), [loCaseInsensitive]) then
        begin
          if result = '' then
            result := dsFieldsParams.FieldByName('TABLE_NAME').AsString + '.' + dsFieldsParams.FieldByName('FIELD_NAME').AsString
          else
            result := result + #13#10 + dsFieldsParams.FieldByName('TABLE_NAME').AsString + '.' + dsFieldsParams.FieldByName('FIELD_NAME').AsString;
        end;

        dsFieldsParams.Next;
      end;

      // дополним списком полей привязки дочерних справочников
      dsChildRef := ConnectionsList.GetDataSet(FSettings.MainDescriptor, qtUserDefined,
        'select o.NAME, r.DESCRIPTOR_ from DYNAMIC_FORM_REFERENCE r ' +
        'join DYNAMIC_FORM_OBJECT_TREE o on o.FORM_PK = r.MAIN_FORM_PK and (o.JOIN_PARENT_PK is null or ' +
        '((o.JOIN_PARENT_PK is not null) and (o.IS_MULTI_JOIN = ''1''))) where PARENT_REFERENCE_PK = :PK');

      dsChildRef.ParamByName('PK').Value := Properties.PK;
      dsChildRef.Open;
      dsChildRef.First;
      while not dsChildRef.Eof do
      begin
        if not Fields.Locate('OBJECT_NAME;FIELD_NAME',
          VarArrayOf([dsChildRef.FieldByName('NAME').Value, dsChildRef.FieldByName('DESCRIPTOR_').Value]), [loCaseInsensitive]) then
        begin
          if result = '' then
            result := dsChildRef.FieldByName('NAME').AsString + '.' + dsChildRef.FieldByName('DESCRIPTOR_').AsString
          else
            result := result + #13#10 + dsChildRef.FieldByName('NAME').AsString + '.' + dsChildRef.FieldByName('DESCRIPTOR_').AsString;
        end;

        dsChildRef.Next;
      end;
    finally
      Screen.Cursor := crDefault;
      if Fields.BookmarkValid(bm) then
      begin
        Fields.GotoBookmark(bm);
        Fields.FreeBookmark(bm);
      end;
      Fields.EnableControls;
      dsFieldsParams.Close;
      if Assigned(dsChildRef) then
      begin
        dsChildRef.Close;
        dsChildRef.Free;
      end;
    end;
  except
  end;
end;

function TFEditDict.GetObjectNames(getPk: boolean): string;
begin
  // список всех объектов БД справочника. Может вернуть дескрипторы или pk
  result := '';
  if (not mtObjectTree.Active) or (mtObjectTree.IsEmpty) then exit;

  if mtObjectTree.State in [dsEdit, dsInsert] then mtObjectTree.Cancel;
  mtObjectTree.DisableControls;
  try
    mtObjectTree.First;
    while not mtObjectTree.Eof do
    begin
      if getPk then
      begin
        if result = '' then result := mtObjectTreePK.AsString
        else result := result + ',' + mtObjectTreePK.AsString;
      end else
      begin
        if result = '' then result := '''' + mtObjectTreeNAME.AsString + ''''
        else result := result + ', ''' + mtObjectTreeNAME.AsString + '''';
      end;
      mtObjectTree.Next;
    end;
  finally
    mtObjectTree.First;
    mtObjectTree.EnableControls;
  end;
end;

function TFEditDict.GetObjectPkField(ObjectName: string): string;
begin
  result := '';

  if mtObjectTree.Locate('NAME', ObjectName, [loCaseInsensitive]) then
    result := ExtractParamValue(mtObjectTreePARAMETERS.AsString, 'primaryKey');
end;

function TFEditDict.GetOrders: string;
begin
  result := '';
  mtDictOrderBy.DisableControls;
  try
    if not mtDictOrderBy.Active then exit;

    mtDictOrderBy.First;
    while not mtDictOrderBy.Eof do
    begin
      if result = '' then
        result := mtDictOrderByFIELD.AsString + ' ' + mtDictOrderBySORT_TYPE.AsString +
          iif(mtDictOrderByNULLS.AsString <> '', ' ' + mtDictOrderByNULLS.AsString, '')
      else
        result := result + ',' + mtDictOrderByFIELD.AsString + ' ' + mtDictOrderBySORT_TYPE.AsString +
          iif(mtDictOrderByNULLS.AsString <> '', ' ' + mtDictOrderByNULLS.AsString, '');

      mtDictOrderBy.Next;
    end;
  finally
    mtDictOrderBy.EnableControls;
  end;
end;

function TFEditDict.GetPrimaryKeys(dsSrc: TMemTableEh): string;
var
  s: string;
  
begin
  result := '{}';
  if not dsSrc.Active or dsSrc.IsEmpty then exit;

  dsSrc.DisableControls;
  try
    s := '';
    result := '{"primaryKey": "';
    dsSrc.First;
    while not dsSrc.Eof do
    begin
      if dsSrc.FieldByName('FIELD').AsString <> '' then
      begin
        if s = '' then s := PyAnsiToUnicode(dsSrc.FieldByName('FIELD').AsString)
        else s := s + ';' + PyAnsiToUnicode(dsSrc.FieldByName('FIELD').AsString);
      end;

      dsSrc.Next;
    end;
    if s <> '' then result := result + s + '"}'
    else result := '{}';
  finally
    dsSrc.EnableControls;
  end;
end;

function TFEditDict.GetRankFullPath(RankPk: integer): string;
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

function TFEditDict.GetShortCaption: string;
begin
  if Mode = omAdd then
    result := Caption
  else
    result := edDictTitle.Text + ' : ' + edDictDescriptor.Text;
end;

procedure TFEditDict.GroupEdit(Grid: TDBGridEh);
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

procedure TFEditDict.InitStartForm;
begin
  if Mode = omAdd then exit;

  if not Assigned(StartForm) then StartForm := TfrmEditForm.Create(Self, tsStartForm);
  StartForm.RequestProcParams := true;
  
  case FMode of
    omAdd, omEdit:
    begin
      StartForm.edFormAlias.ReadOnly := false;
      StartForm.edFormAlias.Color := clWindow;
      StartForm.edFormTitle.ReadOnly := false;
      StartForm.edFormTitle.Color := clWindow;
      StartForm.edFormWidth.ReadOnly := false;
      StartForm.edFormWidth.Color := clWindow;
      StartForm.edFormHeight.ReadOnly := false;
      StartForm.edFormHeight.Color := clWindow;
      StartForm.dbgFormFields.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      StartForm.sbAddField.Enabled := true;
      StartForm.sbEditField.Enabled := true;
      StartForm.sbDelField.Enabled := true;
      StartForm.dbgGroups.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      StartForm.sbAddGroup.Enabled := true;
      StartForm.sbEditGroup.Enabled := true;
      StartForm.sbDelGroup.Enabled := true;
      StartForm.chbLeftAlign.Enabled := true;
      StartForm.edLabelWidth.ReadOnly := false;
      StartForm.edLabelWidth.Color := clWindow;
    end;
    omView:
    begin
      StartForm.edFormAlias.ReadOnly := true;
      StartForm.edFormAlias.Color := clBtnFace;
      StartForm.edFormTitle.ReadOnly := true;
      StartForm.edFormTitle.Color := clBtnFace;
      StartForm.edFormWidth.ReadOnly := true;
      StartForm.edFormWidth.Color := clBtnFace;
      StartForm.edFormHeight.ReadOnly := true;
      StartForm.edFormHeight.Color := clBtnFace;
      StartForm.dbgFormFields.AllowedOperations := [];
      StartForm.sbAddField.Enabled := false;
      StartForm.sbEditField.Enabled := false;
      StartForm.sbDelField.Enabled := false;
      StartForm.dbgGroups.AllowedOperations := [];
      StartForm.sbAddGroup.Enabled := false;
      StartForm.sbEditGroup.Enabled := false;
      StartForm.sbDelGroup.Enabled := false;
      StartForm.chbLeftAlign.Enabled := false;
      StartForm.edLabelWidth.ReadOnly := true;
      StartForm.edLabelWidth.Color := clBtnFace;
    end;
  end;

  if dsStartForm.Active and (not dsStartForm.IsEmpty) then
  begin
    StartForm.edFormPk.Text := dsStartFormPK.AsString;
    StartForm.edFormAlias.Text := dsStartFormALIAS_FORM.AsString;
    StartForm.edFormTitle.Text := dsStartFormTITLE.AsString;
    StartForm.edFormWidth.Value := dsStartForm.FieldByName('WIDTH').Value;
    StartForm.edFormHeight.Value := dsStartForm.FieldByName('HEIGHT').Value;
    StartForm.chbLeftAlign.Checked := dsStartForm.FieldByName('LEFT_ALIGN').Value = 1;
    StartForm.edLabelWidth.Value := dsStartForm.FieldByName('LABEL_WIDTH').Value;
    StartForm.FormPk := dsStartForm.FieldByName('PK').Value;
    StartForm.FormGUID := iif(dsStartForm.FieldByName('GUID').IsNull, CreateGuid, dsStartForm.FieldByName('GUID').Value);
  end else
  begin
    StartForm.FormPk := Null;
    StartForm.FormGUID := CreateGuid;
    StartForm.edFormTitle.Text := 'Ввод параметров для ' + dsDictDESCRIPTOR_.AsString;
  end;

  StartForm.Parent := tsStartForm;
  StartForm.Align := alClient;
  StartForm.Visible := true;
end;

procedure TFEditDict.lcbParentDictChange(Sender: TObject);
begin
  if mtObjectTree.IsEmpty then exit;
  mtObjectTree.DisableControls;
  try
    dsJoinObjects.Close;
    dsJoinObjects.ParamByName('FORM_PK').Value := dsDictMAIN_FORM_PK.Value;
    dsJoinObjects.ParamByName('PARENT_PK').Value := lcbParentDict.KeyValue;
    dsJoinObjects.Open;

    if mtObjectTree.State in [dsEdit, dsInsert] then mtObjectTree.Cancel;
    mtObjectTree.First;
    while not mtObjectTree.Eof do
    begin
      if mtObjectTreeIS_MAIN.AsBoolean then
      begin
        mtObjectTree.Edit;
        mtObjectTreeJOIN_FIELDS.AsString := '[]';
        if dsJoinObjects.Locate('REF_PK', lcbParentDict.KeyValue, []) then
        begin
          mtObjectTree.FieldByName('JOIN_PARENT_PK').Value := dsJoinObjectsPK.AsInteger;
          mtObjectTreeIS_MULTI_JOIN.AsString := '1';
        end else
        begin
          mtObjectTree.FieldByName('JOIN_PARENT_PK').Clear;
          mtObjectTreeIS_MULTI_JOIN.AsString := '0';
        end;
        mtObjectTree.Post;
        break;
      end;

      mtObjectTree.Next;
    end;
  finally
    mtObjectTree.First;
    mtObjectTree.EnableControls;
  end;
end;

procedure TFEditDict.LoadChartGroups;
var
  i: integer;

begin
  mtChartGroup.DisableControls;
  try
    IsLoadingGrid := true;
    if mtChartGroup.Active then
    begin
      mtChartGroup.EmptyTable;
      mtChartGroup.Close;
    end;
    mtChartGroup.CreateDataSet;

    if dsDict.Active and (not dsDict.IsEmpty) then
    begin
      dsChartGroup.Close;
      dsChartGroup.ParamByName('REF_PK').Value := dsDictPK.AsInteger;
      dsChartGroup.Open;
      dsChartGroup.First;

      while not dsChartGroup.Eof do
      begin
        mtChartGroup.Append;
        mtChartGroupCHANGED.AsBoolean := false;
        for i := 0 to dsChartGroup.FieldCount - 1 do
          mtChartGroup.FieldByName(dsChartGroup.Fields.Fields[i].FieldName).Value := dsChartGroup.Fields.Fields[i].Value;

        mtChartGroup.Post;
        dsChartGroup.Next;
      end;
      dsChartGroup.Close;
      mtChartGroup.First;
    end;
  finally
    IsLoadingGrid := false;
    mtChartGroup.EnableControls;
  end;
end;

procedure TFEditDict.LoadCharts;
var
  i: integer;

begin
  mtChart.DisableControls;
  try
    IsLoadingGrid := true;
    if mtChart.Active then
    begin
      mtChart.EmptyTable;
      mtChart.Close;
    end;
    mtChart.CreateDataSet;

    if dsDict.Active and (not dsDict.IsEmpty) then
    begin
      dsChart.Close;
      dsChart.ParamByName('REF_PK').Value := dsDictPK.AsInteger;
      dsChart.Open;
      dsChart.First;

      while not dsChart.Eof do
      begin
        mtChart.Append;
        mtChartCHANGED.AsBoolean := false;
        for i := 0 to dsChart.FieldCount - 1 do
          mtChart.FieldByName(dsChart.Fields.Fields[i].FieldName).Value := dsChart.Fields.Fields[i].Value;

        mtChart.Post;
        dsChart.Next;
      end;
      dsChart.Close;
      mtChart.First;
    end;
  finally
    IsLoadingGrid := false;
    mtChart.EnableControls;
  end;
end;

procedure TFEditDict.LoadColumnStyles(dsDest: TMemTableEh; StylesStr: string);
var
  json: TJson;

begin
  if dsDest.IsEmpty then exit;

  json := TJson.Create;
  dsDest.DisableControls;
  try
    json.Load(StylesStr);
    
    dsDest.First;
    while not dsDest.Eof do
    begin
      dsDest.Edit;
      dsDest.FieldByName('STYLE').AsString := json.ValueOf(dsDest.FieldByName('COLUMN_').AsInteger);
      dsDest.Post;
      dsDest.Next;
    end;
    dsDest.First;
  finally
    json.Free;
    dsDest.EnableControls;
  end;
end;

procedure TFEditDict.LoadFieldTypeParams(OptList: TContainer; OptionsStr: string);
var
  i: integer;
  opt: TOptionRecord;
  sl: TStringList;
  json: TJson;

begin
  sl := TStringList.Create;
  json := TJson.Create;
  try
    json.Load(OptionsStr);

    for i := 0 to json.KeyCount - 1 do
    begin
      opt := OptList.OptionRecByName[json.Keys[i]];
      try
        if Assigned(opt) then opt.Value := json.ValueOf(json.Keys[i]);
      except
        {on e: Exception do Application.MessageBox(pchar('Не удалось задать значение поля ' + opt.Name + '. Ошибка: ' + e.Message),
          'Ошибка', MB_OK + MB_ICONERROR);}
      end;
    end;

    // нужно в правильном порядке выставить опции, зависящие от BaseDescriptor (только те, которые меняются при его смене)
    sl.Text := OPT_baseDescriptor + FIELDTYPEDELIM + OPT_fkTable + FIELDTYPEDELIM + OPT_fkField + FIELDTYPEDELIM + OPT_displayField;
    for i := 0 to sl.Count - 1 do
    begin
      opt := OptList.OptionRecByName[sl.Strings[i]];
      if Assigned(opt) then
      begin
        try
          opt.Value := json.ValueOf(opt.Name);
          if Assigned(opt.OnOptChange) then opt.OnOptChange(opt);
        except
          {on e: Exception do Application.MessageBox(pchar('Не удалось задать значение поля ' + opt.Name + '. Ошибка: ' + e.Message),
            'Ошибка', MB_OK + MB_ICONERROR);}
        end;
      end;
    end;
  finally
    sl.Free;
    json.Free;
  end;
end;

procedure TFEditDict.LoadFilterConfigs;
var
  i: integer;

begin
  mtFilterConfig.DisableControls;
  try
    IsLoadingGrid := true;
    if mtFilterConfig.Active then
    begin
      mtFilterConfig.EmptyTable;
      mtFilterConfig.Close;
    end;
    mtFilterConfig.CreateDataSet;

    if dsDict.Active and (not dsDict.IsEmpty) then
    begin
      dsFilterConfig.Close;
      dsFilterConfig.ParamByName('REF_PK').Value := dsDictPK.AsInteger;
      dsFilterConfig.Open;
      dsFilterConfig.First;

      while not dsFilterConfig.Eof do
      begin
        mtFilterConfig.Append;
        mtFilterConfigCHANGED.AsBoolean := false;
        for i := 0 to dsFilterConfig.FieldCount - 1 do
          mtFilterConfig.FieldByName(dsFilterConfig.Fields.Fields[i].FieldName).Value := dsFilterConfig.Fields.Fields[i].Value;

        mtFilterConfig.Post;
        dsFilterConfig.Next;
      end;
      dsFilterConfig.Close;
      mtFilterConfig.First;
    end;
  finally
    IsLoadingGrid := false;
    mtFilterConfig.EnableControls;
  end;
end;

procedure TFEditDict.LoadFilterGroups;
var
  i: integer;

begin
  mtFilterGroup.DisableControls;
  try
    IsLoadingGrid := true;
    if mtFilterGroup.Active then
    begin
      mtFilterGroup.EmptyTable;
      mtFilterGroup.Close;
    end;
    mtFilterGroup.CreateDataSet;

    if dsDict.Active and (not dsDict.IsEmpty) then
    begin
      dsFilterGroup.Close;
      dsFilterGroup.ParamByName('FORM_PK').Value := dsDictMAIN_FORM_PK.AsVariant;
      dsFilterGroup.Open;
      dsFilterGroup.First;

      while not dsFilterGroup.Eof do
      begin
        mtFilterGroup.Append;
        mtFilterGroupCHANGED.AsBoolean := false;
        for i := 0 to dsFilterGroup.FieldCount - 1 do
          mtFilterGroup.FieldByName(dsFilterGroup.Fields.Fields[i].FieldName).Value := dsFilterGroup.Fields.Fields[i].Value;

        mtFilterGroup.Post;
        dsFilterGroup.Next;
      end;
      dsFilterGroup.Close;
      mtFilterGroup.First;
    end;
  finally
    IsLoadingGrid := false;
    mtFilterGroup.EnableControls;
  end;
end;

procedure TFEditDict.LoadFormFields;
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

    if dsDict.Active and (not dsDict.IsEmpty) then
    begin
      dsFormFields.Close;
      dsFormFields.ParamByName('FORM_PK').Value := dsDictMAIN_FORM_PK.AsInteger;
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
        mtFormFieldsGRID_ORDER.Tag := Max(mtFormFieldsGRID_ORDER.AsInteger, mtFormFieldsGRID_ORDER.Tag);
        dsFormFields.Next;
      end;
      dsFormFields.Close;
      mtFormFields.First;
    end;
  finally
    IsLoadingGrid := false;
    mtFormFields.EnableControls;
  end;
end;

procedure TFEditDict.LoadFormGroups;
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

    if dsDict.Active and (not dsDict.IsEmpty) then
    begin
      dsGroups.Close;
      dsGroups.ParamByName('FORM_PK').Value := dsDictMAIN_FORM_PK.AsInteger;
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
    end;
  finally
    IsLoadingGrid := false;
    mtGroups.EnableControls;
  end;
end;

procedure TFEditDict.LoadInputParams(dsDest: TMemTableEh; ParamsStr: string; CanClear: boolean);
var
  json, pList, param: TJson;
  i, j: integer;

begin
  json := TJson.Create;
  dsDest.DisableControls;
  try
    if CanClear and dsDest.Active then
    begin
      dsDest.EmptyTable;
      dsDest.Close;
    end;
    if not dsDest.Active then dsDest.CreateDataSet;

    json.Load(ParamsStr);
    pList := json.AsObject('inputParams');
    if not Assigned(pList) then exit;

    for i := 0 to pList.Count - 1 do
    begin
      param := pList.AsObject(i);
      if not Assigned(param) then continue;

      if CanClear then dsDest.Append
      else begin
        if dsDest.Locate('NAME', param.ValueOf('name'), [loCaseInsensitive]) then dsDest.Edit
        else continue; //dsDest.Append;
      end;

      for j := 0 to param.KeyCount - 1 do
        dsDest.FieldByName(UpperCase(param.Keys[j])).AsString := param.ValueOf(param.Keys[j]);

      dsDest.Post;
    end;
    dsDest.First;
  finally
    dsDest.EnableControls;
    json.Free;
  end;
end;

procedure TFEditDict.LoadJoinFields(dsDest: TMemTableEh; FieldsStr: string);
var
  json, l: TJson;
  i: integer;

begin
  json := TJson.Create;
  dsDest.DisableControls;
  try
    if dsDest.Active then
    begin
      dsDest.EmptyTable;
      dsDest.Close;
    end;
    dsDest.CreateDataSet;

    json.Load(FieldsStr);

    for i := 0 to json.Count - 1 do
    begin
      l := json.AsObject(i);
      if not Assigned(l) then continue;

      dsDest.Append;
      dsDest.FieldByName('CHILD_FIELD').AsString := l.ValueOf(0);
      dsDest.FieldByName('PARENT_FIELD').AsString := l.ValueOf(1);
      if (not VarIsNull(l.ValueOf(2))) and (l.ValueOf(2) <> '') then
      begin
        dsDest.FieldByName('OPERATOR').AsString := l.ValueOf(2);
        dsDest.FieldByName('CONDITION').AsBoolean := (not VarIsNull(l.ValueOf(3))) and (UpperCase(l.ValueOf(3)) = 'OR');
      end else
        dsDest.FieldByName('CONDITION').AsBoolean := false;
      dsDest.Post;
    end;
    dsDest.First;
  finally
    dsDest.EnableControls;
    json.Free;
  end;
end;

procedure TFEditDict.LoadLookups;
begin
  // справочник
  dsParentDicts.Close;
  dsParentDicts.ParamByName('PK').Value := iif(VarIsNull(Properties.PK), -1, Properties.PK);
  dsParentDicts.Open;
  dsFolders.Close;
  dsFolders.Open;
  dsDocuments.Close;
  dsDocuments.Open;
  dsRoles.Close;
  dsRoles.Open;
  
  lcbParentDict.KeyValue := Properties.ParentDictPK;
  lcbFolder.KeyValue := Properties.FolderPK;
  if FMode <> omAdd then
  begin
    dsJoinObjects.Close;
    dsJoinObjects.ParamByName('FORM_PK').Value := dsDictMAIN_FORM_PK.Value;
    dsJoinObjects.ParamByName('PARENT_PK').Value := lcbParentDict.KeyValue;
    dsJoinObjects.Open;
    dsOrderFields.Close;
    dsOrderFields.ParamByName('FORM_PK').Value := dsDictMAIN_FORM_PK.Value;
    dsOrderFields.Open;
    dsDictGroupingFields.Close;
    dsDictGroupingFields.ParamByName('FORM_PK').Value := dsDictMAIN_FORM_PK.Value;
    dsDictGroupingFields.Open;
    lcbDictGrouping.KeyValue := dsDict.FieldByName('GROUPING').Value;
    lcbDictDocument.KeyValue := dsDict.FieldByName('BRIEF_NOTE').Value;
    // форма
    dsFieldGroups.Close;
    dsFieldGroups.ParamByName('FORM_PK').Value := dsDictMAIN_FORM_PK.Value;
    dsFieldGroups.Open;
    // графики
    dsChartGroups.Close;
    //dsChartGroups.ParamByName('REF_PK').Value := Properties.PK;
    dsChartGroups.Open;
    // для кнопок
    dsEvtDicts.Close;
    dsEvtDicts.Open;
    dsEvtWizards.Close;
    dsEvtWizards.Open;
    dsEvtForms.Close;
    dsEvtForms.Open;
    // группы фильтров
    dsLFilterGroups.Close;
    dsLFilterGroups.ParamByName('FORM_PK').Value := dsDictMAIN_FORM_PK.Value;
    dsLFilterGroups.Open;
  end;
end;

procedure TFEditDict.LoadObjectTree;
var
  i: integer;

begin
  mtObjectTree.DisableControls;
  try
    MainObjPk := Null;
    IsLoadingGrid := true;
    if mtObjectTree.Active then
    begin
      mtObjectTree.EmptyTable;
      mtObjectTree.Close;
    end;
    mtObjectTree.CreateDataSet;

    if dsDict.Active and (not dsDict.IsEmpty) then
    begin
      dsObjectTree.Close;
      dsObjectTree.ParamByName('FORM_PK').Value := dsDictMAIN_FORM_PK.AsInteger;
      dsObjectTree.Open;
      dsObjectTree.First;

      while not dsObjectTree.Eof do
      begin
        mtObjectTree.Append;
        mtObjectTreeCHANGED.AsBoolean := false;

        mtObjectTreeIS_MAIN.AsBoolean := dsObjectTreeJOIN_PARENT_PK.IsNull or
          ((not dsObjectTreeJOIN_PARENT_PK.IsNull) and (dsObjectTreeIS_MULTI_JOIN.AsString = '1'));
        for i := 0 to dsObjectTree.FieldCount - 1 do
          mtObjectTree.FieldByName(dsObjectTree.Fields.Fields[i].FieldName).Value := dsObjectTree.Fields.Fields[i].Value;

        mtObjectTree.Post;
        dsObjectTree.Next;

        if mtObjectTreeIS_MAIN.AsBoolean then
        begin
          MainObjPk := mtObjectTreePK.AsInteger;
        end;
      end;
      dsObjectTree.Close;
      mtObjectTree.First;
    end;
  finally
    IsLoadingGrid := false;
    mtObjectTree.EnableControls;
  end;
end;

procedure TFEditDict.LoadOrders;
var
  i: integer;
  str: string;

begin
  mtDictOrderBy.DisableControls;
  try
    if mtDictOrderBy.Active then
    begin
      mtDictOrderBy.EmptyTable;
      mtDictOrderBy.Close;
    end;
    mtDictOrderBy.CreateDataSet;

    if dsDict.IsEmpty or dsDictORDER_BY.IsNull then exit;

    for i := 1 to WordCountEx(dsDictORDER_BY.AsString, [','], []) do
    begin
      str := Trim(ExtractWordEx(i, dsDictORDER_BY.AsString, [','], []));
      mtDictOrderBy.Append;
      mtDictOrderByFIELD.AsString := Trim(ExtractWordEx(1, str, [' '], []));
      mtDictOrderBySORT_TYPE.AsString := Trim(ExtractWordEx(2, str, [' '], []));
      if Trim(ExtractWordEx(3, str, [' '], [])) <> '' then
        mtDictOrderByNULLS.AsString := Trim(ExtractWordEx(3, str, [' '], [])) + ' ' + Trim(ExtractWordEx(4, str, [' '], []));
      mtDictOrderBy.Post;
    end;
    mtDictOrderBy.First;
  finally
    mtDictOrderBy.EnableControls;
  end;
end;

procedure TFEditDict.LoadOtherEvents;
var
  i: integer;

begin
  mtOtherEvents.DisableControls;
  try
    IsLoadingGrid := true;
    if mtOtherEvents.Active then
    begin
      mtOtherEvents.EmptyTable;
      mtOtherEvents.Close;
    end;
    mtOtherEvents.CreateDataSet;

    if dsDict.Active and (not dsDict.IsEmpty) then
    begin
      dsOtherEvents.Close;
      dsOtherEvents.ParamByName('REF_PK').Value := dsDictPK.AsInteger;
      dsOtherEvents.Open;
      dsOtherEvents.First;

      while not dsOtherEvents.Eof do
      begin
        mtOtherEvents.Append;
        mtOtherEventsCHANGED.AsBoolean := false;
        for i := 0 to dsOtherEvents.FieldCount - 1 do
          mtOtherEvents.FieldByName(dsOtherEvents.Fields.Fields[i].FieldName).Value := dsOtherEvents.Fields.Fields[i].Value;

        mtOtherEvents.Post;
        dsOtherEvents.Next;
      end;
      dsOtherEvents.Close;
      mtOtherEvents.First;
    end;
  finally
    IsLoadingGrid := false;
    mtOtherEvents.EnableControls;
  end;
end;

procedure TFEditDict.LoadPermRanks;
var
  i: integer;

begin
  mtPermRanks.DisableControls;
  try
    IsLoadingGrid := true;
    if mtPermRanks.Active then
    begin
      mtPermRanks.EmptyTable;
      mtPermRanks.Close;
    end;
    mtPermRanks.CreateDataSet;

    if dsDict.Active and (not dsDict.IsEmpty) then
    begin
      dsPermRanks.Close;
      dsPermRanks.ParamByName('REF_PK').Value := dsDictPK.AsInteger;
      dsPermRanks.Open;
      dsPermRanks.First;

      while not dsPermRanks.Eof do
      begin
        mtPermRanks.Append;
        mtPermRanksCHANGED.AsBoolean := false;
        for i := 0 to dsPermRanks.FieldCount - 1 do
          mtPermRanks.FieldByName(dsPermRanks.Fields.Fields[i].FieldName).Value := dsPermRanks.Fields.Fields[i].Value;

        mtPermRanks.Post;
        dsPermRanks.Next;
      end;
      dsPermRanks.Close;
      mtPermRanks.First;
    end;
  finally
    IsLoadingGrid := false;
    mtPermRanks.EnableControls;
  end;
end;

procedure TFEditDict.LoadPermRoles;
var
  i: integer;

begin
  mtPermRoles.DisableControls;
  try
    IsLoadingGrid := true;
    if mtPermRoles.Active then
    begin
      mtPermRoles.EmptyTable;
      mtPermRoles.Close;
    end;
    mtPermRoles.CreateDataSet;

    if dsDict.Active and (not dsDict.IsEmpty) then
    begin
      dsPermRoles.Close;
      dsPermRoles.ParamByName('REF_PK').Value := dsDictPK.AsInteger;
      dsPermRoles.Open;
      dsPermRoles.First;

      while not dsPermRoles.Eof do
      begin
        mtPermRoles.Append;
        mtPermRolesCHANGED.AsBoolean := false;
        for i := 0 to dsPermRoles.FieldCount - 1 do
          mtPermRoles.FieldByName(dsPermRoles.Fields.Fields[i].FieldName).Value := dsPermRoles.Fields.Fields[i].Value;

        mtPermRoles.Post;
        dsPermRoles.Next;
      end;
      dsPermRoles.Close;
      mtPermRoles.First;
    end;
  finally
    IsLoadingGrid := false;
    mtPermRoles.EnableControls;
  end;
end;

procedure TFEditDict.LoadPostFilters;
var
  i: integer;

begin
  mtPostFilter.DisableControls;
  try
    IsLoadingGrid := true;
    if mtPostFilter.Active then
    begin
      mtPostFilter.EmptyTable;
      mtPostFilter.Close;
    end;
    mtPostFilter.CreateDataSet;

    if dsDict.Active and (not dsDict.IsEmpty) then
    begin
      dsPostFilter.Close;
      dsPostFilter.ParamByName('REF_PK').Value := dsDictPK.AsInteger;
      dsPostFilter.Open;
      dsPostFilter.First;

      while not dsPostFilter.Eof do
      begin
        mtPostFilter.Append;
        mtPostFilterCHANGED.AsBoolean := false;
        for i := 0 to dsPostFilter.FieldCount - 1 do
          mtPostFilter.FieldByName(dsPostFilter.Fields.Fields[i].FieldName).Value := dsPostFilter.Fields.Fields[i].Value;

        mtPostFilter.Post;
        dsPostFilter.Next;
      end;
      dsPostFilter.Close;
      mtPostFilter.First;
    end;
  finally
    IsLoadingGrid := false;
    mtPostFilter.EnableControls;
    mtFilterConfigAfterScroll(mtFilterConfig);
  end;
end;

procedure TFEditDict.LoadPrimaryKeys(dsDest: TMemTableEh; FieldsStr: string);
var
  i: integer;
  json: TJson;

begin
  json := TJson.Create;
  dsDest.DisableControls;
  try
    if dsDest.Active then
    begin
      dsDest.EmptyTable;
      dsDest.Close;
    end;
    dsDest.CreateDataSet;

    json.Load(FieldsStr);
    if not json.KeyExists('primaryKey') then exit;

    for i := 1 to WordCountEx(json.ValueOf('primaryKey'), [';'], []) do
    begin
      dsDest.Append;
      dsDest.FieldByName('FIELD').AsString := ExtractWordEx(i, json.ValueOf('primaryKey'), [';'], []);
      dsDest.Post;
    end;
    dsDest.First;
  finally
    dsDest.EnableControls;
    json.Free;
  end;
end;

function TFEditDict.LoadTemplate(TmplPk: integer): string;
begin
  dsTemplate.Close;
  dsTemplate.ParamByName('PK').AsInteger := TmplPk;
  dsTemplate.Open;
  if dsTemplate.Active and (not dsTemplate.IsEmpty) then result := PyUnicodeToAnsi(dsTemplateTEXT_TEMPLATE.AsString);
  dsTemplate.Close;
end;

procedure TFEditDict.LoadUserParams(UserID: integer; Strings: TStringList);
var
  ds: TpFIBDataSet;
  listGroupPk, listGroupName, listGeoPk, listRankPk, listRankName: TStringList;
  i: integer;

begin
  listGroupPk := TStringList.Create;
  listGroupName := TStringList.Create;
  listGeoPk := TStringList.Create;
  listRankPk := TStringList.Create;
  listRankName := TStringList.Create;

  try
    // получаем основные данные
    ds := FMain.OpenSQL('select u.PK, us.USER_PK, u.LOGIN, u.NAME, u.SHORT_NAME, u.ISACTIVE, u.MODERATOR, u.DEVELOPER, u.EMAIL, u.CODE_1C, ' +
      'u.HOLIDAY, u.I_MODERATOR, u.OWNER_GROUP, u.UNIT_PK, u.LASTDATE, u.ACTIVEREASON, u.ISCONTENDER, u.TST_ROLE, u.GROUP_MEMBERSHIPS, ' +
      'u.BRANCHAUTH, u.I_BOSS, u.ISOPINION, u.OWNER, u.ROLE_PK, r.NAME ROLE_NAME, us.GEO_PK BRANCH_PK, us.ROLE_PK RANK_PK, us.UNIT_PK DEP, ' +
      'us.CHAPTER_PK CHAPTER, us.CHAPTER_PK UNIT, us.ROLE_NAME RANK_NAME, us.REGION_PK, ' +
      'extract(month from current_timestamp) CUR_MONTH, extract(year from current_timestamp) CUR_YEAR ' +
      'from USER_EMP_STRUCT us ' +
      'join USERS u on u.PK = us.USER_PK ' +
      'left join ROLES r on r.PK = u.ROLE_PK ' +
      'where us.USER_PK = ' + IntToStr(UserID) + ' and us.MAIN_ROLE = 1');


    if not ds.IsEmpty then
      for i := 0 to ds.FieldCount - 1 do
      begin
        if VarIsNull(ds.Fields.Fields[i].Value) then
          Strings.Add(ds.Fields.Fields[i].FieldName + '=null')
        else
          Strings.Add(ds.Fields.Fields[i].FieldName + '=' + ds.Fields.Fields[i].AsString);
      end;

    ds.Close;
    ds.Free;

    // получаем список групп
    ds := FMain.OpenSQL('select uug.GROUP_PK, g.NAME GROUP_NAME from USERS_USER_GROUPS uug ' +
      'left join USER_GROUPS g on g.PK = uug.GROUP_PK ' +
      'where uug.USER_PK = ' + IntToStr(UserID));
    ds.First;
    while not ds.Eof do
    begin
      listGroupPk.Add(ds.FieldByName('GROUP_PK').AsString);
      listGroupName.Add(ds.FieldByName('GROUP_NAME').AsString);
      ds.Next;
    end;
    ds.Close;
    ds.Free;

    // получаем список должностей и гео
    ds := FMain.OpenSQL('select us.GEO_PK, us.ROLE_PK RANK_PK, us.ROLE_NAME RANK_NAME from USER_EMP_STRUCT us ' +
      'where us.USER_PK = ' + IntToStr(UserID));
    ds.First;
    while not ds.Eof do
    begin
      listGeoPk.Add(ds.FieldByName('GEO_PK').AsString);
      listRankPk.Add(ds.FieldByName('RANK_PK').AsString);
      listRankName.Add(ds.FieldByName('RANK_NAME').AsString);
      ds.Next;
    end;
    ds.Close;
    ds.Free;

    Strings.Add('LIST_GROUP_PK=' + TextToString(listGroupPk.Text));
    Strings.Add('LIST_GROUP_NAME=' + TextToString(listGroupName.Text));
    Strings.Add('LIST_GEO_PK=' + TextToString(listGeoPk.Text));
    Strings.Add('LIST_RANK_PK=' + TextToString(listRankPk.Text));
    Strings.Add('LIST_RANK_NAME=' + TextToString(listRankName.Text));
  finally
    listGroupPk.Free;
    listGroupName.Free;
    listGeoPk.Free;
    listRankPk.Free;
    listRankName.Free;
  end;
end;

procedure TFEditDict.LoadTemplate(Memo: TMemo; TmplPk: integer);
begin
  Memo.Clear;
  dsTemplate.Close;
  dsTemplate.ParamByName('PK').AsInteger := TmplPk;
  dsTemplate.Open;
  if dsTemplate.Active and (not dsTemplate.IsEmpty) then Memo.Text := PyUnicodeToAnsi(dsTemplateTEXT_TEMPLATE.AsString);
  dsTemplate.Close;
end;

procedure TFEditDict.mtChartBeforeDelete(DataSet: TDataSet);
begin
  if mtChartPK.AsString <> '' then DeletedCharts.Add(mtChartPK.AsString);
end;

procedure TFEditDict.mtChartBeforePost(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    if mtChartX_FIELD_PK.IsNull or mtChartY_FIELD_PK.IsNull then raise Exception.Create('Не все обязательные поля заполнены!');

    mtChartCHANGED.AsBoolean := true;
    if mtChartGUID.IsNull then mtChartGUID.AsString := CreateGuid;
  end;
end;

procedure TFEditDict.mtChartGroupBeforeDelete(DataSet: TDataSet);
begin
  if mtChartGroupPK.AsString <> '' then DeletedChartGroups.Add(mtChartGroupPK.AsString);
end;

procedure TFEditDict.mtDictOrderByBeforeOpen(DataSet: TDataSet);
var
  col: TColumnEh;
  
begin
  SetSystemFieldsSQL(dsOrderFieldsUni, cbDictBaseDescriptor.Text, False);
  dsOrderFieldsUni.Open;

  col := FindColumnByFieldName(dbgDictOrderBy, 'FIELD');
  if not Assigned(col) then exit;
  col.PickList.Clear;
  dsOrderFieldsUni.First;

  while not dsOrderFieldsUni.Eof do
  begin
    col.PickList.Add(dsOrderFieldsUni.FieldByName('FULLNAME').AsString);
    dsOrderFieldsUni.Next;
  end;
end;

procedure TFEditDict.mtFilterConfigAfterScroll(DataSet: TDataSet);
begin
  if not mtPostFilter.Active then exit;

  mtPostFilter.Filter := 'FILTER_CONFIG_PK' + iif(mtFilterConfigPK.IsNull, ' is null', ' = ' + mtFilterConfigPK.AsString);
  mtPostFilter.Filtered := true;
end;

procedure TFEditDict.mtFilterConfigBeforeDelete(DataSet: TDataSet);
begin
  if mtFilterConfigPK.AsString <> '' then DeletedFilterConfigs.Add(mtFilterConfigPK.AsString);
end;

procedure TFEditDict.mtFilterGroupBeforeDelete(DataSet: TDataSet);
begin
  if mtFilterGroupPK.AsString <> '' then DeletedFilterGroups.Add(mtFilterGroupPK.AsString);
end;

procedure TFEditDict.mtFormFieldsAfterInsert(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    //AutoIncFields;
    mtFormFieldsOWNER_USER_PK.AsInteger := FMain.dsPortalUserPK.AsInteger;
    {mtFormFieldsGROUP_COLUMN.AsInteger := 0;
    mtFormFieldsORDER_.AsInteger := mtFormFieldsORDER_.Tag;
    mtFormFieldsTYPE_NAME.AsString := 'text';
    mtFormFieldsIS_VISIBLE.AsString := '1';
    mtFormFieldsGRID_VISIBLE.AsString := '1';
    mtFormFieldsGRID_ORDER.AsInteger := mtFormFieldsGRID_ORDER.Tag;
    mtFormFieldsEDITABLE.AsInteger := 1;
    mtFormFieldsADD_EDITABLE.AsInteger := 1;
    mtFormFieldsEXCEL_EXPORT.AsInteger := 0;
    mtFormFieldsIS_VISIBLE_ADD.AsString := '1';
    mtFormFieldsFILTER_ORDER.AsInteger := 0;
    mtFormFieldsIS_FILTER.AsInteger := 0;
    mtFormFieldsSHOW_IN_START_FORM.AsInteger := 0;
    mtFormFieldsEDIT_IN_TABLE.AsString := '0';
    mtFormFieldsSHOW_IN_GROUP_EDIT.AsInteger := 0;
    mtFormFieldsEXCEL_IMPORT.AsInteger := 0;}
    mtFormFieldsMATCH.AsInteger := 0;
  end;
end;

procedure TFEditDict.mtFormFieldsAfterPost(DataSet: TDataSet);
begin
  CheckGrEditFormField;
end;

procedure TFEditDict.mtFormFieldsAfterScroll(DataSet: TDataSet);
begin
  if mtFormFields.ControlsDisabled then exit;
  edCurrField.Text := mtFormFieldsOBJECT_NAME.AsString + '.' + mtFormFieldsFIELD_NAME.AsString + '  ' + mtFormFieldsTITLE.AsString +
    '  ' + mtFormFieldsTYPE_NAME.AsString;
end;

procedure TFEditDict.mtFormFieldsBeforeDelete(DataSet: TDataSet);
begin
  if mtFormFieldsPK.AsString <> '' then DeletedFields.Add(mtFormFieldsPK.AsString);

  // проверим поле группировки
  if lcbDictGrouping.KeyValue = mtFormFieldsOBJECT_NAME.AsString + '/' + mtFormFieldsFIELD_NAME.AsString then
    lcbDictGrouping.KeyValue := Null;

  // проверим поля ID и PARENT_ID
  if lcbDictIdField.KeyValue = mtFormFieldsOBJECT_NAME.AsString + '.' + mtFormFieldsFIELD_NAME.AsString then
    lcbDictIdField.KeyValue := Null;

  if lcbDictParentIdField.KeyValue = mtFormFieldsOBJECT_NAME.AsString + '.' + mtFormFieldsFIELD_NAME.AsString then
    lcbDictParentIdField.KeyValue := Null;

  // почистим списки сортировки
  if (not mtDictOrderBy.Active) or mtDictOrderBy.IsEmpty then exit;
  if mtDictOrderBy.State in [dsEdit, dsInsert] then mtDictOrderBy.Post;

  mtDictOrderBy.DisableControls;
  try
    mtDictOrderBy.First;
    while not mtDictOrderBy.Eof do
    begin
      if mtDictOrderByFIELD.AsString = mtFormFieldsOBJECT_NAME.AsString + '.' + mtFormFieldsFIELD_NAME.AsString then
        mtDictOrderBy.Delete
      else
        mtDictOrderBy.Next;
    end;
    mtDictOrderBy.Refresh;
  finally
    mtDictOrderBy.First;
    mtDictOrderBy.EnableControls;
  end;
end;

procedure TFEditDict.mtFormFieldsBeforePost(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    if mtFormFieldsOBJECT_NAME.IsNull or mtFormFieldsTITLE.IsNull or mtFormFieldsFIELD_NAME.IsNull or mtFormFieldsPARAMETERS.IsNull then
      raise Exception.Create('Не все обязательные поля заполнены!');
       
    mtFormFieldsCHANGED.AsBoolean := true;
    if mtFormFieldsGUID.IsNull then mtFormFieldsGUID.AsString := CreateGuid;
  end;
end;

procedure TFEditDict.mtGroupsAfterInsert(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    AutoIncGroups;
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

procedure TFEditDict.mtGroupsBeforeDelete(DataSet: TDataSet);
begin
  if mtGroupsPK.AsString <> '' then DeletedGroups.Add(mtGroupsPK.AsString);
end;

procedure TFEditDict.mtGroupsBeforePost(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    if mtGroupsTITLE.IsNull then raise Exception.Create('Не все обязательные поля заполнены!');
    mtGroupsCHANGED.AsBoolean := true;
    if mtGroupsGUID.IsNull then mtGroupsGUID.AsString := CreateGuid;
  end;
end;

procedure TFEditDict.mtObjectTreeAfterDelete(DataSet: TDataSet);
begin
  ObjectTreeAfterChange;
end;

procedure TFEditDict.mtObjectTreeAfterInsert(DataSet: TDataSet);
begin
  if mtObjectTree.RecordCount = 0 then mtObjectTreeIS_MAIN.AsBoolean := true
  else mtObjectTreeIS_MAIN.AsBoolean := false;
  mtObjectTreeOWNER_USER_PK.AsInteger := FMain.dsPortalUserPK.AsInteger;
end;

procedure TFEditDict.mtObjectTreeBeforeDelete(DataSet: TDataSet);
begin
  if mtObjectTreeIS_MAIN.AsBoolean then raise Exception.Create('Невозможно удалить главный объект справочника!');
  if mtObjectTreePK.AsString <> '' then DeletedObjects.Add(mtObjectTreePK.AsString);
end;

procedure TFEditDict.mtObjectTreeBeforePost(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    if mtObjectTreeNAME.IsNull or mtObjectTreeOBJECT_TYPE.IsNull or mtObjectTreeJOIN_FIELDS.IsNull or mtObjectTreePARAMETERS.IsNull then
      raise Exception.Create('Не все обязательные поля заполнены!');

    mtObjectTreeCHANGED.AsBoolean := true;
    if mtObjectTreeGUID.IsNull then mtObjectTreeGUID.AsString := CreateGuid;
  end;
end;

procedure TFEditDict.mtOtherEventsBeforeDelete(DataSet: TDataSet);
begin
  if mtOtherEventsID_EV.AsString <> '' then DeletedEvents.Add(mtOtherEventsID_EV.AsString);
end;

procedure TFEditDict.mtPermRanksAfterInsert(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
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
end;

procedure TFEditDict.mtPermRanksAfterScroll(DataSet: TDataSet);
begin
  if not mtPermRanksROLE_PK.IsNull then mUnitFullPath.Text := GetRankFullPath(mtPermRanksROLE_PK.AsInteger)
  else mUnitFullPath.Clear;

  if (dbgPermRanks.SelectedField.FieldName = 'ADD_') or (dbgPermRanks.SelectedField.FieldName = 'EDIT_') or
    (dbgPermRanks.SelectedField.FieldName = 'DEL_') or (dbgPermRanks.SelectedField.FieldName = 'VIEW_REF') or
    (dbgPermRanks.SelectedField.FieldName = 'VIEW_') or (dbgPermRanks.SelectedField.FieldName = 'GRID_SAVE') then
  begin
    lbRankTmplName.Caption := 'Шаблон ' + dbgPermRanks.SelectedField.FieldName;
    LoadTemplate(mRankTemplate, dbgPermRanks.SelectedField.AsInteger);
  end else
  begin
    lbRankTmplName.Caption := 'Шаблон не выбран';
    mRankTemplate.Clear;
  end;
end;

procedure TFEditDict.mtPermRanksBeforeDelete(DataSet: TDataSet);
begin
  if mtPermRanksPK.AsString <> '' then DeletedPermRanks.Add(mtPermRanksPK.AsString);
end;

procedure TFEditDict.mtPermRanksBeforePost(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    if mtPermRanksROLE_PK.IsNull then raise Exception.Create('Не все обязательные поля заполнены!');

    mtPermRanksCHANGED.AsBoolean := true;
    if mtPermRanksGUID.IsNull then mtPermRanksGUID.AsString := CreateGuid;
  end;
end;

procedure TFEditDict.mtPermRolesAfterInsert(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
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
end;

procedure TFEditDict.mtPermRolesAfterScroll(DataSet: TDataSet);
begin
  if (dbgPermRoles.SelectedField.FieldName = 'ADD_') or (dbgPermRoles.SelectedField.FieldName = 'EDIT_') or
    (dbgPermRoles.SelectedField.FieldName = 'DEL_') or (dbgPermRoles.SelectedField.FieldName = 'VIEW_REF') or
    (dbgPermRoles.SelectedField.FieldName = 'VIEW_') or (dbgPermRoles.SelectedField.FieldName = 'GRID_SAVE') then
  begin
    lbRoleTmplName.Caption := 'Шаблон ' + dbgPermRoles.SelectedField.FieldName;
    LoadTemplate(mRoleTemplate, dbgPermRoles.SelectedField.AsInteger);
  end else
  begin
    lbRoleTmplName.Caption := 'Шаблон не выбран';
    mRoleTemplate.Clear;
  end;
end;

procedure TFEditDict.mtPermRolesBeforeDelete(DataSet: TDataSet);
begin
  if mtPermRolesPK.AsString <> '' then DeletedPermRoles.Add(mtPermRolesPK.AsString);
end;

procedure TFEditDict.mtPermRolesBeforePost(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    if mtPermRolesROLE_PK.IsNull then raise Exception.Create('Не все обязательные поля заполнены!');

    mtPermRolesCHANGED.AsBoolean := true;
    if mtPermRolesGUID.IsNull then mtPermRolesGUID.AsString := CreateGuid;
  end;
end;

procedure TFEditDict.mtPostFilterBeforeDelete(DataSet: TDataSet);
begin
  if mtPostFilterPK.AsString <> '' then DeletedPostFilters.Add(mtPostFilterPK.AsString);
end;

procedure TFEditDict.miCopyRefLinkClick(Sender: TObject);
begin
  if Mode = omAdd then Application.MessageBox('Справочник еще не создан!', 'Ошибка', MB_OK + MB_ICONWARNING)
  else FMain.CopyRefLinkToClip(Properties);
end;

procedure TFEditDict.miPreviewRefClick(Sender: TObject);
begin
  if Mode = omAdd then Application.MessageBox('Справочник еще не создан!', 'Ошибка', MB_OK + MB_ICONWARNING)
  else FMain.OpenDictInBrowser(Properties);
end;

function TFEditDict.NumerateTree(TreeConnIdx: integer; ParentId: Variant; n, Level: integer; IdField, ParentIdField: string): integer;
var
  ds: TUniQuery;
  err: string;
  lvl: integer;
  tree_con: TConnection;
  tree_tbl: string;

begin
  lvl := Level + 1;
  result := n;

  tree_con := FSettings.ConnByIndex[TreeConnIdx];
  case tree_con.Server of
    stFirebird: tree_tbl := 'DYNAMIC_FORM_TREE_INDEX';
    stPostgreSQL: tree_tbl := 'main_dir.dynamic_form_tree_index';
    else raise Exception.Create('Указанная БД не поддерживает хранение кэша дерева! Задайте в настройках БД в поле "БД кэша дерева"');
  end;

  try
    ds := ConnectionsList.GetDataSet(dsDictBASE_DESCRIPTOR.AsString, qtUserDefined, 'select ' + IdField + ' from ' +
      GetMainObjectName + ' where ' + ParentIdField + iif(VarIsNull(ParentId), ' is null', ' = ' + VarToStr(ParentId)) + ' and ' +
      IdField + ' <> 0');

    ds.Open;
    ds.First;
    while not ds.Eof do
    begin
      Inc(result);
      if not ConnectionsList.ExecSQL(StringReplace('insert into {table} (ELEMENT_ID, REFERENCE_ID, LEFT_NUM, LVL) values (', '{table}', tree_tbl, []) +
        VariantToDBStr(ds.FieldByName(IdField).Value, true) + ', ' + dsDictPK.AsString + ', ' + IntToStr(result) + ', ' + IntToStr(lvl) + ')',
        TreeConnIdx, err) then raise Exception.Create(err);

      result := NumerateTree(TreeConnIdx, ds.FieldByName(IdField).Value, result, lvl, IdField, ParentIdField);
      Inc(result);

      if not ConnectionsList.ExecSQL(StringReplace('update {table} set RIGHT_NUM = ', '{table}', tree_tbl, []) + IntToStr(result) + ' where ELEMENT_ID = ' +
        VariantToDBStr(ds.FieldByName(IdField).Value, true) + ' and REFERENCE_ID = ' + dsDictPK.AsString, TreeConnIdx, err) then
        raise Exception.Create(err);

      ds.Next;
    end;
  finally
    ds.Close;
    ds.Free;
  end;
end;

procedure TFEditDict.ObjectTreeAfterChange;
var
  dsChildRef: TUniQuery;

begin
  if mtFormFields.State in [dsEdit, dsInsert] then mtFormFields.Post;

  mtFormFields.DisableControls;
  mtObjectTree.DisableControls;
  try
    // список полей привязки дочерних справочников (чтоб не удалять их, т.к. их объектов нет в списке объектов)
    dsChildRef := ConnectionsList.GetDataSet(FSettings.MainDescriptor, qtUserDefined,
      'select o.NAME, r.DESCRIPTOR_ from DYNAMIC_FORM_REFERENCE r ' +
      'join DYNAMIC_FORM_OBJECT_TREE o on o.FORM_PK = r.MAIN_FORM_PK and (o.JOIN_PARENT_PK is null or ' +
      '((o.JOIN_PARENT_PK is not null) and (o.IS_MULTI_JOIN = ''1''))) where PARENT_REFERENCE_PK = :PK');

    dsChildRef.ParamByName('PK').Value := Properties.PK;
    dsChildRef.Open;
    
    // удалить все поля по отсутствующим объектам
    mtFormFields.First;
    while not mtFormFields.Eof do
    begin
      if (not mtObjectTree.Locate('NAME', mtFormFieldsOBJECT_NAME.AsString, [loCaseInsensitive])) and
        (not dsChildRef.Locate('NAME', mtFormFieldsOBJECT_NAME.AsString, [loCaseInsensitive])) then
        mtFormFields.Delete
      else
        mtFormFields.Next;
    end;
    mtFormFields.Refresh;

    if Assigned(GrEditForm) then
    begin
      GrEditForm.mtFormFields.DisableControls;
      GrEditForm.mtFormFields.First;
      while not GrEditForm.mtFormFields.Eof do
      begin
        if not mtObjectTree.Locate('NAME', GrEditForm.mtFormFieldsOBJECT_NAME.AsString, [loCaseInsensitive]) then
          GrEditForm.mtFormFields.Delete
        else
          GrEditForm.mtFormFields.Next;
      end;
      GrEditForm.mtFormFields.Refresh;
    end;
  finally
    if Assigned(dsChildRef) then
    begin
      dsChildRef.Close;
      dsChildRef.Free;
    end;
    if Assigned(GrEditForm) then GrEditForm.mtFormFields.EnableControls;
    mtFormFields.EnableControls;
    mtObjectTree.EnableControls;
  end;

  ChangeBaseDescriptor;
  dsJoinObjects.Close;
  dsJoinObjects.ParamByName('FORM_PK').Value := dsDictMAIN_FORM_PK.Value;
  dsJoinObjects.ParamByName('PARENT_PK').Value := lcbParentDict.KeyValue;
  dsJoinObjects.Open;
  dsOrderFields.Close;
  dsOrderFields.ParamByName('FORM_PK').Value := dsDictMAIN_FORM_PK.Value;
  dsOrderFields.Open;
  SetSystemFieldsSQL(dsOrderFieldsUni, cbDictBaseDescriptor.Text, False);
  dsOrderFieldsUni.Open;
  dsDictGroupingFields.Close;
  dsDictGroupingFields.ParamByName('FORM_PK').Value := dsDictMAIN_FORM_PK.Value;
  dsDictGroupingFields.Open;
  if FMode <> omAdd then
  begin
    lcbDictGrouping.KeyValue := dsDict.FieldByName('GROUPING').Value;
    AutoCreateStartForm;
  end;
end;

procedure TFEditDict.OnChartEditorClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if TFChartEditor(Sender).Success then
  begin
    if mtChart.State in [dsEdit, dsInsert] then
    begin
      case Application.MessageBox(pchar('Невозможно сохранить данные, пока таблица графиков в режиме редактирования! Сначала нужно сохранить ' +
        'или отменить изменения в таблице. Сохранить изменения [YES], оменить [NO], или отложить сохранение формы [CANCEL] ' +
        '(сохранить эти данные можно будет позже)?'), 'Подтверждение', MB_YESNOCANCEL + MB_ICONQUESTION) of
        ID_YES: mtChart.Post;
        ID_NO: mtChart.Cancel;
        ID_CANCEL:
        begin
          TFChartEditor(Sender).Success := false;
          Action := caNone;
        end;
      end;
    end;

    if Action <> caNone then ApplyChartEditorData(TFChartEditor(Sender));
  end;
end;

procedure TFEditDict.OnChartGroupEditorClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if TFChartGroupEditor(Sender).Success then
  begin
    if mtChartGroup.State in [dsEdit, dsInsert] then
    begin
      case Application.MessageBox(pchar('Невозможно сохранить данные, пока таблица групп в режиме редактирования! Сначала нужно сохранить ' +
        'или отменить изменения в таблице. Сохранить изменения [YES], оменить [NO], или отложить сохранение формы [CANCEL] ' +
        '(сохранить эти данные можно будет позже)?'), 'Подтверждение', MB_YESNOCANCEL + MB_ICONQUESTION) of
        ID_YES: mtChartGroup.Post;
        ID_NO: mtChartGroup.Cancel;
        ID_CANCEL:
        begin
          TFChartGroupEditor(Sender).Success := false;
          Action := caNone;
        end;
      end;
    end;

    if Action <> caNone then ApplyChartGroupEditorData(TFChartGroupEditor(Sender));
  end;
end;

procedure TFEditDict.OnEventEditorClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if TFEventEditor(Sender).Success then
  begin
    if mtOtherEvents.State in [dsEdit, dsInsert] then
    begin
      case Application.MessageBox(pchar('Невозможно сохранить данные, пока таблица кнопок в режиме редактирования! Сначала нужно сохранить ' +
        'или отменить изменения в таблице. Сохранить изменения [YES], оменить [NO], или отложить сохранение формы [CANCEL] ' +
        '(сохранить эти данные можно будет позже)?'), 'Подтверждение', MB_YESNOCANCEL + MB_ICONQUESTION) of
        ID_YES: mtOtherEvents.Post;
        ID_NO: mtOtherEvents.Cancel;
        ID_CANCEL:
        begin
          TFEventEditor(Sender).Success := false;
          Action := caNone;
        end;
      end;
    end;

    if Action <> caNone then ApplyEventEditorData(TFEventEditor(Sender));
  end;
end;

procedure TFEditDict.OnFieldEditorClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFEditDict.OnFieldTmplEditorClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFEditDict.OnFilterConfigEditorClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if TFFilterConfigEditor(Sender).Success then
  begin
    if mtFilterConfig.State in [dsEdit, dsInsert] then
    begin
      case Application.MessageBox(pchar('Невозможно сохранить данные, пока таблица конфигураций в режиме редактирования! Сначала нужно сохранить ' +
        'или отменить изменения в таблице. Сохранить изменения [YES], оменить [NO], или отложить сохранение формы [CANCEL] ' +
        '(сохранить эти данные можно будет позже)?'), 'Подтверждение', MB_YESNOCANCEL + MB_ICONQUESTION) of
        ID_YES: mtFilterConfig.Post;
        ID_NO: mtFilterConfig.Cancel;
        ID_CANCEL:
        begin
          TFFilterConfigEditor(Sender).Success := false;
          Action := caNone;
        end;
      end;
    end;

    if Action <> caNone then ApplyFilterConfigEditorData(TFFilterConfigEditor(Sender));
  end;
end;

procedure TFEditDict.OnFilterGroupEditorClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if TFFilterGroupEditor(Sender).Success then
  begin
    if mtFilterGroup.State in [dsEdit, dsInsert] then
    begin
      case Application.MessageBox(pchar('Невозможно сохранить данные, пока таблица групп фильтров в режиме редактирования! Сначала нужно сохранить ' +
        'или отменить изменения в таблице. Сохранить изменения [YES], оменить [NO], или отложить сохранение формы [CANCEL] ' +
        '(сохранить эти данные можно будет позже)?'), 'Подтверждение', MB_YESNOCANCEL + MB_ICONQUESTION) of
        ID_YES: mtFilterGroup.Post;
        ID_NO: mtFilterGroup.Cancel;
        ID_CANCEL:
        begin
          TFFilterGroupEditor(Sender).Success := false;
          Action := caNone;
        end;
      end;
    end;

    if Action <> caNone then ApplyFilterGroupEditorData(TFFilterGroupEditor(Sender));
  end;
end;

procedure TFEditDict.OnGroupEditorClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFEditDict.OnJsonEditorClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if TFJsonReader(Sender).Success then ApplyJsonEditorData(TFJsonReader(Sender));
end;

procedure TFEditDict.OnObjectEditorClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if TFObjectEditor(Sender).Success then
  begin
    if mtObjectTree.State in [dsEdit, dsInsert] then
    begin
      case Application.MessageBox(pchar('Невозможно сохранить данные, пока таблица объектов в режиме редактирования! Сначала нужно сохранить ' +
        'или отменить изменения в таблице. Сохранить изменения [YES], оменить [NO], или отложить сохранение формы [CANCEL] ' +
        '(сохранить эти данные можно будет позже)?'), 'Подтверждение', MB_YESNOCANCEL + MB_ICONQUESTION) of
        ID_YES: mtObjectTree.Post;
        ID_NO: mtObjectTree.Cancel;
        ID_CANCEL:
        begin
          TFObjectEditor(Sender).Success := false;
          Action := caNone;
        end;
      end;
    end;

    if Action <> caNone then ApplyObjectEditorData(TFObjectEditor(Sender));
  end;
end;

function TFEditDict.OpenJsonEditor(Field: TField; StatusText: string): TFJsonReader;
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

procedure TFEditDict.ExecFix(FormFix: TFFixReference; Test: boolean);
var
  r: boolean;
  
begin
  if not Assigned(FormFix) then exit;

  if FormFix.chbOracle.Checked then r := FixOracle(FormFix, Test)
  else r := FixOracle(FormFix, true);

  if r then
  begin
    FormFix.AddToLog('');
    FormFix.AddToLog('Проверка Oracle показала наличие ошибок! Прежде, чем продолжать проверку, нужно устранить их.');
  end else
    FixReference(FormFix, Test);
    
  FormFix.AddToLog('');
  FormFix.AddToLog('Проверка завершена');
end;

procedure TFEditDict.PrepareFix;
var
  frm: TFFixReference;
  con: TConnection;

begin
  frm := TFFixReference.Create(Self);
  con := FSettings.ConnByDbDescr[cbDictBaseDescriptor.Text];
  frm.chbOracle.Enabled := con.Server = stOracle;
  if frm.chbOracle.Enabled then
    frm.chbOracle.Checked := WordCountEx(GetMainObjectName, ['.'], []) < 2
  else
    frm.chbOracle.Checked := false;

  frm.chbUnlinkObject.Checked := true;
  frm.chbObjects.Checked := true;
  frm.chbFields.Checked := true;
  frm.chbNoLinkFields.Checked := true;
  frm.ShowModal;
end;

procedure TFEditDict.PrepareStartForm;
begin
  InitStartForm;
  AutoCreateStartForm;
end;

procedure TFEditDict.ReloadWizards;
begin
  if Mode = omAdd then exit;
  if dsWizard.Active then dsWizard.Close;
  dsWizard.ParamByName('REF_PK').Value := Properties.PK;
  dsWizard.Open;
end;

function TFEditDict.ReplaceTemplateText(TmplPk: Variant; OldStr, NewStr: string): string;
begin
  result := '';
  dsTemplate.Close;
  dsTemplate.ParamByName('PK').Value := TmplPk;
  dsTemplate.Open;
  if dsTemplate.Active and (not dsTemplate.IsEmpty) then result := PyUnicodeToAnsi(dsTemplateTEXT_TEMPLATE.AsString);
  dsTemplate.Close;
  if (result = '') then exit;

  // теперь замены
  result := StringReplace(result, OldStr, NewStr, [rfReplaceAll, rfIgnoreCase]);
end;

procedure TFEditDict.AddChildRefField(OldParentPk: Variant);
var
  err: string;

begin
  // добавление родительскому справочнику поля дочернего, если этот дочерний, или удаление поля,
  // если этот перепривязался к др. родителю или отвязался от родителя
  
  if not mtObjectTree.Locate('IS_MAIN', true, []) then exit;

  if not VarIsNull(lcbParentDict.KeyValue) then
  begin
    // привязка к родителю есть
    if VarIsNull(OldParentPk) or (OldParentPk <> lcbParentDict.KeyValue) then
    begin
      // привязка к родительскому появилась или родителя поменяли, надо новому родителю добавить поле ChildTable
      if not FMain.ExecSQL('insert into DYNAMIC_FORM_FIELD (OWNER_USER_PK, OBJECT_PK, ORDER_, TITLE, DESCRIPTION, TYPE_NAME, ' +
        'FIELD_NAME, STYLE_EXTERNAL, STYLE, PARAMETERS, IS_VISIBLE, FORM_PK, GRID_VISIBLE, GRID_ORDER, EDITABLE, ADD_EDITABLE, EXCEL_EXPORT, ' +
        'IS_VISIBLE_ADD, EDIT_IN_TABLE) values (' + FMain.dsPortalUserPK.AsString + ', ' + mtObjectTreePK.AsString + ', 0, ''' +
        mtObjectTreeNAME.AsString + '.' + VarToStr(Properties.Descriptor) + ''', '''', ''' + FIELDTYPE_ChildTable + ''', ''' +
        VarToStr(Properties.Descriptor) + ''', '''', '''', ''{"joinFields": "' + PyAnsiToUnicode(mtObjectTreeJOIN_FIELDS.AsString) +
        '"}'', 0, (select MAIN_FORM_PK from DYNAMIC_FORM_REFERENCE where PK = ' + VarToStr(lcbParentDict.KeyValue) +
        '), 1, 0, 0, 0, 0, 0, 1)', err) then
        Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
    end;

    if (not VarIsNull(OldParentPk)) and (OldParentPk <> lcbParentDict.KeyValue) then
    begin
      // поменялась привязка - надо удалить у старого родителя поле ChildTable от этого справочника
      if not FMain.ExecSQL('delete from DYNAMIC_FORM_FIELD where OBJECT_PK = ' + mtObjectTreePK.AsString + ' and FIELD_NAME = ''' +
        VarToStr(Properties.Descriptor) + ''' and FORM_PK = (select MAIN_FORM_PK from DYNAMIC_FORM_REFERENCE where PK = ' +
        VarToStr(OldParentPk) + ')', err) then
        Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
    end;
  end else
  begin
    if (not VarIsNull(OldParentPk)) then
    begin
      // справочник отвязали от родителя - надо удалить у старого родителя поле ChildTable от этого справочника
      if not FMain.ExecSQL('delete from DYNAMIC_FORM_FIELD where OBJECT_PK = ' + mtObjectTreePK.AsString + ' and FIELD_NAME = ''' +
        VarToStr(Properties.Descriptor) + ''' and FORM_PK = (select MAIN_FORM_PK from DYNAMIC_FORM_REFERENCE where PK = ' +
        VarToStr(OldParentPk) + ')', err) then
        Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
    end;
  end;
end;

function TFEditDict.SaveData: boolean;
var
  err: string;
  mainFrmPk, grFrmPk, startFrmPk: variant;

begin
  mainFrmPk := Null;
  grFrmPk := Null;
  startFrmPk := Null;

  case Mode of
    omAdd:
    begin
      // сначала проверим - если нет ни одного объекта БД, то создавать нельзя
      if mtObjectTree.IsEmpty then raise Exception.Create('Сначала добавь главный объект БД!');

      // главная форма
      result := FMain.ExecSQL('insert into DYNAMIC_FORM (OWNER_USER_PK, TITLE, WIDTH, HEIGHT, ALIAS_FORM, LEFT_ALIGN, LABEL_WIDTH) values (' +
        VariantToDBStr(FMain.dsPortalUserPK.Value, false) + ', ' + VariantToDBStr(Trim(edFormTitle.Text), true) + ', ' +
        VariantToDBStr(edFormWidth.Value, false, true, true) + ', ' + VariantToDBStr(edFormHeight.Value, false, true, true) + ', ' +
        VariantToDBStr(Trim(edFormAlias.Text), true) + ', ' + iif(chbLeftAlign.Checked, '1', '0') + ', ' +
        VariantToDBStr(edLabelWidth.Value, false, true, true) + ') returning (PK)', 'PK', mainFrmPk, err);

      // теперь референс
      if result then
        result := FMain.ExecSQL('insert into DYNAMIC_FORM_REFERENCE (OWNER_USER_PK, TITLE, ORDER_BY, DESCRIPTOR_, PARENT_REFERENCE_PK, ' +
          'MAIN_FORM_PK, START_FORM_PK, BASE_DESCRIPTOR, FOLDER_PK, PARENT_ID_FIELD, ID_FIELD, EXPAND_REF, COLLAPSE_FILTER, ' +
          'GROUPING, CON_ORIENT, BRIEF_NOTE, EDITABLE, SET_DISTINCT, REF_SIZE, GROUP_EDIT_FORM_PK, SHOW_ONLY_ADMIN, EXPAND_TREE, ' +
          'USE_MEM, COUNT_ON_PAGE, DEFERRED_IMPORTS, AUTOSAVEINTERVAL, SKIP_DUPLICATES, SHOW_FILTER_BOUND, CHECK_SELECT, GUID) values (' +
          VariantToDBStr(FMain.dsPortalUserPK.Value, false) + ', ' + VariantToDBStr(Trim(edDictTitle.Text), true) + ', ' +
          VariantToDBStr(Trim(GetOrders), true) + ', ' + VariantToDBStr(Trim(edDictDescriptor.Text), true) + ', ' +
          VariantToDBStr(lcbParentDict.KeyValue, false, true, true) + ', ' + VariantToDBStr(mainFrmPk, false, true, true) + ', ' +
          VariantToDBStr(dsDictSTART_FORM_PK.AsInteger, false, true, true) + ', ' + VariantToDBStr(cbDictBaseDescriptor.Text, true) + ', ' +
          VariantToDBStr(lcbFolder.KeyValue, false, true, true) + ', ' + VariantToDBStr(lcbDictParentIdField.KeyValue, true) + ', ' +
          VariantToDBStr(lcbDictIdField.KeyValue, true) + ', ' + iif(chbDictExpandRef.Checked, '''1''', '''0''') + ', ' +
          iif(chbDictCollapseFilter.Checked, '''1''', '''0''') + ', ' + VariantToDBStr(lcbDictGrouping.KeyValue, true) + ', ' +
          IntToStr(cbDictConOrient.ItemIndex) + ', ' + VariantToDBStr(lcbDictDocument.KeyValue, false, true, true) + ', ' +
          iif(chbDictEditable.Checked, '1', '0') + ', ' + iif(chbDictSetDistinct.Checked, '''1''', '''0''') + ', ' +
          VariantToDBStr(edDictRefSize.Value, false, true, true) + ', ' + VariantToDBStr(grFrmPk, false, true, true) + ', ' +
          iif(chbDictShowOnlyAdmin.Checked, '1', '0') + ', ' + iif(chbDictExpandTree.Checked, '1', '0') + ', ' +
          iif(chbDictUseMem.Checked, '1', '0') + ', ' + VariantToDBStr(edDictCountOnPage.Value, false, true, true) + ', ' +
          iif(chbDictDeferredImports.Checked, '1', '0') + ', ' + VariantToDBStr(edDictAutosaveInterval.Value, false, true, true) + ', ' +
          iif(chbDictSkipDuplicates.Checked, '''1''', '''0''') + ', ' + iif(cbDictShowFilterBound.ItemIndex = 0, 'null',
          '''' + cbDictShowFilterBound.Text + '''') + ', ' + iif(chbCheckSelect.Checked, '1', '0') + ', ' + VariantToDBStr(Properties.Guid, true) +
          ') returning (PK)', 'PK', Properties.PK, err);

      // пишем в лог
      FMain.AddToRefLog(cotDict, edDictDescriptor.Text, Properties.Guid, rltCreate);
    end;
    omEdit:
    begin
      // сначала проверим - если нет ни одного объекта БД, то создавать нельзя
      if mtObjectTree.IsEmpty then raise Exception.Create('Сначала добавь главный объект БД!');

      // главная форма
      mainFrmPk := dsDictMAIN_FORM_PK.AsInteger;
      result := FMain.ExecSQL('update DYNAMIC_FORM set MODIFY = current_timestamp, TITLE = ' +
        VariantToDBStr(Trim(edFormTitle.Text), true) + ', WIDTH = ' + VariantToDBStr(edFormWidth.Value, false, true, true) +
        ', HEIGHT = ' + VariantToDBStr(edFormHeight.Value, false, true, true) + ', ALIAS_FORM = ' +
        VariantToDBStr(Trim(edFormAlias.Text), true) + ', LEFT_ALIGN = ' + iif(chbLeftAlign.Checked, '1', '0') +
        ', LABEL_WIDTH = ' + VariantToDBStr(edLabelWidth.Value, false, true, true) + ' where PK = ' + dsDictMAIN_FORM_PK.AsString, err);

      // стартовая форма (если есть)
      if result then
        if Assigned(StartForm) then
        begin
          if dsDictSTART_FORM_PK.IsNull or (dsDictSTART_FORM_PK.AsInteger = -1) then
          begin
            // надо создать
            result := FMain.ExecSQL('insert into DYNAMIC_FORM (OWNER_USER_PK, TITLE, WIDTH, HEIGHT, ALIAS_FORM, LEFT_ALIGN, LABEL_WIDTH, GUID) values (' +
              VariantToDBStr(FMain.dsPortalUserPK.Value, false) + ', ' + VariantToDBStr(Trim(StartForm.edFormTitle.Text), true) + ', ' +
              VariantToDBStr(StartForm.edFormWidth.Value, false, true, true) + ', ' +
              VariantToDBStr(StartForm.edFormHeight.Value, false, true, true) + ', ' +
              VariantToDBStr(Trim(StartForm.edFormAlias.Text), true) + ', ' + iif(StartForm.chbLeftAlign.Checked, '1', '0') + ', ' +
              VariantToDBStr(StartForm.edLabelWidth.Value, false, true, true) + ', ' + VariantToDBStr(StartForm.FormGUID, true) +
              ') returning (PK)', 'PK', startFrmPk, err);
          end else
          begin
            // обновиьть
            startFrmPk := dsDictSTART_FORM_PK.AsInteger;
            result := FMain.ExecSQL('update DYNAMIC_FORM set MODIFY = current_timestamp, TITLE = ' +
              VariantToDBStr(Trim(StartForm.edFormTitle.Text), true) + ', WIDTH = ' +
              VariantToDBStr(StartForm.edFormWidth.Value, false, true, true) + ', HEIGHT = ' +
              VariantToDBStr(StartForm.edFormHeight.Value, false, true, true) + ', ALIAS_FORM = ' +
              VariantToDBStr(Trim(StartForm.edFormAlias.Text), true) + ', LEFT_ALIGN = ' +
              iif(StartForm.chbLeftAlign.Checked, '1', '0') + ', LABEL_WIDTH = ' +
              VariantToDBStr(StartForm.edLabelWidth.Value, false, true, true) + ', GUID = ' +
              VariantToDBStr(Trim(StartForm.FormGUID), true) + ' where PK = ' + dsDictSTART_FORM_PK.AsString, err);
          end;
        end else
        begin
          // удаляем
          if (not dsDictSTART_FORM_PK.IsNull) and (dsDictSTART_FORM_PK.AsInteger <> -1) then
            result := FMain.ExecSQL('delete from DYNAMIC_FORM where PK = ' + dsDictSTART_FORM_PK.AsString, err);

          if CanStdStartForm then startFrmPk := -1
          else startFrmPk := Null;
        end;

      // форма группового редактирования (если есть)
      if result then
        if Assigned(GrEditForm) then
        begin
          if dsDictGROUP_EDIT_FORM_PK.IsNull then
          begin
            // надо создать
            result := FMain.ExecSQL('insert into DYNAMIC_FORM (OWNER_USER_PK, TITLE, WIDTH, HEIGHT, ALIAS_FORM, LEFT_ALIGN, LABEL_WIDTH, GUID) values (' +
              VariantToDBStr(FMain.dsPortalUserPK.Value, false) + ', ' + VariantToDBStr(Trim(GrEditForm.edFormTitle.Text), true) + ', ' +
              VariantToDBStr(GrEditForm.edFormWidth.Value, false, true, true) + ', ' +
              VariantToDBStr(GrEditForm.edFormHeight.Value, false, true, true) + ', ' +
              VariantToDBStr(Trim(GrEditForm.edFormAlias.Text), true) + ', ' + iif(GrEditForm.chbLeftAlign.Checked, '1', '0') + ', ' +
              VariantToDBStr(GrEditForm.edLabelWidth.Value, false, true, true) + ', ' + VariantToDBStr(GrEditForm.FormGUID, true) +
              ') returning (PK)', 'PK', grFrmPk, err);
          end else
          begin
            // обновить
            grFrmPk := dsDictGROUP_EDIT_FORM_PK.AsInteger;
            result := FMain.ExecSQL('update DYNAMIC_FORM set MODIFY = current_timestamp, TITLE = ' +
              VariantToDBStr(Trim(GrEditForm.edFormTitle.Text), true) + ', WIDTH = ' +
              VariantToDBStr(GrEditForm.edFormWidth.Value, false, true, true) + ', HEIGHT = ' +
              VariantToDBStr(GrEditForm.edFormHeight.Value, false, true, true) + ', ALIAS_FORM = ' +
              VariantToDBStr(Trim(GrEditForm.edFormAlias.Text), true) + ', LEFT_ALIGN = ' +
              iif(GrEditForm.chbLeftAlign.Checked, '1', '0') + ', LABEL_WIDTH = ' +
              VariantToDBStr(GrEditForm.edLabelWidth.Value, false, true, true) + ', GUID = ' +
              VariantToDBStr(GrEditForm.FormGUID, true) + ' where PK = ' + dsDictGROUP_EDIT_FORM_PK.AsString, err);
          end;
        end else
        begin
          // удаляем
          grFrmPk := Null;
          if not dsDictGROUP_EDIT_FORM_PK.IsNull then
            result := FMain.ExecSQL('delete from DYNAMIC_FORM where PK = ' + dsDictGROUP_EDIT_FORM_PK.AsString, err);
        end;

      // вот теперь уже референс
      if result then
        result := FMain.ExecSQL('update DYNAMIC_FORM_REFERENCE set MODIFY = current_timestamp, TITLE = ' +
          VariantToDBStr(Trim(edDictTitle.Text), true) + ', ORDER_BY = ' + VariantToDBStr(Trim(GetOrders), true) +
          ', DESCRIPTOR_ = ' + VariantToDBStr(Trim(edDictDescriptor.Text), true) + ', PARENT_REFERENCE_PK = ' +
          VariantToDBStr(lcbParentDict.KeyValue, false, true, true) + ', MAIN_FORM_PK = ' + dsDictMAIN_FORM_PK.AsString +
          ', START_FORM_PK = ' + VariantToDBStr(startFrmPk, false, true, true) + ', BASE_DESCRIPTOR = ' +
          VariantToDBStr(cbDictBaseDescriptor.Text, true) + ', FOLDER_PK = ' + VariantToDBStr(lcbFolder.KeyValue, false, true, true) +
          ', PARENT_ID_FIELD = ' + VariantToDBStr(lcbDictParentIdField.KeyValue, true) + ', ID_FIELD = ' +
          VariantToDBStr(lcbDictIdField.KeyValue, true) + ', EXPAND_REF = ' + iif(chbDictExpandRef.Checked, '''1''', '''0''') +
          ', COLLAPSE_FILTER = ' + iif(chbDictCollapseFilter.Checked, '''1''', '''0''') + ', GROUPING = ' +
          VariantToDBStr(lcbDictGrouping.KeyValue, true) + ', CON_ORIENT = ' + IntToStr(cbDictConOrient.ItemIndex) +
          ', BRIEF_NOTE = ' + VariantToDBStr(lcbDictDocument.KeyValue, false, true, true) + ', EDITABLE = ' +
          iif(chbDictEditable.Checked, '1', '0') + ', SET_DISTINCT = ' + iif(chbDictSetDistinct.Checked, '''1''', '''0''') +
          ', REF_SIZE = ' + VariantToDBStr(edDictRefSize.Value, false, true, true) + ', GROUP_EDIT_FORM_PK = ' +
          VariantToDBStr(grFrmPk, false, true, true) + ', SHOW_ONLY_ADMIN = ' + iif(chbDictShowOnlyAdmin.Checked, '1', '0') +
          ', EXPAND_TREE = ' + iif(chbDictExpandTree.Checked, '1', '0') + ', USE_MEM = ' + iif(chbDictUseMem.Checked, '1', '0') +
          ', COUNT_ON_PAGE = ' + VariantToDBStr(edDictCountOnPage.Value, false, true, true) + ', DEFERRED_IMPORTS = ' +
          iif(chbDictDeferredImports.Checked, '1', '0') + ', AUTOSAVEINTERVAL = ' +
          VariantToDBStr(edDictAutosaveInterval.Value, false, true, true) + ', SKIP_DUPLICATES = ' +
          iif(chbDictSkipDuplicates.Checked, '''1''', '''0''') + ', SHOW_FILTER_BOUND = ' +
          iif(cbDictShowFilterBound.ItemIndex = 0, 'null', '''' + cbDictShowFilterBound.Text + '''') + ', CHECK_SELECT = ' +
          iif(chbCheckSelect.Checked, '1', '0') + ', GUID = ' + VariantToDBStr(dsDictGUID.AsVariant, true) + ' where PK = ' + dsDictPK.AsString, err);

      // пишем в лог
      FMain.AddToRefLog(cotDict, edDictDescriptor.Text, Properties.Guid, rltUpdate);
    end
    else result := false;
  end;

  if (err <> '') then Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);

  if result then
  begin
    SetPropValues(Properties.PK, iif(Trim(edDictDescriptor.Text) = '', Null, Trim(edDictDescriptor.Text)),
      iif(Trim(edDictTitle.Text) = '', Null, Trim(edDictTitle.Text)),
      iif(lcbParentDict.KeyValue = 0, Null, lcbParentDict.KeyValue),
      iif(lcbFolder.KeyValue = 0, Null, lcbFolder.KeyValue), Properties.Login, Properties.ObjType, Properties.Guid);
    SaveGridData(mainFrmPk, grFrmPk, startFrmPk);
  end;
end;

procedure TFEditDict.SaveFields(FormPk: Integer; Fields: TMemTableEh; DelList: TStringList);
var
  err: string;
  
begin
  if Mode = omView then exit;

  if Fields.State in [dsEdit, dsInsert] then Fields.Post;

  // удаление полей
  if DelList.Count > 0 then
  begin
    if not FMain.ExecSQL('delete from DYNAMIC_FORM_FIELD where PK in (' + TextToString(DelList.Text) + ')', err) then
    begin
      Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;
    DelList.Clear;
  end;

  // вставка/обновление полей
  try
    Fields.First;
    while not Fields.Eof do
    begin
      if Fields.FieldByName('CHANGED').AsBoolean then
      begin
        qEditField.Close;
        qEditField.ParamByName('PK').Value := Fields.FieldByName('PK').Value;
        qEditField.ParamByName('OWNER_USER_PK').Value := Fields.FieldByName('OWNER_USER_PK').Value;
        qEditField.ParamByName('GROUP_PK').Value := Fields.FieldByName('GROUP_PK').Value;
        qEditField.ParamByName('GROUP_COLUMN').Value := Fields.FieldByName('GROUP_COLUMN').Value;
        qEditField.ParamByName('OBJECT_PK').Value := Fields.FieldByName('OBJECT_PK').Value;
        qEditField.ParamByName('ORDER_').Value := Fields.FieldByName('ORDER_').Value;
        qEditField.ParamByName('TITLE').Value := Fields.FieldByName('TITLE').Value;
        qEditField.ParamByName('DESCRIPTION').Value := Fields.FieldByName('DESCRIPTION').AsString;
        qEditField.ParamByName('TYPE_NAME').Value := Fields.FieldByName('TYPE_NAME').Value;
        qEditField.ParamByName('FIELD_NAME').Value := Fields.FieldByName('FIELD_NAME').Value;
        qEditField.ParamByName('STYLE_EXTERNAL').Value := Fields.FieldByName('STYLE_EXTERNAL').AsString;
        qEditField.ParamByName('STYLE').Value := Fields.FieldByName('STYLE').AsString;
        qEditField.ParamByName('PARAMETERS').Value := Fields.FieldByName('PARAMETERS').Value;
        qEditField.ParamByName('IS_VISIBLE').Value := Fields.FieldByName('IS_VISIBLE').Value;
        qEditField.ParamByName('FORM_PK').Value := FormPk;
        qEditField.ParamByName('GRID_VISIBLE').Value := Fields.FieldByName('GRID_VISIBLE').Value;
        qEditField.ParamByName('GRID_ORDER').Value := Fields.FieldByName('GRID_ORDER').Value;
        qEditField.ParamByName('GRID_WIDTH').Value := Fields.FieldByName('GRID_WIDTH').Value;
        qEditField.ParamByName('EDITABLE').Value := Fields.FieldByName('EDITABLE').Value;
        qEditField.ParamByName('ADD_EDITABLE').Value := Fields.FieldByName('ADD_EDITABLE').Value;
        qEditField.ParamByName('EXCEL_EXPORT').Value := Fields.FieldByName('EXCEL_EXPORT').Value;
        qEditField.ParamByName('IS_VISIBLE_ADD').Value := Fields.FieldByName('IS_VISIBLE_ADD').Value;
        qEditField.ParamByName('FILTER_ORDER').Value := Fields.FieldByName('FILTER_ORDER').Value;
        qEditField.ParamByName('IS_FILTER').Value := Fields.FieldByName('IS_FILTER').Value;
        qEditField.ParamByName('FILTER_GROUP').Value := Fields.FieldByName('FILTER_GROUP').Value;
        qEditField.ParamByName('SHOW_IN_START_FORM').Value := Fields.FieldByName('SHOW_IN_START_FORM').Value;
        qEditField.ParamByName('STYLE_COLUMN').Value := Fields.FieldByName('STYLE_COLUMN').Value;
        qEditField.ParamByName('EDIT_IN_TABLE').Value := Fields.FieldByName('EDIT_IN_TABLE').Value;
        qEditField.ParamByName('SHOW_IN_GROUP_EDIT').Value := Fields.FieldByName('SHOW_IN_GROUP_EDIT').Value;
        qEditField.ParamByName('EXCEL_IMPORT').Value := Fields.FieldByName('EXCEL_IMPORT').Value;
        qEditField.ParamByName('MATCH').Value := Fields.FieldByName('MATCH').Value;
        qEditField.ParamByName('LOCKED').Value := Fields.FieldByName('LOCKED').Value;
        qEditField.ParamByName('GUID').Value := Fields.FieldByName('GUID').Value;
        qEditField.ExecQuery;
        FMain.Transact.CommitRetaining;
      end;
      Fields.Next;
    end;
  except
    on E: Exception do Application.MessageBox(pchar(E.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFEditDict.SaveGridData(MainFormPk, GrFormPk, StartFormPk: Variant);
var
  err: string;

begin
  if mtObjectTree.State in [dsEdit, dsInsert] then mtObjectTree.Post;
  if mtChart.State in [dsEdit, dsInsert] then mtChart.Post;

  if Mode = omView then exit;

  // удаление объектов БД
  if DeletedObjects.Count > 0 then
  begin
    if not FMain.ExecSQL('delete from DYNAMIC_FORM_OBJECT_TREE where PK in (' + TextToString(DeletedObjects.Text) + ')', err) then
    begin
      Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;
    DeletedObjects.Clear;
  end;

  // вставка/обновление объектов
  try
    mtObjectTree.First;
    while not mtObjectTree.Eof do
    begin
      if mtObjectTreeCHANGED.AsBoolean then
      begin
        qEditObject.Close;
        qEditObject.ParamByName('PK').Value := mtObjectTree.FieldByName('PK').Value;
        qEditObject.ParamByName('OWNER_USER_PK').Value := mtObjectTree.FieldByName('OWNER_USER_PK').Value;
        qEditObject.ParamByName('TITLE').Value := mtObjectTree.FieldByName('TITLE').Value;
        qEditObject.ParamByName('NAME').Value := mtObjectTree.FieldByName('NAME').Value;
        qEditObject.ParamByName('OBJECT_TYPE').Value := mtObjectTree.FieldByName('OBJECT_TYPE').Value;
        qEditObject.ParamByName('FORM_PK').Value := MainFormPk;
        qEditObject.ParamByName('JOIN_PARENT_PK').Value := mtObjectTree.FieldByName('JOIN_PARENT_PK').Value;
        qEditObject.ParamByName('IS_MULTI_JOIN').Value := mtObjectTree.FieldByName('IS_MULTI_JOIN').Value;
        qEditObject.ParamByName('JOIN_FIELDS').Value := mtObjectTree.FieldByName('JOIN_FIELDS').Value;
        qEditObject.ParamByName('PARAMETERS').Value := mtObjectTree.FieldByName('PARAMETERS').Value;
        qEditObject.ParamByName('DELETED').Value := mtObjectTree.FieldByName('DELETED').Value;
        qEditObject.ParamByName('INNER_JOIN').Value := mtObjectTree.FieldByName('INNER_JOIN').Value;
        qEditObject.ParamByName('GUID').Value := mtObjectTree.FieldByName('GUID').Value;
        qEditObject.ExecQuery;
        FMain.Transact.CommitRetaining;
      end;
      mtObjectTree.Next;
    end;
  except
    on E: Exception do Application.MessageBox(pchar(E.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;

  // главная форма
  SaveFields(MainFormPk, mtFormFields, DeletedFields);
  SaveGroups(MainFormPk, mtGroups, DeletedGroups);

  // стартовая форма
  if Assigned(StartForm) then
  begin
    SaveFields(StartFormPk, StartForm.mtFormFields, StartForm.DeletedFields);
    SaveGroups(StartFormPk, StartForm.mtGroups, StartForm.DeletedGroups);
  end;

  // форма группового редактирования
  if Assigned(GrEditForm) then
  begin
    SaveFields(GrFormPk, GrEditForm.mtFormFields, GrEditForm.DeletedFields);
    SaveGroups(GrFormPk, GrEditForm.mtGroups, GrEditForm.DeletedGroups);
  end;

  // права ролей
  SavePermissions(mtPermRoles, qEditPermRole, DeletedPermRoles);
  // права должностей
  SavePermissions(mtPermRanks, qEditPermRank, DeletedPermRanks);

  // удаление конфигураций фильтров
  if DeletedFilterConfigs.Count > 0 then
  begin
    if not FMain.ExecSQL('delete from DYNAMIC_FORM_FILTER_CONFIG where PK in (' + TextToString(DeletedFilterConfigs.Text) + ')', err) then
    begin
      Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;
    DeletedFilterConfigs.Clear;
  end;

  // вставка/обновление конфигураций фильтров
  try
    mtFilterConfig.First;
    while not mtFilterConfig.Eof do
    begin
      if mtFilterConfigCHANGED.AsBoolean then
      begin
        qEditFilterConfig.Close;
        qEditFilterConfig.ParamByName('PK').Value := mtFilterConfig.FieldByName('PK').Value;
        qEditFilterConfig.ParamByName('NAME').Value := mtFilterConfig.FieldByName('NAME').Value;
        qEditFilterConfig.ParamByName('REF_PK').Value := Properties.PK;
        qEditFilterConfig.ParamByName('FILTER_VALUE').Value := mtFilterConfig.FieldByName('FILTER_VALUE').Value;
        qEditFilterConfig.ParamByName('GUID').Value := mtFilterConfig.FieldByName('GUID').Value;
        qEditFilterConfig.ExecQuery;
        FMain.Transact.CommitRetaining;
      end;
      mtFilterConfig.Next;
    end;
  except
    on E: Exception do Application.MessageBox(pchar(E.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;

  // удаление привязки конфигураций фильтров к должностям
  if DeletedPostFilters.Count > 0 then
  begin
    if not FMain.ExecSQL('delete from DYNAMIC_FROM_POST_FILTER where PK in (' + TextToString(DeletedPostFilters.Text) + ')', err) then
    begin
      Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;
    DeletedPostFilters.Clear;
  end;

  // вставка привязки конфигураций фильтров к должностям
  try
    mtPostFilter.First;
    while not mtPostFilter.Eof do
    begin
      if mtPostFilterCHANGED.AsBoolean then
      begin
        qAddPostFilter.Close;
        qAddPostFilter.ParamByName('POST_PK').Value := mtPostFilterPOST_PK.AsVariant;
        qAddPostFilter.ParamByName('FILTER_CONFIG_PK').Value := mtPostFilterFILTER_CONFIG_PK.AsVariant;
        qAddPostFilter.ParamByName('GUID').Value := mtPostFilterGUID.AsVariant;
        qAddPostFilter.ExecQuery;
        FMain.Transact.CommitRetaining;
      end;
      mtPostFilter.Next;
    end;
  except
    on E: Exception do Application.MessageBox(pchar(E.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;

  // удаление групп графиков
  if DeletedChartGroups.Count > 0 then
  begin
    if not FMain.ExecSQL('delete from DYNAMIC_FORM_CHART_GROUPS where PK in (' + TextToString(DeletedChartGroups.Text) + ')', err) then
    begin
      Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;
    DeletedChartGroups.Clear;
  end;

  // вставка/обновление групп графиков
  try
    mtChartGroup.First;
    while not mtChartGroup.Eof do
    begin
      if mtChartGroupCHANGED.AsBoolean then
      begin
        qEditChartGroup.Close;
        qEditChartGroup.ParamByName('PK').Value := mtChartGroup.FieldByName('PK').Value;
        qEditChartGroup.ParamByName('REFERENCE_PK').Value := Properties.PK;
        qEditChartGroup.ParamByName('TITLE').Value := mtChartGroup.FieldByName('TITLE').Value;
        qEditChartGroup.ParamByName('ORIENTATION').Value := mtChartGroup.FieldByName('ORIENTATION').Value;
        qEditChartGroup.ParamByName('GUID').Value := mtChartGroup.FieldByName('GUID').Value;
        qEditChartGroup.ExecQuery;
        FMain.Transact.CommitRetaining;
      end;
      mtChartGroup.Next;
    end;
  except
    on E: Exception do Application.MessageBox(pchar(E.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;

  // удаление графиков
  if DeletedCharts.Count > 0 then
  begin
    if not FMain.ExecSQL('delete from DYNAMIC_FORM_CHARTS where PK in (' + TextToString(DeletedCharts.Text) + ')', err) then
    begin
      Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;
    DeletedCharts.Clear;
  end;

  // вставка/обновление графиков
  try
    mtChart.First;
    while not mtChart.Eof do
    begin
      if mtChartCHANGED.AsBoolean then
      begin
        qEditChart.Close;
        qEditChart.ParamByName('PK').Value := mtChart.FieldByName('PK').Value;
        qEditChart.ParamByName('REFERENC_PK').Value := Properties.PK;
        qEditChart.ParamByName('X_FIELD_PK').Value := mtChart.FieldByName('X_FIELD_PK').Value;
        qEditChart.ParamByName('Y_FIELD_PK').Value := mtChart.FieldByName('Y_FIELD_PK').Value;
        qEditChart.ParamByName('GROUP_FUNCTION').Value := mtChart.FieldByName('GROUP_FUNCTION').Value;
        qEditChart.ParamByName('SERIES_DIF').Value := mtChart.FieldByName('SERIES_DIF').Value;
        qEditChart.ParamByName('TITLE').Value := mtChart.FieldByName('TITLE').Value;
        qEditChart.ParamByName('CHART_TYPE').Value := mtChart.FieldByName('CHART_TYPE').Value;
        qEditChart.ParamByName('ORDER_').Value := mtChart.FieldByName('ORDER_').Value;
        qEditChart.ParamByName('X_AXIS_ROTATE').Value := mtChart.FieldByName('X_AXIS_ROTATE').Value;
        qEditChart.ParamByName('ADDITIONAL_FIELD').Value := mtChart.FieldByName('ADDITIONAL_FIELD').Value;
        qEditChart.ParamByName('ADDITIONAL_FIELD_ROTATE').Value := mtChart.FieldByName('ADDITIONAL_FIELD_ROTATE').Value;
        qEditChart.ParamByName('Y_TITLE').Value := mtChart.FieldByName('Y_TITLE').Value;
        qEditChart.ParamByName('GROUP_PK').Value := mtChart.FieldByName('GROUP_PK').Value;
        qEditChart.ParamByName('GROUP_ORDER').Value := mtChart.FieldByName('GROUP_ORDER').Value;
        qEditChart.ParamByName('GUID').Value := mtChart.FieldByName('GUID').Value;
        qEditChart.ExecQuery;
        FMain.Transact.CommitRetaining;
      end;
      mtChart.Next;
    end;
  except
    on E: Exception do Application.MessageBox(pchar(E.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;

  // удаление кнопок справочника
  if DeletedEvents.Count > 0 then
  begin
    if not FMain.ExecSQL('delete from DYNAMIC_FORM_OTHER_EVENT where ID_EV in (' + TextToString(DeletedEvents.Text) + ')', err) then
    begin
      Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;
    DeletedEvents.Clear;
  end;

  // вставка/обновление кнопок справочника
  try
    mtOtherEvents.First;
    while not mtOtherEvents.Eof do
    begin
      if mtOtherEventsCHANGED.AsBoolean then
      begin
        qEditOtherEvent.Close;
        qEditOtherEvent.ParamByName('ID_EV').Value := mtOtherEvents.FieldByName('ID_EV').Value;
        qEditOtherEvent.ParamByName('ID_DF_REFERENCE').Value := Properties.PK;
        qEditOtherEvent.ParamByName('TITLE_EV').Value := mtOtherEvents.FieldByName('TITLE_EV').Value;
        qEditOtherEvent.ParamByName('EVENT_REFERENCE').Value := mtOtherEvents.FieldByName('EVENT_REFERENCE').Value;
        qEditOtherEvent.ParamByName('POSITION_EV').Value := mtOtherEvents.FieldByName('POSITION_EV').Value;
        qEditOtherEvent.ParamByName('IMAGE_NAME_EV').Value := mtOtherEvents.FieldByName('IMAGE_NAME_EV').Value;
        qEditOtherEvent.ParamByName('VIEW_TO_MENU').Value := mtOtherEvents.FieldByName('VIEW_TO_MENU').Value;
        qEditOtherEvent.ParamByName('CLASS_NAME').Value := mtOtherEvents.FieldByName('CLASS_NAME').Value;
        qEditOtherEvent.ParamByName('IS_VIZARD').Value := mtOtherEvents.FieldByName('IS_VIZARD').Value;
        qEditOtherEvent.ParamByName('ALIAS_DF').Value := mtOtherEvents.FieldByName('ALIAS_DF').Value;
        qEditOtherEvent.ParamByName('LINK_METHOD').Value := mtOtherEvents.FieldByName('LINK_METHOD').Value;
        qEditOtherEvent.ParamByName('GUID').Value := mtOtherEvents.FieldByName('GUID').Value;
        qEditOtherEvent.ExecQuery;
        FMain.Transact.CommitRetaining;
      end;
      mtOtherEvents.Next;
    end;
  except
    on E: Exception do Application.MessageBox(pchar(E.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;

  // удаление групп фильтров
  if DeletedFilterGroups.Count > 0 then
  begin
    if not FMain.ExecSQL('delete from DYNAMIC_FORM_FILTER_GROUP where PK in (' + TextToString(DeletedFilterGroups.Text) + ')', err) then
    begin
      Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;
    DeletedFilterGroups.Clear;
  end;

  // вставка/обновление групп фильтров
  try
    mtFilterGroup.First;
    while not mtFilterGroup.Eof do
    begin
      if mtFilterGroupCHANGED.AsBoolean then
      begin
        qEditFilterGroup.Close;
        qEditFilterGroup.ParamByName('PK').Value := mtFilterGroup.FieldByName('PK').Value;
        qEditFilterGroup.ParamByName('FORM_PK').Value := MainFormPk;
        qEditFilterGroup.ParamByName('TITLE').Value := mtFilterGroup.FieldByName('TITLE').Value;
        qEditFilterGroup.ParamByName('ORDER_').Value := mtFilterGroup.FieldByName('ORDER_').Value;
        qEditFilterGroup.ParamByName('COLLAPSED').Value := mtFilterGroup.FieldByName('COLLAPSED').Value;
        qEditFilterGroup.ParamByName('OWNER_USER_PK').Value := FMain.dsPortalUserPK.Value;
        qEditFilterGroup.ParamByName('GUID').Value := mtFilterGroup.FieldByName('GUID').Value;
        qEditFilterGroup.ExecQuery;
        FMain.Transact.CommitRetaining;
      end;
      mtFilterGroup.Next;
    end;
  except
    on E: Exception do Application.MessageBox(pchar(E.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFEditDict.SaveGroups(FormPk: Integer; Groups: TMemTableEh; DelList: TStringList);
var
  err: string;
  
begin
  if Mode = omView then exit;

  if Groups.State in [dsEdit, dsInsert] then Groups.Post;

  // удаление групп
  if DelList.Count > 0 then
  begin
    if not FMain.ExecSQL('delete from DYNAMIC_FORM_FIELD_GROUP where PK in (' + TextToString(DelList.Text) + ')', err) then
    begin
      Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;
    DelList.Clear;
  end;

  // вставка/обновление групп
  try
    Groups.First;
    while not Groups.Eof do
    begin
      if Groups.FieldByName('CHANGED').AsBoolean then
      begin
        qEditGroup.Close;
        qEditGroup.ParamByName('PK').Value := Groups.FieldByName('PK').Value;
        qEditGroup.ParamByName('PARENT_PK').Value := Groups.FieldByName('PARENT_PK').Value;
        qEditGroup.ParamByName('OWNER_USER_PK').Value := Groups.FieldByName('OWNER_USER_PK').Value;
        qEditGroup.ParamByName('FORM_PK').Value := FormPk;
        qEditGroup.ParamByName('ORDER_').Value := Groups.FieldByName('ORDER_').Value;
        qEditGroup.ParamByName('TITLE').Value := Groups.FieldByName('TITLE').AsString;
        qEditGroup.ParamByName('DESCRIPTION').Value := Groups.FieldByName('DESCRIPTION').Value;
        qEditGroup.ParamByName('COUNT_COLUMN').Value := Groups.FieldByName('COUNT_COLUMN').Value;
        qEditGroup.ParamByName('STYLE_EXTERNAL').Value := Groups.FieldByName('STYLE_EXTERNAL').AsString;
        qEditGroup.ParamByName('STYLE_INTERNAL').Value := Groups.FieldByName('STYLE_INTERNAL').AsString;
        qEditGroup.ParamByName('CREATE_').Value := Groups.FieldByName('CREATE_').Value;
        qEditGroup.ParamByName('MODIFY').AsDateTime := Now;
        qEditGroup.ParamByName('IS_VISIBLE').Value := Groups.FieldByName('IS_VISIBLE').Value;
        qEditGroup.ParamByName('COLUMN_').Value := Groups.FieldByName('COLUMN_').Value;
        qEditGroup.ParamByName('STYLE_COLUMNS').Value := Groups.FieldByName('STYLE_COLUMNS').AsString;
        qEditGroup.ParamByName('ADD_VISIBLE').Value := Groups.FieldByName('ADD_VISIBLE').Value;
        qEditGroup.ParamByName('COLLAPSED').Value := Groups.FieldByName('COLLAPSED').Value;
        qEditGroup.ParamByName('LEFT_ALIGN').Value := Groups.FieldByName('LEFT_ALIGN').Value;
        qEditGroup.ParamByName('LABEL_WIDTH').Value := Groups.FieldByName('LABEL_WIDTH').Value;
        qEditGroup.ParamByName('GUID').Value := Groups.FieldByName('GUID').Value;
        qEditGroup.ExecQuery;
        FMain.Transact.CommitRetaining;
      end;
      Groups.Next;
    end;
  except
    on E: Exception do Application.MessageBox(pchar(E.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFEditDict.SavePermissions(dsSrc: TMemTableEh; SaveQuery: TpFIBQuery; DelList: TStringList);
var
  err, t: string;
  
begin
  if Mode = omView then exit;

  if dsSrc.State in [dsEdit, dsInsert] then dsSrc.Post;

  if SaveQuery = qEditPermRole then t := 'DYNAMIC_FORM_PERMISSIONS'
  else if SaveQuery = qEditPermRank then t := 'DYNAMIC_FORM_PERM_RANKS'
  else exit;
  
  // удаление
  if DelList.Count > 0 then
  begin
    if not FMain.ExecSQL('delete from ' + t + ' where PK in (' + TextToString(DelList.Text) + ')', err) then
    begin
      Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
      exit;
    end;
    DelList.Clear;
  end;

  // вставка/обновление
  try
    dsSrc.First;
    while not dsSrc.Eof do
    begin
      if dsSrc.FieldByName('CHANGED').AsBoolean then
      begin
        SaveQuery.Close;
        SaveQuery.ParamByName('PK').Value := dsSrc.FieldByName('PK').Value;
        SaveQuery.ParamByName('REFERENCE_PK').Value := dsDictPK.AsInteger;
        SaveQuery.ParamByName('ROLE_PK').Value := dsSrc.FieldByName('ROLE_PK').Value;
        SaveQuery.ParamByName('ADD_').Value := dsSrc.FieldByName('ADD_').Value;
        SaveQuery.ParamByName('EDIT_').Value := dsSrc.FieldByName('EDIT_').Value;
        SaveQuery.ParamByName('DEL_').Value := dsSrc.FieldByName('DEL_').Value;
        SaveQuery.ParamByName('VIEW_REF').Value := dsSrc.FieldByName('VIEW_REF').Value;
        SaveQuery.ParamByName('VIEW_').Value := dsSrc.FieldByName('VIEW_').Value;
        SaveQuery.ParamByName('CONFIG_').Value := dsSrc.FieldByName('CONFIG_').Value;
        SaveQuery.ParamByName('EXPORT').Value := dsSrc.FieldByName('EXPORT').Value;
        SaveQuery.ParamByName('IMPORT').Value := dsSrc.FieldByName('IMPORT').Value;
        SaveQuery.ParamByName('GRID_SAVE').Value := dsSrc.FieldByName('GRID_SAVE').Value;
        SaveQuery.ParamByName('GUID').Value := dsSrc.FieldByName('GUID').Value;
        SaveQuery.ExecQuery;
        FMain.Transact.CommitRetaining;
      end;
      dsSrc.Next;
    end;
  except
    on E: Exception do Application.MessageBox(pchar(E.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;
end;

function TFEditDict.SaveTemplate(TmplText: string; TmplPk: Variant; Insert, ConvertToUni: boolean): Variant;
var
  err: string;

begin
  result := TmplPk;

  if ConvertToUni then
    TmplText := ReplaceQuote(StringReplace(PyAnsiToUnicode(TmplText), '\"', '"', [rfReplaceAll]))
  else
    TmplText := ReplaceQuote(TmplText);

  if VarIsNull(TmplPk) or (TmplPk = 1) or (TmplPk = 0) or Insert then
    FMain.ExecSQL('insert into DYNAMIC_FORM_PERM_TMP (TEXT_TEMPLATE) values (''' + TmplText + ''') returning (PK)', 'PK', result, err)
  else begin
    FMain.ExecSQL('update DYNAMIC_FORM_PERM_TMP set TEXT_TEMPLATE = ''' + TmplText + ''' where PK = ' + VarToStr(TmplPk), err);
    FMain.AddToRefLog(cotDict, Properties.Descriptor, Properties.Guid, rltUpdate, 'Изменение текста шаблона прав ' + VarToStr(TmplPk));
  end;

  if err <> '' then Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFEditDict.AutoCreateStartForm;
begin
  if Mode = omAdd then exit;

  mtObjectTree.DisableControls;
  try
    // пробежимся по списку полей и посмотрим - если таких объектов уже нет, то надо поудалять их поля
    if Assigned(StartForm) then
    begin
      StartForm.mtFormFields.First;
      while not StartForm.mtFormFields.Eof do
      begin
        if (not mtObjectTree.Locate('NAME', StartForm.mtFormFieldsOBJECT_NAME.AsString, [loCaseInsensitive])) then
          StartForm.mtFormFields.Delete
        else begin
          LoadInputParams(mtInputParams, mtObjectTreePARAMETERS.AsString);
          if not mtInputParams.Locate('NAME', StartForm.mtFormFieldsFIELD_NAME.AsString, [loCaseInsensitive]) then
            StartForm.mtFormFields.Delete
          else begin
            if mtInputParamsTYPE.AsString <> PROCPARAM_user then StartForm.mtFormFields.Delete
            else StartForm.mtFormFields.Next;
          end;
        end;
      end;
      StartForm.mtFormFields.Refresh;
    end;

    // пробежимся по дереву объектов - если есть процедуры, где требуется ввод параметров от пользователя, тогда надо создавать форму,
    // и по таким параметрам клепать поля
    mtObjectTree.First;
    while not mtObjectTree.Eof do
    begin
      if mtObjectTreeOBJECT_TYPE.AsString = 'PROC' then
      begin
        LoadInputParams(mtInputParams, mtObjectTreePARAMETERS.AsString);
        mtInputParams.First;
        while not mtInputParams.Eof do
        begin
          if (mtInputParamsTYPE.AsString = PROCPARAM_user) then
          begin
            if not Assigned(StartForm) then InitStartForm;
            if (not StartForm.mtFormFields.Locate('OBJECT_NAME;FIELD_NAME', VarArrayOf([mtObjectTreeNAME.AsString,
              mtInputParamsNAME.AsString]), [loCaseInsensitive])) then
            begin
              StartForm.AutoIncFields;
              StartForm.mtFormFields.Append;
              StartForm.mtFormFieldsTITLE.AsString := mtInputParamsNAME.AsString;
              StartForm.mtFormFieldsFIELD_NAME.AsString := mtInputParamsNAME.AsString;
              StartForm.mtFormFieldsOBJECT_PK.AsInteger := mtObjectTreePK.AsInteger;
              StartForm.mtFormFieldsOBJECT_NAME.AsString := mtObjectTreeNAME.AsString;
              StartForm.mtFormFieldsOWNER_USER_PK.AsInteger := FMain.dsPortalUserPK.AsInteger;
              StartForm.mtFormFieldsGROUP_COLUMN.AsInteger := 0;
              StartForm.mtFormFieldsORDER_.AsInteger := StartForm.mtFormFieldsORDER_.Tag;
              StartForm.mtFormFieldsTYPE_NAME.AsString := 'text';
              StartForm.mtFormFieldsIS_VISIBLE.AsInteger := 1;
              StartForm.mtFormFieldsGRID_VISIBLE.AsInteger := 0;
              StartForm.mtFormFieldsGRID_ORDER.AsInteger := 0;
              StartForm.mtFormFieldsEDITABLE.AsInteger := 1;
              StartForm.mtFormFieldsADD_EDITABLE.AsInteger := 1;
              StartForm.mtFormFieldsEXCEL_EXPORT.AsInteger := 0;
              StartForm.mtFormFieldsIS_VISIBLE_ADD.AsInteger := 1;
              StartForm.mtFormFieldsFILTER_ORDER.AsInteger := 0;
              StartForm.mtFormFieldsIS_FILTER.AsInteger := 0;
              StartForm.mtFormFieldsSHOW_IN_START_FORM.AsInteger := 0;
              StartForm.mtFormFieldsEDIT_IN_TABLE.AsInteger := 0;
              StartForm.mtFormFieldsSHOW_IN_GROUP_EDIT.AsInteger := 0;
              StartForm.mtFormFieldsEXCEL_IMPORT.AsInteger := 0;
              StartForm.mtFormFieldsMATCH.AsInteger := 0;
              StartForm.mtFormFieldsLOCKED.AsInteger := 0;
              StartForm.mtFormFieldsPARAMETERS.AsString := '{}';
              StartForm.mtFormFieldsSTYLE_EXTERNAL.AsString := '';
              StartForm.mtFormFieldsSTYLE.AsString := '';
              StartForm.mtFormFields.Post;
            end;
          end;
          mtInputParams.Next;
        end;
      end;
      mtObjectTree.Next;
    end;
    mtObjectTree.First;
  finally
    mtObjectTree.EnableControls;
  end;
end;

procedure TFEditDict.sbDelChartClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (not mtChart.Active) or mtChart.IsEmpty then exit;

  if dbgChart.SelectedRows.Count > 1 then
  begin
    if Application.MessageBox(pchar('Удалить все отмеченные графики (' + IntToStr(dbgChart.SelectedRows.Count) + ')?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    dbgChart.SelectedRows.Delete;
  end else
  begin
    if Application.MessageBox(pchar('Удалить график "' + mtChartTITLE.AsString + '"?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    mtChart.Delete;
  end;
end;

procedure TFEditDict.sbDelChartGroupClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (not mtChartGroup.Active) or mtChartGroup.IsEmpty then exit;

  if dbgChartGroup.SelectedRows.Count > 1 then
  begin
    if Application.MessageBox(pchar('Удалить все отмеченные группы графиков (' + IntToStr(dbgChartGroup.SelectedRows.Count) + ')?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    dbgChartGroup.SelectedRows.Delete;
  end else
  begin
    if Application.MessageBox(pchar('Удалить группу графиков "' + mtChartGroupTITLE.AsString + '"?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    mtChartGroup.Delete;
  end;
end;

procedure TFEditDict.sbDelEventClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (not mtOtherEvents.Active) or mtOtherEvents.IsEmpty then exit;

  if dbgOtherEvents.SelectedRows.Count > 1 then
  begin
    if Application.MessageBox(pchar('Удалить все отмеченные кнопки (' + IntToStr(dbgOtherEvents.SelectedRows.Count) + ')?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    dbgOtherEvents.SelectedRows.Delete;
  end else
  begin
    if Application.MessageBox(pchar('Удалить кнопку "' + mtOtherEventsID_EV.AsString + ' : ' + mtOtherEventsTITLE_EV.AsString + '"?'),
      'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    mtOtherEvents.Delete;
  end;
end;

procedure TFEditDict.sbDelFieldClick(Sender: TObject);
begin
  if Mode = omView then exit;
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

procedure TFEditDict.sbDelFilterConfigClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (not mtFilterConfig.Active) or mtFilterConfig.IsEmpty then exit;

  if dbgFilterConfig.SelectedRows.Count > 0 then
  begin
    if Application.MessageBox(pchar('Удалить ' + IntToStr(dbgFilterConfig.SelectedRows.Count) + ' выбранных конфигураций фильтров?'),
      'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    dbgFilterConfig.SelectedRows.Delete;
  end else
  begin
    if Application.MessageBox(pchar('Удалить конфигурацию "' + mtFilterConfigNAME.AsString + '"?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    mtFilterConfig.Delete;
  end;
end;

procedure TFEditDict.sbDelFilterGroupClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (not mtFilterGroup.Active) or mtFilterGroup.IsEmpty then exit;

  if dbgFilterGroup.SelectedRows.Count > 1 then
  begin
    if Application.MessageBox(pchar('Удалить все отмеченные группы фильтров (' + IntToStr(dbgFilterGroup.SelectedRows.Count) + ')?'),
      'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    dbgFilterGroup.SelectedRows.Delete;
  end else
  begin
    if Application.MessageBox(pchar('Удалить группу фильтров "' + mtFilterGroupPK.AsString + ' : ' + mtFilterGroupTITLE.AsString + '"?'),
      'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    mtFilterGroup.Delete;
  end;
end;

procedure TFEditDict.sbDelGroupClick(Sender: TObject);
begin
  if Mode = omView then exit;
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

procedure TFEditDict.sbDelObjectClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (not mtObjectTree.Active) or mtObjectTree.IsEmpty then exit;
  if Application.MessageBox(pchar('Удалить объект БД "' + mtObjectTreeNAME.AsString + '"?'), 'Подтверждение',
    MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

  mtObjectTree.Delete;
end;

procedure TFEditDict.sbDelPermRankClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (not mtPermRanks.Active) or mtPermRanks.IsEmpty then exit;

  if dbgPermRanks.SelectedRows.Count > 0 then
  begin
    if Application.MessageBox(pchar('Удалить права для ' + IntToStr(dbgPermRanks.SelectedRows.Count) + ' выбранных должностей?'),
      'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    dbgPermRanks.SelectedRows.Delete;
  end else
  begin
    if Application.MessageBox(pchar('Удалить права для должности "' + mtPermRanksROLE_NAME.AsString + '"?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    mtPermRanks.Delete;
  end;
end;

procedure TFEditDict.sbDelPermRoleClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (not mtPermRoles.Active) or mtPermRoles.IsEmpty then exit;

  if dbgPermRoles.SelectedRows.Count > 0 then
  begin
    if Application.MessageBox(pchar('Удалить права для ' + IntToStr(dbgPermRanks.SelectedRows.Count) + ' выбранных ролей?'),
      'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    dbgPermRoles.SelectedRows.Delete;
  end else
  begin
    if Application.MessageBox(pchar('Удалить права для роли "' + mtPermRolesROLE_NAME.AsString + '"?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    mtPermRoles.Delete;
  end;
end;

procedure TFEditDict.sbDelPostFilterClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (not mtPostFilter.Active) or mtPostFilter.IsEmpty then exit;

  if dbgPostFilter.SelectedRows.Count > 0 then
  begin
    if Application.MessageBox(pchar('Удалить ' + IntToStr(dbgPostFilter.SelectedRows.Count) + ' выбранных записей?'),
      'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    dbgPostFilter.SelectedRows.Delete;
  end else
  begin
    if Application.MessageBox(pchar('Удалить привязку к должности "' + mtPostFilterPOST_PK.AsString + ':' + mtPostFilterPOST_NAME.AsString + '"?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    mtPostFilter.Delete;
  end;
end;

procedure TFEditDict.sbDelSortClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (not mtDictOrderBy.Active) or mtDictOrderBy.IsEmpty then exit;
  if Application.MessageBox(pchar('Убрать сортировку по полю "' + mtDictOrderByFIELD.AsString + '"?'), 'Подтверждение',
    MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

  mtDictOrderBy.Delete;
end;

procedure TFEditDict.sbDelWizardClick(Sender: TObject);
var
  d: TNodeDictInfo;

begin
  if Mode <> omEdit then exit;
  if (not dsWizard.Active) or dsWizard.IsEmpty then exit;

  d := AssignNodeData(cotWizard);
  try
    d.PK := dsWizardPK.AsVariant;
    d.Descriptor := dsWizardDESCRIPTOR_.AsVariant;
    d.Title := dsWizardNAME.AsVariant;
    d.ParentDictPK := dsWizardREF_PK.AsVariant;
    d.Login := Properties.Login;

    if FMain.DelWizard(d) then ReloadWizards;
  finally
    d.Free;
  end;
end;

procedure TFEditDict.sbEditChartClick(Sender: TObject);
var
  FChartEditor: TFChartEditor;
  m: TOpenMode;

begin
  if mtChart.IsEmpty then exit;

  if Mode = omView then m := omView
  else m := omEdit;
  
  if dbgChart.SelectedRows.Count > 1 then
  begin
    GroupEdit(dbgChart);
    exit;
  end;

  // открытие формы редактирования графика
  if FMain.SetFocusOpenedWindow(mtChartPK.AsInteger, TFChartEditor.ClassName) then exit;
  FChartEditor := TFChartEditor.Create(Self, cftEditor, m, mtChartPK.AsVariant, FMain.OnChildFormClose);
  FChartEditor.OnClose := OnChartEditorClose;
  FChartEditor.dsoFields.DataSet := dsOrderFields;
  FChartEditor.dsoGroup.DataSet := dsChartGroups;
  FChartEditor.EditingRec := mtChart.GetBookmark;
  FChartEditor.Caption := 'Редактирование графика';
  FChartEditor.edPk.Text := mtChartPK.AsString;
  FChartEditor.edTitle.Text := mtChartTITLE.AsString;
  FChartEditor.cbChartType.ItemIndex := FChartEditor.cbChartType.Items.IndexOf(mtChartCHART_TYPE.AsString);
  FChartEditor.lcbGroup.Value := mtChart.FieldByName('GROUP_PK').Value;
  FChartEditor.edGroupOrder.Value := mtChart.FieldByName('GROUP_ORDER').Value;
  FChartEditor.lcbXField.Value := mtChart.FieldByName('X_FIELD_PK').Value;
  FChartEditor.lcbYField.Value := mtChart.FieldByName('Y_FIELD_PK').Value;
  FChartEditor.lcbSDField.Value := mtChart.FieldByName('SERIES_DIF').Value;
  FChartEditor.GruopFunction := mtChartGROUP_FUNCTION.AsString;
  FChartEditor.edXAxisRotate.Value := mtChart.FieldByName('X_AXIS_ROTATE').Value;
  FChartEditor.edOrder.Text := mtChartORDER_.AsString;
  FChartEditor.edYTitle.Text := mtChartY_TITLE.AsString;
  FChartEditor.edAdditionalFieldRotate.Value := mtChart.FieldByName('ADDITIONAL_FIELD_ROTATE').Value;
  if mtChartADDITIONAL_FIELD.IsNull then FChartEditor.mAdditionalField.Clear
  else FChartEditor.mAdditionalField.Lines.Text := mtChartADDITIONAL_FIELD.AsString;
  FChartEditor.RegisterForm;
end;

procedure TFEditDict.sbEditChartGroupClick(Sender: TObject);
var
  FChartGroupEditor: TFChartGroupEditor;
  m: TOpenMode;

begin
  if mtChartGroup.IsEmpty then exit;

  if Mode = omView then m := omView
  else m := omEdit;
  
  if dbgChartGroup.SelectedRows.Count > 1 then
  begin
    GroupEdit(dbgChartGroup);
    exit;
  end;

  // открытие формы редактирования группы графиков
  if FMain.SetFocusOpenedWindow(mtChartGroupPK.AsInteger, TFChartGroupEditor.ClassName) then exit;
  FChartGroupEditor := TFChartGroupEditor.Create(Self, cftEditor, m, mtChartGroupPK.AsVariant, FMain.OnChildFormClose);
  FChartGroupEditor.OnClose := OnChartGroupEditorClose;
  FChartGroupEditor.EditingRec := mtChartGroup.GetBookmark;
  FChartGroupEditor.Caption := 'Редактирование группы графиков';
  FChartGroupEditor.edPk.Text := mtChartGroupPK.AsString;
  FChartGroupEditor.edTitle.Text := mtChartGroupTITLE.AsString;
  FChartGroupEditor.cbOrientation.ItemIndex := FChartGroupEditor.Orientations.IndexOf(mtChartGroupORIENTATION.AsString);
  FChartGroupEditor.RegisterForm;
end;

procedure TFEditDict.sbEditEventClick(Sender: TObject);
var
  FEventEditor: TFEventEditor;
  m: TOpenMode;

begin
  if mtOtherEvents.IsEmpty then exit;

  if Mode = omView then m := omView
  else m := omEdit;

  if dbgOtherEvents.SelectedRows.Count > 1 then
  begin
    GroupEdit(dbgOtherEvents);
    exit;
  end;

  // открытие формы редактирования кнопки
  if FMain.SetFocusOpenedWindow(mtOtherEventsID_EV.AsInteger, TFEventEditor.ClassName) then exit;
  FEventEditor := TFEventEditor.Create(Self, cftEditor, m, mtOtherEventsID_EV.AsVariant, FMain.OnChildFormClose);
  FEventEditor.OnClose := OnEventEditorClose;
  FEventEditor.dsoEvtDicts.DataSet := dsEvtDicts;
  FEventEditor.dsoEvtWizards.DataSet := dsEvtWizards;
  FEventEditor.dsoEvtForms.DataSet := dsEvtForms;
  FEventEditor.EditingRec := mtOtherEvents.GetBookmark;
  FEventEditor.Caption := 'Редактирование кнопки';
  FEventEditor.edPk.Text := mtOtherEventsID_EV.AsString;
  FEventEditor.edTitle.Text := mtOtherEventsTITLE_EV.AsString;
  FEventEditor.edPosition.Value := mtOtherEventsPOSITION_EV.AsInteger;
  FEventEditor.cbViewToMenu.ItemIndex := mtOtherEventsVIEW_TO_MENU.AsInteger;
  FEventEditor.edImage.Text := mtOtherEventsIMAGE_NAME_EV.AsString;
  FEventEditor.edCssClassName.Text := mtOtherEventsCLASS_NAME.AsString;
  FEventEditor.lcbReference.KeyValue := mtOtherEventsEVENT_REFERENCE.AsVariant;
  FEventEditor.lcbIsWizard.KeyValue := mtOtherEventsIS_VIZARD.AsVariant;
  FEventEditor.lcbAliasForm.KeyValue := mtOtherEventsALIAS_DF.AsVariant;
  FEventEditor.RegisterForm;
end;

procedure TFEditDict.sbEditFilterConfigClick(Sender: TObject);
var
  FFilterConfigEditor: TFFilterConfigEditor;
  m: TOpenMode;

begin
  if mtFilterConfig.IsEmpty then exit;

  if Mode = omView then m := omView
  else m := omEdit;

  if dbgFilterConfig.SelectedRows.Count > 1 then
  begin
    GroupEdit(dbgFilterConfig);
    exit;
  end;

  // открытие формы редактирования конфигурации фильтров
  if FMain.SetFocusOpenedWindow(mtFilterConfigPK.AsInteger, TFFilterConfigEditor.ClassName) then exit;
  FFilterConfigEditor := TFFilterConfigEditor.Create(Self, cftEditor, m, mtFilterConfigPK.AsVariant, FMain.OnChildFormClose);
  FFilterConfigEditor.OnClose := OnFilterConfigEditorClose;
  FFilterConfigEditor.EditingRec := mtFilterConfig.GetBookmark;
  FFilterConfigEditor.Caption := 'Редактирование конфигурации фильтров';
  FFilterConfigEditor.edPk.Text := mtFilterConfigPK.AsString;
  FFilterConfigEditor.edTitle.Text := mtFilterConfigNAME.AsString;
  FFilterConfigEditor.Fields := mtFormFields;
  FFilterConfigEditor.Template := mtFilterConfigFILTER_VALUE.AsString;
  FFilterConfigEditor.RegisterForm;
end;

procedure TFEditDict.sbEditFilterGroupClick(Sender: TObject);
var
  FFilterGroupEditor: TFFilterGroupEditor;
  m: TOpenMode;

begin
  if mtFilterGroup.IsEmpty then exit;

  if Mode = omView then m := omView
  else m := omEdit;

  if dbgFilterGroup.SelectedRows.Count > 1 then
  begin
    GroupEdit(dbgFilterGroup);
    exit;
  end;

  // открытие формы редактирования группы фильтров
  if FMain.SetFocusOpenedWindow(mtFilterGroupPK.AsInteger, TFFilterGroupEditor.ClassName) then exit;
  FFilterGroupEditor := TFFilterGroupEditor.Create(Self, cftEditor, m, mtFilterGroupPK.AsVariant, FMain.OnChildFormClose);
  FFilterGroupEditor.OnClose := OnFilterGroupEditorClose;
  FFilterGroupEditor.EditingRec := mtFilterGroup.GetBookmark;
  FFilterGroupEditor.Caption := 'Редактирование группы фильтров';
  FFilterGroupEditor.edPk.Text := mtFilterGroupPK.AsString;
  FFilterGroupEditor.edTitle.Text := mtFilterGroupTITLE.AsString;
  FFilterGroupEditor.edOrder.Value := mtFilterGroupORDER_.AsInteger;
  FFilterGroupEditor.chbCollapsed.Checked := mtFilterGroupCOLLAPSED.AsString = '1';
  FFilterGroupEditor.RegisterForm;
end;

procedure TFEditDict.sbEditFieldClick(Sender: TObject);
var
  FFieldEditor: TFFieldEditor;
  m: TOpenMode;

begin
  if mtFormFields.IsEmpty then exit;

  if Mode = omView then m := omView
  else m := omEdit;

  if dbgFormFields.SelectedRows.Count > 1 then
  begin
    GroupEdit(dbgFormFields);
    exit;
  end;

  // открытие формы редактирования поля
  if FMain.SetFocusOpenedWindow(mtFormFieldsPK.AsInteger, TFFieldEditor.ClassName) then exit;
  FFieldEditor := TFFieldEditor.Create(Self, cftEditor, m, mtFormFieldsPK.AsVariant, FMain.OnChildFormClose);
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
  FFieldEditor.cbFieldName.Items.Text := GetNotInvolvedFields(mtFormFields);
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
  FFieldEditor.chbShowInGroupEdit.Checked := mtFormFieldsSHOW_IN_GROUP_EDIT.AsInteger = 1;
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
  LoadFieldTypeParams(FFieldEditor.ParamControls, mtFormFieldsPARAMETERS.AsString);
  FFieldEditor.RegisterForm;
end;

procedure TFEditDict.sbEditGroupClick(Sender: TObject);
var
  FGroupEditor: TFGroupEditor;
  m: TOpenMode;

begin
  if mtGroups.IsEmpty then exit;

  if Mode = omView then m := omView
  else m := omEdit;

  if dbgGroups.SelectedRows.Count > 1 then
  begin
    GroupEdit(dbgGroups);
    exit;
  end;

  // открытие формы редактирования группы
  if FMain.SetFocusOpenedWindow(mtGroupsPK.AsInteger, TFGroupEditor.ClassName) then exit;
  FGroupEditor := TFGroupEditor.Create(Self, cftEditor, m, mtGroupsPK.AsVariant, FMain.OnChildFormClose);
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
  FGroupEditor.edCountColumnChange(FGroupEditor.edCountColumn);
  LoadColumnStyles(FGroupEditor.mtStyleColumns, mtGroupsSTYLE_COLUMNS.AsString);
  FGroupEditor.chbAddVisible.Checked := mtGroupsADD_VISIBLE.AsInteger = 1;
  FGroupEditor.chbIsVisible.Checked := mtGroupsIS_VISIBLE.AsString = '1';
  FGroupEditor.chbCollapsed.Checked := mtGroupsCOLLAPSED.AsInteger = 1;
  FGroupEditor.chbLeftAlign.Checked := mtGroupsLEFT_ALIGN.AsInteger = 1;
  FGroupEditor.edLabelWidth.Value := mtGroupsLABEL_WIDTH.AsInteger;
  FGroupEditor.mStyleExternal.Text := mtGroupsSTYLE_EXTERNAL.AsString;
  FGroupEditor.mStyleInternal.Text := mtGroupsSTYLE_INTERNAL.AsString;
  FGroupEditor.mDescription.Text := mtGroupsDESCRIPTION.AsString;
  FGroupEditor.RegisterForm;
end;

procedure TFEditDict.sbEditObjectClick(Sender: TObject);
var
  FObjectEditor: TFObjectEditor;
  m: TOpenMode;

begin
  // открытие формы редактирования объекта
  if mtObjectTree.IsEmpty then exit;

  if Mode = omView then m := omView
  else m := omEdit;

  if FMain.SetFocusOpenedWindow(mtObjectTreePK.AsInteger, TFObjectEditor.ClassName) then exit;
  FObjectEditor := TFObjectEditor.Create(Self, cftEditor, m, mtObjectTreePK.AsVariant, FMain.OnChildFormClose);
  FObjectEditor.OnClose := OnObjectEditorClose;
  FObjectEditor.lcbName.ReadOnly := true;
  FObjectEditor.lcbName.Color := clBtnFace;
  FObjectEditor.lcbName.TabStop := false;
  if mtObjectTreeOBJECT_TYPE.AsString = 'PROC' then
  begin
    FObjectEditor.sbAddPk.Enabled := false;
    FObjectEditor.sbDelPk.Enabled := false;
    FObjectEditor.dbgPrimaryKey.Enabled := false;
  end else
  begin
    FObjectEditor.dbgInputParams.Enabled := false;
  end;
  FObjectEditor.EditingRec := mtObjectTree.GetBookmark;
  FObjectEditor.Caption := 'Редактирование объекта БД';

  ConnectionsList.SetSQLToDataSet(FObjectEditor.dsDbObjects, cbDictBaseDescriptor.Text, qtProcedures);
  Screen.Cursor := crSQLWait;
  try
    FObjectEditor.dsDbObjects.Open;
  finally
    Screen.Cursor := crDefault;
  end;
  FObjectEditor.dsJoinParent.Close;
  FObjectEditor.dsJoinParent.ParamByName('FORM_PK').Value := dsDictMAIN_FORM_PK.Value;
  FObjectEditor.dsJoinParent.ParamByName('PARENT_PK').Value := lcbParentDict.KeyValue;
  FObjectEditor.dsJoinParent.Open;
  ConnectionsList.SetSQLToDataSet(FObjectEditor.dsChildFields, cbDictBaseDescriptor.Text, qtFields);
  Screen.Cursor := crSQLWait;
  try
    FObjectEditor.dsChildFields.ParamByName('NAME').Value := mtObjectTreeNAME.AsString;
    FObjectEditor.dsChildFields.Open;
    ConnectionsList.SetSQLToDataSet(FObjectEditor.dsMainFields, cbDictBaseDescriptor.Text, qtFields);
    FObjectEditor.dsMainFields.ParamByName('NAME').Value := mtObjectTreeJOIN_PARENT.AsString;
    FObjectEditor.dsMainFields.Open;
  finally
    Screen.Cursor := crDefault;
  end;
  ConnectionsList.SetSQLToDataSet(FObjectEditor.dsPkFields, cbDictBaseDescriptor.Text, qtPrimaryKeys);
  ConnectionsList.SetSQLToDataSet(FObjectEditor.dsProcParams, cbDictBaseDescriptor.Text, qtProcParams);

  FObjectEditor.edPk.Text := mtObjectTreePK.AsString;
  FObjectEditor.lcbName.KeyValue := mtObjectTreeNAME.AsString;
  FObjectEditor.lcbNameChange(FObjectEditor.lcbName);
  FObjectEditor.edTitle.Text := mtObjectTreeTITLE.AsString;
  FObjectEditor.chbDeleted.Checked := mtObjectTreeDELETED.AsInteger = 1;
  FObjectEditor.lcbJoinParent.KeyValue := mtObjectTreeJOIN_PARENT_PK.AsInteger;
  FObjectEditor.lcbJoinParentChange(FObjectEditor.lcbJoinParent);
  FObjectEditor.chbIsMultiJoin.Checked := mtObjectTreeIS_MULTI_JOIN.AsString = '1';
  FObjectEditor.chbInnerJoin.Checked := mtObjectTreeINNER_JOIN.AsInteger = 1;
  LoadJoinFields(FObjectEditor.mtJoinFields, mtObjectTreeJOIN_FIELDS.AsString);
  LoadPrimaryKeys(FObjectEditor.mtPrimaryKey, mtObjectTreePARAMETERS.AsString);
  LoadInputParams(FObjectEditor.mtInputParams, mtObjectTreePARAMETERS.AsString, false);

  //FObjectEditor.Show; - это у mdi child происходит сразу при создании
  FObjectEditor.RegisterForm;
end;

procedure TFEditDict.sbEditRankTemplateClick(Sender: TObject);
var
  CForm: TFTmplConstructor;
  bm: TBookmark;

begin
  if (dbgPermRanks.SelectedField.FieldName = 'ADD_') or (dbgPermRanks.SelectedField.FieldName = 'EDIT_') or
    (dbgPermRanks.SelectedField.FieldName = 'DEL_') or (dbgPermRanks.SelectedField.FieldName = 'VIEW_REF') or
    (dbgPermRanks.SelectedField.FieldName = 'VIEW_') or (dbgPermRanks.SelectedField.FieldName = 'GRID_SAVE') then
  begin
    CForm := TFTmplConstructor.Create(self);
    try
      bm := mtFormFields.GetBookmark;
      if dbgPermRanks.SelectedField.FieldName = 'VIEW_REF' then
      begin
        if CForm.Execute(mtFormFields, ttStandart, mRankTemplate.Text) then
          mRankTemplate.Text := CForm.Template;
      end else
        Application.MessageBox('Этот тип шаблона представляет собой выражение питона, возвращающее тип bool. Для него невозможно использовать конструктор.',
          'Сообщение', MB_OK + MB_ICONINFORMATION);
    finally
      if mtFormFields.BookmarkValid(bm) then
      begin
        mtFormFields.GotoBookmark(bm);
        mtFormFields.FreeBookmark(bm);
      end;
      CForm.Free;
    end;
  end;
end;

procedure TFEditDict.sbEditRoleTemplateClick(Sender: TObject);
var
  CForm: TFTmplConstructor;
  bm: TBookmark;

begin
  if (dbgPermRoles.SelectedField.FieldName = 'ADD_') or (dbgPermRoles.SelectedField.FieldName = 'EDIT_') or
    (dbgPermRoles.SelectedField.FieldName = 'DEL_') or (dbgPermRoles.SelectedField.FieldName = 'VIEW_REF') or
    (dbgPermRoles.SelectedField.FieldName = 'VIEW_') or (dbgPermRoles.SelectedField.FieldName = 'GRID_SAVE') then
  begin
    CForm := TFTmplConstructor.Create(self);
    try
      bm := mtFormFields.GetBookmark;
      if dbgPermRoles.SelectedField.FieldName = 'VIEW_REF' then
      begin
        if CForm.Execute(mtFormFields, ttStandart, mRoleTemplate.Text) then
          mRoleTemplate.Text := CForm.Template;
      end else
        Application.MessageBox('Этот тип шаблона представляет собой выражение питона, возвращающее тип Boolean - пиши что хочешь!',
          'Сообщение', MB_OK + MB_ICONINFORMATION);
    finally
      if mtFormFields.BookmarkValid(bm) then
      begin
        mtFormFields.GotoBookmark(bm);
        mtFormFields.FreeBookmark(bm);
      end;
      CForm.Free;
    end;
  end;
end;

procedure TFEditDict.sbEditWizardClick(Sender: TObject);
var
  d: TNodeDictInfo;

begin
  if Mode = omAdd then exit;
  if (not dsWizard.Active) or dsWizard.IsEmpty then exit;

  d := AssignNodeData(cotWizard);
  try
    d.PK := dsWizardPK.AsVariant;
    d.Descriptor := dsWizardDESCRIPTOR_.AsVariant;
    d.Title := dsWizardNAME.AsVariant;
    d.ParentDictPK := dsWizardREF_PK.AsVariant;
    d.Login := Properties.Login;

    case Mode of
      omEdit: FMain.EditWizard(d);
      omView: FMain.ViewWizard(d);
    end;
  finally
    d.Free;
  end;
end;

procedure TFEditDict.sbGrEditPermRankClick(Sender: TObject);
begin
  GroupEdit(dbgPermRanks);
end;

procedure TFEditDict.sbGrEditPermRoleClick(Sender: TObject);
begin
  GroupEdit(dbgPermRoles);
end;

procedure TFEditDict.sbReCreateChildTableFieldsClick(Sender: TObject);
begin
  if Application.MessageBox('Хотите обновить список полей ChildTable справочника?', 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;
  UpdateChildTableFields;
end;

procedure TFEditDict.sbRefreshWizardListClick(Sender: TObject);
begin
  ReloadWizards;
end;

procedure TFEditDict.sbSaveRankTemplateClick(Sender: TObject);
var
  pk: Variant;
  c: boolean;

begin
  if (dbgPermRanks.SelectedField.FieldName = 'ADD_') or (dbgPermRanks.SelectedField.FieldName = 'EDIT_') or
    (dbgPermRanks.SelectedField.FieldName = 'DEL_') or (dbgPermRanks.SelectedField.FieldName = 'VIEW_REF') or
    (dbgPermRanks.SelectedField.FieldName = 'VIEW_') or (dbgPermRanks.SelectedField.FieldName = 'GRID_SAVE') then
  begin
    c := (dbgPermRanks.SelectedField.FieldName = 'VIEW_REF') or (dbgPermRanks.SelectedField.FieldName = 'VIEW_');
    pk := SaveTemplate(mRankTemplate.Text, dbgPermRanks.SelectedField.Value, Sender = sbSaveRankTemplate, c);
    if pk <> dbgPermRanks.SelectedField.Value then
    begin
      mtPermRanks.Edit;
      dbgPermRanks.SelectedField.Value := pk;
      mtPermRanks.Post;
    end;
    LoadTemplate(mRankTemplate, pk);
  end;
end;

procedure TFEditDict.sbSaveRoleTemplateClick(Sender: TObject);
var
  pk: Variant;
  c: boolean;

begin
  if (dbgPermRoles.SelectedField.FieldName = 'ADD_') or (dbgPermRoles.SelectedField.FieldName = 'EDIT_') or
    (dbgPermRoles.SelectedField.FieldName = 'DEL_') or (dbgPermRoles.SelectedField.FieldName = 'VIEW_REF') or
    (dbgPermRoles.SelectedField.FieldName = 'VIEW_') or (dbgPermRoles.SelectedField.FieldName = 'GRID_SAVE') then
  begin
    c := (dbgPermRanks.SelectedField.FieldName = 'VIEW_REF') or (dbgPermRanks.SelectedField.FieldName = 'VIEW_');
    pk := SaveTemplate(mRoleTemplate.Text, dbgPermRoles.SelectedField.Value, Sender = sbSaveRoleTemplate, c);
    if pk <> dbgPermRoles.SelectedField.Value then
    begin
      mtPermRoles.Edit;
      dbgPermRoles.SelectedField.Value := pk;
      mtPermRoles.Post;
    end;
    LoadTemplate(mRoleTemplate, pk);
  end;
end;

procedure TFEditDict.sbAddAllFieldsClick(Sender: TObject);
begin
  FillFieldsList;
end;

procedure TFEditDict.sbAddChartClick(Sender: TObject);
var
  FChartEditor: TFChartEditor;

begin
  if Mode = omView then exit;
  // открытие формы редактирования графика
  FChartEditor := TFChartEditor.Create(Self, cftEditor, omAdd, Null, FMain.OnChildFormClose);
  FChartEditor.OnClose := OnChartEditorClose;
  FChartEditor.dsoFields.DataSet := dsOrderFields;
  FChartEditor.dsoGroup.DataSet := dsChartGroups;
  FChartEditor.EditingRec := nil;
  FChartEditor.Caption := 'Новый график';
  FChartEditor.RegisterForm;
end;

procedure TFEditDict.sbAddChartGroupClick(Sender: TObject);
var
  FChartGroupEditor: TFChartGroupEditor;

begin
  if Mode = omView then exit;
  // открытие формы редактирования группы графиков
  FChartGroupEditor := TFChartGroupEditor.Create(Self, cftEditor, omAdd, Null, FMain.OnChildFormClose);
  FChartGroupEditor.OnClose := OnChartGroupEditorClose;
  FChartGroupEditor.EditingRec := nil;
  FChartGroupEditor.Caption := 'Новая группа графиков';
  FChartGroupEditor.RegisterForm;
end;

procedure TFEditDict.sbAddEventClick(Sender: TObject);
var
  FEventEditor: TFEventEditor;

begin
  if Mode = omView then exit;
  // открытие формы редактирования кнопки
  FEventEditor := TFEventEditor.Create(Self, cftEditor, omAdd, Null, FMain.OnChildFormClose);
  FEventEditor.OnClose := OnEventEditorClose;
  FEventEditor.dsoEvtDicts.DataSet := dsEvtDicts;
  FEventEditor.dsoEvtWizards.DataSet := dsEvtWizards;
  FEventEditor.dsoEvtForms.DataSet := dsEvtForms;
  FEventEditor.EditingRec := nil;
  FEventEditor.Caption := 'Новая кнопка';
  FEventEditor.edPosition.Value := mtOtherEventsPOSITION_EV.Tag;
  FEventEditor.cbViewToMenu.ItemIndex := 0;
  AutoIncEvtPos;
  FEventEditor.RegisterForm;
end;

procedure TFEditDict.sbAddFieldClick(Sender: TObject);
var
  FFieldEditor: TFFieldEditor;

begin
  if Mode = omView then exit;
  // открытие формы редактирования поля
  AutoIncFields;
  FFieldEditor := TFFieldEditor.Create(Self, cftEditor, omAdd, Null, FMain.OnChildFormClose);
  FFieldEditor.OnClose := OnFieldEditorClose;
  FFieldEditor.dsoGroup.DataSet := dsFieldGroups;
  FFieldEditor.dsoFilterGroup.DataSet := dsLFilterGroups;
  FFieldEditor.BaseDescriptor := cbDictBaseDescriptor.Text;
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
  FFieldEditor.cbFieldName.Items.Text := GetNotInvolvedFields(mtFormFields);
  if FFieldEditor.cbFieldName.Items.Count > 0 then FFieldEditor.cbFieldName.ItemIndex := 0
  else FFieldEditor.cbFieldName.Text := '';
  FFieldEditor.cbFieldNameChange(FFieldEditor.cbFieldName);
  FFieldEditor.cbGroup.KeyValue := Null;
  FFieldEditor.cbGroupChange(FFieldEditor.cbGroup);
  FFieldEditor.edGroupColumn.Value := 0;
  FFieldEditor.edGroupColumnChange(FFieldEditor.edGroupColumn);
  FFieldEditor.edOrder.Value := mtFormFieldsORDER_.Tag;
  FFieldEditor.edGridVisible.Value := 1;
  FFieldEditor.edEditInTable.Value := 0;
  FFieldEditor.edGridOrder.Value := mtFormFieldsGRID_ORDER.Tag;
  FFieldEditor.edGridWidth.Value := Null;
  FFieldEditor.edIsVisible.Value := iif(chbDictEditable.Checked, 1, 0);
  FFieldEditor.edEditable.Value := iif(chbDictEditable.Checked, 1, 0);
  FFieldEditor.edIsVisibleAdd.Value := iif(chbDictEditable.Checked, 1, 0);
  FFieldEditor.edAddEditable.Value := iif(chbDictEditable.Checked, 1, 0);
  FFieldEditor.chbShowInStartForm.Checked := false;
  FFieldEditor.chbShowInGroupEdit.Checked := false;
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

procedure TFEditDict.sbAddFilterConfigClick(Sender: TObject);
var
  FFilterConfigEditor: TFFilterConfigEditor;

begin
  if Mode = omView then exit;
  // открытие формы редактирования конфигурации фильтра
  FFilterConfigEditor := TFFilterConfigEditor.Create(Self, cftEditor, omAdd, Null, FMain.OnChildFormClose);
  FFilterConfigEditor.OnClose := OnFilterConfigEditorClose;
  FFilterConfigEditor.EditingRec := nil;
  FFilterConfigEditor.Caption := 'Новая конфигурация фильтров';
  FFilterConfigEditor.Fields := mtFormFields;
  FFilterConfigEditor.Template := '';
  FFilterConfigEditor.RegisterForm;
end;

procedure TFEditDict.sbAddFilterGroupClick(Sender: TObject);
var
  FFilterGroupEditor: TFFilterGroupEditor;

begin
  if Mode = omView then exit;
  // открытие формы редактирования конфигурации фильтра
  FFilterGroupEditor := TFFilterGroupEditor.Create(Self, cftEditor, omAdd, Null, FMain.OnChildFormClose);
  FFilterGroupEditor.OnClose := OnFilterGroupEditorClose;
  FFilterGroupEditor.EditingRec := nil;
  FFilterGroupEditor.Caption := 'Новая группа фильтров';
  FFilterGroupEditor.edOrder.Value := mtFilterGroupORDER_.Tag;
  AutoIncFilterGroup;
  FFilterGroupEditor.RegisterForm;
end;

procedure TFEditDict.sbAddGroupClick(Sender: TObject);
var
  FGroupEditor: TFGroupEditor;

begin
  if Mode = omView then exit;
  // открытие формы редактирования группы
  AutoIncGroups;
  FGroupEditor := TFGroupEditor.Create(Self, cftEditor, omAdd, Null, FMain.OnChildFormClose);
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

procedure TFEditDict.sbAddObjectClick(Sender: TObject);
var
  FObjectEditor: TFObjectEditor;

begin
  if Mode = omView then exit;
  // открытие формы редактирования объекта
  if (Mode = omAdd) and (not mtObjectTree.IsEmpty) then
    raise Exception.Create('В режиме создания справочника можно добавлять только главный объект БД!');

  FObjectEditor := TFObjectEditor.Create(Self, cftEditor, omAdd, Null, FMain.OnChildFormClose);
  FObjectEditor.OnClose := OnObjectEditorClose;
  FObjectEditor.EditingRec := nil;
  FObjectEditor.Caption := 'Новый объект БД';
  FObjectEditor.dbgInputParams.Enabled := false;
  FObjectEditor.sbAddPk.Enabled := false;
  FObjectEditor.sbDelPk.Enabled := false;
  FObjectEditor.dbgPrimaryKey.Enabled := false;

  ConnectionsList.SetSQLToDataSet(FObjectEditor.dsDbObjects, cbDictBaseDescriptor.Text, qtProcedures);
  Screen.Cursor := crSQLWait;
  try
    FObjectEditor.dsDbObjects.Open;
  finally
    Screen.Cursor := crDefault;
  end;
  FObjectEditor.dsJoinParent.Close;
  FObjectEditor.dsJoinParent.ParamByName('FORM_PK').Value := dsDictMAIN_FORM_PK.Value;
  FObjectEditor.dsJoinParent.ParamByName('PARENT_PK').Value := lcbParentDict.KeyValue;
  FObjectEditor.dsJoinParent.Open;
  ConnectionsList.SetSQLToDataSet(FObjectEditor.dsChildFields, cbDictBaseDescriptor.Text, qtFields);
  Screen.Cursor := crSQLWait;
  try
    FObjectEditor.dsChildFields.ParamByName('NAME').Value := mtObjectTreeNAME.AsString;
    FObjectEditor.dsChildFields.Open;
    ConnectionsList.SetSQLToDataSet(FObjectEditor.dsMainFields, cbDictBaseDescriptor.Text, qtFields);
    FObjectEditor.dsMainFields.ParamByName('NAME').Value := mtObjectTreeJOIN_PARENT.AsString;
    FObjectEditor.dsMainFields.Open;
  finally
    Screen.Cursor := crDefault;
  end;
  ConnectionsList.SetSQLToDataSet(FObjectEditor.dsPkFields, cbDictBaseDescriptor.Text, qtPrimaryKeys);
  ConnectionsList.SetSQLToDataSet(FObjectEditor.dsProcParams, cbDictBaseDescriptor.Text, qtProcParams);

  FObjectEditor.lcbNameChange(FObjectEditor.lcbName);
  FObjectEditor.chbDeleted.Checked := false;
  FObjectEditor.lcbJoinParent.KeyValue := MainObjPk;
  FObjectEditor.lcbJoinParentChange(FObjectEditor.lcbJoinParent);
  FObjectEditor.chbIsMultiJoin.Checked := (not VarIsNull(lcbParentDict.KeyValue)) and mtObjectTree.IsEmpty;
  FObjectEditor.chbInnerJoin.Checked := false;
  LoadJoinFields(FObjectEditor.mtJoinFields, '');
  LoadPrimaryKeys(FObjectEditor.mtPrimaryKey, '');
  LoadInputParams(FObjectEditor.mtInputParams, '');

  //FObjectEditor.Show; - это у mdi child происходит сразу при создании
  FObjectEditor.RegisterForm;
end;

procedure TFEditDict.sbAddPermRankClick(Sender: TObject);
var
  fSelRank: TFSelectRank;

begin
  if Mode = omView then exit;

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
    dbgPermRanks.SetFocus;
  end;
end;

procedure TFEditDict.sbAddPermRoleClick(Sender: TObject);
begin
  if Mode <> omView then
  begin
    mtPermRoles.Append;
    dbgPermRoles.SetFocus;
  end;
end;

procedure TFEditDict.sbAddPostFilterClick(Sender: TObject);
var
  fSelRank: TFSelectRank;

begin
  if Mode = omView then exit;

  if mtFilterConfigPK.IsNull then
  begin
    Application.MessageBox('Прежде, чем привязывать конфигурацию фильтров к должностям, надо сохранить ее в БД!', 'Предупреждение', MB_OK + MB_ICONWARNING);
    exit;
  end;

  fSelRank := TFSelectRank.Create(Self);
  try
    if fSelRank.ShowModal = mrOk then
    begin
      if not fSelRank.mtSelectedRanks.Active then exit;
      fSelRank.mtSelectedRanks.First;

      while not fSelRank.mtSelectedRanks.Eof do
      begin
        mtPostFilter.Append;
        mtPostFilterPOST_PK.AsInteger := fSelRank.mtSelectedRanksPK.AsInteger;
        mtPostFilterPOST_NAME.AsString := fSelRank.mtSelectedRanksNAME.AsString;
        mtPostFilterFILTER_CONFIG_PK.AsInteger := mtFilterConfigPK.AsInteger;
        mtPostFilter.Post;
        fSelRank.mtSelectedRanks.Next;
      end;
    end;
  finally
    fSelRank.Free;
    dbgPostFilter.SetFocus;
  end;
end;

procedure TFEditDict.sbAddSortClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if mtDictOrderBy.State in [dsEdit, dsInsert] then exit;
  mtDictOrderBy.Append;
  dbgDictOrderBy.SetFocus;
end;

procedure TFEditDict.sbAddWizardClick(Sender: TObject);
var
  fWiz: TFEditWizard;

begin
  if Mode <> omEdit then exit;
  fWiz := TFEditWizard(FMain.CreateWizard);
  if Assigned(fWiz) then fWiz.lcbDict.KeyValue := Properties.PK;
end;

procedure TFEditDict.sbCopyPermRanksClick(Sender: TObject);
begin
  CopyPermissions(Sender = sbCopyPermRanks);
end;

procedure TFEditDict.SetProperties(Value: TNodeDictInfo);
begin
  inherited SetProperties(Value);

  if Mode = omAdd then
  begin
    // справочник
    OldParentRefPk := Null;
    chbDictExpandTree.Checked := false;
    cbDictConOrient.ItemIndex := 0;
    cbDictShowFilterBound.ItemIndex := 0;
    chbDictCollapseFilter.Checked := false;
    chbDictEditable.Checked := true;
    chbDictExpandRef.Checked := false;
    chbDictShowOnlyAdmin.Checked := false;
    chbDictSetDistinct.Checked := false;
    chbDictDeferredImports.Checked := false;
    chbDictUseMem.Checked := false;
    chbDictSkipDuplicates.Checked := false;
    chbCheckSelect.Checked := false;
    cbDictBaseDescriptor.ItemIndex := cbDictBaseDescriptor.Items.IndexOf(DBDESC_FB);
  end else
  begin
    // справочник
    dsDict.Close;
    dsDict.ParamByName('PK').Value := Properties.PK;
    dsDict.Open;
    if dsDict.IsEmpty then
      raise Exception.Create('Не найден справочник с PK ' + VarToStr(Properties.PK) + ' (дескриптор ' + VarToStr(Properties.Descriptor) +
        ')! Возможно он был пересоздан и его PK поменялся.');        
    Properties.Guid := dsDictGUID.AsVariant;
    edDictPk.Text := VarToStr(Properties.PK);
    OldParentRefPk := dsDict.FieldByName('PARENT_REFERENCE_PK').Value;
    edDictDescriptor.Text := VarToStr(Properties.Descriptor);
    edDictTitle.Text := VarToStr(Properties.Title);
    Caption := GenCaption('Справочник', iif(Mode = omEdit, 'редактирование', 'просмотр'), edDictPk.Text, edDictDescriptor.Text,
      edDictTitle.Text, FSettings.TreeShowDescriptor);
    chbDictExpandTree.Checked := dsDictEXPAND_TREE.AsInteger = 1;
    cbDictConOrient.ItemIndex := dsDictCON_ORIENT.AsInteger;
    edDictRefSize.Value := dsDict.FieldByName('REF_SIZE').Value;
    edDictCountOnPage.Value := dsDict.FieldByName('COUNT_ON_PAGE').Value;
    edDictAutosaveInterval.Value := dsDict.FieldByName('AUTOSAVEINTERVAL').Value;
    cbDictShowFilterBound.ItemIndex := iif(dsDictSHOW_FILTER_BOUND.IsNull, 0, cbDictShowFilterBound.Items.IndexOf(dsDictSHOW_FILTER_BOUND.AsString));
    chbDictCollapseFilter.Checked := dsDictCOLLAPSE_FILTER.AsString = '1';
    chbDictEditable.Checked := dsDictEDITABLE.AsInteger = 1;
    chbDictExpandRef.Checked := dsDictEXPAND_REF.AsString = '1';
    chbDictShowOnlyAdmin.Checked := dsDictSHOW_ONLY_ADMIN.AsInteger = 1;
    chbDictSetDistinct.Checked := dsDictSET_DISTINCT.AsString = '1';
    chbDictDeferredImports.Checked := dsDictDEFERRED_IMPORTS.AsInteger = 1;
    chbDictUseMem.Checked := dsDictUSE_MEM.AsInteger = 1;
    chbDictSkipDuplicates.Checked := dsDictSKIP_DUPLICATES.AsString = '1';
    chbCheckSelect.Checked := dsDictCHECK_SELECT.AsInteger = 1;
    if dsDictBASE_DESCRIPTOR.AsString = '' then
    begin
      cbDictBaseDescriptor.ItemIndex := cbDictBaseDescriptor.Items.IndexOf(DBDESC_FB);
      Application.MessageBox(pchar('Обратите внимание, что у справочника не задан дескриптор БД! Установлена БД по умолчанию: ' + DBDESC_FB),
        'Предупреждение', MB_OK + MB_ICONWARNING);
    end else
      cbDictBaseDescriptor.ItemIndex := cbDictBaseDescriptor.Items.IndexOf(dsDictBASE_DESCRIPTOR.AsString);
    if cbDictBaseDescriptor.ItemIndex = -1 then
      raise Exception.Create('Не привязано подключение для дескриптора БД "' + dsDictBASE_DESCRIPTOR.AsString + '"!');

    // форма
    dsForm.Close;
    dsForm.ParamByName('PK').Value := dsDictMAIN_FORM_PK.AsInteger;
    dsForm.Open;
    edFormPk.Text := dsDictMAIN_FORM_PK.AsString;
    edFormAlias.Text := dsFormALIAS_FORM.AsString;
    edFormTitle.Text := dsFormTITLE.AsString;
    edFormWidth.Value := dsFormWIDTH.Value;
    edFormHeight.Value := dsFormHEIGHT.Value;
    chbLeftAlign.Checked := dsFormLEFT_ALIGN.Value = 1;
    edLabelWidth.Value := dsFormLABEL_WIDTH.Value;
    // стартовая форма
    dsStartForm.Close;
    dsStartForm.ParamByName('PK').Value := dsDictSTART_FORM_PK.AsInteger;
    dsStartForm.Open;
    // форма группового редактирования
    dsGrEditForm.Close;
    dsGrEditForm.ParamByName('PK').Value := dsDictGROUP_EDIT_FORM_PK.AsInteger;
    dsGrEditForm.Open;
    // сценарии
    dsWizard.Close;
    dsWizard.ParamByName('REF_PK').Value := Properties.PK;
    dsWizard.Open;
  end;
  LoadLookups;
  LoadObjectTree;
  LoadFormFields;
  LoadFormGroups;
  LoadPermRoles;
  LoadPermRanks;
  LoadChartGroups;
  LoadCharts;
  LoadOtherEvents;
  LoadFilterConfigs;
  LoadPostFilters;
  LoadOrders;
  LoadFilterGroups;
  ChangeBaseDescriptor;

  if (not dsDictSTART_FORM_PK.IsNull) and (dsDictSTART_FORM_PK.AsInteger <> -1) then
  begin
    lbStartFormInfo.Caption := '';
    btnCreateStartForm.Enabled := false;
    if Mode <> omView then btnDelStartForm.Enabled := true;
    PrepareStartForm;
  end else
  begin
    AutoCreateStartForm;
    if Assigned(StartForm) then
    begin
      lbStartFormInfo.Caption := '';
      btnCreateStartForm.Enabled := false;
      if Mode <> omView then btnDelStartForm.Enabled := true;
    end else
    begin
      if Mode <> omView then btnCreateStartForm.Enabled := true;
      btnDelStartForm.Enabled := false;
      if dsDictSTART_FORM_PK.AsInteger = -1 then lbStartFormInfo.Caption := 'Привязана стандартная стартовая форма'
      else lbStartFormInfo.Caption := 'Стартовая форма отсутствует';
    end;
  end;

  if not dsDictGROUP_EDIT_FORM_PK.IsNull then
  begin
    lbGrEditFormInfo.Caption := '';
    btnCreateGrEditForm.Enabled := false;
    if Mode <> omView then btnDelGrEditForm.Enabled := true;
    CreateGrEditForm;
  end else
  begin
    if Assigned(GrEditForm) then
    begin
      lbGrEditFormInfo.Caption := '';
      btnCreateGrEditForm.Enabled := false;
      if Mode <> omView then btnDelGrEditForm.Enabled := true;
    end else
    begin
      if Mode <> omView then btnCreateGrEditForm.Enabled := true;
      btnDelGrEditForm.Enabled := false;
      lbGrEditFormInfo.Caption := 'Форма группового редактирования отсутствует';
    end;
  end;
end;

procedure TFEditDict.SetFrameGridOptions(Options: TGridParams);
begin
  if Assigned(StartForm) then StartForm.SetGridsOptions(Options);
  if Assigned(GrEditForm) then GrEditForm.SetGridsOptions(Options);
end;

procedure TFEditDict.SetMode(Value: TOpenMode);
var
  i: integer;

begin
  inherited SetMode(Value);
  
  case FMode of
    omAdd:
    begin
      btnSave.Enabled := true;
      tbSave.Enabled := true;
      tbGenSQL.Enabled := false;
      tbGenDictWizardsSQL.Enabled := false;
      tbLink.Enabled := false;
      btnRecalcTree.Enabled := false;
      tbFix.Enabled := false;
      btnRefresh.Enabled := false;
      tbRefresh.Enabled := false;
      tbBuildSelect.Enabled := false;
      Caption := 'Новый справочник';
      for i := 1 to pcMain.PageCount - 1 do pcMain.Pages[i].TabVisible := false;
      // справочник
      edDictDescriptor.ReadOnly := false;
      edDictDescriptor.Color := clWindow;
      edDictTitle.ReadOnly := false;
      edDictTitle.Color := clWindow;
      lcbParentDict.ReadOnly := false;
      lcbParentDict.Color := clWindow;
      lcbFolder.ReadOnly := false;
      lcbFolder.Color := clWindow;
      cbDictBaseDescriptor.Enabled := true;
      sbAddObject.Enabled := true;
      sbEditObject.Enabled := true;
      sbDelObject.Enabled := true;
      sbReCreateChildTableFields.Enabled := false;
      dbgObjectTree.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      sbAddSort.Enabled := false;
      sbDelSort.Enabled := false;
      dbgDictOrderBy.AllowedOperations := [];
      lcbDictIdField.ReadOnly := true;
      lcbDictIdField.Color := clBtnFace;
      lcbDictParentIdField.ReadOnly := true;
      lcbDictParentIdField.Color := clBtnFace;
      chbDictExpandTree.Enabled := true;
      lcbDictGrouping.ReadOnly := true;
      lcbDictGrouping.Color := clBtnFace;
      cbDictConOrient.Enabled := true;
      edDictRefSize.ReadOnly := false;
      edDictRefSize.Color := clWindow;
      lcbDictDocument.ReadOnly := false;
      lcbDictDocument.Color := clWindow;
      edDictCountOnPage.ReadOnly := false;
      edDictCountOnPage.Color := clWindow;
      edDictAutosaveInterval.ReadOnly := false;
      edDictAutosaveInterval.Color := clWindow;
      cbDictShowFilterBound.Enabled := true;
      chbDictCollapseFilter.Enabled := true;
      chbDictEditable.Enabled := true;
      chbDictExpandRef.Enabled := true;
      chbDictShowOnlyAdmin.Enabled := true;
      chbDictShowOnlyAdmin.Enabled := true;
      chbDictSetDistinct.Enabled := true;
      chbDictDeferredImports.Enabled := true;
      chbDictUseMem.Enabled := true;
      chbDictSkipDuplicates.Enabled := true;
      chbCheckSelect.Enabled := true;
    end;
    omEdit:
    begin
      btnSave.Enabled := true;
      tbSave.Enabled := true;
      tbGenSQL.Enabled := true;
      tbGenDictWizardsSQL.Enabled := true;
      tbLink.Enabled := true;
      btnRecalcTree.Enabled := true;
      tbFix.Enabled := true;
      btnRefresh.Enabled := true;
      tbRefresh.Enabled := true;
      tbBuildSelect.Enabled := true;
      Caption := 'Редактирование справочника';
      for i := 1 to pcMain.PageCount - 1 do pcMain.Pages[i].TabVisible := true;
      // справочник
      edDictDescriptor.ReadOnly := false;
      edDictDescriptor.Color := clWindow;
      edDictTitle.ReadOnly := false;
      edDictTitle.Color := clWindow;
      lcbParentDict.ReadOnly := false;
      lcbParentDict.Color := clWindow;
      lcbFolder.ReadOnly := false;
      lcbFolder.Color := clWindow;
      cbDictBaseDescriptor.Enabled := true;
      sbAddObject.Enabled := true;
      sbEditObject.Enabled := true;
      sbDelObject.Enabled := true;
      sbReCreateChildTableFields.Enabled := true;
      dbgObjectTree.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      sbAddSort.Enabled := true;
      sbDelSort.Enabled := true;
      dbgDictOrderBy.AllowedOperations := [alopUpdateEh, alopDeleteEh, alopInsertEh, alopAppendEh];
      lcbDictIdField.ReadOnly := false;
      lcbDictIdField.Color := clWindow;
      lcbDictParentIdField.ReadOnly := false;
      lcbDictParentIdField.Color := clWindow;
      chbDictExpandTree.Enabled := true;
      lcbDictGrouping.ReadOnly := false;
      lcbDictGrouping.Color := clWindow;
      cbDictConOrient.Enabled := true;
      edDictRefSize.ReadOnly := false;
      edDictRefSize.Color := clWindow;
      lcbDictDocument.ReadOnly := false;
      lcbDictDocument.Color := clWindow;
      edDictCountOnPage.ReadOnly := false;
      edDictCountOnPage.Color := clWindow;
      edDictAutosaveInterval.ReadOnly := false;
      edDictAutosaveInterval.Color := clWindow;
      cbDictShowFilterBound.Enabled := true;
      chbDictCollapseFilter.Enabled := true;
      chbDictEditable.Enabled := true;
      chbDictExpandRef.Enabled := true;
      chbDictShowOnlyAdmin.Enabled := true;
      chbDictShowOnlyAdmin.Enabled := true;
      chbDictSetDistinct.Enabled := true;
      chbDictDeferredImports.Enabled := true;
      chbDictUseMem.Enabled := true;
      chbDictSkipDuplicates.Enabled := true;
      chbCheckSelect.Enabled := true;
      // форма
      edFormWidth.ReadOnly := false;
      edFormWidth.Color := clWindow;
      edFormHeight.ReadOnly := false;
      edFormHeight.Color := clWindow;
      dbgFormFields.AllowedOperations := [alopUpdateEh, alopDeleteEh];
      sbAddField.Enabled := true;
      sbAddAllFields.Enabled := true;
      sbEditField.Enabled := true;
      sbDelField.Enabled := true;
      dbgGroups.AllowedOperations := [alopDeleteEh, alopUpdateEh];
      sbAddGroup.Enabled := true;
      sbEditGroup.Enabled := true;
      sbDelGroup.Enabled := true;
      chbLeftAlign.Enabled := true;
      edLabelWidth.ReadOnly := false;
      edLabelWidth.Color := clWindow;
    end;
    omView:
    begin
      btnSave.Enabled := false;
      tbSave.Enabled := false;
      tbGenSQL.Enabled := true;
      tbGenDictWizardsSQL.Enabled := true;
      tbLink.Enabled := true;
      btnRecalcTree.Enabled := false;
      tbFix.Enabled := false;
      btnRefresh.Enabled := true;
      tbRefresh.Enabled := true;
      tbBuildSelect.Enabled := true;
      Caption := 'Свойства справочника';
      for i := 1 to pcMain.PageCount - 1 do pcMain.Pages[i].TabVisible := true;
      // справочник
      edDictDescriptor.ReadOnly := true;
      edDictDescriptor.Color := clBtnFace;
      edDictTitle.ReadOnly := true;
      edDictTitle.Color := clBtnFace;
      lcbParentDict.ReadOnly := true;
      lcbParentDict.Color := clBtnFace;
      lcbFolder.ReadOnly := true;
      lcbFolder.Color := clBtnFace;
      cbDictBaseDescriptor.Enabled := false;
      sbAddObject.Enabled := false;
      sbEditObject.Enabled := false;
      sbDelObject.Enabled := false;
      sbReCreateChildTableFields.Enabled := false;
      dbgObjectTree.AllowedOperations := [];
      sbAddSort.Enabled := false;
      sbDelSort.Enabled := false;
      dbgDictOrderBy.AllowedOperations := [];
      lcbDictIdField.ReadOnly := true;
      lcbDictIdField.Color := clBtnFace;
      lcbDictParentIdField.ReadOnly := true;
      lcbDictParentIdField.Color := clBtnFace;
      chbDictExpandTree.Enabled := false;
      lcbDictGrouping.ReadOnly := true;
      lcbDictGrouping.Color := clBtnFace;
      cbDictConOrient.Enabled := false;
      edDictRefSize.ReadOnly := true;
      edDictRefSize.Color := clBtnFace;
      lcbDictDocument.ReadOnly := true;
      lcbDictDocument.Color := clBtnFace;
      edDictCountOnPage.ReadOnly := true;
      edDictCountOnPage.Color := clBtnFace;
      edDictAutosaveInterval.ReadOnly := true;
      edDictAutosaveInterval.Color := clBtnFace;
      cbDictShowFilterBound.Enabled := false;
      chbDictCollapseFilter.Enabled := false;
      chbDictEditable.Enabled := false;
      chbDictExpandRef.Enabled := false;
      chbDictShowOnlyAdmin.Enabled := false;
      chbDictShowOnlyAdmin.Enabled := false;
      chbDictSetDistinct.Enabled := false;
      chbDictDeferredImports.Enabled := false;
      chbDictUseMem.Enabled := false;
      chbDictSkipDuplicates.Enabled := false;
      chbCheckSelect.Enabled := false;
      // форма
      edFormAlias.ReadOnly := true;
      edFormAlias.Color := clBtnFace;
      edFormTitle.ReadOnly := true;
      edFormTitle.Color := clBtnFace;
      edFormWidth.ReadOnly := true;
      edFormWidth.Color := clBtnFace;
      edFormHeight.ReadOnly := true;
      edFormHeight.Color := clBtnFace;
      dbgFormFields.AllowedOperations := [];
      sbAddField.Enabled := false;
      sbAddAllFields.Enabled := false;
      sbEditField.Enabled := false;
      sbDelField.Enabled := false;
      dbgGroups.AllowedOperations := [];
      sbAddGroup.Enabled := false;
      sbEditGroup.Enabled := false;
      sbDelGroup.Enabled := false;
      btnCreateStartForm.Enabled := false;
      btnCreateGrEditForm.Enabled := false;
      btnDelStartForm.Enabled := false;
      btnDelGrEditForm.Enabled := false;
      chbLeftAlign.Enabled := false;
      edLabelWidth.ReadOnly := true;
      edLabelWidth.Color := clBtnFace;
      // права ролей
      dbgPermRoles.AllowedOperations := [];
      sbSaveRoleTemplate.Enabled := false;
      sbUpdateRoleTemplate.Enabled := false;
      sbEditRoleTemplate.Enabled := false;
      mRoleTemplate.Enabled := false;
      sbAddPermRole.Enabled := false;
      sbGrEditPermRole.Enabled := false;
      sbDelPermRole.Enabled := false;
      sbCopyPermRoles.Enabled := false;
      // права должностей
      dbgPermRanks.AllowedOperations := [];
      sbSaveRankTemplate.Enabled := false;
      sbUpdateRankTemplate.Enabled := false;
      sbEditRankTemplate.Enabled := false;
      mRankTemplate.Enabled := false;
      sbAddPermRank.Enabled := false;
      sbGrEditPermRank.Enabled := false;
      sbDelPermRank.Enabled := false;
      sbCopyPermRanks.Enabled := false;
      // конфигурации фильтров
      dbgFilterConfig.AllowedOperations := [];
      sbAddFilterConfig.Enabled := false;
      sbEditFilterConfig.Enabled := false;
      sbDelFilterConfig.Enabled := false;
      // привязки конфигураций фильтров к должностям
      dbgPostFilter.AllowedOperations := [];
      sbAddPostFilter.Enabled := false;
      sbDelPostFilter.Enabled := false;
      // группы фильтров
      dbgFilterGroup.AllowedOperations := [];
      sbAddFilterGroup.Enabled := false;
      sbEditFilterGroup.Enabled := false;
      sbDelFilterGroup.Enabled := false;
      // графики
      dbgChart.AllowedOperations := [];
      sbAddChart.Enabled := false;
      sbEditChart.Enabled := false;
      sbDelChart.Enabled := false;
      // группы графиков
      dbgChartGroup.AllowedOperations := [];
      sbAddChartGroup.Enabled := false;
      sbEditChartGroup.Enabled := false;
      sbDelChartGroup.Enabled := false;
      // сценарии
      sbAddWizard.Enabled := false;
      sbEditWizard.Enabled := false;
      sbDelWizard.Enabled := false;
      sbRefreshWizardList.Enabled := false;
      // кнопки справочника
      dbgOtherEvents.AllowedOperations := [];
      sbAddEvent.Enabled := false;
      sbEditEvent.Enabled := false;
      sbDelEvent.Enabled := false;
    end;
  end;

  tsDummy.TabVisible := false; // скрытая вкладка для временного расположения скрытых контролов
end;

procedure TFEditDict.SetSystemFieldsSQL(DataSet: TUniQuery; BaseDescriptor: string; AddInputParams: boolean);
const
  FbFieldsSQL = 'select TABLE_NAME, FIELD_NAME, (trim(TABLE_NAME) || ''.'' || trim(FIELD_NAME)) FULLNAME from ( ' +
    'select RDB$RELATION_NAME TABLE_NAME, RDB$FIELD_NAME FIELD_NAME, RDB$FIELD_POSITION NUM from RDB$RELATION_FIELDS ' +
    'where RDB$RELATION_NAME in (%s) and RDB$SYSTEM_FLAG = 0 ' +
    'union all ' +
    'select RDB$PROCEDURE_NAME TABLE_NAME, RDB$PARAMETER_NAME FIELD_NAME, RDB$PARAMETER_NUMBER NUM from RDB$PROCEDURE_PARAMETERS ' +
    'where RDB$PROCEDURE_NAME in (%s) and RDB$SYSTEM_FLAG = 0 %s) ' +
    'order by TABLE_NAME, NUM';

  OraFieldsSQL = 'select distinct (OWNER || ''.'' || TABLE_NAME) TABLE_NAME, COLUMN_NAME FIELD_NAME, ' +
    '(OWNER || ''.'' || TABLE_NAME || ''.'' || COLUMN_NAME) FULLNAME ' +
    'from ALL_TAB_COLUMNS where upper(OWNER) || ''.'' || upper(TABLE_NAME) in (%s) order by TABLE_NAME, COLUMN_NAME';

  PgFieldsSQL = 'select (table_schema || ''.'' || table_name)::varchar table_name, column_name::varchar FIELD_NAME, ' +
    '(table_schema || ''.'' || table_name || ''.'' || column_name)::varchar FULLNAME, ordinal_position from information_schema.columns ' +
    'where lower(table_schema || ''.'' || table_name) in (%s) order by table_schema, table_name, ordinal_position';

var
  s, sql{, own}: string;
  con: TConnection;

begin
  if not Assigned(DataSet) then exit;
  DataSet.Close;
  s := GetObjectNames;
  if s = '' then s := 'null';
  con := FSettings.ConnByDbDescr[BaseDescriptor];

  DataSet.Connection := ConnectionsList.InitConnection(BaseDescriptor);
  DataSet.SpecificOptions.Values[DataSet.Connection.ProviderName + '.FetchAll'] := 'True';
  if con.Server = stPostgreSQL then
    DataSet.SpecificOptions.Values[DataSet.Connection.ProviderName + '.UnknownAsString'] := 'True';

  case con.Server of
    stFirebird:
    begin
      sql := Format(FbFieldsSQL, [UpperCase(s), UpperCase(s), '%s']);
      if AddInputParams then sql := Format(sql, [''])
      else sql := Format(sql, ['and RDB$PARAMETER_TYPE = 1']);
      DataSet.SQL.Text := sql;
    end;
    stOracle:
    begin
      {own := DataSet.Connection.SpecificOptions.Values[DataSet.Connection.ProviderName + '.Schema'];
      if own = '' then own := DataSet.Connection.Username;}
      DataSet.SQL.Text := Format(OraFieldsSQL, [UpperCase(s){, own}]);
    end;
    stPostgreSQL: DataSet.SQL.Text := Format(PgFieldsSQL, [LowerCase(s)]);
  end;
end;

procedure TFEditDict.StdMemTableBeforePost(DataSet: TDataSet);
begin
  if not IsLoadingGrid then
  begin
    DataSet.FieldByName('CHANGED').AsBoolean := true;
    if Assigned(DataSet.FindField('GUID')) and DataSet.FieldByName('GUID').IsNull then
      DataSet.FieldByName('GUID').AsString := CreateGuid;
  end;
end;

procedure TFEditDict.tbBuildSelectClick(Sender: TObject);
var
  s: string;

begin
  s := BuildSelectSQL;
  if s <> '' then
  begin
    CopyToClipboard(s);
    Application.MessageBox('Select-запрос скопирован в буфер обмена!', 'Сообщение', MB_OK + MB_ICONINFORMATION);
  end;
end;

procedure TFEditDict.tbFixClick(Sender: TObject);
begin
  if Mode = omEdit then PrepareFix;
end;

procedure TFEditDict.tbGenDictWizardsSQLClick(Sender: TObject);
begin
  FMain.SetSaveDialogToSQL;
  if FMain.SaveDialog.Execute then FMain.SaveToSQL(Properties, FMain.SaveDialog.FileName, 1);
end;

procedure TFEditDict.tbGenSQLClick(Sender: TObject);
begin
  // предупреждение
  if (Application.MessageBox(pchar('Внимание!!! Вместе с выбранным справочником в скрипт попадут ВСЕ ЕГО ДОЧЕРНИЕ И РОДИТЕЛЬСКИЕ справочники! ' +
      'А так же будут ПЕРЕСОЗДАНЫ ВСЕ ПРИВЯЗАННЫЕ СЦЕНАРИИ!'#13#10 + 'Вам оно нужно???'), 'Предупреждение', MB_YESNO + MB_ICONWARNING) <> ID_YES) then exit;

  FMain.SetSaveDialogToSQL;
  if FMain.SaveDialog.Execute then FMain.SaveToSQL(Properties, FMain.SaveDialog.FileName, 0, true);
end;

procedure TFEditDict.tbJumpToTreeClick(Sender: TObject);
begin
  if Mode = omAdd then exit;
  FMain.JumpToNode(cotDict, Properties.Descriptor); 
end;

procedure TFEditDict.tbRefreshClick(Sender: TObject);
begin
  if (Mode = omView) or (Application.MessageBox('При перезагрузке данных справочника все несохраненные изменения будут потеряны! Продолжить?',
    'Подтверждение', MB_YESNO + MB_ICONQUESTION) = ID_YES) then _Reload;
end;

procedure TFEditDict.TemplateToUserParams(UserParams, Strings: TStringList);
var
  userConsts: TStringList;
  i, j: integer;
  fld: string;

begin
  userConsts := TStringList.Create;

  try
    userConsts.Text := LOGINED_USER_VALUES;

    // получаем основные данные
    for i := 0 to Strings.Count - 1 do
    begin
      for j := 0 to userConsts.Count - 1 do
      begin
        fld := StringReplace(StringReplace(userConsts.Strings[j], '?>', '', []), '<?USER_', '', []);
        Strings.Strings[i] := StringReplace(Strings.Strings[i], userConsts.Strings[j], UserParams.Values[fld], [rfReplaceAll]);
      end;

      // тут надо с null-ами подшаманить кое-что
      Strings.Strings[i] := StringReplace(Strings.Strings[i], '=null', 'is null', [rfReplaceAll]);
      Strings.Strings[i] := StringReplace(Strings.Strings[i], '= null', 'is null', [rfReplaceAll]);
      Strings.Strings[i] := StringReplace(Strings.Strings[i], '=''null''', 'is null', [rfReplaceAll]);
      Strings.Strings[i] := StringReplace(Strings.Strings[i], '= ''null''', 'is null', [rfReplaceAll]);
      Strings.Strings[i] := StringReplace(Strings.Strings[i], '<>null', 'is not null', [rfReplaceAll]);
      Strings.Strings[i] := StringReplace(Strings.Strings[i], '<> null', 'is not null', [rfReplaceAll]);
      Strings.Strings[i] := StringReplace(Strings.Strings[i], '<>''null''', 'is not null', [rfReplaceAll]);
      Strings.Strings[i] := StringReplace(Strings.Strings[i], '<> ''null''', 'is not null', [rfReplaceAll]);
      Strings.Strings[i] := StringReplace(Strings.Strings[i], '!=null', 'is not null', [rfReplaceAll]);
      Strings.Strings[i] := StringReplace(Strings.Strings[i], '!= null', 'is not null', [rfReplaceAll]);
      Strings.Strings[i] := StringReplace(Strings.Strings[i], '!=''null''', 'is not null', [rfReplaceAll]);
      Strings.Strings[i] := StringReplace(Strings.Strings[i], '!= ''null''', 'is not null', [rfReplaceAll]);

      // теперь списки залить
      Strings.Strings[i] := StringReplace(Strings.Strings[i], '<?USER_LIST_GROUP_PK?>', UserParams.Values['LIST_GROUP_PK'], [rfReplaceAll]);
      Strings.Strings[i] := StringReplace(Strings.Strings[i], '<?USER_LIST_GROUP_NAME?>', UserParams.Values['LIST_GROUP_NAME'], [rfReplaceAll]);
      Strings.Strings[i] := StringReplace(Strings.Strings[i], '<?USER_LIST_GEO_PK?>', UserParams.Values['LIST_GEO_PK'], [rfReplaceAll]);
      Strings.Strings[i] := StringReplace(Strings.Strings[i], '<?USER_LIST_RANK_PK?>', UserParams.Values['LIST_RANK_PK'], [rfReplaceAll]);
      Strings.Strings[i] := StringReplace(Strings.Strings[i], '<?USER_LIST_RANK_NAME?>', UserParams.Values['LIST_RANK_NAME'], [rfReplaceAll]);
    end;
  finally
    userConsts.Free;
  end;
end;

procedure TFEditDict.UpdateChildTableFields;
var
  dsChildRefs: TpFIBDataSet;
  sql: string;
  s: string;
  bm: TBookmark;
  sl: TStringList;

begin
  if Mode in [omAdd, omView] then exit;

  // обновляем все ChildTable поля у справочника (смотрим по деткам). Отсутствующие удаляем, новые добавляем
  bm := mtFormFields.GetBookmark;

  sql := 'select r.PK, r.DESCRIPTOR_, o.PK OBJECT_PK, o.NAME OBJECT_NAME, o.JOIN_FIELDS from DYNAMIC_FORM_REFERENCE r ' +
    'join DYNAMIC_FORM_OBJECT_TREE o on o.FORM_PK = r.MAIN_FORM_PK and (o.JOIN_PARENT_PK is null or ' +
      '(o.JOIN_PARENT_PK is not null and o.IS_MULTI_JOIN = ''1'')) ' +
    'where r.PARENT_REFERENCE_PK = ' + VarToStr(Properties.PK);

  dsChildRefs := FMain.OpenSQL(sql);

  // сначала добавляем/обновляем
  try
    sl := TStringList.Create;
    mtFormFields.DisableControls;
    sl.Text := StringReplace(GetObjectNames(true), ',', #13#10, [rfReplaceAll]);

    dsChildRefs.First;
    while not dsChildRefs.Eof do
    begin
      if mtFormFields.Locate('FIELD_NAME', dsChildRefs.FieldByName('DESCRIPTOR_').Value, [loCaseInsensitive]) and
        (sl.IndexOf(mtFormFieldsOBJECT_PK.AsString) = -1) then
      begin
        // нашли поле - апдейтим
        mtFormFields.Edit;
        mtFormFieldsOBJECT_PK.AsVariant := dsChildRefs.FieldByName('OBJECT_PK').Value;
        mtFormFieldsOBJECT_NAME.AsVariant := dsChildRefs.FieldByName('OBJECT_NAME').Value;
        if Pos('.' + dsChildRefs.FieldByName('DESCRIPTOR_').AsString, mtFormFieldsTITLE.AsString) > 0 then
          mtFormFieldsTITLE.AsString := dsChildRefs.FieldByName('OBJECT_NAME').AsString + '.' + dsChildRefs.FieldByName('DESCRIPTOR_').AsString;
        mtFormFieldsTYPE_NAME.AsString := FIELDTYPE_ChildTable;
        if Pos('"joinfields"', AnsiLowerCase(mtFormFieldsPARAMETERS.AsString)) = 0 then
          mtFormFieldsPARAMETERS.AsString := '{"joinFields": "' + PyAnsiToUnicode(dsChildRefs.FieldByName('JOIN_FIELDS').AsString) + '"}'
        else begin
          s := PyAnsiToUnicode(ExtractParamValue(mtFormFieldsPARAMETERS.AsString, 'joinFields'));
          mtFormFieldsPARAMETERS.AsString := StringReplace(mtFormFieldsPARAMETERS.AsString, s,
            PyAnsiToUnicode(dsChildRefs.FieldByName('JOIN_FIELDS').AsString), [rfIgnoreCase]);
        end;
      end else
      begin
        // нет такого поля - надо создать новое
        AutoIncFields;
        mtFormFields.Append;
        mtFormFieldsOBJECT_PK.AsVariant := dsChildRefs.FieldByName('OBJECT_PK').Value;
        mtFormFieldsOBJECT_NAME.AsVariant := dsChildRefs.FieldByName('OBJECT_NAME').Value;
        mtFormFieldsFIELD_NAME.AsVariant := dsChildRefs.FieldByName('DESCRIPTOR_').Value;
        mtFormFieldsTITLE.AsString := dsChildRefs.FieldByName('OBJECT_NAME').AsString + '.' + dsChildRefs.FieldByName('DESCRIPTOR_').AsString;
        mtFormFieldsTYPE_NAME.AsString := FIELDTYPE_ChildTable;
        mtFormFieldsPARAMETERS.AsString := '{"joinFields": "' + PyAnsiToUnicode(dsChildRefs.FieldByName('JOIN_FIELDS').AsString) + '"}';
        mtFormFieldsGRID_ORDER.AsInteger := mtFormFieldsGRID_ORDER.Tag;
        mtFormFieldsORDER_.AsInteger := mtFormFieldsORDER_.Tag;
        mtFormFieldsDESCRIPTION.AsString := '';
        mtFormFieldsSTYLE_EXTERNAL.AsString := '';
        mtFormFieldsSTYLE.AsString := '';
        mtFormFieldsGRID_VISIBLE.AsInteger := 1;
        mtFormFieldsEDIT_IN_TABLE.AsInteger := 1;
        mtFormFieldsIS_VISIBLE.AsInteger := 0;
        mtFormFieldsEDITABLE.AsInteger := 0;
        mtFormFieldsIS_VISIBLE_ADD.AsInteger := 0;
        mtFormFieldsADD_EDITABLE.AsInteger := 0;
        mtFormFieldsEXCEL_EXPORT.AsInteger := 0;
        mtFormFieldsSHOW_IN_GROUP_EDIT.AsInteger := 0;
        mtFormFieldsSHOW_IN_START_FORM.AsInteger := 0;
      end;
      mtFormFields.Post;
      dsChildRefs.Next;
    end;

    // теперь пометим галками (например для удаления, да и вобще, чтоб видно было) поля, по которым дочерние справочники были отвязаны
    mtFormFields.First;
    while not mtFormFields.Eof do
    begin
      if mtFormFieldsTYPE_NAME.AsString = FIELDTYPE_ChildTable then
        if not dsChildRefs.Locate('DESCRIPTOR_', mtFormFieldsFIELD_NAME.AsString, [loCaseInsensitive]) then
          dbgFormFields.SelectedRows.AppendItem(mtFormFields.Bookmark);
      mtFormFields.Next;
    end
  finally
    sl.Free;
    mtFormFields.EnableControls;
    if mtFormFields.BookmarkValid(bm) then
    begin
      mtFormFields.GotoBookmark(bm);
      mtFormFields.FreeBookmark(bm);
    end else
      mtFormFields.First;
  end;
end;

procedure TFEditDict._Reload;
begin
  if Mode = omAdd then Mode := omEdit;
  Properties := Properties;
end;

procedure TFEditDict._Save;
begin
  Success := SaveData;
  if Success then
  begin
    Mode := omEdit;
    Properties := Properties;
  end;
end;

end.
