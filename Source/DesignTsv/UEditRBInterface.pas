unit UEditRBInterface;

interface
{$I stbasis.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  UEditRB, StdCtrls, Buttons, ExtCtrls, IBServices, IBQuery, db, IBDatabase, IB,
  ComCtrls, ExtDlgs, Menus, OleCtnrs, ToolWin, ImgList, RAHLEditor,
  RAEditor, UGotoLineDialog, UFindDialog, UReplaceDialog, tsvDesignForm,
  ELDsgnr, UAlignPalette, UTabOrder, UMainUnited, tsvInterpreterCore,
  tsvDocumentForm, IBTable, tsvDesignCore, tsvHintEx;

type


  PInfoLibraryInterpreter=^TInfoLibraryInterpreter;
  TInfoLibraryInterpreter=packed record
    hLibraryInterpreter: THandle;
    GUID: String;
    Hint: String;
    CreateProc: TCreateInterpreterProc;
    RunProc: TRunInterpreterProc;
    ResetProc: TResetInterpreterProc;
    FreeProc: TFreeInterpreterProc;
    IsValidProc: TIsValidInterpreterProc;
    SetParamsProc: TSetInterpreterParamsProc;
    GetCreateInterfaceNameProc: TGetCreateInterfaceNameProc;
    GetInterpreterIdentifersProc: TGetInterpreterIdentifersProc;
  end;

  TfmEditRBInterface = class(TfmEditRB)
    pmScript: TPopupMenu;
    sadgafdg: TMenuItem;
    OD: TOpenPictureDialog;
    SD: TSavePictureDialog;
    odAll: TOpenDialog;
    sdAll: TSaveDialog;
    imL: TImageList;
    pnMain: TPanel;
    pcMain: TPageControl;
    tbsAll: TTabSheet;
    lbName: TLabel;
    lbHint: TLabel;
    lbInterpreter: TLabel;
    edName: TEdit;
    meHint: TMemo;
    cmbInterpreter: TComboBox;
    tbsScript: TTabSheet;
    ctrlBarScript: TControlBar;
    tlBarScript: TToolBar;
    tlbNewScript: TToolButton;
    tlbOpenScript: TToolButton;
    tlbSaveScript: TToolButton;
    ToolButton2: TToolButton;
    tlbUndoScript: TToolButton;
    tlbRedoScript: TToolButton;
    ToolButton6: TToolButton;
    tlbCutScript: TToolButton;
    tlbCopyScript: TToolButton;
    tlbPasteScript: TToolButton;
    tlbDeleteScript: TToolButton;
    ToolButton5: TToolButton;
    tlbRunScript: TToolButton;
    tlbStopScript: TToolButton;
    tlbResetScript: TToolButton;
    tlbCompileScript: TToolButton;
    ToolButton3: TToolButton;
    tlbFindScript: TToolButton;
    tlbReplaceScript: TToolButton;
    tlbFindAgainScript: TToolButton;
    ToolButton4: TToolButton;
    tlbGotoLineScript: TToolButton;
    ToolButton7: TToolButton;
    tlbWathcScript: TToolButton;
    ToolButton8: TToolButton;
    tlbOptionScript: TToolButton;
    tbsForms: TTabSheet;
    tbsDocs: TTabSheet;
    ctrlBarOle: TControlBar;
    tlBarOle: TToolBar;
    tlbOleNew: TToolButton;
    tlbOleOpen: TToolButton;
    tlbOleSave: TToolButton;
    ctrlBarForms: TControlBar;
    tlBarForms1: TToolBar;
    tlbNewForms: TToolButton;
    tlbOpenForms: TToolButton;
    tlbSaveForms: TToolButton;
    stbarScript: TStatusBar;
    pmSetBookMark: TPopupMenu;
    pmGotoBookMark: TPopupMenu;
    ToolButton9: TToolButton;
    tlbSetBookMarkScript: TToolButton;
    tlbGotoBookMarkScript: TToolButton;
    miSetBookMark0: TMenuItem;
    miSetBookMark1: TMenuItem;
    miSetBookMark2: TMenuItem;
    miSetBookMark3: TMenuItem;
    miSetBookMark4: TMenuItem;
    miSetBookMark5: TMenuItem;
    miSetBookMark6: TMenuItem;
    miSetBookMark7: TMenuItem;
    miSetBookMark8: TMenuItem;
    miSetBookMark9: TMenuItem;
    miGotoBookMark0: TMenuItem;
    miGotoBookMark1: TMenuItem;
    miGotoBookMark2: TMenuItem;
    miGotoBookMark3: TMenuItem;
    miGotoBookMark4: TMenuItem;
    miGotoBookMark5: TMenuItem;
    miGotoBookMark6: TMenuItem;
    miGotoBookMark7: TMenuItem;
    miGotoBookMark8: TMenuItem;
    miGotoBookMark9: TMenuItem;
    Button1: TButton;
    imDefaultComp: TImage;
    pmForms: TPopupMenu;
    pnComponents: TPanel;
    pnDesignScrollBox: TPanel;
    pnScripts: TPanel;
    pnOle: TPanel;
    pnFormsLeftDock: TPanel;
    pnFormsRigthDock: TPanel;
    splFormsLeft: TSplitter;
    splFormsRigth: TSplitter;
    imlDOI: TImageList;
    ToolButton11: TToolButton;
    tlbCutForms: TToolButton;
    tlbCopyForms: TToolButton;
    tlbPasteForms: TToolButton;
    tlbDeleteForms: TToolButton;
    tlBarForms2: TToolBar;
    tlbAlignToGrid: TToolButton;
    tlbBringToFront: TToolButton;
    tlbSendToBack: TToolButton;
    ToolButton13: TToolButton;
    tlbLocks: TToolButton;
    pmLocks: TPopupMenu;
    miLocksNoDelete: TMenuItem;
    miLocksNoMove: TMenuItem;
    miLocksNoSize: TMenuItem;
    miLocksNoInsertIn: TMenuItem;
    miLocksNoCopy: TMenuItem;
    ToolButton12: TToolButton;
    tlbObjInsp: TToolButton;
    tlbAlignPallete: TToolButton;
    tlbTabOrder: TToolButton;
    tlbFormsSelectAll: TToolButton;
    tlbOptionForms: TToolButton;
    N1: TMenuItem;
    miLockClear: TMenuItem;
    tlbOptionDocs: TToolButton;
    ToolButton1: TToolButton;
    lbTypeInterface: TLabel;
    cmbTypeInterface: TComboBox;
    chbChangeFlag: TCheckBox;
    chbAutoRun: TCheckBox;
    ilTypeInterface: TImageList;
    lbPriority: TLabel;
    edPriority: TEdit;
    udPriority: TUpDown;
    imNotFound: TImage;
    pmCodeTemplate: TPopupMenu;
    ToolButton10: TToolButton;
    pmFormTemplate: TPopupMenu;
    tlbSaveToBaseScript: TToolButton;
    tlbSaveTobaseForms: TToolButton;
    tlbSaveToBaseDocuments: TToolButton;
    bibLoadInterface: TButton;
    bibSaveINterface: TButton;
    procedure edFactorChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edInnKeyPress(Sender: TObject; var Key: Char);
    procedure edInnChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bibCancelClick(Sender: TObject);
    procedure edNameChange(Sender: TObject);
    procedure meHintChange(Sender: TObject);
    procedure cmbInterpreterChange(Sender: TObject);
    procedure tlbOleOpenClick(Sender: TObject);
    procedure tlbOleSaveClick(Sender: TObject);
    procedure tlbOleNewClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pmScriptPopup(Sender: TObject);
    procedure tlbOptionScriptClick(Sender: TObject);
    procedure tlbNewScriptClick(Sender: TObject);
    procedure tlbOpenScriptClick(Sender: TObject);
    procedure tlbSaveScriptClick(Sender: TObject);
    procedure tlbUndoScriptClick(Sender: TObject);
    procedure tlbRedoScriptClick(Sender: TObject);
    procedure tlbCutScriptClick(Sender: TObject);
    procedure tlbCopyScriptClick(Sender: TObject);
    procedure tlbPasteScriptClick(Sender: TObject);
    procedure tlbDeleteScriptClick(Sender: TObject);
    procedure tlbGotoLineScriptClick(Sender: TObject);
    procedure miSetBookMark9Click(Sender: TObject);
    procedure miGotoBookMark9Click(Sender: TObject);
    procedure tlbFindScriptClick(Sender: TObject);
    procedure pcMainChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure tlbReplaceScriptClick(Sender: TObject);
    procedure ctrlBarFormsResize(Sender: TObject);
    procedure tlbNewFormsClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure pnComponentsResize(Sender: TObject);
    procedure tlbOpenFormsClick(Sender: TObject);
    procedure tlbSaveFormsClick(Sender: TObject);
    procedure pnFormsLeftDockDockDrop(Sender: TObject;
      Source: TDragDockObject; X, Y: Integer);
    procedure pnFormsLeftDockDockOver(Sender: TObject;
      Source: TDragDockObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean);
    procedure pnFormsLeftDockGetSiteInfo(Sender: TObject;
      DockClient: TControl; var InfluenceRect: TRect; MousePos: TPoint;
      var CanDock: Boolean);
    procedure pnFormsLeftDockUnDock(Sender: TObject; Client: TControl;
      NewTarget: TWinControl; var Allow: Boolean);
    procedure ctrlBarScriptBandPaint(Sender: TObject; Control: TControl;
      Canvas: TCanvas; var ARect: TRect; var Options: TBandPaintOptions);
    procedure splFormsLeftMoved(Sender: TObject);
    procedure splFormsRigthMoved(Sender: TObject);
    procedure pnFormsLeftDockResize(Sender: TObject);
    procedure tlbObjInspClick(Sender: TObject);
    procedure tlbOptionFormsClick(Sender: TObject);
    procedure tlbCutFormsClick(Sender: TObject);
    procedure tlbCopyFormsClick(Sender: TObject);
    procedure tlbPasteFormsClick(Sender: TObject);
    procedure tlbDeleteFormsClick(Sender: TObject);
    procedure tlbFormsSelectAllClick(Sender: TObject);
    procedure tlbAlignToGridClick(Sender: TObject);
    procedure tlbBringToFrontClick(Sender: TObject);
    procedure tlbSendToBackClick(Sender: TObject);
    procedure miLocksNoCopyClick(Sender: TObject);
    procedure pmLocksPopup(Sender: TObject);
    procedure miLockClearClick(Sender: TObject);
    procedure tlbAlignPalleteClick(Sender: TObject);
    procedure tlbTabOrderClick(Sender: TObject);
    procedure pmFormsPopup(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure miLocksNoMoveClick(Sender: TObject);
    procedure miLocksNoSizeClick(Sender: TObject);
    procedure miLocksNoInsertInClick(Sender: TObject);
    procedure miLocksNoDeleteClick(Sender: TObject);
    procedure tlbFindAgainScriptClick(Sender: TObject);
    procedure tlbRunScriptClick(Sender: TObject);
    procedure tlbResetScriptClick(Sender: TObject);
    procedure tlbOptionDocsClick(Sender: TObject);
    procedure cmbTypeInterfaceDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure tlbStopScriptClick(Sender: TObject);
    procedure tlbCompileScriptClick(Sender: TObject);
    procedure tlbSaveToBaseScriptClick(Sender: TObject);
    procedure tlbSaveTobaseFormsClick(Sender: TObject);
    procedure tlbSaveToBaseDocumentsClick(Sender: TObject);
    procedure cmbTypeInterfaceChange(Sender: TObject);
    procedure bibSaveINterfaceClick(Sender: TObject);
    procedure bibLoadInterfaceClick(Sender: TObject);
  private
    TPRBIGlobal: TParamRBookInterface;
    TPJIGlobal: TParamJournalInterface;
    TPWIGlobal: TParamWizardInterface;
    TPDIGlobal: TParamDocumentInterface;
    TPSIGlobal: TParamServiceInterface;
    TPRIGlobal: TParamReportInterface;
    
    PBh: THandle;
    isViewCaret: Boolean;
    ScriptEditor: TRAHLEditor;
    fmGotoLine: TfmGotoLineDialog;
    fmFindDialog: TfmFindDialog;
    fmReplaceDialog: TfmReplaceDialog;
    fmAlignPalette: TAlignPalette;
    fmTabOrders: TfmTabOrders;

    UseSetUndockBounds: Boolean;
    FInterpreterHandle: THandle;
    FCurrentLibraryInterpreter: PInfoLibraryInterpreter;

    ListInterpreterPos: TList;
    IdentiferHint: string;
    HintEx: TtsvHintEx; 

    procedure CreateBuildLog;
    procedure FreeBuildLog;
    procedure ClearListInterpreterPos;
    procedure FillInterpreters;
    procedure PrepearToolBarsEditor;
    procedure FillEditorPopUpMenu;
    procedure ViewCaret(CaretX,CaretY: Integer);
    procedure ScriptEditorChange(Sender: TObject);
    procedure ScriptEditorKeyPress(Sender: TObject; var Key: Char);
    procedure ScriptEditorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ScriptEditorKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ScriptEditorMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ScriptEditorMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ScriptEditorMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ScriptEditorSelectionChange(Sender: TObject);
    procedure ScriptEditorBookMarkChange(Sender: TObject; BookMark: Integer);
    procedure ScriptEditorStartLongOperation(Sender: TObject; vMin,vMax: Integer; vHint: string);
    procedure ScriptEditorProgressLongOperation(Sender: TObject; vProgress: Integer);
    procedure ScriptEditorFinishLongOperation(Sender: TObject);
    procedure ScriptEditorShowSource(Sender: TObject);
    procedure ScriptEditorCompletionIdentifier(Sender: TObject; var Cancel: Boolean);
    procedure ScriptEditorCommand(Sender: TObject; Command: TEditCommand);
    procedure ScriptEditorIdentiferHint(Sender: TObject; const Identifer: string; const PosBegin,PosEnd,X,Y: Integer);

    procedure LocalFindText(First: Boolean);
    procedure LocalReplaceText;
    procedure SetUndockBounds(wt: TWinControl);
    procedure DOIOnClose(Sender: TObject; var Action: TCloseAction);
    procedure DOIOnShow(Sender: TObject);
    procedure PrepearToolBarsForms;
    procedure FillFormsPopUpMenu;
    procedure DSBOnDesignCommand(Sender: TObject; DesignCommand: TDesignCommand);
    procedure DSBOnChange(Sender: TObject);
    procedure DTCOnChange(Sender: TObject);
    procedure DTCOnChanging(Sender: TObject;var AllowChange: Boolean);

    procedure DFSBOnDocumentFormCommand(Sender: TObject; DocumentFormCommand: TDocumentFormCommand);
    procedure PrepearToolBarsDocs;
    function isValidInterpreter: Boolean;
    procedure cmbInterpreterClear;
    function GetActiveLibraryInterpreter: PInfoLibraryInterpreter;
    function AddToRBooksForm(interface_id: Integer): Boolean;
    function AddToRBooksDocument(interface_id: Integer): Boolean;

    function GetTypeEditRBook: TTypeEditRBook;

    procedure SetTypeEditRBook(Value: TTypeEditRBook);
    procedure FillDesignCodeTemplates;
    procedure FillDesignFormTemplates;
    procedure MenuDesignCodeTemplateClick(Sender: TObject);
    procedure MenuDesignFormTemplateClick(Sender: TObject);

    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;

    function GetChangeFlag: Boolean;
    procedure SetChangeFlag(Value: Boolean);

    procedure SaveInterface;
    procedure SaveInterfaceToStream(Stream: TStream);
    procedure ClearAll;
    procedure LoadInterface;
    procedure LoadInterfaceFromStream(Stream: TStream);

  protected
    function AddToRBooks: Boolean; override;
    function UpdateRBooks: Boolean; override;
    function CheckFieldsFill: Boolean; override;
    procedure ShowDockPanel(APanel: TPanel; MakeVisible: Boolean;
                            Client: TControl);
    procedure ViewScriptEditorMessage(Mess: string; TypeAdditionalLogItem: TTypeAdditionalLogItem; Position: Integer);
    procedure InterpreterCreateAndRun;
    function InterpreterFree: Boolean;
    function InterpreterReset: Boolean;
    procedure ViewScript;
  public
    DFSB: TDocumentFormScrollBox;
    DSB: TDesignScrollBox;
    DOI: TDesignObjInsp;
    DTC: TDesignTabControl;
    InterfaceFile: string;
    InterfaceName: string;
    fmParent: Tform;
    oldInterface_id: Integer;
    NotChangeLoaded: Boolean;

    procedure CreateWnd; override;
    procedure AddClick(Sender: TObject); override;
    procedure ChangeClick(Sender: TObject); override;
    procedure FilterClick(Sender: TObject); override;
    procedure SetParamsFromOptions(Index: Integer);
    property InterpreterHandle: THandle read FInterpreterHandle;
    function GetInfoInterpreterPos(hLogItem: THandle): Pointer;
    procedure ViewInfoInterpreterPos(P: Pointer);
    procedure LoadFromBaseScript(interface_id: Integer);
    procedure LoadFromBaseForms(interface_id: Integer);
    procedure LoadFromBaseDocuments(interface_id: Integer);
    procedure LoadFromBaseAll(interface_id: Integer);

    procedure SaveToBaseForms;
    procedure SaveToBaseScript;
    procedure SaveToBaseDocuments;

    function GetInterpreterItemIndexByGuid(GUID: String): Integer;

    procedure SaveToIni;override;
    procedure LoadFromIni; override;

    property TypeEditRBook: TTypeEditRBook read GetTypeEditRBook write SetTypeEditRBook;
    property ChangeFlag: Boolean read GetChangeFlag write SetChangeFlag; 

{    procedure GetIdentifierProc(InterpreterHandle: THandle; PIII: PInterpreterIdentiferItem;
                                ArrPIIIC: array of PInterpreterIdentiferItemCaption);}
  end;

  TNewHotKey=class(THotKey)
  public
   property OnKeyUp;
  end;

  TNewControlBar=class(TControlBar)
  public
    procedure PaintControlFrame(Canvas: TCanvas; AControl: TControl;  var ARect: TRect); override;
  end;

var
  fmEditRBInterface: TfmEditRBInterface;

implementation

uses UDesignTsvCode, UDesignTsvData, UDesignTsvOptions, tsvFontBox, tsvColorBox,
     URBInterface, tsvInterbase;

{$R *.DFM}

type
  PInfoInterpreterPos=^TInfoInterpreterPos;
  TInfoInterpreterPos=packed record
    hLogItem: THandle;
    Position: Integer;
  end;


{ TNewControlBar }

procedure TNewControlBar.PaintControlFrame(Canvas: TCanvas; AControl: TControl;  var ARect: TRect);
begin

end;

procedure TfmEditRBInterface.FilterClick(Sender: TObject);
begin
  if fsModal in FormState then
   ModalResult:=mrOk
  else Close;
end;

procedure TfmEditRBInterface.SaveToBaseForms;
begin
  if TypeEditRBook<>terbChange then exit;
  Screen.Cursor:=crHourGlass;
  try
     IBTran.Active:=true;
     AddToRBooksForm(oldInterface_id);
     IBTran.Commit;
     tlbSaveTobaseForms.Enabled:=false;
  finally
    Screen.Cursor:=crDefault;
  end; 
end;

procedure TfmEditRBInterface.SaveToBaseDocuments;
begin
  if TypeEditRBook<>terbChange then exit;
  Screen.Cursor:=crHourGlass;
  try
     IBTran.Active:=true;
     AddToRBooksDocument(oldInterface_id);
     IBTran.Commit;
     tlbSaveToBaseDocuments.Enabled:=false;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TfmEditRBInterface.SaveToBaseScript;
var
  tb: TIBTable;
  id: string;
  ms: TMemoryStream;
begin
 if TypeEditRBook<>terbChange then exit;
 try
  Screen.Cursor:=crHourGlass;
  tb:=TIBTable.Create(nil);
  ms:=TMemoryStream.Create;
  try
    tb.Database:=IBDB;
    tb.Transaction:=ibtran;
    tb.Transaction.Active:=true;
    id:=inttostr(oldInterface_id);
    tb.TableName:=AnsiUpperCase(tbInterface);
    tb.Filter:=' interface_id='+id;
    tb.Filtered:=true;
    tb.Active:=true;
    tb.Locate('interface_id',id,[LocaseInsensitive]);
    tb.Edit;

    ms.Clear;
    DSB.PackMethods;
    ScriptEditor.Lines.SaveToStream(ms);
    ms.Position:=0;
    TBlobField(tb.FieldByName('code')).LoadFromStream(ms);

    tb.Post;
    tb.Transaction.Commit;
    
    tlbSaveToBaseScript.Enabled:=false;

  finally
    ms.Free;
    tb.Free;
    Screen.Cursor:=crDefault;
  end;
 except
  on E: EIBInterBaseError do begin
    TempStr:=TranslateIBError(E.Message);
    ShowErrorEx(TempStr);
    Assert(false,TempStr);
  end;
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message);{$ENDIF}
 end;
end;

function TfmEditRBInterface.AddToRBooksForm(interface_id: Integer): Boolean;
var
  i: Integer;
  tb: TIBTable;
  ms: TMemoryStream;
  fm: TDesignForm;
  id: string;
begin
 Result:=false;
 try
  ms:=TMemoryStream.Create;
  tb:=TIBTable.Create(nil);
  try
    tb.Database:=IBDB;
    tb.Transaction:=ibtran;
    tb.Transaction.Active:=true;
    ExecSql(IBDB,'Delete from '+tbInterfaceForm+' where interface_id='+inttostr(interface_id));
    for i:=0 to DSB.ListForms.Count-1 do begin
      fm:=DSB.ListForms.Items[i];
      
      id:=inttostr(GetGenId(IBDB,tbInterfaceForm,1));
      tb.Active:=false;
      tb.tablename:=AnsiUpperCase(tbInterfaceForm);
      tb.Active:=true;
      tb.Filter:=' interfaceform_id='+id+' ';
      tb.Filtered:=true;
      tb.Transaction.Active:=true;
      tb.Append;
      tb.FieldByName('interfaceform_id').AsString:=id;
      tb.FieldByName('interface_id').AsInteger:=interface_id;
      tb.FieldByName('name').AsString:=Trim(fm.Name);
      tb.FieldByName('hint').Value:=Iff(Trim(fm.Hint)<>'',Trim(fm.Hint),Null);

      ms.Clear;
      fm.SaveToStream(ms);
      ms.Position:=0;
      TBlobField(tb.FieldByName('form')).LoadFromStream(ms);

      tb.Post;
    end;
    Result:=true;
  finally
   tb.Free;
   ms.Free;
  end;
 except
  on E: EIBInterBaseError do begin
    TempStr:=TranslateIBError(E.Message);
    ShowErrorEx(TempStr);
    Assert(false,TempStr);
  end;
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

function TfmEditRBInterface.AddToRBooksDocument(interface_id: Integer): Boolean;
var
  i: Integer;
  tb: TIBTable;
  ms: TMemoryStream;
  fm: TDocumentForm;
  id: string;
begin
 Result:=false;
 try
  ms:=TMemoryStream.Create;
  tb:=TIBTable.Create(nil);
  try
    tb.Database:=IBDB;
    tb.Transaction:=ibtran;
    tb.Transaction.Active:=true;
    ExecSql(IBDB,'Delete from '+tbInterfaceDocument+' where interface_id='+inttostr(interface_id));
    for i:=0 to DFSB.ListForms.Count-1 do begin
      fm:=DFSB.ListForms.Items[i];
      
      id:=inttostr(GetGenId(IBDB,tbInterfaceDocument,1));
      tb.Active:=false;
      tb.tablename:=AnsiUpperCase(tbInterfaceDocument);
      tb.Active:=true;
      tb.Filter:=' interfacedocument_id='+id+' ';
      tb.Filtered:=true;
      tb.Transaction.Active:=true;
      tb.Append;
      tb.FieldByName('interfacedocument_id').AsString:=id;
      tb.FieldByName('interface_id').AsInteger:=interface_id;
      tb.FieldByName('name').AsString:=Trim(fm.edName.Text);
      tb.FieldByName('hint').Value:=Iff(Trim(fm.meHint.Lines.text)<>'',Trim(fm.meHint.Lines.text),Null);
      tb.FieldByName('oleclass').AsString:=Trim(fm.edOleClass.Text);

      ms.Clear;
      fm.SaveToStream(ms);
      ms.Position:=0;
      TBlobField(tb.FieldByName('document')).LoadFromStream(ms);

      tb.Post;
    end;
    Result:=true;
  finally
   tb.Free;
   ms.Free;
  end;
 except
  on E: EIBInterBaseError do begin
    TempStr:=TranslateIBError(E.Message);
    ShowErrorEx(TempStr);
    Assert(false,TempStr);
  end;
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

function TfmEditRBInterface.AddToRBooks: Boolean;
var
  tb: TIBTable;
  id: string;
  ms: TMemoryStream;
  sqls: string;
begin
 Result:=false;
 try
  Screen.Cursor:=crHourGlass;
  tb:=TIBTable.Create(nil);
  ms:=TMemoryStream.Create;
  try
    tb.Database:=IBDB;
    tb.Transaction:=ibtran;
    tb.Transaction.Active:=true;
    id:=inttostr(GetGenId(IBDB,tbInterface,1));
    tb.TableName:=AnsiUpperCase(tbInterface);
    tb.Filter:=' interface_id='+id;
    tb.Filtered:=true;
    tb.Active:=true;
    tb.Append;
    tb.FieldByName('interface_id').AsString:=id;
    tb.FieldByName('name').AsString:=Trim(edName.Text);
    tb.FieldByName('hint').Value:=Iff(Trim(meHint.Lines.Text)<>'',Trim(meHint.Lines.Text),Null);
    tb.FieldByName('interfacetype').AsInteger:=cmbTypeInterface.ItemIndex;
    tb.FieldByName('changeflag').AsInteger:=Integer(chbChangeFlag.Checked);
    tb.FieldByName('autoflag').AsInteger:=Integer(chbAutoRun.Checked);
    tb.FieldByName('interpreterguid').AsString:=GetActiveLibraryInterpreter.GUID;
    tb.FieldByName('priority').AsInteger:=udPriority.Position;

    ms.Clear;
    DSB.PackMethods;
    ScriptEditor.Lines.SaveToStream(ms);
    ms.Position:=0;
    TBlobField(tb.FieldByName('code')).LoadFromStream(ms);

    tb.Post;

    if not AddToRBooksForm(strtoint(id)) then exit;
    if not AddToRBooksDocument(strtoint(id)) then exit;

    tb.Transaction.Commit;
    oldInterface_id:=strtoint(id);

    if fmParent<>nil then begin
      TfmRBInterface(fmParent).IBUpd.InsertSQL.Clear;
      TfmRBInterface(fmParent).IBUpd.InsertSQL.Add(sqls);

      with TfmRBInterface(fmParent).MainQr do begin
        Insert;
        FieldByName('interface_id').AsInteger:=oldInterface_id;
        FieldByName('name').AsString:=Trim(edName.Text);
        FieldByName('hint').Value:=Iff(Trim(meHint.Lines.Text)<>'',Trim(meHint.Lines.Text),Null);
        FieldByName('interfacetype').AsInteger:=cmbTypeInterface.ItemIndex;
        FieldByName('changeflag').AsInteger:=Integer(chbChangeFlag.Checked);
        FieldByName('interpreterguid').AsString:=GetActiveLibraryInterpreter.GUID;
        FieldByName('autoflag').AsInteger:=Integer(chbAutoRun.Checked);
        FieldByName('priority').AsInteger:=udPriority.Position;
        Post;
      end;

      TfmRBInterface(fmParent).Locate('interface_id',oldInterface_id,[loCaseInsensitive]);
    end;

    Result:=true;
  finally
    ms.Free;
    tb.Free;
    Screen.Cursor:=crDefault;
  end;
 except
  on E: EIBInterBaseError do begin
    TempStr:=TranslateIBError(E.Message);
    ShowErrorEx(TempStr);
    Assert(false,TempStr);
  end;
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmEditRBInterface.AddClick(Sender: TObject);
begin
  if not CheckFieldsFill then exit;
  if not AddToRBooks then exit;
  ModalResult:=mrOk;
  Close;
end;

function TfmEditRBInterface.UpdateRBooks: Boolean;
var
  tb: TIBTable;
  id: string;
  ms: TMemoryStream;
  sqls: string;
begin
 Result:=false;
 try
  Screen.Cursor:=crHourGlass;
  tb:=TIBTable.Create(nil);
  ms:=TMemoryStream.Create;
  try
    tb.Database:=IBDB;
    tb.Transaction:=ibtran;
    tb.Transaction.Active:=true;
    id:=inttostr(oldInterface_id);
    tb.TableName:=AnsiUpperCase(tbInterface);
    tb.Filter:=' interface_id='+id;
    tb.Filtered:=true;
    tb.Active:=true;
    tb.Locate('interface_id',id,[LocaseInsensitive]);
    tb.Edit;
    tb.FieldByName('interface_id').AsString:=id;
    tb.FieldByName('name').AsString:=Trim(edName.Text);
    tb.FieldByName('hint').Value:=Iff(Trim(meHint.Lines.Text)<>'',Trim(meHint.Lines.Text),Null);
    tb.FieldByName('interfacetype').AsInteger:=cmbTypeInterface.ItemIndex;
    tb.FieldByName('changeflag').AsInteger:=Integer(chbChangeFlag.Checked);
    tb.FieldByName('autoflag').AsInteger:=Integer(chbAutoRun.Checked);
    tb.FieldByName('interpreterguid').AsString:=GetActiveLibraryInterpreter.GUID;
    tb.FieldByName('priority').AsInteger:=udPriority.Position;

    ms.Clear;
    DSB.PackMethods;
    ScriptEditor.Lines.SaveToStream(ms);
    ms.Position:=0;
    TBlobField(tb.FieldByName('code')).LoadFromStream(ms);

    tb.Post;

    if not AddToRBooksForm(strtoint(id)) then exit;
    if not AddToRBooksDocument(strtoint(id)) then exit;

    tb.Transaction.Commit;
    oldInterface_id:=strtoint(id);

    if fmParent<>nil then begin
      TfmRBInterface(fmParent).IBUpd.ModifySQL.Clear;
      TfmRBInterface(fmParent).IBUpd.ModifySQL.Add(sqls);

      with TfmRBInterface(fmParent).MainQr do begin
        Edit;
        FieldByName('interface_id').AsInteger:=oldInterface_id;
        FieldByName('name').AsString:=Trim(edName.Text);
        FieldByName('hint').Value:=Iff(Trim(meHint.Lines.Text)<>'',Trim(meHint.Lines.Text),Null);
        FieldByName('interfacetype').AsInteger:=cmbTypeInterface.ItemIndex;
        FieldByName('changeflag').AsInteger:=Integer(chbChangeFlag.Checked);
        FieldByName('interpreterguid').AsString:=GetActiveLibraryInterpreter.GUID;
        FieldByName('autoflag').AsInteger:=Integer(chbAutoRun.Checked);
        FieldByName('priority').AsInteger:=udPriority.Position;
        Post;
      end;

      TfmRBInterface(fmParent).Locate('interface_id',oldInterface_id,[loCaseInsensitive]);
    end;

    Result:=true;
  finally
    ms.Free;
    tb.Free;
    Screen.Cursor:=crDefault;
  end;
 except
  on E: EIBInterBaseError do begin
    TempStr:=TranslateIBError(E.Message);
    ShowErrorEx(TempStr);
    Assert(false,TempStr);
  end;
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message);{$ENDIF}
 end;
end;

procedure TfmEditRBInterface.ChangeClick(Sender: TObject);
begin
  if ChangeFlag then begin
   if not CheckFieldsFill then exit;
   if not UpdateRBooks then exit;
  end;
  ModalResult:=mrOk;
  Close;
end;

function TfmEditRBInterface.CheckFieldsFill: Boolean;
begin
  Result:=true;
  if trim(edName.Text)='' then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[lbName.Caption]));
    pcMain.ActivePage:=tbsAll;
    edName.SetFocus;
    Result:=false;
    exit;
  end;
  if cmbTypeInterface.ItemIndex=-1 then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[lbTypeInterface.Caption]));
    pcMain.ActivePage:=tbsAll;
    cmbTypeInterface.SetFocus;
    Result:=false;
    exit;
  end;
  if cmbInterpreter.ItemIndex=-1 then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[lbInterpreter.Caption]));
    pcMain.ActivePage:=tbsAll;
    cmbInterpreter.SetFocus;
    Result:=false;
    exit;
  end else if GetActiveLibraryInterpreter=nil then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[lbInterpreter.Caption]));
    pcMain.ActivePage:=tbsAll;
    cmbInterpreter.SetFocus;
    Result:=false;
    exit;
  end;
  if trim(ScriptEditor.Lines.Text)='' then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[tbsScript.Caption]));
    pcMain.ActivePage:=tbsScript;
    ScriptEditor.SetFocus;
    Result:=false;
    exit;
  end;
end;

procedure TfmEditRBInterface.edFactorChange(Sender: TObject);
begin
  inherited;
  ChangeFlag:=true;
end;

procedure TfmEditRBInterface.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  Left:=0;
  Top:=0;

  ListEditInterfaceForms.Add(self);
  ListInterpreterPos:=TList.Create;

  IBTran.AddDatabase(IBDB);
  IBDB.AddTransaction(IBTran);

  cmbTypeInterface.Clear;
  for i:=0 to 7 do
    cmbTypeInterface.Items.Add(GetTypeInterfaceByIndex(i));
  cmbTypeInterface.ItemIndex:=0;
  cmbTypeInterface.ItemHeight:=ilTypeInterface.Height+2;

  edName.MaxLength:=DomainNameLength;
  meHint.MaxLength:=DomainNoteLength;

  PBh:=0;

  DFSB:=TDocumentFormScrollBox.Create(nil);
  DFSB.Align:=alClient;
  DFSB.Parent:=pnOle;
  DFSB.Color:=clWindow;
  DFSB.OnDocumentFormCommand:=DFSBOnDocumentFormCommand;

  tlbOleNew.Tag:=Integer(dfcNewDocument);
  tlbOleOpen.Tag:=Integer(dfcOpenDocument);
  tlbOleSave.Tag:=Integer(dfcSaveDocument);
  tlbSaveToBaseDocuments.Tag:=Integer(dfcSaveToBaseDocuments);
  tlbOptionDocs.Tag:=Integer(dfcViewOption);
  
  PrepearToolBarsDocs;

  FillInterpreters;

  ScriptEditor:=TRAHLEditor.Create(nil);
  ScriptEditor.Parent:=pnScripts;
  ScriptEditor.Align:=alClient;
  ScriptEditor.GutterWidth:=30;
  ScriptEditor.ShowHint:=true;
  ScriptEditor.PopupMenu:=pmScript;
  ScriptEditor.OnChange:=ScriptEditorChange;
  ScriptEditor.OnKeyPress:=ScriptEditorKeyPress;
  ScriptEditor.OnKeyDown:=ScriptEditorKeyDown;
  ScriptEditor.OnKeyUp:=ScriptEditorKeyUp;
  ScriptEditor.OnMouseDown:=ScriptEditorMouseDown;
  ScriptEditor.OnMouseUp:=ScriptEditorMouseUp;
  ScriptEditor.OnMouseMove:=ScriptEditorMouseMove;
  ScriptEditor.OnSelectionChange:=ScriptEditorSelectionChange;
  ScriptEditor.OnDblClick:=ScriptEditorSelectionChange;
  ScriptEditor.OnBookMarkChange:=ScriptEditorBookMarkChange;
  ScriptEditor.OnStartLongOperation:=ScriptEditorStartLongOperation;
  ScriptEditor.OnProgressLongOperation:=ScriptEditorProgressLongOperation;
  ScriptEditor.OnFinishLongOperation:=ScriptEditorFinishLongOperation;
  ScriptEditor.OnShowSource:=ScriptEditorShowSource;
  ScriptEditor.OnCompletionIdentifer:=ScriptEditorCompletionIdentifier;
  ScriptEditor.OnCommand:=ScriptEditorCommand;
  ScriptEditor.OnIdentiferHint:=ScriptEditorIdentiferHint;

  tlbNewScript.Tag:=ecNewScript;
  tlbOpenScript.Tag:=ecOpenScript;
  tlbSaveScript.Tag:=ecSaveScript;
  tlbSaveToBaseScript.Tag:=ecSaveScriptToBase;
  tlbUndoScript.Tag:=ecUndo;
  tlbRedoScript.Tag:=ecRedo;
  tlbCutScript.Tag:=ecClipboardCut;
  tlbCopyScript.Tag:=ecClipboardCopy;
  tlbPasteScript.Tag:=ecClipBoardPaste;
  tlbDeleteScript.Tag:=ecDeleteSelected;
  tlbRunScript.Tag:=ecRunScript;
  tlbStopScript.Tag:=ecStopScript;
  tlbResetScript.Tag:=ecResetScript;
  tlbCompileScript.Tag:=ecCompileScript;
  tlbFindScript.Tag:=ecFind;
  tlbReplaceScript.Tag:=ecReplace;
  tlbFindAgainScript.Tag:=ecFindNext;
  tlbGotoLineScript.Tag:=ecGotoLine;
  tlbOptionScript.Tag:=ecViewOption;

  PrepearToolBarsEditor;

  fmGotoLine:=TfmGotoLineDialog.Create(nil);
  fmFindDialog:=TfmFindDialog.Create(nil);
  fmReplaceDialog:=TfmReplaceDialog.Create(nil);
  fmAlignPalette:=TAlignPalette.Create(nil);
  fmTabOrders:=TfmTabOrders.Create(nil);

  DOI:=TDesignObjInsp.CreateNew(Self);
  pnFormsLeftDock.Width:=DOI.Width;
  DOI.ManualDock(pnFormsLeftDock);
  SetUndockBounds(pnFormsLeftDock);
  DOI.Visible:=true;
  DOI.OnClose:=DOIOnClose;
  DOI.OnShow:=DOIOnShow;
  DOI.ImageList:=imlDOI;
  DOI.Translated:=false;
  DOI.PanelHintVisible:=true;
  DOI.Sorted:=false;
  DOI.FillDesignPropertyTranslates;
  DOI.FillDesignPropertyRemoves;
  UseSetUndockBounds:=true;

  DTC:=TDesignTabControl.Create(Self);
  DTC.Parent:=pnComponents;
  DTC.TabHeight:=15;
  DTC.Align:=alNone;
  DTC.OnChange:=DTCOnChange;
  DTC.OnChanging:=DTCOnChanging;
  DTC.DefaultBitmap.Assign(imDefaultComp.Picture.Bitmap);
  DTC.NotExistsBitmap.Assign(imNotFound.Picture.Bitmap);
  DTC.FillDesignPalettes(ttiNone);
  DTC.Visible:=DTC.Tabs.Count>0;

  tlbNewForms.Tag:=Integer(dkcNewForm);
  tlbOpenForms.Tag:=Integer(dkcOpenForm);
  tlbSaveForms.Tag:=Integer(dkcSaveForm);
  tlbSaveTobaseForms.Tag:=Integer(dkcSaveFormsToBase);
  tlbCutForms.Tag:=Integer(dkcCutComponents);
  tlbCopyForms.Tag:=Integer(dkcCopyComponents);
  tlbPasteForms.Tag:=Integer(dkcPasteComponents);
  tlbDeleteForms.Tag:=Integer(dkcDeleteComponents);
  tlbFormsSelectAll.Tag:=Integer(dkcSelectAllComponents);
  tlbAlignToGrid.Tag:=Integer(dkcAlignToGridComponents);
  tlbBringToFront.Tag:=Integer(dkcBringToFrontComponents);
  tlbSendToBack.Tag:=Integer(dkcSendToBackComponents);
  tlbObjInsp.Tag:=Integer(dkcViewObjInsp);
  tlbAlignPallete.Tag:=Integer(dkcViewAlignPalette);
  tlbTabOrder.Tag:=Integer(dkcViewTabOrder);
  tlbOptionForms.Tag:=Integer(dkcViewOptions);

  DSB:=TDesignScrollBox.Create(Self);
  DSB.Editor:=ScriptEditor;
  DSB.DesignTabControl:=DTC;
  DSB.DesignObjInsp:=DOI;
  DSB.Parent:=pnDesignScrollBox;
  DSB.Align:=alClient;
  DSB.ActiveDesign:=true;
  DSB.Color:=clWindow;
  DSB.DesignPopupMenu:=pmForms;
  DSB.OnDesignCommand:=DSBOnDesignCommand;
  DSB.OnChange:=DSBOnChange;

  PrepearToolBarsForms;
  
  fmAlignPalette.SetLocalDSB(DSB);

  splFormsLeft.Cursor:=crSizeLR;
  splFormsRigth.Cursor:=crSizeLR;

  pcMain.ActivePage:=tbsAll;

  CreateBuildLog;

  FillDesignCodeTemplates;
  FillDesignFormTemplates;

  SetParamsFromOptions(0);
  SetParamsFromOptions(1);

  HintEx:=TtsvHintEx.Create(nil);
  HintEx.Direction:=bdHorzIn;
  HintEx.StartColor:=clWhite;
  HintEx.EndColor:=clBtnFace;
  HintEx.Brush.Color:=clInfoBk;
  HintEx.Pen.Color:=clBlack;
  HintEx.Pen.Style:=psSolid;
  HintEx.Alignment:=taCenter;
  HintEx.Control:=ScriptEditor;
end;

procedure FillGetDesignCodeTemplateProc(Owner: Pointer; PGDCT: PGetDesignCodeTemplate);stdcall;
var
  mi: TMenuItem;
begin
  if not isValidPointer(Owner) then exit;
  if not isValidPointer(PGDCT) then exit;
  mi:=TMenuItem.Create(nil);
  mi.Caption:=PGDCT.Name;
  mi.Hint:=PGDCT.Hint;
  mi.OnClick:=TfmEditRBInterface(Owner).MenuDesignCodeTemplateClick;
  TfmEditRBInterface(Owner).pmCodeTemplate.Items.Add(mi);
end;

procedure TfmEditRBInterface.FillDesignCodeTemplates;
begin
  pmCodeTemplate.Items.Clear;
  _GetDesignCodeTemplates(Self,FillGetDesignCodeTemplateProc);
end;

procedure TfmEditRBInterface.MenuDesignCodeTemplateClick(Sender: TObject);
var
  Code: PChar;
  str: TStringList;
  i: Integer;
begin
  if Sender is TMenuItem then begin
    Code:=_GetDesignCodeTemplateCodeByName(PChar(TMenuItem(Sender).Caption));
    if Code<>nil then begin
     str:=TStringList.Create;
     try
       str.SetText(Code);
       for i:=0 to str.Count-1 do begin
        ScriptEditor.Lines.Insert(ScriptEditor.CaretY+i,str.Strings[i]);
       end;
     finally
      str.Free;
     end;
    end;
  end;
end;

procedure FillGetDesignFormTemplateProc(Owner: Pointer; PGDFT: PGetDesignFormTemplate);stdcall;
var
  mi: TMenuItem;
begin
  if not isValidPointer(Owner) then exit;
  if not isValidPointer(PGDFT) then exit;
  mi:=TMenuItem.Create(nil);
  mi.Caption:=PGDFT.Name;
  mi.Hint:=PGDFT.Hint;
  mi.OnClick:=TfmEditRBInterface(Owner).MenuDesignFormTemplateClick;
  TfmEditRBInterface(Owner).pmFormTemplate.Items.Add(mi);
end;

procedure TfmEditRBInterface.FillDesignFormTemplates;
begin
  pmFormTemplate.Items.Clear;
  _GetDesignFormTemplates(Self,FillGetDesignFormTemplateProc);
end;

procedure TfmEditRBInterface.MenuDesignFormTemplateClick(Sender: TObject);
var
  Form: PChar;
  ms: TMemoryStream;
  fm: TDesignForm;
begin
  if Sender is TMenuItem then begin
    Form:=_GetDesignFormTemplateFormByName(PChar(TMenuItem(Sender).Caption));
    if Form<>nil then begin
      ms:=TMemoryStream.Create;
      try
       ms.Write(Pointer(Form)^,Length(Form));
       ms.Position:=0;
       fm:=DSB.CreateDesignForm(true);
       try
        fm.LoadFromStream(ms);
       except
        on E: Exception do begin
          fm.Free;
          ShowErrorEx(E.Message);
        end; 
       end; 
      finally
       ms.Free; 
      end; 
    end;
  end;
end;

procedure TfmEditRBInterface.CreateBuildLog;
var
  TCAL: TCreateAdditionalLog;
begin
  if not _isValidAdditionalLog(hAdditionalLogBuild) then begin
   FillChar(TCAL,SizeOf(TCAL),0);
   TCAL.Name:=ConstBuildLogName;
   TCAL.Hint:=ConstBuildLogHint;
   TCAL.Limit:=10;
   hAdditionalLogBuild:=_CreateAdditionalLog(@TCAL);
  end; 
end;

procedure TfmEditRBInterface.FreeBuildLog;
begin
  if ListEditInterfaceForms.Count=0 then
   _FreeAdditionalLog(hAdditionalLogBuild);
end;

procedure TfmEditRBInterface.PrepearToolBarsDocs;

  procedure LocalPrepearTB(tb: TToolBar);
  var
    i: Integer;
    bt: TToolButton;
    dfc: TDocumentFormCommand;
  begin
    for i:=0 to tb.ButtonCount-1 do begin
     bt:=tb.Buttons[i];
     dfc:=TDocumentFormCommand(bt.Tag);
     bt.Caption:=GetHintDocumentFormCommand(dfc,bt.Caption);
     bt.Hint:=GetHintWithShortCutFromDocumentFormCommand(DFSB,dfc,bt.Caption);
    end;
  end;

begin
  LocalPrepearTB(tlBarOle);
end;

procedure TfmEditRBInterface.edInnKeyPress(Sender: TObject; var Key: Char);
begin
  if (not (Key in ['0'..'9']))and((Integer(Key)<>VK_Back)) then Key:=#0;
end;

procedure TfmEditRBInterface.edInnChange(Sender: TObject);
begin
  ChangeFlag:=true;
end;

procedure TfmEditRBInterface.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action:=caFree;
end;

procedure TfmEditRBInterface.bibCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
  Close;
end;

procedure TfmEditRBInterface.edNameChange(Sender: TObject);
begin
  inherited;
  ChangeFlag:=true;
  case TypeEditRBook of
     terbAdd: begin
      if Trim(edName.text)<>'' then
       Caption:=CaptionAdd+Format(' ����� ��������� <%s>',[edName.text])
      else Caption:=CaptionAdd+' ����� ���������';
     end;
  end;
end;

procedure TfmEditRBInterface.meHintChange(Sender: TObject);
begin
  inherited;
  ChangeFlag:=true;
end;

procedure TfmEditRBInterface.cmbInterpreterChange(Sender: TObject);
var
  P: PInfoLibraryInterpreter;
begin
  inherited;
  ChangeFlag:=true;
  if isValidInterpreter then begin
    P:=GetActiveLibraryInterpreter;
    DSB.CreateInterfaceProcName:=P.GetCreateInterfaceNameProc;
  end; 
end;

procedure TfmEditRBInterface.tlbOleOpenClick(Sender: TObject);
begin
  DFSB.RunDocumentFormCommand(nil,dfcOpenDocument);
end;

procedure TfmEditRBInterface.tlbOleSaveClick(Sender: TObject);
begin
  DFSB.RunDocumentFormCommand(nil,dfcSaveDocument);
end;

procedure TfmEditRBInterface.tlbOleNewClick(Sender: TObject);
begin
  DFSB.RunDocumentFormCommand(nil,dfcNewDocument);
end;

procedure TfmEditRBInterface.ClearListInterpreterPos;
var
  i: Integer;
  P: PInfoInterpreterPos;
begin
  for i:=0 to ListInterpreterPos.Count-1 do begin
    P:=ListInterpreterPos.Items[i];
    if P.hLogItem<>ADDITIONALLOGITEM_INVALID_HANDLE then begin
     _FreeAdditionalLogItem(P.hLogItem);
    end;
    Dispose(P);
  end;
  ListInterpreterPos.Clear;
  _ViewAdditionalLog(hAdditionalLogBuild,false);
end;

procedure TfmEditRBInterface.FormDestroy(Sender: TObject);
begin
  inherited;
  SaveToIni;
  HintEx.Free;
  _FreeProgressBar(PBh);
  DSB.ActiveDesign:=false;
  FreeAndNil(DOI);
  DSB.Free;
  FreeAndNil(DTC);
  DFSB.Free;
  fmTabOrders.FRee;
  fmAlignPalette.Free;
  fmReplaceDialog.Free;
  fmFindDialog.Free;
  fmGotoLine.Free;
  ScriptEditor.Free;
  InterpreterFree;
  ClearListInterpreterPos;
  ListInterpreterPos.Free;
  cmbInterpreterClear;
  ListEditInterfaceForms.Remove(self);
  FreeBuildLog;
end;

procedure GetLibraryInterpreterProc(Owner: Pointer; PGLI: PGetLibraryInterpreter); stdcall;
var
  P: PInfoLibraryInterpreter;
begin
  if not isValidPointer(PGLI,SizeOf(TGetLibraryInterpreter)) then exit;
  New(P);
  FillChar(P^,SizeOf(P^),0);
  P.hLibraryInterpreter:=_GetLibraryInterpreterHandleByGUID(PGLI.GUID);
  P.GUID:=PGLI.GUID;
  P.Hint:=PGLI.Hint;
  P.CreateProc:=PGLI.CreateProc;
  P.RunProc:=PGLI.RunProc;
  P.ResetProc:=PGLI.ResetProc;
  P.FreeProc:=PGLI.FreeProc;
  P.IsValidProc:=PGLI.IsValidProc;
  P.SetParamsProc:=PGLI.SetParamsProc;
  P.GetCreateInterfaceNameProc:=PGLI.GetCreateInterfaceNameProc;
  P.GetInterpreterIdentifersProc:=PGLI.GetInterpreterIdentifersProc;
  TfmEditRBInterface(Owner).cmbInterpreter.Items.AddObject(PGLI.Hint,TObject(P));
end;

procedure TfmEditRBInterface.cmbInterpreterClear;
var
  i: Integer;
  P: PInfoLibraryInterpreter;
begin
  for i:=0 to cmbInterpreter.Items.Count-1 do begin
    P:=PInfoLibraryInterpreter(cmbInterpreter.Items.Objects[i]);
    Dispose(P);
  end;
  cmbInterpreter.Clear;
end;

procedure TfmEditRBInterface.FillInterpreters;
begin
 cmbInterpreter.Items.BeginUpdate;
 try
  cmbInterpreterClear;
  _GetLibraryInterpreters(Self,GetLibraryInterpreterProc);
 finally
  cmbInterpreter.Items.EndUpdate;
  if cmbInterpreter.Items.Count>0 then
    cmbInterpreter.ItemIndex:=0;
 end;
end;

procedure TfmEditRBInterface.PrepearToolBarsEditor;

  procedure LocalPrepearTB(tb: TToolBar);
  var
    i: Integer;
    bt: TToolButton;
  begin
    for i:=0 to tb.ButtonCount-1 do begin
     bt:=tb.Buttons[i];
     bt.Caption:=GetHintScriptCommand(bt.tag,bt.Caption);
     bt.Hint:=GetHintWithShortCutScriptCommand(ScriptEditor,bt.Tag,bt.Caption);
    end;
  end;

begin
  LocalPrepearTB(tlBarScript);
end;

procedure TfmEditRBInterface.FillEditorPopUpMenu;

   procedure AddChildMenu(miParent: TmenuItem; Items: TMenuItem);
   var
     mi: TMenuItem;
     i: Integer;
   begin
     for i:=0 to Items.Count-1 do begin
       mi:=TMenuItem.Create(Self);
       mi.Caption:=Items[i].Caption;
       mi.Hint:=Items[i].Hint;
       mi.ImageIndex:=Items[i].ImageIndex;
       mi.Enabled:=Items[i].Enabled;
       mi.Checked:=Items[i].Checked;
       mi.Visible:=Items[i].Visible;
       mi.RadioItem:=Items[i].RadioItem;
       mi.GroupIndex:=Items[i].GroupIndex;
       mi.OnClick:=Items[i].OnClick;
       mi.Tag:=Items[i].Tag;
       miParent.Add(mi);
     end;
   end;

var
  i: Integer;
  mi: TMenuItem;
  bt: TToolButton;
begin
  pmScript.Items.Clear;
  for i:=0 to tlBarScript.ButtonCount-1 do begin
    bt:=tlBarScript.Buttons[i];
    mi:=TMenuItem.Create(Self);
    case bt.Style of
      tbsButton: mi.Caption:=bt.Caption;
      tbsSeparator: mi.Caption:='-';
      tbsDropDown:  mi.Caption:=bt.Caption;
    end;
    if bt.DropdownMenu<>nil then begin
      AddChildMenu(mi,bt.DropdownMenu.Items);
    end;
    mi.Hint:=bt.Hint;
    mi.ImageIndex:=bt.ImageIndex;
    mi.Enabled:=bt.Enabled;
    mi.Visible:=bt.Visible;
    if (bt.Style<>tbsDropDown) then begin
      mi.OnClick:=bt.OnClick;
      mi.ShortCut:=GetShortCutScriptEditor(ScriptEditor,bt.tag);
    end else if bt.DropdownMenu<>nil then
       if bt.DropdownMenu.Items.Count=0 then begin
        mi.OnClick:=bt.OnClick;
        mi.ShortCut:=GetShortCutScriptEditor(ScriptEditor,bt.tag);
       end;
    pmScript.Items.Add(mi);
  end;
end;

function TfmEditRBInterface.GetTypeEditRBook: TTypeEditRBook;
begin
  Result:=inherited TypeEditRBook;
end;

procedure TfmEditRBInterface.SetTypeEditRBook(Value: TTypeEditRBook);
begin
  if (inherited TypeEditRBook)<>Value then begin
    case Value of
      terbAdd: begin
        pnMain.Align:=alClient;
        Caption:=CaptionAdd+Format(' ����� ���������',[]);
        tlbSaveToBaseScript.Enabled:=false;
        tlbSaveTobaseForms.Enabled:=false;
        tlbSaveToBaseDocuments.Enabled:=false;
      end;
      terbChange: begin
        pnMain.Align:=alClient;
        Caption:=CaptionChange+Format(' ��������� <%s>',[InterfaceName]);
        tlbSaveToBaseScript.Enabled:=true;
        tlbSaveTobaseForms.Enabled:=true;
        tlbSaveToBaseDocuments.Enabled:=true;
      end;
      terbView: begin
        pnMain.Align:=alClient;
        Caption:=CaptionView+Format(' �� ���������� <%s>',[InterfaceName]);
        tlbSaveToBaseScript.Enabled:=false;
        tlbSaveTobaseForms.Enabled:=false;
        tlbSaveToBaseDocuments.Enabled:=false;
        bibLoadInterface.Visible:=false;
        bibSaveInterface.Visible:=false;
      end;
      terbFilter: begin
        cbInString.Left:=8;
        cbInString.Top:=ClientHeight-pnBut.Height-cbInString.Height+3;
        Caption:=CaptionFilter;
        tlbSaveToBaseScript.Enabled:=false;
        tlbSaveTobaseForms.Enabled:=false;
        tlbSaveToBaseDocuments.Enabled:=false;
        bibLoadInterface.Visible:=false;
        bibSaveInterface.Visible:=false;
      end;
    end;
    inherited TypeEditRBook:=Value;
  end;
end;

procedure TfmEditRBInterface.pmScriptPopup(Sender: TObject);
begin
  FillEditorPopUpMenu;
end;

procedure TfmEditRBInterface.tlbOptionScriptClick(Sender: TObject);
begin
  ScriptEditor.Command(ecViewOption);
end;

procedure TfmEditRBInterface.ScriptEditorChange(Sender: TObject);
begin
  ChangeFlag:=true;
//  DSB.FillListMethodsFromEditor;
end;

procedure TfmEditRBInterface.ScriptEditorKeyPress(Sender: TObject; var Key: Char);
begin
end;

procedure TfmEditRBInterface.ViewCaret(CaretX,CaretY: Integer);
begin
  stbarScript.Panels[0].Text:=Format(ConstFmtStatusRowColScriptEditor,
                                    [CaretY+1,CaretX+1]);
end;

procedure TfmEditRBInterface.ScriptEditorKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  ViewCaret(ScriptEditor.CaretX,ScriptEditor.CaretY);
end;

procedure TfmEditRBInterface.ScriptEditorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  ViewCaret(ScriptEditor.CaretX,ScriptEditor.CaretY);
end;

procedure TfmEditRBInterface.ScriptEditorMouseDown(Sender: TObject; Button: TMouseButton;
                                                Shift: TShiftState; X, Y: Integer);
var
  CaretX,CaretY: Integer;
begin
  isViewCaret:=true;
  ScriptEditor.Mouse2Caret(X,Y,CaretX,CaretY);
  ViewCaret(CaretX,CaretY);
end;

procedure TfmEditRBInterface.ScriptEditorMouseUp(Sender: TObject; Button: TMouseButton;
                                                Shift: TShiftState; X, Y: Integer);
var
  CaretX,CaretY: Integer;
begin
  ScriptEditor.Mouse2Caret(X,Y,CaretX,CaretY);
  ViewCaret(CaretX,CaretY);
  isViewCaret:=false;
end;

procedure TfmEditRBInterface.ScriptEditorMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  CaretX,CaretY: Integer;
begin
  if isViewCaret then begin
    ScriptEditor.Mouse2Caret(X,Y,CaretX,CaretY);
    ViewCaret(CaretX,CaretY);
  end;
end;

procedure TfmEditRBInterface.ScriptEditorSelectionChange(Sender: TObject);
begin
  ViewCaret(ScriptEditor.CaretX,ScriptEditor.CaretY);
end;

procedure TfmEditRBInterface.tlbNewScriptClick(Sender: TObject);
begin
  ScriptEditor.Command(ecNewScript);
end;

procedure TfmEditRBInterface.tlbOpenScriptClick(Sender: TObject);
begin
  ScriptEditor.Command(ecOpenScript);
end;

procedure TfmEditRBInterface.tlbSaveScriptClick(Sender: TObject);
begin
  ScriptEditor.Command(ecSaveScript);
end;

procedure TfmEditRBInterface.tlbUndoScriptClick(Sender: TObject);
begin
  if ScriptEditor.UndoBuffer.CanUndo then
    ScriptEditor.Command(ecUndo);
end;

procedure TfmEditRBInterface.tlbRedoScriptClick(Sender: TObject);
begin
  if ScriptEditor.UndoBuffer.CanUndo then
    ScriptEditor.Command(ecRedo);
end;

procedure TfmEditRBInterface.tlbCutScriptClick(Sender: TObject);
begin
  ScriptEditor.Command(ecClipboardCut);
end;

procedure TfmEditRBInterface.tlbCopyScriptClick(Sender: TObject);
begin
  ScriptEditor.Command(ecClipboardCopy);
end;

procedure TfmEditRBInterface.tlbPasteScriptClick(Sender: TObject);
begin
  ScriptEditor.Command(ecClipboardPaste);
end;

procedure TfmEditRBInterface.tlbDeleteScriptClick(Sender: TObject);
begin
  ScriptEditor.Command(ecDeleteSelected);
end;

procedure TfmEditRBInterface.tlbGotoLineScriptClick(Sender: TObject);
begin
  ScriptEditor.Command(ecGotoLine);
end;

procedure TfmEditRBInterface.miSetBookMark9Click(Sender: TObject);
var
  mi: TMenuItem;
begin
  mi:=TMenuItem(sender);
  mi.Checked:=not mi.Checked;
  pmGotoBookMark.Items[mi.MenuIndex].Checked:=mi.Checked;
  pmSetBookMark.Items[mi.MenuIndex].Checked:=mi.Checked;
  ScriptEditor.SetBookMarkValues(mi.Tag,mi.Checked);
end;

procedure TfmEditRBInterface.miGotoBookMark9Click(Sender: TObject);
var
  mi: TMenuItem;
begin
  mi:=TMenuItem(sender);
  if mi.Checked then
   ScriptEditor.GotoBookMark(mi.Tag);
end;

procedure TfmEditRBInterface.ScriptEditorBookMarkChange(Sender: TObject; BookMark: Integer);
begin
  pmSetBookMark.Items[BookMark].Checked:=ScriptEditor.BookMarks[BookMark].Valid;
  pmGotoBookMark.Items[BookMark].Checked:=pmSetBookMark.Items[BookMark].Checked;
end;

procedure TfmEditRBInterface.LocalFindText(First: Boolean);
var
  ret: Boolean;
begin
   with fmFindDialog do begin
    ret:=ScriptEditor.FindText(cmbSearchText.Text,chbWithCase.Checked,
                               chbWordOnly.Checked,chbRegExpresion.Checked,
                               rbForward.Checked,rbGlobal.Checked,rbFromCursor.Checked,
                               First,false);

    if not ret then
     ShowInfoEx(Format(ConstFmtStringNotFound,[cmbSearchText.Text]));
   end;
   ScriptEditor.SetFocus;
end;

procedure TfmEditRBInterface.tlbFindScriptClick(Sender: TObject);
begin
  ScriptEditor.Command(ecFind);
end;

procedure TfmEditRBInterface.pcMainChange(Sender: TObject);
begin
  case pcMain.ActivePageIndex of
    0: begin
      bibOk.Default:=true;
      bibCancel.Cancel:=true;
    end;
    1: begin
      ScriptEditor.SetFocus;
      bibOk.Default:=false;
      bibCancel.Cancel:=false;
    end;
    2: begin
      bibOk.Default:=false;
      bibCancel.Cancel:=false;
    end;
  end;
end;

procedure TfmEditRBInterface.Button1Click(Sender: TObject);
begin
  ScriptEditor.SetErrorLine(1,1);
end;

procedure TfmEditRBInterface.LocalReplaceText;
var
  ret: Boolean;
begin
   with fmReplaceDialog do begin
    ret:=ScriptEditor.ReplaceText(cmbSearchText.Text,cmbReplace.Text,chbWithCase.Checked,
                                  chbWordOnly.Checked,chbRegExpresion.Checked,
                                  rbForward.Checked,rbGlobal.Checked,rbFromCursor.Checked,
                                  chbPromt.Checked,true,false);
    if not ret then
     ShowInfoEx(Format(ConstFmtStringNotFound,[cmbSearchText.Text]));

   end;
   ScriptEditor.SetFocus;
end;

procedure TfmEditRBInterface.tlbReplaceScriptClick(Sender: TObject);
begin
  ScriptEditor.Command(ecReplace);
end;

procedure TfmEditRBInterface.ScriptEditorStartLongOperation(Sender: TObject; vMin,vMax: Integer; vHint: string);
var
  TCPB: TCreateProgressBar;
begin
  _FreeProgressBar(PBh);
  FillCHar(TCPB,SizeOf(TCreateProgressBar),0);
  TCPB.Min:=vMin;
  TCPB.Max:=vMax;
  TCPB.Hint:=Pchar(vHint);
  TCPB.Color:=clNavy;
  PBh:=_CreateProgressBar(@TCPB);
end;

procedure TfmEditRBInterface.ScriptEditorProgressLongOperation(Sender: TObject; vProgress: Integer);
var
  TSPBS: TSetProgressBarStatus;
begin
  TSPBS.Progress:=vProgress;
  TSPBS.Hint:='';
  _SetProgressBarStatus(PBh,@TSPBS);
  Application.ProcessMessages;
end;

procedure TfmEditRBInterface.ScriptEditorFinishLongOperation(Sender: TObject);
begin
  _FreeProgressBar(PBh);
end;

procedure TfmEditRBInterface.ctrlBarFormsResize(Sender: TObject);
begin
  pnComponents.Align:=alClient;
end;

procedure TfmEditRBInterface.tlbNewFormsClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcNewForm);
end;

procedure TfmEditRBInterface.FormResize(Sender: TObject);
begin
  pnComponents.Width:=ctrlBarForms.ClientWidth-pnComponents.Left;
end;

procedure TfmEditRBInterface.pnComponentsResize(Sender: TObject);
begin
  if DTC<>nil then DTC.ResizeControl;
end;

procedure TfmEditRBInterface.tlbOpenFormsClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcOpenForm);
end;

procedure TfmEditRBInterface.tlbSaveFormsClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcSaveForm);
end;

procedure TfmEditRBInterface.pnFormsLeftDockDockDrop(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer);
begin
  if (Sender as TPanel).DockClientCount = 1 then
    ShowDockPanel(Sender as TPanel, True, Source.Control);
  (Sender as TPanel).DockManager.ResetBounds(True);
end;

procedure TfmEditRBInterface.ShowDockPanel(APanel: TPanel; MakeVisible: Boolean;
            Client: TControl);
begin
  if Client=nil then exit;
  if not MakeVisible and (APanel.VisibleDockClientCount > 1) then
    Exit;

  if APanel = pnFormsLeftDock then
    splFormsLeft.Visible := MakeVisible;
  if APanel=pnFormsRigthDock then
    splFormsRigth.Visible := MakeVisible;

    if MakeVisible then begin
      if APanel = pnFormsLeftDock then
      begin
        APanel.Width :=DOI.UndockWidth;
        UseSetUndockBounds:=true;
        APanel.Constraints.MinWidth:=DOI.Constraints.MinWidth;
        splFormsLeft.MinSize:=DOI.Constraints.MinWidth;
        splFormsLeft.Left := APanel.Width + splFormsLeft.Width;
      end;
      if APanel = pnFormsRigthDock then
      begin
        APanel.Width :=DOI.UndockWidth;
        UseSetUndockBounds:=true;
        APanel.Constraints.MinWidth:=DOI.Constraints.MinWidth;
        splFormsRigth.MinSize:=DOI.Constraints.MinWidth;
        splFormsRigth.Left := APanel.Width + splFormsRigth.Width;
      end;
    end else begin
      if APanel = pnFormsLeftDock then begin
        UseSetUndockBounds:=false;
        APanel.Constraints.MinWidth:=0;
        APanel.Width := 0;
      end;
      if APanel = pnFormsRigthDock then begin
        UseSetUndockBounds:=false;
        APanel.Constraints.MinWidth:=0;
        APanel.Width := 0;
      end;
    end;

  if MakeVisible and (Client <> nil) then Client.Show;
end;

procedure TfmEditRBInterface.pnFormsLeftDockDockOver(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
var
  ARect: TRect;
begin
  Accept := Source.Control is TDesignObjInsp;
  if Accept then begin
    if Sender=pnFormsLeftDock then begin
     ARect.TopLeft := TPanel(Sender).ClientToScreen(Point(0, 0));
     ARect.BottomRight := TPanel(Sender).ClientToScreen(
        Point(Source.Control.Width, TPanel(Sender).Height));
    end;
    if Sender=pnFormsRigthDock then begin
     ARect.TopLeft := TPanel(Sender).ClientToScreen(
        Point(-Source.Control.Width, 0));
     ARect.BottomRight := TPanel(Sender).ClientToScreen(
        Point(0, TPanel(Sender).Height));
    end;
    Source.DockRect := ARect;
  end;
end;

procedure TfmEditRBInterface.pnFormsLeftDockGetSiteInfo(Sender: TObject;
  DockClient: TControl; var InfluenceRect: TRect; MousePos: TPoint;
  var CanDock: Boolean);
begin
  CanDock := DockClient is TDesignObjInsp;
end;

procedure TfmEditRBInterface.pnFormsLeftDockUnDock(Sender: TObject;
  Client: TControl; NewTarget: TWinControl; var Allow: Boolean);
begin
  if (Sender as TPanel).DockClientCount = 1 then
    ShowDockPanel(Sender as TPanel, False, Client);
end;

procedure TfmEditRBInterface.ctrlBarScriptBandPaint(Sender: TObject;
  Control: TControl; Canvas: TCanvas; var ARect: TRect;
  var Options: TBandPaintOptions);

const
  Offset = 3;
var
  R: TRect;

  procedure DrawCurrentTabIndex;
  var
    tabRt: TRect;
  begin
    with TControlBar(Sender).Canvas, R do
    begin
      Pen.Color := clBtnHighlight;
      if DTC<>nil then begin
        tabRt:=DTC.TabRect(DTC.TabIndex);
        OffsetRect(tabRt,R.Left+4,R.Top-1);
        MoveTo(tabRt.Left, tabRt.Top);
        LineTo(tabRt.Right, tabRt.Top);
      end;
    end;
  end;

  procedure DrawGrabber;
  begin
    with TControlBar(Sender).Canvas, R do
    begin
      Pen.Color := clBtnHighlight;
      MoveTo(R.Left+2, R.Top);
      LineTo(R.Left, R.Top);
      LineTo(R.Left, R.Bottom+1);
      Pen.Color := clBtnShadow;
      MoveTo(R.Right, R.Top);
      LineTo(R.Right, R.Bottom);
      LineTo(R.Left, R.Bottom);
    end;
  end;


begin
  if Control=pnComponents then begin
   Options:=[bpoGrabber];
  end else begin
   Options:=[bpoGrabber];
  end;
end;

procedure TfmEditRBInterface.SetUndockBounds(wt: TWinControl);
begin
  if DOI=nil then exit;
  if not UseSetUndockBounds then exit;
  DOI.LRDockWidth:=wt.Width;
  DOI.TBDockHeight:=wt.Height;
  DOI.UndockWidth:=wt.Width;
  DOI.UndockHeight:=wt.Height;
end;

procedure TfmEditRBInterface.splFormsLeftMoved(Sender: TObject);
begin
  SetUndockBounds(pnFormsLeftDock);
end;

procedure TfmEditRBInterface.splFormsRigthMoved(Sender: TObject);
begin
  SetUndockBounds(pnFormsRigthDock);
end;

procedure TfmEditRBInterface.pnFormsLeftDockResize(Sender: TObject);
begin
  SetUndockBounds(TPanel(Sender));
end;

procedure TfmEditRBInterface.DOIOnClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caHide;
  if DOI.HostDockSite<>nil then
     ShowDockPanel(TPanel(DOI.HostDockSite), false, DOI);
end;

procedure TfmEditRBInterface.DOIOnShow(Sender: TObject);
begin
  //
end;

procedure TfmEditRBInterface.tlbObjInspClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcViewObjInsp);
end;

procedure TfmEditRBInterface.tlbOptionFormsClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcViewOptions);
end;

procedure TfmEditRBInterface.tlbCutFormsClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcCutComponents);
end;

procedure TfmEditRBInterface.tlbCopyFormsClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcCopyComponents);
end;

procedure TfmEditRBInterface.tlbPasteFormsClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcPasteComponents);
end;

procedure TfmEditRBInterface.tlbDeleteFormsClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcDeleteComponents);
end;

procedure TfmEditRBInterface.tlbFormsSelectAllClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcSelectAllComponents);
end;

procedure TfmEditRBInterface.tlbAlignToGridClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcAlignToGridComponents);
end;

procedure TfmEditRBInterface.tlbBringToFrontClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcBringToFrontComponents);
end;

procedure TfmEditRBInterface.tlbSendToBackClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcSendToBackComponents);
end;

procedure TfmEditRBInterface.miLocksNoCopyClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcLocksNoCopyComponents);
end;

procedure TfmEditRBInterface.pmLocksPopup(Sender: TObject);
var
  i: Integer;
begin
  miLocksNoDelete.Checked:=lmNoDelete in DSB.GetLockComponents;
  miLocksNoMove.Checked:=lmNoMove in DSB.GetLockComponents;
  miLocksNoSize.Checked:=lmNoResize in DSB.GetLockComponents;
  miLocksNoInsertIn.Checked:=lmNoInsertIn in DSB.GetLockComponents;
  miLocksNoCopy.Checked:=lmNoCopy in DSB.GetLockComponents;
  for i:=0 to pmLocks.Items.Count-1 do
    pmLocks.Items[i].Enabled:=DSB.isSelectedControls;
end;

procedure TfmEditRBInterface.miLockClearClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcLocksClerComponents);
end;

procedure TfmEditRBInterface.tlbAlignPalleteClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcViewAlignPalette);
end;

procedure TfmEditRBInterface.tlbTabOrderClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcViewTabOrder);
end;

procedure TfmEditRBInterface.PrepearToolBarsForms;

  procedure LocalPrepeareMI(Items: TMenuItem);
  var
    i: Integer;
    dc: TDesignCommand;
  begin
    for i:=0 to Items.Count-1 do begin
      dc:=TDesignCommand(Items[i].Tag);
      if Items[i].Caption<>'-' then begin
       Items[i].Caption:=GetHintDesignCommand(dc,Items[i].Caption);
       Items[i].ShortCut:=GetShortCutFromDesignCommand(DSB,dc);
       Items[i].Hint:=GetHintWithShortCutFromDesignCommand(DSB,dc,Items[i].Hint);
      end; 
    end;
  end;

  procedure LocalPrepearTB(tb: TToolBar);
  var
    i: Integer;
    bt: TToolButton;
    dc: TDesignCommand;
  begin
    for i:=0 to tb.ButtonCount-1 do begin
     bt:=tb.Buttons[i];
     dc:=TDesignCommand(bt.Tag);
     bt.Caption:=GetHintDesignCommand(dc,bt.Caption);
     if bt.DropdownMenu<>nil then begin
       LocalPrepeareMI(bt.DropdownMenu.Items);
     end;
     bt.Hint:=GetHintWithShortCutFromDesignCommand(DSB,dc,bt.Caption);
    end;
  end;

begin
  LocalPrepearTB(tlBarForms1);
  LocalPrepearTB(tlBarForms2);
end;

procedure TfmEditRBInterface.FillFormsPopUpMenu;

   procedure AddChildMenu(miParent: TmenuItem; Items: TMenuItem);
   var
     mi: TMenuItem;
     i: Integer;
   begin
     for i:=0 to Items.Count-1 do begin
       mi:=TMenuItem.Create(Self);
       mi.Tag:=Items[i].Tag;
       mi.Caption:=Items[i].Caption;
       mi.Hint:=Items[i].Hint;
       mi.ImageIndex:=Items[i].ImageIndex;
       mi.Enabled:=Items[i].Enabled;
       mi.Checked:=Items[i].Checked;
       mi.Visible:=Items[i].Visible;
       mi.RadioItem:=Items[i].RadioItem;
       mi.GroupIndex:=Items[i].GroupIndex;
       mi.ShortCut:=Items[i].ShortCut;
       mi.OnClick:=Items[i].OnClick;
       miParent.Add(mi);
     end;
   end;

   procedure FillFromToolBar(tb: TToolBar);
   var
    i: Integer;
    mi: TMenuItem;
    bt: TToolButton;
    dc: TDesignCommand;
   begin
    for i:=0 to tb.ButtonCount-1 do begin
     bt:=tb.Buttons[i];
     dc:=TDesignCommand(bt.Tag);
     mi:=TMenuItem.Create(Self);
     case bt.Style of
       tbsButton: mi.Caption:=bt.Caption;
       tbsSeparator: mi.Caption:='-';
       tbsDropDown:  mi.Caption:=bt.Caption;
     end;
     if bt.DropdownMenu<>nil then begin
       AddChildMenu(mi,bt.DropdownMenu.Items);
     end;
     mi.Hint:=bt.Hint;
     mi.ImageIndex:=bt.ImageIndex;
     mi.Enabled:=bt.Enabled;
     mi.Visible:=bt.Visible;
     if (bt.Style<>tbsDropDown) then begin
       mi.OnClick:=bt.OnClick;
       mi.ShortCut:=GetShortCutFromDesignCommand(DSB,dc);
     end else if bt.DropdownMenu<>nil then
       if bt.DropdownMenu.Items.Count=0 then begin
         mi.OnClick:=bt.OnClick;
         mi.ShortCut:=GetShortCutFromDesignCommand(DSB,dc);
       end;
     pmForms.Items.Add(mi);
    end;
   end;

   procedure AddSeparator;
   var
     mi: TMenuItem;
   begin
     mi:=TMenuItem.Create(Self);
     mi.Caption:='-';
     pmForms.Items.Add(mi);
   end;

begin
  pmForms.Items.Clear;
  DSB.AddComponentEditors;
  FillFromToolBar(tlBarForms1);
  AddSeparator;
  FillFromToolBar(tlBarForms2);
end;

procedure TfmEditRBInterface.pmFormsPopup(Sender: TObject);
begin
  pmLocksPopup(nil);
  FillFormsPopUpMenu;
end;

procedure TfmEditRBInterface.DSBOnDesignCommand(Sender: TObject; DesignCommand: TDesignCommand);
var
  ct: TControl;
begin
  case DesignCommand of
    dkcLocksNoDeleteComponents: TMenuItem(Sender).Checked:=lmNodelete in DSB.GetLockComponents;
    dkcLocksNoMoveComponents: TMenuItem(Sender).Checked:=lmNoMove in DSB.GetLockComponents;
    dkcLocksNoResizeComponents: TMenuItem(Sender).Checked:=lmNoResize in DSB.GetLockComponents;
    dkcLocksNoInsertInComponents: TMenuItem(Sender).Checked:=lmNoInsertIn in DSB.GetLockComponents;
    dkcLocksNoCopyComponents: TMenuItem(Sender).Checked:=lmNoCopy in DSB.GetLockComponents;
    dkcViewAlignPalette: fmAlignPalette.Show;
    dkcViewObjInsp: begin
     if DOI.HostDockSite<>nil then
       ShowDockPanel(TPanel(DOI.HostDockSite), true, DOI)
     else
      DOI.Show;
    end;
    dkcViewTabOrder: begin
      if DSB.isSelectedControls then begin
       ct:=DSB.ActiveDesignForm.ELDesigner.SelectedControls.DefaultControl;
      end else begin
       ct:=DSB.ActiveDesignForm;
      end;
      if not (ct is TWinControl) then exit;
      fmTabOrders.InitTabOrder(TWinControl(ct),DSB);
      if fmTabOrders.ShowModal=mrOk then begin
        fmTabOrders.BackUpTabOrder;
      end;
    end;
    dkcViewOptions: _ViewOption(hOptionForms);
    dkcViewScript: pcMain.ActivePage:=tbsScript;
    dkcSaveFormsToBase: begin
      SaveToBaseForms;
    end;
    dkcRunScript: ScriptEditor.Command(ecRunScript);
    dkcResetScript:ScriptEditor.Command(ecResetScript); 
  end;
end;

procedure TfmEditRBInterface.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case pcMain.ActivePageIndex of
    0:;
    1:;
    2: begin
     if DSB<>nil then
       DSB.DoKeyDown(Sender,Key,Shift);
    end;
    3: begin
     if DFSB<>nil then
       DFSB.DoKeyDown(Sender,Key,Shift);
    end;
  end;
end;

procedure TfmEditRBInterface.miLocksNoMoveClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcLocksNoMoveComponents);
end;

procedure TfmEditRBInterface.miLocksNoSizeClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcLocksNoResizeComponents);
end;

procedure TfmEditRBInterface.miLocksNoInsertInClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcLocksNoInsertInComponents);
end;

procedure TfmEditRBInterface.miLocksNoDeleteClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcLocksNoDeleteComponents);
end;

procedure TfmEditRBInterface.DTCOnChange(Sender: TObject);
begin
//  ctrlBarForms.Invalidate;
end;

procedure TfmEditRBInterface.DTCOnChanging(Sender: TObject;var AllowChange: Boolean);
begin
//  ctrlBarForms.Invalidate;
end;

procedure TfmEditRBInterface.SetParamsFromOptions(Index: Integer);
var
  DD: Integer;
  obj: TObject;
  i: Integer;
  li: TListItem;
  P: PDesignKeyboard;
begin
 if Index=0 then begin
   with ScriptEditor,fmOptions do begin
    Autoindent:=cbScriptAutoIndent.Checked;
    SmartTab:=cbScriptSmartTab.Checked;
    BackSpaceUnindents:=cbScriptBackspaceUnindents.Checked;
    GroupUndo:=cbScriptGroupUndo.Checked;
    CursorBeyondEOF:=cbScriptCursorBeyondEOF.Checked;
    UndoAfterSave:=cbScriptUndoAfterSave.Checked;
    KeepTrailingBlanks:=cbScriptKeepTrailingBlanks.Checked;
    DoubleClickLine:=cbScriptDoubleClickLine.Checked;
    SyntaxHighlighting:=cbScriptSytaxHighlighting.Checked;
    RightMarginVisible:=cbScriptRightMarginVisisble.Checked;
    RightMargin:=udScriptRightMargin.Position;
    GutterWidth:=udScriptGutterWidth.Position;
    SelBlockFormat:=TSelBlockFormat(cmbScriptSelBlockFormat.ItemIndex);
    TabStops:=edScriptTabStops.Text;
    Completion.Enabled:=cbScriptAutoChange.Checked;
    Completion.Interval:=udScriptAutoChange.Position;
    HighLighter:=THighLighter(cmbScriptTypeHigh.ItemIndex);
    ScriptEditor.Font.Name:=TTSVFontBox(cmbScriptFontName).FontName;
    ScriptEditor.Font.Size:=udScriptFontSize.Position;
    Colors.Number.Assign(RaEditor.Colors.Number);
    Colors.Comment.Assign(RaEditor.Colors.Comment);
    Colors.Strings.Assign(RaEditor.Colors.Strings);
    Colors.Symbol.Assign(RaEditor.Colors.Symbol);
    Colors.Reserved.Assign(RaEditor.Colors.Reserved);
    Colors.Identifer.Assign(RaEditor.Colors.Identifer);
    Colors.Preproc.Assign(RaEditor.Colors.Preproc);
    Colors.FunctionCall.Assign(RaEditor.Colors.FunctionCall);
    Colors.Declaration.Assign(RaEditor.Colors.Declaration);
    Colors.Statement.Assign(RaEditor.Colors.Statement);
    Colors.PlainText.Assign(RaEditor.Colors.PlainText);
    Colors.Bookmark.Assign(RaEditor.Colors.Bookmark);
    Colors.FindTxt.Assign(RaEditor.Colors.FindTxt);
    Colors.ErrorLine.Assign(RaEditor.Colors.ErrorLine);
    RightMarginColor:=RaEditor.RightMarginColor;
    GutterColor:=RaEditor.GutterColor;
    SelForeColor:=RaEditor.SelForeColor;
    SelBackColor:=RaEditor.SelBackColor;
    ScriptEditor.Color:=RaEditor.Color;
    DD:=Completion.DropDownWidth;
    Completion.Assign(RaEditor.Completion);
    Completion.DropDownWidth:=DD;
    Keyboard.Assign(RaEditor.Keyboard);
   end;
   ScriptEditor.Repaint;
   PrepearToolBarsEditor;
 end;

 if Index=1 then begin
   with fmOptions do begin
     DSB.GridVisible:=chbRBRFGridVisible.Checked;
     DSB.GridAlign:=chbRBRFGridAlign.Checked;
     DSB.GridXStep:=udRBRFGridXStep.Position;
     DSB.GridYStep:=udRBRFGridYStep.Position;
     cmbRBRFGridColor.HandleNeeded;
     DSB.GridColor:=TTsvColorBox(cmbRBRFGridColor).Selected;
     DSB.HintControl:=chbRBRFHintsControl.Checked;
     DSB.HintSize:=chbRBRFHintsSize.Checked;
     DSB.HintMove:=chbRBRFHintsMove.Checked;
     DSB.HintInsert:=chbRBRFHintsInsert.Checked;
     DSB.HandleClr:=TColor(lbRBRFColors.Items.Objects[0]);
     DSB.HandleBorderClr:=TColor(lbRBRFColors.Items.Objects[1]);
     DSB.MultySelectHandleClr:=TColor(lbRBRFColors.Items.Objects[2]);
     DSB.MultySelectHandleBorderClr:=TColor(lbRBRFColors.Items.Objects[3]);
     DSB.InactiveHandleClr:=TColor(lbRBRFColors.Items.Objects[4]);
     DSB.InactiveHandleBorderClr:=TColor(lbRBRFColors.Items.Objects[5]);
     DSB.LockedHandleClr:=TColor(lbRBRFColors.Items.Objects[6]);
     DSB.SizeHandle:=udRBRFSizeHandle.Position;
     DSB.VisibleComponentCaption:=chbViewComponentCaption.Checked;

     cmbObjColorProperty.HandleNeeded;
     DOI.ObjInsp.Font.Color:=TTSVColorBox(cmbObjColorProperty).Selected;
     cmbObjColorValue.HandleNeeded;
     DOI.ObjInsp.ValueColor:=TTSVColorBox(cmbObjColorValue).Selected;
     cmbObjColorSubProperty.HandleNeeded;
     DOI.ObjInsp.SubPropertyColor:=TTSVColorBox(cmbObjColorSubProperty).Selected;
     cmbObjColorReference.HandleNeeded;
     DOI.ObjInsp.ReferenceColor:=TTSVColorBox(cmbObjColorReference).Selected;
     DOI.ObjInsp.Invalidate;
     DOI.PanelHintVisible:=chbRBRFTranslate.Checked;

     obj:=DOI.ObjInsp.CurObj;
     DOI.ObjInsp.CurObj:=nil;
     DOI.ObjInsp.CurObj:=obj;
     DSB.DesignListKeyboard.Clear;
     lvRBRFKeys.HandleNeeded;
     for i:=0 to lvRBRFKeys.Items.Count-1 do begin
       li:=lvRBRFKeys.Items[i];
       P:=li.data;
       DSB.DesignListKeyboard.Add(P.Command,P.Key,P.Shift);
     end;
     PrepearToolBarsForms;
   end;
 end;  
end;

procedure TfmEditRBInterface.tlbFindAgainScriptClick(Sender: TObject);
begin
  ScriptEditor.Command(ecFindNext);
end;

function TfmEditRBInterface.GetInfoInterpreterPos(hLogItem: THandle): Pointer;
var
  i: Integer;
  P: PInfoInterpreterPos;
begin
  Result:=nil;
  for i:=0 to ListInterpreterPos.Count-1 do begin
    P:=ListInterpreterPos.Items[i];
    if P.hLogItem=hLogItem then begin
      Result:=P;
      exit;
    end;
  end;
end;

procedure TfmEditRBInterface.ViewInfoInterpreterPos(P: Pointer);
var
  PPos: PInfoInterpreterPos;
  X,Y: Integer;
begin
  if P=nil then exit;
  PPos:=P;
  ScriptEditor.ErrorLine.Visible:=false;
  ScriptEditor.CaretFromPos(PPos.Position,X,Y);
  ScriptEditor.ErrorLine.Line:=Y;
  ScriptEditor.ErrorLine.Column:=X;
  ScriptEditor.ErrorLine.Visible:=true;
  ViewScript;
end;

procedure TfmEditRBInterface.ViewScriptEditorMessage(Mess: string; TypeAdditionalLogItem: TTypeAdditionalLogItem; Position: Integer);
var
  TCALI: TCreateAdditionalLogItem;
  hLogItem: THandle;
  P: PInfoInterpreterPos;
begin
  if Trim(Mess)<>'' then begin
   FillChar(TCALI,SizeOf(TCALI),0);
   TCALI.MaxRow:=3;
   TCALI.Caption:=PChar(Mess);
   TCALI.TypeAdditionalLogItem:=TypeAdditionalLogItem;
   if (TypeAdditionalLogItem=taliError)or(TypeAdditionalLogItem=taliWarning) then
     TCALI.ViewAdditionalLogItemProc:=EditInterfaceViewAdditionalLogItemProc
   else TCALI.ViewAdditionalLogItemProc:=nil;
   hLogItem:=_CreateAdditionalLogItem(hAdditionalLogBuild,@TCALI);
   if hLogItem<>LOGITEM_INVALID_HANDLE then begin
     new(P);
     FillChar(P^,SizeOf(P^),0);
     P.hLogItem:=hLogItem;
     P.Position:=Position;
     ListInterpreterPos.Add(P);
     _ViewAdditionalLog(hAdditionalLogBuild,true);
   end;
  end;
end;

function TfmEditRBInterface.isValidInterpreter: Boolean;
var
  P: PInfoLibraryInterpreter;
begin
  Result:=false;
  P:=GetActiveLibraryInterpreter;
  if P=nil then exit;
  if not isValidPointer(@P.CreateProc) then exit;
  if not isValidPointer(@P.FreeProc) then exit;
  if not isValidPointer(@P.ResetProc) then exit;
  if not isValidPointer(@P.RunProc) then exit;
  if not isValidPointer(@P.IsValidProc) then exit;
  if not isValidPointer(@P.SetParamsProc) then exit;
  if not isValidPointer(@P.GetCreateInterfaceNameProc) then exit;
  if not isValidPointer(@P.GetInterpreterIdentifersProc) then exit;
  Result:=true;
end;

function TfmEditRBInterface.GetActiveLibraryInterpreter: PInfoLibraryInterpreter;
begin
  Result:=nil;
  if cmbInterpreter.ItemIndex=-1 then exit;
  Result:=PInfoLibraryInterpreter(cmbInterpreter.Items.Objects[cmbInterpreter.ItemIndex]);
end;

procedure MessageInterpreterProc(Owner: Pointer; InterpreterHandle: THandle; TypeMessage: TTypeMessageInterpreterProc;
                                 Line,Pos: Integer; UnitName,Message: PChar); stdcall;
var
   fmCurrent: TfmEditRBInterface;
                                 
   procedure LocalTranslateWarning;
   begin
     fmCurrent.ViewScriptEditorMessage(Message,taliWarning,Pos);
     fmCurrent.ViewScript;
   end;

   procedure LocalTranslateHint;
   begin
     fmCurrent.ViewScriptEditorMessage(Message,taliInformation,Pos);
   end;

   procedure LocalTranslateError;
   var
     X,Y: Integer;
   begin
     fmCurrent.ScriptEditor.CaretFromPos(Pos,X,Y);
     fmCurrent.ScriptEditor.ErrorLine.Line:=Y;
     fmCurrent.ScriptEditor.ErrorLine.Column:=X;
     fmCurrent.ScriptEditor.ErrorLine.Visible:=true;
     fmCurrent.ViewScriptEditorMessage(Message,taliError,Pos);
     fmCurrent.InterpreterReset;
     fmCurrent.ViewScript;
   end;

   procedure LocalTranslateOk;
   begin
     fmCurrent.ViewScriptEditorMessage(Message,taliInformation,Pos);
     fmCurrent.InterpreterReset;
     fmCurrent.ViewScript;
   end;

begin
  if not IsValidPointer(Owner) then exit;
  fmCurrent:=TfmEditRBInterface(Owner);
  fmCurrent.ScriptEditor.ErrorLine.Visible:=false;
  case TypeMessage of
    tmiWarning: LocalTranslateWarning;
    tmiHint: LocalTranslateHint;
    tmiError: LocalTranslateError;
    tmiOk: LocalTranslateOk;
  end;
end;

procedure GetInterpreterUnitsProc(Owner,ProcOwner: Pointer; Proc: TGetInterpreterUnitProc); stdcall;
var
  TGIU: TGetInterpreterUnit;
begin
  if not isValidPointer(@Proc) then exit;
  if not isValidPointer(Owner) then exit;
  FillChar(TGIU,SizeOf(TGIU),0);
  TGIU.Code:=PChar(TfmEditRBInterface(Owner).ScriptEditor.Lines.Text);
  Proc(ProcOwner,@TGIU);
end;

procedure GetInterpreterFormsProc(Owner,ProcOwner: Pointer; Proc: TGetInterpreterFormProc); stdcall;
var
  TGIF: TGetInterpreterForm;
  i: Integer;
  ms: TMemoryStream;
  fm: TDesignForm;
begin
  if not isValidPointer(@Proc) then exit;
  if not isValidPointer(Owner) then exit;
  ms:=TMemoryStream.Create;
  try
   for i:=0 to TfmEditRBInterface(Owner).DSB.ListForms.Count-1 do begin
    fm:=TfmEditRBInterface(Owner).DSB.ListForms.Items[i];
    ms.Clear;
    fm.SaveToStream(ms);
    ms.Position:=0;
    FillChar(TGIF,SizeOf(TGIF),0);
    TGIF.Form:=StrAlloc(ms.Size);
    try
     Move(ms.Memory^,Pointer(TGIF.Form)^,ms.Size);
     Proc(ProcOwner,@TGIF);
    finally
     StrDispose(TGIF.Form);
    end; 
   end;
  finally
    ms.Free;
  end;
end;

procedure GetInterpreterDocumentsProc(Owner,ProcOwner: Pointer; Proc: TGetInterpreterDocumentProc); stdcall;
var
  TGID: TGetInterpreterDocument;
  i: Integer;
  ms: TMemoryStream;
  fm: TDocumentForm;
  isBreak: Boolean;
begin
  if not isValidPointer(@Proc) then exit;
  if not isValidPointer(Owner) then exit;
  ms:=TMemoryStream.Create;
  try
   isBreak:=false;
   for i:=0 to TfmEditRBInterface(Owner).DFSB.ListForms.Count-1 do begin
    if isBreak then Break; 
    fm:=TfmEditRBInterface(Owner).DFSB.ListForms.Items[i];
    ms.Clear;
    fm.SaveToStream(ms);
    ms.Position:=0;
    FillChar(TGID,SizeOf(TGID),0);
    TGID.DocumentName:=PChar(fm.RealyName);
    TGID.DocumentSize:=ms.Size;
    TGID.Document:=ms.Memory;
    TGID.DocumentClass:=PChar(Trim(fm.edOleClass.Text));
    Proc(ProcOwner,@TGID,isBreak);
   end;
  finally
    ms.Free;
  end;
end;

procedure OnRunInterpreterProc(Owner: Pointer); stdcall;
begin
  if not isValidPointer(Owner) then exit;
  TfmEditRBInterface(Owner).tlbRunScript.Enabled:=false;
  TfmEditRBInterface(Owner).tlbResetScript.Enabled:=true;
  TfmEditRBInterface(Owner).cmbInterpreter.Enabled:=false;
end;

procedure OnResetInterpreterProc(Owner: Pointer); stdcall;
begin
  if not isValidPointer(Owner) then exit;
  TfmEditRBInterface(Owner).tlbRunScript.Enabled:=true;
  TfmEditRBInterface(Owner).tlbResetScript.Enabled:=false;
  TfmEditRBInterface(Owner).cmbInterpreter.Enabled:=true;
//  ShowMessage(GetFirstValueFromPRBI(@TfmEditRBInterface(Owner).TPRBIGlobal,'name'));

end;

procedure OnFreeInterpreterProc(Owner: Pointer); stdcall;
begin
  if not isValidPointer(Owner) then exit;
  TfmEditRBInterface(Owner).tlbRunScript.Enabled:=true;
  TfmEditRBInterface(Owner).tlbResetScript.Enabled:=false;
  TfmEditRBInterface(Owner).cmbInterpreter.Enabled:=true;
end;

procedure TfmEditRBInterface.InterpreterCreateAndRun;
var
  P: PInfoLibraryInterpreter;
  TCI: TCreateInterpreter;
  TSIP: TSetInterpreterParam;
  CurPointer: Pointer;
begin
  P:=GetActiveLibraryInterpreter;

  if P=nil then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[lbInterpreter.Caption]));
    pcMain.ActivePage:=tbsAll;
    cmbInterpreter.SetFocus;
    exit;
  end;

  if not isValidInterpreter then exit;

  ScriptEditor.ErrorLine.Visible:=false;

  if FCurrentLibraryInterpreter<>P then begin
    InterpreterFree;
    FillChar(TCI,SizeOf(TCI),0);
    FInterpreterHandle:=P.CreateProc(@TCI);
    FCurrentLibraryInterpreter:=P;
  end else begin
    P.ResetProc(FInterpreterHandle);
  end;

  if FInterpreterHandle<>INTERPRETER_INVALID_HANDLE then begin

   FillChar(TSIP,SizeOf(TSIP),0);
   TSIP.MessageProc:=MessageInterpreterProc;
   TSIP.GetUnitsProc:=GetInterpreterUnitsProc;
   TSIP.GetFormsProc:=GetInterpreterFormsProc;
   TSIP.GetDocumentsProc:=GetInterpreterDocumentsProc;
   TSIP.OnRunProc:=OnRunInterpreterProc;
   TSIP.OnResetProc:=OnResetInterpreterProc;
   TSIP.OnFreeProc:=OnFreeInterpreterProc;
   TSIP.hInterface:=_GetInterfaceHandleFromName(PChar(InterfaceName));
   
   CurPointer:=nil;
   case TTypeInterface(cmbTypeInterface.ItemIndex) of
    ttiNone: CurPointer:=nil;
    ttiRBook: begin
      FillChar(TPRBIGlobal,SizeOf(TPRBIGlobal),0);
      CurPointer:=@TPRBIGlobal;
    end;
    ttiReport: begin
      FillChar(TPRIGlobal,SizeOf(TPRIGlobal),0);
      CurPointer:=@TPRIGlobal;
    end;
    ttiWizard: begin
      FillChar(TPWIGlobal,SizeOf(TPWIGlobal),0);
      CurPointer:=@TPWIGlobal;
    end;
    ttiJournal: begin
      FillChar(TPJIGlobal,SizeOf(TPJIGlobal),0);
      CurPointer:=@TPJIGlobal;
    end;
    ttiService: begin
      FillChar(TPSIGlobal,SizeOf(TPSIGlobal),0);
      CurPointer:=@TPSIGlobal;
    end;
    ttiDocument: begin
      FillChar(TPDIGlobal,SizeOf(TPDIGlobal),0);
      CurPointer:=@TPDIGlobal;
    end;
   end;
   TSIP.Param:=CurPointer;

   P.SetParamsProc(FInterpreterHandle,Self,@TSIP);

   ClearListInterpreterPos;
   DSB.PackMethods;

   if P.RunProc(FInterpreterHandle) then begin
   
   end;
  end;
end;

procedure TfmEditRBInterface.tlbRunScriptClick(Sender: TObject);
begin
  ScriptEditor.Command(ecRunScript);
end;

function TfmEditRBInterface.InterpreterFree: Boolean;
begin
  Result:=false;
  if FCurrentLibraryInterpreter=nil then exit;
  Result:=FCurrentLibraryInterpreter.FreeProc(FInterpreterHandle);
end;

function TfmEditRBInterface.InterpreterReset: Boolean;
begin
  Result:=false;
  if FCurrentLibraryInterpreter=nil then exit;
  Result:=FCurrentLibraryInterpreter.ResetProc(FInterpreterHandle);
end;

procedure TfmEditRBInterface.tlbResetScriptClick(Sender: TObject);
begin
  ScriptEditor.Command(ecResetScript);
end;

procedure TfmEditRBInterface.ScriptEditorShowSource(Sender: TObject);
begin
  pcMain.ActivePage:=tbsScript;
  ScriptEditor.SetFocus;
end;

procedure TfmEditRBInterface.ViewScript;
begin
  pcMain.ActivePage:=tbsScript;
  Show;
  BringToFront;
  if WindowState=wsMinimized then
    ShowWindow(Handle,SW_RESTORE);
  Windows.SetFocus(Self.handle);
  ScriptEditor.SetFocus;
  ScriptEditor.Invalidate;
end;

procedure fmEditRBInterfaceGetInterpreterIdentiferItemProc(Owner: Pointer; PGIII: PGetInterpreterIdentiferItem);stdcall;
var
  ItemEx: TCompletionItem;
  I: Integer;
  CaptionEx: TCompletionItemCaption;
begin
  if not isValidPointer(Owner) then exit;
  if not isValidPointer(PGIII) then exit;

  ItemEx:=TfmEditRBInterface(Owner).ScriptEditor.Completion.Identifers.Add;
  ItemEx.Caption:=PGIII.Caption;
  ItemEx.InsertedText.Text:=ItemEx.Caption;
  if isValidPointer(PGIII.Brush, SizeOf(TBrush)) then ItemEx.Brush.Assign(PGIII.Brush);
  if isValidPointer(PGIII.Font, SizeOf(TFont)) then ItemEx.Font.Assign(PGIII.Font);
  if isValidPointer(PGIII.Pen, SizeOf(TPen)) then ItemEx.Pen.Assign(PGIII.Pen);

  if not isValidPointer(@PGIII.CaptionEx) then exit;
  for i:=Low(PGIII.CaptionEx) to High(PGIII.CaptionEx) do begin
    if isValidPointer(PGIII.CaptionEx[i]) then begin
     CaptionEx:=ItemEx.CaptionEx.Add;
     CaptionEx.Caption:=PGIII.CaptionEx[i].Caption;
     CaptionEx.Alignment:=PGIII.CaptionEx[i].Alignment;
     CaptionEx.AutoSize:=PGIII.CaptionEx[i].AutoSize;
     CaptionEx.Width:=PGIII.CaptionEx[i].Width;
     if isValidPointer(PGIII.CaptionEx[i].Brush,SizeOf(TBrush)) then CaptionEx.Brush.Assign(PGIII.CaptionEx[i].Brush);
     if isValidPointer(PGIII.CaptionEx[i].Font,SizeOf(TFont)) then CaptionEx.Font.Assign(PGIII.CaptionEx[i].Font);
     if isValidPointer(PGIII.CaptionEx[i].Pen,SizeOf(TPen)) then CaptionEx.Pen.Assign(PGIII.CaptionEx[i].Pen);
    end;
  end;

end;

procedure fmEditRBInterfaceGetDesignComponentProc(Owner,ProcOwner: Pointer; Proc: TGetDesignComponentProc); stdcall;
var
  i: Integer;
begin
  if not isValidPointer(Owner) then exit;
  if not isValidPointer(@Proc) then exit;
  for i:=0 to TfmEditRBInterface(Owner).DSB.ListForms.Count-1 do begin
    Proc(ProcOwner,TfmEditRBInterface(Owner).DSB.ListForms.Items[i]);
  end;
end;

procedure TfmEditRBInterface.ScriptEditorCompletionIdentifier(Sender: TObject; var Cancel: Boolean);

  procedure FillListLocalVars(List: TList);
  var
    TCIV: TCreateInterpreterVar;
    h: THandle;
    i: Integer;
    fm: TForm;
    s: string;
    hLast: Thandle;
  begin
    hLast:=INTERPRETERVAR_INVALID_HANDLE;
    for i:=0 to DSB.ListForms.Count-1 do begin
     fm:=DSB.ListForms.Items[i];
     FillChar(TCIV,SizeOf(TCIV),0);
     TCIV.Identifer:=PChar(fm.Name);
     TCIV.Value:=O2V(fm);
     TCIV.TypeValue:=C2V(fm.ClassType);
     s:=fm.ClassName;
     TCIV.TypeText:=PChar(s);
     TCIV.Hint:=PChar(fm.Hint);
     if i=0 then TCIV.TypeCreate:=tcFirst
     else begin
       TCIV.TypeCreate:=tcAfter;
       TCIV.hCreate:=hLast;
     end; 
     h:=_CreateInterpreterVar(@TCIV);
     hLast:=h;
     List.Add(Pointer(h));
    end; 
  end;

var
  P: PInfoLibraryInterpreter;
  Pos: Integer;
  TGIIP: TGetInterpreterIdentiferParams;
  ListLocalVars: TList;
  i: Integer;
begin
  if not isValidInterpreter then exit;
  Screen.Cursor:=crHourGlass;
  P:=GetActiveLibraryInterpreter;
  ScriptEditor.Completion.Identifers.Clear;
  Pos:=ScriptEditor.PosFromCaret(ScriptEditor.CaretX,ScriptEditor.CaretY);
  ListLocalVars:=TList.Create;
  try
    FillListLocalVars(ListLocalVars);
    FillChar(TGIIP,SizeOf(TGIIP),0);
    TGIIP.Code:=PChar(ScriptEditor.Lines.Text);
    TGIIP.Pos:=Pos;
    TGIIP.GetInterpreterIdentiferItemProc:=fmEditRBInterfaceGetInterpreterIdentiferItemProc;
    TGIIP.DesignClassType:=TDesignComponent;
    TGIIP.ColorVar:=TtsvColorBox(fmOptions.cmbIdentiferColorVar).Selected;
    TGIIP.ColorProcedure:=TtsvColorBox(fmOptions.cmbIdentiferColorProcedure).Selected;
    TGIIP.ColorFunction:=TtsvColorBox(fmOptions.cmbIdentiferColorFunction).Selected;
    TGIIP.ColorType:=TtsvColorBox(fmOptions.cmbIdentiferColorType).Selected;
    TGIIP.ColorProperty:=TtsvColorBox(fmOptions.cmbIdentiferColorProperty).Selected;
    TGIIP.ColorConst:=TtsvColorBox(fmOptions.cmbIdentiferColorConst).Selected;
    TGIIP.ColorBackGround:=TtsvColorBox(fmOptions.cmbIdentiferColorBackGround).Selected;
    TGIIP.ColorCaption:=TtsvColorBox(fmOptions.cmbIdentiferColorCaption).Selected;
    TGIIP.ColorParams:=TtsvColorBox(fmOptions.cmbIdentiferColorParam).Selected;
    TGIIP.ColorHint:=TtsvColorBox(fmOptions.cmbIdentiferColorHint).Selected;
    P.GetInterpreterIdentifersProc(Self,@TGIIP);
  finally
    for i:=0 to ListLocalVars.Count-1 do
      _FreeInterpreterVar(THandle(ListLocalVars.Items[i]));
    Screen.Cursor:=crDefault;  
  end;  
end;

procedure TfmEditRBInterface.tlbOptionDocsClick(Sender: TObject);
begin
  DFSB.RunDocumentFormCommand(nil,dfcViewOption);
end;

procedure TfmEditRBInterface.DFSBOnDocumentFormCommand(Sender: TObject; DocumentFormCommand: TDocumentFormCommand);
begin
 case DocumentFormCommand of
   dfcSaveToBaseDocuments: SaveToBaseDocuments;
   dfcViewOption: _ViewOption(hOptionDocs);
 end;
end;

procedure TfmEditRBInterface.cmbTypeInterfaceDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);

  procedure DRawImages;
  var
    tmps: string;
    rc: TRect;
    t: Integer;
    newRect: TRect;
    NewIndex: Integer;
  begin
    tmps:=cmbTypeInterface.Items.Strings[Index];
    rc.TopLeft:=Rect.TopLeft;
    rc.BottomRight:=Rect.BottomRight;
    rc.Top:=rc.Top;
    rc.Bottom:=rc.Bottom;
    rc.Left:=rc.Left;
    rc.Right:=rc.Left+ilTypeInterface.Width+2;

    newRect.Left:=rc.Right;
    newRect.Top:=Rect.Top;
    newRect.Right:=Rect.Right;
    newRect.Bottom:=Rect.Bottom;

    NewIndex:=Index;

    with cmbTypeInterface.Canvas do begin
     if State<>[odFocused,odSelected] then begin
      FillRect(newRect);
      FillRect(rc);
      ilTypeInterface.Draw(cmbTypeInterface.Canvas,rc.Left+1,rc.Top+1,NewIndex);
     end else begin
      FillRect(newRect);
      FillRect(rc);
      ilTypeInterface.Draw(cmbTypeInterface.Canvas,rc.Left+1,rc.Top+1,NewIndex);
     end;
     t:=(rc.Bottom-rc.Top)div 2 -(TextHeight(tmps) div 2);
     t:=rc.top+t-1;
     TextOut(rc.Right+1,t,tmps);
    end;

  end;

begin
  DRawImages;
end;

procedure TfmEditRBInterface.LoadFromBaseScript(interface_id: Integer);
var
  qr: TIBQuery;
  tran: TIBTransaction;
  sqls: string;
  ms: TMemoryStream;
begin
  qr:=TIBQuery.Create(nil);
  tran:=TIBTransaction.Create(nil);
  ms:=TMemoryStream.Create;
  try
   qr.Database:=IBDB;
   tran.AddDatabase(IBDB);
   IBDB.AddTransaction(tran);
   tran.Params.Text:=DefaultTransactionParamsTwo;
   qr.ParamCheck:=false;
   qr.Transaction:=tran;
   qr.Transaction.Active:=true;
   sqls:='Select * from '+tbInterface+' where interface_id='+inttostr(interface_id);
   qr.SQL.Text:=sqls;
   qr.Active:=true;
   if not qr.IsEmpty then begin
     TBlobField(qr.FieldByName('code')).SaveToStream(ms);
     ms.Position:=0;
     ScriptEditor.Lines.LoadFromStream(ms);
     DSB.FillListMethodsFromEditor;
   end;  
  finally
   ms.Free;
   qr.Free;
   tran.Free;
  end;
end;

function FindGlobalComponentProc(const Name: string): TComponent;
begin
  Result:=nil;
end;

procedure TfmEditRBInterface.LoadFromBaseForms(interface_id: Integer);
var
  qr: TIBQuery;
  tran: TIBTransaction;
  sqls: string;
  ms: TMemoryStream;
  fm: TDesignForm;
  OldFind: TFindGlobalComponent;
begin
  qr:=TIBQuery.Create(nil);
  tran:=TIBTransaction.Create(nil);
  ms:=TMemoryStream.Create;
  try
   qr.Database:=IBDB;
   tran.AddDatabase(IBDB);
   IBDB.AddTransaction(tran);
   tran.Params.Text:=DefaultTransactionParamsTwo;
   qr.ParamCheck:=false;
   qr.Transaction:=tran;
   qr.Transaction.Active:=true;
   sqls:='Select * from '+tbInterfaceForm+' where interface_id='+inttostr(interface_id);
   qr.SQL.Text:=sqls;
   qr.Active:=true;
   qr.First;
   while not qr.Eof do begin
     ms.Clear;
     TBlobField(qr.FieldByName('form')).SaveToStream(ms);
     ms.Position:=0;
     fm:=DSB.CreateDesignFormStream(ms);
     fm.Name:=qr.FieldByName('name').AsString;
     qr.Next;
   end;
  finally
   OldFind:=FindGlobalComponent;
   FindGlobalComponent:=FindGlobalComponentProc;
   GlobalFixupReferences;
   FindGlobalComponent:=OldFind;
   ms.Free;
   qr.Free;
   tran.Free;
  end;
end;

procedure TfmEditRBInterface.LoadFromBaseDocuments(interface_id: Integer);
var
  qr: TIBQuery;
  tran: TIBTransaction;
  sqls: string;
  ms: TMemoryStream;
  fm: TDocumentForm;
begin
  qr:=TIBQuery.Create(nil);
  tran:=TIBTransaction.Create(nil);
  ms:=TMemoryStream.Create;
  try
   qr.Database:=IBDB;
   tran.AddDatabase(IBDB);
   IBDB.AddTransaction(tran);
   tran.Params.Text:=DefaultTransactionParamsTwo;
   qr.ParamCheck:=false;
   qr.Transaction:=tran;
   qr.Transaction.Active:=true;
   sqls:='Select * from '+tbInterfaceDocument+' where interface_id='+inttostr(interface_id);
   qr.SQL.Text:=sqls;
   qr.Active:=true;
   qr.First;
   while not qr.Eof do begin
     ms.Clear;
     TBlobField(qr.FieldByName('document')).SaveToStream(ms);
     ms.Position:=0;
     fm:=DFSB.CreateDocumentFormStream(ms);
     fm.RealyName:=qr.FieldByName('name').AsString;
     fm.edName.Text:=qr.FieldByName('name').AsString;
     fm.meHint.Lines.Text:=qr.FieldByName('hint').AsString;
     fm.edOleClass.Text:=qr.FieldByName('oleclass').AsString;
     qr.Next;
   end;  
  finally
   ms.Free;
   qr.Free;
   tran.Free;
  end;
end;

function TfmEditRBInterface.GetInterpreterItemIndexByGuid(GUID: String): Integer;
var
  i: integer;
  P: PInfoLibraryInterpreter;
begin
  Result:=-1;
  for i:=0 to cmbInterpreter.Items.Count-1 do begin
    P:=PInfoLibraryInterpreter(cmbInterpreter.Items.Objects[i]);
    if AnsiSameText(P.GUID,GUID) then begin
      Result:=i;
      exit;
    end;
  end;
end;

procedure TfmEditRBInterface.ScriptEditorCommand(Sender: TObject; Command: TEditCommand);
var
  oldText: string;
begin
  case Command of
    ecNewScript: begin
      ScriptEditor.Lines.Text:=fmOptions.RaEditor.Lines.Text;
      DSB.FillListMethodsFromEditor;
    end;
    ecOpenScript: begin
      odAll.Filter:=ConstFilterAllFiles;
      if not odAll.Execute then exit;
      Screen.Cursor:=CrHourGlass;
      try
       ScriptEditor.Lines.LoadFromFile(odAll.FileName);
       DSB.FillListMethodsFromEditor;
       ChangeFlag:=true;
      finally
        Screen.Cursor:=crDefault;
      end;
    end;
    ecSaveScript: begin
      if Trim(ScriptEditor.Lines.Text)='' then exit;
      sdAll.Filter:=ConstFilterPasFiles;
      sdAll.FileName:=edName.Text;
      sdAll.DefaultExt:=ConstDefaultPasExt;
      if not sdAll.Execute then exit;
      Screen.Cursor:=CrHourGlass;
      try
        DSB.PackMethods;
        ScriptEditor.Lines.SaveToFile(sdAll.FileName);
      finally
        Screen.Cursor:=crDefault;
      end;
    end;
    ecSaveScriptToBase: begin
      SaveToBaseScript;
    end;
    ecRunScript: begin
      InterpreterCreateAndRun;
    end;
    ecStopScript: begin
//
    end;
    ecResetScript: begin
      if InterpreterReset then
//         ViewScriptEditorMessage(ConstInterpreterReset,taliWarning,0);
    end;
    ecCompileScript: begin
//
    end;
    ecFind: begin
      fmFindDialog.rbSelected.Checked:=ScriptEditor.SelLength<>0;
      fmFindDialog.rbGlobal.Checked:=not fmFindDialog.rbSelected.Checked;
      fmFindDialog.rbEntire.Checked:=fmFindDialog.rbSelected.Checked;
      fmFindDialog.rbFromCursor.Checked:=not fmFindDialog.rbEntire.Checked;
      oldText:=fmFindDialog.cmbSearchText.Text;
      if fmFindDialog.rbSelected.Checked then begin
        fmFindDialog.cmbSearchText.Text:=ScriptEditor.SelText;
      end else begin
        fmFindDialog.cmbSearchText.Text:=ScriptEditor.GetWordFromCaret;
      end;
      if fmFindDialog.ShowModal=mrOk then begin
       LocalFindText(true);
      end else
       fmFindDialog.cmbSearchText.Text:=oldText;
    end;
    ecFindNext: begin
      LocalFindText(false);
    end;
    ecReplace: begin
      fmReplaceDialog.rbSelected.Checked:=ScriptEditor.SelLength<>0;
      fmReplaceDialog.rbGlobal.Checked:=not fmReplaceDialog.rbSelected.Checked;
      fmReplaceDialog.rbEntire.Checked:=fmReplaceDialog.rbSelected.Checked;
      fmReplaceDialog.rbFromCursor.Checked:=not fmReplaceDialog.rbEntire.Checked;
      oldText:=fmReplaceDialog.cmbSearchText.Text;
      if fmReplaceDialog.rbSelected.Checked then begin
        fmReplaceDialog.cmbSearchText.Text:=ScriptEditor.SelText;
      end else begin
        fmReplaceDialog.cmbSearchText.Text:=ScriptEditor.GetWordFromCaret;
      end;
      if fmReplaceDialog.ShowModal=mrOk then begin
       LocalReplaceText;
      end else
       fmReplaceDialog.cmbSearchText.Text:=oldText;
    end;
    ecGotoLine: begin
      fmGotoLine.MaxLine:=ScriptEditor.Lines.Count+1;
      if fmGotoLine.ShowModal=mrOk then begin
        ScriptEditor.SetCaret(0,strtoint(fmGotoLine.cmbLine.Text)-1);
        ScriptEditor.SetFocus;
      end;
    end;
    ecViewOption: begin
      _ViewOption(hOptionScript);
    end;
    ecViewForms: begin
      pcMain.ActivePage:=tbsForms;
    end;
  end;
end;

procedure TfmEditRBInterface.tlbStopScriptClick(Sender: TObject);
begin
  ScriptEditor.Command(ecStopScript);
end;

procedure TfmEditRBInterface.tlbCompileScriptClick(Sender: TObject);
begin
  ScriptEditor.Command(ecCompileScript);
end;

procedure TfmEditRBInterface.SaveToIni;
begin
  if not (TypeEditRBook in [terbAdd,terbChange]) then exit;

  if FormState=[fsCreatedMDIChild] then begin
   WriteParam(ClassName,'Left',Left);
   if WindowState<>wsMinimized then
    WriteParam(ClassName,'Top',Top);
   WriteParam(ClassName,'WindowState',Integer(WindowState));
  end;
  WriteParam(ClassName,'Width',Width);
  WriteParam(ClassName,'Height',Height);


  WriteParam(ClassName,'CompletionWidth',ScriptEditor.Completion.DropDownWidth);
  WriteParam(ClassName,'CompletionCount',ScriptEditor.Completion.DropDownCount);
end;

procedure TfmEditRBInterface.LoadFromIni;
begin
  if not (TypeEditRBook in [terbAdd,terbChange]) then exit;

  WindowState:=TWindowState(ReadParam(ClassName,'WindowState',Integer(WindowState)));
  if WindowState<>wsMaximized then begin
    Width:=ReadParam(ClassName,'Width',Width);
    Height:=ReadParam(ClassName,'Height',Height);
    Left:=ReadParam(ClassName,'Left',Left);
    Top:=ReadParam(ClassName,'Top',Top);
  end;

  ScriptEditor.Completion.DropDownWidth:=ReadParam(ClassName,'CompletionWidth',ScriptEditor.Completion.DropDownWidth);
  ScriptEditor.Completion.DropDownCount:=ReadParam(ClassName,'CompletionCount',ScriptEditor.Completion.DropDownCount);
end;

procedure TfmEditRBInterface.CreateWnd;
begin
  inherited;
end;

procedure TfmEditRBInterface.LoadFromBaseAll(interface_id: Integer);
var
  TCLI: TCreateLogItem;
begin
  if NotChangeLoaded then begin
   Screen.Cursor:=crHourGlass;
   try
     try
       LoadFromBaseScript(Interface_id);
       LoadFromBaseForms(Interface_id);
       LoadFromBaseDocuments(Interface_id);
       NotChangeLoaded:=false;
     except
       on E: Exception do begin
         TCLI.Text:=PChar(E.Message);
         TCLI.TypeLogItem:=tliError;
         TCLI.ViewLogItemProc:=nil;
         _CreateLogItem(@TCLI);
         _ViewLog(true);
       end;  
     end; 
   finally
     Screen.Cursor:=crDefault;
   end;
  end;
end;

procedure TfmEditRBInterface.CMShowingChanged(var Message: TMessage);
const
  ShowFlags: array[Boolean] of Word = (
    SWP_NOSIZE + SWP_NOMOVE + SWP_NOZORDER + SWP_NOACTIVATE + SWP_HIDEWINDOW,
    SWP_NOSIZE + SWP_NOMOVE + SWP_NOZORDER + SWP_NOACTIVATE + SWP_SHOWWINDOW);
const
  ShowCommands: array[TWindowState] of Integer =
    (SW_SHOWNORMAL, SW_SHOWMINNOACTIVE, SW_SHOWMAXIMIZED);
begin
  if FormState=[fsCreatedMDIChild] then begin
   if (TypeEditRBook=terbChange) then begin
     LoadFromBaseAll(oldInterface_id);
   end;  
   if WindowState = wsMaximized then begin
      SendMessage(Application.MainForm.ClientHandle, WM_MDIRESTORE, Handle, 0);
      ShowWindow(Handle, SW_SHOWMAXIMIZED);
   end else begin
      ShowWindow(Handle, ShowCommands[WindowState]);
      CallWindowProc(@DefMDIChildProc,Handle,WM_SIZE,SIZE_RESTORED,Width or (Height shl 16));
      BringToFront;
   end;
   SetWindowPos(Handle, 0, Left,Top,Width,Height, ShowFlags[true]);
   SendMessage(Application.MainForm.ClientHandle,WM_MDIREFRESHMENU, 0, 0);
  end else
   inherited;
end;

procedure TfmEditRBInterface.tlbSaveToBaseScriptClick(Sender: TObject);
begin
  ScriptEditor.Command(ecSaveScriptToBase);
end;

procedure TfmEditRBInterface.tlbSaveTobaseFormsClick(Sender: TObject);
begin
  DSB.RunDesignCommand(Sender,dkcSaveFormsToBase);
end;

function TfmEditRBInterface.GetChangeFlag: Boolean;
begin
  Result:=inherited ChangeFlag;
end;

procedure TfmEditRBInterface.SetChangeFlag(Value: Boolean);
begin
  inherited ChangeFlag:=Value;
  if Value then begin
    if TypeEditRBook=terbChange then begin
     tlbSaveToBaseScript.Enabled:=true;
     tlbSaveTobaseForms.Enabled:=true;
     tlbSaveToBaseDocuments.Enabled:=true;
    end;
  end;
end;

procedure TfmEditRBInterface.DSBOnChange(Sender: TObject);
begin
  ChangeFlag:=true;
end;

procedure fmEditRBInterfaceGetInterpreterIdentiferHintItemProc(Owner: Pointer; PGIII: PGetInterpreterIdentiferItem);stdcall;
var
  I: Integer;
  fm: TfmEditRBInterface;
  hc: TtsvHintExCaption;
begin
  if not isValidPointer(Owner) then exit;
  if not isValidPointer(PGIII) then exit;
  fm:=TfmEditRBInterface(Owner);

  if AnsiSameText(PGIII.Caption,fm.IdentiferHint) then begin

    fm.ScriptEditor.Hint:=PGIII.Caption;
    fm.HintEx.Caption.Text:=PGIII.Caption;

    if isValidPointer(PGIII.Brush) then fm.HintEx.StartColor:=PGIII.Brush.Color;
    if isValidPointer(PGIII.Font) then fm.HintEx.Font.Assign(PGIII.Font);
    if isValidPointer(PGIII.Pen) then fm.HintEx.Pen.Assign(PGIII.Pen);

    if not isValidPointer(@PGIII.CaptionEx) then exit;
    if Abs(High(PGIII.CaptionEx)-Low(PGIII.CaptionEx))>-1 then
      fm.ScriptEditor.Hint:='';
    for i:=Low(PGIII.CaptionEx) to High(PGIII.CaptionEx) do begin
      if isValidPointer(PGIII.CaptionEx[i]) then begin
        hc:=fm.HintEx.Captions.Add;
        hc.Caption:=ChangeString(PGIII.CaptionEx[i].Caption,#13#10,' ');
        if i=Low(PGIII.CaptionEx) then hc.Caption:=hc.Caption+' ';
        fm.ScriptEditor.Hint:=fm.ScriptEditor.Hint+hc.Caption;
        hc.Alignment:=PGIII.CaptionEx[i].Alignment;
        hc.AutoSize:=true;
        hc.Width:=PGIII.CaptionEx[i].Width;
//        if isValidPointer(PGIII.CaptionEx[i].Brush) then hc.Brush.Assign(PGIII.CaptionEx[i].Brush);
        if isValidPointer(PGIII.CaptionEx[i].Font) then hc.Font.Assign(PGIII.CaptionEx[i].Font);
        if isValidPointer(PGIII.CaptionEx[i].Pen) then hc.Pen.Assign(PGIII.CaptionEx[i].Pen);
      end;
    end;

  end;

end;

procedure TfmEditRBInterface.ScriptEditorIdentiferHint(Sender: TObject; const Identifer: string; const PosBegin,PosEnd,X,Y: Integer);

  procedure FillListLocalVars(List: TList);
  var
    TCIV: TCreateInterpreterVar;
    h: THandle;
    i: Integer;
    fm: TForm;
    s: string;
    hLast: Thandle;
  begin
    hLast:=INTERPRETERVAR_INVALID_HANDLE;
    for i:=0 to DSB.ListForms.Count-1 do begin
     fm:=DSB.ListForms.Items[i];
     FillChar(TCIV,SizeOf(TCIV),0);
     TCIV.Identifer:=PChar(fm.Name);
     TCIV.Value:=O2V(fm);
     TCIV.TypeValue:=C2V(fm.ClassType);
     s:=fm.ClassName;
     TCIV.TypeText:=PChar(s);
     TCIV.Hint:=PChar(fm.Hint);
     if i=0 then TCIV.TypeCreate:=tcFirst
     else begin
       TCIV.TypeCreate:=tcAfter;
       TCIV.hCreate:=hLast;
     end; 
     h:=_CreateInterpreterVar(@TCIV);
     hLast:=h;
     List.Add(Pointer(h));
    end; 
  end;

  procedure ClearHint;
  begin
    Application.CancelHint;
    HintEx.Caption.Clear;
    HintEx.Captions.Clear;
    ScriptEditor.Hint:='';
  end;

var
  P: PInfoLibraryInterpreter;
  Pos: Integer;
  TGIIP: TGetInterpreterIdentiferParams;
  ListLocalVars: TList;
  i: Integer;
  s: string;
begin
  
  if not isValidInterpreter then exit;
  if Trim(Identifer)<>'' then begin
    s:=Copy(ScriptEditor.Lines.Text,PosBegin,Length(Identifer));
  end else begin
    s:='';
  end;

//  Memo1.Lines.Add(Iff(s='','�����',s));
  ClearHint;
  if Trim(s)='' then exit;
  IdentiferHint:=s;

  Screen.Cursor:=crHourGlass;
  P:=GetActiveLibraryInterpreter;
  Pos:=Length(IdentiferHint)+PosBegin-1;
  ListLocalVars:=TList.Create;
  try
    FillListLocalVars(ListLocalVars);
    FillChar(TGIIP,SizeOf(TGIIP),0);
    TGIIP.Code:=ScriptEditor.Lines.GetText;
    TGIIP.Pos:=Pos;
    TGIIP.GetInterpreterIdentiferItemProc:=fmEditRBInterfaceGetInterpreterIdentiferHintItemProc;
    TGIIP.DesignClassType:=TDesignComponent;
    TGIIP.ColorVar:=TtsvColorBox(fmOptions.cmbIdentiferColorVar).Selected;
    TGIIP.ColorProcedure:=TtsvColorBox(fmOptions.cmbIdentiferColorProcedure).Selected;
    TGIIP.ColorFunction:=TtsvColorBox(fmOptions.cmbIdentiferColorFunction).Selected;
    TGIIP.ColorType:=TtsvColorBox(fmOptions.cmbIdentiferColorType).Selected;
    TGIIP.ColorProperty:=TtsvColorBox(fmOptions.cmbIdentiferColorProperty).Selected;
    TGIIP.ColorConst:=TtsvColorBox(fmOptions.cmbIdentiferColorConst).Selected;
    TGIIP.ColorBackGround:=TtsvColorBox(fmOptions.cmbIdentiferColorBackGround).Selected;
    TGIIP.ColorCaption:=TtsvColorBox(fmOptions.cmbIdentiferColorCaption).Selected;
    TGIIP.ColorParams:=TtsvColorBox(fmOptions.cmbIdentiferColorParam).Selected;
    TGIIP.ColorHint:=TtsvColorBox(fmOptions.cmbIdentiferColorHint).Selected;
    P.GetInterpreterIdentifersProc(Self,@TGIIP);
  finally
    for i:=0 to ListLocalVars.Count-1 do
      _FreeInterpreterVar(THandle(ListLocalVars.Items[i]));
    Screen.Cursor:=crDefault;
  end;
end;

procedure TfmEditRBInterface.tlbSaveToBaseDocumentsClick(Sender: TObject);
begin
  DFSB.RunDocumentFormCommand(nil,dfcSaveToBaseDocuments);
end;

procedure TfmEditRBInterface.cmbTypeInterfaceChange(Sender: TObject);
begin
  if cmbTypeInterface.ItemIndex in [Integer(ttiNone)..Integer(ttiHelp)] then begin
    DTC.FillDesignPalettes(TTypeInterface(cmbTypeInterface.ItemIndex));
  end;  
end;

procedure TfmEditRBInterface.bibSaveINterfaceClick(Sender: TObject);
begin
  SaveInterface;
end;

procedure TfmEditRBInterface.SaveInterface;
var
  fs: TFileStream;
begin
  sdAll.Filter:=ConstFilterInterfaceFiles;
  sdAll.DefaultExt:=ConstDefaultInterfaceExt;
  sdAll.FileName:=Trim(edName.Text);
  if not sdAll.Execute then exit;
  Screen.Cursor:=crHourGlass;
  fs:=nil;
  try
    fs:=TFileStream.Create(sdAll.FileName,fmCreate);
    SaveInterfaceToStream(fs);
  finally
    fs.Free;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TfmEditRBInterface.SaveInterfaceToStream(Stream: TStream);
var
  wr: TWriter;
  ms: TMemoryStream;

  procedure SaveHeader;
  var
    P: PInfoLibraryInterpreter;
  begin
    wr.WriteInteger(ConstInterfaceVersion_1);
    wr.WriteString(Trim(edName.Text));
    wr.WriteString(Trim(meHint.Lines.Text));
    wr.WriteInteger(cmbTypeInterface.ItemIndex);
    wr.WriteBoolean(chbChangeFlag.Checked);
    wr.WriteBoolean(chbAutoRun.Checked);
    wr.WriteInteger(udPriority.Position);
    P:=GetActiveLibraryInterpreter;
    wr.WriteString(iff(P<>nil,P.GUID,''));
  end;

  procedure SaveScript;
  begin
    ms.Clear;
    DSB.PackMethods;
    ScriptEditor.Lines.SaveToStream(ms);
    wr.WriteInteger(ms.Size);
    wr.Write(ms.Memory^,ms.Size);
  end;

  procedure SaveForms;
  var
    i: Integer;
    fm: TDesignForm;
  begin
    wr.WriteInteger(DSB.ListForms.Count);
    for i:=0 to DSB.ListForms.Count-1 do begin
      fm:=DSB.ListForms.Items[i];
      ms.Clear;
      fm.SaveToStream(ms);
      wr.WriteInteger(ms.Size);
      wr.Write(ms.Memory^,ms.Size);
      wr.WriteString(Trim(fm.Name));
     end;
  end;

  procedure SaveDocuments;
  var
    fm: TDocumentForm;
    i: Integer;
  begin
    wr.WriteInteger(DFSB.ListForms.Count);
    for i:=0 to DFSB.ListForms.Count-1 do begin
      fm:=DFSB.ListForms.Items[i];
      ms.Clear;
      fm.SaveToStream(ms);
      wr.WriteInteger(ms.Size);
      wr.Write(ms.Memory^,ms.Size);
      wr.WriteString(Trim(fm.edName.Text));
      wr.WriteString(Trim(fm.meHint.Lines.text));
      wr.WriteString(Trim(fm.edOleClass.Text));
    end;
  end;


begin
  wr:=TWriter.Create(Stream,4096);
  ms:=TMemoryStream.Create;
  try
    SaveHeader;
    SaveScript;
    SaveForms;
    SaveDocuments;
  finally
    ms.Free;
    wr.Free;
  end;
end;

procedure TfmEditRBInterface.bibLoadInterfaceClick(Sender: TObject);
begin
  LoadInterface;
end;

procedure TfmEditRBInterface.ClearAll;
begin
  ClearListInterpreterPos;
  DSB.ClearListForms;
  ScriptEditor.Lines.Clear;
  DSB.ClearListMethods;
  DFSB.ClearListForms;
end;

procedure TfmEditRBInterface.LoadInterface;
var
  fs: TFileStream;
begin
  if ShowQuestionEx(ConstFmtYourRealyLoadInterface)=mrNo then exit;
  odAll.Filter:=ConstFilterInterfaceFiles;
  odAll.DefaultExt:=ConstDefaultInterfaceExt;
  if not odAll.Execute then exit;
  Screen.Cursor:=crHourGlass;
  fs:=nil;
  try
    fs:=TFileStream.Create(odAll.FileName,fmOpenRead);
    ClearAll;
    LoadInterfaceFromStream(fs);
  finally
    fs.Free;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TfmEditRBInterface.LoadInterfaceFromStream(Stream: TStream);
var
  rd: TReader;
  ms: TMemoryStream;
  V: Integer;

  procedure LoadHeader;
  begin
    V:=rd.ReadInteger;
    if V=ConstInterfaceVersion_1 then begin
      edName.Text:=rd.ReadString;
      meHint.Lines.Text:=rd.ReadString;
      cmbTypeInterface.ItemIndex:=rd.ReadInteger;
      chbChangeFlag.Checked:=rd.ReadBoolean;
      chbAutoRun.Checked:=rd.ReadBoolean;
      udPriority.Position:=rd.ReadInteger;
      cmbInterpreter.ItemIndex:=GetInterpreterItemIndexByGuid(rd.ReadString);
    end;
  end;

  procedure LoadScript;
  begin
    if V=ConstInterfaceVersion_1 then begin
      ms.Clear;
      ms.SetSize(rd.ReadInteger);
      rd.Read(ms.Memory^,ms.Size);
      ms.Position:=0;
      ScriptEditor.Lines.LoadFromStream(ms);
      DSB.FillListMethodsFromEditor;
    end;
  end;

  procedure LoadForms;
  var
    i: Integer;
    rCount: Integer;
    fm: TDesignForm;
  begin
    if V=ConstInterfaceVersion_1 then begin
     rCount:=rd.ReadInteger;
     for i:=0 to rCount-1 do begin
       ms.Clear;
       ms.SetSize(rd.ReadInteger);
       rd.Read(ms.Memory^,ms.Size);
       ms.Position:=0;
       fm:=DSB.CreateDesignFormStream(ms);
       fm.Name:=rd.ReadString;
     end;  
    end;
  end;

  procedure LoadDocuments;
  var
    i: Integer;
    rCount: Integer;
    fm: TDocumentForm;
  begin
    if V=ConstInterfaceVersion_1 then begin
     rCount:=rd.ReadInteger;
     for i:=0 to rCount-1 do begin
       ms.Clear;
       ms.SetSize(rd.ReadInteger);
       rd.Read(ms.Memory^,ms.Size);
       ms.Position:=0;
       fm:=DFSB.CreateDocumentFormStream(ms);
       fm.edName.Text:=rd.ReadString;
       fm.RealyName:=fm.edName.Text;
       fm.meHint.Lines.text:=rd.ReadString;
       fm.edOleClass.Text:=rd.ReadString;
     end;
    end;
  end;

begin
  rd:=TReader.Create(Stream,4096);
  ms:=TMemoryStream.Create;
  try
    LoadHeader;
    LoadScript;
    LoadForms;
    LoadDocuments;
  finally
    ms.Free;
    rd.Free;
  end;
end;

end.



