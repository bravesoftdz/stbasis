unit URBPms_Premises_Advertisment;

interface
{$I stbasis.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  URBMainGrid, Db, IBCustomDataSet, IBQuery, DBCtrls, StdCtrls, Buttons,
  ExtCtrls, dbgrids, IBDatabase, IB, Menus , tsvDbGrid, IBUpdateSQL;

type
   TfmRBPms_Premises_Advertisment = class(TfmRBMainGrid)
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bibRefreshClick(Sender: TObject);
    procedure bibAddClick(Sender: TObject);
    procedure bibChangeClick(Sender: TObject);
    procedure bibDelClick(Sender: TObject);
    procedure bibViewClick(Sender: TObject);
    procedure bibFilterClick(Sender: TObject);
  private
    isFindAdvertisment,isFindPremises,isFindAgent: Boolean;
    FindAdvertisment,FindPremises,FindAgent: String;
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
  fmRBPms_Premises_Advertisment: TfmRBPms_Premises_Advertisment;

implementation

uses UMainUnited, UPremisesTsvCode, UPremisesTsvDM, UPremisesTsvData, UEditRBPms_Premises_Advertisment;

{$R *.DFM}

procedure TfmRBPms_Premises_Advertisment.FormCreate(Sender: TObject);
var
  cl: TColumn;
begin
 inherited;
 try
  Caption:=NameRbkPms_Premises_Advertisment;
  Mainqr.Database:=IBDB;
  IBTran.AddDatabase(IBDB);
  IBDB.AddTransaction(IBTran);
  
  cl:=Grid.Columns.Add;
  cl.FieldName:='advertisment_name';
  cl.Title.Caption:='�������';
  cl.Width:=100;

  cl:=Grid.Columns.Add;
  cl.FieldName:='agent_name';
  cl.Title.Caption:='�����';
  cl.Width:=100;

  cl:=Grid.Columns.Add;
  cl.FieldName:='premises_id';
  cl.Title.Caption:='�� ����';
  cl.Width:=80;

  LoadFromIni;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBPms_Premises_Advertisment.FormDestroy(Sender: TObject);
begin
  inherited;
  if FormState=[fsCreatedMDIChild] then
   fmRBPms_Premises_Advertisment:=nil;
end;

function TfmRBPms_Premises_Advertisment.GetSql: string;
begin
  Result:= inherited GetSql;
  if Trim(Result)<>'' then exit;
  Result:=SQLRbkPms_Premises_Advertisment+GetFilterString+GetLastOrderStr;
end;

procedure TfmRBPms_Premises_Advertisment.ActiveQuery(CheckPerm: Boolean);
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
   SetImageFilter(isFindAdvertisment or isFindPremises or isFindAgent);
   ViewCount;
  finally
   Mainqr.EnableControls;
   Screen.Cursor:=crDefault;
  end;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBPms_Premises_Advertisment.GridTitleClickWithSort(Column: TColumn; TypeSort: TTypeColumnSort);
var
  fn: string;
  id1,id2,id3: string;
begin
 try
   if not MainQr.Active then exit;
   fn:=Column.FieldName;
   if UpperCase(fn)=UpperCase('advertisment_name') then fn:='pa.pms_advertisment_id';
   if UpperCase(fn)=UpperCase('premises_id') then fn:='p.pms_premises_id';
   if UpperCase(fn)=UpperCase('agent_name') then fn:='pag.pms_agent_id';

   id1:=MainQr.fieldByName('pms_advertisment_id').asString;
   id2:=MainQr.fieldByName('pms_agent_id').asString;
   id3:=MainQr.fieldByName('pms_premises_id').asString;
   SetLastOrderFromTypeSort(fn,TypeSort);
   ActiveQuery(false);
   MainQr.First;
   MainQr.Locate('pms_advertisment_id;pms_agent_id;pms_premises_id',VarArrayOf([id1,id2,id3]),[LocaseInsensitive]);
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBPms_Premises_Advertisment.GridDblClick(Sender: TObject);
begin
  if not Mainqr.Active then exit;
  if Mainqr.RecordCount=0 then exit;
  if pnSQL.Visible and bibChange.Enabled then begin
   bibChange.Click;
  end else bibView.Click;
end;

procedure TfmRBPms_Premises_Advertisment.LoadFromIni;
begin
 inherited;
 try
    FindAdvertisment:=ReadParam(ClassName,'Advertisment',FindAdvertisment);
    FindPremises:=ReadParam(ClassName,'Premises',FindPremises);
    FindAgent:=ReadParam(ClassName,'Agent',FindAgent);

    FilterInside:=ReadParam(ClassName,'Inside',FilterInside);
 except
   {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBPms_Premises_Advertisment.SaveToIni;
begin
 inherited;
 try

    WriteParam(ClassName,'Advertisment',FindAdvertisment);
    WriteParam(ClassName,'Premises',FindPremises);
    WriteParam(ClassName,'Agent',FindAgent);
    WriteParam(ClassName,'Inside',FilterInside);
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBPms_Premises_Advertisment.bibRefreshClick(Sender: TObject);
begin
  ActiveQuery(true);
end;

procedure TfmRBPms_Premises_Advertisment.bibAddClick(Sender: TObject);
var
  fm: TfmEditRBPms_Premises_Advertisment;
begin
  if not Mainqr.Active then exit;
  fm:=TfmEditRBPms_Premises_Advertisment.Create(nil);
  try
    fm.fmParent:=Self;
    fm.TypeEditRBook:=terbAdd;
    fm.ChangeFlag:=false;
    fm.lbAgent.Caption:='�� ������';
    fm.btAgent.Visible:=False;
    if fm.ShowModal=mrok then begin
     ViewCount;
     MainQr.Locate('pms_advertisment_id;pms_agent_id;pms_premises_id',VarArrayOf([fm.oldPms_Advertisment_id,fm.oldPms_Agent_id,fm.oldPms_Premises_id]),[loCaseInsensitive]);
    end;
  finally
    fm.Free;
  end;
end;

procedure TfmRBPms_Premises_Advertisment.bibChangeClick(Sender: TObject);
var
  fm: TfmEditRBPms_Premises_Advertisment;
begin
  if not Mainqr.Active then exit;
  if Mainqr.IsEmpty then exit;
  fm:=TfmEditRBPms_Premises_Advertisment.Create(nil);
  try
    fm.fmParent:=Self;

    fm.btAgent.Visible:=False;
    
    fm.edAdvertisment.Text:=Mainqr.fieldByName('advertisment_name').AsString;
    fm.lbAgent.Caption:='�� ������';
    fm.edAgent.Text:=Mainqr.fieldByName('Pms_Agent_id').AsString;
    fm.edPremises.Text:=Mainqr.fieldByName('premises_id').AsString;

    fm.oldPms_Advertisment_id:=MainQr.FieldByName('Pms_Advertisment_id').AsInteger;
    fm.oldPms_Agent_id:=MainQr.FieldByName('Pms_Agent_id').AsInteger;
    fm.oldPms_Premises_id:=MainQr.FieldByName('Pms_Premises_id').AsInteger;

    fm.Pms_Advertisment_id:=MainQr.FieldByName('Pms_Advertisment_id').AsInteger;
    fm.Pms_Agent_id:=MainQr.FieldByName('Pms_Agent_id').AsInteger;
    fm.Pms_Premises_id:=MainQr.FieldByName('Pms_Premises_id').AsInteger;

    fm.ChangeFlag:=false;

    fm.TypeEditRBook:=terbChange;
    if fm.ShowModal=mrok then begin
    MainQr.Locate('pms_advertisment_id;pms_agent_id;pms_premises_id',VarArrayOf([fm.oldPms_Advertisment_id,fm.oldPms_Agent_id,fm.oldPms_Premises_id]),[loCaseInsensitive]);
    end;
  finally
    fm.Free;
  end;
end;

procedure TfmRBPms_Premises_Advertisment.bibDelClick(Sender: TObject);
var
  but: Integer;

  function DeleteRecord: Boolean;
  var
    qr: TIBQuery;
    tran: TIBTransaction;
    sqls: string;
  begin
   Screen.Cursor:=crHourGlass;
   qr:=TIBQuery.Create(nil);
   tran:=TIBTransaction.Create(nil);
   try
    result:=false;
    try
     tran.AddDatabase(IBDB);
     IBDB.AddTransaction(tran);
     tran.Params.Text:=DefaultTransactionParamsTwo;
     qr.Database:=IBDB;
     qr.Transaction:=tran;
     qr.Transaction.Active:=true;
     sqls:='Delete from '+tbPms_Premises_Advertisment+' where Pms_Advertisment_id='+
          Mainqr.FieldByName('Pms_Advertisment_id').asString+ ' and '+' Pms_Premises_id='+
          Mainqr.FieldByName('Pms_Premises_id').asString +' and '+' Pms_Agent_id='+
          Mainqr.FieldByName('Pms_Agent_id').asString;
     qr.sql.Add(sqls);
     qr.ExecSQL;
     qr.Transaction.Commit;

     IBUpd.DeleteSQL.Clear;
     IBUpd.DeleteSQL.Add(sqls);
     Mainqr.Delete;
     
     ViewCount;

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
    tran.Free; 
    qr.Free;
    Screen.Cursor:=crDefault;
   end;

  end;

begin
  if Mainqr.RecordCount=0 then exit;
  but:=DeleteWarningEx('������� <'+Mainqr.FieldByName('advertisment_name').AsString+'> ?');
  if but=mrYes then begin
    if not deleteRecord then begin
    end;
  end;
end;

procedure TfmRBPms_Premises_Advertisment.bibViewClick(Sender: TObject);
var
  fm: TfmEditRBPms_Premises_Advertisment;
begin
  if not Mainqr.Active then exit;
  if Mainqr.IsEmpty then exit;
  fm:=TfmEditRBPms_Premises_Advertisment.Create(nil);
  try
    fm.TypeEditRBook:=terbView;
    fm.btAdvertisment.Visible:=false;
    fm.btPremises.Visible:=false;
    fm.btAgent.Visible:=False;
    fm.edAdvertisment.Text:=Mainqr.fieldByName('advertisment_name').AsString;
    fm.edAgent.Text:=Mainqr.fieldByName('agent_name').AsString;
    fm.edPremises.Text:=Mainqr.fieldByName('premises_id').AsString;
    if fm.ShowModal=mrok then begin
    end;
  finally
    fm.Free;
  end;
end;

procedure TfmRBPms_Premises_Advertisment.bibFilterClick(Sender: TObject);
var
  fm: TfmEditRBPms_Premises_Advertisment;
  filstr: string;
begin
 fm:=TfmEditRBPms_Premises_Advertisment.Create(nil);
 try
  fm.TypeEditRBook:=terbFilter;

  fm.edAdvertisment.ReadOnly:=False;
  fm.edAgent.ReadOnly:=False;
  fm.edPremises.ReadOnly:=False;




  fm.edAdvertisment.Color:=clWindow;
  fm.edAgent.Color:=clWindow;
  fm.edPremises.Color:=clWindow;

  fm.btAdvertisment.Visible:=true;
  fm.btPremises.Visible:=true;

  if Trim(FindAdvertisment)<>'' then fm.edAdvertisment.Text:=FindAdvertisment;
  if Trim(FindAgent)<>'' then fm.edAgent.Text:=FindAgent;
  if Trim(FindPremises)<>'' then fm.edPremises.Text:=FindPremises;

  fm.cbInString.Checked:=FilterInSide;

  fm.ChangeFlag:=false;

  if fm.ShowModal=mrOk then begin

    inherited;

    FindAdvertisment:=Trim(fm.edAdvertisment.Text);
    FindAgent:=Trim(fm.edAgent.Text);
    FindPremises:=Trim(fm.edPremises.Text);

    FilterInSide:=fm.cbInString.Checked;
    if FilterInSide then filstr:='%';

    ActiveQuery(false);
    ViewCount;
  end;
 finally
  fm.Free;
 end;
end;

function TfmRBPms_Premises_Advertisment.GetFilterString: string;
var
  FilInSide: string;
  wherestr: string;
  addstr1,addstr2,addstr3: string;
  and1,and2: string;
begin
    Result:=Inherited GetFilterString;
    if Trim(Result)<>'' then exit;

    isFindAdvertisment:=Trim(FindAdvertisment)<>'';
    isFindAgent:=Trim(FindAgent)<>'';
    isFindPremises:=Trim(FindPremises)<>'';

    if isFindAdvertisment or isFindAgent or isFindPremises then begin
     wherestr:=' where ';
    end else begin
    end;

    if FilterInside then FilInSide:='%';

     if isFindAdvertisment then begin
        addstr1:=' Upper(pa.name) like '+AnsiUpperCase(QuotedStr(FilInSide+FindAdvertisment+'%'))+' ';
     end;

     if isFindAgent then begin
        addstr2:=' Upper(pag.name) like '+AnsiUpperCase(QuotedStr(FilInSide+FindAgent+'%'))+' ';
     end;

     if isFindPremises then begin
        addstr3:=' Upper(p.pms_premises_id) like '+AnsiUpperCase(QuotedStr(FilInSide+FindPremises+'%'))+' ';
     end;

     if (isFindAdvertisment and isFindAgent)
     or (isFindAdvertisment and isFindPremises)
     then and1:=' and ';
     if (isFindAgent and isFindPremises)
     then
      and2:=' and ';
     Result:=wherestr+addstr1+and1+
                      addstr2+and2+addstr3;
end;


end.
