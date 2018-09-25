unit filterConfigEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Mask,
  ComCtrls, utils, DB, ActnList, settings, ToolCtrlsEh, DBCtrlsEh, main, childForm, MemTableDataEh, MemTableEh, DBCtrls,
  StrUtils, json, MemDS, DBAccess, Uni, UniProvider, PostgreSQLUniProvider, OracleUniProvider, MySQLUniProvider,
  InterBaseUniProvider, optControls, dbUtils, JvCombobox, DateUtils, DBGridEhGrouping, GridsEh, DBGridEh, DBLookupEh;

type
  TExpression = (exNone = -1, exEqual, exNotEqual, exLike, exNotLike, exStartWith, exIn, exLarge, exSmall, exEqLarge, exEqSmall,
    exIsNull, exIsNotNull);
  TConcat = (ccAnd, ccOr);
  TControlType = (ctEdit, ctMemo, ctNumeric, ctCombo, ctCheckBox, ctLookup, ctDateTime, ctDate, ctTime, ctMonth);

  TCtrlParam = record
    Name: string;
    Value: string;
  end;

  TCtrlParams = array of TCtrlParam;

  TRecordBase = class
  private
    FParent: TWinControl;
    Fields: TMemTableEh;
    LookupList: TDBGridEh;
    LookupSource: TDataSource;
    LookupDataSet: TUniQuery;
    LookupKeyField: string;
    LookupDisplayField: string;
    FFilterIndex: integer;
    ValueObjType: TControlType;
    ValueKeyValues: TStringList;
    FieldPK: integer;
    ObjectName: string;
    FieldName: string;
    FTitle: string;
    FieldType: string;
    Params: TCtrlParams;
    FTop: integer;
    RusExpr: boolean;
    LookupLoaded: boolean;
    // контролы
    ValueObj1: TControl;
    ValueObj2: TControl;
    ExLabel1: TLabel;
    ExLabel2: TLabel;
    FUsed: TCheckBox;
    FieldConcObj: TComboBox;
    procedure SetTop(val: integer);
    procedure SetValue(val: string);
    function GetValue: string;
    procedure SetExtraValue(val: string);
    function GetExtraValue: string;
    procedure SetConcat(val: TConcat);
    function GetConc: TConcat;
    procedure SetUsed(value: boolean);
    function GetUsed: boolean;
    procedure SetExpression(val: TExpression);
    function GetExpr: TExpression;
    procedure SetField(PK: integer);
    //
    function GetValueCtrlType(TypeName: string): TControlType;
    procedure LoadFieldTypeParams(ParamsStr: string);
    function GetParamValue(ValName: string): string;
    procedure LoadLookup;
    procedure SetGridDefParams;
    // реакция на события
    procedure CheckBoxClick(Sender: TObject);
    procedure CtrlChange(Sender: TObject);
    function GetKeyName: string;
    procedure LookupButtonClick(Sender: TObject; var Handled: Boolean);
    procedure LookupListSelectionChanged(Sender: TObject);
    procedure LookupListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    PreviewProc: procedure of object;
    constructor Create(AParent: TWinControl; AFields: TMemTableEh; ATop: integer; FldPK: integer; AValue: string;
      Expr: TExpression; ConcRule: TConcat; AFilterIndex: integer);
    destructor Destroy; override;
    property Used: boolean read GetUsed write SetUsed;
    property Top: integer read FTop write SetTop;
    property Expression: TExpression read GetExpr write SetExpression;
    property Value: string read GetValue write SetValue;
    property ExtraValue: string read GetExtraValue write SetExtraValue;
    property FieldConcat: TConcat read GetConc write SetConcat;
    property ValueType: TControlType read ValueObjType;
    property KeyName: string read GetKeyName;
    property FilterIndex: integer read FFilterIndex;
  end;

  TRecordsBase = array of TRecordBase;

  TFFilterConfigEditor = class(TChildForm)
    GroupBox1: TGroupBox;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    Label2: TLabel;
    edPk: TEdit;
    Label10: TLabel;
    edTitle: TEdit;
    ActionList: TActionList;
    ASave: TAction;
    ScrollBox: TScrollBox;
    Panel1: TPanel;
    Label1: TLabel;
    rePreview: TRichEdit;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    RecordsBase: TRecordsBase;
    FString: string;
    FDataSet: TMemTableEh;
    procedure SetTemplate(tmpl: string);
    function GetTemplate: string;
    procedure FreeRecords;
    function SetRecord(FieldPK: integer; Value, ExValue: string; AExpr: TExpression; AConcRule: TConcat): integer;
    procedure SetControls;
    procedure SetDataSet(ds: TMemTableEh);
    procedure ShowPreview;
    procedure ParseValue(s: string; SL: TStringList);
    procedure ParseExpression(expr: TStringList; SL: TStringList);
    procedure SetMode(Value: TOpenMode); override;
  public
    EditingRec: TBookmark;
    procedure RegisterForm;
    function GetShortCaption: string; override;
    property Fields: TMemTableEh read FDataSet write SetDataSet; // 1
    property Template: string read GetTemplate write SetTemplate; // 2 тут происходит SetControls
  end;

implementation

{$R *.dfm}

const
  CTRLHEIGHT = 21;
  LOOKUPFIELDSDELIM = ';';
  VAL_DELIM = '^_^';
  // логические выражения
  CC_AND = 'AND';
  CC_AND_RU = 'И';
  CC_OR = 'OR';
  CC_OR_RU = 'ИЛИ';
  EX_EQUAL = '=';
  EX_EQUAL_RU = 'равно';
  EX_NOT_EQUAL = '<>';
  EX_NOT_EQUAL_RU = 'не равно';
  EX_LIKE = 'LIKE';
  EX_LIKE_RU = 'содержит';
  EX_NOT_LIKE = 'NOT LIKE';
  EX_NOT_LIKE_RU = 'не содержит';
  EX_START_WITH = 'STARTING';
  EX_START_WITH_RU = 'начинается с';
  EX_IN = 'IN';
  EX_IN_RU = 'один из';
  EX_LARGE = '>';
  EX_SMALL = '<';
  EX_EQ_LARGE = '>=';
  EX_EQ_SMALL = '<=';
  EX_IS_NULL = 'IS NULL';
  EX_IS_NULL_RU = 'пусто';
  EX_IS_NOT_NULL = 'IS NOT NULL';
  EX_IS_NOT_NULL2 = 'NOT IS NULL';
  EX_IS_NOT_NULL_RU = 'не пусто';

function GetConcat(s: string): TConcat;
begin
  result := ccAnd;
  if (UpperCase(s) = CC_OR) or (AnsiUpperCase(s) = CC_OR_RU) then result := ccOr
  else if (UpperCase(s) = CC_AND) or (AnsiUpperCase(s) = CC_AND_RU) then result := ccAnd;
end;

function GetConcatStr(c: TConcat): string;
begin
  result := '';
  case c of
    ccAnd: result := CC_AND;
    ccOr: result := CC_OR;
  end;
end;

function GetExpression(s: string): TExpression;
begin
  if (s = EX_EQUAL) or (AnsiLowerCase(s) = EX_EQUAL_RU) then result := exEqual
  else if (s = EX_NOT_EQUAL) or (AnsiLowerCase(s) = EX_NOT_EQUAL_RU) then result := exNotEqual
  else if (UpperCase(s) = EX_LIKE) or (AnsiLowerCase(s) = EX_LIKE_RU) then result := exLike
  else if (UpperCase(s) = EX_NOT_LIKE) or (AnsiLowerCase(s) = EX_NOT_LIKE_RU) then result := exNotLike
  else if (UpperCase(s) = EX_START_WITH) or (AnsiLowerCase(s) = EX_START_WITH_RU) then result := exStartWith
  else if (UpperCase(s) = EX_IN) or (AnsiLowerCase(s) = EX_IN_RU) then result := exIn
  else if s = EX_LARGE then result := exLarge
  else if s = EX_SMALL then result := exSmall
  else if s = EX_EQ_LARGE then result := exEqLarge
  else if s = EX_EQ_SMALL then result := exEqSmall
  else if (UpperCase(s) = EX_IS_NULL) or (AnsiLowerCase(s) = EX_IS_NULL_RU) then result := exIsNull
  else if (UpperCase(s) = EX_IS_NOT_NULL) or (UpperCase(s) = EX_IS_NOT_NULL2) or (AnsiLowerCase(s) = EX_IS_NOT_NULL_RU) then
    result := exIsNotNull
  else result := exNone;
end;

function ExprAsString(Expr: TExpression; Rus: boolean): string;
begin
  case Expr of
    exNone: result := '';
    exEqual: result := iif(Rus, EX_EQUAL_RU, EX_EQUAL);
    exNotEqual: result := iif(Rus, EX_NOT_EQUAL_RU, EX_NOT_EQUAL);
    exLike: result := iif(Rus, EX_LIKE_RU, EX_LIKE);
    exNotLike: result := iif(Rus, EX_NOT_LIKE_RU, EX_NOT_LIKE);
    exStartWith: result := iif(Rus, EX_START_WITH_RU, EX_LIKE {EX_START_WITH});
    exIn: result := iif(Rus, EX_IN_RU, EX_IN);
    exLarge: result := EX_LARGE;
    exSmall: result := EX_SMALL;
    exEqLarge: result := EX_EQ_LARGE;
    exEqSmall: result := EX_EQ_SMALL;
    exIsNull: result := iif(Rus, EX_IS_NULL_RU, EX_IS_NULL);
    exIsNotNull: result := iif(Rus, EX_IS_NOT_NULL_RU, EX_IS_NOT_NULL);
  end;
end;

procedure TFFilterConfigEditor.ASaveExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then btnSaveClick(btnSave);
end;

procedure TFFilterConfigEditor.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFFilterConfigEditor.btnSaveClick(Sender: TObject);
begin
  if Mode = omView then exit;
  Success := true;
  Close;
end;

procedure TFFilterConfigEditor.FormActivate(Sender: TObject);
begin
  ASave.Enabled := true;
  FMain.CheckFormButton(Tag);
end;

procedure TFFilterConfigEditor.FormCreate(Sender: TObject);
begin
  SetLength(RecordsBase, 0);
end;

procedure TFFilterConfigEditor.FormDeactivate(Sender: TObject);
begin
  ASave.Enabled := false;
end;

procedure TFFilterConfigEditor.FormDestroy(Sender: TObject);
begin
  FreeRecords;
end;

procedure TFFilterConfigEditor.FreeRecords;
var
  i: integer;

begin
  for i := 0 to Length(RecordsBase) - 1 do
    if Assigned(RecordsBase[i]) then FreeAndNil(RecordsBase[i]);

  SetLength(RecordsBase, 0);
end;

function TFFilterConfigEditor.GetShortCaption: string;
begin
  if Mode = omAdd then
    result := Caption
  else
    result := 'Конфигурация фильтров ' + edTitle.Text;
end;

function TFFilterConfigEditor.GetTemplate: string;
var
  i: integer;
  str: string;
  
begin
  //  - попросили убрать пробелы между параметрами и ключами, а то портал давится
  result := '';

  for i := 0 to Length(RecordsBase) - 1 do
    if RecordsBase[i].Used then
    begin
      //str := '"' + RecordsBase[i].KeyName + '": {"value": "';
      str := '"' + RecordsBase[i].KeyName + '":{"value":"';

      case RecordsBase[i].ValueObjType of
        ctEdit:
        begin
          if RecordsBase[i].Expression = exStartWith then str := str + ' ' + ExprAsString(exLike, false) + ' '
          else if RecordsBase[i].Expression <> exNone then str := str + ' ' + ExprAsString(RecordsBase[i].Expression, false) + ' ';

          if (RecordsBase[i].Expression in [exIsNull, exIsNotNull]) and (str <> '') and (str[Length(str)] = ' ') then
            Delete(str, Length(str), 1);

          case RecordsBase[i].Expression of
            exNone, exEqual, exNotEqual: str := str + '''' + RecordsBase[i].Value + '''';
            exLike, exNotLike: str := str + '''%%' + RecordsBase[i].Value + '%%''';
            exStartWith: str := str + '''' + RecordsBase[i].Value + '%%''';
            exIsNull, exIsNotNull: ; // value пропускаем
          end;
        end;
        ctNumeric:
        begin
          if RecordsBase[i].FilterIndex = 2 then
            str := str + ' >=''' + RecordsBase[i].ExtraValue + '''' + VAL_DELIM + ' <=''' + RecordsBase[i].Value + ''''
          else begin // 1, ...
            if RecordsBase[i].Expression <> exNone then str := str + ExprAsString(RecordsBase[i].Expression, false) + ' ';
            str := str + '''' + RecordsBase[i].Value + '''';
          end;
        end;
        ctDateTime, ctDate, ctTime:
        begin
          if RecordsBase[i].FilterIndex = 2 then str := str + ' >= ' + RecordsBase[i].Value
          else str := str + ' >=''' + RecordsBase[i].ExtraValue + '''' + VAL_DELIM + ' <=''' + RecordsBase[i].Value + '''';
        end;
        ctMonth:
        begin
          if RecordsBase[i].FilterIndex = 2 then str := str + RecordsBase[i].Value
          else str := str + ' >=''' + RecordsBase[i].ExtraValue + '''' + VAL_DELIM + ' <=''' + RecordsBase[i].Value + '''';
        end;
        else str := str + RecordsBase[i].Value;
      end;

      //str := str + '", "bound": "' + GetConcatStr(RecordsBase[i].FieldConcat) + '"}';
      str := str + '","bound":"' + GetConcatStr(RecordsBase[i].FieldConcat) + '"}';

      if result = '' then result := str
      //else result := result + ', ' + str;
      else result := result + ',' + str;
    end;

  result := '{' + result + '}';
end;

procedure TFFilterConfigEditor.ParseExpression(expr, SL: TStringList);
var
  i: integer;
  e, v, exv, str: string;

begin
  // результат - список из 3-х элементов: 1 - оператор, 2 - выражение после оператора, 3 - доп. выражение
  SL.Clear;
  e := '';
  v := '';
  exv := '';

  for i := 0 to expr.Count - 1 do
  begin
    if (expr.Strings[i] = EX_EQUAL) or (expr.Strings[i] = EX_NOT_EQUAL) or (expr.Strings[i] = EX_LIKE) or
      (expr.Strings[i] = EX_START_WITH) or (expr.Strings[i] = EX_IN) or (expr.Strings[i] = EX_LARGE) or
      (expr.Strings[i] = EX_SMALL) or (expr.Strings[i] = EX_EQ_LARGE) or (expr.Strings[i] = EX_EQ_SMALL) or
      (expr.Strings[i] = 'NULL') or (expr.Strings[i] = 'NOT') or (expr.Strings[i] = 'IS') then
    begin
      if e = '' then e := expr.Strings[i]
      else e := e + ' ' + expr.Strings[i];
    end else
    begin
      if v = '' then v := expr.Strings[i]
      else v := v + ' ' + expr.Strings[i];
    end;
  end;

  str := StringReplace(v, VAL_DELIM, #4, [rfReplaceAll]);
  if WordCountEx(str, [#4], ['''']) > 1 then
  begin
    exv := ExtractWordEx(1, str, [#4], ['''']);
    v := ExtractWordEx(2, str, [#4], ['''']);
  end;

  SL.Add(e);
  SL.Add(v);
  SL.Add(exv);
end;

procedure TFFilterConfigEditor.ParseValue(s: string; SL: TStringList);
var
  i: integer;
  bracket: boolean;
  _ts: string;
  tmpSl: TStringList;

begin
  bracket := false;
  i := 1;

  tmpSl := TStringList.Create;
  try
    s := StringReplace(StringReplace(s, '<?', #3, [rfReplaceAll]), '?>', #4, [rfReplaceAll]);
    while i <= Length(s) do
    begin
      if s[i] = #39 then //одинарная кавычка или символ экранирования'
        bracket := not bracket;
      if (not bracket) and ((s[i] = '=') or (s[i] = '<') or (s[i] = '>')) then
      begin
        if (i > 1) and (s[i-1] <> ' ') then
          if (s[i-1] <> '=') and (s[i-1] <> '<') and (s[i-1] <> '>') then
            Insert(' ', s, i);
        if (i < Length(s)) and (s[i+1] <> ' ') then
          if (s[i+1] <> '=') and (s[i+1] <> '<') and (s[i+1] <> '>') then
            Insert(' ', s, i+1);
      end;
      if (s[i] <> ' ') or bracket then
        _ts := _ts + s[i];
      if (not bracket) and (s[i] = ' ') then
        if (_ts) <> '' then
        begin
          tmpSl.Add(Trim(StringReplace(StringReplace(_ts, #3, '<?', [rfReplaceAll]), #4, '?>', [rfReplaceAll])));
          _ts := '';
        end;
      Inc(i);
    end;

    if (_ts <> '') and ((tmpSl.Count = 0) or (_ts <> tmpSl.Strings[tmpSl.count - 1])) then
      tmpSl.Add(Trim(StringReplace(StringReplace(_ts, #3, '<?', [rfReplaceAll]), #4, '?>', [rfReplaceAll])));

    ParseExpression(tmpSl, SL);
  finally
    tmpSl.Free;
  end;
end;

procedure TFFilterConfigEditor.RegisterForm;
begin
  case Mode of
    omAdd: ;
    omEdit: Caption := GenCaption('Конфигурация фильтров', 'редактирование', edPk.Text, '', edTitle.Text, false);
    omView: Caption := GenCaption('Конфигурация фильтров', 'просмотр', edPk.Text, '', edTitle.Text, false);
  end;

  FMain.RegisterChildForm(Self);
end;

procedure TFFilterConfigEditor.SetControls;
var
  conc: TConcat;
  objName, fldName: string;
  json, j: TJson;
  i: integer;
  pk: integer;
  sl: TStringList;

begin
  if FString = '' then exit;

  sl := TStringList.Create;
  json := TJson.Create;
  try
    json.Load(FString);

    for i := 0 to json.KeyCount - 1 do
    begin
      pk := 0;
      SplitFieldName(json.Keys[i], objName, fldName);

      if FDataSet.Locate('OBJECT_NAME;FIELD_NAME', VarArrayOf([objName, fldName]), [loCaseInsensitive]) then
        pk := FDataSet.FieldByName('PK').AsInteger;

      j := json.AsObject(json.Keys[i]);
      ParseValue(j.ValueOf('value'), sl);
      if UpperCase(j.ValueOf('bound')) = CC_OR then conc := ccOr
      else conc := ccAnd;

      SetRecord(pk, sl.Strings[1], sl.Strings[2], GetExpression(sl.Strings[0]), conc);
    end;
  finally
    sl.Free;
    json.Free;
  end;
end;

procedure TFFilterConfigEditor.SetDataSet(ds: TMemTableEh);
var
  _top: integer;
  bm: TBookmark;

begin
  FreeRecords;
  FDataSet := ds;
  bm := FDataSet.GetBookmark;
  FDataSet.DisableControls;
  _top := 6;
  Screen.Cursor := crHourGlass;

  try
    FDataSet.First;
    while not FDataSet.Eof do
    begin
      if (FDataSet.FieldByName('IS_FILTER').AsInteger > 0) and (FDataSet.FieldByName('TYPE_NAME').AsString <> FIELDTYPE_hidden) and
        (FDataSet.FieldByName('TYPE_NAME').AsString <> FIELDTYPE_ChildTable) and
        (FDataSet.FieldByName('TYPE_NAME').AsString <> FIELDTYPE_datePeriod) and
        (FDataSet.FieldByName('TYPE_NAME').AsString <> FIELDTYPE_photo) and
        (FDataSet.FieldByName('TYPE_NAME').AsString <> FIELDTYPE_link) and
        (FDataSet.FieldByName('TYPE_NAME').AsString <> FIELDTYPE_MultipleLookUp) and
        (FDataSet.FieldByName('TYPE_NAME').AsString <> FIELDTYPE_FormField) and
        (FDataSet.FieldByName('TYPE_NAME').AsString <> FIELDTYPE_FileField) and
        (FDataSet.FieldByName('TYPE_NAME').AsString <> FIELDTYPE_Button) then
      begin
        try
          SetLength(RecordsBase, Length(RecordsBase) + 1);
          RecordsBase[High(RecordsBase)] := TRecordBase.Create(ScrollBox, ds, _top, FDataSet.FieldByName('PK').AsInteger, '',
            exEqual, ccAnd, FDataSet.FieldByName('IS_FILTER').AsInteger);
          _top := _top + CTRLHEIGHT + 1;
          RecordsBase[High(RecordsBase)].PreviewProc := ShowPreview;
        except
          SetLength(RecordsBase, Length(RecordsBase) - 1);
        end;
      end;

      FDataSet.Next;
    end;
  finally
    Screen.Cursor := crDefault;
    if FDataSet.BookmarkValid(bm) then FDataSet.GotoBookmark(bm)
    else FDataSet.First;
    FDataSet.EnableControls;
  end;
end;

procedure TFFilterConfigEditor.SetMode(Value: TOpenMode);
begin
  inherited SetMode(Value);

  if Mode = omView then
  begin
    btnSave.Enabled := false;
    edTitle.ReadOnly := true;
    edTitle.Color := clBtnFace;
  end;
end;

function TFFilterConfigEditor.SetRecord(FieldPK: integer; Value, ExValue: string; AExpr: TExpression; AConcRule: TConcat): integer;
var
  i: integer;

begin
  result := -1;

  for i := 0 to Length(RecordsBase) - 1 do
  begin
    if RecordsBase[i].FieldPK = FieldPK then
    begin
      if (AExpr = exLike) and (Pos('%%', Value) <> 1) then AExpr := exStartWith;
      result := i;
      RecordsBase[i].Used := true;
      RecordsBase[i].Expression := AExpr;
      RecordsBase[i].FieldConcat := AConcRule;
      RecordsBase[i].Value := Value;
      RecordsBase[i].ExtraValue := ExValue;
      break;
    end;
  end;
end;

procedure TFFilterConfigEditor.SetTemplate(tmpl: string);
begin
  FString := Tmpl;
  SetControls;
end;

procedure TFFilterConfigEditor.ShowPreview;
begin
  rePreview.Lines.Text := Template;
end;

{ TRecordBase }

procedure TRecordBase.CheckBoxClick(Sender: TObject);
begin
  FieldConcObj.Enabled := TCheckBox(Sender).Checked;
  if Assigned(ValueObj1) then ValueObj1.Enabled := TCheckBox(Sender).Checked;
  if Assigned(ValueObj2) then ValueObj2.Enabled := TCheckBox(Sender).Checked;
  if Assigned(ExLabel1) then ExLabel1.Enabled := TCheckBox(Sender).Checked;
  if Assigned(ExLabel2) then ExLabel2.Enabled := TCheckBox(Sender).Checked;
  if TCheckBox(Sender).Checked then
    try
      if Assigned(ValueObj1) then TWinControl(ValueObj1).SetFocus
      else if Assigned(ValueObj2) then TWinControl(ValueObj2).SetFocus;
    except
    end;

  //if TCheckBox(Sender).Checked then LoadLookup;
  if Assigned(PreviewProc) then PreviewProc;
end;

constructor TRecordBase.Create(AParent: TWinControl; AFields: TMemTableEh; ATop: integer; FldPK: integer; AValue: string;
  Expr: TExpression; ConcRule: TConcat; AFilterIndex: integer);
begin
  if not Assigned(AParent) then
    raise Exception.Create('Не удалось создать строку: отсутствует объект владелец элемента!');
  if not Assigned(AFields) then
    raise Exception.Create('Не удалось создать строку: не указан список полей!');

  inherited Create;

  LookupLoaded := false;
  FParent := AParent;
  Fields := AFields;
  LookupDataSet := TUniQuery.Create(AParent.Owner);
  LookupSource := TDataSource.Create(AParent.Owner);
  LookupList := TDBGridEh.Create(AParent.Owner);
  LookupList.Parent := AParent;
  LookupSource.DataSet := LookupDataSet;
  LookupList.DataSource := LookupSource;
  SetGridDefParams;
  LookupDataSet.Options.QueryRecCount := true; 
  ValueKeyValues := TStringList.Create;
  FFilterIndex := AFilterIndex;

  SetField(FldPK);
  SetValue(AValue);
  Top := ATop;
  Expression := Expr;
  FieldConcat := ConcRule;
end;

procedure TRecordBase.CtrlChange(Sender: TObject);
begin
  if Assigned(PreviewProc) then PreviewProc;
end;

destructor TRecordBase.Destroy;
begin
  SetLength(Params, 0);
  if LookupDataSet.Active then LookupDataSet.Close;
  LookupList.Free;
  LookupSource.Free;
  LookupDataSet.Free;
  ValueKeyValues.Free;
  if Assigned(ValueObj1) then ValueObj1.Free;
  if Assigned(ValueObj2) then ValueObj2.Free;
  if Assigned(ExLabel1) then ExLabel1.Free;
  if Assigned(ExLabel2) then ExLabel2.Free;
  if Assigned(FUsed) then FUsed.Free;
  if Assigned(FieldConcObj) then FieldConcObj.Free;
  inherited Destroy;
end;

function TRecordBase.GetConc: TConcat;
begin
  result := GetConcat(FieldConcObj.Text);
end;

function TRecordBase.GetExpr: TExpression;
begin
  if ValueObj1 is TComboBox then result := GetExpression(TComboBox(ValueObj1).Text)
  else result := exEqual;
end;

function TRecordBase.GetExtraValue: string;
var
  dt: TDateTime;
  
begin
  result := '';
  if (not Assigned(ValueObj1)) then exit;

  case ValueObjType of
    ctEdit, ctMemo: ;
    ctNumeric:
      if VarIsNull(TDBNumberEditEh(ValueObj1).Value) then result := '0'
      else result := TDBNumberEditEh(ValueObj1).Value;
    ctCombo, ctCheckBox, ctLookup: ;
    ctDateTime, ctDate, ctTime:
      if not VarIsNull(TDBDateTimeEditEh(ValueObj1).Value) then result := TDBDateTimeEditEh(ValueObj1).Text;
    ctMonth:
      if not VarIsNull(TDBDateTimeEditEh(ValueObj1).Value) then
      begin
        dt := RecodeDay(StrToDateTime(TDBDateTimeEditEh(ValueObj1).Value), 1);
        result := DateToStr(dt);
      end;
  end;
end;

function TRecordBase.GetKeyName: string;
begin
  result := iif(ObjectName = '', '', ObjectName + '.') + FieldName;
end;

function TRecordBase.GetParamValue(ValName: string): string;
var
  i: integer;

begin
  result := '';
  for i := 0 to Length(Params) - 1 do
    if AnsiLowerCase(Params[i].Name) = AnsiLowerCase(ValName) then
    begin
      result := Params[i].Value;
      break;
    end;
end;

function TRecordBase.GetUsed: boolean;
begin
  result := FUsed.Checked;
end;

function TRecordBase.GetValue: string;
var
  i: integer;
  dt: TDateTime;
  f: TFormatSettings;
  bm: TBookmark;

begin
  result := '';
  if (not Assigned(ValueObj2)) then exit;

  case ValueObjType of
    ctEdit, ctMemo: result := TEdit(ValueObj2).Text;
    ctNumeric:
      if VarIsNull(TDBNumberEditEh(ValueObj2).Value) then result := '0'
      else result := TDBNumberEditEh(ValueObj2).Value;
    ctCombo, ctCheckBox{, ctLookup}:
    begin
      for i := 0 to TJvCheckedComboBox(ValueObj2).Items.Count - 1 do
        if TJvCheckedComboBox(ValueObj2).Checked[i] then
        begin
          if result = '' then result := ValueKeyValues.Strings[i]
          else result := result + ',' + ValueKeyValues.Strings[i];
        end;
    end;
    ctLookup:
    begin
      LookupDataSet.DisableControls;
      try
        bm := LookupDataSet.GetBookmark;
        for i := 0 to LookupList.SelectedRows.Count - 1 do
          if LookupDataSet.BookmarkValid(TBookmark(LookupList.SelectedRows.Items[i])) then
          begin
            LookupDataSet.GotoBookmark(TBookmark(LookupList.SelectedRows.Items[i]));
            if result = '' then result := LookupDataSet.FieldByName(LookupKeyField).AsString
            else result := result + ',' + LookupDataSet.FieldByName(LookupKeyField).AsString;
          end;
      finally
        if LookupDataSet.BookmarkValid(bm) then LookupDataSet.GotoBookmark(bm);
        LookupDataSet.EnableControls;
      end;
    end;
    ctDateTime, ctDate, ctTime:
      if FFilterIndex = 2 then
      begin
        case TComboBox(ValueObj2).ItemIndex of
          0: result := 'current_timestamp - 1';
          1: result := 'current_timestamp - 7';
          2: result := 'current_timestamp - 30';
          3: result := 'current_timestamp - 90';
          4: result := 'current_timestamp - 180';
          5: result := 'current_timestamp - 365';
          else result := 'current_timestamp';
        end;
      end else
        if not VarIsNull(TDBDateTimeEditEh(ValueObj2).Value) then result := TDBDateTimeEditEh(ValueObj2).Text;
    ctMonth:
      if not VarIsNull(TDBDateTimeEditEh(ValueObj2).Value) then
      begin
        dt := RecodeDay(StrToDateTime(TDBDateTimeEditEh(ValueObj2).Value), 1);
        if FFilterIndex = 2 then
        begin
          f.LongTimeFormat := 'HH:mm:ss';
          f.TimeSeparator := ':';
          f.ShortDateFormat := 'yyyy-MM-dd';
          result := DateTimeToStr(dt, f);
        end else result := DateToStr(dt);
      end;
  end;
end;

function TRecordBase.GetValueCtrlType(TypeName: string): TControlType;
begin
  if (TypeName = FIELDTYPE_text) then result := ctEdit
  else if (TypeName = FIELDTYPE_numeric) then result := ctNumeric
  else if (TypeName = FIELDTYPE_comboBox) or (TypeName = FIELDTYPE_LovCombo) then result := ctCombo
  else if (TypeName = FIELDTYPE_Checkbox) then result := ctCheckBox
  else if (TypeName = FIELDTYPE_LookUp) or (TypeName = FIELDTYPE_MLookUpCreat) or
    (TypeName = FIELDTYPE_CheckedLookUp) then result := ctLookup
  else if (TypeName = FIELDTYPE_date) then
  begin
    result := ctDate;
    try
      if StrToBool(GetParamValue(OPT_dateShow)) and StrToBool(GetParamValue(OPT_timeShow)) then
        result := ctDateTime
      else if StrToBool(GetParamValue(OPT_timeShow)) and (not StrToBool(GetParamValue(OPT_dateShow))) then
        result := ctTime;
    except
    end;
  end else if (TypeName = FIELDTYPE_MonthField) then result := ctMonth
  //else if (TypeName = FIELDTYPE_TextArea) or (TypeName = FIELDTYPE_HtmlEditor) then result := ctMemo
  else result := ctMemo;
end;

procedure TRecordBase.LoadFieldTypeParams(ParamsStr: string);
var
  json: TJson;
  i: integer;

begin
  json := TJson.Create;
  try
    json.Load(ParamsStr);

    for i := 0 to json.KeyCount - 1 do
    begin
      SetLength(Params, Length(Params) + 1);
      Params[High(Params)].Name := json.Keys[i];
      Params[High(Params)].Value := json.ValueOf(json.Keys[i]);
    end;
  finally
    json.Free;
  end;
end;

procedure TRecordBase.LoadLookup;
begin
  // сейчас не используется, т.к. Lookup List переделан на Grid
  exit;
  if LookupLoaded or (ValueObjType <> ctLookup) then exit;
  
  try
    ValueKeyValues.Clear;
    TJvCheckedComboBox(ValueObj2).Items.Clear;

    if LookupDataSet.Active and (not LookupDataSet.IsEmpty) then
    begin
      Screen.Cursor := crSQLWait;
      ValueKeyValues.Add('null');
      TJvCheckedComboBox(ValueObj2).Items.Add('Значение не выбрано');

      LookupDataSet.First;
      while not LookupDataSet.Eof do
      begin
        ValueKeyValues.Add(LookupDataSet.FieldByName(LookupKeyField).AsString);
        TJvCheckedComboBox(ValueObj2).Items.Add(LookupDataSet.FieldByName(LookupDisplayField).AsString);
        LookupDataSet.Next;
      end;

      if TJvCheckedComboBox(ValueObj2).Items.Count < 12 then
        TJvCheckedComboBox(ValueObj2).DropDownLines := TJvCheckedComboBox(ValueObj2).Items.Count;

      LookupLoaded := true;
    end;
  finally
    Screen.Cursor := crDefault;
    //if LookupDataSet.Active then LookupDataSet.Close;
  end;
end;

procedure TRecordBase.LookupButtonClick(Sender: TObject; var Handled: Boolean);
begin
  LookupList.Visible := not LookupList.Visible;
  if LookupList.Visible then
  begin
    LookupList.Width := ValueObj2.Width;
    LookupList.Left := ValueObj2.Left;
    LookupList.Top := ValueObj2.Top + ValueObj2.Height; 
    LookupList.BringToFront;
    try
      LookupList.SetFocus;
    except
    end;
  end;
end;

procedure TRecordBase.LookupListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) and (ssCtrl in Shift) then
    LookupList.SelectedRows.SelectAll;
  if ((Key = Ord('B')) or (Key = Ord('b')) or (Key = Ord('И')) or (Key = Ord('и'))) and (ssCtrl in Shift) then
    LookupList.SelectedRows.Clear;
  {if ((Key = Ord('I')) or (Key = Ord('i')) or (Key = Ord('Ш')) or (Key = Ord('ш'))) and (ssCtrl in Shift) then
    LookupList.SelectedRows.;}
end;

procedure TRecordBase.LookupListSelectionChanged(Sender: TObject);
begin
  TDBLookupComboboxEh(ValueObj2).Text := 'Выбрано строк: ' + IntToStr(LookupList.SelectedRows.Count);
  if Assigned(PreviewProc) then PreviewProc;
end;

procedure TRecordBase.SetConcat(val: TConcat);
begin
  FieldConcObj.Text := FieldConcObj.Items.Strings[Ord(val)];
end;

procedure TRecordBase.SetExpression(val: TExpression);
begin
  if not (ValueObj1 is TComboBox) then exit;
  TComboBox(ValueObj1).ItemIndex := TComboBox(ValueObj1).Items.IndexOf(ExprAsString(val, RusExpr));
  TComboBox(ValueObj1).OnChange(ValueObj1);
end;

procedure TRecordBase.SetExtraValue(val: string);
begin
  if not Assigned(ValueObj1) then exit;

  case ValueObjType of
    ctEdit, ctMemo: ;
    ctNumeric:
    try
      if not (ValueObj1 is TDBNumberEditEh) then exit;
      val := StringReplace(StringReplace(val, '''', '', [rfReplaceAll]), '.', ',', []);
      TDBNumberEditEh(ValueObj1).Value := val;
    except
      TDBNumberEditEh(ValueObj1).Value := 0;
    end;
    ctCombo, ctCheckBox, ctLookup: ;
    ctDateTime, ctDate, ctTime, ctMonth:
      try
        if not (ValueObj1 is TDBDateTimeEditEh) then exit;
        val := Trim(StringReplace(val, '''', '', [rfReplaceAll]));
        TDBDateTimeEditEh(ValueObj1).Value := val;
      except
        TDBDateTimeEditEh(ValueObj1).Value := Null;
      end;
  end;
end;

procedure TRecordBase.SetField(PK: integer);
var
  s, sql: string;
  rEdge: integer;
  lft: integer;
  
begin
  // ключевой метод: устанавливает поле и его параметры, создает и задает значения элементов управления
  // вызывается в конструкторе (при парсинге существующего выражения)

  SetLength(Params, 0);
  FieldPK := 0;
  ObjectName := '';
  FieldName := '';
  FTitle := '';
  FieldType := '';

  if (not Fields.Active) or Fields.IsEmpty then exit;
  if not Fields.Locate('PK', PK, []) then exit;

  FieldPK := PK;
  ObjectName := Fields.FieldByName('OBJECT_NAME').AsString;
  FieldName := Fields.FieldByName('FIELD_NAME').AsString;
  FTitle := Fields.FieldByName('TITLE').AsString;
  FieldType := Fields.FieldByName('TYPE_NAME').AsString;
  LoadFieldTypeParams(Fields.FieldByName('PARAMETERS').AsString);
  ValueObjType := GetValueCtrlType(FieldType);

  FieldConcObj := TComboBox.Create(FParent);
  FieldConcObj.Parent := FParent;
  FieldConcObj.Items.Add(CC_AND_RU);
  FieldConcObj.Items.Add(CC_OR_RU);
  FieldConcObj.Style := csDropDownList;
  FieldConcObj.ItemIndex := 0;
  FieldConcObj.OnChange := CtrlChange;
  FieldConcat := ccAnd;

  FUsed := TCheckBox.Create(FParent);
  FUsed.Parent := FParent;
  FUsed.Caption := FTitle;
  FUsed.Hint := iif(ObjectName = '', '', ObjectName + '.') + FieldName;
  FUsed.ShowHint := true;
  FUsed.Checked := false;
  FUsed.OnClick := CheckBoxClick;

  case ValueObjType of
    ctEdit:
    begin
      RusExpr := true;
      ValueObj1 := TComboBox.Create(FParent);
      ValueObj1.Parent := FParent;
      TComboBox(ValueObj1).Style := csDropDownList;
      TComboBox(ValueObj1).Items.Add(EX_EQUAL_RU);
      //TComboBox(ValueObj1).Items.Add(EX_NOT_EQUAL_RU);
      TComboBox(ValueObj1).Items.Add(EX_LIKE_RU);
      //TComboBox(ValueObj1).Items.Add(EX_NOT_LIKE_RU);
      TComboBox(ValueObj1).Items.Add(EX_START_WITH_RU);
      TComboBox(ValueObj1).Items.Add(EX_IS_NULL_RU);
      //TComboBox(ValueObj1).Items.Add(EX_IS_NOT_NULL_RU);
      TComboBox(ValueObj1).ItemIndex := 0;
      TComboBox(ValueObj1).OnChange := CtrlChange;
      ValueObj1.Width := 90;

      ValueObj2 := TEdit.Create(FParent);
      ValueObj2.Parent := FParent;
      TEdit(ValueObj2).OnChange := CtrlChange;
    end;
    ctMemo:
    begin
      ValueObj2 := TEdit.Create(FParent);
      ValueObj2.Parent := FParent;
      TEdit(ValueObj2).OnChange := CtrlChange;
    end;
    ctNumeric:
    begin
      ValueObj2 := TDBNumberEditEh.Create(FParent);
      ValueObj2.Parent := FParent;
      TDBNumberEditEh(ValueObj2).AutoSize := false;
      TDBNumberEditEh(ValueObj2).Increment := 1;
      TDBNumberEditEh(ValueObj2).EditButton.Style := ebsUpDownEh;
      TDBNumberEditEh(ValueObj2).EditButton.Visible := true;
      TDBNumberEditEh(ValueObj2).DecimalPlaces := 0;
      TDBNumberEditEh(ValueObj2).Value := 0;
      TDBNumberEditEh(ValueObj2).OnChange := CtrlChange;

      if FFilterIndex = 1 then
      begin
        ValueObj1 := TComboBox.Create(FParent);
        ValueObj1.Parent := FParent;
        TComboBox(ValueObj1).Style := csDropDownList;
        TComboBox(ValueObj1).Items.Add('=');
        TComboBox(ValueObj1).Items.Add('<>');
        TComboBox(ValueObj1).Items.Add('>');
        TComboBox(ValueObj1).Items.Add('<');
        TComboBox(ValueObj1).Items.Add('>=');
        TComboBox(ValueObj1).Items.Add('<=');
        TComboBox(ValueObj1).ItemIndex := 0;
        TComboBox(ValueObj1).OnChange := CtrlChange;
        ValueObj1.Width := 40;
      end else
      if FFilterIndex = 2 then
      begin
        ExLabel1 := TLabel.Create(FParent);
        ExLabel1.Parent := FParent;
        ExLabel2 := TLabel.Create(FParent);
        ExLabel2.Parent := FParent;

        ValueObj1 := TDBNumberEditEh.Create(FParent);
        ValueObj1.Parent := FParent;
        TDBNumberEditEh(ValueObj1).AutoSize := false;
        TDBNumberEditEh(ValueObj1).Increment := 1;
        TDBNumberEditEh(ValueObj1).EditButton.Style := ebsUpDownEh;
        TDBNumberEditEh(ValueObj1).EditButton.Visible := true;
        TDBNumberEditEh(ValueObj1).DecimalPlaces := 0;
        TDBNumberEditEh(ValueObj1).Value := 0;
        ValueObj1.Width := 100;
        TDBNumberEditEh(ValueObj1).OnChange := CtrlChange;
      end;

      try
        if not StrToBool(GetParamValue(OPT_allowDecimals)) then
        try
          TDBNumberEditEh(ValueObj2).DecimalPlaces := StrToInt(GetParamValue(OPT_decimalPrecision));
        except
          TDBNumberEditEh(ValueObj2).DecimalPlaces := 5;
        end;
      except
      end;

      try
        if GetParamValue(OPT_minValue) <> '' then
          TDBNumberEditEh(ValueObj2).MinValue := StrToInt(GetParamValue(OPT_minValue))
        else begin
          if StrToBool(GetParamValue(OPT_allowNegative)) then
            TDBNumberEditEh(ValueObj2).MinValue := 0;
        end;
        if GetParamValue(OPT_maxValue) <> '' then
          TDBNumberEditEh(ValueObj2).MaxValue := StrToInt(GetParamValue(OPT_maxValue));
      except
      end;

      if FFilterIndex = 2 then
      begin
        TDBNumberEditEh(ValueObj1).DecimalPlaces := TDBNumberEditEh(ValueObj2).DecimalPlaces;
        TDBNumberEditEh(ValueObj1).MinValue := TDBNumberEditEh(ValueObj2).MinValue;
        TDBNumberEditEh(ValueObj1).MaxValue := TDBNumberEditEh(ValueObj2).MaxValue;
      end;
    end;
    ctCombo, ctCheckBox:
    begin
      ValueObj2 := TJvCheckedComboBox.Create(FParent);
      ValueObj2.Parent := FParent;
      TJvCheckedComboBox(ValueObj2).DropDownLines := 12;
      TJvCheckedComboBox(ValueObj2).OnChange := CtrlChange;

      if ValueObjType = ctCombo then
      begin
        TJvCheckedComboBox(ValueObj2).Items.Text := StringReplace(GetParamValue(OPT_values), ';', #13#10, [rfReplaceAll]);
        s := StringReplace(GetParamValue(OPT_fields), ';', #13#10, [rfReplaceAll]);
        if Trim(s) = '' then
          ValueKeyValues.Text := TJvCheckedComboBox(ValueObj2).Items.Text
        else
          ValueKeyValues.Text := s;

        ValueKeyValues.Insert(0, 'null');
        TJvCheckedComboBox(ValueObj2).Items.Insert(0, 'Пусто');
      end else
      if ValueObjType = ctCheckBox then
      begin
        TJvCheckedComboBox(ValueObj2).Items.Add('Да');
        TJvCheckedComboBox(ValueObj2).Items.Add('Нет');
        ValueKeyValues.Add('1');
        ValueKeyValues.Add('0');
      end;

      if TJvCheckedComboBox(ValueObj2).Items.Count < 12 then
        TJvCheckedComboBox(ValueObj2).DropDownLines := TJvCheckedComboBox(ValueObj2).Items.Count;
    end;
    ctLookup:
    begin
      ValueObj2 := TDBLookupComboboxEh.Create(FParent);
      ValueObj2.Parent := FParent;
      TDBLookupComboboxEh(ValueObj2).ReadOnly := true;
      TDBLookupComboboxEh(ValueObj2).Style := csDropDownEh;
      TDBLookupComboboxEh(ValueObj2).OnChange := CtrlChange;
      TDBLookupComboboxEh(ValueObj2).OnButtonClick := LookupButtonClick;

      Screen.Cursor := crSQLWait;
      try
        try
          LookupKeyField := GetParamValue(OPT_fkField);
          LookupDisplayField := GetParamValue(OPT_displayField);
          with LookupList.Columns.Add do
          begin
            FieldName := LookupDisplayField;
          end;

          if FieldType = FIELDTYPE_MLookUpCreat then s := FSettings.MainDescriptor
          else s := GetParamValue(OPT_baseDescriptor);
          sql := 'select ' + LookupKeyField + ', ' + LookupDisplayField + ' from ' + GetParamValue(OPT_fkTable);

          try
            if StrToBool(GetParamValue(OPT_whereInFilter)) then
              sql := sql + ' ' + GetParamValue(OPT_filterWhere)
            else
              sql := sql + ' ' + GetParamValue(OPT_where);
          except
            sql := sql + ' order by ' + LookupDisplayField;
          end;

          ConnectionsList.SetSQLToDataSet(LookupDataSet, s, qtUserDefined, sql);
          LookupDataSet.Open;
        except
          try
            sql := 'select ' + LookupKeyField + ', ' + LookupDisplayField + ' from ' + GetParamValue(OPT_fkTable) +
              ' order by ' + LookupDisplayField;
            LookupDataSet.SQL.Text := sql;
            LookupDataSet.Open;
          except
          end;
        end;

        //LoadLookup; - будет происходить только при активизации этого контрола (установке FUsed в true)
      finally
        Screen.Cursor := crDefault;
        //if LookupDataSet.Active then LookupDataSet.Close;
      end;
    end;
    ctDateTime, ctDate, ctTime:
    begin
      ExLabel1 := TLabel.Create(FParent);
      ExLabel1.Parent := FParent;

      if FFilterIndex = 2 then
      begin
        ExLabel1.Caption := 'Период';

        ValueObj2 := TComboBox.Create(FParent);
        ValueObj2.Parent := FParent;
        TComboBox(ValueObj2).Style := csDropDownList;
        TComboBox(ValueObj2).Items.Add('День');
        TComboBox(ValueObj2).Items.Add('Неделя');
        TComboBox(ValueObj2).Items.Add('Месяц');
        TComboBox(ValueObj2).Items.Add('Квартал');
        TComboBox(ValueObj2).Items.Add('Полгода');
        TComboBox(ValueObj2).Items.Add('Год');
        TComboBox(ValueObj2).OnChange := CtrlChange;
      end else
      begin
        ExLabel2 := TLabel.Create(FParent);
        ExLabel2.Parent := FParent;

        ValueObj1 := TDBDateTimeEditEh.Create(FParent);
        ValueObj1.Parent := FParent;
        case ValueObjType of
          ctDateTime:
          begin
            TDBDateTimeEditEh(ValueObj1).Kind := dtkDateTimeEh;
            TDBDateTimeEditEh(ValueObj1).EditFormat := 'DD/MM/YYYY HH:NN';
          end;
          ctDate: TDBDateTimeEditEh(ValueObj1).Kind := dtkDateEh;
          ctTime:
          begin
            TDBDateTimeEditEh(ValueObj1).Kind := dtkTimeEh;
            TDBDateTimeEditEh(ValueObj1).EditFormat := 'HH:NN';
            TDBDateTimeEditEh(ValueObj1).EditButton.Style := ebsAltUpDownEh;
          end;
        end;
        ValueObj1.Width := 120;
        TDBDateTimeEditEh(ValueObj1).OnChange := CtrlChange;

        ValueObj2 := TDBDateTimeEditEh.Create(FParent);
        ValueObj2.Parent := FParent;
        case ValueObjType of
          ctDateTime:
          begin
            TDBDateTimeEditEh(ValueObj2).Kind := dtkDateTimeEh;
            TDBDateTimeEditEh(ValueObj2).EditFormat := 'DD/MM/YYYY HH:NN';
          end;
          ctDate: TDBDateTimeEditEh(ValueObj2).Kind := dtkDateEh;
          ctTime:
          begin
            TDBDateTimeEditEh(ValueObj2).Kind := dtkTimeEh;
            TDBDateTimeEditEh(ValueObj2).EditFormat := 'HH:NN';
            TDBDateTimeEditEh(ValueObj2).EditButton.Style := ebsAltUpDownEh;
          end;
        end;
        TDBDateTimeEditEh(ValueObj2).OnChange := CtrlChange;
      end;
    end;
    ctMonth:
    begin
      ValueObj2 := TDBDateTimeEditEh.Create(FParent);
      ValueObj2.Parent := FParent;
      TDBDateTimeEditEh(ValueObj2).Kind := dtkCustomEh;
      TDBDateTimeEditEh(ValueObj2).EditFormat := 'MM/YYYY';
      TDBDateTimeEditEh(ValueObj2).OnChange := CtrlChange;

      if FFilterIndex <> 2 then
      begin
        ExLabel1 := TLabel.Create(FParent);
        ExLabel1.Parent := FParent;
        ExLabel2 := TLabel.Create(FParent);
        ExLabel2.Parent := FParent;

        ValueObj1 := TDBDateTimeEditEh.Create(FParent);
        ValueObj1.Parent := FParent;
        TDBDateTimeEditEh(ValueObj1).Kind := dtkCustomEh;
        TDBDateTimeEditEh(ValueObj1).EditFormat := 'MM/YYYY';
        TDBDateTimeEditEh(ValueObj1).OnChange := CtrlChange;
        ValueObj1.Width := 90;
        TDBDateTimeEditEh(ValueObj1).OnChange := CtrlChange;
      end;
    end;
  end;

  // расположение контролов
  FieldConcObj.Top := Top;
  FieldConcObj.Height := CTRLHEIGHT;
  FieldConcObj.Left := 8;
  FieldConcObj.Width := 50;

  FUsed.Top := Top + 2;
  FUsed.Height := CTRLHEIGHT - 4;
  FUsed.Left := FieldConcObj.Left + FieldConcObj.Width + 4;
  FUsed.Width := {Round(FParent.Width / 2.57);} 275;
  lft := FUsed.Left + FUsed.Width + 17;

  if Assigned(ExLabel1) then
  begin
    if ExLabel1.Caption = '' then ExLabel1.Caption := 'От';
    ExLabel1.Top := Top + 2;
    ExLabel1.Height := 13;
    ExLabel1.Left := lft;
    lft := ExLabel1.Left + ExLabel1.Width + 4;
  end;

  if Assigned(ValueObj1) then
  begin
    ValueObj1.Top := Top;
    ValueObj1.Height := CTRLHEIGHT;
    ValueObj1.Left := lft;
    lft := ValueObj1.Left + ValueObj1.Width + 4;
  end;

  if Assigned(ExLabel2) then
  begin
    if ExLabel2.Caption = '' then ExLabel2.Caption := 'До';
    ExLabel2.Top := Top + 2;
    ExLabel2.Height := 13;
    ExLabel2.Left := lft;
    lft := ExLabel2.Left + ExLabel2.Width + 4;
  end;

  if Assigned(ValueObj2) then
  begin
    ValueObj2.Top := Top;
    ValueObj2.Height := CTRLHEIGHT;
    ValueObj2.Left := lft;

    case ValueObjType of
      ctNumeric: ValueObj2.Width := 100;
      ctCheckBox: ValueObj2.Width := 70;
      ctDateTime, ctDate, ctTime: ValueObj2.Width := 120;
      ctMonth: ValueObj2.Width := 90;
      else begin
        if Assigned(ValueObj1) then
          ValueObj2.Width := {FParent.Width - ValueObj2.Left - 10;} iif(ValueObj1.Width > 100, ValueObj1.Width, 400 - ValueObj1.Width)
        else
          ValueObj2.Width := 405;
      end;
    end;
  end;

  CheckBoxClick(FUsed);
end;

procedure TRecordBase.SetGridDefParams;
begin
  LookupList.Visible := false;
  LookupList.AllowedOperations := [];
  LookupList.AllowedSelections := [gstRecordBookmarks];
  LookupList.AutoFitColWidths := true;
  LookupList.Flat := false;
  LookupList.Height := 160;
  LookupList.IndicatorOptions := [gioShowRowselCheckboxesEh];
  LookupList.Options := [dgEditing, dgConfirmDelete, dgMultiSelect];
  LookupList.OptionsEh := [dghFixed3D, dghHighlightFocus, dghRowHighlight];
  LookupList.OnSelectionChanged := LookupListSelectionChanged;
  LookupList.OnKeyDown := LookupListKeyDown;
end;

procedure TRecordBase.SetTop(val: integer);
begin
  if val < 0 then exit;
  FTop := val;
  FieldConcObj.Top := FTop;
  FUsed.Top := FTop + 2;
  if Assigned(ValueObj1) then ValueObj1.Top := FTop;
  if Assigned(ValueObj2) then ValueObj2.Top := FTop;
  if Assigned(ExLabel1) then ExLabel1.Top := FTop + 2;
  if Assigned(ExLabel2) then ExLabel2.Top := FTop + 2;
end;

procedure TRecordBase.SetUsed(value: boolean);
begin
  FUsed.Checked := value;
  CheckBoxClick(FUsed);
end;

procedure TRecordBase.SetValue(val: string);
var
  i: integer;
  sl: TStringList;

begin
  if not Assigned(ValueObj2) then exit;

  sl := TStringList.Create;
  try
    case ValueObjType of
      ctEdit, ctMemo: TEdit(ValueObj2).Text := StringReplace(StringReplace(val, '%', '', [rfReplaceAll]), '''', '', [rfReplaceAll]);
      ctNumeric:
      try
        val := StringReplace(StringReplace(val, '''', '', [rfReplaceAll]), '.', ',', []);
        TDBNumberEditEh(ValueObj2).Value := val;
      except
        TDBNumberEditEh(ValueObj2).Value := 0;
      end;
      ctCombo, ctCheckBox{, ctLookup}:
      begin
        sl.Text := StringReplace(val, ',', #13#10, [rfReplaceAll]);
        for i := 0 to sl.Count - 1 do
        begin
          if ValueKeyValues.IndexOf(sl.Strings[i]) <> -1 then
            TJvCheckedComboBox(ValueObj2).Checked[ValueKeyValues.IndexOf(sl.Strings[i])] := true;
        end;
      end;
      ctLookup:
      begin
        sl.Text := StringReplace(val, ',', #13#10, [rfReplaceAll]);
        LookupDataSet.First;
        while not LookupDataSet.Eof do
        begin
          i := sl.IndexOf(LookupDataSet.FieldByName(LookupKeyField).AsString);
          if i <> -1 then LookupList.SelectedRows.AppendItem(LookupDataSet.Bookmark);
          LookupDataSet.Next;
        end;
        if sl.Count > 0 then LookupDataSet.Locate(LookupKeyField, sl.Strings[sl.Count-1], [loCaseInsensitive])
        else LookupDataSet.First;
        LookupListSelectionChanged(LookupList);
      end;
      ctDateTime, ctDate, ctTime:
        if FFilterIndex = 2 then
        begin
          val := StringReplace(StringReplace(val, 'current_timestamp', '', []), ' ', '', [rfReplaceAll]);
          if val = '-1' then TComboBox(ValueObj2).ItemIndex := 0
          else if val = '-7' then TComboBox(ValueObj2).ItemIndex := 1
          else if val = '-30' then TComboBox(ValueObj2).ItemIndex := 2
          else if val = '-90' then TComboBox(ValueObj2).ItemIndex := 3
          else if val = '-180' then TComboBox(ValueObj2).ItemIndex := 4
          else if val = '-365' then TComboBox(ValueObj2).ItemIndex := 5
          else TComboBox(ValueObj2).ItemIndex := -1;
        end else
        try
          val := Trim(StringReplace(val, '''', '', [rfReplaceAll]));
          TDBDateTimeEditEh(ValueObj2).Value := val;
        except
          TDBDateTimeEditEh(ValueObj2).Value := Null;
        end;
      ctMonth:
        try
          val := Trim(StringReplace(val, '''', '', [rfReplaceAll]));
          TDBDateTimeEditEh(ValueObj2).Value := val;
        except
          TDBDateTimeEditEh(ValueObj2).Value := Null;
        end;
    end;
  finally
    sl.Free;
  end;
end;

end.
