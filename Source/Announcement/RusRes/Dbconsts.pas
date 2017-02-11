{********************************************************}
{                                                        }
{       Borland Delphi Visual Component Library          }
{                                                        }
{       Copyright (c) 1995,99 Inprise Corporation        }
{                                                        }
{ ������������: 1998-99 Polaris Software                 }
{               http://members.xoom.com/PolarisSoft      }
{********************************************************}

unit DbConsts;

interface

resourcestring
  SInvalidFieldSize = '�������� ������ ����';
{$IFNDEF VER100}
  SInvalidFieldKind = '�������� FieldKind';
{$ENDIF}
  SInvalidFieldRegistration = '�������� ����������� ����';
  SUnknownFieldType = '��� ���� ''%s'' ����������';
  SFieldNameMissing = '����������� ��� ����';
  SDuplicateFieldName = '�������� ����� ���� ''%s''';
{$IFNDEF VER100}
  SFieldNotFound = '���� ''%s'' �� �������';
{$ELSE}
  SFieldNotFound = '%s: ���� ''%s'' �� �������';
{$ENDIF}
  SFieldAccessError = '�� ���� �������� ������ � ���� ''%s'' ��� ���� %s';
  SFieldValueError = '�������� �������� ��� ���� ''%s''';
  SFieldRangeError = '%g - �������� �������� ��� ���� ''%s''. ����������� �������� - �� %g �� %g';
  SInvalidIntegerValue = '''%s'' - �������� ����� �������� ��� ���� ''%s''';
  SInvalidBoolValue = '''%s'' - �������� ���������� �������� ��� ���� ''%s''';
  SInvalidFloatValue = '''%s'' - �������� ������� �������� ��� ���� ''%s''';
{$IFNDEF VER100}
  SFieldTypeMismatch = '�������� ��� ���� ''%s'', ���������: %s, �����������: %s';
  SFieldSizeMismatch = '�������� ������ ��� ���� ''%s'', ���������: %d, �����������: %d';
{$ELSE}
  SFieldTypeMismatch = '��� ���� ''%s'' �� ������������� ����������';
{$ENDIF}
  SInvalidVarByteArray = '�������� ���������� ��� ��� ������';
  SFieldOutOfRange = '�������� ���� ''%s'' ����� �� �������';
  SBCDOverflow = '(������������)';
  SFieldRequired = '���� ''%s'' ������ ����� ��������';
  SDataSetMissing = '���� ''%s'' �� ����� ������ ������ (dataset)';
  SInvalidCalcType = '���� ''%s'' �� ����� ���� ����������� ��� ��������� �����';
  SFieldReadOnly = '���� ''%s'' �� ����� ���� ��������';
  SFieldIndexError = '������ ���� ����� �� �������';
  SNoFieldIndexes = '��� ��������� �������';
  SNotIndexField = '���� ''%s'' �� ������������� � �� ����� ���� ��������';
  SIndexFieldMissing = '�� ���� �������� ������ � ���������� ���� ''%s''';
  SDuplicateIndexName = '�������� ����� ������� ''%s''';
{$IFNDEF VER100}
  SNoIndexForFields = '��� ������� ��� ����� ''%s''';
  SIndexNotFound = '������ ''%s'' �� ������';
  SDuplicateName = '�������� ����� ''%s'' � %s';
{$ELSE}
  SNoIndexForFields = '������� ''%s'' �� ����� ������� ��� ����� ''%s''';
{$ENDIF}
  SCircularDataLink = '����������� ����� ������ �� ���������';
  SLookupInfoError = '���������� ������ (lookup) ��� ���� ''%s'' - ��������';
  SDataSourceChange = 'DataSource �� ����� ���� �������';
{$IFNDEF VER100}
  SNoNestedMasterSource = '��������� ������� �� ����� ����� MasterSource';
{$ENDIF}
  SDataSetOpen = '�� ���� ��������� ��� �������� ��� ��������� ������ ������ (dataset)';
  SNotEditing = '����� ������ (Dataset) �� � ������ �������������� ��� �������';
  SDataSetClosed = '�� ���� ��������� ��� �������� ��� ��������� ������ ������ (dataset)';
  SDataSetEmpty = '�� ���� ��������� ��� �������� ��� ������� ������ ������ (dataset)';
  SDataSetReadOnly = '�� ���� �������� ����� ������ "������ ��� ������" (read-only dataset)';
{$IFNDEF VER100}
  SNestedDataSetClass = '��������� ����� ������ ������ ������������� �� %s';
{$ELSE}
  SAutoSessionExclusive = '�� ���� ���������� �������� AutoSession � ����� ��� ����� ������� � ����� ��� ������ ������';
  SAutoSessionExists = '�� ���� �������� ������ � ����� ��� ������ ������, ���� ������ ''%s'' ����� ������������� AutoSession';
  SAutoSessionActive = '�� ���� �������� SessionName, ���� ����������� AutoSession';
{$ENDIF}
  SExprTermination = '��������� ������� ����������� ���������';
  SExprNameError = '������������� ��� ����';
  SExprStringError = '������������� ��������� ���������';
  SExprInvalidChar = '�������� ������ � ��������� �������: ''%s''';
  SExprNoRParen = ''')'' ���������, ���������� %s';
{$IFNDEF VER100}
  SExprNoRParenOrComma = ''')'' ��� '','' ���������, ���������� %s';
  SExprNoLParen = '''('' ���������, ���������� %s';
{$ENDIF}
  SExprExpected = '��������� ���������, ���������� %s';
  SExprBadField = '���� ''%s'' �� ����� �������������� � ��������� �������';
  SExprBadNullTest = 'NULL ��������� ������ � ''='' � ''<>''';
  SExprRangeError = '��������� ����� �� �������';
  SExprNotBoolean = '���� ''%s'' - �� ����������� ����';
  SExprIncorrect = '����������� �������������� ��������� �������';
  SExprNothing = '�����';
{$IFNDEF VER100}
  SExprTypeMis = '������������ ����� � ���������';
  SExprBadScope = '� �������� ������ ��������� ���������� �������� �� ���������� �����';
  SExprNoArith = '���������� � ��������� ������� �� ��������������';
  SExprNotAgg = '��������� �� �������� ����������';
  SExprBadConst = '��������� ��������� ���� %s';
  SExprNoAggFilter = '���������� ��������� �� �������������� � ��������';
  SExprEmptyInList = '������ IN ������� �� ����� ���� ������';
  SInvalidKeywordUse = '�������� ������������� ��������� �����';
{$ENDIF}
  STextFalse = '0';
  STextTrue = '1';
{$IFNDEF VER100}
  SParameterNotFound = '�������� ''%s'' �� ������';
  SInvalidVersion = '���������� ��������� ��������� ��������';
  SParamTooBig = '�������� ''%s'', �� ���� ��������� ������ ������� %d ����';
{$IFDEF VER130}
  SBadFieldType = '��� ���� ''%s'' �� ��������������';
{$ELSE}
  SParamBadFieldType = '��� ���� ''%s'' �� ��������������';
{$ENDIF}
  SAggActive = '�������� �� ����� ���� ��������, ���� aggregate �������';
{$IFDEF VER130}
  SProviderSQLNotSupported = 'SQL �� ��������������: %s';
  SProviderExecuteNotSupported = '���������� �� ��������������: %s';
  SExprNoAggOnCalcs = '������������ ���� ''%s'' ��������� ���� ������������ ���� � aggregate, ����������� internalcalc';
  SRecordChanged = '������ �������� ������ �������������';
{$ENDIF}
{$ENDIF}

{$IFDEF VER100}
  { DBClient }
  SNoDataProvider = '�������� ����� � ����������� ��� ����� ������';
  SInvalidDataPacket = '�������� ����� ������';
  SRefreshError = '���������� ��������� ��������� ����� ����������� ������';
  SExportProvider = '������� %s �� ������ ������';
  SProviderInvalid = '�������� ���������. ��������� ������ �������� ����������';
  SClientDSAssignData = 'Assign Local &Data...';
  SLoadFromFile = '&��������� �� �����...';
  SSaveToFile = '��������� � &����...';
  SClientDSClearData = '&�������� ������';
  SClientDataSetEditor = '%s.%s Data';
  SClientDataFilter = 'Client DataSet (*.cds)|*.cds|��� ����� (*.*)|*.*';
  SInvalidProviderName = '��������� �� ��������� ��������';
  SServerNameBlank = '�� ���� ������������, %s ������ ��������� ���������� ServerName ��� ServerGUID';
{$ENDIF}

  { DBCtrls }
  SFirstRecord = '������ ������';
  SPriorRecord = '���������� ������';
  SNextRecord = '��������� ������';
  SLastRecord = '��������� ������';
  SInsertRecord = '�������� ������';
  SDeleteRecord = '������� ������';
  SEditRecord = '�������� ������';
  SPostEdit = '����������� ���������';
  SCancelEdit = '�������� ���������';
  SRefreshRecord = '�������� ������';
  SDeleteRecordQuestion = '������� ������?';
  SDeleteMultipleRecordsQuestion = '������� ��� ��������� ������?';
  SRecordNotFound = '������ �� �������';
  SDataSourceFixed = '�������� �� ��������� � DBCtrlGrid';
  SNotReplicatable = '���� ������� �� ����� �������������� � DBCtrlGrid';
  SPropDefByLookup = '�������� ��� ���������� ��������� ����� (lookup field)';
  STooManyColumns = '��������� Grid ��� ����������� ����� 256 �������';

{$IFNDEF VER100}
  { DBLogDlg }
  SRemoteLogin = 'Remote Login';

  { DBOleEdt }
  SDataBindings = '�������� ������...';
{$ELSE}
  { MIDASCon }
  SSocketReadError = '������ ������ �� socket';
  SSocketWriteError = '������ ������ � socket';
  SBadVariantType = '���������������� ���������� ���: %s';
  SInvalidAction = '��������� �������� ��������';
  SConnectionLost = '���������� ��������';
  SComputerNameRequired = '��������� ComputerName';

  { ScktSrvr }
  SErrChangePort = '�� ���� �������� ����, ���� ���� �������� ����������';
  SErrClose = '�� ���� �����, ���� ���� �������� ����������';
  SButtonApply = '���������';
  SButtonExit = '�����';
{$ENDIF}

implementation

end.
