unit URbkCountry;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  URbk, IBDatabase, Db, IBCustomDataSet, IBQuery, Grids, DBGrids, StdCtrls,
  DBCtrls, ExtCtrls, Buttons;

type
  TFmRbkCountry = class(TFmRbk)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtDelClick(Sender: TObject);
  private
  protected
    procedure GridTitleClick(Column: TColumn); override;
    procedure GridDblClick(Sender: TObject); override;
  public
    procedure SetGridTitleNames;
    { Public declarations }
  end;

var
  FmRbkCountry: TFmRbkCountry;

implementation
Uses UmainUnited, Uconst, UFuncProc;
{$R *.DFM}

procedure TFmRbkCountry.FormCreate(Sender: TObject);
begin
  inherited;
  Caption:=NameCountry;
  SetGridTitleNames;
  LoadFromIni;
  CreateSQl(tbCountry);
end;

procedure TFmRbkCountry.FormDestroy(Sender: TObject);
begin
  inherited;
  if FormState=[fsCreatedMDIChild] then  fmRBkCountry:=nil;
end;

procedure TFmRbkCountry.BtDelClick(Sender: TObject);
begin
  DeletingRec:='������ <'+RbkQuery.FieldByName('name').AsString+'> ?';
  inherited;
end;


procedure TFmRbkCountry.GridTitleClick(Column: TColumn);
var
  fn: string;
  id: Integer;
begin
  if not RbkQuery.Active then exit;
  if RbkQuery.RecordCount=0 then exit;
  Screen.Cursor:=crHourGlass;
  try
   fn:=Column.FieldName;
   id:=RbkQuery.fieldByName(tbCountry+'_id').asInteger;
   RbkQuery.Active:=false;
   RbkQuery.SQL.Clear;
   OrderSQL:=' Order by '+fn;
   RefreshQuery(true);
   Locate(id);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFmRbkCountry.GridDblClick(Sender: TObject);
begin
  if not RbkQuery.Active then exit;
  if RbkQuery.RecordCount=0 then exit;
  if PnModify.Visible and BtEdit.Enabled then begin
   BtEdit.Click;
  end else BtMore.Click;
end;

procedure TFmRbkCountry.SetGridTitleNames;
var
  cl:TColumn;
  P:PFilterParams;
begin
  cl:=Grid.Columns.Add;
  cl.FieldName:='Code';
  cl.Title.Caption:='���';
  cl.Width:=40;
  New(P);
  P.GridName:='Code';
  P.FieldName:='Code';
  FilterValues.Add(P);

  cl:=Grid.Columns.Add;
  cl.FieldName:='Name';
  cl.Title.Caption:='�������� ������';
  cl.Width:=350;
  New(P);
  P.GridName:='Name';
  P.FieldName:='Name';
  FilterValues.Add(P);
end;


end.
