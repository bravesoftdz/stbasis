{*******************************************************}
{                                                       }
{       Borland Delphi Runtime Library                  }
{                                                       }
{       Copyright (C) 1997,99 Inprise Corporation       }
{                                                       }
{ ������������: 1998-99 Polaris Software                }
{               http://members.xoom.com/PolarisSoft     }
{*******************************************************}

unit ComConst;

interface

resourcestring
  SCreateRegKeyError = '������ �������� ����� (entry) ���������� �������';
  SOleError = '������ OLE %.8x';
  SObjectFactoryMissing = 'Object factory ��� ������ %s ��������';
  STypeInfoMissing = '���������� � ���� �������� ��� ������ %s';
  SBadTypeInfo = '�������� ���������� � ���� ��� ������ %s';
  SDispIntfMissing = 'Dispatch interface ������� ��� ������ %s';
  SNoMethod = '����� ''%s'' �� �������������� automation ��������';
  SVarNotObject = '������� �� ��������� automation ��������';
  SDCOMNotInstalled = 'DCOM �� ����������';
  SDAXError = '������ DAX';

  SAutomationWarning = '�������������� COM �������';
  SNoCloseActiveServer1 = '� ���������� ������� �������� COM �������. ' +
    '���� ��� ����� �������� ����� ��������� �� ��� �������, ' +
    '����� �������, �������� ';
  SNoCloseActiveServer2 = '���������� ����� ������� ���� ���������� ' +
    '����������.'#13#10#13#10'�� �������, ��� ������ ������� ��� ' +
    '����������?';

implementation

end.
