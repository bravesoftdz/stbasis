{*******************************************************}
{                                                       }
{       Borland Delphi Runtime Library                  }
{                                                       }
{       Copyright (C) 1998-99 Inprise Corporation       }
{                                                       }
{ ������������: 1998-99 Polaris Software                }
{               http://members.xoom.com/PolarisSoft     }
{*******************************************************}

unit CorbCnst;

interface

resourcestring
  SCorbaDllNotLoaded = '�� ���� ��������� ���������� CORBA';
  SCorbaNotInitialized = '���������� CORBA �� ������� ��� �� ����������������';
  SCorbaSkeletonNotRegistered = '������-������ CORBA �� ��������������� ��� ������� %s';
  SCorbaStubNotRegistered = '���������� ��������� (stub) CORBA �� ���������������';
  SCorbaInterfaceIDNotRegister = '��������� CORBA �� ���������������';
  SCorbaRepositoryIDNotRegistered = 'CORBA Repository ID "%s" �� ���������������';
  SCorbaIncompleteFactory = 'CORBA Factory �� ��������� CreateInterface';

resourcestring
  sInvalidTypeCast = '������� �� ����� ���� �������������� � CORBA Any';
  sNotCorbaObject = 'Variant/Any - �� ������ CORBA';
  sParamTypeCast = '�������� (%d) ������ %s - ��������� ����';
  sParamOut = '�������� (%d) ������ %s - �������� out ��� in/out � ������� ��������� ��� � ����������';
  sNoRepository = '�� ���� ��������� CORBA Dispatch, �� ������ ����������� ����������';
  sInvalidParameterCount = '�������� ���������� ���������� � ������ %s';
  sMethodNotFound = '����� %s �� ������';
  sConnecting = '���������� � �������� CORBA...';

implementation

end.
