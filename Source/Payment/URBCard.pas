unit URBCard;

interface

{$I stbasis.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  URBMainGrid, Db, IBCustomDataSet, IBQuery, DBCtrls, StdCtrls, Buttons,
  ExtCtrls, dbgrids, IBDatabase, IB, grids, Menus, tsvDbGrid, IBUpdateSQL;

type
   TfmRBCard = class(TfmRBMainGrid)
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bibRefreshClick(Sender: TObject);
    procedure bibAddClick(Sender: TObject);
    procedure bibChangeClick(Sender: TObject);
    procedure bibDelClick(Sender: TObject);
    procedure bibViewClick(Sender: TObject);
    procedure bibFilterClick(Sender: TObject);
  private
    isFindSer,isFindNum: Boolean;
    FindSer,FindNum: String;

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
  fmRBCard: TfmRBCard;

implementation

uses UMainUnited, UPaymentCode, UPaymentDM, UPaymentData, UEditRBCard;

{$R *.DFM}

procedure TfmRBCard.FormCreate(Sender: TObject);
var
  cl: TColumn;
begin
 inherited;
 try
  Caption:=NameRbkCard;
  Mainqr.Database:=IBDB;
  IBTran.AddDatabase(IBDB);
  IBDB.AddTransaction(IBTran);

  cl:=Grid.Columns.Add;
  cl.FieldName:='num_card';
  cl.Title.Caption:='�����';
  cl.Width:=150;

  cl:=Grid.Columns.Add;
  cl.FieldName:='ser_card';
  cl.Title.Caption:='�����';
  cl.Width:=150;

  cl:=Grid.Columns.Add;
  cl.FieldName:='nominal';
  cl.Title.Caption:='�������';
  cl.Width:=60;

  LoadFromIni;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBCard.FormDestroy(Sender: TObject);
begin
  inherited;
  if FormState=[fsCreatedMDIChild] then
   fmRBCard:=nil;
end;

function TfmRBCard.GetSql: string;
begin
  Result:= inherited GetSql;
  if Trim(Result)<>'' then exit;
  Result:=SQLRbkCard+GetFilterString+GetLastOrderStr;
end;

procedure TfmRBCard.ActiveQuery(CheckPerm: Boolean);
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
   SetImageFilter(isFindSer or isFindNum);
   ViewCount;
  finally
   Mainqr.EnableControls; 
   Screen.Cursor:=crDefault;
  end;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBCard.GridTitleClickWithSort(Column: TColumn; TypeSort: TTypeColumnSort);
var
  fn: string;
  id: string;
begin
 try
   if not MainQr.Active then exit;
   fn:=Column.FieldName;
   id:=MainQr.fieldByName('card_id').asString;
   SetLastOrderFromTypeSort(fn,TypeSort);
   ActiveQuery(false);
   MainQr.First;
   MainQr.Locate('card_id',id,[loCaseInsensitive]);
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBCard.GridDblClick(Sender: TObject);
begin
  if not Mainqr.Active then exit;
  if Mainqr.RecordCount=0 then exit;
  if pnSQL.Visible and bibChange.Enabled then begin
   bibChange.Click;
  end else bibView.Click;
end;

procedure TfmRBCard.LoadFromIni;
begin
 inherited;
 try
    FindSer:=ReadParam(ClassName,'ser',FindSer);
    FindNum:=ReadParam(ClassName,'num',FindNum);
    FilterInside:=ReadParam(ClassName,'Inside',FilterInside);
 except
   {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBCard.SaveToIni;
begin
 inherited;
 try
    WriteParam(ClassName,'ser',FindSer);
    WriteParam(ClassName,'num',FindNum);
    WriteParam(ClassName,'Inside',FilterInside);
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBCard.bibRefreshClick(Sender: TObject);
begin
  ActiveQuery(true);
end;

procedure TfmRBCard.bibAddClick(Sender: TObject);
var
  fm: TfmEditRBCard;
begin
  if not Mainqr.Active then exit;
  fm:=TfmEditRBCard.Create(nil);
  try
    fm.fmParent:=Self;
    fm.TypeEditRBook:=terbAdd;
    fm.ChangeFlag:=false;
    if fm.ShowModal=mrok then begin
     ActiveQuery(false);
     MainQr.Locate('card_id',fm.oldcard_id,[loCaseInsensitive]);
    end;
  finally
    fm.Free;
  end;
end;

procedure TfmRBCard.bibChangeClick(Sender: TObject);
var
  fm: TfmEditRBCard;
begin
  if not Mainqr.Active then exit;
  if Mainqr.IsEmpty then exit;
  fm:=TfmEditRBCard.Create(nil);
  try
    fm.fmParent:=Self;
    fm.oldcard_id:=Mainqr.fieldByName('card_id').AsInteger;
    fm.edSer.Text:=Mainqr.fieldByName('ser_card').AsString;
    fm.edNum.Text:=Mainqr.fieldByName('num_card').AsString;
    fm.edNominal.Text:=Mainqr.fieldByName('nominal').AsString;
    fm.dtpDateBegin.Date:=Mainqr.fieldByName('date_begin').Value;
    fm.dtpDateEnd.Date:=Mainqr.fieldByName('date_end').Value;
    fm.TypeEditRBook:=terbChange;
    fm.ChangeFlag:=false;
    if fm.ShowModal=mrok then begin
     ActiveQuery(false);
     MainQr.Locate('card_id',fm.oldcard_id,[loCaseInsensitive]);
    end;
  finally
    fm.Free;
  end;
end;

procedure TfmRBCard.bibDelClick(Sender: TObject);
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
     sqls:='Delete from '+tbCard+' where card_id='+
          Mainqr.FieldByName('card_id').asString;
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
  but:=DeleteWarningEx('����� � ������� <'+Mainqr.FieldByName('num_card').AsString+'> ?');
  if but=mrYes then begin
    if not deleteRecord then begin
    end;
  end;
end;

procedure TfmRBCard.bibViewClick(Sender: TObject);
var
  fm: TfmEditRBCard;
begin
  if not Mainqr.Active then exit;
  if Mainqr.IsEmpty then exit;
  fm:=TfmEditRBCard.Create(nil);
  try
    fm.fmParent:=Self;
    fm.TypeEditRBook:=terbView;
    fm.oldcard_id:=Mainqr.fieldByName('card_id').AsInteger;
    fm.edSer.Text:=Mainqr.fieldByName('ser_card').AsString;
    fm.edNum.Text:=Mainqr.fieldByName('num_card').AsString;
    fm.edNominal.Text:=Mainqr.fieldByName('nominal').AsString;
    fm.dtpDateBegin.Date:=Mainqr.fieldByName('date_begin').Value;
    fm.dtpDateEnd.Date:=Mainqr.fieldByName('date_end').Value;
    if fm.ShowModal=mrok then begin
    end;
  finally
    fm.Free;
  end;
end;

procedure TfmRBCard.bibFilterClick(Sender: TObject);
var
  fm: TfmEditRBCard;
  filstr: string;
begin
 fm:=TfmEditRBCard.Create(nil);
 try
  fm.TypeEditRBook:=terbFilter;

  fm.edNominal.Enabled:=false;
  fm.edNominal.Color:=clBtnFace;
  fm.dtpDateBegin.Enabled:=false;
  fm.dtpDateBegin.Color:=clBtnFace;
  fm.dtpDateend.Enabled:=false;
  fm.dtpDateend.Color:=clBtnFace;

  if Trim(FindSer)<>'' then fm.edSer.Text:=FindSer;
  if Trim(FindNum)<>'' then fm.edNum.Text:=FindNum;

  fm.cbInString.Checked:=FilterInSide;

  fm.ChangeFlag:=false;

  if fm.ShowModal=mrOk then begin

    Inherited;

    FindSer:=Trim(fm.edSer.Text);
    FindNum:=Trim(fm.edNum.Text);

    FilterInSide:=fm.cbInString.Checked;
    if FilterInSide then filstr:='%';

    ActiveQuery(false);
    ViewCount;
  end;
 finally
  fm.Free;
 end;
end;

function TfmRBCard.GetFilterString: string;
var
  FilInSide: string;
  wherestr: string;
  addstr1,addstr2: string;
  and1: string;
begin
    Result:=Inherited GetFilterString;
    if Trim(Result)<>'' then exit;

    isFindSer:=Trim(FindSer)<>'';
    isFindNum:=Trim(FindNum)<>'';

    if isFindSer or isFindNum then begin
     wherestr:=' where ';
    end else begin
    end;

    if FilterInside then FilInSide:='%';

     if isFindSer then begin
        addstr1:=' Upper(ser_card) like '+AnsiUpperCase(QuotedStr(FilInSide+FindSer+'%'))+' ';
     end;

     if isFindNum then begin
        addstr2:=' Upper(num_card) like '+AnsiUpperCase(QuotedStr(FilInSide+FindNum+'%'))+' ';
     end;

     if (isFindSer and isFindNum)then
      and1:=' and ';

     Result:=wherestr+addstr1+and1+
                      addstr2;
end;


end.
