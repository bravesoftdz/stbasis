unit fmTraceRouteMainU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IdBaseComponent, IdComponent, IdRawBase, IdRawClient, IdIcmpClient,
  ComCtrls, ActnList, StdCtrls, Spin, ExtCtrls, IdAntiFreezeBase,
  IdAntiFreeze;

type
  TfmTracertMain = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    lbLog: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    ActionList1: TActionList;
    edTarget: TEdit;
    seMaxHops: TSpinEdit;
    Button1: TButton;
    acGo: TAction;
    acResolve: TAction;
    acPing: TAction;
    acTrace: TAction;
    lvTrace: TListView;
    IdIcmpClient: TIdIcmpClient;
    IdAntiFreeze1: TIdAntiFreeze;
    Splitter1: TSplitter;
    Button2: TButton;
    acStop: TAction;
    procedure edTargetChange(Sender: TObject);
    procedure acResolveExecute(Sender: TObject);
    procedure acGoExecute(Sender: TObject);
    procedure acPingExecute(Sender: TObject);
    procedure acTraceExecute(Sender: TObject);
    procedure lvTraceCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure acStopExecute(Sender: TObject);
  private
    { Private declarations }
    bResolved: Boolean;
    ResolvedHost: String;
    Stopped: Boolean;
    function PingHost(Host: string; TTL: Integer): boolean;
    function FindItem(TTL: Integer; Add: boolean): TListItem;
  public
    { Public declarations }
  end;

var
  fmTracertMain: TfmTracertMain;

implementation


uses idStack, IdException;
{$R *.DFM}

procedure TfmTracertMain.edTargetChange(Sender: TObject);
begin
  bResolved := false;
end;

procedure TfmTracertMain.acResolveExecute(Sender: TObject);
begin
  bResolved := false;
  lbLog.Items.Append(Format('resolving %s',[edTarget.text]));
  try
    Application.ProcessMessages;
    ResolvedHost := gStack.WSGetHostByName(edTarget.text);
    bResolved := true;
    lbLog.Items.Append(format('%s resolved to %s',[edTarget.text, ResolvedHost]));
  except
    on e: EIdSocketError do
      lbLog.Items.text  := lbLog.Items.text + e.message;
  end;
end;

procedure TfmTracertMain.acGoExecute(Sender: TObject);
var
  saveCursor: TCursor;
begin
  saveCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
      Stopped := false;
      acGo.Enabled := false;
      acStop.enabled := true;
      acResolve.execute;
      if bResolved and not stopped then
      begin
        acPing.execute;
        if not stopped then
          acTrace.Execute;
      end;
      acGo.Enabled := true;
      acStop.enabled := false;
  finally
  	Screen.Cursor := saveCursor;
  end;  { try/finally }
end;

function TfmTracertMain.PingHost(Host: string; TTL: Integer): Boolean;
begin
  result := false;
  IdIcmpClient.Host := Host;
  IdIcmpClient.TTL := TTL;
  IdIcmpClient.ReceiveTimeout := 5000;
  IdIcmpClient.Ping;
  case IdIcmpClient.ReplyStatus.ReplyStatusType of
    rsEcho:
    begin
      lbLog.Items.Append(format('response from host %s in %d millisec.',
                                [
                                IdIcmpClient.ReplyStatus.FromIpAddress,
                                IdIcmpClient.ReplyStatus.MsRoundTripTime
                                ]));
      result := true;
    end;
    rsError:
      lbLog.Items.Append('Unknown error.');
    rsTimeOut:
      lbLog.Items.Append('Timed out.');
    rsErrorUnreachable:
      lbLog.Items.Append(format('Host %s reports destination network unreachable.',
                                [
                                IdIcmpClient.ReplyStatus.FromIpAddress
                                ]));
    rsErrorTTLExceeded:
      lbLog.Items.Append(format('Hope %d %s: TTL expired.',
                                [
                                IdIcmpClient.TTL,
                                IdIcmpClient.ReplyStatus.FromIpAddress
                                ]));
  end; // case
end;

procedure TfmTracertMain.acPingExecute(Sender: TObject);
begin
  PingHost(ResolvedHost, seMaxHops.value);
  Application.ProcessMessages;
end;

function TfmTracertMain.FindItem(TTL: Integer; Add: boolean): TListItem;
var
  i: Integer;
begin
  result := nil;
  // Find the TTL item
  if lvTrace.Items.Count < TTL Then
  begin
    for i := 0 to lvTrace.Items.Count - 1 do
    begin
      if StrToIntDef(lvTrace.Items[i].Caption, -1) = TTL then
      begin
        result := lvTrace.Items[i];
        Break;
      end;
    end;
  end;
  if not assigned( result ) then
  begin
    // Not found, add it
    result := lvTrace.Items.Add;
    result.Caption := IntToStr(TTL);
  end;
end;

procedure TfmTracertMain.acTraceExecute(Sender: TObject);
var
  TTL: Integer;
  Reached: boolean;
  aItem: TListItem;
begin
  TTL := 0;
  reached := false;
  lvTrace.Items.Clear;
  repeat
    inc(TTL);
    IdIcmpClient.Host := ResolvedHost;
    IdIcmpClient.TTL := TTL;
    IdIcmpClient.ReceiveTimeout := 5000;
    IdIcmpClient.Ping;
    aItem := FindItem(TTL, True);
    aItem.SubItems.Clear;
    case IdIcmpClient.ReplyStatus.ReplyStatusType of
      rsEcho:
      begin
        aItem.SubItems.Append(IdIcmpClient.ReplyStatus.FromIpAddress);
        aItem.SubItems.Append(format('Reached in : %d ms', [IdIcmpClient.ReplyStatus.MsRoundTripTime]));
        reached := true;
      end;
      rsError:
      begin
        aItem.SubItems.Append(IdIcmpClient.ReplyStatus.FromIpAddress);
        aItem.SubItems.Append('Unknown error.');
      end;
      rsTimeOut:
      begin
        aItem.SubItems.Append('?.?.?.?');
        aItem.SubItems.Append('Timed out.');
      end;
      rsErrorUnreachable:
      begin
        aItem.SubItems.Append(IdIcmpClient.ReplyStatus.FromIpAddress);
        aItem.SubItems.Append(format('Destination network unreachable', [IdIcmpClient.ReplyStatus.MsRoundTripTime]));
        break;
      end;
      rsErrorTTLExceeded:
      begin
        aItem.SubItems.Append(IdIcmpClient.ReplyStatus.FromIpAddress);
        aItem.SubItems.Append(format('TTL=%d', [IdIcmpClient.ReplyStatus.TimeToLive]));
      end;
    end; // case
    Application.ProcessMessages;
  until reached or (TTL > seMaxHops.value) or Stopped;
end;

procedure TfmTracertMain.lvTraceCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  Compare := StrToIntDef(Item1.Caption, -1) - StrToIntDef(Item2.Caption, -1);
end;

procedure TfmTracertMain.acStopExecute(Sender: TObject);
begin
  Stopped := true;
  acStop.enabled := false;
end;

end.
