unit updates;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons;

type
  TFUpdates = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    reDescr: TRichEdit;
    btnSave: TBitBtn;
    btnCancel: TBitBtn;
    lbCurVersion: TLabel;
    lbAvailVersion: TLabel;
    Label5: TLabel;
    lbDate: TLabel;
    Label6: TLabel;
    lbFileSize: TLabel;
  private
  public
  end;

implementation

{$R *.dfm}

end.
