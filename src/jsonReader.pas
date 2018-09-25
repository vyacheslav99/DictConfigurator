unit jsonReader;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, utils, settings, childForm, main,
  json, ActnList, ComCtrls, StdCtrls, Buttons, Mask, JvExMask, JvToolEdit, ExtCtrls, JvExComCtrls, JvComCtrls, ImgList,
  ToolWin, JvListView, DBCtrlsEh, JvExControls, JvGradientHeaderPanel, DB, MemTableDataEh, MemTableEh;

type
  TFJsonReader = class(TChildForm)
    ActionList: TActionList;
    AClose: TAction;
    StatusBar: TStatusBar;
    ilTree: TImageList;
    ToolBar: TToolBar;
    ToolButton7: TToolButton;
    ALoadFromFile: TAction;
    ALoadText: TAction;
    OpenDialog: TOpenDialog;
    ASaveToFile: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    SaveDialog: TSaveDialog;
    ToolButton3: TToolButton;
    Panel1: TPanel;
    mClipLoader: TMemo;
    tvJson: TJvTreeView;
    Panel2: TPanel;
    Splitter2: TSplitter;
    pCaption: TJvGradientHeaderPanel;
    reJsonText: TRichEdit;
    Panel3: TPanel;
    lbType: TLabel;
    cbType: TComboBox;
    lbKey: TLabel;
    edValueNum: TDBNumberEditEh;
    lbValue: TLabel;
    edValueBool: TComboBox;
    btnAdd: TButton;
    btnEdit: TButton;
    btnDel: TButton;
    edValueDate: TDBDateTimeEditEh;
    edKey: TEdit;
    chbFormatted: TCheckBox;
    Bevel1: TBevel;
    ASaveToField: TAction;
    ToolButton4: TToolButton;
    reValueStr: TRichEdit;
    chbNoSpaces: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure ACloseExecute(Sender: TObject);
    procedure ALoadFromFileExecute(Sender: TObject);
    procedure ALoadTextExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ASaveToFileExecute(Sender: TObject);
    procedure tvJsonChange(Sender: TObject; Node: TTreeNode);
    procedure btnEditClick(Sender: TObject);
    procedure cbTypeChange(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure chbFormattedClick(Sender: TObject);
    procedure ASaveToFieldExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure tvJsonKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FJson: TJson;
    procedure SetMode(Value: TOpenMode); override;
    procedure LoadFile(FileName: string);
    procedure LoadTree;
    procedure AddNodes(ParentNode: TTreeNode; JsonObj: TJson);
    procedure ClearValue;
    function GetKey(json: TJson): string;
    function GetFullPath: string;
    procedure FindNode(FullPath: string);
    procedure TvSelectNode(Node: TTreeNode);
  public
    EditingRec: TBookmark;
    Field: TField;
    procedure LoadText(JsonStr: string);
    function GetJsonString: string;
    procedure RegisterForm;
  end;

implementation

{$R *.dfm}

procedure TFJsonReader.ACloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFJsonReader.AddNodes(ParentNode: TTreeNode; JsonObj: TJson);
var
  n: TTreeNode;
  i: integer;
  title: string;
  imIdx: integer;

begin
  // сначала добавляем узел переданного объекта
  if not Assigned(JsonObj) then exit;

  if (JsonObj.Key = '') and (JsonObj.Index <> -1) then title := IntToStr(JsonObj.Index)
  else if (JsonObj.Key = '') then title := ''
  else title := '"' + JsonObj.Key + '"';

  case JsonObj.DataType of
    jdtDict: imIdx := 0;
    jdtList: imIdx := 1;
    jdtStr, jdtDate:
    begin
      imIdx := 2;
      title := title + ': "' + JsonObj.AsString + '"';
    end;
    jdtInt, jdtBool, jdtFloat:
    begin
      imIdx := 3;
      title := title + ': ' + JsonObj.AsString;
    end;
    jdtNull:
    begin
      imIdx := 4;
      title := title + ': <NULL>';
    end;
  end;

  if not Assigned(ParentNode) then n := tvJson.Items.Add(nil, title)
  else n := tvJson.Items.AddChild(ParentNode, title);
  n.ImageIndex := imIdx;
  n.SelectedIndex := imIdx{ + 2};
  n.Data := pointer(JsonObj);

  // теперь добавить дочерние узлы
  for i := 0 to JsonObj.Count - 1 do AddNodes(n, JsonObj.AsObject(i));
end;

procedure TFJsonReader.ALoadFromFileExecute(Sender: TObject);
begin
  if Mode = omView then exit;
  if OpenDialog.Execute then LoadFile(OpenDialog.FileName);
end;

procedure TFJsonReader.ALoadTextExecute(Sender: TObject);
begin
  if Mode = omView then exit;
  if Application.MessageBox('Текущая структура будет перезаписана! Продолжить?', 'Предупреждение', MB_YESNO + MB_ICONWARNING) <> ID_YES then exit;

  mClipLoader.Clear;
  mClipLoader.PasteFromClipboard;
  LoadText(mClipLoader.Text);
end;

procedure TFJsonReader.ASaveToFieldExecute(Sender: TObject);
begin
  if Mode = omView then exit;
  if not TAction(Sender).Visible then exit;
  Success := true;
  Close;
end;

procedure TFJsonReader.ASaveToFileExecute(Sender: TObject);
begin
  if SaveDialog.Execute then FJson.SaveToFile(SaveDialog.FileName);
end;

procedure TFJsonReader.btnAddClick(Sender: TObject);
var
  j: TJson;
  val: Variant;
  js: string;

begin
  if Mode = omView then exit;

  if FJson.DataType = jdtNull then
  begin
    // создадим новый
    case cbType.ItemIndex of
      -1: ;
      0: js := '{}';
      1: js := '[]';
      2: js := '"' + reValueStr.Text + '"';
      3, 5: js := edValueNum.Value;
      4:
        if edValueBool.ItemIndex = 1 then js := 'True'
        else js := 'False';
      6: js := '"' + DateTimeToStr(edValueDate.Value) + '"';
    end;
    FJson.Load(js);
    LoadTree;
    exit;
  end;

  // иначе правим существующий
  if (not Assigned(tvJson.Selected)) or (not Assigned(tvJson.Selected.Data)) then exit;
  j := TJson(tvJson.Selected.Data);

  case cbType.ItemIndex of
    -1, 0, 1: val := Null;
    2: val := reValueStr.Text;
    3, 5: val := edValueNum.Value;
    4:
      if edValueBool.ItemIndex = 1 then val := true
      else val := false;
    6: val := edValueDate.Value;
  end;

  j.Add(TJsonDataType(cbType.ItemIndex), val, edKey.Text);
  LoadTree;
end;

procedure TFJsonReader.btnDelClick(Sender: TObject);
var
  j, pj: TJson;

begin
  if Mode = omView then exit;

  if (not Assigned(tvJson.Selected)) or (not Assigned(tvJson.Selected.Data)) then exit;
  j := TJson(tvJson.Selected.Data);

  if Application.MessageBox(pchar('Удалить узел "' + tvJson.Selected.Text + '"?'), 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

  pj := j.Parent;
  if Assigned(pj) then
  begin
    case pj.DataType of
      jdtDict: pj.Del(j.Key);
      jdtList: pj.Del(j.Index);
    end;
  end else
    j.Clear;
    
  LoadTree;
end;

procedure TFJsonReader.btnEditClick(Sender: TObject);
var
  j: TJson;

begin
  if Mode = omView then exit;

  if (not Assigned(tvJson.Selected)) or (not Assigned(tvJson.Selected.Data)) then exit;
  j := TJson(tvJson.Selected.Data);

  case TJsonDataType(cbType.ItemIndex) of
    jdtDict, jdtList: ;
    jdtStr: j.SetValue(jdtStr, reValueStr.Text);
    jdtInt: j.SetValue(jdtInt, edValueNum.Value);
    jdtBool:
      if edValueBool.ItemIndex = 1 then j.SetValue(jdtBool, true)
      else j.SetValue(jdtBool, false);
    jdtFloat: j.SetValue(jdtFloat, edValueNum.Value);
    jdtDate: j.SetValue(jdtDate, edValueDate.Value);
    jdtNull: j.SetValue(jdtNull, Null);
  end;

  LoadTree;
end;

procedure TFJsonReader.cbTypeChange(Sender: TObject);
begin
  reValueStr.Visible := false;
  edValueDate.Visible := false;
  edValueNum.Visible := false;
  edValueBool.Visible := false;

  case cbType.ItemIndex of
    -1, 0, 1, 7: ;
    2: reValueStr.Visible := true;
    3:
    begin
      edValueNum.Visible := true;
      edValueNum.DecimalPlaces := 0;
      if not VarIsNull(edValueNum.Value) then edValueNum.Value := Round(edValueNum.Value);
    end;
    4: edValueBool.Visible := true;
    5:
    begin
      edValueNum.Visible := true;
      edValueNum.DecimalPlaces := 5;
    end;
    6: edValueDate.Visible := true;
  end;
end;

procedure TFJsonReader.chbFormattedClick(Sender: TObject);
begin
  reJsonText.WordWrap := not chbFormatted.Checked;
  reJsonText.Text := FJson.SaveToString(chbFormatted.Checked, chbNoSpaces.Checked);
end;

procedure TFJsonReader.ClearValue;
begin
  reValueStr.Text := '';
  edValueDate.Value := Null;
  edValueNum.Value := 0;
  edValueBool.ItemIndex := 0;
end;

procedure TFJsonReader.FindNode(FullPath: string);
var
  n: integer;
  s: string;
  node: TTreeNode;
  j: TJson;
  fBreak: boolean;

begin
  node := tvJson.Items.GetFirstNode;

  for n := 1 to WordCountEx(FullPath, ['>'], []) do
  begin
    if not Assigned(node) then break;
    s := Trim(ExtractWordEx(n, FullPath, ['>'], []));
    if s = '' then exit;

    if (n = 1) and (AnsiLowerCase(s) = 'root') then
    begin
      TvSelectNode(node);
      node := node.getFirstChild;
      continue;
    end;

    while Assigned(node) do
    begin
      fBreak := false;
      if not Assigned(node.Data) then exit;
      j := TJson(node.Data);
      if AnsiLowerCase(GetKey(j)) = AnsiLowerCase(s) then
      begin
        TvSelectNode(node);
        node.Expand(false);
        node := node.getFirstChild;
        fBreak := true;
        break;
      end;

      if fBreak then break;
      node := node.getNextSibling;
    end;
  end;
end;

procedure TFJsonReader.FormActivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, true);
  ALoadFromFile.Enabled := Mode <> omView;
  ALoadText.Enabled := Mode <> omView;
  FMain.CheckFormButton(Tag);
end;

procedure TFJsonReader.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FSettings.ChildMaximized := WindowState = wsMaximized;
end;

procedure TFJsonReader.FormCreate(Sender: TObject);
begin
  FJson := TJson.Create;
  reJsonText.WordWrap := not chbFormatted.Checked;
  ASaveToField.Visible := false;
  cbTypeChange(cbType);
end;

procedure TFJsonReader.FormDeactivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, false);
end;

procedure TFJsonReader.FormDestroy(Sender: TObject);
begin
  FJson.Free;
end;

procedure TFJsonReader.FormResize(Sender: TObject);
begin
  StatusBar.Panels[1].Width := StatusBar.Width - (StatusBar.Panels[0].Width) - 35;
end;

function TFJsonReader.GetFullPath: string;
var
  j: TJson;

begin
  result := '';
  if (not Assigned(tvJson.Selected)) or (not Assigned(tvJson.Selected.Data)) then exit;
  j := TJson(tvJson.Selected.Data);

  result := GetKey(j);
  while Assigned(j) do
  begin
    j := j.Parent;
    if not Assigned(j) then break;
    result := GetKey(j) + ' > ' + result;
  end;
end;

function TFJsonReader.GetJsonString: string;
begin
  result := FJson.SaveToString(false, chbNoSpaces.Checked);
end;

function TFJsonReader.GetKey(json: TJson): string;
begin
  result := '';
  if not Assigned(json) then exit;
  if json.Key <> '' then result := json.Key
  else result := IntToStr(json.Index);

  if result = '-1' then result := 'root';
end;

procedure TFJsonReader.LoadFile(FileName: string);
begin
  StatusBar.Panels[1].Text := FileName;
  FJson.LoadFromFile(FileName);
  LoadTree;
end;

procedure TFJsonReader.LoadText(JsonStr: string);
begin
  StatusBar.Panels[1].Text := '';
  FJson.Load(JsonStr);
  LoadTree;
end;

procedure TFJsonReader.LoadTree;
var
  n: TTreeNode;
  p: string;
  
begin
  p := GetFullPath;
  tvJson.Items.Clear;
  AddNodes(nil, FJson);
  reJsonText.Text := FJson.SaveToString(chbFormatted.Checked);
  n := tvJson.Items.GetFirstNode;
  if Assigned(n) then n.Expand(false);
  if p <> '' then FindNode(p)
  else TvSelectNode(n);
end;

procedure TFJsonReader.RegisterForm;
begin
  FMain.RegisterChildForm(Self);
end;

procedure TFJsonReader.SetMode(Value: TOpenMode);
begin
  if Value = omAdd then Value := omEdit;
  inherited SetMode(Value);

  case FMode of
    omAdd, omEdit:
    begin
      StatusBar.Panels[0].Text := 'Read/Write';
    end;
    omView:
    begin
      StatusBar.Panels[0].Text := 'Read Only';
      lbType.Enabled := false;
      cbType.Enabled := false;
      edKey.ReadOnly := true;
      edKey.Color := clBtnFace;
      reValueStr.ReadOnly := true;
      reValueStr.Color := clBtnFace;
      edValueNum.ReadOnly := true;
      edValueNum.Color := clBtnFace;
      edValueBool.Enabled := false;
      edValueDate.ReadOnly := true;
      edValueDate.Color := clBtnFace;
      btnAdd.Enabled := false;
      btnEdit.Enabled := false;
      btnDel.Enabled := false;
      ASaveToField.Visible := false;
    end;
  end;
end;

procedure TFJsonReader.tvJsonChange(Sender: TObject; Node: TTreeNode);
var
  j: TJson;
  
begin
  if Assigned(Node) and Assigned(Node.Data) then
  begin
    j := TJson(Node.Data);
    ClearValue;
    cbType.ItemIndex := Ord(j.DataType);
    if cbType.ItemIndex = -1 then cbType.ItemIndex := cbType.Items.Count - 1;
    cbTypeChange(cbType);

    if j.Key = '' then
    begin
      edKey.Text := IntToStr(j.Index);
      //lbKey.Caption := 'Индекс';
    end else
    begin
      edKey.Text := j.Key;
      //lbKey.Caption := 'Ключ';
    end;

    case j.DataType of
      jdtDict, jdtList: ;
      jdtStr: reValueStr.Text := j.AsString;
      jdtInt: edValueNum.Value := j.AsInteger;
      jdtBool:
        if j.AsBoolean then edValueBool.ItemIndex := 1
        else edValueBool.ItemIndex := 0;
      jdtFloat: edValueNum.Value := j.AsFloat;
      jdtDate: edValueDate.Value := j.AsDateTime;
      jdtNull: ;
    end;
  end;

  pCaption.LabelCaption := GetFullPath;
end;

procedure TFJsonReader.tvJsonKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ADD) and (ssShift in Shift) and (ssCtrl in Shift) then tvJson.FullExpand;
  if (Key = VK_SUBTRACT) and (ssShift in Shift) and (ssCtrl in Shift) then tvJson.FullCollapse;
end;

procedure TFJsonReader.TvSelectNode(Node: TTreeNode);
begin
  if not Assigned(Node) then exit;

  Node.TreeView.Visible := true;
  try
    TJvTreeView(Node.TreeView).ClearSelection;
    TJvTreeView(Node.TreeView).Select(Node);
    TJvTreeView(Node.TreeView).SelectItem(Node);

    TJvTreeView(Node.TreeView).SetFocus;
  except
  end;
end;

end.
