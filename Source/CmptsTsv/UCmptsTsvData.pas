unit UCmptsTsvData;

interface

{$I stbasis.inc}

uses Windows,Forms, Classes, Controls, IBDatabase, UMainUnited, stdctrls,
     daADPhysManager, 
     tsvSecurity;

var
  isInitAll: Boolean=false;
  TempStr: String;
  inistr: string;
  ListDesignPaletteHandles: TList;
  ListDesignPropertyTranslateHandles: TList;
  ListDesignPropertyRemoveHandles: TList;
  ListDesignPropertyEditorHandles: TList;
  ListDesignComponentEditorHandles: TList;
  ListDesignCodeTemplateHandles: TList;
  ListDesignFormTemplateHandles: TList;
  ListInterpreterConstHandles: TList;
  ListInterpreterClassHandles: TList;
  ListInterpreterFunHandles: TList;
  ListInterpreterEventHandles: TList;
  ListInterpreterVarHandles: TList;
  MainTypeLib: TTypeLib=ttleComponents;
  FSecurity: TTsvSecurity;
  
  IBDB: TIBDatabase;
  IBDBSec: TIBDatabase;
  IBT: TIBTransaction;

  // Handles
  hCodeTemplateViewInterface: THandle;

  
  hFormTemplateViewInterface: THandle;

const
  SKey='05BBB43B3D923283E0B6FFAFD088F41F'; // Components

  LibraryHint='���������� ����������� �����������. ���������� ��� '+
              '�������������� ����.';
  LibraryProgrammers='������� ������';            

  // Palette name and hint
  ConstDesignPaletteNameInterface='Interfaces';
  ConstDesignPaletteHintInterface='���������� ��� ������ � ������������';

  ConstDesignPaletteNameStandart='Standart';
  ConstDesignPaletteHintStandart='����������� ����������';

  ConstDesignPaletteNameAdditional='Additional';
  ConstDesignPaletteHintAdditional='�������������� ����������';

  ConstDesignPaletteNameWin32='Win32';
  ConstDesignPaletteHintWin32='��� 32-��������� Windows';

  ConstDesignPaletteNameSystem='System';
  ConstDesignPaletteHintSystem='��������� ����������';

  ConstDesignPaletteNameDialogs='Dialogs';
  ConstDesignPaletteHintDialogs='�������';

  ConstDesignPaletteNameDataControls='Database';
  ConstDesignPaletteHintDataControls='���������� ���� ������';

  ConstDesignPaletteNameInterBase='InterBase';
  ConstDesignPaletteHintInterBase='���������� ��� ��� ������ InterBase';

  ConstDesignPaletteNameHtml='Html';
  ConstDesignPaletteHintHtml='���������� Html';
  
  ConstDesignPaletteNameTsv='TSV';
  ConstDesignPaletteHintTsv='��������� ����������� ����������';

  ConstDesignPaletteNameFastReport='FastReport';
  ConstDesignPaletteHintFastReport='����������� �������';

  ConstDesignPaletteNameRX='RX';
  ConstDesignPaletteHintRX='���������� RX';

  ConstDesignPaletteNameIndy='Indy';
  ConstDesignPaletteHintIndy='���������� Indy';

  ConstDesignPaletteNameAbbrevia='Abbrevia';
  ConstDesignPaletteHintAbbrevia='���������� Abbrevia';

  ConstDesignPaletteNameAnyDac='AnyDac';
  ConstDesignPaletteHintAnyDac='���������� AnyDac';

  // Code Templates
  ConstDCTViewInterfaceName='����� ����������';
  ConstDCTViewInterfaceHint='������� ������� ����������';
  ConstDCTViewInterfaceCode=#13+'procedure ViewInterface;'+#13+
                            'begin'+#13+#13+
                            'end;'+#13;

  // From Template                            
  ConstDFTViewInterfaceName='������ �����';
  ConstDFTViewInterfaceHint='������ �����';
  ConstDFTViewInterfaceForm='object EmptyForm: TDesignForm'+#13+
                            '  Left = 0'+#13+
                            '  Top = 0'+#13+
                            '  Width = 350'+#13+
                            '  Height = 250'+#13+
                            '  Caption = ''������ �����'''+#13+
                            '  Color = clBtnFace'+#13+
                            '  Font.Charset = DEFAULT_CHARSET'+#13+
                            '  Font.Color = clWindowText'+#13+
                            '  Font.Height = -11'+#13+
                            '  Font.Name = ''MS Sans Serif'''+#13+
                            '  Font.Style = []'+#13+
                            '  Icon.Data = {'+#13+
                            '    0000010001001010100000000000280100001600000028000000100000002000'+#13+
                            '    00000100040000000000C0000000000000000000000000000000000000000000'+#13+
                            '    000000008000008000000080800080000000800080008080000080808000C0C0'+#13+
                            '    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000'+#13+
                            '    0000000000000000000000000000078888888888880007FFFFFFFFFFF80007FF'+#13+
                            '    00FF00FFF80007FF00FF00FFF80007FF00F000FFF80007FF00F000FFF80007FF'+#13+
                            '    000F00FFF80007FF000F00FFF80007FF00FF00FFF80007FF00FF00F0000007FF'+#13+
                            '    00FF00F7880007FFFFFFFFF7800007FFFFFFFFF700000777777777770000FFFF'+#13+
                            '    0000800100008001000080010000800100008001000080010000800100008001'+#13+
                            '    0000800100008001000080010000800100008003000080070000800F0000}'+#13+
                            '  OldCreateOrder = False'+#13+
                            '  Visible = True'+#13+
                            '  PixelsPerInch = 96'+#13+
                            '  TextHeight = 13'+#13+
                            'end';

  // Formats
  fmtSetCaption='%s (%s)';

  // Protocol Names
  ConstProtocolRes='res://';

implementation

initialization
  FSecurity:=TTsvSecurity.Create;
  FSecurity.Key:=SKey;

finalization
  FSecurity.Free;
  
end.
