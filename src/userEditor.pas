unit userEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Spin,
  DB, Mask, DBCtrlsEh, DBLookupEh, utils, DBGridEh, ActnList, DBAccess, MemDS, main, childForm, FIBDataSet, pFIBDataSet;

type
  TFUserEditor = class(TChildForm)
    GroupBox1: TGroupBox;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    Label2: TLabel;
    edPk: TEdit;
    Label4: TLabel;
    Bevel1: TBevel;
    chbModerator: TCheckBox;
    dsoRole: TDataSource;
    cbRole: TDBLookupComboboxEh;
    Label3: TLabel;
    Label10: TLabel;
    edName: TEdit;
    chbIsActive: TCheckBox;
    chbDeveloper: TCheckBox;
    chbHoliday: TCheckBox;
    ActionList: TActionList;
    ASave: TAction;
    edLogin: TEdit;
    dsRoles: TpFIBDataSet;
    dsRolesPK: TFIBIntegerField;
    dsRolesNAME: TFIBStringField;
    Label15: TLabel;
    edCode1s: TEdit;
    Label16: TLabel;
    edEmail: TEdit;
    Label17: TLabel;
    edShortName: TEdit;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    procedure SetMode(Value: TOpenMode); override;
  public
    procedure RegisterForm;
    function GetShortCaption: string; override;
  end;

implementation

{$R *.dfm}

uses users;

procedure TFUserEditor.ASaveExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then btnSaveClick(btnSave);
end;

procedure TFUserEditor.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFUserEditor.btnSaveClick(Sender: TObject);
begin
  if Mode = omView then exit;
  Success := true;
  Close;
end;

procedure TFUserEditor.FormActivate(Sender: TObject);
begin
  ASave.Enabled := true;
  FMain.CheckFormButton(Tag);
end;

procedure TFUserEditor.FormCreate(Sender: TObject);
begin
  dsRoles.Open;
end;

procedure TFUserEditor.FormDeactivate(Sender: TObject);
begin
  ASave.Enabled := false;
end;

function TFUserEditor.GetShortCaption: string;
begin
  if Mode = omAdd then
    result := Caption
  else
    result := edLogin.Text + ' : ' + edName.Text;
end;

procedure TFUserEditor.RegisterForm;
begin
  case Mode of
    omAdd: ;
    omEdit: Caption := GenCaption('', 'редактирование', edPk.Text, edLogin.Text, edName.Text, true);
    omView: Caption := GenCaption('', 'просмотр', edPk.Text, edLogin.Text, edName.Text, true);
  end;

  FMain.RegisterChildForm(Self);
end;

procedure TFUserEditor.SetMode(Value: TOpenMode);
begin
  inherited SetMode(Value);

  if Mode = omView then
  begin
    btnSave.Enabled := false;
    edPk.ReadOnly := true;
    edPk.Color := clBtnFace;
    edLogin.ReadOnly := true;
    edLogin.Color := clBtnFace;
    edName.ReadOnly := true;
    edName.Color := clBtnFace;
    cbRole.ReadOnly := true;
    cbRole.Color := clBtnFace;
    chbIsActive.Enabled := false;
    chbDeveloper.Enabled := false;
    chbModerator.Enabled := false;
    edCode1s.ReadOnly := true;
    edCode1s.Color := clBtnFace;
    edShortName.ReadOnly := true;
    edShortName.Color := clBtnFace;
    edEmail.ReadOnly := true;
    edEmail.Color := clBtnFace;
    chbHoliday.Enabled := false;
  end;
end;

end.
