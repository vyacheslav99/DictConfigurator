unit scriptEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, StdCtrls,
  SynEditHighlighter, SynHighlighterSQL, SynCompletionProposal, SynEdit, SynMemo, main, ActnList, ExtCtrls;

type
  TFScriptEditor = class(TForm)
    btnExec: TBitBtn;
    btnClose: TBitBtn;
    btnSaveToFile: TBitBtn;
    btnCopyToClipboard: TBitBtn;
    SynCompletionProposal: TSynCompletionProposal;
    SynAutoComplete: TSynAutoComplete;
    SynSQLSyn: TSynSQLSyn;
    smScript: TSynMemo;
    ActionList: TActionList;
    ACopy: TAction;
    ASelectAll: TAction;
    Panel1: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveToFileClick(Sender: TObject);
    procedure btnCopyToClipboardClick(Sender: TObject);
    procedure ACopyExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure ASelectAllExecute(Sender: TObject);
  private
    procedure CopyToClipboard;
  public
  end;

implementation

{$R *.dfm}

procedure TFScriptEditor.ACopyExecute(Sender: TObject);
begin
  smScript.CopyToClipboard;
end;

procedure TFScriptEditor.ASelectAllExecute(Sender: TObject);
begin
  smScript.SelectAll;
end;

procedure TFScriptEditor.btnCopyToClipboardClick(Sender: TObject);
begin
  CopyToClipboard;
  Application.MessageBox('Скрипт скопирован в буфер обмена', 'Сообщение', MB_OK + MB_ICONINFORMATION);
end;

procedure TFScriptEditor.btnSaveToFileClick(Sender: TObject);
begin
  FMain.SetSaveDialogToSQL;
  if FMain.SaveDialog.Execute then smScript.Lines.SaveToFile(FMain.SaveDialog.FileName);
end;

procedure TFScriptEditor.CopyToClipboard;
var
  selStart, selEnd: integer;

begin
  smScript.BeginUpdate;
  try
    selStart := smScript.SelStart;
    selEnd := smScript.SelEnd;
    smScript.SelectAll;
    smScript.CopyToClipboard;
  finally
    smScript.SelStart := selStart;
    smScript.SelEnd := selEnd;
    smScript.EndUpdate;
  end;
end;

procedure TFScriptEditor.FormActivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, true);
end;

procedure TFScriptEditor.FormCreate(Sender: TObject);
begin
  SynSQLSyn.TableNames.AddStrings(FMain.DbObjectList);
end;

procedure TFScriptEditor.FormDeactivate(Sender: TObject);
begin
  FMain.ActivateActions(ActionList, false);
end;

end.
