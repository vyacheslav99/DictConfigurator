unit previewForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,
  MemTableDataEh, Db, MemTableEh, FIBDataSet, pFIBDataSet, utils, Mask, DBCtrlsEh, Math, childForm;

type
  TFPreviewForm = class(TChildForm)
    btnClose: TBitBtn;
    Label1: TLabel;
    cbFormType: TComboBox;
    ScrollBox: TScrollBox;
    Label2: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbFormTypeChange(Sender: TObject);
    procedure ScrollBoxMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormActivate(Sender: TObject);
  private
    Controls: array of TControl;
    procedure AddControl(AControl: TControl);
    function GetBoxHeight(FormPk, BoxPk: integer; BoxColCount: integer): integer;
    procedure CreateControls(AParent: TWinControl; ParentPk: Variant; CountColumn: integer; LeftAlign: boolean; LabelWidth: integer);
    procedure FreeControls;
  public
    FieldsLeftAlign: boolean;
    RootLabelWidth: integer;
  end;

implementation

uses main;

{$R *.dfm}

const
  DATA_SQL = 'select PK, GROUP_PK, TITLE, COLUMN_, ORDER_, IS_VISIBLE, ADD_VISIBLE, EDITABLE, ADD_EDITABLE, TYPE_NAME, PARAMETERS, ' +
    'COLLAPSED, COUNT_COLUMN, FIELD_NAME, LEFT_ALIGN, LABEL_WIDTH ' +
    'from (' +
    'select g.PK, g.PARENT_PK GROUP_PK, g.TITLE, g.COLUMN_, g.ORDER_, g.IS_VISIBLE, g.ADD_VISIBLE, null EDITABLE, null ADD_EDITABLE, ' +
    '''GroupBox'' TYPE_NAME, null PARAMETERS, g.COLLAPSED, g.COUNT_COLUMN, null FIELD_NAME, g.LEFT_ALIGN, g.LABEL_WIDTH ' +
    'from DYNAMIC_FORM_FIELD_GROUP g ' +
    'where g.FORM_PK = :FORM_PK and coalesce(g.PARENT_PK, 0) = coalesce(:GROUP_PK, 0) ' +
    'union all ' +
    'select f.PK, f.GROUP_PK, f.TITLE, f.GROUP_COLUMN COLUMN_, f.ORDER_, f.IS_VISIBLE, f.IS_VISIBLE_ADD ADD_VISIBLE, f.EDITABLE, ' +
    'f.ADD_EDITABLE, f.TYPE_NAME, f.PARAMETERS, null COLLAPSED, null COUNT_COLUMN, f.FIELD_NAME, null LEFT_ALIGN, null LABEL_WIDTH ' +
    'from DYNAMIC_FORM_FIELD f ' +
    'where f.FORM_PK = :FORM_PK and coalesce(f.GROUP_PK, 0) = coalesce(:GROUP_PK, 0)) ' +
    'order by GROUP_PK, COLUMN_, ORDER_';

procedure TFPreviewForm.AddControl(AControl: TControl);
begin
  SetLength(Controls, Length(Controls) + 1);
  Controls[High(Controls)] := AControl;
end;

procedure TFPreviewForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFPreviewForm.cbFormTypeChange(Sender: TObject);
begin
  FreeControls;
  CreateControls(ScrollBox, Null, 1, FieldsLeftAlign, RootLabelWidth);
end;

procedure TFPreviewForm.CreateControls(AParent: TWinControl; ParentPk: Variant; CountColumn: integer; LeftAlign: boolean; LabelWidth: integer);
var
  ds: TpFIBDataSet;
  top_, stdTop: integer;
  ctrl: TControl;
  colWidth: integer;
  lbl: TLabel;
  oldCol: integer;

begin
  colWidth := Round(AParent.Width / CountColumn);
  if AParent is TScrollBox then colWidth := colWidth - 10;
  oldCol := 0;
  if AParent is TGroupBox then stdTop := 16
  else stdTop := 6;
  top_ := stdTop;

  try
    ds := FMain.OpenSQL(DATA_SQL, 'FORM_PK=' + IntToStr(GetObjectPK) + iif(VarIsNull(ParentPk), '', #13#10'GROUP_PK=' + VarToStr(ParentPk)));
    ds.First;

    while not ds.Eof do
    begin
      if ((ds.FieldByName('IS_VISIBLE').AsInteger = 0) and (cbFormType.ItemIndex = 0)) or
        ((ds.FieldByName('ADD_VISIBLE').AsInteger = 0) and (cbFormType.ItemIndex = 1)) or
        (ds.FieldByName('TYPE_NAME').AsString = 'hidden') then
      begin
        ds.Next;
        continue;
      end;

      if ds.FieldByName('COLUMN_').AsInteger <> oldCol then top_ := stdTop;
      oldCol := ds.FieldByName('COLUMN_').AsInteger;
      lbl := TLabel.Create(Self);
      AddControl(lbl);
      lbl.Parent := AParent;
      if LeftAlign then
      begin
        if LabelWidth = 0 then
          lbl.AutoSize := true
        else begin
          lbl.AutoSize := false;
          lbl.Width := LabelWidth;
        end;
      end else
      begin
        lbl.AutoSize := false;
        if LabelWidth = 0 then lbl.Width := colWidth - 16
        else lbl.Width := LabelWidth;
      end;
      lbl.Caption := ds.FieldByName('TITLE').AsString;
      lbl.Font.Style := [fsBold];
      lbl.Left := (colWidth * ds.FieldByName('COLUMN_').AsInteger) + 8;
      lbl.Top := top_;
      //lbl.Anchors

      if ds.FieldByName('TYPE_NAME').AsString = 'GroupBox' then
      begin
        lbl.Visible := false;
        ctrl := TGroupBox.Create(Self);
        ctrl.Parent := AParent;
        if ds.FieldByName('TITLE').AsString <> '' then TGroupBox(ctrl).Caption := ' ' + ds.FieldByName('TITLE').AsString + ' ';
        ctrl.Width := colWidth - 16;
        ctrl.Height := GetBoxHeight(GetObjectPK, ds.FieldByName('PK').AsInteger, ds.FieldByName('COUNT_COLUMN').AsInteger) + 10;
        ctrl.Left := lbl.Left;
        ctrl.Top := top_;
        //ctrl.Anchors
        CreateControls(TWinControl(ctrl), ds.FieldByName('PK').AsInteger, ds.FieldByName('COUNT_COLUMN').AsInteger,
          ds.FieldByName('LEFT_ALIGN').AsInteger = 1, ds.FieldByName('LABEL_WIDTH').AsInteger);
      end else
      begin
        if ((ds.FieldByName('EDITABLE').AsInteger = 0) and (cbFormType.ItemIndex = 0)) or
          ((ds.FieldByName('ADD_EDITABLE').AsInteger = 0) and (cbFormType.ItemIndex = 1)) then
        begin
          ctrl := TLabel.Create(Self);
          ctrl.Parent := AParent;
          TLabel(ctrl).Caption := 'Тут строка с данными';
          if LeftAlign then
          begin
            TLabel(ctrl).AutoSize := false;
            ctrl.Width := colWidth - (lbl.Left + lbl.Width) - 16;
            ctrl.Left := lbl.Left + lbl.Width + 5;
            ctrl.Top := lbl.Top;
          end else
          begin
            ctrl.Left := lbl.Left;
            ctrl.Top := lbl.Top + lbl.Height + 1;
          end;
          //ctrl.Anchors
        end else if (ds.FieldByName('TYPE_NAME').AsString = 'text') or (ds.FieldByName('TYPE_NAME').AsString = 'link') then
        begin
          ctrl := TEdit.Create(Self);
          ctrl.Parent := AParent;
          ctrl.Height := 21;
          if LeftAlign then
          begin
            ctrl.Width := colWidth - (lbl.Left + lbl.Width) - 16;
            ctrl.Left := lbl.Left + lbl.Width + 5;
            ctrl.Top := lbl.Top;
          end else
          begin
            ctrl.Width := colWidth - 16;
            ctrl.Left := lbl.Left;
            ctrl.Top := lbl.Top + lbl.Height + 1;
          end;
        end else if ds.FieldByName('TYPE_NAME').AsString = 'numeric' then
        begin
          ctrl := TDBNumberEditEh.Create(Self);
          ctrl.Parent := AParent;
          ctrl.Height := 21;
          if LeftAlign then
          begin
            ctrl.Width := colWidth - (lbl.Left + lbl.Width) - 16;
            ctrl.Left := lbl.Left + lbl.Width + 5;
            ctrl.Top := lbl.Top;
          end else
          begin
            ctrl.Width := colWidth - 16;
            ctrl.Left := lbl.Left;
            ctrl.Top := lbl.Top + lbl.Height + 1;
          end;
        end else if (ds.FieldByName('TYPE_NAME').AsString = 'TextArea') or (ds.FieldByName('TYPE_NAME').AsString = 'HtmlEditor') then
        begin
          ctrl := TMemo.Create(Self);
          ctrl.Parent := AParent;
          ctrl.Height := 60;
          if LeftAlign then
          begin
            ctrl.Width := colWidth - (lbl.Left + lbl.Width) - 16;
            ctrl.Left := lbl.Left + lbl.Width + 5;
            ctrl.Top := lbl.Top;
          end else
          begin
            ctrl.Width := colWidth - 16;
            ctrl.Left := lbl.Left;
            ctrl.Top := lbl.Top + lbl.Height + 1;
          end;
        end else if (ds.FieldByName('TYPE_NAME').AsString = 'comboBox') or (ds.FieldByName('TYPE_NAME').AsString = 'LookUp') or
          (ds.FieldByName('TYPE_NAME').AsString = 'LovCombo') or (ds.FieldByName('TYPE_NAME').AsString = 'CheckedLookUp') then
        begin
          ctrl := TComboBox.Create(Self);
          ctrl.Parent := AParent;
          ctrl.Height := 21;
          if LeftAlign then
          begin
            ctrl.Width := colWidth - (lbl.Left + lbl.Width) - 16;
            ctrl.Left := lbl.Left + lbl.Width + 5;
            ctrl.Top := lbl.Top;
          end else
          begin
            ctrl.Width := colWidth - 16;
            ctrl.Left := lbl.Left;
            ctrl.Top := lbl.Top + lbl.Height + 1;
          end;
        end else if ds.FieldByName('TYPE_NAME').AsString = 'Checkbox' then
        begin
          lbl.Visible := false;
          ctrl := TCheckBox.Create(Self);
          ctrl.Parent := AParent;
          TCheckBox(ctrl).Caption := ds.FieldByName('TITLE').AsString;
          ctrl.Width := colWidth - 16;
          ctrl.Height := 17;
          ctrl.Left := lbl.Left;
          ctrl.Top := top_;
        end else if (ds.FieldByName('TYPE_NAME').AsString = 'date') or (ds.FieldByName('TYPE_NAME').AsString = 'datePeriod') or
          (ds.FieldByName('TYPE_NAME').AsString = 'MonthField') then
        begin
          ctrl := TDBDateTimeEditEh.Create(Self);
          ctrl.Parent := AParent;
          ctrl.Height := 21;
          if LeftAlign then
          begin
            ctrl.Width := colWidth - (lbl.Left + lbl.Width) - 16;
            ctrl.Left := lbl.Left + lbl.Width + 5;
            ctrl.Top := lbl.Top;
          end else
          begin
            ctrl.Width := colWidth - 16;
            ctrl.Left := lbl.Left;
            ctrl.Top := lbl.Top + lbl.Height + 1;
          end;
        end else if (ds.FieldByName('TYPE_NAME').AsString = 'Button') or (ds.FieldByName('TYPE_NAME').AsString = 'ChildTable') or
          (ds.FieldByName('TYPE_NAME').AsString = 'MultipleLookUp') or (ds.FieldByName('TYPE_NAME').AsString = 'MLookUpCreat') then
        begin
          lbl.Visible := false;
          ctrl := TButton.Create(Self);
          ctrl.Parent := AParent;
          TButton(ctrl).Caption := ds.FieldByName('TITLE').AsString;
          ctrl.Width := lbl.Canvas.TextWidth(lbl.Caption) + 10;
          if ctrl.Width > (colWidth - 16) then ctrl.Width := colWidth - 16;
          ctrl.Height := 25;
          ctrl.Left := lbl.Left;
          ctrl.Top := top_;
        end else if (ds.FieldByName('TYPE_NAME').AsString = 'photo') or (ds.FieldByName('TYPE_NAME').AsString = 'FileField') then
        begin
          ctrl := TButton.Create(Self);
          ctrl.Parent := AParent;
          TButton(ctrl).Caption := 'Обзор...';
          ctrl.Height := 25;
          if LeftAlign then
          begin
            ctrl.Width := colWidth - (lbl.Left + lbl.Width) - 16;
            ctrl.Left := lbl.Left + lbl.Width + 5;
            ctrl.Top := lbl.Top;
          end else
          begin
            ctrl.Width := 75;
            ctrl.Left := lbl.Left;
            ctrl.Top := lbl.Top + lbl.Height + 1;
          end;
        end;
      end;
      if Assigned(ctrl) then AddControl(ctrl);

      top_ := ctrl.Top + ctrl.Height + 4;
      ds.Next;
    end;
  except
    on e: Exception do Application.MessageBox(pchar(e.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;
  ds.Close;
  ds.Free;
end;

procedure TFPreviewForm.FormActivate(Sender: TObject);
begin
  FMain.CheckFormButton(Tag);
end;

procedure TFPreviewForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFPreviewForm.FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBoxMouseWheel(ScrollBox, Shift, WheelDelta, MousePos, Handled);
  Handled := true;
end;

procedure TFPreviewForm.FreeControls;
var
  i: integer;

begin
  for i := 0 to Length(Controls) - 1 do
    if Assigned(Controls[i]) then FreeAndNil(Controls[i]);

  SetLength(Controls, 0);
end;

function TFPreviewForm.GetBoxHeight(FormPk, BoxPk, BoxColCount: integer): integer;
var
  ds: TpFIBDataSet;
  currCol: integer;
  hh: array of integer;
  i: integer;
  
begin
  result := 0;
  currCol := -1;
  SetLength(hh, 0);

  try
    ds := FMain.OpenSQL(DATA_SQL, 'FORM_PK=' + IntToStr(FormPk) + #13#10'GROUP_PK=' + IntToStr(BoxPk));
    ds.First;

    while not ds.Eof do
    begin
      if ((ds.FieldByName('IS_VISIBLE').AsInteger = 0) and (cbFormType.ItemIndex = 0)) or
        ((ds.FieldByName('ADD_VISIBLE').AsInteger = 0) and (cbFormType.ItemIndex = 1)) or
        (ds.FieldByName('TYPE_NAME').AsString = 'hidden') then
      begin
        ds.Next;
        continue;
      end;

      if ds.FieldByName('COLUMN_').AsInteger <> currCol then
      begin
        SetLength(hh, Length(hh) + 1);
        hh[High(hh)] := 16;
      end;
      currCol := ds.FieldByName('COLUMN_').AsInteger;

      if ds.FieldByName('TYPE_NAME').AsString = 'GroupBox' then
        hh[High(hh)] := hh[High(hh)] + GetBoxHeight(FormPk, ds.FieldByName('PK').AsInteger, ds.FieldByName('COUNT_COLUMN').AsInteger)
      else begin
        if ((ds.FieldByName('EDITABLE').AsInteger = 0) and (cbFormType.ItemIndex = 0)) or
          ((ds.FieldByName('ADD_EDITABLE').AsInteger = 0) and (cbFormType.ItemIndex = 1)) then
          hh[High(hh)] := hh[High(hh)] + 13 + 1 + 13
        else if (ds.FieldByName('TYPE_NAME').AsString = 'ChildTable') or (ds.FieldByName('TYPE_NAME').AsString = 'Button') or
          (ds.FieldByName('TYPE_NAME').AsString = 'MultipleLookUp') or (ds.FieldByName('TYPE_NAME').AsString = 'MLookUpCreat')then
          hh[High(hh)] := hh[High(hh)] + 25
        else if (ds.FieldByName('TYPE_NAME').AsString = 'TextArea') or (ds.FieldByName('TYPE_NAME').AsString = 'HtmlEditor') then
          hh[High(hh)] := hh[High(hh)] + 60 + 1 + 13
        {else if ds.FieldByName('TYPE_NAME').AsString = 'datePeriod' then
          hh[High(hh)] := hh[High(hh)] + }
        else if (ds.FieldByName('TYPE_NAME').AsString = 'photo') or (ds.FieldByName('TYPE_NAME').AsString = 'FileField') then
          hh[High(hh)] := hh[High(hh)] + 24 + 1 + 13
        {else if ds.FieldByName('TYPE_NAME').AsString = 'link' then
          hh[High(hh)] := hh[High(hh)] +
        else if ds.FieldByName('TYPE_NAME').AsString = 'FormField' then
          hh[High(hh)] := hh[High(hh)] + }
        else if ds.FieldByName('TYPE_NAME').AsString = 'Checkbox' then
          hh[High(hh)] := hh[High(hh)] + 17
        else hh[High(hh)] := hh[High(hh)] + 21 + 1 + 13;
      end;
      hh[High(hh)] := hh[High(hh)] + 4;

      ds.Next;
    end;

    if Length(hh) = 0 then result := 21
    else if Length(hh) = 1 then result := hh[0]
    else begin
      for i := 1 to Length(hh) - 1 do
      begin
        if i = 1 then result := Max(hh[i-1], hh[i])
        else result := Max(result, hh[i]);
      end;
    end;
  except
    on e: Exception do Application.MessageBox(pchar(e.Message), 'Ошибка', MB_OK + MB_ICONERROR);
  end;

  ds.Close;
  ds.Free;
end;

procedure TFPreviewForm.ScrollBoxMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBox.VertScrollBar.Position := ScrollBox.VertScrollBar.Position - WheelDelta;
end;

end.
