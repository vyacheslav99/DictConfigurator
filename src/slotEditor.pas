unit slotEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Mask,
  utils, DB, ActnList, settings, main, childForm;

type
  TFSlotEditor = class(TChildForm)
    GroupBox1: TGroupBox;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    Label2: TLabel;
    edPk: TEdit;
    Label10: TLabel;
    edName: TEdit;
    ActionList: TActionList;
    ASave: TAction;
    chbMainSlot: TCheckBox;
    Label14: TLabel;
    cbType: TComboBox;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    procedure SetMode(Value: TOpenMode); override;
  public
    IsScenSlot: boolean;
    EditingRec: TBookmark;
    procedure RegisterForm;
    function GetShortCaption: string; override;
  end;

implementation

{$R *.dfm}

procedure TFSlotEditor.ASaveExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then btnSaveClick(btnSave);
end;

procedure TFSlotEditor.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFSlotEditor.btnSaveClick(Sender: TObject);
begin
  if Mode = omView then exit;
  Success := true;
  Close;
end;

procedure TFSlotEditor.FormActivate(Sender: TObject);
begin
  ASave.Enabled := true;
  FMain.CheckFormButton(Tag);
end;

procedure TFSlotEditor.FormDeactivate(Sender: TObject);
begin
  ASave.Enabled := false;
end;

function TFSlotEditor.GetShortCaption: string;
begin
  if Mode = omAdd then
    result := Caption
  else
    result := 'Слот ' + iif(IsScenSlot, 'сцен. ', 'сост. ') + iif(edName.Text = '', edPk.Text, edName.Text);
end;

procedure TFSlotEditor.RegisterForm;
begin
  case Mode of
    omAdd: ;
    omEdit: Caption := GenCaption('Слот ' + iif(IsScenSlot, 'сценария', 'состояния'), 'редактирование', edPk.Text, '', edName.Text, false);
    omView: Caption := GenCaption('Слот ' + iif(IsScenSlot, 'сценария', 'состояния'), 'просмотр', edPk.Text, '', edName.Text, false);
  end;

  FMain.RegisterChildForm(Self);
end;

procedure TFSlotEditor.SetMode(Value: TOpenMode);
begin
  inherited SetMode(Value);

  if Mode = omView then
  begin
    btnSave.Enabled := false;
    edName.ReadOnly := true;
    edName.Color := clBtnFace;
    cbType.Enabled := false;
    chbMainSlot.Enabled := false;
  end;
end;

end.
