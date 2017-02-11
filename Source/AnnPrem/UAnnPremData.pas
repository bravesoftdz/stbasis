unit UAnnPremData;

interface

{$I stbasis.inc}

uses Windows, Forms, Classes, Controls, IBDatabase, UMainUnited, extctrls, Graphics,
     tsvSecurity;

type
  TTypeStaffTsvOptions=(tstoNone,tstoRBEmp);

var
  isInitAll: Boolean=false;
  IBDB,IBDBSec: TIBDatabase;
  IBT,IBTSec: TIBTransaction;
  TempStr: String;
  IniStr: String;
  MainTypeLib: TTypeLib=ttleDefault;
  FSecurity: TTsvSecurity;

  ListOptionHandles: TList;
  ListToolBarHandles: TList;
  ListInterfaceHandles: TList;
  ListMenuHandles: TList;

  // handles

  hInterfaceRbkAPTypePremises: THandle;
  hInterfaceRbkAPTypeInternet: THandle;
  hInterfaceRbkAPBuilder: THandle;
  hInterfaceRbkAPTypeWater: THandle;
  hInterfaceRbkAPTypeHeat: THandle;
  hInterfaceRbkAPTypeSanitary: THandle;
  hInterfaceRbkAPTown: THandle;
  hInterfaceRbkAPRegion: THandle;
  hInterfaceRbkAPStreet: THandle;
  hInterfaceRbkAPTypePhone: THandle;
  hInterfaceRbkAPCountRoom: THandle;
  hInterfaceRbkAPTypeBuilding: THandle;
  hInterfaceRbkAPTypeApartment: THandle;
  hInterfaceRbkAPPlanning: THandle;
  hInterfaceRbkAPTypeBalcony: THandle;
  hInterfaceRbkAPTypeGarage: THandle;
  hInterfaceRbkAPTypeBath: THandle;
  hInterfaceRbkAPTypeSewerage: THandle;
  hInterfaceRbkAPStyle: THandle;
  hInterfaceRbkAPUnitPrice: THandle;
  hInterfaceRbkAPTypeCondition: THandle;
  hInterfaceRbkAPTypePlate: THandle;
  hInterfaceRbkAPTypeFurniture: THandle;
  hInterfaceRbkAPTypeDoor: THandle;
  hInterfaceRbkAPHomeTech: THandle;
  hInterfaceRbkAPFieldView: THandle;
  hInterfaceRbkAPAgency: THandle;
  hInterfaceRbkAPOperation: THandle;
  hInterfaceRbkAPLandMark: THandle;
  hInterfaceRbkAPDirection: THandle;
  hInterfaceRbkAPRegionStreet: THandle;
  hInterfaceRbkAPPremises: THandle;
  hInterfaceSrvImportPremises: THandle;

  hMenuRBooks: THandle;
  hMenuRBooksPremises: THandle;
  hMenuData: THandle;
  hMenuOpts: THandle;
  hMenuRBooksAPTypePremises: THandle;
  hMenuRBooksAPTypeInternet: THandle;
  hMenuRBooksAPBuilder: THandle;
  hMenuRBooksAPTypeWater: THandle;
  hMenuRBooksAPTypeHeat: THandle;
  hMenuRBooksAPTypeSanitary: THandle;
  hMenuRBooksAPTown: THandle;
  hMenuRBooksAPRegion: THandle;
  hMenuRBooksAPStreet: THandle;
  hMenuRBooksAPTypePhone: THandle;
  hMenuRBooksAPCountRoom: THandle;
  hMenuRBooksAPTypeBuilding: THandle;
  hMenuRBooksAPTypeApartment: THandle;
  hMenuRBooksAPPlanning: THandle;
  hMenuRBooksAPTypeBalcony: THandle;
  hMenuRBooksAPTypeGarage: THandle;
  hMenuRBooksAPTypeBath: THandle;
  hMenuRBooksAPTypeSewerage: THandle;
  hMenuRBooksAPStyle: THandle;
  hMenuRBooksAPUnitPrice: THandle;
  hMenuRBooksAPTypeCondition: THandle;
  hMenuRBooksAPTypePlate: THandle;
  hMenuRBooksAPTypeFurniture: THandle;
  hMenuRBooksAPTypeDoor: THandle;
  hMenuRBooksAPHomeTech: THandle;
  hMenuRBooksAPFieldView: THandle;
  hMenuRBooksAPAgency: THandle;
  hMenuRBooksAPOperation: THandle;
  hMenuRBooksAPLandMark: THandle;
  hMenuRBooksAPDirection: THandle;
  hMenuRBooksAPRegionStreet: THandle;
  hMenuRBooksAPPremises: THandle;
  hMenuOptsPremises: THandle;
  hMenuSrvImportPremises: THandle;


  hOptionOperations: THandle;
  hOptionImport: THandle;

const
  SKey='2354539866DF32347AB2F18E07B821B8'; // Annprem

  LibraryHint='�������� ����������� � ������ ����������� ��� ������������ ���������� ��������� � �������������.';
  LibraryProgrammers='������� ������';            


  SColumns='�������';
  SField='����';
  SWidth='������';
  SAlias='�����';
  SFilter='������';
  SValue='��������';
  SFormatCaption='%s - %s';
  SInvalidValue='�������� ��������';
  SInvalidFormat='�������� ������';
  SSaveFieldView='��������� ������� �������������?';
  SExcelExtension='.xls';
  STextExtension='.txt';
  SPreviewImportFilter='����� Excel (*.xls)|*.xls|��������� ����� (*.txt)|*.txt';
  SPreviewFilter='XML ����� (*.xml)|*.xml';
  SPreviewRubricator='TXT ����� (*.txt)|*.txt';
  SPreviewDefaultExt='.xml';
  SPreviewRubricatorExt='.txt';
  SPreviewCaption='��������������� ��������';

  // Sections
  ConstSectionOptions='AnnPremOptions';

  // Interface Names

  ConstsMenuRBooksPremises='������������';
  ConstsMenuOptsPremises=ConstsMenuRBooksPremises;

  NameRbkAPTypePremises='���������� ����� ������������';
  NameRbkAPTypeInternet='���������� ����� ���������';
  NameRbkAPBuilder='���������� ������������';
  NameRbkAPTypeWater='���������� ����� �������������';
  NameRbkAPTypeHeat='���������� ����� ���������';
  NameRbkAPTypeSanitary='���������� ����� �������';
  NameRbkAPTown='���������� �������';
  NameRbkAPRegion='���������� �������';
  NameRbkAPStreet='���������� ����';
  NameRbkAPTypePhone='���������� ����� ��������';
  NameRbkAPCountRoom='���������� ���������� ������';
  NameRbkAPTypeBuilding='���������� ����� ����';
  NameRbkAPTypeApartment='���������� ����� ��������';
  NameRbkAPPlanning='���������� ����������';
  NameRbkAPTypeBalcony='���������� ����� �������';
  NameRbkAPTypeGarage='���������� ����� ������';
  NameRbkAPTypeBath='���������� ����� ����';
  NameRbkAPTypeSewerage='���������� ����� �����������';
  NameRbkAPStyle='���������� ������';
  NameRbkAPUnitPrice='���������� ������ ��������� ����';
  NameRbkAPTypeCondition='���������� ����� ���������';
  NameRbkAPTypePlate='���������� ����� �����';
  NameRbkAPTypeFurniture='���������� ����� ������';
  NameRbkAPTypeDoor='���������� ����� �����';
  NameRbkAPHomeTech='���������� ������� �������';
  NameRbkAPFieldView='���������� �������������';
  NameRbkAPAgency='���������� ��������';
  NameRbkAPOperation='���������� �������� � �������������';
  NameRbkAPLandMark='���������� ����������';
  NameRbkAPDirection='���������� �����������';
  NameRbkAPRegionStreet='���������� ���� �������';
  NameRbkAPPremises='���������� ������������';
  NameSrvImportPremises='������ ������������';
  NameRbkRelease='���������� ��������';

  // Db Objects

  tbUsers='USERS';
  tbAPTypePremises='AP_TYPE_PREMISES';
  tbAPTypeInternet='AP_TYPE_INTERNET';
  tbAPBuilder='AP_BUILDER';
  tbAPTypeWater='AP_TYPE_WATER';
  tbAPTypeHeat='AP_TYPE_HEAT';
  tbAPTypeSanitary='AP_TYPE_SANITARY';
  tbAPTown='AP_TOWN';
  tbAPRegion='AP_REGION';
  tbAPStreet='AP_STREET';
  tbAPTypePhone='AP_TYPE_PHONE';
  tbAPCountRoom='AP_COUNTROOM';
  tbAPTypeBuilding='AP_TYPE_BUILDING';
  tbAPTypeApartment='AP_TYPE_APARTMENT';
  tbAPPlanning='AP_PLANNING';
  tbAPTypeBalcony='AP_TYPE_BALCONY';
  tbAPTypeGarage='AP_TYPE_GARAGE';
  tbAPTypeBath='AP_TYPE_BATH';
  tbAPTypeSewerage='AP_TYPE_SEWERAGE';
  tbAPStyle='AP_STYLE';
  tbAPUnitPrice='AP_UNIT_PRICE';
  tbAPTypeCondition='AP_TYPE_CONDITION';
  tbAPTypePlate='AP_TYPE_PLATE';
  tbAPTypeFurniture='AP_TYPE_FURNITURE';
  tbAPTypeDoor='AP_TYPE_DOOR';
  tbAPHomeTech='AP_HOME_TECH';
  tbAPFieldView='AP_FIELD_VIEW';
  tbAPAgency='AP_AGENCY';
  tbAPOperation='AP_OPERATION';
  pCreateOperationTree='CREATE_OPERATION_TREE';
  tbAPLandMark='AP_LANDMARK';
  tbAPDirection='AP_DIRECTION';
  tbAPRegionStreet='AP_REGION_STREET';
  tbAPPremises='AP_PREMISES';
  tbRelease='"RELEASE"';

  // Sqls

  SQLSelectAPTable='SELECT * FROM %s %s ORDER BY PRIORITY';
  SQLRbkAPTypePremises='SELECT * FROM '+tbAPTypePremises+' ';
  SQLRbkAPTypeInternet='SELECT * FROM '+tbAPTypeInternet+' ';
  SQLRbkAPBuilder='SELECT * FROM '+tbAPBuilder+' ';
  SQLRbkAPTypeWater='SELECT * FROM '+tbAPTypeWater+' ';
  SQLRbkAPTypeHeat='SELECT * FROM '+tbAPTypeHeat+' ';
  SQLRbkAPTypeSanitary='SELECT * FROM '+tbAPTypeSanitary+' ';
  SQLRbkAPTown='SELECT * FROM '+tbAPTown+' ';
  SQLRbkAPRegion='SELECT * FROM '+tbAPRegion+' ';
  SQLRbkAPStreet='SELECT * FROM '+tbAPStreet+' ';
  SQLRbkAPTypePhone='SELECT * FROM '+tbAPTypePhone+' ';
  SQLRbkAPCountRoom='SELECT * FROM '+tbAPCountRoom+' ';
  SQLRbkAPTypeBuilding='SELECT * FROM '+tbAPTypeBuilding+' ';
  SQLRbkAPTypeApartment='SELECT * FROM '+tbAPTypeApartment+' ';
  SQLRbkAPPlanning='SELECT * FROM '+tbAPPlanning+' ';
  SQLRbkAPTypeBalcony='SELECT * FROM '+tbAPTypeBalcony+' ';
  SQLRbkAPTypeGarage='SELECT * FROM '+tbAPTypeGarage+' ';
  SQLRbkAPTypeBath='SELECT * FROM '+tbAPTypeBath+' ';
  SQLRbkAPTypeSewerage='SELECT * FROM '+tbAPTypeSewerage+' ';
  SQLRbkAPStyle='SELECT * FROM '+tbAPStyle+' ';
  SQLRbkAPUnitPrice='SELECT * FROM '+tbAPUnitPrice+' ';
  SQLRbkAPTypeCondition='SELECT * FROM '+tbAPTypeCondition+' ';
  SQLRbkAPTypePlate='SELECT * FROM '+tbAPTypePlate+' ';
  SQLRbkAPTypeFurniture='SELECT * FROM '+tbAPTypeFurniture+' ';
  SQLRbkAPTypeDoor='SELECT * FROM '+tbAPTypeDoor+' ';
  SQLRbkAPHomeTech='SELECT * FROM '+tbAPHomeTech+' ';
  SQLRbkAPFieldView='SELECT * FROM '+tbAPFieldView+' ';
  SQLRbkAPAgency='SELECT A.*, F.NAME AS FIELD_VIEW_NAME FROM '+tbAPAgency+' A LEFT JOIN '+
                 tbAPFieldView+' F ON A.AP_FIELD_VIEW_ID=F.AP_FIELD_VIEW_ID';
  SQLRbkAPOperation='SELECT O.*,F.NAME AS FIELD_VIEW_NAME,F.CONDITION FROM '+pCreateOperationTree+'(NULL,NULL) C JOIN '+
                    tbAPOperation+' O ON C.AP_OPERATION_ID=O.AP_OPERATION_ID LEFT JOIN '+
                    tbAPFieldView+' F ON F.AP_FIELD_VIEW_ID=O.AP_FIELD_VIEW_ID ';
  SQLRbkAPLandMark='SELECT * FROM '+tbAPLandMark+' ';
  SQLRbkAPDirection='SELECT * FROM '+tbAPDirection+' ';
  SQLRbkAPRegionStreet='SELECT RS.*, R.NAME AS REGION_NAME, S.NAME AS STREET_NAME FROM '+
                       tbAPRegionStreet+' RS JOIN '+
                       tbAPRegion+' R ON RS.AP_REGION_ID=R.AP_REGION_ID JOIN '+
                       tbAPStreet+' S ON RS.AP_STREET_ID=S.AP_STREET_ID ';
  SQLRbkAPPremises='SELECT P.AP_PREMISES_ID'+
                          ',P.AP_OPERATION_ID'+
                          ',P.DELIVERY_DATE'+
                          ',P.NN'+
                          ',P.PHONES AS PREMISES_PHONES'+
                          ',P.NAME AS PREMISES_NAME'+
                          ',P.AP_TOWN_ID'+
                          ',P.AP_REGION_ID'+
                          ',P.AP_LANDMARK_ID'+
                          ',D.AP_DIRECTION_ID'+
                          ',P.AP_STREET_ID'+
                          ',P.AP_COUNTROOM_ID'+
                          ',P.HOUSE'+
                          ',P.APARTMENT'+
                          ',P.FLOOR'+
                          ',P.FLOOR_COUNT'+
                          ',P.AP_TYPE_BUILDING_ID'+
                          ',P.GENERAL_AREA'+
                          ',P.DWELLING_AREA'+
                          ',P.KITCHEN_AREA'+
                          ',P.GROUND_AREA'+
                          ',P.NOTE'+
                          ',P.AP_AGENCY_ID'+
                          ',P.PRICE'+
                          ',P.AP_UNIT_PRICE_ID'+
                          ',P.PERIOD'+
                          ',P.PAYMENT_FOR'+
                          ',P.DELIVERY'+
                          ',P.AP_TYPE_INTERNET_ID'+
                          ',P.AP_TYPE_PREMISES_ID'+
                          ',P.AP_BUILDER_ID'+
                          ',P.AP_TYPE_DOOR_ID'+
                          ',P.AP_HOME_TECH_ID'+
                          ',P.AP_TYPE_FURNITURE_ID'+
                          ',P.AP_TYPE_GARAGE_ID'+
                          ',P.AP_TYPE_BATH_ID'+
                          ',P.AP_TYPE_SEWERAGE_ID'+
                          ',P.AP_TYPE_CONDITION_ID'+
                          ',P.AP_TYPE_PLATE_ID'+
                          ',P.AP_TYPE_WATER_ID'+
                          ',P.AP_TYPE_HEAT_ID'+
                          ',P.AP_TYPE_PHONE_ID'+
                          ',P.AP_TYPE_BALCONY_ID'+
                          ',P.AP_PLANNING_ID'+
                          ',P.AP_TYPE_APARTMENT_ID'+
                          ',P.AP_TYPE_SANITARY_ID'+
                          ',P.AP_STYLE_ID'+
                          ',P.WHO_INSERT_ID'+
                          ',P.WHEN_INSERT'+
                          ',P.WHO_UPDATE_ID'+
                          ',P.WHEN_UPDATE'+
                          ',P.RELEASE_ID'+
                          ',T.NAME AS TOWN_NAME'+
                          ',S.NAME AS STREET_NAME'+
                          ',R.NAME AS REGION_NAME'+
                          ',LM.NAME AS LANDMARK_NAME'+
                          ',D.NAME AS DIRECTION_NAME'+
                          ',CR.NAME AS COUNTROOM_NAME'+
                          ',TB.NAME AS TYPE_BUILDING_NAME'+
                          ',A.NAME AS AGENCY_NAME'+
                          ',UP.NAME AS UNIT_PRICE_NAME'+
                          ',TI.NAME AS TYPE_INTERNET_NAME'+
                          ',TP.NAME AS TYPE_PREMISES_NAME'+
                          ',B.NAME AS BUILDER_NAME'+
                          ',TD.NAME AS TYPE_DOOR_NAME'+
                          ',HT.NAME AS HOME_TECH_NAME'+
                          ',TF.NAME AS TYPE_FURNITURE_NAME'+
                          ',TG.NAME AS TYPE_GARAGE_NAME'+
                          ',TA.NAME AS TYPE_BATH_NAME'+
                          ',TS.NAME AS TYPE_SEWERAGE_NAME'+
                          ',TC.NAME AS TYPE_CONDITION_NAME'+
                          ',TL.NAME AS TYPE_PLATE_NAME'+
                          ',TW.NAME AS TYPE_WATER_NAME'+
                          ',TH.NAME AS TYPE_HEAT_NAME'+
                          ',TN.NAME AS TYPE_PHONE_NAME'+
                          ',TY.NAME AS TYPE_BALCONY_NAME'+
                          ',PL.NAME AS PLANNING_NAME'+
                          ',TT.NAME AS TYPE_APARTMENT_NAME'+
                          ',TR.NAME AS TYPE_SANITARY_NAME'+
                          ',ST.NAME AS STYLE_NAME'+
                          ',UI.NAME AS WHO_INSERT_NAME'+
                          ',UU.NAME AS WHO_UPDATE_NAME'+
                          ',RL.ABOUT AS RELEASE_ABOUT'+
                    ' FROM '+tbAPPremises+' P JOIN '+
                    tbUsers+' UI ON P.WHO_INSERT_ID=UI.USER_ID JOIN '+
                    tbUsers+' UU ON P.WHO_UPDATE_ID=UU.USER_ID JOIN '+
                    tbRelease+' RL ON P.RELEASE_ID=RL.RELEASE_ID LEFT JOIN '+
                    tbAPTown+' T ON P.AP_TOWN_ID=T.AP_TOWN_ID LEFT JOIN '+
                    tbAPStreet+' S ON P.AP_STREET_ID=S.AP_STREET_ID LEFT JOIN '+
                    tbAPAgency+' A ON P.AP_AGENCY_ID=A.AP_AGENCY_ID LEFT JOIN '+
                    tbAPRegion+' R ON P.AP_REGION_ID=R.AP_REGION_ID LEFT JOIN '+
                    tbAPLandMark+' LM ON P.AP_LANDMARK_ID=LM.AP_LANDMARK_ID LEFT JOIN '+
                    tbAPDirection+' D ON P.AP_DIRECTION_ID=D.AP_DIRECTION_ID LEFT JOIN '+
                    tbAPCountRoom+' CR ON P.AP_COUNTROOM_ID=CR.AP_COUNTROOM_ID LEFT JOIN '+
                    tbAPTypeBuilding+' TB ON P.AP_TYPE_BUILDING_ID=TB.AP_TYPE_BUILDING_ID LEFT JOIN '+
                    tbAPUnitPrice+' UP ON P.AP_UNIT_PRICE_ID=UP.AP_UNIT_PRICE_ID LEFT JOIN '+
                    tbAPTypeInternet+' TI ON P.AP_TYPE_INTERNET_ID=TI.AP_TYPE_INTERNET_ID LEFT JOIN '+
                    tbAPTypePremises+' TP ON P.AP_TYPE_PREMISES_ID=TP.AP_TYPE_PREMISES_ID LEFT JOIN '+
                    tbAPBuilder+' B ON P.AP_BUILDER_ID=B.AP_BUILDER_ID LEFT JOIN '+
                    tbAPTypeDoor+' TD ON P.AP_TYPE_DOOR_ID=TD.AP_TYPE_DOOR_ID LEFT JOIN '+
                    tbAPHomeTech+' HT ON P.AP_HOME_TECH_ID=HT.AP_HOME_TECH_ID LEFT JOIN '+
                    tbAPTypeFurniture+' TF ON P.AP_TYPE_FURNITURE_ID=TF.AP_TYPE_FURNITURE_ID LEFT JOIN '+
                    tbAPTypeGarage+' TG ON P.AP_TYPE_GARAGE_ID=TG.AP_TYPE_GARAGE_ID LEFT JOIN '+
                    tbAPTypeBath+' TA ON P.AP_TYPE_BATH_ID=TA.AP_TYPE_BATH_ID LEFT JOIN '+
                    tbAPTypeSewerage+' TS ON P.AP_TYPE_SEWERAGE_ID=TS.AP_TYPE_SEWERAGE_ID LEFT JOIN '+
                    tbAPTypeCondition+' TC ON P.AP_TYPE_CONDITION_ID=TC.AP_TYPE_CONDITION_ID LEFT JOIN '+
                    tbAPTypePlate+' TL ON P.AP_TYPE_PLATE_ID=TL.AP_TYPE_PLATE_ID LEFT JOIN '+
                    tbAPTypeWater+' TW ON P.AP_TYPE_WATER_ID=TW.AP_TYPE_WATER_ID LEFT JOIN '+
                    tbAPTypeHeat+' TH ON P.AP_TYPE_HEAT_ID=TH.AP_TYPE_HEAT_ID LEFT JOIN '+
                    tbAPTypePhone+' TN ON P.AP_TYPE_PHONE_ID=TN.AP_TYPE_PHONE_ID LEFT JOIN '+
                    tbAPTypeBalcony+' TY ON P.AP_TYPE_BALCONY_ID=TY.AP_TYPE_BALCONY_ID LEFT JOIN '+
                    tbAPPlanning+' PL ON P.AP_PLANNING_ID=PL.AP_PLANNING_ID LEFT JOIN '+
                    tbAPTypeApartment+' TT ON P.AP_TYPE_APARTMENT_ID=TT.AP_TYPE_APARTMENT_ID LEFT JOIN '+
                    tbAPTypeSanitary+' TR ON P.AP_TYPE_SANITARY_ID=TR.AP_TYPE_SANITARY_ID LEFT JOIN '+
                    tbAPStyle+' ST ON P.AP_STYLE_ID=ST.AP_STYLE_ID '
                   ;


implementation

initialization
  FSecurity:=TTsvSecurity.Create;
  FSecurity.Key:=SKey;

finalization
  FSecurity.Free;

end.
