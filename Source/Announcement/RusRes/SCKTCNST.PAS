{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{       Copyright (c) 1997,99 Inprise Corporation       }
{                                                       }
{ ������������: 1999 Polaris Software                   }
{               http://members.xoom.com/PolarisSoft     }
{*******************************************************}

unit ScktCnst;

interface

const
  //Do not localize
  KEY_SOCKETSERVER  = '\SOFTWARE\Borland\Socket Server';
{$IFDEF VER130}
  KEY_IE            = 'SOFTWARE\Microsoft\Internet Explorer';
{$ENDIF}
  csSettings        = 'Settings';
  ckPort            = 'Port';
  ckThreadCacheSize = 'ThreadCacheSize';
  ckInterceptGUID   = 'InterceptGUID';
  ckShowHost        = 'ShowHost';
  ckTimeout         = 'Timeout';
{$IFDEF VER130}
  ckRegistered      = 'RegisteredOnly';
  SServiceName      = 'SocketServer';
  SApplicationName  = 'Borland Socket Server';
{$ENDIF}

resourcestring
  SServiceOnly = 'Socket Server ����� �������� ������ ��� ������ �� NT 3.51 ��� �����';
  SErrClose = '�� ���� �����, ����� ���� �������� ����������. �������� ����������?';
  SErrChangeSettings = '�� ���� �������� ���������, ����� ���� �������� ����������. �������� ����������?';
  SQueryDisconnect = '������������ �������� ����� ������� ������ ����������. ����������?';
  SOpenError = '������ �������� ����� %d � �������: %s';
  SHostUnknown = '(����������)';
{$IFDEF VER130}
  SNotShown = '(�������)';
{$ENDIF}
  SNoWinSock2 = '������ ���� ���������� WinSock 2 ��� ������������� socket ����������';
{$IFDEF VER130}
  SStatusline = '%d ������� ����������';
  SAlreadyRunning = 'Socket Server ��� ��������';
  SNotUntilRestart = '��� ��������� �� ������� � ���� ���� Socket Server �� ����� ������������';
{$ENDIF}

implementation

end.
 