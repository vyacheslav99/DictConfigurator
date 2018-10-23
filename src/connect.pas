unit connect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, settings, utils, TypInfo;

type
  TFConnect = class(TForm)
    GroupBox1: TGroupBox;
    btnConnect: TBitBtn;
    btnCancel: TBitBtn;
    Label1: TLabel;
    cbConnection: TComboBox;
    Bevel1: TBevel;
    lbDatabase: TLabel;
    Label8: TLabel;
    edUser: TEdit;
    Label9: TLabel;
    edPass: TEdit;
    Label21: TLabel;
    edRole: TEdit;
    Label17: TLabel;
    Label20: TLabel;
    cbSQLDialect: TComboBox;
    cbCharset: TComboBox;
    Label2: TLabel;
    edType: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cbConnectionChange(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    r_ok: boolean;
    IndexCache: TStringList;
    procedure LoadConnections;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    function SelectedIndex: integer;
  end;

implementation

{$R *.dfm}

uses main;

procedure TFConnect.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFConnect.btnConnectClick(Sender: TObject);
begin
  if (cbConnection.ItemIndex = -1) or (FSettings.ConnByIndex[SelectedIndex].Server <> stFirebird) then
  begin
    Application.MessageBox('В качестве основного можно использовать только Firebird сервер!', 'Ошибка', MB_OK + MB_ICONERROR);
    exit;
  end;

  r_ok := true;
  Close;
end;

procedure TFConnect.cbConnectionChange(Sender: TObject);
var
  c: TConnection;
  s: string;
  defPort: integer;

begin
  if cbConnection.ItemIndex = -1 then
  begin
    cbCharset.Items.Text := '';
    lbDatabase.Caption := '';
    edUser.Text := '';
    edPass.Text := '';
    edRole.Text := '';
    cbCharset.ItemIndex := -1;
    cbSQLDialect.ItemIndex := 0;
    btnConnect.Enabled := false;
    edType.Text := '';
  end else
  begin
    c := FSettings.ConnByIndex[SelectedIndex];
    if c.Server <> stFirebird then btnConnect.Enabled := false
    else btnConnect.Enabled := true;

    case c.Server of
      stFirebird:
      begin
        defPort := 3050;
        cbCharset.Items.Text := StringReplace(FBENCODINGS, ',', #13#10, [rfReplaceAll]);
      end;
      stOracle:
      begin
        defPort := 1521;
        cbCharset.Items.Text := '';
      end;
      stPostgreSQL:
      begin
        defPort := 5432;
        cbCharset.Items.Text := StringReplace(PGENCODINGS, ',', #13#10, [rfReplaceAll]);
      end;
      stMySQL:
      begin
        defPort := 3306;
        cbCharset.Items.Text := StringReplace(MYENCODINGS, ',', #13#10, [rfReplaceAll]);
      end;
    end;

    if c.Host <> '' then
    begin
      if c.Port = defPort then s := c.Host
      else s := c.Host + '/' + IntToStr(c.Port);
      s := s + ':';
    end;
    lbDatabase.Caption := s + c.DataBase;
    if c.AlwaysPromptPass then
    begin
      edUser.Text := '';
      edPass.Text := '';
      edRole.Text := '';
    end else
    begin
      edUser.Text := c.UserName;
      edPass.Text := c.Pass;
      edRole.Text := c.Role;
    end;
    cbCharset.ItemIndex := cbCharset.Items.IndexOf(c.Encoding);
    cbSQLDialect.ItemIndex := cbSQLDialect.Items.IndexOf(IntToStr(c.SQLDialect));
    edType.Text := Copy(GetEnumName(TypeInfo(TConnectionType), Ord(c.ConnType)), 3, 10);
  end;
end;

procedure TFConnect.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if not FMain.Visible then
    Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TFConnect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
  if r_ok then
  begin
    ModalResult := mrOk;
    FSettings.CurrConnect := SelectedIndex;
  end else
    ModalResult := mrCancel;
end;

procedure TFConnect.FormCreate(Sender: TObject);
begin
  r_ok := false;
  IndexCache := TStringList.Create;
  lbDatabase.Caption := '';
  //cbConnection.Items.Assign(FSettings.cbConnection.Items);
  LoadConnections;
  cbConnection.ItemIndex := IndexCache.IndexOf(IntToStr(FSettings.CurrConnect));
  cbConnectionChange(cbConnection);
end;

procedure TFConnect.FormDestroy(Sender: TObject);
begin
  IndexCache.Free;
end;

procedure TFConnect.LoadConnections;
var
  i: integer;

begin
  cbConnection.Items.Clear;
  IndexCache.Clear;
  
  for i := 0 to FSettings.cbConnection.Items.Count - 1 do
  begin
    if FSettings.ConnByIndex[i].AllowLogin then
    begin
      cbConnection.Items.Add(FSettings.cbConnection.Items.Strings[i]);
      IndexCache.Add(IntToStr(i));
    end;
  end;
end;

function TFConnect.SelectedIndex: integer;
begin
  result := -1;
  if (cbConnection.ItemIndex > -1) and (cbConnection.ItemIndex < IndexCache.Count) then
    result := StrToInt(IndexCache.Strings[cbConnection.ItemIndex]);
end;

end.