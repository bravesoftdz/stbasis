{********************************************************}
{                                                        }
{       Borland Delphi Visual Component Library          }
{       InterBase Express core components                }
{                                                        }
{       Copyright (c) 1998-1999 Inprise Corporation      }
{                                                        }
{    InterBase Express is based in part on the product   }
{    Free IB Components, written by Gregory H. Deatz for }
{    Hoagland, Longo, Moran, Dunst & Doukas Company.     }
{    Free IB Components is used under license.           }
{                                                        }
{********************************************************}

unit IB;

interface

uses
  Windows, SysUtils, Classes, IBHeader, IBExternals, IBUtils, DB, IBXConst;

type
  TTraceFlag = (tfQPrepare, tfQExecute, tfQFetch, tfError, tfStmt, tfConnect,
     tfTransact, tfBlob, tfService, tfMisc);
  TTraceFlags = set of TTraceFlag;

  EIBError                  = class(EDatabaseError)
  private
    FSQLCode: Long;
    FIBErrorCode: Long;
  public
    constructor Create(ASQLCode: Long; Msg: string); overload;
    constructor Create(ASQLCode: Long; AIBErrorCode: Long; Msg: string); overload;
    property SQLCode: Long read FSQLCode;
    property IBErrorCode: Long read FIBErrorCode;
  end;

  EIBInterBaseError         = class(EIBError);
  EIBClientError            = class(EIBError);

  TIBDataBaseErrorMessage    = (ShowSQLCode,
                                ShowIBMessage,
                                ShowSQLMessage);
  TIBDataBaseErrorMessages   = set of TIBDataBaseErrorMessage;
  TIBClientError            = (
    ibxeUnknownError,
    ibxeInterBaseMissing,
    ibxeInterBaseInstallMissing,
    ibxeIB60feature,
    ibxeNotSupported,
    ibxeNotPermitted,
    ibxeFileAccessError,
    ibxeConnectionTimeout,
    ibxeCannotSetDatabase,
    ibxeCannotSetTransaction,
    ibxeOperationCancelled,
    ibxeDPBConstantNotSupported,
    ibxeDPBConstantUnknown,
    ibxeTPBConstantNotSupported,
    ibxeTPBConstantUnknown,
    ibxeDatabaseClosed,
    ibxeDatabaseOpen,
    ibxeDatabaseNameMissing,
    ibxeNotInTransaction,
    ibxeInTransaction,
    ibxeTimeoutNegative,
    ibxeNoDatabasesInTransaction,
    ibxeUpdateWrongDB,
    ibxeUpdateWrongTR,
    ibxeDatabaseNotAssigned,
    ibxeTransactionNotAssigned,
    ibxeXSQLDAIndexOutOfRange,
    ibxeXSQLDANameDoesNotExist,
    ibxeEOF,
    ibxeBOF,
    ibxeInvalidStatementHandle,
    ibxeSQLOpen,
    ibxeSQLClosed,
    ibxeDatasetOpen,
    ibxeDatasetClosed,
    ibxeUnknownSQLDataType,
    ibxeInvalidColumnIndex,
    ibxeInvalidParamColumnIndex,
    ibxeInvalidDataConversion,
    ibxeColumnIsNotNullable,
    ibxeBlobCannotBeRead,
    ibxeBlobCannotBeWritten,
    ibxeEmptyQuery,
    ibxeCannotOpenNonSQLSelect,
    ibxeNoFieldAccess,
    ibxeFieldReadOnly,
    ibxeFieldNotFound,
    ibxeNotEditing,
    ibxeCannotInsert,
    ibxeCannotPost,
    ibxeCannotUpdate,
    ibxeCannotDelete,
    ibxeCannotRefresh,
    ibxeBufferNotSet,
    ibxeCircularReference,
    ibxeSQLParseError,
    ibxeUserAbort,
    ibxeDataSetUniDirectional,
    ibxeCannotCreateSharedResource,
    ibxeWindowsAPIError,
    ibxeColumnListsDontMatch,
    ibxeColumnTypesDontMatch,
    ibxeCantEndSharedTransaction,
    ibxeFieldUnsupportedType,
    ibxeCircularDataLink,
    ibxeEmptySQLStatement,
    ibxeIsASelectStatement,
    ibxeRequiredParamNotSet,
    ibxeNoStoredProcName,
    ibxeIsAExecuteProcedure,
    ibxeUpdateFailed,
    ibxeNotCachedUpdates,
    ibxeNotLiveRequest,
    ibxeNoProvider,
    ibxeNoRecordsAffected,
    ibxeNoTableName,
    ibxeCannotCreatePrimaryIndex,
    ibxeCannotDropSystemIndex,
    ibxeTableNameMismatch,
    ibxeIndexFieldMissing,
    ibxeInvalidCancellation,
    ibxeInvalidEvent,
    ibxeMaximumEvents,
    ibxeNoEventsRegistered,
    ibxeInvalidQueueing,
    ibxeInvalidRegistration,
    ibxeInvalidBatchMove,
    ibxeSQLDialectInvalid,
    ibxeSPBConstantNotSupported,
    ibxeSPBConstantUnknown,
    ibxeServiceActive,
    ibxeServiceInActive,
    ibxeServerNameMissing,
    ibxeQueryParamsError,
    ibxeStartParamsError,
    ibxeOutputParsingError,
    ibxeUseSpecificProcedures,
    ibxeSQLMonitorAlreadyPresent
    );

  TStatusVector              = array[0..19] of ISC_STATUS;
  PStatusVector              = ^TStatusVector;

resourcestring
{ generic strings used in code }
  SIBDatabaseEditor = '�������� &��...';
  SIBTransactionEditor = '�������� &����������...';
  SDatabaseFilter = '����� �� (*.gdb)|*.gdb|��� ����� (*.*)|*.*';
  SDisconnectDatabase = '���� �������� ���������� � ����� ������. �������� ���������� � ����������?';
  SCommitTransaction = '���������� �������. �������� �� � ����������?';
  SExecute = '&���������';
  SNoDataSet = '��� ������ �� ����� ������ (dataset)';
  SSQLGenSelect = '���������� ������� ���� �� ���� �������� � ���� ���������� ����';
  SSQLNotGenerated = '������� Update SQL �� �������������, �����?';
  SIBUpdateSQLEditor = '�������� &UpdateSQL...';
  SSQLDataSetOpen = '�� ���� ���������� ����� ����� ��� %s';

{ strings used in error messages}
  SUnknownError = '����������� ������';
  SInterBaseMissing = '���������� InterBase gds32.dll �� �������. ����������, ���������� InterBase ��� ������������� ���� �����������';
  SInterBaseInstallMissing = '���������� ��������� InterBase ibinstall.dll �� �������. ����������, ���������� InterBase 6 ��� ������������� ���� �����������';
  SIB60feature = '%s - ��� ������� InterBase6. ����������, �������� �� InterBase6 ��� ������������� ���� �����������';
  SNotSupported = '���������������� �����������';
  SNotPermitted = '�� ���������';
  SFileAccessError = '������ ������� � ���������� �����';
  SConnectionTimeout = '������� ����� ���������� � ���� ������';
  SCannotSetDatabase = '�� ���� ���������� ���� ������';
  SCannotSetTransaction = '�� ���� ���������� ����������';
  SOperationCancelled = '�������� �������� �� ������� ������������';
  SDPBConstantNotSupported = 'DPB ��������� (isc_dpb_%s) �� ��������������';
  SDPBConstantUnknown = 'DPB ��������� (%d) ����������';
  STPBConstantNotSupported = 'TPB ��������� (isc_tpb_%s) �� ��������������';
  STPBConstantUnknown = 'TPB ��������� (%d) ����������';
  SDatabaseClosed = '�� ���� ��������� �������� -- �� �� �������';
  SDatabaseOpen = '�� ���� ��������� �������� -- �� �������';
  SDatabaseNameMissing = '�� ������� ��� ���� ������';
  SNotInTransaction = '���������� �� �������';
  SInTransaction = '���������� �������';
  STimeoutNegative = '�������� �������� �� ����� ���� ��������������';
  SNoDatabasesInTransaction = '��� ��� ������ � ������ transaction ����������';
  SUpdateWrongDB = '��������� �������� ���� ������';
  SUpdateWrongTR = '��������� �������� ����������. � ������ ��������� ���������� ����������';
  SDatabaseNotAssigned = '���� ������ �� ����������';
  STransactionNotAssigned = '���������� �� ����������';
  SXSQLDAIndexOutOfRange = '������ XSQLDA ����� �� �������';
  SXSQLDANameDoesNotExist = '��� XSQLDA �� ������� (%s)';
  SEOF = '����� �����';
  SBOF = '������ �����';
  SInvalidStatementHandle = '�������� ���������� �������';
  SSQLOpen = 'IBSQL ������';
  SSQLClosed = 'IBSQL ������';
  SDatasetOpen = '����� ������ (Dataset) ������';
  SDatasetClosed = '����� ������ (Dataset) ������';
  SUnknownSQLDataType = '�������� ��� ������ SQL (%d)';
  SInvalidColumnIndex = '�������� ������ ������� (������ �������� ����������� ��������)';
  SInvalidParamColumnIndex = '�������� ������ ��������� (������ �������� ����������� ��������)';
  SInvalidDataConversion = '�������� �������������� ������';
  SColumnIsNotNullable = '������� �� ����� ���� ����������� � NULL (%s)';
  SBlobCannotBeRead = '�� ���� ��������� �� Blob stream';
  SBlobCannotBeWritten = '�� ���� �������� � Blob stream';
  SEmptyQuery = '������ ������';
  SCannotOpenNonSQLSelect = '�� ���� ��������� Open ��� �� SELECT �������. ����������� ExecQuery';
  SNoFieldAccess = '��� ������� � ���� "%s"';
  SFieldReadOnly = '���� "%s" ������ ��� ������';
  SFieldNotFound = '���� "%s" �� �������';
  SNotEditing = '�� ��������������';
  SCannotInsert = '�� ���� �������� ������ � ����� ������ (dataset). (��� insert �������)';
  SCannotPost = '�� ���� ��������� (post). (��� update/insert �������)';
  SCannotUpdate = '�� ���� �������� (update). (��� update �������)';
  SCannotDelete = '�� ���� ������� �� ������ ������ (dataset). (��� delete �������)';
  SCannotRefresh = '�� ���� �������� ������. (��� refresh �������)';
  SBufferNotSet = '����� �� ����������';
  SCircularReference = '����������� ������ �� ���������';
  SSQLParseError = '������ ��������������� ������� SQL:' + CRLF + CRLF + '%s';
  SUserAbort = '�������� �������������';
  SDataSetUniDirectional = '���������������� ����� ������ (Data set)';
  SCannotCreateSharedResource = '�� ���� ������� ����������� ������. (������ Windows %d)';
  SWindowsAPIError = '������ Windows API. (������ Windows %d [$%.8x])';
  SColumnListsDontMatch = '������ ������� �� ���������';
  SColumnTypesDontMatch = '���� ������� �� ���������. (� ������� %d �� %d)';
  SCantEndSharedTransaction = '�� ���� ��������� ����� (shared) ���������� ����� �������, ����� ��� ������������� ��������� and equal ' +
                             'TimeoutAction ����������';
  SFieldUnsupportedType = '���������������� ��� ����';
  SCircularDataLink = '����������� DataLink ������';
  SEmptySQLStatement = '������ SQL �������';
  SIsASelectStatement = '����������� Open ��� Select �������';
  SRequiredParamNotSet = '��������� �������� Param �� �����������';
  SNoStoredProcName = '�� ���������� ��� �������� ���������';
  SIsAExecuteProcedure = '����������� ExecProc ��� ��������; ����������� TQuery ��� Select ��������';
  SUpdateFailed = '������ ��� ��������� (Update)';
  SNotCachedUpdates = 'CachedUpdates �� ���������';
  SNotLiveRequest = '������ ������ �� ��� ��������� (not live) - �� ���� ��������';
  SNoProvider = '��� ����������';
  SNoRecordsAffected = '�� ����� ������ �� ����������';
  SNoTableName = '�� ���������� ��� �������';
  SCannotCreatePrimaryIndex = '�� ���� ������� Primary ������; ������ �������������';
  SCannotDropSystemIndex = '�� ���� ������� System ������';
  STableNameMismatch = '�� ��������� ��� �������';
  SIndexFieldMissing = '�� ������� ��������� ����';
  SInvalidCancellation = '�� ���� �������� ������� �� ����� ���������';
  SInvalidEvent = '�������� �������';
  SMaximumEvents = '��������� ������������ ������ ��� �������';
  SNoEventsRegistered = '��� ������������������ �������';
  SInvalidQueueing = '�������� ����������� ��������';
  SInvalidRegistration = '�������� �����������';
  SInvalidBatchMove = '�������� �������� ����������� (batch move)';
  SSQLDialectInvalid = '�������� ������� SQL';
  SSPBConstantNotSupported = 'SPB ��������� �� ��������������';
  SSPBConstantUnknown = 'SPB ��������� ����������';
  SServiceActive = '�� ���� ��������� �������� -- ������ �� ����������';
  SServiceInActive = '�� ���� ��������� �������� -- ������ ����������';
  SServerNameMissing = '��� ������� �� �������';
  SQueryParamsError = '��������� ������� �� ������� ��� ��������';
  SStartParamsError = 'Start ��������� �� ������� ��� ��������';
  SOutputParsingError = '����������� �������� ������ ������';
  SUseSpecificProcedures = 'Generic ServiceStart �� ��������: ����������� Specific Procedures ��� ��������� ���������� ������������';
  SSQLMonitorAlreadyPresent = 'SQL Monitor ��� �������';

const
  IBPalette1 = 'InterBase'; {do not localize}
  IBPalette2 = 'InterBase Admin'; {do not localize}

  IBLocalBufferLength = 512;
  IBBigLocalBufferLength = IBLocalBufferLength * 2;
  IBHugeLocalBufferLength = IBBigLocalBufferLength * 20;

  IBErrorMessages: array[TIBClientError] of string = (
    SUnknownError,
    SInterBaseMissing,
    SInterBaseInstallMissing,
    SIB60feature,
    SNotSupported,
    SNotPermitted,
    SFileAccessError,
    SConnectionTimeout,
    SCannotSetDatabase,
    SCannotSetTransaction,
    SOperationCancelled,
    SDPBConstantNotSupported,
    SDPBConstantUnknown,
    STPBConstantNotSupported,
    STPBConstantUnknown,
    SDatabaseClosed,
    SDatabaseOpen,
    SDatabaseNameMissing,
    SNotInTransaction,
    SInTransaction,
    STimeoutNegative,
    SNoDatabasesInTransaction,
    SUpdateWrongDB,
    SUpdateWrongTR,
    SDatabaseNotAssigned,
    STransactionNotAssigned,
    SXSQLDAIndexOutOfRange,
    SXSQLDANameDoesNotExist,
    SEOF,
    SBOF,
    SInvalidStatementHandle,
    SSQLOpen,
    SSQLClosed,
    SDatasetOpen,
    SDatasetClosed,
    SUnknownSQLDataType,
    SInvalidColumnIndex,
    SInvalidParamColumnIndex,
    SInvalidDataConversion,
    SColumnIsNotNullable,
    SBlobCannotBeRead,
    SBlobCannotBeWritten,
    SEmptyQuery,
    SCannotOpenNonSQLSelect,
    SNoFieldAccess,
    SFieldReadOnly,
    SFieldNotFound,
    SNotEditing,
    SCannotInsert,
    SCannotPost,
    SCannotUpdate,
    SCannotDelete,
    SCannotRefresh,
    SBufferNotSet,
    SCircularReference,
    SSQLParseError,
    SUserAbort,
    SDataSetUniDirectional,
    SCannotCreateSharedResource,
    SWindowsAPIError,
    SColumnListsDontMatch,
    SColumnTypesDontMatch,
    SCantEndSharedTransaction,
    SFieldUnsupportedType,
    SCircularDataLink,
    SEmptySQLStatement,
    SIsASelectStatement,
    SRequiredParamNotSet,
    SNoStoredProcName,
    SIsAExecuteProcedure,
    SUpdateFailed,
    SNotCachedUpdates,
    SNotLiveRequest,
    SNoProvider,
    SNoRecordsAffected,
    SNoTableName,
    SCannotCreatePrimaryIndex,
    SCannotDropSystemIndex,
    STableNameMismatch,
    SIndexFieldMissing,
    SInvalidCancellation,
    SInvalidEvent,
    SMaximumEvents,
    SNoEventsRegistered,
    SInvalidQueueing,
    SInvalidRegistration,
    SInvalidBatchMove,
    SSQLDialectInvalid,
    SSPBConstantNotSupported,
    SSPBConstantUnknown,
    SServiceActive,
    SServiceInActive,
    SServerNameMissing,
    SQueryParamsError,
    SStartParamsError,
    SOutputParsingError,
    SUseSpecificProcedures,
    SSQLMonitorAlreadyPresent
  );

var
  IBCS: TRTLCriticalSection;

procedure IBAlloc(var P; OldSize, NewSize: Integer);

procedure IBError(ErrMess: TIBClientError; const Args: array of const);
procedure IBDataBaseError;

function StatusVector: PISC_STATUS;
function StatusVectorArray: PStatusVector;
function CheckStatusVector(ErrorCodes: array of ISC_STATUS): Boolean;
function StatusVectorAsText: string;

procedure SetIBDataBaseErrorMessages(Value: TIBDataBaseErrorMessages);
function GetIBDataBaseErrorMessages: TIBDataBaseErrorMessages;

implementation

uses
  IBIntf;

var
  IBDataBaseErrorMessages: TIBDataBaseErrorMessages;
threadvar
  FStatusVector : TStatusVector;

procedure IBAlloc(var P; OldSize, NewSize: Integer);
var
  i: Integer;
begin
  ReallocMem(Pointer(P), NewSize);
  for i := OldSize to NewSize - 1 do PChar(P)[i] := #0;
end;

procedure IBError(ErrMess: TIBClientError; const Args: array of const);
begin
  raise EIBClientError.Create(Ord(ErrMess),
                              Format(IBErrorMessages[ErrMess], Args));
end;

procedure IBDataBaseError;
var
  sqlcode: Long;
  IBErrorCode: Long;
  local_buffer: array[0..IBHugeLocalBufferLength - 1] of char;
  usr_msg: string;
  status_vector: PISC_STATUS;
  IBDataBaseErrorMessages: TIBDataBaseErrorMessages;
begin
  usr_msg := '';

  { Get a local reference to the status vector.
    Get a local copy of the IBDataBaseErrorMessages options.
    Get the SQL error code }
  status_vector := StatusVector;
  IBErrorCode := StatusVectorArray[1];
  IBDataBaseErrorMessages := GetIBDataBaseErrorMessages;
  sqlcode := isc_sqlcode(status_vector);

  if (ShowSQLCode in IBDataBaseErrorMessages) then
    usr_msg := usr_msg + 'SQLCODE: ' + IntToStr(sqlcode); {do not localize}
  Exclude(IBDataBaseErrorMessages, ShowSQLMessage);
  if (ShowSQLMessage in IBDataBaseErrorMessages) then
  begin
    isc_sql_interprete(sqlcode, local_buffer, IBLocalBufferLength);
    if (ShowSQLCode in IBDataBaseErrorMessages) then
      usr_msg := usr_msg + CRLF;
    usr_msg := usr_msg + string(local_buffer);
  end;

  if (ShowIBMessage in IBDataBaseErrorMessages) then
  begin
    if (ShowSQLCode in IBDataBaseErrorMessages) or
       (ShowSQLMessage in IBDataBaseErrorMessages) then
      usr_msg := usr_msg + CRLF;
    while (isc_interprete(local_buffer, @status_vector) > 0) do
    begin
      if (usr_msg <> '') and (usr_msg[Length(usr_msg)] <> LF) then
        usr_msg := usr_msg + CRLF;
      usr_msg := usr_msg + string(local_buffer);
    end;
  end;
  if (usr_msg <> '') and (usr_msg[Length(usr_msg)] = '.') then
    Delete(usr_msg, Length(usr_msg), 1);

  raise EIBInterBaseError.Create(sqlcode, IBErrorCode, usr_msg);
end;

{ Return the status vector for the current thread }
function StatusVector: PISC_STATUS;
begin
  result := @FStatusVector;
end;

function StatusVectorArray: PStatusVector;
begin
  result := @FStatusVector;
end;

function CheckStatusVector(ErrorCodes: array of ISC_STATUS): Boolean;
var
  p: PISC_STATUS;
  i: Integer;
  procedure NextP(i: Integer);
  begin
    p := PISC_STATUS(PChar(p) + (i * SizeOf(ISC_STATUS)));
  end;
begin
  p := @FStatusVector;
  result := False;
  while (p^ <> 0) and (not result) do
    case p^ of
      3: NextP(3);
      1, 4:
      begin
        NextP(1);
        i := 0;
        while (i <= High(ErrorCodes)) and (not result) do
        begin
          result := p^ = ErrorCodes[i];
          Inc(i);
        end;
        NextP(1);
      end;
      else
        NextP(2);
    end;
end;

function StatusVectorAsText: string;
var
  p: PISC_STATUS;
  function NextP(i: Integer): PISC_STATUS;
  begin
    p := PISC_STATUS(PChar(p) + (i * SizeOf(ISC_STATUS)));
    result := p;
  end;
begin
  p := @FStatusVector;
  result := '';
  while (p^ <> 0) do
    if (p^ = 3) then
    begin
      result := result + Format('%d %d %d', [p^, NextP(1)^, NextP(1)^]) + CRLF;
      NextP(1);
    end
    else begin
      result := result + Format('%d %d', [p^, NextP(1)^]) + CRLF;
      NextP(1);
    end;
end;


{ EIBError }
constructor EIBError.Create(ASQLCode: Long; Msg: string);
begin
  inherited Create(Msg);
  FSQLCode := ASQLCode;
end;

constructor EIBError.Create(ASQLCode: Long; AIBErrorCode: Long; Msg: string);
begin
  inherited Create(Msg);
  FSQLCode :=  ASQLCode;
  FIBErrorCode := AIBErrorCode;
end;

procedure SetIBDataBaseErrorMessages(Value: TIBDataBaseErrorMessages);
begin
  EnterCriticalSection(IBCS);
  try
    IBDataBaseErrorMessages := Value;
  finally
    LeaveCriticalSection(IBCS);
  end;
end;

function GetIBDataBaseErrorMessages: TIBDataBaseErrorMessages;
begin
  EnterCriticalSection(IBCS);
  try
    result := IBDataBaseErrorMessages;
  finally
    LeaveCriticalSection(IBCS);
  end;
end;

initialization
  IsMultiThread := True;
  InitializeCriticalSection(IBCS);
  IBDataBaseErrorMessages := [ShowSQLMessage, ShowIBMessage];

finalization
  DeleteCriticalSection(IBCS);

end.
