unit hintView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls;

type
  TFHint = class(TForm)
    reHintText: TRichEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses main;

procedure TFHint.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FMain.miShowHint.Checked := false;
  Action := caHide;
end;

end.
