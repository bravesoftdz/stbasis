unit UDPClientMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IdBaseComponent, IdAntiFreezeBase, IdAntiFreeze, IdWinsock, StdCtrls,
  IdComponent, IdUDPBase, IdUDPClient, IdStack;

type
  TUDPMainForm = class(TForm)
    SourceGroupBox: TGroupBox;
    HostNameLabel: TLabel;
    HostAddressLabel: TLabel;
    HostName: TLabel;
    HostAddress: TLabel;
    UDPAntiFreeze: TIdAntiFreeze;
    PortLabel: TLabel;
    Port: TLabel;
    DestinationLabel: TLabel;
    DestinationAddress: TLabel;
    BufferSizeLabel: TLabel;
    BufferSize: TLabel;
    UDPMemo: TMemo;
    SendButton: TButton;
    UDPClient: TIdUDPClient;
    procedure FormCreate(Sender: TObject);
    procedure SendButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UDPMainForm: TUDPMainForm;

implementation

const
  HOSTNAMELENGTH = 80;
  RECIEVETIMEOUT = 5000; // milliseconds

{$R *.DFM}

procedure TUDPMainForm.FormCreate(Sender: TObject);
begin
  Randomize; // remove if you want reproducible results.
  HostName.Caption := UDPClient.LocalName;
  HostAddress.Caption := GStack.LocalAddress;
  Port.Caption := IntToStr(UDPClient.Port);
  DestinationAddress.Caption := UDPClient.Host;
  BufferSize.Caption := IntToStr(UDPClient.BufferSize);
  UDPClient.ReceiveTimeout := RECIEVETIMEOUT;
end;

procedure TUDPMainForm.SendButtonClick(Sender: TObject);
var
  MessageID: Integer;
  ThisMessage: String;
  ReceivedString: String;
begin
  MessageID := Random(MAXINT);
  ThisMessage := 'Message: ' + IntToStr(MessageID);
  UDPMemo.Lines.Add('Sending ' + ThisMessage);
  UDPClient.Send(ThisMessage);
  ReceivedString := UDPClient.ReceiveString();
  if ReceivedString = '' then
    UDPMemo.Lines.Add('No response received from the server after ' + IntToStr(UDPClient.ReceiveTimeout) + ' millseconds.')
  else
    UDPMemo.Lines.Add('Received: ' + ReceivedString)
end;

end.
