unit tmplEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ActnList, DB,
  utils, childForm, main, tmplConstructor;

type
  TFTmplEditor = class(TChildForm)
    GroupBox1: TGroupBox;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    ActionList: TActionList;
    ASave: TAction;
    sbEditTemplate: TSpeedButton;
    mTemplate: TMemo;
    lbTemplateName: TLabel;
    btnCreate: TBitBtn;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure sbEditTemplateClick(Sender: TObject);
  private
    procedure SetMode(Value: TOpenMode); override;
  public
    EditingRec: TBookmark;
    FieldPK: integer;
    FieldName: string;
    FieldTitle: string;
    TmplField: string;
    procedure RegisterForm;
    function GetShortCaption: string; override;
  end;

implementation

{$R *.dfm}

uses editDict;

procedure TFTmplEditor.ASaveExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then btnSaveClick(btnSave);
end;

procedure TFTmplEditor.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFTmplEditor.btnSaveClick(Sender: TObject);
begin
  if Mode = omView then exit;
  Success := true;
  if Sender = btnCreate then Mode := omAdd;
  Close;
end;

procedure TFTmplEditor.FormActivate(Sender: TObject);
begin
  ASave.Enabled := true;
  FMain.CheckFormButton(Tag);
end;

procedure TFTmplEditor.FormDeactivate(Sender: TObject);
begin
  ASave.Enabled := false;
end;

function TFTmplEditor.GetShortCaption: string;
begin
  if Mode = omAdd then
    result := Caption
  else
    result := 'Шаблон прав ' + TmplField + ' - ' + FieldName;
end;

procedure TFTmplEditor.RegisterForm;
begin
  case Mode of
    omAdd: ;
    omEdit: Caption := GenCaption('Шаблон прав ' + TmplField, 'редактирование', IntToStr(GetObjectPK), FieldName, FieldTitle, true);
    omView: Caption := GenCaption('Шаблон прав ' + TmplField, 'просмотр', IntToStr(GetObjectPK), FieldName, FieldTitle, true);
  end;

  FMain.RegisterChildForm(Self);
end;

procedure TFTmplEditor.sbEditTemplateClick(Sender: TObject);
//var
//  CForm: TFTmplConstructor;
//  bm: TBookmark;

begin
//  if Mode = omView then exit;
//  if not sbEditTemplate.Enabled then
//  begin
//    Application.MessageBox('Этот тип шаблона представляет собой выражение питона, возвращающее тип bool. Для него невозможно использовать конструктор.',
//      'Сообщение', MB_OK + MB_ICONINFORMATION);
//    exit;
//  end;
//
//  try
//    bm := TFEditDict(Owner).mtFormFields.GetBookmark;
//    CForm := TFTmplConstructor.Create(self);
//    if CForm.Execute(TFEditDict(Owner).mtFormFields, ttStandart, mTemplate.Text) then
//      mTemplate.Text := CForm.Template;
//  finally
//    if TFEditDict(Owner).mtFormFields.BookmarkValid(bm) then
//    begin
//      TFEditDict(Owner).mtFormFields.GotoBookmark(bm);
//      TFEditDict(Owner).mtFormFields.FreeBookmark(bm);
//    end;
//    CForm.Free;
//  end;
end;

procedure TFTmplEditor.SetMode(Value: TOpenMode);
begin
  inherited SetMode(Value);

  if Mode = omView then
  begin
    btnSave.Enabled := false;
    mTemplate.ReadOnly := true;
    mTemplate.Color := clBtnFace;
    lbTemplateName.Enabled := false;
    sbEditTemplate.Enabled := false;
  end;
end;

end.
