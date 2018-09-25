unit crStat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, utils, settings, childForm, main,
  ActnList, ToolWin, ComCtrls, DBGridEhGrouping, GridsEh, DBGridEh, DB, FIBDataSet, pFIBDataSet, ExtCtrls, Menus,
  StdCtrls, ImgList, Buttons, DateUtils, MemTableDataEh, MemTableEh;

type
  TFCrStat = class(TChildForm)
    ActionList: TActionList;
    AClose: TAction;
    AGridOptions: TAction;
    ToolBar: TToolBar;
    dbgCrTask: TDBGridEh;
    dsCrTask: TpFIBDataSet;
    dsoCrTask: TDataSource;
    pmGrid: TPopupMenu;
    MenuItem1: TMenuItem;
    ARefresh: TAction;
    ToolButton7: TToolButton;
    dsCrTaskNUM: TFIBIntegerField;
    dsCrTaskNAME: TFIBStringField;
    dsCrTaskAVG_EVALUATE: TFIBBCDField;
    dsCrTaskDIFF_PLAN_FACT: TFIBFloatField;
    dsCrTaskHOURS: TFIBFloatField;
    dsCrTaskCNT_REQ: TFIBIntegerField;
    dsWorkTime: TpFIBDataSet;
    dsWorkTimeHOURS: TFIBFloatField;
    edDateFrom: TDateTimePicker;
    edDateTo: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    ToolButton1: TToolButton;
    dsCrTaskCNT_PROJ: TFIBIntegerField;
    mtCrTask: TMemTableEh;
    mtCrTaskNUM: TIntegerField;
    mtCrTaskNAME: TStringField;
    mtCrTaskAVG_EVALUATE: TIntegerField;
    mtCrTaskDIFF_PLAN_FACT: TFloatField;
    mtCrTaskHOURS: TIntegerField;
    mtCrTaskCNT_REQ: TIntegerField;
    mtCrTaskCNT_PROJ: TIntegerField;
    mtCrTaskOVERDUE: TIntegerField;
    dsCrTaskOVERDUE: TFIBBCDField;
    dsOverdueReq: TpFIBDataSet;
    dsOverdueReqCNT: TFIBIntegerField;
    dsOverdueReqPROJECT: TFIBIntegerField;
    dsCrTaskPROJ_PK: TFIBIntegerField;
    mtCrTaskPROJ_PK: TIntegerField;
    AExportToExcel: TAction;
    AExportToCsv: TAction;
    Excel1: TMenuItem;
    csv1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure ACloseExecute(Sender: TObject);
    procedure AGridOptionsExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ARefreshExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgCrTaskGetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure AExportToExcelExecute(Sender: TObject);
    procedure AExportToCsvExecute(Sender: TObject);
  private
    procedure LoadData;
    procedure SetMode(Value: TOpenMode); override;
  public
  end;

implementation

{$R *.dfm}

procedure TFCrStat.ACloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFCrStat.AExportToCsvExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToCsv(TDBGridEh(ActiveControl), Caption);
end;

procedure TFCrStat.AExportToExcelExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FMain.ExportToExcel(TDBGridEh(ActiveControl), Caption);
end;

procedure TFCrStat.AGridOptionsExecute(Sender: TObject);
begin
  if Assigned(ActiveControl) and (ActiveControl is TDBGridEh) then
    FSettings.GridParamsDialog(TDBGridEh(ActiveControl), ClassName);
end;

procedure TFCrStat.ARefreshExecute(Sender: TObject);
begin
  LoadData;
end;

procedure TFCrStat.dbgCrTaskGetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
begin
  if mtCrTaskNUM.AsInteger = 2 then
    Background := RGB(247, 247, 247)
  else begin
    if mtCrTaskNUM.AsInteger = 1 then Background := RGB(234, 255, 255);

    if (Column.FieldName = 'AVG_EVALUATE') then
    begin
      if (mtCrTaskAVG_EVALUATE.AsInteger < 2) then
        Background := clRed
      else if (mtCrTaskAVG_EVALUATE.AsInteger >= 2) and (mtCrTaskAVG_EVALUATE.AsInteger < 6) then
        Background := FSettings.GridOptions.ChangedRowColor
      else if (mtCrTaskAVG_EVALUATE.AsInteger >= 6) and (mtCrTaskAVG_EVALUATE.AsInteger < 9) then
        Background := FSettings.GridOptions.NewRowColor;
    end else if (Column.FieldName = 'DIFF_PLAN_FACT')then
    begin
      if (mtCrTaskDIFF_PLAN_FACT.AsFloat >= 0.6) then
        Background := FSettings.GridOptions.ChangedRowColor
      else if (mtCrTaskDIFF_PLAN_FACT.AsFloat >= 0.2) and (mtCrTaskDIFF_PLAN_FACT.AsFloat < 0.6) then
        Background := FSettings.GridOptions.NewRowColor;
    end else if (Column.FieldName = 'HOURS') and (mtCrTaskNUM.AsInteger = 1) then
    begin
      if dsWorkTime.Active and (not dsWorkTime.IsEmpty) and (mtCrTaskHOURS.AsInteger < dsWorkTimeHOURS.AsInteger) then
        Background := FSettings.GridOptions.ChangedRowColor;
    end else if (Column.FieldName = 'CNT_REQ') and (mtCrTaskNUM.AsInteger = 1) then
    begin
      if (mtCrTaskCNT_REQ.AsInteger < 35) then
        Background := clRed
      else if (mtCrTaskCNT_REQ.AsInteger >= 35) and (mtCrTaskCNT_REQ.AsInteger <= 45) then
        Background := FSettings.GridOptions.ChangedRowColor
      else if (mtCrTaskCNT_REQ.AsInteger >= 46) and (mtCrTaskCNT_REQ.AsInteger <= 71) then
        Background := FSettings.GridOptions.NewRowColor;
    end else if (Column.FieldName = 'OVERDUE') and (mtCrTaskOVERDUE.AsInteger > 0) then
      Background := FSettings.GridOptions.ChangedRowColor
    else if (Column.FieldName = 'CNT_PROJ') and (mtCrTaskNUM.AsInteger = 1) then
    begin
      if (mtCrTaskCNT_PROJ.AsInteger <= 1) then
        Background := clRed
      else if (mtCrTaskCNT_PROJ.AsInteger > 1) and (mtCrTaskCNT_PROJ.AsInteger <= 3) then
        Background := FSettings.GridOptions.ChangedRowColor
      else if (mtCrTaskCNT_PROJ.AsInteger > 3) and (mtCrTaskCNT_PROJ.AsInteger <= 5) then
        Background := FSettings.GridOptions.NewRowColor;
    end;
  end;
end;

procedure TFCrStat.FormActivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, true);
  FMain.CheckFormButton(Tag);
end;

procedure TFCrStat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FSettings.ChildMaximized := WindowState = wsMaximized;
end;

procedure TFCrStat.FormDeactivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, false);
end;

procedure TFCrStat.FormDestroy(Sender: TObject);
begin
  dsCrTask.Close;
  dsWorkTime.Close;
  dsOverdueReq.Close;
end;

procedure TFCrStat.FormShow(Sender: TObject);
begin
  edDateFrom.DateTime := StartOfTheMonth(Now);
  edDateTo.DateTime := EndOfTheMonth(Now);
  LoadData;
end;

procedure TFCrStat.LoadData;
var
  i: integer;

begin
  Screen.Cursor := crSQLWait;
  try
    if mtCrTask.Active then
    begin
      mtCrTask.EmptyTable;
      mtCrTask.Close;
    end;
    mtCrTask.CreateDataSet;
    
    if dsOverdueReq.Active then dsOverdueReq.Close;
    try
      dsOverdueReq.ParamByName('USER_PK').AsVariant := FMain.dsPortalUserPK.AsVariant;
      dsOverdueReq.Open;
    except
    end;

    if dsWorkTime.Active then dsWorkTime.Close;
    try
      dsWorkTime.ParamByName('DATEBEGIN').AsDate := edDateFrom.Date;
      dsWorkTime.ParamByName('USER_PK').AsVariant := FMain.dsPortalUserPK.AsVariant;
      dsWorkTime.Open;
    except
    end;

    // если табель не посчитан - то явно что-то не так, оставляем все пустым 
    if dsWorkTime.IsEmpty then exit;

    if dsCrTask.Active then dsCrTask.Close;
    dsCrTask.ParamByName('DATEBEGIN').AsDate := edDateFrom.Date;
    dsCrTask.ParamByName('DATEEND').AsDate := IncDay(edDateTo.Date, 1);
    dsCrTask.ParamByName('USER_PK').AsVariant := FMain.dsPortalUserPK.AsVariant;
    dsCrTask.Open;
    dsCrTask.First;

    while not dsCrTask.Eof do
    begin
      mtCrTask.Append;

      for i := 0 to mtCrTask.Fields.Count - 1 do
      begin
        if (mtCrTask.Fields.Fields[i].FieldName = 'OVERDUE') and (dsCrTaskNUM.AsInteger = 0) then
        begin
          if dsOverdueReq.Active and dsOverdueReq.Locate('PROJECT', dsCrTaskPROJ_PK.Value, []) then
            mtCrTask.Fields.Fields[i].Value := dsOverdueReqCNT.AsVariant
          else
            mtCrTask.Fields.Fields[i].Value := 0;
        end else
          mtCrTask.Fields.Fields[i].Value := dsCrTask.FieldByName(mtCrTask.Fields.Fields[i].FieldName).Value;
      end;

      mtCrTask.Post;
      dsCrTask.Next;
    end;
    dsCrTask.Close;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFCrStat.SetMode(Value: TOpenMode);
begin
  if Value = omAdd then Value := omEdit;
  inherited SetMode(Value);
end;

end.
