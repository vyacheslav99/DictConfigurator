unit groupEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Spin,
  DB, DBGridEh, Mask, DBCtrlsEh, DBLookupEh, MemTableDataEh, MemTableEh, DBGridEhGrouping, GridsEh, utils, ActnList, main,
  childForm;

type
  TFGroupEditor = class(TChildForm)
    GroupBox1: TGroupBox;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    Label2: TLabel;
    edPk: TEdit;
    Label4: TLabel;
    edTitle: TEdit;
    Label1: TLabel;
    edOrder: TSpinEdit;
    Bevel1: TBevel;
    chbIsVisible: TCheckBox;
    chbAddVisible: TCheckBox;
    chbCollapsed: TCheckBox;
    dsoParentGroup: TDataSource;
    cbParentGroup: TDBLookupComboboxEh;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edCountColumn: TSpinEdit;
    Label7: TLabel;
    mStyleExternal: TMemo;
    Label8: TLabel;
    mStyleInternal: TMemo;
    gbStyleColumns: TGroupBox;
    Label9: TLabel;
    mDescription: TMemo;
    Bevel2: TBevel;
    mtStyleColumns: TMemTableEh;
    mtStyleColumnsCOLUMN_: TIntegerField;
    mtStyleColumnsSTYLE: TStringField;
    dsoStyleColumns: TDataSource;
    dbgStyleColumns: TDBGridEh;
    edColumn: TSpinEdit;
    ActionList: TActionList;
    ASave: TAction;
    chbLeftAlign: TCheckBox;
    Label30: TLabel;
    edLabelWidth: TDBNumberEditEh;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edCountColumnChange(Sender: TObject);
    procedure cbParentGroupChange(Sender: TObject);
    procedure edColumnChange(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    procedure RefreshColStyles;
    procedure SetMode(Value: TOpenMode); override;
  public
    EditingRec: TBookmark;
    procedure RegisterForm;
    function GetShortCaption: string; override;
  end;

implementation

{$R *.dfm}

procedure TFGroupEditor.ASaveExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then btnSaveClick(btnSave);
end;

procedure TFGroupEditor.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFGroupEditor.btnSaveClick(Sender: TObject);
begin
  if Mode = omView then exit;
  Success := true;
  Close;
end;

procedure TFGroupEditor.cbParentGroupChange(Sender: TObject);
begin
  if (not VarIsNull(cbParentGroup.KeyValue)) and (edPk.Text <> '') and (VarToStr(cbParentGroup.KeyValue) = edPk.Text) then
  begin
    Application.MessageBox('Нельзя в качестве контейнера выбирать самого себя!', 'Ошибка', MB_OK + MB_ICONERROR);
    cbParentGroup.KeyValue := Null;
  end;

  if cbParentGroup.ListSource.DataSet.IsEmpty then
    edColumn.MaxValue := 0
  else begin
    if cbParentGroup.ListSource.DataSet.Locate('PK', cbParentGroup.KeyValue, []) then
      edColumn.MaxValue := cbParentGroup.ListSource.DataSet.FieldByName('COUNT_COLUMN').AsInteger
    else
      edColumn.MaxValue := 0;
  end;
  edColumnChange(edColumn);
end;

procedure TFGroupEditor.RefreshColStyles;
var
  i: integer;

begin
  mtStyleColumns.DisableControls;
  try
    while mtStyleColumns.RecordCount < edCountColumn.Value do
    begin
      i := mtStyleColumns.RecordCount;
      mtStyleColumns.Append;
      mtStyleColumnsCOLUMN_.AsInteger := i;
      if mtStyleColumnsSTYLE.IsNull then
        mtStyleColumnsSTYLE.AsString := 'width:' + IntToStr(Round(100 / edCountColumn.Value)) + '%;vertical-align:top';
      mtStyleColumns.Post;
    end;
    while mtStyleColumns.RecordCount > edCountColumn.Value do
    begin
      mtStyleColumns.Last;
      mtStyleColumns.Delete;
    end;
  finally
    mtStyleColumns.EnableControls;
  end;
end;

procedure TFGroupEditor.RegisterForm;
begin
  case Mode of
    omAdd: ;
    omEdit: Caption := GenCaption('Группа', 'редактирование', edPk.Text, '', edTitle.Text, false);
    omView: Caption := GenCaption('Группа', 'просмотр', edPk.Text, '', edTitle.Text, false);
  end;

  FMain.RegisterChildForm(Self);
end;

procedure TFGroupEditor.SetMode(Value: TOpenMode);
begin
  inherited SetMode(Value);

  if Mode = omView then
  begin
    btnSave.Enabled := false;
    edTitle.ReadOnly := true;
    edTitle.Color := clBtnFace;
    cbParentGroup.ReadOnly := true;
    cbParentGroup.Color := clBtnFace;
    edColumn.ReadOnly := true;
    edColumn.Color := clBtnFace;
    edOrder.ReadOnly := true;
    edOrder.Color := clBtnFace;
    edCountColumn.ReadOnly := true;
    edCountColumn.Color := clBtnFace;
    edLabelWidth.ReadOnly := true;
    edLabelWidth.Color := clBtnFace;
    chbAddVisible.Enabled := false;
    chbCollapsed.Enabled := false;
    chbIsVisible.Enabled := false;
    chbLeftAlign.Enabled := false;
    dbgStyleColumns.AllowedOperations := [];
    mStyleExternal.ReadOnly := true;
    mStyleExternal.Color := clBtnFace;
    mStyleInternal.ReadOnly := true;
    mStyleInternal.Color := clBtnFace;
    mDescription.ReadOnly := true;
    mDescription.Color := clBtnFace;
  end;
end;

procedure TFGroupEditor.edColumnChange(Sender: TObject);
begin
  if edColumn.Value > edColumn.MaxValue then edColumn.Value := edColumn.MaxValue;
  if edColumn.Value < edColumn.MinValue then edColumn.Value := edColumn.MinValue;
end;

procedure TFGroupEditor.edCountColumnChange(Sender: TObject);
begin
  RefreshColStyles;
end;

procedure TFGroupEditor.FormActivate(Sender: TObject);
begin
  ASave.Enabled := true;
  FMain.CheckFormButton(Tag);
end;

procedure TFGroupEditor.FormCreate(Sender: TObject);
begin
  if mtStyleColumns.Active then
  begin
    mtStyleColumns.EmptyTable;
    mtStyleColumns.Close;
  end;
  mtStyleColumns.CreateDataSet;
end;

procedure TFGroupEditor.FormDeactivate(Sender: TObject);
begin
  ASave.Enabled := false;
end;

function TFGroupEditor.GetShortCaption: string;
begin
  if Mode = omAdd then
    result := Caption
  else
    result := 'Группа ' + edOrder.Text + '.' + edTitle.Text;
end;

end.
