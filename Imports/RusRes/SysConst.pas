{********************************************************}
{                                                        }
{       Borland Delphi Runtime Library                   }
{                                                        }
{       Copyright (C) 1995,99 Inprise Corporation        }
{                                                        }
{ ������������: 1999 Polaris Software                    }
{               http://members.xoom.com/PolarisSoft      }
{********************************************************}

unit SysConst;

interface

resourcestring
{$IFDEF VER130}
  SUnknown = '<����������>';
{$ENDIF}
  SInvalidInteger = '''%s'' - �������� ����� ��������';
  SInvalidFloat = '''%s'' - �������� ������� ��������';
  SInvalidDate = '''%s'' - �������� ����';
  SInvalidTime = '''%s'' - �������� �����';
  SInvalidDateTime = '''%s'' - �������� ���� � �����';
  STimeEncodeError = '�������� �������� ��� ������������ �������';
  SDateEncodeError = '�������� �������� ��� ������������ ����';
  SOutOfMemory = '�� ������� ������';
  SInOutError = '������ �����/������ %d';
  SFileNotFound = '���� �� ������';
  SInvalidFilename = '�������� ��� �����';
  STooManyOpenFiles = '������� ����� �������� ������';
  SAccessDenied = '� ������� � ����� ��������';
  SEndOfFile = '������ �� ���������� �����';
  SDiskFull = '���� �����';
  SInvalidInput = '�������� ���� �����';
  SDivByZero = '������� �� ����';
  SRangeError = '������ ������ �� ������� (Range check)';
  SIntOverflow = '������������ ������';
  SInvalidOp = '�������� �������� � �������� �������';
  SZeroDivide = '��������������� ������� �� ����';
  SOverflow = '��������������� ������������';
  SUnderflow = '��������������� ������ (underflow)';
  SInvalidPointer = '�������� �������� � ����������';
  SInvalidCast = '�������� ���������� ������';
  SAccessViolation = '��������� ������� �� ������ %p. %s �� ������ %p';
  SStackOverflow = '������������ �����';
  SControlC = '������� Control-C';
  SPrivilege = '����������������� ����������';
  SOperationAborted = '�������� ��������';
  SException = '�������������� �������� %s � ������ %s �� ������ %p.'#$0A'%s%s';
  SExceptTitle = '������ ����������';
  SInvalidFormat = '������ ''%s'' ������� ��� ����������� � ����������';
  SArgumentMissing = '��� ��������� ��� ������� ''%s''';
  SInvalidVarCast = '�������� �������������� ����������� ����';
  SInvalidVarOp = '�������� �������� � ���������';
  SDispatchError = '������ ���������� ������� �� ��������������';
  SReadAccess = '������';
  SWriteAccess = '������';
  SResultTooLong = '��������� �������������� �������, ��� 4096 ��������';
  SFormatTooLong = '������ ������� ������� �������';
  SVarArrayCreate = '������ �������� ����������� �������';
  SVarNotArray = '������� �� �������� ��������';
  SVarArrayBounds = '������ ����������� ������� ����� �� �������';
  SExternalException = '������� �������������� �������� %x';
  SAssertionFailed = 'Assertion failed';
  SIntfCastError = '��������� �� ��������������';
{$IFDEF VER130}
  SSafecallException = '�������������� �������� � safecall ������'; 
{$ENDIF}
  SAssertError = '%s (%s, ������ %d)';
  SAbstractError = '����������� ������';
  SModuleAccessViolation = '��������� ������� �� ������ %p � ������ ''%s''. %s �� ������ %p';
  SCannotReadPackageInfo = '�� ���� �������� ���������� ������ ��� ������ ''%s''';
  sErrorLoadingPackage = '�� ���� ��������� ����� %s.'#13#10'%s';
  SInvalidPackageFile = '�������� ���� ������ ''%s''';
  SInvalidPackageHandle = '�������� ���������� ������';
  SDuplicatePackageUnit = '�� ���� ��������� ����� ''%s''.  �� �������� ������ ''%s''' +
    ', ������� ����� ���������� � ������ ''%s''';
  SWin32Error = '������ Win32.  ���: %d.'#10'%s';
  SUnkWin32Error = '������ ������� Win32 API';
  SNL = '���������� �� ����� �������� �� ������������� ���� �����������';

  SShortMonthNameJan = '���';
  SShortMonthNameFeb = '���';
  SShortMonthNameMar = '���';
  SShortMonthNameApr = '���';
  SShortMonthNameMay = '���';
  SShortMonthNameJun = '���';
  SShortMonthNameJul = '���';
  SShortMonthNameAug = '���';
  SShortMonthNameSep = '���';
  SShortMonthNameOct = '���';
  SShortMonthNameNov = '���';
  SShortMonthNameDec = '���';

  SLongMonthNameJan = '������';
  SLongMonthNameFeb = '�������';
  SLongMonthNameMar = '����';
  SLongMonthNameApr = '������';
  SLongMonthNameMay = '���';
  SLongMonthNameJun = '����';
  SLongMonthNameJul = '����';
  SLongMonthNameAug = '������';
  SLongMonthNameSep = '��������';
  SLongMonthNameOct = '�������';
  SLongMonthNameNov = '������';
  SLongMonthNameDec = '�������';

  SShortDayNameSun = '���';
  SShortDayNameMon = '���';
  SShortDayNameTue = '���';
  SShortDayNameWed = '���';
  SShortDayNameThu = '���';
  SShortDayNameFri = '���';
  SShortDayNameSat = '���';

  SLongDayNameSun = '�����������';
  SLongDayNameMon = '�����������';
  SLongDayNameTue = '�������';
  SLongDayNameWed = '�����';
  SLongDayNameThu = '�������';
  SLongDayNameFri = '�������';
  SLongDayNameSat = '�������';

implementation

end.





