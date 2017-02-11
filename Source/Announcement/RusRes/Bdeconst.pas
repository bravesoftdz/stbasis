{********************************************************}
{                                                        }
{       Borland Delphi Visual Component Library          }
{                                                        }
{       Copyright (c) 1995,99 Inprise Corporation        }
{                                                        }
{ ������������: 1998-99 Polaris Software                 }
{               http://members.xoom.com/PolarisSoft      }
{********************************************************}

unit BdeConst;

interface

resourcestring
{$IFNDEF VER100}
  SAutoSessionExclusive = '�� ���� �������� �������� AutoSessionName ��� ����� ��� ����� ������ � ����� ��� ������ ������';
  SAutoSessionExists = '�� ���� �������� ������ � ����� ��� ������ ������, ����� ��� ������ ''%s'' �������� AutoSessionName';
  SAutoSessionActive = '�� ���� �������� SessionName, ���� AutoSessionName ��������';
{$ENDIF}
  SDuplicateDatabaseName = '�������� ����� ���� ������ ''%s''';
  SDuplicateSessionName = '�������� ����� ������ ''%s''';
  SInvalidSessionName = '�������� ��� ������ %s';
  SDatabaseNameMissing = '����������� ��� ���� ������';
  SSessionNameMissing = '����������� ��� ������';
  SDatabaseOpen = '�� ���� ��������� ��� �������� ��� �������� ���� ������';
  SDatabaseClosed = '�� ���� ��������� ��� �������� ��� �������� ���� ������';
  SDatabaseHandleSet = '������������ ���� ������ ������� ������ ������';
  SSessionActive = '�� ���� ��������� ��� �������� ��� �������� ������';
  SHandleError = '������ �������� �������';
  SInvalidFloatField = '�� ���� ������������� ���� ''%s'' � ������� ��������';
  SInvalidIntegerField = '�� ���� ������������� ���� ''%s'' � ����� ��������';
  STableMismatch = '�������-�������� � �������� ������������';
  SFieldAssignError = '���� ''%s'' � ''%s'' �� ���������� ��� ������������';
  SNoReferenceTableName = 'ReferenceTableName �� ���������� ��� ''%s''';
{$IFDEF VER100}
  SFieldUndefinedType = '��� ���� ''%s'' ����������';
  SFieldUnsupportedType = '��� ���� ''%s'' �� ��������������';
{$ENDIF}
  SCompositeIndexError = '�� ���� ������������ ������ �������� ����� � ���������-�����������';
  SInvalidBatchMove = '�������� ��������� ��������� ����������� (batch move)';
  SEmptySQLStatement = '��� ��������� SQL ������';
  SNoParameterValue = '��� �������� ��������� ''%s''';
  SNoParameterType = '�� ����� ��� ��������� ''%s''';
{$IFDEF VER100}
  SParameterNotFound = '�������� ''%s'' �� ������';
  SParamTooBig = '�������� ''%s'', �� ���� ��������� ������ ����� ��� %d ����';
{$ENDIF}
  SLoginError = '�� ���� ������������ � ���� ������ ''%s''';
  SInitError = '������ ������������� Borland Database Engine (������ $%.4x)';
{$IFNDEF VER130}
  SDatasetDesigner = '&�������� �����...';
  SFKInternalCalc = '&InternalCalc';
{$ENDIF}
{$IFDEF VER120}
  SFKAggregate = '&Aggregate';
{$ENDIF}
  SDatabaseEditor = '�������� &��...';
  SExplore = 'E&xplore';
{$IFNDEF VER130}
  SLinkDesigner = '���� ''%s'' �� ������ Detail Fields ������ ���� �������';
{$ENDIF}
  SLinkDetail = '������� ''%s'' �� ����� ���� �������';
  SLinkMasterSource = '�������� MasterSource ''%s'' ������ ���� ������� � DataSource';
  SLinkMaster = '���������� ������� ������� �� MasterSource';
{$IFDEF VER100}
  SSQLDatasetDesigner = '�������� &�����...';
  SQBEVerb = '����������� &��������...';
{$ELSE}
  SGQEVerb = '����������� &��������...';
{$ENDIF}
  SBindVerb = '&���������� ���������...';
  SIDAPILangID = '0019';
  SDisconnectDatabase = '���� ������ ������ ������������. ������������� � ����������?';
  SBDEError = '������ BDE $%.4x';
  SLookupSourceError = '���������� ������������ ������������� DataSource � LookupSource';
  SLookupTableError = 'LookupSource ������ ����������� � ����������� TTable';
  SLookupIndexError = '%s ������ ���� lookup table''s �������� ��������';
  SParameterTypes = ';Input;Output;Input/Output;Result';
  SInvalidParamFieldType = '���������� ������� ���������� ��� ����';
  STruncationError = '�������� ''%s'' ������ �� ������';
{$IFDEF VER100}
  SInvalidVersion = '���������� ��������� ��������� ��������';
{$ENDIF}
  SDataTypes = ';String;SmallInt;Integer;Word;Boolean;Float;Currency;BCD;Date;Time;DateTime;;;;Blob;Memo;Graphic;;;;;Cursor;';
  SResultName = 'Result';
  SDBCaption = '%s%s%s ���� ������';
  SParamEditor = '%s%s%s ���������';
{$IFNDEF VER130}
  SDatasetEditor = '%s%s%s';
{$ENDIF}
  SIndexFilesEditor = '%s%s%s ��������� �����';
  SNoIndexFiles = '(���)';
  SIndexDoesNotExist = '������ �� ����������. ������: %s';
  SNoTableName = '����������� �������� TableName';
{$IFNDEF VER100}
  SNoDataSetField = '����������� �������� DataSetField';
{$ENDIF}
  SBatchExecute = '�&��������';
  SNoCachedUpdates = '�� � ������ cached update';
  SInvalidAliasName = '�������� ��� ���������� (alias) %s';
{$IFNDEF VER130}
  SDBGridColEditor = '&�������� ��������...';
{$ENDIF}
  SNoFieldAccess = '�� ���� �������� ������ � ���� ''%s'' � �������';
  SUpdateSQLEditor = '&�������� UpdateSQL...';
{$IFNDEF VER100}
  SNoDataSet = '��� ���������� � ������� ������ (dataset)';
{$ENDIF}
  SUntitled = '��������� ��� ���������';
  SUpdateWrongDB = '�� ���� ��������, %s �� ����� ��������� %s';
  SUpdateFailed = '��������� (update) �� ���������';
  SSQLGenSelect = '����� ������� ���� �� ���� �������� ���� � ���� ���������� ����';
  SSQLNotGenerated = '������� Update SQL �� �������������, �����?';
  SSQLDataSetOpen = '���������� ���������� ����� ����� ��� %s';
  SLocalTransDirty = '������� �������� ���������� ������ ���� dirty read ��� ��������� ��';
{$IFNDEF VER130}
  SPrimary = 'Primary';
{$ENDIF}
  SMissingDataSet = '����������� �������� DataSet';
  SNoProvider = '��� ��������� �����������';
{$IFNDEF VER100}
  SNotAQuery = '����� ������ (Dataset) �� �������� ��������';
{$ENDIF}

implementation

end.
