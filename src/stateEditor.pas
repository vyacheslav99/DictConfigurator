unit stateEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Spin,
  DB, Mask, DBCtrlsEh, DBLookupEh, utils, ActnList, DBAccess, MemDS, DBGridEh, settings, main, childForm;

type
  TFStateEditor = class(TChildForm)
    GroupBox1: TGroupBox;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    Label2: TLabel;
    edPk: TEdit;
    Bevel1: TBevel;
    dsoForm: TDataSource;
    lcbForm: TDBLookupComboboxEh;
    Label3: TLabel;
    Label8: TLabel;
    mFieldJson: TMemo;
    Label10: TLabel;
    edDescriptor: TEdit;
    Label11: TLabel;
    Label14: TLabel;
    cbAction: TComboBox;
    edFormWidth: TDBNumberEditEh;
    ActionList: TActionList;
    ASave: TAction;
    Label1: TLabel;
    edFormHeight: TDBNumberEditEh;
    chbFullScreen: TCheckBox;
    chbSafeClose: TCheckBox;
    chbMayDouble: TCheckBox;
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

procedure TFStateEditor.ASaveExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then btnSaveClick(btnSave);
end;

procedure TFStateEditor.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFStateEditor.btnSaveClick(Sender: TObject);
begin
  if Mode = omView then exit;
  Success := true;
  Close;
end;

procedure TFStateEditor.FormActivate(Sender: TObject);
begin
  ASave.Enabled := true;
  FMain.CheckFormButton(Tag);
end;

procedure TFStateEditor.FormDeactivate(Sender: TObject);
begin
  ASave.Enabled := false;
end;

function TFStateEditor.GetShortCaption: string;
begin
  if Mode = omAdd then
    result := Caption
  else
    result := 'Состояние ' + lcbForm.Text + iif(edDescriptor.Text <> '', ' : ' + edDescriptor.Text, '');
end;

procedure TFStateEditor.RegisterForm;
begin
  case Mode of
    omAdd: ;
    omEdit: Caption := GenCaption('Состояние', 'редактирование', edPk.Text, edDescriptor.Text, lcbForm.Text, FSettings.TreeShowDescriptor);
    omView: Caption := GenCaption('Состояние', 'просмотр', edPk.Text, edDescriptor.Text, lcbForm.Text, FSettings.TreeShowDescriptor);
  end;

  FMain.RegisterChildForm(Self);
end;

procedure TFStateEditor.SetMode(Value: TOpenMode);
begin
  inherited SetMode(Value);

  if Mode = omView then
  begin
    btnSave.Enabled := false;
    edDescriptor.ReadOnly := true;
    edDescriptor.Color := clBtnFace;
    lcbForm.ReadOnly := true;
    lcbForm.Color := clBtnFace;
    edFormWidth.ReadOnly := true;
    edFormWidth.Color := clBtnFace;
    edFormHeight.ReadOnly := true;
    edFormHeight.Color := clBtnFace;
    cbAction.Enabled := false;
    chbFullScreen.Enabled := false;
    chbSafeClose.Enabled := false;
    chbMayDouble.Enabled := false;
    mFieldJson.ReadOnly := true;
    mFieldJson.Color := clBtnFace;
  end;
end;

end.
