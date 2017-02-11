unit UAnnPremCode;

interface

{$I stbasis.inc}

uses Windows, Forms, UAnnPremData, UMainUnited, Classes, UAnnPremDm, graphics, dialogs,
     IBDatabase, IBQuery, Controls, tsvHint, db, SysUtils, IBServices, stdctrls,
     comctrls, extctrls;

// Internal
procedure DeInitAll;
procedure ClearListInterfaceHandles;
procedure AddToListInterfaceHandles;
function ViewInterface(InterfaceHandle: THandle; Param: Pointer): Boolean; stdcall;
procedure ClearListMenuHandles;
procedure MenuClickProc(MenuHandle: THandle);stdcall;
procedure AddToListMenuRootHandles;
procedure ClearListToolBarHandles;
procedure ToolButtonClickProc(ToolButtonHandle: THandle);stdcall;
procedure AddToListToolBarHandles;
procedure ClearListOptionHandles;
procedure AddToListOptionRootHandles;
procedure BeforeSetOptionProc(OptionHandle: THandle);stdcall;
procedure AfterSetOptionProc(OptionHandle: THandle; isOk: Boolean);stdcall;
function isPermissionOnInterfaceView(InterfaceHandle: THandle): Boolean;

// Export
procedure InitAll_;stdcall;
procedure GetInfoLibrary_(P: PInfoLibrary);stdcall;
procedure RefreshLibrary_;stdcall;
procedure SetConnection_(IBDbase: TIBDatabase; IBTran: TIBTransaction;
                         IBDBSecurity: TIBDatabase; IBTSecurity: TIBTransaction);stdcall;

// Import

implementation

uses ActiveX,Menus,tsvDbGrid,dbtree,
     UAnnPremOptions,
     URBAPTypePremises, URBAPTypeInternet, URBAPBuilder, URBAPTypeWater,
     URBAPTypeHeat, URBAPTypeSanitary, URBAPTown, URBAPRegion, URBAPStreet,
     URBAPTypePhone, URBAPCountRoom, URBAPTypeBuilding, URBAPTypeApartment,
     URBAPPlanning, URBAPTypeBalcony, URBAPTypeGarage, URBAPTypeBath,
     URBAPTypeSewerage, URBAPStyle, URBAPUnitPrice, URBAPTypeCondition,
     URBAPTypePlate, URBAPTypeFurniture, URBAPTypeDoor, URBAPHomeTech,
     URBAPFieldView, URBAPAgency, URBAPOperation, URBAPLandMark, URBAPDirection,
     URBAPRegionStreet,
     URBAPPremises, USrvImportPremises,
     tsvSecurity;

//******************* Internal ************************

procedure InitAll_; stdcall;
begin
 try
  CoInitialize(nil);
  dm:=Tdm.Create(nil);
  fmOptions:=TfmOptions.Create(nil);

  ListInterfaceHandles:=TList.Create;
  AddToListInterfaceHandles;

  ListMenuHandles:=Tlist.Create;
  AddToListMenuRootHandles;

  ListOptionHandles:=TList.Create;
  AddToListOptionRootHandles;

  ListToolBarHandles:=TList.Create;
  AddToListToolBarHandles;

  isInitAll:=true;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure DeInitAll;
begin
 try
  if not isInitAll then exit;

  FreeAndNil(fmRBAPTypePremises);
  FreeAndNil(fmRBAPTypeInternet);
  FreeAndNil(fmRBAPBuilder);
  FreeAndNil(fmRBAPTypeWater);
  FreeAndNil(fmRBAPTypeHeat);
  FreeAndNil(fmRBAPTypeSanitary);
  FreeAndNil(fmRBAPTown);
  FreeAndNil(fmRBAPRegion);
  FreeAndNil(fmRBAPStreet);
  FreeAndNil(fmRBAPTypePhone);
  FreeAndNil(fmRBAPCountRoom);
  FreeAndNil(fmRBAPTypeBuilding);
  FreeAndNil(fmRBAPTypeApartment);
  FreeAndNil(fmRBAPPlanning);
  FreeAndNil(fmRBAPTypeBalcony);
  FreeAndNil(fmRBAPTypeGarage);
  FreeAndNil(fmRBAPTypeBath);
  FreeAndNil(fmRBAPTypeSewerage);
  FreeAndNil(fmRBAPStyle);
  FreeAndNil(fmRBAPUnitPrice);
  FreeAndNil(fmRBAPTypeCondition);
  FreeAndNil(fmRBAPTypePlate);
  FreeAndNil(fmRBAPTypeFurniture);
  FreeAndNil(fmRBAPTypeDoor);
  FreeAndNil(fmRBAPHomeTech);
  FreeAndNil(fmRBAPFieldView);
  FreeAndNil(fmRBAPAgency);
  FreeAndNil(fmRBAPOperation);
  FreeAndNil(fmRBAPLandMark);
  FreeAndNil(fmRBAPDirection);
  FreeAndNil(fmRBAPRegionStreet);
  FreeAndNil(fmRBAPPremises);
  FreeAndNil(fmSrvImportPremises);

  FreeAndNil(fmOptions);

  ClearListMenuHandles;
  ListMenuHandles.free;

  ClearListOptionHandles;
  ListOptionHandles.Free;

  ClearListToolBarHandles;
  ListToolBarHandles.Free;

  ClearListInterfaceHandles;
  ListInterfaceHandles.Free;

  dm.Free;
 except
//  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure ClearListToolBarHandles;
var
  i: Integer;
begin
  for i:=0 to ListToolBarHandles.Count-1 do begin
    _FreeToolBar(THandle(ListToolBarHandles.Items[i]));
  end;
  ListToolBarHandles.Clear;
end;

procedure ToolButtonClickProc(ToolButtonHandle: THandle);stdcall;
begin
{  if ToolButtonHandle=hToolButtonRelease then MenuClickProc(hMenuRBooksRelease);
  if ToolButtonHandle=hToolButtonKeyWords then MenuClickProc(hMenuRBooksKeyWords);
  if ToolButtonHandle=hToolButtonBlackList then MenuClickProc(hMenuRBooksBlackList);
  if ToolButtonHandle=hToolButtonTreeHeading then MenuClickProc(hMenuRBooksTreeHeading);
  if ToolButtonHandle=hToolButtonAnnouncement then MenuClickProc(hMenuOptsAnnouncement);
  if ToolButtonHandle=hToolButtonAnnouncementDubl then MenuClickProc(hMenuOptsAnnouncementDubl);
  if ToolButtonHandle=hToolButtonExport then MenuClickProc(hMenuRptsExport);
  if ToolButtonHandle=hToolButtonImport then MenuClickProc(hMenuOptsImport);}
end;

procedure AddToListToolBarHandles;

  function CreateToolBarLocal(Name,Hint: PChar;
                              ShortCut: TShortCut;
                              Visible: Boolean=true;
                              Position: TToolBarPosition=tbpTop): THandle;
  var
    CTBLocal: TCreateToolBar;
  begin
    FillChar(CTBLocal,SizeOf(TCreateToolBar),0);
    CTBLocal.Name:=Name;
    CTBLocal.Hint:=Hint;
    CTBLocal.ShortCut:=ShortCut;
    CTBLocal.Visible:=Visible;
    CTBLocal.Position:=Position;
    Result:=_CreateToolBar(@CTBLocal);
  end;

  function CreateToolButtonLocal(TH: THandle; Name,Hint: PChar;
                                 ImageIndex: Integer; Proc: TToolButtonClickProc=nil;
                                 Style: TToolButtonStyleEx=tbseButton;
                                 Control: TControl=nil): THandle;
  var
   CTBLocal: TCreateToolButton;
   Image: TBitmap;
  begin
   Image:=nil;
   try
    Result:=TOOLBUTTON_INVALID_HANDLE;
    Image:=TBitmap.Create;
    FillChar(CTBLocal,SizeOf(TCreateToolButton),0);
    CTBLocal.Name:=Name;
    CTBLocal.Hint:=Hint;
    dm.IL.GetBitmap(ImageIndex,Image);
    CTBLocal.Bitmap:=Image;
    CTBLocal.ToolButtonClickProc:=Proc;
    CTBLocal.Style:=Style;
    CTBLocal.Control:=Control;
    Result:=_CreateToolButton(TH,@CTBLocal);
   finally
     Image.Free;
   end;
  end;

{var
  tBar1: THandle;}
begin
  ListToolBarHandles.Clear;
{  if (hMenuRBooksRelease<>MENU_INVALID_HANDLE)or
     (hMenuRBooksKeyWords<>MENU_INVALID_HANDLE)or
     (hMenuRBooksBlackList<>MENU_INVALID_HANDLE)or
     (hMenuRBooksTreeHeading<>MENU_INVALID_HANDLE)or
     (hMenuOptsAnnouncement<>MENU_INVALID_HANDLE)or
     (hMenuOptsAnnouncementDubl<>MENU_INVALID_HANDLE)or
     (hMenuRptsExport<>MENU_INVALID_HANDLE) then begin
   tbar1:=CreateToolBarLocal('����������','������ ����������',0);
   ListToolBarHandles.Add(Pointer(tbar1));
   if hMenuRBooksRelease<>MENU_INVALID_HANDLE then
    hToolButtonRelease:=CreateToolButtonLocal(tbar1,'�������',NameRbkRelease,0,ToolButtonClickProc);
   if hMenuRBooksKeyWords<>MENU_INVALID_HANDLE then
    hToolButtonKeyWords:=CreateToolButtonLocal(tbar1,'�������� �����',NameRbkKeyWords,3,ToolButtonClickProc);
   if hMenuRBooksBlackList<>MENU_INVALID_HANDLE then
    hToolButtonBlackList:=CreateToolButtonLocal(tbar1,'����������',NameRbkBlackList,1,ToolButtonClickProc);
   if hMenuRBooksTreeHeading<>MENU_INVALID_HANDLE then
    hToolButtonTreeHeading:=CreateToolButtonLocal(tbar1,'������ ������',NameRbkTreeHeading,2,ToolButtonClickProc);
   if hMenuOptsAnnouncement<>MENU_INVALID_HANDLE then begin
    CreateToolButtonLocal(tbar1,'','',-1,nil,tbseSeparator);
    hToolButtonAnnouncement:=CreateToolButtonLocal(tbar1,'����������',NameRbkAnnouncement,4,ToolButtonClickProc);
   end;
   if hMenuOptsAnnouncementDubl<>MENU_INVALID_HANDLE then begin
    CreateToolButtonLocal(tbar1,'','',-1,nil,tbseSeparator);
    hToolButtonAnnouncementDubl:=CreateToolButtonLocal(tbar1,'����� ����������',NameRbkAnnouncementDubl,6,ToolButtonClickProc);
    CreateToolButtonLocal(tbar1,'','',-1,nil,tbseSeparator);
   end;
   if hMenuOptsImport<>MENU_INVALID_HANDLE then
    hToolButtonImport:=CreateToolButtonLocal(tbar1,'������',NameSrvImport,7,ToolButtonClickProc);
   if hMenuRptsExport<>MENU_INVALID_HANDLE then
    hToolButtonExport:=CreateToolButtonLocal(tbar1,'�������',NameRptExport,5,ToolButtonClickProc);
   _RefreshToolBar(tbar1);
  end;}
end;

procedure ClearListOptionHandles;
var
  i: Integer;
begin
  for i:=0 to ListOptionHandles.Count-1 do begin
    _FreeOption(THandle(ListOptionHandles.Items[i]));
  end;
  ListOptionHandles.Clear;
end;

procedure AddToListOptionRootHandles;

  function CreateOptionLocal(ParentHandle: THandle; Name: PChar;
                             ImageIndex: Integer): THandle;
  var
   OCLocal: TCreateOption;
   Image: TBitmap;
  begin
   Image:=nil;
   try
    Image:=TBitmap.Create;
    FillChar(OCLocal,SizeOf(TCreateOption),0);
    OCLocal.Name:=Name;
    OCLocal.BeforeSetOptionProc:=BeforeSetOptionProc;
    OCLocal.AfterSetOptionProc:=AfterSetOptionProc;
    if ImageIndex<>-1 then begin
     dm.IL.GetBitmap(ImageIndex,Image);
     OCLocal.Bitmap:=Image;
    end;
    Result:=_CreateOption(ParentHandle,@OCLocal);
   finally
     Image.Free;
   end;
  end;

begin
  ListOptionHandles.Clear;
  if isPermissionOnInterfaceView(hInterfaceSrvImportPremises) then begin
    hOptionOperations:=CreateOptionLocal(OPTION_ROOT_HANDLE,ConstOptionOperations,-1);
    ListOptionHandles.Add(Pointer(hOptionOperations));
    if hOptionOperations<>MENU_INVALID_HANDLE then begin
      hOptionImport:=CreateOptionLocal(hOptionOperations,NameSrvImportPremises,-1);
    end;
  end;
end;

procedure BeforeSetOptionProc(OptionHandle: THandle);stdcall;

  procedure BeforeSetOption;
  var
    wc: TWinControl;
  begin
    if OptionHandle=hOptionImport then begin
     wc:=FindControl(_GetOptionParentWindow(hOptionImport));
     if isValidPointer(wc) then begin
      fmOptions.pc.ActivePage:=fmOptions.tsSrvImport;
      fmOptions.pnSrvImport.Parent:=wc;
     end;
    end;
  end;

begin
  fmOptions.Visible:=true;
  fmOptions.LoadFromIni(OptionHandle);
  BeforeSetOption;
end;

procedure AfterSetOptionProc(OptionHandle: THandle; isOk: Boolean);stdcall;

  procedure AfterSetOption;
  begin
    if OptionHandle=hOptionImport then begin
      fmOptions.pnSrvImport.Parent:=fmOptions.tsSrvImport;
    end;
  end;

begin
   AfterSetOption;
  if isOK then fmOptions.SaveToIni(OptionHandle)
  else fmOptions.LoadFromIni(OptionHandle);
  fmOptions.Visible:=false;
end;

procedure ClearListMenuHandles;
var
  i: Integer;
begin
  for i:=0 to ListMenuHandles.Count-1 do begin
    _FreeMenu(THandle(ListMenuHandles.Items[i]));
  end;
  ListMenuHandles.Clear;
end;

procedure MenuClickProc(MenuHandle: THandle);stdcall;
var
  TPRBI: TParamRBookInterface;
  TPRI: TParamReportInterface;
  TPSI: TParamServiceInterface;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  FillChar(TPRI,SizeOf(TPRI),0);
  FillChar(TPSI,SizeOf(TPSI),0);

  if MenuHandle=hMenuRBooksAPTypePremises then ViewInterface(hInterfaceRbkAPTypePremises,@TPRBI);
  if MenuHandle=hMenuRBooksAPTypeInternet then ViewInterface(hInterfaceRbkAPTypeInternet,@TPRBI);
  if MenuHandle=hMenuRBooksAPBuilder then ViewInterface(hInterfaceRbkAPBuilder,@TPRBI);
  if MenuHandle=hMenuRBooksAPTypeWater then ViewInterface(hInterfaceRbkAPTypeWater,@TPRBI);
  if MenuHandle=hMenuRBooksAPTypeHeat then ViewInterface(hInterfaceRbkAPTypeHeat,@TPRBI);
  if MenuHandle=hMenuRBooksAPTypeSanitary then ViewInterface(hInterfaceRbkAPTypeSanitary,@TPRBI);
  if MenuHandle=hMenuRBooksAPTown then ViewInterface(hInterfaceRbkAPTown,@TPRBI);
  if MenuHandle=hMenuRBooksAPRegion then ViewInterface(hInterfaceRbkAPRegion,@TPRBI);
  if MenuHandle=hMenuRBooksAPStreet then ViewInterface(hInterfaceRbkAPStreet,@TPRBI);
  if MenuHandle=hMenuRBooksAPTypePhone then ViewInterface(hInterfaceRbkAPTypePhone,@TPRBI);
  if MenuHandle=hMenuRBooksAPCountRoom then ViewInterface(hInterfaceRbkAPCountRoom,@TPRBI);
  if MenuHandle=hMenuRBooksAPTypeBuilding then ViewInterface(hInterfaceRbkAPTypeBuilding,@TPRBI);
  if MenuHandle=hMenuRBooksAPTypeApartment then ViewInterface(hInterfaceRbkAPTypeApartment,@TPRBI);
  if MenuHandle=hMenuRBooksAPPlanning then ViewInterface(hInterfaceRbkAPPlanning,@TPRBI);
  if MenuHandle=hMenuRBooksAPTypeBalcony then ViewInterface(hInterfaceRbkAPTypeBalcony,@TPRBI);
  if MenuHandle=hMenuRBooksAPTypeGarage then ViewInterface(hInterfaceRbkAPTypeGarage,@TPRBI);
  if MenuHandle=hMenuRBooksAPTypeBath then ViewInterface(hInterfaceRbkAPTypeBath,@TPRBI);
  if MenuHandle=hMenuRBooksAPTypeSewerage then ViewInterface(hInterfaceRbkAPTypeSewerage,@TPRBI);
  if MenuHandle=hMenuRBooksAPStyle then ViewInterface(hInterfaceRbkAPStyle,@TPRBI);
  if MenuHandle=hMenuRBooksAPUnitPrice then ViewInterface(hInterfaceRbkAPUnitPrice,@TPRBI);
  if MenuHandle=hMenuRBooksAPTypeCondition then ViewInterface(hInterfaceRbkAPTypeCondition,@TPRBI);
  if MenuHandle=hMenuRBooksAPTypePlate then ViewInterface(hInterfaceRbkAPTypePlate,@TPRBI);
  if MenuHandle=hMenuRBooksAPTypeFurniture then ViewInterface(hInterfaceRbkAPTypeFurniture,@TPRBI);
  if MenuHandle=hMenuRBooksAPTypeDoor then ViewInterface(hInterfaceRbkAPTypeDoor,@TPRBI);
  if MenuHandle=hMenuRBooksAPHomeTech then ViewInterface(hInterfaceRbkAPHomeTech,@TPRBI);
  if MenuHandle=hMenuRBooksAPFieldView then ViewInterface(hInterfaceRbkAPFieldView,@TPRBI);
  if MenuHandle=hMenuRBooksAPAgency then ViewInterface(hInterfaceRbkAPAgency,@TPRBI);
  if MenuHandle=hMenuRBooksAPOperation then ViewInterface(hInterfaceRbkAPOperation,@TPRBI);
  if MenuHandle=hMenuRBooksAPLandMark then ViewInterface(hInterfaceRbkAPLandMark,@TPRBI);
  if MenuHandle=hMenuRBooksAPDirection then ViewInterface(hInterfaceRbkAPDirection,@TPRBI);
  if MenuHandle=hMenuRBooksAPRegionStreet then ViewInterface(hInterfaceRbkAPRegionStreet,@TPRBI);
  if MenuHandle=hMenuRBooksAPPremises then ViewInterface(hInterfaceRbkAPPremises,@TPRBI);

  if MenuHandle=hMenuSrvImportPremises then ViewInterface(hInterfaceSrvImportPremises,@TPSI);

end;

procedure AddToListMenuRootHandles;

  function CreateMenuLocal(ParentHandle: THandle; Name: PChar;
                           Hint: PChar;
                           TypeCreateMenu: TTypeCreateMenu=tcmAddLast;
                           InsertMenuHandle: THandle=MENU_INVALID_HANDLE;
                           ImageIndex: Integer=-1;
                           ShortCut: TShortCut=0;
                           Proc: TMenuClickProc=nil): THandle;
  var
   CMLocal: TCreateMenu;
   Image: TBitmap;
  begin
   Image:=nil;
   try
    Result:=MENU_INVALID_HANDLE;
    Image:=TBitmap.Create;
    FillChar(CMLocal,SizeOf(TCreateMenu),0);
    CMLocal.Name:=Name;
    CMLocal.Hint:=Hint;
    CMLocal.MenuClickProc:=Proc;
    CMLocal.ShortCut:=ShortCut;
    CMLocal.TypeCreateMenu:=TypeCreateMenu;
    CMLocal.InsertMenuHandle:=InsertMenuHandle;
    if ImageIndex<>-1 then begin
     dm.IL.GetBitmap(ImageIndex,Image);
     CMLocal.Bitmap:=Image;
    end;
    Result:=_CreateMenu(ParentHandle,@CMLocal);
   finally
     Image.Free;
   end;
  end;

var
  isFreeMenuRBooks: Boolean;
  isFreeMenuOpts: Boolean;
  isFreeMenuData: Boolean;
begin
  ListMenuHandles.Clear;

  hMenuRBooks:=CreateMenuLocal(MENU_ROOT_HANDLE,ConstsMenuRBooks,PChar(ChangeString(ConstsMenuRBooks,'&','')),
                               tcmInsertBefore,_GetMenuHandleFromName(MENU_ROOT_HANDLE,ConstsMenuService));
  ListMenuHandles.Add(Pointer(hMenuRBooks));

  hMenuRBooksPremises:=CreateMenuLocal(hMenuRBooks,ConstsMenuRBooksPremises,PChar(ChangeString(ConstsMenuRBooksPremises,'&','')),
                                       tcmAddFirst,0);
  hMenuRBooksAPTypePremises:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPTypePremises) then
    hMenuRBooksAPTypePremises:=CreateMenuLocal(hMenuRBooksPremises,'���� ������������',NameRbkAPTypePremises,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPTypeInternet:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPTypeInternet) then
    hMenuRBooksAPTypeInternet:=CreateMenuLocal(hMenuRBooksPremises,'��������',NameRbkAPTypeInternet,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPBuilder:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPBuilder) then
    hMenuRBooksAPBuilder:=CreateMenuLocal(hMenuRBooksPremises,'�����������',NameRbkAPBuilder,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPTypeWater:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPTypeWater) then
    hMenuRBooksAPTypeWater:=CreateMenuLocal(hMenuRBooksPremises,'�������������',NameRbkAPTypeWater,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPTypeHeat:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPTypeHeat) then
    hMenuRBooksAPTypeHeat:=CreateMenuLocal(hMenuRBooksPremises,'���������',NameRbkAPTypeHeat,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPTypeSanitary:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPTypeSanitary) then
    hMenuRBooksAPTypeSanitary:=CreateMenuLocal(hMenuRBooksPremises,'���. ����',NameRbkAPTypeSanitary,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPTown:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPTown) then
    hMenuRBooksAPTown:=CreateMenuLocal(hMenuRBooksPremises,'������',NameRbkAPTown,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPRegion:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPRegion) then
    hMenuRBooksAPRegion:=CreateMenuLocal(hMenuRBooksPremises,'������',NameRbkAPRegion,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPLandMark:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPLandMark) then
    hMenuRBooksAPLandMark:=CreateMenuLocal(hMenuRBooksPremises,'���������',NameRbkAPLandMark,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPDirection:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPDirection) then
    hMenuRBooksAPDirection:=CreateMenuLocal(hMenuRBooksPremises,'�����������',NameRbkAPDirection,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPRegionStreet:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPRegionStreet) then
    hMenuRBooksAPRegionStreet:=CreateMenuLocal(hMenuRBooksPremises,'����� �������',NameRbkAPRegionStreet,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPStreet:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPStreet) then
    hMenuRBooksAPStreet:=CreateMenuLocal(hMenuRBooksPremises,'�����',NameRbkAPStreet,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPTypePhone:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPTypePhone) then
    hMenuRBooksAPTypePhone:=CreateMenuLocal(hMenuRBooksPremises,'��������',NameRbkAPTypePhone,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPCountRoom:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPCountRoom) then
    hMenuRBooksAPCountRoom:=CreateMenuLocal(hMenuRBooksPremises,'�����������',NameRbkAPCountRoom,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPTypeBuilding:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPTypeBuilding) then
    hMenuRBooksAPTypeBuilding:=CreateMenuLocal(hMenuRBooksPremises,'���� �����',NameRbkAPTypeBuilding,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPTypeApartment:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPTypeApartment) then
    hMenuRBooksAPTypeApartment:=CreateMenuLocal(hMenuRBooksPremises,'���� ��������',NameRbkAPTypeApartment,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPPlanning:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPPlanning) then
    hMenuRBooksAPPlanning:=CreateMenuLocal(hMenuRBooksPremises,'����������',NameRbkAPPlanning,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPTypeBalcony:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPTypeBalcony) then
    hMenuRBooksAPTypeBalcony:=CreateMenuLocal(hMenuRBooksPremises,'�������',NameRbkAPTypeBalcony,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPTypeGarage:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPTypeGarage) then
    hMenuRBooksAPTypeGarage:=CreateMenuLocal(hMenuRBooksPremises,'������',NameRbkAPTypeGarage,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPTypeBath:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPTypeBath) then
    hMenuRBooksAPTypeBath:=CreateMenuLocal(hMenuRBooksPremises,'����',NameRbkAPTypeBath,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPTypeSewerage:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPTypeSewerage) then
    hMenuRBooksAPTypeSewerage:=CreateMenuLocal(hMenuRBooksPremises,'�����������',NameRbkAPTypeSewerage,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPStyle:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPStyle) then
    hMenuRBooksAPStyle:=CreateMenuLocal(hMenuRBooksPremises,'�����',NameRbkAPStyle,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPUnitPrice:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPUnitPrice) then
    hMenuRBooksAPUnitPrice:=CreateMenuLocal(hMenuRBooksPremises,'������� ���������',NameRbkAPUnitPrice,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPTypeCondition:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPTypeCondition) then
    hMenuRBooksAPTypeCondition:=CreateMenuLocal(hMenuRBooksPremises,'���������',NameRbkAPTypeCondition,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPTypePlate:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPTypePlate) then
    hMenuRBooksAPTypePlate:=CreateMenuLocal(hMenuRBooksPremises,'�����',NameRbkAPTypePlate,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPTypeFurniture:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPTypeFurniture) then
    hMenuRBooksAPTypeFurniture:=CreateMenuLocal(hMenuRBooksPremises,'������',NameRbkAPTypeFurniture,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPTypeDoor:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPTypeDoor) then
    hMenuRBooksAPTypeDoor:=CreateMenuLocal(hMenuRBooksPremises,'�����',NameRbkAPTypeDoor,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPHomeTech:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPHomeTech) then
    hMenuRBooksAPHomeTech:=CreateMenuLocal(hMenuRBooksPremises,'������� �������',NameRbkAPHomeTech,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPFieldView:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPFieldView) then
    hMenuRBooksAPFieldView:=CreateMenuLocal(hMenuRBooksPremises,'�������������',NameRbkAPFieldView,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPOperation:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPOperation) then
    hMenuRBooksAPOperation:=CreateMenuLocal(hMenuRBooksPremises,'��������',NameRbkAPOperation,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAPAgency:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPAgency) then
    hMenuRBooksAPAgency:=CreateMenuLocal(hMenuRBooksPremises,'���������',NameRbkAPAgency,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);

  hMenuData:=CreateMenuLocal(MENU_ROOT_HANDLE,ConstsMenuData,PChar(ChangeString(ConstsMenuData,'&','')),
                             tcmInsertBefore,hMenuRBooks);
  ListMenuHandles.Add(Pointer(hMenuData));
  hMenuRBooksAPPremises:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuRBooksAPPremises) then
    hMenuRBooksAPPremises:=CreateMenuLocal(hMenuData,'������������',NameRbkAPPremises,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);


  hMenuOpts:=CreateMenuLocal(MENU_ROOT_HANDLE,ConstsMenuOperations,PChar(ChangeString(ConstsMenuOperations,'&','')),
                             tcmInsertAfter,hMenuRBooks);
  ListMenuHandles.Add(Pointer(hMenuOpts));
  hMenuOptsPremises:=CreateMenuLocal(hMenuOpts,ConstsMenuOptsPremises,PChar(ChangeString(ConstsMenuOptsPremises,'&','')),
                                     tcmAddFirst,0);
  hMenuSrvImportPremises:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hMenuSrvImportPremises) then
    hMenuSrvImportPremises:=CreateMenuLocal(hMenuOptsPremises,'������ ������������',NameSrvImportPremises,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);

  isFreeMenuRBooks:=(hMenuRBooks<>MENU_INVALID_HANDLE)and
                    (hMenuRBooksPremises<>MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPTypePremises=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPTypeInternet=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPBuilder=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPTypeHeat=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPTypeWater=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPTypeSanitary=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPTown=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPRegion=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPStreet=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPLandMark=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPDirection=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPTypePhone=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPCountRoom=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPTypeBuilding=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPTypeApartment=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPPlanning=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPTypeBalcony=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPTypeGarage=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPTypeBath=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPTypeSewerage=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPStyle=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPUnitPrice=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPTypeCondition=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPTypePlate=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPTypeFurniture=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPTypeDoor=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPHomeTech=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPFieldView=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPAgency=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPOperation=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPRegionStreet=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAPRegionStreet=MENU_INVALID_HANDLE);
  if isFreeMenuRBooks then
    if _FreeMenu(hMenuRBooks) then hMenuRBooks:=MENU_INVALID_HANDLE;

  isFreeMenuOpts:=(hMenuOpts<>MENU_INVALID_HANDLE)and
                  (hMenuOptsPremises<>MENU_INVALID_HANDLE)and
                  (hMenuSrvImportPremises=MENU_INVALID_HANDLE);
  if isFreeMenuOpts then
    if _FreeMenu(hMenuOpts) then hMenuOpts:=MENU_INVALID_HANDLE;

  isFreeMenuData:=(hMenuData<>MENU_INVALID_HANDLE)and
                  (hMenuRBooksAPPremises=MENU_INVALID_HANDLE);
  if isFreeMenuData then
    if _FreeMenu(hMenuData) then hMenuData:=MENU_INVALID_HANDLE;

end;

procedure ClearListInterfaceHandles;
var
  i: Integer;
begin
  for i:=0 to ListInterfaceHandles.Count-1 do begin
    _FreeInterface(THandle(ListInterfaceHandles.Items[i]));
  end;
  ListInterfaceHandles.Clear;
end;

procedure AddToListInterfaceHandles;

  function CreateLocalInterface(Name,Hint: PChar; TypeInterface: TTypeInterface=ttiRBook): THandle;
  var
    TPCI: TCreateInterface;
  begin
    FillChar(TPCI,SizeOf(TCreateInterface),0);
    TPCI.Name:=Name;
    TPCI.Hint:=Hint;
    TPCI.ViewInterface:=ViewInterface;
    TPCI.TypeInterface:=TypeInterface;
    Result:=_CreateInterface(@TPCI);
    ListInterfaceHandles.Add(Pointer(Result));
  end;

  function CreateLocalPermission(InterfaceHandle: THandle;
                                 DBObject: PChar;
                                 DBPermission: TTypeDBPermission=ttpSelect;
                                 DBSystem: Boolean=false;
                                 Action: TTypeInterfaceAction=ttiaView): Boolean;
  var
     TCPFI: TCreatePermissionForInterface;
  begin
     FillCHar(TCPFI,SizeOf(TCreatePermissionForInterface),0);
     TCPFI.Action:=Action;
     TCPFI.DBObject:=DBObject;
     TCPFI.DBPermission:=DBPermission;
     TCPFI.DBSystem:=DBSystem;
     Result:=_CreatePermissionForInterface(InterfaceHandle,@TCPFI);
  end;


begin
  ListInterfaceHandles.Clear;

  hInterfaceRbkAPTypePremises:=CreateLocalInterface(NameRbkAPTypePremises,NameRbkAPTypePremises);
  CreateLocalPermission(hInterfaceRbkAPTypePremises,tbAPTypePremises,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPTypePremises,tbAPTypePremises,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPTypePremises,tbAPTypePremises,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPTypePremises,tbAPTypePremises,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPTypeInternet:=CreateLocalInterface(NameRbkAPTypeInternet,NameRbkAPTypeInternet);
  CreateLocalPermission(hInterfaceRbkAPTypeInternet,tbAPTypeInternet,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPTypeInternet,tbAPTypeInternet,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPTypeInternet,tbAPTypeInternet,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPTypeInternet,tbAPTypeInternet,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPBuilder:=CreateLocalInterface(NameRbkAPBuilder,NameRbkAPBuilder);
  CreateLocalPermission(hInterfaceRbkAPBuilder,tbAPBuilder,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPBuilder,tbAPBuilder,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPBuilder,tbAPBuilder,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPBuilder,tbAPBuilder,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPTypeWater:=CreateLocalInterface(NameRbkAPTypeWater,NameRbkAPTypeWater);
  CreateLocalPermission(hInterfaceRbkAPTypeWater,tbAPTypeWater,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPTypeWater,tbAPTypeWater,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPTypeWater,tbAPTypeWater,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPTypeWater,tbAPTypeWater,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPTypeHeat:=CreateLocalInterface(NameRbkAPTypeHeat,NameRbkAPTypeHeat);
  CreateLocalPermission(hInterfaceRbkAPTypeHeat,tbAPTypeHeat,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPTypeHeat,tbAPTypeHeat,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPTypeHeat,tbAPTypeHeat,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPTypeHeat,tbAPTypeHeat,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPTypeSanitary:=CreateLocalInterface(NameRbkAPTypeSanitary,NameRbkAPTypeSanitary);
  CreateLocalPermission(hInterfaceRbkAPTypeSanitary,tbAPTypeSanitary,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPTypeSanitary,tbAPTypeSanitary,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPTypeSanitary,tbAPTypeSanitary,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPTypeSanitary,tbAPTypeSanitary,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPTown:=CreateLocalInterface(NameRbkAPTown,NameRbkAPTown);
  CreateLocalPermission(hInterfaceRbkAPTown,tbAPTown,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPTown,tbAPTown,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPTown,tbAPTown,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPTown,tbAPTown,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPRegion:=CreateLocalInterface(NameRbkAPRegion,NameRbkAPRegion);
  CreateLocalPermission(hInterfaceRbkAPRegion,tbAPRegion,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPRegion,tbAPRegion,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPRegion,tbAPRegion,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPRegion,tbAPRegion,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPStreet:=CreateLocalInterface(NameRbkAPStreet,NameRbkAPStreet);
  CreateLocalPermission(hInterfaceRbkAPStreet,tbAPStreet,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPStreet,tbAPStreet,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPStreet,tbAPStreet,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPStreet,tbAPStreet,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPTypePhone:=CreateLocalInterface(NameRbkAPTypePhone,NameRbkAPTypePhone);
  CreateLocalPermission(hInterfaceRbkAPTypePhone,tbAPTypePhone,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPTypePhone,tbAPTypePhone,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPTypePhone,tbAPTypePhone,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPTypePhone,tbAPTypePhone,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPCountRoom:=CreateLocalInterface(NameRbkAPCountRoom,NameRbkAPCountRoom);
  CreateLocalPermission(hInterfaceRbkAPCountRoom,tbAPCountRoom,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPCountRoom,tbAPCountRoom,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPCountRoom,tbAPCountRoom,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPCountRoom,tbAPCountRoom,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPTypeBuilding:=CreateLocalInterface(NameRbkAPTypeBuilding,NameRbkAPTypeBuilding);
  CreateLocalPermission(hInterfaceRbkAPTypeBuilding,tbAPTypeBuilding,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPTypeBuilding,tbAPTypeBuilding,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPTypeBuilding,tbAPTypeBuilding,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPTypeBuilding,tbAPTypeBuilding,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPTypeApartment:=CreateLocalInterface(NameRbkAPTypeApartment,NameRbkAPTypeApartment);
  CreateLocalPermission(hInterfaceRbkAPTypeApartment,tbAPTypeApartment,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPTypeApartment,tbAPTypeApartment,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPTypeApartment,tbAPTypeApartment,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPTypeApartment,tbAPTypeApartment,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPPlanning:=CreateLocalInterface(NameRbkAPPlanning,NameRbkAPPlanning);
  CreateLocalPermission(hInterfaceRbkAPPlanning,tbAPPlanning,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPlanning,tbAPPlanning,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPPlanning,tbAPPlanning,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPPlanning,tbAPPlanning,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPTypeBalcony:=CreateLocalInterface(NameRbkAPTypeBalcony,NameRbkAPTypeBalcony);
  CreateLocalPermission(hInterfaceRbkAPTypeBalcony,tbAPTypeBalcony,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPTypeBalcony,tbAPTypeBalcony,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPTypeBalcony,tbAPTypeBalcony,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPTypeBalcony,tbAPTypeBalcony,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPTypeGarage:=CreateLocalInterface(NameRbkAPTypeGarage,NameRbkAPTypeGarage);
  CreateLocalPermission(hInterfaceRbkAPTypeGarage,tbAPTypeGarage,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPTypeGarage,tbAPTypeGarage,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPTypeGarage,tbAPTypeGarage,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPTypeGarage,tbAPTypeGarage,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPTypeBath:=CreateLocalInterface(NameRbkAPTypeBath,NameRbkAPTypeBath);
  CreateLocalPermission(hInterfaceRbkAPTypeBath,tbAPTypeBath,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPTypeBath,tbAPTypeBath,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPTypeBath,tbAPTypeBath,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPTypeBath,tbAPTypeBath,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPTypeSewerage:=CreateLocalInterface(NameRbkAPTypeSewerage,NameRbkAPTypeSewerage);
  CreateLocalPermission(hInterfaceRbkAPTypeSewerage,tbAPTypeSewerage,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPTypeSewerage,tbAPTypeSewerage,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPTypeSewerage,tbAPTypeSewerage,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPTypeSewerage,tbAPTypeSewerage,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPStyle:=CreateLocalInterface(NameRbkAPStyle,NameRbkAPStyle);
  CreateLocalPermission(hInterfaceRbkAPStyle,tbAPStyle,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPStyle,tbAPStyle,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPStyle,tbAPStyle,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPStyle,tbAPStyle,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPUnitPrice:=CreateLocalInterface(NameRbkAPUnitPrice,NameRbkAPUnitPrice);
  CreateLocalPermission(hInterfaceRbkAPUnitPrice,tbAPUnitPrice,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPUnitPrice,tbAPUnitPrice,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPUnitPrice,tbAPUnitPrice,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPUnitPrice,tbAPUnitPrice,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPTypeCondition:=CreateLocalInterface(NameRbkAPTypeCondition,NameRbkAPTypeCondition);
  CreateLocalPermission(hInterfaceRbkAPTypeCondition,tbAPTypeCondition,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPTypeCondition,tbAPTypeCondition,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPTypeCondition,tbAPTypeCondition,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPTypeCondition,tbAPTypeCondition,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPTypePlate:=CreateLocalInterface(NameRbkAPTypePlate,NameRbkAPTypePlate);
  CreateLocalPermission(hInterfaceRbkAPTypePlate,tbAPTypePlate,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPTypePlate,tbAPTypePlate,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPTypePlate,tbAPTypePlate,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPTypePlate,tbAPTypePlate,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPTypeFurniture:=CreateLocalInterface(NameRbkAPTypeFurniture,NameRbkAPTypeFurniture);
  CreateLocalPermission(hInterfaceRbkAPTypeFurniture,tbAPTypeFurniture,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPTypeFurniture,tbAPTypeFurniture,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPTypeFurniture,tbAPTypeFurniture,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPTypeFurniture,tbAPTypeFurniture,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPTypeDoor:=CreateLocalInterface(NameRbkAPTypeDoor,NameRbkAPTypeDoor);
  CreateLocalPermission(hInterfaceRbkAPTypeDoor,tbAPTypeDoor,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPTypeDoor,tbAPTypeDoor,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPTypeDoor,tbAPTypeDoor,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPTypeDoor,tbAPTypeDoor,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPHomeTech:=CreateLocalInterface(NameRbkAPHomeTech,NameRbkAPHomeTech);
  CreateLocalPermission(hInterfaceRbkAPHomeTech,tbAPHomeTech,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPHomeTech,tbAPHomeTech,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPHomeTech,tbAPHomeTech,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPHomeTech,tbAPHomeTech,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPFieldView:=CreateLocalInterface(NameRbkAPFieldView,NameRbkAPFieldView);
  CreateLocalPermission(hInterfaceRbkAPFieldView,tbAPFieldView,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPFieldView,tbAPFieldView,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPFieldView,tbAPFieldView,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPFieldView,tbAPFieldView,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPAgency:=CreateLocalInterface(NameRbkAPAgency,NameRbkAPAgency);
  CreateLocalPermission(hInterfaceRbkAPAgency,tbAPAgency,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPAgency,tbAPAgency,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPAgency,tbAPAgency,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPAgency,tbAPAgency,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPOperation:=CreateLocalInterface(NameRbkAPOperation,NameRbkAPOperation);
  CreateLocalPermission(hInterfaceRbkAPOperation,tbAPOperation,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPOperation,tbAPFieldView,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPOperation,tbAPOperation,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPOperation,tbAPOperation,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPOperation,tbAPOperation,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPLandMark:=CreateLocalInterface(NameRbkAPLandMark,NameRbkAPLandMark);
  CreateLocalPermission(hInterfaceRbkAPLandMark,tbAPLandMark,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPLandMark,tbAPLandMark,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPLandMark,tbAPLandMark,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPLandMark,tbAPLandMark,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPDirection:=CreateLocalInterface(NameRbkAPDirection,NameRbkAPDirection);
  CreateLocalPermission(hInterfaceRbkAPDirection,tbAPDirection,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPDirection,tbAPDirection,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPDirection,tbAPDirection,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPDirection,tbAPDirection,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPRegionStreet:=CreateLocalInterface(NameRbkAPRegionStreet,NameRbkAPRegionStreet);
  CreateLocalPermission(hInterfaceRbkAPRegionStreet,tbAPRegionStreet,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPRegionStreet,tbAPRegionStreet,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPRegionStreet,tbAPRegionStreet,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPRegionStreet,tbAPRegionStreet,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAPPremises:=CreateLocalInterface(NameRbkAPPremises,NameRbkAPPremises);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPPremises,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbUsers,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPTypePremises,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPTypeInternet,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPBuilder,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPTypeWater,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPTypeHeat,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPTypeSanitary,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPTown,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPRegion,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPStreet,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPTypePhone,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPCountRoom,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPTypeBuilding,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPTypeApartment,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPPlanning,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPTypeBalcony,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPTypeGarage,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPTypeBath,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPTypeSewerage,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPStyle,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPUnitPrice,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPTypeCondition,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPTypePlate,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPTypeFurniture,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPTypeDoor,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPHomeTech,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPFieldView,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPAgency,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPOperation,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPLandMark,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPDirection,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPRegionStreet,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,pCreateOperationTree,ttpExecute,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbRelease,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPPremises,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPPremises,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAPPremises,tbAPPremises,ttpDelete,false,ttiaDelete);

  hInterfaceSrvImportPremises:=CreateLocalInterface(NameSrvImportPremises,NameSrvImportPremises);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPPremises,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbUsers,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPTypePremises,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPTypeInternet,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPBuilder,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPTypeWater,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPTypeHeat,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPTypeSanitary,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPTown,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPRegion,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPStreet,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPTypePhone,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPCountRoom,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPTypeBuilding,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPTypeApartment,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPPlanning,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPTypeBalcony,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPTypeGarage,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPTypeBath,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPTypeSewerage,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPStyle,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPUnitPrice,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPTypeCondition,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPTypePlate,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPTypeFurniture,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPTypeDoor,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPHomeTech,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPFieldView,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPAgency,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPOperation,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPLandMark,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPDirection,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPRegionStreet,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbRelease,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,pCreateOperationTree,ttpExecute,false);
  CreateLocalPermission(hInterfaceSrvImportPremises,tbAPPremises,ttpInsert,false,ttiaAdd);

end;

function CreateAndViewTypePremises(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPTypePremises=nil then
       fmRBAPTypePremises:=TfmRBAPTypePremises.Create(Application);
     fmRBAPTypePremises.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPTypePremises;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPTypePremises.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPTypePremises,Param);
  end;
end;

function CreateAndViewTypeInternet(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPTypeInternet=nil then
       fmRBAPTypeInternet:=TfmRBAPTypeInternet.Create(Application);
     fmRBAPTypeInternet.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPTypeInternet;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPTypeInternet.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPTypeInternet,Param);
  end;
end;

function CreateAndViewBuilder(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPBuilder=nil then
       fmRBAPBuilder:=TfmRBAPBuilder.Create(Application);
     fmRBAPBuilder.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPBuilder;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPBuilder.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPBuilder,Param);
  end;
end;

function CreateAndViewTypeWater(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPTypeWater=nil then
       fmRBAPTypeWater:=TfmRBAPTypeWater.Create(Application);
     fmRBAPTypeWater.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPTypeWater;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPTypeWater.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPTypeWater,Param);
  end;
end;

function CreateAndViewTypeHeat(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPTypeHeat=nil then
       fmRBAPTypeHeat:=TfmRBAPTypeHeat.Create(Application);
     fmRBAPTypeHeat.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPTypeHeat;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPTypeHeat.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPTypeHeat,Param);
  end;
end;

function CreateAndViewTypeSanitary(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPTypeSanitary=nil then
       fmRBAPTypeSanitary:=TfmRBAPTypeSanitary.Create(Application);
     fmRBAPTypeSanitary.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPTypeSanitary;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPTypeSanitary.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPTypeSanitary,Param);
  end;
end;

function CreateAndViewTown(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPTown=nil then
       fmRBAPTown:=TfmRBAPTown.Create(Application);
     fmRBAPTown.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPTown;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPTown.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPTown,Param);
  end;
end;

function CreateAndViewRegion(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPRegion=nil then
       fmRBAPRegion:=TfmRBAPRegion.Create(Application);
     fmRBAPRegion.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPRegion;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPRegion.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPRegion,Param);
  end;
end;

function CreateAndViewStreet(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPStreet=nil then
       fmRBAPStreet:=TfmRBAPStreet.Create(Application);
     fmRBAPStreet.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPStreet;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPStreet.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPStreet,Param);
  end;
end;

function CreateAndViewTypePhone(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPTypePhone=nil then
       fmRBAPTypePhone:=TfmRBAPTypePhone.Create(Application);
     fmRBAPTypePhone.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPTypePhone;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPTypePhone.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPTypePhone,Param);
  end;
end;

function CreateAndViewCountRoom(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPCountRoom=nil then
       fmRBAPCountRoom:=TfmRBAPCountRoom.Create(Application);
     fmRBAPCountRoom.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPCountRoom;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPCountRoom.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPCountRoom,Param);
  end;
end;

function CreateAndViewTypeBuilding(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPTypeBuilding=nil then
       fmRBAPTypeBuilding:=TfmRBAPTypeBuilding.Create(Application);
     fmRBAPTypeBuilding.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPTypeBuilding;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPTypeBuilding.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPTypeBuilding,Param);
  end;
end;

function CreateAndViewTypeApartment(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPTypeApartment=nil then
       fmRBAPTypeApartment:=TfmRBAPTypeApartment.Create(Application);
     fmRBAPTypeApartment.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPTypeApartment;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPTypeApartment.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPTypeApartment,Param);
  end;
end;

function CreateAndViewPlanning(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPPlanning=nil then
       fmRBAPPlanning:=TfmRBAPPlanning.Create(Application);
     fmRBAPPlanning.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPPlanning;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPPlanning.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPPlanning,Param);
  end;
end;

function CreateAndViewTypeBalcony(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPTypeBalcony=nil then
       fmRBAPTypeBalcony:=TfmRBAPTypeBalcony.Create(Application);
     fmRBAPTypeBalcony.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPTypeBalcony;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPTypeBalcony.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPTypeBalcony,Param);
  end;
end;

function CreateAndViewTypeGarage(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPTypeGarage=nil then
       fmRBAPTypeGarage:=TfmRBAPTypeGarage.Create(Application);
     fmRBAPTypeGarage.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPTypeGarage;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPTypeGarage.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPTypeGarage,Param);
  end;
end;

function CreateAndViewTypeBath(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPTypeBath=nil then
       fmRBAPTypeBath:=TfmRBAPTypeBath.Create(Application);
     fmRBAPTypeBath.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPTypeBath;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPTypeBath.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPTypeBath,Param);
  end;
end;

function CreateAndViewTypeSewerage(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPTypeSewerage=nil then
       fmRBAPTypeSewerage:=TfmRBAPTypeSewerage.Create(Application);
     fmRBAPTypeSewerage.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPTypeSewerage;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPTypeSewerage.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPTypeSewerage,Param);
  end;
end;

function CreateAndViewStyle(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPStyle=nil then
       fmRBAPStyle:=TfmRBAPStyle.Create(Application);
     fmRBAPStyle.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPStyle;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPStyle.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPStyle,Param);
  end;
end;

function CreateAndViewUnitPrice(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPUnitPrice=nil then
       fmRBAPUnitPrice:=TfmRBAPUnitPrice.Create(Application);
     fmRBAPUnitPrice.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPUnitPrice;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPUnitPrice.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPUnitPrice,Param);
  end;
end;

function CreateAndViewTypeCondition(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPTypeCondition=nil then
       fmRBAPTypeCondition:=TfmRBAPTypeCondition.Create(Application);
     fmRBAPTypeCondition.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPTypeCondition;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPTypeCondition.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPTypeCondition,Param);
  end;
end;

function CreateAndViewTypePlate(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPTypePlate=nil then
       fmRBAPTypePlate:=TfmRBAPTypePlate.Create(Application);
     fmRBAPTypePlate.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPTypePlate;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPTypePlate.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPTypePlate,Param);
  end;
end;

function CreateAndViewTypeFurniture(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPTypeFurniture=nil then
       fmRBAPTypeFurniture:=TfmRBAPTypeFurniture.Create(Application);
     fmRBAPTypeFurniture.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPTypeFurniture;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPTypeFurniture.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPTypeFurniture,Param);
  end;
end;

function CreateAndViewTypeDoor(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPTypeDoor=nil then
       fmRBAPTypeDoor:=TfmRBAPTypeDoor.Create(Application);
     fmRBAPTypeDoor.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPTypeDoor;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPTypeDoor.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPTypeDoor,Param);
  end;
end;

function CreateAndViewHomeTech(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPHomeTech=nil then
       fmRBAPHomeTech:=TfmRBAPHomeTech.Create(Application);
     fmRBAPHomeTech.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPHomeTech;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPHomeTech.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPHomeTech,Param);
  end;
end;

function CreateAndViewFieldView(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPFieldView=nil then
       fmRBAPFieldView:=TfmRBAPFieldView.Create(Application);
     fmRBAPFieldView.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPFieldView;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPFieldView.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPFieldView,Param);
  end;
end;

function CreateAndViewAgency(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPAgency=nil then
       fmRBAPAgency:=TfmRBAPAgency.Create(Application);
     fmRBAPAgency.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPAgency;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPAgency.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPAgency,Param);
  end;
end;

function CreateAndViewOperation(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPOperation=nil then
       fmRBAPOperation:=TfmRBAPOperation.Create(Application);
     fmRBAPOperation.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPOperation;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPOperation.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPOperation,Param);
  end;
end;

function CreateAndViewLandMark(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPLandMark=nil then
       fmRBAPLandMark:=TfmRBAPLandMark.Create(Application);
     fmRBAPLandMark.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPLandMark;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPLandMark.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPLandMark,Param);
  end;
end;

function CreateAndViewDirection(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPDirection=nil then
       fmRBAPDirection:=TfmRBAPDirection.Create(Application);
     fmRBAPDirection.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPDirection;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPDirection.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPDirection,Param);
  end;
end;

function CreateAndViewRegionStreet(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPRegionStreet=nil then
       fmRBAPRegionStreet:=TfmRBAPRegionStreet.Create(Application);
     fmRBAPRegionStreet.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPRegionStreet;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPRegionStreet.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPRegionStreet,Param);
  end;
end;

function CreateAndViewPremises(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAPPremises=nil then
       fmRBAPPremises:=TfmRBAPPremises.Create(Application);
     fmRBAPPremises.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAPPremises;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAPPremises.Create(nil);
       fm.InitModalParams(InterfaceHandle,Param);
       if fm.ShowModal=mrOk then begin
        fm.ReturnModalParams(Param);
        Result:=true;
       end;
     finally
       fm.Free;
     end;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=false;
  case Param.Visual.TypeView of
    tviMdiChild: Result:=CreateAndViewAsMDIChild;
    tvibvModal: Result:=CreateAndViewAsModal;
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAPPremises,Param);
  end;
end;

function CreateAndViewSrvImportPremises(InterfaceHandle: THandle; Param: PParamServiceInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmSrvImportPremises=nil then
       fmSrvImportPremises:=TfmSrvImportPremises.Create(Application);
     fmSrvImportPremises.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=CreateAndViewAsMDIChild;
end;

function ViewInterface(InterfaceHandle: THandle; Param: Pointer): Boolean; stdcall;
begin
  Result:=false;

  // RBooks

  if InterfaceHandle=hInterfaceRbkAPTypePremises then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewTypePremises(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPTypeInternet then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewTypeInternet(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPBuilder then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewBuilder(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPTypeWater then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewTypeWater(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPTypeHeat then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewTypeHeat(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPTypeSanitary then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewTypeSanitary(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPTown then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewTown(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPRegion then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewRegion(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPStreet then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewStreet(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPTypePhone then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewTypePhone(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPCountRoom then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewCountRoom(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPTypeBuilding then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewTypeBuilding(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPTypeApartment then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewTypeApartment(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPPlanning then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewPlanning(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPTypeBalcony then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewTypeBalcony(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPTypeGarage then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewTypeGarage(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPTypeBath then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewTypeBath(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPTypeSewerage then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewTypeSewerage(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPStyle then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewStyle(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPUnitPrice then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewUnitPrice(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPTypeCondition then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewTypeCondition(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPTypePlate then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewTypePlate(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPTypeFurniture then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewTypeFurniture(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPTypeDoor then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewTypeDoor(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPHomeTech then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewHomeTech(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPFieldView then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewFieldView(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPAgency then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewAgency(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPOperation then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewOperation(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPLandMark then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewLandMark(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPDirection then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewDirection(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPRegionStreet then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewRegionStreet(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAPPremises then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewPremises(InterfaceHandle,Param);
  end;

  // Services

  if InterfaceHandle=hInterfaceSrvImportPremises then begin
    if not isValidPointer(Param,SizeOf(TParamServiceInterface)) then exit;
    Result:=CreateAndViewSrvImportPremises(InterfaceHandle,Param);
  end;
  
end;

function isPermissionOnInterfaceView(InterfaceHandle: THandle): Boolean;
var
  isRemove: Boolean;
begin
  isRemove:=false;
  if InterfaceHandle=hInterfaceRbkAPTypePremises then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPTypePremises)
    else if fmRBAPTypePremises<>nil then begin
     fmRBAPTypePremises.SetInterfaceHandle(InterfaceHandle);
     fmRBAPTypePremises.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPTypeInternet then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPTypeInternet)
    else if fmRBAPTypeInternet<>nil then begin
     fmRBAPTypeInternet.SetInterfaceHandle(InterfaceHandle);
     fmRBAPTypeInternet.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPBuilder then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPBuilder)
    else if fmRBAPBuilder<>nil then begin
     fmRBAPBuilder.SetInterfaceHandle(InterfaceHandle);
     fmRBAPBuilder.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPTypeWater then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPTypeWater)
    else if fmRBAPTypeWater<>nil then begin
     fmRBAPTypeWater.SetInterfaceHandle(InterfaceHandle);
     fmRBAPTypeWater.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPTypeHeat then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPTypeHeat)
    else if fmRBAPTypeHeat<>nil then begin
     fmRBAPTypeHeat.SetInterfaceHandle(InterfaceHandle);
     fmRBAPTypeHeat.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPTypeSanitary then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPTypeSanitary)
    else if fmRBAPTypeSanitary<>nil then begin
     fmRBAPTypeSanitary.SetInterfaceHandle(InterfaceHandle);
     fmRBAPTypeSanitary.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPTown then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPTown)
    else if fmRBAPTown<>nil then begin
     fmRBAPTown.SetInterfaceHandle(InterfaceHandle);
     fmRBAPTown.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPRegion then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPRegion)
    else if fmRBAPRegion<>nil then begin
     fmRBAPRegion.SetInterfaceHandle(InterfaceHandle);
     fmRBAPRegion.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPStreet then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPStreet)
    else if fmRBAPStreet<>nil then begin
     fmRBAPStreet.SetInterfaceHandle(InterfaceHandle);
     fmRBAPStreet.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPTypePhone then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPTypePhone)
    else if fmRBAPTypePhone<>nil then begin
     fmRBAPTypePhone.SetInterfaceHandle(InterfaceHandle);
     fmRBAPTypePhone.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPCountRoom then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPCountRoom)
    else if fmRBAPCountRoom<>nil then begin
     fmRBAPCountRoom.SetInterfaceHandle(InterfaceHandle);
     fmRBAPCountRoom.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPTypeBuilding then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPTypeBuilding)
    else if fmRBAPTypeBuilding<>nil then begin
     fmRBAPTypeBuilding.SetInterfaceHandle(InterfaceHandle);
     fmRBAPTypeBuilding.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPTypeApartment then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPTypeApartment)
    else if fmRBAPTypeApartment<>nil then begin
     fmRBAPTypeApartment.SetInterfaceHandle(InterfaceHandle);
     fmRBAPTypeApartment.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPPlanning then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPPlanning)
    else if fmRBAPPlanning<>nil then begin
     fmRBAPPlanning.SetInterfaceHandle(InterfaceHandle);
     fmRBAPPlanning.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPTypeBalcony then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPTypeBalcony)
    else if fmRBAPTypeBalcony<>nil then begin
     fmRBAPTypeBalcony.SetInterfaceHandle(InterfaceHandle);
     fmRBAPTypeBalcony.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPTypeGarage then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPTypeGarage)
    else if fmRBAPTypeGarage<>nil then begin
     fmRBAPTypeGarage.SetInterfaceHandle(InterfaceHandle);
     fmRBAPTypeGarage.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPTypeBath then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPTypeBath)
    else if fmRBAPTypeBath<>nil then begin
     fmRBAPTypeBath.SetInterfaceHandle(InterfaceHandle);
     fmRBAPTypeBath.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPTypeSewerage then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPTypeSewerage)
    else if fmRBAPTypeSewerage<>nil then begin
     fmRBAPTypeSewerage.SetInterfaceHandle(InterfaceHandle);
     fmRBAPTypeSewerage.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPStyle then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPStyle)
    else if fmRBAPStyle<>nil then begin
     fmRBAPStyle.SetInterfaceHandle(InterfaceHandle);
     fmRBAPStyle.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPUnitPrice then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPUnitPrice)
    else if fmRBAPUnitPrice<>nil then begin
     fmRBAPUnitPrice.SetInterfaceHandle(InterfaceHandle);
     fmRBAPUnitPrice.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPTypeCondition then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPTypeCondition)
    else if fmRBAPTypeCondition<>nil then begin
     fmRBAPTypeCondition.SetInterfaceHandle(InterfaceHandle);
     fmRBAPTypeCondition.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPTypePlate then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPTypePlate)
    else if fmRBAPTypePlate<>nil then begin
     fmRBAPTypePlate.SetInterfaceHandle(InterfaceHandle);
     fmRBAPTypePlate.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPTypeFurniture then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPTypeFurniture)
    else if fmRBAPTypeFurniture<>nil then begin
     fmRBAPTypeFurniture.SetInterfaceHandle(InterfaceHandle);
     fmRBAPTypeFurniture.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPTypeDoor then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPTypeDoor)
    else if fmRBAPTypeDoor<>nil then begin
     fmRBAPTypeDoor.SetInterfaceHandle(InterfaceHandle);
     fmRBAPTypeDoor.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPHomeTech then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPHomeTech)
    else if fmRBAPHomeTech<>nil then begin
     fmRBAPHomeTech.SetInterfaceHandle(InterfaceHandle);
     fmRBAPHomeTech.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPFieldView then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPFieldView)
    else if fmRBAPFieldView<>nil then begin
     fmRBAPFieldView.SetInterfaceHandle(InterfaceHandle);
     fmRBAPFieldView.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPAgency then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPAgency)
    else if fmRBAPAgency<>nil then begin
     fmRBAPAgency.SetInterfaceHandle(InterfaceHandle);
     fmRBAPAgency.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPLandMark then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPLandMark)
    else if fmRBAPLandMark<>nil then begin
     fmRBAPLandMark.SetInterfaceHandle(InterfaceHandle);
     fmRBAPLandMark.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPDirection then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPDirection)
    else if fmRBAPDirection<>nil then begin
     fmRBAPDirection.SetInterfaceHandle(InterfaceHandle);
     fmRBAPDirection.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPRegionStreet then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPRegionStreet)
    else if fmRBAPRegionStreet<>nil then begin
     fmRBAPRegionStreet.SetInterfaceHandle(InterfaceHandle);
     fmRBAPRegionStreet.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPOperation then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPOperation)
    else if fmRBAPOperation<>nil then begin
     fmRBAPOperation.SetInterfaceHandle(InterfaceHandle);
     fmRBAPOperation.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceRbkAPPremises then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmRBAPPremises)
    else if fmRBAPPremises<>nil then begin
     fmRBAPPremises.SetInterfaceHandle(InterfaceHandle);
     fmRBAPPremises.ActiveQuery(true);
    end;
  end;
  if InterfaceHandle=hInterfaceSrvImportPremises then begin
    isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
    if isRemove then FreeAndNil(fmSrvImportPremises)
    else if fmSrvImportPremises<>nil then begin
     fmSrvImportPremises.SetInterfaceHandle(InterfaceHandle);
    end;
  end;
  result:=not isRemove;
end;


//********************* end of Internal *****************


//********************* Export *************************

procedure GetInfoLibrary_(P: PInfoLibrary);stdcall;
begin
  if P=nil then exit;
  P.Hint:=LibraryHint;
  P.TypeLib:=MainTypeLib;
  P.Programmers:=LibraryProgrammers;

  FSecurity.LoadDb;
  P.StopLoad:=not FSecurity.Check([sctInclination,sctRunCount]);
  P.Condition:=PChar(FSecurity.Condition);
  FSecurity.DecRunCount;
  FSecurity.SaveDb;
end;

procedure SetConnection_(IBDbase: TIBDatabase; IBTran: TIBTransaction;
                         IBDBSecurity: TIBDatabase; IBTSecurity: TIBTransaction);stdcall;
begin
  IBDB:=IBDbase;
  IBT:=IBTran;
  IBDBSec:=IBDBSecurity;
  IBTSec:=IBTSecurity;
end;

procedure RefreshLibrary_;stdcall;
begin
 try
  Screen.Cursor:=crHourGlass;
  try
    ClearListInterfaceHandles;
    AddToListInterfaceHandles;

    ClearListMenuHandles;
    AddToListMenuRootHandles;

    ClearListOptionHandles;
    AddToListOptionRootHandles;

    FreeAndNil(fmOptions);
    fmOptions:=TfmOptions.Create(nil);
    fmOptions.ParentWindow:=Application.Handle;

    ClearListToolBarHandles;
    AddToListToolBarHandles;
  finally
    Screen.Cursor:=crDefault;
  end;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;


//**************** end of Export *************************

end.
