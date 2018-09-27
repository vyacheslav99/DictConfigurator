unit editFolder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, settings, utils,
  main, ExtCtrls, DB, FIBDataSet, pFIBDataSet, DBGridEh, Mask, DBCtrlsEh, DBLookupEh, ActnList, childForm, ToolWin,
  ComCtrls;

type
  TFEditFolder = class(TChildForm)
    GroupBox1: TGroupBox;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    Label11: TLabel;
    edFolderName: TEdit;
    Label12: TLabel;
    edFolderPk: TEdit;
    Bevel1: TBevel;
    dsFolders: TpFIBDataSet;
    dsoFolders: TDataSource;
    dsFoldersPK: TFIBIntegerField;
    dsFoldersNAME: TFIBStringField;
    Label1: TLabel;
    lcbFolders: TDBLookupComboboxEh;
    ActionList: TActionList;
    ASave: TAction;
    ToolBar: TToolBar;
    ToolButton1: TToolButton;
    tbRefresh: TToolButton;
    btnRefresh: TBitBtn;
    tbGenSQL: TToolButton;
    tbSave: TToolButton;
    tbJumpToTree: TToolButton;
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ASaveExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure tbRefreshClick(Sender: TObject);
    procedure tbGenSQLClick(Sender: TObject);
    procedure tbJumpToTreeClick(Sender: TObject);
  private
    function SaveData: boolean;
    procedure SetMode(Value: TOpenMode); override;
    procedure SetProperties(Value: TNodeDictInfo); override;
    procedure _Reload;
  public
    function GetShortCaption: string; override;
  end;

implementation

{$R *.dfm}

procedure TFEditFolder.ASaveExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then btnSaveClick(btnSave);
end;

procedure TFEditFolder.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFEditFolder.btnSaveClick(Sender: TObject);
begin
  if Mode = omView then exit;

  if FSettings.ConfirmSave and
    (Application.MessageBox('Сохранить изменения папки в базу данных?', 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES) then exit;

  Success := SaveData;
  Close;
end;

procedure TFEditFolder.FormActivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, true);
  FMain.CheckFormButton(Tag);
end;

procedure TFEditFolder.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FSettings.ChildMaximized := WindowState = wsMaximized;
end;

procedure TFEditFolder.FormCreate(Sender: TObject);
begin
  dsFolders.Close;
  dsFolders.Open;
end;

procedure TFEditFolder.FormDeactivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, false);
end;

function TFEditFolder.GetShortCaption: string;
begin
  if Mode = omAdd then
    result := Caption
  else
    result := iif(edFolderName.Text = '', edFolderPk.Text, edFolderName.Text);
end;

function TFEditFolder.SaveData: boolean;
var
  err: string;

begin
  case Mode of
    omAdd:
    begin
      result := FMain.ExecSQL('insert into DYNAMIC_FORM_FOLDER (NAME, PARENT_FOLDER_PK) values (' +
        VariantToDBStr(Trim(edFolderName.Text), true) + ', ' + VariantToDBStr(lcbFolders.KeyValue, false) + ')', err);
      FMain.AddToRefLog(cotFolder, edFolderName.Text, rltCreate);
    end;
    omEdit:
    begin
      result := FMain.ExecSQL('update DYNAMIC_FORM_FOLDER set NAME = ' + VariantToDBStr(Trim(edFolderName.Text), true) +
        ', PARENT_FOLDER_PK = ' + VariantToDBStr(lcbFolders.KeyValue, false) + ' where PK = ' + VarToStr(Properties.PK), err);
      FMain.AddToRefLog(cotFolder, edFolderName.Text, rltUpdate, 'PK ' + VarToStr(Properties.PK));
    end
    else result := false;
  end;

  if result then
    SetPropValues(Properties.PK, Properties.Descriptor, Trim(edFolderName.Text), Properties.ParentDictPK, lcbFolders.KeyValue,
      Properties.Login, Properties.ObjType);

  if (err <> '') then Application.MessageBox(pchar(err), 'Ошибка', MB_OK + MB_ICONERROR);
end;

procedure TFEditFolder.SetProperties(Value: TNodeDictInfo);
begin
  inherited SetProperties(Value);

  lcbFolders.KeyValue := Properties.FolderPK;
  edFolderPk.Text := VarToStr(Properties.PK);
  edFolderName.Text := VarToStr(Properties.Title);
  
  if Mode <> omAdd then
  begin
    Caption := GenCaption('Папка', iif(Mode = omEdit, 'редактирование', 'просмотр'), edFolderPk.Text, '', edFolderName.Text, false);
  end;
end;

procedure TFEditFolder.tbGenSQLClick(Sender: TObject);
begin
  FMain.SetSaveDialogToSQL;
  if FMain.SaveDialog.Execute then FMain.SaveToSQL(Properties, FMain.SaveDialog.FileName);
end;

procedure TFEditFolder.tbJumpToTreeClick(Sender: TObject);
begin
  if Mode = omAdd then exit;
  FMain.JumpToNode(cotFolder, Properties.PK);
end;

procedure TFEditFolder.tbRefreshClick(Sender: TObject);
begin
  if (Mode = omView) or (Application.MessageBox('При перезагрузке данных папки все несохраненные изменения будут потеряны! Продолжить?',
    'Подтверждение', MB_YESNO + MB_ICONQUESTION) = ID_YES) then _Reload;
end;

procedure TFEditFolder._Reload;
begin
  if Mode = omAdd then Mode := omEdit;
  Properties := Properties;
end;

procedure TFEditFolder.SetMode(Value: TOpenMode);
begin
  inherited SetMode(Value);
  
  case FMode of
    omAdd:
    begin
      btnSave.Enabled := true;
      tbSave.Enabled := true;
      tbGenSQL.Enabled := false;
      btnRefresh.Enabled := false;
      tbRefresh.Enabled := false;
      Caption := 'Новая папка';
      edFolderName.ReadOnly := false;
      edFolderName.Color := clWindow;
      lcbFolders.Enabled := true;
    end;
    omEdit:
    begin
      btnSave.Enabled := true;
      tbSave.Enabled := true;
      tbGenSQL.Enabled := true;
      btnRefresh.Enabled := true;
      tbRefresh.Enabled := true;
      Caption := 'Редактирование папки';
      edFolderName.ReadOnly := false;
      edFolderName.Color := clWindow;
      lcbFolders.Enabled := true;
    end;
    omView:
    begin
      btnSave.Enabled := false;
      tbSave.Enabled := false;
      tbGenSQL.Enabled := true;
      btnRefresh.Enabled := true;
      tbRefresh.Enabled := true;
      Caption := 'Свойства папки';
      edFolderName.ReadOnly := true;
      edFolderName.Color := clBtnFace;
      lcbFolders.Enabled := false;
    end;
  end;
end;

end.
