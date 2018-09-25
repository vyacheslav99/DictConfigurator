unit chartGroupEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Mask,
  utils, DB, ActnList, settings, DBCtrlsEh, main, childForm;

type
  TFChartGroupEditor = class(TChildForm)
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
    cbOrientation: TComboBox;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure SetMode(Value: TOpenMode); override;
  public
    Orientations: TStringList;
    EditingRec: TBookmark;
    procedure RegisterForm;
    function GetShortCaption: string; override;
  end;

implementation

{$R *.dfm}

procedure TFChartGroupEditor.ASaveExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then btnSaveClick(btnSave);
end;

procedure TFChartGroupEditor.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFChartGroupEditor.btnSaveClick(Sender: TObject);
begin
  if Mode = omView then exit;
  Success := true;
  Close;
end;

procedure TFChartGroupEditor.FormActivate(Sender: TObject);
begin
  ASave.Enabled := true;
  FMain.CheckFormButton(Tag);
end;

procedure TFChartGroupEditor.FormCreate(Sender: TObject);
begin
  Orientations := TStringList.Create;
  Orientations.Text := 'horizontal'#13#10'vertical';
end;

procedure TFChartGroupEditor.FormDeactivate(Sender: TObject);
begin
  ASave.Enabled := false;
end;

procedure TFChartGroupEditor.FormDestroy(Sender: TObject);
begin
  Orientations.Free;
end;

function TFChartGroupEditor.GetShortCaption: string;
begin
  if Mode = omAdd then
    result := Caption
  else
    result := 'Гр. графиков ' + iif(edTitle.Text = '', edPk.Text, edTitle.Text);
end;

procedure TFChartGroupEditor.RegisterForm;
begin
  case Mode of
    omAdd: ;
    omEdit: Caption := GenCaption('Группа', 'редактирование', edPk.Text, '', edTitle.Text, false);
    omView: Caption := GenCaption('Группа', 'просмотр', edPk.Text, '', edTitle.Text, false);
  end;

  FMain.RegisterChildForm(Self);
end;

procedure TFChartGroupEditor.SetMode(Value: TOpenMode);
begin
  inherited SetMode(Value);

  if Mode = omView then
  begin
    btnSave.Enabled := false;
    edTitle.ReadOnly := true;
    edTitle.Color := clBtnFace;
    cbOrientation.Enabled := false;
  end;
end;

end.
