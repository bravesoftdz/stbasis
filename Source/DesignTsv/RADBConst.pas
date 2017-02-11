{***********************************************************
                R&A Library
       Copyright (C) 1996-2000 R&A

       description : Language specific constants for Russian

       author      : Andrei Prygounkov
       e-mail      : a.prygounkov@gmx.de
       www         : http://ralib.hotbox.ru
************************************************************}

{$INCLUDE RA.INC}

unit RADBConst;

interface

const

 {TRADBTreeView}
  SDeleteNode             = '������� %s ?';
  SDeleteNode2            = '������� %s (������ �� ���� ����������) ?';
  SMasterFieldEmpty       = '"MasterField" property must be filled';
  SDetailFieldEmpty       = '"DetailField" property must be filled';
  SItemFieldEmpty         = '"ItemField" property must be filled';
  SMasterDetailFieldError = '"MasterField" and "DetailField" must be of same type';
  SMasterFieldError       = '"MasterField" must be integer type';
  SDetailFieldError       = '"DetailField" must be integer type';
  SItemFieldError         = '"ItemField" must be string, date or integer type';
  SIconFieldError         = '"IconField" must be integer type';
  SMoveToModeError        = '�������� ����� ����������� RADBTreeNode';
  SDataSetNotActive       = 'DataSet not active';

implementation

end.

