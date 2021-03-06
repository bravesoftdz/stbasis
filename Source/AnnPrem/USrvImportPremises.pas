unit USrvImportPremises;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Buttons, Menus,
  contnrs,
  USrvMain, ExtCtrls, StdCtrls, DB, Grids, DBGrids, tsvDbGrid, DBClient, tsvMemIniFile, IBQuery,
  IBDatabase,
  tsvStdCtrls, tsvInterbase, StbasisSClientDataSet, UAPPremisesDefs,
  ComCtrls, tsvComCtrls;

type
  TPreviewImportType=(piUnknown,piExcel,piText);

  TfmSrvImportPremises = class(TfmSrvMain)
    pnTop: TPanel;
    splTopBottom: TSplitter;
    pnBottom: TPanel;
    pnOption: TPanel;
    grbOption: TGroupBox;
    lbAgency: TLabel;
    edAgency: TEdit;
    btAgency: TButton;
    pnFieldView: TPanel;
    grbFieldView: TGroupBox;
    pnFieldViewBottom: TPanel;
    pnFieldViewTop: TPanel;
    pnGridColumns: TPanel;
    lbFieldView: TLabel;
    edFieldView: TEdit;
    btFieldView: TButton;
    btUpColumns: TBitBtn;
    btDownColumns: TBitBtn;
    lbRelease: TLabel;
    edRelease: TEdit;
    btRelease: TButton;
    pnPreview: TPanel;
    pnBut: TPanel;
    grbPreview: TGroupBox;
    pnGridPreview: TPanel;
    btLoad: TButton;
    lbCount: TLabel;
    btImport: TButton;
    btBreak: TButton;
    btClose: TButton;
    pmPreview: TPopupMenu;
    lbOperation: TLabel;
    edOperation: TEdit;
    btOperation: TButton;
    miPreviewSave: TMenuItem;
    N1: TMenuItem;
    miPreviewClear: TMenuItem;
    miPreviewLoad: TMenuItem;
    miPreviewAdd: TMenuItem;
    N3: TMenuItem;
    miPreviewDelete: TMenuItem;
    miPreviewRefresh: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    miPreviewChange: TMenuItem;
    N2: TMenuItem;
    dtpDateDelivery: TDateTimePicker;
    lbDateDelivery: TLabel;
    lbTown: TLabel;
    edTown: TEdit;
    btTown: TButton;
    miTranslate: TMenuItem;
    N6: TMenuItem;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btAgencyClick(Sender: TObject);
    procedure btFieldViewClick(Sender: TObject);
    procedure btUpColumnsClick(Sender: TObject);
    procedure btDownColumnsClick(Sender: TObject);
    procedure btReleaseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btCloseClick(Sender: TObject);
    procedure btOperationClick(Sender: TObject);
    procedure btLoadClick(Sender: TObject);
    procedure btBreakClick(Sender: TObject);
    procedure btImportClick(Sender: TObject);
    procedure miPreviewClearClick(Sender: TObject);
    procedure miPreviewSaveClick(Sender: TObject);
    procedure miPreviewLoadClick(Sender: TObject);
    procedure pmPreviewPopup(Sender: TObject);
    procedure miPreviewAddClick(Sender: TObject);
    procedure miPreviewDeleteClick(Sender: TObject);
    procedure miPreviewRefreshClick(Sender: TObject);
    procedure btTownClick(Sender: TObject);
    procedure miPreviewChangeClick(Sender: TObject);
    procedure miTranslateClick(Sender: TObject);
  private
    FDataColumns: TClientDataSet;
    FGridColumns: TNewdbGrid;
    FDSColumns: TDataSource;

    FDataPreview: TStbasisSClientDataSet;
    FGridPreview: TNewdbGrid;
    FDSPreview: TDataSource;

    FColumnVisible: TColumn;
    FColumnName: TColumn;
    FColumnValue: TColumn;
    FColumnWidth: TColumn;
    FMemIniFile: TtsvMemIniFile;
    FFieldColumnName: TStringField;
    FSaved: Boolean;
    FBreaked: Boolean;
    FLastFileName: String;
    FListLogItems: TObjectList;
    FOldFieldViewId: Integer;

    procedure FillFields;
    procedure FillColumns;
    procedure LoadFieldDefs;
    procedure SaveFieldDefs;
    procedure ChangeFieldView(Save: Boolean);
    procedure GridColumnsDrawColumnCell(Sender: TObject; const Rect: TRect;
                                        DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridColumnsDblClick(Sender: TObject);
    procedure GridColumnsEditButtonClick(Sender: TObject);
    function GetValueIdByDef(AValue: Variant; ADef: TAPPremisesDef; var AName: String): Variant;
    procedure DataColumnsBeforeEdit(DataSet: TDataSet);
    procedure DataColumnsAfterEdit(DataSet: TDataSet);
    procedure DataColumnsAfterScroll(DataSet: TDataSet);
    procedure DataColumnsAfterPost(DataSet: TDataSet);
    procedure DataColumnsAfterDelete(DataSet: TDataSet);
    procedure DataColumnsNewRecord(DataSet: TDataSet);
    procedure CheckMoveButtons;
    procedure MoveColumn(Up: Boolean);
    procedure FieldColumnNameSetText(Sender: TField; const Text: string);
    procedure GridColumnsCellClick(Column: TColumn);
    procedure GridColumnsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridPreviewCellClick(Column: TColumn);
    procedure GridPreviewEditButtonClick(Sender: TObject);
    procedure SetRelease;
    procedure SetAgency;
    procedure SetFieldView;
    procedure SetOperation;
    procedure SetTown;
    procedure RefillGridPreview;
    function GetPreviewImportType(Extension: String): TPreviewImportType;
    procedure LoadToPreviewFromExcel(FileName: String; UseOriginal: Boolean);
    procedure ImportToDataBaseFromPreview;
    function GridPreviewGetFontColor(Sender: TObject; Column: TColumn): TColor;
    procedure GridPreviewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function CheckPreviewAdd: Boolean;
    procedure UpdateLabelCount;
    procedure ClearListLogItems;
    procedure TranslateData(FileName: String);
//    procedure FillMenuPreviewChange;
//    procedure MenuPreviewChangeClick(Sender: TObject);
  public
    procedure LoadFromIni; override;
    procedure SaveToIni; override;

  end;

var
  fmSrvImportPremises: TfmSrvImportPremises;

implementation

{$R *.DFM}

uses ActiveX, ComObj,
     UAnnPremData, UMainUnited, UAnnPremOptions;

type
  TLogItemObject=class(TObject)
  private
    FHandle: THandle;
    FPremisesId: Integer;
  public
    property Handle: THandle read FHandle write FHandle;
    property PremisesId: Integer read FPremisesId write FPremisesId;
  end;     

procedure TfmSrvImportPremises.FormCreate(Sender: TObject);
var
  Column: TColumn;
begin
  inherited;
  Caption:=NameSrvImportPremises;

  FListLogItems:=TObjectList.Create;

  FMemIniFile:=TtsvMemIniFile.Create;

  FDataColumns:=TClientDataSet.Create(nil);
  with FDataColumns do begin
    BeforeEdit:=DataColumnsBeforeEdit;
    AfterEdit:=DataColumnsAfterEdit;
    AfterScroll:=DataColumnsAfterScroll;
    AfterPost:=DataColumnsAfterPost;
    AfterDelete:=DataColumnsAfterDelete;
    OnNewRecord:=DataColumnsNewRecord;
    FieldDefs.Add('VISIBLE',ftInteger);
    FieldDefs.Add('NAME',ftString,250);
    FieldDefs.Add('VALUE_NAME',ftString,250);
    FieldDefs.Add('VALUE_ID',ftInteger);
    FieldDefs.Add('VALUE_WIDTH',ftInteger);
    CreateDataSet;
    FFieldColumnName:=TStringField(Fields[1]);
    FFieldColumnName.OnSetText:=FieldColumnNameSetText;
  end;

  FDSColumns:=TDataSource.Create(nil);
  with FDSColumns do begin
    DataSet:=FDataColumns;
    Enabled:=true;
  end;
  
  FGridColumns:=TNewdbGrid.Create(nil);
  with FGridColumns do begin
    Parent:=pnGridColumns;
    Align:=alClient;
    DataSource:=FDSColumns;
    RowSelected.Visible:=true;
    VisibleRowNumber:=_GetOptions.VisibleRowNumber;
    AssignFont(_GetOptions.RBTableFont,Font);
    TitleFont.Assign(Font);
    RowSelected.Font.Assign(Font);
    RowSelected.Brush.Style:=bsClear;
    RowSelected.Brush.Color:=_GetOptions.RBTableRecordColor;
    RowSelected.Font.Color:=clWhite;
    RowSelected.Pen.Style:=psClear;
    CellSelected.Visible:=true;
    CellSelected.Brush.Color:=_GetOptions.RBTableCursorColor;
    CellSelected.Font.Assign(Font);
    CellSelected.Font.Color:=clHighlightText;
    TitleCellMouseDown.Font.Assign(Font);
    Options:=Options+[dgEditing]-[dgTabs];
    RowSizing:=false;
    VisibleRowNumber:=true;
    ReadOnly:=not FDataColumns.CanModify;
    ColumnSortEnabled:=false;
    OnEditButtonClick:=GridColumnsEditButtonClick;
    OnDblClick:=GridColumnsDblClick;
    OnDrawColumnCell:=GridColumnsDrawColumnCell;
    OnCellClick:=GridColumnsCellClick;
    OnKeyDown:=GridColumnsKeyDown;

    Column:=Columns.Add;
    Column.FieldName:='VISIBLE_PLUS';
    Column.Title.Caption:='���';
    Column.Width:=25;
    Column.ReadOnly:=true;
    FColumnVisible:=Column;

    Column:=Columns.Add;
    Column.FieldName:='NAME';
    Column.Title.Caption:='�������';
    Column.Width:=120;
    Column.ReadOnly:=false;
    Column.ButtonStyle:=cbsAuto;
    FColumnName:=Column;

    Column:=Columns.Add;
    Column.FieldName:='VALUE_WIDTH';
    Column.Title.Caption:='������';
    Column.Width:=40;
    Column.ReadOnly:=false;
    FColumnWidth:=Column;

    Column:=Columns.Add;
    Column.FieldName:='VALUE_NAME';
    Column.Title.Caption:='�������� �� ���������';
    Column.Width:=150;
    FColumnValue:=Column;

  end;

  FDataPreview:=TStbasisSClientDataSet.Create(nil);
  with FDataPreview do begin
  end;

  FDSPreview:=TDataSource.Create(nil);
  with FDSPreview do begin
    DataSet:=FDataPreview;
    Enabled:=true;
  end;

  FGridPreview:=TNewdbGrid.Create(nil);
  with FGridPreview do begin
    Parent:=pnGridPreview;
    Align:=alClient;
    DataSource:=FDSPreview;
    RowSelected.Visible:=true;
    VisibleRowNumber:=_GetOptions.VisibleRowNumber;
    AssignFont(_GetOptions.RBTableFont,Font);
    TitleFont.Assign(Font);
    RowSelected.Font.Assign(Font);
    RowSelected.Brush.Style:=bsClear;
    RowSelected.Brush.Color:=_GetOptions.RBTableRecordColor;
    RowSelected.Font.Color:=clWhite;
    RowSelected.Pen.Style:=psClear;
    CellSelected.Visible:=true;
    CellSelected.Brush.Color:=_GetOptions.RBTableCursorColor;
    CellSelected.Font.Assign(Font);
    CellSelected.Font.Color:=clHighlightText;
    TitleCellMouseDown.Font.Assign(Font);
    Options:=Options+[dgEditing]-[dgTabs];
    RowSizing:=false;
    ReadOnly:=false;
    ColumnSortEnabled:=false;
    PopupMenu:=pmPreview;
    Visible:=false;
    VisibleRowNumber:=true;
    OnCellClick:=GridPreviewCellClick;
    OnEditButtonClick:=GridPreviewEditButtonClick;
    OnGetFontColor:=GridPreviewGetFontColor;
    OnKeyDown:=GridPreviewKeyDown;
    if fmOptions.chbImportSelectInvalidChar.Checked then begin
      WordColor:=clRed;
      Words.Text:=fmOptions.meImportValidChars.Lines.Text;
    end;
  end;

  btImport.Enabled:=false;
  btBreak.Enabled:=false;


  FillColumns;
  LoadFromIni;

  dtpDateDelivery.Date:=_GetWorkDate;

  FSaved:=true;
end;

procedure TfmSrvImportPremises.FormDestroy(Sender: TObject);
begin
  inherited;
  FGridPreview.DataSource:=nil;
  FGridPreview.Free;
  FDSPreview.Free;
  FDataPreview.Free;
  FGridColumns.DataSource:=nil;
  FGridColumns.Free;
  FDSColumns.Free;
  FDataColumns.Free;
  FMemIniFile.Free;
  ClearListLogItems;
  FListLogItems.Free;
  if FormState=[fsCreatedMDIChild] then
    fmSrvImportPremises:=nil;
end;

procedure TfmSrvImportPremises.btAgencyClick(Sender: TObject);
var
  TPRBI: TParamRBookInterface;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tvibvModal;
  TPRBI.Locate.KeyFields:='AP_AGENCY_ID';
  TPRBI.Locate.KeyValues:=edAgency.Tag;
  TPRBI.Locate.Options:=[loCaseInsensitive];
  if _ViewInterfaceFromName(NameRbkAPAgency,@TPRBI) then begin
    edAgency.Tag:=GetFirstValueFromParamRBookInterface(@TPRBI,'AP_AGENCY_ID');
    edAgency.Text:=GetFirstValueFromParamRBookInterface(@TPRBI,'NAME');
  end;
end;

procedure TfmSrvImportPremises.btFieldViewClick(Sender: TObject);
var
  TPRBI: TParamRBookInterface;
  FlagSave: Boolean;
begin
  FlagSave:=true;
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tvibvModal;
  TPRBI.Condition.WhereStrNoRemoved:=PChar(' VISIBLE=1 ');
  TPRBI.Locate.KeyFields:='AP_FIELD_VIEW_ID';
  TPRBI.Locate.KeyValues:=edFieldView.Tag;
  TPRBI.Locate.Options:=[loCaseInsensitive];
  if _ViewInterfaceFromName(NameRbkAPFieldView,@TPRBI) then begin
    FOldFieldViewId:=edFieldView.Tag;
    edFieldView.Tag:=GetFirstValueFromParamRBookInterface(@TPRBI,'AP_FIELD_VIEW_ID');
    edFieldView.Text:=GetFirstValueFromParamRBookInterface(@TPRBI,'NAME');
    ChangeFieldView(FlagSave);
  end;
end;

procedure TfmSrvImportPremises.ChangeFieldView(Save: Boolean);
begin
  if Trim(edFieldView.Text)<>'' then begin
    Screen.Cursor:=crHourGlass;
    try
      if Save then
        SaveFieldDefs;
      LoadFieldDefs;
      APPremisesDefs.FillDefValues;
      FillFields;
      FillDataSetByQuery(IBDB,FDataPreview,Format('%s WHERE AP_PREMISES_ID IS NULL',[SQLRbkAPPremises]));
      RefillGridPreview;
    finally
      Screen.Cursor:=crDefault;
    end;
  end else
    FDataColumns.EmptyDataSet;
end;

procedure TfmSrvImportPremises.LoadFieldDefs;
var
  Stream: TStringStream;
  S: String;
begin
  if Trim(edFieldView.Text)<>'' then begin
    S:=GetFirstValueBySQL(IBDB,
                          Format('SELECT FIELDS FROM AP_FIELD_VIEW WHERE AP_FIELD_VIEW_ID=%d',
                                 [edFieldView.Tag]),
                          'FIELDS');
    Stream:=TStringStream.Create(S);
    try
      FMemIniFile.Clear;
      FMemIniFile.LoadFromStream(Stream);
    finally
      Stream.Free;
    end;
  end;
end;

function TfmSrvImportPremises.GetValueIdByDef(AValue: Variant; ADef: TAPPremisesDef; var AName: String): Variant;
var
  AValueS: String;
begin
  AValueS:=VarToStr(AValue);
  Result:=ADef.GetValueId(AValueS,AName);
  if Result=0 then
    Result:=Null;                                         
end;

procedure TfmSrvImportPremises.FillColumns;
begin
  APPremisesDefs.FillColumns(FColumnName.PickList);
end;

procedure TfmSrvImportPremises.FillFields;
var
  Section: TStringList;
  AName,AValue: string;
  AValueId: Variant;
  i: Integer;
  ADef: TAPPremisesDef;
  ANewName: String;
begin
  FDataColumns.DisableControls;
  Section:=TStringList.Create;
  FDataColumns.AfterPost:=nil;
  FDataColumns.OnNewRecord:=nil;
  try
    FDataColumns.EmptyDataSet;
    FMemIniFile.ReadSection(SColumns,Section);
    for i:=0 to Section.Count-1 do begin
      AName:=Section.Strings[i];
      ADef:=APPremisesDefs.FindDefByColumn(AName);
      if Assigned(ADef) then begin
        FDataColumns.Append;
        try
          FDataColumns.FieldByName('VISIBLE').AsInteger:=Integer(FMemIniFile.ReadBool(SColumns,AName,false));
          FDataColumns.FieldByName('NAME').AsString:=AName;
          AValue:=FMemIniFile.ReadString(AName,SValue,'');
          if Trim(ADef.TableName)='' then begin
            FDataColumns.FieldByName('VALUE_NAME').Value:=AValue;
          end else begin
            AValueId:=GetValueIdByDef(AValue,ADef,ANewName);
            if not VarIsNull(AValueId) then begin
              FDataColumns.FieldByName('VALUE_ID').Value:=AValueId;
              FDataColumns.FieldByName('VALUE_NAME').Value:=AValue;
            end;
          end;
          FDataColumns.FieldByName('VALUE_WIDTH').AsInteger:=FMemIniFile.ReadInteger(AName,SWidth,40);
        finally
          FDataColumns.Post;
        end;
      end;  
    end;
    FDataColumns.First;
  finally
    FDataColumns.AfterPost:=DataColumnsAfterPost;
    FDataColumns.OnNewRecord:=DataColumnsNewRecord;
    Section.Free;
    FDataColumns.EnableControls;
  end;
end;

procedure TfmSrvImportPremises.GridColumnsDrawColumnCell(Sender: TObject; const Rect: TRect;
                                                         DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  rt: TRect;
  chk: Boolean;
begin
  if not FDataColumns.Active or
        FDataColumns.isEmpty
        then exit;
  rt.Right:=rect.Right;
  rt.Left:=rect.Left;
  rt.Top:=rect.Top+2;
  rt.Bottom:=rect.Bottom-2;
  if Column=FColumnVisible then begin
    chk:=Boolean(FDataColumns.FieldByName('VISIBLE').AsInteger);
    if not chk then Begin
      DrawFrameControl(FGridColumns.Canvas.Handle,Rt,DFC_BUTTON,DFCS_BUTTONCHECK);
    end else begin
      DrawFrameControl(FGridColumns.Canvas.Handle,Rt,DFC_BUTTON,DFCS_CHECKED);
    end;
  end;
end;

procedure TfmSrvImportPremises.GridColumnsDblClick(Sender: TObject);
var
  AVisible: Boolean;
begin
  if FDataColumns.Active and not FDataColumns.IsEmpty then begin
    if FGridColumns.Columns.Items[FGridColumns.SelectedIndex]=FColumnVisible then begin
      FDataColumns.AfterPost:=nil;
      FDataColumns.DisableControls;
      try
        FDataColumns.Edit;
        try
          AVisible:=Boolean(FDataColumns.FieldByName('VISIBLE').AsInteger);
          FDataColumns.FieldByName('VISIBLE').AsInteger:=Integer(not AVisible);
        finally
          FDataColumns.Post;
          DataColumnsAfterPost(nil);
        end;
      finally
        FDataColumns.EnableControls;
        FDataColumns.AfterPost:=DataColumnsAfterPost;
      end;
    end;  
  end;
end;

procedure TfmSrvImportPremises.DataColumnsAfterEdit(DataSet: TDataSet);
begin
end;

procedure TfmSrvImportPremises.DataColumnsBeforeEdit(DataSet: TDataSet);
begin
end;

procedure TfmSrvImportPremises.DataColumnsAfterScroll(DataSet: TDataSet);
var
  AColumn: String;
  ADef: TAPPremisesDef;
begin
  if FDataColumns.Active and not FDataColumns.IsEmpty then begin
    AColumn:=FDataColumns.FieldByName('NAME').AsString;
    ADef:=APPremisesDefs.FindDefByColumn(AColumn);
    if Assigned(ADef) then begin
      FColumnValue.ButtonStyle:=iff(Trim(ADef.TableName)<>'',cbsEllipsis,cbsNone);
      FColumnValue.ReadOnly:=FColumnValue.ButtonStyle=cbsEllipsis;
    end;
  end;
  CheckMoveButtons;
end;

procedure TfmSrvImportPremises.GridColumnsEditButtonClick(Sender: TObject);
var
  AColumn: String;
  ADef: TAPPremisesDef;
  TPRBI: TParamRBookInterface;
begin
  if FDataColumns.Active and not FDataColumns.IsEmpty then begin
    AColumn:=FDataColumns.FieldByName('NAME').AsString;
    ADef:=APPremisesDefs.FindDefByColumn(AColumn);
    if Assigned(ADef) then begin
      FillChar(TPRBI,SizeOf(TPRBI),0);
      TPRBI.Visual.TypeView:=tvibvModal;
      TPRBI.Locate.KeyFields:=PChar(ADef.FieldName);
      TPRBI.Locate.KeyValues:=FDataColumns.FieldByName('VALUE_ID').Value;
      TPRBI.Locate.Options:=[loCaseInsensitive];
      if _ViewInterfaceFromName(PChar(ADef.InterfaceName),@TPRBI) then begin
        FDataColumns.AfterPost:=nil;
        FDataColumns.Edit;
        try
          FDataColumns.FieldByName('VALUE_NAME').Value:=GetFirstValueFromParamRBookInterface(@TPRBI,ADef.FieldName2);
          FDataColumns.FieldByName('VALUE_ID').Value:=GetFirstValueFromParamRBookInterface(@TPRBI,ADef.FieldName);
        finally
          FDataColumns.Post;
          FDataColumns.AfterPost:=DataColumnsAfterPost;
        end;
      end;
    end;
  end;
end;

procedure TfmSrvImportPremises.CheckMoveButtons;
begin
  if FDataColumns.Active and not FDataColumns.IsEmpty then begin
    btUpColumns.Enabled:=not FDataColumns.Bof;
    btDownColumns.Enabled:=not FDataColumns.Eof;
  end else begin
    btUpColumns.Enabled:=false;
    btDownColumns.Enabled:=false;
  end;
end;

procedure TfmSrvImportPremises.btUpColumnsClick(Sender: TObject);
begin
  MoveColumn(true);
end;

procedure TfmSrvImportPremises.btDownColumnsClick(Sender: TObject);
begin
  MoveColumn(false);
end;

procedure TfmSrvImportPremises.MoveColumn(Up: Boolean);
var
  AName: String;
  AVisible: Boolean;
  AValueName: String;
  AValueId: Variant;
  AWidth: Integer;
  isLast: Boolean;
begin
  isLast:=FDataColumns.RecNo=FDataColumns.RecordCount;
  FDataColumns.AfterPost:=nil;
  FDataColumns.OnNewRecord:=nil;
  FDataColumns.AfterDelete:=nil;
  FDataColumns.DisableControls;
  try
    with FDataColumns do begin
      AName:=FieldByName('NAME').AsString;
      AVisible:=Boolean(FieldByName('VISIBLE').AsInteger);
      AValueName:=FieldByName('VALUE_NAME').AsString;
      AValueId:=FieldByName('VALUE_ID').Value;
      AWidth:=FieldByName('VALUE_WIDTH').AsInteger;
    end;
    with FDataColumns do begin
      Delete;
      if Up then begin
        if not isLast then
          Prior;
        Insert;
      end else begin
        Next;
        if not Eof then
          Insert
        else Append;
      end;
      try
        FieldByName('NAME').AsString:=AName;
        FieldByName('VISIBLE').AsInteger:=Integer(AVisible);
        FieldByName('VALUE_NAME').AsString:=AValueName;
        FieldByName('VALUE_ID').Value:=AValueId;
        FieldByName('VALUE_WIDTH').AsInteger:=AWidth;
      finally
        Post;
        DataColumnsAfterPost(nil);
      end;
    end;
  finally
    FDataColumns.EnableControls;
    FDataColumns.AfterPost:=DataColumnsAfterPost;
    FDataColumns.OnNewRecord:=DataColumnsNewRecord;
    FDataColumns.AfterDelete:=DataColumnsAfterDelete;
  end;
end;

procedure TfmSrvImportPremises.FieldColumnNameSetText(Sender: TField; const Text: string);
var
  Def: TAPPremisesDef;
begin
  Def:=APPremisesDefs.FindDefByColumn(Text);
  if not Assigned(Def) then begin
    ShowErrorEx(SInvalidValue);
    raise Exception.Create(SInvalidValue);
  end else begin
    Sender.AsString:=Text;
  end;  
end;

procedure TfmSrvImportPremises.GridColumnsCellClick(Column: TColumn);
begin
  if Column=FColumnVisible then begin
    FGridColumns.Options:=FGridColumns.Options-[dgEditing]-[dgTabs];
  end else begin
    FGridColumns.Options:=FGridColumns.Options+[dgEditing]-[dgTabs];
  end;
end;

procedure TfmSrvImportPremises.GridColumnsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_SPACE then
    GridColumnsDblClick(nil);
end;

procedure TfmSrvImportPremises.btReleaseClick(Sender: TObject);
var
  TPRBI: TParamRBookInterface;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tvibvModal;
  TPRBI.Locate.KeyFields:='RELEASE_ID';
  TPRBI.Locate.KeyValues:=edRelease.Tag;
  TPRBI.Locate.Options:=[loCaseInsensitive];
  if _ViewInterfaceFromName(NameRbkRelease,@TPRBI) then begin
    edRelease.Tag:=GetFirstValueFromParamRBookInterface(@TPRBI,'RELEASE_ID');
    edRelease.Text:=GetFirstValueFromParamRBookInterface(@TPRBI,'ABOUT');
  end;
end;

procedure TfmSrvImportPremises.SaveFieldDefs;
var
  Stream: TStringStream;
  AName,AValue: String;
  ADef: TAPPremisesDef;
begin
  if FDataColumns.Active  then begin
      FMemIniFile.Clear;
      with FDataColumns do begin
        DisableControls;
        try
          First;
          while not Eof do begin
            AName:=FieldByName('NAME').AsString;
            FMemIniFile.WriteBool(SColumns,AName,Boolean(FieldByName('VISIBLE').AsInteger));
            ADef:=APPremisesDefs.FindDefByColumn(AName);
            if Assigned(ADef) then
              FMemIniFile.WriteString(AName,SField,ADef.FieldName);
            AValue:=FieldByName('VALUE_NAME').AsString;
            if Trim(AValue)<>'' then
              FMemIniFile.WriteString(AName,SValue,AValue);
            FMemIniFile.WriteInteger(AName,SWidth,FieldByName('VALUE_WIDTH').AsInteger);
            Next;
          end;
        finally
          EnableControls;
        end;
      end;  

      Stream:=TStringStream.Create('');
      try
        FMemIniFile.SaveToStream(Stream);
        ExecSql(IBDB,
                Format('UPDATE AP_FIELD_VIEW SET FIELDS=%s WHERE AP_FIELD_VIEW_ID=%s',
                       [QuotedStr(Stream.DataString),IntToStr(FOldFieldViewId)]));
      finally
        Stream.Free;
      end;
  end;
end;

procedure TfmSrvImportPremises.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  FOldFieldViewId:=edFieldView.Tag;
  SaveFieldDefs;
end;

procedure TfmSrvImportPremises.SetRelease;
var
  TPRBI: TParamRBookInterface;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.WhereStr:=PChar(' RELEASE_ID='+IntToStr(edRelease.Tag)+' ');
  if _ViewInterfaceFromName(NameRbkRelease,@TPRBI) then begin
    edRelease.Tag:=GetFirstValueFromParamRBookInterface(@TPRBI,'RELEASE_ID');
    edRelease.Text:=GetFirstValueFromParamRBookInterface(@TPRBI,'ABOUT');
  end;
end;

procedure TfmSrvImportPremises.SetAgency;
var
  TPRBI: TParamRBookInterface;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.WhereStr:=PChar(' AP_AGENCY_ID='+IntToStr(edAgency.Tag)+' ');
  if _ViewInterfaceFromName(NameRbkAPAgency,@TPRBI) then begin
    edAgency.Tag:=GetFirstValueFromParamRBookInterface(@TPRBI,'AP_AGENCY_ID');
    edAgency.Text:=GetFirstValueFromParamRBookInterface(@TPRBI,'NAME');
  end;
end;

procedure TfmSrvImportPremises.SetFieldView;
var
  TPRBI: TParamRBookInterface;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.WhereStr:=PChar(' AP_FIELD_VIEW_ID='+IntToStr(edFieldView.Tag)+' ');
  if _ViewInterfaceFromName(NameRbkAPFieldView,@TPRBI) then begin
    FOldFieldViewId:=edFieldView.Tag;
    edFieldView.Tag:=GetFirstValueFromParamRBookInterface(@TPRBI,'AP_FIELD_VIEW_ID');
    edFieldView.Text:=GetFirstValueFromParamRBookInterface(@TPRBI,'NAME');
  end;
end;

procedure TfmSrvImportPremises.SetOperation;
var
  TPRBI: TParamRBookInterface;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.WhereStr:=PChar(' O.AP_OPERATION_ID='+IntToStr(edOperation.Tag)+' ');
  if _ViewInterfaceFromName(NameRbkAPOperation,@TPRBI) then begin
    edOperation.Tag:=GetFirstValueFromParamRBookInterface(@TPRBI,'AP_OPERATION_ID');
    edOperation.Text:=GetFirstValueFromParamRBookInterface(@TPRBI,'NAME');
  end;
end;

procedure TfmSrvImportPremises.SetTown;
var
  TPRBI: TParamRBookInterface;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.WhereStr:=PChar(' AP_TOWN_ID='+IntToStr(edTown.Tag)+' ');
  if _ViewInterfaceFromName(NameRbkAPTown,@TPRBI) then begin
    edTown.Tag:=GetFirstValueFromParamRBookInterface(@TPRBI,'AP_TOWN_ID');
    edTown.Text:=GetFirstValueFromParamRBookInterface(@TPRBI,'NAME');
  end;
end;

procedure TfmSrvImportPremises.LoadFromIni;
begin
  inherited LoadFromIni;
  pnTop.Height:=ReadParam(ClassName,pnTop.Name,pnTop.Height);
  FColumnVisible.Width:=ReadParam(ClassName,'ColumnVisible',FColumnVisible.Width);
  FColumnName.Width:=ReadParam(ClassName,'ColumnName',FColumnName.Width);
  FColumnValue.Width:=ReadParam(ClassName,'ColumnValue',FColumnValue.Width);
  FColumnWidth.Width:=ReadParam(ClassName,'ColumnWidth',FColumnWidth.Width);
  edRelease.Tag:=ReadParam(ClassName,edRelease.Name,edRelease.Tag);
  edAgency.Tag:=ReadParam(ClassName,edAgency.Name,edAgency.Tag);
  FOldFieldViewId:=edFieldView.Tag;
  edFieldView.Tag:=ReadParam(ClassName,edFieldView.Name,edFieldView.Tag);
  edOperation.Tag:=ReadParam(ClassName,edOperation.Name,edOperation.Tag);
  edTown.Tag:=ReadParam(ClassName,edTown.Name,edTown.Tag);
  SetRelease;
  SetAgency;
  SetFieldView;
  SetOperation;
  SetTown;
  ChangeFieldView(false);
end;

procedure TfmSrvImportPremises.SaveToIni;
begin
  WriteParam(ClassName,pnTop.Name,pnTop.Height);
  WriteParam(ClassName,'ColumnVisible',FColumnVisible.Width);
  WriteParam(ClassName,'ColumnName',FColumnName.Width);
  WriteParam(ClassName,'ColumnValue',FColumnValue.Width);
  WriteParam(ClassName,'ColumnWidth',FColumnWidth.Width);
  WriteParam(ClassName,edRelease.Name,edRelease.Tag);
  WriteParam(ClassName,edAgency.Name,edAgency.Tag);
  WriteParam(ClassName,edFieldView.Name,edFieldView.Tag);
  WriteParam(ClassName,edOperation.Name,edOperation.Tag);
  WriteParam(ClassName,edTown.Name,edTown.Tag);
  inherited SaveToIni;
end;

procedure TfmSrvImportPremises.btCloseClick(Sender: TObject);
begin
  FBreaked:=true;
  Close;
end;

procedure TfmSrvImportPremises.RefillGridPreview;
var
  ADef: TAPPremisesDef;
  AColumn: TColumn;
  AVisible: Boolean;
  OldCursor: TCursor;
  B: TBookmark;
  i: Integer;
  ALink: TAPPremisesDefLink;
begin
  if FDataColumns.Active then begin
    with FDataColumns do begin
      OldCursor:=Screen.Cursor;
      Screen.Cursor:=crHourGlass;
      B:=GetBookmark;
      DisableControls;
      try
        FGridPreview.Columns.Clear;
        First;
        while not Eof do begin
          ADef:=APPremisesDefs.FindDefByColumn(FieldByName('NAME').AsString);
          AVisible:=Boolean(FieldByName('VISIBLE').AsInteger);
          if AVisible then begin
            if Assigned(ADef) then begin
              if ADef.Links.Count=0 then begin
                AColumn:=FGridPreview.FindColumnByTitle(ADef.ColumnName);
                if not Assigned(AColumn) then
                  AColumn:=FGridPreview.Columns.Add;
                AColumn.Title.Caption:=ADef.ColumnName;
                AColumn.Width:=FieldByName('VALUE_WIDTH').AsInteger;
                AColumn.ButtonStyle:=iff(Trim(ADef.TableName)<>'',cbsEllipsis,cbsNone);
                AColumn.ReadOnly:=AColumn.ButtonStyle=cbsEllipsis;
                if Trim(ADef.AliasName)<>'' then
                  AColumn.FieldName:=ADef.AliasName
                else AColumn.FieldName:=ADef.FieldName;
              end else begin
                for i:=0 to ADef.Links.Count-1 do begin
                  ALink:=TAPPremisesDefLink(ADef.Links[i]);
                  AColumn:=FGridPreview.FindColumnByTitle(ALink.Def.ColumnName);
                  if not Assigned(AColumn) then begin
                    AColumn:=FGridPreview.Columns.Add;
                    AColumn.Title.Caption:=ALink.Def.ColumnName;
                    AColumn.Width:=FieldByName('VALUE_WIDTH').AsInteger;
                    AColumn.ButtonStyle:=iff(Trim(ALink.Def.TableName)<>'',cbsEllipsis,cbsNone);
                    AColumn.ReadOnly:=AColumn.ButtonStyle=cbsEllipsis;
                    if Trim(ALink.Def.AliasName)<>'' then
                      AColumn.FieldName:=ALink.Def.AliasName
                    else AColumn.FieldName:=ALink.Def.FieldName;
                  end;
                end;
              end;
            end;
          end;
          Next;
        end;
        First;
      finally
        if Assigned(B) and BookmarkValid(B) then
          GotoBookmark(B);
        FGridPreview.Visible:=not FDataColumns.IsEmpty;
        EnableControls;
        Screen.Cursor:=OldCursor;
      end;
    end;
  end;
end;

procedure TfmSrvImportPremises.DataColumnsNewRecord(DataSet: TDataSet);
begin
  if FDataColumns.Active then begin
    with FDataColumns do begin
      FieldByName('VALUE_WIDTH').AsInteger:=40;
    end;
  end;
end;

procedure TfmSrvImportPremises.DataColumnsAfterPost(DataSet: TDataSet);
begin
  if FDataColumns.Active then begin
    RefillGridPreview;
  end;
end;

procedure TfmSrvImportPremises.DataColumnsAfterDelete(DataSet: TDataSet);
begin
  if FDataColumns.Active then begin
    RefillGridPreview;
  end;
end;

procedure TfmSrvImportPremises.GridPreviewCellClick(Column: TColumn);
var
  ADef: TAPPremisesDef;
begin
  ADef:=APPremisesDefs.FindDefByColumn(Column.Title.Caption);
  if Assigned(ADef) then begin
    Column.ButtonStyle:=iff(Trim(ADef.TableName)<>'',cbsEllipsis,cbsNone);
    Column.ReadOnly:=Column.ButtonStyle=cbsEllipsis;
  end;
end;

procedure TfmSrvImportPremises.GridPreviewEditButtonClick(Sender: TObject);
var
  AColumn: TColumn;
  ADef: TAPPremisesDef;
  ARegionDef: TAPPremisesDef;
  TPRBI: TParamRBookInterface;
  S: String;
  V: Variant;
begin
  if FDataPreview.Active then begin
    AColumn:=FGridPreview.Columns.Items[FGridPreview.SelectedIndex];
    if Assigned(AColumn) then begin
      ADef:=APPremisesDefs.FindDefByColumn(AColumn.Title.Caption);
      if Assigned(ADef) then begin
        FillChar(TPRBI,SizeOf(TPRBI),0);
        TPRBI.Visual.TypeView:=tvibvModal;
        TPRBI.Locate.KeyFields:=PChar(ADef.FieldName);
        TPRBI.Locate.KeyValues:=FDataPreview.FieldByName(ADef.FieldName).Value;
        TPRBI.Locate.Options:=[loCaseInsensitive];
        if AnsiSameText(ADef.InterfaceName,NameRbkAPStreet) then begin
          TPRBI.Condition.WhereStr:='';
          ARegionDef:=APPremisesDefs.FindDefByColumn('�����');
          if Assigned(ARegionDef) then begin
            V:=FDataPreview.FieldByName(ARegionDef.FieldName).Value;
            if not VarIsNull(V) then begin
              S:=Format('AP_STREET_ID IN (SELECT AP_STREET_ID FROM AP_REGION_STREET WHERE AP_REGION_ID=%s)',[VarToStr(V)]);
              TPRBI.Condition.WhereStr:=PChar(S);
            end;
          end;
        end;

        if _ViewInterfaceFromName(PChar(ADef.InterfaceName),@TPRBI) then begin
          FDataPreview.Edit;
          try
            FDataPreview.FieldByName(ADef.FieldName).Value:=GetFirstValueFromParamRBookInterface(@TPRBI,ADef.FieldName);
            FDataPreview.FieldByName(ADef.AliasName).Value:=GetFirstValueFromParamRBookInterface(@TPRBI,ADef.FieldName2);
          finally
            FDataPreview.Post;
          end;
        end;
      end;
    end;  
  end;
end;

procedure TfmSrvImportPremises.btOperationClick(Sender: TObject);
var
  TPRBI: TParamRBookInterface;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tvibvModal;
  TPRBI.Locate.KeyFields:='AP_OPERATION_ID';
  TPRBI.Locate.KeyValues:=edOperation.Tag;
  TPRBI.Locate.Options:=[loCaseInsensitive];
  if _ViewInterfaceFromName(NameRbkAPOperation,@TPRBI) then begin
    edOperation.Tag:=GetFirstValueFromParamRBookInterface(@TPRBI,'AP_OPERATION_ID');
    edOperation.Text:=GetFirstValueFromParamRBookInterface(@TPRBI,'NAME');
  end;
end;

function TfmSrvImportPremises.GetPreviewImportType(Extension: String): TPreviewImportType;
begin
  Result:=piUnknown;
  if AnsiSameText(Extension,SExcelExtension) then Result:=piExcel;
  if AnsiSameText(Extension,STextExtension) then Result:=piText;
end;

procedure TfmSrvImportPremises.btBreakClick(Sender: TObject);
begin
  FBreaked:=true;
end;

procedure TfmSrvImportPremises.btLoadClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
  PreviewType: TPreviewImportType;
begin
  OpenDialog:=TOpenDialog.Create(nil);
  try
    OpenDialog.Filter:=SPreviewImportFilter;
    OpenDialog.FileName:=FLastFileName;
    if OpenDialog.Execute then begin
      PreviewType:=GetPreviewImportType(ExtractFileExt(OpenDialog.FileName));
      case PreviewType of
        piUnknown: ShowErrorEx(SInvalidFormat);
        piExcel: begin
          APPremisesDefs.FillDefValues;
          LoadToPreviewFromExcel(OpenDialog.FileName,fmOptions.CheckBoxUseOriginalText.Checked);
        end;  
      end;
    end;
  finally
    OpenDialog.Free;
  end;
end;

procedure ViewLogItemProc(Owner: Pointer; LogItemHandle: THandle); stdcall;
var
  i: Integer;
  AObject: TLogItemObject;
begin
  with TfmSrvImportPremises(Owner) do begin
    if FDataPreview.Active and not FDataPreview.IsEmpty then begin
      for i:=0 to FListLogItems.Count-1 do begin
        AObject:=TLogItemObject(FListLogItems.Items[i]);
        if AObject.Handle=LogItemHandle then begin
          FDataPreview.Locate('AP_PREMISES_ID',AObject.PremisesId,[loCaseInsensitive]);
          break;
        end;
      end;
    end;  
  end;
end;

procedure TfmSrvImportPremises.LoadToPreviewFromExcel(FileName: String; UseOriginal: Boolean);

  procedure AppendByColumnIndex(PremisesId: Integer; VOle: OleVariant; Index: Integer);
  var
    ADef: TAPPremisesDef;
    ALink: TAPPremisesDefLink;
    i: Integer;
    AValueId: Variant;
    TCLI: TCreateLogItem;
    AObject: TLogItemObject;
    AValue: Variant;
    V: Variant;
    AName: String;
  begin
    V:=VOle;
    FDataColumns.First;
    FDataColumns.MoveBy(Index-1);
    ADef:=APPremisesDefs.FindDefByColumn(FDataColumns.FieldByName('NAME').AsString);
    if Assigned(ADef) then begin
      try
        if ADef.Links.Count=0 then begin
          if Trim(ADef.AliasName)='' then begin
            FDataPreview.FieldByName(ADef.FieldName).Value:=V;
          end else begin
            AName:='';
            AValueId:=GetValueIdByDef(V,ADef,AName);
            if not VarIsNull(AValueId) then begin
              FDataPreview.FieldByName(ADef.FieldName).Value:=AValueId;
            end;
            if UseOriginal or (Trim(AName)='') then
              FDataPreview.FieldByName(ADef.AliasName).Value:=V
            else
              FDataPreview.FieldByName(ADef.AliasName).Value:=AName;
          end;
        end else begin
          for i:=0 to ADef.Links.Count-1 do begin
            ALink:=TAPPremisesDefLink(ADef.Links[i]);
            AValue:=ADef.Links.GetValueByIndex(V,i);
            if Trim(ALink.Def.AliasName)='' then begin
              FDataPreview.FieldByName(ALink.Def.FieldName).Value:=AValue;
            end else begin
              AName:='';
              AValueId:=GetValueIdByDef(AValue,ALink.Def,AName);
              if not VarIsNull(AValueId) then begin
                FDataPreview.FieldByName(ALink.Def.FieldName).Value:=AValueId;
              end;
            if UseOriginal or (Trim(AName)='') then
                FDataPreview.FieldByName(ALink.Def.AliasName).Value:=AValue
              else
                FDataPreview.FieldByName(ALink.Def.AliasName).Value:=AName;
            end;                                      
          end;
        end;
      except
        On E: Exception do begin
          FillChar(TCLI,SizeOf(TCLI),0);
          TCLI.Text:=PChar(Format('������� %s: �������� = %s (%s)',[FDataColumns.FieldByName('NAME').AsString,VarToStr(V),E.Message]));
          TCLI.TypeLogItem:=tliError;
          TCLI.Owner:=Self;
          TCLI.ViewLogItemProc:=ViewLogItemProc;
          AObject:=TLogItemObject.Create;
          AObject.Handle:=_CreateLogItem(@TCLI);
          AObject.PremisesId:=PremisesId;
          FListLogItems.Add(AObject);
        end;
      end;
    end;
  end;

  procedure UpdateRegionIfExists;

    function FindDef(AName: String): TAPPremisesDef;
    var
      i: Integer;
      AColumn: TColumn;
    begin
      Result:=nil;
      for i:=0 to FGridPreview.Columns.Count-1 do begin
        AColumn:=FGridPreview.Columns.Items[i];
        if AnsiSameText(AColumn.Title.Caption,AName) then begin
          Result:=APPremisesDefs.FindDefByColumn(AName);
          exit;
        end;  
      end;
    end;

    procedure GetRegionByStreet(AStreetId: Variant; AOldRegionId: Variant; AOldRegionName: Variant;
                                out ANewRegionId: Variant; out ANewRegionName: Variant);
    var
      qr: TIBQuery;
      tran: TIBTransaction;
      Value: Integer;
      Sql: String;
    begin
      ANewRegionId:=AOldRegionId;
      ANewRegionName:=AOldRegionName;
      qr:=TIBQuery.Create(nil);
      tran:=TIBTransaction.Create(nil);
      try
        tran.AddDatabase(IBDB);
        IBDB.AddTransaction(tran);
        tran.Params.Text:=DefaultTransactionParamsTwo;
        qr.Database:=IBDB;
        qr.Transaction:=tran;
        qr.Transaction.Active:=true;
        Sql:=Format('SELECT RS.*, S.NAME AS STREET_NAME, R.NAME AS REGION_NAME FROM AP_REGION_STREET RS JOIN '+
                    'AP_STREET S ON S.AP_STREET_ID=RS.AP_STREET_ID JOIN '+
                    'AP_REGION R ON R.AP_REGION_ID=RS.AP_REGION_ID '+
                    'WHERE RS.AP_STREET_ID=%s',[VarToStr(AStreetId)]);
        qr.SQL.Add(Sql);
        qr.Open;
        if not qr.IsEmpty then begin
          Value:=qr.FieldByName('AP_REGION_ID').Value;
          if not VarIsNull(Value) and (Value<>AOldRegionId) then begin
            ANewRegionId:=Value;
            ANewRegionName:=qr.FieldByName('REGION_NAME').Value;
          end;
        end else begin
          ANewRegionId:=Null;
          ANewRegionName:=Null;
        end;
      finally
        tran.Free;
        qr.Free;
      end;
    end;

  var
    AStreetDef: TAPPremisesDef;
    AStreetId: Variant;
    ARegionDef: TAPPremisesDef;
    ARegionId, ARegionName: Variant;
    ANewRegionId, ANewRegionName: Variant;
  begin
    if fmOptions.CheckBoxAutoTranslateRegion.Checked then begin
      AStreetDef:=FindDef('�����');
      if Assigned(AStreetDef) then begin
        AStreetId:=FDataPreview.FieldByName(AStreetDef.FieldName).Value;
        ARegionDef:=FindDef('�����');
        if Assigned(ARegionDef) and not VarIsNull(AStreetId) then begin
          ARegionId:=FDataPreview.FieldByName(ARegionDef.FieldName).Value;
          ARegionName:=FDataPreview.FieldByName(ARegionDef.AliasName).Value;
          if VarIsNull(ARegionId) or VarIsNull(ARegionName) then begin
            GetRegionByStreet(AStreetId,ARegionId,ARegionName,ANewRegionId,ANewRegionName);
            FDataPreview.FieldByName(ARegionDef.FieldName).Value:=ANewRegionId;
            FDataPreview.FieldByName(ARegionDef.AliasName).Value:=ANewRegionName;
          end;
        end;
      end;
    end;
  end;

var
  TCPB: TCreateProgressBar;
  TSPBS: TSetProgressBarStatus;
  Excel: OleVariant;
  wb: OleVariant;
  sh: OleVariant;
  V: OleVariant;
  S: OleVariant;
  Data: OleVariant;
  rwCount,clCount: Integer;
  pb: THandle;
  i,j: Integer;
  B: TBookmark;

begin
  CoInitialize(nil);
  btBreak.Enabled:=true;
  try
    FBreaked:=false;
    ClearListLogItems;
    Excel:=CreateOleObject(ConstExcelOle);
    Excel:=Excel.Application;
    Excel.WorkBooks.Open(FileName);
    wb:=Excel.WorkBooks.Item[1];
    Sh:=Wb.Sheets.Item[1];
    S:=Excel.Selection;
    if VarIsEmpty(S) then exit;
    rwCount:=S.Rows.Count;
    if rwCount=0 then exit;
    clCount:=S.Columns.Count;
    if clCount=0 then exit;
    Data:=S.Value;

    FillChar(TCPB,SizeOf(TCPB),0);
    TCPB.Min:=0;
    TCPB.Max:=rwCount;
    TCPB.Color:=clNavy;
    pb:=_CreateProgressBar(@TCPB);
    B:=FDataColumns.GetBookmark;
    FDataColumns.AfterScroll:=nil;
    FDataColumns.DisableControls;
    FDataPreview.DisableControls;
    try
      FDataPreview.EmptyDataSet;
      for i:=1 to rwCount do begin
        Application.ProcessMessages;
        if FBreaked then break;
        try
          FDataPreview.Append;
          try
            FDataPreview.FieldByName('AP_PREMISES_ID').AsInteger:=i;
            for j:=1 to clCount do begin
              Application.ProcessMessages;
              if FBreaked then break;
              V:=Data[i,j];
              AppendByColumnIndex(i,V,j);
            end;
            UpdateRegionIfExists;
          finally
            FDataPreview.Post;
          end;
        except
          FDataPreview.Cancel;
        end;
        FillChar(TSPBS,SizeOf(TSPBS),0);
        TSPBS.Progress:=i;
        TSPBS.Max:=rwCount;
        _SetProgressBarStatus(pb,@TSPBS);
      end;
    finally
      FDataPreview.EnableControls;
      if Assigned(B) and FDataColumns.BookmarkValid(B) then
        FDataColumns.GotoBookmark(B);
      FDataColumns.EnableControls;
      FDataColumns.AfterScroll:=DataColumnsAfterScroll;
      _FreeProgressBar(pb);
      if FListLogItems.Count>0 then
        _ViewLog(true);
      Application.ProcessMessages;
    end;

  finally
    if not VarIsEmpty(Excel) then begin
      Excel.Quit;
    end;
    btBreak.Enabled:=false;
    btImport.Enabled:=not FDataPreview.IsEmpty;
    FLastFileName:=FileName;
    grbPreview.Caption:=Format(' %s --> %s ',[SPreviewCaption,FLastFileName]);
    UpdateLabelCount;
    CoUninitialize;
  end;
end;

procedure TfmSrvImportPremises.miPreviewClearClick(Sender: TObject);
begin
  if FDataPreview.Active then begin
    FDataPreview.EmptyDataSet;
    UpdateLabelCount;
  end;  
end;

procedure TfmSrvImportPremises.miPreviewSaveClick(Sender: TObject);
var
  SaveDialog: TSaveDialog;
begin
  if FDataPreview.Active and not FDataPreview.IsEmpty then begin
    SaveDialog:=TSaveDialog.Create(nil);
    try
      SaveDialog.Filter:=SPreviewFilter;
      SaveDialog.DefaultExt:=SPreviewDefaultExt;
      SaveDialog.FileName:=Format('%s_%s_%s',[edRelease.Text,edAgency.Text,edOperation.Text]);
      if SaveDialog.Execute then begin
        Screen.Cursor:=crHourglass;
        try
          FDataPreview.MergeChangeLog;
          FDataPreview.SaveToFile(SaveDialog.FileName,dfXML);
        finally
          Screen.Cursor:=crDefault;
        end;   
      end;
    finally
      SaveDialog.Free;
    end;
  end;  
end;

procedure TfmSrvImportPremises.miPreviewLoadClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
begin
  if FDataPreview.Active then begin
    OpenDialog:=TOpenDialog.Create(nil);
    try
      OpenDialog.Filter:=SPreviewFilter;
      OpenDialog.DefaultExt:=SPreviewDefaultExt;
      if OpenDialog.Execute then begin
        Screen.Cursor:=crHourglass;
        try
          FDataPreview.LoadFromFile(OpenDialog.FileName);
          FDataPreview.MergeChangeLog;
          UpdateLabelCount;
          btImport.Enabled:=not FDataPreview.IsEmpty;
        finally
          Screen.Cursor:=crDefault;
        end;  
      end;
    finally
      OpenDialog.Free;
    end;
  end;  
end;

procedure TfmSrvImportPremises.pmPreviewPopup(Sender: TObject);
begin
  miPreviewAdd.Enabled:=CheckPreviewAdd;
  miPreviewChange.Enabled:=CheckPreviewAdd;
  miPreviewChange.Caption:='�������� � �����������';
  miTranslate.Enabled:=FDataPreview.Active and not FDataPreview.IsEmpty;
  miPreviewSave.Enabled:=FDataPreview.Active and not FDataPreview.IsEmpty;
  miPreviewLoad.Enabled:=FDataPreview.Active;
  miPreviewClear.Enabled:=FDataPreview.Active and not FDataPreview.IsEmpty;
  miPreviewDelete.Enabled:=FDataPreview.Active and not FDataPreview.IsEmpty;
  miPreviewRefresh.Enabled:=FileExists(FLastFileName);
end;

procedure TfmSrvImportPremises.btImportClick(Sender: TObject);
begin
  if Trim(edRelease.Text)='' then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[lbRelease.Caption]));
    edRelease.SetFocus;
    exit;
  end;
  if Trim(edAgency.Text)='' then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[lbAgency.Caption]));
    edAgency.SetFocus;
    exit;
  end;
  if Trim(edOperation.Text)='' then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[lbOperation.Caption]));
    edOperation.SetFocus;
    exit;
  end;
  if Trim(edTown.Text)='' then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[lbTown.Caption]));
    edTown.SetFocus;
    exit;
  end;
  ImportToDataBaseFromPreview;
end;

procedure TfmSrvImportPremises.ImportToDataBaseFromPreview;
var
  AFIelds,AValues: String;

  procedure ProcessFieldValue(AField: TField; ADefValue: Variant; AFieldName: String);
  var
    S: String;
  begin
    AFields:=AFields+','+AFieldName;
    case AField.DataType of
      ftInteger,ftWord,ftSmallint: begin
        AValues:=AValues+','+inttostr(ADefValue);
      end;
      ftString,ftMemo,ftFixedChar,ftWideString,ftFmtMemo,ftDate,ftTime,ftDateTime: begin
        S:=VarToStr(ADefValue);
        S:=ChangeString(S,#10,' ');
        AValues:=AValues+','+QuotedStr(S);
      end;
      ftFloat,ftCurrency,ftBCD: begin
        AValues:=AValues+','+QuotedStr(ChangeString(VarToStr(ADefValue),DecimalSeparator,'.'));
      end;
    end;
  end;

  procedure ProcessField(AField: TField; ADefValueName,ADefValueId: Variant; ADef: TAPPremisesDef; AFieldName: String);
  begin
    if Assigned(AField) then begin
      if not VarIsNull(AField.Value) then begin
        ProcessFieldValue(AField,AField.Value,AFieldName);
      end else begin
        if Trim(ADef.TableName)<>'' then begin
          if not VarIsNull(ADefValueId) then begin
            ProcessFieldValue(AField,ADefValueId,AFieldName);
          end;
        end else begin
          if not VarIsNull(ADefValueName) then begin
            ProcessFieldValue(AField,ADefValueName,AFieldName);
          end;
        end;
      end;
    end;
  end;

  procedure FillFieldsAndValues;
  var
    B: TBookmark;
    AName: String;
    ADef: TAPPremisesDef;
    AVisible: Boolean;
    ADefValueName,ADefValueId: Variant;
    AField: TField;
    i: Integer;
    ALink: TAPPremisesDefLink;               
    AFieldName: String;
  begin
    FDataColumns.DisableControls;
    B:=FDataColumns.GetBookmark;
    try
      FDataColumns.First;
      while not FDataColumns.Eof do begin
        AName:=FDataColumns.FieldByName('NAME').AsString;
        AVisible:=true;
        if AVisible then begin
          ADef:=APPremisesDefs.FindDefByColumn(AName);
          if Assigned(ADef) then begin
            ADefValueName:=FDataColumns.FieldByName('VALUE_NAME').Value;
            if Trim(VarToStr(ADefValueName))='' then ADefValueName:=Null;
            ADefValueId:=FDataColumns.FieldByName('VALUE_ID').Value;
            if ADef.Links.Count=0 then begin
              AFieldName:=ADef.FieldName;
              AField:=FDataPreview.Fields.FindField(AFieldName);
              if not Assigned(AField) and (Trim(ADef.AliasName)<>'')then begin
                AField:=FDataPreview.Fields.FindField(ADef.AliasName);
              end;  
              ProcessField(AField,ADefValueName,ADefValueId,ADef,AFieldName);
            end else begin
              for i:=0 to ADef.Links.Count-1 do begin
                ALink:=TAPPremisesDefLink(ADef.Links[i]);
                AFieldName:=ALink.Def.FieldName;
                AField:=FDataPreview.Fields.FindField(AFieldName);
                if not Assigned(AField) and (Trim(ALink.Def.AliasName)<>'')then begin
                  AField:=FDataPreview.Fields.FindField(ALink.Def.AliasName);
                  AFieldName:=ALink.Def.AliasName;
                end;  
                ProcessField(AField,ADef.Links.GetValueByIndex(ADefValueName,i),ADefValueId,ADef,AFieldName);
              end;
            end;
          end;
        end;  
        FDataColumns.Next;
      end;
    finally
      if Assigned(B) and FDataColumns.BookmarkValid(B) then
        FDataColumns.GotoBookmark(B);
      FDataColumns.EnableControls;
    end;
  end;

var
  Sqls: string;
  T: TInfoConnectUser;
  dt: TDateTime;
  PremisesId: Integer;
  TCLI: TCreateLogItem;
  AObject: TLogItemObject;
begin
  FDataPreview.DisableControls;
  try

    FBreaked:=false;
    ClearListLogItems;
    FillChar(T,SizeOf(T),0);
    _GetInfoConnectUser(@T);
    dt:=_GetDateTimeFromServer;
    FDataPreview.First;
    while not FDataPreview.Eof do begin
      Application.ProcessMessages;
      if FBreaked then break;

      PremisesId:=GetGenId(IBDB,'AP_PREMISES',1);

      AFields:='AP_PREMISES_ID';
      AValues:=InttoStr(PremisesId);

      AFields:=AFields+',AP_OPERATION_ID';
      AValues:=AValues+','+IntToStr(edOperation.Tag);

      AFields:=AFields+',AP_AGENCY_ID';
      AValues:=AValues+','+IntToStr(edAgency.Tag);

      AFields:=AFields+',RELEASE_ID';
      AValues:=AValues+','+IntToStr(edRelease.Tag);

      AFields:=AFields+',AP_TOWN_ID';
      AValues:=AValues+','+IntToStr(edTown.Tag);

      AFields:=AFields+',DELIVERY_DATE';
      AValues:=AValues+','+QuotedStr(DateToStr(dtpDateDelivery.Date));
      
      AFields:=AFields+',WHO_INSERT_ID';
      AValues:=AValues+','+IntToStr(T.User_id);

      AFields:=AFields+',WHEN_INSERT';
      AValues:=AValues+','+QuotedStr(DateTimeToStr(dt));

      AFields:=AFields+',WHO_UPDATE_ID';
      AValues:=AValues+','+IntToStr(T.User_id);

      AFields:=AFields+',WHEN_UPDATE';
      AValues:=AValues+','+QuotedStr(DateTimeToStr(dt));
      
      FillFieldsAndValues;
      Sqls:=Format('INSERT INTO AP_PREMISES (%s) VALUES (%s)',[AFIelds,AValues]);
      try
        ExecSql(IBDB,Sqls);
        FDataPreview.Delete;
        UpdateLabelCount;
      except
        On E: Exception do begin
          FDataPreview.Next;
          FillChar(TCLI,SizeOf(TCLI),0);
          TCLI.Text:=PChar(E.Message);
          TCLI.TypeLogItem:=tliError;
          TCLI.Owner:=Self;
          TCLI.ViewLogItemProc:=ViewLogItemProc;
          AObject:=TLogItemObject.Create;
          AObject.Handle:=_CreateLogItem(@TCLI);
          AObject.PremisesId:=PremisesId;
          FListLogItems.Add(AObject);
        end;
      end;
    end;
  finally
    FDataPreview.EnableControls;
    if FListLogItems.Count>0 then
      _ViewLog(true);
  end;
end;

function TfmSrvImportPremises.GridPreviewGetFontColor(Sender: TObject; Column: TColumn): TColor;
var
  ADef: TAPPremisesDef;
  AValue: Variant;
  AName: String;
begin
  Result:=Column.Font.Color;
  ADef:=APPremisesDefs.FindDefByColumn(Column.Title.Caption);
  if Assigned(ADef) then begin
    if Trim(ADef.TableName)<>'' then begin
      AValue:=GetValueIdByDef(FDataPreview.FieldByName(ADef.AliasName).Value,ADef,AName);
      if VarIsNull(AValue) then
        Result:=clRed;
    end;
  end;
end;

function TfmSrvImportPremises.CheckPreviewAdd: Boolean;
var
  ADef: TAPPremisesDef;
  AValue: Variant;
  AColumn: TColumn;
  AName: String;
begin
  Result:=False;
  if FDataPreview.Active and not FDataPreview.IsEmpty and (FGridPreview.SelectedIndex<>-1) then begin
    AColumn:=FGridPreview.Columns[FGridPreview.SelectedIndex];
    if Assigned(AColumn) then begin
      ADef:=APPremisesDefs.FindDefByColumn(AColumn.Title.Caption);
      if Assigned(ADef) then begin
        if Trim(ADef.TableName)<>'' then begin
          AValue:=GetValueIdByDef(FDataPreview.FieldByName(ADef.AliasName).AsString,ADef,AName);
          if VarIsNull(AValue) then
            Result:=true;
        end;
      end;
    end;
  end;
end;

procedure TfmSrvImportPremises.GridPreviewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F2 then
    if CheckPreviewAdd then begin
      miPreviewAdd.Click;
    end;
  if Key=VK_F3 then
    if CheckPreviewAdd then begin
      miPreviewChange.Click;
    end;

  if (Key=VK_DELETE) and (ssCtrl in Shift) then
    if FDataPreview.Active and not FDataPreview.IsEmpty then begin
      miPreviewDelete.Click;
    end;

  if Key=VK_F5 then begin
    if FileExists(FLastFileName) then
      miPreviewRefresh.Click;
  end;

end;

procedure TfmSrvImportPremises.miPreviewAddClick(Sender: TObject);
var
  ADef: TAPPremisesDef;
  AColumn: TColumn;
  TPRBI: TParamRBookInterface;
begin
  if FDataPreview.Active and not FDataPreview.IsEmpty and (FGridPreview.SelectedIndex<>-1) then begin
    AColumn:=FGridPreview.Columns[FGridPreview.SelectedIndex];
    if Assigned(AColumn) then begin
      ADef:=APPremisesDefs.FindDefByColumn(AColumn.Title.Caption);
      if Assigned(ADef) then begin
        FillChar(TPRBI,SizeOf(TPRBI),0);
        TPRBI.Visual.TypeView:=tvibvModal;
        TPRBI.Visual.TypeEdit:=terbAdd;
        SetLength(TPRBI.Edit,1);
        TPRBI.Edit[0].FieldName:=ADef.FieldName2;
        TPRBI.Edit[0].FieldValue:=FDataPreview.FieldByName(ADef.AliasName).AsString;
        if _ViewInterfaceFromName(PChar(ADef.InterfaceName),@TPRBI) then begin
          FDataPreview.Edit;
          try
            FDataPreview.FieldByName(ADef.FieldName).Value:=GetFirstValueFromParamRBookInterface(@TPRBI,ADef.FieldName);
            FDataPreview.FieldByName(ADef.AliasName).Value:=GetFirstValueFromParamRBookInterface(@TPRBI,ADef.FieldName2);
            ADef.FillValues;
          finally
            FDataPreview.Post;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfmSrvImportPremises.UpdateLabelCount;
begin
  lbCount.Caption:=Format('�����: %d',[FDataPreview.RecordCount]);
end;

procedure TfmSrvImportPremises.miPreviewDeleteClick(Sender: TObject);
begin
  if FDataPreview.Active and not FDataPreview.IsEmpty then begin
    FDataPreview.Delete;
    UpdateLabelCount;
  end;
end;

procedure TfmSrvImportPremises.miPreviewRefreshClick(Sender: TObject);
begin
  if FileExists(FLastFileName) then begin
    APPremisesDefs.FillDefValues;
    LoadToPreviewFromExcel(FLastFileName,fmOptions.CheckBoxUseOriginalText.Checked);
  end;
end;

procedure TfmSrvImportPremises.ClearListLogItems;
var
  i: Integer;
  AObject: TLogItemObject;
begin
  for i:=0 to FListLogItems.Count-1 do begin
    AObject:=TLogItemObject(FListLogItems.Items[i]);
    _FreeLogItem(AObject.Handle);
  end;
  FListLogItems.Clear;
end;

{procedure TfmSrvImportPremises.FillMenuPreviewChange;
var
  ADef: TAPPremisesDef;
  AColumn: TColumn;
  i: Integer;
  AMenu: TMenuItem;
  AValue: TAPPremisesDefValue;
begin
  if FDataPreview.Active and not FDataPreview.IsEmpty and (FGridPreview.SelectedIndex<>-1) then begin
    Screen.Cursor:=crHourGlass;
    try
      AColumn:=FGridPreview.Columns[FGridPreview.SelectedIndex];
      if Assigned(AColumn) then begin
        ADef:=APPremisesDefs.FindDefByColumn(AColumn.Title.Caption);
        if Assigned(ADef) then begin
          if (Trim(ADef.TableName)<>'') and (ADef.Values.Count>0) then begin
            miPreviewChange.Clear;
            try
              for i:=0 to ADef.Values.Count-1 do begin
                AValue:=ADef.Values.Items[i];
                AMenu:=TMenuItem.Create(nil);
                AMenu.Caption:=AValue.Name;
                AMenu.Tag:=Integer(AValue);
                AMenu.OnClick:=MenuPreviewChangeClick;
                miPreviewChange.Add(AMenu);
              end;
            finally
              miPreviewChange.Caption:=Format('�������� %s',[ADef.InterfaceName]);
            end;
          end;
        end;
      end;
    finally
      Screen.Cursor:=crDefault;
    end;  
  end;
end;}

{procedure TfmSrvImportPremises.MenuPreviewChangeClick(Sender: TObject);
var
  AMenu: TMenuItem;
  AValue: TAPPremisesDefValue;
  S: String;
  ASql: String;
  ADef: TAPPremisesDef;
begin
  AMenu:=TMenuItem(Sender);
  if Assigned(AMenu) then begin
    AValue:=TAPPremisesDefValue(AMenu.Tag);
    if Assigned(AValue) then begin
      if FDataPreview.Active and not FDataPreview.IsEmpty then begin
        ADef:=AValue.DefValues.Def;
        S:=FDataPreview.FieldByName(ADef.AliasName).AsString;
        AValue.Variants.Add(S);
        ASql:=Format('UPDATE %s SET %s=%s WHERE %s=%d',[ADef.TableName,ADef.FieldName3,
                                                        QuotedStr(Trim(AValue.Variants.Text)),
                                                        ADef.TableName+'_ID',AValue.Value]);
        ExecSql(IBDB,ASql);
        FGridPreview.Repaint;
      end;
    end;
  end;
end;}

procedure TfmSrvImportPremises.btTownClick(Sender: TObject);
var
  TPRBI: TParamRBookInterface;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tvibvModal;
  TPRBI.Locate.KeyFields:='AP_TOWN_ID';
  TPRBI.Locate.KeyValues:=edTown.Tag;
  TPRBI.Locate.Options:=[loCaseInsensitive];
  if _ViewInterfaceFromName(NameRbkAPTown,@TPRBI) then begin
    edTown.Tag:=GetFirstValueFromParamRBookInterface(@TPRBI,'AP_TOWN_ID');
    edTown.Text:=GetFirstValueFromParamRBookInterface(@TPRBI,'NAME');
  end;
end;

procedure TfmSrvImportPremises.miPreviewChangeClick(Sender: TObject);
var
  ADef: TAPPremisesDef;
  AColumn: TColumn;
  S,ASql: String;
  TPRBI: TParamRBookInterface;
  Str: TStringList;
  Id: Integer;
begin
  if FDataPreview.Active and not FDataPreview.IsEmpty and (FGridPreview.SelectedIndex<>-1) then begin
    AColumn:=FGridPreview.Columns[FGridPreview.SelectedIndex];
    if Assigned(AColumn) then begin
      ADef:=APPremisesDefs.FindDefByColumn(AColumn.Title.Caption);
      if Assigned(ADef) then begin
        FillChar(TPRBI,SizeOf(TPRBI),0);
        TPRBI.Visual.TypeView:=tvibvModal;
        TPRBI.Visual.TypeEdit:=terbNone;
        if _ViewInterfaceFromName(PChar(ADef.InterfaceName),@TPRBI) then begin
          Str:=TStringList.Create;
          try
            Id:=GetFirstValueFromParamRBookInterface(@TPRBI,ADef.TableName+'_ID');
            Str.Text:=GetFirstValueFromParamRBookInterface(@TPRBI,'VARIANT');
            S:=FDataPreview.FieldByName(ADef.AliasName).AsString;
            Str.Add(S);
            ASql:=Format('UPDATE %s SET %s=%s WHERE %s=%d',[ADef.TableName,ADef.FieldName3,
                                                            QuotedStr(Trim(Str.Text)),
                                                            ADef.TableName+'_ID',Id]);
            ExecSql(IBDB,ASql);
            ADef.FillValues;
            FGridPreview.Repaint;
          finally
            Str.Free;
          end;  
        end;
      end;
    end;
  end;
end;

procedure TfmSrvImportPremises.miTranslateClick(Sender: TObject);
var
  SaveDialog: TSaveDialog;
begin

  if Trim(edOperation.Text)='' then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[lbOperation.Caption]));
    edOperation.SetFocus;
    exit;
  end;
  if Trim(edTown.Text)='' then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[lbTown.Caption]));
    edTown.SetFocus;
    exit;
  end;

  if FDataPreview.Active and not FDataPreview.IsEmpty then begin
    SaveDialog:=TSaveDialog.Create(nil);
    try
      SaveDialog.Filter:=SPreviewRubricator;
      SaveDialog.DefaultExt:=SPreviewRubricatorExt;
      SaveDialog.FileName:=Format('%s_%s_%s',[edRelease.Text,edAgency.Text,edOperation.Text]);
      if SaveDialog.Execute then begin
        Screen.Cursor:=crHourglass;
        try
          TranslateData(SaveDialog.FileName);
        finally
          Screen.Cursor:=crDefault;
        end;   
      end;
    finally
      SaveDialog.Free;
    end;
  end;  
end;

function TrimSpaceForOne(const s: string): string;
var
  I: Integer;
  tmps: string;
begin
  for i:=1 to Length(s) do begin
   if i=1 then begin
     tmps:=s[i];
   end else begin
     if (s[i]<>' ') then
      tmps:=tmps+s[i]
     else
      if (s[i-1]<>' ') then
        tmps:=tmps+s[i];
   end;
  end;
  Result:=tmps;
end;

procedure TfmSrvImportPremises.TranslateData(FileName: String);
var
  B: TBookmark;
  StrOut: TStringList;
  Str: TStringList;
  S,S1,S2,S3: String;
  L1,L2,L3,L4,L5,L6: String;
  Progress: THandle;
  TCPB: TCreateProgressBar;
  TPBS :TSetProgressBarStatus;
  ADef: TAPPremisesDef;
  ID: Integer;
  Counter: Integer;
  OutFormat: String;
  i: Integer;
  Column: TColumn;
  Field: TField;
  Check: Boolean;
  Apos: Integer;
  Search: String;
  AName: String;
begin
  if FDataPreview.Active and not FDataPreview.IsEmpty then begin
    OutFormat:=Trim(fmOptions.meFormat.Lines.Text);
    Check:=fmOptions.CheckBoxDelNextChar.Checked;
    FillCHar(TCPB,SizeOf(TCPB),0);
    TCPB.Min:=0;
    TCPB.Max:=FDataPreview.RecordCount;
    TCPB.Color:=clRed;
    Progress:=_CreateProgressBar(@TCPB);
    FDataPreview.DisableControls;
    B:=FDataPreview.GetBookmark;
    StrOut:=TStringList.Create;
    try
      Counter:=0;
      FDataPreview.First;

      while not FDataPreview.Eof do begin
        Application.ProcessMessages;
        Str:=TStringList.Create;
        try

          case edOperation.Tag of
            14, 15, 17, 21, 20: begin
{              L1:=GetFirstValueBySQL(IBDB,Format('SELECT LINK FROM AP_TOWN WHERE AP_TOWN_ID=%d',[edTown.Tag]),'LINK');
              Str.Add(L1);}
              L1:='';

              L2:='';
              L2:=GetFirstValueBySQL(IBDB,Format('SELECT LINK FROM AP_OPERATION WHERE AP_OPERATION_ID=%d',[edOperation.Tag]),'LINK');
              Str.Add(L2);

              L3:='';
              ADef:=APPremisesDefs.FindDefByColumn('�����������');
              if Assigned(ADef) then begin
                ID:=ADef.GetValueId(FDataPreview.FieldByName(ADef.AliasName).AsString,AName);
                L3:=GetFirstValueBySQL(IBDB,Format('SELECT LINK FROM AP_COUNTROOM WHERE AP_COUNTROOM_ID=%d',[ID]),'LINK');
                Str.Add(L3);
              end;                                                                                                                   

              L4:='';
              ADef:=APPremisesDefs.FindDefByColumn('�����');
              if Assigned(ADef) then begin
                ID:=ADef.GetValueId(FDataPreview.FieldByName(ADef.AliasName).AsString,AName);
                L4:=GetFirstValueBySQL(IBDB,Format('SELECT LINK FROM AP_REGION WHERE AP_REGION_ID=%d',[ID]),'LINK');
                Str.Add(L4);
              end;

              L5:='';
              ADef:=APPremisesDefs.FindDefByColumn('��������');
              if Assigned(ADef) then begin
                ID:=ADef.GetValueId(FDataPreview.FieldByName(ADef.AliasName).AsString,AName);
                L5:=GetFirstValueBySQL(IBDB,Format('SELECT LINK FROM AP_LANDMARK WHERE AP_LANDMARK_ID=%d',[ID]),'LINK');
                Str.Add(L5);
              end;
            end;
            23, 24: begin
              L2:='';
              L2:=GetFirstValueBySQL(IBDB,Format('SELECT LINK FROM AP_OPERATION WHERE AP_OPERATION_ID=%d',[edOperation.Tag]),'LINK');
              Str.Add(L2);

              L6:='';
              ADef:=APPremisesDefs.FindDefByColumn('��� ������������');
              if Assigned(ADef) then begin
                ID:=ADef.GetValueId(FDataPreview.FieldByName(ADef.AliasName).AsString,AName);
                L6:=GetFirstValueBySQL(IBDB,Format('SELECT LINK FROM AP_TYPE_PREMISES WHERE AP_TYPE_PREMISES_ID=%d',[ID]),'LINK');
                Str.Add(L6);
              end;

              Str.Add(iff(edOperation.Tag=24,'������','�����'));
            end;
            26: begin
              L2:='';
              L2:=GetFirstValueBySQL(IBDB,Format('SELECT LINK FROM AP_OPERATION WHERE AP_OPERATION_ID=%d',[edOperation.Tag]),'LINK');
              Str.Add(L2);

              L3:='';
              ADef:=APPremisesDefs.FindDefByColumn('�����������');
              if Assigned(ADef) then begin
                ID:=ADef.GetValueId(FDataPreview.FieldByName(ADef.AliasName).AsString,AName);
                L3:=GetFirstValueBySQL(IBDB,Format('SELECT LINK FROM AP_COUNTROOM WHERE AP_COUNTROOM_ID=%d',[ID]),'LINK');
                Str.Add(L3);
              end;
              
            end;
            else begin
              Str.Add('��� �������');
            end;

          end;


          S:=GetFilterString(Str,'\');
          if Trim(S)<>'' then
            S:='['+S+']';

          StrOut.Add(S);

          Str.Clear;

          for i:=0 to FDataPreview.FieldCount-1 do begin
            Field:=FDataPreview.Fields[i];
            Column:=FGridPreview.FindColumnByField(Field.FieldName);
            if Assigned(Column) then begin
              ADef:=APPremisesDefs.FindDefByColumn(Column.Title.Caption);
              if Assigned(ADef) then begin
                if Trim(ADef.TableName)<>'' then begin
                  ID:=ADef.GetValueId(FDataPreview.FieldByName(ADef.AliasName).AsString,AName);
                  S:=GetFirstValueBySQL(IBDB,Format('SELECT EXPORT FROM %s WHERE %s_ID=%d',[ADef.TableName,ADef.TableName,ID]),'EXPORT');
                  if Trim(S)='' then
                    S:=FDataPreview.FieldByName(ADef.AliasName).AsString;
                  Str.Add(Format('%s=%s',[ADef.AliasName,S]));
                end else begin
                  if Trim(ADef.AliasName)<>'' then begin
                    S:=FDataPreview.FieldByName(ADef.AliasName).AsString;
                    Str.Add(Format('%s=%s',[ADef.AliasName,S]));
                  end else begin
                    S:=FDataPreview.FieldByName(ADef.FieldName).AsString;
                    Str.Add(Format('%s=%s',[ADef.FieldName,S]));
                  end;
                end;
              end;
            end else begin
              Str.Add(Format('%s=%s',[Field.FieldName,Field.AsString]));
            end;  
          end;

          Str.Sort;

          S:=OutFormat;
          S:=ChangeString(S,#13#10,' ');
          Search:=AnsiUpperCase(S);

          for i:=0 to Str.Count-1 do begin
            S1:=AnsiUpperCase('%'+Str.Names[i]);
            S2:=Str.Values[Str.Names[i]];
            Apos:=-1;
            while Apos<>0 do begin
              Apos:=AnsiPos(S1,Search);
              if Apos<>0 then begin
                S3:=Copy(S,1,Apos-1);
                if Trim(S2)<>'' then begin
                  S:=S3+S2+Copy(S,Apos+Length(S1),Length(S));
                end else begin
                  if Check then begin
                    S:=S3+Copy(S,Apos+Length(S1)+1,Length(S));
                  end else begin
                    S:=S3+Copy(S,Apos+Length(S1),Length(S));
                  end;
                end;
                Search:=S;
              end;
            end;
          end;

          S:=Trim(TrimSpaceForOne(S));

          StrOut.Add(S);

        finally
          Str.Free;
        end;

        FDataPreview.Next;
        Inc(Counter);
        FillCHar(TPBS,SizeOf(TPBS),0);
        TPBS.Progress:=Counter;
        TPBS.Max:=FDataPreview.RecordCount;
        _SetProgressBarStatus(Progress,@TPBS);

      end;
      StrOut.SaveToFile(FileName);
    finally
      StrOut.Free;
      _FreeProgressBar(Progress);
      if Assigned(B) and FDataPreview.BookmarkValid(B) then begin
        FDataPreview.GotoBookmark(B);
      end;
      FDataPreview.EnableControls;
    end;
  end;  
end;

end.
