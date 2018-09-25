unit ensFolder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvDBLookupTreeView, StdCtrls, DB, MemDS, DBAccess, Uni, Buttons;

type
  TFEditEnsFolder = class(TForm)
    dsEnsFolders: TUniQuery;
    dsEnsFoldersPK: TIntegerField;
    dsEnsFoldersNAME: TWideStringField;
    dsEnsFoldersPARENT_PK: TIntegerField;
    dsEnsFoldersICON_INDEX: TIntegerField;
    dsoEnsFolders: TDataSource;
    Label1: TLabel;
    edName: TEdit;
    Label2: TLabel;
    lctFolder: TJvDBLookupTreeViewCombo;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
  private
  public
  end;

implementation

{$R *.dfm}

end.
