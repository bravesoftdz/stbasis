unit URBTypeStud;

interface

{$I stbasis.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  URBMainGrid, Db, IBCustomDataSet, IBQuery, DBCtrls, StdCtrls, Buttons,
  ExtCtrls, dbgrids, IBDatabase, IB, Menus , tsvDbGrid, IBUpdateSQL;

type
   TfmRBTypeStud = class(TfmRBMainGrid)
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bibRefreshClick(Sender: TObject);
    procedure bibAddClick(Sender: TObject);
    procedure bibChangeClick(Sender: TObject);
    procedure bibDelClick(Sender: TObject);
    procedure bibViewClick(Sender: TObject);
    procedure bibFilterClick(Sender: TObject);
  private
    isFindName: Boolean;
    FindName: String;
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
  fmRBTypeStud: TfmRBTypeStud;

implementation

uses UMainUnited, UStaffTsvCode, UStaffTsvDM, UStaffTsvData, UEditRBTypeStud;

{$R *.DFM}

procedure TfmRBTypeStud.FormCreate(Sender: TObject);
var
 cl: TColumn;
begin
 inherited;
 try
  Caption:=NameRbkTypeStud;
  Mainqr.Database:=IBDB;
  IBTran.AddDatabase(IBDB);
  IBDB.AddTransaction(IBTran);
  cl:=Grid.Columns.Add;
  cl.FieldName:='name';
  cl.Title.Caption:='��� ��������';
  cl.Width:=250;
  LoadFromIni;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBTypeStud.FormDestroy(Sender: TObject);
begin
  inherited;
  if FormState=[fsCreatedMDIChild] then
   fmRBTypeStud:=nil;
end;

function TfmRBTypeStud.GetSql: string;
begin
  Result:= inherited GetSql;
  if Trim(Result)<>'' then exit;
  Result:=SQLRbkTypeStud+GetFilterString+GetLastOrderStr;
end;

procedure TfmRBTypeStud.ActiveQuery(CheckPerm: Boolean);
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
   SetImageFilter(isFindName);
   ViewCount;
  finally
   Mainqr.EnableControls;
   Screen.Cursor:=crDefault;
  end;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBTypeStud.GridTitleClickWithSort(Column: TColumn; TypeSort: TTypeColumnSort);
var
  fn: string;
  id: string;
begin
 try
   if not MainQr.Active then exit;
   fn:=Column.FieldName;
   id:=MainQr.fieldByName('typestud_id').asString;
   SetLastOrderFromTypeSort(fn,TypeSort);
   ActiveQuery(false);
   MainQr.First;
   MainQr.Locate('typestud_id',id,[loCaseInsensitive]);
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBTypeStud.GridDblClick(Sender: TObject);
begin
  if not Mainqr.Active then exit;
  if Mainqr.RecordCount=0 then exit;
  if pnSQL.Visible and bibChange.Enabled then begin
   bibChange.Click;
  end else bibView.Click;
end;

procedure TfmRBTypeStud.LoadFromIni;
begin
 inherited;
 try
    FindName:=ReadParam(ClassName,'name',FindName);
    FilterInside:=ReadParam(ClassName,'Inside',FilterInside);
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBTypeStud.SaveToIni;
begin
 inherited;
 try
   WriteParam(ClassName,'name',FindName);
   WriteParam(ClassName,'Inside',FilterInside);
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBTypeStud.bibRefreshClick(Sender: TObject);
begin
  ActiveQuery(true);
end;

procedure TfmRBTypeStud.bibAddClick(Sender: TObject);
var
  fm: TfmEditRBTypeStud;
begin
  if not Mainqr.Active then exit;
  fm:=TfmEditRBTypeStud.Create(nil);
  try
    fm.TypeEditRBook:=terbAdd;
    fm.ChangeFlag:=false;
    if fm.ShowModal=mrok then begin
     ActiveQuery(false);
     MainQr.Locate('typestud_id',fm.oldtypestud_id,[loCaseInsensitive]);
    end;
  finally
    fm.Free;
  end;
end;

procedure TfmRBTypeStud.bibChangeClick(Sender: TObject);
var
  fm: TfmEditRBTypeStud;
begin
  if not Mainqr.Active then exit;
  if Mainqr.RecordCount=0 then exit;
  fm:=TfmEditRBTypeStud.Create(nil);
  try
    fm.TypeEditRBook:=terbChange;
    fm.edName.Text:=Mainqr.fieldByName('name').AsString;
    fm.oldtypestud_id:=MainQr.FieldByName('typestud_id').AsInteger;
    fm.ChangeFlag:=false;
    if fm.ShowModal=mrok then begin
     ActiveQuery(false);
     MainQr.Locate('typestud_id',fm.oldtypestud_id,[loCaseInsensitive]);
    end;
  finally
    fm.Free;
  end;
end;

procedure TfmRBTypeStud.bibDelClick(Sender: TObject);
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
     sqls:='Delete from '+tbTypeStud+' where typestud_id='+
          Mainqr.FieldByName('typestud_id').asString;
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
  but:=DeleteWarningEx('��� �������� <'+Mainqr.FieldByName('name').AsString+'> ?');
  if but=mrYes then begin
    if not deleteRecord then begin
{      ShowError(Application.Handle,
               '��� �������� <'+Mainqr.FieldByName('name').AsString+'> ������������.');}
    end;
  end;
end;

procedure TfmRBTypeStud.bibViewClick(Sender: TObject);
var
  fm: TfmEditRBTypeStud;
begin
  if not Mainqr.Active then exit;
  if Mainqr.RecordCount=0 then exit;
  fm:=TfmEditRBTypeStud.Create(nil);
  try
    fm.TypeEditRBook:=terbView;
    fm.edName.Text:=Mainqr.fieldByName('name').AsString;
    if fm.ShowModal=mrok then begin
    end;
  finally
    fm.Free;
  end;
end;

procedure TfmRBTypeStud.bibFilterClick(Sender: TObject);
var
  fm: TfmEditRBTypeStud;
  filstr: string;
begin
 fm:=TfmEditRBTypeStud.Create(nil);
 try
  fm.TypeEditRBook:=terbFilter;

  if Trim(FindName)<>'' then fm.edName.Text:=FindName;

  fm.cbInString.Checked:=FilterInSide;

  fm.ChangeFlag:=false;

  if fm.ShowModal=mrOk then begin

    inherited;

    FindName:=Trim(fm.edName.Text);

    FilterInSide:=fm.cbInString.Checked;
    if FilterInSide then filstr:='%';

    ActiveQuery(false);
    ViewCount;
  end;
 finally
  fm.Free;
 end;
end; 

function TfmRBTypeStud.GetFilterString: string;
var
  FilInSide: string;
  wherestr: string;
  addstr1: string;
begin
    Result:=Inherited GetFilterString;
    if Trim(Result)<>'' then exit;

    isFindName:=Trim(FindName)<>'';

    if isFindName then begin
     wherestr:=' where ';
    end else begin
    end;

    if FilterInside then FilInSide:='%';

     if isFindName then begin
        addstr1:=' Upper(name) like '+AnsiUpperCase(QuotedStr(FilInSide+FindName+'%'))+' ';
     end;

     Result:=wherestr+addstr1;
end;


end.
