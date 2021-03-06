unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Ras, RasHelperClasses;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    edPhone: TEdit;
    Label2: TLabel;
    edUser: TEdit;
    Label3: TLabel;
    edPass: TEdit;
    Dial: TButton;
    Memo1: TMemo;
    Create: TButton;
    Dialog: TButton;
    procedure DialClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CreateClick(Sender: TObject);
    procedure DialogClick(Sender: TObject);
  private
    procedure DialerNotify(Sender: TObject; State: TRasConnState; ErrorCode: DWORD);
  public
    Dialer: TRasDialer;
  end;

var
  Form1: TForm1;

implementation

uses RasUtils;

{$R *.dfm}

procedure TForm1.DialClick(Sender: TObject);
begin
  Dialer.PhoneNumber:=edPhone.Text;
  Dialer.UserName:=edUser.Text;
  Dialer.Password:=edPass.Text;
  Dialer.HangUp;
  Dialer.Dial;
end;

procedure TForm1.DialerNotify(Sender: TObject; State: TRasConnState; ErrorCode: DWORD);
begin
  with Memo1 do
  begin
    Lines.Add(RasConnStatusString(State, ErrorCode));
    SelStart := GetTextLen - 1;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Dialer:=TRasDialer.Create;
  Dialer.OnNotify:=DialerNotify;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dialer.Free;
end;

procedure TForm1.CreateClick(Sender: TObject);
var
  PB: TRasPhonebookEntry;
begin
  PB:=TRasPhonebookEntry.Create(nil,'������');
  try
    PB.Password:=edPass.Text;
    PB.UserName:=edUser.Text;
    PB.PhoneNumber:=edPhone.Text;
  finally
    PB.DeleteEntry;
    PB.Free;
  end;
end;

procedure TForm1.DialogClick(Sender: TObject);
begin
 ///  rasdial

end;

end.
