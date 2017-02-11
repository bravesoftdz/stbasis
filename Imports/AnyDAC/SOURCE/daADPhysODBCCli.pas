{-------------------------------------------------------------------------------}
{ AnyDAC ODBC API                                                               }
{ Copyright (c) 2004-2006 by Dmitry Arefiev (www.da-soft.com)                   }
{                                                                               }
{ All rights reserved.                                                          }
{-------------------------------------------------------------------------------}
{ Portions copyright:                                                           }
{  - 2001-2003 Edward Benson. The file based on OdbcApi unit of DbExpress       }
{    driver for ODBC.                                                           }
{-------------------------------------------------------------------------------}
{$I daAD.inc}

unit daADPhysODBCCli;

interface

type
  // API declaration data types
  SQLChar       = AnsiChar;
  SQLVarchar    = Byte;
  SQLWChar      = WideChar;
  PSQLChar      = ^SQLChar;
  PSQLVarchar   = ^SQLVarchar;
  PSQLWChar     = ^SQLWChar;

  SQLPointer    = Pointer;
  PSQLPointer    = ^SQLPointer;

  SQLDate       = Byte;
  SQLTime       = Byte;
  SQLTimeStamp  = Byte;
  PSQLDate      = ^SQLDate;
  PSQLTime      = ^SQLTime;
  PSQLTimeStamp = ^SQLTimeStamp;

  SQLDouble     = Double;
  SQLFloat      = Double;
  SQLReal       = Single;
  PSQLDouble    = ^SQLDouble;
  PSQLFloat     = ^SQLFloat;
  PSQLReal      = ^SQLReal;

  SQLNumeric    = Byte;
  SQLDecimal    = Byte;
  SQLSmallint   = Smallint;
  SQLUSmallint  = Word;
  SQLInteger    = LongInt;
  SQLByte       = Byte;
  PSQLNumeric   = ^SQLNumeric;
  PSQLDecimal   = ^SQLDecimal;
  PSQLSmallint  = ^SQLSmallint;
  PSQLUSmallint = ^SQLUSmallint;
  PSQLInteger   = ^SQLInteger;
  PSQLByte      = ^SQLByte;

  ODBCInt64     = Int64;
  SQLBigInt     = ODBCInt64;
  SQLUBigInt    = ODBCInt64;
  PSQLBigInt    = ^SQLBigInt;
  PSQLUBigInt   = ^SQLUBigInt;

  SQLGuid       = TGUID;

  Bookmark      = Longint;

  SQLReturn     = SQLSmallint;

  SQLHandle     = Pointer;
  SQLHEnv       = Pointer;
  SQLHDbc       = Pointer;
  SQLHStmt      = Pointer;
  SQLHDesc      = Pointer;

  // SQL portable types
  UChar        = Byte;
  UWord        = Word;
  UShort       = Word;
  ULong        = LongInt;
  UDword       = LongInt;
  SChar        = Shortint;
  SWord        = Smallint;
  SShort       = Smallint;
  SDword       = Longint;
  SLong        = LongInt;
  PUWord       = ^UWord;
  SQLUInteger  = UDword;
  PSQLUInteger = ^SQLUInteger;
  SDouble      = Double;
  LDouble      = Double;
  SFloat       = Single;
  Ptr          = Pointer;

  HEnv  = Pointer;
  HDbc  = Pointer;
  HStmt = Pointer;

  Retcode = Smallint;

  SQLHWnd = LongWord;

  PSQLDateStruct = ^TSQLDateStruct;
  TSQLDateStruct = packed record
    Year:  SQLSmallint;
    Month: SQLUSmallint;
    Day:   SQLUSmallint;
  end;
  SQL_DATE_STRUCT = TSQLDateStruct;

  PSQLTimeStruct = ^TSQLTimeStruct;
  TSQLTimeStruct = packed record
    Hour:   SQLUSmallint;
    Minute: SQLUSmallint;
    Second: SQLUSmallint;
  end;
  SQL_TIME_STRUCT = TSQLTimeStruct;

  PODBCTimeStamp = ^TODBCTimeStamp;
  TODBCTimeStamp = packed record
    Year:     SQLSmallint;
    Month:    SQLUSmallint;
    Day:      SQLUSmallint;
    Hour:     SQLUSmallint;
    Minute:   SQLUSmallint;
    Second:   SQLUSmallint;
    Fraction: SQLUInteger;
  end;
  SQL_TIMESTAMP_STRUCT = TODBCTimeStamp;

  PSQLYearMonth = ^TSQLYearMonth;
  TSQLYearMonth = packed record
    Year:  SQLUInteger;
    Month: SQLUInteger;
  end;
  SQL_YEAR_MONTH = TSQLYearMonth;

  PSQLDaySecond = ^TSQLDaySecond;
  TSQLDaySecond = packed record
    Day:      SQLUInteger;
    Hour:     SQLUInteger;
    Minute:   SQLUInteger;
    Second:   SQLUInteger;
    Fraction: SQLUInteger;
  end;
  SQL_DAY_SECOND = TSQLDaySecond;

  SQLInterval = (
    SQL_IS_DUMMY,
    SQL_IS_YEAR,
    SQL_IS_MONTH,
    SQL_IS_DAY,
    SQL_IS_HOUR,
    SQL_IS_MINUTE,
    SQL_IS_SECOND,
    SQL_IS_YEAR_TO_MONTH,
    SQL_IS_DAY_TO_HOUR,
    SQL_IS_DAY_TO_MINUTE,
    SQL_IS_DAY_TO_SECOND,
    SQL_IS_HOUR_TO_MINUTE,
    SQL_IS_HOUR_TO_SECOND,
    SQL_IS_MINUTE_TO_SECOND);

  PSQLInterval = ^TSQLInterval;
  TSQLInterval = packed record
    Interval_type: SQLInterval;
    Interval_sign: SQLSmallint;
    case SQLInterval of
      SQL_IS_YEAR_TO_MONTH: (YearMonth: TSQLYearMonth);
      SQL_IS_DAY_TO_SECOND: (DaySecond: TSQLDaySecond);
  end;

  PSQLGUID = ^TSQLGUID;
  TSQLGUID = packed record
    Data1: UDword;
    Data2: WORD;
    Data3: WORD;
    Data4: array [0..8-1] of BYTE;
  end;

const
  // Length indicator values
  SQL_NULL_DATA    = -1;
  SQL_DATA_AT_EXEC = -2;

  // SQLReturn values from functions
  SQL_SUCCESS           = 0;
  SQL_SUCCESS_WITH_INFO = 1;
  SQL_NO_DATA           = 100;
  SQL_ERROR             = -1;
  SQL_INVALID_HANDLE    = -2;
  SQL_STILL_EXECUTING   = 2;
  SQL_NEED_DATA         = 99;

  function SQL_LEN_BINARY_ATTR(Length: SQLInteger): SQLInteger;
  function SQL_LEN_DATA_AT_EXEC(Length: SQLInteger): SQLInteger;

const
  SQL_INTERVAL_COLSIZE = 28;

  // Flags for null-terminated string
  SQL_NTS  = -3;
  SQL_NTSL = -3;

  // Maximum message Length
  SQL_MAX_MESSAGE_LENGTH = 512;

  // Date/time Length constants
  SQL_DATE_LEN      = 10;
  SQL_TIME_LEN      = 8;  // Add P+1 if precision is nonzero
  SQL_TIMESTAMP_LEN = 19; // Add P+1 if precision is nonzero

  // Handle type identifiers
  SQL_HANDLE_ENV  = 1;
  SQL_HANDLE_DBC  = 2;
  SQL_HANDLE_STMT = 3;
  SQL_HANDLE_DESC = 4;

  // Environment attribute
  SQL_ATTR_OUTPUT_NTS = 10001;

  // Connection attributes
  SQL_ATTR_AUTO_IPD    = 10001;
  SQL_ATTR_METADATA_ID = 10014;

  // For IBM DB2
  SQL_ATTR_LONGDATA_COMPAT = 1253;
  SQL_LD_COMPAT_NO = 0;
  SQL_LD_COMPAT_YES = 1;

  // Statement attributes
  SQL_ATTR_APP_ROW_DESC       = 10010;
  SQL_ATTR_APP_PARAM_DESC     = 10011;
  SQL_ATTR_IMP_ROW_DESC       = 10012;
  SQL_ATTR_IMP_PARAM_DESC     = 10013;
  SQL_ATTR_CURSOR_SCROLLABLE  = -1;
  SQL_ATTR_CURSOR_SENSITIVITY = -2;

  // SQL_ATTR_CURSOR_SCROLLABLE values
  SQL_NONSCROLLABLE = 0;
  SQL_SCROLLABLE    = 1;

  // Identifiers of fields in the SQL descriptor
  SQL_DESC_COUNT                  = 1001;
  SQL_DESC_TYPE                   = 1002;
  SQL_DESC_LENGTH                 = 1003;
  SQL_DESC_OCTET_LENGTH_PTR       = 1004;
  SQL_DESC_PRECISION              = 1005;
  SQL_DESC_SCALE                  = 1006;
  SQL_DESC_DATETIME_INTERVAL_CODE = 1007;
  SQL_DESC_NULLABLE               = 1008;
  SQL_DESC_INDICATOR_PTR          = 1009;
  SQL_DESC_DATA_PTR               = 1010;
  SQL_DESC_NAME                   = 1011;
  SQL_DESC_UNNAMED                = 1012;
  SQL_DESC_OCTET_LENGTH           = 1013;
  SQL_DESC_ALLOC_TYPE             = 1099;

  // Identifiers of fields in the diagnostics area
  SQL_DIAG_RETURNCODE            = 1;
  SQL_DIAG_NUMBER                = 2;
  SQL_DIAG_ROW_COUNT             = 3;
  SQL_DIAG_SQLSTATE              = 4;
  SQL_DIAG_NATIVE                = 5;
  SQL_DIAG_MESSAGE_TEXT          = 6;
  SQL_DIAG_DYNAMIC_FUNCTION      = 7;
  SQL_DIAG_CLASS_ORIGIN          = 8;
  SQL_DIAG_SUBCLASS_ORIGIN       = 9;
  SQL_DIAG_CONNECTION_NAME       = 10;
  SQL_DIAG_SERVER_NAME           = 11;
  SQL_DIAG_DYNAMIC_FUNCTION_CODE = 12;

  // Dynamic function codes
  SQL_DIAG_ALTER_DOMAIN          = 3;
  SQL_DIAG_ALTER_TABLE           = 4;
  SQL_DIAG_CALL                  = 7;
  SQL_DIAG_CREATE_ASSERTION      = 6;
  SQL_DIAG_CREATE_CHARACTER_SET  = 8;
  SQL_DIAG_CREATE_COLLATION      = 10;
  SQL_DIAG_CREATE_DOMAIN         = 23;
  SQL_DIAG_CREATE_INDEX          = -1;
  SQL_DIAG_CREATE_SCHEMA         = 64;
  SQL_DIAG_CREATE_TABLE          = 77;
  SQL_DIAG_CREATE_TRANSLATION    = 79;
  SQL_DIAG_CREATE_VIEW           = 84;
  SQL_DIAG_DELETE_WHERE          = 19;
  SQL_DIAG_DROP_ASSERTION        = 24;
  SQL_DIAG_DROP_CHARACTER_SET    = 25;
  SQL_DIAG_DROP_COLLATION        = 26;
  SQL_DIAG_DROP_DOMAIN           = 27;
  SQL_DIAG_DROP_INDEX            = -2;
  SQL_DIAG_DROP_SCHEMA           = 31;
  SQL_DIAG_DROP_TABLE            = 32;
  SQL_DIAG_DROP_TRANSLATION      = 33;
  SQL_DIAG_DROP_VIEW             = 36;
  SQL_DIAG_DYNAMIC_DELETE_CURSOR = 38;
  SQL_DIAG_DYNAMIC_UPDATE_CURSOR = 81;
  SQL_DIAG_GRANT                 = 48;
  SQL_DIAG_INSERT                = 50;
  SQL_DIAG_REVOKE                = 59;
  SQL_DIAG_SELECT_CURSOR         = 85;
  SQL_DIAG_UNKNOWN_STATEMENT     = 0;
  SQL_DIAG_UPDATE_WHERE          = 82;

  // SQL data type codes
  SQL_UNKNOWN_TYPE = 0;
  SQL_CHAR         = 1;
  SQL_NUMERIC      = 2;
  SQL_DECIMAL      = 3;
  SQL_INTEGER      = 4;
  SQL_SMALLINT     = 5;
  SQL_FLOAT        = 6;
  SQL_REAL         = 7;
  SQL_DOUBLE       = 8;
  SQL_DATETIME     = 9;
  SQL_VARCHAR      = 12;

  // One-parameter shortcuts for date/time data types
  SQL_TYPE_DATE      = 91;
  SQL_TYPE_TIME      = 92;
  SQL_TYPE_TIMESTAMP = 93;

  // Statement attribute values for cursor sensitivity
  SQL_UNSPECIFIED = 0;
  SQL_INSENSITIVE = 1;
  SQL_SENSITIVE   = 2;

  // GetTypeInfo() request for all data types
  SQL_ALL_TYPES = 0;

  // Default conversion code for SQLBindCol(), SQLBindParam() and SQLGetData()
  SQL_DEFAULT = 99;

  // SQLGetData() code indicating that the application row descriptor
  // specifies the data type
  SQL_ARD_TYPE = -99;

  // SQL date/time type subcodes
  SQL_CODE_DATE      = 1;
  SQL_CODE_TIME      = 2;
  SQL_CODE_TIMESTAMP = 3;

  // CLI option values
  SQL_FALSE = 0;
  SQL_TRUE  = 1;

  // Values of NULLABLE field in descriptor
  SQL_NO_NULLS = 0;
  SQL_NULLABLE = 1;

  // Value returned by SQLGetTypeInfo() to denote that it is
  // not known whether or not a data type supports null values.
  SQL_NULLABLE_UNKNOWN = 2;

  // Values returned by SQLGetTypeInfo() to show WHERE clause supported
  SQL_PRED_NONE  = 0;
  SQL_PRED_CHAR  = 1;
  SQL_PRED_BASIC = 2;

  // values of UNNAMED field in descriptor
  SQL_NAMED = 0;
  SQL_UNNAMED = 1;

  // values of ALLOC_TYPE field in descriptor
  SQL_DESC_ALLOC_AUTO = 1;
  SQL_DESC_ALLOC_USER = 2;

  // FreeStmt() options
  SQL_CLOSE        = 0;
  SQL_DROP         = 1;
  SQL_UNBIND       = 2;
  SQL_RESET_PARAMS = 3;

  // Codes used for FetchOrientation in SQLFetchScroll(), and in SQLDataSources()
  SQL_FETCH_NEXT  = 1;
  SQL_FETCH_FIRST = 2;

  // Other codes used for FetchOrientation in SQLFetchScroll()
  SQL_FETCH_LAST     = 3;
  SQL_FETCH_PRIOR    = 4;
  SQL_FETCH_ABSOLUTE = 5;
  SQL_FETCH_RELATIVE = 6;

  // SQLEndTran() options
  SQL_COMMIT   = 0;
  SQL_ROLLBACK = 1;

  // Null handles returned by SQLAllocHandle()
  SQL_NULL_HENV  = SQLHandle(0);
  SQL_NULL_HDBC  = SQLHandle(0);
  SQL_NULL_HSTMT = SQLHandle(0);
  SQL_NULL_HDESC = SQLHandle(0);

  // Null handle used in place of parent handle when allocating HENV
  SQL_NULL_HANDLE = SQLHandle(0);

  // Values that may appear in the Result set of SQLSpecialColumns()
  SQL_SCOPE_CURROW      = 0;
  SQL_SCOPE_TRANSACTION = 1;
  SQL_SCOPE_SESSION     = 2;
  SQL_PC_UNKNOWN        = 0;
  SQL_PC_NON_PSEUDO     = 1;
  SQL_PC_PSEUDO         = 2;

  // Reserved value for the IdentifierType argument of SQLSpecialColumns()
  SQL_ROW_IDENTIFIER = 1;

  // Reserved values for UNIQUE argument of SQLStatistics()
  SQL_INDEX_UNIQUE = 0;
  SQL_INDEX_ALL    = 1;

  // Values that may appear in the Result set of SQLStatistics()
  SQL_INDEX_CLUSTERED = 1;
  SQL_INDEX_HASHED    = 2;
  SQL_INDEX_OTHER     = 3;

  // SQLGetFunctions() values to identify ODBC APIs
  SQL_API_SQLALLOCCONNECT     = 1;
  SQL_API_SQLALLOCENV         = 2;
  SQL_API_SQLALLOCHANDLE      = 1001;
  SQL_API_SQLALLOCSTMT        = 3;
  SQL_API_SQLBINDCOL          = 4;
  SQL_API_SQLBINDPARAM        = 1002;
  SQL_API_SQLCANCEL           = 5;
  SQL_API_SQLCLOSECURSOR      = 1003;
  SQL_API_SQLCOLATTRIBUTE     = 6;
  SQL_API_SQLCOLUMNS          = 40;
  SQL_API_SQLCONNECT          = 7;
  SQL_API_SQLCOPYDESC         = 1004;
  SQL_API_SQLDATASOURCES      = 57;
  SQL_API_SQLDESCRIBECOL      = 8;
  SQL_API_SQLDISCONNECT       = 9;
  SQL_API_SQLENDTRAN          = 1005;
  SQL_API_SQLERROR            = 10;
  SQL_API_SQLEXECDIRECT       = 11;
  SQL_API_SQLEXECUTE          = 12;
  SQL_API_SQLFETCH            = 13;
  SQL_API_SQLFETCHSCROLL      = 1021;
  SQL_API_SQLFREECONNECT      = 14;
  SQL_API_SQLFREEENV          = 15;
  SQL_API_SQLFREEHANDLE       = 1006;
  SQL_API_SQLFREESTMT         = 16;
  SQL_API_SQLGETCONNECTATTR   = 1007;
  SQL_API_SQLGETCONNECTOPTION = 42;
  SQL_API_SQLGETCURSORNAME    = 17;
  SQL_API_SQLGETDATA          = 43;
  SQL_API_SQLGETADSCFIELD     = 1008;
  SQL_API_SQLGETADSCREC       = 1009;
  SQL_API_SQLGETDIAGFIELD     = 1010;
  SQL_API_SQLGETDIAGREC       = 1011;
  SQL_API_SQLGETENVATTR       = 1012;
  SQL_API_SQLGETFUNCTIONS     = 44;
  SQL_API_SQLGETINFO          = 45;
  SQL_API_SQLGETSTMTATTR      = 1014;
  SQL_API_SQLGETSTMTOPTION    = 46;
  SQL_API_SQLGETTYPEINFO      = 47;
  SQL_API_SQLNUMRESULTCOLS    = 18;
  SQL_API_SQLPARAMDATA        = 48;
  SQL_API_SQLPREPARE          = 19;
  SQL_API_SQLPUTDATA          = 49;
  SQL_API_SQLROWCOUNT         = 20;
  SQL_API_SQLSETCONNECTATTR   = 1016;
  SQL_API_SQLSETCONNECTOPTION = 50;
  SQL_API_SQLSETCURSORNAME    = 21;
  SQL_API_SQLSETADSCFIELD     = 1017;
  SQL_API_SQLSETADSCREC       = 1018;
  SQL_API_SQLSETENVATTR       = 1019;
  SQL_API_SQLSETPARAM         = 22;
  SQL_API_SQLSETSTMTATTR      = 1020;
  SQL_API_SQLSETSTMTOPTION    = 51;
  SQL_API_SQLSPECIALCOLUMNS   = 52;
  SQL_API_SQLSTATISTICS       = 53;
  SQL_API_SQLTABLES           = 54;
  SQL_API_SQLTRANSACT         = 23;

  // Information requested by SQLGetInfo()
  SQL_MAX_DRIVER_CONNECTIONS        = 0;
  SQL_MAXIMUM_DRIVER_CONNECTIONS    = SQL_MAX_DRIVER_CONNECTIONS;
  SQL_MAX_CONCURRENT_ACTIVITIES     = 1;
  SQL_MAXIMUM_CONCURRENT_ACTIVITIES = SQL_MAX_CONCURRENT_ACTIVITIES;
  SQL_DATA_SOURCE_NAME              = 2;
  SQL_FETCH_DIRECTION               = 8;
  SQL_SERVER_NAME                   = 13;
  SQL_SEARCH_PATTERN_ESCAPE         = 14;
  SQL_DBMS_NAME                     = 17;
  SQL_DBMS_VER                      = 18;
  SQL_ACCESSIBLE_TABLES             = 19;
  SQL_ACCESSIBLE_PROCEDURES         = 20;
  SQL_CURSOR_COMMIT_BEHAVIOR        = 23;
  SQL_DATA_SOURCE_READ_ONLY         = 25;
  SQL_DEFAULT_TXN_ISOLATION         = 26;
  SQL_IDENTIFIER_CASE               = 28;
  SQL_IDENTIFIER_QUOTE_CHAR         = 29;
  SQL_MAX_COLUMN_NAME_LEN           = 30;
  SQL_MAXIMUM_COLUMN_NAME_LENGTH    = SQL_MAX_COLUMN_NAME_LEN;
  SQL_MAX_CURSOR_NAME_LEN           = 31;
  SQL_MAXIMUM_CURSOR_NAME_LENGTH    = SQL_MAX_CURSOR_NAME_LEN;
  SQL_MAX_SCHEMA_NAME_LEN           = 32;
  SQL_MAXIMUM_SCHEMA_NAME_LENGTH    = SQL_MAX_SCHEMA_NAME_LEN;
  SQL_MAX_CATALOG_NAME_LEN          = 34;
  SQL_MAXIMUM_CATALOG_NAME_LENGTH   = SQL_MAX_CATALOG_NAME_LEN;
  SQL_MAX_TABLE_NAME_LEN            = 35;
  SQL_SCROLL_CONCURRENCY            = 43;
  SQL_TXN_CAPABLE                   = 46;
  SQL_TRANSACTION_CAPABLE           = SQL_TXN_CAPABLE;
  SQL_USER_NAME                     = 47;
  SQL_TXN_ISOLATION_OPTION          = 72;
  SQL_TRANSACTION_ISOLATION_OPTION  = SQL_TXN_ISOLATION_OPTION;
  SQL_INTEGRITY                     = 73;
  SQL_GETDATA_EXTENSIONS            = 81;
  SQL_NULL_COLLATION                = 85;
  SQL_ALTER_TABLE                   = 86;
  SQL_ORDER_BY_COLUMNS_IN_SELECT    = 90;
  SQL_SPECIAL_CHARACTERS            = 94;
  SQL_MAX_COLUMNS_IN_GROUP_BY       = 97;
  SQL_MAXIMUM_COLUMNS_IN_GROUP_BY   = SQL_MAX_COLUMNS_IN_GROUP_BY;
  SQL_MAX_COLUMNS_IN_INDEX          = 98;
  SQL_MAXIMUM_COLUMNS_IN_INDEX      = SQL_MAX_COLUMNS_IN_INDEX;
  SQL_MAX_COLUMNS_IN_ORDER_BY       = 99;
  SQL_MAXIMUM_COLUMNS_IN_ORDER_BY   = SQL_MAX_COLUMNS_IN_ORDER_BY;
  SQL_MAX_COLUMNS_IN_SELECT         = 100;
  SQL_MAXIMUM_COLUMNS_IN_SELECT     = SQL_MAX_COLUMNS_IN_SELECT;
  SQL_MAX_COLUMNS_IN_TABLE          = 101;
  SQL_MAX_INDEX_SIZE                = 102;
  SQL_MAXIMUM_INDEX_SIZE            = SQL_MAX_INDEX_SIZE;
  SQL_MAX_ROW_SIZE                  = 104;
  SQL_MAXIMUM_ROW_SIZE              = SQL_MAX_ROW_SIZE;
  SQL_MAX_STATEMENT_LEN             = 105;
  SQL_MAXIMUM_STATEMENT_LENGTH      = SQL_MAX_STATEMENT_LEN;
  SQL_MAX_TABLES_IN_SELECT          = 106;
  SQL_MAXIMUM_TABLES_IN_SELECT      = SQL_MAX_TABLES_IN_SELECT;
  SQL_MAX_USER_NAME_LEN             = 107;
  SQL_MAXIMUM_USER_NAME_LENGTH      = SQL_MAX_USER_NAME_LEN;
  SQL_OJ_CAPABILITIES               = 115;
  SQL_OUTER_JOIN_CAPABILITIES       = SQL_OJ_CAPABILITIES;
  SQL_XOPEN_CLI_YEAR                = 10000;
  SQL_CURSOR_SENSITIVITY            = 10001;
  SQL_DESCRIBE_PARAMETER            = 10002;
  SQL_CATALOG_NAME                  = 10003;
  SQL_COLLATION_SEQ                 = 10004;
  SQL_MAX_IDENTIFIER_LEN            = 10005;
  SQL_MAXIMUM_IDENTIFIER_LENGTH     = SQL_MAX_IDENTIFIER_LEN;

  // SQL_ALTER_TABLE bitmasks
  SQL_AT_ADD_COLUMN     = $00000001;
  SQL_AT_DROP_COLUMN    = $00000002;
  SQL_AT_ADD_CONSTRAINT = $00000008;

  // The following bitmasks are ODBC extensions
  SQL_AT_COLUMN_SINGLE                  = $00000020;
  SQL_AT_ADD_COLUMN_DEFAULT             = $00000040;
  SQL_AT_ADD_COLUMN_COLLATION           = $00000080;
  SQL_AT_SET_COLUMN_DEFAULT             = $00000100;
  SQL_AT_DROP_COLUMN_DEFAULT            = $00000200;
  SQL_AT_DROP_COLUMN_CASCADE            = $00000400;
  SQL_AT_DROP_COLUMN_RESTRICT           = $00000800;
  SQL_AT_ADD_TABLE_CONSTRAINT           = $00001000;
  SQL_AT_DROP_TABLE_CONSTRAINT_CASCADE  = $00002000;
  SQL_AT_DROP_TABLE_CONSTRAINT_RESTRICT = $00004000;
  SQL_AT_CONSTRAINT_NAME_DEFINITION     = $00008000;
  SQL_AT_CONSTRAINT_INITIALLY_DEFERRED  = $00010000;
  SQL_AT_CONSTRAINT_INITIALLY_IMMEDIATE = $00020000;
  SQL_AT_CONSTRAINT_DEFERRABLE          = $00040000;
  SQL_AT_CONSTRAINT_NON_DEFERRABLE      = $00080000;

  // SQL_ASYNC_MODE values
  SQL_AM_NONE       = 0;
  SQL_AM_CONNECTION = 1;
  SQL_AM_STATEMENT  = 2;

  // SQL_CURSOR_COMMIT_BEHAVIOR values
  SQL_CB_DELETE   = 0;
  SQL_CB_CLOSE    = 1;
  SQL_CB_PRESERVE = 2;

  // SQL_FETCH_DIRECTION bitmasks
  SQL_FD_FETCH_NEXT     = $00000001;
  SQL_FD_FETCH_FIRST    = $00000002;
  SQL_FD_FETCH_LAST     = $00000004;
  SQL_FD_FETCH_PRIOR    = $00000008;
  SQL_FD_FETCH_ABSOLUTE = $00000010;
  SQL_FD_FETCH_RELATIVE = $00000020;

  // SQL_GETDATA_EXTENSIONS bitmasks
  SQL_GD_ANY_COLUMN = $00000001;
  SQL_GD_ANY_ORDER  = $00000002;

  // SQL_IDENTIFIER_CASE values
  SQL_IC_UPPER     = 1;
  SQL_IC_LOWER     = 2;
  SQL_IC_SENSITIVE = 3;
  SQL_IC_MIXED     = 4;

  // SQL_OJ_CAPABILITIES bitmasks
  // NB: this means 'outer join', not what you may be thinking
  SQL_OJ_LEFT               = $00000001;
  SQL_OJ_RIGHT              = $00000002;
  SQL_OJ_FULL               = $00000004;
  SQL_OJ_NESTED             = $00000008;
  SQL_OJ_NOT_ORDERED        = $00000010;
  SQL_OJ_INNER              = $00000020;
  SQL_OJ_ALL_COMPARISON_OPS = $00000040;

  // SQL_SCROLL_CONCURRENCY bitmasks
  SQL_SCCO_READ_ONLY  = $00000001;
  SQL_SCCO_LOCK       = $00000002;
  SQL_SCCO_OPT_ROWVER = $00000004;
  SQL_SCCO_OPT_VALUES = $00000008;

  // SQL_TXN_CAPABLE values
  SQL_TC_NONE       = 0;
  SQL_TC_DML        = 1;
  SQL_TC_ALL        = 2;
  SQL_TC_DDL_COMMIT = 3;
  SQL_TC_DDL_IGNORE = 4;

  // SQL_TXN_ISOLATION_OPTION bitmasks
  SQL_TXN_READ_UNCOMMITTED         = $00000001;
  SQL_TRANSACTION_READ_UNCOMMITTED = SQL_TXN_READ_UNCOMMITTED;
  SQL_TXN_READ_COMMITTED           = $00000002;
  SQL_TRANSACTION_READ_COMMITTED   = SQL_TXN_READ_COMMITTED;
  SQL_TXN_REPEATABLE_READ          = $00000004;
  SQL_TRANSACTION_REPEATABLE_READ  = SQL_TXN_REPEATABLE_READ;
  SQL_TXN_SERIALIZABLE             = $00000008;
  SQL_TRANSACTION_SERIALIZABLE     = SQL_TXN_SERIALIZABLE;

  // SQL_NULL_COLLATION values
  SQL_NC_HIGH = 0;
  SQL_NC_LOW  = 1;

type
  // Deprecated
  TSQLAllocConnect = function(
    EnvironmentHandle:    SQLHEnv;
    var ConnectionHandle: SQLHDbc
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  // Deprecated
  TSQLAllocEnv = function(
    var EnvironmentHandle: SQLHEnv
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLAllocHandle = function(
    HandleType:       SQLSmallint;
    InputHandle:      SQLHandle;
    var OutputHandle: SQLHandle
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  // Deprecated
  TSQLAllocStmt = function(
    ConnectionHandle:    SQLHDbc;
    var StatementHandle: SQLHStmt
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLBindCol = function(
    StatementHandle: SQLHStmt;
    ColumnNumber:    SQLUSmallint;
    TargetType:      SQLSmallint;
    TargetValue:     SQLPointer;
    BufferLength:    SQLInteger;
    StrLen_or_Ind:   PSQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLBindParam = function(
    StatementHandle:   SQLHStmt;
    ParameterNumber:   SQLUSmallint;
    ValueType:         SQLSmallint;
    ParameterType:     SQLSmallint;
    LengthPrecision:   SQLUInteger;
    ParameterScale:    SQLSmallint;
    ParameterValue:    SQLPointer;
    var StrLen_or_Ind: SQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLCancel = function(
    StatementHandle: SQLHStmt
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLCloseCursor = function(
    StatementHandle: SQLHStmt
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  // SQLColAttribute is overloaded

  TSQLColAttribute = function(
    StatementHandle:     SQLHStmt;
    ColumnNumber:        SQLUSmallint;
    FieldIdentifier:     SQLUSmallint;
    CharacterAttribute:  SQLPointer;
    BufferLength:        SQLSmallint;
    StringLength:        PSQLSmallint;
    NumericAttributePtr: SQLPointer
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  // Overloaded version for String attributes
  TSQLColAttributeString = function(
    StatementHandle:    SQLHStmt;
    ColumnNumber:       SQLUSmallint;
    FieldIdentifier:    SQLUSmallint;
    CharacterAttribute: SQLPointer;
    BufferLength:       SQLSmallint;
    var StringLength:   SQLSmallint;
    NumericAttribute:   SQLPointer
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

   // Overloaded version for Integer attributes
  TSQLColAttributeInt = function(
    StatementHandle:      SQLHStmt;
    ColumnNumber:         SQLUSmallint;
    FieldIdentifier:      SQLUSmallint;
    CharacterAttribute:   SQLPointer;
    BufferLength:         SQLSmallint;
    StringLength:         PSQLSmallint;
    var NumericAttribute: SQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLColumns = function(
    StatementHandle: SQLHStmt;
    CatalogName:     PSQLChar;
    NameLength1:     SQLSmallint;
    SchemaName:      PSQLChar;
    NameLength2:     SQLSmallint;
    TableName:       PSQLChar;
    NameLength3:     SQLSmallint;
    ColumnName:      PSQLChar;
    NameLength4:     SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLConnect = function(
    ConnectionHandle: SQLHDbc;
    ServerName:       PSQLChar;
    NameLength1:      SQLSmallint;
    UserName:         PSQLChar;
    NameLength2:      SQLSmallint;
    Authentication:   PSQLChar;
    NameLength3:      SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLCopyDesc = function(
    SourceDescHandle: SQLHDesc;
    TargetDescHandle: SQLHDesc
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLDataSources = function(
    EnvironmentHandle: SQLHEnv;
    Direction:         SQLUSmallint;
    ServerName:        PSQLChar;
    BufferLength1:     SQLSmallint;
    var NameLength1:   SQLSmallint;
    Description:       PSQLChar;
    BufferLength2:     SQLSmallint;
    var NameLength2:   SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLDescribeCol = function(
    StatementHandle:   SQLHStmt;
    ColumnNumber:      SQLUSmallint;
    ColumnName:        PSQLChar;
    BufferLength:      SQLSmallint;
    var NameLength:    SQLSmallint;
    var DataType:      SQLSmallint;
    var ColumnSize:    SQLUInteger;
    var DecimalDigits: SQLSmallint;
    var Nullable:      SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLDisconnect = function(
    ConnectionHandle: SQLHDbc
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLEndTran = function(
    HandleType:     SQLSmallint;
    Handle:         SQLHandle;
    CompletionType: SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  // Deprecated
  TSQLError = function(
    EnvironmentHandle: SQLHEnv;
    ConnectionHandle:  SQLHDbc;
    StatementHandle:   SQLHStmt;
    var SQLstate:      SQLChar;
    var NativeError:   SQLInteger;
    var MessageText:   SQLChar;
    BufferLength:      SQLSmallint;
    var TextLength:    SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLExecDirect = function(
    StatementHandle: SQLHStmt;
    StatementText:   PSQLChar;
    TextLength:      SQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLExecute = function(
    StatementHandle: SQLHStmt
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLFetch = function(
    StatementHandle: SQLHStmt
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLFetchScroll = function(
    StatementHandle:  SQLHStmt;
    FetchOrientation: SQLSmallint;
    FetchOffset:      SQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  // Deprecated
  TSQLFreeConnect = function(
    ConnectionHandle: SQLHDbc
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  // Deprecated
  TSQLFreeEnv = function(
    EnvironmentHandle: SQLHEnv
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLFreeHandle = function(
    HandleType: SQLSmallint;
    Handle:     SQLHandle
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  // Deprecated
  TSQLFreeStmt = function(
    StatementHandle: SQLHStmt;
    Option:          SQLUSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  // SQLGetConnectAttr is overloaded. See OBDC API doc:
  // "Depending on the value of Attribute,
  //  ValuePtr will be a 32-bit unsigned integer value
  //  or will point to a null-terminated character string."

  TSQLGetConnectAttr = function(
    ConnectionHandle: SQLHDbc;
    Attribute:        SQLInteger;
    ValuePtr:         SQLPointer;
    BufferLength:     SQLInteger;
    var StringLength: SQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLGetConnectOption = function(
    ConnectionHandle: SQLHDbc;
    Option:           SQLUSmallint;
    Value:            SQLPointer
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLGetCursorName = function(
    StatementHandle: SQLHStmt;
    CursorName:      PSQLChar;
    BufferLength:    SQLSmallint;
    var NameLength:  SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLGetData = function(
    StatementHandle: SQLHStmt;
    ColumnNumber:    SQLUSmallint;
    TargetType:      SQLSmallint;
    TargetValue:     SQLPointer;
    BufferLength:    SQLInteger;
    StrLen_or_Ind:   PSQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLGetDescField = function(
    DescriptorHandle: SQLHDesc;
    RecNumber:        SQLSmallint;
    FieldIdentifier:  SQLSmallint;
    Value:            SQLPointer;
    BufferLength:     SQLInteger;
    var StringLength: SQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLGetDescRec = function(
    DescriptorHandle: SQLHDesc;
    RecNumber:        SQLSmallint;
    var Name:         SQLChar;
    BufferLength:     SQLSmallint;
    var StringLength: SQLSmallint;
    var _Type:        SQLSmallint;
    var SubType:      SQLSmallint;
    var Length:       SQLInteger;
    var Precision:    SQLSmallint;
    var Scale:        SQLSmallint;
    var Nullable:     SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLGetDiagField = function(
    HandleType:       SQLSmallint;
    Handle:           SQLHandle;
    RecNumber:        SQLSmallint;
    DiagIdentifier:   SQLSmallint;
    DiagInfo:         SQLPointer;
    BufferLength:     SQLSmallint;
    var StringLength: SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLGetDiagRec = function(
    HandleType:      SQLSmallint;
    Handle:          SQLHandle;
    RecNumber:       SQLSmallint;
    SQLstate:        PSQLChar; // pointer to 5 character buffer
    var NativeError: SQLInteger;
    MessageText:     PSQLChar;
    BufferLength:    SQLSmallint;
    var TextLength:  SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLGetEnvAttr = function(
    EnvironmentHandle: SQLHEnv;
    Attribute:         SQLInteger;
    Value:             SQLPointer;
    BufferLength:      SQLInteger;
    var StringLength:  SQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLGetFunctions = function(
    ConnectionHandle: SQLHDbc;
    FunctionId:       SQLUSmallint;
    var Supported:    SQLUSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  // SQLGetInfo is overloaded. See OBDC API doc:
  // "Depending on the InfoType requested,
  //  the information returned will be one of the following:
  //  a null-terminated character string,
  //  an SQLUSMALLINT value,
  //  an SQLUINTEGER bitmask,
  //  an SQLUINTEGER flag,
  //  or a SQLUINTEGER binary value."

  TSQLGetInfo = function(
    ConnectionHandle: SQLHDbc;
    InfoType:         SQLUSmallint;
    InfoValuePtr:     SQLPointer;
    BufferLength:     SQLSmallint;
    StringLengthPtr:  SQLPointer
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLGetInfoString = function(
    ConnectionHandle: SQLHDbc;
    InfoType:         SQLUSmallint;
    InfoValueString:  PSQLChar;       // PSQLWChar when calling SQLGetInfoW
    BufferLength:     SQLSmallint;
    var StringLength: SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLGetInfoSmallint = function(
    ConnectionHandle: SQLHDbc;
    InfoType:         SQLUSmallint;
    var InfoValue:    SQLUSmallint;
    Ignored1:         SQLSmallint;    // I seems to be a SizeOf(SQLSmallint)
    Ignored2:         SQLPointer
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLGetInfoInt = function(
    ConnectionHandle: SQLHDbc;
    InfoType:         SQLUSmallint;
    var InfoValue:    SQLUInteger;
    Ignored1:         SQLSmallint;    // I seems to be a SizeOf(SQLInteger)
    Ignored2:         SQLPointer
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLGetStmtAttr = function(
    StatementHandle:  SQLHStmt;
    Attribute:        SQLInteger;
    Value:            SQLPointer;
    BufferLength:     SQLInteger;
    var StringLength: SQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLGetStmtOption = function(
    StatementHandle: SQLHStmt;
    Option:          SQLUSmallint;
    Value:           SQLPointer
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLGetTypeInfo = function(
    StatementHandle: SQLHStmt;
    DataType:        SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLNumResultCols = function(
    StatementHandle: SQLHStmt;
    var ColumnCount: SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLParamData = function(
    StatementHandle: SQLHStmt;
    var Value:       SQLPointer
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLPrepare = function(
    StatementHandle: SQLHStmt;
    StatementText:   PSQLChar;
    TextLength:      SQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLPutData = function(
    StatementHandle: SQLHStmt;
    Data:            SQLPointer;
    StrLen_or_Ind:   SQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLRowCount = function(
    StatementHandle: SQLHStmt;
    var RowCount:    SQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLSetConnectAttr = function(
    ConnectionHandle: SQLHDbc;
    Attribute:        SQLInteger;
    ValuePtr:         SQLPointer;
    StringLength:     SQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLSetConnectOption = function(
    ConnectionHandle: SQLHDbc;
    Option:           SQLUSmallint;
    Value:            SQLUInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLSetCursorName = function(
    StatementHandle: SQLHStmt;
    CursorName:      PSQLChar;
    NameLength:      SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLSetDescField = function(
    DescriptorHandle: SQLHDesc;
    RecNumber:        SQLSmallint;
    FieldIdentifier:  SQLSmallint;
    Value:            SQLPointer;
    BufferLength:     SQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLSetDescRec = function(
    DescriptorHandle: SQLHDesc;
    RecNumber:        SQLSmallint;
    _Type:            SQLSmallint;
    SubType:          SQLSmallint;
    Length:           SQLInteger;
    Precision:        SQLSmallint;
    Scale:            SQLSmallint;
    Data:             SQLPointer;
    var StringLength: SQLInteger;
    var Indicator:    SQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  // SQLSetEnvAttr is overloaded. See OBDC API doc:
  // "Depending on the value of Attribute,
  //  value will be a 32-bit integer value
  //  or point to a null-terminated character string."

  TSQLSetEnvAttr = function(
    EnvironmentHandle: SQLHEnv;
    Attribute:         SQLInteger;
    ValuePtr:          SQLPointer;
    StringLength:      SQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLSetParam = function(
    StatementHandle:   SQLHStmt;
    ParameterNumber:   SQLUSmallint;
    ValueType:         SQLSmallint;
    ParameterType:     SQLSmallint;
    LengthPrecision:   SQLUInteger;
    ParameterScale:    SQLSmallint;
    ParameterValue:    SQLPointer;
    var StrLen_or_Ind: SQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLSetStmtAttr = function(
    StatementHandle: SQLHStmt;
    Attribute:       SQLInteger;
    Value:           SQLPointer;
    StringLength:    SQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLSetStmtOption = function(
    StatementHandle: SQLHStmt;
    Option:          SQLUSmallint;
    Value:           SQLUInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLSpecialColumns = function(
    StatementHandle: SQLHStmt;
    IdentifierType:  SQLUSmallint;
    CatalogName:     PSQLChar;
    NameLength1:     SQLSmallint;
    SchemaName:      PSQLChar;
    NameLength2:     SQLSmallint;
    TableName:       PSQLChar;
    NameLength3:     SQLSmallint;
    Scope:           SQLUSmallint;
    Nullable:        SQLUSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLStatistics = function(
    StatementHandle: SQLHStmt;
    CatalogName:     PSQLChar;
    NameLength1:     SQLSmallint;
    SchemaName:      PSQLChar;
    NameLength2:     SQLSmallint;
    TableName:       PSQLChar;
    NameLength3:     SQLSmallint;
    Unique:          SQLUSmallint;
    Reserved:        SQLUSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLTables = function(
    StatementHandle: SQLHStmt;
    CatalogName:     PSQLChar;
    NameLength1:     SQLSmallint;
    SchemaName:      PSQLChar;
    NameLength2:     SQLSmallint;
    TableName:       PSQLChar;
    NameLength3:     SQLSmallint;
    TableType:       PSQLChar;
    NameLength4:     SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLTransact = function(
    EnvironmentHandle: SQLHEnv;
    ConnectionHandle:  SQLHDbc;
    CompletionType:    SQLUSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLState = array[0..5] of PSQLChar;
  PSQLState = PSQLChar;

const
  ODBCVER = $0351;

  SQL_WCHAR        = -8;
  SQL_WVARCHAR     = -9;
  SQL_WLONGVARCHAR = -10;

  // Generally useful constants
  SQL_SPEC_MAJOR  = 3;       // Major version of specification
  SQL_SPEC_MINOR  = 51;      // Minor version of specification
  SQL_SPEC_STRING = '03.51'; // String constant for version

  SQL_SQLSTATE_SIZE  = 5;  // Size of SQLSTATE
  SQL_MAX_DSN_LENGTH = 32; // Maximum data source name size

  SQL_MAX_OPTION_STRING_LENGTH = 256;

  // Return code SQL_NO_DATA_FOUND is the same as SQL_NO_DATA
  SQL_NO_DATA_FOUND = SQL_NO_DATA;

  // An env handle type
  SQL_HANDLE_SENV = 5;

  // Environment attributes
  SQL_ATTR_ODBC_VERSION       = 200;
  SQL_ATTR_CONNECTION_POOLING = 201;
  SQL_ATTR_CP_MATCH           = 202;

  // Values for SQL_ATTR_CONNECTION_POOLING
  SQL_CP_OFF            = ULong(0);
  SQL_CP_ONE_PER_DRIVER = ULong(1);
  SQL_CP_ONE_PER_HENV   = ULong(2);
  SQL_CP_DEFAULT        = SQL_CP_OFF;

  // Values for SQL_ATTR_CP_MATCH
  SQL_CP_STRICT_MATCH  = ULong(0);
  SQL_CP_RELAXED_MATCH = ULong(1);
  SQL_CP_MATCH_DEFAULT = SQL_CP_STRICT_MATCH;

  // Values for SQL_ATTR_ODBC_VERSION
  SQL_OV_ODBC2 = ULong(2);
  SQL_OV_ODBC3 = ULong(3);

  // Connection attributes
  SQL_ACCESS_MODE       = 101;
  SQL_AUTOCOMMIT        = 102;
  SQL_LOGIN_TIMEOUT     = 103;
  SQL_OPT_TRACE         = 104;
  SQL_OPT_TRACEFILE     = 105;
  SQL_TRANSLATE_DLL     = 106;
  SQL_TRANSLATE_OPTION  = 107;
  SQL_TXN_ISOLATION     = 108;
  SQL_CURRENT_QUALIFIER = 109;
  SQL_ODBC_CURSORS      = 110;
  SQL_QUIET_MODE        = 111;
  SQL_PACKET_SIZE       = 112;

  // Connection attributes with new names
  SQL_ATTR_ACCESS_MODE         = SQL_ACCESS_MODE;
  SQL_ATTR_AUTOCOMMIT          = SQL_AUTOCOMMIT;
  SQL_ATTR_CONNECTION_TIMEOUT  = 113;
  SQL_ATTR_CURRENT_CATALOG     = SQL_CURRENT_QUALIFIER;
  SQL_ATTR_DISCONNECT_BEHAVIOR = 114;
  SQL_ATTR_ENLIST_IN_DTC       = 1207;
  SQL_ATTR_ENLIST_IN_XA        = 1208;
  SQL_ATTR_LOGIN_TIMEOUT       = SQL_LOGIN_TIMEOUT;
  SQL_ATTR_ODBC_CURSORS        = SQL_ODBC_CURSORS;
  SQL_ATTR_PACKET_SIZE         = SQL_PACKET_SIZE;
  SQL_ATTR_QUIET_MODE          = SQL_QUIET_MODE;
  SQL_ATTR_TRACE               = SQL_OPT_TRACE;
  SQL_ATTR_TRACEFILE           = SQL_OPT_TRACEFILE;
  SQL_ATTR_TRANSLATE_LIB       = SQL_TRANSLATE_DLL;
  SQL_ATTR_TRANSLATE_OPTION    = SQL_TRANSLATE_OPTION;
  SQL_ATTR_TXN_ISOLATION       = SQL_TXN_ISOLATION;
  SQL_ATTR_CONNECTION_DEAD     = 1209;                   // GetConnectAttr only

  { ODBC Driver Manager sets this connection attribute to an unicode driver
    (which supports SQLConnectW) when the application is an ANSI application
    (which calls SQLConnect, SQLDriverConnect, or SQLBrowseConnect).
    This is SetConnectAttr only and application does not set this attribute
    This attribute was introduced because some unicode driver's some APIs may
    need to behave differently on ANSI or Unicode applications. A unicode
    driver, which has same behavior for both ANSI or Unicode applications,
    should return SQL_ERROR when the driver manager sets this connection
    attribute. When a unicode driver returns SQL_SUCCESS on this attribute,
    the driver manager treates ANSI and Unicode connections differently in
    connection pooling. }
  SQL_ATTR_ANSI_APP = 115;

  // SQL_ACCESS_MODE options
  SQL_MODE_READ_WRITE = ULong(0);
  SQL_MODE_READ_ONLY  = ULong(1);
  SQL_MODE_DEFAULT    = SQL_MODE_READ_WRITE;

  // SQL_AUTOCOMMIT options
  SQL_AUTOCOMMIT_OFF     = ULong(0);
  SQL_AUTOCOMMIT_ON      = ULong(1);
  SQL_AUTOCOMMIT_DEFAULT = SQL_AUTOCOMMIT_ON;

  // SQL_LOGIN_TIMEOUT options
  SQL_LOGIN_TIMEOUT_DEFAULT = ULong(15);

  // SQL_OPT_TRACE options
  SQL_OPT_TRACE_OFF          = ULong(0);
  SQL_OPT_TRACE_ON           = ULong(1);
  SQL_OPT_TRACE_DEFAULT      = SQL_OPT_TRACE_OFF;
  SQL_OPT_TRACE_FILE_DEFAULT = '\\SQL.LOG';

  // SQL_ODBC_CURSORS options
  SQL_CUR_USE_IF_NEEDED = ULong(0);
  SQL_CUR_USE_ODBC      = ULong(1);
  SQL_CUR_USE_DRIVER    = ULong(2);
  SQL_CUR_DEFAULT       = SQL_CUR_USE_DRIVER;

  // Values for SQL_ATTR_DISCONNECT_BEHAVIOR
  SQL_DB_RETURN_TO_POOL = ULong(0);
  SQL_DB_DISCONNECT     = ULong(1);
  SQL_DB_DEFAULT        = SQL_DB_RETURN_TO_POOL;

  // Values for SQL_ATTR_ENLIST_IN_DTC
  SQL_DTC_DONE = 0;

  // Values for SQL_ATTR_CONNECTION_DEAD
  SQL_CD_TRUE  = 1; // Connection is closed/dead
  SQL_CD_FALSE = 0; // Connection is open/available

  // Values for SQL_ATTR_ANSI_APP
  SQL_AA_TRUE  = 1; // the application is an ANSI app
  SQL_AA_FALSE = 0; // the application is a Unicode app

  // Statement attributes
  SQL_QUERY_TIMEOUT   = 0;
  SQL_MAX_ROWS        = 1;
  SQL_NOSCAN          = 2;
  SQL_MAX_LENGTH      = 3;
  SQL_ASYNC_ENABLE    = 4;  // Same as SQL_ATTR_ASYNC_ENABLE
  SQL_BIND_TYPE       = 5;
  SQL_CURSOR_TYPE     = 6;
  SQL_CONCURRENCY     = 7;
  SQL_KEYSET_SIZE     = 8;
  SQL_ROWSET_SIZE     = 9;
  SQL_SIMULATE_CURSOR = 10;
  SQL_RETRIEVE_DATA   = 11;
  SQL_USE_BOOKMARKS   = 12;
  SQL_GET_BOOKMARK    = 13; // GetStmtOption Only
  SQL_ROW_NUMBER      = 14; // GetStmtOption Only

  SQL_ATTR_ASYNC_ENABLE          = 4;
  SQL_ATTR_CONCURRENCY           = SQL_CONCURRENCY;
  SQL_ATTR_CURSOR_TYPE           = SQL_CURSOR_TYPE;
  SQL_ATTR_ENABLE_AUTO_IPD       = 15;
  SQL_ATTR_FETCH_BOOKMARK_PTR    = 16;
  SQL_ATTR_KEYSET_SIZE           = SQL_KEYSET_SIZE;
  SQL_ATTR_MAX_LENGTH            = SQL_MAX_LENGTH;
  SQL_ATTR_MAX_ROWS              = SQL_MAX_ROWS;
  SQL_ATTR_NOSCAN                = SQL_NOSCAN;
  SQL_ATTR_PARAM_BIND_OFFSET_PTR = 17;
  SQL_ATTR_PARAM_BIND_TYPE       = 18;
  SQL_ATTR_PARAM_OPERATION_PTR   = 19;
  SQL_ATTR_PARAM_STATUS_PTR      = 20;
  SQL_ATTR_PARAMS_PROCESSED_PTR  = 21;
  SQL_ATTR_PARAMSET_SIZE         = 22;
  SQL_ATTR_QUERY_TIMEOUT         = SQL_QUERY_TIMEOUT;
  SQL_ATTR_RETRIEVE_DATA         = SQL_RETRIEVE_DATA;
  SQL_ATTR_ROW_BIND_OFFSET_PTR   = 23;
  SQL_ATTR_ROW_BIND_TYPE         = SQL_BIND_TYPE;
  SQL_ATTR_ROW_NUMBER            = SQL_ROW_NUMBER;      // GetStmtAttr
  SQL_ATTR_ROW_OPERATION_PTR     = 24;
  SQL_ATTR_ROW_STATUS_PTR        = 25;
  SQL_ATTR_ROWS_FETCHED_PTR      = 26;
  SQL_ATTR_ROW_ARRAY_SIZE        = 27;
  SQL_ATTR_SIMULATE_CURSOR       = SQL_SIMULATE_CURSOR;
  SQL_ATTR_USE_BOOKMARKS         = SQL_USE_BOOKMARKS;

  // SQLColAttributes defines
  SQL_COLUMN_COUNT          = 0;
  SQL_COLUMN_NAME           = 1;
  SQL_COLUMN_TYPE           = 2;
  SQL_COLUMN_LENGTH         = 3;
  SQL_COLUMN_PRECISION      = 4;
  SQL_COLUMN_SCALE          = 5;
  SQL_COLUMN_DISPLAY_SIZE   = 6;
  SQL_COLUMN_NULLABLE       = 7;
  SQL_COLUMN_UNSIGNED       = 8;
  SQL_COLUMN_MONEY          = 9;
  SQL_COLUMN_UPDATABLE      = 10;
  SQL_COLUMN_AUTO_INCREMENT = 11;
  SQL_COLUMN_CASE_SENSITIVE = 12;
  SQL_COLUMN_SEARCHABLE     = 13;
  SQL_COLUMN_TYPE_NAME      = 14;
  SQL_COLUMN_TABLE_NAME     = 15;
  SQL_COLUMN_OWNER_NAME     = 16;
  SQL_COLUMN_QUALIFIER_NAME = 17;
  SQL_COLUMN_LABEL          = 18;

  // For MSSQL sql_variant C subtype
  SQL_CA_SS_VARIANT_TYPE    = 1215;

  SQL_COLATT_OPT_MAX = SQL_COLUMN_LABEL;
  SQL_COLATT_OPT_MIN = SQL_COLUMN_COUNT;

  // SQLColAttributes subdefines for SQL_COLUMN_UPDATABLE
  SQL_ATTR_READONLY          = 0;
  SQL_ATTR_WRITE             = 1;
  SQL_ATTR_READWRITE_UNKNOWN = 2;

  // SQLColAttributes subdefines for SQL_COLUMN_SEARCHABLE
  // These are also used by SQLGetInfo
  SQL_UNSEARCHABLE    = 0;
  SQL_LIKE_ONLY       = 1;
  SQL_ALL_EXCEPT_LIKE = 2;
  SQL_SEARCHABLE      = 3;
  SQL_PRED_SEARCHABLE = SQL_SEARCHABLE;

  // Special return values for SQLGetData
  SQL_NO_TOTAL =  -4;

  // New defines for SEARCHABLE column in SQLGetTypeInfo
  SQL_COL_PRED_CHAR  = SQL_LIKE_ONLY;
  SQL_COL_PRED_BASIC = SQL_ALL_EXCEPT_LIKE;

  // Whether an attribute is a pointer or not
  SQL_IS_POINTER   = -4;
  SQL_IS_UINTEGER  = -5;
  SQL_IS_INTEGER   = -6;
  SQL_IS_USMALLINT = -7;
  SQL_IS_SMALLINT  = -8;

  // The value of SQL_ATTR_PARAM_BIND_TYPE
  SQL_PARAM_BIND_BY_COLUMN    = ULong(0);
  SQL_PARAM_BIND_TYPE_DEFAULT = SQL_PARAM_BIND_BY_COLUMN;

  // SQL_QUERY_TIMEOUT options
  SQL_QUERY_TIMEOUT_DEFAULT = ULong(0);

  // SQL_MAX_ROWS options
  SQL_MAX_ROWS_DEFAULT = ULong(0);

  // SQL_NOSCAN options
  SQL_NOSCAN_OFF     = ULong(0);       // 1.0 FALSE
  SQL_NOSCAN_ON      = ULong(1);       // 1.0 TRUE
  SQL_NOSCAN_DEFAULT = SQL_NOSCAN_OFF;

  // SQL_MAX_LENGTH options
  SQL_MAX_LENGTH_DEFAULT = ULong(0);

  // Values for SQL_ATTR_ASYNC_ENABLE
  SQL_ASYNC_ENABLE_OFF     = ULong(0);
  SQL_ASYNC_ENABLE_ON      = ULong(1);
  SQL_ASYNC_ENABLE_DEFAULT = SQL_ASYNC_ENABLE_OFF;

  // SQL_BIND_TYPE options
  SQL_BIND_BY_COLUMN    = ULong(0);
  SQL_BIND_TYPE_DEFAULT = SQL_BIND_BY_COLUMN; // Default value

  // SQL_CONCURRENCY options
  SQL_CONCUR_READ_ONLY = 1;
  SQL_CONCUR_LOCK      = 2;
  SQL_CONCUR_ROWVER    = 3;
  SQL_CONCUR_VALUES    = 4;
  SQL_CONCUR_DEFAULT   = SQL_CONCUR_READ_ONLY; // Default value

  // SQL_CURSOR_TYPE options
  SQL_CURSOR_FORWARD_ONLY  = ULong(0);
  SQL_CURSOR_KEYSET_DRIVEN = ULong(1);
  SQL_CURSOR_DYNAMIC       = ULong(2);
  SQL_CURSOR_STATIC        = ULong(3);
  SQL_CURSOR_TYPE_DEFAULT  = SQL_CURSOR_FORWARD_ONLY; // Default value

  // SQL_ROWSET_SIZE options
  SQL_ROWSET_SIZE_DEFAULT = ULong(1);

  // SQL_KEYSET_SIZE options
  SQL_KEYSET_SIZE_DEFAULT = ULong(0);

  // SQL_SIMULATE_CURSOR options
  SQL_SC_NON_UNIQUE = ULong(0);
  SQL_SC_TRY_UNIQUE = ULong(1);
  SQL_SC_UNIQUE     = ULong(2);

  // SQL_RETRIEVE_DATA options
  SQL_RD_OFF     = ULong(0);
  SQL_RD_ON      = ULong(1);
  SQL_RD_DEFAULT = SQL_RD_ON;

  // SQL_USE_BOOKMARKS options
  SQL_UB_OFF     = ULong(0);
  SQL_UB_ON      = ULong(1);
  SQL_UB_DEFAULT = SQL_UB_OFF;

  // New values for SQL_USE_BOOKMARKS attribute
  SQL_UB_FIXED    = SQL_UB_ON;
  SQL_UB_VARIABLE = ULong(2);

  // Extended descriptor field
  SQL_DESC_ARRAY_SIZE                  = 20;
  SQL_DESC_ARRAY_STATUS_PTR            = 21;
  SQL_DESC_AUTO_UNIQUE_VALUE           = SQL_COLUMN_AUTO_INCREMENT;
  SQL_DESC_BASE_COLUMN_NAME            = 22;
  SQL_DESC_BASE_TABLE_NAME             = 23;
  SQL_DESC_BIND_OFFSET_PTR             = 24;
  SQL_DESC_BIND_TYPE                   = 25;
  SQL_DESC_CASE_SENSITIVE              = SQL_COLUMN_CASE_SENSITIVE;
  SQL_DESC_CATALOG_NAME                = SQL_COLUMN_QUALIFIER_NAME;
  SQL_DESC_CONCISE_TYPE                = SQL_COLUMN_TYPE;
  SQL_DESC_DATETIME_INTERVAL_PRECISION = 26;
  SQL_DESC_DISPLAY_SIZE                = SQL_COLUMN_DISPLAY_SIZE;
  SQL_DESC_FIXED_PREC_SCALE            = SQL_COLUMN_MONEY;
  SQL_DESC_LABEL                       = SQL_COLUMN_LABEL;
  SQL_DESC_LITERAL_PREFIX              = 27;
  SQL_DESC_LITERAL_SUFFIX              = 28;
  SQL_DESC_LOCAL_TYPE_NAME             = 29;
  SQL_DESC_MAXIMUM_SCALE               = 30;
  SQL_DESC_MINIMUM_SCALE               = 31;
  SQL_DESC_NUM_PREC_RADIX              = 32;
  SQL_DESC_PARAMETER_TYPE              = 33;
  SQL_DESC_ROWS_PROCESSED_PTR          = 34;
  SQL_DESC_ROWVER                      = 35;
  SQL_DESC_SCHEMA_NAME                 = SQL_COLUMN_OWNER_NAME;
  SQL_DESC_SEARCHABLE                  = SQL_COLUMN_SEARCHABLE;
  SQL_DESC_TYPE_NAME                   = SQL_COLUMN_TYPE_NAME;
  SQL_DESC_TABLE_NAME                  = SQL_COLUMN_TABLE_NAME;
  SQL_DESC_UNSIGNED                    = SQL_COLUMN_UNSIGNED;
  SQL_DESC_UPDATABLE                   = SQL_COLUMN_UPDATABLE;

  // Defines for diagnostics fields
  SQL_DIAG_CURSOR_ROW_COUNT = -1249;
  SQL_DIAG_ROW_NUMBER       = -1248;
  SQL_DIAG_COLUMN_NUMBER    = -1247;

  // SQL extended datatypes
  SQL_DATE          = 9;
  SQL_INTERVAL      = 10;
  SQL_TIME          = 10;
  SQL_TIMESTAMP     = 11;
  SQL_LONGVARCHAR   = -1;
  SQL_BINARY        = -2;
  SQL_VARBINARY     = -3;
  SQL_LONGVARBINARY = -4;
  SQL_BIGINT        = -5;
  SQL_TINYINT       = -6;
  SQL_BIT           = -7;
  SQL_GUID          = -11;

  // This is a new MSSQL Server data type
  SQL_SS_VARIANT    = -150;

  // These are IBM DB2 data types
  SQL_DB2DBCLOB     = -97;

  // These types are used if LONGDATA_COMPAT don't set to SQL_LD_COMPAT_YES
  SQL_DB2BLOB       = -98;
  SQL_DB2CLOB       = -99;

  // Oracle
  SQL_REFCURSOR    = -403;

  // Interval code
  SQL_CODE_YEAR             = 1;
  SQL_CODE_MONTH            = 2;
  SQL_CODE_DAY              = 3;
  SQL_CODE_HOUR             = 4;
  SQL_CODE_MINUTE           = 5;
  SQL_CODE_SECOND           = 6;
  SQL_CODE_YEAR_TO_MONTH    = 7;
  SQL_CODE_DAY_TO_HOUR      = 8;
  SQL_CODE_DAY_TO_MINUTE    = 9;
  SQL_CODE_DAY_TO_SECOND    = 10;
  SQL_CODE_HOUR_TO_MINUTE   = 11;
  SQL_CODE_HOUR_TO_SECOND   = 12;
  SQL_CODE_MINUTE_TO_SECOND = 13;

  SQL_INTERVAL_YEAR             = (100 + SQL_CODE_YEAR);
  SQL_INTERVAL_MONTH            = (100 + SQL_CODE_MONTH);
  SQL_INTERVAL_DAY              = (100 + SQL_CODE_DAY);
  SQL_INTERVAL_HOUR             = (100 + SQL_CODE_HOUR);
  SQL_INTERVAL_MINUTE           = (100 + SQL_CODE_MINUTE);
  SQL_INTERVAL_SECOND           = (100 + SQL_CODE_SECOND);
  SQL_INTERVAL_YEAR_TO_MONTH    = (100 + SQL_CODE_YEAR_TO_MONTH);
  SQL_INTERVAL_DAY_TO_HOUR      = (100 + SQL_CODE_DAY_TO_HOUR);
  SQL_INTERVAL_DAY_TO_MINUTE    = (100 + SQL_CODE_DAY_TO_MINUTE);
  SQL_INTERVAL_DAY_TO_SECOND    = (100 + SQL_CODE_DAY_TO_SECOND);
  SQL_INTERVAL_HOUR_TO_MINUTE   = (100 + SQL_CODE_HOUR_TO_MINUTE);
  SQL_INTERVAL_HOUR_TO_SECOND   = (100 + SQL_CODE_HOUR_TO_SECOND);
  SQL_INTERVAL_MINUTE_TO_SECOND = (100 + SQL_CODE_MINUTE_TO_SECOND);

  SQL_UNICODE             = SQL_WCHAR;
  SQL_UNICODE_VARCHAR     = SQL_WVARCHAR;
  SQL_UNICODE_LONGVARCHAR = SQL_WLONGVARCHAR;
  SQL_UNICODE_CHAR        = SQL_WCHAR;

  // C datatype to SQL datatype mapping SQL types
  SQL_C_DEFAULT                   = 99;
  SQL_SIGNED_OFFSET               = -20;
  SQL_UNSIGNED_OFFSET             = -22;
  SQL_C_CHAR                      = SQL_CHAR;     // CHAR, VARCHAR, DECIMAL, NUMERIC
  SQL_C_WCHAR                     = SQL_WCHAR;
  SQL_C_LONG                      = SQL_INTEGER;  // INTEGER
  SQL_C_SHORT                     = SQL_SMALLINT; // SMALLINT
  SQL_C_FLOAT                     = SQL_REAL;     // REAL
  SQL_C_DOUBLE                    = SQL_DOUBLE;   // FLOAT, DOUBLE
  SQL_C_NUMERIC                   = SQL_NUMERIC;
  SQL_C_DATE                      = SQL_DATE;
  SQL_C_TIME                      = SQL_TIME;
  SQL_C_TIMESTAMP                 = SQL_TIMESTAMP;
  SQL_C_TYPE_DATE                 = SQL_TYPE_DATE;
  SQL_C_TYPE_TIME                 = SQL_TYPE_TIME;
  SQL_C_TYPE_TIMESTAMP            = SQL_TYPE_TIMESTAMP;
  SQL_C_INTERVAL_YEAR             = SQL_INTERVAL_YEAR;
  SQL_C_INTERVAL_MONTH            = SQL_INTERVAL_MONTH;
  SQL_C_INTERVAL_DAY              = SQL_INTERVAL_DAY;
  SQL_C_INTERVAL_HOUR             = SQL_INTERVAL_HOUR;
  SQL_C_INTERVAL_MINUTE           = SQL_INTERVAL_MINUTE;
  SQL_C_INTERVAL_SECOND           = SQL_INTERVAL_SECOND;
  SQL_C_INTERVAL_YEAR_TO_MONTH    = SQL_INTERVAL_YEAR_TO_MONTH;
  SQL_C_INTERVAL_DAY_TO_HOUR      = SQL_INTERVAL_DAY_TO_HOUR;
  SQL_C_INTERVAL_DAY_TO_MINUTE    = SQL_INTERVAL_DAY_TO_MINUTE;
  SQL_C_INTERVAL_DAY_TO_SECOND    = SQL_INTERVAL_DAY_TO_SECOND;
  SQL_C_INTERVAL_HOUR_TO_MINUTE   = SQL_INTERVAL_HOUR_TO_MINUTE;
  SQL_C_INTERVAL_HOUR_TO_SECOND   = SQL_INTERVAL_HOUR_TO_SECOND;
  SQL_C_INTERVAL_MINUTE_TO_SECOND = SQL_INTERVAL_MINUTE_TO_SECOND;
  SQL_C_BINARY                    = SQL_BINARY;
  SQL_C_BIT                       = SQL_BIT;
  SQL_C_SBIGINT                   = (SQL_BIGINT + SQL_SIGNED_OFFSET);    // SIGNED BIGINT
  SQL_C_UBIGINT                   = (SQL_BIGINT + SQL_UNSIGNED_OFFSET);  // UNSIGNED BIGINT
  SQL_C_TINYINT                   = SQL_TINYINT;
  SQL_C_SLONG                     = (SQL_C_LONG + SQL_SIGNED_OFFSET);    // SIGNED INTEGER
  SQL_C_SSHORT                    = (SQL_C_SHORT + SQL_SIGNED_OFFSET);   // SIGNED SMALLINT
  SQL_C_STINYINT                  = (SQL_TINYINT + SQL_SIGNED_OFFSET);   // SIGNED TINYINT
  SQL_C_ULONG                     = (SQL_C_LONG + SQL_UNSIGNED_OFFSET);  // UNSIGNED INTEGER
  SQL_C_USHORT                    = (SQL_C_SHORT + SQL_UNSIGNED_OFFSET); // UNSIGNED SMALLINT
  SQL_C_UTINYINT                  = (SQL_TINYINT + SQL_UNSIGNED_OFFSET); // UNSIGNED TINYINT
  SQL_C_BOOKMARK                  = SQL_C_ULONG;                         // BOOKMARK
  SQL_C_GUID                      = SQL_GUID;

  SQL_TYPE_NULL     = 0;
  SQL_C_VARBOOKMARK = SQL_C_BINARY;

  // Define for SQL_DIAG_ROW_NUMBER and SQL_DIAG_COLUMN_NUMBER
  SQL_NO_ROW_NUMBER         = -1;
  SQL_NO_COLUMN_NUMBER      = -1;
  SQL_ROW_NUMBER_UNKNOWN    = -2;
  SQL_COLUMN_NUMBER_UNKNOWN = -2;

  // SQLBindParameter extensions
  SQL_DEFAULT_PARAM           = -5;
  SQL_IGNORE                  = -6;
  SQL_COLUMN_IGNORE           = SQL_IGNORE;
  SQL_LEN_DATA_AT_EXEC_OFFSET = -100;

  // Binary Length for driver specific attributes
  SQL_LEN_BINARY_ATTR_OFFSET = -100;

const
  // Defines for SQLBindParameter and
  // SQLProcedureColumns (returned in the Result set)
  SQL_PARAM_TYPE_UNKNOWN = 0;
  SQL_PARAM_INPUT        = 1;
  SQL_PARAM_INPUT_OUTPUT = 2;
  SQL_RESULT_COL         = 3;
  SQL_PARAM_OUTPUT       = 4;
  SQL_RETURN_VALUE       = 5;

  // Defines used by Driver Manager when mapping SQLSetParam to SQLBindParameter
  SQL_PARAM_TYPE_DEFAULT = SQL_PARAM_INPUT_OUTPUT;
  SQL_SETPARAM_VALUE_MAX = -1;

  // SQLGetFunctions: additional values for
  // fFunction to represent functions that
  // are not in the X/Open spec.
  SQL_API_SQLALLOCHANDLESTD   = 73;
  SQL_API_SQLBULKOPERATIONS   = 24;
  SQL_API_SQLBINDPARAMETER    = 72;
  SQL_API_SQLBROWSECONNECT    = 55;
  SQL_API_SQLCOLATTRIBUTES    = 6;
  SQL_API_SQLCOLUMNPRIVILEGES = 56;
  SQL_API_SQLDESCRIBEPARAM    = 58;
  SQL_API_SQLDRIVERCONNECT    = 41;
  SQL_API_SQLDRIVERS          = 71;
  SQL_API_SQLEXTENDEDFETCH    = 59;
  SQL_API_SQLFOREIGNKEYS      = 60;
  SQL_API_SQLMORERESULTS      = 61;
  SQL_API_SQLNATIVESQL        = 62;
  SQL_API_SQLNUMPARAMS        = 63;
  SQL_API_SQLPARAMOPTIONS     = 64;
  SQL_API_SQLPRIMARYKEYS      = 65;
  SQL_API_SQLPROCEDURECOLUMNS = 66;
  SQL_API_SQLPROCEDURES       = 67;
  SQL_API_SQLSETPOS           = 68;
  SQL_API_SQLSETSCROLLOPTIONS = 69;
  SQL_API_SQLTABLEPRIVILEGES  = 70;

  // SQL_API_ALL_FUNCTIONS returns an array
  // of 'booleans' representing whether a
  // function is implemented by the driver.
  //
  // CAUTION: Only functions defined in ODBC
  // version 2.0 and earlier are returned, the
  // new high-range function numbers defined by
  // X/Open break this scheme. See the new
  // method -- SQL_API_ODBC3_ALL_FUNCTIONS
  SQL_API_ALL_FUNCTIONS = 0; // See CAUTION above

  // 2.X drivers export a dummy function with
  // ordinal number SQL_API_LOADBYORDINAL to speed
  // loading under the windows operating system.
  //
  // CAUTION: Loading by ordinal is not supported
  // for 3.0 and above drivers.
  SQL_API_LOADBYORDINAL = 199; // See CAUTION above

  // SQL_API_ODBC3_ALL_FUNCTIONS
  // This returns a bitmap, which allows us to*
  // handle the higher-valued function numbers.
  // Use SQL_FUNC_EXISTS(bitmap,function_number)
  // to determine if the function exists.
  SQL_API_ODBC3_ALL_FUNCTIONS      = 999;
  SQL_API_ODBC3_ALL_FUNCTIONS_SIZE = 250; // Array of 250 words

const
  // Extended definitions for SQLGetInfo
  // Values in ODBC 2.0 that are not
  // in the X/Open spec
  SQL_INFO_FIRST                 = 0;
  SQL_ACTIVE_CONNECTIONS         = 0;  // MAX_DRIVER_CONNECTIONS
  SQL_ACTIVE_STATEMENTS          = 1;  // MAX_CONCURRENT_ACTIVITIES
  SQL_DRIVER_HDBC                = 3;
  SQL_DRIVER_HENV                = 4;
  SQL_DRIVER_HSTMT               = 5;
  SQL_DRIVER_NAME                = 6;
  SQL_DRIVER_VER                 = 7;
  SQL_ODBC_API_CONFORMANCE       = 9;
  SQL_ODBC_VER                   = 10;
  SQL_ROW_UPDATES                = 11;
  SQL_ODBC_SAG_CLI_CONFORMANCE   = 12;
  SQL_ODBC_SQL_CONFORMANCE       = 15;
  SQL_PROCEDURES                 = 21;
  SQL_CONCAT_NULL_BEHAVIOR       = 22;
  SQL_CURSOR_ROLLBACK_BEHAVIOR   = 24;
  SQL_EXPRESSIONS_IN_ORDERBY     = 27;
  SQL_MAX_OWNER_NAME_LEN         = 32; // MAX_SCHEMA_NAME_LEN
  SQL_MAX_PROCEDURE_NAME_LEN     = 33;
  SQL_MAX_QUALIFIER_NAME_LEN     = 34; // MAX_CATALOG_NAME_LEN
  SQL_MULT_RESULT_SETS           = 36;
  SQL_MULTIPLE_ACTIVE_TXN        = 37;
  SQL_OUTER_JOINS                = 38;
  SQL_OWNER_TERM                 = 39;
  SQL_PROCEDURE_TERM             = 40;
  SQL_QUALIFIER_NAME_SEPARATOR   = 41;
  SQL_QUALIFIER_TERM             = 42;
  SQL_SCROLL_OPTIONS             = 44;
  SQL_TABLE_TERM                 = 45;
  SQL_CONVERT_FUNCTIONS          = 48;
  SQL_NUMERIC_FUNCTIONS          = 49;
  SQL_STRING_FUNCTIONS           = 50;
  SQL_SYSTEM_FUNCTIONS           = 51;
  SQL_TIMEDATE_FUNCTIONS         = 52;
  SQL_CONVERT_BIGINT             = 53;
  SQL_CONVERT_BINARY             = 54;
  SQL_CONVERT_BIT                = 55;
  SQL_CONVERT_CHAR               = 56;
  SQL_CONVERT_DATE               = 57;
  SQL_CONVERT_DECIMAL            = 58;
  SQL_CONVERT_DOUBLE             = 59;
  SQL_CONVERT_FLOAT              = 60;
  SQL_CONVERT_INTEGER            = 61;
  SQL_CONVERT_LONGVARCHAR        = 62;
  SQL_CONVERT_NUMERIC            = 63;
  SQL_CONVERT_REAL               = 64;
  SQL_CONVERT_SMALLINT           = 65;
  SQL_CONVERT_TIME               = 66;
  SQL_CONVERT_TIMESTAMP          = 67;
  SQL_CONVERT_TINYINT            = 68;
  SQL_CONVERT_VARBINARY          = 69;
  SQL_CONVERT_VARCHAR            = 70;
  SQL_CONVERT_LONGVARBINARY      = 71;
  SQL_ODBC_SQL_OPT_IEF           = 73; // SQL_INTEGRITY
  SQL_CORRELATION_NAME           = 74;
  SQL_NON_NULLABLE_COLUMNS       = 75;
  SQL_DRIVER_HLIB                = 76;
  SQL_DRIVER_ODBC_VER            = 77;
  SQL_LOCK_TYPES                 = 78;
  SQL_POS_OPERATIONS             = 79;
  SQL_POSITIONED_STATEMENTS      = 80;
  SQL_BOOKMARK_PERSISTENCE       = 82;
  SQL_STATIC_SENSITIVITY         = 83;
  SQL_FILE_USAGE                 = 84;
  SQL_COLUMN_ALIAS               = 87;
  SQL_GROUP_BY                   = 88;
  SQL_KEYWORDS                   = 89;
  SQL_OWNER_USAGE                = 91;
  SQL_QUALIFIER_USAGE            = 92;
  SQL_QUOTED_IDENTIFIER_CASE     = 93;
  SQL_SUBQUERIES                 = 95;
  SQL_UNION                      = 96;
  SQL_MAX_ROW_SIZE_INCLUDES_LONG = 103;
  SQL_MAX_CHAR_LITERAL_LEN       = 108;
  SQL_TIMEDATE_ADD_INTERVALS     = 109;
  SQL_TIMEDATE_DIFF_INTERVALS    = 110;
  SQL_NEED_LONG_DATA_LEN         = 111;
  SQL_MAX_BINARY_LITERAL_LEN     = 112;
  SQL_LIKE_ESCAPE_CLAUSE         = 113;
  SQL_QUALIFIER_LOCATION         = 114;

  // ODBC 3.0 SQLGetInfo values that are not part
  // of the X/Open standard at this time. X/Open
  // standard values are in SQL.h.
  SQL_ACTIVE_ENVIRONMENTS             = 116;
  SQL_ALTER_DOMAIN                    = 117;
  SQL_SQL_CONFORMANCE                 = 118;
  SQL_DATETIME_LITERALS               = 119;
  SQL_ASYNC_MODE                      = 10021; // new X/Open spec
  SQL_BATCH_ROW_COUNT                 = 120;
  SQL_BATCH_SUPPORT                   = 121;
  SQL_CATALOG_LOCATION                = SQL_QUALIFIER_LOCATION;
  SQL_CATALOG_NAME_SEPARATOR          = SQL_QUALIFIER_NAME_SEPARATOR;
  SQL_CATALOG_TERM                    = SQL_QUALIFIER_TERM;
  SQL_CATALOG_USAGE                   = SQL_QUALIFIER_USAGE;
  SQL_CONVERT_WCHAR                   = 122;
  SQL_CONVERT_INTERVAL_DAY_TIME       = 123;
  SQL_CONVERT_INTERVAL_YEAR_MONTH     = 124;
  SQL_CONVERT_WLONGVARCHAR            = 125;
  SQL_CONVERT_WVARCHAR                = 126;
  SQL_CREATE_ASSERTION                = 127;
  SQL_CREATE_CHARACTER_SET            = 128;
  SQL_CREATE_COLLATION                = 129;
  SQL_CREATE_DOMAIN                   = 130;
  SQL_CREATE_SCHEMA                   = 131;
  SQL_CREATE_TABLE                    = 132;
  SQL_CREATE_TRANSLATION              = 133;
  SQL_CREATE_VIEW                     = 134;
  SQL_DRIVER_HDESC                    = 135;
  SQL_DROP_ASSERTION                  = 136;
  SQL_DROP_CHARACTER_SET              = 137;
  SQL_DROP_COLLATION                  = 138;
  SQL_DROP_DOMAIN                     = 139;
  SQL_DROP_SCHEMA                     = 140;
  SQL_DROP_TABLE                      = 141;
  SQL_DROP_TRANSLATION                = 142;
  SQL_DROP_VIEW                       = 143;
  SQL_DYNAMIC_CURSOR_ATTRIBUTES1      = 144;
  SQL_DYNAMIC_CURSOR_ATTRIBUTES2      = 145;
  SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1 = 146;
  SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2 = 147;
  SQL_INDEX_KEYWORDS                  = 148;
  SQL_INFO_SCHEMA_VIEWS               = 149;
  SQL_KEYSET_CURSOR_ATTRIBUTES1       = 150;
  SQL_KEYSET_CURSOR_ATTRIBUTES2       = 151;
  SQL_MAX_ASYNC_CONCURRENT_STATEMENTS = 10022; // new X/Open spec
  SQL_ODBC_INTERFACE_CONFORMANCE      = 152;
  SQL_PARAM_ARRAY_ROW_COUNTS          = 153;
  SQL_PARAM_ARRAY_SELECTS             = 154;
  SQL_SCHEMA_TERM                     = SQL_OWNER_TERM;
  SQL_SCHEMA_USAGE                    = SQL_OWNER_USAGE;
  SQL_SQL92_DATETIME_FUNCTIONS        = 155;
  SQL_SQL92_FOREIGN_KEY_DELETE_RULE   = 156;
  SQL_SQL92_FOREIGN_KEY_UPDATE_RULE   = 157;
  SQL_SQL92_GRANT                     = 158;
  SQL_SQL92_NUMERIC_VALUE_FUNCTIONS   = 159;
  SQL_SQL92_PREDICATES                = 160;
  SQL_SQL92_RELATIONAL_JOIN_OPERATORS = 161;
  SQL_SQL92_REVOKE                    = 162;
  SQL_SQL92_ROW_VALUE_CONSTRUCTOR     = 163;
  SQL_SQL92_STRING_FUNCTIONS          = 164;
  SQL_SQL92_VALUE_EXPRESSIONS         = 165;
  SQL_STANDARD_CLI_CONFORMANCE        = 166;
  SQL_STATIC_CURSOR_ATTRIBUTES1       = 167;
  SQL_STATIC_CURSOR_ATTRIBUTES2       = 168;
  SQL_AGGREGATE_FUNCTIONS             = 169;
  SQL_DDL_INDEX                       = 170;
  SQL_DM_VER                          = 171;
  SQL_INSERT_STATEMENT                = 172;
  SQL_CONVERT_GUID                    = 173;
  SQL_UNION_STATEMENT                 = SQL_UNION;

  SQL_DTC_TRANSITION_COST             = 1750;

  // SQL_CONVERT_* return value bitmasks
  SQL_CVT_CHAR                = $00000001;
  SQL_CVT_NUMERIC             = $00000002;
  SQL_CVT_DECIMAL             = $00000004;
  SQL_CVT_INTEGER             = $00000008;
  SQL_CVT_SMALLINT            = $00000010;
  SQL_CVT_FLOAT               = $00000020;
  SQL_CVT_REAL                = $00000040;
  SQL_CVT_DOUBLE              = $00000080;
  SQL_CVT_VARCHAR             = $00000100;
  SQL_CVT_LONGVARCHAR         = $00000200;
  SQL_CVT_BINARY              = $00000400;
  SQL_CVT_VARBINARY           = $00000800;
  SQL_CVT_BIT                 = $00001000;
  SQL_CVT_TINYINT             = $00002000;
  SQL_CVT_BIGINT              = $00004000;
  SQL_CVT_DATE                = $00008000;
  SQL_CVT_TIME                = $00010000;
  SQL_CVT_TIMESTAMP           = $00020000;
  SQL_CVT_LONGVARBINARY       = $00040000;
  SQL_CVT_INTERVAL_YEAR_MONTH = $00080000;
  SQL_CVT_INTERVAL_DAY_TIME   = $00100000;
  SQL_CVT_WCHAR               = $00200000;
  SQL_CVT_WLONGVARCHAR        = $00400000;
  SQL_CVT_WVARCHAR            = $00800000;
  SQL_CVT_GUID                = $01000000;

  // SQL_CONVERT_FUNCTIONS functions
  SQL_FN_CVT_CONVERT = $00000001;
  SQL_FN_CVT_CAST    = $00000002;

  // SQL_STRING_FUNCTIONS functions
  SQL_FN_STR_CONCAT           = $00000001;
  SQL_FN_STR_INSERT           = $00000002;
  SQL_FN_STR_LEFT             = $00000004;
  SQL_FN_STR_LTRIM            = $00000008;
  SQL_FN_STR_LENGTH           = $00000010;
  SQL_FN_STR_LOCATE           = $00000020;
  SQL_FN_STR_LCASE            = $00000040;
  SQL_FN_STR_REPEAT           = $00000080;
  SQL_FN_STR_REPLACE          = $00000100;
  SQL_FN_STR_RIGHT            = $00000200;
  SQL_FN_STR_RTRIM            = $00000400;
  SQL_FN_STR_SUBSTRING        = $00000800;
  SQL_FN_STR_UCASE            = $00001000;
  SQL_FN_STR_ASCII            = $00002000;
  SQL_FN_STR_CHAR             = $00004000;
  SQL_FN_STR_DIFFERENCE       = $00008000;
  SQL_FN_STR_LOCATE_2         = $00010000;
  SQL_FN_STR_SOUNDEX          = $00020000;
  SQL_FN_STR_SPACE            = $00040000;
  SQL_FN_STR_BIT_LENGTH       = $00080000;
  SQL_FN_STR_CHAR_LENGTH      = $00100000;
  SQL_FN_STR_CHARACTER_LENGTH = $00200000;
  SQL_FN_STR_OCTET_LENGTH     = $00400000;
  SQL_FN_STR_POSITION         = $00800000;

  // SQL_SQL92_STRING_FUNCTIONS
  SQL_SSF_CONVERT       = $00000001;
  SQL_SSF_LOWER         = $00000002;
  SQL_SSF_UPPER         = $00000004;
  SQL_SSF_SUBSTRING     = $00000008;
  SQL_SSF_TRANSLATE     = $00000010;
  SQL_SSF_TRIM_BOTH     = $00000020;
  SQL_SSF_TRIM_LEADING  = $00000040;
  SQL_SSF_TRIM_TRAILING = $00000080;

  // SQL_NUMERIC_FUNCTIONS functions
  SQL_FN_NUM_ABS     = $00000001;
  SQL_FN_NUM_ACOS     = $00000002;
  SQL_FN_NUM_ASIN     = $00000004;
  SQL_FN_NUM_ATAN     = $00000008;
  SQL_FN_NUM_ATAN2    = $00000010;
  SQL_FN_NUM_CEILING  = $00000020;
  SQL_FN_NUM_COS      = $00000040;
  SQL_FN_NUM_COT      = $00000080;
  SQL_FN_NUM_EXP      = $00000100;
  SQL_FN_NUM_FLOOR    = $00000200;
  SQL_FN_NUM_LOG      = $00000400;
  SQL_FN_NUM_MOD      = $00000800;
  SQL_FN_NUM_SIGN     = $00001000;
  SQL_FN_NUM_SIN      = $00002000;
  SQL_FN_NUM_SQRT     = $00004000;
  SQL_FN_NUM_TAN      = $00008000;
  SQL_FN_NUM_PI       = $00010000;
  SQL_FN_NUM_RAND     = $00020000;
  SQL_FN_NUM_DEGREES  = $00040000;
  SQL_FN_NUM_LOG10    = $00080000;
  SQL_FN_NUM_POWER    = $00100000;
  SQL_FN_NUM_RADIANS  = $00200000;
  SQL_FN_NUM_ROUND    = $00400000;
  SQL_FN_NUM_TRUNCATE = $00800000;

  // SQL_SQL92_NUMERIC_VALUE_FUNCTIONS
  SQL_SNVF_BIT_LENGTH       = $00000001;
  SQL_SNVF_CHAR_LENGTH      = $00000002;
  SQL_SNVF_CHARACTER_LENGTH = $00000004;
  SQL_SNVF_EXTRACT          = $00000008;
  SQL_SNVF_OCTET_LENGTH     = $00000010;
  SQL_SNVF_POSITION         = $00000020;

  // SQL_TIMEDATE_FUNCTIONS functions
  SQL_FN_TD_NOW               = $00000001;
  SQL_FN_TD_CURDATE           = $00000002;
  SQL_FN_TD_DAYOFMONTH        = $00000004;
  SQL_FN_TD_DAYOFWEEK         = $00000008;
  SQL_FN_TD_DAYOFYEAR         = $00000010;
  SQL_FN_TD_MONTH             = $00000020;
  SQL_FN_TD_QUARTER           = $00000040;
  SQL_FN_TD_WEEK              = $00000080;
  SQL_FN_TD_YEAR              = $00000100;
  SQL_FN_TD_CURTIME           = $00000200;
  SQL_FN_TD_HOUR              = $00000400;
  SQL_FN_TD_MINUTE            = $00000800;
  SQL_FN_TD_SECOND            = $00001000;
  SQL_FN_TD_TIMESTAMPADD      = $00002000;
  SQL_FN_TD_TIMESTAMPDIFF     = $00004000;
  SQL_FN_TD_DAYNAME           = $00008000;
  SQL_FN_TD_MONTHNAME         = $00010000;
  SQL_FN_TD_CURRENT_DATE      = $00020000;
  SQL_FN_TD_CURRENT_TIME      = $00040000;
  SQL_FN_TD_CURRENT_TIMESTAMP = $00080000;
  SQL_FN_TD_EXTRACT           = $00100000;

  // SQL_SQL92_DATETIME_FUNCTIONS
  SQL_SDF_CURRENT_DATE      = $00000001;
  SQL_SDF_CURRENT_TIME      = $00000002;
  SQL_SDF_CURRENT_TIMESTAMP = $00000004;

  // SQL_SYSTEM_FUNCTIONS functions
  SQL_FN_SYS_USERNAME = $00000001;
  SQL_FN_SYS_DBNAME   = $00000002;
  SQL_FN_SYS_IFNULL   = $00000004;

  // SQL_TIMEDATE_ADD_INTERVALS and SQL_TIMEDATE_DIFF_INTERVALS functions
  SQL_FN_TSI_FRAC_SECOND = $00000001;
  SQL_FN_TSI_SECOND      = $00000002;
  SQL_FN_TSI_MINUTE      = $00000004;
  SQL_FN_TSI_HOUR        = $00000008;
  SQL_FN_TSI_DAY         = $00000010;
  SQL_FN_TSI_WEEK        = $00000020;
  SQL_FN_TSI_MONTH       = $00000040;
  SQL_FN_TSI_QUARTER     = $00000080;
  SQL_FN_TSI_YEAR        = $00000100;

  // Supported SQLFetchScroll FetchOrientation's
  SQL_CA1_NEXT     = $00000001;
  SQL_CA1_ABSOLUTE = $00000002;
  SQL_CA1_RELATIVE = $00000004;
  SQL_CA1_BOOKMARK = $00000008;

  // Supported SQLSetPos LockType's
  SQL_CA1_LOCK_NO_CHANGE = $00000040;
  SQL_CA1_LOCK_EXCLUSIVE = $00000080;
  SQL_CA1_LOCK_UNLOCK    = $00000100;

  // Supported SQLSetPos Operations
  SQL_CA1_POS_POSITION = $00000200;
  SQL_CA1_POS_UPDATE   = $00000400;
  SQL_CA1_POS_DELETE   = $00000800;
  SQL_CA1_POS_REFRESH  = $00001000;

  // Positioned updates and deletes
  SQL_CA1_POSITIONED_UPDATE = $00002000;
  SQL_CA1_POSITIONED_DELETE = $00004000;
  SQL_CA1_SELECT_FOR_UPDATE = $00008000;

  // Supported SQLBulkOperations operations
  SQL_CA1_BULK_ADD                = $00010000;
  SQL_CA1_BULK_UPDATE_BY_BOOKMARK = $00020000;
  SQL_CA1_BULK_DELETE_BY_BOOKMARK = $00040000;
  SQL_CA1_BULK_FETCH_BY_BOOKMARK  = $00080000;

  // Supported values for SQL_ATTR_SCROLL_CONCURRENCY
  SQL_CA2_READ_ONLY_CONCURRENCY  = $00000001;
  SQL_CA2_LOCK_CONCURRENCY       = $00000002;
  SQL_CA2_OPT_ROWVER_CONCURRENCY = $00000004;
  SQL_CA2_OPT_VALUES_CONCURRENCY = $00000008;

  // Sensitivity of the cursor to its own inserts, deletes, and updates
  SQL_CA2_SENSITIVITY_ADDITIONS = $00000010;
  SQL_CA2_SENSITIVITY_DELETIONS = $00000020;
  SQL_CA2_SENSITIVITY_UPDATES   = $00000040;

  // Semantics of SQL_ATTR_MAX_ROWS
  SQL_CA2_MAX_ROWS_SELECT      = $00000080;
  SQL_CA2_MAX_ROWS_INSERT      = $00000100;
  SQL_CA2_MAX_ROWS_DELETE      = $00000200;
  SQL_CA2_MAX_ROWS_UPDATE      = $00000400;
  SQL_CA2_MAX_ROWS_CATALOG     = $00000800;
  SQL_CA2_MAX_ROWS_AFFECTS_ALL = (SQL_CA2_MAX_ROWS_SELECT or
                                  SQL_CA2_MAX_ROWS_INSERT or
                                  SQL_CA2_MAX_ROWS_DELETE or
                                  SQL_CA2_MAX_ROWS_UPDATE or
                                  SQL_CA2_MAX_ROWS_CATALOG);

  // Semantics of SQL_DIAG_CURSOR_ROW_COUNT
  SQL_CA2_CRC_EXACT       = $00001000;
  SQL_CA2_CRC_APPROXIMATE = $00002000;

  // The kinds of positioned statements that can be simulated
  SQL_CA2_SIMULATE_NON_UNIQUE = $00004000;
  SQL_CA2_SIMULATE_TRY_UNIQUE = $00008000;
  SQL_CA2_SIMULATE_UNIQUE     = $00010000;

  // SQL_ODBC_API_CONFORMANCE values
  SQL_OAC_NONE   = $0000;
  SQL_OAC_LEVEL1 = $0001;
  SQL_OAC_LEVEL2 = $0002;

  // SQL_ODBC_SAG_CLI_CONFORMANCE values
  SQL_OSCC_NOT_COMPLIANT = $0000;
  SQL_OSCC_COMPLIANT     = $0001;

  // SQL_ODBC_SQL_CONFORMANCE values
  SQL_OSC_MINIMUM  = $0000;
  SQL_OSC_CORE     = $0001;
  SQL_OSC_EXTENDED = $0002;

  // SQL_CONCAT_NULL_BEHAVIOR values
  SQL_CB_NULL     = $0000;
  SQL_CB_NON_NULL = $0001;

  // SQL_SCROLL_OPTIONS masks
  SQL_SO_FORWARD_ONLY  = $00000001;
  SQL_SO_KEYSET_DRIVEN = $00000002;
  SQL_SO_DYNAMIC       = $00000004;
  SQL_SO_MIXED         = $00000008;
  SQL_SO_STATIC        = $00000010;

  // SQL_FETCH_DIRECTION masks
  SQL_FD_FETCH_RESUME   = $00000040; // SQL_FETCH_RESUME is no longer supported
  SQL_FD_FETCH_BOOKMARK = $00000080;

  // SQL_TXN_ISOLATION_OPTION masks
  SQL_TXN_VERSIONING = $00000010;    // SQL_TXN_VERSIONING is no longer supported

  // SQL_CORRELATION_NAME values
  SQL_CN_NONE      = $0000;
  SQL_CN_DIFFERENT = $0001;
  SQL_CN_ANY       = $0002;

  // SQL_NON_NULLABLE_COLUMNS values
  SQL_NNC_NULL     = $0000;
  SQL_NNC_NON_NULL = $0001;

  // SQL_NULL_COLLATION values
  SQL_NC_START = $0002;
  SQL_NC_END   = $0004;

  // SQL_FILE_USAGE values
  SQL_FILE_NOT_SUPPORTED = $0000;
  SQL_FILE_TABLE         = $0001;
  SQL_FILE_QUALIFIER     = $0002;
  SQL_FILE_CATALOG       = SQL_FILE_QUALIFIER; // ODBC 3.0

  // SQL_GETDATA_EXTENSIONS values
  SQL_GD_BLOCK = $00000004;
  SQL_GD_BOUND = $00000008;

  // SQL_POSITIONED_STATEMENTS masks
  SQL_PS_POSITIONED_DELETE = $00000001;
  SQL_PS_POSITIONED_UPDATE = $00000002;
  SQL_PS_SELECT_FOR_UPDATE = $00000004;

  // SQL_GROUP_BY values
  SQL_GB_NOT_SUPPORTED            = $0000;
  SQL_GB_GROUP_BY_EQUALS_SELECT   = $0001;
  SQL_GB_GROUP_BY_CONTAINS_SELECT = $0002;
  SQL_GB_NO_RELATION              = $0003;
  SQL_GB_COLLATE                  = $0004;

  // SQL_OWNER_USAGE masks
  SQL_OU_DML_STATEMENTS       = $00000001;
  SQL_OU_PROCEDURE_INVOCATION = $00000002;
  SQL_OU_TABLE_DEFINITION     = $00000004;
  SQL_OU_INDEX_DEFINITION     = $00000008;
  SQL_OU_PRIVILEGE_DEFINITION = $00000010;

  // SQL_SCHEMA_USAGE masks
  SQL_SU_DML_STATEMENTS       = SQL_OU_DML_STATEMENTS;
  SQL_SU_PROCEDURE_INVOCATION = SQL_OU_PROCEDURE_INVOCATION;
  SQL_SU_TABLE_DEFINITION     = SQL_OU_TABLE_DEFINITION;
  SQL_SU_INDEX_DEFINITION     = SQL_OU_INDEX_DEFINITION;
  SQL_SU_PRIVILEGE_DEFINITION = SQL_OU_PRIVILEGE_DEFINITION;

  // SQL_QUALIFIER_USAGE masks
  SQL_QU_DML_STATEMENTS       = $00000001;
  SQL_QU_PROCEDURE_INVOCATION = $00000002;
  SQL_QU_TABLE_DEFINITION     = $00000004;
  SQL_QU_INDEX_DEFINITION     = $00000008;
  SQL_QU_PRIVILEGE_DEFINITION = $00000010;

  // SQL_CATALOG_USAGE masks
  SQL_CU_DML_STATEMENTS       = SQL_QU_DML_STATEMENTS;
  SQL_CU_PROCEDURE_INVOCATION = SQL_QU_PROCEDURE_INVOCATION;
  SQL_CU_TABLE_DEFINITION     = SQL_QU_TABLE_DEFINITION;
  SQL_CU_INDEX_DEFINITION     = SQL_QU_INDEX_DEFINITION;
  SQL_CU_PRIVILEGE_DEFINITION = SQL_QU_PRIVILEGE_DEFINITION;

  // SQL_SUBQUERIES masks
  SQL_SQ_COMPARISON            = $00000001;
  SQL_SQ_EXISTS                = $00000002;
  SQL_SQ_IN                    = $00000004;
  SQL_SQ_QUANTIFIED            = $00000008;
  SQL_SQ_CORRELATED_SUBQUERIES = $00000010;

  // SQL_UNION masks
  SQL_U_UNION     = $00000001;
  SQL_U_UNION_ALL = $00000002;

  // SQL_BOOKMARK_PERSISTENCE values
  SQL_BP_CLOSE       = $00000001;
  SQL_BP_DELETE      = $00000002;
  SQL_BP_DROP        = $00000004;
  SQL_BP_TRANSACTION = $00000008;
  SQL_BP_UPDATE      = $00000010;
  SQL_BP_OTHER_HSTMT = $00000020;
  SQL_BP_SCROLL      = $00000040;

  // SQL_STATIC_SENSITIVITY values
  SQL_SS_ADDITIONS = $00000001;
  SQL_SS_DELETIONS = $00000002;
  SQL_SS_UPDATES   = $00000004;

  // SQL_VIEW values
  SQL_CV_CREATE_VIEW  = $00000001;
  SQL_CV_CHECK_OPTION = $00000002;
  SQL_CV_CASCADED     = $00000004;
  SQL_CV_LOCAL        = $00000008;

  // SQL_LOCK_TYPES masks
  SQL_LCK_NO_CHANGE = $00000001;
  SQL_LCK_EXCLUSIVE = $00000002;
  SQL_LCK_UNLOCK    = $00000004;

  // SQL_POS_OPERATIONS masks
  SQL_POS_POSITION = $00000001;
  SQL_POS_REFRESH  = $00000002;
  SQL_POS_UPDATE   = $00000004;
  SQL_POS_DELETE   = $00000008;
  SQL_POS_ADD      = $00000010;

  // SQL_QUALIFIER_LOCATION values
  SQL_QL_START = $0001;
  SQL_QL_END   = $0002;

  // Here start return values for ODBC 3.0 SQLGetInfo
  // SQL_AGGREGATE_FUNCTIONS bitmasks
  SQL_AF_AVG      = $00000001;
  SQL_AF_COUNT    = $00000002;
  SQL_AF_MAX      = $00000004;
  SQL_AF_MIN      = $00000008;
  SQL_AF_SUM      = $00000010;
  SQL_AF_DISTINCT = $00000020;
  SQL_AF_ALL      = $00000040;

  // SQL_SQL_CONFORMANCE bit masks
  SQL_SC_SQL92_ENTRY            = $00000001;
  SQL_SC_FIPS127_2_TRANSITIONAL = $00000002;
  SQL_SC_SQL92_INTERMEDIATE     = $00000004;
  SQL_SC_SQL92_FULL             = $00000008;

  // SQL_DATETIME_LITERALS masks
  SQL_DL_SQL92_DATE                      = $00000001;
  SQL_DL_SQL92_TIME                      = $00000002;
  SQL_DL_SQL92_TIMESTAMP                 = $00000004;
  SQL_DL_SQL92_INTERVAL_YEAR             = $00000008;
  SQL_DL_SQL92_INTERVAL_MONTH            = $00000010;
  SQL_DL_SQL92_INTERVAL_DAY              = $00000020;
  SQL_DL_SQL92_INTERVAL_HOUR             = $00000040;
  SQL_DL_SQL92_INTERVAL_MINUTE           = $00000080;
  SQL_DL_SQL92_INTERVAL_SECOND           = $00000100;
  SQL_DL_SQL92_INTERVAL_YEAR_TO_MONTH    = $00000200;
  SQL_DL_SQL92_INTERVAL_DAY_TO_HOUR      = $00000400;
  SQL_DL_SQL92_INTERVAL_DAY_TO_MINUTE    = $00000800;
  SQL_DL_SQL92_INTERVAL_DAY_TO_SECOND    = $00001000;
  SQL_DL_SQL92_INTERVAL_HOUR_TO_MINUTE   = $00002000;
  SQL_DL_SQL92_INTERVAL_HOUR_TO_SECOND   = $00004000;
  SQL_DL_SQL92_INTERVAL_MINUTE_TO_SECOND = $00008000;

  // SQL_CATALOG_LOCATION values
  SQL_CL_START = SQL_QL_START;
  SQL_CL_END   = SQL_QL_END;

  // Values for SQL_BATCH_ROW_COUNT
  SQL_BRC_PROCEDURES = $0000001;
  SQL_BRC_EXPLICIT   = $0000002;
  SQL_BRC_ROLLED_UP  = $0000004;

  // Bitmasks for SQL_BATCH_SUPPORT
  SQL_BS_SELECT_EXPLICIT    = $00000001;
  SQL_BS_ROW_COUNT_EXPLICIT = $00000002;
  SQL_BS_SELECT_PROC        = $00000004;
  SQL_BS_ROW_COUNT_PROC     = $00000008;

  // Values for SQL_PARAM_ARRAY_ROW_COUNTS getinfo
  SQL_PARC_BATCH    = 1;
  SQL_PARC_NO_BATCH = 2;

  // Values for SQL_PARAM_ARRAY_SELECTS
  SQL_PAS_BATCH     = 1;
  SQL_PAS_NO_BATCH  = 2;
  SQL_PAS_NO_SELECT = 3;

  // Bitmasks for SQL_INDEX_KEYWORDS
  SQL_IK_NONE = $00000000;
  SQL_IK_ASC  = $00000001;
  SQL_IK_DESC = $00000002;
  SQL_IK_ALL  = (SQL_IK_ASC or SQL_IK_DESC);

  // Bitmasks for SQL_INFO_SCHEMA_VIEWS
  SQL_ISV_ASSERTIONS              = $00000001;
  SQL_ISV_CHARACTER_SETS          = $00000002;
  SQL_ISV_CHECK_CONSTRAINTS       = $00000004;
  SQL_ISV_COLLATIONS              = $00000008;
  SQL_ISV_COLUMN_DOMAIN_USAGE     = $00000010;
  SQL_ISV_COLUMN_PRIVILEGES       = $00000020;
  SQL_ISV_COLUMNS                 = $00000040;
  SQL_ISV_CONSTRAINT_COLUMN_USAGE = $00000080;
  SQL_ISV_CONSTRAINT_TABLE_USAGE  = $00000100;
  SQL_ISV_DOMAIN_CONSTRAINTS      = $00000200;
  SQL_ISV_DOMAINS                 = $00000400;
  SQL_ISV_KEY_COLUMN_USAGE        = $00000800;
  SQL_ISV_REFERENTIAL_CONSTRAINTS = $00001000;
  SQL_ISV_SCHEMATA                = $00002000;
  SQL_ISV_SQL_LANGUAGES           = $00004000;
  SQL_ISV_TABLE_CONSTRAINTS       = $00008000;
  SQL_ISV_TABLE_PRIVILEGES        = $00010000;
  SQL_ISV_TABLES                  = $00020000;
  SQL_ISV_TRANSLATIONS            = $00040000;
  SQL_ISV_USAGE_PRIVILEGES        = $00080000;
  SQL_ISV_VIEW_COLUMN_USAGE       = $00100000;
  SQL_ISV_VIEW_TABLE_USAGE        = $00200000;
  SQL_ISV_VIEWS                   = $00400000;

  // Bitmasks for SQL_ALTER_DOMAIN
  SQL_AD_CONSTRAINT_NAME_DEFINITION         = $00000001;
  SQL_AD_ADD_DOMAIN_CONSTRAINT              = $00000002;
  SQL_AD_DROP_DOMAIN_CONSTRAINT             = $00000004;
  SQL_AD_ADD_DOMAIN_DEFAULT                 = $00000008;
  SQL_AD_DROP_DOMAIN_DEFAULT                = $00000010;
  SQL_AD_ADD_CONSTRAINT_INITIALLY_DEFERRED  = $00000020;
  SQL_AD_ADD_CONSTRAINT_INITIALLY_IMMEDIATE = $00000040;
  SQL_AD_ADD_CONSTRAINT_DEFERRABLE          = $00000080;
  SQL_AD_ADD_CONSTRAINT_NON_DEFERRABLE      = $00000100;

  // SQL_CREATE_SCHEMA bitmasks
  SQL_CS_CREATE_SCHEMA         = $00000001;
  SQL_CS_AUTHORIZATION         = $00000002;
  SQL_CS_DEFAULT_CHARACTER_SET = $00000004;

  // SQL_CREATE_TRANSLATION bitmasks
  SQL_CTR_CREATE_TRANSLATION = $00000001;

  // SQL_CREATE_ASSERTION bitmasks
  SQL_CA_CREATE_ASSERTION               = $00000001;
  SQL_CA_CONSTRAINT_INITIALLY_DEFERRED  = $00000010;
  SQL_CA_CONSTRAINT_INITIALLY_IMMEDIATE = $00000020;
  SQL_CA_CONSTRAINT_DEFERRABLE          = $00000040;
  SQL_CA_CONSTRAINT_NON_DEFERRABLE      = $00000080;

  // SQL_CREATE_CHARACTER_SET bitmasks
  SQL_CCS_CREATE_CHARACTER_SET = $00000001;
  SQL_CCS_COLLATE_CLAUSE       = $00000002;
  SQL_CCS_LIMITED_COLLATION    = $00000004;

  // SQL_CREATE_COLLATION bitmasks
  SQL_CCOL_CREATE_COLLATION = $00000001;

  // SQL_CREATE_DOMAIN bitmasks
  SQL_CDO_CREATE_DOMAIN                  = $00000001;
  SQL_CDO_DEFAULT                        = $00000002;
  SQL_CDO_CONSTRAINT                     = $00000004;
  SQL_CDO_COLLATION                      = $00000008;
  SQL_CDO_CONSTRAINT_NAME_DEFINITION     = $00000010;
  SQL_CDO_CONSTRAINT_INITIALLY_DEFERRED  = $00000020;
  SQL_CDO_CONSTRAINT_INITIALLY_IMMEDIATE = $00000040;
  SQL_CDO_CONSTRAINT_DEFERRABLE          = $00000080;
  SQL_CDO_CONSTRAINT_NON_DEFERRABLE      = $00000100;

  // SQL_CREATE_TABLE bitmasks
  SQL_CT_CREATE_TABLE                   = $00000001;
  SQL_CT_COMMIT_PRESERVE                = $00000002;
  SQL_CT_COMMIT_DELETE                  = $00000004;
  SQL_CT_GLOBAL_TEMPORARY               = $00000008;
  SQL_CT_LOCAL_TEMPORARY                = $00000010;
  SQL_CT_CONSTRAINT_INITIALLY_DEFERRED  = $00000020;
  SQL_CT_CONSTRAINT_INITIALLY_IMMEDIATE = $00000040;
  SQL_CT_CONSTRAINT_DEFERRABLE          = $00000080;
  SQL_CT_CONSTRAINT_NON_DEFERRABLE      = $00000100;
  SQL_CT_COLUMN_CONSTRAINT              = $00000200;
  SQL_CT_COLUMN_DEFAULT                 = $00000400;
  SQL_CT_COLUMN_COLLATION               = $00000800;
  SQL_CT_TABLE_CONSTRAINT               = $00001000;
  SQL_CT_CONSTRAINT_NAME_DEFINITION     = $00002000;

  // SQL_DDL_INDEX bitmasks
  SQL_DI_CREATE_INDEX = $00000001;
  SQL_DI_DROP_INDEX   = $00000002;

  // SQL_DROP_COLLATION bitmasks
  SQL_DC_DROP_COLLATION = $00000001;

  // SQL_DROP_DOMAIN bitmasks
  SQL_DD_DROP_DOMAIN = $00000001;
  SQL_DD_RESTRICT    = $00000002;
  SQL_DD_CASCADE     = $00000004;

  // SQL_DROP_SCHEMA bitmasks
  SQL_DS_DROP_SCHEMA = $00000001;
  SQL_DS_RESTRICT    = $00000002;
  SQL_DS_CASCADE     = $00000004;

  // SQL_DROP_CHARACTER_SET bitmasks
  SQL_DCS_DROP_CHARACTER_SET = $00000001;

  // SQL_DROP_ASSERTION bitmasks
  SQL_DA_DROP_ASSERTION = $00000001;

  // SQL_DROP_TABLE bitmasks
  SQL_DT_DROP_TABLE = $00000001;
  SQL_DT_RESTRICT   = $00000002;
  SQL_DT_CASCADE    = $00000004;

  // SQL_DROP_TRANSLATION bitmasks
  SQL_DTR_DROP_TRANSLATION = $00000001;

  // SQL_DROP_VIEW bitmasks
  SQL_DV_DROP_VIEW = $00000001;
  SQL_DV_RESTRICT  = $00000002;
  SQL_DV_CASCADE   = $00000004;

  // SQL_INSERT_STATEMENT bitmasks
  SQL_IS_INSERT_LITERALS = $00000001;
  SQL_IS_INSERT_SEARCHED = $00000002;
  SQL_IS_SELECT_INTO     = $00000004;

  // SQL_ODBC_INTERFACE_CONFORMANCE values
  SQL_OIC_CORE   = ULong(1);
  SQL_OIC_LEVEL1 = ULong(2);
  SQL_OIC_LEVEL2 = ULong(3);

  // SQL_SQL92_FOREIGN_KEY_DELETE_RULE bitmasks
  SQL_SFKD_CASCADE     = $00000001;
  SQL_SFKD_NO_ACTION   = $00000002;
  SQL_SFKD_SET_DEFAULT = $00000004;
  SQL_SFKD_SET_NULL    = $00000008;

  // SQL_SQL92_FOREIGN_KEY_UPDATE_RULE bitmasks
  SQL_SFKU_CASCADE     = $00000001;
  SQL_SFKU_NO_ACTION   = $00000002;
  SQL_SFKU_SET_DEFAULT = $00000004;
  SQL_SFKU_SET_NULL    = $00000008;

  // SQL_SQL92_GRANT bitmasks
  SQL_SG_USAGE_ON_DOMAIN        = $00000001;
  SQL_SG_USAGE_ON_CHARACTER_SET = $00000002;
  SQL_SG_USAGE_ON_COLLATION     = $00000004;
  SQL_SG_USAGE_ON_TRANSLATION   = $00000008;
  SQL_SG_WITH_GRANT_OPTION      = $00000010;
  SQL_SG_DELETE_TABLE           = $00000020;
  SQL_SG_INSERT_TABLE           = $00000040;
  SQL_SG_INSERT_COLUMN          = $00000080;
  SQL_SG_REFERENCES_TABLE       = $00000100;
  SQL_SG_REFERENCES_COLUMN      = $00000200;
  SQL_SG_SELECT_TABLE           = $00000400;
  SQL_SG_UPDATE_TABLE           = $00000800;
  SQL_SG_UPDATE_COLUMN          = $00001000;

  // SQL_SQL92_PREDICATES bitmasks
  SQL_SP_EXISTS                = $00000001;
  SQL_SP_ISNOTNULL             = $00000002;
  SQL_SP_ISNULL                = $00000004;
  SQL_SP_MATCH_FULL            = $00000008;
  SQL_SP_MATCH_PARTIAL         = $00000010;
  SQL_SP_MATCH_UNIQUE_FULL     = $00000020;
  SQL_SP_MATCH_UNIQUE_PARTIAL  = $00000040;
  SQL_SP_OVERLAPS              = $00000080;
  SQL_SP_UNIQUE                = $00000100;
  SQL_SP_LIKE                  = $00000200;
  SQL_SP_IN                    = $00000400;
  SQL_SP_BETWEEN               = $00000800;
  SQL_SP_COMPARISON            = $00001000;
  SQL_SP_QUANTIFIED_COMPARISON = $00002000;

  // SQL_SQL92_RELATIONAL_JOIN_OPERATORS bitmasks
  SQL_SRJO_CORRESPONDING_CLAUSE = $00000001;
  SQL_SRJO_CROSS_JOIN           = $00000002;
  SQL_SRJO_EXCEPT_JOIN          = $00000004;
  SQL_SRJO_FULL_OUTER_JOIN      = $00000008;
  SQL_SRJO_INNER_JOIN           = $00000010;
  SQL_SRJO_INTERSECT_JOIN       = $00000020;
  SQL_SRJO_LEFT_OUTER_JOIN      = $00000040;
  SQL_SRJO_NATURAL_JOIN         = $00000080;
  SQL_SRJO_RIGHT_OUTER_JOIN     = $00000100;
  SQL_SRJO_UNION_JOIN           = $00000200;

  // SQL_SQL92_REVOKE bitmasks
  SQL_SR_USAGE_ON_DOMAIN        = $00000001;
  SQL_SR_USAGE_ON_CHARACTER_SET = $00000002;
  SQL_SR_USAGE_ON_COLLATION     = $00000004;
  SQL_SR_USAGE_ON_TRANSLATION   = $00000008;
  SQL_SR_GRANT_OPTION_FOR       = $00000010;
  SQL_SR_CASCADE                = $00000020;
  SQL_SR_RESTRICT               = $00000040;
  SQL_SR_DELETE_TABLE           = $00000080;
  SQL_SR_INSERT_TABLE           = $00000100;
  SQL_SR_INSERT_COLUMN          = $00000200;
  SQL_SR_REFERENCES_TABLE       = $00000400;
  SQL_SR_REFERENCES_COLUMN      = $00000800;
  SQL_SR_SELECT_TABLE           = $00001000;
  SQL_SR_UPDATE_TABLE           = $00002000;
  SQL_SR_UPDATE_COLUMN          = $00004000;

  // SQL_SQL92_ROW_VALUE_CONSTRUCTOR bitmasks
  SQL_SRVC_VALUE_EXPRESSION = $00000001;
  SQL_SRVC_NULL             = $00000002;
  SQL_SRVC_DEFAULT          = $00000004;
  SQL_SRVC_ROW_SUBQUERY     = $00000008;

  // SQL_SQL92_VALUE_EXPRESSIONS bitmasks
  SQL_SVE_CASE     = $00000001;
  SQL_SVE_CAST     = $00000002;
  SQL_SVE_COALESCE = $00000004;
  SQL_SVE_NULLIF   = $00000008;

  // SQL_STANDARD_CLI_CONFORMANCE bitmasks
  SQL_SCC_XOPEN_CLI_VERSION1 = $00000001;
  SQL_SCC_ISO92_CLI          = $00000002;

  // SQL_UNION_STATEMENT bitmasks
  SQL_US_UNION     = SQL_U_UNION;
  SQL_US_UNION_ALL = SQL_U_UNION_ALL;

  // SQL_DTC_TRANSITION_COST bitmasks
  SQL_DTC_ENLIST_EXPENSIVE   = $00000001;
  SQL_DTC_UNENLIST_EXPENSIVE = $00000002;

  // additional SQLDataSources fetch directions
  SQL_FETCH_FIRST_USER   = 31;
  SQL_FETCH_FIRST_SYSTEM = 32;

  // Defines for SQLSetPos
  SQL_ENTIRE_ROWSET = 0;

  // Operations in SQLSetPos
  SQL_POSITION = 0; // 1.0 FALSE
  SQL_REFRESH  = 1; // 1.0 TRUE
  SQL_UPDATE   = 2;
  SQL_DELETE   = 3;

  // Operations in SQLBulkOperations
  SQL_ADD                     = 4;
  SQL_SETPOS_MAX_OPTION_VALUE = SQL_ADD;
  SQL_UPDATE_BY_BOOKMARK      = 5;
  SQL_DELETE_BY_BOOKMARK      = 6;
  SQL_FETCH_BY_BOOKMARK       = 7;

  // Lock options in SQLSetPos
  SQL_LOCK_NO_CHANGE = 0; // 1.0 FALSE
  SQL_LOCK_EXCLUSIVE = 1; // 1.0 TRUE
  SQL_LOCK_UNLOCK    = 2;

  SQL_SETPOS_MAX_LOCK_VALUE = SQL_LOCK_UNLOCK;

const
  // Column types and scopes in SQLSpecialColumns.
  SQL_BEST_ROWID = 1;
  SQL_ROWVER     = 2;

  // Defines for SQLSpecialColumns (returned in the Result set
  SQL_PC_NOT_PSEUDO = 1;

  // Defines for SQLStatistics
  SQL_QUICK  = 0;
  SQL_ENSURE = 1;

  // Defines for SQLStatistics (returned in the Result set)
  SQL_TABLE_STAT = 0;

  // Defines for SQLTables
  SQL_ALL_CATALOGS    = '%';
  SQL_ALL_SCHEMAS     = '%';
  SQL_ALL_TABLE_TYPES = '%';

  // Options for SQLDriverConnect
  SQL_DRIVER_NOPROMPT          = 0;
  SQL_DRIVER_COMPLETE          = 1;
  SQL_DRIVER_PROMPT            = 2;
  SQL_DRIVER_COMPLETE_REQUIRED = 3;

type
  TSQLDriverConnect = function(
    HDbc:              SQLHDbc;
    hwnd:              SQLHWnd;
    szConnStrIn:       PSQLChar;
    cbConnStrIn:       SQLSmallint;
    szConnStrOut:      PSQLChar;
    cbConnStrOutMax:   SQLSmallint;
    var pcbConnStrOut: SQLSmallint;
    fDriverCompletion: SQLUSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

const
  // SQLExtendedFetch
  SQL_FETCH_BOOKMARK = 8;

  // SQLExtendedFetch row status element values
  SQL_ROW_SUCCESS           = 0;
  SQL_ROW_DELETED           = 1;
  SQL_ROW_UPDATED           = 2;
  SQL_ROW_NOROW             = 3;
  SQL_ROW_ADDED             = 4;
  SQL_ROW_ERROR             = 5;
  SQL_ROW_SUCCESS_WITH_INFO = 6;
  SQL_ROW_PROCEED           = 0;
  SQL_ROW_IGNORE            = 1;

  // Value for SQL_DESC_ARRAY_STATUS_PTR
  SQL_PARAM_SUCCESS           = 0;
  SQL_PARAM_SUCCESS_WITH_INFO = 6;
  SQL_PARAM_ERROR             = 5;
  SQL_PARAM_UNUSED            = 7;
  SQL_PARAM_DIAG_UNAVAILABLE  = 1;
  SQL_PARAM_PROCEED           = 0;
  SQL_PARAM_IGNORE            = 1;

  // Defines for SQLForeignKeys (UPDATE_RULE and DELETE_RULE)
  SQL_CASCADE     = 0;
  SQL_RESTRICT    = 1;
  SQL_SET_NULL    = 2;
  SQL_NO_ACTION   = 3;
  SQL_SET_DEFAULT = 4;

  // Note that the following are in a different column of SQLForeignKeys than
  // the previous #defines.   These are for DEFERRABILITY.
  SQL_INITIALLY_DEFERRED  = 5;
  SQL_INITIALLY_IMMEDIATE = 6;
  SQL_NOT_DEFERRABLE      = 7;

  // Defines for SQLProcedures (returned in the Result set)
  SQL_PT_UNKNOWN   = 0;
  SQL_PT_PROCEDURE = 1;
  SQL_PT_FUNCTION  = 2;

type
  TSQLBrowseConnect = function(
    HDbc:              SQLHDbc;
    var szConnStrIn:   SQLChar;
    cbConnStrIn:       SQLSmallint;
    var szConnStrOut:  SQLChar;
    cbConnStrOutMax:   SQLSmallint;
    var pcbConnStrOut: SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLBulkOperations = function(
    StatementHandle: SQLHStmt;
    Operation:       SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLColAttributes = function(
    HStmt:       SQLHStmt;
    icol:        SQLUSmallint;
    fDescType:   SQLUSmallint;
    rgbDesc:     SQLPointer;
    cbDescMax:   SQLSmallint;
    var pcbDesc: SQLSmallint;
    var pfDesc:  SQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLColumnPrivileges = function(
    HStmt:             SQLHStmt;
    var szCatalogName: SQLChar;
    cbCatalogName:     SQLSmallint;
    var szSchemaName:  SQLChar;
    cbSchemaName:      SQLSmallint;
    var szTableName:   SQLChar;
    cbTableName:       SQLSmallint;
    var szColumnName:  SQLChar;
    cbColumnName:      SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLDescribeParam = function(
    HStmt:           SQLHStmt;
    ipar:            SQLUSmallint;
    var pfSQLType:   SQLSmallint;
    var pcbParamDef: SQLUInteger;
    var pibScale:    SQLSmallint;
    var pfNullable:  SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLExtendedFetch = function(
    HStmt:            SQLHStmt;
    fFetchType:       SQLUSmallint;
    irow:             SQLInteger;
    var pcrow:        SQLUInteger;
    var rgfRowStatus: SQLUSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLForeignKeys = function(
    HStmt:            SQLHStmt;
    szPkCatalogName:  PSQLChar;
    cbPkCatalogName:  SQLSmallint;
    szPkSchemaName:   PSQLChar;
    cbPkSchemaName:   SQLSmallint;
    szPkTableName:    PSQLChar;
    cbPkTableName:    SQLSmallint;
    szFkCatalogName:  PSQLChar;
    cbFkCatalogName:  SQLSmallint;
    szFkSchemaName:   PSQLChar;
    cbFkSchemaName:   SQLSmallint;
    szFkTableName:    PSQLChar;
    cbFkTableName:    SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLMoreResults = function(
    HStmt: SQLHStmt
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLNativeSQL = function(
    HDbc:           SQLHDbc;
    var szSQLStrIn: SQLChar;
    cbSQLStrIn:     SQLInteger;
    var szSQLStr:   SQLChar;
    cbSQLStrMax:    SQLInteger;
    var pcbSQLStr:  SQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLNumParams = function(
    HStmt:     SQLHStmt;
    var pcpar: SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLParamOptions = function(
    HStmt:     SQLHStmt;
    crow:      SQLUInteger;
    var pirow: SQLUInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLPrimaryKeys = function(
    HStmt:         SQLHStmt;
    szCatalogName: PSQLChar;
    cbCatalogName: SQLSmallint;
    szSchemaName:  PSQLChar;
    cbSchemaName:  SQLSmallint;
    szTableName:   PSQLChar;
    cbTableName:   SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLProcedureColumns = function(
    HStmt:         SQLHStmt;
    szCatalogName: PSQLChar;
    cbCatalogName: SQLSmallint;
    szSchemaName:  PSQLChar;
    cbSchemaName:  SQLSmallint;
    szProcName:    PSQLChar;
    cbProcName:    SQLSmallint;
    szColumnName:  PSQLChar;
    cbColumnName:  SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLProcedures = function(
    HStmt:         SQLHStmt;
    szCatalogName: PSQLChar;
    cbCatalogName: SQLSmallint;
    szSchemaName:  PSQLChar;
    cbSchemaName:  SQLSmallint;
    szProcName:    PSQLChar;
    cbProcName:    SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLSetPos = function(
    HStmt:   SQLHStmt;
    irow:    SQLUSmallint;
    fOption: SQLUSmallint;
    fLock:   SQLUSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLTablePrivileges = function(
    HStmt:             SQLHStmt;
    var szCatalogName: SQLChar;
    cbCatalogName:     SQLSmallint;
    var szSchemaName:  SQLChar;
    cbSchemaName:      SQLSmallint;
    var szTableName:   SQLChar;
    cbTableName:       SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLDrivers = function(
    HEnv:               SQLHEnv;
    fDirection:         SQLUSmallint;
    szDriverDesc:       PSQLChar;
    cbDriverDescMax:    SQLSmallint;
    var pcbDriverDesc:  SQLSmallint;
    szDriverAttributes: PSQLChar;
    cbDrvrAttrMax:      SQLSmallint;
    var pcbDrvrAttr:    SQLSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  TSQLBindParameter = function(
    HStmt:      SQLHStmt;
    ipar:       SQLUSmallint;
    fParamType: SQLSmallint;
    fCType:     SQLSmallint;
    fSQLType:   SQLSmallint;
    cbColDef:   SQLUInteger;
    ibScale:    SQLSmallint;
    rgbValue:   SQLPointer;
    cbValueMax: SQLInteger;
    pcbValue:   PSQLInteger
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

const
  // SQLAllocHandleStd is implemented to make SQLAllocHandle
  // compatible with X/Open standard. an application should
  // not call SQLAllocHandleStd directly

  // Internal type subcodes (ODBC_STD, ie X/OPEN)
  SQL_YEAR             = SQL_CODE_YEAR;
  SQL_MONTH            = SQL_CODE_MONTH;
  SQL_DAY              = SQL_CODE_DAY;
  SQL_HOUR             = SQL_CODE_HOUR;
  SQL_MINUTE           = SQL_CODE_MINUTE;
  SQL_SECOND           = SQL_CODE_SECOND;
  SQL_YEAR_TO_MONTH    = SQL_CODE_YEAR_TO_MONTH;
  SQL_DAY_TO_HOUR      = SQL_CODE_DAY_TO_HOUR;
  SQL_DAY_TO_MINUTE    = SQL_CODE_DAY_TO_MINUTE;
  SQL_DAY_TO_SECOND    = SQL_CODE_DAY_TO_SECOND;
  SQL_HOUR_TO_MINUTE   = SQL_CODE_HOUR_TO_MINUTE;
  SQL_HOUR_TO_SECOND   = SQL_CODE_HOUR_TO_SECOND;
  SQL_MINUTE_TO_SECOND = SQL_CODE_MINUTE_TO_SECOND;

type
  TSQLAllocHandleStd = function(
    fHandleType:  SQLSmallint;
    hInput:       SQLHandle;
    var phOutput: SQLHandle
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

const
  // Deprecated defines from prior versions of ODBC
  SQL_DATABASE_NAME        = 16;                  // Use SQLGetConnectOption/SQL_CURRENT_QUALIFIER
  SQL_FD_FETCH_PREV        = SQL_FD_FETCH_PRIOR;
  SQL_FETCH_PREV           = SQL_FETCH_PRIOR;
  SQL_CONCUR_TIMESTAMP     = SQL_CONCUR_ROWVER;
  SQL_SCCO_OPT_TIMESTAMP   = SQL_SCCO_OPT_ROWVER;
  SQL_CC_DELETE            = SQL_CB_DELETE;
  SQL_CR_DELETE            = SQL_CB_DELETE;
  SQL_CC_CLOSE             = SQL_CB_CLOSE;
  SQL_CR_CLOSE             = SQL_CB_CLOSE;
  SQL_CC_PRESERVE          = SQL_CB_PRESERVE;
  SQL_CR_PRESERVE          = SQL_CB_PRESERVE;
  // SQL_FETCH_RESUME is not supported by 2.0+ drivers
  SQL_FETCH_RESUME         = 7;
  SQL_SCROLL_FORWARD_ONLY  = 0;  //-SQL_CURSOR_FORWARD_ONLY
  SQL_SCROLL_KEYSET_DRIVEN = -1; //-SQL_CURSOR_KEYSET_DRIVEN
  SQL_SCROLL_DYNAMIC       = -2; //-SQL_CURSOR_DYNAMIC
  SQL_SCROLL_STATIC        = -3; //-SQL_CURSOR_STATIC

type
  // Deprecated functions from prior versions of ODBC
  // Use SQLSetStmtOptions
  TSQLSetScrollOptions = function(
    HStmt:        SQLHStmt;
    fConcurrency: SQLUSmallint;
    crowKeyset:   SQLInteger;
    crowRowset:   SQLUSmallint
    ): SQLReturn; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

{-------------------------------------------------------------------------------}
// MSSQL specific

const
  SQL_COPT_SS_BASE = 1200;
  SQL_COPT_SS_PRESERVE_CURSORS = SQL_COPT_SS_BASE + 4; // Preserve server cursors after SQLTransact

  //  Defines for use with SQL_COPT_SS_PRESERVE_CURSORS
  SQL_PC_OFF = 0;               //  Cursors are closed on SQLTransact
  SQL_PC_ON = 1;                //  Cursors remain open on SQLTransact
  SQL_PC_DEFAULT = SQL_PC_OFF;

  SQL_SOPT_SS_BASE = 1225;
  SQL_SOPT_SS_CURSOR_OPTIONS = SQL_SOPT_SS_BASE + 5;   // Server cursor options
  SQL_SOPT_SS_NOCOUNT_STATUS = SQL_SOPT_SS_BASE + 6;   // Real vs. Not Real row count indicator

  // SQL_SOPT_SS_NOCOUNT_STATUS
  SQL_NC_OFF = 0;
  SQL_NC_ON = 1;

  //  Defines for use with SQL_SOPT_SS_CURSOR_OPTIONS
  SQL_CO_OFF = 0;                           //  Clear all cursor options
  SQL_CO_FFO = 1;                           //  Fast-forward cursor will be used
  SQL_CO_AF = 2;                            //  Autofetch on cursor open
  SQL_CO_FFO_AF = SQL_CO_FFO or SQL_CO_AF;  //  Fast-forward cursor with autofetch
  SQL_CO_FIREHOSE_AF = 4;                   //  Auto fetch on fire-hose cursors
  SQL_CO_DEFAULT = SQL_CO_OFF;

  // SQL_SS_LENGTH_UNLIMITED is used to describe the max length of
  // VARCHAR(max), VARBINARY(max), NVARCHAR(max), and XML columns
  SQL_SS_LENGTH_UNLIMITED = 0;

implementation

{-------------------------------------------------------------------------------}
function SQL_LEN_BINARY_ATTR(Length: SQLInteger): SQLInteger;
begin
  Result := -(Length) + SQL_LEN_BINARY_ATTR_OFFSET;
end;

{-------------------------------------------------------------------------------}
function SQL_LEN_DATA_AT_EXEC(Length: SQLInteger): SQLInteger;
begin
  Result := -(Length) + SQL_LEN_DATA_AT_EXEC_OFFSET;
end;

end.
