unit childForm;

interface

uses Windows, Classes, SysUtils, Variants, Forms, Controls, DBGridEh, GridsEh, Math, DB, FIBDataSet, pFIBDataSet,
  MemTableDataEh, MemTableEh, EhLibMTE, EhLibFIB, utils, settings, scriptEditor;

type
  TChildFormType = (cftNone = -1, cftFolder, cftDict, cftForm, cftWizard, cftEditor, cftPreview, cftInstrUsers, cftInstrGroups,
    cftInstrJson, cftInstrTask, cftInstrEns, cftInstrCrStat, cftInstrHistory);
  TOnChildClose = procedure(Index: integer; CanRefresh: boolean) of object;

  TChildForm = class(TForm)
  private
    OldProperties: TNodeDictInfo;
    FProperties: TNodeDictInfo;
    procedure SaveGridsParams;
  protected
    FOnChildClose: TOnChildClose;
    FMode: TOpenMode;
    FFormType: TChildFormType;
    FirstProps: boolean;
    procedure SetMode(Value: TOpenMode); virtual;
    procedure SetProperties(Value: TNodeDictInfo); virtual;
    function GetCanRefresh: boolean;
    procedure SetPropValues(PK: variant; Descriptor: variant; Title: variant; ParentDictPK: variant; FolderPK: variant;
      Login: variant; ObjType: TConfObjectType; FGuid: Variant);
    procedure SetFrameGridOptions(Options: TGridParams); virtual;
    // генерация скрипта изменений
    function gcsCheckOption(arr: TStringList; Field: TField; Value: Variant; QuotedString: boolean; EmptyStrToNull: boolean = true; ZeroToNull: boolean = false;
      QuoteSymb: char = ''''): string; overload;
    function gcsCheckOption(arr: TStringList; FieldName: string; OldValue, NewValue: Variant; QuotedString: boolean; EmptyStrToNull: boolean = true;
      ZeroToNull: boolean = false; QuoteSymb: char = ''''): string; overload;
    function gcsGenParentParam(Script, Vars, Cache: TStringList; KeyValue: Variant; ParamPrefix, PkFieldName, TableName: string;
      PreExpr: string = ''): string;
    function gcsGenUpdateSQL(Script, Fields: TStringList; TableName, KeyField, KeyValue: string; AddFields: array of string;
      Comment: string = ''; AddWhere: string = ''): boolean;
    procedure gcsGenInsertSQL(Script, Values: TStringList; TableName, Fields: string; RetFields, RetParams: array of string;
      Comment: string = ''; PassLine: boolean = true);
    function gcsGenDeleteSQL(Script, Deleted: TStringList; TableName, PkFieldName: string; AddWhere: string = ''): boolean;
    function GenChangesSQL(Script, Vars: TStringList): boolean; virtual;
    function PrepareScriptForm: TFScriptEditor; virtual;
    function ShowScriptForm: boolean; virtual;
  public
    Success: boolean;
    constructor Create(AOwner: TComponent; AFormType: TChildFormType; AMode: TOpenMode; AObjectPK: Variant;
      AOnChildClose: TOnChildClose; NoMDI: boolean = false); virtual;
    destructor Destroy; override;
    function GetObjectPK: Variant; virtual;
    function GetCapImage: integer; virtual;
    function GetShortCaption: string; virtual;
    procedure SetGridsOptions(Options: TGridParams);
    procedure RestoreGridSort;
    procedure ClearGridSort;
    procedure RestoreFormState;
    function GetParentIndex: integer;
    property Mode: TOpenMode read FMode write SetMode;
    property Properties: TNodeDictInfo read FProperties write SetProperties;
    property FormType: TChildFormType read FFormType;
    property CanRefresh: boolean read GetCanRefresh;
  end;

implementation

{ TChildForm }

uses main;

procedure TChildForm.RestoreGridSort;
var
  i, j: integer;
  str, order: string;
  flds: array of integer;
  ords: array of boolean;
  
begin
  // false, smUpEh - по возрастанию (ASC), стрелка вверх, A->Z
  // true, smDownEh - по убыванию (DESC), стрелка вниз, Z->A

  for i := 0 to ComponentCount - 1 do
    if Components[i] is TDBGridEh then
    begin
      if TDBGridEh(Components[i]).SortMarkedColumns.Count = 0 then continue;
      if TDBGridEh(Components[i]).DataSource.DataSet is TMemTableEh then
      begin
        str := '';
        for j := 0 to TDBGridEh(Components[i]).SortMarkedColumns.Count - 1 do
        begin
          case TDBGridEh(Components[i]).SortMarkedColumns.Items[j].Title.SortMarker of
            smDownEh: order := ' ASC';
            smUpEh: order := ' DESC';
            else order := '';
          end;

          if str = '' then str := TDBGridEh(Components[i]).SortMarkedColumns.Items[j].FieldName + order
          else str := str + ',' + TDBGridEh(Components[i]).SortMarkedColumns.Items[j].FieldName + order;
        end;

        if str <> '' then TMemTableEh(TDBGridEh(Components[i]).DataSource.DataSet).SortOrder := str;
      end else if TDBGridEh(Components[i]).DataSource.DataSet is TpFIBDataSet then
      begin
        SetLength(flds, TDBGridEh(Components[i]).SortMarkedColumns.Count);
        SetLength(ords, TDBGridEh(Components[i]).SortMarkedColumns.Count);
        for j := 0 to TDBGridEh(Components[i]).SortMarkedColumns.Count - 1 do
        begin
          case TDBGridEh(Components[i]).SortMarkedColumns.Items[j].Title.SortMarker of
            smDownEh: ords[j] := true;
            smUpEh: ords[j] := false;
            else ords[j] := false;
          end;

          flds[j] := TDBGridEh(Components[i]).SortMarkedColumns.Items[j].Field.Index;
        end;

        if Length(flds) > 0 then TpFIBDataSet(TDBGridEh(Components[i]).DataSource.DataSet).DoSortEx(flds, ords);
      end;
    end;
end;

procedure TChildForm.ClearGridSort;
var
  i, j: integer;
  
begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TDBGridEh then
    begin
      TDBGridEh(Components[i]).SortMarkedColumns.Clear;
      for j := 0 to TDBGridEh(Components[i]).Columns.Count - 1 do
        TDBGridEh(Components[i]).Columns.Items[j].Title.SortMarker := smNoneEh;
    end;
end;

constructor TChildForm.Create(AOwner: TComponent; AFormType: TChildFormType; AMode: TOpenMode; AObjectPK: Variant;
  AOnChildClose: TOnChildClose; NoMDI: boolean);
begin
  inherited Create(AOwner);

  if NoMDI then FormStyle := fsNormal
  else FormStyle := fsMDIChild;

  // позиция
  Left := 1;
  Top := 1;

  FOnChildClose := AOnChildClose;
  FFormType := AFormType;
  FirstProps := true;
  Success := false;
  Mode := AMode;
  FProperties := AssignNodeData(cotNone);
  OldProperties := AssignNodeData(cotNone);
  FProperties.PK := AObjectPK;
  RestoreFormState;

  // параметры грида
  SetGridsOptions(FSettings.GridOptions);
end;

destructor TChildForm.Destroy;
var
  r: boolean;

begin
  SaveGridsParams;
  r := false;
  if FormType in [cftFolder, cftDict, cftForm, cftWizard] then
    r := Success and CanRefresh;

  if Assigned(FOnChildClose) then FOnChildClose(Tag, r);
  FProperties.Free;
  inherited Destroy;
end;

function TChildForm.gcsCheckOption(arr: TStringList; Field: TField; Value: Variant; QuotedString, EmptyStrToNull, ZeroToNull: boolean; QuoteSymb: char): string;
var
  old_val, new_val: Variant;

begin
  old_val := VariantToDBStr(Field.Value, false, EmptyStrToNull, ZeroToNull);
  new_val := VariantToDBStr(Value, false, EmptyStrToNull, ZeroToNull);

  if old_val <> new_val then
    arr.Add(Field.FieldName + ' = ' + VariantToDBStr(Value, QuotedString, EmptyStrToNull, ZeroToNull, QuoteSymb));
end;

function TChildForm.gcsCheckOption(arr: TStringList; FieldName: string; OldValue, NewValue: Variant; QuotedString, EmptyStrToNull, ZeroToNull: boolean;
  QuoteSymb: char): string;
var
  old_val, new_val: Variant;

begin
  old_val := VariantToDBStr(OldValue, false, EmptyStrToNull, ZeroToNull);
  new_val := VariantToDBStr(NewValue, false, EmptyStrToNull, ZeroToNull);

  if old_val <> new_val then
    arr.Add(FieldName + ' = ' + VariantToDBStr(NewValue, QuotedString, EmptyStrToNull, ZeroToNull, QuoteSymb));
end;

function TChildForm.gcsGenDeleteSQL(Script, Deleted: TStringList; TableName, PkFieldName, AddWhere: string): boolean;
var
  ds: TpFIBDataSet;

begin
  result := false;

  if Deleted.Count > 0 then
  try
    ds := FMain.OpenSQL('select GUID from ' + TableName + ' where ' + PkFieldName + ' in (' + TextToString(Deleted.Text) + ')');
    result := not ds.IsEmpty;

    if result then
    begin
      Script.Add('');
      Script.Add('  /* ' + TableName + ' */');
      Script.Add('');
    end;

    while not ds.Eof do
    begin
      if ds.FieldByName('GUID').IsNull then raise Exception.Create(GUID_WARNING);
      Script.Add('  delete from ' + TableName + ' where GUID = ''' + ds.FieldByName('GUID').AsString + ''';');
      ds.Next;
    end;
  finally
    ds.Close;
    FreeAndNil(ds);
  end;
end;

procedure TChildForm.gcsGenInsertSQL(Script, Values: TStringList; TableName, Fields: string; RetFields, RetParams: array of string; Comment: string;
  PassLine: boolean);
begin
  if PassLine then Script.Add('');
  if Comment <> '' then
  begin
    Script.Add('  ' + Comment);
    Script.Add('');
  end;

  Script.Add('  insert into ' + TableName + ' (' + Fields + ')');

  if Length(RetFields) = 0 then
    Script.Add('  values (' + TextToString(Values.Text, '', ', ') + ');')
  else begin
    Script.Add('  values (' + TextToString(Values.Text, '', ', ') + ')');
    Script.Add('  returning ' + ArrayToString(RetFields, '', ', ') + ' into ' + ArrayToString(RetParams, '', ', ') + ';');
  end;
end;

function TChildForm.gcsGenParentParam(Script, Vars, Cache: TStringList; KeyValue: Variant; ParamPrefix, PkFieldName, TableName, PreExpr: string): string;
var
  n: integer;
  ds: TpFIBDataSet;

begin
  // поиск в кэше индекса переменной, возвращает имя этой переменной для связки
  // если в кэше ее нет, добавляет в скрипт и объявление запрос на выборку этой переменной и в кэш ее имя.
  // Возвращает имя переменной

  // Входные параметры:
  //  Script, Vars, Cache - понятно
  //  KeyValue - ключевое значение - ссылка на родительскую запись
  //  ParamPrefix - префикс для генерации названия переменной в скрипте - ее имя без индекса
  //  PkFieldName - ключевое поле (обчно PK) из родительской таблицы, куда ссылается KeyValue
  //  TableName - родительская таблица куда ссылается дочерняя (для генерации select запроса)
  //  PreExpr - выражение, которое надо добавить перед результатом (например "FEILD = ")

  if VarIsNull(KeyValue) then
    result := PreExpr + 'null'
  else begin
    ds := FMain.OpenSQL('select GUID from ' + TableName + ' where ' + PkFieldName + ' = ' + VarToStr(KeyValue));
    try
      if ds.FieldByName('GUID').IsNull then raise Exception.Create(GUID_WARNING);

      n := Cache.IndexOf(ds.FieldByName('GUID').AsString);

      if n = -1 then
      begin
        n := Cache.Add(ds.FieldByName('GUID').AsString);
        result := ParamPrefix + IntToStr(n);
        Vars.Add('declare variable ' + result + ' integer;');
        Script.Add('');
        Script.Add('  select ' + PkFieldName + ' from ' + TableName + ' where GUID = ' + VariantToDBStr(ds.FieldByName('GUID').AsString, true) +
          ' into :' + result + ';');
      end else
        result := ParamPrefix + IntToStr(n);

      result := PreExpr + ':' + result;
    finally
      ds.Close;
      FreeAndNil(ds);
    end;
  end;
end;

function TChildForm.gcsGenUpdateSQL(Script, Fields: TStringList; TableName, KeyField, KeyValue: string; AddFields: array of string; Comment,
  AddWhere: string): boolean;
var
  i: integer;

begin
  result := false;

  if Fields.Count > 0 then
  begin
    result := true;
    for i := 0 to Length(AddFields) - 1 do
      Fields.Add(AddFields[i]);

    Script.Add('');
    if Comment <> '' then Script.Add('  ' + Comment);
    Script.Add('  update ' + TableName + ' set');
    for i := 0 to Fields.Count - 1 do
      if i = Fields.Count - 1 then Script.Add('    ' + Fields.Strings[i])
      else Script.Add('    ' + Fields.Strings[i] + ',');
    Script.Add('  where ' + KeyField + ' = ' + KeyValue + AddWhere + ';');
  end;
end;

function TChildForm.GenChangesSQL(Script, Vars: TStringList): boolean;
begin
  // этот метод - точка входа генерации скриптов изменений. Именно его надо переопределять в дочерних формах если надо создать этот функционал
  result := false;
end;

function TChildForm.GetCanRefresh: boolean;
begin
  result := false;
  if not Success then exit;

  if Mode = omAdd then result := true
  else result := not FProperties.IsEqual(OldProperties);
end;

function TChildForm.GetCapImage: integer;
begin
  result := Ord(FormType);
  if Mode = omView then result := result + Ord(cftInstrCrStat) + 1;
end;

function TChildForm.GetObjectPK: Variant;
begin
  result := FProperties.PK;
end;

function TChildForm.GetParentIndex: integer;
begin
  if Owner is TChildForm then result := TChildForm(Owner).Tag
  else result := -1;
end;

function TChildForm.GetShortCaption: string;
begin
  result := Caption;
end;

function TChildForm.PrepareScriptForm: TFScriptEditor;
var
  Script, Vars: TStringList;
  i: integer;

begin
  Script := TStringList.Create;
  Vars := TStringList.Create;
  result := TFScriptEditor.Create(FMain);

  try
    try
      if GenChangesSQL(Script, Vars) then
      begin
        FMain.WriteSQLHeader(Properties, Ord(Mode), 0, TStringList(result.smScript.Lines));
        result.smScript.Lines.AddStrings(Vars);
        result.smScript.Lines.Add('begin');
        result.smScript.Lines.AddStrings(Script);
        result.smScript.Lines.Add('');
        result.smScript.Lines.Add('  insert into DCFG_REF_LOG (OBJ_TYPE, REF_DESCRIPTOR, ACTION_, USER_PK, GUID) values (' + IntToStr(Ord(Properties.ObjType)) +
          ', ' + VariantToDBStr(Properties.Descriptor, true) + ', 1, ' + FMain.dsPortalUserPK.AsString + ', ' + VariantToDBStr(Properties.Guid, true) + ');');
        FMain.WriteSQLFooter(Properties, Ord(Mode), 0, TStringList(result.smScript.Lines));
      end else
      begin
        FreeAndNil(result);
        { result.smScript.Lines.Add('/*');
        result.smScript.Lines.Add('');
        result.smScript.Lines.Add('  --== Не обнаружено изменений для генерации скрипта ==--');
        result.smScript.Lines.Add('');
        result.smScript.Lines.Add('*/'); }
      end;
    except
      on e: Exception do
      begin
        Script.Text := e.Message;
        result.smScript.Lines.Add('/*');
        result.smScript.Lines.Add('');
        for i := 0 to Script.Count - 1 do result.smScript.Lines.Add('  ' + Script.Strings[i]);
        result.smScript.Lines.Add('');
        result.smScript.Lines.Add('*/');
      end;
    end;
  finally
    Script.Free;
    Vars.Free;
  end;
end;

procedure TChildForm.RestoreFormState;
begin
  case FSettings.ChildWindowState of
    cwsNormal: WindowState := wsNormal;
    cwsMaximized: WindowState := wsMaximized;
    cwsKeep: if FSettings.ChildMaximized then WindowState := wsMaximized else WindowState := wsNormal;
  end;
end;

procedure TChildForm.SaveGridsParams;
var
  i: integer;

begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TDBGridEh then FSettings.SaveGridParams(TDBGridEh(Components[i]), ClassName);
end;

procedure TChildForm.SetFrameGridOptions(Options: TGridParams);
begin

end;

procedure TChildForm.SetGridsOptions(Options: TGridParams);
var
  i: integer;

begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TDBGridEh then
    begin
      Options.AssignTo(TDBGridEh(Components[i]));
      FSettings.LoadGridParams(TDBGridEh(Components[i]), ClassName);
      TDBGridEh(Components[i]).OnKeyUp := FMain.GridKeyUp;
    end;

  SetFrameGridOptions(Options);
end;

procedure TChildForm.SetMode(Value: TOpenMode);
begin
  FMode := Value;
end;

procedure TChildForm.SetProperties(Value: TNodeDictInfo);
begin
  if FirstProps then OldProperties.Assign(Value);
  FProperties.Assign(Value);
  FirstProps := false;
  // у MemTableEh почему-то после такого сносит крышу и он перестает сортировать по нажатию на шапку колонки
  //RestoreGridSort;
  ClearGridSort;
end;

procedure TChildForm.SetPropValues(PK, Descriptor, Title, ParentDictPK, FolderPK, Login: variant; ObjType: TConfObjectType; FGuid: Variant);
begin
  FProperties.PK := PK;
  FProperties.Descriptor := Descriptor;
  FProperties.Title := Title;
  FProperties.ParentDictPK := ParentDictPK;
  FProperties.FolderPK := FolderPK;
  FProperties.Login := Login;
  FProperties.ObjType := ObjType;
  FProperties.Guid := FGuid;
end;

function TChildForm.ShowScriptForm: boolean;
var
  FScript: TFScriptEditor;
  Script, Vars: TStringList;

begin
  result := false;

  Script := TStringList.Create;
  Vars := TStringList.Create;
  FScript := TFScriptEditor.Create(Self);
  try
    if GenChangesSQL(Script, Vars) then
    begin
      FMain.WriteSQLHeader(Properties, Ord(Mode), 0, TStringList(FScript.smScript.Lines));
      FScript.smScript.Lines.AddStrings(Vars);
      FScript.smScript.Lines.Add('begin');
      FScript.smScript.Lines.AddStrings(Script);
      FScript.smScript.Lines.Add('');
      FScript.smScript.Lines.Add('  insert into DCFG_REF_LOG (OBJ_TYPE, REF_DESCRIPTOR, ACTION_, USER_PK, GUID) values (' + IntToStr(Ord(Properties.ObjType)) +
        ', ' + VariantToDBStr(Properties.Descriptor, true) + ', 1, ' + FMain.dsPortalUserPK.AsString + ', ' + VariantToDBStr(Properties.Guid, true) + ');');
      FMain.WriteSQLFooter(Properties, Ord(Mode), 0, TStringList(FScript.smScript.Lines));
    end else
    begin
      FScript.smScript.Lines.Add('');
      FScript.smScript.Lines.Add('/*');
      FScript.smScript.Lines.Add('');
      FScript.smScript.Lines.Add('  --== Не обнаружено изменений для генерации скрипта ==--');
      FScript.smScript.Lines.Add('');
      FScript.smScript.Lines.Add('*/');
    end;

    result := FScript.ShowModal = mrOk;
  finally
    Script.Free;
    Vars.Free;
    FScript.Free;
  end;
end;

end.