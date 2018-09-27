unit childForm;

interface

uses Windows, Classes, Forms, Controls, Variants, utils, settings, DBGridEh, GridsEh, Math, DB, FIBDataSet, pFIBDataSet,
  MemTableDataEh, MemTableEh, EhLibMTE, EhLibFIB;

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
      Login: variant; ObjType: TConfObjectType);
    procedure SetFrameGridOptions(Options: TGridParams); virtual;
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

procedure TChildForm.SetPropValues(PK, Descriptor, Title, ParentDictPK, FolderPK, Login: variant; ObjType: TConfObjectType);
begin
  FProperties.PK := PK;
  FProperties.Descriptor := Descriptor;
  FProperties.Title := Title;
  FProperties.ParentDictPK := ParentDictPK;
  FProperties.FolderPK := FolderPK;
  FProperties.Login := Login;
  FProperties.ObjType := ObjType;
end;

end.
