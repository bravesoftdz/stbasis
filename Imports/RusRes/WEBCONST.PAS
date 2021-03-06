{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{       Copyright (c) 1997,99 Inprise Corporation       }
{                                                       }
{ ������������: 1999 Polaris Software                   }
{               http://members.xoom.com/PolarisSoft     }
{*******************************************************}

unit WebConst;

interface

resourcestring
  sInvalidActionRegistration = '�������� ����������� Action';
{$IFNDEF VER130}
  sOnlyOneDataModuleAllowed = '�������� ������ ���� ������ ������ �� ����������';
  sNoDataModulesRegistered = '�� ���������������� �� ������ ������ ������';
  sNoDispatcherComponent = '�� ������� �� ������ ����������-���������� � ������ ������';
  sOnlyOneDispatcher = '������ ���� WebDispatcher �� �����/������ ������';
{$ENDIF}
  sDuplicateActionName = '�������� ����� action';
{$IFDEF VER130}
  sOnlyOneDispatcher = '������ ���� WebDispatcher �� �����/������ ������';
{$ENDIF}
{$IFNDEF VER130}
  sTooManyActiveConnections = '��������� �������� ������������� ����������.  ' +
    '��������� ������� �����';
{$ENDIF}
  sHTTPItemName = 'Name';
  sHTTPItemURI = 'PathInfo';
  sHTTPItemEnabled = 'Enabled';
  sHTTPItemDefault = 'Default';
{$IFDEF VER130}
  sHTTPItemProducer = 'Producer';
{$ENDIF}

{$IFNDEF VER130}
  sInternalServerError = '<html><title>���������� ������ ������� 500</title>'#13#10 +
    '<h1>���������� ������ ������� 500</h1><hr>'#13#10 +
    '�������������� ��������: %s<br>'#13#10 +
    '���������: %s<br></html>'#13#10;
{$ENDIF}
{$IFDEF VER120}
  sDocumentMoved = '<html><title>�������� ��������� 302</title>'#13#10 +
    '<body><h1>������ ���������</h1><hr>'#13#10 +
    '���� ������ ����� ���� ������ <a HREF="%s">�����.</a><br>'#13#10 +
    '<br></body></html>'#13#10;
{$ENDIF}
{$IFDEF VER100}
  sWindowsSocketError = '������ Windows socket: %s (%d), � API ''%s''';
  sNoAddress = '�� ������ �����';
  sCannotCreateSocket = '�� ���� ������� ����� socket';
  sCannotListenOnOpen = '�� ���� ������� �������� socket';
  sSocketAlreadyOpen = 'Socket ��� ������';
  sCantChangeWhileActive = '�� ���� �������� ��������, ���� socket ��������';
  sMustCreateThread = '����� ������ ����������� � ������ Thread blocking';
  sSocketMustBeBlocking = 'Socket ������ ���� � blocking mode';
  sSocketIOError = '%s ������ %d, %s';
  sSocketRead = '������';
  sSocketWrite = '������';
  sAsyncSocketError = '������ ������������ socket %d';
{$ENDIF}

  sResNotFound = '������ %s �� ������';

  sTooManyColumns = '������� ����� �������� � �������';
  sFieldNameColumn = 'Field Name';
  sFieldTypeColumn = 'Field Type';

{$IFNDEF VER130}
  sInvalidMask = '''%s'' - �������� ����� (%d)';
{$ENDIF}

implementation

end.

