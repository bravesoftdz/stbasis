unit URBAPOperation;

interface
{$I stbasis.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  URBMainTreeViewEx, Db, IBCustomDataSet, IBQuery, DBCtrls, StdCtrls, Buttons,
  ExtCtrls, dbgrids, IBDatabase, ImgList, comctrls,
  dbtree, IB, Menus, VirtualTrees, tsvInterbase;

type
   TfmRBAPOperation = class(TfmRBMainTreeViewEx)
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
    procedure TreeViewDblClick(Sender: TObject); override;
    procedure SaveToIni;override;
    procedure LoadFromIni; override;
    function GetFilterString: string; override;
    function GetSql: string; override;
  public
    procedure ActiveQuery(CheckPerm: Boolean);override;
  end;

var
  fmRBAPOperation: TfmRBAPOperation;

implementation

uses UMainUnited, UAnnPremData, UEditRBAPOperation;

{$R *.DFM}

procedure TfmRBAPOperation.FormCreate(Sender: TObject);
begin
 inherited;
 try
  Caption:=NameRbkAPOperation;
  
  Mainqr.Database:=IBDB;
  IBTran.AddDatabase(IBDB);
  IBDB.AddTransaction(IBTran);

  TreeView.KeyFieldName:='AP_OPERATION_ID';
  TreeView.ParentFieldName:='PARENT_ID';
  TreeView.ViewFieldName:='NAME';

  DefLastOrderStr:=' ORDER BY C.INC ';
  
  LoadFromIni;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBAPOperation.FormDestroy(Sender: TObject);
begin
  inherited;
  if FormState=[fsCreatedMDIChild] then
   fmRBAPOperation:=nil;
end;

function TfmRBAPOperation.GetSql: string;
begin
  Result:= inherited GetSql;
  if Trim(Result)<>'' then exit;
  Result:=SQLRbkAPOperation+GetFilterString+GetLastOrderStr;
end;

procedure TfmRBAPOperation.ActiveQuery(CheckPerm: Boolean);
var
 sqls: String;
begin
 try
  inherited;

  if CheckPerm then
   if not CheckPermission then exit;

  Screen.Cursor:=crHourGlass;
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
    TreeView.CollapseAll;
    Screen.Cursor:=crDefault;
  end;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBAPOperation.TreeViewDblClick(Sender: TObject);
begin
  inherited;
end;

procedure TfmRBAPOperation.LoadFromIni;
begin
 inherited;
 try
    FindName:=ReadParam(ClassName,'name',FindName);
    FilterInside:=ReadParam(ClassName,'Inside',FilterInside);
 except
   {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBAPOperation.SaveToIni;
begin
 inherited;
 try
    WriteParam(ClassName,'name',FindName);
    WriteParam(ClassName,'Inside',FilterInside);
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBAPOperation.bibRefreshClick(Sender: TObject);
begin
  ActiveQuery(true);
end;

procedure TfmRBAPOperation.bibAddClick(Sender: TObject);
var
  fm: TfmEditRBAPOperation;
begin
  if not Mainqr.Active then exit;
  fm:=TfmEditRBAPOperation.Create(nil);
  try
    fm.TypeEditRBook:=terbAdd;
    fm.ChangeFlag:=false;
    if fm.ShowModal=mrok then begin
     ActiveQuery(false);
     MainQr.Locate('AP_OPERATION_ID',fm.oldOperation_id,[loCaseInsensitive]);
    end;
  finally
    fm.Free;
  end;
end;

procedure TfmRBAPOperation.bibChangeClick(Sender: TObject);
var
  fm: TfmEditRBAPOperation;
  nd: PVirtualNode;
begin
  nd:=TreeView.FocusedNode;
  if nd=nil then exit;
  if not Mainqr.Active then exit;
  if Mainqr.RecordCount=0 then exit;
  fm:=TfmEditRBAPOperation.Create(nil);
  try
    fm.TypeEditRBook:=terbChange;
    fm.edName.Text:=Mainqr.fieldByName('name').AsString;
    fm.edFullName.Text:=Mainqr.fieldByName('fullname').AsString;
    fm.udPriority.Position:=Mainqr.fieldByName('priority').AsInteger;
    fm.oldOperation_id:=MainQr.FieldByName('ap_operation_id').AsInteger;
    fm.ap_field_view_id:=MainQr.FieldByName('ap_field_view_id').AsInteger;
    fm.edFieldViewName.Text:=MainQr.FieldByName('field_view_name').AsString;
    fm.edLink.Text:=MainQr.FieldByName('link').AsString;
    fm.meFormat.Lines.Text:=MainQr.FieldByName('format').AsString;
    if nd.Parent<>TreeView.RootNode then begin
      fm.ParentOperationId:=Mainqr.fieldByName('parent_id').AsInteger;
      fm.edParent.Text:=TreeView.NodeText[nd.Parent];
    end;
    fm.ChangeFlag:=false;
    if fm.ShowModal=mrok then begin
     ActiveQuery(false);
     MainQr.Locate('AP_OPERATION_ID',fm.oldOperation_id,[loCaseInsensitive]);
    end;
  finally
    fm.Free;
  end;
end;

procedure TfmRBAPOperation.bibDelClick(Sender: TObject);
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
     sqls:='Delete from '+tbAPOperation+' where AP_OPERATION_ID='+
          Mainqr.FieldByName('AP_OPERATION_ID').asString;
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
  but:=DeleteWarningEx('�������� <'+Mainqr.FieldByName('name').AsString+'> ?');
  if but=mrYes then begin
    if not deleteRecord then begin
    end;
  end;
end;

procedure TfmRBAPOperation.bibViewClick(Sender: TObject);
var
  fm: TfmEditRBAPOperation;
  nd: PVirtualNode;
begin
  nd:=TreeView.FocusedNode;
  if nd=nil then exit;
  if not Mainqr.Active then exit;
  if Mainqr.RecordCount=0 then exit;
  fm:=TfmEditRBAPOperation.Create(nil);
  try
    fm.TypeEditRBook:=terbView;
    fm.edName.Text:=Mainqr.fieldByName('name').AsString;
    fm.edFullName.Text:=Mainqr.fieldByName('fullname').AsString;
    fm.udPriority.Position:=Mainqr.fieldByName('priority').AsInteger;
    fm.oldOperation_id:=MainQr.FieldByName('ap_operation_id').AsInteger;
    fm.ap_field_view_id:=MainQr.FieldByName('ap_field_view_id').AsInteger;
    fm.edFieldViewName.Text:=MainQr.FieldByName('field_view_name').AsString;
    fm.edLink.Text:=MainQr.FieldByName('link').AsString;
    fm.meFormat.Lines.Text:=MainQr.FieldByName('format').AsString;
    if nd.Parent<>TreeView.RootNode then begin
      fm.ParentOperationId:=Mainqr.fieldByName('parent_id').AsInteger;
      fm.edParent.Text:=TreeView.NodeText[nd.Parent];
    end;
    if fm.ShowModal=mrok then begin
    end;
  finally
    fm.Free;
  end;
end;

procedure TfmRBAPOperation.bibFilterClick(Sender: TObject);
var
  fm: TfmEditRBAPOperation;
  filstr: string;
begin
 fm:=TfmEditRBAPOperation.Create(nil);
 try
  fm.TypeEditRBook:=terbFilter;

  if Trim(FindName)<>'' then fm.edName.Text:=FindName;

  fm.edParent.Enabled:=false;
  fm.bibParent.Enabled:=false;
  fm.lbParent.Enabled:=false;

  fm.edFullName.Enabled:=false;
  fm.edFullName.Color:=clBtnFace;
  fm.lbFullName.Enabled:=false;

  fm.edFieldViewName.Enabled:=false;
  fm.btFieldViewName.Enabled:=false;
  fm.lbFieldViewName.Enabled:=false;

  fm.LabelLink.Enabled:=false;
  fm.edLink.Enabled:=false;
  fm.edLink.Color:=clBtnFace;

  fm.lbPriority.Enabled:=false;
  fm.edPriority.Enabled:=false;
  fm.edPriority.Color:=clBtnFace;
  fm.udPriority.Enabled:=false;

  fm.lbFormat.Enabled:=false;
  fm.meFormat.Enabled:=false;
  fm.meFormat.Color:=clBtnFace;

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

function TfmRBAPOperation.GetFilterString: string;
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
        addstr1:=' Upper(o.name) like '+AnsiUpperCase(QuotedStr(FilInSide+FindName+'%'))+' ';
     end;

     Result:=wherestr+addstr1;
end;


end.