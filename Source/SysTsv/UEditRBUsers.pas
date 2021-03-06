unit UEditRBUsers;

interface

{$I stbasis.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UEditRB, StdCtrls, Buttons, ExtCtrls, IBServices, IBQuery, db, IBDatabase,
  IB;

type
  TfmEditRBUser = class(TfmEditRB)
    lbName: TLabel;
    lbPass: TLabel;
    lbSqlname: TLabel;
    edName: TEdit;
    edPass: TEdit;
    chbHidePass: TCheckBox;
    edSqlName: TEdit;
    IBSecServ: TIBSecurityService;
    procedure edNameChange(Sender: TObject);
    procedure chbHidePassClick(Sender: TObject);
    procedure edNameKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edSqlNameKeyPress(Sender: TObject; var Key: Char);
  private
    function ConnectSecurityService: Boolean;
//    function AddUser(UserId: Integer): Boolean;
    function ChangeUser(UserId: Integer): Boolean;
    procedure GetCurrentUserIniData(Stream: TStream);
  protected
    function AddToRBooks: Boolean; override;
    function UpdateRBooks: Boolean; override;
    function CheckFieldsFill: Boolean; override;
  public
    olduser_id: Integer;
    olduser_name: string;
    procedure AddClick(Sender: TObject); override;
    procedure ChangeClick(Sender: TObject); override;
    procedure FilterClick(Sender: TObject); override;
    function GetPassword(UserName: String):String;
  end;

var
  fmEditRBUser: TfmEditRBUser;

implementation

uses USysTsvCode, USysTsvData, UMainUnited;

{$R *.DFM}               

procedure TfmEditRBUser.FilterClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TfmEditRBUser.GetCurrentUserIniData(Stream: TStream);
var
  qr: TIBQuery;
  sqls: string;
  UserId: String;
  Info: TInfoConnectUser;
begin
  qr:=TIBQuery.Create(nil);
  try
    FillChar(Info,SizeOf(Info),0);
    _GetInfoConnectUser(@Info);
    UserId:=IntToStr(Info.User_id);
    qr.Database:=IBDB;
    qr.Transaction:=ibtran;
    qr.Transaction.Active:=true;
    sqls:='Select inidata from '+tbUsers+' where user_id='+UserId+' ';
    qr.SQL.Add(sqls);
    qr.Open;
    if qr.Active and not qr.IsEmpty then
      TBlobField(qr.FieldByName('inidata')).SaveToStream(Stream);
  finally
    qr.Free;
  end;
end;

function TfmEditRBUser.AddToRBooks: Boolean;
var
  qr: TIBQuery;
  sqls: string;
  id: string;
  Stream: TMemoryStream;
begin
 Result:=false;
 try
  Screen.Cursor:=crHourGlass;
  qr:=TIBQuery.Create(nil);
  Stream:=TMemoryStream.Create;
  try
    id:=inttostr(GetGenId(IBDB,tbUsers,1));
    if not ChangeUser(Strtoint(id)) then exit;
    qr.Database:=IBDB;
    qr.Transaction:=ibtran;
    qr.Transaction.Active:=true;
    sqls:='Insert into '+tbUsers+
          ' (user_id,name,user_name,inidata) values '+
          '('+id+
          ','+QuotedStr(Trim(edName.Text))+
          ','+QuotedStr(Trim(edSqlName.Text))+
          ',:inidata)';
    qr.SQL.Add(sqls);
    GetCurrentUserIniData(Stream);
    Stream.Position:=0;
    qr.ParamByName('inidata').LoadFromStream(Stream,ftBlob);
    qr.ExecSQL;
    qr.Transaction.Commit;
    olduser_id:=StrToInt(id);

    Result:=true;
  finally
    Stream.Free;
    qr.Free;
    Screen.Cursor:=crDefault;
  end;
 except
  on E: EIBInterBaseError do begin
        TempStr:=TranslateIBError(E.Message);
        ShowErrorEx(TempStr);
        Assert(false,TempStr);
  end;
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end; 
end;

procedure TfmEditRBUser.AddClick(Sender: TObject);
begin
  if not CheckFieldsFill then exit;
  if not AddToRBooks then exit;
  ModalResult:=mrOk;
end;

function TfmEditRBUser.UpdateRBooks: Boolean;
var
  qr: TIBQuery;
  sqls: string;
  id: String;
begin
 Result:=false;
 try
  Screen.Cursor:=crHourGlass;
  qr:=TIBQuery.Create(nil);
  try
    if not ChangeUser(olduser_id) then exit;
    id:=inttostr(olduser_id);
    qr.Database:=IBDB;
    qr.Transaction:=IBTran;
    qr.Transaction.Active:=true;
    sqls:='Update '+tbUsers+
          ' set name='+QuotedStr(Trim(edName.Text))+
          ', user_name='+QuotedStr(Trim(edSqlName.Text))+
          ' where user_id='+id;
    qr.SQL.Add(sqls);
    qr.ExecSQL;
    qr.Transaction.Commit;

    Result:=true;
  finally
    qr.Free;
    Screen.Cursor:=crDefault;
  end;
 except
  on E: EIBInterBaseError do begin
        TempStr:=TranslateIBError(E.Message);
        ShowErrorEx(TempStr);
        Assert(false,TempStr);
  end;
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmEditRBUser.ChangeClick(Sender: TObject);
begin
  if ChangeFlag then begin
   if not CheckFieldsFill then exit;
   if not UpdateRBooks then exit;
  end; 
  ModalResult:=mrOk;
end;

function TfmEditRBUser.CheckFieldsFill: Boolean;
begin
  Result:=true;
  if trim(edName.Text)='' then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[lbName.Caption]));
    edName.SetFocus;
    Result:=false;
    exit;
  end;
  if trim(edSqlName.Text)='' then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[lbSqlName.Caption]));
    edSqlName.SetFocus;
    Result:=false;
    exit;
  end;
{  if trim(edPass.Text)='' then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[lbPass.Caption]));
    edPass.SetFocus;
    Result:=false;
    exit;
  end;}
  
end;

function TfmEditRBUser.ConnectSecurityService: Boolean;
var
  Srvname: array[0..ConstSrvName-1] of char;
  protocol: TProtocol;
  P: PInfoConnectUser;
begin
 Result:=false;
 try
  new(P);
  try
   ZeroMemory(P,sizeof(TInfoConnectUser));
   FillChar(Srvname,ConstSrvName,0);
   _GetProtocolAndServerName(PChar(IBDB.DatabaseName),protocol,Srvname);
   IBSecServ.ServerName := Srvname;
   IBSecServ.Protocol:=protocol;
   IBSecServ.LoginPrompt := False;
   if IBSecServ.Active then
    IBSecServ.Active := false;
   IBSecServ.Params.Clear;
   _GetInfoConnectUser(P);
   IBSecServ.Params.Add('user_name='+P.SqlUserName);
   IBSecServ.Params.Add('password='+P.UserPass);
//   IBSecServ.Params.Add('sql_role_name='+P.SqlRole);
   IBSecServ.Active := true;
   Result:=true;
  finally
   dispose(P);
  end;
 except
   {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end; 
end;

(*function TfmEditRBUser.AddUser(UserId: Integer): Boolean;
begin
  Result:=false;
  try
    if ConnectSecurityService then begin
     IBSecServ.UserName:=Trim(edSqlName.Text);
     IBSecServ.UserID:=UserId;
     IBSecServ.GroupID:=0;
     IBSecServ.Password:=Trim(edPass.Text);

     IBSecServ.AddUser;
     IBSecServ.Active := false;
     Result:=true;
    end;
  except
   {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
  end;
end;*)

function TfmEditRBUser.ChangeUser(UserId: Integer): Boolean;
var
  FlagExists: Boolean;
  i: Integer;
begin
  Result:=false;
  try
    if ConnectSecurityService then begin
      FlagExists:=false;
      IBSecServ.DisplayUser(Trim(edSqlName.Text));
      for i:=0 to IBSecServ.UserInfoCount-1 do begin
        if AnsiSameText(IBSecServ.UserInfo[i].UserName,Trim(edSqlName.Text)) then
           FlagExists:=true;
      end;
      IBSecServ.UserName:=Trim(edSqlName.Text);
      IBSecServ.Password:=Trim(edPass.Text);
      IBSecServ.UserID:=0;
      IBSecServ.GroupID:=0;

      if FlagExists then
        IBSecServ.ModifyUser
      else IBSecServ.AddUser;

      IBSecServ.Active := false;
      Result:=true;
    end;
  except
   {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
  end; 
end;

function TfmEditRBUser.GetPassword(UserName: String):String;
begin
  Result:=ConstDefaultPassword;
end;

procedure TfmEditRBUser.edNameChange(Sender: TObject);
begin
  inherited;
  ChangeFlag:=true;
end;

procedure TfmEditRBUser.chbHidePassClick(Sender: TObject);
begin
  if chbHidePass.Checked then begin
    edPass.PasswordChar:='*';
  end else begin
    edPass.PasswordChar:=#0;
  end;
end;

procedure TfmEditRBUser.edNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key='''' then Key:=#0;
end;


procedure TfmEditRBUser.FormCreate(Sender: TObject);
begin
  inherited;
  IBTran.AddDatabase(IBDB);
  IBDB.AddTransaction(IBTran);
end;

procedure TfmEditRBUser.edSqlNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key='''' then Key:=#0;
  if (Key in ['�'..'�']) then Key:=#0;
end;

end.
