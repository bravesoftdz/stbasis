unit UEditRBUsersEmp;

interface
{$I stbasis.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UEditRB, StdCtrls, Buttons, ExtCtrls, IBServices, IBQuery, db, IBDatabase,
  IB;

type
  TfmEditRBUsersEmp = class(TfmEditRB)
    lbEmp: TLabel;
    edEmp: TEdit;
    lbUsername: TLabel;
    edUsername: TEdit;
    bibEmp: TButton;
    bibUserName: TButton;
    procedure edEmpChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bibEmpClick(Sender: TObject);
    procedure bibUserNameClick(Sender: TObject);
  protected
    function AddToRBooks: Boolean; override;
    function UpdateRBooks: Boolean; override;
    function CheckFieldsFill: Boolean; override;
  public
    emp_id: Integer;
    oldemp_id: Integer;
    user_id: Integer;
    olduser_id: Integer;
    procedure AddClick(Sender: TObject); override;
    procedure ChangeClick(Sender: TObject); override;
    procedure FilterClick(Sender: TObject); override;
  end;

var
  fmEditRBUsersEmp: TfmEditRBUsersEmp;

implementation

uses USysTsvCode, USysTsvData, UMainUnited;

{$R *.DFM}

procedure TfmEditRBUsersEmp.FilterClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;


function TfmEditRBUsersEmp.AddToRBooks: Boolean;
var
  qr: TIBQuery;
  sqls: string;
begin
 Result:=false;
 try
  Screen.Cursor:=crHourGlass;
  qr:=TIBQuery.Create(nil);
  try
    qr.Database:=IBDB;
    qr.Transaction:=IBTran;
    qr.Transaction.Active:=true;
    sqls:='Insert into '+tbUsersEmp+
          ' (emp_id,user_id) values '+
          ' ('+inttostr(emp_id)+','+inttostr(user_id)+')';
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

procedure TfmEditRBUsersEmp.AddClick(Sender: TObject);
begin
  if not CheckFieldsFill then exit;
  if not AddToRBooks then exit;
  ModalResult:=mrOk;
end;

function TfmEditRBUsersEmp.UpdateRBooks: Boolean;
var
  qr: TIBQuery;
  sqls: string;
begin
 result:=false;
 try
  Screen.Cursor:=crHourGlass;
  qr:=TIBQuery.Create(nil);
  try
    qr.Database:=IBDB;
    qr.Transaction:=IBTran;
    qr.Transaction.Active:=true;
    sqls:='Update '+tbUsersEmp+
          ' set emp_id='+inttostr(emp_id)+
          ', user_id='+inttostr(user_id)+
          ' where emp_id='+inttostr(oldemp_id)+
          ' and user_id='+inttostr(olduser_id);
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

procedure TfmEditRBUsersEmp.ChangeClick(Sender: TObject);
begin
  if ChangeFlag then begin
   if not CheckFieldsFill then exit;
   if not UpdateRBooks then exit;
  end; 
  ModalResult:=mrOk;
end;

function TfmEditRBUsersEmp.CheckFieldsFill: Boolean;
begin
  Result:=true;
  if trim(edEmp.Text)='' then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[lbEmp.Caption]));
    bibEmp.SetFocus;
    Result:=false;
    exit;
  end;
  if trim(edUserName.Text)='' then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[lbUserName.Caption]));
    bibUserName.SetFocus;
    Result:=false;
    exit;
  end;
end;

procedure TfmEditRBUsersEmp.edEmpChange(Sender: TObject);
begin
  inherited;
  ChangeFlag:=true;
end;

procedure TfmEditRBUsersEmp.FormCreate(Sender: TObject);
begin
  inherited;
  IBTran.AddDatabase(IBDB);
  IBDB.AddTransaction(IBTran);

end;

procedure TfmEditRBUsersEmp.bibEmpClick(Sender: TObject);
var
  TPRBI: TParamRBookInterface;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tvibvModal;
  TPRBI.Locate.KeyFields:='emp_id';
  TPRBI.Locate.KeyValues:=emp_id;
  TPRBI.Locate.Options:=[loCaseInsensitive];
  if _ViewInterfaceFromName(NameRbkEmp,@TPRBI) then begin
   ChangeFlag:=true;
   emp_id:=GetFirstValueFromParamRBookInterface(@TPRBI,'emp_id');
   edEmp.Text:=GetFirstValueFromParamRBookInterface(@TPRBI,'fname')+' '+
               GetFirstValueFromParamRBookInterface(@TPRBI,'name')+' '+
               GetFirstValueFromParamRBookInterface(@TPRBI,'sname');
  end;
end;

procedure TfmEditRBUsersEmp.bibUserNameClick(Sender: TObject);
var
  TPRBI: TParamRBookInterface;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tvibvModal;
  TPRBI.Locate.KeyFields:='User_id';
  TPRBI.Locate.KeyValues:=User_id;
  TPRBI.Locate.Options:=[loCaseInsensitive];
  if _ViewInterfaceFromName(NameRbkUsers,@TPRBI) then begin
   ChangeFlag:=true;
   edUsername.Text:=GetFirstValueFromParamRBookInterface(@TPRBI,'name');
   User_id:=GetFirstValueFromParamRBookInterface(@TPRBI,'user_id');
  end;
end;

end.
