unit eventEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Spin,
  DB, Mask, DBCtrlsEh, DBLookupEh, utils, ActnList, DBAccess, Uni, UniProvider, PostgreSQLUniProvider, OracleUniProvider,
  MySQLUniProvider, InterBaseUniProvider, MemDS, dbUtils, DBGridEh, main, childForm, ComCtrls;

type
  TFEventEditor = class(TChildForm)
    GroupBox1: TGroupBox;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    Label2: TLabel;
    edPk: TEdit;
    Bevel1: TBevel;
    dsoEvtDicts: TDataSource;
    lcbReference: TDBLookupComboboxEh;
    Label3: TLabel;
    Label10: TLabel;
    edTitle: TEdit;
    Label14: TLabel;
    cbViewToMenu: TComboBox;
    ActionList: TActionList;
    ASave: TAction;
    Label13: TLabel;
    Label12: TLabel;
    edImage: TEdit;
    Label1: TLabel;
    edCssClassName: TEdit;
    Label4: TLabel;
    lcbIsWizard: TDBLookupComboboxEh;
    dsoEvtWizards: TDataSource;
    Label5: TLabel;
    lcbAliasForm: TDBLookupComboboxEh;
    dsoEvtForms: TDataSource;
    edPosition: TSpinEdit;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    procedure SetMode(Value: TOpenMode); override;
  public
    EditingRec: TBookmark;
    procedure RegisterForm;
    function GetShortCaption: string; override;
  end;

implementation

{$R *.dfm}

procedure TFEventEditor.ASaveExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then btnSaveClick(btnSave);
end;

procedure TFEventEditor.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFEventEditor.btnSaveClick(Sender: TObject);
begin
  if Mode = omView then exit;
  Success := true;
  Close;
end;

procedure TFEventEditor.FormActivate(Sender: TObject);
begin
  ASave.Enabled := true;
  FMain.CheckFormButton(Tag);
end;

procedure TFEventEditor.FormDeactivate(Sender: TObject);
begin
  ASave.Enabled := false;
end;

function TFEventEditor.GetShortCaption: string;
begin
  if Mode = omAdd then
    result := Caption
  else
    result := 'Кнопка ' + iif(edTitle.Text = '', edPk.Text, edTitle.Text);
end;

procedure TFEventEditor.RegisterForm;
begin
  case Mode of
    omAdd: ;
    omEdit: Caption := GenCaption('Кнопка', 'редактирование', edPk.Text, '', edTitle.Text, false);
    omView: Caption := GenCaption('Кнопка', 'просмотр', edPk.Text, '', edTitle.Text, false);
  end;

  FMain.RegisterChildForm(Self);
end;

procedure TFEventEditor.SetMode(Value: TOpenMode);
begin
  inherited SetMode(Value);

  if Mode = omView then
  begin
    btnSave.Enabled := false;
    edTitle.ReadOnly := true;
    edTitle.Color := clBtnFace;
    edPosition.ReadOnly := true;
    edPosition.Color := clBtnFace;
    cbViewToMenu.Enabled := false;
    edImage.ReadOnly := true;
    edImage.Color := clBtnFace;
    edCssClassName.ReadOnly := true;
    edCssClassName.Color := clBtnFace;
    lcbReference.ReadOnly := true;
    lcbReference.Color := clBtnFace;
    lcbIsWizard.ReadOnly := true;
    lcbIsWizard.Color := clBtnFace;
    lcbAliasForm.ReadOnly := true;
    lcbAliasForm.Color := clBtnFace;
  end;
end;

end.
