{
  ���������� �������������� �����������

  �������

  ����� �. �������
  E-mail: roman@sar.nnov.ru
}

unit Ex_Utils;

interface

uses
  Windows, ShellAPI, ShlObj, SysUtils, Messages, Graphics, Classes, Controls,
  Forms, Registry, Math;

type

  { WndProc hook record }

  TWndHook = record
    Control: TWinControl; { ���������, �� ������� �������� Hook }
    Handle: THandle;      { ��������� ����, �� ������� �������� Hook }
    WndProc: TWndMethod;  { ����� ��������� ��������� ��������� }
    Instance: Pointer;    { ��������������� }
    OldProc: Longint;     { ��������������� }
  end;

{ Hook WndProc of specified window. }

function CreateWndHook(Control: TWinControl; Handle: THandle; WndProc: TWndMethod): TWndHook;

{ Hook Application WndProc. }

function CreateAppHook(WndProc: TWndMethod): TWndHook;

{ Clear window hook, restore old WndProc. }

procedure FreeWndHook(var Hook: TWndHook);

{ Calling previos WndProc. }

procedure CallWndHook(var Hook: TWndHook; var Message: TMessage);

{ ��������� ��������� ����, � �������� �������������� ���������. }

function HookHandle(Hook: TWndHook): THandle;

{ ��������, ���������� �� ������ ����. }

function HookAllocated(Hook: TWndHook): Boolean;

{ ������������� ��������� ���������� � ������� �������� �����������. }

procedure InitControlHandle(Control: TWinControl; Recurse: Boolean);

{ ������������ ����������� ���������� � ������ ��������� ��� ���������. }

function IsControlVisible(Control: TWinControl): Boolean;
function InvalidateControl(Control: TWinControl): Boolean;
function InvalidateControlRect(Control: TWinControl; Rect: TRect; Erase: Boolean): Boolean;

{ ��������� ������ � ����� ������ ���� ����:\����\����,����� (�������� ���
  ������� ������ ���� ����� � �������). }

function ExtractIconFile(const IconPath: string): string;
function ExtractIconIndex(const IconPath: string): Integer;
function ExpandIconPath(const IconFile: string; IconIndex: Integer): string;

{ �������� ������ �� ����� �� ���� ���� ����:\����\����,����� (��������, ��
  ���� �� �������). }

function LoadIconFromFile(const IconPath: string): HICON;

function LoadLargeIconFromFile(const IconPath: string): HICON;
function LoadSmallIconFromFile(const IconPath: string): HICON;

{ �������� ����� ����� � ��������. }

function IsValidFileName(const Name: string): Boolean;

{ �������� �� ��������� ���� ���������, �'����� �����������. }

function IsFolder(const Name: string): Boolean;
function IsFloppy(const Name: string): Boolean;

{ ���� �� ��������� �������. }

function IsFolderEmpty(const Name: string; Mask: string): Boolean;

{ �������� ������� � �������� ��������. }

function DirectoryExists(const Name: string): Boolean;
function ForceDirectories(Dir: string): Boolean;

{ �������� ��������� ����� �����. }

function ExtractBakName(const FileName: string): string;
function CreateBakFile(const FileName: string): Boolean;
function CreateFileCopy(const FileName, CopyName: string): Boolean;

{ ��������� �������� �������� ������ ����� ����� �� �������. �������
  �������� ��������� �� ��� ���, ���� ���� �� ������ ������ ���������
  �����. ������������ ��������� ����� ��� C:\...\Name.exe }

function CompressFilePath(const Path: string; Len: Integer): string;

{ ��������� �������� ����� ����� � ���� �� ���������� ��� DOS. ������ ����� ��
  RXLib, ������� ��������� �����. }

function GetLongFileName(const ShortName: string): string;
function GetLongPathName(const ShortName: string): string;

{ ��������� ����� ���������� ����� ��� ���������� �����. ��� ����������
  ����� ����� ���������� � ����� Prefix. ��������: ��������� ���������� �����
  ����������� ����� ������ �������������� ������� Windows API, ������� �
  ��� �������� ����� ������ ������ 3 �������. }

function GetTemporaryFileName(const BaseFileName, Prefix: string): string;

{ ��������� ����� ����� �� ���� � ����������� ��� ���. }

function ExtractFileNameEx(const FileName: string; Extension: Boolean): string;

{ ������� ������ ��������� � ������ ��� ����������� �� ��������. }

function CasePos(Substr: string; S: string; MatchCase: Boolean): Integer;

{ ������� �������, �������� � ������ ��������. }

function ReplaceChar(const S: string; C1, C2: Char): string;
function ReplaceStr(const S: string; S1, S2: string): string;
function RemoveChars(const S: string; C: array of Char): string;
function RemoveLineBreaks(const S: string): string;
function RemoveDoubleSpace(const S: string): string;
function TrimCharLeft(const S: string; C: Char): string;
function TrimCharRight(const S: string; C: Char): string;
function InsertCharLeft(const S: string; C: Char; Len: Integer): string;
function InsertCharRight(const S: string; C: Char; Len: Integer): string;
function TruncLeft(const S: string; MaxLen: Integer): string;
function TruncRight(const S: string; MaxLen: Integer): string;

{ ����������� ���������� ����� (���� � ������ ���� ��������). }

function GetLineCount(const S: string): Integer;

{ ������� ��������� ��������� ������ � ��� ��������. }

function ParamExists(const Param: string): Boolean;
function GetParamValue(const Param: string): string;
function GetParamValueDef(const Param: string; const Default: string): string;

{ �������� ������� � ����������� �� ������� � ����� ������������. }

procedure RegEraseKey(Root: HKEY; const Key: string);
procedure RegEraseKeyEx(Root: HKEY; const Key: string; SubKeys: Boolean);
procedure RegEraseSubKeys(Root: HKEY; const Key: string);

{ ������ � ������ ���� � �������� ������� � StringList. }

procedure RegReadKey(Root: HKEY; const Key: string; Strings: TStrings);
procedure RegWriteKey(Root: HKEY; const Key: string; Strings: TStrings);

{ ������ � ������� ������ �������. ��������: � ������� ������ �������������
  ������ ��������� ��������. }

procedure RegImport(const FileName: string);
procedure RegExport(Root: HKEY; const Key: string; const FileName: string);

{ ������� ������ �������� �� ������� � ������ � �������� (������ "\\" �� "\"). }

function StrToRegStr(const Value: string): string;
function RegStrToStr(const Value: string): string;

{ �������: �������� ���� (HKEY_XXX) - ������. }

function RegRootKeyToStr(Root: HKEY): string;
function RegStrToRootKey(const S: string): HKEY;
function RegStrToRootKeyDef(const S: string; Default: HKEY): HKEY;

{ ������� ������ � ���� � �����. ���� ������ �������� �������� ��������,
  ������������ �������� �� ���������. }

function StrToTimeDef(const S: string; Default: TDateTime): TDateTime;
function StrToDateDef(const S: string; Default: TDateTime): TDateTime;

{ ������� ������� � ���� � ������ �������� ������� � ������ ���������
  ���� �������. }

function TimeToLongStr(Time: TDateTime): string;
function DateToLongStr(Date: TDateTime): string;

function DateTimeToLongStr(DateTime: TDateTime): string;

{ ������� ���� � ������� � ������ ��������� �������. }

function TimeToShortStr(Time: TDateTime): string;
function DateToShortStr(Date: TDateTime): string;

{ ������� ������� � ������. ����� �������� � ����. }

function MSecToStr(Time: Longint): string;
function MSecToStrFmt(Time: Longint; const Format: string): string;

{ ��������� ��������� ���� �� ���������, ��� ��� �������� � Windows 
  (�������� ����� ���������� �������). ������������ ��� ��������� 
  ��������� ������� (Windows ���������� poDefault ��� �������� � 
  ������ �� � ����� ������� ����). }

function GetDefFormPos: TPoint;
function GetDefFormBounds(Width, Height: Integer): TRect;

{ �������������/������� ��������� "������ ������" � ����. ��������: �� 
  ������ ��� ���� �������� FormStyle. }

procedure SetTopMostWindow(Wnd: HWND; TopMost, Activate: Boolean);

{ ����� ������� Application.MessageBox � ������������ ���������� ��
  ������ �����. }

function AppMessageBox(const Text, Caption: string; Flags: Longint): Integer;

{ �������� (������ Delay �� TP). �������� ~5 ����. ����� �������� ��������
  �� ���������� ������ ����������, ��������� ���������� ������������
  ��������� (����� ����� � ����������) �� ����� ��������. }

type
  TDelayProc = procedure(var Cancel: Boolean) of object;

procedure AppDelay(TimeOut: DWORD);
procedure AppDelayEx(TimeOut: DWORD; AppTerminate, AppMessages: Boolean; DelayProc: TDelayProc);

{  ��������� ������ ���������� � ������ �����. ���� �������� � ������ Key
   �����������, ������������ �������� �� ���������.

   �������� ���������������� �������� ��������� Key:

    CompanyName - �������������
    FileDescription - �������� �����
    FileVersion - ������ �����
    InternalName - ���������� ���
    LegalCopyright - �������� (��������� �����)
    LegalTrademarks - �������� �����
    OriginalFilename - �������� ��� �����
    ProductName - �������� ��������
    ProductVersion - ������ ��������
    Comments - �����������
}

function GetVersionStr(const FileName, Key, Default: string): string;

{$IFDEF VER90 }

{ Returns the smallest and largest value in the data array (MIN/MAX) }

function MinIntValue(const Data: array of Integer): Integer;
function MaxIntValue(const Data: array of Integer): Integer;

{$ENDIF}

implementation

function CreateWndHook(Control: TWinControl; Handle: THandle; WndProc: TWndMethod): TWndHook;
begin
  { ���������� ��������� }
  Result.Control := Control;
  { �������� ��������� ���� }
  if Assigned(Control) then
  begin
    InitControlHandle(Control, True);
    Result.Handle := Control.Handle;
  end
  else
    Result.Handle := Handle;
  { ����� ��������� ��������� ��������� }
  Result.WndProc := WndProc;
  Result.Instance := MakeObjectInstance(WndProc);
  { ������������� �� }
  Result.OldProc := SetWindowLong(Result.Handle, GWL_WNDPROC, Longint(Result.Instance));
end;

function CreateAppHook(WndProc: TWndMethod): TWndHook;
begin
  Result := CreateWndHook(nil, Application.Handle, WndProc);
end;

procedure FreeWndHook(var Hook: TWndHook);
var
  H: THandle;
begin
  with Hook do
  begin
    { �������� ��������� }
    H := HookHandle(Hook);
    { ��������� ��� }
    if H <> INVALID_HANDLE_VALUE then
    begin
      { ��������������� ��������� ��������� ��������� }
      if OldProc <> 0 then
      begin
        SetWindowLong(H, GWL_WNDPROC, OldProc);
        OldProc := 0;
      end;
      { ���������� ��������� }
      Handle := INVALID_HANDLE_VALUE;
    end;
    { ����������� ��������� ��������� }
    if Instance <> nil then
    begin
      FreeObjectInstance(Instance);
      Instance := nil;
    end;
    { ���������� ��������� ��������� }
    WndProc := nil;
    Control := nil;
  end;
end;

type
  TControlHack = class(TWinControl);

procedure CallWndHook(var Hook: TWndHook; var Message: TMessage);
var
  H: THandle;
  P: Pointer;
begin
  with Hook, Message do
  begin
    { �������� ��������� }
    H := HookHandle(Hook);
    { ��������� ��� }
    if H <> INVALID_HANDLE_VALUE then
    begin
      { ���������� ����� ��������� (����� ���������� ��� ������������ �������) }
      P := Pointer(OldProc);
      { ��� ����������� ���� ����������� ������ }
      if (Msg = WM_DESTROY) or (Msg = CM_RELEASE) then FreeWndHook(Hook);
      { ����� ���������� ��������� }
      if Assigned(P) then
        Result := CallWindowProc(P, H, Msg, wParam, lParam)
      else if Control <> nil then
        Result := CallWindowProc(TControlHack(Control).DefWndProc, H, Msg, wParam, lParam)
      else
        DefWindowProc(H, Msg, wParam, lParam);
    end;
  end;
end;

function HookHandle(Hook: TWndHook): THandle;
begin
  with Hook do
    if Control = nil then
      { ���������� ��� - ���������, ���������� ������������� }
      Result := Handle
    else if Control.HandleAllocated then
      { ��������� ���� � ����� ���� ��������� - ���������� ��� }
      Result := Control.Handle
    else
      { ��������� ��� }
      Result := INVALID_HANDLE_VALUE;
end;

function HookAllocated(Hook: TWndHook): Boolean;
begin
  Result := Hook.Instance <> nil;
end;

procedure InitControlHandle(Control: TWinControl; Recurse: Boolean);
var
  I: Integer;
  ChildControl: TControl;
begin
  { �������������� ��������� ���������� }
  Control.HandleNeeded;
  { �������������� ��������� ���� �������� }
  if Recurse then
    for I := 0 to Control.ControlCount - 1 do
    begin
      ChildControl := Control.Controls[I];
      if ChildControl is TWinControl then
        InitControlHandle(TWinControl(ChildControl), True);
    end;
end;

function IsControlVisible(Control: TWinControl): Boolean;
begin
  with Control do
  begin
    { � ����� �� ��� ��������� }
    if (not HandleAllocated) or (not Visible) then
    begin
      Result := False;
      Exit;
    end;
    { � ������ ��������� ��������� �� ��������� }
    if csDesigning in ComponentState then
    begin
      Result := True;
      Exit;
    end;
    { ��������� �����, ���� ����� �������� }
    Result := (Parent <> nil) and (Parent.Visible);
  end;
end;

function InvalidateControl(Control: TWinControl): Boolean;
var
  Rect: TRect;
begin
  with Control do
  begin
    Rect := ClientRect;
    Result := InvalidateControlRect(Control, Rect, not (csOpaque in ControlStyle));
  end;
end;

function InvalidateControlRect(Control: TWinControl; Rect: TRect; Erase: Boolean): Boolean;
begin
  { ����� �� ��������� }
  if not IsControlVisible(Control) then
  begin
    Result := False;
    Exit;
  end;
  { ��������� ������� }
  Result := InvalidateRect(Control.Handle, @Rect, Erase);
end;

function ExtractIconFile(const IconPath: string): string;
var
  I: Integer;
begin
  I := Length(IconPath);
  while (I > 0) and not (IconPath[I] in [',']) do Dec(I);
  if (I > 0) and (IconPath[I] = ',') then
    Result := Trim(Copy(IconPath, 1, I - 1)) else
    Result := Trim(IconPath);
end;

function ExtractIconIndex(const IconPath: string): Integer;
var
  I: Integer;
begin
  I := Length(IconPath);
  while (I > 0) and not (IconPath[I] in [',']) do Dec(I);
  if (I > 0) and (IconPath[I] = ',') then
    Result := StrToIntDef(Trim(Copy(IconPath, I + 1, 255)), 0) else
    Result := StrToIntDef(Trim(IconPath), 0);
end;

function ExpandIconPath(const IconFile: string; IconIndex: Integer): string;
begin
  Result := Format('%s, %d', [IconFile, IconIndex]);
end;

function LoadIconFromFile(const IconPath: string): HICON;
var
  IconFile: string;
  IconIndex: Integer;
begin
  { �������� ��� ����� � ������ ������ }
  IconFile := ExtractIconFile(IconPath);
  IconIndex := ExtractIconIndex(IconPath);
  { �������� ������ }
  Result := ExtractIcon(HInstance, PChar(IconFile), IconIndex);
end;

function LoadLargeIconFromFile(const IconPath: string): HICON;
var
  IconFile: string;
  IconIndex: Integer;
  LargeIcon, SmallIcon: HICON;
begin
  { �������� ��� ����� � ������ ������ }
  IconFile := ExtractIconFile(IconPath);
  IconIndex := ExtractIconIndex(IconPath);
  { �������� ��������� ������ }
  if ExtractIconEx(PChar(IconFile), IconIndex, LargeIcon, SmallIcon, 1) = 0 then
  begin
    Result := 0;
    Exit;
  end;
  { ���������� ��������� ������� ������ }
  Result := LargeIcon;
end;

function LoadSmallIconFromFile(const IconPath: string): HICON;
var
  IconFile: string;
  IconIndex: Integer;
  LargeIcon, SmallIcon: HICON;
begin
  { �������� ��� ����� � ������ ������ }
  IconFile := ExtractIconFile(IconPath);
  IconIndex := ExtractIconIndex(IconPath);
  { �������� ��������� ������ }
  if ExtractIconEx(PChar(IconFile), IconIndex, LargeIcon, SmallIcon, 1) = 0 then
  begin
    Result := 0;
    Exit;
  end;
  { ���������� ��������� ��������� ������ }
  Result := SmallIcon;
end;

function IsValidFileName(const Name: string): Boolean;
const
  C: string = '*?<>|"';
var
  I, P: Integer;
begin
  P := Pos(':', Name);
  if (P <> 0) and (P <> 2) then
  begin
    Result := False;
    Exit;
  end;
  for I := 1 to Length(C) do
  begin
    P := Pos(C[I], Name);
    if P <> 0 then
    begin
      Result := False;
      Exit;
    end;
  end;
  if (Name = '.') or (Name = '..') then { ! only for this release }
  begin
    Result := False;
    Exit;
  end;
  Result := True;
end;

function IsFolder(const Name: string): Boolean;
var
  SR: TSearchRec;
begin
  Result := False;
  if FindFirst(TrimCharRight(Name, '\'), faDirectory, SR) = 0 then
  try
    Result := SR.Attr and faDirectory <> 0;
  finally
    FindClose(SR);
  end;
end;

function IsFloppy(const Name: string): Boolean;
var
  Info: TSHFileInfo;
begin
  SHGetFileInfo(PChar(Name), 0, Info, SizeOf(Info), SHGFI_ATTRIBUTES);
  Result := Info.dwAttributes and SFGAO_REMOVABLE <> 0;
end;

function IsFolderEmpty(const Name: string; Mask: string): Boolean;
var
  Info: TSHFileInfo;
  SR: TSearchRec;
begin
  SHGetFileInfo(PChar(Name), 0, Info, SizeOf(Info), SHGFI_ATTRIBUTES);
  if Info.dwAttributes and SFGAO_HASSUBFOLDER <> 0 then
  begin
    Result := False;
    Exit;
  end;
  if FindFirst(Name + Mask, faAnyFile and not faSysFile, SR) = 0 then
  try
    Result := False;
    Exit;
  finally
    FindClose(SR);
  end;
  Result := True;
end;

function DirectoryExists(const Name: string): Boolean;
var
  Code: Integer;
begin
  Code := GetFileAttributes(PChar(Name));
  Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;

function ForceDirectories(Dir: string): Boolean;
begin
  { ��������� ��� }
  if Length(Dir) = 0 then
  begin
    Result := False;
    Exit;
  end;
  { ������� "\" � ����� ������ }
  Dir := TrimCharRight(Dir, '\');
  { � ���������� �� ������������ ������� }
  if (Length(Dir) < 3) or DirectoryExists(Dir) or (ExtractFilePath(Dir) = Dir) then
  begin
    Result := True;
    Exit;
  end;
  { ������� ������������ �������� }
  if not ForceDirectories(ExtractFilePath(Dir)) then
  begin
    Result := False;
    Exit;
  end;
  { ������� ������� }
  Result := CreateDir(Dir);
end;

function ExtractBakName(const FileName: string): string;
var
  Ext: string;
  I: Integer;
begin
  { �������� ���������� ����� }
  I := Length(FileName);
  while (I > 0) and not (FileName[I] in ['.', '\', ':']) do Dec(I);
  { ������ ��� }
  if (I > 0) and (FileName[I] = '.') then
  begin
    Ext := Copy(FileName, I + 1, 255);
    if Length(Ext) > 2 then Ext := Copy(Ext, 1, Length(Ext) - 1);
    Result := Copy(FileName, 1, I - 1) + '.~' + Ext;
  end
  else
    Result := FileName + '.~';
end;

function CreateBakFile(const FileName: string): Boolean;
var
  BakName: string;
begin
  { ��� ��������� ����� }
  BakName := ExtractBakName(FileName);
  { ������� ���� ������ ����� }
  if FileExists(BakName) and (not DeleteFile(BakName)) then
  begin
    Result := False;
    Exit;
  end;
  { ��������������� ���� }
  if FileExists(FileName) and (not RenameFile(FileName, BakName)) then
  begin
    Result := False;
    Exit;
  end;
  { ��� ������ ������� }
  Result := True;
end;

function CreateFileCopy(const FileName, CopyName: string): Boolean;
begin
  { ������� ���� ������ ����� }
  if FileExists(CopyName) and (not DeleteFile(CopyName)) then
  begin
    Result := False;
    Exit;
  end;
  { ������� ����� ����� }
  if FileExists(FileName) and (not CopyFile(PChar(FileName), PChar(CopyName), False)) then
  begin
    Result := False;
    Exit;
  end;
  { ��� ������ ������� }
  Result := True;
end;

function CompressFilePath(const Path: string; Len: Integer): string;
var
  L, I, P1, P2: Integer;
begin
  { ��������� }
  Result := Path;
  { �������� ����� ���� }
  L := Length(Path);
  { ��������� �� }
  if L > Len then
  begin
    { ������� ����� ��������� }
    while Length(Result) > Len - 4 do
    begin
      { �������� ������ ����������� �������� }
      P1 := Pos('\', Result);
      { � ���� �� �� }
      if P1 = 0 then Exit;
      { ���� ������ }
      P2 := P1;
      for I := P1 + 1 to Length(Result) do
        if (P2 = P1) and (Result[I] = '\') then
        begin
          P2 := I;
          Break;
        end;
      { � ���� �� �� }
      if P2 = P1 then Exit;
      { ������� ������� }
      Delete(Result, P1 + 1, P2 - P1);
    end;
    { ��������� ����������� }
    Insert('...\', Result, 4);
  end;
end;

function GetLongFileName(const ShortName: string): string;
var
  SearchHandle: THandle;
  FindData: TWin32FindData;
begin
  { �������� �� ��������� }
  Result := ShortName;
  { ���� ���� }
  SearchHandle := FindFirstFile(PChar(ShortName), FindData);
  { ���� �� ������ - ����� ��� ��� }
  if SearchHandle <> INVALID_HANDLE_VALUE then
  begin
    Result := FindData.cFileName;
    if Result = '' then Result := FindData.cAlternateFileName;
  end;
  { ��������� ��������� }
  Windows.FindClose(SearchHandle);
end;

function GetLongPathName(const ShortName: string): string;
var
  LastSlash: PChar;
  PathPtr: PChar;
  PathName: string;
  SearchHandle: THandle;
  FindData: TWin32FindData;
begin
  Result := '';
  PathPtr := PChar(ShortName);
  LastSlash := StrRScan(PathPtr, '\');
  { ���������� ���� }
  while LastSlash <> nil do
  begin
    { �������� ��������� ��� }
    SearchHandle := FindFirstFile(PathPtr, FindData);
    try
      { ���� ��� ������� - ����� ������� ��� ��� }
      if SearchHandle <> INVALID_HANDLE_VALUE then
      begin
        { �������� ������� ��� }
        PathName := FindData.cFileName;
        if PathName = '' then PathName := FindData.cAlternateFileName;
        { ��������� ��� � ���������� }
        Result := '\' + PathName + Result;
      end
      else
        { ���� �� ������ - ������� ����� ��� ���� � ����� }
        Break;
    finally
      Windows.FindClose(SearchHandle);
    end;
    { ���� ��������� ����������� ���� }
    if LastSlash <> nil then
    begin
      LastSlash^ := Char(0);
      LastSlash := StrRScan(PathPtr, '\');
    end;
  end;
  { ��������� }
  Result := PathPtr + Result;
end;

function GetTemporaryFileName(const BaseFileName, Prefix: string): string;
var
  Dir: string;
  Buffer: array[0..MAX_PATH] of Char;
begin
  { �������� ������� }
  Dir := ExtractFileDir(BaseFileName);
  { ������� ��� ������������ ���������� }
  if Windows.GetTempFileName(PChar(Dir), PChar(Prefix), 0, @Buffer) <> 0 then
  begin
    Result := Buffer;
    Exit;
  end;
  { ������� ��� ���� }
  repeat
    Result := Format('%s\%s%d.tmp', [Dir, Prefix, Random(MaxWord)]);
  until not FileExists(Result);
end;

function ExtractFileNameEx(const FileName: string; Extension: Boolean): string;
var
  I: Integer;
begin
  { �������� ��� ����� }
  Result := ExtractFileName(FileName);
  { ������� ���������� }
  if not Extension then
  begin
    I := Length(Result);
    while (I > 0) and not (Result[I] in ['.', '\', ':']) do Dec(I);
    if (I > 0) and (Result[I] = '.') then Result := Copy(Result, 1, I - 1);
  end;
end;

function CasePos(Substr: string; S: string; MatchCase: Boolean): Integer;
begin
  if not MatchCase then
  begin
    { ��� � ������� ������� }
    Substr := AnsiUpperCase(Substr);
    S := AnsiUpperCase(S);
  end;
  { ���� }
{$IFDEF VER90 }
  Result := Pos(Substr, S);
{$ELSE}
  Result := AnsiPos(Substr, S);
{$ENDIF}
end;

function ReplaceChar(const S: string; C1, C2: Char): string;
var
  I: Integer;
begin
  { ������������� ��������� � �������� ������ }
  Result := S;
  { ������ ������ }
  for I := 0 to Length(Result) do
    if Result[I] = C1 then Result[I] := C2;
end;

function ReplaceStr(const S: string; S1, S2: string): string;
var
  P: Integer;
begin
  Result := S;
  P := CasePos(S1, Result, False);
  if P <> 0 then
  begin
    Delete(Result, P, Length(S1));
    Insert(S2, Result, P);
  end;
end;

function RemoveChars(const S: string; C: array of Char): string;
var
  I, J, K, L, N: Integer;
begin
  { ����� ������ }
  L := Length(S);
  { ������������� ����� ���������� � ����� ������ }
  SetString(Result, nil, L);
  N := 0;
  { ���������� ������� ������ }
  for I := 1 to L do
  begin
    { ���� �� ������� ������ ����� ��������� }
    K := 0;
    for J := Low(C) to High(C) do
      if S[I] = C[J] then
      begin
        Inc(K);
        Break;
      end;
    { ��� - ��������� ��� � ��������� }
    if K = 0 then
    begin
      Inc(N);
      Result[N] := S[I];
    end;
  end;
  { ������������� �������� ����� ������ ���������� }
  SetLength(Result, N);
end;

function RemoveLineBreaks(const S: string): string;
var
  I, L, N: Integer;
begin
  { ����� ������ }
  L := Length(S);
  { ������������� ����� ���������� � ����� ������ }
  SetString(Result, nil, L);
  N := 0;
  { ���������� ������� ������ }
  I := 1;
  while I <= L do
  begin
    Inc(N);
    { �������� �� ������� ������ �������� �������� ������ }
    if S[I] in [#13, #10] then
    begin
      { ��- ������ ��� �� ������ }
      Result[N] := ' ';
      { ��������� ������� �������� ���������� }
      while (I < L) and (S[I + 1] in [#13, #10]) do Inc(I);
    end
    else
      { ��� - ����� ��� }
      Result[N] := S[I];
    { ��������� ������ }
    Inc(I);
  end;
  { ������������� �������� ����� ������ ���������� }
  SetLength(Result, N);
end;

function RemoveDoubleSpace(const S: string): string;
var
  I, L, N: Integer;
begin
  { ����� ������ }
  L := Length(S);
  { ������������� ����� ���������� � ����� ������ }
  SetString(Result, nil, L);
  N := 0;
  { ���������� ������� ������ }
  I := 1;
  while I <= L do
  begin
    Inc(N);
    { �������� �� ������� ������ �������� �������� ������ }
    if S[I] = ' ' then
    begin
      { ��- ������ ��� �� ������ }
      Result[N] := ' ';
      { ��������� ������� �������� ���������� }
      while (I < L) and (S[I + 1] = ' ') do Inc(I);
    end
    else
      { ��� - ����� ��� }
      Result[N] := S[I];
    { ��������� ������ }
    Inc(I);
  end;
  { ������������� �������� ����� ������ ���������� }
  SetLength(Result, N);
end;

function TrimCharLeft(const S: string; C: Char): string;
var
  I, L: Integer;
begin
  L := Length(S);
  I := 1;
  while (I <= L) and (S[I] = C) do Inc(I);
  Result := Copy(S, I, Maxint);
end;

function TrimCharRight(const S: string; C: Char): string;
var
  I: Integer;
begin
  I := Length(S);
  while (I > 0) and (S[I] = C) do Dec(I);
  if I <> 0 then Result := Copy(S, 1, I) else Result := '';
end;

function InsertCharLeft(const S: string; C: Char; Len: Integer): string;
var
  L: Integer;
  A: string;
begin
  L := Length(S);
  { �������� ����� }
  if L >= Len then
  begin
    Result := S;
    Exit;
  end;
  { ��������� ������� }
  SetString(A, nil, Len - L);
  FillChar(Pointer(A)^, Len - L, Byte(C));
  { ��������� }
  Result := A + S;
end;

function InsertCharRight(const S: string; C: Char; Len: Integer): string;
var
  L: Integer;
  A: string;
begin
  { �������� ����� ������ }
  L := Length(S);
  { ��������� ����� }
  if L >= Len then
  begin
    Result := S;
    Exit;
  end;
  { ��������� ������� }
  SetString(A, nil, Len - L);
  FillChar(Pointer(A)^, Len - L, Byte(C));
  { ��������� }
  Result := S + A;
end;

function TruncLeft(const S: string; MaxLen: Integer): string;
var
  L: Integer;
begin
  { �������� ����� ������ }
  L := Length(S);
  { ���� ����� ������ - �������� ������� ����� }
  if L > MaxLen then
  begin
    Result := Copy(S, MaxIntValue([1, L - MaxLen]), MaxLen);
    Exit;
  end;
  { ���������� ������ ��� ��������� }
  Result := S;
end;

function TruncRight(const S: string; MaxLen: Integer): string;
var
  L: Integer;
begin
  { �������� ����� ������ }
  L := Length(S);
  { ���� ����� ������ - �������� ������� ����� }
  if L > MaxLen then
  begin
    Result := Copy(S, 1, MaxLen);
    Exit;
  end;
  { ���������� ������ ��� ��������� }
  Result := S;
end;

function GetLineCount(const S: string): Integer;
var
  P: PChar;
begin
  Result := 0;
  { ���� ������� ������ }
  P := Pointer(S);
  while P^ <> #0 do
  begin
    while not (P^ in [#0, #10, #13]) do Inc(P);
    { ���� ������ }
    Inc(Result);
    { ��������� ������� �������� }
    if P^ = #13 then Inc(P);
    if P^ = #10 then Inc(P);
  end;
end;

function ParamExists(const Param: string): Boolean;
var
  I, P: Integer;
  S: string;
begin
  { ���������� ��������� ��������� ������ }
  for I := 1 to ParamCount do
  begin
    { �������� �������� }
    S := ParamStr(I);
    { ���� � ��������� ������� }
    P := CasePos(Param, S, False);
    if P = 1 then
    begin
      { �������� ���������� - ����� }
      Result := True;
      Exit;
    end;
  end;
  { ��������� ��� }
  Result := False;
end;

function GetParamValue(const Param: string): string;
var
  I, P: Integer;
  S: string;
begin
  { ���������� ��������� ��������� ������ }
  for I := 1 to ParamCount do
  begin
    { �������� �������� }
    S := ParamStr(I);
    { ���� � ��������� ������� }
    P := CasePos(Param, S, False);
    if P = 1 then
    begin
      { �������� ���������� - ����� }
      Result := Copy(S, P + Length(Param), 255);
      Exit;
    end;
  end;
  { ��������� ��� }
  Result := '';
end;

function GetParamValueDef(const Param: string; const Default: string): string;
begin
  Result := GetParamValue(Param);
  if Length(Result) = 0 then Result := Default;
end;

type
  TRegistryEx = class(TRegistry);

procedure RegEraseKey(Root: HKEY; const Key: string);
begin
  RegEraseKeyEx(Root, Key, True);
end;

procedure RegEraseKeyEx(Root: HKEY; const Key: string; SubKeys: Boolean);
begin
  { ������� ���������� }
  if SubKeys then RegEraseSubKeys(Root, Key);
  { ������� ��� ������ }
  with TRegistryEx.Create do
  try
    { ��������� ���� ������� }
    RootKey := Root;
    { ������� ������ }
    DeleteKey(PChar(Key));
  finally
    Free;
  end;
end;

procedure RegEraseSubKeys(Root: HKEY; const Key: string);
var
  Registry: TRegistryEx;

  procedure DoErase(const Key: string; SubIndex: Integer);
  var
    I: Integer;
    OldKey, NewKey: HKEY;
    Strings: TStringList;
  begin
    with Registry do
    begin
      { ���������� ������� ������ }
      OldKey := CurrentKey;
      { ��������� ����� ������ }
      NewKey := GetKey(Key);
      if NewKey <> 0 then
      try
        { ��������� �� ��������� ������ }
        SetCurrentKey(NewKey);
        { ������� ������ ����������� }
        Strings := TStringList.Create;
        try
          { ��������� ������ ����������� }
          GetKeyNames(Strings);
          { ������� ���������� }
          for I := Strings.Count - 1 downto 0 do
            DoErase(Strings[I], SubIndex + 1);
        finally
          Strings.Free;
        end;
      finally
        { ���������� ������� ������ }
        SetCurrentKey(OldKey);
        { ��������� ��������� ������ }
        RegCloseKey(NewKey);
      end;
      { ������� ��� ������ }
      if SubIndex > 1 then DeleteKey(PChar(Key));
    end;
  end;

begin
  { �������� ������ � ������� }
  Registry := TRegistryEx.Create;
  { ������� }
  with Registry do
  try
    { ��������� ���� ������� }
    RootKey := Root;
    { ������� ���������� }
    DoErase(Key, 1);
  finally
    Registry.Free;
  end;
end;

procedure RegReadKey(Root: HKEY; const Key: string; Strings: TStrings);
var
  I: Integer;
  Names: TStringList;
  Info: TRegDataInfo;
  Value: string;
begin
  with TRegistryEx.Create do
  try
    { ��������� ���� ������� }
    RootKey := Root;
    { ��������� ������ }
    if OpenKey(Key, False) then
    begin
      Strings.Clear;
      { ������� ����� ��� ���� }
      Names := TStringList.Create;
      try
        { ��������� ����� }
        GetValueNames(Names);
        { ��������� �������� }
        for I := 0 to Names.Count - 1 do
          { �������� ��� �������� }
          if GetDataInfo(Names[I], Info) then
          begin
            { �������� �������� � ��������� ������ }
            case Info.RegData of
              rdString, rdExpandString:
                { ������ }
                Value := ReadString(Names[I]);
              else
                { ��������� ���� �� �������������� }
                Continue;
            end;
            { ���������� �������� }
            Strings.Add(Format('%s=%s', [Names[I], Value]));
          end;
      finally
        Names.Free;
      end;
    end;
  finally
    Free;
  end;
end;

procedure RegWriteKey(Root: HKEY; const Key: string; Strings: TStrings);
var
  I: Integer;
begin
  with TRegistryEx.Create do
  try
    { ��������� ���� ������� }
    RootKey := Root;
    { ��������� ������ }
    if OpenKey(Key, True) then
      { ���������� �������� }
      with Strings do
        { ����������  }
        for I := 0 to Count - 1 do
          { ���������� }
          WriteString(Names[I], Values[Names[I]]);
  finally
    Free;
  end;
end;

const
  RegSignature = 'REGEDIT4';

procedure RegImport(const FileName: string);
var
  RegFile: TextFile;
  Registry: TRegistryEx;
  Line: string;

  procedure DoImportValue;
  var
    P: Integer;
    Name, Value: string;
    StrValue: string;
  begin
    with Registry do
    try
      { ��������� �������� }
      P := Pos('=', Line);
      if P <> 0 then
      begin
        { �������� ��� ����� }
        Name := Copy(Line, 2, P - 3);
        { �������� ��� }
        Line := Copy(Line, P + 1, Length(Line) - P);
        { ���� ���� �������� - ��������� ��� }
        if Length(Line) > 0 then
        begin
          { ��������� ��������� �������� }
          P := Pos('"', Line);
          if P = 1 then
          begin
            { �������� �������� }
            Value := Copy(Line, P + 1, Length(Line) - P - 1);
            { ����������� ������ }
            StrValue := StrToRegStr(Value);
            { ���������� � ������ }
            WriteString(Name, StrValue);
          end;
          { ��������� �������� DWORD }
          P := Pos('dword:', Line);
          if P = 1 then
          begin
          end;
          { ��������� �������� HEX }
          P := Pos('hex:', Line);
          if P = 1 then
          begin
          end;
        end;
      end;
    except
      Exit;
    end;
  end;

  procedure DoImportKey;
  var
    P: Integer;
    Root: HKEY;
    Key: string;
  begin
    with Registry do
    try
      { ��������� ������ }
      P := Pos('[', Line);
      if P = 1 then
      begin
        { �������� ��� ��������� ������� }
        P := Pos('\', Line);
        if P <> 0 then
        begin
          { ��������� ������ � �������� }
          Root := RegStrToRootKey(Copy(Line, 2, P - 2));
          { �������� ��� ������� }
          Key := Copy(Line, P + 1, Length(Line) - P - 1);
          { ��������� ������ � ������� }
          RootKey := Root;
          if OpenKey(Key, True) then
          try
            { ��������� �������� ������ }
            while not EOF(RegFile) do
            begin
              { ��������� ������ }
              Readln(RegFile, Line);
              { ���� ��� ����������� ��� ����� ������ - ����� }
              if (Length(Line) = 0) or (Line[1] = '[') then Exit;
              { ��������� ������ }
              DoImportValue;
            end;
          finally
            CloseKey;
          end;
        end;
      end;
    except
      Exit;
    end;
  end;

begin
  { ��������� ���� }
  AssignFile(RegFile, FileName);
  try
    { �������������� ������ }
    Reset(RegFile);
    { ���� �� ���� }
    if not EOF(RegFile) then
    begin
      { ��������� ����� }
      Readln(RegFile, Line);
      { ��������� ����� }
      if CompareText(Line, RegSignature) = 0 then
      begin
        { �������� ������ � ������� }
        Registry := TRegistryEx.Create;
        try
          { ��������� ������ }
          while not EOF(RegFile) do
          begin
            { ��������� ������ }
            Readln(RegFile, Line);
            { ��������� ������ }
            DoImportKey;
          end;
        finally
          Registry.Free;
        end;
      end;
    end;
  finally
    CloseFile(RegFile);
  end;
end;

procedure RegExport(Root: HKEY; const Key: string; const FileName: string);
var
  RegFile: TextFile;
  Registry: TRegistryEx;

  procedure DoSave(const Key, Path: string);
  var
    I: Integer;
    OldKey, NewKey: HKEY;
    Strings: TStringList;
    Line: string;
    Info: TRegDataInfo;
    StrValue: string;
  begin
    with Registry do
    begin
      { ���������� ������� ������ }
      OldKey := CurrentKey;
      { ��������� ����� ������ }
      NewKey := GetKey(Key);
      if NewKey <> 0 then
      try
        { ��������� �� ��������� ������ }
        SetCurrentKey(NewKey);
        { ������ - ����������� }
        Writeln(RegFile);
        { ��������� �������� ������� }
        Line := Format('[%s\%s]', [Path, Key]);
        { ���������� �������� ������� }
        Writeln(RegFile, Line);
        { ������� ������ �������� }
        Strings := TStringList.Create;
        try
          { �������� ��� �������� }
          GetValueNames(strings);
          { ���������� �������� }
          for I := 0 to Strings.Count - 1 do
            { �������� ��� �������� }
            if GetDataInfo(Strings[I], Info) then
            begin
              { �������� �������� � ��������� ������ }
              case Info.RegData of
                rdString, rdExpandString:
                  { ������ }
                  begin
                    { ��������� �������� }
                    StrValue := ReadString(Strings[I]);
                    { ����������� ������ }
                    StrValue := RegStrToStr(StrValue);
                    { ��������� ������ }
                    Line := Format('"%s"="%s"', [Strings[I], StrValue]);
                  end;
                rdInteger:
                  { DWORD }
                  begin
                  end;
                rdBinary:
                  { HEX }
                  begin
                  end;
                else
                  { ��������� ���� �� �������������� }
                  Continue;
              end;
              { ���������� �������� }
              Writeln(RegFile, Line);
            end;
        finally
          Strings.Free;
        end;
        { ������� ������ ����������� }
        Strings := TStringList.Create;
        try
          { ��������� ��������� }
          GetKeyNames(Strings);
          { ���������� ���������� }
          for I := 0 to Strings.Count - 1 do
            DoSave(Strings[I], Format('%s\%s', [Path, Key]));
        finally
          Strings.Free;
        end;
      finally
        { ���������� ������� ������ }
        SetCurrentKey(OldKey);
        { ��������� ��������� ������ }
        RegCloseKey(NewKey);
      end;
    end;
  end;

begin
  { ��������� ���� }
  AssignFile(RegFile, FileName);
  try
    { �������������� ������ }
    Rewrite(RegFile);
    { ���������� ����� ����� }
    Writeln(RegFile, RegSignature);
    { �������� ������ � ������� }
    Registry := TRegistryEx.Create;
    { ��������� }
    with Registry do
    try
      { ��������� ���� ������� }
      RootKey := Root;
      { ��������� ������ }
      DoSave(Key, RegRootKeyToStr(Root));
    finally
      Free;
    end;
  finally
    CloseFile(RegFile);
  end;
end;

function StrToRegStr(const Value: string): string;
var
  I: Integer;
begin
  { ��������� }
  Result := Value;
  { ������ "\\" �� "\" }
  I := Length(Result) - 1;
  while I > 0 do
  begin
    { ��������� ������ "\" }
    if (Result[I] = '\') and (Result[I + 1] = '\') then Delete(Result, I, 1);
    { ��������� ������ }
    Dec(I);
  end;
end;

function RegStrToStr(const Value: string): string;
var
  I: Integer;
begin
  { ��������� }
  Result := Value;
  { ������ "\" �� "\\" }
  I := Length(Result);
  while I > 0 do
  begin
    { ��������� ������ "\" }
    if Result[I] = '\' then Insert('\', Result, I + 1);
    { ��������� ������ }
    Dec(I);
  end;
end;

type
  TRootEntry = record
    Value: HKEY;
    Name: string;
  end;

const
  RootList: array[0..6] of TRootEntry = (
    (Value: HKEY_CLASSES_ROOT; Name: 'HKEY_CLASSES_ROOT'),
    (Value: HKEY_CURRENT_USER; Name: 'HKEY_CURRENT_USER'),
    (Value: HKEY_LOCAL_MACHINE; Name: 'HKEY_LOCAL_MACHINE'),
    (Value: HKEY_USERS; Name: 'HKEY_USERS'),
    (Value: HKEY_PERFORMANCE_DATA; Name: 'HKEY_PERFORMANCE_DATA'),
    (Value: HKEY_CURRENT_CONFIG; Name: 'HKEY_CURRENT_CONFIG'),
    (Value: HKEY_DYN_DATA; Name: 'HKEY_DYN_DATA'));

function RegRootKeyToStr(Root: HKEY): string;
var
  I: Integer;
begin
  for I := Low(RootList) to High(RootList) do
    if RootList[I].Value = Root then
    begin
      Result := RootList[I].Name;
      Exit;
    end;
  Result := IntToStr(Root);
end;

function RegStrToRootKey(const S: string): HKEY;
var
  I: Integer;
begin
  for I := Low(RootList) to High(RootList) do
    if CompareText(RootList[I].Name, S) = 0 then
    begin
      Result := RootList[I].Value;
      Exit;
    end;
  Result := StrToInt(S);
end;

function RegStrToRootKeyDef(const S: string; Default: HKEY): HKEY;
begin
  try
    Result := RegStrToRootKey(S);
  except
    Result := Default;
  end;
end;

function StrToTimeDef(const S: string; Default: TDateTime): TDateTime;
begin
  try
    Result := StrToTime(S);
  except
    Result := Default;
  end;
end;

function StrToDateDef(const S: string; Default: TDateTime): TDateTime;
begin
  try
    Result := StrToDate(S);
  except
    Result := Default;
  end;
end;

function TimeToLongStr(Time: TDateTime): string;
begin
  Result := FormatDateTime('hh:mm:ss', Time);
end;

function DateToLongStr(Date: TDateTime): string;
const
  MonthNames: array[1..12] of string = (
    '������',
    '�������',
    '�����',
    '������',
    '���',
    '����',
    '����',
    '�������',
    '��������',
    '�������',
    '������',
    '�������');
var
  I: Integer;
  M: array[1..12] of string;
begin
  { ��������� ������� ����� ������� �� ����� �� ���������� }
  for I := 1 to 12 do M[I] := LongMonthNames[I];
  try
    { ������������� ���� (�� ����������) }
    for I := 1 to 12 do LongMonthNames[I] := MonthNames[I];
    { ��������� }
    Result := FormatDateTime(LongDateFormat, Date);
  finally
    for I := 1 to 12 do LongMonthNames[I] := M[I];
  end;
end;

function DateTimeToLongStr(DateTime: TDateTime): string;
begin
  Result := DateToLongStr(DateTime) + ' ' + TimeToLongStr(DateTime);
end;

function TimeToShortStr(Time: TDateTime): string;
begin
  Result := FormatDateTime('hh:mm', Time);
end;

function DateToShortStr(Date: TDateTime): string;
begin
  Result := FormatDateTime('dd.mm.yyyy', Date);
end;

function MSecToStr(Time: Longint): string;
var
  Sec, Min, Hour: Integer;
begin
  { �������� ���������� �����, ����� � ������ }
  Hour := Time div 3600000;
  Min := (Time - Hour * 3600000) div 60000;
  Sec := (Time - Hour * 3600000 - Min * 60000) div 1000;
  { ��������� ��������� }
  if Sec > 0 then
    Result := IntToStr(Sec) + '���.'
  else
    Result := '';
  if Min > 0 then
    if Length(Result) > 0 then
      Result := IntToStr(Min) + '���. ' + Result
    else
      Result := IntToStr(Min) + '���.';
  if Hour > 0 then
    if Length(Result) > 0 then
      Result := IntToStr(Hour) + '�. ' + Result
    else
      Result := IntToStr(Hour) + '�.';
end;

function MSecToStrFmt(Time: Longint; const Format: string): string;
var
  MSec, Sec, Min, Hour: Integer;
begin
  { �������� ���������� �����, ����� � ������ }
  Hour := Time div 3600000;
  Min := (Time - Hour * 3600000) div 60000;
  Sec := (Time - (Hour * 3600000 + Min * 60000)) div 1000;
  MSec := Time - (Hour * 3600000 + Min * 60000 + Sec * 1000);
  { �������� ����� }
  Result := FormatDateTime(Format, EncodeTime(Hour, Min, Sec, MSec));
end;

var
  FPosCount: Integer = 0;

function GetDefFormPos: TPoint;
var
  X, Y, C: Integer;
begin
  { �������� ������� ����� ���� }
  X := GetSystemMetrics(SM_CXFRAME);
  Y := GetSystemMetrics(SM_CYFRAME);
  C := GetSystemMetrics(SM_CYCAPTION);
  { ��������� ��������� }
  Result.X := (X + C) * FPosCount;
  Result.Y := (Y + C) * FPosCount;
  { ����������� ������� ��������� }
  Inc(FPosCount);
  { ��������� ��� (��������� 6 ���������) }
  if FPosCount > 5 then FPosCount := 0;
end;

function GetDefFormBounds(Width, Height: Integer): TRect;
var
  P: TPoint;
begin
  { �������� ��������� ���� �� ��������� }
  P := GetDefFormPos;
  { ��������� }
  Result := Bounds(P.X, P.Y, Width, Height);
end;

procedure SetTopMostWindow(Wnd: HWND; TopMost, Activate: Boolean);
const
  Flags: array[Boolean] of Integer = (
    SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE,
    SWP_NOMOVE or SWP_NOSIZE);
begin
  if TopMost then
    SetWindowPos(Wnd, HWND_TOPMOST, 0, 0, 0, 0, Flags[Activate])
  else
    SetWindowPos(Wnd, HWND_NOTOPMOST, 0, 0, 0, 0, Flags[Activate]);
end;

function AppMessageBox(const Text, Caption: string; Flags: Longint): Integer;
var
  AppVisible: Boolean;
begin
  with Application do
  begin
    { ���������, ����� �� ���� ���������� }
    AppVisible := IsWindowVisible(Handle);
    { ���� ���������� �� ����� - ���������� ��� }
    if not AppVisible then ShowWindow(Handle, SW_SHOW);
    { ���������� ������ }
    Result := MessageBox(PChar(Text), PChar(Caption), Flags);
    { ���� ���������� ���� �������� - ����� ��� ����� }
    if not AppVisible then ShowWindow(Handle, SW_HIDE);
  end;
end;

procedure AppDelay(TimeOut: DWORD);
begin
  AppDelayEx(TimeOut, False, True, nil);
end;

function KeyboardProc(Code: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; far; stdcall;
begin
  Result := 1;
end;

function MouseProc(Code: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; far; stdcall;
begin
  Result := 1;
end;

procedure AppDelayEx(TimeOut: DWORD; AppTerminate, AppMessages: Boolean; DelayProc: TDelayProc);
var
  K, M: HHOOK;
  T: DWORD;
  C: Boolean;
begin
  { ����������� �� ��������� ��������� }
  if AppMessages then
  begin
    { ������������� ��������� ���������� � ����� }
    K := SetWindowsHookEx(WH_KEYBOARD, @KeyboardProc, 0, GetCurrentThreadID);
    M := SetWindowsHookEx(WH_MOUSE, @MouseProc, 0, GetCurrentThreadID);
  end
  else
  begin
    K := 0;
    M := 0;
  end;
  { �������� }
  try
    C := False;
    { �������� ������� ����� }
    T := GetTickCount;
    { ���� �������� }
    while True  do
    begin
      { ��������� ����� }
      if Abs(GetTickCount - T) > TimeOut then Break;
      { ���������, � �� ����������� �� ���������� }
      if AppTerminate then if Application.Terminated then Break;
      { ������������ ��������� }
      if AppMessages then Application.ProcessMessages;
      { ��������� �������� ����� }
      if Assigned(DelayProc) then
      begin
        DelayProc(C);
        if C then Break;
      end;
      { ������ ����� ������ ��������� }
      Sleep(5);
    end;
    { ������������ ����������� ��������� }
    if not AppMessages then
    begin
      Application.ProcessMessages;
      Application.HideHint;
    end;
  finally
    if K <> 0 then UnhookWindowsHookEx(K);
    if M <> 0 then UnhookWindowsHookEx(M);
  end;
end;

function GetVersionStr(const FileName, Key, Default: string): string;
const
  SLang = '\\VarFileInfo\\Translation';
  SBlock = '\\StringFileInfo\\%.4x%.4x\\%s';
type
  PLangList = ^TLangList;
  TLangList = array[0..MAXINT div SizeOf(LongRec) - 1] of LongRec;
var
  Handle: DWORD;
  Size: DWORD;
  Data: Pointer;
  Buffer: Pointer;
  Len: UINT;
  LangCount, I: Integer;
  Lang, CharSet: Word;
  Block: string;
begin
  Result := Default;
  Size := GetFileVersionInfoSize(PChar(FileName), Handle);
  if Size > 0 then
  begin
    GetMem(Data, Size);
    if Data <> nil then
    try
      if not GetFileVersionInfo(PChar(FileName), Handle, Size, Data) then Exit;
      if not VerQueryValue(Data, '\\', Buffer, Len) then Exit;
      if not VerQueryValue(Data, SLang, Buffer, Len) then Exit;
      LangCount := Len div SizeOf(LongRec);
      for I := 0 to LangCount - 1 do
      begin
        Lang := LongRec(PLangList(Buffer)^[I]).Lo;
        CharSet := LongRec(PLangList(Buffer)^[I]).Hi;
        Block := Format(SBlock, [Lang, CharSet, Key]);
        if VerQueryValue(Data, PChar(Block), Buffer, Len) then
        begin
          Len := StrLen(PChar(Buffer));
          if Len > 0 then
          begin
            SetString(Result, PChar(Buffer), Len);
            Exit;
          end;
        end;
      end;
    finally
      FreeMem(Data, Size);
    end;
  end;
end;

{$IFDEF VER90 }

function MinIntValue(const Data: array of Integer): Integer;
var
  I: Integer;
begin
  Result := Data[Low(Data)];
  for I := Low(Data) + 1 to High(Data) do
    if Result > Data[I] then Result := Data[I];
end;

function MaxIntValue(const Data: array of Integer): Integer;
var
  I: Integer;
begin
  Result := Data[Low(Data)];
  for I := Low(Data) + 1 to High(Data) do
    if Result < Data[I] then Result := Data[I];
end;

{$ENDIF}

end.
