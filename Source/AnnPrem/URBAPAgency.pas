unit URBAPAgency;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  URBAP, Menus, IBCustomDataSet, IBUpdateSQL, IBDatabase, Db, IBQuery, DBGrids,
  DBCtrls, StdCtrls, ExtCtrls, UEditRBAP, UEditRBAPAgency;

type
  TfmRBAPAgency = class(TfmRBAP)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FIndexFindPhones: Integer;
    FIndexFindAddress: Integer;
    FIndexFindSite: Integer;
    FIndexFindEmail: Integer;
    FIndexFieldView: Integer;
  protected
    procedure InitColumns; override;
    procedure InitFilters; override;
    procedure InitOrders; override;
    function GetSortFieldName(FieldName: String): String; override;
    function GetEditClass: TfmEditRBAPClass; override;
  public
    property IndexFindPhones: Integer read FIndexFindPhones write FIndexFindPhones;
    property IndexFindAddress: Integer read FIndexFindAddress write FIndexFindAddress;
    property IndexFindSite: Integer read FIndexFindSite write FIndexFindSite;
    property IndexFindEmail: Integer read FIndexFindEmail write FIndexFindEmail;
    property IndexFieldView: Integer read FIndexFieldView write FIndexFieldView;
  end;

var
  fmRBAPAgency: TfmRBAPAgency;

implementation

uses UAnnPremData, UMainUnited;

{$R *.DFM}

procedure TfmRBAPAgency.FormCreate(Sender: TObject);
begin
  inherited;
  Caption:=NameRbkAPAgency;
  QuerySQL:=SQLRbkAPAgency;
  TableName:=tbAPAgency;
  DeleteQuery:='��������� <%s> ?';
end;

procedure TfmRBAPAgency.FormDestroy(Sender: TObject);
begin
  inherited;
  if FormState=[fsCreatedMDIChild] then
    fmRBAPAgency:=nil;
end;

procedure TfmRBAPAgency.InitColumns;
var
  cl: TColumn;
begin
  inherited InitColumns;

  cl:=Grid.Columns.Add;
  cl.FieldName:='ADDRESS';
  cl.Title.Caption:='�����';
  cl.Width:=200;

  cl:=Grid.Columns.Add;
  cl.FieldName:='PHONES';
  cl.Title.Caption:='��������';
  cl.Width:=100;

end;

procedure TfmRBAPAgency.InitFilters;
begin
  inherited InitFilters;
  Filters.Items[IndexFindName].FieldName:='A.NAME';
  Filters.Items[IndexFindFullName].FieldName:='A.FULLNAME';
  FIndexFindPhones:=Filters.Add('PHONES',tdbcLike,false).Index;
  FIndexFindAddress:=Filters.Add('ADDRESS',tdbcLike,false).Index;
  FIndexFindSite:=Filters.Add('SITE',tdbcLike,false).Index;
  FIndexFindEmail:=Filters.Add('EMAIL',tdbcLike,false).Index;
  FIndexFieldView:=Filters.Add('F.NAME',tdbcLike,false).Index;
end;

procedure TfmRBAPAgency.InitOrders;
begin
  inherited InitOrders;
  DefaultOrders.Items[0].FieldName:='A.NAME';
  DefaultOrders.Items[1].FieldName:='A.FULLNAME';
  DefaultOrders.Items[2].FieldName:='A.PRIORITY';
end;

function TfmRBAPAgency.GetEditClass: TfmEditRBAPClass;
begin
  Result:=TfmEditRBAPAgency;
end;

function TfmRBAPAgency.GetSortFieldName(FieldName: String): String;
begin
  Result:=inherited GetSortFieldName(FieldName);
  if AnsiSameText(FieldName,'NAME') then Result:='A.NAME';
  if AnsiSameText(FieldName,'FULLNAME') then Result:='A.FULLNAME';
  if AnsiSameText(FieldName,'PRIORITY') then Result:='A.PRIORITY';
end;

end.
