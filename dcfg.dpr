program dcfg;

uses
  Forms,
  Windows,
  SysUtils,
  ShellAPI,
  main in 'src\main.pas' {FMain},
  utils in 'src\utils.pas',
  settings in 'src\settings.pas' {FSettings},
  UserInfo in 'src\UserInfo.pas' {FUserInfo},
  connect in 'src\connect.pas' {FConnect},
  selObject in 'src\selObject.pas' {FSelObject},
  editFolder in 'src\editFolder.pas' {FEditFolder},
  editForm in 'src\editForm.pas' {FEditForm},
  groupEditor in 'src\groupEditor.pas' {FGroupEditor},
  fieldEditor in 'src\fieldEditor.pas' {FFieldEditor},
  optControls in 'src\optControls.pas',
  editDict in 'src\editDict.pas' {FEditDict},
  objectEditor in 'src\objectEditor.pas' {FObjectEditor},
  dbUtils in 'src\dbUtils.pas',
  fmEditForm in 'src\fmEditForm.pas' {frmEditForm: TFrame},
  groupedit in 'src\groupedit.pas' {FGroupEdit},
  selectRank in 'src\selectRank.pas' {FSelectRank},
  chartEditor in 'src\chartEditor.pas' {FChartEditor},
  find in 'src\find.pas' {FindDialog},
  previewForm in 'src\previewForm.pas' {FPreviewForm},
  editWizard in 'src\editWizard.pas' {FEditWizard},
  stateEditor in 'src\stateEditor.pas' {FStateEditor},
  crossEditor in 'src\crossEditor.pas' {FCrossEditor},
  slotEditor in 'src\slotEditor.pas' {FSlotEditor},
  slotValEditor in 'src\slotValEditor.pas' {FSlotValEditor},
  chartGroupEditor in 'src\chartGroupEditor.pas' {FChartGroupEditor},
  updates in 'src\updates.pas' {FUpdates},
  childForm in 'src\childForm.pas',
  selUser in 'src\selUser.pas' {FSelUser},
  users in 'src\users.pas' {FUsers},
  filter in 'src\filter.pas' {fFilter},
  gridsettings in 'src\gridsettings.pas' {FGridSettings},
  groups in 'src\groups.pas' {FGroups},
  addRank in 'src\addRank.pas' {FAddRank},
  tmplConstructor in 'src\tmplConstructor.pas' {FTmplConstructor},
  field in 'src\field.pas',
  copyRanks in 'src\copyRanks.pas' {FCopyRanks},
  fixRef in 'src\fixRef.pas' {FFixReference},
  json in 'src\json.pas',
  jsonReader in 'src\jsonReader.pas' {FJsonReader},
  filterConfigEditor in 'src\filterConfigEditor.pas' {FFilterConfigEditor},
  hintView in 'src\hintView.pas' {FHint},
  task in 'src\task.pas' {FTask},
  refList in 'src\refList.pas' {FRefList},
  crStat in 'src\crStat.pas' {FCrStat},
  ensTask in 'src\ensTask.pas' {FEnsTask},
  ensTaskEditor in 'src\ensTaskEditor.pas' {FEnsTaskEditor},
  groupAction in 'src\groupAction.pas' {FGroupAction},
  eventEditor in 'src\eventEditor.pas' {FEventEditor},
  userEditor in 'src\userEditor.pas' {FUserEditor},
  filterGroupEditor in 'src\filterGroupEditor.pas' {FFilterGroupEditor},
  dbFind in 'src\dbFind.pas' {DBFindDialog},
  ensFolder in 'src\ensFolder.pas' {FEditEnsFolder},
  history in 'src\history.pas' {FHistory},
  tmplEditor in 'src\tmplEditor.pas' {FTmplEditor},
  scriptEditor in 'src\scriptEditor.pas' {FScriptEditor};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Конфигуратор справочников';
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
