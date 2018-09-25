unit selUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, Mask, DB,
  DBGridEh, DBCtrlsEh, DBLookupEh, main, FIBDataSet, pFIBDataSet;

type
  TFSelUser = class(TForm)
    lbQuery: TLabel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    dsoUsers: TDataSource;
    lcbUsers: TDBLookupComboboxEh;
    dsUsers: TpFIBDataSet;
  private
  public
    procedure LoadData(SQLQuery: string);
  end;

implementation

{$R *.dfm}

{ TFSelUser }

procedure TFSelUser.LoadData(SQLQuery: string);
begin
  dsUsers.SelectSQL.Text := SQLQuery;
  dsUsers.Open;
  if dsUsers.RecordCount = 1 then lcbUsers.KeyValue := dsUsers.FieldByName('PK').Value;
end;

end.
