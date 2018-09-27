unit optControls;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,
  DB, DBCtrlsEh, DBLookupEh, ToolCtrlsEh, utils, Math, DBAccess, Uni, UniProvider, PostgreSQLUniProvider, OracleUniProvider,
  MySQLUniProvider, InterBaseUniProvider, MemDS, dbUtils, settings;

const
  CTRLHEIGHT = 21;
  FIELDTYPEDELIM = #13#10;
  OPTSDELIM = ',';
  PARAMSDELIM = ';';
  EMPTYVALUE = '<::NOTHING::>';

  FIELDTYPE_text = 'text';
  FIELDTYPE_numeric = 'numeric';
  FIELDTYPE_TextArea = 'TextArea';
  FIELDTYPE_HtmlEditor = 'HtmlEditor';
  FIELDTYPE_hidden = 'hidden';
  FIELDTYPE_comboBox = 'comboBox';
  FIELDTYPE_Checkbox = 'Checkbox';
  FIELDTYPE_ChildTable = 'ChildTable';
  FIELDTYPE_LookUp = 'LookUp';
  FIELDTYPE_date = 'date';
  FIELDTYPE_datePeriod = 'datePeriod';
  FIELDTYPE_photo = 'photo';
  FIELDTYPE_link = 'link';
  FIELDTYPE_MultipleLookUp = 'MultipleLookUp';
  FIELDTYPE_MLookUpCreat = 'MLookUpCreat';
  FIELDTYPE_FormField = 'FormField';
  FIELDTYPE_FileField = 'FileField';
  FIELDTYPE_LovCombo = 'LovCombo';
  FIELDTYPE_CheckedLookUp = 'CheckedLookUp';
  FIELDTYPE_Button = 'Button';
  FIELDTYPE_MonthField = 'MonthField';

  FIELDTYPES = FIELDTYPE_text + FIELDTYPEDELIM + FIELDTYPE_numeric + FIELDTYPEDELIM + FIELDTYPE_TextArea + FIELDTYPEDELIM +
    FIELDTYPE_HtmlEditor + FIELDTYPEDELIM + FIELDTYPE_hidden + FIELDTYPEDELIM + FIELDTYPE_comboBox + FIELDTYPEDELIM +
    FIELDTYPE_Checkbox + FIELDTYPEDELIM + FIELDTYPE_ChildTable + FIELDTYPEDELIM + FIELDTYPE_LookUp + FIELDTYPEDELIM +
    FIELDTYPE_date + FIELDTYPEDELIM + FIELDTYPE_datePeriod + FIELDTYPEDELIM + FIELDTYPE_photo + FIELDTYPEDELIM +
    FIELDTYPE_link + FIELDTYPEDELIM + FIELDTYPE_MultipleLookUp + FIELDTYPEDELIM + FIELDTYPE_MLookUpCreat + FIELDTYPEDELIM +
    FIELDTYPE_FormField + FIELDTYPEDELIM + FIELDTYPE_FileField + FIELDTYPEDELIM + FIELDTYPE_LovCombo + FIELDTYPEDELIM +
    FIELDTYPE_CheckedLookUp + FIELDTYPEDELIM + FIELDTYPE_Button + FIELDTYPEDELIM + FIELDTYPE_MonthField;

  OPT_allowBlank = 'allowBlank';
  OPT_defaultValue = 'defaultValue';
  OPT_surValue = 'surValue';
  OPT_maxLength = 'maxLength';
  OPT_regValid = 'regValid';
  OPT_regMessage = 'regMessage';
  OPT_decimalPrecision = 'decimalPrecision';
  OPT_allowNegative = 'allowNegative';
  OPT_allowDecimals = 'allowDecimals';
  OPT_percent = 'percent';
  OPT_needRound = 'needRound';
  OPT_summaryType = 'summaryType';
  OPT_minValue = 'minValue';
  OPT_maxValue = 'maxValue';
  OPT_height = 'height';
  OPT_values = 'values';
  OPT_fields = 'fields';
  OPT_joinFields = 'joinFields';
  OPT_descTable = 'descTable';
  OPT_descField = 'descField';
  OPT_where = 'where';
  OPT_notCount = 'notCount';
  OPT_showAsGrid = 'showAsGrid';
  OPT_gridWidth = 'gridWidth';
  OPT_gridHeight = 'gridHeight';
  OPT_maxRow = 'maxRow';
  OPT_minRow = 'minRow';
  OPT_rowCount = 'rowCount';
  OPT_baseDescriptor = 'baseDescriptor';
  OPT_fkTable = 'fkTable';
  OPT_fkField = 'fkField';
  OPT_displayField = 'displayField';
  OPT_fkRef = 'fkRef';
  OPT_fkRefField = 'fkRefField';
  OPT_whereInFilter = 'whereInFilter';
  OPT_filterWhere = 'filterWhere';
  OPT_joinConst = 'joinConst';
  OPT_mayAdd = 'mayAdd';
  OPT_cachType = 'cachType';
  OPT_dateShow = 'dateShow';
  OPT_timeShow = 'timeShow';
  OPT_increment = 'increment';
  OPT_fromTitle = 'fromTitle';
  OPT_toTitle = 'toTitle';
  OPT_maxDays = 'maxDays';
  OPT_pkField = 'pkField';
  OPT_separator = 'separator';
  OPT_needName = 'needName';
  OPT_showProtokol = 'showProtokol';
  OPT_defProtokol = 'defProtokol';
  OPT_maxCount = 'maxCount';
  OPT_descriptor = 'descriptor';
  OPT_fieldName = 'fieldName';
  OPT_displayFieldName = 'displayFieldName';
  OPT_isList = 'isList';
  OPT_rightWidth = 'rightWidth';
  OPT_showValue = 'showValue';
  OPT_formPk = 'formPk';
  OPT_fileSize = 'fileSize';
  OPT_fileType = 'fileType';
  OPT_isolationLoad = 'isolationLoad';
  OPT_minDate = 'minDate';
  OPT_shortLink = 'shortLink';
  OPT_selectAll = 'selectAll';
  OPT_currency = 'currency';
  OPT_use_where_in_import = 'use_where_in_import';
  OPT_keepPeriod = 'keepPeriod';
  OPT_noDelete = 'noDelete';
  OPT_addBbar = 'addBbar';
  OPT_separator_val = 'separator_val';
  OPT_topLabel = 'topLabel';
  OPT_localSort = 'localSort';

  OPTS_all = OPT_allowBlank + OPTSDELIM + OPT_defaultValue + OPTSDELIM + OPT_surValue;
  OPTS_text = OPTS_all + OPTSDELIM + OPT_maxLength + OPTSDELIM + OPT_regValid + OPTSDELIM + OPT_regMessage;
  OPTS_numeric = OPTS_all + OPTSDELIM + OPT_maxLength + OPTSDELIM + OPT_decimalPrecision + OPTSDELIM + OPT_allowNegative +
    OPTSDELIM + OPT_allowDecimals + OPTSDELIM + OPT_percent + OPTSDELIM + OPT_needRound + OPTSDELIM + OPT_summaryType +
    OPTSDELIM + OPT_minValue + OPTSDELIM + OPT_maxValue + OPTSDELIM + OPT_currency + OPTSDELIM + OPT_addBbar;
  OPTS_TextArea = OPTS_all + OPTSDELIM + OPT_height + OPTSDELIM + OPT_maxLength;
  OPTS_HtmlEditor = OPTS_all + OPTSDELIM + OPT_height;
  OPTS_hidden = OPTS_all;
  OPTS_comboBox = OPTS_all + OPTSDELIM + OPT_values + OPTSDELIM + OPT_fields + OPTSDELIM + OPT_summaryType;
  OPTS_Checkbox = OPTS_all + OPTSDELIM + OPT_summaryType + OPTSDELIM + OPT_topLabel;
  OPTS_ChildTable = OPTS_all + OPTSDELIM + OPT_joinFields + OPTSDELIM + OPT_descTable + OPTSDELIM + OPT_descField + OPTSDELIM +
    OPT_where + OPTSDELIM + OPT_notCount + OPTSDELIM + OPT_showAsGrid + OPTSDELIM + OPT_localSort + OPTSDELIM + OPT_gridWidth +
    OPTSDELIM + OPT_gridHeight + OPTSDELIM + OPT_maxRow + OPTSDELIM + OPT_minRow + OPTSDELIM + OPT_rowCount;
  OPTS_LookUp = OPTS_all + OPTSDELIM + OPT_baseDescriptor + OPTSDELIM + OPT_fkTable + OPTSDELIM + OPT_fkField + OPTSDELIM +
    OPT_displayField + OPTSDELIM + OPT_fkRef + OPTSDELIM + OPT_fkRefField + OPTSDELIM + OPT_whereInFilter + OPTSDELIM +
    OPT_where + OPTSDELIM + OPT_filterWhere + OPTSDELIM + OPT_joinConst + OPTSDELIM + OPT_mayAdd + OPTSDELIM + OPT_cachType +
    OPTSDELIM + OPT_use_where_in_import;
  OPTS_date = OPTS_all + OPTSDELIM + OPT_dateShow + OPTSDELIM + OPT_timeShow + OPTSDELIM + OPT_increment;
  OPTS_datePeriod = OPTS_all + OPTSDELIM + OPT_dateShow + OPTSDELIM + OPT_timeShow + OPTSDELIM + OPT_fromTitle + OPTSDELIM +
    OPT_toTitle + OPTSDELIM + OPT_maxDays;
  OPTS_photo = OPTS_all + OPTSDELIM + OPT_pkField;
  OPTS_link = OPTS_all + OPTSDELIM + OPT_separator + OPTSDELIM + OPT_needName + OPTSDELIM + OPT_showProtokol + OPTSDELIM + OPT_defProtokol;
  OPTS_MultipleLookUp = OPTS_all + OPTSDELIM + OPT_maxCount + OPTSDELIM + OPT_descriptor + OPTSDELIM + OPT_fieldName + OPTSDELIM +
    OPT_displayFieldName + OPTSDELIM + OPT_isList + OPTSDELIM + OPT_rightWidth + OPTSDELIM + OPT_showValue + OPTSDELIM + OPT_where +
    OPTSDELIM + OPT_separator_val;
  OPTS_MLookUpCreat = OPTS_all + OPTSDELIM + OPT_fkTable + OPTSDELIM + OPT_fkField + OPTSDELIM + OPT_displayField + OPTSDELIM +
    OPT_descriptor + OPTSDELIM + OPT_fieldName + OPTSDELIM + OPT_displayFieldName + OPTSDELIM + OPT_maxCount + OPTSDELIM +
    OPT_isList + OPTSDELIM + OPT_rightWidth + OPTSDELIM + OPT_showValue + OPTSDELIM + OPT_where + OPTSDELIM + OPT_separator_val;
  OPTS_FormField = OPTS_all + OPTSDELIM + OPT_formPk + OPTSDELIM + OPT_height;
  OPTS_FileField = OPTS_all + OPTSDELIM + OPT_pkField + OPTSDELIM + OPT_fileSize + OPTSDELIM + OPT_fileType + OPTSDELIM + OPT_isolationLoad +
    OPTSDELIM + OPT_shortLink + OPTSDELIM + OPT_keepPeriod + OPTSDELIM + OPT_noDelete;
  OPTS_LovCombo = OPTS_all + OPTSDELIM + OPT_values + OPTSDELIM + OPT_fields;
  OPTS_CheckedLookUp = OPTS_all + OPTSDELIM + OPT_baseDescriptor + OPTSDELIM + OPT_fkTable + OPTSDELIM + OPT_fkField + OPTSDELIM +
    OPT_displayField + OPTSDELIM + OPT_whereInFilter + OPTSDELIM + OPT_where + OPTSDELIM + OPT_filterWhere + OPTSDELIM + OPT_selectAll;
  OPTS_Button = ''{OPTS_all};
  OPTS_MonthField = OPTS_all + OPTSDELIM + OPT_minDate;

type
  TOptionRecord = class;
  TRecordOnChande = procedure(OptionRec: TOptionRecord) of object;
  
  TFieldControlType = (fctUnknown, fctText, fctNumeric, fctTextArea, fctHtmlEditor, fctHidden, fctComboBox, fctCheckbox,
    fctChildTable, fctLookUp, fctDate, fctDatePeriod, fctPhoto, fctLink, fctMultipleLookUp, fctMLookUpCreat, fctFormField,
    fctFileField, fctLovCombo, fctCheckedLookUp, fctButton, fctMonthField);

  TOptionDataType = (odtStr, odtInt, odtBool, odtFloat);
  TOptionControlType = (octEdit, octNumeric, octCheckBox, octCombo, octEditCombo, octLookup, octMemo);

  TContainer = class;

  TOptionRecord = class
  private
    FOption: string;
    FContainer: TContainer;
    FControlType: TOptionControlType;
    FLeft: integer;
    FTop: integer;
    FWidth: integer;
    FHeight: integer;
    FDataType: TOptionDataType;
    // видимые на форме контролы
    FDisplayLabel: TLabel;
    FControl: TControl;
    // дополнительные элементы
    FComboKeyValues: TStringList;
    FLookupDataSet: TDataSet;
    FDataSource: TDataSource;
    // события
    FOnChange: TRecordOnChande;
    procedure OnWinControlChange(Sender: TObject);
    // тут создание всего
    procedure SetOption(AName: string);
    procedure SetControlType(ct: TOptionControlType);
    // методы свойств
    function GetValue: Variant;
    procedure SetValue(AValue: Variant);
    function GetDisplayValue: Variant;
    procedure SetDisplayValue(AValue: Variant);
    function GetExpression: string;
    function GetDisplayLabel: string;
    procedure SetDiaplayLabel(AValue: string);
    function GetComboDisplayValues: string;
    function GetComboKeyValues: string;
    procedure SetComboDisplayValues(AValue: string);
    procedure SetComboKeyValues(AValue: string);
    procedure SetLookupDataSet(AValue: TDataSet);
    function GetHint: string;
    procedure SetHint(AValue: string);
    function GetHeight: integer;
    function GetLeft: integer;
    function GetTop: integer;
    function GetWidth: integer;
    function GetMaxValue: integer;
    function GetMinValue: integer;
    procedure SetMaxValue(Value: integer);
    procedure SetMinValue(Value: integer);
  public
    ChilOptionNames: string;
    constructor Create(AParent: TContainer; OptionName: string; ALeft, ATop, AWidth, AHeight: integer);
    destructor Destroy; override;

    property Name: string read FOption;
    property Value: Variant read GetValue write SetValue;
    property DisplayValue: Variant read GetDisplayValue write SetDisplayValue;
    property DataType: TOptionDataType read FDataType;
    property ControlType: TOptionControlType read FControlType;
    property Expression: string read GetExpression;
    // параметры контролов
    property DisplayLabel: string read GetDisplayLabel write SetDiaplayLabel;
    property ComboKeyValues: string read GetComboKeyValues write SetComboKeyValues;
    property ComboDisplayValues: string read GetComboDisplayValues write SetComboDisplayValues;
    property LookupDataSet: TDataSet read FLookupDataSet write SetLookupDataSet;
    property Hint: string read GetHint write SetHint;
    property Left: integer read GetLeft;
    property Top: integer read GetTop;
    property Width: integer read GetWidth;
    property Height: integer read GetHeight;
    property MinValue: integer read GetMinValue write SetMinValue;
    property MaxValue: integer read GetMaxValue write SetMaxValue;
    property OnOptChange: TRecordOnChande read FOnChange write FOnChange;
  end;

  TOptRecords = array of TOptionRecord;

  TContainer = class
  private
    FBaseDescriptor: string;
    FieldTypeStr: string;
    FFieldType: TFieldControlType;
    FContainer: TWinControl;
    FOptions: TOptRecords;
    procedure ClearOptions;
    function FieldTypeFromStr(StrFieldType: string): TFieldControlType;
    function GetFieldTypeOptions(ft: TFieldControlType): string;
    function FindControl(Option: string; var Idx: integer): TOptionRecord;
    procedure SetDatasetParams(Option: string; Params: string; Values: Variant);
    procedure SetLookupDataset(Option: string; DBDescriptor: string);
    function GetOptionHint(Option: string): string;
    // тут все создается
    procedure SetFieldType(AFieldType: string);
    // события
    procedure OnLookupChangeSetDSParams(OptionRec: TOptionRecord);
    procedure OnComboChangeSetDataSet(OptionRec: TOptionRecord);
    procedure OnGridWidthEditChange(OptionRec: TOptionRecord);
    // методы свойств
    function GetCount: integer;
    function GetOptionRecord(OptName: string): TOptionRecord; overload;
    function GetOptionRecord(Index: integer): TOptionRecord; overload;
  public
    constructor Create(AParent: TWinControl; AFieldType: string; ABaseDescriptor: string);
    destructor Destroy; override;

    property Parent: TWinControl read FContainer;
    property FieldType: TFieldControlType read FFieldType;
    property Count: integer read GetCount;
    property OptionRecByName[OptName: string]: TOptionRecord read GetOptionRecord;
    property OptionRecByIndex[Index: integer]: TOptionRecord read GetOptionRecord;
  end;

implementation

{ TOptionRecord }

constructor TOptionRecord.Create(AParent: TContainer; OptionName: string; ALeft, ATop, AWidth, AHeight: integer);
begin
  inherited Create;
  FComboKeyValues := TStringList.Create;
  FContainer := AParent;
  FLeft := ALeft;
  FTop := ATop;
  FWidth := AWidth;
  FHeight := AHeight;
  SetOption(OptionName);
end;

destructor TOptionRecord.Destroy;
begin
  FDisplayLabel.Free;
  FControl.Free;
  FComboKeyValues.Free;
  if Assigned(FDataSource) then FDataSource.Free;
  if Assigned(FLookupDataSet) then FLookupDataSet.Free;
  inherited Destroy;
end;

function TOptionRecord.GetComboDisplayValues: string;
begin
  case FControlType of
    octCombo, octEditCombo: result := TComboBox(FControl).Items.Text;
    octLookup: result := TDBLookupComboboxEh(FControl).ListField;
    else result := '';
  end;
end;

function TOptionRecord.GetComboKeyValues: string;
begin
  case FControlType of
    octCombo, octEditCombo: result := FComboKeyValues.Text;
    octLookup: result := TDBLookupComboboxEh(FControl).KeyField;
    else result := '';
  end;
end;

function TOptionRecord.GetDisplayLabel: string;
begin
  case FControlType of
    octCheckBox: result := TCheckBox(FControl).Caption;
    else result := FDisplayLabel.Caption;
  end;
end;

function TOptionRecord.GetDisplayValue: Variant;
begin
  case FControlType of
    octEdit: result := TEdit(FControl).Text;
    octNumeric: result := TDBNumberEditEh(FControl).Value;
    octCheckBox: result := TCheckBox(FControl).Checked;
    octCombo:
    begin
      if TComboBox(FControl).ItemIndex = -1 then result := ''
      else result := TComboBox(FControl).Items.Strings[TComboBox(FControl).ItemIndex];
    end;
    octEditCombo: TComboBox(FControl).Text;
    octLookup: result := TDBLookupComboboxEh(FControl).Value;
    octMemo: result := TMemo(FControl).Text;
  end;
end;

function TOptionRecord.GetExpression: string;
var
  val: string;

begin
  result := '"' + FOption + '": ';
  val := PyAnsiToUnicode(VarToStr(Value));
  if (FDataType = odtStr) or (val = '') then val := '"' + val + '"';
  if (FDataType = odtFloat) and (val <> '') then val := StringReplace(val, ',', '.', []);
  result := result + val;
end;

function TOptionRecord.GetHeight: integer;
begin
  if FControlType = octMemo then
    result := FDisplayLabel.Height + (FControl.Top - (FDisplayLabel.Top + FDisplayLabel.Height)) + FControl.Height
  else
    result := FControl.Height;
end;

function TOptionRecord.GetHint: string;
begin
  result := FControl.Hint;
end;

function TOptionRecord.GetLeft: integer;
begin
  if FControlType = octCheckBox then result := FControl.Left
  else result := FDisplayLabel.Left;
end;

function TOptionRecord.GetMaxValue: integer;
begin
  if FControlType = octNumeric then result := Round(TDBNumberEditEh(FControl).MaxValue)
  else result := 0;
end;

function TOptionRecord.GetMinValue: integer;
begin
  if FControlType = octNumeric then result := Round(TDBNumberEditEh(FControl).MinValue)
  else result := 0;
end;

function TOptionRecord.GetTop: integer;
begin
  if FControlType = octMemo then result := FDisplayLabel.Top
  else result := FControl.Top;
end;

function TOptionRecord.GetValue: Variant;
begin
  case FControlType of
    octEdit: result := TEdit(FControl).Text;
    octNumeric: result := TDBNumberEditEh(FControl).Value;
    octCheckBox:
    begin
      result := TCheckBox(FControl).Checked;
      result := LowerCase(result);
    end;
    octCombo:
    begin
      if FComboKeyValues.Count <> TComboBox(FControl).Items.Count then
      begin
        if TComboBox(FControl).ItemIndex = -1 then result := ''
        else result := TComboBox(FControl).Items.Strings[TComboBox(FControl).ItemIndex];
      end else
      begin
        if TComboBox(FControl).ItemIndex = -1 then result := ''
        else result := StringReplace(FComboKeyValues.Strings[TComboBox(FControl).ItemIndex], EMPTYVALUE, '', [rfReplaceAll]);
      end;
    end;
    octEditCombo:
    begin
      if FComboKeyValues.Count <> TComboBox(FControl).Items.Count then
      begin
        if TComboBox(FControl).ItemIndex = -1 then result := TComboBox(FControl).Text
        else result := TComboBox(FControl).Items.Strings[TComboBox(FControl).ItemIndex];
      end else
      begin
        if TComboBox(FControl).ItemIndex = -1 then result := TComboBox(FControl).Text
        else result := StringReplace(FComboKeyValues.Strings[TComboBox(FControl).ItemIndex], EMPTYVALUE, '', [rfReplaceAll]);
      end;
    end;
    octLookup: result := TDBLookupComboboxEh(FControl).KeyValue;
    octMemo: result := TMemo(FControl).Text;
  end;
end;

function TOptionRecord.GetWidth: integer;
begin
  case FControlType of
    octCheckBox, octMemo: result := FControl.Width;
    else result := FDisplayLabel.Width + (FControl.Left - (FDisplayLabel.Left + FDisplayLabel.Width)) + FControl.Width;
  end;
end;

procedure TOptionRecord.OnWinControlChange(Sender: TObject);
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TOptionRecord.SetComboDisplayValues(AValue: string);
begin
  case FControlType of
    octCombo, octEditCombo: TComboBox(FControl).Items.Text := AValue;
    octLookup: TDBLookupComboboxEh(FControl).ListField := AValue;
  end;
end;

procedure TOptionRecord.SetComboKeyValues(AValue: string);
begin
  case FControlType of
    octCombo, octEditCombo: FComboKeyValues.Text := AValue;
    octLookup: TDBLookupComboboxEh(FControl).KeyField := AValue;
  end;
end;

procedure TOptionRecord.SetControlType(ct: TOptionControlType);
begin
  FControlType := ct;

  FDisplayLabel := TLabel.Create(FContainer.Parent);
  FDisplayLabel.Parent := FContainer.Parent;
  FDisplayLabel.Left := FLeft;
  FDisplayLabel.Top := FTop + 3;
  FDisplayLabel.Visible := FControlType <> octCheckBox;

  case FControlType of
    octEdit: FControl := TEdit.Create(FContainer.Parent);
    octNumeric: FControl := TDBNumberEditEh.Create(FContainer.Parent);
    octCheckBox: FControl := TCheckBox.Create(FContainer.Parent);
    octCombo, octEditCombo: FControl := TComboBox.Create(FContainer.Parent);
    octLookup: FControl := TDBLookupComboboxEh.Create(FContainer.Parent);
    octMemo: FControl := TMemo.Create(FContainer.Parent);
  end;

  FControl.Parent := FContainer.Parent;
  FControl.Left := FDisplayLabel.Left + FDisplayLabel.Width + 6;
  FControl.Top := FTop;
  //FControl.Width := FWidth;
  //FControl.Height := FHeight;
  FControl.Visible := true;

  case FControlType of
    octEdit:
    begin
      TEdit(FControl).Width := 200;
      TEdit(FControl).OnChange := OnWinControlChange;
    end;
    octNumeric:
    begin
      TDBNumberEditEh(FControl).EditButton.Style := ebsAltUpDownEh;
      TDBNumberEditEh(FControl).EditButton.Visible := true;
      TDBNumberEditEh(FControl).DecimalPlaces := 3;
      TDBNumberEditEh(FControl).DisplayFormat := '#.###';
      TDBNumberEditEh(FControl).EmptyDataInfo.Text := '<не задано>';
      TDBNumberEditEh(FControl).Width := 90;
      TDBNumberEditEh(FControl).OnChange := OnWinControlChange;
    end;
    octCheckBox:
    begin
      TCheckBox(FControl).Left := FLeft;
      TCheckBox(FControl).Width := 20;
      TCheckBox(FControl).OnClick := OnWinControlChange;
    end;
    octCombo:
    begin
      TComboBox(FControl).Style := csDropDownList;
      TComboBox(FControl).Width := 200;
      TComboBox(FControl).OnChange := OnWinControlChange;
    end;
    octEditCombo:
    begin
      TComboBox(FControl).Style := csDropDown;
      TComboBox(FControl).Width := 200;
      TComboBox(FControl).OnChange := OnWinControlChange;
    end;
    octLookup:
    begin
      FDataSource := TDataSource.Create(nil);
      TDBLookupComboboxEh(FControl).ListSource := FDataSource;
      TDBLookupComboboxEh(FControl).Width := 400;
      TDBLookupComboboxEh(FControl).OnChange := OnWinControlChange;
    end;
    octMemo:
    begin
      FDisplayLabel.Top := FTop;
      TMemo(FControl).Lines.Clear;
      TMemo(FControl).Left := FLeft;
      TMemo(FControl).Top := FDisplayLabel.Top + FDisplayLabel.Height + 6;
      //TMemo(FControl).Height := FHeight;
      TMemo(FControl).Height := 120;
      TMemo(FControl).Width := 370;
      TMemo(FControl).ScrollBars := ssVertical;
      TMemo(FControl).OnChange := OnWinControlChange;
    end;
  end;
end;

procedure TOptionRecord.SetDiaplayLabel(AValue: string);
begin
  case FControlType of
    octCheckBox:
    begin
      FDisplayLabel.Caption := AValue;
      TCheckBox(FControl).Caption := AValue;
      TCheckBox(FControl).Width := FDisplayLabel.Canvas.TextWidth(AValue) + 20;
    end;
    else begin
      FDisplayLabel.Caption := AValue;
      if FControlType <> octMemo then FControl.Left := FDisplayLabel.Left + FDisplayLabel.Width + 6;
    end;
  end;
end;

procedure TOptionRecord.SetDisplayValue(AValue: Variant);
begin
  case FControlType of
    octEdit: TEdit(FControl).Text := VarToStr(AValue);
    octNumeric: TDBNumberEditEh(FControl).Value := AValue;
    octCheckBox: TCheckBox(FControl).Checked := iif(VarIsNull(AValue), false, AValue);
    octCombo: TComboBox(FControl).ItemIndex := TComboBox(FControl).Items.IndexOf(VarToStr(AValue));
    octEditCombo: TComboBox(FControl).Text := VarToStr(AValue);
    octLookup: TDBLookupComboboxEh(FControl).Value := AValue;
    octMemo: TMemo(FControl).Text := VarToStr(AValue);
  end;
end;

procedure TOptionRecord.SetHint(AValue: string);
begin
  FControl.Hint := AValue;
  FControl.ShowHint := AValue <> '';
end;

procedure TOptionRecord.SetLookupDataSet(AValue: TDataSet);
begin
  if Assigned(FLookupDataSet) then
  begin
    if FLookupDataSet.Active then FLookupDataSet.Close;
    FreeAndNil(FLookupDataSet);
  end;

  FLookupDataSet := AValue;
  FDataSource.DataSet := FLookupDataSet;
end;

procedure TOptionRecord.SetMaxValue(Value: integer);
begin
  if FControlType = octNumeric then TDBNumberEditEh(FControl).MaxValue := Value;
end;

procedure TOptionRecord.SetMinValue(Value: integer);
begin
  if FControlType = octNumeric then TDBNumberEditEh(FControl).MinValue := Value;
end;

procedure TOptionRecord.SetOption(AName: string);
begin
  FOption := AName;

  // CheckBox
  if (FOption = OPT_allowBlank) or (FOption = OPT_allowNegative) or (FOption = OPT_allowDecimals) or (FOption = OPT_percent) or
    (FOption = OPT_needRound) or (FOption = OPT_notCount) or (FOption = OPT_showAsGrid) or (FOption = OPT_whereInFilter) or
    (FOption = OPT_mayAdd) or (FOption = OPT_cachType) or (FOption = OPT_dateShow) or (FOption = OPT_timeShow) or (FOption = OPT_needName) or
    (FOption = OPT_showProtokol) or (FOption = OPT_isList) or (FOption = OPT_showValue) or (FOption = OPT_isolationLoad) or (FOption = OPT_minDate) or
    (FOption = OPT_shortLink) or (FOption = OPT_selectAll) or (FOption = OPT_currency) or (FOption = OPT_use_where_in_import) or
    (FOption = OPT_noDelete) or (FOption = OPT_addBbar) or (FOption = OPT_topLabel) or (FOption = OPT_localSort) then
  begin
    FDataType := odtBool;
    SetControlType(octCheckBox);
  // Edit
  end else if (FOption = OPT_regValid) or (FOption = OPT_regMessage) or (FOption = OPT_joinConst) or
    (FOption = OPT_fromTitle) or (FOption = OPT_toTitle) or (FOption = OPT_pkField) or (FOption = OPT_separator) or (FOption = OPT_formPk) or
    (FOption = OPT_fileType) or (FOption = OPT_gridWidth) or (FOption = OPT_separator_val) then
  begin
    FDataType := odtStr;
    SetControlType(octEdit);
  // ComboBox
  end else if (FOption = OPT_surValue) or (FOption = OPT_summaryType) or (FOption = OPT_baseDescriptor) or (FOption = OPT_defProtokol) then
  begin
    FDataType := odtStr;
    SetControlType(octCombo);
  // EditCombo
  end else if (FOption = OPT_defaultValue) then
  begin
    FDataType := odtStr;
    SetControlType(octEditCombo);
  // Numeric
  end else if (FOption = OPT_maxLength) or (FOption = OPT_decimalPrecision) or (FOption = OPT_height) {or (FOption = OPT_gridWidth)} or
    (FOption = OPT_gridHeight) or (FOption = OPT_maxRow) or (FOption = OPT_minRow) or (FOption = OPT_rowCount) or (FOption = OPT_increment) or
    (FOption = OPT_maxDays) or (FOption = OPT_maxCount) or (FOption = OPT_rightWidth) or (FOption = OPT_fileSize) or
    (FOption = OPT_keepPeriod) then
  begin
    FDataType := odtInt;
    SetControlType(octNumeric);
  // Float
  end else if (FOption = OPT_minValue) or (FOption = OPT_maxValue) then
  begin
    FDataType := odtFloat;
    SetControlType(octNumeric);
  // Memo
  end else if (FOption = OPT_values) or (FOption = OPT_fields) or (FOption = OPT_joinFields) or (FOption = OPT_where) or
    (FOption = OPT_filterWhere) then
  begin
    FDataType := odtStr;
    SetControlType(octMemo);
  // LookupCombo
  end else if (FOption = OPT_descTable) or (FOption = OPT_descField) or (FOption = OPT_fkTable) or (FOption = OPT_fkField) or
    (FOption = OPT_displayField) or (FOption = OPT_fkRef) or (FOption = OPT_fkRefField) or (FOption = OPT_descriptor) or
    (FOption = OPT_fieldName) or (FOption = OPT_displayFieldName) then
  begin
    FDataType := odtStr;
    SetControlType(octLookup);
  end;
end;

procedure TOptionRecord.SetValue(AValue: Variant);
begin
  case FControlType of
    octEdit: TEdit(FControl).Text := VarToStr(AValue);
    octNumeric: TDBNumberEditEh(FControl).Value := iif(VarToStr(AValue) = '', Null, AValue);
    octCheckBox: TCheckBox(FControl).Checked := iif(VarIsNull(AValue), false, AValue);
    octCombo:
    begin
      if VarToStr(AValue) = '' then AValue := EMPTYVALUE;
      TComboBox(FControl).ItemIndex := FComboKeyValues.IndexOf(VarToStr(AValue));
      if TComboBox(FControl).ItemIndex = -1 then TComboBox(FControl).ItemIndex := FComboKeyValues.IndexOf(EMPTYVALUE);
    end;
    octEditCombo:
    begin
      if (VarToStr(AValue) = '') and (FComboKeyValues.IndexOf(EMPTYVALUE) <> -1) then AValue := EMPTYVALUE;
      TComboBox(FControl).ItemIndex := FComboKeyValues.IndexOf(VarToStr(AValue));
      if TComboBox(FControl).ItemIndex = -1 then TComboBox(FControl).Text := VarToStr(AValue);
    end;
    octLookup: TDBLookupComboboxEh(FControl).KeyValue := AValue;
    octMemo: TMemo(FControl).Text := VarToStr(AValue);
  end;
end;

{ TContainer }

procedure TContainer.ClearOptions;
var
  i: integer;

begin
  for i := 0 to Length(FOptions) - 1 do FreeAndNil(FOptions[i]);
  SetLength(FOptions, 0);
end;

constructor TContainer.Create(AParent: TWinControl; AFieldType: string; ABaseDescriptor: string);
begin
  inherited Create;
  FContainer := AParent;
  if Pos(ABaseDescriptor, FSettings.DbDescriptors) > 0 then
    FBaseDescriptor := ABaseDescriptor
  else
    FBaseDescriptor := DBDESC_FB;
  SetFieldType(AFieldType);
end;

destructor TContainer.Destroy;
begin
  ClearOptions;
  inherited Destroy;
end;

function TContainer.FieldTypeFromStr(StrFieldType: string): TFieldControlType;
begin
  if StrFieldType = FIELDTYPE_text then result := fctText
  else if StrFieldType = FIELDTYPE_numeric then result := fctNumeric
  else if StrFieldType = FIELDTYPE_TextArea then result := fctTextArea
  else if StrFieldType = FIELDTYPE_HtmlEditor then result := fctHtmlEditor
  else if StrFieldType = FIELDTYPE_hidden then result := fctHidden
  else if StrFieldType = FIELDTYPE_comboBox then result := fctComboBox
  else if StrFieldType = FIELDTYPE_Checkbox then result := fctCheckbox
  else if StrFieldType = FIELDTYPE_ChildTable then result := fctChildTable
  else if StrFieldType = FIELDTYPE_LookUp then result := fctLookUp
  else if StrFieldType = FIELDTYPE_date then result := fctDate
  else if StrFieldType = FIELDTYPE_datePeriod then result := fctDatePeriod
  else if StrFieldType = FIELDTYPE_photo then result := fctPhoto
  else if StrFieldType = FIELDTYPE_link then result := fctLink
  else if StrFieldType = FIELDTYPE_MultipleLookUp then result := fctMultipleLookUp
  else if StrFieldType = FIELDTYPE_MLookUpCreat then result := fctMLookUpCreat
  else if StrFieldType = FIELDTYPE_FormField then result := fctFormField
  else if StrFieldType = FIELDTYPE_FileField then result := fctFileField
  else if StrFieldType = FIELDTYPE_LovCombo then result := fctLovCombo
  else if StrFieldType = FIELDTYPE_CheckedLookUp then result := fctCheckedLookUp
  else if StrFieldType = FIELDTYPE_Button then result := fctButton
  else if StrFieldType = FIELDTYPE_MonthField then result := fctMonthField
  else result := fctUnknown;
end;

function TContainer.FindControl(Option: string; var Idx: integer): TOptionRecord;
var
  i: integer;

begin
  Idx := -1;
  result := nil;

  for i := 0 to Length(FOptions) - 1 do
    if FOptions[i].Name = Option then
    begin
      Idx := i;
      result := FOptions[i];
      exit;
    end;
end;

function TContainer.GetCount: integer;
begin
  result := Length(FOptions);
end;

function TContainer.GetFieldTypeOptions(ft: TFieldControlType): string;
begin
  case ft of
    fctUnknown: result := '';
    fctText: result := OPTS_text;
    fctNumeric: result := OPTS_numeric;
    fctTextArea: result := OPTS_TextArea;
    fctHtmlEditor: result := OPTS_HtmlEditor;
    fctHidden: result := OPTS_hidden;
    fctComboBox: result := OPTS_comboBox;
    fctCheckbox: result := OPTS_Checkbox;
    fctChildTable: result := OPTS_ChildTable;
    fctLookUp: result := OPTS_LookUp;
    fctDate: result := OPTS_date;
    fctDatePeriod: result := OPTS_datePeriod;
    fctPhoto: result := OPTS_photo;
    fctLink: result := OPTS_link;
    fctMultipleLookUp: result := OPTS_MultipleLookUp;
    fctMLookUpCreat: result := OPTS_MLookUpCreat;
    fctFormField: result := OPTS_FormField;
    fctFileField: result := OPTS_FileField;
    fctLovCombo: result := OPTS_LovCombo;
    fctCheckedLookUp: result := OPTS_CheckedLookUp;
    fctButton: result := OPTS_Button;
    fctMonthField: result := OPTS_MonthField;
    else result := '';
  end;
end;

function TContainer.GetOptionHint(Option: string): string;
begin
  if Option = OPT_allowBlank then result := 'Запрещает оставлять поле незаполненным. Такое поле будет подчеркнуто красным и'#13#10 +
    'форма не будет сохраняться, пока оно пустое'
  else if Option = OPT_defaultValue then result := 'Значение по-умолчанию будет автоматически вставляться в поле при открытии формы добавления'
  else if Option = OPT_surValue then result := 'Выбранное значение будет сохраняться в поле при сохранении формы.'#13#10 +
    'Введенное пользователем в поле значение будет всегда заменяться на значение этого параметра'
  else if Option = OPT_maxLength then result := 'Если длина вводимой строки превысит указанное число, остальные символы перестанут вводиться.'#13#10 +
    'Если оставить пустым - длина строки будет не ограничена. Если поле уже содержит строку, длина которой превышает это число,'#13#10 +
    'оно станет подчеркнутым красным и форма не будет сохраняться'
  else if Option = OPT_regValid then result := 'Регулярное выражение, которому должны соответствовать вводимые символы.'#13#10 +
    'Если введенный текст ему не удовлетворяет, будет выведено сообщение ошибки из параметра "Сообщение ошибки для рег. выражения",'#13#10 +
    'поле станет подчеркнутым красным и форма не будет сохраняться'
  else if Option = OPT_regMessage then result := 'Сообщение ошибки, которое будет показано, если введенный в поле текст не соответствует'#13#10 +
    'регулярному выражению из параметра "Регулярное выражение"'
  else if Option = OPT_decimalPrecision then result := 'Точность дробной части числа - количество знаков после запятой,'#13#10 +
    'которые можно ввести у числа. Не учитывается, если установлен флаг "Запретить дробные числа"'
  else if Option = OPT_allowNegative then result := 'Запрещает вводить в поле отрицательные числа.'#13#10 +
    'Если поле уже содержит отрицательное число, то оно подчеркнется красным и форма не будет сохраняться'
  else if Option = OPT_allowDecimals then result := 'Возможен только ввод целых чисел.'#13#10 +
    'Если этот флаг установлен, все параметры, относящиеся к дробным числам, не будут учитываться'
  else if Option = OPT_percent then result := 'Включает отображение числа в виде процентов.'#13#10'При включенном процентном отображении ' +
    'число хранится в БД в виде сотых долей единицы (при сохранении видимое число делится на 100), а при отображении число из БД'#13#10 +
    'умножается на 100 и добавляется символ %'
  else if Option = OPT_needRound then result := 'Отключает дополнение дробной части нулями до указанной точности.'#13#10 +
    'Точность задается параметром "Знаков после запятой". Не учитывается для целых чисел'
  else if Option = OPT_summaryType then result := 'Выбор функции для группировки массива данных по этому полю'#13#10 +
    'Группировка выполняется на уровне SQL-запроса. Выражение этого параметра - это аггрегатная функция SQL, применяемая к полю в запросе'
  else if Option = OPT_minValue then result := 'Минимально допустимое значение. Не позволяет ввести в поле значение меньше указанного'#13#10 +
    'Если оставить пустым - значение будет не ограничено. Если поле уже содержит недопустимое значение, то оно будет подчеркнуто'#13#10 +
    'красным и форма не будет сохраняться'
  else if Option = OPT_maxValue then result := 'Максимально допустимое значение. Не позволяет ввести в поле значение больше указанного'#13#10 +
    'Если оставить пустым - значение будет не ограничено. Если поле уже содержит недопустимое значение, то оно будет подчеркнуто'#13#10 +
    'красным и форма не будет сохраняться'
  else if Option = OPT_height then result := 'Высота поля ввода на форме (формы у FormField). Если не указано, то будет задана высота по-умолчанию'
  else if Option = OPT_values then result := 'Список значений, которые будут видны в выпадающем списке.'#13#10 +
    'Строки списка отделяются символом ";" (точка с запятой)'
  else if Option = OPT_fields then result := 'Список ключевых значений. Строки списка отделяются символом ";" (точка с запятой)'#13#10 +
    'Ключевые значения соответствуют отображаемым в порядке их расположения в списке. Если оставить этот список пустым, то в'#13#10 +
    'качестве ключевых значений будут использованы значения списка отображаемых значений.'#13#10 +
    'Ключевое значение будет сохраняться в БД при выборе соответствуюещего отображаемого значения'
  else if Option = OPT_joinFields then result := 'Содержит список полей для построения условия JOIN SQL-запроса.'#13#10 +
    'Представляет собой список в формате JSON-строки, каждый элемент которого - список из 2-х элементов:'#13#10 +
    '1 - имя поля присоединяемого объекта, 2 - имя поля объекта, к которому идет присоединение.'#13#10 +
    'Этот параметр заполняется автоматически и менять его значение не рекомендуется.'
  else if Option = OPT_descTable then result := 'Используется, когда по одной кнопке дочернего справочника нужно открывать несколько'#13#10 +
    'разных справочников. Содержит список таблиц БД. Выбранная таблица должна хранить список дескрипторов всех открывающихся'#13#10 +
    'по этой кнопке справочников. Она включается в блок FROM <TABLE> SQL-запроса на получение списка справочников'
  else if Option = OPT_descField then result := 'Используется, когда по одной кнопке дочернего справочника нужно открывать несколько'#13#10 +
    'разных справочников. Содержит список полей таблицы БД, выбранной в параметре "Выберите таблицу".'#13#10 +
    'Выбранное поле должно хранить дескрипторы справочников. Оно включается в блок SELECT <FIELD> SQL-запроса на получение списка справочников'
  else if Option = OPT_where then result := 'Условие WHERE SQL-запроса выбора данных (выпадающего списка у Lookup, списка для ChildTable и т.д.).'#13#10 +
    'Ключевое слово "WHERE" должно присутствовать (если есть условие)! Сюда же можно вписать конструкции JOIN, ORDER BY, GROUP BY и т.д.'#13#10 +
    'Содержимое данного параметра просто дописывается снизу к SQL-запросу'
  else if Option = OPT_notCount then result := 'Не будет подсчитываться количество строк в таблице дочернего справочника,'#13#10 +
    'а на кнопке справочника в таблице будет написано его название.'#13#10 +
    'Если не отмечено - то будет подсчитано кол-во строк и на кнопке выведено это число.'#13#10 +
    'Подсчет количества строк может замедлять открытие основного справочника'
  else if Option = OPT_showAsGrid then result := 'Задает способ показа дочернего справочника на формах добавления, редактирования и просмотра:'#13#10 +
    'Если отмечено - то на форме будет расположена таблица дочернего справочника.'#13#10 +
    'Если снято - то кнопка открытия дочернего справочника'
  else if Option = OPT_localSort then result := 'Включает локальную (на клиенте) сортировку набора данных грида вместо отправки запроса на сервер, при'#13#10 +
    'отображении поля на формах в виде грида (если включена опция "Выводить как грид", иначе не используется).'#13#10 +
    'Это имеет значение при редактировании таблицы на форме, т.к. при отправке запроса для перезагрузки стора, которая произойдет при сортировке,'#13#10 +
    'если локальная сортировка отключена, все несохраненные изменения в таблице будут потеряны.'
  else if Option = OPT_gridWidth then result := 'Задает ширину таблицы дочернего справочника на формах добавления, редактирования, просмотра.'#13#10 +
    'Можно задать в пикселях (ввести число) или процентах (ввести число со знаком %).'#13#10 +
    'Учитывается только при установленном параметре "Выводить как грид". Если остаить пустым - будет установлена ширина по-умолчанию'
  else if Option = OPT_gridHeight then result := 'Задает высоту таблицы дочернего справочника на формах добавления, редактирования, просмотра.'#13#10 +
    'Число в пикселях. Учитывается только при установленном параметре "Выводить как грид". Если остаить пустым - будет установлена высота по-умолчанию'
  else if Option = OPT_maxRow then result := 'Ограничивает возможность добавлять запии в таблицу дочернего справочника при режиме отображения'#13#10 +
    '"как грид". Не больше указанного количества строк. Если остаить пустым - без ограничения'
  else if Option = OPT_minRow then result := 'Ограничивает возможность добавлять запии в таблицу дочернего справочника при режиме отображения'#13#10 +
    '"как грид". Не меньше указанного количества строк. Если остаить пустым - без ограничения'
  else if Option = OPT_rowCount then result := 'Устанавливает количество записей в таблице на страницу при режиме отображения "как грид".'#13#10 +
    'Если оставить пустым - будет использовано значение по-умолчанию (50)'
  else if Option = OPT_baseDescriptor then result := 'Выбор дескриптора базы данных на портале.'#13#10 +
    'Поле будет брать данные из указанной БД, в остальных параметрах будут подгружены данные из указанной БД'
  else if Option = OPT_fkTable then result := 'Таблица (представление) БД, из которой будут выбираться данные для списка выбора'
  else if Option = OPT_fkField then result := 'Поле таблицы, заданной параметром "Выберите таблицу", используемое в качестве ключевого.'#13#10 +
    'Данные этого поля будут сохраняться в этом поле в БД по установленному значению списка выбора'
  else if Option = OPT_displayField then result := 'Поле таблицы, заданной параметром "Выберите таблицу", данные которого будут показаны в списке'
  else if Option = OPT_fkRef then result := 'Справочник, который будет открыт при нажатии на ячейку этого поля (ссылку) в таблице.'#13#10 +
    'Если он задан, то в таблице данное поле будет выглядеть как ссылка. Если поле редактируемо, то выбранная запись в справочнике'#13#10 +
    'будет сохранена в поле (точнее значение ее ключевого поля)'
  else if Option = OPT_fkRefField then result := 'Ключевое поле справочника, заданного параметром "Выберите справочник".'#13#10 +
    'По этому полю будет происходить поиск записи в справочнике, открываемом при нажатии на ячейку этого поля в таблице.'#13#10 +
    'Значение для поиска будет браться из ключевого поля Lookup, заданного параметром "Выберите поле таблицы"'
  else if Option = OPT_whereInFilter then result := 'Указывает, какое из условий WHERE применять для формирования списка значений на панели фильтра:'#13#10 +
    'из параметра "Условие where" - если установлено, или из "Условие для фильтра" - если нет'
  else if Option = OPT_filterWhere then result := 'Условие WHERE, используемое для формирования списка значений поля на панели фильтра.'#13#10 +
    'Правила формирования такие-же, как для параметра "Условие where". Не используется, если установлен параметр "Применять условие на фильтр"'
  else if Option = OPT_joinConst then result := 'Позволяет задать вид присоединения (INNER, LEFT, RIGHT) таблицы этого Lookup-поля к основному'#13#10 +
    'запросу выборки данных справочника. Нужно вписать ключевое слово (INNER, LEFT, RIGHT).'#13#10 +
    'Если оставить пустым - будет использовано значение по-умолчанию (LEFT)'
  else if Option = OPT_mayAdd then result := 'Включает возможность добавлять записи в таблицу Lookup-поля.'#13#10 +
    'Работает только если в параметрах поля задан справочник. В выпадающем списке добавлят в начало строку "Добавить".'#13#10 +
    'При ее выборе открывается указанный справочник и его форма добавления. После сохранения подставляет новую запись в поле ввода.'#13#10 +
    'Так же у открываемого справочника появляется возможность добавлять записи'
  else if Option = OPT_cachType then result := 'Механизм кэширования списков Lookup-полей при импорте данных:'#13#10 +
    'Если установлен флаг "загружать сразу всю таблицу", то из БД будут выбраны один раз, в начале, все записи отображаемой таблицы, и помещены в кэш.'#13#10 +
    'Если флаг снят, то предварительно кэш не заполняется, а загрузка значений из БД и добавление их в кэш будет происходить на каждой записи,'#13#10 +
    'если нужного значения там еще нет; загружаться будет только одно значение для текущей записи, а не вся таблица.'#13#10 +
    'Устанавливать этот флаг лучше только для маленькии таблиц, для больших оптимальнее снять. Для очень больших КРАЙНЕ НЕ РЕКОМЕНДУЕТСЯ УСТАНАВЛИВАТЬ!'#13#10 +
    'В обоих случаях, если установлен флаг "Применять условие where при импорте", для выбора значений будет добавлено условие where!'
  else if Option = OPT_dateShow then result := 'В поле ввода будет возможность ввести дату и добавится выпадающий календарь'
  else if Option = OPT_timeShow then result := 'В поле ввода будет возможность вводить время'
  else if Option = OPT_increment then result := 'Определяет, какие значения будут присутсвовать в списке выбора времени.'#13#10 +
    'В списке присутсвуют все часы от 00 до 23, с минутмаи. Количество значений минут зависит от заданного шага.'#13#10 +
    'Не влияет на ручной ввод - т.е. руками в поле ввода всегда можно вводить любые значения минут'
  else if Option = OPT_fromTitle then result := 'Текстовая подпись для поля, задающего начало периода'
  else if Option = OPT_toTitle then result := 'Текстовая подпись для поля, задающего конец периода'
  else if Option = OPT_maxDays then result := 'Ограничение на размер задаваемого периода в днях.'#13#10 +
    'Работает так: если установлена дата начала периода, то в поле конца периода можно будет выбрать дату не превышающую'#13#10 +
    '"дата начала" + "указанное количество дней"; если установлена дата конца периода, в поле начала периода можно выбрать'#13#10 +
    'дату, не меньше "дата конца" - "указанное количество дней".'#13#10 +
    'Если поля уже содержат неверный диапазон, то они будут подчеркнуты красным и форма не сохраниться' 
  else if Option = OPT_pkField then result := 'Необходимо для расчета логарифмического пути расположения файла на сервере.'#13#10 +
    'Значение ID поля вставляется в имя файла, по нему система сможет найти файл на сервере.'#13#10 +
    'В каждой папке хранятся файлы с определенным диапазоном ID'
  else if Option = OPT_separator then result := 'Символ, отделяющий ссылку от текста над ссылкой'
  else if Option = OPT_needName then result := 'Выводить над ссылкой имя, заданное в тексте поля ссылки (имя отделяется символом,'#13#10 +
    'заданным в параметре "Разделитель"), или выводить надпись "Скачать"'
  else if Option = OPT_showProtokol then result := 'Возможность выбора протокола'
  else if Option = OPT_defProtokol then result := 'Протокол, который будет добавлен к ссылке, если ссылка его не содержит'
  else if Option = OPT_maxCount then result := 'Ограничивает максимально возможное количество выбранных записей'
  else if Option = OPT_descriptor then result := 'Выбор справочника, на данные которого будет ссылаться поле.'#13#10 +
    'Этот справочник будет открываться для выбора записей списка'
  else if Option = OPT_fieldName then result := 'Ключевое поле выбранного справочника. Значения этого поля будут храниться'#13#10 +
    'в поле при выборе записей'
  else if Option = OPT_displayFieldName then result := 'Поле выбранного справочника, значения которого будут отображаться в поле таблицы и форм'#13#10 +
    'Показываться будут значения строк, соответствующих значениям ключевого поля, разделенные запятой'
  else if Option = OPT_isList then result := 'Применяется для справочника в виде дерева. Если установлено, то при перетаскивании'#13#10 +
    'в список выбранного будет переноситься только перетаскиваемая запись, иначе вся ветка до корня'
  else if Option = OPT_rightWidth then result := 'Ширина панели списка выбранных строк'
  else if Option = OPT_showValue then result := 'Если отмечено, то на формах, после выбора будет показан весь список выбранных строк,'#13#10 +
    'если нет - то количество выбранных записей'
  else if Option = OPT_formPk then result := 'PK формы, с которой связано поле и которая будет открыта'
  else if Option = OPT_fileSize then result := 'Максимально допустимый размер закачиваемого файла в Кб. Если пусто - размер не ограничен'
  else if Option = OPT_keepPeriod then result := 'Срок хранения файла на сервере, дней. После истечения данного срока (от времени создания файла)'#13#10 +
    'файл будет автоматически удален. Если пусто или 0 - срок не ограничен'
  else if Option = OPT_fileType then result := 'Ограничивает типы закачиваемых файлов. Несколько типов отделяются символом ",".'#13#10 +
    'Указываются расширения файлов, например: odt,ods,doc,xls'
  else if Option = OPT_isolationLoad then result := 'Если снято - файл загружается на сервер при сохранении данных формы (нажатии на "Сохранить").'#13#10 +
    'Если установлено - будет открыто модальное окно закачки файла и файл будет загружен сразу в этом окне, после чего оно будет закрыто.'#13#10 +
    'Т.о. эта возможность позволяет закачать файл до сохранения данных формы'
  else if Option = OPT_minDate then result := 'В поле ввода и выпадающем календаре доступен только выбор текущего и будущих месяцев.'#13#10 +
    'Если поле уже содержит недопустимое значение - оно будет подчеркнуто красным и форма не будет сохраняться'
  else if Option = OPT_shortLink then result := 'При отображении ссылки на файл показывать обычную или генерировать короткую ссылку'
  else if Option = OPT_selectAll then result := 'Добавлять или нет в список выбора пункт "Вбрать все"'
  else if Option = OPT_currency then result := 'Включает отображение числа в денежном формате (к числу будет добавляться сокращенное название валюты)'
  else if Option = OPT_use_where_in_import then result := 'Включает использование условия where при получении списка значений lookup при импорте из Excel'
  else if Option = OPT_noDelete then result := 'Не показывать кнопку удаления файла'
  else if Option = OPT_addBbar then result := 'Будет подсчитывать сумму по этому полю по всем отмеченным галками в таблице строкам'#13#10 +
    'и выводить ее в строке состояния таблицы'
  else if Option = OPT_separator_val then result := 'Разделитель элементов списка для отображения значения поля на форме'
  else if Option = OPT_topLabel then result := 'Располагать подписи к чекбоксу сверху'
  else result := '';
end;

function TContainer.GetOptionRecord(Index: integer): TOptionRecord;
begin
  result := nil;
  if (Index < 0) or (Index >= Length(FOptions)) then exit;
  result := FOptions[Index];
end;

function TContainer.GetOptionRecord(OptName: string): TOptionRecord;
var
  idx: integer;

begin
  result := FindControl(OptName, idx);
end;

procedure TContainer.OnComboChangeSetDataSet(OptionRec: TOptionRecord);
var
  i: integer;

begin
  for i := 1 to WordCountEx(OptionRec.ChilOptionNames, [PARAMSDELIM], []) do
    SetLookupDataset(ExtractWordEx(i, OptionRec.ChilOptionNames, [PARAMSDELIM], []), OptionRec.Value);
end;

procedure TContainer.OnGridWidthEditChange(OptionRec: TOptionRecord);
var
  s, str: string;
  i: integer;

begin
  str := '';
  s := VarToStr(OptionRec.Value);
  for i := 1 to Length(s) do
    if s[i] in ['0'..'9', ',', '.', '%'] then str := str + s[i];

  if str <> s then OptionRec.Value := str;
end;

procedure TContainer.OnLookupChangeSetDSParams(OptionRec: TOptionRecord);
var
  i: integer;

begin
  for i := 1 to WordCountEx(OptionRec.ChilOptionNames, [PARAMSDELIM], []) do
    SetDatasetParams(ExtractWordEx(i, OptionRec.ChilOptionNames, [PARAMSDELIM], []), OptionRec.ComboKeyValues, OptionRec.Value);
end;

procedure TContainer.SetDatasetParams(Option, Params: string; Values: Variant);
var
  i, idx: integer;
  p: string;
  val: Variant;

begin
  FindControl(Option, idx);
  if (idx < 0) or (not Assigned(FOptions[idx])) or (not Assigned(FOptions[idx].LookupDataSet)) then exit;

  FOptions[idx].LookupDataSet.Close;
  for i := 1 to WordCountEx(Params, [PARAMSDELIM], []) do
  begin
    p := ExtractWordEx(i, Params, [PARAMSDELIM], []);
    if VarIsArray(Values) then val := Values[i-1]
    else val := Values;

    TUniQuery(FOptions[idx].LookupDataSet).ParamByName(p).Value := val;
  end;

  Screen.Cursor := crSQLWait;
  try
    FOptions[idx].LookupDataSet.Open;
  except
    on e: Exception do Application.MessageBox(pchar(e.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;
  Screen.Cursor := crDefault;
end;

procedure TContainer.SetFieldType(AFieldType: string);
var
  vTop, vLeft: integer;
  i: integer;
  opt, fldOpts: string;
  sumWidth, maxHeight: integer;

begin
  FieldTypeStr := AFieldType;
  FFieldType := FieldTypeFromStr(AFieldType);
  ClearOptions;

  sumWidth := 0;
  maxHeight := 0;
  vTop := 8;
  vLeft := 8;
  fldOpts := GetFieldTypeOptions(FFieldType);

  for i := 1 to WordCountEx(fldOpts, [OPTSDELIM], []) do
  begin
    opt := ExtractWordEx(i, fldOpts, [OPTSDELIM], []);
    if (((opt = OPT_values) or (opt = OPT_fields) or (opt = OPT_joinFields) or (opt = OPT_where) or (opt = OPT_filterWhere)) and
      ((i < 2) or (FOptions[i-2].ControlType <> octMemo))) or
      ((opt = OPT_descTable) or (opt = OPT_descField) or (opt = OPT_fkTable) or (opt = OPT_fkField) or (opt = OPT_displayField) or
      (opt = OPT_fkRef) or (opt = OPT_fkRefField) or (opt = OPT_descriptor) or (opt = OPT_fieldName) or (opt = OPT_displayFieldName)) then
    begin
      // некоторые контролы надо располагать сначала
      vLeft := 8;
      vTop := vTop + maxHeight + 8;
      maxHeight := 0;
      sumWidth := 0;
    end;

    SetLength(FOptions, i);
    FOptions[i-1] := TOptionRecord.Create(Self, opt, vLeft, vTop, -1, -1);
    maxHeight := Max(maxHeight, FOptions[i-1].Height);
    
    if FOptions[i-1].Name = OPT_allowBlank then
    begin
      FOptions[i-1].DisplayLabel := 'Обязательно для заполнения';
    end else if FOptions[i-1].Name = OPT_defaultValue then
    begin
      FOptions[i-1].DisplayLabel := 'Значение по умолчанию';
      FOptions[i-1].ComboKeyValues := 'USER.PK' + FIELDTYPEDELIM + 'USER.LOGIN' + FIELDTYPEDELIM + 'USER.BRANCH_PK' +
        FIELDTYPEDELIM + 'USER.UNIT_PK' + FIELDTYPEDELIM + 'today' + FIELDTYPEDELIM + 'tag';
      FOptions[i-1].ComboDisplayValues := 'USER.PK' + FIELDTYPEDELIM + 'USER.LOGIN' + FIELDTYPEDELIM + 'USER.BRANCH_PK' +
        FIELDTYPEDELIM + 'USER.UNIT_PK' + FIELDTYPEDELIM + 'Текущая дата и время' + FIELDTYPEDELIM + 'Тэг справочника';
    end else if FOptions[i-1].Name = OPT_surValue then
    begin
      FOptions[i-1].DisplayLabel := 'Использовать Окружение';
      FOptions[i-1].ComboKeyValues := EMPTYVALUE + FIELDTYPEDELIM + 'USER.PK' + FIELDTYPEDELIM + 'USER.LOGIN' + FIELDTYPEDELIM +
        'USER.BRANCH_PK' + FIELDTYPEDELIM + 'USER.UNIT_PK' + FIELDTYPEDELIM + 'today' + FIELDTYPEDELIM + 'tag';
      FOptions[i-1].ComboDisplayValues := 'Не использовать' + FIELDTYPEDELIM + 'USER.PK' + FIELDTYPEDELIM + 'USER.LOGIN' + FIELDTYPEDELIM +
        'USER.BRANCH_PK' + FIELDTYPEDELIM + 'USER.UNIT_PK' + FIELDTYPEDELIM + 'Текущая дата и время' + FIELDTYPEDELIM + 'Тэг справочника';
      FOptions[i-1].DisplayValue := 'Не использовать';
    end else if FOptions[i-1].Name = OPT_maxLength then
    begin
      FOptions[i-1].DisplayLabel := 'Макс кол-во символов';
    end else if FOptions[i-1].Name = OPT_regValid then
    begin
      FOptions[i-1].DisplayLabel := 'Регулярное выражение';
    end else if FOptions[i-1].Name = OPT_regMessage then
    begin
      FOptions[i-1].DisplayLabel := 'Сообщение ошибки для рег. выражения';
      //FOptions[i-1].Hint := 'Сообщение ошибки, которое будет показано, если введенное значение не соответствует регулярному выражению';
    end else if FOptions[i-1].Name = OPT_decimalPrecision then
    begin
      FOptions[i-1].DisplayLabel := 'Знаков после запятой';
      FOptions[i-1].Value := 2;
    end else if FOptions[i-1].Name = OPT_allowNegative then
    begin
      FOptions[i-1].DisplayLabel := 'Запретить числа < 0';
    end else if FOptions[i-1].Name = OPT_allowDecimals then
    begin
      FOptions[i-1].DisplayLabel := 'Запретить дробные числа';
      FOptions[i-1].Value := true;
    end else if FOptions[i-1].Name = OPT_percent then
    begin
      FOptions[i-1].DisplayLabel := 'Проценты';
    end else if FOptions[i-1].Name = OPT_needRound then
    begin
      FOptions[i-1].DisplayLabel := 'Убирать 0 после запятой';
      FOptions[i-1].Value := true;
    end else if FOptions[i-1].Name = OPT_summaryType then
    begin
      FOptions[i-1].DisplayLabel := 'Функция группировки';
      case FFieldType of
        fctNumeric:
        begin
          FOptions[i-1].ComboKeyValues := EMPTYVALUE + FIELDTYPEDELIM + 'sum' + FIELDTYPEDELIM + 'count' + FIELDTYPEDELIM + 'max' +
            FIELDTYPEDELIM + 'min' + FIELDTYPEDELIM + 'avg' + FIELDTYPEDELIM + 'proc' + FIELDTYPEDELIM + 'proc_without_zero' +
            FIELDTYPEDELIM + 'dif';
          FOptions[i-1].ComboDisplayValues := 'Не использовать' + FIELDTYPEDELIM + 'sum' + FIELDTYPEDELIM + 'count' + FIELDTYPEDELIM +
            'max' + FIELDTYPEDELIM + 'min' + FIELDTYPEDELIM + 'avg' + FIELDTYPEDELIM + 'proc' + FIELDTYPEDELIM + 'proc_without_zero' +
            FIELDTYPEDELIM + 'dif';
        end;
        fctComboBox:
        begin
          FOptions[i-1].ComboKeyValues := EMPTYVALUE + FIELDTYPEDELIM + 'count' + FIELDTYPEDELIM + 'count_null';
          FOptions[i-1].ComboDisplayValues := 'Не использовать' + FIELDTYPEDELIM + 'count' + FIELDTYPEDELIM + 'count_null';
        end;
        fctCheckbox:
        begin
          FOptions[i-1].ComboKeyValues := EMPTYVALUE + FIELDTYPEDELIM + 'count' + FIELDTYPEDELIM + 'max'+ FIELDTYPEDELIM + 'min';
          FOptions[i-1].ComboDisplayValues := 'Не использовать' + FIELDTYPEDELIM + 'count' + FIELDTYPEDELIM + 'max'+ FIELDTYPEDELIM + 'min';
        end;
      end;
      FOptions[i-1].DisplayValue := 'Не использовать';
    end else if FOptions[i-1].Name = OPT_minValue then
    begin
      FOptions[i-1].DisplayLabel := 'Мин значение';
    end else if FOptions[i-1].Name = OPT_maxValue then
    begin
      FOptions[i-1].DisplayLabel := 'Макс значение';
    end else if FOptions[i-1].Name = OPT_height then
    begin
      FOptions[i-1].DisplayLabel := 'Высота';
    end else if FOptions[i-1].Name = OPT_values then
    begin
      FOptions[i-1].DisplayLabel := 'Список отображаемых значений (разделитель ";")';
    end else if FOptions[i-1].Name = OPT_fields then
    begin
      FOptions[i-1].DisplayLabel := 'Список ключевых значений (разделитель ";")';
      //FOptions[i-1].Hint := 'Если оставить пустым, будет использован список отображаемых значений'
    end else if FOptions[i-1].Name = OPT_joinFields then
    begin
      FOptions[i-1].DisplayLabel := 'Конструкция соединения';
    end else if FOptions[i-1].Name = OPT_descTable then
    begin
      FOptions[i-1].DisplayLabel := 'Выберите таблицу';
      FOptions[i-1].ComboKeyValues := 'NAME';
      FOptions[i-1].ComboDisplayValues := 'NAME';
      FOptions[i-1].LookupDataSet := ConnectionsList.GetDataSet(FBaseDescriptor, qtTables);
      FOptions[i-1].LookupDataSet.Open;
      FOptions[i-1].ChilOptionNames := OPT_descField;
      FOptions[i-1].OnOptChange := OnLookupChangeSetDSParams;
    end else if FOptions[i-1].Name = OPT_descField then
    begin
      FOptions[i-1].DisplayLabel := 'Выберите поле c дескриптором справочника';
      FOptions[i-1].ComboKeyValues := 'FIELD_NAME';
      FOptions[i-1].ComboDisplayValues := 'FIELD_NAME';
      FOptions[i-1].LookupDataSet := ConnectionsList.GetDataSet(FBaseDescriptor, qtFields);
    end else if FOptions[i-1].Name = OPT_where then
    begin
      FOptions[i-1].DisplayLabel := 'Условие where';
    end else if FOptions[i-1].Name = OPT_notCount then
    begin
      FOptions[i-1].DisplayLabel := 'НЕ считать количество строчек';
      FOptions[i-1].Value := true;
    end else if FOptions[i-1].Name = OPT_showAsGrid then
    begin
      FOptions[i-1].DisplayLabel := 'Выводить как грид';
    end else if FOptions[i-1].Name = OPT_localSort then
    begin
      FOptions[i-1].DisplayLabel := 'Сортировать локально';
    end else if FOptions[i-1].Name = OPT_gridWidth then
    begin
      FOptions[i-1].DisplayLabel := 'Ширина таблицы';
      FOptions[i-1].OnOptChange := OnGridWidthEditChange;
    end else if FOptions[i-1].Name = OPT_gridHeight then
    begin
      FOptions[i-1].DisplayLabel := 'Высота таблицы';
    end else if FOptions[i-1].Name = OPT_maxRow then
    begin
      FOptions[i-1].DisplayLabel := 'Максимум записей';
    end else if FOptions[i-1].Name = OPT_minRow then
    begin
      FOptions[i-1].DisplayLabel := 'Минимум записей';
    end else if FOptions[i-1].Name = OPT_rowCount then
    begin
      FOptions[i-1].DisplayLabel := 'Кол-во записей в гриде';
    end else if FOptions[i-1].Name = OPT_baseDescriptor then
    begin
      FOptions[i-1].DisplayLabel := 'База данных';
      FOptions[i-1].ComboKeyValues := FSettings.DbDescriptors;
      FOptions[i-1].ComboDisplayValues := FSettings.DbDescriptors;
      FOptions[i-1].ChilOptionNames := OPT_fkTable + PARAMSDELIM + OPT_fkField + PARAMSDELIM + OPT_displayField;
      FOptions[i-1].Value := FBaseDescriptor;
      FOptions[i-1].OnOptChange := OnComboChangeSetDataSet;
    end else if FOptions[i-1].Name = OPT_fkTable then
    begin
      FOptions[i-1].DisplayLabel := 'Выберите таблицу';
      FOptions[i-1].ComboKeyValues := 'NAME';
      FOptions[i-1].ComboDisplayValues := 'NAME';
      FOptions[i-1].LookupDataSet := ConnectionsList.GetDataSet(FBaseDescriptor, qtProcedures);
      FOptions[i-1].LookupDataSet.Open;
      FOptions[i-1].ChilOptionNames := OPT_fkField + PARAMSDELIM + OPT_displayField;
      FOptions[i-1].OnOptChange := OnLookupChangeSetDSParams;
    end else if FOptions[i-1].Name = OPT_fkField then
    begin
      FOptions[i-1].DisplayLabel := 'Выберите поле таблицы';
      FOptions[i-1].ComboKeyValues := 'FIELD_NAME';
      FOptions[i-1].ComboDisplayValues := 'FIELD_NAME';
      FOptions[i-1].LookupDataSet := ConnectionsList.GetDataSet(FBaseDescriptor, qtFields);
    end else if FOptions[i-1].Name = OPT_displayField then
    begin
      FOptions[i-1].DisplayLabel := 'Выберите поле для отображения';
      FOptions[i-1].ComboKeyValues := 'FIELD_NAME';
      FOptions[i-1].ComboDisplayValues := 'FIELD_NAME';
      FOptions[i-1].LookupDataSet := ConnectionsList.GetDataSet(FBaseDescriptor, qtFields);
    end else if FOptions[i-1].Name = OPT_fkRef then
    begin
      FOptions[i-1].DisplayLabel := 'Выберите Справочник';
      FOptions[i-1].ComboKeyValues := 'DESCRIPTOR_';
      FOptions[i-1].ComboDisplayValues := 'NAME';
      FOptions[i-1].LookupDataSet := ConnectionsList.GetDataSet(DBDESC_FB, qtReference);
      FOptions[i-1].LookupDataSet.Open;
      FOptions[i-1].ChilOptionNames := OPT_fkRefField;
      FOptions[i-1].OnOptChange := OnLookupChangeSetDSParams;
    end else if FOptions[i-1].Name = OPT_fkRefField then
    begin
      FOptions[i-1].DisplayLabel := 'Выберите поле справочника';
      FOptions[i-1].ComboKeyValues := 'FIELD_NAME';
      FOptions[i-1].ComboDisplayValues := 'FIELD_NAME';
      FOptions[i-1].LookupDataSet := ConnectionsList.GetDataSet(DBDESC_FB, qtRefFields);
    end else if FOptions[i-1].Name = OPT_whereInFilter then
    begin
      FOptions[i-1].DisplayLabel := 'Применять условие на фильтр';
    end else if FOptions[i-1].Name = OPT_filterWhere then
    begin
      FOptions[i-1].DisplayLabel := 'Условие для фильтра';
    end else if FOptions[i-1].Name = OPT_joinConst then
    begin
      FOptions[i-1].DisplayLabel := 'Конструкция присоединения';
    end else if FOptions[i-1].Name = OPT_mayAdd then
    begin
      FOptions[i-1].DisplayLabel := 'Можно добавлять';
    end else if FOptions[i-1].Name = OPT_cachType then
    begin
      FOptions[i-1].DisplayLabel := 'Кэшировать при импорте сразу всю таблицу';
    end else if FOptions[i-1].Name = OPT_dateShow then
    begin
      FOptions[i-1].DisplayLabel := 'Выводить дату';
      FOptions[i-1].Value := true;
    end else if FOptions[i-1].Name = OPT_timeShow then
    begin
      FOptions[i-1].DisplayLabel := 'Выводить время';
    end else if FOptions[i-1].Name = OPT_increment then
    begin
      FOptions[i-1].DisplayLabel := 'Шаг времени, мин';
    end else if FOptions[i-1].Name = OPT_fromTitle then
    begin
      FOptions[i-1].DisplayLabel := 'Заголовок начала периода';
    end else if FOptions[i-1].Name = OPT_toTitle then
    begin
      FOptions[i-1].DisplayLabel := 'Заголовок конца периода';
    end else if FOptions[i-1].Name = OPT_maxDays then
    begin
      FOptions[i-1].DisplayLabel := 'Макс длина периода';
    end else if FOptions[i-1].Name = OPT_pkField then
    begin
      FOptions[i-1].DisplayLabel := 'Имя поля с ID записи';
      //if FFieldType = fctFileField then FOptions[i-1].Value := 'PK';
    end else if FOptions[i-1].Name = OPT_separator then
    begin
      FOptions[i-1].DisplayLabel := 'Разделитель';
      FOptions[i-1].Value := ';';
    end else if FOptions[i-1].Name = OPT_needName then
    begin
      FOptions[i-1].DisplayLabel := 'Выводить имя в ссылке';
    end else if FOptions[i-1].Name = OPT_showProtokol then
    begin
      FOptions[i-1].DisplayLabel := 'Выбор протокола';
    end else if FOptions[i-1].Name = OPT_defProtokol then
    begin
      FOptions[i-1].DisplayLabel := 'Протокол по умолчанию';
      FOptions[i-1].ComboKeyValues := 'http://' + FIELDTYPEDELIM + 'mailto:' + FIELDTYPEDELIM + 'file:///' + FIELDTYPEDELIM + EMPTYVALUE;
      FOptions[i-1].ComboDisplayValues := 'http://' + FIELDTYPEDELIM + 'mailto:' + FIELDTYPEDELIM + 'file:///' + FIELDTYPEDELIM + 'Пусто';
      FOptions[i-1].Value := 'http://';
    end else if FOptions[i-1].Name = OPT_maxCount then
    begin
      FOptions[i-1].DisplayLabel := 'Макс кол-во выбранных';
    end else if FOptions[i-1].Name = OPT_descriptor then
    begin
      FOptions[i-1].DisplayLabel := 'Выберите Справочник';
      FOptions[i-1].ComboKeyValues := 'DESCRIPTOR_';
      FOptions[i-1].ComboDisplayValues := 'NAME';
      FOptions[i-1].LookupDataSet := ConnectionsList.GetDataSet(DBDESC_FB, qtReference);
      FOptions[i-1].LookupDataSet.Open;
      FOptions[i-1].ChilOptionNames := OPT_fieldName + PARAMSDELIM + OPT_displayFieldName;
      FOptions[i-1].OnOptChange := OnLookupChangeSetDSParams;
    end else if FOptions[i-1].Name = OPT_fieldName then
    begin
      FOptions[i-1].DisplayLabel := 'Выберите поле справочника';
      FOptions[i-1].ComboKeyValues := 'FIELD_NAME';
      FOptions[i-1].ComboDisplayValues := 'FIELD_NAME';
      FOptions[i-1].LookupDataSet := ConnectionsList.GetDataSet(DBDESC_FB, qtRefFields2);
    end else if FOptions[i-1].Name = OPT_displayFieldName then
    begin
      FOptions[i-1].DisplayLabel := 'Выберите выводимое поле справочника';
      FOptions[i-1].ComboKeyValues := 'FIELD_NAME';
      FOptions[i-1].ComboDisplayValues := 'FIELD_NAME';
      FOptions[i-1].LookupDataSet := ConnectionsList.GetDataSet(DBDESC_FB, qtRefFields2);
    end else if FOptions[i-1].Name = OPT_isList then
    begin
      FOptions[i-1].DisplayLabel := 'В выборе плоский список';
    end else if FOptions[i-1].Name = OPT_rightWidth then
    begin
      FOptions[i-1].DisplayLabel := 'Ширина правой части';
    end else if FOptions[i-1].Name = OPT_showValue then
    begin
      FOptions[i-1].DisplayLabel := 'Отображать значения';
    end else if FOptions[i-1].Name = OPT_formPk then
    begin
      FOptions[i-1].DisplayLabel := 'PK формы';
    end else if FOptions[i-1].Name = OPT_fileSize then
    begin
      FOptions[i-1].DisplayLabel := 'Максимальный размер файла, кб';
      FOptions[i-1].Value := 5120;
    end else if FOptions[i-1].Name = OPT_keepPeriod then
    begin
      FOptions[i-1].DisplayLabel := 'Срок хранения, дней';
      //FOptions[i-1].Value := 0;
      FOptions[i-1].MaxValue := 65536;
      FOptions[i-1].MinValue := 0;
    end else if FOptions[i-1].Name = OPT_fileType then
    begin
      FOptions[i-1].DisplayLabel := 'Тип файла';
    end else if FOptions[i-1].Name = OPT_isolationLoad then
    begin
      FOptions[i-1].DisplayLabel := 'Загружать файл отдельно';
    end else if FOptions[i-1].Name = OPT_minDate then
    begin
      FOptions[i-1].DisplayLabel := 'Только будущие месяцы';
    end else if FOptions[i-1].Name = OPT_shortLink then
    begin
      FOptions[i-1].DisplayLabel := 'Короткая ссылка';
    end else if FOptions[i-1].Name = OPT_selectAll then
    begin
      FOptions[i-1].DisplayLabel := 'Возможность выбрать все';
    end else if FOptions[i-1].Name = OPT_currency then
    begin
      FOptions[i-1].DisplayLabel := 'Денежный формат';
    end else if FOptions[i-1].Name = OPT_use_where_in_import then
    begin
      FOptions[i-1].DisplayLabel := 'Применять условие where при импорте';
    end else if FOptions[i-1].Name = OPT_noDelete then
    begin
      FOptions[i-1].DisplayLabel := 'Не разрешать удаление';
    end else if FOptions[i-1].Name = OPT_addBbar then
    begin
      FOptions[i-1].DisplayLabel := 'Суммировать значения по выделенным строкам';
    end else if FOptions[i-1].Name = OPT_separator_val then
    begin
      FOptions[i-1].DisplayLabel := 'Разделитель';
      FOptions[i-1].Value := ', <br/>';
    end else if FOptions[i-1].Name = OPT_topLabel then
    begin
      FOptions[i-1].DisplayLabel := 'Подписи сверху';
    end;

    // хинты
    FOptions[i-1].Hint := GetOptionHint(FOptions[i-1].Name);

    // расположение
    sumWidth := sumWidth + FOptions[i-1].Left + FOptions[i-1].Width;
    if sumWidth >= (FContainer.Width - 300) then
    begin
      // если суммарная ширина в ряду больше ширины контейнера (т.е. мы вылазиим за его правую границу) - начинаем новый ряд
      vLeft := 8;
      vTop := vTop + maxHeight + 8;
      maxHeight := 0;
      sumWidth := 0;
    end else
    begin
      // иначе перелазиим в следующую колонку
      vLeft := FOptions[i-1].Left + FOptions[i-1].Width + 25;
    end;
  end;
end;

procedure TContainer.SetLookupDataset(Option, DBDescriptor: string);
var
  idx: integer;

begin
  FindControl(Option, idx);
  if (idx < 0) or (not Assigned(FOptions[idx])) or (not Assigned(FOptions[idx].LookupDataSet)) then exit;

  FOptions[idx].LookupDataSet := ConnectionsList.GetDataSet(DBDescriptor, TQueryType(TUniQuery(FOptions[idx].LookupDataSet).Tag),
    TUniQuery(FOptions[idx].LookupDataSet).SQL.Text);
    
  if TUniQuery(FOptions[idx].LookupDataSet).ParamCount <= 0 then
  try
    Screen.Cursor := crSQLWait;
    FOptions[idx].LookupDataSet.Open;
  except
    on e: Exception do Application.MessageBox(pchar(e.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;
  Screen.Cursor := crDefault;
end;

end.
