unit fieldEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Spin,
  DB, Mask, DBCtrlsEh, DBLookupEh, utils, optControls, DBGridEh, ActnList, DBAccess, Uni, UniProvider, PostgreSQLUniProvider,
  OracleUniProvider, MySQLUniProvider, InterBaseUniProvider, MemDS, dbUtils, main, childForm;

type
  TFFieldEditor = class(TChildForm)
    GroupBox1: TGroupBox;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    Label2: TLabel;
    edPk: TEdit;
    Label4: TLabel;
    Label1: TLabel;
    edOrder: TSpinEdit;
    Bevel1: TBevel;
    dsoGroup: TDataSource;
    cbGroup: TDBLookupComboboxEh;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edGridOrder: TSpinEdit;
    Label7: TLabel;
    mStyleExternal: TMemo;
    Label8: TLabel;
    mStyle: TMemo;
    Bevel2: TBevel;
    edGroupColumn: TSpinEdit;
    Label10: TLabel;
    edTitle: TEdit;
    Label11: TLabel;
    chbExcelExport: TCheckBox;
    chbExcelImport: TCheckBox;
    Label12: TLabel;
    mStyleColumn: TMemo;
    Label13: TLabel;
    edFilterOrder: TSpinEdit;
    Bevel3: TBevel;
    Label14: TLabel;
    cbTypeName: TComboBox;
    GroupBox2: TGroupBox;
    edGridWidth: TDBNumberEditEh;
    ScrollBox: TScrollBox;
    cbFieldName: TComboBox;
    chbShowInStartForm: TCheckBox;
    ActionList: TActionList;
    ASave: TAction;
    chbShowInGroupEdit: TCheckBox;
    chbLocked: TCheckBox;
    Label9: TLabel;
    edIsFilter: TDBNumberEditEh;
    Label15: TLabel;
    cbFilterGroup: TDBLookupComboboxEh;
    dsoFilterGroup: TDataSource;
    Label16: TLabel;
    edGridVisible: TSpinEdit;
    Label17: TLabel;
    edIsVisible: TSpinEdit;
    Label18: TLabel;
    edIsVisibleAdd: TSpinEdit;
    Label19: TLabel;
    edEditInTable: TSpinEdit;
    Label20: TLabel;
    edEditable: TSpinEdit;
    edAddEditable: TSpinEdit;
    Label21: TLabel;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbGroupChange(Sender: TObject);
    procedure edGroupColumnChange(Sender: TObject);
    procedure cbTypeNameChange(Sender: TObject);
    procedure cbFieldNameChange(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure ScrollBoxMouseEnter(Sender: TObject);
    procedure ScrollBoxMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure cbGroupMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    MouseOverCtrl: TObject;
    procedure CreateTypeFields;
    procedure SetFieldParams;
    function GetControlType(FieldType, FieldDomain: string; FieldSize: integer): string;
    function FiledTypeIsDecimal(FieldType: string): boolean;
    function ExtractFieldTitle(FieldDescr: string): string;
    procedure SetMode(Value: TOpenMode); override;
  public
    ParamControls: TContainer;
    EditingRec: TBookmark;
    BaseDescriptor: string;
    procedure RegisterForm;
    function GetShortCaption: string; override;
  end;

implementation

{$R *.dfm}

uses editDict;

procedure TFFieldEditor.ASaveExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then btnSaveClick(btnSave);
end;

procedure TFFieldEditor.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFFieldEditor.btnSaveClick(Sender: TObject);
begin
  if Mode = omView then exit;
  Success := true;
  Close;
end;

procedure TFFieldEditor.cbFieldNameChange(Sender: TObject);
begin
  if (Mode = omAdd) then
  begin
    edTitle.Text := cbFieldName.Text;
    SetFieldParams;
  end;
end;

procedure TFFieldEditor.cbGroupChange(Sender: TObject);
begin
  if cbGroup.ListSource.DataSet.IsEmpty then
    edGroupColumn.MaxValue := 0
  else begin
    if cbGroup.ListSource.DataSet.Locate('PK', cbGroup.KeyValue, []) then
      edGroupColumn.MaxValue := cbGroup.ListSource.DataSet.FieldByName('COUNT_COLUMN').AsInteger
    else
      edGroupColumn.MaxValue := 0;
  end;
  edGroupColumnChange(edGroupColumn);
end;

procedure TFFieldEditor.cbGroupMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  MouseOverCtrl := Sender;
end;

procedure TFFieldEditor.cbTypeNameChange(Sender: TObject);
begin
  CreateTypeFields;
end;

procedure TFFieldEditor.CreateTypeFields;
var
  tblName, fldName: string;

begin
  if Assigned(ParamControls) then FreeAndNil(ParamControls);
  ParamControls := TContainer.Create(ScrollBox, cbTypeName.Text, BaseDescriptor);

  if (Mode = omAdd) and (cbTypeName.Text = FIELDTYPE_FileField) then
  begin
    SplitFieldName(cbFieldName.Text, tblName, fldName);
    if tblName <> '' then ParamControls.OptionRecByName[OPT_pkField].Value := TFEditDict(Owner).GetObjectPkField(tblName);
  end;
end;

procedure TFFieldEditor.edGroupColumnChange(Sender: TObject);
begin
  if edGroupColumn.Value > edGroupColumn.MaxValue then edGroupColumn.Value := edGroupColumn.MaxValue;
  if edGroupColumn.Value < edGroupColumn.MinValue then edGroupColumn.Value := edGroupColumn.MinValue;
end;

function TFFieldEditor.ExtractFieldTitle(FieldDescr: string): string;
var
  op, cp: integer;

begin
  result := '';
  if Trim(FieldDescr) = '' then exit;
  op := Pos('<<', FieldDescr);
  cp := Pos('>>', FieldDescr);
  if op = 0 then exit;
  Inc(op, 2);
  if cp = 0 then cp := Length(FieldDescr)
  else cp := cp - op;

  result := Trim(Copy(FieldDescr, op, cp));
end;

function TFFieldEditor.FiledTypeIsDecimal(FieldType: string): boolean;
begin
  FieldType := UpperCase(FieldType);
  if (FieldType = 'FLOAT') or (FieldType = 'NUMERIC') or (FieldType = 'DECIMAL') or (FieldType = 'DOUBLE PRECISION') or
    (FieldType = 'MONEY') or (FieldType = 'REAL') then result := true
  else result := false;
end;

procedure TFFieldEditor.FormActivate(Sender: TObject);
begin
  ASave.Enabled := true;
  FMain.CheckFormButton(Tag);
end;

procedure TFFieldEditor.FormCreate(Sender: TObject);
begin
  cbTypeName.Items.Text := FIELDTYPES;
end;

procedure TFFieldEditor.FormDeactivate(Sender: TObject);
begin
  ASave.Enabled := false;
end;

procedure TFFieldEditor.FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if MouseOverCtrl = ScrollBox then
  begin
    ScrollBoxMouseWheel(ScrollBox, Shift, WheelDelta, MousePos, Handled);
    {if (ActiveControl is TComboBox) then }Handled := True;
  end else
    Handled := not (MouseOverCtrl = ActiveControl);
end;

function TFFieldEditor.GetControlType(FieldType, FieldDomain: string; FieldSize: integer): string;
begin
  FieldType := UpperCase(FieldType);
  FieldDomain := UpperCase(FieldDomain);

  if (Pos('BOOL', FieldDomain) > 0) or (Pos('BOOL', FieldType) > 0) or (Pos('BIT', FieldType) > 0) then
    result := FIELDTYPE_Checkbox
  else if (Pos('SMALLINT', FieldType) > 0) or (Pos('INTEGER', FieldType) > 0) or (Pos('FLOAT', FieldType) > 0) or
    (Pos('BIGINT', FieldType) > 0) or (Pos('NUMERIC', FieldType) > 0) or (Pos('DECIMAL', FieldType) > 0) or
    (Pos('DOUBLE', FieldType) > 0) or (Pos('NUMBER', FieldType) > 0) or (Pos('LONG', FieldType) > 0) or
    (Pos('SERIAL', FieldType) > 0) or (Pos('MONEY', FieldType) > 0) or (Pos('REAL', FieldType) > 0) then
    result := FIELDTYPE_numeric
  else if (Pos('CHAR', FieldType) > 0) or (Pos('VARCHAR', FieldType) > 0) or (Pos('VARCHAR2', FieldType) > 0) then
  begin
    if FieldSize >= 2500 then result := FIELDTYPE_TextArea
    else result := FIELDTYPE_text;
  end
  else if (Pos('DATE', FieldType) > 0) or (Pos('TIME', FieldType) > 0) or (Pos('TIMESTAMP', FieldType) > 0) then result := FIELDTYPE_date
  else if (Pos('BLOB', FieldType) > 0) or (Pos('CLOB', FieldType) > 0) or (Pos('TEXT', FieldType) > 0) or
    (Pos('BYTEA', FieldType) > 0) then result := FIELDTYPE_TextArea
  else result := '';
end;

function TFFieldEditor.GetShortCaption: string;
var
  s: string;
  
begin
  if Mode = omAdd then
    result := Caption
  else begin
    s := cbFieldName.Text;
    if Pos('.', s) > 0 then s := Copy(s, Pos('.', s) + 1, Length(s));
    result := 'Поле ' + s + ' : ' + edTitle.Text;
  end;
end;

procedure TFFieldEditor.RegisterForm;
begin
  case Mode of
    omAdd: ;
    omEdit: Caption := GenCaption('Поле', 'редактирование', edPk.Text, cbFieldName.Text, edTitle.Text, true);
    omView: Caption := GenCaption('Поле', 'просмотр', edPk.Text, cbFieldName.Text, edTitle.Text, true);
  end;

  FMain.RegisterChildForm(Self);
end;

procedure TFFieldEditor.ScrollBoxMouseEnter(Sender: TObject);
begin
  MouseOverCtrl := Sender;
end;

procedure TFFieldEditor.ScrollBoxMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBox.VertScrollBar.Position := ScrollBox.VertScrollBar.Position - WheelDelta;
end;

procedure TFFieldEditor.SetFieldParams;
var
  tblName, fldName: string;
  dsFieldData, dsFieldKeys, dsPkFields: TUniQuery;
  s: string;
  
begin
  if (cbFieldName.ItemIndex > -1) and (BaseDescriptor <> '') then
  begin
    SplitFieldName(cbFieldName.Items[cbFieldName.ItemIndex], tblName, fldName);
    if tblName <> '' then
    begin
      dsFieldData := ConnectionsList.GetDataSet(BaseDescriptor, qtFieldType);
      dsFieldKeys := ConnectionsList.GetDataSet(BaseDescriptor, qtFieldForeignKeys);
      dsPkFields := ConnectionsList.GetDataSet(BaseDescriptor, qtPrimaryKeys);

      try
        Screen.Cursor := crSQLWait;
        try
          dsFieldData.ParamByName('TABLE_NAME').AsString := tblName;
          dsFieldData.ParamByName('FIELD_NAME').AsString := fldName;
          dsFieldData.Open;
          dsFieldKeys.ParamByName('TABLE_NAME').AsString := tblName;
          dsFieldKeys.ParamByName('FIELD_NAME').AsString := fldName;
          dsFieldKeys.Open;
          dsPkFields.ParamByName('NAME').AsString := tblName;
          dsPkFields.Open;
        finally
          Screen.Cursor := crDefault;
        end;

        // параметры поля
        if not dsFieldKeys.IsEmpty then
        begin
          cbTypeName.ItemIndex := cbTypeName.Items.IndexOf(FIELDTYPE_LookUp);
          cbTypeNameChange(cbTypeName);
          ParamControls.OptionRecByName[OPT_baseDescriptor].Value := BaseDescriptor;
          ParamControls.OptionRecByName[OPT_fkTable].Value := dsFieldKeys.FieldByName('FK_TABLE').AsString;
          ParamControls.OptionRecByName[OPT_fkField].Value := dsFieldKeys.FieldByName('FK_FIELD').AsString;
          if ParamControls.OptionRecByName[OPT_displayField].LookupDataSet.Locate('FIELD_NAME', 'NAME', [loCaseInsensitive]) then
            ParamControls.OptionRecByName[OPT_displayField].Value :=
              ParamControls.OptionRecByName[OPT_displayField].LookupDataSet.FieldByName('FIELD_NAME').Value;
        end else if dsPkFields.Locate('FIELD_NAME', fldName, [loCaseInsensitive]) then
        begin
          cbTypeName.ItemIndex := cbTypeName.Items.IndexOf(FIELDTYPE_hidden);
          cbTypeNameChange(cbTypeName);
          ParamControls.OptionRecByName[OPT_allowBlank].Value := false;
        end else if not dsFieldData.IsEmpty then
        begin
          cbTypeName.ItemIndex := cbTypeName.Items.IndexOf(GetControlType(dsFieldData.FieldByName('FIELD_TYPE').AsString,
            dsFieldData.FieldByName('DOMAIN_').AsString, dsFieldData.FieldByName('SIZE_').AsInteger));

          cbTypeNameChange(cbTypeName);

          if cbTypeName.Text = FIELDTYPE_numeric then
          begin
            ParamControls.OptionRecByName[OPT_allowDecimals].Value := not FiledTypeIsDecimal(dsFieldData.FieldByName('FIELD_TYPE').AsString);
          end else if (cbTypeName.Text = FIELDTYPE_text) or (cbTypeName.Text = FIELDTYPE_TextArea) then
          begin
            if dsFieldData.FieldByName('SIZE_').AsInteger > 0 then
              ParamControls.OptionRecByName[OPT_maxLength].Value := dsFieldData.FieldByName('SIZE_').AsInteger;
          end else if cbTypeName.Text = FIELDTYPE_date then
          begin
            if (Pos('DATE', UpperCase(dsFieldData.FieldByName('FIELD_TYPE').AsString)) > 0) or
              (Pos('TIMESTAMP', UpperCase(dsFieldData.FieldByName('FIELD_TYPE').AsString)) > 0) then
              ParamControls.OptionRecByName[OPT_dateShow].Value := true
            else
              ParamControls.OptionRecByName[OPT_dateShow].Value := false;

            if ((UpperCase(dsFieldData.FieldByName('FIELD_TYPE').AsString) <> 'TIMESTAMP') and
              (Pos('TIME', UpperCase(dsFieldData.FieldByName('FIELD_TYPE').AsString)) > 0)) or
              (dsFieldData.FieldByName('DOMAIN_').AsString = 'R_DATETIME') then
              ParamControls.OptionRecByName[OPT_timeShow].Value := true
            else
              ParamControls.OptionRecByName[OPT_timeShow].Value := false;
          end;
        end else
        begin
          cbTypeName.ItemIndex := cbTypeName.Items.IndexOf(FIELDTYPE_ChildTable);
          cbTypeNameChange(cbTypeName);
          //ParamControls.OptionRecByName[OPT_joinFields].Value := ;
        end;

        if not dsFieldData.IsEmpty then
        begin
          ParamControls.OptionRecByName[OPT_allowBlank].Value := dsFieldData.FieldByName('NULL_FLAG').AsInteger = 1;
          s := ExtractFieldTitle(dsFieldData.FieldByName('FIELD_DESCR').AsString);
          if s <> '' then edTitle.Text := s;
        end;
      except
      end;
    end;
  end;
end;

procedure TFFieldEditor.SetMode(Value: TOpenMode);
begin
  inherited SetMode(Value);

  if Mode = omView then
  begin
    btnSave.Enabled := false;
    cbFieldName.Enabled := false;
    edTitle.ReadOnly := true;
    edTitle.Color := clBtnFace;
    cbGroup.ReadOnly := true;
    cbGroup.Color := clBtnFace;
    edGroupColumn.ReadOnly := true;
    edGroupColumn.Color := clBtnFace;
    edOrder.ReadOnly := true;
    edOrder.Color := clBtnFace;
    edGridVisible.ReadOnly := true;
    edGridVisible.Color := clBtnFace;
    edIsVisible.ReadOnly := true;
    edIsVisible.Color := clBtnFace;
    edIsVisibleAdd.ReadOnly := true;
    edIsVisibleAdd.Color := clBtnFace;
    chbExcelExport.Enabled := false;
    chbExcelImport.Enabled := false;
    edEditInTable.ReadOnly := true;
    edEditInTable.Color := clBtnFace;
    edEditable.ReadOnly := true;
    edEditable.Color := clBtnFace;
    edAddEditable.ReadOnly := true;
    edAddEditable.Color := clBtnFace;
    chbLocked.Enabled := false;
    chbShowInStartForm.Enabled := false;
    chbShowInGroupEdit.Enabled := false;
    edIsFilter.ReadOnly := true;
    edIsFilter.Color := clBtnFace;
    edFilterOrder.ReadOnly := true;
    edFilterOrder.Color := clBtnFace;
    cbFilterGroup.ReadOnly := true;
    cbFilterGroup.Color := clBtnFace;
    edGridOrder.ReadOnly := true;
    edGridOrder.Color := clBtnFace;
    edGridWidth.ReadOnly := true;
    edGridWidth.Color := clBtnFace;
    mStyle.ReadOnly := true;
    mStyle.Color := clBtnFace;
    mStyleExternal.ReadOnly := true;
    mStyleExternal.Color := clBtnFace;
    mStyleColumn.ReadOnly := true;
    mStyleColumn.Color := clBtnFace;
    cbTypeName.Enabled := false;
  end;
end;

end.
