unit slotValEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Mask,
  utils, DB, ActnList, settings, DBCtrlsEh, main, childForm;

type
  TFSlotValEditor = class(TChildForm)
    GroupBox1: TGroupBox;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    Label2: TLabel;
    edPk: TEdit;
    Label10: TLabel;
    edSlotValue: TEdit;
    ActionList: TActionList;
    ASave: TAction;
    Label11: TLabel;
    edCross: TDBNumberEditEh;
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

procedure TFSlotValEditor.ASaveExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then btnSaveClick(btnSave);
end;

procedure TFSlotValEditor.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFSlotValEditor.btnSaveClick(Sender: TObject);
begin
  if Mode = omView then exit;
  Success := true;
  Close;
end;

procedure TFSlotValEditor.FormActivate(Sender: TObject);
begin
  ASave.Enabled := true;
  FMain.CheckFormButton(Tag);
end;

procedure TFSlotValEditor.FormDeactivate(Sender: TObject);
begin
  ASave.Enabled := false;
end;

function TFSlotValEditor.GetShortCaption: string;
begin
  if Mode = omAdd then
    result := Caption
  else
    result := 'Значение слота ' + edPk.Text;
end;

procedure TFSlotValEditor.RegisterForm;
begin
  case Mode of
    omAdd: ;
    omEdit: Caption := GenCaption('Значение слота', 'редактирование', edPk.Text, '', '', false);
    omView: Caption := GenCaption('Значение слота', 'просмотр', edPk.Text, '', '', false);
  end;

  FMain.RegisterChildForm(Self);
end;

procedure TFSlotValEditor.SetMode(Value: TOpenMode);
begin
  inherited SetMode(Value);

  if Mode = omView then
  begin
    btnSave.Enabled := false;
    edCross.ReadOnly := true;
    edCross.Color := clBtnFace;
    edSlotValue.ReadOnly := true;
    edSlotValue.Color := clBtnFace;
  end;
end;

end.
