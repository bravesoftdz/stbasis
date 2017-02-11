unit main;

interface

{
1 May 2000 Pete Mee
 - Added some Gopher+ functionality.
 - Added Active check box
30 Apr 2000 Pete Mee
 - Added Send No Reply option for testing (just closes connection).
29 Apr 2000 Pete Mee
 - Converted to new Indy component.
3 Oct 1999 Pete Mee
 - Got basic implementation & some Gopher+ guess work.
}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IdTCPServer, IdGopherServer, StdCtrls, IdComponent, IdGlobal, IdGopherConsts,
  IdBaseComponent;

const
     ServerInfo = 'Indy Gopher Server';
     TelnetInfo = 'Telnet : Example';
     TelnetUser = 'Anonymous';
     TelnetServer = '127.0.0.1';
     TelnetPort = 23;

     InfoMessage = 'Indy Gopher Server v1.0.  Basic ' +
      'Server written in a couple of hours by A. Peter Mee.' + EOL +
      'For more information on the Internet Direct (a.k.a. Indy) component ' +
      'suite, check out the web site: http://www.pbe.com/';

     ImageExtensions : Array [0..6] of String =
       ('jpg',
        'jpe',
        'jpeg',
        'tif',
        'tiff',
        'bmp',
        'pcx');

     SoundExtensions : Array [0..2] of String =
       ('au',
        'wav',
        'mp3');

     MovieExtensions : Array [0..3] of string =
       ('avi',
        'mpg',
        'mpe',
        'mpeg');

     HTMLExtensions : Array [0..2] of string =
       ('htm',
        'html',
        'shtml');

type
  TGopher = class(TForm)
    lstMon: TListBox;
    IdGopherServer1: TIdGopherServer;
    chkNoReply: TCheckBox;
    chkActive: TCheckBox;
    procedure IdGopherServer1Request(Thread: TIdPeerThread;
      Request: String);
    procedure FormCreate(Sender: TObject);
    procedure IdGopherServer1PlusRequest(Thread: TIdPeerThread; Request,
      PlusData: String);
    procedure chkActiveClick(Sender: TObject);
  private
    { Private declarations }

    procedure SendDirectoryContents(Thread : TIdPeerThread;
      Dir : String);
    procedure SendTextFile(Thread : TIdPeerThread;
      FName : String);
    procedure SendFile(Thread : TIdPeerThread;
      FName : String);
  public
    { Public declarations }
  end;

var
  Gopher: TGopher;

implementation

{$R *.DFM}

{ TODO: Modify DirectoryExists to work with Kylix...}

{$IFDEF KYLIX}
function DirectoryExists(Dir : String) : Boolean;
begin
  result := False;
end;
{$ELSE}
function DirectoryExists(Dir: String): Boolean;
var
  curDir: String;
begin
  //Quick & dirty programming.  Could be programmed neater using Delphi stuff
  //and faster using direct API calls - but I'm being lazy. ;-)

  //Grab current dir.
  GetDir(0, curDir);

  //Switch off file I/O checking
  {$I-}

  //Attempt to change
  ChDir(Dir);

  //Switch on file I/O checking
  {$I+}

  //Check the result
  if IOresult = 0
  then DirectoryExists := True
  else DirectoryExists := False;

  //Switch off file I/O checking in case the 'current' dir has been removed
  //during the above
  {$I-}

  //Change back
  ChDir(curDir);

  //Switch back to default
  {$I+}

  //Grab the result to free up the IOResult var.
  If IOResult = 0 then begin
  end;
end;
{$ENDIF}

procedure TGopher.SendDirectoryContents;
var
   sr : TWin32FindData;
   hnd : Integer;
   oldFile, str : String;
begin
     IdGopherServer1.SendDirectoryEntry(Thread,
       IdGopherItem_Information, ServerInfo,
       ServerInfo,
       IdGopherServer1.LocalName,
       IdGopherServer1.DefaultPort);
     IdGopherServer1.SendDirectoryEntry(Thread,
       IdGopherItem_Telnet, TelnetInfo,
       TelnetUser,
       TelnetServer,
       TelnetPort);
     hnd := FindFirstFile(PChar(IncludeTrailingBackslash(Dir) + '*.*'), sr);
     if hnd <> Integer(INVALID_HANDLE_VALUE) then begin
        oldFile := '';
        repeat
              if sr.dwFileAttributes and faDirectory = faDirectory then begin
                 if sr.cFileName = String('.') then begin
                    //Ignore
                 end else if sr.cFileName = '..' then begin
                     If Thread.Connection.Connected then begin
                        str := ExtractFilePath(Dir);
                        str := Copy(str, 1, length(str) - 1);
                        IdGopherServer1.SendDirectoryEntry(Thread,
                          IdGopherItem_Directory, '..', Str,
                          IdGopherServer1.LocalName,
                          IdGopherServer1.DefaultPort);
                     end;
                 
                 end else begin
                     If Thread.Connection.Connected then begin
                        IdGopherServer1.SendDirectoryEntry(Thread,
                          IdGopherItem_Directory, sr.cFileName,
                          IncludeTrailingBackslash(Dir) + sr.cFileName,
                          IdGopherServer1.LocalName,
                          IdGopherServer1.DefaultPort);
                     end;
                 end;
              end else begin
                  If Thread.Connection.Connected then begin
                     str := LowerCase(ExtractFileExt(sr.cFileName));
                     if length(str) > 1 then begin
                        str := Copy(str, 2, length(str));
                     end;
                     if str = 'txt' then begin
                        IdGopherServer1.SendDirectoryEntry(Thread,
                          IdGopherItem_Document, sr.cFileName,
                          IncludeTrailingBackslash(Dir) + sr.cFileName,
                          IdGopherServer1.LocalName,
                          IdGopherServer1.DefaultPort);
                     end else if str = 'uue' then begin
                        IdGopherServer1.SendDirectoryEntry(Thread,
                          IdGopherItem_UUE, sr.cFileName,
                          IncludeTrailingBackslash(Dir) + sr.cFileName,
                          IdGopherServer1.LocalName,
                          IdGopherServer1.DefaultPort);
                     end else if str = 'gif' then begin
                        IdGopherServer1.SendDirectoryEntry(Thread,
                          IdGopherItem_Gif, sr.cFileName,
                          IncludeTrailingBackslash(Dir) + sr.cFileName,
                          IdGopherServer1.LocalName,
                          IdGopherServer1.DefaultPort);
                     end else if PosInStrArray(str, ImageExtensions) <> -1 then begin
                        IdGopherServer1.SendDirectoryEntry(Thread,
                          IdGopherItem_Image, sr.cFileName,
                          IncludeTrailingBackslash(Dir) + sr.cFileName,
                          IdGopherServer1.LocalName,
                          IdGopherServer1.DefaultPort);
                     end else if PosInStrArray(str, SoundExtensions) <> -1 then begin
                        IdGopherServer1.SendDirectoryEntry(Thread,
                          IdGopherItem_Sound, sr.cFileName,
                          IncludeTrailingBackslash(Dir) + sr.cFileName,
                          IdGopherServer1.LocalName,
                          IdGopherServer1.DefaultPort);
                     end else if PosInStrArray(str, MovieExtensions) <> -1 then begin
                        IdGopherServer1.SendDirectoryEntry(Thread,
                          IdGopherItem_Movie, sr.cFileName,
                          IncludeTrailingBackslash(Dir) + sr.cFileName,
                          IdGopherServer1.LocalName,
                          IdGopherServer1.DefaultPort);
                     end else if PosInStrArray(str, HTMLExtensions) <> -1 then begin
                        IdGopherServer1.SendDirectoryEntry(Thread,
                          IdGopherItem_HTML, sr.cFileName,
                          IncludeTrailingBackslash(Dir) + sr.cFileName,
                          IdGopherServer1.LocalName,
                          IdGopherServer1.DefaultPort);
                     end else begin
                         IdGopherServer1.SendDirectoryEntry(Thread,
                           IdGopherItem_Binary, sr.cFileName,
                           IncludeTrailingBackslash(Dir) + sr.cFileName,
                           IdGopherServer1.LocalName,
                           IdGopherServer1.DefaultPort);
                     end;
                  end;
              end;

              oldFile := sr.cFileName;
              FindNextFile(hnd, sr);

        until oldFile = sr.cFileName;
        Windows.CloseHandle(hnd);
     end;
     Thread.Connection.Writeln('.');
end;

procedure TGopher.IdGopherServer1Request(
  Thread: TIdPeerThread; Request: String);
var
   str : String;
   i : Integer;
begin
  lstMon.Items.Add('Request: ' + Request);

  // Grab resource as specified by Request
  if Length(Request) > 0 then begin
    i := Pos(TAB, Request);
  end else begin
    i := -1;
  end;

  if chkNoReply.Checked then begin
    exit;
  end else if Request = '' then begin
    // Send root
    SendDirectoryContents(Thread, 'C:\');
  end else if Request = ServerInfo then begin
    Thread.Connection.WriteLn(InfoMessage);
    Thread.Connection.WriteLn('.');
  end else if i > 0 then begin
    Thread.Connection.WriteLn('+2');
  end else begin
    if DirectoryExists(Request) then begin
      SendDirectoryContents(Thread, Request);
    end else If FileExists(Request) then begin
      //Send the requested file
      str := LowerCase(ExtractFileExt(Request));
      If Length(str) > 1 then begin
        str := Copy(str, 2, length(str));
      end;
      if str = 'txt' then begin
        SendTextFile(Thread, Request);
        Thread.Connection.Write('.' + CR + LF);
      end else begin
        SendFile(Thread, Request);
      end;
    end else begin
      Thread.Connection.WriteLn('.');
    end;
  end;
  If Thread.Connection.Connected then begin
    try
      Thread.Connection.Disconnect;
    except
    end;
  end;
end;

procedure TGopher.IdGopherServer1PlusRequest(Thread: TIdPeerThread;
  Request, PlusData: String);
var
  Representation, LeftOvers : String;
  Views : TStringList;
begin
  lstMon.Items.Add('Request: ' + Request + TAB + PlusData);

  // This is a Gopher+ request.  Split into component parts:

  // Request remains as-is
  LeftOvers := PlusData; // Any additional data is stored here
  Representation := Fetch(LeftOvers, TAB); // Representational requirements
  Views := TStringList.Create;
  try
    if length(PlusData) > 0 then begin
      Thread.Connection.Write(IdGopherPlusData_ErrorBeginSign +
        'Error: No Plus extra data' + EOL + IdGopherPlusData_EndSign);

    end else if Length(Representation) = 0 then begin
      // Something strange - a gopher request with no indication of expentancy
      Thread.Connection.Write(IdGopherPlusData_UnknownSize);
      IdGopherServer1Request(Thread, Request);

    end else if (Representation[1] = IdGopherPlusInformation)
    or (Representation[1] = IdGopherPlusDirectoryInformation) then begin
      // Perform information retrieval on Request item or Request contents
      If length(Representation) > 1 then begin

        Representation := Copy(Representation, 2, length(Representation));

        // Only need to send those information items in Representation
        // Split it up into component parts:

        while Representation <> '' do begin
          Views.Add(IdGopherPlusIndicator + Fetch(Representation,
            IdGopherPlusIndicator));
          if Views[Views.Count - 1] = IdGopherPlusIndicator then begin
            Views.Delete(Views.Count - 1);
          end;
        end;

      end else begin
        // Send all representation items
        Views.Add(IdGopherPlusInfo);
        Views.Add(IdGopherPlusAdmin);
        Views.Add(IdGopherPlusViews);
      end;

      // Views is now set up
      if Representation[1] = IdGopherPlusInformation then begin
        // Send info on single item

        {TODO: Separate procedure for Info on single item }
      end else begin
        // Send info on directory

        {TODO: Iterate single directory & use above proc. for Info on each item}  
      end;
    end;
  finally
    Views.Free;
  end;

end;

procedure TGopher.SendTextFile;
var
   fio : TFileStream;
   str, str1, str2 : String;
   i, read : Integer;
const
  fReadSize = 4096;

  procedure SortAndSend;
  begin
    i := Pos(IdGopherPlusData_EndSign, str1);
    str2 := '';
    while i > 0 do begin
      str2 := str2 + Copy(str1, 1, i) + '.';
      str1 := Copy(str1, i + 1, length(str1));
      i := Pos(IdGopherPlusData_EndSign, str);
    end;
    str1 := str2 + str1;
    Thread.Connection.Write(str1);
  end;
begin
  fio := TFileStream.Create(FName, fmOpenRead);
  SetLength(str, fReadSize);
  UniqueString(str);
  read := fio.Read(str[1], fReadSize);
  while read = fReadSize do begin
    str1 := str;
    SortAndSend;
    read := fio.Read(str[1], fReadSize);
  end;
  str1 := Copy(str, 1, read);
  SortAndSend;
  Thread.Connection.Write('.');
end;

procedure TGopher.SendFile;
var
   fio : TFileStream;
   str : String;
   read : Integer;
const
  fReadSize = 4096;
begin
  fio := TFileStream.Create(FName, fmOpenRead);
  SetLength(str, fReadSize);
  UniqueString(str);
  read := fio.Read(str[1], fReadSize);
  while read = fReadSize do begin
    Thread.Connection.Write(str);
    read := fio.Read(str[1], fReadSize);
  end;
  if read > 0 then begin
    Thread.Connection.Write(Copy(str, 1, read));
  end;
end;

procedure TGopher.FormCreate(Sender: TObject);
begin
  IdGopherServer1.Active := True;
end;

procedure TGopher.chkActiveClick(Sender: TObject);
begin
  IdGopherServer1.Active := chkActive.Checked;
end;

end.
