unit objectEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Spin,
  DB, Mask, DBCtrlsEh, DBLookupEh, utils, DBGridEh, DBGridEhGrouping, GridsEh, MemTableDataEh, MemTableEh, MemDS, DBAccess,
  Uni, FIBDataSet, pFIBDataSet, UniProvider, PostgreSQLUniProvider, OracleUniProvider, MySQLUniProvider, InterBaseUniProvider,
  dbUtils, ActnList, main, childForm;

type
  TFObjectEditor = class(TChildForm)
    GroupBox1: TGroupBox;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    Label2: TLabel;
    edPk: TEdit;
    Label4: TLabel;
    dsoJoinParent: TDataSource;
    lcbJoinParent: TDBLookupComboboxEh;
    Label3: TLabel;
    Bevel2: TBevel;
    Label10: TLabel;
    edTitle: TEdit;
    Bevel3: TBevel;
    Label14: TLabel;
    chbIsMultiJoin: TCheckBox;
    Label25: TLabel;
    sbAddField: TSpeedButton;
    sbDelField: TSpeedButton;
    dbgJoinFields: TDBGridEh;
    mtJoinFields: TMemTableEh;
    dsoJoinFields: TDataSource;
    mtJoinFieldsCHILD_FIELD: TStringField;
    mtJoinFieldsPARENT_FIELD: TStringField;
    chbInnerJoin: TCheckBox;
    chbDeleted: TCheckBox;
    dbgPrimaryKey: TDBGridEh;
    sbDelPk: TSpeedButton;
    sbAddPk: TSpeedButton;
    Label1: TLabel;
    mtPrimaryKey: TMemTableEh;
    dsoPrimaryKey: TDataSource;
    dsChildFields: TUniQuery;
    dsJoinParent: TpFIBDataSet;
    dsJoinParentPK: TFIBIntegerField;
    dsJoinParentNAME: TFIBStringField;
    mtPrimaryKeyFIELD: TStringField;
    mtPrimaryKeyFIELD_NAME: TStringField;
    lcbName: TDBLookupComboboxEh;
    dsDbObjects: TUniQuery;
    dsoDbObjects: TDataSource;
    edObjectType: TEdit;
    Label5: TLabel;
    dbgInputParams: TDBGridEh;
    mtInputParams: TMemTableEh;
    dsoInputParams: TDataSource;
    dsMainFields: TUniQuery;
    mtInputParamsVALUE: TStringField;
    mtInputParamsTYPE: TStringField;
    mtInputParamsNAME: TStringField;
    dsJoinParentFORM_PK: TFIBIntegerField;
    dsJoinParentJOIN_PARENT_PK: TFIBIntegerField;
    dsPkFields: TUniQuery;
    dsProcParams: TUniQuery;
    ActionList: TActionList;
    ASave: TAction;
    mtJoinFieldsOPERATOR: TStringField;
    mtJoinFieldsCONDITION: TBooleanField;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure lcbJoinParentChange(Sender: TObject);
    procedure lcbNameChange(Sender: TObject);
    procedure sbAddPkClick(Sender: TObject);
    procedure sbDelPkClick(Sender: TObject);
    procedure sbAddFieldClick(Sender: TObject);
    procedure sbDelFieldClick(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure mtInputParamsTYPEChange(Sender: TField);
  private
    procedure SetMode(Value: TOpenMode); override;
  public
    EditingRec: TBookmark;
    procedure RegisterForm;
    function GetShortCaption: string; override;
  end;

implementation

{$R *.dfm}

procedure TFObjectEditor.ASaveExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then btnSaveClick(btnSave);
end;

procedure TFObjectEditor.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFObjectEditor.btnSaveClick(Sender: TObject);
begin
  if Mode = omView then exit;
  Success := true;
  Close;
end;

procedure TFObjectEditor.lcbJoinParentChange(Sender: TObject);
var
  i: integer;
  
begin
  mtJoinFields.EmptyTable;

  dbgJoinFields.Enabled := (not VarIsNull(lcbJoinParent.KeyValue)) and (lcbJoinParent.KeyValue <> 0);
  sbAddField.Enabled := dbgJoinFields.Enabled and (Mode <> omView);
  sbDelField.Enabled := sbAddField.Enabled;

  // заливаем список полей выбранного объекта
  dsMainFields.Close;
  dsMainFields.ParamByName('NAME').Value := lcbJoinParent.Text;
  dsMainFields.Open;

  for i := 0 to dbgJoinFields.Columns.Count - 1 do
  begin
    if dbgJoinFields.Columns.Items[i].FieldName <> 'PARENT_FIELD' then continue;

    dbgJoinFields.Columns.Items[i].PickList.Clear;
    dsMainFields.First;
    while not dsMainFields.Eof do
    begin
      dbgJoinFields.Columns.Items[i].PickList.Add(dsMainFields.FieldByName('FIELD_NAME').AsString);
      dsMainFields.Next;
    end;
  end;
end;

procedure TFObjectEditor.lcbNameChange(Sender: TObject);
var
  i: integer;
  
begin
  mtJoinFields.EmptyTable;
  mtPrimaryKey.EmptyTable;
  mtInputParams.EmptyTable;

  if dsDbObjects.Locate('NAME', lcbName.KeyValue, [loCaseInsensitive]) then
    edObjectType.Text := dsDbObjects.FieldByName('TYPE_').AsString;

  dbgInputParams.Enabled := false;
  sbAddPk.Enabled := false;
  sbDelPk.Enabled := false;
  dbgPrimaryKey.Enabled := false;

  if edObjectType.Text = 'PROC' then
  begin
    dbgInputParams.Enabled := true;
  end else if (edObjectType.Text = 'TABLE') or (edObjectType.Text = 'VIEW') then
  begin
    sbAddPk.Enabled := (Mode <> omView) and true;
    sbDelPk.Enabled := (Mode <> omView) and true;
    dbgPrimaryKey.Enabled := true;
  end;

  // заливаем список полей выбранного объекта
  dsChildFields.Close;
  dsChildFields.ParamByName('NAME').Value := lcbName.KeyValue;
  dsChildFields.Open;

  for i := 0 to dbgJoinFields.Columns.Count - 1 do
  begin
    if dbgJoinFields.Columns.Items[i].FieldName <> 'CHILD_FIELD' then continue;

    dbgJoinFields.Columns.Items[i].PickList.Clear;
    dsChildFields.First;
    while not dsChildFields.Eof do
    begin
      dbgJoinFields.Columns.Items[i].PickList.Add(dsChildFields.FieldByName('FIELD_NAME').AsString);
      dsChildFields.Next;
    end;
  end;

  // заполняем поле(я) ПК
  try
    dsPkFields.Close;
    dsPkFields.ParamByName('NAME').Value := lcbName.KeyValue;
    dsPkFields.Open;

    dsPkFields.First;
    if (not dsPkFields.IsEmpty) and (not mtPrimaryKey.Active) then mtPrimaryKey.CreateDataSet;
    while not dsPkFields.Eof do
    begin
      mtPrimaryKey.Append;
      mtPrimaryKeyFIELD.AsString := dsPkFields.FieldByName('FIELD_NAME').AsString;
      mtPrimaryKey.Post;
      dsPkFields.Next;
    end;
    dsPkFields.Close;
    if mtPrimaryKey.Active then mtPrimaryKey.First;
  except
  end;

  // заполняем вх. параметры процедуры
  try
    dsProcParams.Close;
    dsProcParams.ParamByName('NAME').Value := lcbName.KeyValue;
    dsProcParams.Open;
    
    dsProcParams.First;
    if (not dsProcParams.IsEmpty) and (not mtInputParams.Active) then mtInputParams.CreateDataSet;
    while not dsProcParams.Eof do
    begin
      mtInputParams.Append;
      mtInputParamsTYPE.AsString := PROCPARAM_insertValue;
      mtInputParamsNAME.AsString := dsProcParams.FieldByName('PARAM_NAME').AsString;
      mtInputParams.Post;
      dsProcParams.Next;
    end;
    dsProcParams.Close;
    if mtInputParams.Active then mtInputParams.First;
  except
  end;
end;

procedure TFObjectEditor.mtInputParamsTYPEChange(Sender: TField);
var
  col: TColumnEh;

begin
  col := FindColumnByFieldName(dbgInputParams, 'VALUE');

  if Sender.Value = PROCPARAM_loginnedUser then
  begin
    if Assigned(col) then col.PickList.Text := LOGINED_USER_VALUES;
  end else
  begin
    if Assigned(col) then col.PickList.Text := '';
  end;
end;

procedure TFObjectEditor.RegisterForm;
var
  s: string;

begin
  if Mode <> omAdd then
  begin
    if edObjectType.Text = 'TABLE' then s := 'Таблица'
    else if edObjectType.Text = 'VIEW' then s := 'Представление'
    else if edObjectType.Text = 'PROC' then s := 'Процедура';

    if Mode = omEdit then
      Caption := GenCaption(s, 'редактирование', edPk.Text, edTitle.Text, VarToStr(lcbName.Value), false)
    else
      Caption := GenCaption(s, 'просмотр', edPk.Text, edTitle.Text, VarToStr(lcbName.Value), false);
  end;

  FMain.RegisterChildForm(Self);
end;

procedure TFObjectEditor.sbAddFieldClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if not (mtJoinFields.State in [dsEdit, dsInsert]) then mtJoinFields.Append;
  dbgJoinFields.SetFocus;
end;

procedure TFObjectEditor.sbAddPkClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if not (mtPrimaryKey.State in [dsEdit, dsInsert]) then mtPrimaryKey.Append;
  dbgPrimaryKey.SetFocus;
end;

procedure TFObjectEditor.sbDelFieldClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (not mtJoinFields.Active) or mtJoinFields.IsEmpty then exit;

  if Application.MessageBox(pchar('Убрать связку по полю "' + mtJoinFieldsCHILD_FIELD.AsString + '"?'), 'Подтверждение',
    MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

  mtJoinFields.Delete;
end;

procedure TFObjectEditor.sbDelPkClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (not mtPrimaryKey.Active) or mtPrimaryKey.IsEmpty then exit;

  if Application.MessageBox(pchar('Удалить поле первичного ключа "' + mtPrimaryKeyFIELD_NAME.AsString + '"?'), 'Подтверждение',
    MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

  mtPrimaryKey.Delete;
end;

procedure TFObjectEditor.SetMode(Value: TOpenMode);
begin
  inherited SetMode(Value);

  if Mode = omView then
  begin
    btnSave.Enabled := false;
    lcbName.ReadOnly := true;
    lcbName.Color := clBtnFace;
    edTitle.ReadOnly := true;
    edTitle.Color := clBtnFace;
    chbDeleted.Enabled := false;
    lcbJoinParent.ReadOnly := true;
    lcbJoinParent.Color := clBtnFace;
    chbIsMultiJoin.Enabled := false;
    chbInnerJoin.Enabled := false;
    sbAddField.Enabled := false;
    sbDelField.Enabled := false;
    dbgJoinFields.AllowedOperations := [];
    sbAddPk.Enabled := false;
    sbDelPk.Enabled := false;
    dbgPrimaryKey.AllowedOperations := [];
    dbgInputParams.AllowedOperations := [];
  end;
end;

procedure TFObjectEditor.FormActivate(Sender: TObject);
begin
  ASave.Enabled := true;
  FMain.CheckFormButton(Tag);
end;

procedure TFObjectEditor.FormDeactivate(Sender: TObject);
begin
  ASave.Enabled := false;
end;

function TFObjectEditor.GetShortCaption: string;
begin
  if Mode = omAdd then
    result := Caption
  else begin
    if edObjectType.Text = 'TABLE' then result := 'Таблица'
    else if edObjectType.Text = 'VIEW' then result := 'Представление'
    else if edObjectType.Text = 'PROC' then result := 'Процедура';
    result := result + ' ' + VarToStr(lcbName.Value);
  end;
end;

end.
