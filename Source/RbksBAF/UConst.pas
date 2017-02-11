unit UConst;

interface
uses Forms, Classes, IBDatabase, UmainUnited, Windows;
type
  TTypeStaffBAFOptions=(tstoNone,tstoRBEmp);
var
  LERoot: Tlist; // �������� ��������� ����
  IBDB,IBDBSec: TIBDatabase;
  IBT,IBTSec: TIBTransaction;
  CurTable: String;
  TempStr: string;
  MainTypeLib: TTypeLib=ttleDefault;

  ListOptionsRoot: TList;

  ListInterfaceHandles: TList;
  ListMenuHandles: Tlist;

  hMenuRptsStaff: THandle;
  hMenuRpts: THandle;


  // handles of Rbooks Menu
  hMenuStaffRBooks: THandle;
  HMenuCountry: THandle;
  hMenuStreet: THandle;
  HMenuRegion: THandle;
  HMenuTown: THandle;
  HMenuPlacement: THandle;
  HMenuState: THandle;
  HMenuProf: THandle;
  HMenuNation: THandle;
  HMenuMotive: THandle;
  HMenuPersonDocType: THandle;
  HMenuSeat: THandle;
  hMenuTypeDoc: THandle;
  hMenuTypeLeave: THandle;
  hMenuBank: THandle;
  hMenuDocum: THandle;
  hMenuAccountType: THandle;
  hMenuDepart: THandle;
  hMenuExperiencePercent: THandle;
  hMenuStandartOperation: THandle;
  hMenuStOperation_AcType: THandle;
  hMenuRptPersCard_T2: THandle;
  hMenuRptsEducation: THandle;
  hMenuRptsMilRank: THandle;

  hMenuDelimetr: THandle;

  //handles of interface
  hInterfaceCountry: Thandle;
  hInterfaceStreet: THandle;
  hInterfaceRegion: THandle;
  hInterfaceTown: THandle;
  hInterfacePlacement: THandle;
  hInterfaceState: THandle;
  hInterFaceProf: THandle;
  hInterfaceNation: THandle;
  hInterfaceMotive: THandle;
  hInterfacePersonDocType: THandle;
  hInterfaceSeat: THandle;
  hInterfaceTypeDoc: THandle;
  hInterfaceTypeLeave: THandle;
  hInterfaceBank: THandle;
  hInterfaceDocum: THandle;
  hInterfaceAccountType: THandle;
  hInterfaceDepart: THandle;
  hInterfaceExperiencePercent: THandle;
  hInterfaceStandartOperation: THandle;
  hInterfaceStOperation_AcType: THandle;
  hInterfaceTypePay: THandle;

  hInterfaceRptPersCard_T2: THandle;
  hInterfaceRptsEducation: THandle;
  hInterfaceRptsMilRank: THandle;
const
  LibraryHint='�������� ����������� - "�����",'+#13+
              ' "����� ����", "���� �������� � ��������", '+#13+
              '"���� ������� � ���������� �������"';
  ConstEmptyField = '���� <%S> �� ����� ���� ������';
  ConstTypeEntry='te';
  ConstSectionShortCut='StaffBAFHotKeys';

  //names of Tables
  tbCountry='Country';
  tbRegion='Region';
  tbStreet='Street';
  tbtown='town';
  tbstate='State';
  tbplacement='placement';
  tbProf='Prof';
  tbPersonDocType='PersonDocType';
  tbNation='Nation';
  tbMotive='Motive';
  tbSeat='Seat';
  tbTypeDoc='TypeDoc';
  tbDepart='Depart';
  tbDocum='Docum';
  tbBank='Bank';
  tbTypeLeave='TypeLeave';
  tbexperiencepercent='experiencepercent';
  tbStandartoperation='Standartoperation';
  TbAccountType='AccountType';
  tbStOperation_AcType='STOPERATION_ACCOUNTTYPE';
  tbCalcPeriod='CalcPeriod';
  tbTypePay='TypePay';
  tbProfession='Profession';
  tbEmp='Emp';
  tbConst='Const';
  tbplant='Plant';
  tbSex='Sex';
  tbFamilyState='FamilyState';
  tbSchool='School';
  tbTypeStud='TypeStud';
  tbDiplom='Diplom';
  tbEduc='Educ';
  tbmilRank ='MilRank';
  tbmilitary='military'; 



  //captions
  NameCountry ='���������� �����';
  Nameregion= '���������� ����� � ��������';
  Namestreet='���������� ����';
  Nametown='���������� �������';
  Namestate='���������� �������';
  Nameplacement='���������� ��������� �������';
  NameProf='���������� ���������';
  NamePersonDocType='���������� ����� ���������� �������������� ��������';
  NameNation='���������� ���������������';
  NameMotive='���������� ������ ����������';
  NameSeat='���������� ����������';
  NameTypeDoc='���������� ����� ����������';
  NameDepart='���������� �������';
  NameDocum='���������� ����������';
  NameBank='���������� ������';
  NameTypeLeave='���������� ����� ��������';
  NameWizJobAccept='�������� �������� �� ������';
  Nameexperiencepercent='�������� �� �����';
  NameStandartoperation='���������� ����������� ��������';
  NameAccountType='���� ������������� ��������';
  NameStOperation_AccountType='�������� �������� - ���� ��������';
  NameCalcPeriod='��������� �������';
  NameTypePay='���������� ����� ������ �� �����';


  NameRptsPersCard_T2='������ ��������';
  NameRptsEducation = '������ �� �����������';
  NameRptsMilRank = '����� �� �������� �������';

  //from Sergey
  NameRbkEmp='���������� �����������';
  NameRbkConsts='���������� ��������';
  NameRbkTypeStud='���������� ����� ��������';
  NameRbkEduc='���������� ����� �����������';
  NameRbkProfession='���������� �������������� �� �������';
  NameRbkMilrank='���������� �������� ������';
  NameRbkPlant='���������� ������������';
  //SQL

  SQLRbkCountry='Select * from '+tbCountry;
  SQLRbkStreet='Select * from '+tbStreet;
  SQLRbkRegion='Select * from '+tbregion;
  SQlTown='Select * from '+tbtown;
  SQlstate='Select * from '+tbState;
  SQLplacement='Select * from '+tbPlacement;
  SQlProf='Select * from '+tbProf;
  SQlPersonDocType='Select * from '+tbPersonDocType;
  SQlNation='Select * from '+tbNation;
  SQlMotive='Select * from '+tbMotive;
  SQlSeat='Select * from '+tbSeat;
  SQlTypeDoc='Select * from '+tbTypeDoc;
  SQlDocum='Select * from '+tbDocum;
  SQLDepart='Select * from '+tbDepart;
  SQlBank='Select * from '+tbBank;
  SQlTypeLeave='Select * from '+tbTypeLeave;
  SQlexperiencepercent='Select tp.Name, exp.* from '+tbexperiencepercent+' exp join TypePay tp';
  SQlStandartoperation='Select * from '+tbStandartoperation;
  SQlAccountType='Select * from '+tbAccountType;
  SQlStOperation_AcType='Select * from '+tbStOperation_AcType;

//  'Select * from '+tbTypeLive='TypeLive';
implementation

end.
