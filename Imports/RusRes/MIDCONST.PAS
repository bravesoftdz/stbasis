{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{       Copyright (c) 1997,99 Inprise Corporation       }
{                                                       }
{ ������������: 1998-99 Polaris Software                }
{               http://members.xoom.com/PolarisSoft     }
{*******************************************************}

unit MidConst;

interface

{$IFDEF VER130}
const
{ Do not localize }
  MIDAS_CatDesc = 'Borland MIDAS Application Servers';
  CATID_MIDASAppServer: TGUID = '{13E85B3C-9508-11D2-AB63-00C04FA35CFA}';
  SCatImplBaseKey = 'CLSID\%s\Implemented Categories';
  SCatImplKey = SCatImplBaseKey + '\%s';
  MIDAS_DLL = 'MIDAS.DLL';
  SClsid = 'CLSID\';
  SPooled = 'Pooled';
  SMaxObjects = 'MaxObjects';
  STimeout = 'Timeout';
  SSingleton = 'Singleton';
  SSockets = 'Sockets';
  SWeb = 'Web';
  SFlagOn = '1';
  SFlagOff = '0'; 
{$ENDIF}

resourcestring
{$IFDEF VER130}
  { App Server }
  SProviderNotExported = '��������� �� �������������: %s';
{$ENDIF}

  { DBClient }
  SNoDataProvider = '������� ��������� ������ ��� ����� ������';
  SInvalidDataPacket = '�������� ����� ������';
  SRefreshError = '���������� ��������� ��������� ����� ����������� ������';
  SProviderInvalid = '�������� ���������. ��������� ��� ���������� �������� ����������';
  SServerNameBlank = '�� ���� �����������, %s ������ ��������� ���������� ServerName ��� ServerGUID';
  SRepositoryIdBlank = '�� ���� �����������, %s ������ ��������� ���������� repository id';
  SAggsGroupingLevel = '������� ����������� �������� ������� ���������� ����� �������';
  SAggsNoSuchLevel = '������� ����������� �� ���������';
  SNoCircularReference = '����������� ������ ����������� �� �����������';
{$IFDEF VER130}
  SErrorLoadingMidas = '������ �������� MIDAS.DLL';
  SCannotCreateDataSet = '���� �� ����������.  �� ���� ������� ����� ������ (dataset)';
{$ENDIF}

  { MConnect }
  SSocketReadError = '������ ������ �� socket';
  SInvalidProviderName = '��� ���������� "%s" �� ���������� ��������';
  SBadVariantType = '���������������� ���������� ���: %s';
  SInvalidAction = '��������� �������� �������� (action): %d';

  { Resolver }
  SInvalidResponse = '�������� �����';
{$IFNDEF VER130}
  SRecordChanged = '������ �������� ������ �������������';
{$ENDIF}
  SRecordNotFound = '������ �� �������';
  STooManyRecordsModified = '��������� (Update) ����������� ����� 1 ������.';

  { Provider }
  SInvalidOptParamType = '�������� �� ����� ���� ��������� � �������������� ��������';
  SMissingDataSet = '�������� �������� DataSet';
  SConstraintFailed = '������� �� ������ ��� ���� (constraint) �� �����������.';
  SField = 'Field';
  SReadOnlyProvider = '�� ���� ��������� ��������� ��� ReadOnly ����������';
  SNoKeySpecified = '�� ���� ����� ������.  �� ��������� ����';
  SFieldNameTooLong = '��� ���� �� ����� ���� ������� ��� %d ��������.  ����������� ' +
                      '���������� ObjectView � True � dataset';
  SNoDataSets = '�� ���� ���������� ����� ������, ����� ������������ ��������� ������ ������ ��� ������';
  SRecConstFail = '���������� record constraint �� ����������� � ������� "%s"';
  SFieldConstFail = '���������� field constraint �� ����������� � ������� "%s"';
  SDefExprFail = '���������� default expression �� ����������� � ������� "%s"';
  SArrayElementError = '������ ��������� ���� %s �� ��������������'; 
  SNoTableName = '�� ���� ���������� ������.  ��� ������� �� �������.';
{$IFDEF VER130}
  SNoEditsAllowed = '��������� �� ���������';
  SNoDeletesAllowed = '�������� �� ���������';
  SNoInsertsAllowed = '���������� (inserts) �� ���������';
  SCannotChangeCommandText = '��������� CommandText �� ���������';
{$ENDIF}

  { ObjectBroker }
  SNoServers = '��� ���������� �������';

  { Socket Connection }
  SReturnError = '��������� ������������ �������� �� ��������';
  SNoWinSock2 = '������ ���� ���������� WinSock 2 ��� ������������� socket ����������';

{$IFDEF VER130}
  { Web Connection }
  SURLRequired = '��������� URL';
  SDefaultURL = 'http://server.company.com/scripts/httpsrvr.dll';
  SInvalidURL = 'URL ������ ���� � ����� "http://server.company.com/scripts/httpsrvr.dll"';
  SServerIsBusy = '������ �����';

  SObjectNotAvailable = '������ �� ��������: %s';
{$ENDIF}

implementation

end.
