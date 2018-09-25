unit dumpObjects;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Mask, JvExMask, JvToolEdit,
  Buttons, ActnList, ComCtrls, DB, fib, FIBDatabase, pFIBDatabase, FIBDataSet, pFIBDataSet, settings, utils, main;

type
  TFDumpObjects = class(TForm)
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    ActionList: TActionList;
    AClose: TAction;
    AExec: TAction;
    lbProgress: TLabel;
    pcMain: TPageControl;
    tsMain: TTabSheet;
    lbDescription: TLabel;
    Label1: TLabel;
    edScriptFile: TJvFilenameEdit;
    Label4: TLabel;
    cbScriptType: TComboBox;
    lbTypeDescr: TLabel;
    Label2: TLabel;
    tsRef: TTabSheet;
    tsForm: TTabSheet;
    tsStartForm: TTabSheet;
    tsGrEditForm: TTabSheet;
    tsWizard: TTabSheet;
    tsFolder: TTabSheet;
    chbRefOptions: TCheckBox;
    Label3: TLabel;
    chbDbObjects: TCheckBox;
    Label5: TLabel;
    chbMainForm: TCheckBox;
    Label6: TLabel;
    chbRankPermissions: TCheckBox;
    Label7: TLabel;
    chbRolePermissions: TCheckBox;
    Label8: TLabel;
    chbStartForm: TCheckBox;
    Label9: TLabel;
    chbGrEditForm: TCheckBox;
    Label10: TLabel;
    chbRankPermRecreate: TCheckBox;
    chbRolePermRecreate: TCheckBox;
    chbFilterConfig: TCheckBox;
    chbFilterConfigBind: TCheckBox;
    chbFilterGroup: TCheckBox;
    chbCharts: TCheckBox;
    chbChartGroups: TCheckBox;
    chbWizard: TCheckBox;
    Label11: TLabel;
    chbOtherEvents: TCheckBox;
    chbFolders: TCheckBox;
    Label12: TLabel;
    chbFormParams: TCheckBox;
    Label13: TLabel;
    chbFormFields: TCheckBox;
    Label14: TLabel;
    chbFormFieldGroups: TCheckBox;
    Label15: TLabel;
    chbStFormParams: TCheckBox;
    Label16: TLabel;
    chbStFormFields: TCheckBox;
    Label17: TLabel;
    chbStFormFieldGroups: TCheckBox;
    Label18: TLabel;
    chbGrFormParams: TCheckBox;
    Label19: TLabel;
    chbGrFormFields: TCheckBox;
    Label20: TLabel;
    chbGrFormFieldGroups: TCheckBox;
    Label21: TLabel;
    chbFolderParams: TCheckBox;
    Label22: TLabel;
    chbScenParams: TCheckBox;
    Label23: TLabel;
    chbScenStates: TCheckBox;
    Label24: TLabel;
    procedure ACloseExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure AExecExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edScriptFileChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbScriptTypeChange(Sender: TObject);
    procedure chbMainFormClick(Sender: TObject);
    procedure chbRankPermissionsClick(Sender: TObject);
    procedure chbRolePermissionsClick(Sender: TObject);
    procedure chbFilterConfigClick(Sender: TObject);
    procedure chbChartsClick(Sender: TObject);
    procedure chbStartFormClick(Sender: TObject);
    procedure chbGrEditFormClick(Sender: TObject);
    procedure chbWizardClick(Sender: TObject);
    procedure chbFoldersClick(Sender: TObject);
  private
    FItem: TNodeDictInfo;
    procedure SetItem(const Value: TNodeDictInfo);
    function GetObjectDescription: string;
    procedure ActivatePages;
    procedure RestoreOptions;
    procedure SaveOptions;
    function CheckOptions(Silent: boolean): boolean;
    procedure SetProgressText(msg: string);
    // собственно методы процесса генерации
    function DoExec: boolean;
    procedure GenSQL(Script, Vars: TStringList);
    procedure DeleteSQL(Script, Vars: TStringList);
    procedure WriteSQLHeader(Script: TStringList; NoBlocks: boolean);
    procedure WriteSQLFooter(Script: TStringList);
    // Dict
    procedure DelDictSQL(descr: string; Script: TStringList);
    procedure GenDictSQL(Pk: integer; Script, Vars: TStringList);
    // Wizard
    procedure DelWizardsOnDict(refPk: integer; Script: TStringList; isMain: boolean=false);
    procedure DelWizardSQL(descr: string; Script: TStringList; isMain: boolean=false);
    procedure GenWizardSQL(Pk: integer; Script, Vars: TStringList);
    // Form
    procedure DelFormSQL(descr: string; Script: TStringList);
    procedure GenFormSQL(Pk: integer; Script, Vars: TStringList);
    // Folder
    procedure GenFolderSQL(Pk: integer; refDescr: string; Script, Vars: TStringList);
  public
    property Item: TNodeDictInfo read FItem write SetItem;
  end;

implementation

{$R *.dfm}

{ TFCmpObjects }

procedure TFDumpObjects.ACloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFDumpObjects.ActivatePages;
begin
  tsRef.TabVisible := false;
  tsForm.TabVisible := false;
  tsStartForm.TabVisible := false;
  tsGrEditForm.TabVisible := false;
  tsWizard.TabVisible := false;
  tsFolder.TabVisible := false;

  case cbScriptType.ItemIndex of
    -1, 0, 2: ;  // все вкладки уже скрыты, больше ничего делать не надо
    1:
    begin
      case FItem.ObjType of
        cotFolder: tsFolder.TabVisible := true;
        cotDict:
        begin
          tsRef.TabVisible := true;
          tsForm.TabVisible := chbMainForm.Checked;
          tsForm.Caption := 'Главная форма';
          tsStartForm.TabVisible := chbStartForm.Checked;
          tsGrEditForm.TabVisible := chbGrEditForm.Checked;
          tsWizard.TabVisible := chbWizard.Checked;
          tsFolder.TabVisible := chbFolders.Checked;
        end;
        cotForm:
        begin
          tsForm.TabVisible := true;
          tsForm.Caption := 'Форма';
        end;
        cotWizard: tsWizard.TabVisible := true;
      end;
    end;
  end;
end;

procedure TFDumpObjects.AExecExecute(Sender: TObject);
begin
  if DoExec then
  begin
    Application.MessageBox('Скрипт сформирован!', 'Результат', MB_OK + MB_ICONINFORMATION);
    Close;
  end;
end;

procedure TFDumpObjects.cbScriptTypeChange(Sender: TObject);
begin
  case cbScriptType.ItemIndex of
    -1: lbTypeDescr.Caption := 'Не выбран тип создаваемого скрипта';
    0: lbTypeDescr.Caption := 'Скрипт полного создания объекта. В скрипт будут включены все элементы объекта, возможность выбора отдельных элементов будет недоступна.'#13#10 +
      'В скрипт будут добавлены команды на удаление объекта и всех сопутствующих объектов.'#13#10 +
      'В скрипт для справочника будут включены:'#13#10 +
      '  - все дочерние справочники и родительские с их дочерними - если данный справочник их имеет;'#13#10 +
      '  - все сценарии всех попавших в скрипт справочников.';
    1: lbTypeDescr.Caption := 'Обновление элементов конфигурации объекта. В скрипт попадут только выбранные элементы.'#13#10 +
      'Все связанные элементы (такие, как поля форм и т.п.) будут обновлены по ключу (не PK), если есть или добавлены.';
    2: lbTypeDescr.Caption := 'Скрипт полного удаления объекта и всех привязанных к нему объектов.';
  end;

  ActivatePages;
  btnSave.Enabled := CheckOptions(true);
end;

procedure TFDumpObjects.chbChartsClick(Sender: TObject);
begin
  chbChartGroups.Enabled := chbCharts.Checked;
end;

procedure TFDumpObjects.chbFilterConfigClick(Sender: TObject);
begin
  chbFilterConfigBind.Enabled := chbFilterConfig.Checked;
end;

procedure TFDumpObjects.chbFoldersClick(Sender: TObject);
begin
  tsFolder.TabVisible := chbFolders.Checked;
end;

procedure TFDumpObjects.chbGrEditFormClick(Sender: TObject);
begin
  tsGrEditForm.TabVisible := chbGrEditForm.Checked;
end;

procedure TFDumpObjects.chbMainFormClick(Sender: TObject);
begin
  tsForm.TabVisible := chbMainForm.Checked;
end;

procedure TFDumpObjects.chbRankPermissionsClick(Sender: TObject);
begin
  chbRankPermRecreate.Enabled := chbRankPermissions.Checked;
end;

procedure TFDumpObjects.chbRolePermissionsClick(Sender: TObject);
begin
  chbRolePermRecreate.Enabled := chbRolePermissions.Checked;
end;

procedure TFDumpObjects.chbStartFormClick(Sender: TObject);
begin
  tsStartForm.TabVisible := chbStartForm.Checked;
end;

procedure TFDumpObjects.chbWizardClick(Sender: TObject);
begin
  tsWizard.TabVisible := chbWizard.Checked;
end;

function TFDumpObjects.CheckOptions(Silent: boolean): boolean;
begin
  result := false;

  if (Trim(edScriptFile.FileName) = '') or (not DirectoryExists(ExtractFileDir(edScriptFile.FileName))) then
  begin
    if not Silent then
      Application.MessageBox('Файл скрипта не задан или неверно указана папка расположения файла!', 'Ошибка', MB_OK + MB_ICONERROR);
    exit;
  end;

  if cbScriptType.ItemIndex = -1 then
  begin
    if not Silent then
      Application.MessageBox('Не указан тип создаваемого скрипта!', 'Ошибка', MB_OK + MB_ICONERROR);
    exit;
  end;

  result := true;
end;

procedure TFDumpObjects.DelDictSQL(descr: string; Script: TStringList);
var
  ds: TpFIBDataSet;

begin
  // поудаляем сценарии
  try
    ds := FMain.OpenSQL('select PK from DYNAMIC_FORM_REFERENCE where DESCRIPTOR_ = ''' + descr + '''');

    if not ds.IsEmpty then
      DelWizardsOnDict(ds.FieldByName('PK').AsInteger, Script, true);
  finally
    if Assigned(ds) then
    begin
      ds.Close;
      ds.Free;
    end;
  end;

  // удаляем основной, все дочерние справочники и прочие объекты будут удалены каскадно
  Script.Add('/* deleting dict */');
  Script.Add('delete from DYNAMIC_FORM_REFERENCE where DESCRIPTOR_ = ''' + descr + ''';');
  Script.Add('insert into DCFG_REF_LOG (OBJ_TYPE, REF_DESCRIPTOR, ACTION_, USER_PK) values (1, ''' + descr + ''', 3, ' + FMain.dsPortalUserPK.AsString + ');');
  Script.Add('');
end;

procedure TFDumpObjects.DeleteSQL(Script, Vars: TStringList);
begin
  case FItem.ObjType of
    cotFolder: ; // папки не удаляем
    cotDict: DelDictSQL(FItem.Descriptor, Script);
    cotForm: DelFormSQL(FItem.Descriptor, Script);
    cotWizard: DelWizardSQL(FItem.Descriptor, Script, true);
  end;
end;

procedure TFDumpObjects.DelFormSQL(descr: string; Script: TStringList);
begin
  Script.Add('/* deleteing form */');

  if descr <> '' then
    Script.Add('delete from DYNAMIC_FORM where ALIAS_FORM = ''' + descr + ''';')
  else
    //Script.Add('delete from WIZARD_SCENS where PK = ' + IntToStr(pk) + ';');
    raise Exception.Create('Форма не может быть добавлена в скрипт на удаление, т.к. она не имеет дескриптора!');

  Script.Add('insert into DCFG_REF_LOG (OBJ_TYPE, REF_DESCRIPTOR, ACTION_, USER_PK) values (2, ' + VariantToDBStr(descr, true) + ', 3, ' +
    FMain.dsPortalUserPK.AsString + ');');
  Script.Add('');
end;

procedure TFDumpObjects.DelWizardsOnDict(refPk: integer; Script: TStringList; isMain: boolean);
var
  ds: TpFIBDataSet;

begin
  try
    ds := FMain.OpenSQL('select TYPE_, PK, DESCRIPTOR_ from (' +
      'select 0 TYPE_, PK, DESCRIPTOR_ from WIZARD_SCENS where REF_PK = :REF_PK ' +
      '/*union select 1 TYPE_, s.PK, s.DESCRIPTOR_ from WIZARD_SATES st ' +
      'join WIZARD_SCENS s on s.PK = st.SCEN_PK ' +
      'join DYNAMIC_FORM_REFERENCE r on r.MAIN_FORM_PK = st.FORM_PK ' +
      'where r.PK = :REF_PK*/) order by TYPE_, PK', 'REF_PK=' + IntToStr(refPk));

    while not ds.Eof do
    begin
      DelWizardSQL(ds.FieldByName('DESCRIPTOR_').AsString, Script, isMain and (ds.RecNo = 1));
      ds.Next;
    end;

    // теперь пройдемся по дочерним справочникам
    ds.Close;
    ds.SQLs.SelectSQL.Text := 'select PK from DYNAMIC_FORM_REFERENCE where PARENT_REFERENCE_PK = :REF_PK';
    ds.ParamByName('REF_PK').Value := refPk;

    ds.Open;
    while not ds.Eof do
    begin
      DelWizardsOnDict(ds.FieldByName('PK').AsInteger, Script, false);
      ds.Next;
    end;
  finally
    if Assigned(ds) then
    begin
      ds.Close;
      ds.Free;
    end;
  end;
end;

procedure TFDumpObjects.DelWizardSQL(descr: string; Script: TStringList; isMain: boolean);
begin
  if isMain then Script.Add('/* deleteing wizard */');

  if descr <> '' then
    Script.Add('delete from WIZARD_SCENS where DESCRIPTOR_ = ''' + descr + ''';')
  else
    //Script.Add('delete from WIZARD_SCENS where PK = ' + IntToStr(pk) + ';');
    raise Exception.Create('Сценарий не может быть добавлен в скрипт на удаление, т.к. он не имеет дескриптора!');

  Script.Add('insert into DCFG_REF_LOG (OBJ_TYPE, REF_DESCRIPTOR, ACTION_, USER_PK) values (3, ' + VariantToDBStr(descr, true) + ', 3, ' +
    FMain.dsPortalUserPK.AsString + ');');
  Script.Add('');
end;

function TFDumpObjects.DoExec: boolean;
var
  Script, Vars, Body: TStringList;

begin
  result := false;
  if not CheckOptions(false) then exit;

  Screen.Cursor := crSQLWait;
  Script := TStringList.Create;
  Vars := TStringList.Create;
  Body := TStringList.Create;

  try
    case cbScriptType.ItemIndex of
      0:
      begin
        FMain.SaveToSQL(FItem, edScriptFile.FileName, 0, true);
        result := true;
      end;
      1:
      begin
        GenSQL(Body, Vars);
        Vars.Add('begin');
        WriteSQLHeader(Script, false);
        Script.AddStrings(Vars);
        Script.AddStrings(Body);
        WriteSQLFooter(Script);
        SetProgressText('Сохраняю...');
        Script.SaveToFile(edScriptFile.FileName);
        result := true;
      end;
      2:
      begin
        WriteSQLHeader(Script, true);
        DeleteSQL(Script, Vars);
        SetProgressText('Сохраняю...');
        Script.SaveToFile(edScriptFile.FileName);
        result := true;
      end;
    end;
  finally
    SetProgressText('');
    Screen.Cursor := crDefault;
    Script.Free;
    Vars.Free;
    Body.Free;
  end;
end;

procedure TFDumpObjects.edScriptFileChange(Sender: TObject);
begin
  btnSave.Enabled := CheckOptions(true);
end;

procedure TFDumpObjects.FormActivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, true);
end;

procedure TFDumpObjects.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveOptions;
end;

procedure TFDumpObjects.FormCreate(Sender: TObject);
begin
  lbProgress.Caption := '';
  RestoreOptions;
end;

procedure TFDumpObjects.FormDeactivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, false);
end;

procedure TFDumpObjects.FormShow(Sender: TObject);
begin
  pcMain.ActivePage := tsMain;
  cbScriptTypeChange(cbScriptType);
end;

procedure TFDumpObjects.GenDictSQL(Pk: integer; Script, Vars: TStringList);
begin

end;

procedure TFDumpObjects.GenFolderSQL(Pk: integer; refDescr: string; Script, Vars: TStringList);
var
  ds, dsRef: TpFIBDataSet;

begin
  try
    ds := FMain.OpenSQL('select PK, NAME, PARENT_FOLDER_PK from DYNAMIC_FORM_FOLDER where PK = ' + IntToStr(Pk));
    if ds.IsEmpty then exit;

    // если дочерний справочник передан - будем искать по нему

//    Script.Add('declare variable PK integer;');
//    Script.Add('declare variable FK_PARENT integer;');
//    Script.Add('begin');
//    Script.Add('  if (exists(select PK from DYNAMIC_FORM_FOLDER where NAME = ''' + ReplaceQuote(ds1.FieldByName('NAME').AsString) + ''' ' +
//      'and PARENT_FOLDER_PK ' + iif(ds1.FieldByName('PARENT_FOLDER_PK').IsNull, 'is null', '= :FK') + ')) then');
//    Script.Add('    select first 1 PK from DYNAMIC_FORM_FOLDER where NAME = ''' + ReplaceQuote(ds1.FieldByName('NAME').AsString) + ''' ' +
//      'and PARENT_FOLDER_PK ' + iif(ds1.FieldByName('PARENT_FOLDER_PK').IsNull, 'is null', '= :FK') + ' into :PK;');
//    Script.Add('  else');
//    Script.Add('    insert into DYNAMIC_FORM_FOLDER (NAME, PARENT_FOLDER_PK) values (''' + ReplaceQuote(ds1.FieldByName('NAME').AsString) +
//      ''', :FK) returning PK into :PK;');
//    Script.Add('  PARAMS = PARAMS || ''' + ds1.FieldByName('PK').AsString + ''' || '':'' || :PK || '','';');
//    Script.Add('  update or insert into TMP_VAR (VAR_NAME, VALUE_) values (''DYNAMIC_FORM_FOLDER'', :PARAMS) matching (VAR_NAME);');
//    Script.Add('  insert into DCFG_REF_LOG (OBJ_TYPE, REF_DESCRIPTOR, ACTION_, USER_PK, ACTION_DETAIL) values (0, ''' +
//      ReplaceQuote(ds1.FieldByName('NAME').AsString) + ''', 2, ' + dsPortalUserPK.AsString + ', ''PK '' || :PK);');
//    ds1.Close;
//    FreeAndNil(ds1);

    // теперь дочерние папки
    {ds1 := OpenSQL('select PK from DYNAMIC_FORM_FOLDER where PARENT_FOLDER_PK = ' + IntToStr(Pk) + ' order by PK');
    ds1.First;
    while not ds1.Eof do
    begin
      GenFolderSQL(ds1.FieldByName('PK').AsInteger, Script, Folders, false);
      ds1.Next;
    end;}
  finally
//    if Assigned(ds1) then
//    begin
//      ds1.Close;
//      ds1.Free;
//    end;
  end;
end;

procedure TFDumpObjects.GenFormSQL(Pk: integer; Script, Vars: TStringList);
begin

end;

procedure TFDumpObjects.GenSQL(Script, Vars: TStringList);
begin
  case FItem.ObjType of
    cotFolder: GenFolderSQL(FItem.PK, '', Script, Vars);
    cotDict: GenDictSQL(FItem.PK, Script, Vars);
    cotForm: GenFormSQL(FItem.PK, Script, Vars);
    cotWizard: GenWizardSQL(FItem.PK, Script, Vars);
  end;
end;

procedure TFDumpObjects.GenWizardSQL(Pk: integer; Script, Vars: TStringList);
begin

end;

function TFDumpObjects.GetObjectDescription: string;
var
  ot: string;

begin
  case FItem.ObjType of
    cotFolder: ot := 'Папка';
    cotDict: ot := 'Справочник';
    cotForm: ot := 'Форма';
    cotWizard: ot := 'Сценарий';
    else ot := '<Неожиданный тип объекта>';
  end;

  result := ot + ' - ' + VarToStr(FItem.PK) + iif(VarIsNull(FItem.Descriptor), '', ' : ' + FItem.Descriptor) + ' : ' + VarToStr(FItem.Title);
end;

procedure TFDumpObjects.RestoreOptions;
begin
  edScriptFile.FileName := FSettings.CmpScriptFile;
  cbScriptType.ItemIndex := FSettings.CmpType;
  chbRefOptions.Checked := FSettings.CmpRefOptions;
  chbDbObjects.Checked := FSettings.CmpDbObjects;
  chbMainForm.Checked := FSettings.CmpMainForm;
  chbStartForm.Checked := FSettings.CmpStartForm;
  chbGrEditForm.Checked := FSettings.CmpGrEditForm;
  chbRankPermissions.Checked := FSettings.CmpRankPermissions;
  chbRankPermRecreate.Checked := FSettings.CmpRankPermRecreate;
  chbRolePermissions.Checked := FSettings.CmpRolePermissions;
  chbRolePermRecreate.Checked := FSettings.CmpRolePermRecreate;
  chbFilterConfig.Checked := FSettings.CmpFilterConfig;
  chbFilterConfigBind.Checked := FSettings.CmpFilterConfigBind;
  chbFilterGroup.Checked := FSettings.CmpFilterGroup;
  chbCharts.Checked := FSettings.CmpCharts;
  chbChartGroups.Checked := FSettings.CmpChartGroups;
  chbOtherEvents.Checked := FSettings.CmpOtherEvents;
  chbWizard.Checked := FSettings.CmpWizards;
  chbFolders.Checked := FSettings.CmpFolders;
  chbFormParams.Checked := FSettings.CmpFormParams;
  chbFormFields.Checked := FSettings.CmpFormFields;
  chbFormFieldGroups.Checked := FSettings.CmpFormFieldGroups;
  chbStFormParams.Checked := FSettings.CmpStFormParams;
  chbStFormFields.Checked := FSettings.CmpStFormFields;
  chbStFormFieldGroups.Checked := FSettings.CmpStFormFieldGroups;
  chbGrFormParams.Checked := FSettings.CmpGrFormParams;
  chbGrFormFields.Checked := FSettings.CmpGrFormFields;
  chbGrFormFieldGroups.Checked := FSettings.CmpGrFormFieldGroups;
  chbScenParams.Checked := FSettings.CmpScenParams;
  chbScenStates.Checked := FSettings.CmpScenStates;
  chbFolderParams.Checked := FSettings.CmpFolderParams;

  chbRankPermissionsClick(chbRankPermissions);
  chbRolePermissionsClick(chbRolePermissions);
  chbFilterConfigClick(chbFilterConfig);
  chbChartsClick(chbCharts);
end;

procedure TFDumpObjects.SaveOptions;
begin
  FSettings.CmpScriptFile := edScriptFile.FileName;
  FSettings.CmpType := cbScriptType.ItemIndex;
  FSettings.CmpRefOptions := chbRefOptions.Checked;
  FSettings.CmpDbObjects := chbDbObjects.Checked;
  FSettings.CmpMainForm := chbMainForm.Checked;
  FSettings.CmpStartForm := chbStartForm.Checked;
  FSettings.CmpGrEditForm := chbGrEditForm.Checked;
  FSettings.CmpRankPermissions := chbRankPermissions.Checked;
  FSettings.CmpRankPermRecreate := chbRankPermRecreate.Checked;
  FSettings.CmpRolePermissions := chbRolePermissions.Checked;
  FSettings.CmpRolePermRecreate := chbRolePermRecreate.Checked;
  FSettings.CmpFilterConfig := chbFilterConfig.Checked;
  FSettings.CmpFilterConfigBind := chbFilterConfigBind.Checked;
  FSettings.CmpFilterGroup := chbFilterGroup.Checked;
  FSettings.CmpCharts := chbCharts.Checked;
  FSettings.CmpChartGroups := chbChartGroups.Checked;
  FSettings.CmpOtherEvents := chbOtherEvents.Checked;
  FSettings.CmpWizards := chbWizard.Checked;
  FSettings.CmpFolders := chbFolders.Checked;
  FSettings.CmpFormParams := chbFormParams.Checked;
  FSettings.CmpFormFields := chbFormFields.Checked;
  FSettings.CmpFormFieldGroups := chbFormFieldGroups.Checked;
  FSettings.CmpStFormParams := chbStFormParams.Checked;
  FSettings.CmpStFormFields := chbStFormFields.Checked;
  FSettings.CmpStFormFieldGroups := chbStFormFieldGroups.Checked;
  FSettings.CmpGrFormParams := chbGrFormParams.Checked;
  FSettings.CmpGrFormFields := chbGrFormFields.Checked;
  FSettings.CmpGrFormFieldGroups := chbGrFormFieldGroups.Checked;
  FSettings.CmpScenParams := chbScenParams.Checked;
  FSettings.CmpScenStates := chbScenStates.Checked;
  FSettings.CmpFolderParams := chbFolderParams.Checked;
end;

procedure TFDumpObjects.SetItem(const Value: TNodeDictInfo);
begin
  FItem := Value;
  lbDescription.Caption := GetObjectDescription;
end;

procedure TFDumpObjects.SetProgressText(msg: string);
begin
  lbProgress.Caption := msg;
  Application.ProcessMessages;
end;

procedure TFDumpObjects.WriteSQLFooter(Script: TStringList);
begin
  Script.Add('end^');
  Script.Add('');
  Script.Add('commit^');
end;

procedure TFDumpObjects.WriteSQLHeader(Script: TStringList; NoBlocks: boolean);
begin
  Script.Add('/*');
  Script.Add('  Script generated by Dict Configurator, Ver.: ' + GetVersion(Application.ExeName));
  Script.Add('');
  Script.Add('  Объект:      ' + GetObjectDescription);
  Script.Add('  Правило:     ' + cbScriptType.Text);
  Script.Add('*/');
  Script.Add('');
  if NoBlocks then exit;
  Script.Add('set term ^ ;');
  Script.Add('');
  Script.Add('execute block');
  Script.Add('as');
end;

end.
