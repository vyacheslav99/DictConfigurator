unit addRank;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, settings, utils, main, StdCtrls,
  Buttons, DB, FIBDataSet, pFIBDataSet, DBGridEh, Mask, DBCtrlsEh, DBLookupEh;

type
  TFAddRank = class(TForm)
    dsUnitStruct: TpFIBDataSet;
    dsUnitStructPK: TFIBIntegerField;
    dsUnitStructNAME: TFIBStringField;
    dsUnitStructDEPARTMENT: TFIBStringField;
    dsUnitStructOFFICE: TFIBStringField;
    dsUnitStructCHAPTER: TFIBStringField;
    dsUnitStructSECTOR: TFIBStringField;
    dsoUnitStruct: TDataSource;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    Label1: TLabel;
    lcbRank: TDBLookupComboboxEh;
    chbMain: TCheckBox;
    dsBranch: TpFIBDataSet;
    dsoBranch: TDataSource;
    Label2: TLabel;
    lcbBranch: TDBLookupComboboxEh;
    dsBranchPK: TFIBIntegerField;
    dsBranchNAME: TFIBStringField;
    dsBranchFULLNAME: TFIBStringField;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

procedure TFAddRank.FormCreate(Sender: TObject);
begin
  dsUnitStruct.Open;
  dsBranch.Open;
end;

end.