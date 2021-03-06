unit StbasisSTCPServer;

interface

uses Classes, SysUtils,
     IdTCPServer, IdSocketHandle,
     StbasisSPrimaryDb, StbasisSConfig, StbasisSLog, StbasisSCrypter;

type
  TStbasisSTCPServer=class;

  TStbasisSTCPServerCustom=class(TIdTCPServer)
  private
    FServer: TStbasisSTCPServer;
  public
    property Server: TStbasisSTCPServer read FServer write FServer;
  end;

  TThreadClient=class(TObject)
  private
    FKeyOutHash: String;
    FOfficeName: string;
    FOfficeId: Integer;
    FOfficeKey: string;
    FOfficeKeyHash: string;
    FConnection: TIdTCPServerConnection;
  public
    function IsInit: Boolean;

    property KeyOutHash: String read FKeyOutHash write FKeyOutHash;
    property OfficeName: string read FOfficeName write FOfficeName;
    property OfficeId: Integer read FOfficeId write FOfficeId;
    property OfficeKey: String read FOfficeKey write FOfficeKey;
    property OfficeKeyHash: string read FOfficeKeyHash write FOfficeKeyHash;
    property Connection: TIdTCPServerConnection read FConnection write FConnection;
  end;

  TActivityEvent=procedure (Active: Boolean) of object;

  TStbasisSTCPServer=class(TComponent)
  private
    FPrimaryDb: TStbasisSPrimaryDb;
    FConfig: TStbasisSConfig;
    FLog: TStbasisSLog;
    FTCPServer: TStbasisSTCPServerCustom;
    FBindings: String;
    FCrypter: TStbasisSCrypter;
    FClients: TThreadList;
    FOnActivity: TActivityEvent;
    procedure TCPServerOnConnect(AThread: TIdPeerThread);
    procedure TCPServerOnDisconnect(AThread: TIdPeerThread);
    procedure TCPServerOnException(AThread: TIdPeerThread; AException: Exception);
    procedure TCPServerOnExecute(AThread: TIdPeerThread);

    procedure CommandInit(AClient: TThreadClient);
    procedure CommandData(AClient: TThreadClient);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Init;
    procedure Done;
    procedure Start;
    procedure Stop;

    property PrimaryDb: TStbasisSPrimaryDb read FPrimaryDb write FPrimaryDb;
    property Config: TStbasisSConfig read FConfig write FConfig;
    property Log: TStbasisSLog read FLog write FLog;
    property Crypter: TStbasisSCrypter read FCrypter write FCrypter;
    property OnActivity: TActivityEvent read FOnActivity write FOnActivity;
  end;

implementation

uses
     StbasisSData, StbasisSUtils, StbasisSGlobal;

{ TStbasisSTCPServerCustom }

{ TThreadClient }

function TThreadClient.IsInit: Boolean;
begin
  Result:=Trim(FOfficeName)<>'';
end;

{ TStbasisSTCPServer }

constructor TStbasisSTCPServer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FClients:=TThreadList.Create;
  FTCPServer:=TStbasisSTCPServerCustom.Create(nil);
  FTCPServer.DefaultPort:=TCPServerDefaultPort;
  FTCPServer.Server:=Self;
  FTCPServer.OnConnect:=TCPServerOnConnect;
  FTCPServer.OnDisconnect:=TCPServerOnDisconnect;
  FTCPServer.OnException:=TCPServerOnException;
  FTCPServer.OnExecute:=TCPServerOnExecute;
end;

destructor TStbasisSTCPServer.Destroy;
begin
  FTCPServer.Free;
  FClients.Free;
  inherited Destroy;
end;

procedure TStbasisSTCPServer.Init;
begin
  FBindings:=FConfig.ReadString(SSectionTCPServer,SParamBindings,FBindings);
end;

procedure TStbasisSTCPServer.Done;
begin
end;

procedure TStbasisSTCPServer.Start;
var
  i: Integer;
  List: TStringList;
  Handle: TIdSocketHandle;
  S: string; 
begin
  List:=TStringList.Create;
  try
    FTCPServer.Active:=false;
    FTCPServer.Bindings.Clear;
    StrParseDelim(FBindings,',',List);
    for i:=0 to List.Count-1 do begin
      S:=List.Strings[i];
      if Trim(S)<>'' then begin
        Handle:=FTCPServer.Bindings.Add;
        Handle.IP:=Copy(S,1,AnsiPos(':',S)-1);
        Handle.Port:=StrToIntDef(Copy(S,AnsiPos(':',S)+1,Length(S)),FTCPServer.DefaultPort);
      end;
    end;
    FTCPServer.Active:=true;
    FLog.WriteToFile(Format('TCP Server started: %s success',[FBindings]),ltInformation);
  finally
    List.Free;
  end;
end;

procedure TStbasisSTCPServer.Stop;
begin
  FTCPServer.Active:=false;
  FLog.WriteToFile('TCP Server stopped success',ltInformation);
end;

procedure TStbasisSTCPServer.TCPServerOnConnect(AThread: TIdPeerThread);
var
  Client: TThreadClient;
begin
  if Assigned(FOnActivity) then FOnActivity(true); 
  with AThread.Connection.Socket.Binding do begin
    Client:=TThreadClient.Create;
    Client.KeyOutHash:='';
//    Client.KeyOutHash:=FCrypter.HashString(Format('%s:%d',[Ip,Port]),haMD5,hfHEX); �� �������� ����� ������
    FLog.WriteToFile(Format('Remote client %d KeyOutHash: %s',[AThread.Handle,Client.KeyOutHash]),ltInformation);
    Client.Connection:=AThread.Connection;
    AThread.Data:=Client;
    try
      FClients.LockList.Add(Client);
    finally
      FClients.UnlockList;
    end;
    FLog.WriteToFile(Format('Remote client %d %s:%d connect to %s:%d',[AThread.Handle,PeerIp,PeerPort,IP,Port]),ltInformation);
  end;
end;

procedure TStbasisSTCPServer.TCPServerOnDisconnect(AThread: TIdPeerThread);
var
  Client: TThreadClient;
  List: TList;
begin
  Client:=TThreadClient(AThread.Data);
  if Assigned(Client) then begin
    try
      List:=FClients.LockList;
      List.Remove(Client);
      if Assigned(FOnActivity) then
        FOnActivity(List.Count>0);         
    finally
      FClients.UnlockList;
    end;
    AThread.Data:=nil;
  end;
  FLog.WriteToFile(Format('Remote client %d disconnect',[AThread.Handle]),ltInformation);
end;

procedure TStbasisSTCPServer.TCPServerOnException(AThread: TIdPeerThread; AException: Exception);
begin
  FLog.WriteToFile(Format('Remote client %d exception: %s',[AThread.Handle,AException.Message]),ltError);
end;

procedure TStbasisSTCPServer.TCPServerOnExecute(AThread: TIdPeerThread);
var
  Global: TStbasisSGlobal;
  Client: TThreadClient;
begin
  Client:=TThreadClient(AThread.Data);
  if Assigned(Client) then begin
    FillChar(Global,SizeOf(Global),0);
    with AThread.Connection do begin
      ReadBuffer(Global,SizeOf(Global));
      case Global.Command of
        gcInit: CommandInit(Client);
        gcData: CommandData(Client);
        gcDone: begin
          Client.Connection.Disconnect;
        end;  
      end;
    end;
  end;   
end;

procedure TStbasisSTCPServer.CommandInit(AClient: TThreadClient);
var
  GlobalInit: TStbasisSGlobalInit;
  GlobalResult: TStbasisSGlobalResult;
  OfficeName: String;
  OfficeId: Integer;
  OfficeKey: String;
begin
  FillChar(GlobalInit,SizeOf(GlobalInit),0);
  FillChar(GlobalResult,SizeOf(GlobalResult),0);
  with AClient.Connection do begin
    ReadBuffer(GlobalInit,SizeOf(GlobalInit));
    OfficeName:=GlobalInit.OfficeName;
    try
      try
        if FPrimaryDb.CheckOffice(OfficeName,OfficeId,OfficeKey) then begin
          AClient.OfficeName:=OfficeName;
          AClient.OfficeId:=OfficeId;
          AClient.OfficeKey:=OfficeKey;
          AClient.OfficeKeyHash:=FCrypter.HashString(OfficeKey,haMD5,hfHEX);
          FLog.WriteToFile(Format('CommandInit OfficeKeyHash: %s success',[AClient.OfficeKeyHash]),ltInformation);
          GlobalResult.Code:=GLOBAL_RESULT_SUCCESS;
        end;
      except
        on E: Exception do begin
          GlobalResult.Code:=GLOBAL_RESULT_ERROR;
          GlobalResult.Message:='����������� ����';
        end;
      end;
    finally
      WriteBuffer(GlobalResult,SizeOf(GlobalResult),true);
    end;
  end;
end;

procedure TStbasisSTCPServer.CommandData(AClient: TThreadClient);
var
  GlobalData: TStbasisSGlobalData;
  GlobalResult: TStbasisSGlobalResult;
  Stream: TMemoryStream;
  RealyKey: String;
  Size: Integer;
  IsError: Boolean;
  ErrorStr: string;
  AStreamHash: String;
begin
  FillChar(GlobalData,SizeOf(GlobalData),0);
  FillChar(GlobalResult,SizeOf(GlobalResult),0);
  AClient.Connection.ReadBuffer(GlobalData,SizeOf(GlobalData));
  if not AClient.IsInit then begin
    AClient.Connection.Disconnect;
  end else begin
    try
      try
        IsError:=false;
        // �������� ��������
        Stream:=TMemoryStream.Create;
        try
          with AClient.Connection do begin
            try
              FPrimaryDb.GetOutDataDesc(AClient.OfficeId,Stream);
              FLog.WriteToFile('GetOutDataDesc success',ltInformation);
            except
              On E: Exception do begin
                IsError:=true;
                ErrorStr:=E.Message;
                FLog.WriteToFile(Format('GetOutDataDesc error: %s',[E.Message]),ltError);
              end;
            end;
            Stream.Position:=0;
            AStreamHash:=FCrypter.HashStream(Stream,haMD5,hfHEX);
            FLog.WriteToFile(Format('GetOutDataDesc StreamHash: %s',[AStreamHash]),ltInformation);
            Stream.Position:=0;
            RealyKey:=Format('%s%s',[AClient.KeyOutHash,AClient.OfficeKeyHash]);
            FCrypter.EncodeStream(RealyKey,Stream,caRC5,cmCTS);
            Stream.Position:=0;
            OpenWriteBuffer;
            WriteInteger(Stream.Size);
            WriteStream(Stream);
            CloseWriteBuffer;
          end;
        finally
          Stream.Free;
        end;
        // ��������� ������
        Stream:=TMemoryStream.Create;
        try
          with AClient.Connection do begin
            Size:=ReadInteger;
            ReadStream(Stream,Size,false);
            Stream.Position:=0;
            RealyKey:=Format('%s%s',[AClient.KeyOutHash,AClient.OfficeKeyHash]);
            FCrypter.DecodeStream(RealyKey,Stream,caRC5,cmCTS);
            Stream.Position:=0;
            AStreamHash:=FCrypter.HashStream(Stream,haMD5,hfHEX);
            FLog.WriteToFile(Format('SetNewData StreamHash: %s',[AStreamHash]),ltInformation);
            Stream.Position:=0;
            try
              FPrimaryDb.SetNewData(Stream);
              FLog.WriteToFile('SetNewData success',ltInformation);
            except
              On E: Exception do begin
                IsError:=true;
                ErrorStr:=E.Message;
                FLog.WriteToFile(Format('SetNewData error: %s',[E.Message]),ltError);
              end;
            end;
          end;
        finally
          Stream.Free;
        end;
        // �������� ������
        Stream:=TMemoryStream.Create;
        try
          with AClient.Connection do begin
            try
              FPrimaryDb.GetOutData(AClient.OfficeId,Stream);
              FLog.WriteToFile('GetOutData success',ltInformation);
            except
              On E: Exception do begin
                IsError:=true;
                ErrorStr:=E.Message;
                FLog.WriteToFile(Format('GetOutData error: %s',[E.Message]),ltError);
              end;
            end;
            Stream.Position:=0;
            AStreamHash:=FCrypter.HashStream(Stream,haMD5,hfHEX);
            FLog.WriteToFile(Format('GetOutData StreamHash: %s',[AStreamHash]),ltInformation);
            Stream.Position:=0;
            RealyKey:=Format('%s%s',[AClient.KeyOutHash,AClient.OfficeKeyHash]);
            FCrypter.EncodeStream(RealyKey,Stream,caRC5,cmCTS);
            Stream.Position:=0;
            OpenWriteBuffer;
            WriteInteger(Stream.Size);
            WriteStream(Stream);
            CloseWriteBuffer;
          end;
        finally
          Stream.Free;
        end;

        if IsError then begin
          raise Exception.Create(ErrorStr);
        end;

        FPrimaryDb.UpdateConstex;
        
        GlobalResult.Code:=GLOBAL_RESULT_SUCCESS;
      except
        On E: Exception do begin
          GlobalResult.Code:=GLOBAL_RESULT_ERROR;
          StrPCopy(@GlobalResult.Message,E.Message);
        end;
      end;
    finally
      AClient.Connection.WriteBuffer(GlobalResult,SizeOf(GlobalResult),true);
    end;
  end;
end;

end.
