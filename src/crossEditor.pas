unit crossEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Spin,
  DB, Mask, DBCtrlsEh, utils, ActnList, settings, main, childForm;

type
  TFCrossEditor = class(TChildForm)
    GroupBox1: TGroupBox;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    Label2: TLabel;
    edPk: TEdit;
    Label10: TLabel;
    edName: TEdit;
    Label11: TLabel;
    edNextState: TDBNumberEditEh;
    ActionList: TActionList;
    ASave: TAction;
    Label1: TLabel;
    edButtonOrder: TDBNumberEditEh;
    chbNeedClose: TCheckBox;
    chbShowInView: TCheckBox;
    chbAddButton: TCheckBox;
    Label3: TLabel;
    edHotKey: TEdit;
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

procedure TFCrossEditor.ASaveExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then btnSaveClick(btnSave);
end;

procedure TFCrossEditor.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFCrossEditor.btnSaveClick(Sender: TObject);
begin
  if Mode = omView then exit; 
  Success := true;
  Close;
end;

procedure TFCrossEditor.FormActivate(Sender: TObject);
begin
  ASave.Enabled := true;
  FMain.CheckFormButton(Tag);
end;

procedure TFCrossEditor.FormDeactivate(Sender: TObject);
begin
  ASave.Enabled := false;
end;

function TFCrossEditor.GetShortCaption: string;
begin
  if Mode = omAdd then
    result := Caption
  else
    result := 'Кнопка ' + iif(edName.Text = '', edPk.Text, edName.Text);
end;

procedure TFCrossEditor.RegisterForm;
begin
  case Mode of
    omAdd: ;
    omEdit: Caption := GenCaption('Кнопка', 'редактирование', edPk.Text, '', edName.Text, false);
    omView: Caption := GenCaption('Кнопка', 'просмотр', edPk.Text, '', edName.Text, false);
  end;

  FMain.RegisterChildForm(Self);
end;

procedure TFCrossEditor.SetMode(Value: TOpenMode);
begin
  inherited SetMode(Value);

  if Mode = omView then
  begin
    btnSave.Enabled := false;
    edName.ReadOnly := true;
    edName.Color := clBtnFace;
    edNextState.ReadOnly := true;
    edNextState.Color := clBtnFace;
    edButtonOrder.ReadOnly := true;
    edButtonOrder.Color := clBtnFace;
    chbNeedClose.Enabled := false;
    chbShowInView.Enabled := false;
    chbAddButton.Enabled := false;
    edHotKey.ReadOnly := true;
    edHotKey.Color := clBtnFace;
  end;
end;

end.
