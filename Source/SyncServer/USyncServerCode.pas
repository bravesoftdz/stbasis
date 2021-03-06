unit USyncServerCode;

interface

{$I stbasis.inc}

uses Windows, Forms, USyncServerData, UMainUnited, Classes, USyncServerDm, graphics, dialogs,
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
     URBSync_Office, URBSync_Package, URBSync_Object, URBSync_OfficePackage, tsvSecurity;

//******************* Internal ************************

procedure InitAll_; stdcall;
begin
 try
  CoInitialize(nil);
  dm:=Tdm.Create(nil);

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

  FreeAndNil(fmRBSync_Office);
  FreeAndNil(fmRBSync_Package);
  FreeAndNil(fmRBSync_Object);
  FreeAndNil(fmRBSync_OfficePackage);

  ClearListMenuHandles;
  ListMenuHandles.free;

  ClearListOptionHandles;
  ListOptionHandles.Free;

  ClearListToolBarHandles;
  ListToolBarHandles.Free;

  ClearListInterfaceHandles;
  ListInterfaceHandles.Free;

  dm.Free;

  CoUnInitialize;
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

begin
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
begin
  ListOptionHandles.Clear;
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
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);

  if MenuHandle=hMenuRBooksSync_Office then ViewInterface(hInterfaceRbkSync_Office,@TPRBI);
  if MenuHandle=hMenuRBooksSync_Package then ViewInterface(hInterfaceRbkSync_Package,@TPRBI);
  if MenuHandle=hMenuRBooksSync_Object then ViewInterface(hInterfaceRbkSync_Object,@TPRBI);
  if MenuHandle=hMenuRBooksSync_OfficePackage then ViewInterface(hInterfaceRbkSync_OfficePackage,@TPRBI);
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
  hMenuService: THandle;
  isFreeServiceSync: Boolean;
  isFreeService: Boolean;
begin
  ListMenuHandles.Clear;
  hMenuService:=CreateMenuLocal(MENU_ROOT_HANDLE,ConstsMenuService,PChar(ChangeString(ConstsMenuService,'&','')));
  ListMenuHandles.Add(Pointer(hMenuService));
  hMenuServiceSync:=CreateMenuLocal(hMenuService,'�������������','����������� �������������',tcmAddFirst);
  hMenuRBooksSync_Office:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hInterfaceRbkSync_Office) then
    hMenuRBooksSync_Office:=CreateMenuLocal(hMenuServiceSync,'�����',NameRbkSync_Office,tcmAddLast,MENU_INVALID_HANDLE,0,0,MenuClickProc);

  hMenuRBooksSync_Package:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hInterfaceRbkSync_Package) then
    hMenuRBooksSync_Package:=CreateMenuLocal(hMenuServiceSync,'������',NameRbkSync_Package,tcmAddLast,MENU_INVALID_HANDLE,0,0,MenuClickProc);

  hMenuRBooksSync_Object:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hInterfaceRbkSync_Object) then
    hMenuRBooksSync_Object:=CreateMenuLocal(hMenuServiceSync,'�������',NameRbkSync_Object,tcmAddLast,MENU_INVALID_HANDLE,0,0,MenuClickProc);

  hMenuRBooksSync_OfficePackage:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hInterfaceRbkSync_OfficePackage) then
    hMenuRBooksSync_OfficePackage:=CreateMenuLocal(hMenuServiceSync,'������� ������',NameRbkSync_OfficePackage,tcmAddLast,MENU_INVALID_HANDLE,0,0,MenuClickProc);
    
  isFreeServiceSync:=(hMenuServiceSync<>MENU_INVALID_HANDLE)and
                     (hMenuRBooksSync_Office=MENU_INVALID_HANDLE)and
                     (hMenuRBooksSync_Package=MENU_INVALID_HANDLE)and
                     (hMenuRBooksSync_Object=MENU_INVALID_HANDLE)and
                     (hMenuRBooksSync_OfficePackage=MENU_INVALID_HANDLE);
  if isFreeServiceSync then
    if _FreeMenu(hMenuServiceSync) then hMenuServiceSync:=MENU_INVALID_HANDLE;

  isFreeService:=(hMenuService<>MENU_INVALID_HANDLE)and
                 (hMenuServiceSync=MENU_INVALID_HANDLE);

  if isFreeService then
    if _FreeMenu(hMenuService) then ;//hMenuService:=MENU_INVALID_HANDLE;
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

  hInterfaceRbkSync_Office:=CreateLocalInterface(NameRbkSync_Office,NameRbkSync_Office);
  CreateLocalPermission(hInterfaceRbkSync_Office,tbSync_Office,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkSync_Office,tbSync_Office,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkSync_Office,tbSync_Office,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkSync_Office,tbSync_Office,ttpDelete,false,ttiaDelete);

  hInterfaceRbkSync_Package:=CreateLocalInterface(NameRbkSync_Package,NameRbkSync_Package);
  CreateLocalPermission(hInterfaceRbkSync_Package,tbSync_Package,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkSync_Package,tbSync_Package,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkSync_Package,tbSync_Package,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkSync_Package,tbSync_Package,ttpDelete,false,ttiaDelete);

  hInterfaceRbkSync_Object:=CreateLocalInterface(NameRbkSync_Object,NameRbkSync_Object);
  CreateLocalPermission(hInterfaceRbkSync_Object,tbSync_Object,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkSync_Object,tbSync_Object,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkSync_Object,tbSync_Object,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkSync_Object,tbSync_Object,ttpDelete,false,ttiaDelete);
  CreateLocalPermission(hInterfaceRbkSync_Object,tbSync_Package,ttpSelect,false);

  hInterfaceRbkSync_OfficePackage:=CreateLocalInterface(NameRbkSync_OfficePackage,NameRbkSync_OfficePackage);
  CreateLocalPermission(hInterfaceRbkSync_OfficePackage,tbSync_OfficePackage,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkSync_OfficePackage,tbSync_OfficePackage,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkSync_OfficePackage,tbSync_OfficePackage,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkSync_OfficePackage,tbSync_OfficePackage,ttpDelete,false,ttiaDelete);
  CreateLocalPermission(hInterfaceRbkSync_OfficePackage,tbSync_Office,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkSync_OfficePackage,tbSync_Package,ttpSelect,false);

end;

function CreateAndViewSync_Office(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBSync_Office=nil then
       fmRBSync_Office:=TfmRBSync_Office.Create(Application);
     fmRBSync_Office.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBSync_Office;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBSync_Office.Create(nil);
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
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkSync_Office,Param);
  end;
end;

function CreateAndViewSync_Package(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBSync_Package=nil then
       fmRBSync_Package:=TfmRBSync_Package.Create(Application);
     fmRBSync_Package.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBSync_Package;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBSync_Package.Create(nil);
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
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkSync_Package,Param);
  end;
end;

function CreateAndViewSync_Object(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBSync_Object=nil then
       fmRBSync_Object:=TfmRBSync_Object.Create(Application);
     fmRBSync_Object.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBSync_Object;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBSync_Object.Create(nil);
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
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkSync_Object,Param);
  end;
end;

function CreateAndViewSync_OfficePackage(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBSync_OfficePackage=nil then
       fmRBSync_OfficePackage:=TfmRBSync_OfficePackage.Create(Application);
     fmRBSync_OfficePackage.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBSync_OfficePackage;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBSync_OfficePackage.Create(nil);
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
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkSync_OfficePackage,Param);
  end;
end;

function ViewInterface(InterfaceHandle: THandle; Param: Pointer): Boolean; stdcall;
begin
  Result:=false;

  // RBooks

  if InterfaceHandle=hInterfaceRbkSync_Office then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewSync_Office(InterfaceHandle,Param);
  end;
  if InterfaceHandle=hInterfaceRbkSync_Package then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewSync_Package(InterfaceHandle,Param);
  end;
  if InterfaceHandle=hInterfaceRbkSync_Object then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewSync_Object(InterfaceHandle,Param);
  end;
  if InterfaceHandle=hInterfaceRbkSync_OfficePackage then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewSync_OfficePackage(InterfaceHandle,Param);
  end;
end;

function isPermissionOnInterfaceView(InterfaceHandle: THandle): Boolean;
var
    isRemove: Boolean;
begin
    isRemove:=false;
    if InterfaceHandle=hInterfaceRbkSync_Office then begin
      isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
      if isRemove then FreeAndNil(fmRBSync_Office)
      else if fmRBSync_Office<>nil then begin
       fmRBSync_Office.SetInterfaceHandle(InterfaceHandle);
       fmRBSync_Office.ActiveQuery(true);
      end;
    end;
    if InterfaceHandle=hInterfaceRbkSync_Package then begin
      isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
      if isRemove then FreeAndNil(fmRBSync_Package)
      else if fmRBSync_Package<>nil then begin
       fmRBSync_Package.SetInterfaceHandle(InterfaceHandle);
       fmRBSync_Package.ActiveQuery(true);
      end;
    end;
    if InterfaceHandle=hInterfaceRbkSync_Object then begin
      isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
      if isRemove then FreeAndNil(fmRBSync_Object)
      else if fmRBSync_Object<>nil then begin
       fmRBSync_Object.SetInterfaceHandle(InterfaceHandle);
       fmRBSync_Object.ActiveQuery(true);
      end;
    end;
    if InterfaceHandle=hInterfaceRbkSync_OfficePackage then begin
      isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
      if isRemove then FreeAndNil(fmRBSync_OfficePackage)
      else if fmRBSync_OfficePackage<>nil then begin
       fmRBSync_OfficePackage.SetInterfaceHandle(InterfaceHandle);
       fmRBSync_OfficePackage.ActiveQuery(true);
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
