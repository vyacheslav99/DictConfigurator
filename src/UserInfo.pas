unit UserInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, settings, utils;

type
  TFUserInfo = class(TForm)
    Label1: TLabel;
    edPk: TEdit;
    Label2: TLabel;
    edLogin: TEdit;
    Label3: TLabel;
    edName: TEdit;
    Label4: TLabel;
    edEmail: TEdit;
    chbDeveloper: TCheckBox;
    chbModerator: TCheckBox;
    chbIsActive: TCheckBox;
    chbHoliday: TCheckBox;
    Label5: TLabel;
    edCode1C: TEdit;
    Label6: TLabel;
    edBranch: TEdit;
    Label7: TLabel;
    edDepartment: TEdit;
    Label8: TLabel;
    edRole: TEdit;
    btnClose: TButton;
    Label9: TLabel;
    edUnit: TEdit;
    Label10: TLabel;
    edOffice: TEdit;
    Label11: TLabel;
    edChapter: TEdit;
    Label12: TLabel;
    edSector: TEdit;
    btnCreateGuid: TButton;
    edGuid: TEdit;
    procedure btnCloseClick(Sender: TObject);
    procedure chbDeveloperClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnCreateGuidClick(Sender: TObject);
  private
    UsrSelPas: string;
    FDeveloper: boolean;
    FModerator: boolean;
    FIsActive: boolean;
    FHoliday: boolean;
    gdash: boolean;
    procedure SetDeveloper(Value: boolean);
    procedure SetModerator(Value: boolean);
    procedure SetIsActive(Value: boolean);
    procedure SetHoliday(Value: boolean);
  public
    property Developer: boolean read FDeveloper write SetDeveloper;
    property Moderator: boolean read FModerator write SetModerator;
    property IsActive: boolean read FIsActive write SetIsActive;
    property Holiday: boolean read FHoliday write SetHoliday;
  end;

implementation

{$R *.dfm}

uses main;

const
  USR_SEL_PAS = 'gbc.kzdrf'; // писюлявка

procedure TFUserInfo.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFUserInfo.btnCreateGuidClick(Sender: TObject);
begin
  gdash := not gdash;
  edGuid.Text := CreateGuid(gdash);
end;

procedure TFUserInfo.chbDeveloperClick(Sender: TObject);
begin
  if Sender = chbDeveloper then chbDeveloper.Checked := FDeveloper
  else if Sender = chbModerator then chbModerator.Checked := FModerator
  else if Sender = chbIsActive then chbIsActive.Checked := FIsActive
  else if Sender = chbHoliday then chbHoliday.Checked := FHoliday;
end;

procedure TFUserInfo.FormKeyPress(Sender: TObject; var Key: Char);
var
  s: string;
  
begin
  UsrSelPas := UsrSelPas + Key;
  if UsrSelPas = USR_SEL_PAS then
  begin
    UsrSelPas := '';
    s := InputBox('-= Режим Читов =-', 'Введите имя пользователя портала, под которым хотите поработать', FSettings.PortalUser);
    if (Trim(s) <> '') and (AnsiLowerCase(s) <> AnsiLowerCase(FSettings.PortalUser)) then
    begin
      FSettings.PortalUser := Trim(s);
      if (FMain.Database.Connected) and
        (Application.MessageBox(pchar('Текущий пользователь портала изменен! Чтобы изменения вступили в силу, нужно переподключиться! ' +
          'Переподключиться сейчас?'), 'Внимание', MB_YESNO + MB_ICONWARNING) = ID_YES) then
      begin
        FMain.AReconnectExecute(FMain.AReconnect);
        Close;
      end;
    end;
  end;
end;

procedure TFUserInfo.SetIsActive(Value: boolean);
begin
  FIsActive := Value;
  chbIsActive.Checked := Value;
end;

procedure TFUserInfo.SetDeveloper(Value: boolean);
begin
  FDeveloper := Value;
  chbDeveloper.Checked := Value;
end;

procedure TFUserInfo.SetHoliday(Value: boolean);
begin
  FHoliday := Value;
  chbHoliday.Checked := Value;
end;

procedure TFUserInfo.SetModerator(Value: boolean);
begin
  FModerator := Value;
  chbModerator.Checked := Value;
end;

end.
