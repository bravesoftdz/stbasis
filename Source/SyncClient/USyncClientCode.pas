unit USyncClientCode;

interface

{$I stbasis.inc}

uses Windows, Forms, USyncClientData, UMainUnited, Classes, USyncClientDm, graphics, dialogs,
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
     URBSync_Connection, USvcSync, tsvSecurity;

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

  FreeAndNil(fmRBSync_Connection);

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
  if ToolButtonHandle=hToolButtonSync then MenuClickProc(hMenuSvcSync);
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

var
  tbar1: THandle;
begin
  if (hMenuService<>MENU_INVALID_HANDLE)or
     (hMenuServiceSync<>MENU_INVALID_HANDLE) then begin
   tbar1:=CreateToolBarLocal('�������������','������ �������������',0);
   ListToolBarHandles.Add(Pointer(tbar1));
   if hMenuSvcSync<>MENU_INVALID_HANDLE then
     hToolButtonSync:=CreateToolButtonLocal(tbar1,'����������������',NameSvcSync,0,ToolButtonClickProc);
   _RefreshToolBar(tBar1);
  end; 
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
  TPRSI: TParamServiceInterface;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  FillChar(TPRSI,SizeOf(TPRSI),0);

  if MenuHandle=hMenuRBooksSync_Connection then ViewInterface(hInterfaceRbkSync_Connection,@TPRBI);
  if MenuHandle=hMenuSvcSync then ViewInterface(hInterfaceSvcSync,@TPRSI);
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
  isFreeServiceSync: Boolean;
  isFreeService: Boolean;
begin
  ListMenuHandles.Clear;
  hMenuService:=CreateMenuLocal(MENU_ROOT_HANDLE,ConstsMenuService,PChar(ChangeString(ConstsMenuService,'&','')));
  ListMenuHandles.Add(Pointer(hMenuService));
  hMenuServiceSync:=CreateMenuLocal(hMenuService,'�������������','����������� �������������',tcmAddFirst);

  hMenuSvcSync:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hInterfaceSvcSync) then
    hMenuSvcSync:=CreateMenuLocal(hMenuServiceSync,'����������������',NameSvcSync,tcmAddLast,MENU_INVALID_HANDLE,0,0,MenuClickProc);

  hMenuRBooksSync_Connection:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hInterfaceRbkSync_Connection) then
    hMenuRBooksSync_Connection:=CreateMenuLocal(hMenuServiceSync,'����������',NameRbkSync_Connection,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);

  isFreeServiceSync:=(hMenuServiceSync<>MENU_INVALID_HANDLE)and
                     (hMenuRBooksSync_Connection=MENU_INVALID_HANDLE);
  if isFreeServiceSync then
    if _FreeMenu(hMenuServiceSync) then hMenuServiceSync:=MENU_INVALID_HANDLE;

  isFreeService:=(hMenuService<>MENU_INVALID_HANDLE)and
                 (hMenuServiceSync=MENU_INVALID_HANDLE)and
                 (hMenuSvcSync=MENU_INVALID_HANDLE);

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

  hInterfaceRbkSync_Connection:=CreateLocalInterface(NameRbkSync_Connection,NameRbkSync_Connection);
  CreateLocalPermission(hInterfaceRbkSync_Connection,tbSync_Connection,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkSync_Connection,tbSync_Connection,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkSync_Connection,tbSync_Connection,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkSync_Connection,tbSync_Connection,ttpDelete,false,ttiaDelete);

  hInterfaceSvcSync:=CreateLocalInterface(NameSvcSync,NameSvcSync,ttiService);
  CreateLocalPermission(hInterfaceSvcSync,tbSync_Connection,ttpSelect,false);

end;

function CreateAndViewSync_Connection(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBSync_Connection=nil then
       fmRBSync_Connection:=TfmRBSync_Connection.Create(Application);
     fmRBSync_Connection.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBSync_Connection;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBSync_Connection.Create(nil);
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
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkSync_Connection,Param);
  end;
end;

function CreateAndViewSync(InterfaceHandle: THandle; Param: PParamServiceInterface): Boolean;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmSvcSync;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmSvcSync.Create(nil);
       fm.SetInterfaceHandle(InterfaceHandle);
       if fm.ShowModal=mrOk then begin
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
  Result:=CreateAndViewAsModal;
end;

function ViewInterface(InterfaceHandle: THandle; Param: Pointer): Boolean; stdcall;
begin
  Result:=false;

  // RBooks

  if InterfaceHandle=hInterfaceRbkSync_Connection then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewSync_Connection(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceSvcSync then begin
    if not isValidPointer(Param,SizeOf(TParamServiceInterface)) then exit;
    Result:=CreateAndViewSync(InterfaceHandle,Param);
  end;
end;

function isPermissionOnInterfaceView(InterfaceHandle: THandle): Boolean;
var
    isRemove: Boolean;
begin
    isRemove:=false;
    if InterfaceHandle=hInterfaceRbkSync_Connection then begin
      isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
      if isRemove then FreeAndNil(fmRBSync_Connection)
      else if fmRBSync_Connection<>nil then begin
       fmRBSync_Connection.SetInterfaceHandle(InterfaceHandle);
       fmRBSync_Connection.ActiveQuery(true);
      end;
    end;
    if InterfaceHandle=hInterfaceSvcSync then begin
      isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
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
