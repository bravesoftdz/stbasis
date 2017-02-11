unit UIntrprTsvData;

interface

{$I stbasis.inc}

uses Windows, Forms, Classes, Controls, IBDatabase, UMainUnited, stdctrls,
     tsvInterpreterCore, Graphics, tsvSecurity;

type
  PInfoInterface=^TInfoInterface;
  TInfoInterface=packed record
    Interface_id: Integer;
    TypeInterface: TTypeInterface;
    Priority: Integer;
    hInterface: THandle;
    Name: String;
    isRunning: Boolean;
    hInterpreter: THandle;
  end;

  PInfoMenu=^TInfoMenu;
  TInfoMenu=packed record
    Menu_id: Integer;
    Interface_id: Integer;
    Parent_id: Integer;
    TypeInterface: Variant;
    hMenu: THandle;
    Name: string;
  end;

  PInfoToolbar=^TInfoToolbar;
  TInfoToolbar=packed record
    Toolbar_id: Integer;
    hToolbar: THandle;
    ListToolButtons: TList;
  end;

  PInfoToolButton=^TInfoToolButton;
  TInfoToolButton=packed record
    ToolButton_id: Integer;
    hToolButton: THandle;
    TypeInterface: Variant;
    Interface_id: Integer;
  end;

var
  isInitAll: Boolean=false;
  IBDB,IBDBSec: TIBDatabase;
  IBT,IBTSec: TIBTransaction;
  TempStr: String;
  inistr: string;
  MainTypeLib: TTypeLib=ttleInterpreter;
  FSecurity: TTsvSecurity;
  
  ListInterpreterHandles: TList;
  ListInterfaceHandles: TList;
  ListMenuHandles: Tlist;
  ListToolBarHandles: TList;
  ListInterpreterFunHandles: TList;

  // Handles
  hLibraryInterpreter: THandle;

const
  SKey='DF608EDB53FCC79C12759CDBDF58D9DB'; // Interpreter
  
  LibraryHint='���������� �������� ������������� PASCAL-�������� � ���������� ����.';
  LibraryProgrammers='������� ������';            
  LibraryInterpreterGUID='{0921F68E-E564-4172-A84A-5D6237FC32D5}';
  LibraryInterpreterHint='������������� PASCAL-��������';

  // Messages
  ConstInterpreterUnitPrepear='���������� � ���������� ������ ...';
  ConstInterpreterUnitRun='������ ������ ...';
  ConstInterpreterUnitExecuted='������ ������� ...';
  ConstInterpreterUnitSuccessEnd='������ ������� �������� ...';

  // Interfaces
  NameRbkQuery='������';

  // Db Objects
  tbInterface='interface';
  tbInterfaceForm='interfaceform';
  tbInterfaceDocument='interfacedocument';
  tbInterfacePermission='interfacepermission';
  tbMenu='menu';
  tbToolbar='toolbar';
  tbToolButton='toolbutton';

  // Formats
  fmtInterfaceNameMessage='��������� <%s>: %s';
  fmtDocumentNotFound='�������� <%s> �� ������.';

  ConstReturnInterface='ReturnInterface';


implementation

initialization
  FSecurity:=TTsvSecurity.Create;
  FSecurity.Key:=SKey;

finalization
  FSecurity.Free;
  
end.
