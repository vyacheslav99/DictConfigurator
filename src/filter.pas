unit filter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Mask,
  DB, ImgList, ComCtrls, ToolWin, DBCtrls, DBCtrlsEh, ToolCtrlsEh, DBGridEh, DBLookupEh;

type
  TExpression = (exNone, exEqual, exNotEqual, exLike, exNotLike, exIn, exLarge, exSmall, exEqLarge, exEqSmall, exIs);
  TConcat = (ccAnd, ccOr);
  TObjType = (otVariant, otInt, otFloat, otString, otDateTime, otDate, otTime, otLookup);

  TSetIdx = procedure(idx: integer) of object;

  TRecordEx = class
  private
    FSetIdx: TSetIdx;
    FIndex: integer;
    FFieldName: string;
    FFieldCap: string;
    FieldConcObj: TComboBox;
    FieldObj: TComboBox;
    ExprObj: TComboBox;
    ValueObj: TEdit;
    FTop: integer;
    FHeight: integer;
    FFontColor: TColor;
    FOKeyItems: TStringList;
    FLabels: array of TStaticText;
    FEditMode: boolean;
    procedure SetTop(value: integer);
    procedure SetFieldName(value: string);
    procedure SetFieldCap(value: string);
    procedure SetValue(value: string);
    function GetValue: string;
    procedure SetExpression(value: TExpression);
    function GetExpr: TExpression;
    procedure SetConcat(value: TConcat);
    function GetConc: TConcat;
    procedure SetIndex(value: integer);
    procedure SetFontColor(value: TColor);
    procedure SetHeight(value: integer);
    function GetLabel(index: integer): TStaticText;
    procedure SetEditMode(value: boolean);
    //реакция на события
    procedure FieldObjChange(Sender: TObject);
    procedure ExprObjChange(Sender: TObject);
    procedure ValueObjChange(Sender: TObject);
    procedure ConcatObjChange(Sender: TObject);
    procedure AllOnEnter(Sender: TObject);
  public
    PreviewProc: procedure of object;
    function IsDone: boolean;
    function LabelsCount: integer;
    property Top: integer read FTop write SetTop;
    property Height: integer read FHeight write SetHeight;
    property FieldName: string read FFieldName write SetFieldName;
    property FieldCap: string read FFieldCap write SetFieldCap;
    property Expression: TExpression read GetExpr write SetExpression;
    property SValue: string read GetValue write SetValue;
    property FieldConcat: TConcat read GetConc write SetConcat;
    property Index: integer read FIndex write SetIndex;
    property FontColor: TColor read FFontColor write SetFontColor;
    property RowLabel[index: integer]: TStaticText read GetLabel;
    property EditMode: boolean read FEditMode write SetEditMode;
    constructor Create(AParent: TWinControl; ATop: integer; AFieldName, AFieldCap, AValue: string; AExpr: TExpression;
      AConcRule: TConcat; AFields: TStringList; AIndex: integer);
    destructor Destroy; override;
  end;

  TRecordBase = class
  private
    FObjType: TObjType;
    FField: TField;
    ValueObj1: TControl;
    ValueObj2: TControl;
    ExLabel1: TLabel;
    ExLabel2: TLabel;
    FTop: integer;
    FUsed: TCheckBox;
    FieldConcObj: TComboBox;
    FLookupDataSet: TDataSet;
    FLookupSource: TDataSource;
    FKeyValues: TStringList;
    procedure CheckBoxClick(Sender: TObject);
    procedure CtrlChange(Sender: TObject);
    procedure SetTop(value: integer);
    procedure SetField(AField: TField);
    function GetValue(caseSens: boolean): string;
    procedure SetValue(AExpr: TExpression; value: string);
    procedure ChangeField(AParent: TWinControl; ATop: integer; AField: TField);
    function GetUsed: boolean;
    procedure SetUsed(value: boolean);
    procedure SetConcat(value: TConcat);
    function GetConc: TConcat;
  public
    PreviewProc: procedure of object;
    property Top: integer read FTop write SetTop;
    property DataField: TField read FField write SetField;
    property Expr[caseSens: boolean]: string read GetValue;
    property Used: boolean read GetUsed write SetUsed;
    property FieldConcat: TConcat read GetConc write SetConcat;
    constructor Create(AParent: TWinControl; ATop: integer; AField: TField);
    destructor Destroy; override;
  end;

  TRecordsEx = array of TRecordEx;
  TRecordsBase = array of TRecordBase;

  TfFilter = class(TForm)
    Panel1: TPanel;
    btnApply: TBitBtn;
    btnCancel: TBitBtn;
    ImageList1: TImageList;
    PageControl1: TPageControl;
    tsExtended: TTabSheet;
    ToolBar1: TToolBar;
    btnAdd: TToolButton;
    btnDelete: TToolButton;
    btnClear: TToolButton;
    ScrollBox1: TScrollBox;
    lbCapField: TStaticText;
    lbCapExpr: TStaticText;
    lbCapValue: TStaticText;
    lbCapConcat: TStaticText;
    btnOff: TBitBtn;
    ToolButton1: TToolButton;
    btnHelp: TToolButton;
    tsGeneral: TTabSheet;
    ScrollBox2: TScrollBox;
    rbnOr: TRadioButton;
    rbnAnd: TRadioButton;
    chbAddOldFilter: TCheckBox;
    rePreview: TRichEdit;
    Label1: TLabel;
    Panel2: TPanel;
    chbCaseSensitive: TCheckBox;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnOffClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure rbnOrClick(Sender: TObject);
    procedure chbAddOldFilterClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chbCaseSensitiveClick(Sender: TObject);
  private
    CurrIndex: integer;
    FieldsList: TStringList;
    f_ok: boolean;
    RecordsEx: TRecordsEx;
    RecordsBase: TRecordsBase;
    FDataSet: TDataSet;
    FGrid: TDBGridEh;
    FString: string;
    FOldFilter: string;
    DefConcat: TConcat;
    AddOldFilter: boolean;
    function CreateFilter: string;
    procedure SetControls;
    procedure SetDataSet(ADataSet: TDataSet);
    procedure ClearRecordsEx;
    procedure FreeRecordsBase;
    procedure ResetBase;
    procedure AddRecordEx(Field: TField; Value: string; AExpr: TExpression; AConcRule: TConcat);
    procedure SetRecordBase(Field: TField; Value: string; AExpr: TExpression; AConcRule: TConcat);
    procedure DelRecordEx(Index: integer);
    procedure SetCurrIndex(idx: integer);
    procedure ParseFields(fstr: string; SL: TStringList);
    procedure ParseField(fstr: string; SL: TStringList);
    procedure ParseString(s: string; SL: TStringList);
    function DelSpecSymb(s: string): string;
    function CreateFilterString(r: TRecordEx): string;
    procedure SetOldFilter(OFilter: string);
    procedure ShowPreview;
    procedure CopyFieldParams(Grid: TDBGridEh);
    property OldFilter: string read FOldFilter write SetOldFilter;
  public
    procedure ResetFilter;
    function Execute(Grid: TDBGridEh; Extend: boolean = false; Expr: string = ''): boolean;
    property AFilter: string read FString;
  end;

implementation

{$R *.dfm}

const
  CTRLHEIGHT = 21;
  FILLRECLIMIT = 10000;
  LOOKUPFIELDSDELIM = ';';
  EMPTY_VALUE = '<ПУСТО>';

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
    ccAnd: result := 'and';
    ccOr: result := 'or';
  end;
end;

function GetExprString(e: TExpression): string;
begin
  case e of
    exNone: result := '';
    exEqual: result := '=';
    exNotEqual: result := '<>';
    exLike: result := 'LIKE';
    exNotLike: result := 'NOT %s LIKE';
    exIn: result := 'IN';
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
  result := ccOr;
  if (UpperCase(s) = 'OR') or (AnsiUpperCase(s) = 'ИЛИ') then result := ccOr
  else if (UpperCase(s) = 'AND') or (AnsiUpperCase(s) = 'И') then result := ccAnd;
end;

function FindColByFieldName(Grid: TDBGridEh; FieldName: string): TColumnEh;
var
  i: integer;

begin
  for i := 0 to Grid.Columns.Count - 1 do
  begin
    result := Grid.Columns[i];
    if AnsiUpperCase(result.FieldName) = AnsiUpperCase(FieldName) then exit;
  end;
  result := nil;
end;

{ TRecordEx }

procedure TRecordEx.AllOnEnter(Sender: TObject);
begin
  if @FSetIdx <> nil then FSetIdx(TComponent(Sender).Tag);
end;

procedure TRecordEx.ConcatObjChange(Sender: TObject);
begin
  FLabels[0].Caption := FieldConcObj.Text;
  if Assigned(PreviewProc) then PreviewProc;
end;

constructor TRecordEx.Create(AParent: TWinControl; ATop: integer; AFieldName, AFieldCap, AValue: string; AExpr: TExpression;
  AConcRule: TConcat; AFields: TStringList; AIndex: integer);
var
  ExprItems: TStringList;
  ConcItems: TStringList;
  i: integer;

begin
  if not Assigned(AParent) then
    raise Exception.Create('Не удалось создать строку, отсутствует объект владелец элемента!');

  inherited Create;
  ExprItems := TStringList.Create;
  ExprItems.Add('<нет>');
  ExprItems.Add('=');
  ExprItems.Add('<>');
  ExprItems.Add('содержит');
  ExprItems.Add('не содержит');
  ExprItems.Add('один из');
  ExprItems.Add('>');
  ExprItems.Add('<');
  ExprItems.Add('>=');
  ExprItems.Add('<=');
  ExprItems.Add('is');
  ConcItems := TStringList.Create;
  ConcItems.Add('ИЛИ');
  ConcItems.Add('И');
  FOKeyItems := TStringList.Create;

  FieldObj := TComboBox.Create(AParent);
  ExprObj := TComboBox.Create(AParent);
  ValueObj := TEdit.Create(AParent);
  FieldConcObj := TComboBox.Create(AParent);
  SetLength(FLabels, 4);
  for i := 0 to Length(FLabels) - 1 do
  begin
    FLabels[i] := TStaticText.Create(AParent);
    FLabels[i].Parent := AParent;
    FLabels[i].Visible := false;
    FLabels[i].AutoSize := false;
    FLabels[i].Color := clBtnFace;
    FLabels[i].Enabled := true;
    FLabels[i].BorderStyle := sbsSunken;
    FLabels[i].Alignment := taCenter;
    FLabels[i].Transparent := false;
    FLabels[i].OnClick := AllOnEnter;
    case i of
      0:
      begin
        FLabels[i].Left := TfFilter(AParent.Owner).lbCapConcat.Left;
        FLabels[i].Width := TfFilter(AParent.Owner).lbCapConcat.Width;
      end;
      1:
      begin
        FLabels[i].Left := TfFilter(AParent.Owner).lbCapField.Left;
        FLabels[i].Width := TfFilter(AParent.Owner).lbCapField.Width;
      end;
      2:
      begin
        FLabels[i].Left := TfFilter(AParent.Owner).lbCapExpr.Left;
        FLabels[i].Width := TfFilter(AParent.Owner).lbCapExpr.Width;
      end;
      3:
      begin
        FLabels[i].Left := TfFilter(AParent.Owner).lbCapValue.Left;
        FLabels[i].Width := TfFilter(AParent.Owner).lbCapValue.Width;
      end;
    end;
  end;

  with FieldConcObj do
  begin
    ParentColor := false;
    ParentCtl3D := false;
    ParentFont := false;
    Parent := AParent;
    Ctl3D := true;
    Color := clBtnFace;
    Left := TfFilter(Parent.Owner).lbCapConcat.Left;
    Width := TfFilter(Parent.Owner).lbCapConcat.Width;
    Items.AddStrings(ConcItems);
    Style := csDropDownList;
    if AConcRule = ccOr then ItemIndex := 0
    else ItemIndex := 1;
    Visible := true;
    Enabled := AIndex <> 0;
    OnChange := ConcatObjChange;
    OnEnter := AllOnEnter;
    FieldConcObj.OnChange(FieldConcObj);
  end;
  with FieldObj do
  begin
    ParentColor := false;
    ParentCtl3D := false;
    ParentFont := false;
    Parent := AParent;
    Ctl3D := true;
    Color := clBtnFace;
    Left := TfFilter(Parent.Owner).lbCapField.Left;//FieldConcObj.Left + FieldConcObj.Width + 2;
    Width := TfFilter(Parent.Owner).lbCapField.Width;
    for i := 0 to AFields.Count - 1 do
    begin
      Items.Add(AFields.Values[AFields.Names[i]]);
      FOKeyItems.Add(AFields.Names[i]);
    end;
    Style := csDropDownList;
    //ItemIndex := 0;
    Visible := true;
    OnChange := FieldObjChange;
    OnEnter := AllOnEnter;
  end;
  with ExprObj do
  begin
    ParentColor := false;
    ParentCtl3D := false;
    ParentFont := false;
    Parent := AParent;
    Ctl3D := true;
    Color := clBtnFace;
    Left := TfFilter(Parent.Owner).lbCapExpr.Left;//FieldObj.Left + FieldObj.Width + 2;
    Width := TfFilter(Parent.Owner).lbCapExpr.Width;
    Items.AddStrings(ExprItems);
    Style := csDropDownList;
    //ItemIndex := 0;
    Visible := true;
    OnEnter := AllOnEnter;
    OnChange := ExprObjChange;
  end;
  with ValueObj do
  begin
    ParentColor := false;
    ParentCtl3D := false;
    ParentFont := false;
    Parent := AParent;
    Ctl3D := true;
    Color := clBtnFace;
    Anchors := Anchors + [akRight];
    Left := TfFilter(Parent.Owner).lbCapValue.Left;//ExprObj.Left + ExprObj.Width + 2;
    Width := TfFilter(Parent.Owner).lbCapValue.Width;
    ReadOnly := false;
    Visible := true;
    OnChange := ValueObjChange;
    OnEnter := AllOnEnter;
  end;
  Top := ATop;
  Height := CTRLHEIGHT;//TfFilter(AParent.Owner).lbCapField.Height;
  FEditMode := true;
  FieldName := AFieldName;
  FieldCap := AFieldCap;
  Expression := AExpr;
  FieldConcat := AConcRule;
  SValue := AValue;
  Index := AIndex;
  ExprItems.Free;
  ConcItems.Free;
end;

destructor TRecordEx.Destroy;
var
  i: integer;

begin
  FieldObj.Free;
  ExprObj.Free;
  ValueObj.Free;
  FieldConcObj.Free;
  FOKeyItems.Free;
  for i := 0 to Length(FLabels) - 1 do
    if Assigned(FLabels[i]) then FreeAndNil(FLabels[i]);
  SetLength(FLabels, 0);
  inherited;
end;

procedure TRecordEx.ExprObjChange(Sender: TObject);
begin
  FontColor := clBlack;
  FLabels[2].Caption := ExprObj.Text;
  if Assigned(PreviewProc) then PreviewProc;
end;

procedure TRecordEx.FieldObjChange(Sender: TObject);
begin
  FFieldCap := TComboBox(Sender).Text;
  FFieldName := FOKeyItems.Strings[TComboBox(Sender).ItemIndex];
  FontColor := clBlack;
  FLabels[1].Caption := FFieldCap;
  if Assigned(PreviewProc) then PreviewProc;
end;

function TRecordEx.GetConc: TConcat;
begin
  result := GetConcat(FieldConcObj.Text);
end;

function TRecordEx.GetExpr: TExpression;
begin
  result := GetExpression(ExprObj.Text);
end;

function TRecordEx.GetLabel(index: integer): TStaticText;
begin
  if (index < 0) or (index >= Length(FLabels)) then raise Exception.Create('Индекс метки вышел за границы массива!');
  result := FLabels[index];
end;

function TRecordEx.GetValue: string;
begin
  result := ValueObj.Text;
end;

function TRecordEx.IsDone: boolean;
begin
  result := (FieldName <> '') and (Expression <> exNone) and (SValue <> '');
end;

function TRecordEx.LabelsCount: integer;
begin
  result := Length(FLabels);
end;

procedure TRecordEx.SetConcat(value: TConcat);
begin
  FieldConcObj.Text := FieldConcObj.Items.Strings[Ord(value)];
//  FLabels[0].Caption := FieldConcObj.Text;
end;

procedure TRecordEx.SetEditMode(value: boolean);
var
  i: integer;

begin
  FEditMode := value;
  FieldConcObj.Visible := FEditMode;
  FieldObj.Visible := FEditMode;
  ExprObj.Visible := FEditMode;
  ValueObj.Visible := FEditMode;
  for i := 0 to Length(FLabels) - 1 do FLabels[i].Visible := not FEditMode;
end;

procedure TRecordEx.SetExpression(value: TExpression);
begin
  ExprObj.ItemIndex := Ord(value);
  ExprObj.OnChange(ExprObj);
//  ExprObj.Text := ExprObj.Items.Strings[Ord(value)];
//  FLabels[2].Caption := ExprObj.Text;
end;

procedure TRecordEx.SetFieldCap(value: string);
begin
  FFieldCap := value;
  FieldObj.ItemIndex := FieldObj.Items.IndexOf(FFieldCap);
  FieldObj.OnChange(FieldObj);
//  FieldObj.Text := FFieldCap;
//  FLabels[1].Caption := FFieldCap;
end;

procedure TRecordEx.SetFieldName(value: string);
begin
  FFieldName := value;
end;

procedure TRecordEx.SetFontColor(value: TColor);
var
  i: integer;

begin
  if not IsDone then FFontColor := clRed
  else FFontColor := value;
  FieldObj.Font.Color := FFontColor;
  ExprObj.Font.Color := FFontColor;
  ValueObj.Font.Color := FFontColor;
  FieldConcObj.Font.Color := FFontColor;
  for i := 0 to Length(FLabels) - 1 do FLabels[i].Font.Color := FFontColor;
end;

procedure TRecordEx.SetHeight(value: integer);
var
  i: integer;

begin
  if value < 0 then exit;
  FHeight := value;
  FieldObj.Height := FHeight;
  ExprObj.Height := FHeight;
  ValueObj.Height := FHeight;
  FieldConcObj.Height := FHeight;
  for i := 0 to Length(FLabels) - 1 do FLabels[i].Height := FHeight - 4;
end;

procedure TRecordEx.SetIndex(value: integer);
var
  i: integer;

begin
  if (value < 0) then exit;
  FIndex := value;
  FieldObj.Tag := FIndex;
  ExprObj.Tag := FIndex;
  ValueObj.Tag := FIndex;
  FieldConcObj.Tag := FIndex;
  for i := 0 to Length(FLabels) - 1 do FLabels[i].Tag := FIndex;
  if FIndex = 0 then FLabels[0].Enabled := false;
end;

procedure TRecordEx.SetTop(value: integer);
var
  i: integer;

begin
  if value < 0 then exit;
  FTop := value;
  FieldObj.Top := FTop;
  ExprObj.Top := FTop;
  ValueObj.Top := FTop;
  FieldConcObj.Top := FTop;
  for i := 0 to Length(FLabels) - 1 do FLabels[i].Top := FTop;
end;

procedure TRecordEx.SetValue(value: string);
begin
  ValueObj.Text := value;
//  FLabels[3].Caption := value;
end;

procedure TRecordEx.ValueObjChange(Sender: TObject);
begin
  FontColor := clBlack;
  FLabels[3].Caption := ValueObj.Text;
  if Assigned(PreviewProc) then PreviewProc;
end;

{ TfFilter }

procedure TfFilter.AddRecordEx(Field: TField; Value: string; AExpr: TExpression; AConcRule: TConcat);
var
  _top: integer;

begin
  if (Field.Lookup) or (Field.Calculated) then exit;
  try
    if Length(RecordsEx) = 0 then
      _top := lbCapField.Top + lbCapField.Height + 2
    else
      _top := RecordsEx[High(RecordsEx)].Top + CTRLHEIGHT + 1;
    SetLength(RecordsEx, Length(RecordsEx) + 1);
    RecordsEx[High(RecordsEx)] := TRecordEx.Create(ScrollBox1, _top, Field.FieldName, Field.DisplayName, Value, AExpr,
      AConcRule, FieldsList, High(RecordsEx));
    RecordsEx[High(RecordsEx)].FSetIdx := SetCurrIndex;
    SetCurrIndex(High(RecordsEx));
    RecordsEx[High(RecordsEx)].PreviewProc := ShowPreview;
  except
  end;
  if Length(RecordsEx) > 0 then btnDelete.Enabled := true;
end;

procedure TfFilter.btnAddClick(Sender: TObject);
var
  n: integer;

begin
  for n := 0 to FDataSet.Fields.Count - 1 do
    if (not FDataSet.Fields.Fields[n].Lookup) and (not FDataSet.Fields.Fields[n].Calculated) then break;
  AddRecordEx(FDataSet.Fields.Fields[n], '', exNone, ccOr);
end;

procedure TfFilter.btnApplyClick(Sender: TObject);
begin
  f_ok := true;
  self.Close;
end;

procedure TfFilter.btnCancelClick(Sender: TObject);
begin
  f_ok := false;
  self.Close;
end;

procedure TfFilter.btnClearClick(Sender: TObject);
begin
  ClearRecordsEx;
end;

procedure TfFilter.btnDeleteClick(Sender: TObject);
begin
  DelRecordEx(CurrIndex);
end;

procedure TfFilter.ClearRecordsEx;
var
  i: integer;

begin
  for i := 0 to Length(RecordsEx) - 1 do
    if Assigned(RecordsEx[i]) then FreeAndNil(RecordsEx[i]);
  SetLength(RecordsEx, 0);
  btnDelete.Enabled := false;
end;

procedure TfFilter.CopyFieldParams(Grid: TDBGridEh);
var
  i: integer;
  col: TColumnEh;

begin
  for i := 0 to Grid.Columns.Count - 1 do
  begin
    Grid.Columns[i].Field.DisplayLabel := Grid.Columns[i].Title.Caption;
    Grid.Columns[i].Field.Visible := Grid.Columns[i].Visible;
  end;

  // поля, по которым нет колонок в гриде
  for i := 0 to Grid.DataSource.DataSet.Fields.Count - 1 do
  begin
    col := FindColByFieldName(Grid, Grid.DataSource.DataSet.Fields.Fields[i].FieldName);
    if not Assigned(col) then Grid.DataSource.DataSet.Fields.Fields[i].Visible := false;
  end;
end;

function TfFilter.CreateFilter: string;
var
  i: integer;

begin
  result := '';
  if PageControl1.ActivePage = tsGeneral then
  begin
    for i := 0 to Length(RecordsBase) - 1 do
    begin
      if not RecordsBase[i].Used then continue;
      if result = '' then
        result := RecordsBase[i].Expr[chbCaseSensitive.Checked]
      else
        if RecordsBase[i].Expr[chbCaseSensitive.Checked] <> '' then
          result := result + ' ' + GetConcatStr(RecordsBase[i].FieldConcat) + ' ' + RecordsBase[i].Expr[chbCaseSensitive.Checked];
    end;
    if AddOldFilter then
    begin
      if (result <> '') then
      begin
        if (OldFilter <> '') then
          result := '(' + result + ') ' + GetConcatStr(DefConcat) + ' (' + OldFilter + ')';
      end else
        if (OldFilter <> '') then
          result := OldFilter;
    end;
  end else
  begin
    for i := 0 to Length(RecordsEx) - 1 do
    begin
      if not RecordsEx[i].IsDone then continue;
      if result = '' then
        result := CreateFilterString(RecordsEx[i])
      else
        result := result + ' ' + GetConcatStr(RecordsEx[i].FieldConcat) + ' ' + CreateFilterString(RecordsEx[i]);
    end;
  end;
end;

function TfFilter.CreateFilterString(r: TRecordEx): string;
begin
  if r.Expression = exNotLike then
    result := Format(GetExprString(r.Expression), [{iif(chbCaseSensitive.Checked, }r.FieldName{, 'lower(' + r.FieldName + ')')}])
  else
    result := {iif(chbCaseSensitive.Checked,} r.FieldName{, 'lower(' + r.FieldName + ')')} +  ' ' + GetExprString(r.Expression);
  case r.Expression of
    exEqual, exNotEqual, exLarge, exSmall, exEqLarge, exEqSmall: result := result + ' ''' +
      {iif(chbCaseSensitive.Checked,} r.SValue{, AnsiLowerCase(r.SValue))} + '''';
    exLike, exNotLike: result := result + ' ''%' + {iif(chbCaseSensitive.Checked,} r.SValue{, AnsiLowerCase(r.SValue))} + '%''';
    exIn: result := result + ' (' + r.SValue + ')';
    exIs: result := result + ' ' + r.SValue;
  end;
end;

procedure TfFilter.DelRecordEx(Index: integer);
var
  i: integer;
  _top: integer;

begin
  if (Length(RecordsEx) > Index) and (Index >= 0) and Assigned(RecordsEx[Index]) then
  begin
    RecordsEx[Index].Free;
    if (Index < Length(RecordsEx) - 1) then
      RecordsEx[Index] := RecordsEx[High(RecordsEx)];
    SetLength(RecordsEx, Length(RecordsEx) - 1);
    for i := index to Length(RecordsEx) - 1 do
    begin
      if i = 0 then
        _top := lbCapField.Top + lbCapField.Height + 2
      else
        _top := RecordsEx[i - 1].Top + lbCapField.Height + 5;
      RecordsEx[i].Top := _top;
      RecordsEx[i].Index := i;
    end;
    if Index >= Length(RecordsEx) then Index := High(RecordsEx);
    if Index < 0 then Index := 0;
    SetCurrIndex(Index);
  end;
  if Length(RecordsEx) <= 0 then btnDelete.Enabled := false;
end;

function TfFilter.DelSpecSymb(s: string): string;
begin
  result := '';
  if Length(s) <= 0 then exit;

  while (s[1] = #39) or (s[1] = '(') or (s[1] = ')') do
  begin
    Delete(s, 1, 1);
    if Length(s) <= 0 then break;
  end;
  if Length(s) > 0 then
    while (s[Length(s)] = #39) or (s[Length(s)] = '(') or (s[Length(s)] = ')') do
    begin
      Delete(s, Length(s), 1);
      if Length(s) <= 0 then break;
    end;
    
  //теперь симыол %
  if Length(s) > 0 then
    while (s[1] = '%') do
    begin
      Delete(s, 1, 1);
      if Length(s) <= 0 then break;
    end;
  if Length(s) > 0 then
    while (s[Length(s)] = '%') do
    begin
      Delete(s, Length(s), 1);
      if Length(s) <= 0 then break;
    end;

  result := s;
end;

function TfFilter.Execute(Grid: TDBGridEh; Extend: boolean; Expr: string): boolean;
var
  i: integer;

begin
  if (not Assigned(Grid.DataSource)) or (not Assigned(Grid.DataSource.DataSet)) then
    raise Exception.Create('Отсутствует набор данных для фильтрации!');

  FString := '';
  FGrid := Grid;
  CopyFieldParams(Grid);
  SetDataSet(Grid.DataSource.DataSet);
  OldFilter := Trim(FDataSet.Filter);
  if FDataSet.Filtered then FString := OldFilter;
  if FString <> '' then
    FString := FString + ' or ' + Expr
  else
    FString := Expr;
    
  SetControls;
  if Extend then PageControl1.ActivePageIndex := tsExtended.PageIndex;

  for i := 0 to ScrollBox2.ComponentCount - 1 do
    case ScrollBox2.Components[i].Tag of
      1: TWinControl(ScrollBox2.Components[i]).Anchors := [akLeft, akTop, akRight];
      2: TWinControl(ScrollBox2.Components[i]).Anchors := [akTop, akRight];
    end;
    
  self.ShowModal;
  result := f_ok;
end;

procedure TfFilter.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
  
begin
  if f_ok then
  begin
    FString := CreateFilter;
    try
      if chbCaseSensitive.Checked then FDataSet.FilterOptions := FDataSet.FilterOptions - [foCaseInsensitive]
      else FDataSet.FilterOptions := FDataSet.FilterOptions + [foCaseInsensitive];
      FDataSet.Filter := FString;
      FDataSet.Filtered := FString <> '';
      if not FDataSet.Filtered then
      begin
        FGrid.ClearFilter;
        for i := 0 to FGrid.Columns.Count - 1 do
          FGrid.Columns[i].STFilter.ExpressionStr := '';
        if Assigned(FGrid.OnApplyFilter) then FGrid.OnApplyFilter(FGrid); 
      end;
    except
      on e: Exception do
        Application.MessageBox(pchar('Ошибка в строке фильтра! Задано неверное выражение для одного из полей!'#13#10 + e.Message),
          'Ошибка', MB_OK + MB_ICONERROR);
    end;
  end;
  Action := caHide;
end;

procedure TfFilter.FormCreate(Sender: TObject);
begin
  SetLength(RecordsBase, 0);
  SetLength(RecordsEx, 0);
  FieldsList := TStringList.Create;
  CurrIndex := 0;
  f_ok := false;
  PageControl1.ActivePageIndex := tsGeneral.PageIndex;
  DefConcat := ccOr;
  rbnOr.Checked := true;
  AddOldFilter := false;
  chbAddOldFilter.Checked := AddOldFilter;
  chbAddOldFilterClick(chbAddOldFilter);
end;

procedure TfFilter.FormDestroy(Sender: TObject);
begin
  ClearRecordsEx;
  FreeRecordsBase;
  FieldsList.Free;
end;

procedure TfFilter.FormShow(Sender: TObject);
begin
  ShowPreview;
end;

procedure TfFilter.PageControl1Change(Sender: TObject);
begin
  ShowPreview;
end;

procedure TfFilter.ParseField(fstr: string; SL: TStringList);
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
  SL.Add(tmpSL.Strings[1]);
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

procedure TfFilter.ParseFields(fstr: string; SL: TStringList);
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

procedure TfFilter.ResetFilter;
begin
  FDataSet.Filter := OldFilter;
  if OldFilter <> '' then
    FDataSet.Filtered := true
  else
    FDataSet.Filtered := false;
end;

procedure TfFilter.SetControls;
var
  conditions, elements: TStringList;
  i: integer;
  conc: TConcat;
  notflg: boolean;

begin
  if FString = '' then exit;
  conditions := TStringList.Create;
  elements := TStringList.Create;
  conc := ccOr;
  notflg := false;

  ParseFields(FString, conditions);
  try
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
        if notflg then elements.Strings[1] := 'NOT ' + elements.Strings[1];
        notflg := false;
        AddRecordEx(FDataSet.FieldByName(DelSpecSymb(elements.Strings[0])), DelSpecSymb(elements.Strings[2]),
          GetExpression(elements.Strings[1]), conc);
        if Length(RecordsEx) > 0 then
          RecordsEx[High(RecordsEx)].FontColor := clBlue;
        SetRecordBase(FDataSet.FieldByName(DelSpecSymb(elements.Strings[0])), DelSpecSymb(elements.Strings[2]),
          GetExpression(elements.Strings[1]), conc);
      end else
      begin
        if UpperCase(conditions.Strings[i]) = 'OR' then conc := ccOr
        else conc := ccAnd;
      end;
    end;
  except
    on e: Exception do
      Application.MessageBox(pchar('Ошибка при определении текущего фильтра! Возможность добавить новый фильтр к текущему будет недоступна. ' +
        'Сообщение ошибки:'#13#10 + e.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;

  conditions.Free;
  elements.Free;
end;

procedure TfFilter.SetCurrIndex(idx: integer);
var
  i: integer;

begin
  CurrIndex := idx;
  for i := 0 to Length(RecordsEx) - 1 do
    if i = idx then
      RecordsEx[i].EditMode := true
    else
      RecordsEx[i].EditMode := false;
end;

procedure TfFilter.SetDataSet(ADataSet: TDataSet);
var
  i: integer;
  _top: integer;

begin
  FieldsList.Clear;
  ClearRecordsEx;
  FreeRecordsBase;
  FDataSet := ADataSet;
  FDataSet.DisableControls;
  _top := 6;
  Screen.Cursor := crHourGlass;

  try
    for i := 0 to FDataSet.Fields.Count - 1 do
    begin
      //if FDataSet.Fields.Fields[i].FieldKind = fkCalculated then continue;
      if not FDataSet.Fields.Fields[i].Lookup then
        FieldsList.Add(FDataSet.Fields.Fields[i].FieldName + '=' + FDataSet.Fields.Fields[i].DisplayName);
      if FDataSet.Fields.Fields[i].Visible then
      begin
        try
          SetLength(RecordsBase, Length(RecordsBase) + 1);
          RecordsBase[High(RecordsBase)] := TRecordBase.Create(ScrollBox2, _top, FDataSet.Fields.Fields[i]);
          _top := _top + CTRLHEIGHT + 1;
          RecordsBase[High(RecordsBase)].PreviewProc := ShowPreview;
        except
          SetLength(RecordsBase, Length(RecordsBase) - 1);
        end;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
    FDataSet.EnableControls;
  end;
end;

procedure TfFilter.ParseString(s: string; SL: TStringList);
var
  i: integer;
  bracket: boolean;
  _ts: string;

begin
  bracket := false;
  SL.Clear;
  i := 1;

  while i <= Length(s) do
  begin
    if s[i] = #39 then //одинарная кавычка '
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
        SL.Add(Trim(_ts));
        _ts := '';
      end;
    Inc(i);
  end;
  if (_ts <> '') and ((SL.Count = 0) or (_ts <> SL.Strings[SL.count - 1])) then SL.Add(Trim(_ts));
end;

procedure TfFilter.btnOffClick(Sender: TObject);
begin
  ClearRecordsEx;
  ResetBase;
  OldFilter := '';
  f_ok := true;
  self.Close;
end;

procedure TfFilter.btnHelpClick(Sender: TObject);
begin
//
end;

procedure TfFilter.FreeRecordsBase;
var
  i: integer;

begin
  for i := 0 to Length(RecordsBase) - 1 do
    if Assigned(RecordsBase[i]) then FreeAndNil(RecordsBase[i]);
  SetLength(RecordsBase, 0);
end;

procedure TfFilter.ResetBase;
var
  i: integer;

begin
  for i := 0 to Length(RecordsBase) - 1 do RecordsBase[i].Used := false;
end;

procedure TfFilter.SetOldFilter(OFilter: string);
begin
  FOldFilter := OFilter;
  chbAddOldFilter.Enabled := FOldFilter <> '';
  chbAddOldFilterClick(chbAddOldFilter);
end;

procedure TfFilter.SetRecordBase(Field: TField; Value: string; AExpr: TExpression; AConcRule: TConcat);
var
  i: integer;

begin
  for i := 0 to Length(RecordsBase) - 1 do
    if RecordsBase[i].DataField = Field then
    begin
      RecordsBase[i].Used := true;
      RecordsBase[i].FieldConcat := AConcRule;
      RecordsBase[i].SetValue(AExpr, Value);
    end;
end;

procedure TfFilter.ShowPreview;
begin
  rePreview.Lines.Text := CreateFilter;
end;

{ TRecordBase }

procedure TRecordBase.ChangeField(AParent: TWinControl; ATop: integer; AField: TField);
var
  bm: TBookmark;
  asf: TDataSetNotifyEvent;
  column: TColumnEh;
  
begin
  asf := nil;
  DataField := AField;

  FieldConcObj := TComboBox.Create(AParent);
  with FieldConcObj do
  begin
    ParentColor := false;
    ParentCtl3D := false;
    ParentFont := false;
    Parent := AParent;
    Ctl3D := true;
    Color := clBtnFace;
    Left := 8;
    Width := 50;
    Top := ATop;
    Height := CTRLHEIGHT;
    Items.Add('И');
    Items.Add('ИЛИ');
    Style := csDropDownList;
    ItemIndex := 0;
    Visible := true;
    OnChange := CtrlChange;
  end;
  FieldConcat := ccAnd;

  FUsed := TCheckBox.Create(AParent);
  FUsed.Parent := AParent;
  if FField.DisplayName = '' then
    FUsed.Caption := FField.FieldName
  else begin
    FUsed.Caption := FField.DisplayName;
    FUsed.Hint := FField.FieldName;
  end;
  FUsed.ShowHint := FUsed.Hint <> '';
  FUsed.Checked := false;
  FUsed.Height := CTRLHEIGHT - 4;
  FUsed.Left := FieldConcObj.Left + FieldConcObj.Width + 4;
  FUsed.Visible := true;
  FUsed.Top := ATop + 2;
  FUsed.Width := 175;
  //FUsed.Anchors := [akLeft, akTop, akRight];
  FUsed.Tag := 1;
  FUsed.OnClick := CheckBoxClick;

  case FObjType of
    otVariant, otString:
    begin
      ValueObj1 := TComboBox.Create(AParent);
      ValueObj1.Parent := AParent;
      TComboBox(ValueObj1).Style := csDropDownList;
      TComboBox(ValueObj1).Items.Add('равно');
      TComboBox(ValueObj1).Items.Add('не равно');
      TComboBox(ValueObj1).Items.Add('содержит');
      TComboBox(ValueObj1).Items.Add('не содержит');
      TComboBox(ValueObj1).ItemIndex := 0;
      TComboBox(ValueObj1).OnChange := CtrlChange;
      ValueObj1.Width := 90;

      ValueObj2 := TComboBox.Create(AParent);
      ValueObj2.Parent := AParent;
      TComboBox(ValueObj2).Style := csDropDown;
      TComboBox(ValueObj2).Items.Add(EMPTY_VALUE);
      //TComboBox(ValueObj2).Text := EMPTY_VALUE;

      column := FindColByFieldName(TfFilter(AParent.Owner).FGrid, FField.FieldName);
      if column.PickList.Count > 0 then
      begin
        TComboBox(ValueObj2).Items.AddStrings(column.PickList);
        if column.KeyList.Count > 0 then FKeyValues.AddStrings(column.KeyList);
      end else
      if TfFilter(AParent.Owner).FDataSet.RecordCount < FILLRECLIMIT then
      begin
        bm := TfFilter(AParent.Owner).FDataSet.GetBookmark;
        if Assigned(TfFilter(AParent.Owner).FDataSet.AfterScroll) then
        begin
          asf := TfFilter(AParent.Owner).FDataSet.AfterScroll;
          TfFilter(AParent.Owner).FDataSet.AfterScroll := nil;
        end;
        TfFilter(AParent.Owner).FDataSet.DisableControls;
        try
          TfFilter(AParent.Owner).FDataSet.First;
          while not TfFilter(AParent.Owner).FDataSet.Eof do
          begin
            if (TfFilter(AParent.Owner).FDataSet.FieldByName(FField.FieldName).AsString <> '') and
              (TComboBox(ValueObj2).Items.IndexOf(TfFilter(AParent.Owner).FDataSet.FieldByName(FField.FieldName).AsString) < 0) then
              TComboBox(ValueObj2).Items.Add(TfFilter(AParent.Owner).FDataSet.FieldByName(FField.FieldName).AsString);
            TfFilter(AParent.Owner).FDataSet.Next;
          end;
        finally
          if Assigned(bm) and TfFilter(AParent.Owner).FDataSet.BookmarkValid(bm) then
          begin
            TfFilter(AParent.Owner).FDataSet.GotoBookmark(bm);
            TfFilter(AParent.Owner).FDataSet.FreeBookmark(bm);
          end;
          if Assigned(asf) then
          begin
            TfFilter(AParent.Owner).FDataSet.AfterScroll := asf;
            asf := nil;
          end;
          TfFilter(AParent.Owner).FDataSet.EnableControls;
        end;
      end;
      
      ValueObj2.Width := 220;
      ValueObj2.Left := 340;
      TComboBox(ValueObj2).OnChange := CtrlChange;
    end;
    otInt:
    begin
      ValueObj1 := TComboBox.Create(AParent);
      ValueObj1.Parent := AParent;
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

      ValueObj2 := TDBNumberEditEh.Create(AParent);
      ValueObj2.Parent := AParent;
      TDBNumberEditEh(ValueObj2).AutoSize := false;
      TDBNumberEditEh(ValueObj2).Increment := 1;
      TDBNumberEditEh(ValueObj2).EditButton.Style := ebsUpDownEh;
      TDBNumberEditEh(ValueObj2).EditButton.Visible := true;
      TDBNumberEditEh(ValueObj2).DecimalPlaces := 0;
      TDBNumberEditEh(ValueObj2).Value := 0;
      ValueObj2.Width := 270;
      ValueObj2.Left := 290;
      TDBNumberEditEh(ValueObj2).OnChange := CtrlChange;
    end;
    otFloat:
    begin
      ExLabel1 := TLabel.Create(AParent);
      ExLabel1.Parent := AParent;
      ExLabel2 := TLabel.Create(AParent);
      ExLabel2.Parent := AParent;

      ValueObj1 := TDBNumberEditEh.Create(AParent);
      ValueObj1.Parent := AParent;
      TDBNumberEditEh(ValueObj1).AutoSize := false;
      TDBNumberEditEh(ValueObj1).Increment := 1;
      TDBNumberEditEh(ValueObj1).EditButton.Style := ebsUpDownEh;
      TDBNumberEditEh(ValueObj1).EditButton.Visible := true;
      TDBNumberEditEh(ValueObj1).DecimalPlaces := 5;
      TDBNumberEditEh(ValueObj1).Value := 0;
      ValueObj1.Width := 150;
      TDBNumberEditEh(ValueObj1).OnChange := CtrlChange;

      ValueObj2 := TDBNumberEditEh.Create(AParent);
      ValueObj2.Parent := AParent;
      TDBNumberEditEh(ValueObj2).AutoSize := false;
      TDBNumberEditEh(ValueObj2).Increment := 1;
      TDBNumberEditEh(ValueObj2).EditButton.Style := ebsUpDownEh;
      TDBNumberEditEh(ValueObj2).EditButton.Visible := true;
      TDBNumberEditEh(ValueObj2).DecimalPlaces := 5;
      TDBNumberEditEh(ValueObj2).Value := 0;
      ValueObj2.Width := 150;
      ValueObj2.Left := 410;
      TDBNumberEditEh(ValueObj2).OnChange := CtrlChange;
    end;
    otDateTime, otDate, otTime:
    begin
      ExLabel1 := TLabel.Create(AParent);
      ExLabel1.Parent := AParent;
      ExLabel2 := TLabel.Create(AParent);
      ExLabel2.Parent := AParent;

      ValueObj1 := TDateTimePicker.Create(AParent);
      ValueObj1.Parent := AParent;
      TDateTimePicker(ValueObj1).DateTime := Now;
      TDateTimePicker(ValueObj1).DateFormat := dfShort;
      if FObjType = otTime then
      begin
        TDateTimePicker(ValueObj1).DateMode := dmUpDown;
        TDateTimePicker(ValueObj1).Kind := dtkTime;
      end else
      begin
        TDateTimePicker(ValueObj1).DateMode := dmComboBox;
        TDateTimePicker(ValueObj1).Kind := dtkDate;
        {if FObjType = otDate then TDateTimePicker(ValueObj1).Format := 'dd.MM.yyyy'
        else TDateTimePicker(ValueObj1).Format := 'dd.MM.yyyy HH:mm:ss';}
      end;
      ValueObj1.Width := 150;
      TDateTimePicker(ValueObj1).OnChange := CtrlChange;

      ValueObj2 := TDateTimePicker.Create(AParent);
      ValueObj2.Parent := AParent;
      TDateTimePicker(ValueObj2).DateTime := Now;
      TDateTimePicker(ValueObj2).DateFormat := dfShort;
      if FObjType = otTime then
      begin
        TDateTimePicker(ValueObj2).DateMode := dmUpDown;
        TDateTimePicker(ValueObj2).Kind := dtkTime;
      end else
      begin
        TDateTimePicker(ValueObj2).DateMode := dmComboBox;
        TDateTimePicker(ValueObj2).Kind := dtkDate;
        {if FObjType = otDate then TDateTimePicker(ValueObj2).Format := 'dd.MM.yyyy'
        else TDateTimePicker(ValueObj2).Format := 'dd.MM.yyyy HH:mm:ss';}
      end;
      ValueObj2.Width := 150;
      ValueObj2.Left := 410;
      TDateTimePicker(ValueObj2).OnChange := CtrlChange;
    end;
    otLookup:
    begin
      ValueObj1 := TComboBox.Create(AParent);
      ValueObj1.Parent := AParent;
      TComboBox(ValueObj1).Style := csDropDownList;
      TComboBox(ValueObj1).Items.Add('=');
      TComboBox(ValueObj1).Items.Add('<>');
      TComboBox(ValueObj1).ItemIndex := 0;
      TComboBox(ValueObj1).OnChange := CtrlChange;
      ValueObj1.Width := 40;
      ValueObj2 := TDBLookupComboBoxEh.Create(AParent);
      ValueObj2.Parent := AParent;
      TDBLookupComboBoxEh(ValueObj2).DropDownBox.Align := daLeft;
      TDBLookupComboBoxEh(ValueObj2).DropDownBox.Rows := 7;
      TDBLookupComboBoxEh(ValueObj2).ListSource := FLookupSource;
      TDBLookupComboBoxEh(ValueObj2).KeyField := FField.LookupKeyFields;
      TDBLookupComboBoxEh(ValueObj2).ListField := FField.LookupResultField;
      ValueObj2.Width := 270;
      ValueObj2.Left := 290;
      TDBLookupComboBoxEh(ValueObj2).OnChange := CtrlChange;
    end;
  end;

  ValueObj1.Height := CTRLHEIGHT;
  ValueObj1.Top := ATop;
  ValueObj1.Left := 245;
  //ValueObj1.Anchors := [akTop, akRight];
  ValueObj1.Tag := 2;
  ValueObj1.Visible := true;

  if Assigned(ValueObj2) then
  begin
    ValueObj2.Height := CTRLHEIGHT;
    ValueObj2.Top := ATop;
    ValueObj2.Tag := 2;
    //ValueObj2.Anchors := [akTop, akRight];
    ValueObj2.Visible := true;
  end;

  if Assigned(ExLabel1) then
  begin
    ExLabel1.Caption := 'с';
    ExLabel1.Height := 13;
    ExLabel1.Top := ATop + 2;
    ExLabel1.Left := 239;
    ExLabel1.Width := 5;
    ExLabel1.Tag := 2;
    //ExLabel1.Anchors := [akTop, akRight];
    ExLabel1.Visible := true;
  end;

  if Assigned(ExLabel2) then
  begin
    ExLabel2.Caption := 'по';
    ExLabel2.Height := 13;
    ExLabel2.Top := ATop + 2;
    ExLabel2.Left := 397;
    ExLabel2.Width := 12;
    ExLabel2.Tag := 2;
    //ExLabel2.Anchors := [akTop, akRight];
    ExLabel2.Visible := true;
  end;

  CheckBoxClick(FUsed);
end;

procedure TRecordBase.CheckBoxClick(Sender: TObject);
begin
  if Assigned(FieldConcObj) then FieldConcObj.Enabled := TCheckBox(Sender).Checked;
  if Assigned(ValueObj1) then ValueObj1.Enabled := TCheckBox(Sender).Checked;
  if Assigned(ValueObj2) then ValueObj2.Enabled := TCheckBox(Sender).Checked;
  if Assigned(ExLabel1) then ExLabel1.Enabled := TCheckBox(Sender).Checked;
  if Assigned(ExLabel2) then ExLabel2.Enabled := TCheckBox(Sender).Checked;
  if TCheckBox(Sender).Checked then
    try
      TWinControl(ValueObj1).SetFocus;
    except
    end;

  if Assigned(PreviewProc) then PreviewProc;
end;

constructor TRecordBase.Create(AParent: TWinControl; ATop: integer; AField: TField);
begin
  inherited Create;
  FKeyValues := TStringList.Create;
  ChangeField(AParent, ATop, AField);
end;

procedure TRecordBase.CtrlChange(Sender: TObject);
begin
  if Assigned(PreviewProc) then PreviewProc;  
end;

destructor TRecordBase.Destroy;
begin
//  if Assigned(FField) then FreeAndNil(FField);
  if Assigned(ValueObj1) then FreeAndNil(ValueObj1);
  if Assigned(ValueObj2) then FreeAndNil(ValueObj2);
  if Assigned(ExLabel1) then FreeAndNil(ExLabel1);
  if Assigned(ExLabel2) then FreeAndNil(ExLabel2);
  if Assigned(FUsed) then FreeAndNil(FUsed);
//  if Assigned(FLookupDataSet) then FreeAndNil(FLookupDataSet);
  if Assigned(FLookupSource) then FreeAndNil(FLookupSource);
  if Assigned(FieldConcObj) then FreeAndNil(FieldConcObj);
  FKeyValues.Free;
  inherited Destroy;
end;

function TRecordBase.GetConc: TConcat;
begin
  result := GetConcat(FieldConcObj.Text);
end;

function TRecordBase.GetUsed: boolean;
begin
  result := FUsed.Checked;
end;

function TRecordBase.GetValue(caseSens: boolean): string;
var
  i: integer;
  slFields1, slFields2, slValues: TStringList;
  is_null: boolean;
  c, val: string;

begin
  result := '';
  if not Assigned(ValueObj1) then exit;
  case FObjType of
    otVariant, otString: if Trim(TComboBox(ValueObj1).Text) <> '' then
    begin
      if TComboBox(ValueObj2).Text = EMPTY_VALUE then
        case TComboBox(ValueObj1).ItemIndex of
          0, 2: result := FField.FieldName + ' is NULL';
          1, 3: result := FField.FieldName + ' is not NULL';
        end
      else begin
        if (FKeyValues.Count > 0) and (TComboBox(ValueObj2).ItemIndex > 0) then
          val := FKeyValues[TComboBox(ValueObj2).ItemIndex-1]
        else
          val := TComboBox(ValueObj2).Text;
          
        case TComboBox(ValueObj1).ItemIndex of
          0: result := FField.FieldName + ' = ''' + {iif(caseSens,} val {, AnsiLowerCase(val))} + '''';
          1: result := FField.FieldName + ' <> ''' + {iif(caseSens,} val {, AnsiLowerCase(val))} + '''';
          2: result := FField.FieldName + ' like ''%' + {iif(caseSens,} val {, AnsiLowerCase(val))} + '%''';
          3: result := ' not ' + FField.FieldName + ' like ''%' + {iif(caseSens,} val {, AnsiLowerCase(val))} + '%''';
        end;
      end;
    end;
    otInt: if Trim(TComboBox(ValueObj1).Text) <> '' then
      if VarIsNull(TDBNumberEditEh(ValueObj2).Value) then
        case TComboBox(ValueObj1).ItemIndex of
          0: result := FField.FieldName + ' is null';
          else result := FField.FieldName + ' is not null';
        end
      else
        case TComboBox(ValueObj1).ItemIndex of
          0: result := FField.FieldName + ' = ' + IntToStr(TDBNumberEditEh(ValueObj2).Value);
          1: result := FField.FieldName + ' <> ' + IntToStr(TDBNumberEditEh(ValueObj2).Value);
          2: result := FField.FieldName + ' > ' + IntToStr(TDBNumberEditEh(ValueObj2).Value);
          3: result := FField.FieldName + ' < ' + IntToStr(TDBNumberEditEh(ValueObj2).Value);
          4: result := FField.FieldName + ' >= ' + IntToStr(TDBNumberEditEh(ValueObj2).Value);
          5: result := FField.FieldName + ' <= ' + IntToStr(TDBNumberEditEh(ValueObj2).Value);
        end;
    otFloat:
      if VarIsNull(TDBNumberEditEh(ValueObj1).Value) or VarIsNull(TDBNumberEditEh(ValueObj2).Value) then
        result := FField.FieldName + ' is null'
      else
        result := FField.FieldName + ' >= ' + FloatToStr(TDBNumberEditEh(ValueObj1).Value) + ' and ' + FField.FieldName + ' <= ' +
          FloatToStr(TDBNumberEditEh(ValueObj2).Value);
    otDateTime, otDate: result := FField.FieldName + ' >= ''' + DateToStr(TDateTimePicker(ValueObj1).DateTime) +
      ''' and ' + FField.FieldName + ' <= ''' + DateToStr(TDateTimePicker(ValueObj2).DateTime) + '''';
    otTime: result := FField.FieldName + ' >= ''' + TimeToStr(TDateTimePicker(ValueObj1).DateTime) +
      ''' and ' + FField.FieldName + ' <= ''' + TimeToStr(TDateTimePicker(ValueObj2).DateTime) + '''';
    otLookup:
      //if not VarIsNull(TDBLookupComboBoxEh(ValueObj1).KeyValue) then
    begin
      is_null := VarIsNull(TDBLookupComboBoxEh(ValueObj2).KeyValue);
      slFields1 := TStringList.Create;
      slFields1.Delimiter := LOOKUPFIELDSDELIM;
      slFields1.DelimitedText := TDBLookupComboBoxEh(ValueObj2).KeyField;

      slFields2 := TStringList.Create;
      slFields2.Delimiter := LOOKUPFIELDSDELIM;
      slFields2.DelimitedText := FField.KeyFields;

      slValues := TStringList.Create;

      if slFields1.Count > 1 then
        for i := 0 to slFields1.Count - 1 do
          slValues.Add(iif(is_null, 'null', VarToStr(TDBLookupComboBoxEh(ValueObj2).KeyValue[i])))
      else
        slValues.Text := iif(is_null, 'null', VarToStr(TDBLookupComboBoxEh(ValueObj2).KeyValue));

      for i := 0 to slFields1.Count - 1 do
        if is_null then
        begin
          case TComboBox(ValueObj1).ItemIndex of
            0: c := ' is ';
            1: c := ' is not ';
          end;
          if result = '' then result := slFields2.Strings[i] + c + slValues.Strings[i]
          else result := result + ' AND ' + slFields2.Strings[i] + c + slValues.Strings[i]
        end else
        begin
          case TComboBox(ValueObj1).ItemIndex of
            0: c := ' = ';
            1: c := ' <> ';
          end;
          case FLookupDataSet.FieldByName(slFields1.Strings[i]).DataType of
            ftUnknown, ftString, ftFixedChar, ftWideString, ftGuid, ftVariant:
              if result = '' then result := slFields2.Strings[i] + c + '''' + slValues.Strings[i] + ''''
              else result := result + ' AND ' + slFields2.Strings[i] + c + '''' + slValues.Strings[i] + '''';
            else
              if result = '' then result := slFields2.Strings[i] + c + slValues.Strings[i]
              else result := result + ' AND ' + slFields2.Strings[i] + c + slValues.Strings[i];
          end;
        end;

      slFields1.Free;
      slFields2.Free;
      slValues.Free;
    end;
  end;
end;

procedure TRecordBase.SetConcat(value: TConcat);
begin
  FieldConcObj.Text := FieldConcObj.Items.Strings[Ord(value)];
end;

procedure TRecordBase.SetField(AField: TField);
begin
  //if Assigned(FField) then FreeAndNil(FField);
  FField := AField;
  //FField := TField.Create(nil);
  //FField.Assign(AField);
  if FField.FieldKind = fkLookup then
  begin
    FObjType := otLookup;
    //if Assigned(FLookupDataSet) then FreeAndNil(FLookupDataSet);
    //FLookupDataSet := TDataSet.Create(nil);
    FLookupDataSet := TDataSet(FField.LookupDataSet);
    if Assigned(FLookupSource) then FreeAndNil(FLookupSource);
    FLookupSource := TDataSource.Create(nil);
    FLookupSource.DataSet := FLookupDataSet;
  end else
    case FField.DataType of
      ftUnknown, ftString, ftBlob, ftMemo, ftFmtMemo, ftFixedChar, ftWideString, ftOraBlob, ftOraClob, ftVariant, ftGuid:
        FObjType := otString;
      ftSmallint, ftInteger, ftWord, ftBoolean, ftAutoInc, ftLargeint: FObjType := otInt;
      ftFloat, ftCurrency: FObjType := otFloat;
      ftDateTime, ftTimeStamp, ftTime: FObjType := otDateTime;
      ftDate: FObjType := otDate;
      else FObjType := otVariant;
    end;
end;

procedure TRecordBase.SetTop(value: integer);
begin
  if value < 0 then exit;
  FTop := value;
  FieldConcObj.Top := FTop;
  FUsed.Top := FTop + 2;
  ValueObj1.Top := FTop;
  if Assigned(ValueObj2) then ValueObj2.Top := FTop;
  if Assigned(ExLabel1) then ExLabel1.Top := FTop + 2;
  if Assigned(ExLabel2) then ExLabel2.Top := FTop + 2;
end;

procedure TRecordBase.SetUsed(value: boolean);
begin
  FUsed.Checked := value;
  CheckBoxClick(FUsed);
end;

procedure TRecordBase.SetValue(AExpr: TExpression; value: string);
var
  val: variant;
  
begin
  if ((AExpr = exIs) and (AnsiUpperCase(value) = 'NULL')) or (value = EMPTY_VALUE) then val := Null
  else val := value;
  
  case FObjType of
    otVariant, otString:
    begin
      if VarIsNull(val) then val := EMPTY_VALUE;
      TComboBox(ValueObj1).ItemIndex := Ord(AExpr) - 1;

      if (FKeyValues.Count > 0) then
        TComboBox(ValueObj2).ItemIndex := FKeyValues.IndexOf(val) + 1
      else
        TComboBox(ValueObj2).Text := val;
    end;
    otInt:
    begin
      if (val = '') then val := Null;
      TComboBox(ValueObj1).ItemIndex := Ord(AExpr) - 1;
      TDBNumberEditEh(ValueObj2).Value := val;
        //iif(VarIsNull(val), val, StrToInt(val));
    end;
    otFloat:
    begin
      if (val = '') then val := Null;
      TDBNumberEditEh(ValueObj1).Value := val;
        //iif(VarIsNull(val), val, StrToFloat(val));
      TDBNumberEditEh(ValueObj2).Value := val;
        //iif(VarIsNull(val), val, StrToFloat(val));
    end;
    otDateTime, otDate, otTime:
    begin
      if VarIsNull(val) or (val = '') then val := DateTimeToStr(Now);
      TDateTimePicker(ValueObj1).DateTime := StrToDateTime(val);
      TDateTimePicker(ValueObj2).DateTime := StrToDateTime(val);
    end;
    otLookup:
    begin
      TComboBox(ValueObj1).ItemIndex := Ord(AExpr) - 1;
      TDBLookupComboBoxEh(ValueObj2).Text := value;
    end;
  end;

//  if Assigned(PreviewProc) then PreviewProc; 
end;

procedure TfFilter.rbnOrClick(Sender: TObject);
begin
  if rbnOr.Checked then DefConcat := ccOr
  else DefConcat := ccAnd;
  ShowPreview;
end;

procedure TfFilter.chbAddOldFilterClick(Sender: TObject);
begin
  AddOldFilter := chbAddOldFilter.Checked and chbAddOldFilter.Enabled;
  rbnOr.Enabled := chbAddOldFilter.Checked and chbAddOldFilter.Enabled;
  rbnAnd.Enabled := chbAddOldFilter.Checked and chbAddOldFilter.Enabled;
  ShowPreview;
end;

procedure TfFilter.chbCaseSensitiveClick(Sender: TObject);
begin
  ShowPreview;
end;

end.