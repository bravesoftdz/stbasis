unit UPms_United;

interface

{$I stbasis.inc}

uses Classes;

var
  cnppNN,cnppWaterName,cnppHeatName,cnppStyleName,
  cnppDateArrivals,cnppRegionName,{}cnppCityRegionName{},cnppStreetName,cnppHouseNumber,cnppApartmentNumber,
  cnppCountRoomName,cnppTypeRoomName,cnppPlanningName,cnppPhoneName,cnppSaleStatusName,
  cnppDocumentName,cnppFloor,cnppCountFloor,cnppTypeHouseName,cnppGeneralArea,
  cnppDwellingArea,cnppgroundArea,
  cnppKitchenArea,cnppBalconyName,cnppConditionName,cnppStoveName,cnppSanitaryNodeName,
  cnppSelfFormName,cnppTypePremises,cnppPrice,cnppUnitPriceName,cnppNote,{by BART} cnppAdvertismentNote {by BART},cnppContact,
  cnppClientInfo,cnppAgentName,cnppStationName,cnppDateTimeInsert,cnppWhoInsertName,
  cnppDateTimeUpdate,cnppWhoUpdateName,cnppDateRecyledOut,cnppFurnitureName,cnppTerm,
  cnppPayment,cnppTypePremisesname,cnppDoorName,cnppPriceUnitPrice,cnppContactClientInfo,
  cnppFloorCountFloorTypeHouseName,cnppGeneralDwellingKitchenArea,cnppPaymentTerm,
  cnppBuilderName,cnppDelivery,cnppPrice2, cnppDecoration,cnppGlassy,cnppBlockSection


  : Integer;

  function GetColumnPremisesName(Index: Integer): string;


implementation

var
  ColumnsPremises: TStringList;

  function GetColumnPremisesName(Index: Integer): string;
  begin
    Result:='';
    if (Index>=0)or(Index<=ColumnsPremises.Count-1) then
      Result:=ColumnsPremises.Strings[Index];
  end;

  function AddToColumnsPremises(Name: String): Integer;
  begin
    Result:=ColumnsPremises.Add(Name);
  end;


initialization
  ColumnsPremises:=TStringList.Create;
  cnppDateArrivals:=AddToColumnsPremises('���� �����������');
  cnppRegionName:=AddToColumnsPremises('�����');
 {by BART} cnppCityRegionName:=AddToColumnsPremises('����� ������');  {byBaRT}
  cnppStreetName:=AddToColumnsPremises('�����');
  cnppHouseNumber:=AddToColumnsPremises('���');
  cnppApartmentNumber:=AddToColumnsPremises('��������');
  cnppCountRoomName:=AddToColumnsPremises('���������� ������');
  cnppTypeRoomName:=AddToColumnsPremises('��� ������');
  cnppPlanningName:=AddToColumnsPremises('����������');
  cnppPhoneName:=AddToColumnsPremises('�������');
  cnppSaleStatusName:=AddToColumnsPremises('������ �������');
  cnppDocumentName:=AddToColumnsPremises('���������');
  cnppFloor:=AddToColumnsPremises('����');
  cnppCountFloor:=AddToColumnsPremises('���������');
  cnppTypeHouseName:=AddToColumnsPremises('��� ����');
  cnppGeneralArea:=AddToColumnsPremises('����� �������');
  cnppDwellingArea:=AddToColumnsPremises('����� �������');
  cnppKitchenArea:=AddToColumnsPremises('������� �����');
  cnppBalconyName:=AddToColumnsPremises('������');
  cnppConditionName:=AddToColumnsPremises('������');
  cnppStoveName:=AddToColumnsPremises('�����');
  cnppSanitaryNodeName:=AddToColumnsPremises('�������');
  cnppSelfFormName:=AddToColumnsPremises('����� �������������');
  cnppTypePremises:=AddToColumnsPremises('��� ������������');
  cnppPrice:=AddToColumnsPremises('����');
  cnppUnitPriceName:=AddToColumnsPremises('������� ��������� ����');
  cnppNote:=AddToColumnsPremises('����������');
  cnppAdvertismentNote:=AddToColumnsPremises('���������� ��� �������');
  cnppContact:=AddToColumnsPremises('�������');
  cnppClientInfo:=AddToColumnsPremises('������');
  cnppAgentName:=AddToColumnsPremises('�����');
  cnppStationName:=AddToColumnsPremises('������ ���������');
  cnppDateTimeInsert:=AddToColumnsPremises('���� � ����� �����');
  cnppWhoInsertName:=AddToColumnsPremises('��� ����');
  cnppDateTimeUpdate:=AddToColumnsPremises('���� � ����� ���������');
  cnppWhoUpdateName:=AddToColumnsPremises('��� �������');
  cnppDateRecyledOut:=AddToColumnsPremises('���� ���������� �� �������');
  cnppFurnitureName:=AddToColumnsPremises('������');
  cnppTerm:=AddToColumnsPremises('����');
  cnppPayment:=AddToColumnsPremises('������ ��');
  cnppTypePremisesname:=AddToColumnsPremises('��� ������������');
  cnppDoorName:=AddToColumnsPremises('�����');
  cnppPriceUnitPrice:=AddToColumnsPremises('���� � ������� ���������');
  cnppContactClientInfo:=AddToColumnsPremises('������� � ������');
  cnppFloorCountFloorTypeHouseName:=AddToColumnsPremises('����/��������� ��� ����');
  cnppGeneralDwellingKitchenArea:=AddToColumnsPremises('������� �����/�����/�����');
  cnppPaymentTerm:=AddToColumnsPremises('������ ��/����');
  cnppNN:=AddToColumnsPremises('��');
  cnppgroundArea:=AddToColumnsPremises('������� ���.�������');
  cnppWaterName:=AddToColumnsPremises('�������������');
  cnppHeatName:=AddToColumnsPremises('���������');
  cnppStyleName:=AddToColumnsPremises('�����');
  cnppBuilderName:=AddToColumnsPremises('����������');
  cnppDelivery:=AddToColumnsPremises('�����');
  cnppPrice2:=AddToColumnsPremises('���� �� �2');
  cnppDecoration:=AddToColumnsPremises('�������');
  cnppGlassy:=AddToColumnsPremises('����������');
  cnppBlockSection:=AddToColumnsPremises('���� ������');

finalization
  ColumnsPremises.Free;

end.
