unit tmplConstructor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Mask,
  DB, ImgList, ComCtrls, ToolWin, DBCtrls, DBCtrlsEh, ToolCtrlsEh, DBGridEh, DBLookupEh, MemTableDataEh, MemTableEh, MemDS,
  DBGridEhGrouping, GridsEh, FIBDataSet, pFIBDataSet, DBAccess, Uni, UniProvider, PostgreSQLUniProvider, OracleUniProvider,
  MySQLUniProvider, InterBaseUniProvider, optControls, utils, dbUtils, main, settings, StrUtils, json;

type
  TExpression = (exNone, exEqual, exNotEqual, exLike, exNotLike, exIn, exNotIn, exLarge, exSmall, exEqLarge, exEqSmall, exIs);
  TConcat = (ccAnd, ccOr);
  TTemplateType = (ttStandart, ttExtend);
  TControlType = (ctEdit, ctNumeric, ctDate, ctCombo, ctLookup);

  TCtrlParam = record
    Name: string;
    Value: string;
  end;

  TCtrlParams = array of TCtrlParam;

  TSetIdx = procedure(idx: integer) of object;

  TRecordStd = class
  private
    FParent: TWinControl;
    FSetIdx: TSetIdx;
    FIndex: integer;
    FEditMode: boolean;
    LookupSource: TDataSource;
    Fields: TMemTableEh;
    ValueObjType: TControlType;
    ValueKeyValues: TStringList;
    FieldKeyValues: TStringList;
    FieldPK: Variant;
    ObjectName: string;
    FieldName: string;
    FTitle: string;
    FieldType: string;
    RawValue: Variant;
    Params: TCtrlParams;
    // контролы
    ConcObj: TComboBox;
    FieldObj: TComboBox;
    ExprObj: TComboBox;
    TypeObj: TComboBox;
    ValueObj: TControl;
    FTop: integer;
    FHeight: integer;
    FFontColor: TColor;
    FLabels: array of TStaticText;
    // свойства
    procedure SetTop(val: integer);
    procedure SetValue(val: Variant);
    function GetValue: Variant;
    function GetDisplayValye: string;
    procedure SetExpression(val: TExpression);
    function GetExpr: TExpression;
    procedure SetConcat(val: TConcat);
    function GetConc: TConcat;
    procedure SetIndex(val: integer);
    procedure SetFontColor(val: TColor);
    procedure SetHeight(val: integer);
    procedure SetEditMode(val: boolean);
    //
    function GetValueCtrlType(TypeName: string): TControlType;
    procedure CreateValueObject;
    procedure LoadFieldTypeParams(ParamsStr: string);
    function GetParamValue(ValName: string): string;
    //реакция на события
    procedure ConcatObjChange(Sender: TObject);
    procedure FieldObjChange(Sender: TObject);
    procedure TypeObjChange(Sender: TObject);
    procedure ExprObjChange(Sender: TObject);
    procedure ValueObjChange(Sender: TObject);
    procedure AllOnEnter(Sender: TObject);
    function GetInputType: integer;
  public
    PreviewProc: procedure of object;
    function IsDone: boolean;
    function IsNull: boolean;
    procedure SetField(PK: Variant; FldText: string; SetToControl: boolean);
    property Top: integer read FTop write SetTop;
    property Height: integer read FHeight write SetHeight;
    property Expression: TExpression read GetExpr write SetExpression;
    property Value: Variant read GetValue write SetValue;
    property DisplayValue: string read GetDisplayValye;
    property FieldConcat: TConcat read GetConc write SetConcat;
    property Index: integer read FIndex write SetIndex;
    property FontColor: TColor read FFontColor write SetFontColor;
    property EditMode: boolean read FEditMode write SetEditMode;
    property ValueType: TControlType read ValueObjType;
    property InputType: integer read GetInputType;
    constructor Create(AParent: TWinControl; AFields: TMemTableEh; ATop: integer; FldPK: Variant; FldText: string; AValue: Variant;
      Expr: TExpression; ConcRule: TConcat; AIndex: integer);
    destructor Destroy; override;
  end;

  TRecordsStd = array of TRecordStd;

  TFTmplConstructor = class(TForm)
    Panel1: TPanel;
    btnSave: TBitBtn;
    btnCancel: TBitBtn;
    ImageList: TImageList;
    rePreview: TRichEdit;
    Label1: TLabel;
    Panel2: TPanel;
    ToolBar: TToolBar;
    btnAdd: TToolButton;
    btnDelete: TToolButton;
    btnClear: TToolButton;
    ScrollBox: TScrollBox;
    lbCapField: TStaticText;
    lbCapExpr: TStaticText;
    lbCapValue: TStaticText;
    lbCapConcat: TStaticText;
    lbCapInputType: TStaticText;
    chbCreateAsList: TCheckBox;
    ToolButton1: TToolButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    f_ok: boolean;
    CurrIndex: integer;
    RecordsStd: TRecordsStd;
    FString: string;
    Fields: TMemTableEh;
    TemplateType: TTemplateType;
    function CreateTemplate: string;
    function CreateTemplateFull: string;
    procedure SetControls;
    procedure ClearRecords;
    procedure AddRecord(ObjectName, FieldName: string; Value: Variant; AExpr: TExpression; AConcRule: TConcat);
    procedure DelRecord(Index: integer);
    procedure SetCurrIndex(idx: integer);
    procedure ExtractValues(fstr: string; SL: TStringList);
    procedure ParseFields(fstr: string; SL: TStringList);
    procedure ParseField(fstr: string; SL: TStringList);
    procedure ParseString(s: string; SL: TStringList);
    function DelSpecSymb(s: string): string;
    function CreateTemplateString(r: TRecordStd): string;
    procedure ShowPreview;
  public
    function Execute(AFields: TMemTableEh; TmplType: TTemplateType; Tmpl: string = ''): boolean;
    property Template: string read FString;
  end;

implementation

{$R *.dfm}

const
  CTRLHEIGHT = 21;

function iif(Switch: boolean; iftrue: variant; iffalse: variant): variant;
begin
  if Switch then
    result := iftrue
  else
    result := iffalse;
end;

function GetExpression(s: string): TExpression;
begin
  if s = '=' then result := exEqual
  else if s = '<>' then result := exNotEqual
  else if (UpperCase(s) = 'LIKE') or (AnsiLowerCase(s) = 'содержит') then result := exLike
  else if (UpperCase(s) = 'NOT LIKE') or (AnsiLowerCase(s) = 'не содержит') then result := exNotLike
  else if (UpperCase(s) = 'IN') or (AnsiLowerCase(s) = 'один из') then result := exIn
  else if (UpperCase(s) = 'NOT IN') or (AnsiLowerCase(s) = 'не один из') then result := exNotIn
  else if s = '>' then result := exLarge
  else if s = '<' then result := exSmall
  else if s = '>=' then result := exEqLarge
  else if s = '<=' then result := exEqSmall
  else if UpperCase(s) = 'IS' then result := exIs
  else result := exNone;
end;

function GetConcatStr(c: TConcat): string;
begin
  result := '';
  case c of
    ccAnd: result := 'AND';
    ccOr: result := 'OR';
  end;
end;

function GetExprString(e: TExpression): string;
begin
  case e of
    exNone: result := '';
    exEqual: result := '=';
    exNotEqual: result := '<>';
    exLike: result := 'LIKE';
    exNotLike: result := '%s NOT LIKE';
    exIn: result := 'IN';
    exNotIn: result := 'NOT IN';
    exLarge: result := '>';
    exSmall: result := '<';
    exEqLarge: result := '>=';
    exEqSmall: result := '<=';
    exIs: result := 'IS';
    else result := '';
  end;
end;

function GetConcat(s: string): TConcat;
begin
  result := ccAnd;
  if (UpperCase(s) = 'OR') or (AnsiUpperCase(s) = 'ИЛИ') then result := ccOr
  else if (UpperCase(s) = 'AND') or (AnsiUpperCase(s) = 'И') then result := ccAnd;
end;

{ TRecordStd }

procedure TRecordStd.AllOnEnter(Sender: TObject);
begin
  if @FSetIdx <> nil then FSetIdx(TComponent(Sender).Tag);
end;

procedure TRecordStd.ConcatObjChange(Sender: TObject);
begin
  FLabels[0].Caption := ConcObj.Text;
  if Assigned(PreviewProc) then PreviewProc;
end;

constructor TRecordStd.Create(AParent: TWinControl; AFields: TMemTableEh; ATop: integer; FldPK: Variant; FldText: string; AValue: Variant;
  Expr: TExpression; ConcRule: TConcat; AIndex: integer);
var
  i: integer;

begin
  if not Assigned(AParent) then
    raise Exception.Create('Не удалось создать строку: отсутствует объект владелец элемента!');
  if not Assigned(AFields) then
    raise Exception.Create('Не удалось создать строку: не указан список полей!');

  inherited Create;

  FParent := AParent;
  Fields := AFields;
  RawValue := AValue;
  LookupSource := TDataSource.Create(AParent.Owner);
  ValueKeyValues := TStringList.Create;
  FieldKeyValues := TStringList.Create;

  ConcObj := TComboBox.Create(AParent.Owner);
  FieldObj := TComboBox.Create(AParent.Owner);
  TypeObj := TComboBox.Create(AParent.Owner);
  ExprObj := TComboBox.Create(AParent.Owner);
  SetLength(FLabels, 5);
  for i := 0 to Length(FLabels) - 1 do
  begin
    FLabels[i] := TStaticText.Create(AParent.Owner);
    FLabels[i].Parent := AParent;
    FLabels[i].ParentFont := false;
    FLabels[i].Transparent := false; // чтобы применялся цвет шрифта
    FLabels[i].Visible := false;
    FLabels[i].AutoSize := false;
    FLabels[i].Color := clBtnFace;
    FLabels[i].Enabled := true;
    FLabels[i].BorderStyle := sbsSunken;
    FLabels[i].Alignment := taCenter;
    FLabels[i].OnClick := AllOnEnter;
    case i of
      0:
      begin
        FLabels[i].Left := TFTmplConstructor(AParent.Owner).lbCapConcat.Left;
        FLabels[i].Width := TFTmplConstructor(AParent.Owner).lbCapConcat.Width;
      end;
      1:
      begin
        FLabels[i].Left := TFTmplConstructor(AParent.Owner).lbCapField.Left;
        FLabels[i].Width := TFTmplConstructor(AParent.Owner).lbCapField.Width;
      end;
      2:
      begin
        FLabels[i].Left := TFTmplConstructor(AParent.Owner).lbCapInputType.Left;
        FLabels[i].Width := TFTmplConstructor(AParent.Owner).lbCapInputType.Width;
      end;
      3:
      begin
        FLabels[i].Left := TFTmplConstructor(AParent.Owner).lbCapExpr.Left;
        FLabels[i].Width := TFTmplConstructor(AParent.Owner).lbCapExpr.Width;
      end;
      4:
      begin
        FLabels[i].Left := TFTmplConstructor(AParent.Owner).lbCapValue.Left;
        FLabels[i].Width := TFTmplConstructor(AParent.Owner).lbCapValue.Width;
      end;
    end;
  end;

  with ConcObj do
  begin
    Parent := AParent;
    Left := TFTmplConstructor(Parent.Owner).lbCapConcat.Left;
    Width := TFTmplConstructor(Parent.Owner).lbCapConcat.Width;
    Items.Add('И');
    Items.Add('ИЛИ');
    Style := csDropDownList;
    ItemIndex := Ord(ConcRule);
    Visible := true;
    Enabled := AIndex <> 0;
    OnChange := ConcatObjChange;
    OnEnter := AllOnEnter;
    ConcObj.OnChange(ConcObj);
  end;
  with FieldObj do
  begin
    Parent := AParent;
    Left := TFTmplConstructor(Parent.Owner).lbCapField.Left;
    Width := TFTmplConstructor(Parent.Owner).lbCapField.Width;
    Fields.First;
    while not Fields.Eof do
    begin
      FieldKeyValues.Add(Fields.FieldByName('PK').AsString);
      Items.Add(Fields.FieldByName('TITLE').AsString);
      Fields.Next;
    end;
    Style := csDropDown;
    Visible := true;
    OnChange := FieldObjChange;
    OnEnter := AllOnEnter;
  end;
  with TypeObj do
  begin
    Parent := AParent;
    Left := TFTmplConstructor(Parent.Owner).lbCapInputType.Left;
    Width := TFTmplConstructor(Parent.Owner).lbCapInputType.Width;
    Items.Add('Ввод значения');
    Items.Add('Вошедший пользователь');
    Style := csDropDownList;
    ItemIndex := 0;
    Visible := true;
    OnChange := TypeObjChange;
    OnEnter := AllOnEnter;
  end;
  with ExprObj do
  begin
    Parent := AParent;
    Left := TFTmplConstructor(Parent.Owner).lbCapExpr.Left;
    Width := TFTmplConstructor(Parent.Owner).lbCapExpr.Width;
    Items.Add('<нет>');
    Items.Add('=');
    Items.Add('<>');
    Items.Add('LIKE');
    Items.Add('NOT LIKE');
    Items.Add('IN');
    Items.Add('NOT IN');
    Items.Add('>');
    Items.Add('<');
    Items.Add('>=');
    Items.Add('<=');
    Items.Add('IS');
    Style := csDropDownList;
    Visible := true;
    ItemIndex := Ord(Expr);
    FLabels[3].Caption := ExprObj.Text;
    OnChange := ExprObjChange;
    OnEnter := AllOnEnter;
  end;
  SetField(FldPK, FldText, true);
  SetValue(AValue);
  FLabels[4].Caption := DisplayValue;
  Index := AIndex;
  Top := ATop;
  Height := CTRLHEIGHT;
  FEditMode := true;
  //Expression := Expr;
  FieldConcat := ConcRule;
  FontColor := clBlack;
end;

procedure TRecordStd.CreateValueObject;
begin
  FreeAndNil(ValueObj);

  if (TypeObj.ItemIndex = 1) then ValueObjType := ctCombo
  else if Expression in [exIn, exIs] then ValueObjType := ctEdit;

  case ValueObjType of
    ctEdit:
    begin
      ValueObj := TEdit.Create(FParent.Owner);
      ValueObj.Parent := FParent;
      TEdit(ValueObj).OnChange := ValueObjChange;
      TEdit(ValueObj).OnEnter := AllOnEnter;
    end;
    ctNumeric:
    begin
      ValueObj := TDBNumberEditEh.Create(FParent.Owner);
      ValueObj.Parent := FParent;
      TDBNumberEditEh(ValueObj).AutoSize := false;
      TDBNumberEditEh(ValueObj).Increment := 1;
      TDBNumberEditEh(ValueObj).EditButton.Style := ebsUpDownEh;
      TDBNumberEditEh(ValueObj).EditButton.Visible := true;
      TDBNumberEditEh(ValueObj).OnChange := ValueObjChange;
      TDBNumberEditEh(ValueObj).OnEnter := AllOnEnter;
    end;
    ctDate:
    begin
      ValueObj := TDBDateTimeEditEh.Create(FParent.Owner);
      ValueObj.Parent := FParent;
      TDBDateTimeEditEh(ValueObj).OnChange := ValueObjChange;
      TDBDateTimeEditEh(ValueObj).OnEnter := AllOnEnter;
    end;
    ctCombo:
    begin
      ValueObj := TComboBox.Create(FParent.Owner);
      ValueObj.Parent := FParent;
      if (TypeObj.ItemIndex = 1) then
      begin
        TComboBox(ValueObj).Items.Text := LOGINED_USER_VALUES;
        ValueKeyValues.Text := LOGINED_USER_VALUES;
      end;
      TComboBox(ValueObj).OnChange := ValueObjChange;
      TComboBox(ValueObj).OnEnter := AllOnEnter;
    end;
    ctLookup:
    begin
      ValueObj := TDBLookupComboBoxEh.Create(FParent.Owner);
      ValueObj.Parent := FParent;
      TDBLookupComboBoxEh(ValueObj).DropDownBox.Align := daLeft;
      TDBLookupComboBoxEh(ValueObj).DropDownBox.Rows := 7;
      TDBLookupComboBoxEh(ValueObj).ListSource := LookupSource;
      TDBLookupComboBoxEh(ValueObj).OnChange := ValueObjChange;
      TDBLookupComboBoxEh(ValueObj).OnEnter := AllOnEnter;
    end;
  end;

  ValueObj.Anchors := ValueObj.Anchors + [akRight];
  ValueObj.Tag := Index;
  ValueObj.Top := Top;
  ValueObj.Left := TFTmplConstructor(FParent.Owner).lbCapValue.Left;
  ValueObj.Width := TFTmplConstructor(FParent.Owner).lbCapValue.Width;
  ValueObj.Visible := true;
end;

destructor TRecordStd.Destroy;
var
  i: integer;

begin
  ConcObj.Free;
  FieldObj.Free;
  TypeObj.Free;
  ExprObj.Free;
  ValueObj.Free;
  LookupSource.Free;
  ValueKeyValues.Free;
  FieldKeyValues.Free;

  for i := 0 to Length(FLabels) - 1 do
    if Assigned(FLabels[i]) then FreeAndNil(FLabels[i]);

  SetLength(FLabels, 0);
  SetLength(Params, 0);
  inherited Destroy;
end;

procedure TRecordStd.ExprObjChange(Sender: TObject);
begin
  if TypeObj.ItemIndex = 0 then SetField(FieldPK, '', false);
  FontColor := clBlack;
  FLabels[3].Caption := ExprObj.Text;
  if Assigned(PreviewProc) then PreviewProc;
end;

procedure TRecordStd.FieldObjChange(Sender: TObject);
var
  pk: Variant;

begin
  pk := null;
  if FieldObj.ItemIndex > -1 then pk := FieldKeyValues.Strings[FieldObj.ItemIndex];
  SetField(pk, '', false);
  FontColor := clBlack;
  FLabels[1].Caption := FTitle;
end;

function TRecordStd.GetConc: TConcat;
begin
  result := GetConcat(ConcObj.Text);
end;

function TRecordStd.GetDisplayValye: string;
begin
  result := '';
  if not Assigned(ValueObj) then exit;
  if IsNull then exit;

  case ValueObjType of
    ctEdit: result := TEdit(ValueObj).Text;
    ctNumeric: result := VarToStr(TDBNumberEditEh(ValueObj).Value);
    ctDate: result := VarToStr(TDBDateTimeEditEh(ValueObj).Value);
    ctCombo: result := TComboBox(ValueObj).Text;
    ctLookup: result := TDBLookupComboboxEh(ValueObj).Text;
  end;
end;

function TRecordStd.GetExpr: TExpression;
begin
  result := GetExpression(ExprObj.Text);
end;

function TRecordStd.GetInputType: integer;
begin
  if Assigned(TypeObj) then
    result := TypeObj.ItemIndex
  else
    result := -1;
end;

function TRecordStd.GetParamValue(ValName: string): string;
var
  i: integer;

begin
  result := '';
  for i := 0 to Length(Params) - 1 do
    if AnsiLowerCase(Params[i].Name) = AnsiLowerCase(ValName) then result := Params[i].Value; 
end;

function TRecordStd.GetValue: Variant;
begin
  result := Null;
  if not Assigned(ValueObj) then exit;
  
  case ValueObjType of
    ctEdit: result := TEdit(ValueObj).Text;
    ctNumeric: result := TDBNumberEditEh(ValueObj).Value;
    ctDate: result := TDBDateTimeEditEh(ValueObj).Value;
    ctCombo: if TComboBox(ValueObj).ItemIndex <> -1 then result := ValueKeyValues.Strings[TComboBox(ValueObj).ItemIndex];
    ctLookup: result := TDBLookupComboboxEh(ValueObj).KeyValue;
  end;
end;

function TRecordStd.GetValueCtrlType(TypeName: string): TControlType;
begin
  if TypeName = FIELDTYPE_numeric then result := ctNumeric
  else if (TypeName = FIELDTYPE_comboBox) or (TypeName = FIELDTYPE_LovCombo) then result := ctCombo
  else if (TypeName = FIELDTYPE_LookUp) {or (TypeName = FIELDTYPE_MultipleLookUp)} or (TypeName = FIELDTYPE_MLookUpCreat) or
    (TypeName = FIELDTYPE_CheckedLookUp) then result := ctLookup
  else if (TypeName = FIELDTYPE_date) or (TypeName = FIELDTYPE_datePeriod) or (TypeName = FIELDTYPE_MonthField) then result := ctDate
  else result := ctEdit;
end;

function TRecordStd.IsDone: boolean;
begin
  result := (FieldName <> '') and (Expression <> exNone);
end;

function TRecordStd.IsNull: boolean;
begin
  result := VarIsNull(Value);  
end;

procedure TRecordStd.LoadFieldTypeParams(ParamsStr: string);
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

procedure TRecordStd.SetConcat(val: TConcat);
begin
  ConcObj.Text := ConcObj.Items.Strings[Ord(val)];
end;

procedure TRecordStd.SetEditMode(val: boolean);
var
  i: integer;

begin
  FEditMode := val;
  ConcObj.Visible := FEditMode;
  FieldObj.Visible := FEditMode;
  TypeObj.Visible := FEditMode;
  ExprObj.Visible := FEditMode;
  ValueObj.Visible := FEditMode;
  for i := 0 to Length(FLabels) - 1 do FLabels[i].Visible := not FEditMode;
end;

procedure TRecordStd.SetExpression(val: TExpression);
begin
  ExprObj.ItemIndex := Ord(val);
  ExprObj.OnChange(ExprObj);
end;

procedure TRecordStd.SetField(PK: Variant; FldText: string; SetToControl: boolean);
var
  sl: TStringList;
  s, sql: string;

begin
  // ключевой метод: устанавливает поле и его параметры, задает значения элементов управления
  // вызывается при установке поля пользователем в контроле со списком полей
  // или программно из формы при парсинге существующего выражения (точнее из конструктора)

  SetLength(Params, 0);
  FieldPK := Null;
  ObjectName := '';
  FieldName := '';
  FTitle := '';
  FieldType := '';

  if (not Fields.Active) or Fields.IsEmpty then exit;

  FieldPK := PK;
  if SetToControl then
  begin
    FieldObj.OnChange := nil;
    if not VarIsNull(FieldPK) then FieldObj.ItemIndex := FieldKeyValues.IndexOf(VarToStr(FieldPK))
    else FieldObj.Text := FldText;
    FieldObj.OnChange := FieldObjChange;
    FLabels[1].Caption := FieldObj.Text;
  end;

  sl := TStringList.Create;
  try
    if Fields.Locate('PK', FieldPK, []) then
    begin
      ObjectName := Fields.FieldByName('OBJECT_NAME').AsString;
      FieldName := Fields.FieldByName('FIELD_NAME').AsString;
      FTitle := Fields.FieldByName('TITLE').AsString;
      FieldType := Fields.FieldByName('TYPE_NAME').AsString;
      LoadFieldTypeParams(Fields.FieldByName('PARAMETERS').AsString);
    end else
    begin
      FieldType := FIELDTYPE_text;
      FieldName := FieldObj.Text;
      FTitle := FieldObj.Text;
    end;
    
    sl.Text := LOGINED_USER_VALUES;
    if (not VarIsNull(RawValue)) and (sl.IndexOf(VarToStr(RawValue)) > -1) then
    begin
      ValueObjType := ctCombo;
      TypeObj.ItemIndex := 1;
    end else
    begin
      ValueObjType := GetValueCtrlType(FieldType);
      TypeObj.ItemIndex := 0;
    end;
    FLabels[2].Caption := TypeObj.Text;
    CreateValueObject;

    case ValueObjType of
      ctEdit: ;
      ctNumeric:
      begin
        TDBNumberEditEh(ValueObj).DecimalPlaces := 0;
        try
          if not StrToBool(GetParamValue(OPT_allowDecimals)) then
            TDBNumberEditEh(ValueObj).DecimalPlaces := StrToInt(GetParamValue(OPT_decimalPrecision));
          if GetParamValue(OPT_minValue) <> '' then
            TDBNumberEditEh(ValueObj).MinValue := StrToInt(GetParamValue(OPT_minValue))
          else begin
            if StrToBool(GetParamValue(OPT_allowNegative)) then
              TDBNumberEditEh(ValueObj).MinValue := 0;
          end;
          if GetParamValue(OPT_maxValue) <> '' then
            TDBNumberEditEh(ValueObj).MaxValue := StrToInt(GetParamValue(OPT_maxValue));
        except
        end;
      end;
      ctDate:
      begin
        TDBDateTimeEditEh(ValueObj).Kind := dtkDateEh;
        try
          if StrToBool(GetParamValue(OPT_dateShow)) and StrToBool(GetParamValue(OPT_timeShow)) then
            TDBDateTimeEditEh(ValueObj).Kind := dtkDateTimeEh
          else if StrToBool(GetParamValue(OPT_timeShow)) and (not StrToBool(GetParamValue(OPT_dateShow))) then
            TDBDateTimeEditEh(ValueObj).Kind := dtkTimeEh;
        except
        end;
      end;
      ctCombo:
      begin
        if TypeObj.ItemIndex = 0 then
        begin
          TComboBox(ValueObj).Items.Text := StringReplace(GetParamValue(OPT_values), ';', #13#10, [rfReplaceAll]);
          s := StringReplace(GetParamValue(OPT_fields), ';', #13#10, [rfReplaceAll]);
          if Trim(s) = '' then
            ValueKeyValues.Text := TComboBox(ValueObj).Items.Text
          else
            ValueKeyValues.Text := s;
        end;
      end;
      ctLookup:
      begin
        try
          TDBLookupComboBoxEh(ValueObj).KeyField := GetParamValue(OPT_fkField);
          TDBLookupComboBoxEh(ValueObj).ListField := GetParamValue(OPT_displayField);
          if FieldType = OPTS_MLookUpCreat then s := FSettings.MainDescriptor
          else s := GetParamValue(OPT_baseDescriptor);
          sql := 'select ' + TDBLookupComboBoxEh(ValueObj).KeyField + ', ' + TDBLookupComboBoxEh(ValueObj).ListField +
            ' from ' + GetParamValue(OPT_fkTable) + ' ' + GetParamValue(OPT_where);
          LookupSource.DataSet := ConnectionsList.GetDataSet(GetParamValue(OPT_baseDescriptor), qtUserDefined, sql);
          LookupSource.DataSet.Open;
        except
          try
            sql := 'select ' + TDBLookupComboBoxEh(ValueObj).KeyField + ', ' + TDBLookupComboBoxEh(ValueObj).ListField +
              ' from ' + GetParamValue(OPT_fkTable);
            TUniQuery(LookupSource.DataSet).SQL.Text := sql;
            LookupSource.DataSet.Open;
          except
          end;
        end;
      end;
    end;

    if Assigned(PreviewProc) then PreviewProc;
  finally
    sl.Free;
  end;
end;

procedure TRecordStd.SetFontColor(val: TColor);
var
  i: integer;

begin
  if not IsDone then FFontColor := clRed
  else FFontColor := val;
  ConcObj.Font.Color := FFontColor;
  FieldObj.Font.Color := FFontColor;
  TypeObj.Font.Color := FFontColor;
  ExprObj.Font.Color := FFontColor;
  case ValueObjType of
    ctEdit, ctCombo: TComboBox(ValueObj).Font.Color := FFontColor;
    ctNumeric: TDBNumberEditEh(ValueObj).Font.Color := FFontColor;
    ctDate: TDBDateTimeEditEh(ValueObj).Font.Color := FFontColor;
    ctLookup: TDBLookupComboboxEh(ValueObj).Font.Color := FFontColor;
  end;
  for i := 0 to Length(FLabels) - 1 do FLabels[i].Font.Color := FFontColor;
end;

procedure TRecordStd.SetHeight(val: integer);
var
  i: integer;

begin
  if val < 0 then exit;
  FHeight := val;
  ConcObj.Height := FHeight;
  FieldObj.Height := FHeight;
  TypeObj.Height := FHeight;
  ExprObj.Height := FHeight;
  ValueObj.Height := FHeight;
  for i := 0 to Length(FLabels) - 1 do FLabels[i].Height := FHeight - 4;
end;

procedure TRecordStd.SetIndex(val: integer);
var
  i: integer;

begin
  if (val < 0) then exit;
  FIndex := val;
  ConcObj.Tag := FIndex;
  FieldObj.Tag := FIndex;
  TypeObj.Tag := FIndex;
  ExprObj.Tag := FIndex;
  ValueObj.Tag := FIndex;
  for i := 0 to Length(FLabels) - 1 do FLabels[i].Tag := FIndex;
  if FIndex = 0 then FLabels[0].Enabled := false;
end;

procedure TRecordStd.SetTop(val: integer);
var
  i: integer;

begin
  if val < 0 then exit;
  FTop := val;
  ConcObj.Top := FTop;
  FieldObj.Top := FTop;
  TypeObj.Top := FTop;
  ExprObj.Top := FTop;
  ValueObj.Top := FTop;
  for i := 0 to Length(FLabels) - 1 do FLabels[i].Top := FTop;
end;

procedure TRecordStd.SetValue(val: Variant);
begin
  if not Assigned(ValueObj) then SetField(FieldPK, '', false);
  if not Assigned(ValueObj) then exit;

  case ValueObjType of
    ctEdit:
      if VarIsNull(val) then TEdit(ValueObj).Text := ''
      else TEdit(ValueObj).Text := VarToStr(val);
    ctNumeric:
    try
      TDBNumberEditEh(ValueObj).Value := val;
    except
      TDBNumberEditEh(ValueObj).Value := Null;
    end;
    ctDate:
    try
      TDBDateTimeEditEh(ValueObj).Value := val;
    except
      TDBDateTimeEditEh(ValueObj).Value := Null;
    end;
    ctCombo:
    begin
      if VarIsNull(val) then TComboBox(ValueObj).ItemIndex := -1
      else TComboBox(ValueObj).ItemIndex := ValueKeyValues.IndexOf(VarToStr(val));
    end;
    ctLookup: TDBLookupComboboxEh(ValueObj).KeyValue := val;
  end;
end;

procedure TRecordStd.TypeObjChange(Sender: TObject);
begin
  CreateValueObject;
  FontColor := clBlack;
  FLabels[2].Caption := TypeObj.Text;
end;

procedure TRecordStd.ValueObjChange(Sender: TObject);
begin
  FontColor := clBlack;
  FLabels[4].Caption := DisplayValue;
  if Assigned(PreviewProc) then PreviewProc;
end;

{ TFTmplConstructor }

procedure TFTmplConstructor.AddRecord(ObjectName, FieldName: string; Value: Variant; AExpr: TExpression; AConcRule: TConcat);
var
  _top: integer;
  pk: Variant;
  
begin
  try
    if Fields.Locate('OBJECT_NAME;FIELD_NAME', VarArrayOf([ObjectName, FieldName]), [loCaseInsensitive]) then
      pk := Fields.FieldByName('PK').Value
    else
      pk := null;

    if Length(RecordsStd) = 0 then
      _top := lbCapField.Top + lbCapField.Height + 2
    else
      _top := RecordsStd[High(RecordsStd)].Top + CTRLHEIGHT + 1;

    SetLength(RecordsStd, Length(RecordsStd) + 1);
    RecordsStd[High(RecordsStd)] := TRecordStd.Create(ScrollBox, Fields, _top, pk, FieldName, Value, AExpr, AConcRule, High(RecordsStd));
    RecordsStd[High(RecordsStd)].FSetIdx := SetCurrIndex;
    SetCurrIndex(High(RecordsStd));
    RecordsStd[High(RecordsStd)].PreviewProc := ShowPreview;
  except
  end;
  if Length(RecordsStd) > 0 then
  begin
    btnDelete.Enabled := true;
    btnClear.Enabled := true;
  end;
end;

procedure TFTmplConstructor.btnAddClick(Sender: TObject);
begin
  AddRecord('', '', Null, exEqual, ccAnd);
end;

procedure TFTmplConstructor.btnSaveClick(Sender: TObject);
begin
  FString := CreateTemplateFull;
  f_ok := true;
  Close;
end;

procedure TFTmplConstructor.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFTmplConstructor.btnClearClick(Sender: TObject);
begin
  if Application.MessageBox('Удалить все строки???', 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;
  ClearRecords;
  ShowPreview;
end;

procedure TFTmplConstructor.btnDeleteClick(Sender: TObject);
begin
  DelRecord(CurrIndex);
  ShowPreview;
end;

procedure TFTmplConstructor.ClearRecords;
var
  i: integer;

begin
  for i := 0 to Length(RecordsStd) - 1 do
    if Assigned(RecordsStd[i]) then FreeAndNil(RecordsStd[i]);

  SetLength(RecordsStd, 0);
  btnDelete.Enabled := false;
  btnClear.Enabled := false;
end;

function TFTmplConstructor.CreateTemplate: string;
var
  i: integer;

begin
  result := '';
  for i := 0 to Length(RecordsStd) - 1 do
  begin
    if not RecordsStd[i].IsDone then continue;
    if result = '' then
      result := CreateTemplateString(RecordsStd[i])
    else
      result := result + ' ' + GetConcatStr(RecordsStd[i].FieldConcat) + ' ' + CreateTemplateString(RecordsStd[i]);
  end;
end;

function TFTmplConstructor.CreateTemplateFull: string;
const
  tm_template = '{"name": "%s", "value": "%s"}';

var
  tm_name: string;
  tm_val: string;
  i, idx: integer;
  names: TStringList;

begin
  if chbCreateAsList.Checked then
  begin
    names := TStringList.Create;
    try
      for i := 0 to Length(RecordsStd) - 1 do
      begin
        if not RecordsStd[i].IsDone then continue;

        tm_val := CreateTemplateString(RecordsStd[i]);
        if i < Length(RecordsStd)-1 then tm_val := tm_val + ' ' + GetConcatStr(RecordsStd[i+1].FieldConcat)
        else tm_val := tm_val + ' AND';

        idx := 1;
        if RecordsStd[i].ObjectName <> '' then tm_name := RecordsStd[i].ObjectName + '.';
        tm_name := tm_name + RecordsStd[i].FieldName;
        if names.IndexOf(tm_name) > -1 then
        begin
          while names.IndexOf(tm_name + IntToStr(idx)) > -1 do Inc(idx);
          tm_name := tm_name + IntToStr(idx);
        end;

        if result = '' then
          result := Format(tm_template, [tm_name, tm_val])
        else
          result := result + ', ' + Format(tm_template, [tm_name, tm_val]);
      end;
    finally
      names.Free;
    end;
  end else
  begin
    tm_val := '(' + CreateTemplate + ') AND';

    idx := 0;
    if (Length(RecordsStd) > 0) then
    begin
      while (Length(RecordsStd) < idx) and (not RecordsStd[idx].IsDone) do Inc(idx);
      if (idx > 0) and (idx = Length(RecordsStd)) then Dec(idx);
      if RecordsStd[idx].ObjectName <> '' then tm_name := RecordsStd[idx].ObjectName + '.';
      tm_name := tm_name + RecordsStd[idx].FieldName;
    end else
      tm_name := 'TEMPLATE';

    result := Format(tm_template, [tm_name, tm_val]);
  end;

  if result <> '' then result := '[' + result + ']';
end;

function TFTmplConstructor.CreateTemplateString(r: TRecordStd): string;
var
  quot: string;
  obj: string;
    
begin
  obj := r.ObjectName;
  if obj <> '' then obj := obj + '.'; 
  
  if r.IsNull then
  begin
    if r.Expression in [exNotEqual, exNotLike] then result := obj + r.FieldName + ' IS NOT NULL'
    else result := obj + r.FieldName + ' IS NULL';
  end else
  begin
    if r.Expression = exNotLike then
      result := Format(GetExprString(r.Expression), [obj + r.FieldName])
    else
      result := obj + r.FieldName + ' ' + GetExprString(r.Expression);

    if r.InputType = 0 then
    begin
      case r.ValueType of
        ctEdit, ctDate, ctCombo, ctLookup: quot := '''';
        else quot := '';
      end;
    end else
      quot := '';

    case r.Expression of
      exEqual, exNotEqual, exLarge, exSmall, exEqLarge, exEqSmall: result := result + ' ' + quot + VarToStr(r.Value) + quot;
      exLike, exNotLike: result := result + ' ''%' + VarToStr(r.Value) + '%''';
      exIn, exNotIn: result := result + ' (' + VarToStr(r.Value) + ')';
      exIs: result := result + ' ' + VarToStr(r.Value);
    end;
  end;
  
  if result <> '' then result := '(' + result + ')';
end;

procedure TFTmplConstructor.DelRecord(Index: integer);
var
  i: integer;
  _top: integer;

begin
  if (Length(RecordsStd) > Index) and (Index >= 0) and Assigned(RecordsStd[Index]) then
  begin
    RecordsStd[Index].Free;
    if (Index < Length(RecordsStd) - 1) then
      RecordsStd[Index] := RecordsStd[High(RecordsStd)];

    SetLength(RecordsStd, Length(RecordsStd) - 1);
    for i := index to Length(RecordsStd) - 1 do
    begin
      if i = 0 then
        _top := lbCapField.Top + lbCapField.Height + 2
      else
        _top := RecordsStd[i - 1].Top + lbCapField.Height + 5;

      RecordsStd[i].Top := _top;
      RecordsStd[i].Index := i;
    end;

    if Index >= Length(RecordsStd) then Index := High(RecordsStd);
    if Index < 0 then Index := 0;
    SetCurrIndex(Index);
  end;
  if Length(RecordsStd) <= 0 then
  begin
    btnDelete.Enabled := false;
    btnClear.Enabled := false;
  end;
end;

function TFTmplConstructor.DelSpecSymb(s: string): string;
begin
  result := '';
  if Length(s) <= 0 then exit;
  s := Trim(s);

  while (s[1] = #39) or (s[1] = '(') or (s[1] = ')') do
  begin
    Delete(s, 1, 1);
    if Length(s) <= 0 then break;
    s := Trim(s);
  end;
  if Length(s) > 0 then
    while (s[Length(s)] = #39) or (s[Length(s)] = '(') or (s[Length(s)] = ')') do
    begin
      Delete(s, Length(s), 1);
      if Length(s) <= 0 then break;
      s := Trim(s);
    end;
    
  //теперь симыол %
  if Length(s) > 0 then
    while (s[1] = '%') do
    begin
      Delete(s, 1, 1);
      if Length(s) <= 0 then break;
      s := Trim(s);
    end;
  if Length(s) > 0 then
    while (s[Length(s)] = '%') do
    begin
      Delete(s, Length(s), 1);
      if Length(s) <= 0 then break;
      s := Trim(s);
    end;

  result := s;
end;

function TFTmplConstructor.Execute(AFields: TMemTableEh; TmplType: TTemplateType; Tmpl: string = ''): boolean;
begin
  if (not Assigned(AFields)) or (not AFields.Active) then
    raise Exception.Create('Недоступен набор полей для работы с шаблонами!');

  TemplateType := TmplType;
  FString := Tmpl;
  Fields := AFields;
  SetControls;
  self.ShowModal;
  result := f_ok;
end;

procedure TFTmplConstructor.ExtractValues(fstr: string; SL: TStringList);
var
  json, dict: TJson;
  i: integer;

begin
  SL.Clear;
  json := TJson.Create;
  try
    json.Load(fstr);

    for i := 0 to json.Count - 1 do
    begin
      dict := json.AsObject(i);
      if Assigned(dict) and dict.KeyExists('value') then SL.Add(dict.ValueOf('value'));
    end;
  finally
    json.Free;
  end;
end;

procedure TFTmplConstructor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
  FSettings.TmplCCreateAsList := chbCreateAsList.Checked;
end;

procedure TFTmplConstructor.FormCreate(Sender: TObject);
begin
  SetLength(RecordsStd, 0);
  CurrIndex := 0;
  f_ok := false;
  btnDelete.Enabled := false;
  btnClear.Enabled := false;
  chbCreateAsList.Checked := FSettings.TmplCCreateAsList;
end;

procedure TFTmplConstructor.FormDestroy(Sender: TObject);
begin
  ClearRecords;
end;

procedure TFTmplConstructor.FormShow(Sender: TObject);
begin
  ShowPreview;
end;

procedure TFTmplConstructor.ParseField(fstr: string; SL: TStringList);
var
  i: integer;
  _ts: string;
  tmpSL: TStringList;

begin
  SL.Clear;
  tmpSL := TStringList.Create;

  ParseString(fstr, tmpSL);

  tmpSL.Strings[0] := StringReplace(tmpSL.Strings[0], 'lower', '', [rfIgnoreCase]);
  tmpSL.Strings[0] := StringReplace(tmpSL.Strings[0], 'upper', '', [rfIgnoreCase]);
  tmpSL.Strings[0] := StringReplace(tmpSL.Strings[0], '(', '', [rfReplaceAll]);
  tmpSL.Strings[0] := StringReplace(tmpSL.Strings[0], ')', '', [rfReplaceAll]);
  tmpSL.Strings[0] := StringReplace(tmpSL.Strings[0], '[', '', [rfReplaceAll]);
  tmpSL.Strings[0] := StringReplace(tmpSL.Strings[0], ']', '', [rfReplaceAll]);

  SL.Add(tmpSL.Strings[0]);
  if tmpSL.Count > 1 then SL.Add(tmpSL.Strings[1])
  else SL.Add('');
  for i := 2 to tmpSL.Count - 1 do
  begin
    if _ts = '' then
      _ts := tmpSL.Strings[i]
    else
      _ts := _ts + ' ' + tmpSL.Strings[i]
  end;
  SL.Add(_ts);

  tmpSL.Free;
end;

procedure TFTmplConstructor.ParseFields(fstr: string; SL: TStringList);
var
  i: integer;
  _ts: string;
  tmpSL: TStringList;

begin
  SL.Clear;
  tmpSL := TStringList.Create;

  ParseString(fstr, tmpSL);

  for i := 0 to tmpSL.Count - 1 do
  begin
    if (UpperCase(tmpSL.Strings[i]) = 'OR') or (UpperCase(tmpSL.Strings[i]) = 'AND') then
    begin
      SL.Add(Trim(_ts));
      _ts := '';
      SL.Add(tmpSL.Strings[i]);
    end else
    begin
      if (UpperCase(tmpSL.Strings[i]) = 'NOT') then SL.Add(tmpSL.Strings[i])
      else if _ts = '' then
        _ts := tmpSL.Strings[i]
      else
        _ts := _ts + ' ' + tmpSL.Strings[i];
    end;
  end;
  if (_ts <> '') and ((SL.Count = 0) or (_ts <> SL.Strings[SL.count - 1])) then SL.Add(_ts);

  tmpSL.Free;
end;

procedure TFTmplConstructor.SetControls;
var
  conditions, elements: TStringList;
  i, j: integer;
  conc: TConcat;
  notflg: boolean;
  objName, fieldName: string;
  values: TStringList;

begin
  if FString = '' then exit;
  conditions := TStringList.Create;
  elements := TStringList.Create;
  values := TStringList.Create;
  conc := ccAnd;
  notflg := false;

  try
    ExtractValues(FString, values);
    for j := 0 to values.Count - 1 do
    begin
      ParseFields(values.Strings[j], conditions);
      for i := 0 to conditions.Count - 1 do
      begin
        if (UpperCase(conditions.Strings[i]) <> 'OR') and (UpperCase(conditions.Strings[i]) <> 'AND') then
        begin
          if UpperCase(conditions.Strings[i]) = 'NOT' then
          begin
            notflg := true;
            continue;
          end;
          ParseField(conditions.Strings[i], elements);
          if notflg then
          begin
            if UpperCase(elements.Strings[1]) = 'IS' then
              elements.Strings[2] := 'NOT ' + elements.Strings[2]
            else
              elements.Strings[1] := 'NOT ' + elements.Strings[1];
          end;
          notflg := false;

          SplitFieldName(DelSpecSymb(elements.Strings[0]), objName, fieldName);
          AddRecord(objName, fieldName, DelSpecSymb(elements.Strings[2]), GetExpression(elements.Strings[1]), conc);
          if Length(RecordsStd) > 0 then RecordsStd[High(RecordsStd)].FontColor := clBlue;
        end else
        begin
          if UpperCase(conditions.Strings[i]) = 'OR' then conc := ccOr
          else conc := ccAnd;
        end;
      end;
    end;
  except
    on e: Exception do
      Application.MessageBox(pchar('Не удалось разобрать текущий шаблон!'#13#10 + e.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;

  conditions.Free;
  elements.Free;
  values.Free;
end;

procedure TFTmplConstructor.SetCurrIndex(idx: integer);
var
  i: integer;

begin
  CurrIndex := idx;
  for i := 0 to Length(RecordsStd) - 1 do
    if i = idx then
      RecordsStd[i].EditMode := true
    else
      RecordsStd[i].EditMode := false;
end;

procedure TFTmplConstructor.ParseString(s: string; SL: TStringList);
var
  i: integer;
  bracket: boolean;
  _ts: string;

begin
  bracket := false;
  SL.Clear;
  i := 1;

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
        SL.Add(Trim(StringReplace(StringReplace(_ts, #3, '<?', [rfReplaceAll]), #4, '?>', [rfReplaceAll])));
        _ts := '';
      end;
    Inc(i);
  end;
  
  if (_ts <> '') and ((SL.Count = 0) or (_ts <> SL.Strings[SL.count - 1])) then
    SL.Add(Trim(StringReplace(StringReplace(_ts, #3, '<?', [rfReplaceAll]), #4, '?>', [rfReplaceAll])));
end;

procedure TFTmplConstructor.ShowPreview;
begin
  rePreview.Lines.Text := CreateTemplate;
end;

end.
