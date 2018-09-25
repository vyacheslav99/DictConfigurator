unit chartEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Spin,
  DB, Mask, DBCtrlsEh, DBLookupEh, utils, ActnList, DBAccess, Uni, UniProvider, PostgreSQLUniProvider, OracleUniProvider,
  MySQLUniProvider, InterBaseUniProvider, MemDS, dbUtils, DBGridEh, main, childForm, ComCtrls;

type
  TFChartEditor = class(TChildForm)
    GroupBox1: TGroupBox;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    Label2: TLabel;
    edPk: TEdit;
    Bevel1: TBevel;
    dsoFields: TDataSource;
    lcbXField: TDBLookupComboboxEh;
    Label3: TLabel;
    Label8: TLabel;
    Bevel2: TBevel;
    Label10: TLabel;
    edTitle: TEdit;
    Label11: TLabel;
    Label14: TLabel;
    cbChartType: TComboBox;
    edXAxisRotate: TDBNumberEditEh;
    ActionList: TActionList;
    ASave: TAction;
    Label1: TLabel;
    lcbYField: TDBLookupComboboxEh;
    Label4: TLabel;
    lcbSDField: TDBLookupComboboxEh;
    Label5: TLabel;
    cbGroupFunction: TComboBox;
    Label6: TLabel;
    edOrder: TEdit;
    Label7: TLabel;
    edYTitle: TEdit;
    Label9: TLabel;
    edAdditionalFieldRotate: TDBNumberEditEh;
    lcbGroup: TDBLookupComboboxEh;
    Label12: TLabel;
    Label13: TLabel;
    edGroupOrder: TDBNumberEditEh;
    dsoGroup: TDataSource;
    mAdditionalField: TRichEdit;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    grfKeyList: TStringList;
    function GetGruopFunction: string;
    procedure SetGruopFunction(Value: string);
    procedure SetMode(Value: TOpenMode); override;
  public
    EditingRec: TBookmark;
    procedure RegisterForm;
    function GetShortCaption: string; override;
    property GruopFunction: string read GetGruopFunction write SetGruopFunction;
  end;

implementation

{$R *.dfm}

procedure TFChartEditor.ASaveExecute(Sender: TObject);
begin
  if TAction(Sender).Enabled then btnSaveClick(btnSave);
end;

procedure TFChartEditor.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFChartEditor.btnSaveClick(Sender: TObject);
begin
  if Mode = omView then exit;
  Success := true;
  Close;
end;

procedure TFChartEditor.FormActivate(Sender: TObject);
begin
  ASave.Enabled := true;
  FMain.CheckFormButton(Tag);
end;

procedure TFChartEditor.FormCreate(Sender: TObject);
begin
  grfKeyList := TStringList.Create;
  grfKeyList.Text := 'SUM'#13#10'AVG'#13#10'COUNT'#13#10'MAX'#13#10'MIN'#13#10;
end;

procedure TFChartEditor.FormDeactivate(Sender: TObject);
begin
  ASave.Enabled := false;
end;

procedure TFChartEditor.FormDestroy(Sender: TObject);
begin
  grfKeyList.Free;
end;

function TFChartEditor.GetGruopFunction: string;
begin
  if cbGroupFunction.ItemIndex = -1 then result := ''
  else result := grfKeyList.Strings[cbGroupFunction.ItemIndex];
end;

function TFChartEditor.GetShortCaption: string;
begin
  if Mode = omAdd then
    result := Caption
  else
    result := 'График ' + iif(edTitle.Text = '', edPk.Text, edTitle.Text);
end;

procedure TFChartEditor.RegisterForm;
begin
  case Mode of
    omAdd: ;
    omEdit: Caption := GenCaption('График', 'редактирование', edPk.Text, '', edTitle.Text, false);
    omView: Caption := GenCaption('График', 'просмотр', edPk.Text, '', edTitle.Text, false);
  end;

  FMain.RegisterChildForm(Self);
end;

procedure TFChartEditor.SetGruopFunction(Value: string);
begin
  cbGroupFunction.ItemIndex := grfKeyList.IndexOf(Value);
end;

procedure TFChartEditor.SetMode(Value: TOpenMode);
begin
  inherited SetMode(Value);

  if Mode = omView then
  begin
    btnSave.Enabled := false;
    edTitle.ReadOnly := true;
    edTitle.Color := clBtnFace;
    cbChartType.Enabled := false;
    lcbGroup.ReadOnly := true;
    lcbGroup.Color := clBtnFace;
    edGroupOrder.ReadOnly := true;
    edGroupOrder.Color := clBtnFace;
    lcbXField.ReadOnly := true;
    lcbXField.Color := clBtnFace;
    lcbYField.ReadOnly := true;
    lcbYField.Color := clBtnFace;
    lcbSDField.ReadOnly := true;
    lcbSDField.Color := clBtnFace;
    cbGroupFunction.Enabled := false;
    edXAxisRotate.ReadOnly := true;
    edXAxisRotate.Color := clBtnFace;
    edOrder.ReadOnly := true;
    edOrder.Color := clBtnFace;
    edYTitle.ReadOnly := true;
    edYTitle.Color := clBtnFace;
    edAdditionalFieldRotate.ReadOnly := true;
    edAdditionalFieldRotate.Color := clBtnFace;
    mAdditionalField.ReadOnly := true;
    mAdditionalField.Color := clBtnFace;
  end;
end;

end.
