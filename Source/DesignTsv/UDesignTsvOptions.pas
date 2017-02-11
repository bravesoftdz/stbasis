unit UDesignTsvOptions;

interface

{$I stbasis.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, Buttons, IBServices, CheckLst,
  menus, ImgList, Grids, IBQuery, IBDatabase, RAHLEditor,
  RAEditor, tsvDesignForm;

type

  TRASampleViewer = class(TRAHLEditor)
  private
    TmpEd : TRAHLEditor;
    procedure SetCurrentAttr(isMouse: Boolean; XPos,YPos: Integer);
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMKeyUp(var Message: TWMKeyUp); message WM_KEYUP;
  protected
    procedure WndProc(var Message: TMessage); override;
  public

    constructor Create(AOwner: TComponent); override;
  end;

  TfmOptions = class(TForm)
    ilShortCut: TImageList;
    ilOptions: TImageList;
    pc: TPageControl;
    tsScript: TTabSheet;
    pnScript: TPanel;
    pnScriptBottom: TPanel;
    grbScriptPreview: TGroupBox;
    pnScriptRAEditor: TPanel;
    pcScript: TPageControl;
    tbsScriptHigh: TTabSheet;
    tbsScriptGeneral: TTabSheet;
    lbScriptTypeHigh: TLabel;
    lbScriptRElement: TLabel;
    cmbScriptTypeHigh: TComboBox;
    cmbScriptRElement: TComboBox;
    grbScriptColors: TGroupBox;
    lbScriptFGColor: TLabel;
    lbScriptBGColor: TLabel;
    cmbScriptFGColor: TComboBox;
    cmbScriptBGColor: TComboBox;
    grbScriptTextAttr: TGroupBox;
    chbScriptTextAttrBold: TCheckBox;
    chbScriptTextAttrItalic: TCheckBox;
    chbScriptTextAttrUnderline: TCheckBox;
    grbScriptFont: TGroupBox;
    lbScriptFontName: TLabel;
    lbScriptFontSize: TLabel;
    cmbScriptFontName: TComboBox;
    edScriptFontSize: TEdit;
    udScriptFontSize: TUpDown;
    lbScriptTabStops: TLabel;
    edScriptTabStops: TEdit;
    cbScriptUndoAfterSave: TCheckBox;
    cbScriptDoubleClickLine: TCheckBox;
    cbScriptKeepTrailingBlanks: TCheckBox;
    cbScriptSytaxHighlighting: TCheckBox;
    cbScriptAutoIndent: TCheckBox;
    cbScriptSmartTab: TCheckBox;
    cbScriptBackspaceUnindents: TCheckBox;
    cbScriptGroupUndo: TCheckBox;
    cbScriptCursorBeyondEOF: TCheckBox;
    tbsScriptCodeIns: TTabSheet;
    lbScriptGutterWidth: TLabel;
    edScriptGutterWidth: TEdit;
    udScriptGutterWidth: TUpDown;
    lbScriptRightMargin: TLabel;
    edScriptRightMargin: TEdit;
    udScriptRightMargin: TUpDown;
    cbScriptRightMarginVisisble: TCheckBox;
    lbScriptSelBlockFormat: TLabel;
    cmbScriptSelBlockFormat: TComboBox;
    tbsScriptKey: TTabSheet;
    edScriptAutoChange: TEdit;
    udScriptAutoChange: TUpDown;
    cbScriptAutoChange: TCheckBox;
    pnScriptCodeIns: TPanel;
    Panel1: TPanel;
    bibScriptAddCodeIns: TButton;
    bibScriptEditCodeIns: TButton;
    bibScriptDelCodeIns: TButton;
    bibScriptResetCodeIns: TButton;
    Panel2: TPanel;
    lvScriptCodeIns: TListView;
    pnScriptBackRAEditorCodeIns: TPanel;
    Bevel1: TBevel;
    Panel3: TPanel;
    lvScriptKey: TListView;
    Panel4: TPanel;
    bibScriptAddKey: TButton;
    bibScriptChangeKey: TButton;
    bibScriptDelKey: TButton;
    bibScriptResetKey: TButton;
    tsForms: TTabSheet;
    pnForms: TPanel;
    pcForms: TPageControl;
    tsFormsGeneral: TTabSheet;
    tsFormsObjInsp: TTabSheet;
    tsFormsKeys: TTabSheet;
    grbRBRFHints: TGroupBox;
    grbRBRFGrid: TGroupBox;
    chbRBRFHintsControl: TCheckBox;
    chbRBRFHintsSize: TCheckBox;
    chbRBRFHintsMove: TCheckBox;
    chbRBRFHintsInsert: TCheckBox;
    chbRBRFGridVisible: TCheckBox;
    lbRBRFGridXStep: TLabel;
    edRBRFGridXStep: TEdit;
    udRBRFGridXStep: TUpDown;
    lbRBRFGridYStep: TLabel;
    edRBRFGridYStep: TEdit;
    udRBRFGridYStep: TUpDown;
    chbRBRFGridAlign: TCheckBox;
    lbRBRFGridColor: TLabel;
    cmbRBRFGridColor: TComboBox;
    grbRBRFColors: TGroupBox;
    lbRBRFColorsCurrent: TLabel;
    cmbRBRFColorsCurrent: TComboBox;
    lbRBRFColors: TListBox;
    chbRBRFTranslate: TCheckBox;
    pnRBRFKeys: TPanel;
    lvRBRFKeys: TListView;
    pnRBRFKeysButton: TPanel;
    bibRBRFKeysAdd: TButton;
    bibRBRFKeysChange: TButton;
    bibRBRFKeysDelete: TButton;
    bibRBRFKeysReset: TButton;
    lbRBRFSizeHandle: TLabel;
    edRBRFSizeHandle: TEdit;
    udRBRFSizeHandle: TUpDown;
    tsDocs: TTabSheet;
    pnDocs: TPanel;
    tbsScriptOther: TTabSheet;
    pnIdentiferColors: TPanel;
    grbColorIdentifers: TGroupBox;
    lbIdentiferColorBackGround: TLabel;
    lbIdentiferColorVar: TLabel;
    lbIdentiferColorConst: TLabel;
    lbIdentiferColorFunction: TLabel;
    lbIdentiferColorProcedure: TLabel;
    cmbIdentiferColorBackGround: TComboBox;
    cmbIdentiferColorVar: TComboBox;
    cmbIdentiferColorConst: TComboBox;
    cmbIdentiferColorFunction: TComboBox;
    cmbIdentiferColorProcedure: TComboBox;
    lbIdentiferColorProperty: TLabel;
    cmbIdentiferColorProperty: TComboBox;
    lbIdentiferColorType: TLabel;
    cmbIdentiferColorType: TComboBox;
    lbIdentiferColorCaption: TLabel;
    cmbIdentiferColorCaption: TComboBox;
    lbIdentiferColorParam: TLabel;
    cmbIdentiferColorParam: TComboBox;
    lbIdentiferColorHint: TLabel;
    cmbIdentiferColorHint: TComboBox;
    od: TOpenDialog;
    sd: TSaveDialog;
    grbObjInspColor: TGroupBox;
    cmbObjColorValue: TComboBox;
    lbObjColorValue: TLabel;
    lbObjColorProperty: TLabel;
    cmbObjColorProperty: TComboBox;
    lbObjColorSubProperty: TLabel;
    cmbObjColorSubProperty: TComboBox;
    lbObjColorReference: TLabel;
    cmbObjColorReference: TComboBox;
    chbViewComponentCaption: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmbScriptRElementChange(Sender: TObject);
    procedure pcScriptChange(Sender: TObject);
    procedure bibScriptAddCodeInsClick(Sender: TObject);
    procedure lvScriptCodeInsChange(Sender: TObject;
      Item: TListItem; Change: TItemChange);
    procedure bibScriptDelCodeInsClick(Sender: TObject);
    procedure bibScriptEditCodeInsClick(Sender: TObject);
    procedure lvScriptCodeInsCustomDrawItem(
      Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure lvScriptCodeInsColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure lvScriptKeyColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure lvScriptCodeInsDblClick(Sender: TObject);
    procedure bibScriptAddKeyClick(Sender: TObject);
    procedure bibScriptDelKeyClick(Sender: TObject);
    procedure bibScriptChangeKeyClick(Sender: TObject);
    procedure lvScriptKeyDblClick(Sender: TObject);
    procedure bibScriptResetKeyClick(Sender: TObject);
    procedure bibScriptResetCodeInsClick(Sender: TObject);
    procedure lbRBRFColorsClick(Sender: TObject);
    procedure cmbRBRFColorsCurrentChange(Sender: TObject);
    procedure bibRBRFKeysAddClick(Sender: TObject);
    procedure bibRBRFKeysDeleteClick(Sender: TObject);
    procedure bibRBRFKeysResetClick(Sender: TObject);
    procedure bibRBRFKeysChangeClick(Sender: TObject);
    procedure lvRBRFKeysDblClick(Sender: TObject);
    procedure lvRBRFKeysColumnClick(Sender: TObject; Column: TListColumn);
    procedure cbScriptAutoIndentClick(Sender: TObject);
    procedure cbScriptSmartTabClick(Sender: TObject);
    procedure cbScriptBackspaceUnindentsClick(Sender: TObject);
    procedure cbScriptGroupUndoClick(Sender: TObject);
    procedure cbScriptCursorBeyondEOFClick(Sender: TObject);
    procedure cbScriptUndoAfterSaveClick(Sender: TObject);
    procedure cbScriptKeepTrailingBlanksClick(Sender: TObject);
    procedure cbScriptDoubleClickLineClick(Sender: TObject);
    procedure cbScriptSytaxHighlightingClick(Sender: TObject);
    procedure cbScriptRightMarginVisisbleClick(Sender: TObject);
    procedure cmbScriptSelBlockFormatChange(Sender: TObject);
    procedure edScriptTabStopsChange(Sender: TObject);
    procedure cbScriptAutoChangeClick(Sender: TObject);
    procedure cmbScriptTypeHighChange(Sender: TObject);
    procedure cmbScriptFontNameChange(Sender: TObject);
    procedure cmbScriptFGColorChange(Sender: TObject);
    procedure cmbScriptBGColorChange(Sender: TObject);
    procedure chbScriptTextAttrBoldClick(Sender: TObject);
    procedure chbScriptTextAttrItalicClick(Sender: TObject);
    procedure chbScriptTextAttrUnderlineClick(Sender: TObject);
    procedure udScriptRightMarginChangingEx(Sender: TObject;
      var AllowChange: Boolean; NewValue: Smallint;
      Direction: TUpDownDirection);
    procedure udScriptGutterWidthChangingEx(Sender: TObject;
      var AllowChange: Boolean; NewValue: Smallint;
      Direction: TUpDownDirection);
    procedure udScriptAutoChangeChangingEx(Sender: TObject;
      var AllowChange: Boolean; NewValue: Smallint;
      Direction: TUpDownDirection);
    procedure udScriptFontSizeChangingEx(Sender: TObject;
      var AllowChange: Boolean; NewValue: Smallint;
      Direction: TUpDownDirection);
    procedure grbScriptPreviewDblClick(Sender: TObject);
  private
    glSortSubItem:integer;
    glSortForward:boolean;
    glSortSubItemKey:integer;
    glSortForwardKey:boolean;
    glSortSubItemFormsKey:integer;
    glSortForwardFormsKey:boolean;
    FDSB: TDesignScrollBox;
    procedure SetSettingsFromRaEditorScript;
    procedure ClearListTemplates;
    procedure SetTemplatesToListView;
    procedure lvCompareStr(Sender: TObject; Item1, Item2: TListItem;
                           Data: Integer; var Compare: Integer);
    procedure lvCompareStrKey(Sender: TObject; Item1, Item2: TListItem;
                           Data: Integer; var Compare: Integer);
    procedure lvCompareStrFormsKey(Sender: TObject; Item1, Item2: TListItem;
                           Data: Integer; var Compare: Integer);
    procedure SetShortCutToListView;
    procedure SetFormsKeyToListView;
    procedure ClearFormsKeyListView;



    procedure SetDefaultChangeEventToScript(isEnabled: Boolean);
    procedure SetScriptColors;
    procedure SetDefaultScriptEditorTSVParams;
  public
    RaEditor: TRASampleViewer;
    RaEditorCodeIns: TRAHLEditor;
    procedure LoadFromIni(OptionHandle: THandle);
    procedure SaveToIni(OptionHandle: THandle);
  end;

var
  fmOptions: TfmOptions;

implementation


uses UMainUnited, UDesignTsvCode, UDesignTsvData, tsvColorBox, tsvFontBox,
     UEditOptionsRbInterfaceScript, UEditOptionsKeyRBInterfaceForms,
     UEditOptionsKeyRBInterfaceScript;

type
  PInfoListTemplate=^TInfoListTemplate;
  TInfoListTemplate=packed record
     Code: String;
  end;

{$R *.DFM}

constructor TRASampleViewer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TmpEd := TRAHLEditor.Create(Self);
  TmpEd.Visible := False;
  TmpEd.Parent := Self;
end;

procedure TRASampleViewer.SetCurrentAttr(isMouse: Boolean; XPos,YPos: Integer);
var
  XX, YY: integer;
  F: integer;
  Str : string;
  XPosNew: Integer;
begin
  if fmOptions=nil then exit;
  if isMouse then begin
    Mouse2Caret(XPos, YPos, XX, YY);
    XPosNew:=XPos;
  end else begin
    XX:=XPos;
    YY:=YPos;
    XPosNew:=GutterWidth+1;
  end;
  if (YY=-1)or(XX=-1) then exit;
  if (XX = RightMargin) or (XX - 1 = RightMargin) then
    F:=13
  else if(XPosNew<=GutterWidth)then
    F:=14
  else begin
    TmpEd.Lines := Lines;
    TmpEd.HighLighter := HighLighter;
    TmpEd.Font.Color := 0;
    TmpEd.Colors.Comment.ForeColor := 1;
    TmpEd.Colors.Reserved.ForeColor := 2;
    TmpEd.Colors.Identifer.ForeColor := 3;
    TmpEd.Colors.Symbol.ForeColor := 4;
    TmpEd.Colors.Strings.ForeColor := 5;
    TmpEd.Colors.Number.ForeColor := 6;
    TmpEd.Colors.Preproc.ForeColor := 7;
    TmpEd.Colors.Declaration.ForeColor := 8;
    TmpEd.Colors.FunctionCall.ForeColor := 9;
    TmpEd.Colors.Statement.ForeColor := 10;
    TmpEd.Colors.PlainText.ForeColor := 11;
    TmpEd.SelForeColor := 12;
    if TmpEd.Lines.Count>0 then begin
     Str := TmpEd.Lines[YY];
     TRASampleViewer(TmpEd).GetLineAttr(Str, YY, 0, RAEditor.Max_X - 1);
     F := TRASampleViewer(TmpEd).LineAttrs[XX].FC;
    end else F:=0; 
  end;
  fmOptions.cmbScriptRElement.ItemIndex:=F;
  fmOptions.cmbScriptRElement.OnChange(nil);
end;

procedure TRASampleViewer.WMLButtonDown(var Message: TWMLButtonDown);
begin
  SetCurrentAttr(True,Message.XPos,Message.YPos);
  inherited;
end;

procedure TRASampleViewer.WMKeyUp(var Message: TWMKeyUp);
begin
  SetCurrentAttr(False,CaretX,CaretY);
  inherited;
end;

procedure TRASampleViewer.WndProc(var Message: TMessage);
begin
  inherited;
end;

procedure TfmOptions.FormCreate(Sender: TObject);
var
  tmpCB: TTSVColorBox;
  tmpFB: TTSVFontBox;
begin
  Left:=ConstOptionLeft;
  Top:=ConstOptionTop;
  ClientWidth:=ConstOptionWidth;
  ClientHeight:=ConstOptionHeight;

  // script
   
  tmpCB:=TTSVColorBox.Create(nil);
  tmpCB.Parent:=cmbScriptFGColor.Parent;
  tmpCB.TabOrder:=cmbScriptFGColor.TabOrder;
  tmpCB.OnChange:=cmbScriptFGColor.OnChange;
  tmpCB.Style:=[cbStandardColors,cbExtendedColors,cbSystemColors,
                 cbIncludeNone,cbIncludeDefault,cbCustomColor,cbPrettyNames];
  tmpCB.SetBounds(cmbScriptFGColor.Left,cmbScriptFGColor.Top,
                   cmbScriptFGColor.Width,cmbScriptFGColor.Height);
  cmbScriptFGColor.Free;
  tmpCB.Name:='cmbScriptFGColor';
  cmbScriptFGColor:=TComboBox(tmpCB);

  tmpCB:=TTSVColorBox.Create(nil);
  tmpCB.Parent:=cmbScriptBGColor.Parent;
  tmpCB.TabOrder:=cmbScriptBGColor.TabOrder;
  tmpCB.OnChange:=cmbScriptBGColor.OnChange;
  tmpCB.Style:=[cbStandardColors,cbExtendedColors,cbSystemColors,
                 cbIncludeNone,cbIncludeDefault,cbCustomColor,cbPrettyNames];
  tmpCB.SetBounds(cmbScriptBGColor.Left,cmbScriptBGColor.Top,
                   cmbScriptBGColor.Width,cmbScriptBGColor.Height);
  cmbScriptBGColor.Free;
  tmpCB.Name:='cmbScriptBGColor';
  cmbScriptBGColor:=TComboBox(tmpCB);


  tmpCB:=TTSVColorBox.Create(nil);
  tmpCB.Parent:=cmbIdentiferColorBackGround.Parent;
  tmpCB.TabOrder:=cmbIdentiferColorBackGround.TabOrder;
  tmpCB.OnChange:=cmbIdentiferColorBackGround.OnChange;
  tmpCB.Style:=[cbStandardColors,cbExtendedColors,cbSystemColors,
                 cbIncludeNone,cbIncludeDefault,cbCustomColor,cbPrettyNames];
  tmpCB.SetBounds(cmbIdentiferColorBackGround.Left,cmbIdentiferColorBackGround.Top,
                   cmbIdentiferColorBackGround.Width,cmbIdentiferColorBackGround.Height);
  cmbIdentiferColorBackGround.Free;
  tmpCB.Name:='cmbIdentiferColorBackGround';
  tmpCB.Selected:=ConstColorBackGround;
  cmbIdentiferColorBackGround:=TComboBox(tmpCB);

  tmpCB:=TTSVColorBox.Create(nil);
  tmpCB.Parent:=cmbIdentiferColorVar.Parent;
  tmpCB.TabOrder:=cmbIdentiferColorVar.TabOrder;
  tmpCB.OnChange:=cmbIdentiferColorVar.OnChange;
  tmpCB.Style:=[cbStandardColors,cbExtendedColors,cbSystemColors,
                 cbIncludeNone,cbIncludeDefault,cbCustomColor,cbPrettyNames];
  tmpCB.SetBounds(cmbIdentiferColorVar.Left,cmbIdentiferColorVar.Top,
                   cmbIdentiferColorVar.Width,cmbIdentiferColorVar.Height);
  cmbIdentiferColorVar.Free;
  tmpCB.Name:='cmbIdentiferColorVar';
  tmpCB.Selected:=ConstColorVar;
  cmbIdentiferColorVar:=TComboBox(tmpCB);

  tmpCB:=TTSVColorBox.Create(nil);
  tmpCB.Parent:=cmbIdentiferColorConst.Parent;
  tmpCB.TabOrder:=cmbIdentiferColorConst.TabOrder;
  tmpCB.OnChange:=cmbIdentiferColorConst.OnChange;
  tmpCB.Style:=[cbStandardColors,cbExtendedColors,cbSystemColors,
                 cbIncludeNone,cbIncludeDefault,cbCustomColor,cbPrettyNames];
  tmpCB.SetBounds(cmbIdentiferColorConst.Left,cmbIdentiferColorConst.Top,
                   cmbIdentiferColorConst.Width,cmbIdentiferColorConst.Height);
  cmbIdentiferColorConst.Free;
  tmpCB.Name:='cmbIdentiferColorConst';
  tmpCB.Selected:=ConstColorConst;
  cmbIdentiferColorConst:=TComboBox(tmpCB);

  tmpCB:=TTSVColorBox.Create(nil);
  tmpCB.Parent:=cmbIdentiferColorFunction.Parent;
  tmpCB.TabOrder:=cmbIdentiferColorFunction.TabOrder;
  tmpCB.OnChange:=cmbIdentiferColorFunction.OnChange;
  tmpCB.Style:=[cbStandardColors,cbExtendedColors,cbSystemColors,
                 cbIncludeNone,cbIncludeDefault,cbCustomColor,cbPrettyNames];
  tmpCB.SetBounds(cmbIdentiferColorFunction.Left,cmbIdentiferColorFunction.Top,
                   cmbIdentiferColorFunction.Width,cmbIdentiferColorFunction.Height);
  cmbIdentiferColorFunction.Free;
  tmpCB.Name:='cmbIdentiferColorFunction';
  tmpCB.Selected:=ConstColorFunction;
  cmbIdentiferColorFunction:=TComboBox(tmpCB);

  tmpCB:=TTSVColorBox.Create(nil);
  tmpCB.Parent:=cmbIdentiferColorProcedure.Parent;
  tmpCB.TabOrder:=cmbIdentiferColorProcedure.TabOrder;
  tmpCB.OnChange:=cmbIdentiferColorProcedure.OnChange;
  tmpCB.Style:=[cbStandardColors,cbExtendedColors,cbSystemColors,
                 cbIncludeNone,cbIncludeDefault,cbCustomColor,cbPrettyNames];
  tmpCB.SetBounds(cmbIdentiferColorProcedure.Left,cmbIdentiferColorProcedure.Top,
                  cmbIdentiferColorProcedure.Width,cmbIdentiferColorProcedure.Height);
  cmbIdentiferColorProcedure.Free;
  tmpCB.Name:='cmbIdentiferColorProcedure';
  tmpCB.Selected:=ConstColorProcedure;
  cmbIdentiferColorProcedure:=TComboBox(tmpCB);

  tmpCB:=TTSVColorBox.Create(nil);
  tmpCB.Parent:=cmbIdentiferColorProperty.Parent;
  tmpCB.TabOrder:=cmbIdentiferColorProperty.TabOrder;
  tmpCB.OnChange:=cmbIdentiferColorProperty.OnChange;
  tmpCB.Style:=[cbStandardColors,cbExtendedColors,cbSystemColors,
                 cbIncludeNone,cbIncludeDefault,cbCustomColor,cbPrettyNames];
  tmpCB.SetBounds(cmbIdentiferColorProperty.Left,cmbIdentiferColorProperty.Top,
                  cmbIdentiferColorProperty.Width,cmbIdentiferColorProperty.Height);
  cmbIdentiferColorProperty.Free;
  tmpCB.Name:='cmbIdentiferColorProperty';
  tmpCB.Selected:=ConstColorProperty;
  cmbIdentiferColorProperty:=TComboBox(tmpCB);

  tmpCB:=TTSVColorBox.Create(nil);
  tmpCB.Parent:=cmbIdentiferColorType.Parent;
  tmpCB.TabOrder:=cmbIdentiferColorType.TabOrder;
  tmpCB.OnChange:=cmbIdentiferColorType.OnChange;
  tmpCB.Style:=[cbStandardColors,cbExtendedColors,cbSystemColors,
                 cbIncludeNone,cbIncludeDefault,cbCustomColor,cbPrettyNames];
  tmpCB.SetBounds(cmbIdentiferColorType.Left,cmbIdentiferColorType.Top,
                  cmbIdentiferColorType.Width,cmbIdentiferColorType.Height);
  cmbIdentiferColorType.Free;
  tmpCB.Name:='cmbIdentiferColorType';
  tmpCB.Selected:=ConstColorType;
  cmbIdentiferColorType:=TComboBox(tmpCB);

  tmpCB:=TTSVColorBox.Create(nil);
  tmpCB.Parent:=cmbIdentiferColorCaption.Parent;
  tmpCB.TabOrder:=cmbIdentiferColorCaption.TabOrder;
  tmpCB.OnChange:=cmbIdentiferColorCaption.OnChange;
  tmpCB.Style:=[cbStandardColors,cbExtendedColors,cbSystemColors,
                 cbIncludeNone,cbIncludeDefault,cbCustomColor,cbPrettyNames];
  tmpCB.SetBounds(cmbIdentiferColorCaption.Left,cmbIdentiferColorCaption.Top,
                  cmbIdentiferColorCaption.Width,cmbIdentiferColorCaption.Height);
  cmbIdentiferColorCaption.Free;
  tmpCB.Name:='cmbIdentiferColorCaption';
  tmpCB.Selected:=ConstColorCaption;
  cmbIdentiferColorCaption:=TComboBox(tmpCB);

  tmpCB:=TTSVColorBox.Create(nil);
  tmpCB.Parent:=cmbIdentiferColorParam.Parent;
  tmpCB.TabOrder:=cmbIdentiferColorParam.TabOrder;
  tmpCB.OnChange:=cmbIdentiferColorParam.OnChange;
  tmpCB.Style:=[cbStandardColors,cbExtendedColors,cbSystemColors,
                 cbIncludeNone,cbIncludeDefault,cbCustomColor,cbPrettyNames];
  tmpCB.SetBounds(cmbIdentiferColorParam.Left,cmbIdentiferColorParam.Top,
                  cmbIdentiferColorParam.Width,cmbIdentiferColorParam.Height);
  cmbIdentiferColorParam.Free;
  tmpCB.Name:='cmbIdentiferColorParam';
  tmpCB.Selected:=ConstColorParams;
  cmbIdentiferColorParam:=TComboBox(tmpCB);

  tmpCB:=TTSVColorBox.Create(nil);
  tmpCB.Parent:=cmbIdentiferColorHint.Parent;
  tmpCB.TabOrder:=cmbIdentiferColorHint.TabOrder;
  tmpCB.OnChange:=cmbIdentiferColorHint.OnChange;
  tmpCB.Style:=[cbStandardColors,cbExtendedColors,cbSystemColors,
                 cbIncludeNone,cbIncludeDefault,cbCustomColor,cbPrettyNames];
  tmpCB.SetBounds(cmbIdentiferColorHint.Left,cmbIdentiferColorHint.Top,
                  cmbIdentiferColorHint.Width,cmbIdentiferColorHint.Height);
  cmbIdentiferColorHint.Free;
  tmpCB.Name:='cmbIdentiferColorHint';
  tmpCB.Selected:=ConstColorHint;
  cmbIdentiferColorHint:=TComboBox(tmpCB);

  tmpFB:=TTSVFontBox.Create(nil);
  tmpFB.Parent:=cmbScriptFontName.Parent;
  tmpFB.TabOrder:=cmbScriptFontName.TabOrder;
  tmpFB.OnChange:=cmbScriptFontName.OnChange;
  tmpFB.SetBounds(cmbScriptFontName.Left,cmbScriptFontName.Top,
                  cmbScriptFontName.Width,cmbScriptFontName.Height);
  cmbScriptFontName.Free;
  tmpFB.Name:='cmbScriptFontName';
  tmpFB.Preview.Visible:=false;
  cmbScriptFontName:=TComboBox(tmpFB);

  RaEditor:=TRASampleViewer.Create(nil);
  RaEditor.Parent:=pnScriptRAEditor;
  RaEditor.Align:=alClient;
  RaEditor.Lines.Text:=ConstDefaultRAEditorText;
  RaEditor.GutterWidth:=30;

  RaEditorCodeIns:=TRAHLEditor.Create(nil);
  RaEditorCodeIns.parent:=pnScriptBackRAEditorCodeIns;
  RaEditorCodeIns.ReadOnly:=true;
  RaEditorCodeIns.Align:=alClient;


  cmbScriptTypeHigh.ItemIndex:=0;
  cmbScriptRElement.ItemIndex:=0;
  SetSettingsFromRaEditorScript;
  SetTemplatesToListView;
  SetShortCutToListView;
  pcScript.ActivePage:=tbsScriptGeneral;

  // forms

  tmpCB:=TTSVColorBox.Create(nil);
  tmpCB.Parent:=cmbRBRFGridColor.Parent;
  tmpCB.TabOrder:=cmbRBRFGridColor.TabOrder;
  tmpCB.OnChange:=cmbRBRFGridColor.OnChange;
  tmpCB.Style:=[cbStandardColors,cbExtendedColors,cbSystemColors,
                 cbIncludeNone,cbIncludeDefault,cbCustomColor,cbPrettyNames];
  tmpCB.SetBounds(cmbRBRFGridColor.Left,cmbRBRFGridColor.Top,
                  cmbRBRFGridColor.Width,cmbRBRFGridColor.Height);
  cmbRBRFGridColor.Free;
  tmpCB.Name:='cmbRBRFGridColor';
  cmbRBRFGridColor:=TComboBox(tmpCB);
  tmpCB.Selected:=clBlack;

  tmpCB:=TTSVColorBox.Create(nil);
  tmpCB.Parent:=cmbRBRFColorsCurrent.Parent;
  tmpCB.TabOrder:=cmbRBRFColorsCurrent.TabOrder;
  tmpCB.OnChange:=cmbRBRFColorsCurrent.OnChange;
  tmpCB.Style:=[cbStandardColors,cbExtendedColors,cbSystemColors,
                 cbIncludeNone,cbIncludeDefault,cbCustomColor,cbPrettyNames];
  tmpCB.SetBounds(cmbRBRFColorsCurrent.Left,cmbRBRFColorsCurrent.Top,
                  cmbRBRFColorsCurrent.Width,cmbRBRFColorsCurrent.Height);
  cmbRBRFColorsCurrent.Free;
  tmpCB.Name:='cmbRBRFColorsCurrent';
  cmbRBRFColorsCurrent:=TComboBox(tmpCB);
  tmpCB.Selected:=clBlack;

  lbRBRFColors.Items.Clear;
  lbRBRFColors.Items.AddObject(ConstRBRFColorsHandleClr,TObject(clBlack));
  lbRBRFColors.Items.AddObject(ConstRBRFColorsHandleBorderClr,TObject(clBlack));
  lbRBRFColors.Items.AddObject(ConstRBRFColorsMultySelectHandleClr,TObject(clGray));
  lbRBRFColors.Items.AddObject(ConstRBRFColorsMultySelectHandleBorderClr,TObject(clGray));
  lbRBRFColors.Items.AddObject(ConstRBRFColorsInactiveHandleClr,TObject(clGray));
  lbRBRFColors.Items.AddObject(ConstRBRFColorsInactiveHandleBorderClr,TObject(clBlack));
  lbRBRFColors.Items.AddObject(ConstRBRFColorsLockedHandleClr,TObject(clRed));
  lbRBRFColors.ItemIndex:=0;

  tmpCB:=TTSVColorBox.Create(nil);
  tmpCB.Parent:=cmbObjColorProperty.Parent;
  tmpCB.TabOrder:=cmbObjColorProperty.TabOrder;
  tmpCB.OnChange:=cmbObjColorProperty.OnChange;
  tmpCB.Enabled:=cmbObjColorProperty.Enabled;
  tmpCB.Style:=[cbStandardColors,cbExtendedColors,cbSystemColors,
                 cbIncludeNone,cbIncludeDefault,cbCustomColor,cbPrettyNames];
  tmpCB.SetBounds(cmbObjColorProperty.Left,cmbObjColorProperty.Top,
                  cmbObjColorProperty.Width,cmbObjColorProperty.Height);
  cmbObjColorProperty.Free;
  tmpCB.Name:='cmbObjColorProperty';
  cmbObjColorProperty:=TComboBox(tmpCB);
  tmpCB.Selected:=clBlack;

  tmpCB:=TTSVColorBox.Create(nil);
  tmpCB.Parent:=cmbObjColorSubProperty.Parent;
  tmpCB.TabOrder:=cmbObjColorSubProperty.TabOrder;
  tmpCB.OnChange:=cmbObjColorSubProperty.OnChange;
  tmpCB.Style:=[cbStandardColors,cbExtendedColors,cbSystemColors,
                 cbIncludeNone,cbIncludeDefault,cbCustomColor,cbPrettyNames];
  tmpCB.SetBounds(cmbObjColorSubProperty.Left,cmbObjColorSubProperty.Top,
                  cmbObjColorSubProperty.Width,cmbObjColorSubProperty.Height);
  cmbObjColorSubProperty.Free;
  tmpCB.Name:='cmbObjColorSubProperty';
  cmbObjColorSubProperty:=TComboBox(tmpCB);
  tmpCB.Selected:=clBtnShadow;

  tmpCB:=TTSVColorBox.Create(nil);
  tmpCB.Parent:=cmbObjColorReference.Parent;
  tmpCB.TabOrder:=cmbObjColorReference.TabOrder;
  tmpCB.OnChange:=cmbObjColorReference.OnChange;
  tmpCB.Style:=[cbStandardColors,cbExtendedColors,cbSystemColors,
                 cbIncludeNone,cbIncludeDefault,cbCustomColor,cbPrettyNames];
  tmpCB.SetBounds(cmbObjColorReference.Left,cmbObjColorReference.Top,
                  cmbObjColorReference.Width,cmbObjColorReference.Height);
  cmbObjColorReference.Free;
  tmpCB.Name:='cmbObjColorReference';
  cmbObjColorReference:=TComboBox(tmpCB);
  tmpCB.Selected:=clMaroon;

  tmpCB:=TTSVColorBox.Create(nil);
  tmpCB.Parent:=cmbObjColorValue.Parent;
  tmpCB.TabOrder:=cmbObjColorValue.TabOrder;
  tmpCB.OnChange:=cmbObjColorValue.OnChange;
  tmpCB.Style:=[cbStandardColors,cbExtendedColors,cbSystemColors,
                 cbIncludeNone,cbIncludeDefault,cbCustomColor,cbPrettyNames];
  tmpCB.SetBounds(cmbObjColorValue.Left,cmbObjColorValue.Top,
                  cmbObjColorValue.Width,cmbObjColorValue.Height);
  cmbObjColorValue.Free;
  tmpCB.Name:='cmbObjColorValue';
  cmbObjColorValue:=TComboBox(tmpCB);
  tmpCB.Selected:=clNavy;

  tmpCB:=TTSVColorBox.Create(nil);
  tmpCB.Parent:=cmbObjColorValue.Parent;
  tmpCB.TabOrder:=cmbObjColorValue.TabOrder;
  tmpCB.OnChange:=cmbObjColorValue.OnChange;
  tmpCB.Selected:=clBlack;
  tmpCB.Style:=[cbStandardColors,cbExtendedColors,cbSystemColors,
                 cbIncludeNone,cbIncludeDefault,cbCustomColor,cbPrettyNames];
  tmpCB.SetBounds(cmbObjColorValue.Left,cmbObjColorValue.Top,
                  cmbObjColorValue.Width,cmbObjColorValue.Height);
  cmbObjColorValue.Free;
  tmpCB.Name:='cmbObjColorValue';
  cmbObjColorValue:=TComboBox(tmpCB);
  tmpCB.Selected:=clNavy;

  FDSB:=TDesignScrollBox.Create(nil);
  SetFormsKeyToListView;

  pcForms.ActivePage:=tsFormsGeneral;

  LoadFromIni(OPTION_INVALID_HANDLE);

end;

procedure TfmOptions.LoadFromIni(OptionHandle: THandle);

  procedure LoadFromIniScript;

     procedure LoadScriptColors(clrs: TSymbolColor; inName: string);
     var
       ms: TMemoryStream;
       tmps: string;
       rwsc: TReadWriteSymbolColor;
     begin
       ms:=TMemoryStream.Create;
       rwsc:=TReadWriteSymbolColor.Create(nil);
       try
        try
         tmps:=ReadParam(ConstSectionOptions,inName,tmps);
         tmps:=HexStrToStr(tmps);
         ms.SetSize(Length(tmps));
         Move(Pointer(tmps)^,ms.Memory^,ms.Size);
         ms.Position:=0;
         ms.ReadComponent(rwsc);

         clrs.Assign(rwsc.SymbolColor);
        except
        end;
         
       finally
        rwsc.Free;
        ms.Free;
       end;
     end;

     procedure LoadScriptCodeIns;
     var
       i: Integer;
       li: TListItem;
       P: PInfoListTemplate;
       ms: TMemoryStream;
       rd: TReader;
       tmps: string;
       NCount: Integer;
//       s: string;
     begin
       ms:=TMemoryStream.Create;
       lvScriptCodeIns.Items.BeginUpdate;
       try
        rd:=TReader.Create(ms,4096);
        try
         tmps:=ReadParam(ConstSectionOptions,lvScriptCodeIns.Name,tmps);
         try
          tmps:=HexStrToStr(tmps);
          ms.SetSize(Length(tmps));
          Move(Pointer(tmps)^,ms.Memory^,ms.Size);
          ms.Position:=0;
          NCount:=rd.ReadInteger;
          ClearListTemplates;
          RaEditor.Completion.Templates.Clear;
          for i:=0 to NCount-1 do begin
            li:=lvScriptCodeIns.Items.Add;
            New(P);
            li.Data:=P;
            li.caption:=rd.ReadString;
            li.SubItems.Add(rd.ReadString);
            P.Code:=rd.ReadString;
//            s:=li.Caption+RaEditor.Completion.Separator+li.SubItems[0];
//            s:=s+RaEditor.Completion.Separator+P.Code;
//            RaEditor.Completion.Templates.Add(s);
          end;
         except
         end; 
        finally
         rd.Free;
        end;
       finally
        lvScriptCodeIns.Items.EndUpdate;
        ms.Free;
       end;
     end;

     procedure LoadScriptKeys;
     var
       i: Integer;
       li: TListItem;
       ms: TMemoryStream;
       rd: TReader;
       tmps: string;
       sh1,sh2: TShortCut;
       key1,key2: Word;
       Shift1,Shift2: TShiftState;
       ek: TEditKey;
       NCount: Integer;
       tek: TTypeEditKey;
       Command: TEditCommand;
       P: PCommandHint;
       news: string;
     begin
       ms:=TMemoryStream.Create;
       lvScriptKey.Items.BeginUpdate;
       try
        rd:=TReader.Create(ms,4096);
        try
         try
          tmps:=ReadParam(ConstSectionOptions,lvScriptKey.Name,tmps);
          tmps:=HexStrToStr(tmps);
          ms.SetSize(Length(tmps));
          Move(Pointer(tmps)^,ms.Memory^,ms.Size);
          ms.Position:=0;
          NCount:=rd.ReadInteger;
          lvScriptKey.Items.Clear;
          RaEditor.Keyboard.Clear;
          for i:=0 to NCount-1 do begin
            tek:=TTypeEditKey(rd.ReadInteger);
            Command:=rd.ReadInteger;
            sh1:=rd.ReadInteger;
            sh2:=rd.ReadInteger;
            P:=GetCommandHint(Command);
            ek:=nil;
            if P<>nil then begin
             li:=lvScriptKey.Items.Add;
             case tek of
              tek1: begin
               news:=ShortCutToText(sh1);
               ShortCutToKey(sh1,key1,Shift1);
               ek:=RaEditor.Keyboard.Add(Command,key1,Shift1);
              end;
              tek2: begin
               news:=ShortCutToText(sh1)+','+ShortCutToText(sh2);
               ShortCutToKey(sh1,key1,Shift1);
               ShortCutToKey(sh2,key2,Shift2);
               ek:=RaEditor.Keyboard.Add2(Command,key1,Shift1,key2,Shift2);
              end;
             end;
             li.caption:=P.Hint;
             li.SubItems.Add(news);
             li.Data:=ek;
            end; 
          end;
         except
         end;
        finally
         rd.Free;
        end;
        SetLength(tmps,ms.Size);
        Move(ms.Memory^,Pointer(tmps)^,ms.Size);

       finally
        lvScriptKey.Items.EndUpdate;
        ms.Free;
       end;
     end;

     procedure LoadScriptText;
     var
       tmps: string;
     begin
       tmps:=ReadParam(ConstSectionOptions,'EText',tmps);
       if Trim(tmps)='' then tmps:=ConstDefaultRAEditorText
       else tmps:=HexStrToStr(tmps);
       RaEditor.Lines.Text:=tmps;
     end;

  begin
   try
    cbScriptAutoIndent.Checked:=ReadParam(ConstSectionOptions,cbScriptAutoIndent.Name,cbScriptAutoIndent.Checked);
    cbScriptSmartTab.Checked:=ReadParam(ConstSectionOptions,cbScriptSmartTab.Name,cbScriptSmartTab.Checked);
    cbScriptBackspaceUnindents.Checked:=ReadParam(ConstSectionOptions,cbScriptBackspaceUnindents.Name,cbScriptBackspaceUnindents.Checked);
    cbScriptGroupUndo.Checked:=ReadParam(ConstSectionOptions,cbScriptGroupUndo.Name,cbScriptGroupUndo.Checked);
    cbScriptCursorBeyondEOF.Checked:=ReadParam(ConstSectionOptions,cbScriptCursorBeyondEOF.Name,cbScriptCursorBeyondEOF.Checked);
    cbScriptUndoAfterSave.Checked:=ReadParam(ConstSectionOptions,cbScriptUndoAfterSave.Name,cbScriptUndoAfterSave.Checked);
    cbScriptKeepTrailingBlanks.Checked:=ReadParam(ConstSectionOptions,cbScriptKeepTrailingBlanks.Name,cbScriptKeepTrailingBlanks.Checked);
    cbScriptDoubleClickLine.Checked:=ReadParam(ConstSectionOptions,cbScriptDoubleClickLine.Name,cbScriptDoubleClickLine.Checked);
    cbScriptSytaxHighlighting.Checked:=ReadParam(ConstSectionOptions,cbScriptSytaxHighlighting.Name,cbScriptSytaxHighlighting.Checked);
    cbScriptRightMarginVisisble.Checked:=ReadParam(ConstSectionOptions,cbScriptRightMarginVisisble.Name,cbScriptRightMarginVisisble.Checked);

    udScriptRightMargin.Position:=ReadParam(ConstSectionOptions,udScriptRightMargin.Name,udScriptRightMargin.Position);
    udScriptGutterWidth.Position:=ReadParam(ConstSectionOptions,udScriptGutterWidth.Name,udScriptGutterWidth.Position);
    cmbScriptSelBlockFormat.ItemIndex:=ReadParam(ConstSectionOptions,cmbScriptSelBlockFormat.Name,cmbScriptSelBlockFormat.ItemIndex);

    edScriptTabStops.Text:=ReadParam(ConstSectionOptions,edScriptTabStops.Name,edScriptTabStops.Text);

    cbScriptAutoChange.Checked:=ReadParam(ConstSectionOptions,cbScriptAutoChange.Name,cbScriptAutoChange.Checked);
    udScriptAutoChange.Position:=ReadParam(ConstSectionOptions,udScriptAutoChange.Name,udScriptAutoChange.Position);

    cmbScriptTypeHigh.ItemIndex:=ReadParam(ConstSectionOptions,cmbScriptTypeHigh.Name,cmbScriptTypeHigh.ItemIndex);

    cmbScriptFontName.Text:=ReadParam(ConstSectionOptions,cmbScriptFontName.Name,cmbScriptFontName.Text);
    udScriptFontSize.Position:=ReadParam(ConstSectionOptions,udScriptFontSize.Name,udScriptFontSize.Position);

    LoadScriptColors(RaEditor.Colors.Comment,'EClrsComment');
    LoadScriptColors(RaEditor.Colors.Strings,'EClrsStrings');
    LoadScriptColors(RaEditor.Colors.Symbol,'EClrsSymbol');
    LoadScriptColors(RaEditor.Colors.Number,'EClrsNumber');
    LoadScriptColors(RaEditor.Colors.Reserved,'EClrsReserved');
    LoadScriptColors(RaEditor.Colors.Identifer,'EClrsIdentifer');
    LoadScriptColors(RaEditor.Colors.Preproc,'EClrsPreproc');
    LoadScriptColors(RaEditor.Colors.FunctionCall,'EClrsFunctionCall');
    LoadScriptColors(RaEditor.Colors.Declaration,'EClrsDeclaration');
    LoadScriptColors(RaEditor.Colors.Statement,'EClrsStatement');
    LoadScriptColors(RaEditor.Colors.PlainText,'EClrsPlainText');
    LoadScriptColors(RaEditor.Colors.Bookmark,'EClrsBookmark');
    LoadScriptColors(RaEditor.Colors.FindTxt,'EClrsFindTxt');
    LoadScriptColors(RaEditor.Colors.ErrorLine,'EClrsErrorLine');

    RaEditor.RightMarginColor:=ReadParam(ConstSectionOptions,'ERightMarginColor',RaEditor.RightMarginColor);
    RaEditor.GutterColor:=ReadParam(ConstSectionOptions,'EGutterColor',RaEditor.GutterColor);
    RaEditor.SelForeColor:=ReadParam(ConstSectionOptions,'ESelForeColor',RaEditor.SelForeColor);
    RaEditor.SelBackColor:=ReadParam(ConstSectionOptions,'ESelBackColor',RaEditor.SelBackColor);
    RaEditor.Color:=ReadParam(ConstSectionOptions,'EColor',RaEditor.Color);

    LoadScriptCodeIns;
    LoadScriptKeys;
    LoadScriptText;

    TTSVColorBox(cmbIdentiferColorBackGround).Selected:=ReadParam(ConstSectionOptions,cmbIdentiferColorBackGround.Name,TTSVColorBox(cmbIdentiferColorBackGround).Selected);
    TTSVColorBox(cmbIdentiferColorVar).Selected:=ReadParam(ConstSectionOptions,cmbIdentiferColorVar.Name,TTSVColorBox(cmbIdentiferColorVar).Selected);
    TTSVColorBox(cmbIdentiferColorConst).Selected:=ReadParam(ConstSectionOptions,cmbIdentiferColorConst.Name,TTSVColorBox(cmbIdentiferColorConst).Selected);
    TTSVColorBox(cmbIdentiferColorFunction).Selected:=ReadParam(ConstSectionOptions,cmbIdentiferColorFunction.Name,TTSVColorBox(cmbIdentiferColorFunction).Selected);
    TTSVColorBox(cmbIdentiferColorProcedure).Selected:=ReadParam(ConstSectionOptions,cmbIdentiferColorProcedure.Name,TTSVColorBox(cmbIdentiferColorProcedure).Selected);
    TTSVColorBox(cmbIdentiferColorProperty).Selected:=ReadParam(ConstSectionOptions,cmbIdentiferColorProperty.Name,TTSVColorBox(cmbIdentiferColorProperty).Selected);
    TTSVColorBox(cmbIdentiferColorType).Selected:=ReadParam(ConstSectionOptions,cmbIdentiferColorType.Name,TTSVColorBox(cmbIdentiferColorType).Selected);
    TTSVColorBox(cmbIdentiferColorCaption).Selected:=ReadParam(ConstSectionOptions,cmbIdentiferColorCaption.Name,TTSVColorBox(cmbIdentiferColorCaption).Selected);
    TTSVColorBox(cmbIdentiferColorParam).Selected:=ReadParam(ConstSectionOptions,cmbIdentiferColorParam.Name,TTSVColorBox(cmbIdentiferColorParam).Selected);
    TTSVColorBox(cmbIdentiferColorHint).Selected:=ReadParam(ConstSectionOptions,cmbIdentiferColorHint.Name,TTSVColorBox(cmbIdentiferColorHint).Selected);


   except
   end;
  end;

  procedure LoadFromForms;

    procedure LoadFormsColors;
    var
      i: Integer;
      val: Integer;
    begin
      for i:=0 to lbRBRFColors.Items.Count-1 do begin
        val:=ReadParam(ConstSectionOptions,'FormsColors'+inttostr(i),TColor(lbRBRFColors.Items.Objects[i]));
        lbRBRFColors.Items.Objects[i]:=TObject(val);
      end;
    end;

    procedure LoadFormsKeys;
    var
       i: Integer;
       li: TListItem;
       ms: TMemoryStream;
       P: PDesignKeyboard;
       rd: TReader;
       tmps: string;
       sh: TShortCut;
       NCount: Integer;
    begin
       ms:=TMemoryStream.Create;
       lvRBRFKeys.Items.BeginUpdate;
       try
        rd:=TReader.Create(ms,4096);
        try
         try
          tmps:=ReadParam(ConstSectionOptions,lvRBRFKeys.Name,tmps);
          tmps:=HexStrToStr(tmps);
          ms.SetSize(Length(tmps));
          Move(Pointer(tmps)^,ms.Memory^,ms.Size);
          ms.Position:=0;
          NCount:=rd.ReadInteger;
          ClearFormsKeyListView;
          for i:=0 to NCount-1 do begin
            li:=lvRBRFKeys.Items.Add;
            New(P);
            P.Command:=TDesignCommand(rd.ReadInteger);
            sh:=rd.ReadInteger;
            ShortCutToKey(sh,P.Key,P.Shift);
            li.Caption:=GetHintDesignCommand(P.Command,ConstdkcNone);
            li.SubItems.Add(ShortCutToText(sh));
            li.Data:=P;
          end;
         except
         end;
        finally
         rd.Free;
        end;
       finally
        lvRBRFKeys.Items.EndUpdate;
        ms.Free;
       end;
    end;

  begin
    try

     chbRBRFGridVisible.Checked:=ReadParam(ConstSectionOptions,chbRBRFGridVisible.Name,chbRBRFGridVisible.Checked);
     chbRBRFGridAlign.Checked:=ReadParam(ConstSectionOptions,chbRBRFGridAlign.Name,chbRBRFGridAlign.Checked);
     udRBRFGridXStep.Position:=ReadParam(ConstSectionOptions,udRBRFGridXStep.Name,udRBRFGridXStep.Position);
     udRBRFGridYStep.Position:=ReadParam(ConstSectionOptions,udRBRFGridYStep.Name,udRBRFGridYStep.Position);
     udRBRFGridYStep.Position:=ReadParam(ConstSectionOptions,udRBRFGridYStep.Name,udRBRFGridYStep.Position);

     TTSVColorBox(cmbRBRFGridColor).Selected:=ReadParam(ConstSectionOptions,cmbRBRFGridColor.Name,TTSVColorBox(cmbRBRFGridColor).Selected);
     LoadFormsColors;
     lbRBRFColorsClick(nil);

     chbRBRFHintsControl.Checked:=ReadParam(ConstSectionOptions,chbRBRFHintsControl.Name,chbRBRFHintsControl.Checked);
     chbRBRFHintsSize.Checked:=ReadParam(ConstSectionOptions,chbRBRFHintsSize.Name,chbRBRFHintsSize.Checked);
     chbRBRFHintsMove.Checked:=ReadParam(ConstSectionOptions,chbRBRFHintsMove.Name,chbRBRFHintsMove.Checked);
     chbRBRFHintsInsert.Checked:=ReadParam(ConstSectionOptions,chbRBRFHintsInsert.Name,chbRBRFHintsInsert.Checked);
     udRBRFSizeHandle.Position:=ReadParam(ConstSectionOptions,udRBRFSizeHandle.Name,udRBRFSizeHandle.Position);
     chbViewComponentCaption.Checked:=ReadParam(ConstSectionOptions,chbViewComponentCaption.Name,chbViewComponentCaption.Checked);

     chbRBRFTranslate.Checked:=ReadParam(ConstSectionOptions,chbRBRFTranslate.Name,chbRBRFTranslate.Checked);

     TTSVColorBox(cmbObjColorProperty).Selected:=ReadParam(ConstSectionOptions,cmbObjColorProperty.Name,TTSVColorBox(cmbObjColorProperty).Selected);
     TTSVColorBox(cmbObjColorSubProperty).Selected:=ReadParam(ConstSectionOptions,cmbObjColorSubProperty.Name,TTSVColorBox(cmbObjColorSubProperty).Selected);
     TTSVColorBox(cmbObjColorReference).Selected:=ReadParam(ConstSectionOptions,cmbObjColorReference.Name,TTSVColorBox(cmbObjColorReference).Selected);
     TTSVColorBox(cmbObjColorValue).Selected:=ReadParam(ConstSectionOptions,cmbObjColorValue.Name,TTSVColorBox(cmbObjColorValue).Selected);

     LoadFormsKeys;
    except
    end;
  end;

begin
  if (OptionHandle=hOptionScript)or(OptionHandle=OPTION_INVALID_HANDLE) then begin
    LoadFromIniScript;
  end;
  if (OptionHandle=hOptionForms)or(OptionHandle=OPTION_INVALID_HANDLE) then begin
    LoadFromForms;
  end;  
end;

procedure TfmOptions.SaveToIni(OptionHandle: THandle);

  procedure SaveToIniScript;

     procedure SaveScriptColors(clrs: TSymbolColor; inName: string);
     var
       ms: TMemoryStream;
       tmps: string;
       rwsc: TReadWriteSymbolColor;

     begin
       ms:=TMemoryStream.Create;
       rwsc:=TReadWriteSymbolColor.Create(nil);
       try
        rwsc.SymbolColor:=clrs;
        ms.WriteComponent(rwsc);
        SetLength(tmps,ms.Size);
        Move(ms.Memory^,Pointer(tmps)^,ms.Size);
        tmps:=StrToHexStr(tmps);
        WriteParam(ConstSectionOptions,inName,tmps);
       finally
        rwsc.Free;
        ms.Free;
       end;
     end;

     procedure SaveScriptCodeIns;
     var
       i: Integer;
       li: TListItem;
       P: PInfoListTemplate;
       ms: TMemoryStream;
       wr: TWriter;
       tmps: string;
     begin
       ms:=TMemoryStream.Create;
       try
        wr:=TWriter.Create(ms,4096);
        try
         lvScriptCodeIns.HandleNeeded;
         wr.writeInteger(lvScriptCodeIns.Items.Count);
         for i:=0 to lvScriptCodeIns.Items.Count-1 do begin
           li:=lvScriptCodeIns.Items[i];
           P:=li.Data;
           wr.WriteString(li.caption);
           wr.WriteString(li.SubItems[0]);
           wr.WriteString(P.Code);
         end;
        finally
         wr.Free;
        end;
        SetLength(tmps,ms.Size);
        Move(ms.Memory^,Pointer(tmps)^,ms.Size);
        tmps:=StrToHexStr(tmps);
        WriteParam(ConstSectionOptions,lvScriptCodeIns.Name,tmps);        
       finally
        ms.Free;
       end;
     end;

     procedure SaveScriptKeys;
     var
       i: Integer;
       li: TListItem;
       ms: TMemoryStream;
       wr: TWriter;
       tmps: string;
       sh1,sh2: TShortCut;
       ek: TEditKey;
     begin
       ms:=TMemoryStream.Create;
       try
        wr:=TWriter.Create(ms,4096);
        try
         lvScriptKey.HandleNeeded;
         wr.writeInteger(lvScriptKey.Items.Count);
         for i:=0 to lvScriptKey.Items.Count-1 do begin
           li:=lvScriptKey.Items[i];
           ek:=TEditKey(li.Data);
           wr.WriteInteger(Integer(ek.TypeEditKey));
           wr.WriteInteger(ek.Command);
           sh1:=ShortCut(ek.Key1,ek.Shift1);
           sh2:=ShortCut(ek.Key2,ek.Shift2);
           wr.WriteInteger(sh1);
           wr.WriteInteger(sh2);
         end;
        finally
         wr.Free;
        end;
        SetLength(tmps,ms.Size);
        Move(ms.Memory^,Pointer(tmps)^,ms.Size);
        tmps:=StrToHexStr(tmps);
        WriteParam(ConstSectionOptions,lvScriptKey.Name,tmps);
       finally
        ms.Free;
       end;
     end;

     procedure SaveScriptText;
     var
       tmps: string;
     begin
       tmps:=StrToHexStr(RaEditor.Lines.Text);
       WriteParam(ConstSectionOptions,'EText',tmps);
     end;

  begin
    WriteParam(ConstSectionOptions,cbScriptAutoIndent.Name,cbScriptAutoIndent.Checked);
    WriteParam(ConstSectionOptions,cbScriptSmartTab.Name,cbScriptSmartTab.Checked);
    WriteParam(ConstSectionOptions,cbScriptBackspaceUnindents.Name,cbScriptBackspaceUnindents.Checked);
    WriteParam(ConstSectionOptions,cbScriptGroupUndo.Name,cbScriptGroupUndo.Checked);
    WriteParam(ConstSectionOptions,cbScriptCursorBeyondEOF.Name,cbScriptCursorBeyondEOF.Checked);
    WriteParam(ConstSectionOptions,cbScriptUndoAfterSave.Name,cbScriptUndoAfterSave.Checked);
    WriteParam(ConstSectionOptions,cbScriptKeepTrailingBlanks.Name,cbScriptKeepTrailingBlanks.Checked);
    WriteParam(ConstSectionOptions,cbScriptDoubleClickLine.Name,cbScriptDoubleClickLine.Checked);
    WriteParam(ConstSectionOptions,cbScriptSytaxHighlighting.Name,cbScriptSytaxHighlighting.Checked);
    WriteParam(ConstSectionOptions,cbScriptRightMarginVisisble.Name,cbScriptRightMarginVisisble.Checked);

    WriteParam(ConstSectionOptions,udScriptRightMargin.Name,udScriptRightMargin.Position);
    WriteParam(ConstSectionOptions,udScriptGutterWidth.Name,udScriptGutterWidth.Position);
    WriteParam(ConstSectionOptions,cmbScriptSelBlockFormat.Name,cmbScriptSelBlockFormat.ItemIndex);

    WriteParam(ConstSectionOptions,edScriptTabStops.Name,edScriptTabStops.Text);

    WriteParam(ConstSectionOptions,cbScriptAutoChange.Name,cbScriptAutoChange.Checked);
    WriteParam(ConstSectionOptions,udScriptAutoChange.Name,udScriptAutoChange.Position);

    WriteParam(ConstSectionOptions,cmbScriptTypeHigh.Name,cmbScriptTypeHigh.ItemIndex);

    WriteParam(ConstSectionOptions,cmbScriptFontName.Name,cmbScriptFontName.Text);
    WriteParam(ConstSectionOptions,udScriptFontSize.Name,udScriptFontSize.Position);

    SaveScriptColors(RaEditor.Colors.Comment,'EClrsComment');
    SaveScriptColors(RaEditor.Colors.Strings,'EClrsStrings');
    SaveScriptColors(RaEditor.Colors.Symbol,'EClrsSymbol');
    SaveScriptColors(RaEditor.Colors.Number,'EClrsNumber');
    SaveScriptColors(RaEditor.Colors.Reserved,'EClrsReserved');
    SaveScriptColors(RaEditor.Colors.Identifer,'EClrsIdentifer');
    SaveScriptColors(RaEditor.Colors.Preproc,'EClrsPreproc');
    SaveScriptColors(RaEditor.Colors.FunctionCall,'EClrsFunctionCall');
    SaveScriptColors(RaEditor.Colors.Declaration,'EClrsDeclaration');
    SaveScriptColors(RaEditor.Colors.Statement,'EClrsStatement');
    SaveScriptColors(RaEditor.Colors.PlainText,'EClrsPlainText');
    SaveScriptColors(RaEditor.Colors.Bookmark,'EClrsBookmark');
    SaveScriptColors(RaEditor.Colors.FindTxt,'EClrsFindTxt');
    SaveScriptColors(RaEditor.Colors.ErrorLine,'EClrsErrorLine');

    WriteParam(ConstSectionOptions,'ERightMarginColor',RaEditor.RightMarginColor);
    WriteParam(ConstSectionOptions,'EGutterColor',RaEditor.GutterColor);
    WriteParam(ConstSectionOptions,'ESelForeColor',RaEditor.SelForeColor);
    WriteParam(ConstSectionOptions,'ESelBackColor',RaEditor.SelBackColor);
    WriteParam(ConstSectionOptions,'EColor',RaEditor.Color);

    SaveScriptCodeIns;
    SaveScriptKeys;
    SaveScriptText;

    WriteParam(ConstSectionOptions,cmbIdentiferColorBackGround.Name,TTSVColorBox(cmbIdentiferColorBackGround).Selected);
    WriteParam(ConstSectionOptions,cmbIdentiferColorVar.Name,TTSVColorBox(cmbIdentiferColorVar).Selected);
    WriteParam(ConstSectionOptions,cmbIdentiferColorConst.Name,TTSVColorBox(cmbIdentiferColorConst).Selected);
    WriteParam(ConstSectionOptions,cmbIdentiferColorFunction.Name,TTSVColorBox(cmbIdentiferColorFunction).Selected);
    WriteParam(ConstSectionOptions,cmbIdentiferColorProcedure.Name,TTSVColorBox(cmbIdentiferColorProcedure).Selected);
    WriteParam(ConstSectionOptions,cmbIdentiferColorProperty.Name,TTSVColorBox(cmbIdentiferColorProperty).Selected);
    WriteParam(ConstSectionOptions,cmbIdentiferColorType.Name,TTSVColorBox(cmbIdentiferColorType).Selected);
    WriteParam(ConstSectionOptions,cmbIdentiferColorCaption.Name,TTSVColorBox(cmbIdentiferColorCaption).Selected);
    WriteParam(ConstSectionOptions,cmbIdentiferColorParam.Name,TTSVColorBox(cmbIdentiferColorParam).Selected);
    WriteParam(ConstSectionOptions,cmbIdentiferColorHint.Name,TTSVColorBox(cmbIdentiferColorHint).Selected);
  end;

  procedure SaveToIniForms;

    procedure SaveFormsColors;
    var
      i: Integer;
    begin
      for i:=0 to lbRBRFColors.Items.Count-1 do begin
        WriteParam(ConstSectionOptions,'FormsColors'+inttostr(i),TColor(lbRBRFColors.Items.Objects[i]));
      end;
    end;

    procedure SaveFormsKeys;
    var
       i: Integer;
       li: TListItem;
       ms: TMemoryStream;
       P: PDesignKeyboard;
       wr: TWriter;
       tmps: string;
       sh: TShortCut;
    begin
       ms:=TMemoryStream.Create;
       try
        wr:=TWriter.Create(ms,4096);
        try
         lvRBRFKeys.HandleNeeded;
         wr.writeInteger(lvRBRFKeys.Items.Count);
         for i:=0 to lvRBRFKeys.Items.Count-1 do begin
           li:=lvRBRFKeys.Items[i];
           P:=li.Data;
           wr.WriteInteger(Integer(P.Command));
           sh:=ShortCut(P.Key,P.Shift);
           wr.WriteInteger(sh);
         end;
        finally
         wr.Free;
        end;
        SetLength(tmps,ms.Size);
        Move(ms.Memory^,Pointer(tmps)^,ms.Size);
        tmps:=StrToHexStr(tmps);
        WriteParam(ConstSectionOptions,lvRBRFKeys.Name,tmps);
       finally
        ms.Free;
       end;
    end;
    
  begin
    WriteParam(ConstSectionOptions,chbRBRFGridVisible.Name,chbRBRFGridVisible.Checked);
    WriteParam(ConstSectionOptions,chbRBRFGridAlign.Name,chbRBRFGridAlign.Checked);
    WriteParam(ConstSectionOptions,udRBRFGridXStep.Name,udRBRFGridXStep.Position);
    WriteParam(ConstSectionOptions,udRBRFGridYStep.Name,udRBRFGridYStep.Position);
    WriteParam(ConstSectionOptions,udRBRFGridYStep.Name,udRBRFGridYStep.Position);

    WriteParam(ConstSectionOptions,cmbRBRFGridColor.Name,TTSVColorBox(cmbRBRFGridColor).Selected);
    SaveFormsColors;

    WriteParam(ConstSectionOptions,chbRBRFHintsControl.Name,chbRBRFHintsControl.Checked);
    WriteParam(ConstSectionOptions,chbRBRFHintsSize.Name,chbRBRFHintsSize.Checked);
    WriteParam(ConstSectionOptions,chbRBRFHintsMove.Name,chbRBRFHintsMove.Checked);
    WriteParam(ConstSectionOptions,chbRBRFHintsInsert.Name,chbRBRFHintsInsert.Checked);
    WriteParam(ConstSectionOptions,udRBRFSizeHandle.Name,udRBRFSizeHandle.Position);
    WriteParam(ConstSectionOptions,chbViewComponentCaption.Name,chbViewComponentCaption.Checked);

    WriteParam(ConstSectionOptions,chbRBRFTranslate.Name,chbRBRFTranslate.Checked);
    WriteParam(ConstSectionOptions,cmbObjColorProperty.Name,TTSVColorBox(cmbObjColorProperty).Selected);
    WriteParam(ConstSectionOptions,cmbObjColorSubProperty.Name,TTSVColorBox(cmbObjColorSubProperty).Selected);
    WriteParam(ConstSectionOptions,cmbObjColorReference.Name,TTSVColorBox(cmbObjColorReference).Selected);
    WriteParam(ConstSectionOptions,cmbObjColorValue.Name,TTSVColorBox(cmbObjColorValue).Selected);

    SaveFormsKeys;
  end;
  

begin
  if (OptionHandle=hOptionScript)or(OptionHandle=OPTION_INVALID_HANDLE) then begin
    SaveToIniScript;
  end;
  if (OptionHandle=hOptionForms)or(OptionHandle=OPTION_INVALID_HANDLE) then begin
    SaveToIniForms;
  end;  
end;

procedure TfmOptions.FormDestroy(Sender: TObject);
begin

  FDSB.Free;
  ClearFormsKeyListView;

  cmbIdentiferColorBackGround.Free;
  cmbIdentiferColorVar.Free;
  cmbIdentiferColorConst.Free;
  cmbIdentiferColorFunction.Free;
  cmbIdentiferColorProcedure.Free;
  cmbIdentiferColorProperty.Free;
  cmbIdentiferColorType.Free;
  cmbIdentiferColorCaption.Free;
  cmbIdentiferColorParam.Free;
  cmbIdentiferColorHint.Free;

  cmbRBRFGridColor.Free;
  cmbRBRFColorsCurrent.Free;
  cmbObjColorProperty.Free;
  cmbObjColorSubProperty.Free;
  cmbObjColorReference.Free;
  cmbObjColorValue.Free;
  ClearListTemplates;
  cmbScriptFGColor.Free;
  cmbScriptBGColor.Free;
  cmbScriptFontName.Free;
  RaEditor.Free;
  FreeAndNil(RaEditorCodeIns);
end;

procedure TfmOptions.SetSettingsFromRaEditorScript;
begin
  if RaEditor=nil then exit;
  SetDefaultChangeEventToScript(false);

  cbScriptAutoIndent.Checked:=RaEditor.AutoIndent;
  cbScriptSmartTab.Checked:=RaEditor.SmartTab;
  cbScriptBackspaceUnindents.Checked:=RaEditor.BackSpaceUnindents;
  cbScriptGroupUndo.Checked:=RaEditor.GroupUndo;
  cbScriptCursorBeyondEOF.Checked:=RaEditor.CursorBeyondEOF;
  cbScriptUndoAfterSave.Checked:=RaEditor.UndoAfterSave;
  cbScriptKeepTrailingBlanks.Checked:=RaEditor.KeepTrailingBlanks;
  cbScriptDoubleClickLine.Checked:=RaEditor.DoubleClickLine;
  cbScriptSytaxHighlighting.Checked:=RaEditor.SyntaxHighlighting;
  edScriptTabStops.Text:=RaEditor.TabStops;
  cbScriptRightMarginVisisble.Checked:=RaEditor.RightMarginVisible;
  udScriptRightMargin.Position:=RaEditor.RightMargin;
  udScriptGutterWidth.Position:=RaEditor.GutterWidth;
  cmbScriptSelBlockFormat.ItemIndex:=Integer(RaEditor.SelBlockFormat);
  cbScriptAutoChange.Checked:=RaEditor.Completion.Enabled;
  udScriptAutoChange.Position:=RaEditor.Completion.Interval;

  cmbScriptTypeHigh.ItemIndex:=Integer(RaEditor.HighLighter);
  TTSVFontBox(cmbScriptFontName).FontName:=RaEditor.Font.Name;
  udScriptFontSize.Position:=RaEditor.Font.Size;

  SetDefaultChangeEventToScript(true);
end;


procedure TfmOptions.pcScriptChange(Sender: TObject);
begin
  case pcScript.ActivePageIndex of
    2: begin
      RaEditorCodeIns.Colors.Assign(RaEditor.Colors);
      RaEditorCodeIns.Font.Assign(RaEditor.Font);
      RaEditorCodeIns.Color:=RaEditor.color;
      RaEditorCodeIns.GutterWidth:=RaEditor.GutterWidth;
      RaEditorCodeIns.GutterColor:=RaEditor.GutterColor;
      RaEditorCodeIns.RightMarginVisible:=RaEditor.RightMarginVisible;
      RaEditorCodeIns.RightMargin:=RaEditor.RightMargin;
      RaEditorCodeIns.RightMarginColor:=RaEditor.RightMarginColor;
      RaEditorCodeIns.SelForeColor:=RaEditor.SelForeColor;
      RaEditorCodeIns.SelBackColor:=RaEditor.SelBackColor;
      RaEditorCodeIns.SelBlockFormat:=RaEditor.SelBlockFormat;
      lvScriptCodeIns.SetFocus;
    end;
  else
  end;
end;

procedure TfmOptions.SetTemplatesToListView;
{var
{  i: Integer;
  tmps: string;
  li: TListItem;
  APos: Integer;
  inName,inHint,InCode: string;
  P: PInfoListTemplate;}
begin
{ lvScriptCodeIns.Items.BeginUpdate;
 try
  ClearListTemplates;
  RaEditorCodeIns.Lines.Clear;
{  for i:=0 to RaEditor.Completion.Templates.Count-1 do begin
    tmps:=RaEditor.Completion.Templates.Items[i].Caption;
    APos:=Pos(Sep,tmps);
    if Apos<>0 then begin
      inName:=Copy(tmps,1,APos-1);
      tmps:=Copy(tmps,APos+Length(Sep),Length(tmps)-APos);
    end;
    APos:=Pos(Sep,tmps);
    if Apos<>0 then begin
      inHint:=Copy(tmps,1,APos-1);
      tmps:=Copy(tmps,APos+Length(Sep),Length(tmps)-APos);
    end;
    inCode:=TranslateFromTemplates(tmps);
    if (Trim(inName)<>'') and
       (Trim(inHint)<>'') and
       (Trim(inCode)<>'') then begin
      li:=lvScriptCodeIns.Items.Add;
      li.Caption:=Trim(inName);
      li.SubItems.Add(inHint);
      new(P);
      P.Code:=inCode;
      li.Data:=P;
    end;
  end;}
// finally
{  lvScriptCodeIns.Items.EndUpdate;
  if lvScriptCodeIns.Items.Count>0 then  begin
    li:=lvScriptCodeIns.Items[0];
    li.Selected:=true;
    li.MakeVisible(true);
    lvScriptCodeInsChange(nil,li,ctText);
  end;}
// end;
end;

procedure TfmOptions.bibScriptAddCodeInsClick(Sender: TObject);
{var
  fm: TfmEditOptionsRbInterfaceScript;
  li: TListItem;
  P: PInfoListTemplate;
  tmps: string;}
begin
{  fm:=nil;
  try
   fm:=TfmEditOptionsRbInterfaceScript.Create(nil);
   fm.Caption:=CaptionAdd;
   fm.SetEditorParams(RaEditor);
   if fm.ShowModal=mrOk then begin
     li:=lvScriptCodeIns.Items.Add;
     li.Caption:=Trim(fm.edName.Text);
     li.SubItems.Add(Trim(fm.edHint.Text));
     new(P);
     P.Code:=fm.RaEditor.Lines.Text;
     li.Data:=P;
//     tmps:=li.Caption+RaEditor.Completion.Separator+li.SubItems[0];
//     tmps:=tmps+RaEditor.Completion.Separator+P.Code;
//     RaEditor.Completion.Templates.Add(tmps);
     li.Selected:=true;
     li.MakeVisible(true);
   end;
  finally
   fm.Free;
  end;}
end;

procedure TfmOptions.ClearListTemplates;
var
  i: Integer;
  P: PInfoListTemplate;
begin
  for i:=0 to lvScriptCodeIns.Items.Count-1 do begin
    P:=lvScriptCodeIns.Items[i].Data;
    if P<>nil then
     dispose(P);
  end;
  lvScriptCodeIns.Items.Clear;
end;

procedure TfmOptions.lvScriptCodeInsChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
var
  li: TListItem;
begin
  if RaEditorCodeIns=nil then exit;
  li:=lvScriptCodeIns.Selected;
  if li=nil then exit;
  if li.Data=nil then exit;
  RaEditorCodeIns.Lines.Text:=PInfoListTemplate(li.Data).Code;
end;

procedure TfmOptions.bibScriptDelCodeInsClick(Sender: TObject);
var
  li: TListItem;
  i: Integer;
begin
 lvScriptCodeIns.Items.BeginUpdate;
 try
   for i:=lvScriptCodeIns.Items.Count-1 downto 0 do begin
     li:=lvScriptCodeIns.Items[i];
     if Li.Selected then begin
       Dispose(PInfoListTemplate(li.Data));
       RaEditor.Completion.Templates.Delete(li.Index);
       lvScriptCodeIns.Items.Delete(i);
       RaEditorCodeIns.Lines.Clear;
     end;
   end;
 finally
   lvScriptCodeIns.Items.EndUpdate;
 end;
end;

procedure TfmOptions.bibScriptEditCodeInsClick(Sender: TObject);
{var
  li: TListItem;
  fm: TfmEditOptionsRbInterfaceScript;
  P: PInfoListTemplate;
  tmps: string;}
begin
{  li:=lvScriptCodeIns.Selected;
  if li=nil then exit;
  if li.Data=nil then exit;
  fm:=nil;
  try
   fm:=TfmEditOptionsRbInterfaceScript.Create(nil);
   fm.Caption:=CaptionChange;
   fm.SetEditorParams(RaEditor);
   fm.edName.Text:=li.Caption;
   fm.edHint.Text:=li.SubItems[0];
   P:=li.Data;
   fm.RaEditor.Lines.Text:=P.Code;
   if fm.ShowModal=mrOk then begin
     li.Caption:=Trim(fm.edName.Text);
     li.SubItems[0]:=Trim(fm.edHint.Text);
     P.Code:=fm.RaEditor.Lines.Text;
     li.Data:=P;
//     tmps:=li.Caption+RaEditor.Completion.Separator+li.SubItems[0];
//     tmps:=tmps+RaEditor.Completion.Separator+P.Code;
//     RaEditor.Completion.Templates.Strings[li.Index]:=tmps;
     li.Selected:=true;
     li.MakeVisible(true);
   end;
  finally
   fm.Free;
  end;}
end;

procedure TfmOptions.lvScriptCodeInsCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
  procedure DrawItem;
  var
    rt: Trect;
    wd: Integer;
    OldBrush: TBrush;
    OldFont: TFont;
    OldPen: Tpen;
  begin
   OldBrush:=TBrush.Create;
   OldFont:=TFont.Create;
   OldPen:=Tpen.Create;
   try
    OldBrush.Assign(Canvas.Brush);
    OldFont.Assign(Canvas.Font);
    OldPen.Assign(Canvas.Pen);
    rt:=Item.DisplayRect(drLabel);
    with Sender.Canvas do begin
     brush.Style:=bsSolid;
     brush.Color:=clBtnFace;
     wd:=TextWidth(Item.Caption);
     InflateRect(rt,0,-1);
     rt.Right:=rt.Left+wd;
     FillRect(rt);
    end;
   finally
     Canvas.Brush.Assign(OldBrush);
     OldBrush.Free;
     Canvas.Font.Assign(OldFont);
     OldFont.Free;
     Canvas.Pen.Assign(OldPen);
     OldPen.Free;
   end;
  end;

begin
{  DefaultDraw:=true;
  if (Item.Selected)and(not(cdsHot in State)) then
      DrawItem
  else DefaultDraw:=true; }
  inherited;
end;

procedure TfmOptions.lvScriptCodeInsColumnClick(Sender: TObject;
  Column: TListColumn);
var
 newSortItem:integer;
begin
 newSortItem:=Column.Index-1;
 if glSortSubItem=newSortItem then glSortForward:=not glSortForward
 else glSortForward:=true;
 glSortSubItem:=newSortItem;
 lvScriptCodeIns.OnCompare:=lvCompareStr;
 lvScriptCodeIns.AlphaSort;
end;

procedure TfmOptions.lvCompareStr(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
begin
 if glSortSubItem>=0 then Compare:=CompareText(Item1.SubItems[glSortSubItem],Item2.SubItems[glSortSubItem])
 else Compare:=CompareText(Item1.Caption,Item2.Caption);
 if glSortForward=false then Compare:=-Compare;
end;

procedure TfmOptions.lvScriptKeyColumnClick(Sender: TObject;
  Column: TListColumn);
var
 newSortItem:integer;
begin
 newSortItem:=Column.Index-1;
 if glSortSubItemKey=newSortItem then glSortForwardKey:=not glSortForwardKey
 else glSortForwardKey:=true;
 glSortSubItemKey:=newSortItem;
 lvScriptKey.OnCompare:=lvCompareStrKey;
 lvScriptKey.AlphaSort;
end;

procedure TfmOptions.lvCompareStrKey(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
begin
 if glSortSubItemKey>=0 then Compare:=CompareText(Item1.SubItems[glSortSubItemKey],Item2.SubItems[glSortSubItemKey])
 else Compare:=CompareText(Item1.Caption,Item2.Caption);
 if glSortForwardKey=false then Compare:=-Compare;
end;

procedure TfmOptions.lvScriptCodeInsDblClick(Sender: TObject);
begin
  bibScriptEditCodeInsClick(nil);
end;

procedure TfmOptions.SetShortCutToListView;
var
   i: Integer;
   ek: TEditKey;
   li: TListItem;
   tmps: string;
   P: PCommandHint;
begin
  lvScriptKey.Items.BeginUpdate;
  try
   lvScriptKey.Items.Clear;
   for i:=0 to RaEditor.Keyboard.GetCount-1 do begin
     ek:=RaEditor.Keyboard.GetEditKey(i);
     li:=lvScriptKey.Items.Add;
     li.data:=ek;
     P:=GetCommandhint(ek.Command);
     if P<>nil then begin
      li.Caption:=P.Hint;
      case ek.TypeEditKey of
       tek1: begin
         tmps:=ShortCutToText(ShortCut(ek.Key1,ek.Shift1));
       end;
       tek2: begin
         tmps:=ShortCutToText(ShortCut(ek.Key1,ek.Shift1))+'; '+
               ShortCutToText(ShortCut(ek.Key2,ek.Shift2));
       end;

      end;
      li.SubItems.Add(tmps);
     end; 
   end;
  finally
   lvScriptKey.Items.EndUpdate;
   if lvScriptKey.Items.Count>0 then begin
    li:=lvScriptKey.Items[0];
    li.Selected:=true;
    li.MakeVisible(true);
   end;
  end;
end;

procedure TfmOptions.bibScriptAddKeyClick(Sender: TObject);
var
  fm: TfmEditOptionsKeyRBInterfaceScript;
  li: TListItem;
  P: PCommandHint;
  tmps: string;
  inKey,inKey2: Word;
  inShift,inShift2: TShiftState;
  ek: TEditKey;
begin
  fm:=nil;
  try
   fm:=TfmEditOptionsKeyRBInterfaceScript.Create(nil);
   fm.Caption:=CaptionAdd;
   if fm.ShowModal=mrOk then begin
     li:=lvScriptKey.Items.Add;
     li.Caption:=fm.cmbCommand.Items.Strings[fm.cmbCommand.itemindex];
     P:=PCommandHint(fm.cmbCommand.Items.Objects[fm.cmbCommand.itemindex]);
     ek:=nil;
     case fm.rgCase.ItemIndex of
       0: begin
         tmps:=ShortCutToText(fm.hkKeyOne.HotKey);
         li.SubItems.Add(tmps);
         ShortCutToKey(fm.hkKeyOne.HotKey,inKey,inShift);
         ek:=RaEditor.Keyboard.Add(P.Command,inKey,inShift);
       end;
       1: begin
         tmps:=ShortCutToText(fm.hkKeyTwo.HotKey)+'; '+
               ShortCutToText(fm.hkKeyTwo.HotKey);
         li.SubItems.Add(tmps);
         ShortCutToKey(fm.hkKeyOne.HotKey,inKey,inShift);
         ShortCutToKey(fm.hkKeyTwo.HotKey,inKey2,inShift2);
         ek:=RaEditor.Keyboard.Add2(P.Command,inKey,inShift,inKey2,inShift2);
       end;
     end;
     li.Data:=ek;
     li.Selected:=true;
     li.MakeVisible(true);
   end;
  finally
   fm.Free;
  end;
end;

procedure TfmOptions.bibScriptDelKeyClick(Sender: TObject);
var
  li: TListItem;
  ek: TEditKey;
  i: Integer;
begin
  lvScriptKey.Items.BeginUpdate;
  try
    for i:=lvScriptKey.Items.Count-1 downto 0 do begin
      li:=lvScriptKey.Items[i];
      if li.Selected then begin
       ek:=TEditKey(li.Data);
       RaEditor.Keyboard.RemoveEditKey(ek);
       li.Delete;
      end;
    end;
  finally
   lvScriptKey.Items.EndUpdate;
  end;
end;

procedure TfmOptions.bibScriptChangeKeyClick(Sender: TObject);
var
  li: TListItem;
  fm: TfmEditOptionsKeyRBInterfaceScript;
  tmps: string;
  P: PCommandHint;
  ek: TEditKey;
  inKey,inKey2: Word;
  inShift,inShift2: TShiftState;
begin
  li:=lvScriptKey.Selected;
  if li=nil then exit;
  if li.Data=nil then exit;
  ek:=TEditKey(li.Data);
  fm:=nil;
  try
   fm:=TfmEditOptionsKeyRBInterfaceScript.Create(nil);
   fm.Caption:=CaptionChange;
   fm.rgCase.ItemIndex:=integer(ek.TypeEditKey);
   fm.rgCaseClick(nil);
   P:=GetCommandHint(ek.Command);
   if P<>nil then begin
    fm.cmbCommand.ItemIndex:=fm.cmbCommand.Items.IndexOf(P.Hint);
//    tmps:=ShortCutToText(ShortCut(ek.Key1,ek.Shift1));
//    fm.hkKeyOne.HotKey:=TextToShortCut(tmps);
    fm.hkKeyOne.HotKey:=ShortCut(ek.Key1,ek.Shift1);
    fm.hkKeyTwo.HotKey:=ShortCut(ek.Key2,ek.Shift2);
   end;
   if fm.ShowModal=mrOk then begin
     li.Caption:=fm.cmbCommand.Items.Strings[fm.cmbCommand.itemindex];
     P:=PCommandHint(fm.cmbCommand.Items.Objects[fm.cmbCommand.itemindex]);
     case fm.rgCase.ItemIndex of
       0: begin
         tmps:=ShortCutToText(fm.hkKeyOne.HotKey);
         li.SubItems.Strings[0]:=tmps;
         ShortCutToKey(fm.hkKeyOne.HotKey,inKey,inShift);
         RaEditor.Keyboard.Replace(ek,P.Command,inKey,inShift);
       end;
       1: begin
         tmps:=ShortCutToText(fm.hkKeyTwo.HotKey)+'; '+
               ShortCutToText(fm.hkKeyTwo.HotKey);
         li.SubItems.Strings[0]:=tmps;
         ShortCutToKey(fm.hkKeyOne.HotKey,inKey,inShift);
         ShortCutToKey(fm.hkKeyTwo.HotKey,inKey2,inShift2);
         RaEditor.Keyboard.Replace2(ek,P.Command,inKey,inShift,inKey2,inShift2);
       end;
     end;
     li.Selected:=true;
     li.MakeVisible(true);
   end;
  finally
   fm.Free;
  end;
end;

procedure TfmOptions.lvScriptKeyDblClick(Sender: TObject);
begin
  bibScriptChangeKeyClick(nil);
end;

procedure TfmOptions.bibScriptResetKeyClick(Sender: TObject);
begin
  RaEditor.Keyboard.SetDefLayot;
  SetShortCutToListView;
end;

procedure TfmOptions.bibScriptResetCodeInsClick(Sender: TObject);
begin
//  RaEditor.Completion.Templates.Text:=ConstDefaultRAEditorCompletition;
  SetTemplatesToListView;
end;

procedure TfmOptions.lbRBRFColorsClick(Sender: TObject);
begin
  if lbRBRFColors.ItemIndex=-1 then exit;
  TTSVColorBox(cmbRBRFColorsCurrent).Selected:=
      TColor(lbRBRFColors.Items.Objects[lbRBRFColors.ItemIndex]);
end;

procedure TfmOptions.cmbRBRFColorsCurrentChange(Sender: TObject);
begin
  if lbRBRFColors.ItemIndex=-1 then exit;
  lbRBRFColors.Items.Objects[lbRBRFColors.ItemIndex]:=
    TObject(TTSVColorBox(cmbRBRFColorsCurrent).Selected);
end;

procedure TfmOptions.SetFormsKeyToListView;
var
  i: Integer;
  P,PNew: PDesignKeyboard;
  li: TListItem;
begin
  lvRBRFKeys.Items.BeginUpdate;
  try
   ClearFormsKeyListView;
   for i:=0 to FDSB.DesignListKeyboard.Count-1 do begin
     P:=FDSB.DesignListKeyboard.Items[i];
     New(PNew);
     FillChar(PNew^,SizeOf(TDesignKeyboard),0);
     Move(P^,PNew^,SizeOf(TDesignKeyboard));
     li:=lvRBRFKeys.Items.Add;
     li.Caption:=GetHintDesignCommand(PNew.Command,ConstdkcNone);
     li.SubItems.Add(ShortCutToText(ShortCut(PNew.Key,PNew.Shift)));
     li.Data:=PNew;
   end;
  finally
   lvRBRFKeys.Items.EndUpdate;
  end;
end;

procedure TfmOptions.ClearFormsKeyListView;
var
  i: Integer;
  P: PDesignKeyboard;
begin
  for i:=0 to lvRBRFKeys.Items.Count-1 do begin
    P:=lvRBRFKeys.Items[i].Data;
    Dispose(P);
  end;
  lvRBRFKeys.Items.Clear;
end;


procedure TfmOptions.bibRBRFKeysDeleteClick(Sender: TObject);
var
  li: TListItem;
  i: Integer;
begin
  lvRBRFKeys.Items.BeginUpdate;
  try
    for i:=lvRBRFKeys.Items.Count-1 downto 0 do begin
      li:=lvRBRFKeys.Items[i];
      if li.Selected then begin
       Dispose(PDesignKeyboard(li.Data));
       li.Delete;
      end;
    end;
  finally
    lvRBRFKeys.Items.EndUpdate;
  end;
end;

procedure TfmOptions.bibRBRFKeysResetClick(Sender: TObject);
begin
  SetFormsKeyToListView;
end;

procedure TfmOptions.bibRBRFKeysAddClick(Sender: TObject);
var
  fm: TfmEditOptionsKeyRBInterfaceForms;
  li: TListItem;
  P: PDesignKeyboard;
  tmps: string;
  inKey: Word;
  inShift: TShiftState;
begin
  fm:=nil;
  try
   fm:=TfmEditOptionsKeyRBInterfaceForms.Create(nil);
   fm.Caption:=CaptionAdd;
   if fm.ShowModal=mrOk then begin
     li:=lvRBRFKeys.Items.Add;
     new(P);
     ShortCutToKey(fm.hkKey.HotKey,inKey,inShift);
     P.Key:=inKey;
     P.Shift:=inShift;
     P.Command:=PInfoHintDesignCommand(fm.cmbCommand.Items.Objects[fm.cmbCommand.itemindex]).Command;
     li.Caption:=fm.cmbCommand.Items.Strings[fm.cmbCommand.itemindex];
     tmps:=ShortCutToText(fm.hkKey.HotKey);
     li.SubItems.Add(tmps);
     li.Data:=P;
     li.Selected:=true;
     li.MakeVisible(true);
   end;
  finally
   fm.Free;
  end;
end;

procedure TfmOptions.bibRBRFKeysChangeClick(Sender: TObject);
var
  fm: TfmEditOptionsKeyRBInterfaceForms;
  li: TListItem;
  P: PDesignKeyboard;
  tmps: string;
  inKey: Word;
  inShift: TShiftState;
begin
  li:=lvRBRFKeys.Selected;
  if li=nil then exit;
  fm:=nil;
  try
   fm:=TfmEditOptionsKeyRBInterfaceForms.Create(nil);
   fm.Caption:=CaptionChange;
   P:=li.data;
   fm.hkKey.HotKey:=ShortCut(P.Key,P.Shift);
   fm.cmbCommand.ItemIndex:=fm.cmbCommand.Items.IndexOf(
          GetHintDesignCommand(P.Command,ConstdkcNone));
   if fm.ShowModal=mrOk then begin
     ShortCutToKey(fm.hkKey.HotKey,inKey,inShift);
     P.Key:=inKey;
     P.Shift:=inShift;
     P.Command:=PInfoHintDesignCommand(fm.cmbCommand.Items.Objects[fm.cmbCommand.itemindex]).Command;
     li.Caption:=fm.cmbCommand.Items.Strings[fm.cmbCommand.itemindex];
     tmps:=ShortCutToText(fm.hkKey.HotKey);
     li.SubItems[0]:=tmps;
     li.Selected:=true;
     li.MakeVisible(true);
   end;
  finally
   fm.Free;
  end;
end;

procedure TfmOptions.lvRBRFKeysDblClick(Sender: TObject);
begin
  bibRBRFKeysChangeClick(nil);
end;

procedure TfmOptions.lvCompareStrFormsKey(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
begin
 if glSortSubItemFormsKey>=0 then Compare:=CompareText(Item1.SubItems[glSortSubItemFormsKey],
     Item2.SubItems[glSortSubItemFormsKey])
 else Compare:=CompareText(Item1.Caption,Item2.Caption);
 if glSortForwardFormsKey=false then Compare:=-Compare;
end;

procedure TfmOptions.lvRBRFKeysColumnClick(Sender: TObject;
  Column: TListColumn);
var
 newSortItem:integer;
begin
 newSortItem:=Column.Index-1;
 if glSortSubItemFormsKey=newSortItem then glSortForwardFormsKey:=not glSortForwardFormsKey
 else glSortForwardFormsKey:=true;
 glSortSubItemFormsKey:=newSortItem;
 lvRBRFKeys.OnCompare:=lvCompareStrFormsKey;
 lvRBRFKeys.AlphaSort;
end;

procedure TfmOptions.SetDefaultChangeEventToScript(isEnabled: Boolean);
begin
  if isEnabled then begin
    cbScriptAutoIndent.OnClick:=cbScriptAutoIndentClick;
    cbScriptSmartTab.OnClick:=cbScriptSmartTabClick;
    cbScriptBackspaceUnindents.OnClick:=cbScriptBackspaceUnindentsClick;
    cbScriptGroupUndo.OnClick:=cbScriptGroupUndoClick;
    cbScriptCursorBeyondEOF.OnClick:=cbScriptCursorBeyondEOFClick;
    cbScriptUndoAfterSave.OnClick:=cbScriptUndoAfterSaveClick;
    cbScriptKeepTrailingBlanks.OnClick:=cbScriptKeepTrailingBlanksClick;
    cbScriptDoubleClickLine.OnClick:=cbScriptDoubleClickLineClick;
    cbScriptSytaxHighlighting.OnClick:=cbScriptSytaxHighlightingClick;
    cbScriptRightMarginVisisble.OnClick:=cbScriptRightMarginVisisbleClick;
    udScriptRightMargin.OnChangingEx:=udScriptRightMarginChangingEx;
    udScriptGutterWidth.OnChangingEx:=udScriptGutterWidthChangingEx;
    cmbScriptSelBlockFormat.OnChange:=cmbScriptSelBlockFormatChange;
    edScriptTabStops.OnChange:=edScriptTabStopsChange;
    cbScriptAutoChange.OnClick:=cbScriptAutoChangeClick;
    udScriptAutoChange.OnChangingEx:=udScriptAutoChangeChangingEx;
    cmbScriptTypeHigh.OnChange:=cmbScriptTypeHighChange;
    cmbScriptFontName.OnChange:=cmbScriptFontNameChange;
    udScriptFontSize.OnChangingEx:=udScriptFontSizeChangingEx;
    cmbScriptRElement.OnChange:=cmbScriptRElementChange;
    chbScriptTextAttrBold.OnClick:=chbScriptTextAttrBoldClick;
    chbScriptTextAttrItalic.OnClick:=chbScriptTextAttrItalicClick;
    chbScriptTextAttrUnderline.OnClick:=chbScriptTextAttrUnderlineClick;
    cmbScriptFGColor.OnChange:=cmbScriptFGColorChange;
    cmbScriptBGColor.OnChange:=cmbScriptBGColorChange;

  end else begin
    cbScriptAutoIndent.OnClick:=nil;
    cbScriptSmartTab.OnClick:=nil;
    cbScriptBackspaceUnindents.OnClick:=nil;
    cbScriptGroupUndo.OnClick:=nil;
    cbScriptCursorBeyondEOF.OnClick:=nil;
    cbScriptUndoAfterSave.OnClick:=nil;
    cbScriptKeepTrailingBlanks.OnClick:=nil;
    cbScriptDoubleClickLine.OnClick:=nil;
    cbScriptSytaxHighlighting.OnClick:=nil;
    cbScriptRightMarginVisisble.OnClick:=nil;
    udScriptRightMargin.OnChanging:=nil;
    udScriptGutterWidth.OnChanging:=nil;
    cmbScriptSelBlockFormat.OnChange:=nil;
    edScriptTabStops.OnChange:=nil;
    cbScriptAutoChange.OnClick:=nil;
    udScriptAutoChange.OnChanging:=nil;
    cmbScriptTypeHigh.OnChange:=nil;
    cmbScriptFontName.OnChange:=nil;
    udScriptFontSize.OnChanging:=nil;
    cmbScriptRElement.OnChange:=nil;
    chbScriptTextAttrBold.OnClick:=nil;
    chbScriptTextAttrItalic.OnClick:=nil;
    chbScriptTextAttrUnderline.OnClick:=nil;
    cmbScriptFGColor.OnChange:=nil;
    cmbScriptBGColor.OnChange:=nil;

  end;

end;

procedure TfmOptions.cbScriptAutoIndentClick(Sender: TObject);
begin
  RaEditor.Autoindent:=cbScriptAutoIndent.Checked;
end;

procedure TfmOptions.cbScriptSmartTabClick(Sender: TObject);
begin
  RaEditor.SmartTab:=cbScriptSmartTab.Checked;
end;

procedure TfmOptions.cbScriptBackspaceUnindentsClick(Sender: TObject);
begin
  RaEditor.BackSpaceUnindents:=cbScriptBackspaceUnindents.Checked;
end;

procedure TfmOptions.cbScriptGroupUndoClick(Sender: TObject);
begin
  RaEditor.GroupUndo:=cbScriptGroupUndo.Checked;
end;

procedure TfmOptions.cbScriptCursorBeyondEOFClick(Sender: TObject);
begin
  RaEditor.CursorBeyondEOF:=cbScriptCursorBeyondEOF.Checked;
end;

procedure TfmOptions.cbScriptUndoAfterSaveClick(Sender: TObject);
begin
  RaEditor.UndoAfterSave:=cbScriptUndoAfterSave.Checked;
end;

procedure TfmOptions.cbScriptKeepTrailingBlanksClick(Sender: TObject);
begin
  RaEditor.KeepTrailingBlanks:=cbScriptKeepTrailingBlanks.Checked;
end;

procedure TfmOptions.cbScriptDoubleClickLineClick(Sender: TObject);
begin
  RaEditor.DoubleClickLine:=cbScriptDoubleClickLine.Checked;
end;

procedure TfmOptions.cbScriptSytaxHighlightingClick(Sender: TObject);
begin
  RaEditor.SyntaxHighlighting:=cbScriptSytaxHighlighting.Checked;
end;

procedure TfmOptions.cbScriptRightMarginVisisbleClick(Sender: TObject);
begin
  RaEditor.RightMarginVisible:=cbScriptRightMarginVisisble.Checked;
end;

procedure TfmOptions.cmbScriptSelBlockFormatChange(Sender: TObject);
begin
  RaEditor.SelBlockFormat:=TSelBlockFormat(cmbScriptSelBlockFormat.ItemIndex);
end;

procedure TfmOptions.edScriptTabStopsChange(Sender: TObject);
begin
  RaEditor.TabStops:=edScriptTabStops.Text;
end;

procedure TfmOptions.cbScriptAutoChangeClick(Sender: TObject);
begin
  if cbScriptAutoChange.Checked then begin
    edScriptAutoChange.Enabled:=true;
    edScriptAutoChange.Color:=clWindow;
    udScriptAutoChange.Enabled:=true;
  end else begin
    edScriptAutoChange.Enabled:=false;
    edScriptAutoChange.Color:=clBtnFace;
    udScriptAutoChange.Enabled:=false;
  end;
  RaEditor.Completion.Enabled:=cbScriptAutoChange.Checked;
  RaEditor.Completion.Interval:=udScriptAutoChange.Position;
end;

procedure TfmOptions.cmbScriptTypeHighChange(Sender: TObject);
begin
  RaEditor.HighLighter:=THighLighter(cmbScriptTypeHigh.ItemIndex);
end;

procedure TfmOptions.cmbScriptFontNameChange(Sender: TObject);
begin
  RaEditor.Font.Name:=TTSVFontBox(cmbScriptFontName).FontName;
end;

procedure TfmOptions.cmbScriptRElementChange(Sender: TObject);

  procedure SetLocalParams(sc: TSymbolColor);
  begin
    TTSVColorBox(cmbScriptFGColor).Selected:=sc.ForeColor;
    TTSVColorBox(cmbScriptBGColor).Selected:=sc.BackColor;
    chbScriptTextAttrBold.Checked:=fsBold in sc.Style;
    chbScriptTextAttrItalic.Checked:=fsItalic in sc.Style;
    chbScriptTextAttrUnderline.Checked:=fsUnderline in sc.Style;
  end;

var
  ra: TRAHLEditor;
begin
 ra:=RaEditor;
 SetDefaultChangeEventToScript(false);
 chbScriptTextAttrBold.Enabled:=true;
 chbScriptTextAttrItalic.Enabled:=true;
 chbScriptTextAttrUnderline.Enabled:=true;
 chbScriptTextAttrBold.Checked:=false;
 chbScriptTextAttrItalic.Checked:=false;
 chbScriptTextAttrUnderline.Checked:=false;
 cmbScriptFGColor.Enabled:=true;
 cmbScriptFGColor.Color:=clWindow;
 cmbScriptBGColor.Enabled:=true;
 cmbScriptBGColor.Color:=clWindow;
 case cmbScriptRElement.ItemIndex of
    0: begin // WhiteSpace
      cmbScriptFGColor.Enabled:=false;
      cmbScriptFGColor.Color:=clBtnFace;
      TTSVColorBox(cmbScriptBGColor).Selected:=ra.Color;
      TTSVColorBox(cmbScriptFGColor).Selected:=ra.Color;
      chbScriptTextAttrBold.Checked:=fsBold in ra.Font.Style;
      chbScriptTextAttrItalic.Checked:=fsItalic in ra.Font.Style;
      chbScriptTextAttrUnderline.Checked:=fsUnderline in ra.Font.Style;
    end;
    1: begin // Comment
      SetLocalParams(ra.Colors.Comment);
    end;
    2: begin // Reserved word
      SetLocalParams(ra.Colors.Reserved);
    end;
    3: begin // Identifer
      SetLocalParams(ra.Colors.Identifer);
    end;
    4: begin // Symbol
      SetLocalParams(ra.Colors.Symbol);
    end;
    5: begin // String
      SetLocalParams(ra.Colors.Strings);
    end;
    6: begin // Number
      SetLocalParams(ra.Colors.Number);
    end;
    7: begin // Preprocessor
      SetLocalParams(ra.Colors.Preproc);
    end;
    8: begin // Declaration
      SetLocalParams(ra.Colors.Declaration);
    end;
    9: begin // Function call
      SetLocalParams(ra.Colors.FunctionCall);
    end;
    10: begin // Statement
      SetLocalParams(ra.Colors.Statement);
    end;
    11: begin // Plain text
      SetLocalParams(ra.Colors.PlainText);
    end;
    12: begin // Marked block
      chbScriptTextAttrBold.Enabled:=false;
      chbScriptTextAttrItalic.Enabled:=false;
      chbScriptTextAttrUnderline.Enabled:=false;
      TTSVColorBox(cmbScriptFGColor).Selected:=ra.SelForeColor;
      TTSVColorBox(cmbScriptBGColor).Selected:=ra.SelBackColor;
    end;
    13: begin // Right margin
      chbScriptTextAttrBold.Enabled:=false;
      chbScriptTextAttrItalic.Enabled:=false;
      chbScriptTextAttrUnderline.Enabled:=false;
      cmbScriptBGColor.Enabled:=false;
      cmbScriptBGColor.Color:=clBtnFace;
      TTSVColorBox(cmbScriptBGColor).Selected:=ra.RightMarginColor;
      TTSVColorBox(cmbScriptFGColor).Selected:=ra.RightMarginColor;
    end;
    14: begin // Gutter
      chbScriptTextAttrBold.Enabled:=false;
      chbScriptTextAttrItalic.Enabled:=false;
      chbScriptTextAttrUnderline.Enabled:=false;
      cmbScriptFGColor.Enabled:=false;
      cmbScriptFGColor.Color:=clBtnFace;
      TTSVColorBox(cmbScriptBGColor).Selected:=ra.GutterColor;
      TTSVColorBox(cmbScriptFGColor).Selected:=ra.GutterColor;
    end;
    15: begin // Bookmark
      SetLocalParams(ra.Colors.Bookmark);
    end;
    16: begin // FindTxt
      SetLocalParams(ra.Colors.FindTxt);
    end;
    17: begin // ErrorLine
      SetLocalParams(ra.Colors.ErrorLine);
    end;
 end;
 SetDefaultChangeEventToScript(true);
end;

procedure TfmOptions.SetScriptColors;

  procedure SetLocalParams(sc: TSymbolColor);
  begin
   sc.ForeColor:=TTSVColorBox(cmbScriptFGColor).Selected;
   sc.BackColor:=TTSVColorBox(cmbScriptBGColor).Selected;
   if chbScriptTextAttrBold.Checked then sc.Style:=sc.Style+[fsBold]
   else sc.Style:=sc.Style-[fsBold];
   if chbScriptTextAttrItalic.Checked then sc.Style:=sc.Style+[fsItalic]
   else sc.Style:=sc.Style-[fsItalic];
   if chbScriptTextAttrUnderline.Checked then sc.Style:=sc.Style+[fsUnderline]
   else sc.Style:=sc.Style-[fsUnderline];
  end;

var
  ra: TRAHLEditor;  
begin
  ra:=RaEditor;
  case cmbScriptRElement.ItemIndex of
   0: begin // WhiteSpace
    ra.Color:=TTSVColorBox(cmbScriptBGColor).Selected;
    TTSVColorBox(cmbScriptFGColor).Selected:=ra.color;
    if chbScriptTextAttrBold.Checked then ra.Font.Style:=ra.Font.Style+[fsBold]
    else ra.Font.Style:=ra.Font.Style-[fsBold];
    if chbScriptTextAttrItalic.Checked then ra.Font.Style:=ra.Font.Style+[fsItalic]
    else ra.Font.Style:=ra.Font.Style-[fsItalic];
    if chbScriptTextAttrUnderline.Checked then ra.Font.Style:=ra.Font.Style+[fsUnderline]
    else ra.Font.Style:=ra.Font.Style-[fsUnderline];
   end;
   1: begin // Comment
    SetLocalParams(ra.Colors.Comment);
   end;
   2: begin // Reserved word
    SetLocalParams(ra.Colors.Reserved);
  //      ShowMessage(ColorToString(ra.colors.Reserved.ForeColor));
   end;
   3: begin // Identifer
    SetLocalParams(ra.Colors.Identifer);
   end;
   4: begin // Symbol
    SetLocalParams(ra.Colors.Symbol);
   end;
   5: begin // String
    SetLocalParams(ra.Colors.Strings);
   end;
   6: begin // Number
    SetLocalParams(ra.Colors.Number);
   end;
   7: begin // Preprocessor
    SetLocalParams(ra.Colors.Preproc);
   end;
   8: begin // Declaration
    SetLocalParams(ra.Colors.Declaration);
   end;
   9: begin // Function call
    SetLocalParams(ra.Colors.FunctionCall);
   end;
   10: begin // Statement
    SetLocalParams(ra.Colors.Statement);
   end;
   11: begin // Plain text
    SetLocalParams(ra.Colors.PlainText);
   end;
   12: begin // Marked block
    ra.SelForeColor:=TTSVColorBox(cmbScriptFGColor).Selected;
    ra.SelBackColor:=TTSVColorBox(cmbScriptBGColor).Selected;
   end;
   13: begin // Right margin
    ra.RightMarginColor:=TTSVColorBox(cmbScriptFGColor).Selected;
    TTSVColorBox(cmbScriptBGColor).Selected:=ra.RightMarginColor;
   end;
   14: begin // Gutter
    ra.GutterColor:=TTSVColorBox(cmbScriptBGColor).Selected;
    TTSVColorBox(cmbScriptFGColor).Selected:=ra.GutterColor;
   end;
   15: begin // Bookmark
     SetLocalParams(ra.Colors.Bookmark);
   end;
   16: begin // FindTxt
     SetLocalParams(ra.Colors.FindTxt);
   end;
   17: begin // ErrorLine
     SetLocalParams(ra.Colors.ErrorLine);
   end;
  end;
  ra.Repaint;
end;

procedure TfmOptions.cmbScriptFGColorChange(Sender: TObject);
begin
  SetScriptColors;
end;

procedure TfmOptions.cmbScriptBGColorChange(Sender: TObject);
begin
  SetScriptColors;
end;

procedure TfmOptions.chbScriptTextAttrBoldClick(Sender: TObject);
begin
  SetScriptColors;
end;

procedure TfmOptions.chbScriptTextAttrItalicClick(Sender: TObject);
begin
  SetScriptColors;
end;

procedure TfmOptions.chbScriptTextAttrUnderlineClick(Sender: TObject);
begin
  SetScriptColors;
end;

procedure TfmOptions.udScriptRightMarginChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
  RaEditor.RightMargin:=NewValue;
end;

procedure TfmOptions.udScriptGutterWidthChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
  RaEditor.GutterWidth:=NewValue;
end;

procedure TfmOptions.udScriptAutoChangeChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
  RaEditor.Completion.Interval:=NewValue;
end;

procedure TfmOptions.udScriptFontSizeChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
  RaEditor.Font.Size:=NewValue;
end;

procedure TfmOptions.grbScriptPreviewDblClick(Sender: TObject);
begin
  SetDefaultScriptEditorTSVParams;
end;

procedure TfmOptions.SetDefaultScriptEditorTSVParams;
begin
  with RaEditor.Colors do begin
    Comment.SetColor(clGray, clSilver, [fsItalic]);
    Number.SetColor(clBlue, clSilver, [fsBold]);
    Strings.SetColor(clBlue, clSilver, [fsBold]);
    Symbol.SetColor(clWhite, clSilver, [fsBold]);
    Reserved.SetColor(clWindowText, clSilver, [fsBold]);
    Statement.SetColor(clWindowText, clSilver, [fsBold]);
    Identifer.SetColor(clNavy, clSilver, [fsBold]);
    Preproc.SetColor(clGreen, clSilver, []);
    FunctionCall.SetColor(clWindowText, clSilver, []);
    Declaration.SetColor(clWindowText, clSilver, []);
    PlainText.SetColor(clWindowText, clSilver, []);
    Bookmark.SetColor(clRed, clBtnFace, [fsBold]);
    FindTxt.SetColor(clWhite, clBlack, []);
    ErrorLine.SetColor(clWhite, clMaroon, []);
  end;
  RaEditor.Color:=clSilver;
  RaEditor.GutterColor:=clBtnFace;
  RaEditor.RightMarginVisible:=false;
  SetSettingsFromRaEditorScript;
end;

end.