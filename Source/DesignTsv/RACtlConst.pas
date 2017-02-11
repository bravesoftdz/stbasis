{***********************************************************
                R&A Library
       Copyright (C) 1996-2000 R&A

       description : Language specific constants for Russian

       author      : Andrei Prygounkov
       e-mail      : a.prygounkov@gmx.de
       www         : http://ralib.hotbox.ru
************************************************************}

{$INCLUDE RA.INC}

unit RACtlConst;

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

   {RegAutoEditor}
  sRegAutoEditorEdtPropHint    = '��� �������� ����� ������ ����� �����';
  sRegAutoEditorTreeHint       = '��������� ��������';
  sRegAutoEditorListHint       = '������ ����������� �������';
  sRegAutoEditorBtnAddPropHint = '��������/������� ��������';
  sRegAutoEditorSort           = '�����������';

 {RAEditor}
  RAEditorCompletionChars = #8+'_0123456789QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm�������������������������������ި���������������������������������';

{IParser}
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

{$IFDEF RA_D2}
  SScrollBarRange = '�������� Scrollbar ����� �� ���������� �������';
{$ENDIF}

 {RADlg}
  SOk = 'OK';
  SCancel = '������';

 { Menu Designer }
  SMDMenuDesigner       = 'Menu &Designer';
  SMDInsertItem         = '&Insert';
  SMDDeleteItem         = '&Delete';
  SMDCreateSubmenuItem  = 'Create &SubMenu';

  SCantGetShortCut      = 'Target FileName for ShortCut %s not available';


 { RALib 1.23 } 
  SPropertyNotExists    = 'Property "%s" does not exists';
  SInvalidPropertyType  = 'Property "%s" has invalid type';

 { RALib 1.55 }

 {RAHLEdPropDlg}
  SHLEdPropDlg_Caption = '��������: ��������';
  SHLEdPropDlg_tsEditor = '��������';
  SHLEdPropDlg_tsColors = '�����';
  SHLEdPropDlg_lblEditorSpeedSettings = '����� ������� ������';
  SHLEdPropDlg_cbKeyboardLayotDefault = '����������� �����';
  SHLEdPropDlg_gbEditor = '��������� ���������:';
  SHLEdPropDlg_cbAutoIndent = '&����������';
  SHLEdPropDlg_cbSmartTab = '&����� ���';
  SHLEdPropDlg_cbBackspaceUnindents = '����� &�������� �����';
  SHLEdPropDlg_cbGroupUndo = '&��������� ������';
  SHLEdPropDlg_cbCursorBeyondEOF = '������ �� ����� &�����';
  SHLEdPropDlg_cbUndoAfterSave = '������ &����� ����������';
  SHLEdPropDlg_cbKeepTrailingBlanks = '��������� &����������� �������';
  SHLEdPropDlg_cbDoubleClickLine = '&������� ���� �������� ������';
  SHLEdPropDlg_cbSytaxHighlighting = '�������� &���������';
  SHLEdPropDlg_lblTabStops = '&�����������:';
  SHLEdPropDlg_lblColorSpeedSettingsFor = '����� ���';
  SHLEdPropDlg_lblElement = '&�������:';
  SHLEdPropDlg_lblColor = '&����:';
  SHLEdPropDlg_gbTextAttributes = '�������� ������:';
  SHLEdPropDlg_gbUseDefaultsFor = '�����������:';
  SHLEdPropDlg_cbBold = '&������';
  SHLEdPropDlg_cbItalic = '&���������';
  SHLEdPropDlg_cbUnderline = '&������������';
  SHLEdPropDlg_cbDefForeground = '&�����';
  SHLEdPropDlg_cbDefBackground = '&���';
  SHLEdPropDlg_OptionCantBeChanged = '���� �������� ������ ������. ��������.';
  SHLEdPropDlg_RAHLEditorNotAssigned = '�������� RAHLEditor �� ���������';
  SHLEdPropDlg_RegAutoNotAssigned = '�������� RegAuto �� ���������';

  { add by TSV}

  Const_ecLeft='�����';
  Const_ecRight='������';
  Const_ecUp='�����';
  Const_ecDown='����';
  Const_ecSelLeft='�������� �����';
  Const_ecSelRight='�������� ������';
  Const_ecSelUp='�������� �����';
  Const_ecSelDown='�������� ����';
  Const_ecBeginLine='�� ��������� �����';
  Const_ecSelBeginLine='�������� �� ��������� �����';
  Const_ecBeginDoc='� ������ ���������';
  Const_ecSelBeginDoc='�������� �� ������ ���������';
  Const_ecEndLine='�� ��������� �����';
  Const_ecSelEndLine='�������� �� ��������� �����';
  Const_ecEndDoc='� ����� ���������';
  Const_ecSelEndDoc='�������� �� ����� ���������';
  Const_ecPrevWord='���������� �����';
  Const_ecNextWord='��������� �����';
  Const_ecSelPrevWord='�������� ���������� �����';
  Const_ecSelNextWord='�������� ��������� �����';
  Const_ecSelAll='�������� ���';

  Const_ecWindowTop='���� �����';
  Const_ecWindowBottom='���� ����';
  Const_ecPrevPage='���������� ��������';
  Const_ecNextPage='��������� ��������';
  Const_ecSelPrevPage='�������� ���������� ��������';
  Const_ecSelNextPage='�������� ��������� ��������';
  Const_ecScrollLineUp='���������� ����� �����';
  Const_ecScrollLineDown='���������� ����� ����';

  Const_ecChangeInsertMode='������� �������� Insert';

  Const_ecInsertPara='������� �������';
  Const_ecBackspace='�����';
  Const_ecDelete='�������';
  Const_ecTab='���������';
  Const_ecBackTab='�������� ���������';
  Const_ecDeleteSelected='������� ����������';
  Const_ecClipboardCopy='���������� � �����';
  Const_ecClipboardCut='�������� � �����';
  Const_ecClipBoardPaste='�������� �� ������';

  Const_ecSetBookmark0='��������� �������� 0';
  Const_ecSetBookmark1='��������� �������� 1';
  Const_ecSetBookmark2='��������� �������� 2';
  Const_ecSetBookmark3='��������� �������� 3';
  Const_ecSetBookmark4='��������� �������� 4';
  Const_ecSetBookmark5='��������� �������� 5';
  Const_ecSetBookmark6='��������� �������� 6';
  Const_ecSetBookmark7='��������� �������� 7';
  Const_ecSetBookmark8='��������� �������� 8';
  Const_ecSetBookmark9='��������� �������� 9';

  Const_ecGotoBookmark0='������� � �������� 0';
  Const_ecGotoBookmark1='������� � �������� 1';
  Const_ecGotoBookmark2='������� � �������� 2';
  Const_ecGotoBookmark3='������� � �������� 3';
  Const_ecGotoBookmark4='������� � �������� 4';
  Const_ecGotoBookmark5='������� � �������� 5';
  Const_ecGotoBookmark6='������� � �������� 6';
  Const_ecGotoBookmark7='������� � �������� 7';
  Const_ecGotoBookmark8='������� � �������� 8';
  Const_ecGotoBookmark9='������� � �������� 9';

  Const_ecNonInclusiveBlock='�� ������������ ����';
  Const_ecInclusiveBlock='������������ ����';
  Const_ecColumnBlock='���������� ����';

  Const_ecUndo='������';

  Const_ecCompletionIdentifers='��������������';
  Const_ecCompletionTemplates='��������� ����';

  { cursor movement - default and classic }

  Const_ecDeleteWord='������� �����';
  Const_ecDeleteLine='������� �����';

  Const_ecSelWord='�������� �����';
  Const_ecToUpperCase='��������� � ������� �������';
  Const_ecToLowerCase='��������� � ������ �������';
  Const_ecChangeCase='�������� �������';
  Const_ecIndent='Indent';
  Const_ecUnindent='Unindent';

  Const_ecRecordMacro='RecordMacro';
  Const_ecPlayMacro='PlayMacro';

  Const_ecNewScript='����� ������';
  Const_ecOpenScript='������� ������';
  Const_ecSaveScript='��������� ������';
  Const_ecSaveScriptToBase='��������� ������ � ����';
  Const_ecRunScript='��������� ������';
  Const_ecStopScript='���������� ������';
  Const_ecResetScript='�������� ������';
  Const_ecCompileScript='������������� ������';
  Const_ecGotoLine='������� �� �����';
  Const_ecFind='�����';
  Const_ecFindNext='����� �����';
  Const_ecReplace='��������';
  Const_ecViewOption='���������';
  Const_ecViewForms='�������� �����';

  ConstReplaceText='�������� ���� ����� �� <%s>?';
  ConstReplaceConfirm='�������������';

  // Long operations
  ConstLongOperationExpandTabs='��������������';


implementation

end.

