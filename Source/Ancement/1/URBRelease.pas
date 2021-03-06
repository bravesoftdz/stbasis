unit URBRelease;

interface
{$I stbasis.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  URBMainGrid, Db, IBCustomDataSet, IBQuery, DBCtrls, StdCtrls, Buttons,
  ExtCtrls, dbgrids, IBDatabase, IB, Menus, tsvDbGrid, IBUpdateSQL;

type
   TfmRBRelease = class(TfmRBMainGrid)
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bibRefreshClick(Sender: TObject);
    procedure bibAddClick(Sender: TObject);
    procedure bibChangeClick(Sender: TObject);
    procedure bibDelClick(Sender: TObject);
    procedure bibViewClick(Sender: TObject);
    procedure bibFilterClick(Sender: TObject);
  private
    isFindNumRelease, isFindDateRelease, isFindAbout, isFindDateReleaseTo: Boolean;
    FindNumRelease, FindAbout: String;
    FindDateRelease,FindDateReleaseTo: TDateTime;

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
  fmRBRelease: TfmRBRelease;

implementation

uses UMainUnited, UAncementCode, UAncementDM, UAncementData, UEditRBRelease;

{$R *.DFM}

procedure TfmRBRelease.FormCreate(Sender: TObject);
var
  cl: TColumn;
begin
 inherited;
 try
  Caption:=NameRbkRelease;
  Mainqr.Database:=IBDB;
  IBTran.AddDatabase(IBDB);
  IBDB.AddTransaction(IBTran);
  
  cl:=Grid.Columns.Add;
  cl.FieldName:='numrelease';
  cl.Title.Caption:='����� �������';
  cl.Width:=60;

  cl:=Grid.Columns.Add;
  cl.FieldName:='daterelease';
  cl.Title.Caption:='���� �������';
  cl.Width:=80;

  cl:=Grid.Columns.Add;
  cl.FieldName:='about';
  cl.Title.Caption:='����������';
  cl.Width:=150;

  DefaultOrders.Add('�� �������','numrelease');

  LoadFromIni;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBRelease.FormDestroy(Sender: TObject);
begin
  inherited;
  if FormState=[fsCreatedMDIChild] then
   fmRBRelease:=nil;
end;

function TfmRBRelease.GetSql: string;
begin
  Result:= inherited GetSql;
  if Trim(Result)<>'' then exit;
  Result:=SQLRbkRelease+GetFilterString+GetLastOrderStr;
end;

procedure TfmRBRelease.ActiveQuery(CheckPerm: Boolean);
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
   SetImageFilter(isFindNumRelease or isFindDateRelease or IsFindAbout or isFindDateReleaseTo);
   ViewCount;
  finally
   Mainqr.EnableControls;
   Screen.Cursor:=crDefault;
  end;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBRelease.GridTitleClickWithSort(Column: TColumn; TypeSort: TTypeColumnSort);
var
  fn: string;
  id: string;
begin
 try
   if not MainQr.Active then exit;
   fn:=Column.FieldName;
   id:=MainQr.fieldByName('release_id').asString;
   SetLastOrderFromTypeSort(fn,TypeSort);
   ActiveQuery(false);
   MainQr.First;
   MainQr.Locate('release_id',id,[loCaseInsensitive]);
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBRelease.GridDblClick(Sender: TObject);
begin
  if not Mainqr.Active then exit;
  if Mainqr.RecordCount=0 then exit;
  if pnSQL.Visible and bibChange.Enabled then begin
   bibChange.Click;
  end else bibView.Click;
end;

procedure TfmRBRelease.LoadFromIni;
begin
 inherited;
 try
    FindNumRelease:=ReadParam(ClassName,'numrelease',FindNumRelease);
    isFindDateRelease:=ReadParam(ClassName,'isdaterelease',isFindDateRelease);
    if isFindDateRelease then
     FindDateRelease:=ReadParam(ClassName,'daterelease',FindDateRelease);

    FindAbout:=ReadParam(ClassName,'about',FindAbout);
    isFindDateReleaseTo:=ReadParam(ClassName,'isdatereleaseto',isFindDateReleaseTo);
    if isFindDateReleaseTo then
      FindDateReleaseTo:=ReadParam(ClassName,'datereleaseto',FindDateReleaseTo);
    FilterInside:=ReadParam(ClassName,'Inside',FilterInside);
 except
   {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBRelease.SaveToIni;
begin
 inherited;
 try
    WriteParam(ClassName,'numrelease',FindNumRelease);
    WriteParam(ClassName,'daterelease',FindDateRelease);
    WriteParam(ClassName,'isdaterelease',isFindDateRelease);
    WriteParam(ClassName,'about',FindAbout);
    WriteParam(ClassName,'datereleaseto',FindDateReleaseTo);
    WriteParam(ClassName,'isdatereleaseto',isFindDateReleaseTo);
    WriteParam(ClassName,'Inside',FilterInside);
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBRelease.bibRefreshClick(Sender: TObject);
begin
  ActiveQuery(true);
end;

procedure TfmRBRelease.bibAddClick(Sender: TObject);
var
  fm: TfmEditRBRelease;
begin
  if not Mainqr.Active then exit;
  fm:=TfmEditRBRelease.Create(nil);
  try
    fm.TypeEditRBook:=terbAdd;
    fm.ChangeFlag:=false;
    if fm.ShowModal=mrok then begin
     ActiveQuery(false);
     MainQr.Locate('release_id',fm.oldrelease_id,[loCaseInsensitive]);
    end;
  finally
    fm.Free;
  end;
end;

procedure TfmRBRelease.bibChangeClick(Sender: TObject);
var
  fm: TfmEditRBRelease;
begin
  if not Mainqr.Active then exit;
  if Mainqr.IsEmpty then exit;
  fm:=TfmEditRBRelease.Create(nil);
  try
    fm.edNumRelease.Text:=Mainqr.fieldByName('numrelease').AsString;
    fm.dtpDate.Date:=Mainqr.fieldByName('daterelease').AsDateTime;
    fm.edAbout.Text:=Mainqr.fieldByName('about').AsString;
    fm.oldrelease_id:=MainQr.FieldByName('release_id').AsInteger;
    fm.TypeEditRBook:=terbChange;
    fm.ChangeFlag:=false;
    if fm.ShowModal=mrok then begin
     ActiveQuery(false);
     MainQr.Locate('release_id',fm.oldrelease_id,[loCaseInsensitive]);
    end;
  finally
    fm.Free;
  end;
end;

procedure TfmRBRelease.bibDelClick(Sender: TObject);
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
     sqls:='Delete from '+tbRelease+' where release_id='+
          Mainqr.FieldByName('release_id').asString;
     qr.sql.Add(sqls);
     qr.ExecSQL;
     qr.Transaction.Commit;
     ActiveQuery(false);
     Result:=true;
    except
     on E: EIBInterBaseError do begin
        TempStr:=TranslateIBError(E.Message);
        ShowErrorEx(TempStr);
        Assert(false,TempStr);
     end;
     {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
    end;
   finally
    qr.Free;
    Screen.Cursor:=crDefault;
   end;

  end;

begin
  if Mainqr.RecordCount=0 then exit;
  but:=DeleteWarningEx('������ � <'+Mainqr.FieldByName('numrelease').AsString+'> ?');
  if but=mrYes then begin
    if not deleteRecord then begin
    end;
  end;
end;

procedure TfmRBRelease.bibViewClick(Sender: TObject);
var
  fm: TfmEditRBRelease;
begin
  if not Mainqr.Active then exit;
  if Mainqr.IsEmpty then exit;
  fm:=TfmEditRBRelease.Create(nil);
  try
    fm.TypeEditRBook:=terbView;
    fm.edNumRelease.Text:=Mainqr.fieldByName('numrelease').AsString;
    fm.dtpDate.Date:=Mainqr.fieldByName('daterelease').AsDateTime;
    fm.edAbout.Text:=Mainqr.fieldByName('about').AsString;
    fm.oldrelease_id:=MainQr.FieldByName('release_id').AsInteger;
    if fm.ShowModal=mrok then begin
    end;
  finally
    fm.Free;
  end;
end;

procedure TfmRBRelease.bibFilterClick(Sender: TObject);
var
  fm: TfmEditRBRelease;
  filstr: string;
begin
 fm:=TfmEditRBRelease.Create(nil);
 try
  fm.TypeEditRBook:=terbFilter;

  fm.dtpDate.ShowCheckbox:=true;
  if isFindDateRelease then
   fm.dtpDate.Date:=FindDateRelease;
  fm.dtpDate.Checked:=isFindDateRelease;
  fm.dtpDate.Checked:=isFindDateRelease;

  fm.lbToDate.Visible:=true;
  fm.dtpToDate.Visible:=true;
  fm.bibTodate.Visible:=true;
  fm.dtpToDate.ShowCheckbox:=true;
  if isFindDateReleaseTo then
   fm.dtpToDate.Date:=FindDateReleaseTo;
  fm.dtpToDate.Checked:=isFindDateReleaseTo;
  fm.dtpToDate.Checked:=isFindDateReleaseTo;

  if Trim(FindNumRelease)<>'' then fm.edNumRelease.Text:=FindNumRelease;
  if Trim(FindAbout)<>'' then fm.edAbout.Text:=FindAbout;

  fm.cbInString.Checked:=FilterInSide;

  fm.ChangeFlag:=false;

  if fm.ShowModal=mrOk then begin

    inherited;

    FindNumRelease:=Trim(fm.edNumRelease.Text);
    FindAbout:=Trim(fm.edAbout.Text);
    isFindDateRelease:=fm.dtpDate.Checked;
    FindDateRelease:=fm.dtpDate.Date;
    isFindDateReleaseTo:=fm.dtpToDate.Checked;
    FindDateReleaseTo:=fm.dtpToDate.Date;

    FilterInSide:=fm.cbInString.Checked;
    if FilterInSide then filstr:='%';

    ActiveQuery(false);
    ViewCount;
  end;
 finally
  fm.Free;
 end;
end;

function TfmRBRelease.GetFilterString: string;
var
  FilInSide: string;
  wherestr: string;
  addstr1,addstr2,addstr3,addstr4: string;
  and1,and2,and3: string;
begin
    Result:=Inherited GetFilterString;
    if Trim(Result)<>'' then exit;

    isFindNumRelease:=isInteger(FindNumRelease);
    isFindAbout:=trim(FindAbout)<>'';

    if isFindNumRelease or
       isFindAbout or
       isFindDateRelease or
       isFindDateReleaseTo then begin
     wherestr:=' where ';
    end else begin
    end;

    if FilterInside then FilInSide:='%';

     if isFindNumRelease then begin
        addstr1:=' Upper(numrelease) like '+AnsiUpperCase(QuotedStr(FilInSide+FindNumRelease+'%'))+' ';
     end;

     if isFindDateRelease then begin
        addstr2:=' daterelease>='+QuotedStr(DateToStr(FindDateRelease))+' ';
     end;

     if isFindAbout then begin
        addstr3:=' Upper(about) like '+AnsiUpperCase(QuotedStr(FilInSide+FindAbout+'%'))+' ';
     end;

     if isFindDateReleaseTo then begin
        addstr4:=' daterelease<='+QuotedStr(DateToStr(FindDateReleaseTo))+' ';
     end;

     if (isFindNumRelease and isFindDateRelease) or
        (isFindNumRelease and isFindAbout)or
        (isFindNumRelease and isFindDateReleaseTo)then
      and1:=' and ';

     if (isFindDateRelease and isFindAbout)or
        (isFindDateRelease and isFindDateReleaseTo)then
      and2:=' and ';
      
     if isFindAbout and isFindDateReleaseTo then
      and3:=' and ';

     Result:=wherestr+addstr1+and1+
                      addstr2+and2+
                      addstr3+and3+
                      addstr4;
end;


end.
