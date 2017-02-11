{***********************************************************
                R&A Library
       Copyright (C) 1996-2000 R&A

       description : Language specific constant for English

       author      : Andrei Prygounkov
       e-mail      : a.prygounkov@gmx.de
       www         : http://ralib.hotbox.ru
************************************************************}

{$INCLUDE RA.INC}

unit RAI2Const;

interface

const

{RAI2Parser}
 {$IFDEF RA_D}
  StIdSymbols      = ['_', '0'..'9', 'A'..'Z', 'a'..'z', '�'..'�', '�'..'�'];
  StIdFirstSymbols = ['_', 'A'..'Z', 'a'..'z', '�'..'�', '�'..'�'];
  StConstSymbols   = ['0'..'9', 'A'..'F', 'a'..'f'];
  StConstSymbols10 = ['0'..'9'];
  StSeparators     = ['(', ')', ',', '.', ';'];
 {$ENDIF RA_D}
 {$IFDEF RA_B}
  StIdSymbols      = '_0123456789QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm�������������������������������ި���������������������������������';
  StIdFirstSymbols = '_QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm�������������������������������ި���������������������������������';
  StConstSymbols   = '0123456789ABCDEFabcdef';
  StConstSymbols10 = '0123456789';
  StSeparators     = '(),.;';
 {$ENDIF RA_B}

 {RAI2Fm}
  SNoReportProc = '�� ������� ��������� "RAI2RunReportPreview"';
  SNoReportProc2 = '�� ������� ��������� "RAI2RunReportPreview2"';

 {RAI2 Error Descriptions}
  RAI2Errors : array [0..47] of
    record
      ID: Integer;
      Description: String;
    end
    = (
      (ID:   0; Description: 'Ok'),
      (ID:   1; Description: '����������� ������'),
      (ID:   2; Description: '���������� ������ ��������������: %s'),
      (ID:   3; Description: '�������� �������������'),
      (ID:   4; Description: 'Re-raising an exception only allowed in exception handler'),
      (ID:   5; Description: '������ � ������ ''%s'' �� ����� %d : %s'),
      (ID:   6; Description: '������� ������ � ������ ''%s'' �� ����� %d : %s'),
      (ID:   7; Description: '��� ������� � ''%s'''),
      (ID:  31; Description: '������ ''%s'' �� ����������'),

      (ID:  52; Description: '������������ �����'),
      (ID:  53; Description: '�������� ���'),
      (ID:  55; Description: '������� ''ViewInterface'' �� ����������'),
      (ID:  56; Description: '������ ''%s'' �� ������'),
      (ID:  57; Description: '������� ''%s'' �� ����������������'),
      (ID:  58; Description: '����� ''%s'' �� �������'),

      (ID: 101; Description: '������ � ���������'),
      (ID: 103; Description:'%s ���������(��), �� ������(�) %s'),
      (ID: 104; Description: '�� ��������� ������������� ''%s'''),
      (ID: 105; Description: '��� ��������� ������ ���� �����'),
      (ID: 106; Description: '��������� ��� ������'),
      (ID: 107; Description:' �� ����������� �� ����'),
      (ID: 108; Description: '��� ��������� ������ ���� �����'),
      (ID: 109; Description: '��������� ��� ������, ������ ��� �����'),
      (ID: 110; Description: '�� ������� ����� � �������'),
      (ID: 111; Description: '������������� �������� ����� ���: ''%s'''),

      (ID: 171; Description: '������ ������� ��� ��������'),
      (ID: 172; Description: '������� ������� ������� �������'),
      (ID: 173; Description: '�� ������� �������� �������'),
      (ID: 174; Description: '�������� ������ �������'),
      (ID: 175; Description: '�������� ������� �������'),
      (ID: 176; Description: '��������� ��� �������'),

      (ID: 181; Description: '������� ����� ����������� ����������'),
      (ID: 182; Description: '�� ������� ����������'),
      (ID: 183; Description: '������������� ����: ''%s'' � ''%s'''),
      (ID: 184; Description: '������ �������� ���������� ''%s'''),
      (ID: 185; Description: '�������� ��� ���������� � ���������� ������� ''%s'''),
      (ID: 186; Description: '�������� ��� ������������ �������� ''%s'''),
      (ID: 187; Description: '������ �������� ����� ��� ������� ''%s'''),
      (ID: 188; Description: '�������� ��� ���������� � ������ ������� ''%s'''),
      (ID: 189; Description: '�������� ��� �������� � ������ ������� ''%s'''),
      (ID: 190; Description: '�������� ���������� ��� ������ ������� ''%s'''),

      (ID: 201; Description: '����� ''%s'' ���������: ''%s'''),

      (ID: 301; Description: '���������'),
      (ID: 302; Description: '�������������'),
      (ID: 303; Description: '����������'),
      (ID: 304; Description: '����� �����'),
      (ID: 305; Description: '���������� ������'),

      (ID: 401; Description: '������ ''Implementation'' �� ������ � ������')
    );

implementation

end.
