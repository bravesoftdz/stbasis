{********************************************************}
{                                                        }
{       Borland Delphi Visual Component Library          }
{                                                        }
{       Copyright (c) 1995,99 Inprise Corporation        }
{                                                        }
{ ������������: 1998-99 Polaris Software                 }
{               http://members.xoom.com/PolarisSoft      }
{********************************************************}

unit OleConst;

interface

resourcestring
  SBadPropValue = '''%s'' - ������������ �������� ��������';
  SCannotActivate = '������ ��������� �������� ���������� OLE';
  SNoWindowHandle = '�� ���� �������� ���������� ���� �������� ���������� OLE';
  SOleError = '������ OLE %.8x';
  SVarNotObject = 'Variant �� ��������� �� ������ OLE';
  SVarNotAutoObject = 'Variant �� ��������� �� ������ automation';
  SNoMethod = '����� ''%s'' �� �������������� �������� OLE';
  SLinkProperties = '�������� ����������';
  SInvalidLinkSource = '�� ���� ������������ � ��������� ���������.';
  SCannotBreakLink = '�������� ������ ���������� �� ��������������.';
  SLinkedObject = '��������� %s';
  SEmptyContainer = '�������� �� ��������� �� ������ OLE ����������';
  SInvalidVerb = 'Invalid object verb';
  SPropDlgCaption = '%s ��������';
  SInvalidStreamFormat = '�������� ������ ������';
  SInvalidLicense = '�������� ���������� � �������� ��� %s';
  SNotLicensed = '���������� � �������� ��� %s �� �������. �� �� ������ ������������ ���� ������� ���������� � ������ ����������';
{$IFDEF VER130}
  sNoRunningObject = '�� ���� �������� ������ �� ���������� ������, ������������������ � OLE, ��� %s/%s';
{$ENDIF}

implementation

end.