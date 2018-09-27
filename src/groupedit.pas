unit groupedit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, DB, ImgList, ComCtrls, ToolWin,
  DBCtrls, DBCtrlsEh, ToolCtrlsEh, DBLookupEh, DBGridEh;

type
  TObjType = (otVariant, otInt, otFloat, otString, otBool, otDateTime, otDate, otTime, otLookup);

  TRecordBase = class
  private
    FObjType: TObjType;
    FField: TField;
    FColumn: TColumnEh;
    FUsed: TCheckBox;
    ValueObj: TControl;
    FTop: integer;
    FLookupDataSet: TDataSet;
    FLookupSource: TDataSource;
    FKeyValues: TStringList;
    procedure CheckBoxClick(Sender: TObject);
    procedure SetTop(value: integer);
    procedure SetField(AField: TField);
    procedure SetColumn(AColumn: TColumnEh);
    procedure ChangeColumn(AParent: TWinControl; ATop: integer; AColumn: TColumnEh);
    function GetUsed: boolean;
    procedure SetUsed(value: boolean);
  public
    constructor Create(AParent: TWinControl; ATop: integer; AColumn: TColumnEh);
    destructor Destroy; override;
    function GetValue: string;
    procedure SetFocus;
    property Top: integer read FTop write SetTop;
    property Used: boolean read GetUsed write SetUsed;
  end;

  TRecordsBase = array of TRecordBase;

  TFGroupEdit = class(TForm)
    Panel1: TPanel;
    btnApply: TBitBtn;
    btnCancel: TBitBtn;
    ImageList1: TImageList;
    ScrollBox: TScrollBox;
    ToolBar1: TToolBar;
    btnCheck: TToolButton;
    btnUncheck: TToolButton;
    btnInvert: TToolButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCheckClick(Sender: TObject);
    procedure btnUncheckClick(Sender: TObject);
    procedure btnInvertClick(Sender: TObject);
    procedure ScrollBoxMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  private
    f_ok: boolean;
    RecordsBase: TRecordsBase;
    FDataSet: TDataSet;
    FGrid: TDBGridEh;
    procedure SetGrid(AGrid: TDBGridEh);
    procedure FreeRecordsBase;
    procedure SetChecked(value: boolean; invert: boolean = false);
  public
    function GetData: TStringList;
    function Execute(AGrid: TDBGridEh): boolean;
  end;

implementation

{$R *.dfm}

const
  CTRLHEIGHT = 21;
  CTRLWIDHT = 220;
  CTRLLEFT = 180;
  FILLRECLIMIT = 100;
  LOOKUPFIELDSDELIM = ';';

{ TFGroupEdit }

procedure TFGroupEdit.btnApplyClick(Sender: TObject);
begin
  f_ok := true;
  self.Close;
end;

procedure TFGroupEdit.btnCancelClick(Sender: TObject);
begin
  f_ok := false;
  self.Close;
end;

function TFGroupEdit.GetData: TStringList;
var
  i: integer;
  s: string;

begin
  result := TStringList.Create;
  for i := 0 to Length(RecordsBase) - 1 do
    if RecordsBase[i].Used then result.Add(RecordsBase[i].GetValue);

  // из-за составных лукап полей в result-е может оказаться одна строка, содержащая #13#10,
  // которую надо разделить на 2 строки таким вот способом (как ни странно - это работает)
  s := result.Text;
  result.Text := s;
end;

function TFGroupEdit.Execute(AGrid: TDBGridEh): boolean;
var
  i: integer;

begin
  if (not Assigned(AGrid)) or (not Assigned(AGrid.DataSource)) or (not Assigned(AGrid.DataSource.DataSet)) then
    raise Exception.Create('Отсутствует набор данных!');

  SetGrid(AGrid);
  for i := 0 to ScrollBox.ComponentCount - 1 do
    case ScrollBox.Components[i].Tag of
      {1: TWinControl(ScrollBox.Components[i]).Anchors := [akLeft, akTop, akRight];
      2: TWinControl(ScrollBox.Components[i]).Anchors := [akTop, akRight];}
      1: TWinControl(ScrollBox.Components[i]).Anchors := [akLeft, akTop];
      2: TWinControl(ScrollBox.Components[i]).Anchors := [akLeft, akTop, akRight];
    end;

  Self.ShowModal;
  result := f_ok;
end;

procedure TFGroupEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TFGroupEdit.FormCreate(Sender: TObject);
begin
  SetLength(RecordsBase, 0);
  f_ok := false;
end;

procedure TFGroupEdit.FormDestroy(Sender: TObject);
begin
  FreeRecordsBase;
end;

procedure TFGroupEdit.FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBoxMouseWheel(ScrollBox, Shift, WheelDelta, MousePos, Handled);
end;

procedure TFGroupEdit.SetGrid(AGrid: TDBGridEh);
var
  i: integer;
  _top: integer;

begin
  FreeRecordsBase;
  FGrid := AGrid;
  FDataSet := AGrid.DataSource.DataSet;
  FDataSet.DisableControls;
  _top := 6;

  Screen.Cursor := crHourGlass;
  try
    for i := 0 to FGrid.Columns.Count - 1 do
    begin
      if (FGrid.Columns.Items[i].ReadOnly) or (not FGrid.Columns.Items[i].Visible) or
        ((not FGrid.Columns.Items[i].TextEditing) and (not FGrid.Columns.Items[i].Checkboxes)) or
        (not FGrid.Columns.Items[i].Field.Visible) or FGrid.Columns.Items[i].Field.ReadOnly or
        (FGrid.Columns.Items[i].Field.FieldKind = fkCalculated) then continue;

      SetLength(RecordsBase, Length(RecordsBase) + 1);
      RecordsBase[High(RecordsBase)] := TRecordBase.Create(ScrollBox, _top, FGrid.Columns.Items[i]);
      _top := _top + CTRLHEIGHT + 1;
    end;
  finally
    Screen.Cursor := crDefault;
    FDataSet.EnableControls;
  end;
end;

procedure TFGroupEdit.FreeRecordsBase;
var
  i: integer;

begin
  for i := 0 to Length(RecordsBase) - 1 do
    if Assigned(RecordsBase[i]) then FreeAndNil(RecordsBase[i]);

  SetLength(RecordsBase, 0);
end;

procedure TFGroupEdit.ScrollBoxMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBox.VertScrollBar.Position := ScrollBox.VertScrollBar.Position - WheelDelta;
end;

procedure TFGroupEdit.SetChecked(value: boolean; invert: boolean);
var
  i: integer;

begin
  for i := 0 to Length(RecordsBase) - 1 do
    if invert then
      RecordsBase[i].Used := not RecordsBase[i].Used
    else
      RecordsBase[i].Used := value;

  if Assigned(RecordsBase[0]) then RecordsBase[0].SetFocus;
end;

procedure TFGroupEdit.btnCheckClick(Sender: TObject);
begin
  SetChecked(true);
end;

procedure TFGroupEdit.btnUncheckClick(Sender: TObject);
begin
  SetChecked(false);
end;

procedure TFGroupEdit.btnInvertClick(Sender: TObject);
begin
  SetChecked(true, true);
end;

{ TRecordBase }

procedure TRecordBase.ChangeColumn(AParent: TWinControl; ATop: integer; AColumn: TColumnEh);
var
  bm: TBookmark;
  asf: TDataSetNotifyEvent;

begin
  if (not Assigned(AColumn)) or (not Assigned(AColumn.Field)) then
    raise Exception.Create('Не привязана колонка или поле к колонке!');

  asf := nil;
  SetColumn(AColumn);

  FUsed := TCheckBox.Create(AParent);
  
  if FColumn.Title.Caption = '' then
    FUsed.Caption := FField.FieldName
  else
    FUsed.Caption := FColumn.Title.Caption;

  if FColumn.Title.Hint = '' then
    FUsed.Hint := FUsed.Caption
  else
    FUsed.Hint := FColumn.Title.Hint;

  FUsed.ShowHint := true;
  FUsed.Checked := false;
  FUsed.Height := CTRLHEIGHT - 4;
  FUsed.Left := 8;
  FUsed.Visible := true;
  FUsed.Top := ATop + 2;
  FUsed.Width := 180;
  FUsed.Parent := AParent;
  FUsed.Tag := 1;
  FUsed.OnClick := CheckBoxClick;

  case FObjType of
    otVariant, otString:
    begin
      ValueObj := TComboBox.Create(AParent);
      ValueObj.Parent := AParent;
      TComboBox(ValueObj).Style := csDropDown;
      TComboBox(ValueObj).Text := '';

      if FColumn.PickList.Count > 0 then
      begin
        TComboBox(ValueObj).Items.Text := FColumn.PickList.Text;
        if FColumn.KeyList.Count = FColumn.PickList.Count then TComboBox(ValueObj).Style := csDropDownList;
      end else if TFGroupEdit(AParent.Owner).FDataSet.RecordCount < FILLRECLIMIT then
      begin
        bm := TFGroupEdit(AParent.Owner).FDataSet.GetBookmark;
        if Assigned(TFGroupEdit(AParent.Owner).FDataSet.AfterScroll) then
        begin
          asf := TFGroupEdit(AParent.Owner).FDataSet.AfterScroll;
          TFGroupEdit(AParent.Owner).FDataSet.AfterScroll := nil;
        end;
        TFGroupEdit(AParent.Owner).FDataSet.DisableControls;
        try
          TFGroupEdit(AParent.Owner).FDataSet.First;
          while not TFGroupEdit(AParent.Owner).FDataSet.Eof do
          begin
            if (TFGroupEdit(AParent.Owner).FDataSet.FieldByName(FField.FieldName).AsString <> '') and
              (TComboBox(ValueObj).Items.IndexOf(TFGroupEdit(AParent.Owner).FDataSet.FieldByName(FField.FieldName).AsString) < 0) then
              TComboBox(ValueObj).Items.Add(TFGroupEdit(AParent.Owner).FDataSet.FieldByName(FField.FieldName).AsString);
            TFGroupEdit(AParent.Owner).FDataSet.Next;
          end;
        finally
          if Assigned(bm) and TFGroupEdit(AParent.Owner).FDataSet.BookmarkValid(bm) then
          begin
            TFGroupEdit(AParent.Owner).FDataSet.GotoBookmark(bm);
            TFGroupEdit(AParent.Owner).FDataSet.FreeBookmark(bm);
          end;
          if Assigned(asf) then
          begin
            TFGroupEdit(AParent.Owner).FDataSet.AfterScroll := asf;
            asf := nil;
          end;
          TFGroupEdit(AParent.Owner).FDataSet.EnableControls;
        end;
      end;

      if TComboBox(ValueObj).Items.Count = 0 then TComboBox(ValueObj).Style := csSimple;
    end;
    otInt, otFloat:
    begin
      ValueObj := TDBNumberEditEh.Create(AParent);
      ValueObj.Parent := AParent;
      TDBNumberEditEh(ValueObj).AutoSize := false;
      TDBNumberEditEh(ValueObj).Increment := 1;
      TDBNumberEditEh(ValueObj).EditButton.Style := ebsAltUpDownEh;
      TDBNumberEditEh(ValueObj).EditButton.Visible := true;
      if FObjType = otInt then
      begin
        TDBNumberEditEh(ValueObj).DecimalPlaces := 0;
      end else
      begin
        TDBNumberEditEh(ValueObj).DecimalPlaces := 5;
      end;
      TDBNumberEditEh(ValueObj).Value := 0;
    end;
    otBool:
    begin
      ValueObj := TCheckBox.Create(AParent);
      ValueObj.Parent := AParent;
    end;
    otDateTime, otDate, otTime:
    begin
      ValueObj := TDBDateTimeEditEh.Create(AParent);
      ValueObj.Parent := AParent;
      case FObjType of
        otDateTime: TDBDateTimeEditEh(ValueObj).Kind := dtkDateTimeEh;
        otDate: TDBDateTimeEditEh(ValueObj).Kind := dtkDateEh;
        otTime: TDBDateTimeEditEh(ValueObj).Kind := dtkTimeEh;
        else TDBDateTimeEditEh(ValueObj).Kind := dtkCustomEh;
      end;
    end;
    otLookup:
    begin
      ValueObj := TDBLookupComboBoxEh.Create(AParent);
      ValueObj.Parent := AParent;
      TDBLookupComboBoxEh(ValueObj).DropDownBox.Align := daLeft;
      TDBLookupComboBoxEh(ValueObj).DropDownBox.Rows := 7;
      TDBLookupComboBoxEh(ValueObj).ListSource := FLookupSource;
      TDBLookupComboBoxEh(ValueObj).KeyField := FField.LookupKeyFields;
      TDBLookupComboBoxEh(ValueObj).ListField := FField.LookupResultField;
    end;
  end;

  ValueObj.Width := CTRLWIDHT;
  if (ValueObj is TCheckBox) then
    ValueObj.Top := ATop + 2
  else begin
    ValueObj.Height := CTRLHEIGHT;
    ValueObj.Top := ATop;
  end;
  ValueObj.Left := CTRLLEFT;
  ValueObj.Visible := true;
  ValueObj.Tag := 2;
  ValueObj.Parent := AParent;
  CheckBoxClick(FUsed);
end;

procedure TRecordBase.CheckBoxClick(Sender: TObject);
begin
  if Assigned(ValueObj) then ValueObj.Enabled := TCheckBox(Sender).Checked;
  if TCheckBox(Sender).Checked then
    try
      TWinControl(ValueObj).SetFocus;
    except
    end;
end;

constructor TRecordBase.Create(AParent: TWinControl; ATop: integer; AColumn: TColumnEh);
begin
  inherited Create;
  FKeyValues := TStringList.Create;
  ChangeColumn(AParent, ATop, AColumn);
end;

destructor TRecordBase.Destroy;
begin
  if Assigned(ValueObj) then FreeAndNil(ValueObj);
  if Assigned(FUsed) then FreeAndNil(FUsed);
  if Assigned(FLookupSource) then FreeAndNil(FLookupSource);
  FKeyValues.Free;
  inherited Destroy;
end;

function TRecordBase.GetUsed: boolean;
begin
  result := FUsed.Checked;
end;

function TRecordBase.GetValue: string;
var
  i: integer;
  slFields1, slFields2, slValues: TStringList;

begin
  result := '';
  if not Assigned(ValueObj) then exit;
  case FObjType of
    otVariant, otString:
    begin
      if TComboBox(ValueObj).ItemIndex > -1 then
      begin
        if FKeyValues.Count > 0 then
          result := FField.FieldName + '=' + FKeyValues.Strings[TComboBox(ValueObj).ItemIndex]
        else
          result := FField.FieldName + '=' + TComboBox(ValueObj).Items.Strings[TComboBox(ValueObj).ItemIndex];
      end else
        result := FField.FieldName + '=' + TComboBox(ValueObj).Text;
    end;
    otInt:
      if VarIsNull(TDBNumberEditEh(ValueObj).Value) then
        result := FField.FieldName + '='
      else result := FField.FieldName + '=' +
        IntToStr(TDBNumberEditEh(ValueObj).Value);
    otFloat:
      if VarIsNull(TDBNumberEditEh(ValueObj).Value) then
        result := FField.FieldName + '='
      else result := FField.FieldName + '=' +
        FloatToStr(TDBNumberEditEh(ValueObj).Value);
    otBool:
    begin
      if FKeyValues.Count = 0 then
      begin
        if TCheckBox(ValueObj).Checked then result := FField.FieldName + '=1'
        else result := FField.FieldName + '=0';
      end else
      begin
        if TCheckBox(ValueObj).Checked then
          result := FField.FieldName + '=' + FKeyValues.Strings[0]
        else
          result := FField.FieldName + '=' + FKeyValues.Strings[1];
      end;
    end;
    otDateTime:
    begin
      if VarIsNull(TDBDateTimeEditEh(ValueObj).Value) then
        result := FField.FieldName + '='
      else
        result := FField.FieldName + '=' + DateTimeToStr(TDBDateTimeEditEh(ValueObj).Value);
    end;
    otDate:
    begin
      if VarIsNull(TDBDateTimeEditEh(ValueObj).Value) then
        result := FField.FieldName + '='
      else
        result := FField.FieldName + '=' + DateToStr(TDBDateTimeEditEh(ValueObj).Value);
    end;
    otTime:
    begin
      if VarIsNull(TDBDateTimeEditEh(ValueObj).Value) then
        result := FField.FieldName + '='
      else
        result := FField.FieldName + '=' + TimeToStr(TDBDateTimeEditEh(ValueObj).Value);
    end;
    otLookup:
    begin
      slFields1 := TStringList.Create;
      slFields1.Delimiter := LOOKUPFIELDSDELIM;
      slFields1.DelimitedText := TDBLookupComboBoxEh(ValueObj).KeyField;

      slFields2 := TStringList.Create;
      slFields2.Delimiter := LOOKUPFIELDSDELIM;
      slFields2.DelimitedText := FField.KeyFields;

      slValues := TStringList.Create;

      if slFields1.Count > 1 then
        for i := 0 to slFields1.Count - 1 do
          slValues.Add(VarToStr(TDBLookupComboBoxEh(ValueObj).KeyValue[i]))
      else
        slValues.Add(VarToStr(TDBLookupComboBoxEh(ValueObj).KeyValue));

      for i := 0 to slFields1.Count - 1 do
        if result = '' then result := slFields2.Strings[i] + '=' + slValues.Strings[i]
        else result := result + #13#10 + slFields2.Strings[i] + '=' + slValues.Strings[i];

      slFields1.Free;
      slFields2.Free;
      slValues.Free;
    end;
  end;
end;

procedure TRecordBase.SetColumn(AColumn: TColumnEh);
begin
  FColumn := AColumn;
  SetField(FColumn.Field);
  if FColumn.Checkboxes then FObjType := otBool;
  FKeyValues.Text := FColumn.KeyList.Text;
end;

procedure TRecordBase.SetField(AField: TField);
begin
  FField := AField;
  if FField.FieldKind = fkLookup then
  begin
    FObjType := otLookup;
    FLookupDataSet := FField.LookupDataSet;
    if Assigned(FLookupSource) then FreeAndNil(FLookupSource);
    FLookupSource := TDataSource.Create(nil);
    FLookupSource.DataSet := FLookupDataSet;
  end else
    case FField.DataType of
      ftUnknown, ftString, ftBlob, ftMemo, ftFmtMemo, ftFixedChar, ftWideString, ftOraBlob, ftOraClob, ftVariant, ftGuid:
        FObjType := otString;
      ftBoolean: FObjType := otBool;
      ftSmallint, ftInteger, ftWord, ftAutoInc, ftLargeint: FObjType := otInt;
      ftFloat, ftCurrency: FObjType := otFloat;
      ftDateTime, ftTimeStamp: FObjType := otDateTime;
      ftDate: FObjType := otDate;
      ftTime: FObjType := otTime;
      else FObjType := otVariant;
    end;
end;

procedure TRecordBase.SetFocus;
begin
  try
    case FObjType of
      otVariant, otString: TComboBox(ValueObj).SetFocus;
      otInt, otFloat: TDBNumberEditEh(ValueObj).SetFocus;
      otBool: TCheckBox(ValueObj).SetFocus;
      otDateTime, otDate, otTime: TDBDateTimeEditEh(ValueObj).SetFocus;
      otLookup: TDBLookupComboBoxEh(ValueObj).SetFocus;
    end;
  except
  end;
end;

procedure TRecordBase.SetTop(value: integer);
begin
  if value < 0 then exit;
  FTop := value;
  FUsed.Top := FTop + 2;
  if ValueObj is TCheckBox then ValueObj.Top := FTop + 2
  else ValueObj.Top := FTop;
end;

procedure TRecordBase.SetUsed(value: boolean);
begin
  FUsed.Checked := value;
  CheckBoxClick(FUsed);
end;

end.
