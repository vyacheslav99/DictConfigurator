unit refList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, main, settings, utils, DB,
  FIBDataSet, pFIBDataSet, DBGridEhGrouping, GridsEh, DBGridEh, StdCtrls, Buttons, ActnList, Menus;

type
  TFRefList = class(TForm)
    dsRefList: TpFIBDataSet;
    dsoRefList: TDataSource;
    dsRefListPK: TFIBIntegerField;
    dsRefListDESCRIPTOR_: TFIBStringField;
    dsRefListTITLE: TFIBStringField;
    dsRefListBASE_DESCRIPTOR: TFIBStringField;
    dsRefListMAIN_OBJECT: TFIBIntegerField;
    dsRefListFOLDER: TFIBStringField;
    dsRefListLOGIN: TFIBStringField;
    dsRefListUSER_NAME: TFIBStringField;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    dbgRefList: TDBGridEh;
    ActionList: TActionList;
    AClose: TAction;
    AGridOptions: TAction;
    pmGrid: TPopupMenu;
    N1: TMenuItem;
    AGo: TAction;
    AClose2: TAction;
    btnOpenAll: TButton;
    AOpenAll: TAction;
    AExportToExcel: TAction;
    AExportToCsv: TAction;
    Excel1: TMenuItem;
    csv1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure ACloseExecute(Sender: TObject);
    procedure AGridOptionsExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure dbgRefListKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgRefListDblClick(Sender: TObject);
    procedure AGoExecute(Sender: TObject);
    procedure btnOpenAllClick(Sender: TObject);
    procedure AOpenAllExecute(Sender: TObject);
    procedure AExportToExcelExecute(Sender: TObject);
    procedure AExportToCsvExecute(Sender: TObject);
  private
    r_ok: boolean;
    procedure SaveGridsParams;
  public
    OpenAll: boolean;
    procedure SetGridsOptions(Options: TGridParams);
    function Execute(FindStr: string; FindOptions: TFindOptions): boolean;
  end;

implementation

{$R *.dfm}

{ TFRefList }

procedure TFRefList.ACloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFRefList.AExportToCsvExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToCsv(TDBGridEh(ActiveControl), Caption);
end;

procedure TFRefList.AExportToExcelExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToExcel(TDBGridEh(ActiveControl), Caption);
end;

procedure TFRefList.AGoExecute(Sender: TObject);
begin
  r_ok := true;
  Close;
end;

procedure TFRefList.AGridOptionsExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FSettings.GridParamsDialog(TDBGridEh(ActiveControl), ClassName);
end;

procedure TFRefList.AOpenAllExecute(Sender: TObject);
begin
  btnOpenAllClick(btnOpenAll);
end;

procedure TFRefList.btnOpenAllClick(Sender: TObject);
begin
  if dsRefList.Active and (dsRefList.RecordCount > 10) then
  begin
    Application.MessageBox('Вы хотите слишком много! Не лучше ли уточнить условия поиска?', 'Предупреждение', MB_OK + MB_ICONWARNING);
    exit;
  end;

  OpenAll := true;
  r_ok := true;
  Close;
end;

procedure TFRefList.dbgRefListDblClick(Sender: TObject);
begin
  r_ok := true;
  Close;
end;

procedure TFRefList.dbgRefListKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_F12) and (ssShift in Shift) and (ssCtrl in Shift) then TDBGridEh(Sender).OptimizeAllColsWidth;
end;

function TFRefList.Execute(FindStr: string; FindOptions: TFindOptions): boolean;
const
  sql = 'select r.PK, r.DESCRIPTOR_, r.TITLE, r.BASE_DESCRIPTOR, ' +
    '(case when ((o.JOIN_PARENT_PK is null) or (o.JOIN_PARENT_PK is not null and o.IS_MULTI_JOIN = ''1'')) then 1 else 0 end) MAIN_OBJECT, ' +
    'd.NAME FOLDER, u.LOGIN, u.NAME USER_NAME ' +
    'from DYNAMIC_FORM_OBJECT_TREE o ' +
    'join DYNAMIC_FORM_REFERENCE r on r.MAIN_FORM_PK = o.FORM_PK ' +
    'join USERS u on u.PK = r.OWNER_USER_PK ' +
    'left join DYNAMIC_FORM_FOLDER d on d.PK = r.FOLDER_PK ' +
    'where %s ' +
    'order by r.DESCRIPTOR_';

var
  str: string;

begin
  result := false;

  if foMatchCase in FindOptions then
    str := 'o.NAME'
  else begin
    str := 'lower(o.NAME)';
    FindStr := AnsiLowerCase(FindStr);
  end;

  if foToExistence in FindOptions then str := str + ' like ''%' + FindStr + '%'''
  else str := str + ' = ''' + FindStr + '''';

  dsRefList.Close;
  dsRefList.SQLs.SelectSQL.Text := Format(sql, [str]);
  dsRefList.Open;

  if ShowModal = mrOk then result := true;
end;

procedure TFRefList.FormActivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, true);
end;

procedure TFRefList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
  if r_ok then ModalResult := mrOk;
end;

procedure TFRefList.FormCreate(Sender: TObject);
begin
  SetGridsOptions(FSettings.GridOptions);
end;

procedure TFRefList.FormDeactivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, false);
end;

procedure TFRefList.FormDestroy(Sender: TObject);
begin
  dsRefList.Close;
  SaveGridsParams;
end;

procedure TFRefList.SaveGridsParams;
var
  i: integer;

begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TDBGridEh then FSettings.SaveGridParams(TDBGridEh(Components[i]), ClassName);
end;

procedure TFRefList.SetGridsOptions(Options: TGridParams);
var
  i: integer;

begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TDBGridEh then
    begin
      Options.AssignTo(TDBGridEh(Components[i]));
      FSettings.LoadGridParams(TDBGridEh(Components[i]), ClassName);
    end;
end;

end.
