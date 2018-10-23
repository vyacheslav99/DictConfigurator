unit dbUtils;

interface

uses Windows, Messages, Forms, SysUtils, Variants, Classes, Controls, ExtCtrls, DB, utils, Math, DBAccess, Uni, UniProvider,
  PostgreSQLUniProvider, OracleUniProvider, MySQLUniProvider, InterBaseUniProvider, MemDS, DBGridEh, GridsEh, settings,
  fib, FIBDatabase, pFIBDatabase, FIBDataSet, pFIBDataSet, DBGrids, Grids;

const
  PROCPARAM_insertValue = 'insertValue';
  PROCPARAM_loginnedUser = 'loginnedUser';
  PROCPARAM_user = 'user';
  PROC_PARAMS = PROCPARAM_insertValue + #13#10 + PROCPARAM_loginnedUser + #13#10 + PROCPARAM_user;

  LOGINED_USER_VALUES = '<?USER_CHAPTER?>'#13#10'<?USER_DEP?>'#13#10'<?USER_CODE_1C?>'#13#10'<?USER_DEP_DIR?>'#13#10 +
    '<?USER_FONT_COLOR?>'#13#10'<?USER_LOGIN?>'#13#10'<?USER_HOLIDAY?>'#13#10'<?USER_EMAIL?>'#13#10'<?USER_I_MODERATOR?>'#13#10 +
    '<?USER_USER_PK?>'#13#10'<?USER_OWNER_GROUP?>'#13#10'<?USER_UNIT_PK?>'#13#10'<?USER_SHORT_NAME?>'#13#10'<?USER_BG_COLOR?>'#13#10 +
    '<?USER_LIST_GROUP_NAME?>'#13#10'<?USER_WALLPAPER?>'#13#10'<?USER_MODERATOR?>'#13#10'<?USER_LASTDATE?>'#13#10'<?USER_BRANCH_PK?>'#13#10 +
    '<?USER_ACTIVEREASON?>'#13#10'<?USER_PK?>'#13#10'<?USER_ROLE_PK?>'#13#10'<?USER_LIST_GROUP_PK?>'#13#10'<?USER_LIST_GEO_PK?>'#13#10 +
    '<?USER_ISCONTENDER?>'#13#10'<?USER_TST_ROLE?>'#13#10'<?USER_GROUP_MEMBERSHIPS?>'#13#10'<?USER_ROLE_NAME?>'#13#10 +
    '<?USER_DOC_TREE_LIST?>'#13#10'<?USER_BRANCHAUTH?>'#13#10'<?USER_UNIT?>'#13#10'<?USER_RANK_PK?>'#13#10'<?USER_I_BOSS?>'#13#10 +
    '<?USER_ISOPINION?>'#13#10'<?USER_NAME?>'#13#10'<?USER_SHORTCUTS?>'#13#10'<?USER_PHOTO?>'#13#10'<?USER_COUNT_RANK?>'#13#10 +
    '<?USER_RANK_NAME?>'#13#10'<?USER_I_AM_A_BOSS?>'#13#10'<?USER_OWNER?>'#13#10'<?USER_SKIN_NAME?>'#13#10'<?USER_DEVELOPER?>'#13#10 +
    '<?USER_ISACTIVE?>'#13#10'<?USER_LIST_RANK_PK?>'#13#10'<?USER_LIST_RANK_NAME?>'#13#10'<?USER_CUR_MONTH?>'#13#10'<?USER_CUR_YEAR?>'#13#10 +
    '<?USER_REGION_PK?>';

  CHECK_CONN_INTERVAL = 3000;
  CHECK_CONN_QUERY = 'select * from RDB$DATABASE';

type
  TQueryType = (qtTables, qtViews, qtProcedures, qtFields, qtFieldType, qtProcParams, qtPrimaryKeys, qtFieldForeignKeys,
    qtReference, qtRefFields, qtRefFields2, qtUserDefined);

  TConnectManager = class
  private
    FOwner: TComponent;
    FConnectionsList: array of TUniConnection;
    FConnDescrList: array of string;
    function FindConnection(BaseDescriptor: string; var Idx: integer): TUniConnection;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure ClearConnections;
    function InitConnection(BaseDescriptor: string): TUniConnection; overload;
    function InitConnection(ConnIndex: integer): TUniConnection; overload;
    function GetSystemSQL(ServerType: TServerType; QueryType: TQueryType): string;
    function GetDataSet(BaseDescriptor: string; QueryType: TQueryType; UserDefinedSQL: string = ''): TUniQuery; overload;
    function GetDataSet(ConnIndex: integer; QueryType: TQueryType; UserDefinedSQL: string = ''): TUniQuery; overload;
    procedure SetSQLToDataSet(DataSet: TUniQuery; BaseDescriptor: string; QueryType: TQueryType; UserDefinedSQL: string = ''); overload;
    procedure SetSQLToDataSet(DataSet: TUniQuery; ConnIndex: integer; QueryType: TQueryType; UserDefinedSQL: string = ''); overload;
    function ExecSQL(SQL: string; ConnIndex: integer; var Err: string): boolean;
  end;

  TOnLostConnect = procedure(Connection: TObject; ErrorMessage: string) of object;

  TConnectChecker = class;
  
  TConnectionItem = class
  private
    FParent: TConnectChecker;
    FName: string;
    FActive: boolean;
    FIndex: integer;
    FConnection: TObject;
    FLastError: string;
    FOnLostConnect: TOnLostConnect;
    FPingInterval: Cardinal;
    FPingQuery: string;
    PingTimer: TTimer;
    UniQuery: TUniQuery;
    FIBDataSet: TpFIBDataSet;
    procedure OnPingTimer(Sender: TObject);
    procedure SetActive(Value: boolean);
    procedure SetConnection(Value: TObject);
    procedure SetPingInterval(Value: Cardinal);
    procedure SetPingQuery(Value: string);
    procedure CheckFib;
    procedure CheckUni;
  public
    constructor Create(AParent: TConnectChecker; AConnection: TObject; AOnLostConnect: TOnLostConnect; AInterval: Cardinal;
      APingQuery: string);
    destructor Destroy; override;
    property Active: boolean read FActive write SetActive;
    property Index: integer read FIndex;
    property Connection: TObject read FConnection write SetConnection;
    property PingInterval: Cardinal read FPingInterval write SetPingInterval;
    property PingQuery: string read FPingQuery write SetPingQuery;
    property LastError: string read FLastError;
    property Name: string read FName;
  end;
  
  TConnectChecker = class
  private
    FActive: boolean;
    FConnections: array of TConnectionItem;
    procedure SetActive(Value: boolean);
    function GetItem(Index: integer): TConnectionItem;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function Count: integer;
    function Add(AConnection: TObject; AOnLostConnect: TOnLostConnect; AInterval: Cardinal; APingQuery: string;
      AActive: boolean): TConnectionItem;
    function AddItem(AItem: TConnectionItem; AActive: boolean): integer;
    procedure Delete(Index: integer);
    procedure Start;
    procedure Stop;
    function FindItem(Name: string): integer;
    function ItemByName(Name: string): TConnectionItem;
    property Item[Index: integer]: TConnectionItem read GetItem;
    property Active: boolean read FActive write SetActive;
  end;

var
  ConnectionsList: TConnectManager;
  
function FindColumnByFieldName(Grid: TDBGridEh; FieldName: string): TColumnEh;
procedure CopyGrid(SrcGrid: TDBGridEh; DestGrid: TDBGrid);

implementation

{ TConnectManager }

procedure TConnectManager.ClearConnections;
var
  i: integer;

begin
  for i := 0 to Length(FConnectionsList) - 1 do
    if Assigned(FConnectionsList[i]) then
    begin
      FConnectionsList[i].Close;
      FreeAndNil(FConnectionsList[i]);
    end;

  SetLength(FConnectionsList, 0);
  SetLength(FConnDescrList, 0);
end;

constructor TConnectManager.Create(AOwner: TComponent);
begin
  inherited Create;
  FOwner := AOwner;
  ClearConnections;
end;

destructor TConnectManager.Destroy;
begin
  ClearConnections;
  inherited Destroy;
end;

function TConnectManager.ExecSQL(SQL: string; ConnIndex: integer; var Err: string): boolean;
var
  q: TUniSQL;

begin
  result := false;
  Err := '';

  q := TUniSQL.Create(nil);
  try
    q.Connection := InitConnection(ConnIndex);
    q.SQL.Text := SQL;
    try
      q.Execute;
      result := true;
    except
      on e: Exception do err := e.Message;
    end
  finally
    q.Free;
  end;
end;

function TConnectManager.FindConnection(BaseDescriptor: string; var Idx: integer): TUniConnection;
var
  i: integer;

begin
  result := nil;
  Idx := -1;
  if Trim(BaseDescriptor) = '' then exit;
  
  for i := 0 to Length(FConnDescrList) - 1 do
    if FConnDescrList[i] = BaseDescriptor then
    begin
      Idx := i;
      result := FConnectionsList[i];
      exit;
    end;
end;

function TConnectManager.GetDataSet(BaseDescriptor: string; QueryType: TQueryType; UserDefinedSQL: string): TUniQuery;
begin
  result := TUniQuery.Create(FOwner);
  {TUniQuery(result).Connection := InitConnection(BaseDescriptor);
  TUniQuery(result).SpecificOptions.Values[TUniQuery(result).Connection.ProviderName + '.FetchAll'] := 'True';}
  SetSQLToDataSet(result, BaseDescriptor, QueryType, UserDefinedSQL);
end;

function TConnectManager.GetDataSet(ConnIndex: integer; QueryType: TQueryType; UserDefinedSQL: string): TUniQuery;
begin
  result := TUniQuery.Create(FOwner);
  {TUniQuery(result).Connection := InitConnection(BaseDescriptor);
  TUniQuery(result).SpecificOptions.Values[TUniQuery(result).Connection.ProviderName + '.FetchAll'] := 'True';}
  SetSQLToDataSet(result, ConnIndex, QueryType, UserDefinedSQL);
end;

function TConnectManager.GetSystemSQL(ServerType: TServerType; QueryType: TQueryType): string;
begin
  case QueryType of
    qtTables:
    begin
      // только таблицы
      case ServerType of
        stFirebird: result := 'select RDB$RELATION_NAME NAME, ''TABLE'' TYPE_ from RDB$RELATIONS where ' +
          'RDB$SYSTEM_FLAG = 0 and RDB$VIEW_BLR is null order by RDB$RELATION_NAME';
        stOracle: result := 'select (t.OWNER || ''.'' || t.TABLE_NAME) NAME, cast(''TABLE'' as varchar2(32)) TYPE_ from ALL_TABLES t ' +
          'where upper(t.OWNER) not like ''%SYS%'' and t.STATUS = ''VALID'' and t.TEMPORARY = ''N'' and t.DROPPED = ''NO'' ' +
          'order by 1';
        stPostgreSQL: result := 'select (table_schema || ''.'' || table_name)::varchar "NAME", ''TABLE''::varchar TYPE_ ' +
          'from information_schema.tables ' +
          'where table_type = ''BASE TABLE'' and table_schema not in (''pg_catalog'', ''information_schema'') ' +
          'order by "NAME"';
        stMySQL: result := '';
      end;
    end;
    qtViews:
    begin
      // таблицы и представления
      case ServerType of
        stFirebird: result := 'select RDB$RELATION_NAME NAME, (case when RDB$VIEW_BLR is null then ''TABLE'' else ''VIEW'' end) TYPE_ ' +
          'from RDB$RELATIONS where RDB$SYSTEM_FLAG = 0 order by /*TYPE_,*/ RDB$RELATION_NAME';
        stOracle: result := 'select (t.OWNER || ''.'' || t.TABLE_NAME) NAME, cast(''TABLE'' as varchar2(32)) TYPE_ from ALL_TABLES t ' +
          'where upper(t.OWNER) not like ''%SYS%'' and t.STATUS = ''VALID'' and t.TEMPORARY = ''N'' and t.DROPPED = ''NO'' ' +
          'union all ' +
          'select (v.OWNER || ''.'' || v.VIEW_NAME) NAME, cast(''VIEW'' as varchar2(32)) TYPE_ from ALL_VIEWS v ' +
          'where upper(v.OWNER) not like ''%SYS%'' ' +
          'order by /*2,*/ 1';
        stPostgreSQL: result := 'select (table_schema || ''.'' || table_name)::varchar "NAME", ' +
          '(case table_type when ''BASE TABLE'' then ''TABLE'' else table_type end)::varchar TYPE_ ' +
          'from information_schema.tables ' +
          'where table_type in (''BASE TABLE'', ''VIEW'') and table_schema not in (''pg_catalog'', ''information_schema'') ' +
          'order by /*table_type,*/ table_name';
        stMySQL: result := '';
      end;
    end;
    qtProcedures:
    begin
      // таблицы, представления, процедуры
      case ServerType of
        stFirebird: result := 'select NAME, TYPE_ from ( ' +
          'select (case when RDB$VIEW_BLR is null then 0 else 1 end) OBJ_TYPE, RDB$RELATION_NAME NAME, ' +
          '(case when RDB$VIEW_BLR is null then ''TABLE'' else ''VIEW'' end) TYPE_ ' +
          'from RDB$RELATIONS where RDB$SYSTEM_FLAG = 0 ' +
          'union all ' +
          'select 2 OBJ_TYPE, RDB$PROCEDURE_NAME NAME, ''PROC'' TYPE_ from RDB$PROCEDURES where RDB$SYSTEM_FLAG = 0) ' +
          'order by /*OBJ_TYPE,*/ NAME';
        stOracle: result := 'select 0 OBJ_TYPE, (t.OWNER || ''.'' || t.TABLE_NAME) NAME, cast(''TABLE'' as varchar2(32)) TYPE_ from ALL_TABLES t ' +
          'where upper(t.OWNER) not like ''%SYS%'' and t.STATUS = ''VALID'' and t.TEMPORARY = ''N'' and t.DROPPED = ''NO'' ' +
          'union all ' +
          'select 1 OBJ_TYPE, (v.OWNER || ''.'' || v.VIEW_NAME) NAME, cast(''VIEW'' as varchar2(32)) TYPE_ from ALL_VIEWS v ' +
          'where upper(v.OWNER) not like ''%SYS%'' ' +
          {'union all ' +
          'select 2 TYPE, (p.object_name || ''.'' || p.PROCEDURE_NAME) NAME, cast(''PROC'' as varchar2(32)) TYPE_ from ALL_PROCEDURES p ' +
          'where PROCEDURE_NAME is not null and upper(p.OWNER) not like ''%SYS%'' ' +}
          'order by /*1,*/ 2';
        stPostgreSQL: result := 'select t.OBJ_TYPE, t."NAME", t.TYPE_ from ( ' +
          'select (case table_type when ''BASE TABLE'' then 0 else 1 end)::integer OBJ_TYPE, ' +
          '(table_schema || ''.'' || table_name)::varchar "NAME", ' +
          '(case table_type when ''BASE TABLE'' then ''TABLE'' else table_type end)::varchar TYPE_ ' +
          'from information_schema.tables ' +
          'where table_type in (''BASE TABLE'', ''VIEW'') and table_schema not in (''pg_catalog'', ''information_schema'') ' +
          'union all ' +
          'select 2::integer OBJ_TYPE, (specific_schema || ''.'' || routine_name)::varchar "NAME", ''PROC'' TYPE_ ' +
          'from information_schema.routines ' +
          'where specific_schema not in (''pg_catalog'', ''information_schema'')) t ' +
          'order by /*t.OBJ_TYPE,*/ t."NAME"';
        stMySQL: result := '';
      end;
    end;
    qtFields:
    begin
      // поля таблицы/представления или выходные параметры процедуры
      case ServerType of
        stFirebird: result := 'select FIELD_NAME from ( ' +
          'select RDB$FIELD_NAME FIELD_NAME, RDB$FIELD_POSITION NUM from RDB$RELATION_FIELDS ' +
          'where RDB$RELATION_NAME = upper(:NAME) and RDB$SYSTEM_FLAG = 0 ' +
          'union all ' +
          'select RDB$PARAMETER_NAME FIELD_NAME, RDB$PARAMETER_NUMBER NUM from RDB$PROCEDURE_PARAMETERS ' +
          'where RDB$PROCEDURE_NAME = upper(:NAME) and RDB$SYSTEM_FLAG = 0 and RDB$PARAMETER_TYPE = 1) ' +
          'order by NUM';
        stOracle: result := 'select distinct COLUMN_NAME FIELD_NAME from ALL_TAB_COLUMNS ' +
          'where upper(OWNER) || ''.'' || upper(TABLE_NAME) = upper(:NAME)';
        stPostgreSQL: result := 'select column_name::varchar FIELD_NAME, ordinal_position ' +
          'from information_schema.columns where lower(table_schema || ''.'' || table_name) = lower(:NAME) ' +
          'order by ordinal_position';
        stMySQL: result := '';
      end;
    end;
    qtFieldType:
    begin
      // тип поля и др. данные по полю
      case ServerType of
        stFirebird: result := 'select f.RDB$FIELD_NAME FIELD_NAME, ' +
          'case ft.RDB$SYSTEM_FLAG ' +
          '  when 1 then null ' +
          '  else ' +
          '    case when upper(f.RDB$FIELD_SOURCE) containing ''RDB$'' then null ' +
          '    else f.RDB$FIELD_SOURCE ' +
          '  end ' +
          'end DOMAIN_, ' +
          'case ft.RDB$FIELD_TYPE ' +
          '  when 7 then ''SMALLINT'' ' +
          '  when 8 then ''INTEGER'' ' +
          '  when 10 then ''FLOAT'' ' +
          '  when 12 then ''DATE'' ' +
          '  when 13 then ''TIME'' ' +
          '  when 14 then ''CHAR'' ' +
          '  when 16 then ' +
          '    case ft.RDB$FIELD_SUB_TYPE ' +
          '      when 0 then ''BIGINT'' ' +
          '      when 1 then ''NUMERIC'' ' +
          '      when 2 then ''DECIMAL'' ' +
          '    end ' +
          '  when 27 then ''DOUBLE PRECISION'' ' +
          '  when 35 then ''TIMESTAMP'' ' +
          '  when 37 then ''VARCHAR'' ' +
          '  when 261 then ''BLOB'' ' +
          '  else t.RDB$TYPE_NAME ' +
          'end FIELD_TYPE, ' +
          'case ft.RDB$FIELD_TYPE ' +
          '  when 16 then ' +
          '    case ft.RDB$FIELD_SUB_TYPE ' +
          '      when 0 then null ' +
          '      else ft.RDB$FIELD_PRECISION ' +
          '    end ' +
          '  when 261 then ft.RDB$SEGMENT_LENGTH ' +
          '  else ft.RDB$CHARACTER_LENGTH ' +
          'end SIZE_, ' +
          'coalesce(f.RDB$NULL_FLAG, ft.RDB$NULL_FLAG, 0) NULL_FLAG, ' +
          'coalesce(f.RDB$DEFAULT_SOURCE, ft.RDB$DEFAULT_SOURCE, null) DEFAULT_SOURCE, f.RDB$DESCRIPTION FIELD_DESCR ' +
          'from RDB$RELATION_FIELDS f ' +
          'left join RDB$FIELDS ft on ft.RDB$FIELD_NAME = f.RDB$FIELD_SOURCE ' +
          'left join RDB$TYPES t on t.RDB$TYPE = ft.RDB$FIELD_TYPE and t.RDB$FIELD_NAME = ''RDB$FIELD_TYPE'' ' +
          'where f.RDB$RELATION_NAME = upper(:TABLE_NAME) and f.RDB$FIELD_NAME = upper(:FIELD_NAME) ' +
          'union ' +
          'select p.RDB$PARAMETER_NAME FIELD_NAME, ' +
          'case p.RDB$SYSTEM_FLAG ' +
          '  when 1 then null ' +
          '  else ' +
          '    case when upper(p.RDB$FIELD_SOURCE) containing ''RDB$'' then null ' +
          '    else p.RDB$FIELD_SOURCE ' +
          '  end ' +
          'end DOMAIN_, ' +
          'case ft.RDB$FIELD_TYPE ' +
          '  when 7 then ''SMALLINT'' ' +
          '  when 8 then ''INTEGER'' ' +
          '  when 10 then ''FLOAT'' ' +
          '  when 12 then ''DATE'' ' +
          '  when 13 then ''TIME'' ' +
          '  when 14 then ''CHAR'' ' +
          '  when 16 then ' +
          '    case ft.RDB$FIELD_SUB_TYPE ' +
          '      when 0 then ''BIGINT'' ' +
          '      when 1 then ''NUMERIC'' ' +
          '      when 2 then ''DECIMAL'' ' +
          '    end ' +
          '  when 27 then ''DOUBLE PRECISION'' ' +
          '  when 35 then ''TIMESTAMP'' ' +
          '  when 37 then ''VARCHAR'' ' +
          '  when 261 then ''BLOB'' ' +
          '  else t.RDB$TYPE_NAME ' +
          'end FIELD_TYPE, ' +
          'case ft.RDB$FIELD_TYPE ' +
          '  when 16 then ' +
          '    case ft.RDB$FIELD_SUB_TYPE ' +
          '      when 0 then null ' +
          '      else ft.RDB$FIELD_PRECISION ' +
          '    end ' +
          '  when 261 then ft.RDB$SEGMENT_LENGTH ' +
          '  else ft.RDB$CHARACTER_LENGTH ' +
          'end SIZE_, ' +
          'coalesce(p.RDB$NULL_FLAG, ft.RDB$NULL_FLAG, 0) NULL_FLAG, ' +
          'coalesce(p.RDB$DEFAULT_SOURCE, ft.RDB$DEFAULT_SOURCE, null) DEFAULT_SOURCE, p.RDB$DESCRIPTION FIELD_DESCR ' +
          'from RDB$PROCEDURE_PARAMETERS p ' +
          '  left join RDB$FIELDS ft on ft.RDB$FIELD_NAME = p.RDB$FIELD_SOURCE ' +
          '  left join RDB$TYPES t on t.RDB$TYPE = ft.RDB$FIELD_TYPE and t.RDB$FIELD_NAME = ''RDB$FIELD_TYPE'' ' +
          'where p.RDB$PROCEDURE_NAME = upper(:TABLE_NAME) and p.RDB$PARAMETER_NAME = upper(:FIELD_NAME)';
        stOracle: result := 'select distinct COLUMN_NAME FIELD_NAME, null DOMAIN_, DATA_TYPE FIELD_TYPE, CHAR_LENGTH SIZE_, ' +
          '(case NULLABLE when ''N'' then 1 when ''Y'' then 0 else 0 end) NULL_FLAG, null DEFAULT_SOURCE, null FIELD_DESCR ' +
          'from ALL_TAB_COLUMNS where upper(OWNER) || ''.'' || upper(TABLE_NAME) = upper(:TABLE_NAME) and upper(COLUMN_NAME) = upper(:FIELD_NAME)';
        stPostgreSQL: result := 'select col.column_name::varchar FIELD_NAME, null DOMAIN_,' +
          '(case col.data_type ' +
          '  when ''character varying'' then ''varchar'' ' +
          '  when ''character'' then ''char'' ' +
          '  when ''time with time zone'' then ''time'' ' +
          '  when ''time without time zone'' then ''time'' ' +
          '  when ''timestamp with time zone'' then ''timestamp'' ' +
          '  when ''timestamp without time zone'' then ''timestamp'' ' +
          '  else col.data_type ' +
          'end) FIELD_TYPE, ' +
          'col.character_maximum_length SIZE_, ' +
          '(case col.is_nullable when ''NO'' then 1 when ''YES'' then 0 else 0 end) NULL_FLAG, ' +
          '(select d.description FROM pg_class c ' +
          'join pg_namespace n on n.oid = c.relnamespace ' +
          'join pg_description d on d.objoid = c.oid ' +
          'join pg_attribute a on a.attrelid = c.oid and a.attnum = d.objsubid and a.attname = col.column_name ' +
          'where c.relname = col.table_name and n.nspname = col.table_schema and a.attname = col.column_name) FIELD_DESCR ' +
          'from information_schema.columns col ' +
          'where lower(col.table_schema || ''.'' || col.table_name) = lower(:TABLE_NAME) and lower(col.column_name) = lower(:FIELD_NAME)';
        stMySQL: result := '';
      end;
    end;
    qtProcParams:
    begin
      // входные параметры процедуры
      case ServerType of
        stFirebird: result := 'select RDB$PARAMETER_NAME PARAM_NAME from RDB$PROCEDURE_PARAMETERS ' +
          'where RDB$PROCEDURE_NAME = upper(:NAME) and RDB$SYSTEM_FLAG = 0 and RDB$PARAMETER_TYPE = 0 order by RDB$PARAMETER_NUMBER';
        stOracle: result := 'select distinct ARGUMENT_NAME PARAM_NAME, SEQUENCE from user_arguments ' +
          'where upper(PACKAGE_NAME || ''.'' || OBJECT_NAME) = upper(:NAME) and ARGUMENT_NAME is not null order by SEQUENCE';
        stPostgreSQL: result := 'select p.parameter_name::varchar PARAM_NAME from information_schema.routines r ' +
          'join information_schema.parameters p on p.specific_name = r.specific_name ' +
          'where lower(r.routine_schema || ''.'' || r.routine_name) = lower(:NAME) order by p.ordinal_position';
        stMySQL: result := '';
      end;
    end;
    qtPrimaryKeys:
    begin
      // поля первичного ключа таблицы
      case ServerType of
        stFirebird: result := 'select distinct rc.RDB$CONSTRAINT_NAME CONSTRAINT_NAME, trim(i.RDB$FIELD_NAME) FIELD_NAME ' +
          'from RDB$RELATION_CONSTRAINTS rc ' +
          'join RDB$INDEX_SEGMENTS i on i.RDB$INDEX_NAME = rc.RDB$INDEX_NAME ' +
          'join RDB$INDICES idx on idx.RDB$INDEX_NAME = rc.RDB$INDEX_NAME ' +
          'where (rc.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'') and (rc.RDB$RELATION_NAME = upper(:NAME))';
        stOracle: result := 'select distinct col.COLUMN_NAME FIELD_NAME, col.POSITION from USER_CONSTRAINTS c ' +
          'join USER_CONS_COLUMNS col on col.CONSTRAINT_NAME = c.CONSTRAINT_NAME ' +
          'where upper(col.owner) || ''.'' || upper(c.TABLE_NAME) = upper(:NAME) and c.CONSTRAINT_TYPE = ''P'' ' +
          'order by col.POSITION';
        stPostgreSQL: result := 'select c.column_name::varchar FIELD_NAME, k.position_in_unique_constraint ' +
          'from information_schema.columns c ' +
          'join information_schema.key_column_usage k on k.table_schema = c.table_schema and k.table_name = c.table_name ' +
          'and k.column_name = c.column_name join information_schema.table_constraints tc on tc.constraint_name = k.constraint_name and ' +
          'tc.table_schema = c.table_schema and tc.table_name = c.table_name ' +
          'where lower(c.table_schema || ''.'' || c.table_name) = lower(:NAME) and tc.constraint_type = ''PRIMARY KEY'' ' +
          'order by k.position_in_unique_constraint';
        stMySQL: result := '';
      end;
    end;
    qtFieldForeignKeys:
    begin
      // подробности по внешнему ключу по полю
      case ServerType of
        stFirebird: result := 'select distinct trim(e.RDB$FIELD_NAME) FIELD_NAME, c.RDB$RELATION_NAME FK_TABLE, trim(d.RDB$FIELD_NAME) FK_FIELD ' +
          'from RDB$REF_CONSTRAINTS b ' +
          'join RDB$RELATION_CONSTRAINTS a on a.RDB$CONSTRAINT_NAME = b.RDB$CONSTRAINT_NAME ' +
          'join RDB$RELATION_CONSTRAINTS c on c.RDB$CONSTRAINT_NAME = b.RDB$CONST_NAME_UQ ' +
          'join RDB$INDEX_SEGMENTS d on d.RDB$INDEX_NAME = c.RDB$INDEX_NAME ' +
          'join RDB$INDEX_SEGMENTS e on e.RDB$INDEX_NAME = a.RDB$INDEX_NAME ' +
          'where (a.RDB$CONSTRAINT_TYPE = ''FOREIGN KEY'') and (a.RDB$RELATION_NAME = upper(:TABLE_NAME)) and (e.RDB$FIELD_NAME = upper(:FIELD_NAME))';
        stOracle: result := 'select distinct col.COLUMN_NAME FIELD_NAME, fc.TABLE_NAME FK_TABLE, fcol.COLUMN_NAME FK_FIELD ' +
          'from sys.all_constraints c ' +
          'join sys.all_cons_columns col on col.TABLE_NAME = c.TABLE_NAME ' +
          'join sys.all_constraints fc on fc.CONSTRAINT_NAME = c.R_CONSTRAINT_NAME ' +
          'join sys.all_cons_columns fcol on fcol.TABLE_NAME = fc.TABLE_NAME and fcol.CONSTRAINT_NAME = c.R_CONSTRAINT_NAME ' +
          'where c.CONSTRAINT_TYPE = ''R'' and upper(c.OWNER) || ''.'' || upper(c.TABLE_NAME) = upper(:TABLE_NAME) and ' +
          'upper(col.COLUMN_NAME) = upper(:FIELD_NAME)';
        stPostgreSQL: result := 'select distinct c.column_name FIELD_NAME, (fc.table_schema || ''.'' || fc.table_name) FK_TABLE, ' +
          'fc.column_name FK_FIELD ' +
          'from information_schema.columns c ' +
          'join information_schema.key_column_usage ku on ku.table_schema = c.table_schema and ' +
          'ku.table_name = c.table_name and ku.column_name = c.column_name ' +
          'join information_schema.table_constraints tc on tc.constraint_name = ku.constraint_name and ' +
          'tc.table_schema = c.table_schema and tc.table_name = c.table_name ' +
          'join information_schema.referential_constraints refc on refc.constraint_schema = c.table_schema and ' +
          'refc.constraint_name = ku.constraint_name ' +
          'join information_schema.key_column_usage fc on fc.constraint_schema = refc.unique_constraint_schema and ' +
          'fc.constraint_name = refc.unique_constraint_name ' +
          'where lower(c.table_schema || ''.'' || c.table_name) = lower(:TABLE_NAME) and lower(c.column_name) = lower(:FIELD_NAME) ' +
          'and tc.constraint_type = ''FOREIGN KEY''';
        stMySQL: result := '';
      end;
    end;
    qtReference:
    begin
      // список справочников
      case ServerType of
        stFirebird: result := 'select DESCRIPTOR_, TITLE ||  '' ['' || DESCRIPTOR_ || '']'' NAME from DYNAMIC_FORM_REFERENCE order by TITLE';
        stOracle, stPostgreSQL, stMySQL: result := '';
      end;
    end;
    qtRefFields:
    begin
      // список полей справочника: таблица.поле
      case ServerType of
        stFirebird: result := 'select o.NAME || ''.'' || fld.FIELD_NAME FIELD_NAME from DYNAMIC_FORM_REFERENCE r ' +
          'join DYNAMIC_FORM_FIELD fld on fld.FORM_PK = r.MAIN_FORM_PK ' +
          'left join DYNAMIC_FORM_OBJECT_TREE o on o.PK = fld.OBJECT_PK ' +
          'where upper(r.DESCRIPTOR_) = upper(:DESCRIPTOR_)';
        stOracle, stPostgreSQL, stMySQL: result := '';
      end;
    end;
    qtRefFields2:
    begin
      // список полей справочника: таблица/поле
      case ServerType of
        stFirebird: result :=
          'select o.NAME || ''/'' || fld.FIELD_NAME FIELD_NAME from DYNAMIC_FORM_REFERENCE r ' +
          'join DYNAMIC_FORM_FIELD fld on fld.FORM_PK = r.MAIN_FORM_PK ' +
          'left join DYNAMIC_FORM_OBJECT_TREE o on o.PK = fld.OBJECT_PK ' +
          'where upper(r.DESCRIPTOR_) = upper(:DESCRIPTOR_)';
        stOracle, stPostgreSQL, stMySQL: result := '';
      end;
    end;
    else result := '';
  end;
end;

function TConnectManager.InitConnection(BaseDescriptor: string): TUniConnection;
var
  idx: integer;
  connParams: TConnection;

begin
  result := FindConnection(BaseDescriptor, idx);

  if not Assigned(result) then
  begin
    connParams := FSettings.ConnByDbDescr[BaseDescriptor];
    if (connParams.Host = '') or (connParams.DataBase = '') or (connParams.UserName = '') then
      raise Exception.Create('Подключение для дескриптора "' + BaseDescriptor + '" не задано или не настроено!');

    result := TUniConnection.Create(FOwner);
    result.LoginPrompt := false;

    case connParams.Server of
      stFirebird:
      begin
        result.ProviderName := 'InterBase';
        result.SpecificOptions.Values[result.ProviderName + '.Role'] := connParams.Role;
        result.SpecificOptions.Values[result.ProviderName + '.SQLDialect'] := IntToStr(connParams.SQLDialect);
      end;
      stOracle:
      begin
        result.ProviderName := 'Oracle';
        if connParams.Role = '' then
          result.SpecificOptions.Values[result.ProviderName + '.Schema'] := connParams.UserName
        else
          result.SpecificOptions.Values[result.ProviderName + '.Schema'] := connParams.Role;
      end;
      stPostgreSQL: result.ProviderName := 'PostgreSQL';
      stMySQL: result.ProviderName := 'MySQL';
    end;

    //SqlConn.SpecificOptions.Values[result.ProviderName + '.Schema'] := connParams.UserName;
    result.SpecificOptions.Values[result.ProviderName + '.UseUnicode'] := 'True';
    result.SpecificOptions.Values[result.ProviderName + '.Charset'] := connParams.Encoding;
    result.Server := connParams.Host;
    result.Port := connParams.Port;
    result.Database := connParams.DataBase;
    result.Username := connParams.UserName;
    result.Password := connParams.Pass;
    try
      Screen.Cursor := crSQLWait;
      result.Open;
    finally
      Screen.Cursor := crDefault;
      if result.Connected then
      begin
        SetLength(FConnectionsList, Length(FConnectionsList) + 1);
        FConnectionsList[High(FConnectionsList)] := result;
        SetLength(FConnDescrList, Length(FConnectionsList));
        FConnDescrList[High(FConnDescrList)] := BaseDescriptor;
      end else
        FreeAndNil(result);
    end;
  end;
end;

function TConnectManager.InitConnection(ConnIndex: integer): TUniConnection;
var
  idx: integer;
  connParams: TConnection;

begin
  connParams := FSettings.ConnByIndex[ConnIndex];
  if (connParams.Host = '') or (connParams.DataBase = '') or (connParams.UserName = '') then
    raise Exception.Create('Подключение "' + IntToStr(ConnIndex) + '" не задано или не настроено!');

  result := FindConnection(connParams.Alias, idx);

  if not Assigned(result) then
  begin
    result := TUniConnection.Create(FOwner);
    result.LoginPrompt := false;

    case connParams.Server of
      stFirebird:
      begin
        result.ProviderName := 'InterBase';
        result.SpecificOptions.Values[result.ProviderName + '.Role'] := connParams.Role;
        result.SpecificOptions.Values[result.ProviderName + '.SQLDialect'] := IntToStr(connParams.SQLDialect);
      end;
      stOracle:
      begin
        result.ProviderName := 'Oracle';
        if connParams.Role = '' then
          result.SpecificOptions.Values[result.ProviderName + '.Schema'] := connParams.UserName
        else
          result.SpecificOptions.Values[result.ProviderName + '.Schema'] := connParams.Role;
      end;
      stPostgreSQL: result.ProviderName := 'PostgreSQL';
      stMySQL: result.ProviderName := 'MySQL';
    end;

    //SqlConn.SpecificOptions.Values[result.ProviderName + '.Schema'] := connParams.UserName;
    result.SpecificOptions.Values[result.ProviderName + '.UseUnicode'] := 'True';
    result.SpecificOptions.Values[result.ProviderName + '.Charset'] := connParams.Encoding;
    result.Server := connParams.Host;
    result.Port := connParams.Port;
    result.Database := connParams.DataBase;
    result.Username := connParams.UserName;
    result.Password := connParams.Pass;
    try
      Screen.Cursor := crSQLWait;
      result.Open;
    finally
      Screen.Cursor := crDefault;
      if result.Connected then
      begin
        SetLength(FConnectionsList, Length(FConnectionsList) + 1);
        FConnectionsList[High(FConnectionsList)] := result;
        SetLength(FConnDescrList, Length(FConnectionsList));
        FConnDescrList[High(FConnDescrList)] := connParams.Alias;
      end else
        FreeAndNil(result);
    end;
  end else
    if not result.Connected then result.Open;
end;

procedure TConnectManager.SetSQLToDataSet(DataSet: TUniQuery; ConnIndex: integer; QueryType: TQueryType; UserDefinedSQL: string);
var
  con: TConnection;
  //own: string;

begin
  if not Assigned(DataSet) then exit;
  con := FSettings.ConnByIndex[ConnIndex];
  DataSet.Close;
  DataSet.Connection := InitConnection(ConnIndex);
  DataSet.Tag := Ord(QueryType);
  DataSet.SpecificOptions.Values[DataSet.Connection.ProviderName + '.FetchAll'] := 'True';
  if con.Server = stPostgreSQL then
    DataSet.SpecificOptions.Values[DataSet.Connection.ProviderName + '.UnknownAsString'] := 'True';

  if QueryType = qtUserDefined then
    DataSet.SQL.Text := UserDefinedSQL
  else begin
    {own := DataSet.Connection.SpecificOptions.Values[DataSet.Connection.ProviderName + '.Schema'];
    if own = '' then own := DataSet.Connection.Username;}
    DataSet.SQL.Text := {StringReplace(}GetSystemSQL(con.Server, QueryType){, ':OWNER', 'upper(''' + own + ''')', [rfReplaceAll])};
  end;
end;

procedure TConnectManager.SetSQLToDataSet(DataSet: TUniQuery; BaseDescriptor: string; QueryType: TQueryType; UserDefinedSQL: string);
var
  con: TConnection;
  //own: string;

begin
  if not Assigned(DataSet) then exit;
  con := FSettings.ConnByDbDescr[BaseDescriptor];
  DataSet.Close;
  DataSet.Connection := InitConnection(BaseDescriptor);
  DataSet.Tag := Ord(QueryType);
  DataSet.SpecificOptions.Values[DataSet.Connection.ProviderName + '.FetchAll'] := 'True';
  if con.Server = stPostgreSQL then
    DataSet.SpecificOptions.Values[DataSet.Connection.ProviderName + '.UnknownAsString'] := 'True';

  if QueryType = qtUserDefined then
    DataSet.SQL.Text := UserDefinedSQL
  else begin
    {own := DataSet.Connection.SpecificOptions.Values[DataSet.Connection.ProviderName + '.Schema'];
    if own = '' then own := DataSet.Connection.Username;}
    DataSet.SQL.Text := {StringReplace(}GetSystemSQL(con.Server, QueryType){, ':OWNER', 'upper(''' + own + ''')', [rfReplaceAll])};
  end;
end;

{ прочее }

function FindColumnByFieldName(Grid: TDBGridEh; FieldName: string): TColumnEh;
var
  i: integer;

begin
  result := nil;
  for i := 0 to Grid.Columns.Count - 1 do
    if Grid.Columns.Items[i].FieldName = FieldName then
    begin
      result := Grid.Columns.Items[i];
      break;
    end;
end;

procedure CopyGrid(SrcGrid: TDBGridEh; DestGrid: TDBGrid);
var
  i: integer;
  col: TColumn;

begin
  if (not Assigned(SrcGrid)) or (not Assigned(DestGrid)) then exit;
  DestGrid.DataSource := SrcGrid.DataSource;
  DestGrid.Columns.Clear;
  for i := 0 to SrcGrid.Columns.Count - 1 do
  begin
    col := DestGrid.Columns.Add;
    col.Field := SrcGrid.Columns.Items[i].Field;
    col.Alignment := SrcGrid.Columns.Items[i].Alignment;
    col.Width := SrcGrid.Columns.Items[i].Width;
    col.Visible := SrcGrid.Columns.Items[i].Visible;
    col.DisplayName := SrcGrid.Columns.Items[i].DisplayName;
    col.Font.Charset := SrcGrid.Columns.Items[i].Font.Charset;
    col.Font.Color := SrcGrid.Columns.Items[i].Font.Color;
    col.Font.Height := SrcGrid.Columns.Items[i].Font.Height;
    col.Font.Name := SrcGrid.Columns.Items[i].Font.Name;
    col.Font.Orientation := SrcGrid.Columns.Items[i].Font.Orientation;
    col.Font.Size := SrcGrid.Columns.Items[i].Font.Size;
    col.Font.Style := SrcGrid.Columns.Items[i].Font.Style;
    col.Color := SrcGrid.Columns.Items[i].Color;
    col.Title.Alignment := SrcGrid.Columns.Items[i].Title.Alignment;
    col.Title.Caption := SrcGrid.Columns.Items[i].Title.Caption;
    col.Title.Color := SrcGrid.Columns.Items[i].Title.Color;
    col.Title.Font.Charset := SrcGrid.Columns.Items[i].Title.Font.Charset;
    col.Title.Font.Color := SrcGrid.Columns.Items[i].Title.Font.Color;
    col.Title.Font.Height := SrcGrid.Columns.Items[i].Title.Font.Height;
    col.Title.Font.Name := SrcGrid.Columns.Items[i].Title.Font.Name;
    col.Title.Font.Orientation := SrcGrid.Columns.Items[i].Title.Font.Orientation;
    col.Title.Font.Size := SrcGrid.Columns.Items[i].Title.Font.Size;
    col.Title.Font.Style := SrcGrid.Columns.Items[i].Title.Font.Style;
  end;
end;

{ TConnectChecker }

function TConnectChecker.Add(AConnection: TObject; AOnLostConnect: TOnLostConnect; AInterval: Cardinal; APingQuery: string;
  AActive: boolean): TConnectionItem;
begin
  result := TConnectionItem.Create(Self, AConnection, AOnLostConnect, AInterval, APingQuery);
  AddItem(result, AActive);
end;

function TConnectChecker.AddItem(AItem: TConnectionItem; AActive: boolean): integer;
begin
  result := Length(FConnections);
  SetLength(FConnections, result + 1);
  FConnections[result] := AItem;
  FConnections[result].FIndex := result;
  FConnections[result].Active := AActive;
end;

procedure TConnectChecker.Clear;
var
  i: integer;

begin
  for i := 0 to Count - 1 do
    FreeAndNil(FConnections[i]);

  SetLength(FConnections, 0);
end;

function TConnectChecker.Count: integer;
begin
  result := Length(FConnections);
end;

constructor TConnectChecker.Create;
begin
  inherited Create;
  Clear;
  FActive := false;
end;

procedure TConnectChecker.Delete(Index: integer);
var
  i: integer;

begin
  if (Index < 0) or (Index >= Count) then exit;

  FreeAndNil(FConnections[Index]);

  for i := Index + 1 to Count - 1 do
  begin
    FConnections[i-1] := FConnections[i];
    FConnections[i-1].FIndex := i - 1;
  end;

  SetLength(FConnections, Length(FConnections) - 1);
end;

destructor TConnectChecker.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TConnectChecker.FindItem(Name: string): integer;
var
  i: integer;

begin
  result := -1;

  for i := 0 to Count - 1 do
    if AnsiLowerCase(FConnections[i].Name) = AnsiLowerCase(Name) then
    begin
      result := i;
      exit;
    end;
end;

function TConnectChecker.GetItem(Index: integer): TConnectionItem;
begin
  if (Index < 0) or (Index >= Count) then raise Exception.Create('Индекс вышел за границу массива');
  result := FConnections[Index];
end;

function TConnectChecker.ItemByName(Name: string): TConnectionItem;
var
  i: integer;

begin
  result := nil;

  for i := 0 to Count - 1 do
    if AnsiLowerCase(FConnections[i].Name) = AnsiLowerCase(Name) then
    begin
      result := FConnections[i];
      exit;
    end;
end;

procedure TConnectChecker.SetActive(Value: boolean);
var
  i: integer;

begin
  FActive := Value;

  for i := 0 to Count - 1 do
    if Assigned(FConnections[i]) then FConnections[i].Active := FActive;
end;

procedure TConnectChecker.Start;
begin
  Active := true;
end;

procedure TConnectChecker.Stop;
begin
  Active := false;
end;

{ TConnectionItem }

procedure TConnectionItem.CheckFib;
begin
  FIBDataSet.Close;
  try
    try
      FIBDataSet.Open;
    finally
      FIBDataSet.Close;
    end;
  except
    on e: Exception do
    begin
      Active := false;
      FLastError := e.Message;
      if Assigned(FOnLostConnect) then FOnLostConnect(FConnection, FLastError);
    end;
  end;
end;

procedure TConnectionItem.CheckUni;
begin
  UniQuery.Close;
  try
    try
      UniQuery.Open;
    finally
      UniQuery.Close;
    end;
  except
    on e: Exception do
    begin
      Active := false;
      FLastError := e.Message;
      if Assigned(FOnLostConnect) then FOnLostConnect(FConnection, FLastError);
    end;
  end;
end;

constructor TConnectionItem.Create(AParent: TConnectChecker; AConnection: TObject; AOnLostConnect: TOnLostConnect;
  AInterval: Cardinal; APingQuery: string);
begin
  inherited Create;

  if not Assigned(AParent) then raise Exception.Create('Не задан параметр Parent');

  FParent := AParent;
  PingTimer := TTimer.Create(nil);
  PingTimer.OnTimer := OnPingTimer;
  UniQuery := TUniQuery.Create(nil);
  FIBDataSet := TpFIBDataSet.Create(nil);

  Active := false;
  FOnLostConnect := AOnLostConnect;
  Connection := AConnection;
  PingInterval := AInterval;
  PingQuery := APingQuery;
end;

destructor TConnectionItem.Destroy;
begin
  PingTimer.Free;
  if UniQuery.Active then UniQuery.Close;
  UniQuery.Free;
  if FIBDataSet.Active then FIBDataSet.Close;
  FIBDataSet.Free;

  inherited Destroy;
end;

procedure TConnectionItem.OnPingTimer(Sender: TObject);
begin
  if not FActive then exit;
  if (FConnection is TpFIBDatabase) then CheckFib;
  if (FConnection is TUniConnection) then CheckUni;
end;

procedure TConnectionItem.SetActive(Value: boolean);
begin
  FActive := FParent.Active and Value;
  PingTimer.Enabled := FActive;
end;

procedure TConnectionItem.SetConnection(Value: TObject);
begin
  if (not Assigned(Value)) or ((not (Value is TpFIBDatabase)) and (not (Value is TUniConnection))) then
    raise Exception.Create('Connection должен быть экземпляром TpFIBDatabase или TUniConnection');

  FConnection := Value;

  if UniQuery.Active then UniQuery.Close;
  if FIBDataSet.Active then FIBDataSet.Close;
  UniQuery.Connection := nil;
  FIBDataSet.Database := nil;
  FIBDataSet.Transaction := nil;

  if (FConnection is TpFIBDatabase) then
  begin
    FName := TpFIBDatabase(FConnection).Name;
    FIBDataSet.Database := TpFIBDatabase(FConnection);
    FIBDataSet.Transaction := TpFIBDatabase(FConnection).DefaultTransaction;
  end;

  if (FConnection is TUniConnection) then
  begin
    FName := TUniConnection(FConnection).Name;
    UniQuery.Connection := TUniConnection(FConnection);
  end;
end;

procedure TConnectionItem.SetPingInterval(Value: Cardinal);
begin
  FPingInterval := Value;
  PingTimer.Enabled := false;
  PingTimer.Interval := FPingInterval;
  PingTimer.Enabled := FActive;
end;

procedure TConnectionItem.SetPingQuery(Value: string);
var
  a: boolean;

begin
  a := Active;
  Active := false;

  FPingQuery := Value;

  if UniQuery.Active then UniQuery.Close;
  if FIBDataSet.Active then FIBDataSet.Close;
  FIBDataSet.SQLs.SelectSQL.Text := FPingQuery;
  UniQuery.SQL.Text := FPingQuery;

  Active := a;
end;

end.
