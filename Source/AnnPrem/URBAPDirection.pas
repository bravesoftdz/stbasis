unit URBAPDirection;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  URBAP, Menus, IBCustomDataSet, IBUpdateSQL, IBDatabase, Db, IBQuery,
  DBCtrls, StdCtrls, ExtCtrls;

type
  TfmRBAPDirection = class(TfmRBAP)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRBAPDirection: TfmRBAPDirection;

implementation

uses UAnnPremData;

{$R *.DFM}

procedure TfmRBAPDirection.FormCreate(Sender: TObject);
begin
  inherited;
  Caption:=NameRbkAPDirection;
  QuerySQL:=SQLRbkAPDirection;
  TableName:=tbAPDirection;
  DeleteQuery:='направление <%s> ?';
end;

procedure TfmRBAPDirection.FormDestroy(Sender: TObject);
begin
  inherited;
  if FormState=[fsCreatedMDIChild] then
    fmRBAPDirection:=nil;
end;

end.
