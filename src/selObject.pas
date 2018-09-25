unit selObject;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFSelObject = class(TForm)
    Label1: TLabel;
    cbObject: TComboBox;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
  private
  public
  end;

implementation

{$R *.dfm}

end.
