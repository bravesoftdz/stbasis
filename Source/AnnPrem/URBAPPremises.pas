unit URBAPPremises;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  URBMainGrid, Menus, IBCustomDataSet, IBUpdateSQL, IBDatabase, Db,
  IBQuery, DBCtrls, StdCtrls, ExtCtrls, dbgrids,
  UMainUnited, tsvDbGrid,
  UEditRBAPPremises, ImgList, VirtualTrees, VirtualDBTree,
  tsvMemIniFile, tsvInterbase, tsvDbFilter;

type
  TPremisesColumn=class(TColumn)
  private
    FAlias: String;
    FFilter: Integer;
    FFilterObj: TtsvDbFilterItem;
  protected
    property FilterObj: TtsvDbFilterItem read FFilterObj write FFilterObj;
  public
    property Alias: String read FAlias write FAlias;
    property Filter: Integer read FFilter write FFilter;
  end;

  TPremisesIniFile=class(TtsvMemIniFile)
  private
    function GetEmpty: Boolean;
  public
    property Empty: Boolean read GetEmpty;
  end;

  TfmRBAPPremises = class(TfmRBMainGrid)
    pnTree: TPanel;
    Splitter: TSplitter;
    IL: TImageList;
    qrTree: TIBQuery;
    trTree: TIBTransaction;
    dsTree: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure bibAddClick(Sender: TObject);
    procedure bibChangeClick(Sender: TObject);
    procedure bibDelClick(Sender: TObject);
    procedure bibViewClick(Sender: TObject);
    procedure bibFilterClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bibRefreshClick(Sender: TObject);
    procedure bibAdjustClick(Sender: TObject);
  private
    FTree: TVirtualDBTree;
    FQuerySQL: String;
    FIndexFindName: Integer;
    FFieldKeyName: String;
    FTableName: String;
    FDeleteQuery: String;
    FSaveOperationId: Integer;
    FOldOperationId: Integer;
    FOldFieldViewId: Integer;
    FMemIniFile: TPremisesIniFile;
    FSaved: Boolean;

    procedure SetTableName(Value: String);
    procedure TreeViewClick(Sender: TObject);
    procedure TreeViewChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure TreeViewOnGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
                                      Kind: TVTImageKind; Column: Integer;  var Ghosted: Boolean; var ImageIndex: Integer);
    function ActiveQueryTree: Boolean;
    procedure ActiveQueryGrid(EnabledInit: Boolean=true);
    procedure PermByFieldView;
    procedure LoadFieldDefs;
    procedure SaveFieldDefs;
  protected
    procedure InitColumns; virtual;
    procedure InitFilters; virtual;
    procedure InitOrders; virtual;
    function GetSql: string; override;
    procedure GridTitleClickWithSort(Column: TColumn; TypeSort: TTypeColumnSort); override;
    function GetEditClass: TfmEditRBAPPremisesClass; virtual;
    function GetFilterString: string; override;
    procedure SetPositionEdSearch; override;
    function GetDefaultOrdersName: string; override;
    procedure SaveToIni; override;
    procedure LoadFromIni; override;
  public
    procedure ActiveQuery(CheckPerm: Boolean);override;
    procedure SaveGridProp(ClsName: string; Grd: TDBGrid); override;
    procedure LoadGridProp(ClsName: string; Grd: TDBGrid); override;

    property QuerySQL: String read FQuerySQL write FQuerySQL;
    property FieldKeyName: String read FFieldKeyName write FFieldKeyName;
    property TableName: String read FTableName write SetTableName;
    property DeleteQuery: String read FDeleteQuery write FDeleteQuery;

    property IndexFindName: Integer read FIndexFindName write FIndexFindName;

  end;

var
  fmRBAPPremises: TfmRBAPPremises;

implementation

uses UAnnPremCode, UAnnPremDM, UAnnPremData, tsvAdjust;

{$R *.DFM}

function TPremisesIniFile.GetEmpty: Boolean;
begin
  Result:=not SectionExists(SColumns);
end;

procedure TfmRBAPPremises.FormCreate(Sender: TObject);
begin
  inherited;
  FMemIniFile:=TPremisesIniFile.Create;

  FTree:=TVirtualDBTree.Create(nil);
  FTree.Parent:=pnTree;
  AssignFont(_GetOptions.RBTableFont,FTree.Font);
  FTree.Align:=alClient;
  FTree.Images:=IL;
  FTree.DataSource:=dsTree;
  FTree.Margin:=2;
  FTree.DefaultNodeHeight:=16;
  FTree.OnKeyDown:=FormKeyDown;
  FTree.OnClick:=TreeViewClick;
  FTree.OnChange:=TreeViewChange;
  FTree.OnGetImageIndex:=TreeViewOnGetImageIndex;
  FTree.TabOrder:=1;

  qrTree.Database:=IBDB;
  trTree.AddDatabase(IBDB);
  IBDB.AddTransaction(trTree);

  FTree.KeyFieldName:='AP_OPERATION_ID';
  FTree.ParentFieldName:='PARENT_ID';
  FTree.ViewFieldName:='NAME';

  Mainqr.Database:=IBDB;
  Database:=IBDB;
  IBTran.AddDatabase(IBDB);
  IBDB.AddTransaction(IBTran);

  Grid.Visible:=false;
  
  InitColumns;
  InitFilters;
  InitOrders;
  
  Caption:=NameRbkAPPremises;
  TableName:=tbAPPremises;
  QuerySQL:=SQLRbkAPPremises;
  DeleteQuery:='������� �������?';
  LoadFromIni;

end;

procedure TfmRBAPPremises.InitColumns;
var
  Column: TPremisesColumn;
  Section: TStringList;
  i: Integer;
  AName: String;
begin
  Grid.Columns.BeginUpdate;
  Section:=TStringList.Create;
  try
    Grid.Columns.Clear;
    FMemIniFile.ReadSection(SColumns,Section);
    for i:=0 to Section.Count-1 do begin
      AName:=Section.Strings[i];
      Column:=TPremisesColumn.Create(Grid.Columns);
      Column.Visible:=FMemIniFile.ReadBool(SColumns,AName,false);
      Column.FieldName:=FMemIniFile.ReadString(AName,SField,'');
      Column.Title.Caption:=AName;
      Column.Width:=FMemIniFile.ReadInteger(AName,SWidth,64);
      Column.Alias:=FMemIniFile.ReadString(AName,SAlias,'');
      Column.Filter:=FMemIniFile.ReadInteger(AName,SFilter,-1);
    end;
  finally
    Section.Free;
    Grid.Columns.EndUpdate;
  end;
end;

procedure TfmRBAPPremises.InitFilters;
var
  i: Integer;
  Column: TPremisesColumn;
begin
  Filters.Clear;
  if not FMemIniFile.Empty then begin
    for i:=0 to Grid.Columns.Count-1 do begin
      Column:=TPremisesColumn(Grid.Columns.Items[i]);
      Column.FilterObj:=Filters.Add(Column.Alias,tdbcLike,false);
      Column.FilterObj.Caption:=Column.Title.Caption;
      if AnsiSameText(Column.FieldName,'DELIVERY_DATE') then begin
        with Column.FilterObj do begin
          TypeCondition:=tdbcEqualGreater;
          CheckCase:=true;
          TypeCondition2:=tdbcEqualLess;
          CheckCase2:=true;
        end;  
      end;
      if AnsiSameText(Column.FieldName,'PRICE') then begin
        with Column.FilterObj do begin
          TypeCondition:=tdbcEqualLess;
          CheckCase:=true;
        end;
      end;
    end;
  end;   
end;

procedure TfmRBAPPremises.InitOrders;
var
  i: Integer;
  Column: TPremisesColumn;
begin
  DefaultOrders.Clear;
  if not FMemIniFile.Empty then begin
    for i:=0 to Grid.Columns.Count-1 do begin
      Column:=TPremisesColumn(Grid.Columns.Items[i]);
      DefaultOrders.Add(Column.Title.Caption,Column.Alias,false);
    end;
  end;    
end;

function TfmRBAPPremises.GetSql: string;
begin
  Result:= inherited GetSql;
  if Trim(Result)<>'' then exit;
  Result:=FQuerySQL+GetFilterString+GetLastOrderStr;
end;

function TfmRBAPPremises.ActiveQueryTree: Boolean;
var
  sqls: String;
begin
  Result:=false;
  qrTree.DisableControls;
  try
   qrTree.sql.Clear;
   sqls:=SQLRbkAPOperation+' ORDER BY C.INC ';
   qrTree.sql.Add(sqls);
   qrTree.Transaction.Active:=false;
   qrTree.Transaction.Active:=true;
   qrTree.Active:=true;
   if qrTree.Active and not qrTree.IsEmpty then begin
     FOldOperationId:=qrTree.FieldByName('AP_OPERATION_ID').AsInteger;
     FOldFieldViewId:=qrTree.FieldByName('AP_FIELD_VIEW_ID').AsInteger;
   end;
  finally
   qrTree.EnableControls;
  end;

  if qrTree.Active and not qrTree.IsEmpty then begin
    if FSaveOperationId<>FOldOperationId then begin
      Result:=not qrTRee.Locate('AP_OPERATION_ID',FSaveOperationId,[loCaseInsensitive, loPartialKey]);
    end else Result:=true;
  end;  
end;

procedure TfmRBAPPremises.PermByFieldView;
var
  Perm: Boolean;
begin
  Perm:=not VarIsNull(qrTree.FieldByName('AP_FIELD_VIEW_ID').Value);
  isPerm:=_isPermissionOnInterface(FhInterface,ttiaView);
  bibOk.Enabled:=isPerm;
  if not ViewSelect then begin
    bibChange.Enabled:=isPerm and _isPermissionOnInterface(FhInterface,ttiaChange) and Perm;
    bibAdd.Enabled:=isPerm and _isPermissionOnInterface(FhInterface,ttiaAdd) and Perm;
    bibDel.Enabled:=isPerm and _isPermissionOnInterface(FhInterface,ttiaDelete) and Perm;
    bibView.Enabled:=isPerm and Perm;
    bibFilter.Enabled:=isPerm and Perm;
    bibAdjust.Enabled:=isPerm and Perm;
    bibPreview.Enabled:=isPerm and ExistsExcel and Perm;
  end else begin
   pnSQL.Visible:=false;
  end;
end;

procedure TfmRBAPPremises.LoadFieldDefs;
var
  Stream: TStringStream;
  S: String;
begin
  if qrTRee.Active and not qrTRee.IsEmpty then begin
    if not VarIsNull(qrTree.FieldByName('AP_FIELD_VIEW_ID').Value) then begin
      S:=GetFirstValueBySQL(IBDB,
                            Format('SELECT FIELDS FROM AP_FIELD_VIEW WHERE AP_FIELD_VIEW_ID=%s',
                                   [qrTree.FieldByName('AP_FIELD_VIEW_ID').AsString]),
                            'FIELDS');
      Stream:=TStringStream.Create(S);
      try
        FMemIniFile.Clear;
        FMemIniFile.LoadFromStream(Stream);
        FSaved:=false;
      finally
        Stream.Free;
      end;
    end;
  end;
end;

procedure TfmRBAPPremises.SaveFieldDefs;
var
  Stream: TStringStream;
  Column: TPremisesColumn;
  i: Integer;
begin
  if Grid.Visible and not FMemIniFile.Empty and not FSaved then begin
    FMemIniFile.Clear;
    for i:=0 to Grid.Columns.Count-1 do begin
      Column:=TPremisesColumn(Grid.Columns[i]);
      with FMemIniFile do begin
        WriteBool(SColumns,Column.Title.Caption,Column.Visible);
        WriteString(Column.Title.Caption,SField,Column.FieldName);
        if Column.Visible then
          WriteInteger(Column.Title.Caption,SWidth,Column.Width);
        WriteString(Column.Title.Caption,SAlias,Column.Alias);
        if Assigned(Column.FilterObj) then
          WriteInteger(Column.Title.Caption,SFilter,Column.Filter);
      end;
    end;

    Stream:=TStringStream.Create('');
    try
      FMemIniFile.SaveToStream(Stream);
      ExecSql(IBDB,
              Format('UPDATE AP_FIELD_VIEW SET FIELDS=%s WHERE AP_FIELD_VIEW_ID=%s',
                     [QuotedStr(Stream.DataString),IntToStr(FOldFieldViewId)]));
      FSaved:=true;                     
    finally
      Stream.Free;
    end;
  end;
end;

procedure TfmRBAPPremises.ActiveQueryGrid(EnabledInit: Boolean=true);
var
  sqls: String;
begin
  Mainqr.Active:=false;
  if VarIsNull(qrTree.FieldByName('AP_FIELD_VIEW_ID').Value) then begin
    if EnabledInit then begin
      SaveFieldDefs;
      PermByFieldView;
      LoadFieldDefs;
      Grid.Visible:=false;
    end;
  end else begin
    if EnabledInit then begin
      SaveFieldDefs;
      PermByFieldView;
      LoadFieldDefs;
    end;  
    Mainqr.DisableControls;
    try
      if EnabledInit then begin
        InitColumns;
        InitFilters;
        LoadDbFilters(ClassName,Filters);
        InitOrders;
        LoadDbOrders(ClassName,DefaultOrders);
      end;
      Mainqr.sql.Clear;
      sqls:=GetSql;
      Mainqr.sql.Add(sqls);
      Mainqr.Transaction.Active:=false;
      Mainqr.Transaction.Active:=true;
      Mainqr.Active:=true;
      SetImageFilter(Filters.Enabled);
      ViewCount;
      Grid.Visible:=true;
    finally
      Mainqr.EnableControls;
    end;
  end;
end;

procedure TfmRBAPPremises.ActiveQuery(CheckPerm: Boolean);
begin
  try
    Screen.Cursor:=crHourGlass;
    try
      qrTree.Active:=false;
      Mainqr.Active:=false;
      if CheckPerm then
        if not CheckPermission then exit;
      if ActiveQueryTree then
        ActiveQueryGrid;
    finally
      Screen.Cursor:=crDefault;
    end;
  except
   {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
  end;
end;


procedure TfmRBAPPremises.GridTitleClickWithSort(Column: TColumn; TypeSort: TTypeColumnSort);
var
  fn: string;
  id: string;
begin
  try
    if not MainQr.Active then exit;
    fn:=TPremisesColumn(Column).Alias;
    id:=MainQr.fieldByName(FFieldKeyName).asString;
    SetLastOrderFromTypeSort(fn,TypeSort);
    ActiveQueryGrid(false);
    MainQr.First;
    MainQr.Locate(FFieldKeyName,id,[loCaseInsensitive]);
  except
   {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
  end;
end;

procedure TfmRBAPPremises.bibAddClick(Sender: TObject);
var
  fm: TfmEditRBAPPremises;
begin
  if not Mainqr.Active then exit;
  fm:=GetEditClass.Create(nil);
  try
    fm.ParentForm:=Self;
    fm.InitAdd;
    fm.ChangeFlag:=false;
    if fm.ShowModal=mrok then begin
     ViewCount;
     MainQr.Locate(FFieldKeyName,fm.OldFieldKeyValue,[loCaseInsensitive]);
    end;
  finally
    fm.Free;
  end;
end;

procedure TfmRBAPPremises.bibChangeClick(Sender: TObject);
var
  fm: TfmEditRBAPPremises;
begin
  if not Mainqr.Active then exit;
  if Mainqr.IsEmpty then exit;
  fm:=GetEditClass.Create(nil);
  try
    fm.ParentForm:=Self;
    fm.InitUpdate;
    fm.ChangeFlag:=false;
    if fm.ShowModal=mrok then begin
      MainQr.Locate(FFieldKeyName,fm.OldFieldKeyValue,[loCaseInsensitive]);
    end;
  finally
    fm.Free;
  end;
end;

procedure TfmRBAPPremises.bibDelClick(Sender: TObject);
begin
  if not Mainqr.IsEmpty then
    DeleteRecord(FDeleteQuery,FTableName,FFieldKeyName,Mainqr.FieldByName(FFieldKeyName).asString);
end;

procedure TfmRBAPPremises.SetTableName(Value: String);
begin
  FTableName:=Value;
  FFieldKeyName:=Value+'_ID';
end;

procedure TfmRBAPPremises.bibViewClick(Sender: TObject);
var
  fm: TfmEditRBAPPremises;
begin
  if not Mainqr.Active then exit;
  if Mainqr.IsEmpty then exit;
  fm:=GetEditClass.Create(nil);
  try
    fm.ParentForm:=Self;
    fm.InitView;
    fm.ChangeFlag:=false;
    if fm.ShowModal=mrok then begin
    end;
  finally
    fm.Free;
  end;
end;

procedure TfmRBAPPremises.bibFilterClick(Sender: TObject);
var
  fm: TfmEditRBAPPremises;
begin
  fm:=GetEditClass.Create(nil);
  try
    fm.ParentForm:=Self;
    fm.InitFilter;
    fm.ChangeFlag:=false;
    if fm.ShowModal=mrOk then begin
      Screen.Cursor:=crHourGlass;
      try
        inherited;
        fm.DoneFilter;
        SaveDbFilters(ClassName,Filters);
        ActiveQueryGrid(false);
      finally
        Screen.Cursor:=crDefault;
      end;
    end;
  finally
    fm.Free;
  end;
end;

function TfmRBAPPremises.GetEditClass: TfmEditRBAPPremisesClass;
begin
  Result:=TfmEditRBAPPremises;
end;

procedure TfmRBAPPremises.FormDestroy(Sender: TObject);
begin
  FTree.Parent:=nil;
  FTree.Free;
  FMemIniFile.Free;
  inherited;
  if FormState=[fsCreatedMDIChild] then
   fmRBAPPremises:=nil;
end;

procedure TfmRBAPPremises.TreeViewClick(Sender: TObject);
begin
  TreeViewChange(nil,nil);
end;                

procedure TfmRBAPPremises.TreeViewChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  if qrTree.Active and not qrTree.IsEmpty then begin
    if FOldOperationId<>qrTree.FieldByName('AP_OPERATION_ID').AsInteger then begin
      Screen.Cursor:=crHourGlass;
      try
        ActiveQueryGrid;
        FOldOperationId:=qrTree.FieldByName('AP_OPERATION_ID').AsInteger;
        FOldFieldViewId:=qrTree.FieldByName('AP_FIELD_VIEW_ID').AsInteger;
      finally
        Screen.Cursor:=crDefault;
      end;
    end;
  end;
end;

procedure TfmRBAPPremises.TreeViewOnGetImageIndex(Sender: TBaseVirtualTree;
    Node: PVirtualNode; Kind: TVTImageKind; Column: Integer;  var Ghosted: Boolean; var ImageIndex: Integer);
begin
  case Kind of
    ikNormal,ikSelected: begin
       if Node.ChildCount=0 then begin
         ImageIndex:=2;
       end else begin
         if Kind=ikNormal then
          ImageIndex:=0
         else ImageIndex:=1;
       end;
    end;
  end;
end;

function TfmRBAPPremises.GetFilterString: string;
var
  ap_operation_id, condition: string;
begin
  Result:=inherited GetFilterString;
  ap_operation_id:=qrTRee.FieldByName('AP_OPERATION_ID').AsString;
  condition:=VarToStr(qrTRee.FieldByName('CONDITION').Value);
  condition:=iff(Trim(condition)<>'',' OR '+condition,'');
  if Trim(Result)='' then begin
    Result:=Format(' WHERE (P.AP_OPERATION_ID=%S%S)',[ap_operation_id,condition]);
  end else begin
    Result:=Format(' %S AND (P.AP_OPERATION_ID=%S%S)',[Result,ap_operation_id,condition]);
  end; 
end;

procedure TfmRBAPPremises.SetPositionEdSearch; 
begin
  edSearch.Width:=pnTree.Width+Splitter.Width+pnGrid.Width-edSearch.Left-pnGrid.BorderWidth;
end;

procedure TfmRBAPPremises.SaveGridProp(ClsName: string; Grd: TDBGrid);
begin
end;

procedure TfmRBAPPremises.LoadGridProp(ClsName: string; Grd: TDBGrid); 
begin
end;

procedure TfmRBAPPremises.bibRefreshClick(Sender: TObject);
begin
  FSaveOperationId:=FOldOperationId;
  inherited;
end;

procedure TfmRBAPPremises.bibAdjustClick(Sender: TObject);
begin
  if SetAdjust(Grid.Columns,DefaultOrders) then begin
    SaveFieldDefs;
    SaveDbOrders(ClassName,DefaultOrders);
    LastOrderStr:=PrepearOrderString(DefaultOrders.GetOrderString);
    if bibRefresh.Enabled then
      bibRefresh.Click;
  end;
end;

function TfmRBAPPremises.GetDefaultOrdersName: string;
begin
  Result:=inherited GetDefaultOrdersName;
  if qrTree.Active and not qrTree.IsEmpty then
    Result:=Result+InttoStr(qrTree.FieldByName('AP_OPERATION_ID').AsInteger);
end;

procedure TfmRBAPPremises.SaveToIni;
begin
  inherited SaveToIni;
  WriteParam(ClassName,pnTree.Name,pnTree.Width);
end;

procedure TfmRBAPPremises.LoadFromIni;
begin
  inherited LoadFromIni;
  pnTree.Width:=ReadParam(ClassName,pnTree.Name,pnTree.Width);
end;

end.
