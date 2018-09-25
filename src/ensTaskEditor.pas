unit ensTaskEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Mask,
  utils, ActnList, settings, main, childForm, Menus, JvExControls, JvDBLookupTreeView, DB, MemDS, DBAccess, Uni,
  DBCtrlsEh;

type
  TFEnsTaskEditor = class(TChildForm)
    GroupBox1: TGroupBox;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    Label2: TLabel;
    edPk: TEdit;
    Label10: TLabel;
    edDescription: TEdit;
    ActionList: TActionList;
    ASave: TAction;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    edHours: TEdit;
    Label3: TLabel;
    edMinutes: TEdit;
    Label4: TLabel;
    edDays: TEdit;
    Label5: TLabel;
    edMonths: TEdit;
    Label6: TLabel;
    edDow: TEdit;
    chbIsActive: TCheckBox;
    Label7: TLabel;
    Label8: TLabel;
    edLogFile: TEdit;
    sbFillLog: TSpeedButton;
    sbFillScript: TSpeedButton;
    edProcessName: TEdit;
    chbOnlyOneCopy: TCheckBox;
    Label11: TLabel;
    edParametres: TEdit;
    dsEnsFolders: TUniQuery;
    dsEnsFoldersPK: TIntegerField;
    dsEnsFoldersNAME: TWideStringField;
    dsEnsFoldersPARENT_PK: TIntegerField;
    dsEnsFoldersICON_INDEX: TIntegerField;
    dsoEnsFolders: TDataSource;
    Label9: TLabel;
    lctFolder: TJvDBLookupTreeViewCombo;
    GroupBox3: TGroupBox;
    Label12: TLabel;
    edExecTimeout: TDBNumberEditEh;
    chbSendOnTimeout: TCheckBox;
    Label13: TLabel;
    mSendAddrs: TMemo;
    Label14: TLabel;
    cbTimeoutAction: TComboBox;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure sbFillLogClick(Sender: TObject);
    procedure sbFillScriptClick(Sender: TObject);
  private
    procedure SetMode(Value: TOpenMode); override;
  public
    procedure RegisterForm;
    function GetShortCaption: string; override;
  end;

implementation

{$R *.dfm}

procedure TFEnsTaskEditor.ASaveExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then btnSaveClick(btnSave);
end;

procedure TFEnsTaskEditor.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFEnsTaskEditor.btnSaveClick(Sender: TObject);
begin
  if Mode = omView then exit;
  if (Trim(edProcessName.Text) = '') or (Trim(edDescription.Text) = '') then
  begin
    Application.MessageBox('Не все обязательные поля заполнены!', 'Ошибка', MB_OK + MB_ICONERROR);
    exit;
  end;

  Success := true;
  Close;
end;

procedure TFEnsTaskEditor.FormActivate(Sender: TObject);
begin
  ASave.Enabled := true;
  FMain.CheckFormButton(Tag);
end;

procedure TFEnsTaskEditor.FormDeactivate(Sender: TObject);
begin
  ASave.Enabled := false;
end;

function TFEnsTaskEditor.GetShortCaption: string;
begin
  if Mode = omAdd then
    result := Caption
  else
    result := 'Задача ENS ' + iif(edDescription.Text = '', edPk.Text, edDescription.Text);
end;

procedure TFEnsTaskEditor.RegisterForm;
begin
  case Mode of
    omAdd: ;
    omEdit: Caption := GenCaption('Задача ENS', 'редактирование', edPk.Text, '', edDescription.Text, false);
    omView: Caption := GenCaption('Задача ENS', 'просмотр', edPk.Text, '', edDescription.Text, false);
  end;

  FMain.RegisterChildForm(Self);
end;

procedure TFEnsTaskEditor.sbFillLogClick(Sender: TObject);
begin
  if Mode = omView then exit;

  if (edLogFile.Text <> '') and
    (Application.MessageBox(pchar('Путь к файлу лога не пустой! Перезаписать?'), 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES) then exit;

  edLogFile.Text := FSettings.EnsDefLogPath;
end;

procedure TFEnsTaskEditor.sbFillScriptClick(Sender: TObject);
begin
  if Mode = omView then exit;

  if (edParametres.Text <> '') and
    (Application.MessageBox(pchar('Поле с параметрами не пустое! Перезаписать?'), 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES) then exit;

  edParametres.Text := FSettings.EnsDefScriptPath;
end;

procedure TFEnsTaskEditor.SetMode(Value: TOpenMode);
begin
  inherited SetMode(Value);

  case Mode of
    omView:
    begin
      btnSave.Enabled := false;
      chbIsActive.Enabled := false;
      chbOnlyOneCopy.Enabled := false;
      edProcessName.ReadOnly := true;
      edProcessName.Color := clBtnFace;
      edParametres.ReadOnly := true;
      edParametres.Color := clBtnFace;
      edDescription.ReadOnly := true;
      edDescription.Color := clBtnFace;
      edLogFile.ReadOnly := true;
      edLogFile.Color := clBtnFace;
      edHours.ReadOnly := true;
      edHours.Color := clBtnFace;
      edMinutes.ReadOnly := true;
      edMinutes.Color := clBtnFace;
      edDays.ReadOnly := true;
      edDays.Color := clBtnFace;
      edMonths.ReadOnly := true;
      edMonths.Color := clBtnFace;
      edDow.ReadOnly := true;
      edDow.Color := clBtnFace;
      sbFillLog.Enabled := false;
      sbFillScript.Enabled := false;
      lctFolder.Enabled := false;
      edExecTimeout.ReadOnly := true;
      edExecTimeout.Color := clBtnFace;
      cbTimeoutAction.Enabled := false;
      chbSendOnTimeout.Enabled := false;
      mSendAddrs.ReadOnly := true;
      mSendAddrs.Color := clBtnFace;
    end;
  end;
end;

end.
