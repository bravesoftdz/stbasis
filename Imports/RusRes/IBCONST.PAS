{ ������������: 1998-99 Polaris Software                }
{               http://members.xoom.com/PolarisSoft     }

unit IBConst;

interface

resourcestring
  srSamples = 'Samples';
  SNoEventsRegistered  = '�� ������ ���������������� ������� ����� �� ��������';
  SInvalidDBConnection = '��������� �� ��������� � �������� Database';
  SInvalidDatabase     = '''''%s'''' �� ��������� � ���� ������ InterBase';
  SInvalidCancellation = '������ ������� CancelEvents ������ OnEventAlert';
  SInvalidEvent        = '�������� ������ ������� ��������� � ������ ������� EventAlerter';
  SInvalidQueueing     = '������ ������� QueueEvents ������ OnEventAlert';
  SInvalidRegistration = '������ ������� Register ��� Unregister ��� ������� ������ OnEventAlert';  
{$IFNDEF VER100}
  SMaximumEvents       = '����� ���������������� ������ 15 ������� � EventAlerter';
{$ENDIF}

implementation

end.
  
