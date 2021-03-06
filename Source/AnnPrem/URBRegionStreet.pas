unit URBRegionStreet;

interface

{$I stbasis.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  URBMainGrid, Db, IBCustomDataSet, IBQuery, DBCtrls, StdCtrls, Buttons,
  ExtCtrls, dbgrids, IBDatabase, IB, Menus, tsvDbGrid, IBUpdateSQL;

type
   TfmRBAPRegionStreet = class(TfmRBMainGrid)
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bibRefreshClick(Sender: TObject);
    procedure bibAddClick(Sender: TObject);
    procedure bibChangeClick(Sender: TObject);
    procedure bibDelClick(Sender: TObject);
    procedure bibViewClick(Sender: TObject);
    procedure bibFilterClick(Sender: TObject);
  private
    isFindRegionName,isFindStreetName: Boolean;
    FindRegionName,FindStreetName: String;
  protected
    procedure GridDblClick(Sender: TObject); override;
    procedure SaveToIni;override;
    procedure LoadFromIni; override;
    function GetFilterString: string; override;
    procedure GridTitleClickWithSort(Column: TColumn; TypeSort: TTypeColumnSort); override;
    function GetSql: string; override;
  public
    procedure ActiveQuery(CheckPerm: Boolean);override;
  end;

var
  fmRBAPRegionStreet: TfmRBAPRegionStreet;

implementation

uses UMainUnited, USysTsvCode, USysTsvDM, USysTsvData, UEditRBUsersStreetName;

{$R *.DFM}

procedure TfmRBAPRegionStreet.FormCreate(Sender: TObject);
var
 cl: TColumn;
begin
 inherited;
 try
  Caption:=NameRbkAPRegionStreet;
  
  Mainqr.Database:=IBDB;
  IBTran.AddDatabase(IBDB);
  IBDB.AddTransaction(IBTran);

  cl:=Grid.Columns.Add;
  cl.FieldName:='REGION_NAME';
  cl.Title.Caption:='�����';
  cl.Width:=180;

  cl:=Grid.Columns.Add;
  cl.FieldName:='STREET_NAME';
  cl.Title.Caption:='�����';
  cl.Width:=180;
  LoadFromIni;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end; 
end;

procedure TfmRBAPRegionStreet.FormDestroy(Sender: TObject);
begin
  inherited;
  if FormState=[fsCreatedMDIChild] then
   fmRBAPRegionStreet:=nil;
end;

function TfmRBAPRegionStreet.GetSql: string;
begin
  Result:= inherited GetSql;
  if Trim(Result)<>'' then exit;
  Result:=SQLRbkAPRegionStreet+GetFilterString+GetLastOrderStr;
end;


procedure TfmRBAPRegionStreet.ActiveQuery(CheckPerm: Boolean);
var
 sqls: String;
begin
 try
  Mainqr.Active:=false;
  if CheckPerm then
   if not CheckPermission then exit;

  Screen.Cursor:=crHourGlass;
  Mainqr.DisableControls;
  try
   Mainqr.sql.Clear;
   sqls:=GetSql;
   Mainqr.sql.Add(sqls);
   Mainqr.Transaction.Active:=false;
   Mainqr.Transaction.Active:=true;
   Mainqr.Active:=true;
   SetImageFilter(isFindRegionName or isFindStreetName);
   ViewCount;
  finally
   Mainqr.EnableControls;
   Screen.Cursor:=crDefault;
  end;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBAPRegionStreet.GridTitleClickWithSort(Column: TColumn; TypeSort: TTypeColumnSort);
var
  fn: string;
  id1,id2: string;
begin
 try
   if not MainQr.Active then exit;
   fn:=Column.FieldName;
   if UpperCase(fn)=UpperCase('STREET_NAME') then fn:='S.NAME';
   if UpperCase(fn)=UpperCase('REGION_NAME') then fn:='R.NAME';
   id1:=MainQr.fieldByName('AP_REGION_ID').asString;
   id2:=MainQr.fieldByName('AP_STREET_ID').asString;
   SetLastOrderFromTypeSort(fn,TypeSort);
   ActiveQuery(false);
   MainQr.First;
   MainQr.Locate('AP_REGION_ID;AP_STREET_ID',VarArrayOf([id1,id2]),[LocaseInsensitive]);
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBAPRegionStreet.GridDblClick(Sender: TObject);
begin
  if not Mainqr.Active then exit;
  if Mainqr.RecordCount=0 then exit;
  if pnSQL.Visible and bibChange.Enabled then begin
   bibChange.Click;
  end else bibView.Click;
end;

procedure TfmRBAPRegionStreet.LoadFromIni;
begin
 inherited;
 try
   FindRegionName:=ReadParam(ClassName,'RegionName',FindRegionName);
   FindStreetName:=ReadParam(ClassName,'StreetName',FindStreetName);
   FilterInside:=ReadParam(ClassName,'Inside',FilterInside);
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBAPRegionStreet.SaveToIni;
begin
 Inherited;
 try
    WriteParam(ClassName,'RegionName',FindRegionName);
    WriteParam(ClassName,'StreetName',FindStreetName);
    WriteParam(ClassName,'Inside',FilterInside);
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBAPRegionStreet.bibRefreshClick(Sender: TObject);
begin
  ActiveQuery(true);
end;

procedure TfmRBAPRegionStreet.bibAddClick(Sender: TObject);
var
  fm: TfmEditRBUsersStreetName;
begin
 try
  if not Mainqr.Active then exit;
  fm:=TfmEditRBUsersStreetName.Create(nil);
  try
    fm.TypeEditRBook:=terbAdd;
    fm.ChangeFlag:=false;
    if fm.ShowModal=mrok then begin
     ActiveQuery(false);
     MainQr.Locate('AP_REGION_ID;AP_STREET_ID',VarArrayOf([fm.user_id,fm.StreetName_id]),[LocaseInsensitive]);
    end;
  finally
    fm.Free;
  end;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBAPRegionStreet.bibChangeClick(Sender: TObject);
var
  fm: TfmEditRBUsersStreetName;
begin
 try
  if Mainqr.isStreetNamety then exit;
  fm:=TfmEditRBUsersStreetName.Create(nil);
  try
    fm.TypeEditRBook:=terbChange;
    fm.StreetName_id:=Mainqr.fieldByName('StreetName_id').AsInteger;
    fm.oldStreetName_id:=fm.StreetName_id;
    fm.edStreetName.Text:=Mainqr.fieldByName('StreetNamename').AsString;
    fm.user_id:=Mainqr.fieldByName('user_id').AsInteger;
    fm.olduser_id:=fm.user_id;
    fm.edRegionName.Text:=Mainqr.fieldByName('RegionName').AsString;
    fm.ChangeFlag:=false;
    if fm.ShowModal=mrok then begin
     ActiveQuery(false);
     MainQr.Locate('user_id;StreetName_id',VarArrayOf([fm.user_id,fm.StreetName_id]),[LocaseInsensitive]);
    end;
  finally
    fm.Free;
  end;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBAPRegionStreet.bibDelClick(Sender: TObject);
var
  but: Integer;

  function DeleteRecord: Boolean;
  var
    qr: TIBQuery;
    sqls: string;
  begin
   Screen.Cursor:=crHourGlass;
   qr:=TIBQuery.Create(nil);
   try
    result:=false;
    try
     qr.Database:=IBDB;
     qr.Transaction:=IBTran;
     qr.Transaction.Active:=true;
     sqls:='Delete from '+tbUsersStreetName+
           ' where user_id='+ QuotedStr(Mainqr.FieldByName('user_id').asString)+
           ' and StreetName_id='+Mainqr.FieldByName('StreetName_id').asString;
     qr.sql.Add(sqls);
     qr.ExecSQL;
     qr.Transaction.Commit;
     ActiveQuery(false);
     Result:=true;
    except
     on E: EIBInterBaseError do begin
        TStreetNameStr:=TranslateIBError(E.Message);
        ShowErrorEx(TStreetNameStr);
        Assert(false,TStreetNameStr);
     end;
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   finally
    qr.Free;
    Screen.Cursor:=crDefault;
   end;

  end;

begin
  if  Mainqr.isStreetNamety then exit;
  but:=DeleteWarningEx('������� ������ ?');
  if but=mrYes then begin
    if not deleteRecord then begin
    end;
  end;
end;

procedure TfmRBAPRegionStreet.bibViewClick(Sender: TObject);
var
  fm: TfmEditRBUsersStreetName;
begin
 try
  if not Mainqr.Active then exit;
  if Mainqr.RecordCount=0 then exit;
  fm:=TfmEditRBUsersStreetName.Create(nil);
  try
    fm.TypeEditRBook:=terbView;
    fm.StreetName_id:=Mainqr.fieldByName('StreetName_id').AsInteger;
    fm.oldStreetName_id:=fm.StreetName_id;
    fm.edStreetName.Text:=Mainqr.fieldByName('StreetNamename').AsString;
    fm.user_id:=Mainqr.fieldByName('user_id').AsInteger;
    fm.olduser_id:=fm.user_id;
    fm.edRegionName.Text:=Mainqr.fieldByName('RegionName').AsString;
    if fm.ShowModal=mrok then begin
    end;
  finally
    fm.Free;
  end;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBAPRegionStreet.bibFilterClick(Sender: TObject);
var
  fm: TfmEditRBUsersStreetName;
  filstr: string;
begin
try
 fm:=TfmEditRBUsersStreetName.Create(nil);
 try
  fm.TypeEditRBook:=terbFilter;

  fm.edStreetName.Color:=clWindow;
  fm.edStreetName.ReadOnly:=false;
  fm.edRegionName.Color:=clWindow;
  fm.edRegionName.ReadOnly:=false;

  if Trim(FindStreetName)<>'' then fm.edStreetName.Text:=FindStreetName;
  if Trim(FindRegionName)<>'' then fm.edRegionName.Text:=FindRegionName;

  fm.cbInString.Checked:=FilterInSide;

  fm.ChangeFlag:=false;

  if fm.ShowModal=mrOk then begin

    inherited;

    FindStreetName:=Trim(fm.edStreetName.Text);
    FindRegionName:=Trim(fm.edRegionName.Text);

    FilterInSide:=fm.cbInString.Checked;
    if FilterInSide then filstr:='%';

    ActiveQuery(false);
    ViewCount;
  end;
 finally
  fm.Free;
 end;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

function TfmRBAPRegionStreet.GetFilterString: string;
var
  FilInSide: string;
  wherestr: string;
  addstr1,addstr2: string;
  and1: string;
begin
    Result:=Inherited GetFilterString;
    if Trim(Result)<>'' then exit;

    isFindStreetName:=Trim(FindStreetName)<>'';
    isFindRegionName:=Trim(FindRegionName)<>'';

    if isFindStreetName or isFindRegionName then begin
     wherestr:=' where ';
    end else begin
    end;

    if FilterInside then FilInSide:='%';

     if isFindStreetName then begin
        addstr1:=' Upper(e.fname||'' ''||e.name||'' ''||e.sname) like '+AnsiUpperCase(QuotedStr(FilInSide+FindStreetName+'%'))+' ';
     end;

     if isFindRegionName then begin
        addstr2:=' Upper(u.name) like '+AnsiUpperCase(QuotedStr(FilInSide+FindRegionName+'%'))+' ';
     end;

     if (isFindStreetName and isFindRegionName)
       then and1:=' and ';

     Result:=wherestr+addstr1+and1+addstr2;
end;


end.
