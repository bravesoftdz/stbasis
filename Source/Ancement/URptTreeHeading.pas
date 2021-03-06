unit URptTreeHeading;

interface
{$I stbasis.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  URptMain, OleCtnrs, StdCtrls, Buttons, ExtCtrls, Excel97, ComCtrls, IBQuery,
  IBDatabase, Db, IBCustomDataSet, ImgList, URBMainTreeView,
  DBClient, VirtualTrees, VirtualDBTree;

type
  TfmRptTreeHeading = class(TfmRptMain)
    pnResult: TPanel;
    grbTree: TGroupBox;
    pnTreeView: TPanel;
    sd: TSaveDialog;
    IL: TImageList;
    ds: TDataSource;
    cdsTree: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bibBreakClick(Sender: TObject);
    procedure bibGenClick(Sender: TObject);
  private
    procedure OnRptTerminate(Sender: TObject);
    procedure TreeViewOnGetImageIndex(Sender: TBaseVirtualTree;  Node: PVirtualNode; Kind: TVTImageKind; Column: Integer;
                                      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure TreeViewOnChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    function CheckFieldsFill: Boolean;
    function CreateTable: Boolean;
    Procedure UnCheckAllChildren(Node: PVirtualNode);
    procedure CheckAllParent(Node: PVirtualNode);
    Function FindNode(Start: PVirtualNode; ID: Integer): PVirtualNode;
  public
    TreeView: TVirtualDBTree;
    CursorColor: TColor;
    procedure LoadFromIni;override;
    procedure SaveToIni;override;
    procedure GenerateReport;override;
    procedure ThreadCreate;
    procedure ThreadDestroy;
    procedure ActiveQuery;
    function GetTreeViewPath(treeheading_id: Integer; b,a,d: string): string;
  end;

var
  fmRptTreeHeading: TfmRptTreeHeading;

implementation

uses UAncementCode,URptThread,comobj,UMainUnited,ActiveX, UAncementData,
     UAncementOptions, tsvRTFStream, tsvComponentFont;

type

  TRptThreadTreeHeading=class(TRptThread)
  private
    Book: TBookmark;
    procedure DisableControls;
    procedure EnableControls; 
  public
    FRtfStream: TTsvRTFMemoryStream;
    FSQLStream: TStringList;
    fmParent: TfmRptTreeHeading;
    procedure Execute;override;
    constructor Create; override;
    destructor Destroy;override;
  end;

var
  Rpt: TRptThreadTreeHeading;

{$R *.DFM}

procedure TfmRptTreeHeading.FormCreate(Sender: TObject);
begin
 inherited;
 try
  Caption:=NameRptTreeHeading;
  Mainqr.Database:=IBDB;
  IBTran.AddDatabase(IBDB);
  IBDB.AddTransaction(IBTran);

  TreeView:=TVirtualDBTree.Create(nil);
  TreeView.Parent:=pnTreeView;
  AssignFont(_GetOptions.RBTableFont,TreeView.Font);
  CursorColor:=_GetOptions.RBTableCursorColor;
  TreeView.Align:=alClient;
  TreeView.Images:=IL;
  TreeView.DataSource:=ds;
  TreeView.Margin:=2;
  TreeView.DefaultNodeHeight:=16;
  TreeView.CheckImageKind:=ckDarkTick;
  TreeView.OnGetImageIndex:=TreeViewOnGetImageIndex;
  TreeView.OnChecked:=TreeViewOnChecked;
  TreeView.DBOptions:=TreeView.DBOptions-[dboTrackCursor];
  TreeView.DBOptions:=TreeView.DBOptions+[dboAllowChecking,dboShowChecks,dboCheckChildren];

  TreeView.KeyFieldName:='treeheading_id';
  TreeView.ParentFieldName:='parent_id';
  TreeView.ViewFieldName:='nameheading';

  LoadFromIni;

  ActiveQuery;

 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRptTreeHeading.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Rpt);
  TreeView.Parent:=nil;
  TreeView.Free;
  if FormState=[fsCreatedMDIChild] then
   fmRptTreeHeading:=nil;
end;

procedure TfmRptTreeHeading.ActiveQuery;
var
 sqls: String;
begin
 try
  Screen.Cursor:=crHourGlass;
  try
    Mainqr.sql.Clear;
    sqls:=SQLRptTreeHeading;
    Mainqr.sql.Add(sqls);
    Mainqr.Transaction.Active:=false;
    Mainqr.Transaction.Active:=true;
    Mainqr.Active:=true;
  finally
   Screen.Cursor:=crDefault;
  end;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRptTreeHeading.TreeViewOnGetImageIndex(Sender: TBaseVirtualTree;
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

procedure TfmRptTreeHeading.TreeViewOnChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  if Node.CheckState=csUnCheckedNormal then begin
    UnCheckAllChildren(Node);
  end else begin
    CheckAllParent(Node);
  end;
end;

Procedure TfmRptTreeHeading.UnCheckAllChildren(Node: PVirtualNode);
Var
  Last: PVirtualNode;
Begin
  Last:=TreeView.GetFirstChild(Node);
  While Assigned(Last) Do Begin
    if Last.CheckState=csCheckedNormal then
      Last.CheckState:=csUncheckedNormal;
    if Last.ChildCount>0 then
      UnCheckAllChildren(Last);
    Last:=TreeView.GetNextSibling(Last);
  End;
End;

procedure TfmRptTreeHeading.CheckAllParent(Node: PVirtualNode);
Var
  Last: PVirtualNode;
Begin
  if Node=nil then exit;
  Last:=Node.Parent;
  if not Assigned(Last) then exit;
  Last.CheckState:=csCheckedNormal;
  CheckAllParent(Last);
End;

procedure TfmRptTreeHeading.LoadFromIni;
begin
 inherited;
 try
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRptTreeHeading.SaveToIni;
begin
 inherited;
 try
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmRptTreeHeading.OnRptTerminate(Sender: TObject);
begin
  FreeAndNil(Rpt);
  bibBreakClick(nil);
end;

procedure TfmRptTreeHeading.GenerateReport;
begin
  if Rpt<>nil then exit;
  Rpt:=TRptThreadTreeHeading.Create;
  Rpt.fmParent:=Self;
  Rpt.OnTerminate:=OnRptTerminate;
  Rpt.Resume;
end;

procedure TfmRptTreeHeading.bibBreakClick(Sender: TObject);
begin
  if Rpt<>nil then
    Rpt.Terminate;
  inherited;  
end;

function TfmRptTreeHeading.CheckFieldsFill: Boolean;
begin
  Result:=true;
end;

procedure TfmRptTreeHeading.bibGenClick(Sender: TObject);
begin
  if CheckFieldsFill then begin
   sd.FilterIndex:=fmOptions.rgExportTreeHeading.ItemIndex+1;
   case fmOptions.rgExportTreeHeading.ItemIndex of
     0: sd.FileName:=FileNameTreeHeadingXml;
     1: sd.FileName:=FileNameTreeHeadingRtf;
     2: sd.FileName:=FileNameTreeHeadingTxt;
   end;
   if not sd.Execute then exit; 
   if not CreateTable then exit;
   ThreadCreate;
   inherited;
  end;
end;

function TfmRptTreeHeading.CreateTable: Boolean;
begin
  cdsTree.Active:=false;
  cdsTree.FieldDefs.Assign(Mainqr.FieldDefs);
  cdsTree.CreateDataSet;
  cdsTree.Active:=true;
  Result:=cdsTree.Active;
end;

procedure TfmRptTreeHeading.ThreadCreate;
begin
  TreeView.Enabled:=false;
  TreeView.Color:=clBtnFace;
end;

procedure TfmRptTreeHeading.ThreadDestroy;
begin
  TreeView.Enabled:=true;
  TreeView.Color:=clWindow;
end;

Function TfmRptTreeHeading.FindNode(Start: PVirtualNode; ID: Integer): PVirtualNode;
Var
  Data: PDBVTData;
Begin
  If Assigned(Start) Then Result := Start
  Else Result := TreeView.GetFirst;
  While Assigned(Result) Do Begin
    Data := TreeView.GetNodeData(Result);
    If Data.ID = ID Then break;
    Result := TreeView.GetNext(Result);
  End;
End;

function TfmRptTreeHeading.GetTreeViewPath(treeheading_id: Integer; b,a,d: string): string;
var
  Node: PVirtualNode;
  isFirst: Boolean;
begin
  Result:='';
  Node:=FindNode(nil,treeheading_id);
  if Assigned(Node) then begin
    isFirst:=true;
    while Node<>TreeView.RootNode do begin
      if isFirst then begin
        Result:=TreeView.NodeText[Node];
        isFirst:=false;
      end else begin
        Result:=TreeView.NodeText[Node]+d+Result;
      end;
      Node:=Node.Parent;
    end;
    Result:=b+Result+a;
  end;
end;

{ TRptThreadTreeHeading }

constructor TRptThreadTreeHeading.Create;
begin
  inherited Create;
  Priority:=tpHighest;
  FRTFStream:=TTsvRTFMemoryStream.Create;
  FSQLStream:=TStringList.Create;
end;

destructor TRptThreadTreeHeading.Destroy;
begin
  fmParent.ThreadDestroy;
  if fmOptions.rgExportTreeHeading.ItemIndex=0 then fmParent.cdsTree.SaveToFile(fmParent.sd.FileName,dfXML);
  if fmOptions.rgExportTreeHeading.ItemIndex=1 then begin
    if not FRTFStream.closed then FRTFStream.CloseRtf;
    FRTFStream.SaveToFile(fmParent.sd.FileName);
  end;
  if fmOptions.rgExportTreeHeading.ItemIndex=2 then  begin
    FSQLStream.SaveToFile(fmParent.sd.FileName);
  end;
  FSQLStream.Free;
  FRTFStream.Free;
  inherited;
end;

procedure TRptThreadTreeHeading.DisableControls;
begin
  fmParent.Mainqr.DisableControls;
  Book:=fmParent.Mainqr.GetBookmark;
  fmParent.Update;
end;

procedure TRptThreadTreeHeading.EnableControls;
begin
  fmParent.Mainqr.GotoBookmark(Book);
  fmParent.Mainqr.EnableControls;
  fmParent.Update;
end;

procedure TRptThreadTreeHeading.Execute;
var
  PBHMain: THandle;
  TreeCount: Integer;
  TCPB: TCreateProgressBar;

  function GetCheckedTreeCount: Integer;
  var
    i: Integer;
    Node: PVirtualNode;
  begin
    Result:=0;
    i:=0;
    Node:=fmParent.TreeView.GetFirst;
    if Assigned(Node) then
     while i<>Integer(fmParent.TreeView.TotalCount) do begin
       if Node.CheckState=csCheckedNormal then
        Inc(Result);
       Node:=fmParent.TreeView.GetNext(Node);
       inc(i);
     end;
  end;

  procedure ExportTreeHeadingToXml;
  var
    i,j: Integer;
    TSPBS: TSetProgressBarStatus;
    Node: PVirtualNode;
    Data: PDBVTData;
  begin
    Synchronize(DisableControls);
    try
      i:=0;
      Node:=fmParent.TreeView.GetFirst;
      While Assigned(Node) Do Begin
        if Terminated then break;
        if Node.CheckState=csCheckedNormal then begin
          Data:=fmParent.TreeView.GetNodeData(Node);
          inc(i);
          if Assigned(Data) then begin
            fmParent.Mainqr.First;
            if fmParent.Mainqr.Locate('treeheading_id',Data.ID,[loCaseInsensitive]) then begin
              fmParent.cdsTree.Append;
              for j:=0 to fmParent.Mainqr.FieldCount-1 do begin
                fmParent.cdsTree.Fields[j].Value:=fmParent.Mainqr.Fields[j].Value;
              end;
              fmParent.cdsTree.Post;
            end;
          end;
          TSPBS.Progress:=i;
          TSPBS.Hint:='';
          _SetProgressBarStatus(PBHMain,@TSPBS);
        end;
        Node := fmParent.TreeView.GetNext(Node);
      End;
    finally
      Synchronize(EnableControls);
    end;
  end;

  procedure ExportTreeHeadingToSQL;
  var
    i: Integer;
    TSPBS: TSetProgressBarStatus;
    Node: PVirtualNode;
    Data: PDBVTData;
    s,s1,s2,s3,s4: string;
  begin
    Synchronize(DisableControls);
    try
      i:=0;
      Node:=fmParent.TreeView.GetFirst;
      While Assigned(Node) Do Begin
        if Terminated then break;
        if Node.CheckState=csCheckedNormal then begin
          Data:=fmParent.TreeView.GetNodeData(Node);
          inc(i);
          if Assigned(Data) then begin
            fmParent.Mainqr.First;
            if fmParent.Mainqr.Locate('treeheading_id',Data.ID,[loCaseInsensitive]) then begin
              s1:=fmParent.Mainqr.FieldByName('treeheading_id').AsString;
              s2:=QuotedStr(fmParent.Mainqr.FieldByName('nameheading').AsString);
              s3:=fmParent.Mainqr.FieldByName('sortnumber').AsString;
              s4:=iff(fmParent.Mainqr.FieldByName('parent_id').AsString='','null',fmParent.Mainqr.FieldByName('parent_id').AsString);
              s:=Format(fmtTreeHeadingInsertSql,[s1,s2,s3,s4]);
              FSQLStream.Add(s);
            end;
          end;
          TSPBS.Progress:=i;
          TSPBS.Hint:='';
          _SetProgressBarStatus(PBHMain,@TSPBS);
        end;
        Node := fmParent.TreeView.GetNext(Node);
      End;
    finally
      Synchronize(EnableControls);
    end;
  end;

  procedure ExportTreeHeadingToRtf;
  var
    i: Integer;
    TSPBS: TSetProgressBarStatus;
    Node: PVirtualNode;
    Data: PDBVTData;
    fnt: TFont;
    cf: TComponentFont;
  begin
    fnt:=TFont.Create;
    cf:=TComponentFont.Create(nil);
    FRtfStream.OpenRtf;
    FRtfStream.CreateHeader;
    FRtfStream.OpenBody;
    Synchronize(DisableControls);
    try
      i:=0;
      Node:=fmParent.TreeView.GetFirst;
      While Node<>nil Do Begin
        if Terminated then break;
        if Node.CheckState=csCheckedNormal then begin
          Data:=fmParent.TreeView.GetNodeData(Node);
          inc(i);
          if Assigned(Data) then begin
            fmParent.Mainqr.First;
            if fmParent.Mainqr.Locate('treeheading_id',Data.ID,[loCaseInsensitive]) then begin
              cf.SetFontFromHexStr(fmParent.Mainqr.FieldByName('font').AsString);
              fnt.Assign(cf.Font);
              FRtfStream.CreateString(fmParent.GetTreeViewPath(Data.ID,fmOptions.edBeforeTree.Text,
                                                               fmOptions.edAfterTree.Text,fmOptions.edPointerTree.Text),fnt,true);
            end;
          end;
          TSPBS.Progress:=i;
          TSPBS.Hint:='';
          _SetProgressBarStatus(PBHMain,@TSPBS);
        end;
        Node := fmParent.TreeView.GetNext(Node);
      End;
    finally
      Synchronize(EnableControls);
      FRtfStream.CloseBody;
      FRtfStream.CloseRtf;
      cf.Free;
      fnt.Free;
    end;
  end;

begin
 try
   PBHMain:=0;
   TreeCount:=GetCheckedTreeCount;
   if TreeCount=0 then exit;
   try
    TCPB.Min:=0;
    TCPB.Max:=TreeCount;
    TCPB.Hint:='Экспорт рубрикатора';
    TCPB.Color:=clNavy;
    PBHMain:=_CreateProgressBar(@TCPB);

    case fmOptions.rgExportTreeHeading.ItemIndex of
      0: ExportTreeHeadingToXml;
      1: ExportTreeHeadingToRtf;
      2: ExportTreeHeadingToSql;
    end;

   finally
    _FreeProgressBar(PBHMain);
    DoTerminate;
   end;
 except
  {$IFDEF DEBUG}
    on E: Exception do begin
     try
       Assert(false,E.message);
     except
       Application.HandleException(nil);
     end;
    end;
  {$ENDIF}
 end;
end;

end.
