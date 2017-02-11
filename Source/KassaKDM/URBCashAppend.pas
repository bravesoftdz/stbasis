unit URBCashAppend;

interface

{$I stbasis.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  URBMainGrid, Db, IBCustomDataSet, IBQuery, DBCtrls, StdCtrls, Buttons,
  ExtCtrls, dbgrids, IBDatabase, IB, Menus, IBUpdateSQL, tsvDbGrid;

type
    TfmRBCashAppend = class(TfmRBMainGrid)
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bibRefreshClick(Sender: TObject);
    procedure bibAddClick(Sender: TObject);
    procedure bibChangeClick(Sender: TObject);
    procedure bibDelClick(Sender: TObject);
    procedure bibViewClick(Sender: TObject);
    procedure bibFilterClick(Sender: TObject);
//    procedure Button1Click(Sender: TObject);
  private
    isFindCA_Text: Boolean;
    FindCA_Text: String;
  protected
    procedure GridDblClick(Sender: TObject); override;
    procedure SaveToIni;override;
    procedure LoadFromIni; override;
    function GetFilterString: string;
    procedure GridTitleClickWithSort(Column: TColumn; TypeSort: TTypeColumnSort); override;
    function GetSql: string; override;
  public
    procedure ActiveQuery(CheckPerm: Boolean);override;
  end;

var
  fmRBCashAppend: TfmRBCashAppend;

implementation

uses UMainUnited, UKassaKDMCode, UKassaKDMDM, UKassaKDMData, UEditRBCashAppend;

{$R *.DFM}

procedure TfmRBCashAppend.FormCreate(Sender: TObject);
var
 cl: TColumn;
begin
 inherited;
 try
  Caption:=NameRbkCashAppend;
  Mainqr.Database:=IBDB;
  IBTran.AddDatabase(IBDB);
  IBDB.AddTransaction(IBTran);

  cl:=Grid.Columns.Add;
  cl.FieldName:='ca_text';
  cl.Title.Caption:='���������� ��������� ������';
  cl.Width:=180;

  LoadFromIni;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBCashAppend.FormDestroy(Sender: TObject);
begin
  inherited;
  if FormState=[fsCreatedMDIChild] then
   fmRBCashAppend:=nil;
end;

procedure TfmRBCashAppend.ActiveQuery(CheckPerm: Boolean);
var
 sqls: String;
begin
 try
  Mainqr.Active:=false;
  if CheckPerm then
   if not CheckPermission then exit;

  Screen.Cursor:=crHourGlass;
  try
   Mainqr.sql.Clear;
   sqls:=GetSQL;
   Mainqr.sql.Add(sqls);
   Mainqr.Transaction.Active:=false;
   Mainqr.Transaction.Active:=true;
   Mainqr.Active:=true;
   SetImageFilter(isFindCA_Text);
   ViewCount;
  finally
   Screen.Cursor:=crDefault;
  end;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

{procedure TfmRBCashAppend.GridTitleClick(Column: TColumn);
var
  fn: string;
  id1: string;
  sqls: string;
begin
 try
  if not MainQr.Active then exit;
  if MainQr.RecordCount=0 then exit;
  Screen.Cursor:=crHourGlass;
  try
   fn:=Column.FieldName;
   if UpperCase(fn)=UpperCase('c�_text') then fn:='ca_text';
   id1:=MainQr.fieldByName('CA_TEXT').asString;
   MainQr.Active:=false;
   MainQr.SQL.Clear;
   LastOrderStr:=' Order by '+fn;
   sqls:='Select * from '+tbCashAppend+' '+
         GetFilterString+LastOrderStr;
   MainQr.SQL.Add(sqls);
   MainQr.Transaction.Active:=false;
   MainQr.Transaction.Active:=true;
   MainQr.Active:=true;
   MainQr.First;
   MainQr.Locate('CA_TEXT',id1,[LocaseInsensitive]);
  finally
    Screen.Cursor:=crDefault;
  end;
 except
  {$IFDEF DEBUG} //on E: Exception do Assert(false,E.message); {$ENDIF}
{ end;
end;}

procedure TfmRBCashAppend.GridDblClick(Sender: TObject);
begin
  if not Mainqr.Active then exit;
  if Mainqr.RecordCount=0 then exit;
  if pnSQL.Visible and bibChange.Enabled then begin
   bibChange.Click;
  end else bibView.Click;
end;

procedure TfmRBCashAppend.LoadFromIni;
begin
 inherited;
 try
    FindCA_Text:=ReadParam(ClassName,'ca_text',FindCA_Text);
    FilterInside:=ReadParam(ClassName,'Inside',FilterInside);
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBCashAppend.SaveToIni;
begin
 Inherited;
 try
   WriteParam(ClassName,'ca_text',FindCA_Text);
   WriteParam(ClassName,'Inside',FilterInside);
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBCashAppend.bibRefreshClick(Sender: TObject);
begin
  ActiveQuery(true);
end;

procedure TfmRBCashAppend.bibAddClick(Sender: TObject);
var
  fm: TfmEditRBCashAppend;
begin
 try
  if not Mainqr.Active then exit;
  fm:=TfmEditRBCashAppend.Create(nil);
  try
    fm.bibOk.OnClick:=fm.AddClick;
    fm.Caption:=CaptionAdd;
    if fm.ShowModal=mrok then begin
     ActiveQuery(false);
     MainQr.Locate('ca_text',Trim(fm.Edit.Text),[loCaseInsensitive]);
    end;
  finally
    fm.Free;
  end;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBCashAppend.bibChangeClick(Sender: TObject);
var
  fm: TfmEditRBCashAppend;
begin
 try
  if Mainqr.isEmpty then exit;
  fm:=TfmEditRBCashAppend.Create(nil);
  try
    fm.bibOk.OnClick:=fm.ChangeClick;
    fm.Caption:=CaptionChange;
    fm.ca_id:=Mainqr.fieldByName('ca_id').AsInteger;
    fm.Edit.Text:=Mainqr.fieldByName('ca_text').AsString;
    fm.ca_text:=Mainqr.fieldByName('ca_text').AsString;
    fm.oldca_text:=fm.ca_text;
    fm.ChangeFlag := false;
    if fm.ShowModal=mrok then begin
     ActiveQuery(false);
     MainQr.Locate('ca_text',Trim(fm.Edit.Text),[loCaseInsensitive]);
    end;
  finally
    fm.Free;
  end;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBCashAppend.bibDelClick(Sender: TObject);
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
     sqls:='Delete from '+tbCashAppend+
           ' where ca_id='+ QuotedStr(Mainqr.FieldByName('ca_id').asString);
     qr.sql.Add(sqls);
     qr.ExecSQL;
     qr.Transaction.Commit;
     ActiveQuery(false);
     Result:=true;
    except
     on E: EIBInterBaseError do begin
        TempStr:=TranslateIBError(E.Message);
        ShowError(Handle,TempStr);
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
  if  Mainqr.isEmpty then exit;
  but:=MessageBox(Application.Handle,
                  Pchar(CaptionDelete+' ������� ������ ?'),
                  ConstWarning,MB_YESNO+MB_ICONWARNING);
  if but=ID_YES then begin
    if not deleteRecord then begin
      ShowError(Application.Handle,
               '������ � ���������� <'+Mainqr.FieldByName('taname').AsString+
               '> � ������������ <'+Mainqr.FieldByName('tuname').AsString+'> ������������.');
    end;
  end;
end;

procedure TfmRBCashAppend.bibViewClick(Sender: TObject);
var
  fm: TfmEditRBCashAppend;
begin
 try
  if not Mainqr.Active then exit;
  if Mainqr.RecordCount=0 then exit;
  fm:=TfmEditRBCashAppend.Create(nil);
  try
    fm.bibOk.OnClick:=nil;
    fm.bibOk.Visible:=false;
    fm.bibCancel.Caption:=CaptionClose;
    fm.Caption:=CaptionView;
    fm.ca_id:=Mainqr.fieldByName('ca_id').AsInteger;
    fm.Edit.Text:=Mainqr.fieldByName('ca_text').AsString;
    fm.ca_text:=Mainqr.fieldByName('ca_text').AsString;
    if fm.ShowModal=mrok then begin
    end;
  finally
    fm.Free;
  end;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRBCashAppend.bibFilterClick(Sender: TObject);
var
  fm: TfmEditRBCashAppend;
  filstr: string;
begin
try
 fm:=TfmEditRBCashAppend.Create(nil);
 try
  fm.Caption:=CaptionFilter;
  fm.bibOK.OnClick:=fm.filterClick;
  fm.Edit.Color:=clWindow;
  fm.Edit.ReadOnly:=false;

  if Trim(FindCA_Text)<>'' then fm.Edit.Text:=FindCA_Text;

  fm.cbInString.Visible:=true;
  fm.bibClear.Visible:=true;
  fm.cbInString.Checked:=FilterInSide;

  fm.ChangeFlag:=false;

  if fm.ShowModal=mrOk then begin

    FindCA_Text:=Trim(fm.Edit.Text);

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

function TfmRBCashAppend.GetFilterString: string;
var
  FilInSide: string;
  wherestr: string;
  addstr2: string;
begin
    Result:=Inherited GetFilterString;
    if Trim(Result)<>'' then begin
      exit;
    end;

    isFindCA_Text:=Trim(FindCA_Text)<>'';

    if isFindCA_Text then begin
     wherestr:=' where ';
    end else begin
    end;

    if FilterInside then FilInSide:='%';

     if isFindCA_Text then begin
        addstr2:=' Upper(ca_text) like '+AnsiUpperCase(QuotedStr(FilInSide+FindCA_Text+'%'))+' ';
     end;

     Result:=wherestr+addstr2;
end;


{procedure TfmRBCashAppend.Button1Click(Sender: TObject);
var
  P: PCashAppendParams;
begin
  GetMem(P,SizeOf(TCashAppendParams));
  try
    FillChar(P^,SizeOf(TCashAppendParams),0);
    P.username:='adminuser';
    if _ViewEntryFromMain(tte_rbksCashAppend,P,true) then begin
      ShowMessage(P.username);
    end;
  finally
    FreeMem(P,SizeOf(TCashAppendParams));
  end;

end;
}

function TfmRBCashAppend.GetSql: string;
begin
  Result:= inherited GetSql;
  if Trim(Result)<>'' then exit;
  Result:=SQLRbkCashAppend+GetFilterString+GetLastOrderStr;
end;

procedure TfmRBCashAppend.GridTitleClickWithSort(Column: TColumn; TypeSort: TTypeColumnSort);
var
  fn: string;
  id: string;
begin
 try
   if not MainQr.Active then exit;
   fn:=Column.FieldName;
   id:=MainQr.fieldByName('ca_id').asString;
   SetLastOrderFromTypeSort(fn,TypeSort);
   ActiveQuery(false);
   MainQr.First;
   MainQr.Locate('ca_id',id,[loCaseInsensitive]);
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

end.
