unit filterGroupEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Mask,
  utils, ActnList, settings, main, childForm, Spin, DB;

type
  TFFilterGroupEditor = class(TChildForm)
    GroupBox1: TGroupBox;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    Label2: TLabel;
    edPk: TEdit;
    Label10: TLabel;
    edTitle: TEdit;
    ActionList: TActionList;
    ASave: TAction;
    Label1: TLabel;
    edOrder: TSpinEdit;
    chbCollapsed: TCheckBox;
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

procedure TFFilterGroupEditor.ASaveExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then btnSaveClick(btnSave);
end;

procedure TFFilterGroupEditor.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFFilterGroupEditor.btnSaveClick(Sender: TObject);
begin
  if Mode = omView then exit;
  Success := true;
  Close;
end;

procedure TFFilterGroupEditor.FormActivate(Sender: TObject);
begin
  ASave.Enabled := true;
  FMain.CheckFormButton(Tag);
end;

procedure TFFilterGroupEditor.FormDeactivate(Sender: TObject);
begin
  ASave.Enabled := false;
end;

function TFFilterGroupEditor.GetShortCaption: string;
begin
  if Mode = omAdd then
    result := Caption
  else
    result := 'Гр. фильтров ' + iif(edTitle.Text = '', edPk.Text, edTitle.Text);
end;

procedure TFFilterGroupEditor.RegisterForm;
begin
  case Mode of
    omAdd: ;
    omEdit: Caption := GenCaption('Группа', 'редактирование', edPk.Text, '', edTitle.Text, false);
    omView: Caption := GenCaption('Группа', 'просмотр', edPk.Text, '', edTitle.Text, false);
  end;

  FMain.RegisterChildForm(Self);
end;

procedure TFFilterGroupEditor.SetMode(Value: TOpenMode);
begin
  inherited SetMode(Value);

  if Mode = omView then
  begin
    btnSave.Enabled := false;
    edTitle.ReadOnly := true;
    edTitle.Color := clBtnFace;
    edOrder.ReadOnly := true;
    edOrder.Color := clBtnFace;
    chbCollapsed.Enabled := false;
  end;
end;

end.
