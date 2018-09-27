unit field;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Spin,
  DB, Mask, DBCtrlsEh, DBLookupEh, utils, optControls, DBGridEh, ActnList, DBAccess, Uni, UniProvider, PostgreSQLUniProvider,
  OracleUniProvider, MySQLUniProvider, InterBaseUniProvider, MemDS, dbUtils, MemTableDataEh, MemTableEh, FIBDataSet, pFIBDataSet,
  main, editDict;

type
  TFField = class(TObject)
  private
    function GetControlType(FieldType, FieldDomain: string; FieldSize: integer): string;
    function FiledTypeIsDecimal(FieldType: string): boolean;
    function ExtractFieldTitle(FieldDescr: string): string;
  public
    Fields: TMemTableEh;
    Objects: TMemTableEh;
    Parent: TWinControl;
    Owner: TFEditDict;
    ParamControls: TContainer;
    EditingRec: TBookmark;
    BaseDescriptor: string;
    Mode: TOpenMode;
    // свойства поля
    Pk: Variant;
    Title: string;
    Order: integer;
    IsVisible: integer;
    IsVisibleAdd: integer;
    AddEditable: integer;
    Group: Variant;
    GridOrder: integer;
    Style: string;
    StyleExternal: string;
    GroupColumn: integer;
    GridVisible: integer;
    EditInTable: integer;
    Editable: integer;
    ExcelExport: boolean;
    ExcelImport: boolean;
    StyleColumn: string;
    FilterOrder: integer;
    TypeName: string;
    GridWidth: Variant;
    FieldName: string;
    ShowInStartForm: boolean;
    ShowInGroupEdit: boolean;
    Locked: boolean;
    IsFilter: Variant;
    FilterGroup: Variant;
    destructor Destroy; override;
    procedure CreateTypeFields;
    procedure SetFieldParams;
    procedure Save;
  end;

implementation

procedure TFField.CreateTypeFields;
begin
  if Assigned(ParamControls) then FreeAndNil(ParamControls);
  ParamControls := TContainer.Create(Parent, TypeName, BaseDescriptor);
end;

destructor TFField.Destroy;
begin
  if Assigned(ParamControls) then FreeAndNil(ParamControls);
  inherited Destroy;
end;

function TFField.ExtractFieldTitle(FieldDescr: string): string;
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

function TFField.FiledTypeIsDecimal(FieldType: string): boolean;
begin
  FieldType := UpperCase(FieldType);
  if (FieldType = 'FLOAT') or (FieldType = 'NUMERIC') or (FieldType = 'DECIMAL') or (FieldType = 'DOUBLE PRECISION') or
    (FieldType = 'MONEY') or (FieldType = 'REAL') then result := true
  else result := false;
end;

function TFField.GetControlType(FieldType, FieldDomain: string; FieldSize: integer): string;
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

procedure TFField.Save;
var
  obj, fld: string;
  ds: TpFIBDataSet;

begin
  Fields.DisableControls;
  Objects.DisableControls;
  try
    if Mode = omAdd then Fields.Append
    else begin
      if Fields.BookmarkValid(EditingRec) then
      begin
        Fields.GotoBookmark(EditingRec);
        Fields.Edit;
      end else
      begin
        if Application.MessageBox('Редактируемая запись была удалена! Восстановить?', 'Подтверждение',
          MB_YESNO + MB_ICONWARNING) = ID_YES then
        begin
          Fields.Append;
        end else exit;
      end;
    end;

    SplitFieldName(FieldName, obj, fld);
    if obj <> '' then
    begin
      Fields.FieldByName('OBJECT_NAME').AsString := obj;
      Fields.FieldByName('FIELD_NAME').AsString := fld;
      if Objects.Locate('NAME', Fields.FieldByName('OBJECT_NAME').AsString, [loCaseInsensitive]) then
        Fields.FieldByName('OBJECT_PK').Value := Objects.FieldByName('PK').Value
      else begin
        try
          // такой вариант не катит, надо искать среди всех объектов DYNAMIC_FORM_OBJECT_TREE по имени.
          // А все потому, что поле ChildTable на самом деле может ссылаться на любой объект, даже вобще никак не связанный со справочником
          {ds := FMain.OpenSQL('select o.PK from DYNAMIC_FORM_REFERENCE r join DYNAMIC_FORM_OBJECT_TREE o on o.FORM_PK = r.MAIN_FORM_PK ' +
            'where r.PARENT_REFERENCE_PK = :PK and o.NAME = :NAME', 'PK=' + dsDictPK.AsString + #13#10 + 'NAME=' +
            mtFormFieldsOBJECT_NAME.AsString); }

          ds := FMain.OpenSQL('select PK from DYNAMIC_FORM_OBJECT_TREE where NAME = :NAME', 'NAME=' + Fields.FieldByName('OBJECT_NAME').AsString);

          if ds.Active and (not ds.IsEmpty) then
            Fields.FieldByName('OBJECT_PK').Value := ds.FieldByName('PK').Value
          else
            Fields.FieldByName('OBJECT_PK').Clear;
        finally
          if ds.Active then ds.Close;
          ds.Free;
        end;
      end;
    end else
    begin
      Fields.FieldByName('OBJECT_NAME').Clear;
      Fields.FieldByName('OBJECT_PK').Clear;
      Fields.FieldByName('FIELD_NAME').AsString := FieldName;
    end;
    Fields.FieldByName('TITLE').AsString := Title;
    Fields.FieldByName('GROUP_PK').Value := Group;
    Fields.FieldByName('GROUP_COLUMN').AsInteger := GroupColumn;
    Fields.FieldByName('ORDER_').AsInteger := Order;
    Fields.FieldByName('GRID_VISIBLE').AsInteger := GridVisible;
    Fields.FieldByName('EDIT_IN_TABLE').AsInteger := EditInTable;
    Fields.FieldByName('GRID_ORDER').AsInteger := GridOrder;
    Fields.FieldByName('GRID_WIDTH').Value := GridWidth;
    Fields.FieldByName('IS_VISIBLE').AsInteger := IsVisible;
    Fields.FieldByName('EDITABLE').AsInteger := Editable;
    Fields.FieldByName('IS_VISIBLE_ADD').AsInteger := IsVisibleAdd;
    Fields.FieldByName('ADD_EDITABLE').AsInteger := AddEditable;
    Fields.FieldByName('SHOW_IN_START_FORM').AsInteger := iif(ShowInStartForm, 1, 0);
    Fields.FieldByName('SHOW_IN_GROUP_EDIT').AsInteger := iif(ShowInGroupEdit, 1, 0);
    Fields.FieldByName('EXCEL_EXPORT').AsInteger := iif(ExcelExport, 1, 0);
    Fields.FieldByName('EXCEL_IMPORT').AsInteger := iif(ExcelImport, 1, 0);
    Fields.FieldByName('IS_FILTER').Value := IsFilter;
    Fields.FieldByName('FILTER_ORDER').AsInteger := FilterOrder;
    Fields.FieldByName('FILTER_GROUP').Value := FilterGroup;
    Fields.FieldByName('LOCKED').AsInteger := iif(Locked, 1, 0);
    Fields.FieldByName('STYLE').AsString := Style;
    Fields.FieldByName('STYLE_EXTERNAL').AsString := StyleExternal;
    if StyleColumn = '' then Fields.FieldByName('STYLE_COLUMN').Clear
    else Fields.FieldByName('STYLE_COLUMN').Value := StyleColumn;
    Fields.FieldByName('TYPE_NAME').AsString := TypeName;
    Fields.FieldByName('PARAMETERS').AsString := Owner.GetFieldTypeParams(ParamControls);
    Fields.Post;
  finally
    Objects.First;
    Objects.EnableControls;
    Fields.EnableControls;
  end;
end;

procedure TFField.SetFieldParams;
var
  tblName, fldName: string;
  dsFieldData, dsFieldKeys, dsPkFields: TUniQuery;
  s: string;
  
begin
  if (FieldName <> '') and (BaseDescriptor <> '') then
  begin
    SplitFieldName(FieldName, tblName, fldName);
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
          TypeName := FIELDTYPE_LookUp;
          CreateTypeFields;
          ParamControls.OptionRecByName[OPT_baseDescriptor].Value := BaseDescriptor;
          ParamControls.OptionRecByName[OPT_fkTable].Value := dsFieldKeys.FieldByName('FK_TABLE').AsString;
          ParamControls.OptionRecByName[OPT_fkField].Value := dsFieldKeys.FieldByName('FK_FIELD').AsString;
          if ParamControls.OptionRecByName[OPT_displayField].LookupDataSet.Locate('FIELD_NAME', 'NAME', [loCaseInsensitive]) then
            ParamControls.OptionRecByName[OPT_displayField].Value :=
              ParamControls.OptionRecByName[OPT_displayField].LookupDataSet.FieldByName('FIELD_NAME').Value;
        end else if dsPkFields.Locate('FIELD_NAME', fldName, [loCaseInsensitive]) then
        begin
          TypeName := FIELDTYPE_hidden;
          CreateTypeFields;
          ParamControls.OptionRecByName[OPT_allowBlank].Value := false;
        end else if not dsFieldData.IsEmpty then
        begin
          TypeName := GetControlType(dsFieldData.FieldByName('FIELD_TYPE').AsString,
            dsFieldData.FieldByName('DOMAIN_').AsString, dsFieldData.FieldByName('SIZE_').AsInteger);

          CreateTypeFields;

          if TypeName = FIELDTYPE_numeric then
          begin
            ParamControls.OptionRecByName[OPT_allowDecimals].Value := not FiledTypeIsDecimal(dsFieldData.FieldByName('FIELD_TYPE').AsString);
          end else if (TypeName = FIELDTYPE_text) or (TypeName = FIELDTYPE_TextArea) then
          begin
            if dsFieldData.FieldByName('SIZE_').AsInteger > 0 then
              ParamControls.OptionRecByName[OPT_maxLength].Value := dsFieldData.FieldByName('SIZE_').AsInteger;
          end else if TypeName = FIELDTYPE_date then
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
          TypeName := FIELDTYPE_ChildTable;
          CreateTypeFields;
          //ParamControls.OptionRecByName[OPT_joinFields].Value := ;
        end;

        if not dsFieldData.IsEmpty then
        begin
          ParamControls.OptionRecByName[OPT_allowBlank].Value := dsFieldData.FieldByName('NULL_FLAG').AsInteger = 1;
          s := ExtractFieldTitle(dsFieldData.FieldByName('FIELD_DESCR').AsString);
          if s <> '' then Title := s;
        end;
      except
      end;
    end;
  end;
end;

end.
