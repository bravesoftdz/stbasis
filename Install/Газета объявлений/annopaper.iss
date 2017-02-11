; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define AppVersion GetFileVersion(SourcePath+"\files\stbasis.exe")
#define AppPublisher "NextSoft"
#define AppPublisherURL "http://www.nextsoft.ru"
#define OutputDir SourcePath+"\_output"
#define SetupIconFile ""

#define DEMO

#ifdef DEMO
  #define AppName "������ ���������� ����"
  #define OutputBaseFilename "annopaper_demo_"+AppVersion
  #define AppID "{{41A5663F-BAE8-404C-AED4-F72E7D41C3B4}"
  #define LicenseFile SourcePath+"\files\license_demo.rtf"
  #define LicenseFileTwo "files\license_demo.rtf"
  #define InfoBeforeFile SourcePath+"\files\info_before_demo.rtf"
  #define InfoAfterFile SourcePath+"\files\info_after_demo.rtf"
#else
  #define AppName "������ ����������"
  #define OutputBaseFilename "annopaper_"+AppVersion
  #define AppID "{{916E59C3-0331-4AB6-AEF8-83B20C5EBB76}"
  #define LicenseFile SourcePath+"\files\license.rtf"
  #define LicenseFileTwo "files\license.rtf"
  #define InfoBeforeFile SourcePath+"\files\info_before.rtf"
  #define InfoAfterFile SourcePath+"\files\info_after.rtf"
#endif

#define ADMIN_MODULE
#define DESIGN_MODULE
;#define SYNC_MODULE
;#define SYNC_CLIENT_MODULE
;#define SYNC_SERVER_MODULE

[Setup]
AppName={#AppName}
AppVerName={#AppName} {#AppVersion}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppPublisherURL}
AppSupportURL={#AppPublisherURL}
AppUpdatesURL={#AppPublisherURL}
DefaultDirName={pf}\{#AppPublisher}\{#AppName}
DefaultGroupName={#AppName}
OutputDir={#OutputDir}
OutputBaseFilename={#OutputBaseFilename}
Compression=lzma/ultra
SolidCompression=true
AppID={#AppID}
InternalCompressLevel=ultra
VersionInfoVersion={#AppVersion}
VersionInfoCompany={#AppPublisher}
VersionInfoDescription={#AppName} Setup
VersionInfoTextVersion={#AppVersion}
VersionInfoCopyright={#AppPublisher}
MinVersion=4.0.950,5.0.2195
AppCopyright={#AppPublisher}
AppMutex=NextSoft_Annopaper
LicenseFile={#LicenseFile}
InfoBeforeFile={#InfoBeforeFile}
InfoAfterFile={#InfoAfterFile}
EnableDirDoesntExistWarning=true
AppVersion={#AppVersion}
UninstallDisplayName={#AppName} {#AppVersion}
UninstallDisplayIcon={app}\stbasis.exe
SetupIconFile={#SetupIconFile}
UserInfoPage=true
PrivilegesRequired=admin
;Encryption=true
;Password=E1492E04BD45168073D818831F587090

[Languages]
Name: russian; MessagesFile: compiler:Languages\Russian.isl

[Types]
Name: full; Description: ������ ���������; Flags: iscustom

[Files]
Source: files\stbasis.exe; DestDir: {app}; Flags: replacesameversion; Components: client
Source: files\stbasis.pth; DestDir: {app}; Flags: onlyifdoesntexist; Components: client
;Source: files\help.doc; DestDir: {app}; Flags: ignoreversion; Components: client
Source: {#LicenseFileTwo}; DestDir: {app}; Flags: ignoreversion; DestName: license.rtf; Components: client
Source: files\gds32.dll; DestDir: {sys}; Flags: replacesameversion; Components: client
Source: files\vcl50.bpl; DestDir: {app}; Flags: replacesameversion; Components: client
Source: files\vcldb50.bpl; DestDir: {app}; Flags: replacesameversion; Components: client
Source: files\vclib50.bpl; DestDir: {app}; Flags: replacesameversion; Components: client
Source: files\vcl50.rus; DestDir: {app}; Flags: replacesameversion; Components: client
Source: files\vcldb50.rus; DestDir: {app}; Flags: replacesameversion; Components: client
Source: files\vclib50.rus; DestDir: {app}; Flags: replacesameversion; Components: client
Source: files\midas.dll; DestDir: {app}; Flags: replacesameversion regserver noregerror; Components: client
Source: files\Firebird-1.5.5.4926-3-Win32.exe; DestDir: {tmp}; Flags: deleteafterinstall ignoreversion; Components: server
Source: files\stbasisudf.dll; DestDir: {app}; Flags: replacesameversion; Components: db
Source: files\stbasis.fdb; DestDir: {app}\data; Flags: onlyifdoesntexist; Components: db
Source: files\components.dll; DestDir: {app}; Flags: replacesameversion; Components: client
Source: files\interpreter.dll; DestDir: {app}; Flags: replacesameversion; Components: client
Source: files\annfree.dll; DestDir: {app}; Flags: replacesameversion; Components: client
Source: files\components.db; DestDir: {app}; Flags: onlyifdoesntexist; Components: client
Source: files\interpreter.db; DestDir: {app}; Flags: onlyifdoesntexist; Components: client
Source: files\annfree.db; DestDir: {app}; Flags: onlyifdoesntexist; Components: client
#ifdef ADMIN_MODULE
Source: files\systems.dll; DestDir: {app}; Flags: replacesameversion; Components: admin
Source: files\systems.db; DestDir: {app}; Flags: onlyifdoesntexist; Components: admin
#endif
#ifdef DESIGN_MODULE
Source: files\design.dll; DestDir: {app}; Flags: replacesameversion; Components: design
Source: files\design.db; DestDir: {app}; Flags: onlyifdoesntexist; Components: design
#endif
#ifdef SYNC_CLIENT_MODULE
Source: files\client.dll; DestDir: {app}; Flags: replacesameversion; Components: sync\client
Source: files\client.db; DestDir: {app}; Flags: onlyifdoesntexist; Components: sync\client
#endif
#ifdef SYNC_SERVER_MODULE
Source: files\server.dll; DestDir: {app}; Flags: replacesameversion; Components: sync\server
Source: files\server.db; DestDir: {app}; Flags: onlyifdoesntexist; Components: sync\server
Source: files\stbasiss.exe; DestDir: {app}; Flags: replacesameversion; Components: sync\server
Source: files\stbasiss.ini; DestDir: {app}; Flags: replacesameversion; Components: sync\server
Source: files\stbasiss.log; DestDir: {app}; Flags: replacesameversion; Components: sync\server
#endif
Source: files\stbasis.log; DestDir: {app}; Flags: onlyifdoesntexist; Components: client
Source: files\import.txt; DestDir: {app}; Flags: ignoreversion; Components: client

[Icons]
Name: {userprograms}\{#AppPublisher}\{#AppName}\{#AppName}; Filename: {app}\stbasis.exe; WorkingDir: {app}; IconFilename: {app}\stbasis.exe; Comment: {#AppName} {#AppVersion}; IconIndex: 0; Parameters: "/pathfile ""{app}\stbasis.pth"""; Components: client
#ifdef SYNC_SERVER_MODULE
Name: {userprograms}\{#AppPublisher}\{#AppName}\������ �������������; Filename: {app}\stbasiss.exe; WorkingDir: {app}; IconFilename: {app}\stbasiss.exe; Comment: ������ �������������; IconIndex: 0; Components: sync\server
#endif
Name: {userprograms}\{#AppPublisher}\{#AppName}\��������; Filename: {app}\license.rtf; WorkingDir: {app}; IconFilename: {app}\license.rtf; Components: client
;Name: {userprograms}\{#AppPublisher}\{#AppName}\����������� ������������; Filename: {app}\help.doc; WorkingDir: {app}; IconFilename: {app}\help.doc; Components: client
Name: {userprograms}\{#AppPublisher}\{#AppName}\������� {#AppName}; Filename: {uninstallexe}; WorkingDir: {app}; IconFilename: {uninstallexe}; Components: client
Name: {userdesktop}\{#AppName}; Filename: {app}\stbasis.exe; WorkingDir: {app}; IconFilename: {app}\stbasis.exe; Comment: {#AppName} {#AppVersion}; IconIndex: 0; Parameters: "/pathfile ""{app}\stbasis.pth"""; Components: client
#ifdef SYNC_SERVER_MODULE
Name: {userdesktop}\������ �������������; Filename: {app}\stbasiss.exe; WorkingDir: {app}; IconFilename: {app}\stbasiss.exe; Comment: ������ �������������; IconIndex: 0; Components: sync\server
#endif

[Components]
Name: client; Description: ��������� {#AppName} {#AppVersion} (�������); Types: full; Flags: fixed
Name: server; Description: ������ ��� ������ Firebird 1.5.5.4926; Types: full
Name: db; Description: ���� ������; Types: full
#ifdef ADMIN_MODULE
Name: admin; Description: �����������������; Types: full
#endif
#ifdef DESIGN_MODULE
Name: design; Description: ��������������; Types: full
#endif
#ifdef SYNC_MODULE
Name: sync; Description: �������������; Types: full; Flags: checkablealone
#endif
#ifdef SYNC_CLIENT_MODULE
Name: sync\client; Description: ������ �������������; Types: full; Flags: exclusive
#endif
#ifdef SYNC_SERVER_MODULE
Name: sync\server; Description: ������ �������������; Types: full; Flags: exclusive
#endif

[Run]
Filename: {tmp}\Firebird-1.5.5.4926-3-Win32.exe; WorkingDir: {tmp}; Components: server; StatusMsg: ��������� ������� Firebird; Parameters: /silent; Flags: runhidden
Filename: {app}\stbasis.exe; Parameters: /inclination true; WorkingDir: {app}; Flags: runhidden waituntilidle; Components: client
#ifdef DEMO
Filename: {app}\stbasis.exe; Parameters: /runcount true 100; WorkingDir: {app}; Flags: runhidden waituntilidle; Components: client
#endif
Filename: {app}\stbasis.exe; WorkingDir: {app}; Flags: postinstall nowait skipifsilent; Parameters: "/pathfile ""{app}\stbasis.pth"""; Components: client; Description: ��������� {#AppName}

[Dirs]
Name: {app}\temp; Components: client

[Code]
var
  SystemDb: String;
  PageUpdate: TWizardPage;
  LabelInfo: TLabel;
  LabelUser: TLabel;
  EditUser: TEdit;
  LabelPass: TLabel;
  EditPass: TPasswordEdit;
  LabelPath: TLabel;
  EditPath: TEdit;
  ButtonPath: TButton;
  LabelFile: TLabel;
  EditFile: TEdit;
  ButtonFile: TButton;

function GetFirebirdPath: String;
var
  S: String;
begin
  Result:='';
  SystemDb:='';
  RegQueryStringValue(HKEY_LOCAL_MACHINE,'SOFTWARE\Firebird Project\Firebird Server\Instances',
                     'DefaultInstance',Result);
  if not DirExists(Result) then
    RegQueryStringValue(HKEY_LOCAL_MACHINE,'SOFTWARE\Borland\InterBase\CurrentVersion',
                       'RootDirectory',Result);
  if DirExists(Result) then begin
    S:=Result+'security.fdb';
    if FileExists(S) then begin
      SystemDb:=ExtractFileName(S);
    end else begin
      S:=Result+'isc4.gdb';
      if FileExists(S) then begin
        SystemDb:=ExtractFileName(S);
      end;
    end;
  end else begin
    Result:='';
    SystemDb:='';
    if WizardForm.ComponentsList.Checked[1] then begin
      S:=ExpandConstant('{pf}');
      Result:=S+'\Firebird\Firebird_1_5\';
      SystemDb:='security.fdb';
    end;
  end;
end;

procedure ButtonPathOnClick(Sender: TObject);
var
  Dir: String;
begin
  Dir:=EditPath.Text;
  if BrowseForFolder('������� ���� � ������� ��� ������ Firebird',Dir,false) then
    EditPath.Text:=Dir;
end;

procedure ButtonFileOnClick(Sender: TObject);
var
  Filename: String;
begin
  Filename:=EditFile.Text;
  if GetOpenFileName('�������� ��������� ���� ������ Firebird',Filename,EditPath.Text,
                     '���� ������ Firebird (*.fdb)|*.fdb|���� ������ Interbase (*.gdb)|*.gdb|��� �����|*.*',
                     '') then
    EditFile.Text:=ExtractFileName(Filename);
end;

function PageUpdateCreatePage(PreviousPageId: Integer): Integer;
begin
  PageUpdate := CreateCustomPage(PreviousPageId,
                                 '���������� ������� ��� ������ Firebird',
                                 '����������, ������� ������ ��� ����������.');

  LabelInfo := TLabel.Create(PageUpdate);
  with LabelInfo do
  begin
    Parent := PageUpdate.Surface;
    Caption :='��� ���������� ������ ��������� {#AppName}, ���������� ���������� ���������� ������� ��� ������ Firebird.';
    Left := ScaleX(8);
    Top := ScaleY(8);
    Width := ScaleX(399);
    Height := ScaleY(37);
    AutoSize := False;
    WordWrap := True;
  end;

  LabelUser := TLabel.Create(PageUpdate);
  with LabelUser do
  begin
    Parent := PageUpdate.Surface;
    Caption :='������������ ��:';
    Left := ScaleX(23);
    Top := ScaleY(56);
    Width := ScaleX(94);
    Height := ScaleY(13);
    Alignment := taRightJustify;
    FocusControl := EditUser;
  end;

  EditUser := TEdit.Create(PageUpdate);
  with EditUser do
  begin
    Parent := PageUpdate.Surface;
    Left := ScaleX(125);
    Top := ScaleY(53);
    Width := ScaleX(100);
    Height := ScaleY(21);
    TabOrder := 0;
    Text := 'SYSDBA';
  end;

  LabelPass := TLabel.Create(PageUpdate);
  with LabelPass do
  begin
    Parent := PageUpdate.Surface;
    Caption := '������:';
    Left := ScaleX(244);
    Top := ScaleY(56);
    Width := ScaleX(41);
    Height := ScaleY(13);
    Alignment := taRightJustify;
    FocusControl := EditPass;
  end;

  EditPass := TPasswordEdit.Create(PageUpdate);
  with EditPass do
  begin
    Parent := PageUpdate.Surface;
    Left := ScaleX(294);
    Top := ScaleY(52);
    Width := ScaleX(100);
    Height := ScaleY(21);
    TabOrder := 1;
    Text := 'masterkey';
  end;

  LabelPath := TLabel.Create(PageUpdate);
  with LabelPath do
  begin
    Parent := PageUpdate.Surface;
    Caption := '���� � ������� ��� ������ Firebird:';
    Left := ScaleX(23);
    Top := ScaleY(90);
    Width := ScaleX(183);
    Height := ScaleY(13);
    FocusControl := EditPath;
  end;

  EditPath := TEdit.Create(PageUpdate);
  with EditPath do
  begin
    Parent := PageUpdate.Surface;
    Left := ScaleX(23);
    Top := ScaleY(110);
    Width := ScaleX(289);
    Height := ScaleY(21);
    TabOrder := 2;
    Text := GetFirebirdPath;
  end;

  ButtonPath := TButton.Create(PageUpdate);
  with ButtonPath do
  begin
    Parent := PageUpdate.Surface;
    Caption := '�����';
    Left := ScaleX(319);
    Top := ScaleY(109);
    Width := ScaleX(75);
    Height := ScaleY(23);
    TabOrder := 3;
    OnClick := @ButtonPathOnClick;
  end;

  LabelFile := TLabel.Create(PageUpdate);
  with LabelFile do
  begin
    Parent := PageUpdate.Surface;
    Caption := '��������� ���� ������ Firebird:';
    Left := ScaleX(23);
    Top := ScaleY(146);
    Width := ScaleX(165);
    Height := ScaleY(13);
    FocusControl := EditFile;
  end;

  EditFile := TEdit.Create(PageUpdate);
  with EditFile do
  begin
    Parent := PageUpdate.Surface;
    Left := ScaleX(23);
    Top := ScaleY(166);
    Width := ScaleX(289);
    Height := ScaleY(21);
    TabOrder := 4;
    Text := SystemDb;
  end;

  ButtonFile := TButton.Create(PageUpdate);
  with ButtonFile do
  begin
    Parent := PageUpdate.Surface;
    Caption := '�����';
    Left := ScaleX(319);
    Top := ScaleY(165);
    Width := ScaleX(75);
    Height := ScaleY(23);
    TabOrder := 5;
    OnClick := @ButtonFileOnClick;
  end;

  Result := PageUpdate.ID;
end;

procedure InitializeWizard();
begin
  PageUpdateCreatePage(wpSelectComponents);
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result:=false;
  if PageID=PageUpdate.ID then begin
    Result:=not WizardForm.ComponentsList.Checked[2];
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode: Integer;
  S: String;
begin
  case CurStep of
    ssPostInstall: begin
      if WizardForm.ComponentsList.Checked[2] then begin
        S:=EditPath.Text+'\udf';
        if DirExists(S) then begin
          FileCopy(ExpandConstant('{app}\stbasisudf.dll'),S+'\stbasisudf.dll',false);
        end;
        S:='/updateserver "'+EditUser.Text+'" "'+EditPass.Text+'" "'+EditPath.Text+'\'+EditFile.Text+'"';
        Exec(ExpandConstant('{app}\stbasis.exe'),S,ExpandConstant('{app}'),SW_SHOWNORMAL,ewWaitUntilTerminated,ResultCode);
        BringToFrontAndRestore();
      end;
    end;
  end;
end;
