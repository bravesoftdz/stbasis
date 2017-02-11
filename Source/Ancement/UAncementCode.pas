unit UAncementCode;

interface

{$I stbasis.inc}

uses Windows, Forms, UAncementData, UMainUnited, Classes, UAncementDm, graphics, dialogs,
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
     URBRelease,URBBlackList,URBTreeHeading,URBKeyWords,URBAnnouncement,URBAnnouncementDubl, URptExport,
     URBAnnStreet, URBAnnStreetTree, URBAutoReplace, URBPublishing, 
     UAncementOptions, USrvImport, URBRusWords, URptTreeHeading,
     tsvSecurity;

//******************* Internal ************************

procedure InitAll_; stdcall;
var
  TCAM: TCreateAboutMarquee;
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

  TCAM.Text:=PChar(Format(fmtBuildFor,[ExtractFileName(GetDllName),ConstNewsPaper]));

  TCAM.TypeCreate:=tcLast;
  hAboutTest:=_CreateAboutMarquee(@TCAM);

  isInitAll:=true;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure DeInitAll;
begin
 try
  if not isInitAll then exit;

  _FreeAboutMarquee(hAboutTest);
  
  FreeAndNil(fmRBRelease);
  FreeAndNil(fmRBBlackList);
  FreeAndNil(fmRBAutoReplace);
  FreeAndNil(fmRBTreeHeading);
  FreeAndNil(fmRBKeyWords);
  FreeAndNil(fmRBKeyWords);
  FreeAndNil(fmRBAnnouncement);
  FreeAndNil(fmRBAnnouncementDubl);
  FreeAndNil(fmRBRusWords);
  FreeAndNil(fmRBAnnStreetTree);
  FreeAndNil(fmRptExport);
  FreeAndNil(fmSrvImport);
  FreeAndNil(fmRptTreeHeading);
  FreeAndNil(fmRBRelease);

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
  if ToolButtonHandle=hToolButtonRelease then MenuClickProc(hMenuRBooksRelease);
  if ToolButtonHandle=hToolButtonKeyWords then MenuClickProc(hMenuRBooksKeyWords);
  if ToolButtonHandle=hToolButtonBlackList then MenuClickProc(hMenuRBooksBlackList);
  if ToolButtonHandle=hToolButtonTreeHeading then MenuClickProc(hMenuRBooksTreeHeading);
  if ToolButtonHandle=hToolButtonAnnouncement then MenuClickProc(hMenuOptsAnnouncement);
  if ToolButtonHandle=hToolButtonAnnouncementDubl then MenuClickProc(hMenuOptsAnnouncementDubl);
  if ToolButtonHandle=hToolButtonExport then MenuClickProc(hMenuRptsExport);
  if ToolButtonHandle=hToolButtonImport then MenuClickProc(hMenuOptsImport);
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
  tBar1: THandle;
begin
  ListToolBarHandles.Clear;
  if (hMenuRBooksRelease<>MENU_INVALID_HANDLE)or
     (hMenuRBooksKeyWords<>MENU_INVALID_HANDLE)or
     (hMenuRBooksBlackList<>MENU_INVALID_HANDLE)or
     (hMenuRBooksTreeHeading<>MENU_INVALID_HANDLE)or
     (hMenuOptsAnnouncement<>MENU_INVALID_HANDLE)or
     (hMenuOptsAnnouncementDubl<>MENU_INVALID_HANDLE)or
     (hMenuRptsExport<>MENU_INVALID_HANDLE) then begin
   tbar1:=CreateToolBarLocal('���������� ����������','������ ���������� ����������',0);
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
  if isPermissionOnInterfaceView(hInterfaceRbkAnnouncement) then begin
   hOptionRBooks:=CreateOptionLocal(OPTION_ROOT_HANDLE,ConstOptionRBooks,-1);
   ListOptionHandles.Add(Pointer(hOptionRBooks));
   if hOptionRBooks<>MENU_INVALID_HANDLE then begin
    hOptionAnnouncement:=CreateOptionLocal(hOptionRBooks,NameRbkAnnouncement,4);
   end;
  end;
  if isPermissionOnInterfaceView(hInterfaceRptExport)or
     isPermissionOnInterfaceView(hInterfaceRptTreeHeading) then begin
   hOptionReports:=CreateOptionLocal(OPTION_ROOT_HANDLE,ConstOptionReports,-1);
   ListOptionHandles.Add(Pointer(hOptionReports));
   if hOptionReports<>MENU_INVALID_HANDLE then begin
     if isPermissionOnInterfaceView(hInterfaceRptExport) then
       hOptionExport:=CreateOptionLocal(hOptionReports,NameRptExport,5);
     if isPermissionOnInterfaceView(hInterfaceRptTreeHeading) then
       hOptionExportTreeHeading:=CreateOptionLocal(hOptionReports,NameRptTreeHeading,-1);
   end;
  end;
  if isPermissionOnInterfaceView(hInterfaceSrvImport) then begin
   hOptionOperations:=CreateOptionLocal(OPTION_ROOT_HANDLE,ConstOptionOperations,-1);
   ListOptionHandles.Add(Pointer(hOptionOperations));
   if hOptionOperations<>MENU_INVALID_HANDLE then begin
    hOptionImport:=CreateOptionLocal(hOptionOperations,NameSrvImport,7);
   end;
  end;
end;

procedure BeforeSetOptionProc(OptionHandle: THandle);stdcall;

  procedure BeforeSetOption;
  var
    wc: TWinControl;
  begin
    if OptionHandle=hOptionExport then begin
     wc:=FindControl(_GetOptionParentWindow(hOptionExport));
     if isValidPointer(wc) then begin
      fmOptions.pc.ActivePage:=fmOptions.tsRptExport;
      fmOptions.pnRptExport.Parent:=wc;
     end;
    end;
    if OptionHandle=hOptionExportTreeHeading then begin
     wc:=FindControl(_GetOptionParentWindow(hOptionExportTreeHeading));
     if isValidPointer(wc) then begin
      fmOptions.pc.ActivePage:=fmOptions.tsRptExportTreeHeading;
      fmOptions.pnRptExportTreeHeading.Parent:=wc;
     end;
    end;
    if OptionHandle=hOptionImport then begin
     wc:=FindControl(_GetOptionParentWindow(hOptionImport));
     if isValidPointer(wc) then begin
      fmOptions.pc.ActivePage:=fmOptions.tsSrvImport;
      fmOptions.pnSrvImport.Parent:=wc;
     end;
    end;
    if OptionHandle=hOptionAnnouncement then begin
     wc:=FindControl(_GetOptionParentWindow(hOptionAnnouncement));
     if isValidPointer(wc) then begin
      fmOptions.pc.ActivePage:=fmOptions.tsRbkAnnouncement;
      fmOptions.pnRbkAnnouncement.Parent:=wc;
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
     if OptionHandle=hOptionExport then begin
      fmOptions.pnRptExport.Parent:=fmOptions.tsRptExport;
     end;
     if OptionHandle=hOptionExportTreeHeading then begin
      fmOptions.pnRptExportTreeHeading.Parent:=fmOptions.tsRptExportTreeHeading;
     end;
     if OptionHandle=hOptionImport then begin
      fmOptions.pnSrvImport.Parent:=fmOptions.tsSrvImport;
     end;
     if OptionHandle=hOptionAnnouncement then begin
      fmOptions.pnRbkAnnouncement.Parent:=fmOptions.tsRbkAnnouncement;
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

  if MenuHandle=hMenuRBooksRelease then ViewInterface(hInterfaceRbkRelease,@TPRBI);
  if MenuHandle=hMenuRBooksKeyWords then ViewInterface(hInterfaceRbkKeyWords,@TPRBI);
  if MenuHandle=hMenuRBooksRusWords then ViewInterface(hInterfaceRbkRusWords,@TPRBI);
  if MenuHandle=hMenuRBooksAnnStreet then ViewInterface(hInterfaceRbkAnnStreet,@TPRBI);
  if MenuHandle=hMenuRBooksAnnStreetTree then ViewInterface(hInterfaceRbkAnnStreetTree,@TPRBI);
  if MenuHandle=hMenuRBooksBlackList then ViewInterface(hInterfaceRbkBlackList,@TPRBI);
  if MenuHandle=hMenuRBooksAutoReplace then ViewInterface(hInterfaceRbkAutoReplace,@TPRBI);
  if MenuHandle=hMenuRBooksTreeHeading then ViewInterface(hInterfaceRbkTreeHeading,@TPRBI);
  if MenuHandle=hMenuOptsAnnouncement then ViewInterface(hInterfaceRbkAnnouncement,@TPRBI);
  if MenuHandle=hMenuOptsAnnouncementDubl then ViewInterface(hInterfaceRbkAnnouncementDubl,@TPRBI);
  if MenuHandle=hMenuRBooksPublishing then ViewInterface(hInterfaceRbkPublishing,@TPRBI);

  if MenuHandle=hMenuRptsExport then ViewInterface(hInterfaceRptExport,@TPRI);
  if MenuHandle=hMenuRptsTreeHeading then ViewInterface(hInterfaceRptTreeHeading,@TPRI);

  if MenuHandle=hMenuOptsImport then ViewInterface(hInterfaceSrvImport,@TPSI);
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
  isFreeMenuRpts: Boolean;
  isFreeMenuOpts: Boolean;
  isFreeData: Boolean;
begin
  ListMenuHandles.Clear;

  hMenuRBooks:=CreateMenuLocal(MENU_ROOT_HANDLE,ConstsMenuRBooks,PChar(ChangeString(ConstsMenuRBooks,'&','')),
                               tcmInsertBefore,_GetMenuHandleFromName(MENU_ROOT_HANDLE,ConstsMenuService));
  ListMenuHandles.Add(Pointer(hMenuRBooks));

  hMenuRBooksRelease:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hInterfaceRbkRelease) then
   hMenuRBooksRelease:=CreateMenuLocal(hMenuRBooks,'�������',NameRbkRelease,tcmAddLast,MENU_INVALID_HANDLE,0,0,MenuClickProc);

  hMenuRBooksPublishing:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hInterfaceRbkPublishing) then
   hMenuRBooksPublishing:=CreateMenuLocal(hMenuRBooks,'�������',NameRbkPublishing,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);

  hMenuRBooksFree:=CreateMenuLocal(hMenuRBooks,ConstsMenuRBooksAnnFree,PChar(ChangeString(ConstsMenuRBooksAnnFree,'&','')),
                                   tcmAddFirst,0);

  hMenuRBooksKeyWords:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hInterfaceRbkKeyWords) then
   hMenuRBooksKeyWords:=CreateMenuLocal(hMenuRBooksFree,'�������� �����',NameRbkKeyWords,tcmAddLast,MENU_INVALID_HANDLE,3,0,MenuClickProc);
  hMenuRBooksRusWords:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hInterfaceRbkRusWords) then
   hMenuRBooksRusWords:=CreateMenuLocal(hMenuRBooksFree,'�������',NameRbkRusWords,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAnnStreet:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hInterfaceRbkAnnStreet) then
   hMenuRBooksAnnStreet:=CreateMenuLocal(hMenuRBooksFree,'�����',NameRbkAnnStreet,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksAnnStreetTree:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hInterfaceRbkAnnStreetTree) then
   hMenuRBooksAnnStreetTree:=CreateMenuLocal(hMenuRBooksFree,'������ ������ - �����',NameRbkAnnStreetTree,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksBlackList:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hInterfaceRbkBlackList) then
   hMenuRBooksBlackList:=CreateMenuLocal(hMenuRBooksFree,'���������� ����������',NameRbkBlackList,tcmAddLast,MENU_INVALID_HANDLE,1,0,MenuClickProc);
  hMenuRBooksAutoReplace:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hInterfaceRbkAutoReplace) then
   hMenuRBooksAutoReplace:=CreateMenuLocal(hMenuRBooksFree,'����������',NameRbkAutoReplace,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);
  hMenuRBooksTreeHeading:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hInterfaceRbkTreeHeading) then
   hMenuRBooksTreeHeading:=CreateMenuLocal(hMenuRBooksFree,'������ ������',NameRbkTreeHeading,tcmAddLast,MENU_INVALID_HANDLE,2,0,MenuClickProc);

  hMenuData:=CreateMenuLocal(MENU_ROOT_HANDLE,ConstsMenuData,PChar(ChangeString(ConstsMenuData,'&','')),
                             tcmInsertBefore,hMenuRBooks);
  ListMenuHandles.Add(Pointer(hMenuData));
  hMenuOptsAnnouncement:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hInterfaceRbkAnnouncement) then
   hMenuOptsAnnouncement:=CreateMenuLocal(hMenuData,'����������',NameRbkAnnouncement,tcmAddLast,MENU_INVALID_HANDLE,4,0,MenuClickProc);

  hMenuOpts:=CreateMenuLocal(MENU_ROOT_HANDLE,ConstsMenuOperations,PChar(ChangeString(ConstsMenuOperations,'&','')),
                             tcmInsertBefore,_GetMenuHandleFromName(MENU_ROOT_HANDLE,ConstsMenuService));
  ListMenuHandles.Add(Pointer(hMenuOpts));
  hMenuOptsAnnouncementDubl:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hInterfaceRbkAnnouncementDubl) then
   hMenuOptsAnnouncementDubl:=CreateMenuLocal(hMenuOpts,'����� ������',NameRbkAnnouncementDubl,tcmAddLast,MENU_INVALID_HANDLE,6,0,MenuClickProc);

  hMenuOptsFree:=CreateMenuLocal(hMenuOpts,ConstsMenuOptsFree,PChar(ChangeString(ConstsMenuOptsFree,'&','')),
                                 tcmAddFirst,0);

  hMenuOptsImport:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hInterfaceSrvImport) then
   hMenuOptsImport:=CreateMenuLocal(hMenuOptsFree,'������ ����������',NameSrvImport,tcmAddLast,MENU_INVALID_HANDLE,7,0,MenuClickProc);
   

  hMenuRpts:=CreateMenuLocal(MENU_ROOT_HANDLE,ConstsMenuReports,PChar(ChangeString(ConstsMenuReports,'&','')),
                               tcmInsertBefore,_GetMenuHandleFromName(MENU_ROOT_HANDLE,ConstsMenuService));
  ListMenuHandles.Add(Pointer(hMenuRpts));

  hMenuRptsFree:=CreateMenuLocal(hMenuRpts,ConstsMenuRptsFree,PChar(ChangeString(ConstsMenuRptsFree,'&','')),
                                 tcmAddFirst,0);
  
  hMenuRptsExport:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hInterfaceRptExport) then
   hMenuRptsExport:=CreateMenuLocal(hMenuRptsFree,'������� ������',NameRptExport,tcmAddLast,MENU_INVALID_HANDLE,5,0,MenuClickProc);
  hMenuRptsTreeHeading:=MENU_INVALID_HANDLE;
  if isPermissionOnInterfaceView(hInterfaceRptTreeHeading) then
   hMenuRptsTreeHeading:=CreateMenuLocal(hMenuRptsFree,'������� �����������',NameRptTreeHeading,tcmAddLast,MENU_INVALID_HANDLE,-1,0,MenuClickProc);


  isFreeMenuRBooks:=(hMenuRBooks<>MENU_INVALID_HANDLE)and
                    (hMenuRBooksFree<>MENU_INVALID_HANDLE) and
                    (hMenuRBooksKeyWords=MENU_INVALID_HANDLE)and
                    (hMenuRBooksRusWords=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAnnStreet=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAnnStreetTree=MENU_INVALID_HANDLE)and
                    (hMenuRBooksBlackList=MENU_INVALID_HANDLE)and
                    (hMenuRBooksAutoReplace=MENU_INVALID_HANDLE)and
                    (hMenuRBooksTreeHeading=MENU_INVALID_HANDLE);
  if isFreeMenuRBooks then
    if _FreeMenu(hMenuRBooks) then hMenuRBooks:=MENU_INVALID_HANDLE;

  isFreeData:=(hMenuData<>MENU_INVALID_HANDLE)and
              (hMenuOptsAnnouncement=MENU_INVALID_HANDLE);

  if isFreeData then
    if _FreeMenu(hMenuData) then hMenuData:=MENU_INVALID_HANDLE;

  isFreeMenuOpts:=(hMenuOpts<>MENU_INVALID_HANDLE) and
                  (hMenuOptsFree<>MENU_INVALID_HANDLE) and
                  (hMenuOptsAnnouncement=MENU_INVALID_HANDLE) and
                  (hMenuOptsAnnouncementDubl=MENU_INVALID_HANDLE) and
                  (hMenuOptsImport=MENU_INVALID_HANDLE);

  if isFreeMenuOpts then
    if _FreeMenu(hMenuOpts) then hMenuOpts:=MENU_INVALID_HANDLE;

  isFreeMenuRpts:=(hMenuRpts<>MENU_INVALID_HANDLE)and
                  (hMenuRptsFree<>MENU_INVALID_HANDLE)and
                  (hMenuRptsExport=MENU_INVALID_HANDLE)and
                  (hMenuRptsTreeHeading=MENU_INVALID_HANDLE);
  if isFreeMenuRpts then
    if _FreeMenu(hMenuRpts) then hMenuRpts:=MENU_INVALID_HANDLE;

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

  hInterfaceRbkPublishing:=CreateLocalInterface(NameRbkPublishing,NameRbkPublishing);
  CreateLocalPermission(hInterfaceRbkPublishing,tbPublishing,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkPublishing,tbPublishing,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkPublishing,tbPublishing,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkPublishing,tbPublishing,ttpDelete,false,ttiaDelete);

  hInterfaceRbkRelease:=CreateLocalInterface(NameRbkRelease,NameRbkRelease);
  CreateLocalPermission(hInterfaceRbkRelease,tbRelease,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkRelease,tbPublishing,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkRelease,tbRelease,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkRelease,tbRelease,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkRelease,tbRelease,ttpDelete,false,ttiaDelete);

  hInterfaceRbkKeyWords:=CreateLocalInterface(NameRbkKeyWords,NameRbkKeyWords);
  CreateLocalPermission(hInterfaceRbkKeyWords,tbKeyWords,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkKeyWords,tbKeyWords,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkKeyWords,tbKeyWords,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkKeyWords,tbKeyWords,ttpDelete,false,ttiaDelete);
  CreateLocalPermission(hInterfaceRbkKeyWords,tbTreeHeading,ttpSelect,false);

  hInterfaceRbkRusWords:=CreateLocalInterface(NameRbkRusWords,NameRbkRusWords);
  CreateLocalPermission(hInterfaceRbkRusWords,tbRusWords,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkRusWords,tbRusWords,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkRusWords,tbRusWords,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkRusWords,tbRusWords,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAnnStreet:=CreateLocalInterface(NameRbkAnnStreet,NameRbkAnnStreet);
  CreateLocalPermission(hInterfaceRbkAnnStreet,tbAnnStreet,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAnnStreet,tbAnnStreet,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAnnStreet,tbAnnStreet,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAnnStreet,tbAnnStreet,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAnnStreetTree:=CreateLocalInterface(NameRbkAnnStreetTree,NameRbkAnnStreetTree);
  CreateLocalPermission(hInterfaceRbkAnnStreetTree,tbAnnStreetTree,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAnnStreetTree,tbAnnStreetTree,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAnnStreetTree,tbAnnStreetTree,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAnnStreetTree,tbAnnStreetTree,ttpDelete,false,ttiaDelete);
  CreateLocalPermission(hInterfaceRbkAnnStreetTree,tbAnnStreet,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAnnStreetTree,tbTreeHeading,ttpSelect,false);

  hInterfaceRbkBlackList:=CreateLocalInterface(NameRbkBlackList,NameRbkBlackList);
  CreateLocalPermission(hInterfaceRbkBlackList,tbBlackList,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkBlackList,tbBlackList,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkBlackList,tbBlackList,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkBlackList,tbBlackList,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAutoReplace:=CreateLocalInterface(NameRbkAutoReplace,NameRbkAutoReplace);
  CreateLocalPermission(hInterfaceRbkAutoReplace,tbAutoReplace,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAutoReplace,tbAutoReplace,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAutoReplace,tbAutoReplace,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAutoReplace,tbAutoReplace,ttpDelete,false,ttiaDelete);

  hInterfaceRbkTreeheading:=CreateLocalInterface(NameRbkTreeheading,NameRbkTreeheading);
  CreateLocalPermission(hInterfaceRbkTreeheading,tbTreeheading,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkTreeheading,tbTreeheading,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkTreeheading,tbTreeheading,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkTreeheading,tbTreeheading,ttpDelete,false,ttiaDelete);

  hInterfaceRbkAnnouncement:=CreateLocalInterface(NameRbkAnnouncement,NameRbkAnnouncement);
  CreateLocalPermission(hInterfaceRbkAnnouncement,tbAnnouncement,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAnnouncement,tbAnnouncement,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAnnouncement,tbAnnouncement,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAnnouncement,tbAnnouncement,ttpDelete,false,ttiaDelete);
  CreateLocalPermission(hInterfaceRbkAnnouncement,tbRelease,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAnnouncement,tbKeyWords,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAnnouncement,tbTreeHeading,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAnnouncement,tbRusWords,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAnnouncement,tbRusWords,ttpInsert,false);
  CreateLocalPermission(hInterfaceRbkAnnouncement,prGetTreeHeadingName,ttpExecute,false);

  hInterfaceRbkAnnouncementDubl:=CreateLocalInterface(NameRbkAnnouncementDubl,NameRbkAnnouncementDubl);
  CreateLocalPermission(hInterfaceRbkAnnouncementDubl,tbAnnouncement,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAnnouncementDubl,tbAnnouncement,ttpUpdate,false,ttiaChange);
  CreateLocalPermission(hInterfaceRbkAnnouncementDubl,tbAnnouncement,ttpInsert,false,ttiaAdd);
  CreateLocalPermission(hInterfaceRbkAnnouncementDubl,tbAnnouncement,ttpDelete,false,ttiaDelete);
  CreateLocalPermission(hInterfaceRbkAnnouncementDubl,tbRelease,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAnnouncementDubl,tbKeyWords,ttpSelect,false);
  CreateLocalPermission(hInterfaceRbkAnnouncementDubl,tbTreeHeading,ttpSelect,false);

  hInterfaceRptExport:=CreateLocalInterface(NameRptExport,NameRptExport,ttiReport);
  CreateLocalPermission(hInterfaceRptExport,tbAnnouncement,ttpSelect,false);
  CreateLocalPermission(hInterfaceRptExport,tbRelease,ttpSelect,false);
  CreateLocalPermission(hInterfaceRptExport,tbTreeHeading,ttpSelect,false);
  CreateLocalPermission(hInterfaceRptExport,tbKeyWords,ttpSelect,false);
  CreateLocalPermission(hInterfaceRptExport,tbBlackList,ttpSelect,false);
  CreateLocalPermission(hInterfaceRptExport,prGetTreeHeadingName,ttpExecute,false);
  CreateLocalPermission(hInterfaceRptExport,prCreateTreeHeading,ttpExecute,false);

  hInterfaceRptTreeHeading:=CreateLocalInterface(NameRptTreeHeading,NameRptTreeHeading,ttiReport);
  CreateLocalPermission(hInterfaceRptTreeHeading,tbTreeHeading,ttpSelect,false);

  hInterfaceSrvImport:=CreateLocalInterface(NameSrvImport,NameSrvImport,ttiService);
  CreateLocalPermission(hInterfaceSrvImport,tbAnnouncement,ttpSelect,false);
  CreateLocalPermission(hInterfaceSrvImport,tbAnnouncement,ttpInsert,false);
  
end;

function CreateAndViewRelease(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBRelease=nil then
       fmRBRelease:=TfmRBRelease.Create(Application);
     fmRBRelease.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBRelease;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBRelease.Create(nil);
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
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkRelease,Param);
  end;
end;

function CreateAndViewPublishing(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBPublishing=nil then
       fmRBPublishing:=TfmRBPublishing.Create(Application);
     fmRBPublishing.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBPublishing;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBPublishing.Create(nil);
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
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkPublishing,Param);
  end;
end;

function CreateAndViewKeyWords(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBKeyWords=nil then
       fmRBKeyWords:=TfmRBKeyWords.Create(Application);
     fmRBKeyWords.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBKeyWords;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBKeyWords.Create(nil);
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
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkKeyWords,Param);
  end;
end;

function CreateAndViewRusWords(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBRusWords=nil then
       fmRBRusWords:=TfmRBRusWords.Create(Application);
     fmRBRusWords.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBRusWords;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBRusWords.Create(nil);
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
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkRusWords,Param);
  end;
end;

function CreateAndViewAnnStreet(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAnnStreet=nil then
       fmRBAnnStreet:=TfmRBAnnStreet.Create(Application);
     fmRBAnnStreet.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAnnStreet;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAnnStreet.Create(nil);
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
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAnnStreet,Param);
  end;
end;

function CreateAndViewAnnStreetTree(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAnnStreetTree=nil then
       fmRBAnnStreetTree:=TfmRBAnnStreetTree.Create(Application);
     fmRBAnnStreetTree.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAnnStreetTree;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAnnStreetTree.Create(nil);
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
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAnnStreetTree,Param);
  end;
end;

function CreateAndViewBlackList(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBBlackList=nil then
       fmRBBlackList:=TfmRBBlackList.Create(Application);
     fmRBBlackList.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBBlackList;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBBlackList.Create(nil);
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
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkBlackList,Param);
  end;
end;

function CreateAndViewAutoReplace(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAutoReplace=nil then
       fmRBAutoReplace:=TfmRBAutoReplace.Create(Application);
     fmRBAutoReplace.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAutoReplace;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAutoReplace.Create(nil);
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
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAutoReplace,Param);
  end;
end;

function CreateAndViewTreeHeading(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBTreeHeading=nil then
       fmRBTreeHeading:=TfmRBTreeHeading.Create(Application);
     fmRBTreeHeading.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBTreeHeading;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBTreeHeading.Create(nil);
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
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkTreeHeading,Param);
  end;
end;

function CreateAndViewAnnouncement(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAnnouncement=nil then
       fmRBAnnouncement:=TfmRBAnnouncement.Create(Application);
     fmRBAnnouncement.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAnnouncement;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAnnouncement.Create(nil);
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
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAnnouncement,Param);
  end;
end;

function CreateAndViewAnnouncementDubl(InterfaceHandle: THandle; Param: PParamRBookInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRBAnnouncementDubl=nil then
       fmRBAnnouncementDubl:=TfmRBAnnouncementDubl.Create(Application);
     fmRBAnnouncementDubl.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

   function CreateAndViewAsModal: Boolean;
   var
    fm: TfmRBAnnouncementDubl;
   begin
    Result:=false;
    try
     fm:=nil;
     try
       fm:=TfmRBAnnouncementDubl.Create(nil);
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
    tviOnlyData: Result:=QueryForParamRBookInterface(IBDB,SQLRbkAnnouncementDubl,Param);
  end;
end;


function CreateAndViewRptExport(InterfaceHandle: THandle; Param: PParamReportInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRptExport=nil then
       fmRptExport:=TfmRptExport.Create(Application);
     fmRptExport.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=CreateAndViewAsMDIChild;
end;

function CreateAndViewRptTreeHeading(InterfaceHandle: THandle; Param: PParamReportInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmRptTreeHeading=nil then
       fmRptTreeHeading:=TfmRptTreeHeading.Create(Application);
     fmRptTreeHeading.InitMdiChildParams(InterfaceHandle,Param);
     Result:=true;
    except
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   end;

begin
  Result:=CreateAndViewAsMDIChild;
end;

function CreateAndViewSrvImport(InterfaceHandle: THandle; Param: PParamServiceInterface): Boolean;

   function CreateAndViewAsMDIChild: Boolean;
   begin
    result:=false;
    try
     if fmSrvImport=nil then
       fmSrvImport:=TfmSrvImport.Create(Application);
     fmSrvImport.InitMdiChildParams(InterfaceHandle,Param);
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

  if InterfaceHandle=hInterfaceRbkRelease then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewRelease(InterfaceHandle,Param);
  end;
  if InterfaceHandle=hInterfaceRbkPublishing then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewPublishing(InterfaceHandle,Param);
  end;
  if InterfaceHandle=hInterfaceRbkKeyWords then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewKeyWords(InterfaceHandle,Param);
  end;
  if InterfaceHandle=hInterfaceRbkRusWords then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewRusWords(InterfaceHandle,Param);
  end;
  if InterfaceHandle=hInterfaceRbkAnnStreet then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewAnnStreet(InterfaceHandle,Param);
  end;
  if InterfaceHandle=hInterfaceRbkAnnStreetTree then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewAnnStreetTree(InterfaceHandle,Param);
  end;
  if InterfaceHandle=hInterfaceRbkBlackList then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewBlackList(InterfaceHandle,Param);
  end;
  if InterfaceHandle=hInterfaceRbkAutoReplace then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewAutoReplace(InterfaceHandle,Param);
  end;
  if InterfaceHandle=hInterfaceRbkTreeHeading then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewTreeHeading(InterfaceHandle,Param);
  end;
  if InterfaceHandle=hInterfaceRbkAnnouncement then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewAnnouncement(InterfaceHandle,Param);
  end;

  if InterfaceHandle=hInterfaceRbkAnnouncementDubl then begin
    if not isValidPointer(Param,SizeOf(TParamRBookInterface)) then exit;
    Result:=CreateAndViewAnnouncementDubl(InterfaceHandle,Param);
  end;

  // Reports

  if InterfaceHandle=hInterfaceRptExport then begin
    if not isValidPointer(Param,SizeOf(TParamReportInterface)) then exit;
    Result:=CreateAndViewRptExport(InterfaceHandle,Param);
  end;
  if InterfaceHandle=hInterfaceRptTreeHeading then begin
    if not isValidPointer(Param,SizeOf(TParamReportInterface)) then exit;
    Result:=CreateAndViewRptTreeHeading(InterfaceHandle,Param);
  end;

  // Services

  if InterfaceHandle=hInterfaceSrvImport then begin
    if not isValidPointer(Param,SizeOf(TParamServiceInterface)) then exit;
    Result:=CreateAndViewSrvImport(InterfaceHandle,Param);
  end;
  
end;

function isPermissionOnInterfaceView(InterfaceHandle: THandle): Boolean;
var
    isRemove: Boolean;
begin
    isRemove:=false;
    if InterfaceHandle=hInterfaceRbkRelease then begin
      isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
      if isRemove then FreeAndNil(fmRBRelease)
      else if fmRBRelease<>nil then begin
       fmRBRelease.SetInterfaceHandle(InterfaceHandle);
       fmRBRelease.ActiveQuery(true);
      end;
    end;
    if InterfaceHandle=hInterfaceRbkPublishing then begin
      isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
      if isRemove then FreeAndNil(fmRBPublishing)
      else if fmRBPublishing<>nil then begin
       fmRBPublishing.SetInterfaceHandle(InterfaceHandle);
       fmRBPublishing.ActiveQuery(true);
      end;
    end;
    if InterfaceHandle=hInterfaceRbkKeyWords then begin
      isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
      if isRemove then FreeAndNil(fmRBKeyWords)
      else if fmRBKeyWords<>nil then begin
       fmRBKeyWords.SetInterfaceHandle(InterfaceHandle);
       fmRBKeyWords.ActiveQuery(true);
      end;
    end;
    if InterfaceHandle=hInterfaceRbkRusWords then begin
      isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
      if isRemove then FreeAndNil(fmRBRusWords)
      else if fmRBRusWords<>nil then begin
       fmRBRusWords.SetInterfaceHandle(InterfaceHandle);
       fmRBRusWords.ActiveQuery(true);
      end;
    end;
    if InterfaceHandle=hInterfaceRbkAnnStreet then begin
      isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
      if isRemove then FreeAndNil(fmRBAnnStreet)
      else if fmRBAnnStreet<>nil then begin
       fmRBAnnStreet.SetInterfaceHandle(InterfaceHandle);
       fmRBAnnStreet.ActiveQuery(true);
      end;
    end;
    if InterfaceHandle=hInterfaceRbkAnnStreetTree then begin
      isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
      if isRemove then FreeAndNil(fmRBAnnStreetTree)
      else if fmRBAnnStreetTree<>nil then begin
       fmRBAnnStreetTree.SetInterfaceHandle(InterfaceHandle);
       fmRBAnnStreetTree.ActiveQuery(true);
      end;
    end;
    if InterfaceHandle=hInterfaceRbkBlackList then begin
      isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
      if isRemove then FreeAndNil(fmRBBlackList)
      else if fmRBBlackList<>nil then begin
       fmRBBlackList.SetInterfaceHandle(InterfaceHandle);
       fmRBBlackList.ActiveQuery(true);
      end;
    end;
    if InterfaceHandle=hInterfaceRbkAutoReplace then begin
      isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
      if isRemove then FreeAndNil(fmRBAutoReplace)
      else if fmRBAutoReplace<>nil then begin
       fmRBAutoReplace.SetInterfaceHandle(InterfaceHandle);
       fmRBAutoReplace.ActiveQuery(true);
      end;
    end;
    if InterfaceHandle=hInterfaceRbkTreeHeading then begin
      isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
      if isRemove then FreeAndNil(fmRBTreeHeading)
      else if fmRBTreeHeading<>nil then begin
       fmRBTreeHeading.SetInterfaceHandle(InterfaceHandle);
       fmRBTreeHeading.ActiveQuery(true);
      end;
    end;
    if InterfaceHandle=hInterfaceRbkAnnouncement then begin
      isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
      if isRemove then FreeAndNil(fmRBAnnouncement)
      else if fmRBAnnouncement<>nil then begin
       fmRBAnnouncement.SetInterfaceHandle(InterfaceHandle);
       fmRBAnnouncement.ActiveQuery(true);
      end;
    end;

    if InterfaceHandle=hInterfaceRbkAnnouncementDubl then begin
      isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
      if isRemove then FreeAndNil(fmRBAnnouncementDubl)
      else if fmRBAnnouncementDubl<>nil then begin
       fmRBAnnouncementDubl.SetInterfaceHandle(InterfaceHandle);
       fmRBAnnouncementDubl.ActiveQuery(true);
      end;
    end;

    if InterfaceHandle=hInterfaceRptExport then begin
      isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
      if isRemove then FreeAndNil(fmRptExport)
      else if fmRptExport<>nil then begin
       fmRptExport.SetInterfaceHandle(InterfaceHandle);
      end;
    end;

    if InterfaceHandle=hInterfaceRptTreeHeading then begin
      isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
      if isRemove then FreeAndNil(fmRptTreeHeading)
      else if fmRptTreeHeading<>nil then begin
       fmRptTreeHeading.SetInterfaceHandle(InterfaceHandle);
      end;
    end;

    if InterfaceHandle=hInterfaceSrvImport then begin
      isRemove:=not _isPermissionOnInterface(InterfaceHandle,ttiaView);
      if isRemove then FreeAndNil(fmSrvImport)
      else if fmSrvImport<>nil then begin
       fmSrvImport.SetInterfaceHandle(InterfaceHandle);
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
