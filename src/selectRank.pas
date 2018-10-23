unit selectRank;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, DBGridEhGrouping,
  MemTableDataEh, Db, MemTableEh, GridsEh, DBGridEh, FIBDataSet, pFIBDataSet, Buttons, main, utils, settings, StdCtrls,
  EhLibMTE, EhLibFIB, Mask, DBCtrlsEh, DBLookupEh, ActnList, Menus, dbFind;

type
  TFSelectRank = class(TForm)
    mtSelectedRanks: TMemTableEh;
    mtSelectedRanksPK: TIntegerField;
    dsoSelectedRanks: TDataSource;
    dsUnitStruct: TpFIBDataSet;
    mtSelectedRanksNAME: TStringField;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    dbgSelectedRanks: TDBGridEh;
    sbAdd: TSpeedButton;
    sbAddAll: TSpeedButton;
    sbDel: TSpeedButton;
    sbDelAll: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    dbgUnitStruct: TDBGridEh;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    dsoUnitStruct: TDataSource;
    Label3: TLabel;
    lcbDepartment: TDBLookupComboboxEh;
    Label4: TLabel;
    lcbService: TDBLookupComboboxEh;
    Label5: TLabel;
    lcbDivision: TDBLookupComboboxEh;
    Label6: TLabel;
    lcbSector: TDBLookupComboboxEh;
    btnApplyFilter: TBitBtn;
    btnClearFilter: TBitBtn;
    dsDepartment: TpFIBDataSet;
    dsoDepartment: TDataSource;
    dsDepartmentNAME: TFIBStringField;
    dsService: TpFIBDataSet;
    FIBStringField1: TFIBStringField;
    dsoService: TDataSource;
    dsDivision: TpFIBDataSet;
    FIBStringField2: TFIBStringField;
    dsoDivision: TDataSource;
    dsSector: TpFIBDataSet;
    FIBStringField3: TFIBStringField;
    dsoSector: TDataSource;
    dsUser: TpFIBDataSet;
    dsoUser: TDataSource;
    dsUserPK: TFIBIntegerField;
    dsUserNAME: TFIBStringField;
    lcbUser: TDBLookupComboboxEh;
    Label7: TLabel;
    chbUserMainRole: TCheckBox;
    Label8: TLabel;
    cbConcatStr: TComboBox;
    dsGetUserRanks: TpFIBDataSet;
    dsGetUserRanksPK: TFIBIntegerField;
    dsGetUserRanksLOGIN: TFIBStringField;
    dsGetUserRanksUSER_NAME: TFIBStringField;
    dsGetUserRanksROLE_PK: TFIBIntegerField;
    dsGetUserRanksROLE_NAME: TFIBStringField;
    dsGetUserRanksBRANCH_PK: TFIBIntegerField;
    dsGetUserRanksBRANCH_NAME: TFIBStringField;
    dsGetUserRanksFULLNAME: TFIBStringField;
    dsGetUserRanksMAIN_ROLE: TFIBStringField;
    ActionList: TActionList;
    ASave: TAction;
    AClose: TAction;
    AFilter: TAction;
    dsUnitStructPK: TFIBIntegerField;
    dsUnitStructNAME: TFIBStringField;
    dsUnitStructDEPARTMENT: TFIBStringField;
    dsUnitStructOFFICE: TFIBStringField;
    dsUnitStructCHAPTER: TFIBStringField;
    dsUnitStructSECTOR: TFIBStringField;
    AGridOptions: TAction;
    pmGrid: TPopupMenu;
    N1: TMenuItem;
    AExportToExcel: TAction;
    AExportToCsv: TAction;
    Excel1: TMenuItem;
    csv1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbAddClick(Sender: TObject);
    procedure sbAddAllClick(Sender: TObject);
    procedure sbDelClick(Sender: TObject);
    procedure sbDelAllClick(Sender: TObject);
    procedure dbgUnitStructKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure mtSelectedRanksBeforeDelete(DataSet: TDataSet);
    procedure dbgUnitStructDblClick(Sender: TObject);
    procedure dbgSelectedRanksDblClick(Sender: TObject);
    procedure btnClearFilterClick(Sender: TObject);
    procedure btnApplyFilterClick(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure ACloseExecute(Sender: TObject);
    procedure AFilterExecute(Sender: TObject);
    procedure AGridOptionsExecute(Sender: TObject);
    procedure dbgUnitStructKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AExportToExcelExecute(Sender: TObject);
    procedure AExportToCsvExecute(Sender: TObject);
  private
    r_ok: boolean;
    SelPkList: TStringList;
    procedure AddSelected;
    procedure DelSelected;
    procedure SaveGridsParams;
    procedure Find(Grid: TDBGridEh; AContinue: boolean = false);
  public
    procedure SetGridsOptions(Options: TGridParams);
  end;

implementation

{$R *.dfm}

procedure TFSelectRank.ACloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFSelectRank.AddSelected;
var
  i: integer;
  bm: TBookmark;
  
begin
  if (not dsUnitStruct.Active) or dsUnitStruct.IsEmpty then exit;

  bm := dsUnitStruct.GetBookmark;
  dsUnitStruct.DisableControls;
  mtSelectedRanks.DisableControls;
  try
    if dbgUnitStruct.SelectedRows.Count = 0 then dbgUnitStruct.SelectedRows.AppendItem(dsUnitStruct.Bookmark);

    for i := 0 to dbgUnitStruct.SelectedRows.Count - 1 do
    begin
      if dsUnitStruct.BookmarkValid(TBookmark(dbgUnitStruct.SelectedRows.Items[i])) then
      begin
        dsUnitStruct.GotoBookmark(TBookmark(dbgUnitStruct.SelectedRows.Items[i]));
        if SelPkList.IndexOf(dsUnitStructPK.AsString) = -1 then
        begin
          mtSelectedRanks.Append;
          mtSelectedRanksPK.AsInteger := dsUnitStructPK.AsInteger;
          mtSelectedRanksNAME.AsString := dsUnitStructNAME.AsString;
          mtSelectedRanks.Post;
          SelPkList.Add(dsUnitStructPK.AsString);
        end;
      end;
    end;

    dbgUnitStruct.SelectedRows.Clear;
  finally
    mtSelectedRanks.EnableControls;
    if dsUnitStruct.BookmarkValid(bm) then dsUnitStruct.GotoBookmark(bm);
    dsUnitStruct.EnableControls;
  end;
end;

procedure TFSelectRank.AExportToCsvExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToCsv(TDBGridEh(ActiveControl), Caption);
end;

procedure TFSelectRank.AExportToExcelExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToExcel(TDBGridEh(ActiveControl), Caption);
end;

procedure TFSelectRank.AFilterExecute(Sender: TObject);
begin
  if dsUnitStruct.Filtered then btnClearFilterClick(btnClearFilter)
  else btnApplyFilterClick(btnApplyFilter);
end;

procedure TFSelectRank.AGridOptionsExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FSettings.GridParamsDialog(TDBGridEh(ActiveControl), ClassName);
end;

procedure TFSelectRank.ASaveExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then
  begin
    r_ok := true;
    Close;
  end;
end;

procedure TFSelectRank.btnApplyFilterClick(Sender: TObject);
var
  str, s: string;

begin
  if lcbDepartment.Text <> '' then str := 'DEPARTMENT like ''%' + lcbDepartment.Text + '%''';
  if lcbService.Text <> '' then str := iif(str = '', '', str + ' ' + cbConcatStr.Text + ' ') + 'OFFICE like ''%' + lcbService.Text + '%''';
  if lcbDivision.Text <> '' then str := iif(str = '', '', str + ' ' + cbConcatStr.Text + ' ') + 'CHAPTER like ''%' + lcbDivision.Text + '%''';
  if lcbSector.Text <> '' then str := iif(str = '', '', str + ' ' + cbConcatStr.Text + ' ') + 'SECTOR like ''%' + lcbSector.Text + '%''';

  if not VarIsNull(lcbUser.KeyValue) then
  begin
    try
      dsGetUserRanks.Close;
      dsGetUserRanks.ParamByName('PK').Value := lcbUser.KeyValue;
      dsGetUserRanks.Open;
      dsGetUserRanks.First;
      while not dsGetUserRanks.Eof do
      begin
        if (chbUserMainRole.Checked and (dsGetUserRanksMAIN_ROLE.AsString = '1')) or (not chbUserMainRole.Checked) then
          s := iif(s = '', '(', s + ' or ') + 'PK = ' + dsGetUserRanksROLE_PK.AsString;
        dsGetUserRanks.Next;
      end;
    except
    end;
    dsGetUserRanks.Close;
    if s <> '' then str := iif(str = '', '', str + ' ' + cbConcatStr.Text + ' ') + s + ')';
  end;

  dsUnitStruct.Filter := str;
  dsUnitStruct.Filtered := str <> '';
  dbgUnitStruct.SelectedRows.Clear;
end;

procedure TFSelectRank.btnClearFilterClick(Sender: TObject);
begin
  dsUnitStruct.Filtered := false;
  dsUnitStruct.Filter := '';
  dbgUnitStruct.SelectedRows.Clear;
end;

procedure TFSelectRank.dbgSelectedRanksDblClick(Sender: TObject);
begin
  //sbDelClick(sbDel);
end;

procedure TFSelectRank.dbgUnitStructDblClick(Sender: TObject);
begin
  //sbAddClick(sbAdd);
end;

procedure TFSelectRank.dbgUnitStructKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_INSERT: if (Sender = dbgUnitStruct) and (not (ssShift in Shift)) and (not (ssCtrl in Shift)) then sbAddClick(sbAdd);
    VK_F3: Find(TDBGridEh(Sender), true);
    else begin
      if (ssCtrl in Shift) and ((Key = Ord('A')) or (Key = Ord('a')) or (Key = Ord('Ф')) or (Key = Ord('ф'))) then
        TDBGridEh(Sender).SelectedRows.SelectAll;
      if (ssCtrl in Shift) and ((Key = Ord('F')) or (Key = Ord('f')) or (Key = Ord('А')) or (Key = Ord('а'))) then
        Find(TDBGridEh(Sender));
    end;
  end;
end;

procedure TFSelectRank.dbgUnitStructKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_F12) and (ssShift in Shift) and (ssCtrl in Shift) then TDBGridEh(Sender).OptimizeAllColsWidth;
end;

procedure TFSelectRank.DelSelected;
begin
  if (not mtSelectedRanks.Active) or mtSelectedRanks.IsEmpty then exit;

  if dbgSelectedRanks.SelectedRows.Count = 0 then dbgSelectedRanks.SelectedRows.AppendItem(mtSelectedRanks.Bookmark);
  dbgSelectedRanks.SelectedRows.Delete;
end;

procedure TFSelectRank.Find(Grid: TDBGridEh; AContinue: boolean);
var
  FindOptions: TFindOptions;
  col: TColumnEh;
  defCol: string;

begin
  if (not Assigned(Grid)) then exit;

  if (not AContinue) or (DBFindDialog.cbFindText.Text = '') then
  begin
    // если новый, то показать диалог
    if Assigned(Grid.SelectedField) then col := Grid.FindFieldColumn(Grid.SelectedField.FieldName);
    if Assigned(col) then defCol := col.Title.Caption;
    if DBFindDialog.ShowDialog(Grid, defCol) <> mrOk then exit;
  end;

  FindOptions := [];
  if DBFindDialog.chbMatchCase.Checked then FindOptions := [foMatchCase];
  if DBFindDialog.chbToExistence.Checked then FindOptions := FindOptions + [foToExistence];
  if DBFindDialog.rbWholeString.Checked then FindOptions := FindOptions + [foWholeString];
  if DBFindDialog.rbAnyWord.Checked then FindOptions := FindOptions + [foAnyWord];
  if DBFindDialog.rbAllWords.Checked then FindOptions := FindOptions + [foAllWords];

  FindInGrid(Grid, DBFindDialog.cbFindText.Text, DBFindDialog.SelectedField, FindOptions, AContinue);
end;

procedure TFSelectRank.FormActivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, true);
end;

procedure TFSelectRank.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
  if r_ok then ModalResult := mrOk;
end;

procedure TFSelectRank.FormCreate(Sender: TObject);
begin
  SelPkList := TStringList.Create;
  
  if mtSelectedRanks.Active then
  begin
    mtSelectedRanks.EmptyTable;
    mtSelectedRanks.Close;
  end;
  mtSelectedRanks.CreateDataSet;

  SetGridsOptions(FSettings.GridOptions);
end;

procedure TFSelectRank.FormDeactivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, false);
end;

procedure TFSelectRank.FormDestroy(Sender: TObject);
begin
  SaveGridsParams;
  SelPkList.Free;
end;

procedure TFSelectRank.FormShow(Sender: TObject);
begin
  dsUnitStruct.Open;
  dsDepartment.Open;
  dsService.Open;
  dsDivision.Open;
  dsSector.Open;
  dsUser.Open;
end;

procedure TFSelectRank.mtSelectedRanksBeforeDelete(DataSet: TDataSet);
begin                       
  if SelPkList.IndexOf(mtSelectedRanksPK.AsString) > -1 then SelPkList.Delete(SelPkList.IndexOf(mtSelectedRanksPK.AsString));
end;

procedure TFSelectRank.SaveGridsParams;
var
  i: integer;

begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TDBGridEh then FSettings.SaveGridParams(TDBGridEh(Components[i]), ClassName);
end;

procedure TFSelectRank.sbAddAllClick(Sender: TObject);
begin
  dbgUnitStruct.SelectedRows.SelectAll;
  AddSelected;
end;

procedure TFSelectRank.sbAddClick(Sender: TObject);
begin
  AddSelected;
end;

procedure TFSelectRank.sbDelAllClick(Sender: TObject);
begin
  dbgSelectedRanks.SelectedRows.SelectAll;
  DelSelected;
end;

procedure TFSelectRank.sbDelClick(Sender: TObject);
begin
  DelSelected;
end;

procedure TFSelectRank.SetGridsOptions(Options: TGridParams);
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
