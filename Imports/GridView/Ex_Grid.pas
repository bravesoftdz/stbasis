{
  ���������� �������������� �����������

  GridView ��������� (�������)

  ��������� ��������:

  - ��������� �� TCustomControl; �� ������� TCustomGrid � �.�.
    ����������-������� �� Delphi, �� ����� ����������� ��� �����������
    ��������
  - �� ������ ������ ������ ����, ����� ������ �� �������� ������ ������
    ����� ��� ���������.
  - �������� ��� TListView � ������ ������� (�.�. ��� ViewStyle = vsReport)
  - �������������, ��������������� ������������� (����� ������� ���� ������
    �� ��������� �������) ���������; �� �������� �������������� ��������,
    ��� ��� ������� � TCustomGrid
  - ������������ ������ ������ ��������� �����, �� ������, ������
  - ���� ���� � ����� ��� ���������
  - ����������� ��������� ���� � ����� ������ ������ ���������
  - ����������� ��������������� �������� ���� ��������� (WordWrap)
  - ���������� ������ �������������� � ������� ... � ���������� �������,
    ��� ������ �������������� ����������
  - ��������� ������ �������, ������ �� ��������� ������ ��������� �������
  - ���������� ���������� �������
  - ������������ ������ ������� �����, �� ������, ������
  - ��������� ������ �������������� � ������������� ������ � �������� �
    ������������ � ������������� ������� ��������������
  - ������������� ������� (������ �����, �� ������������� �� �����������)
  - ��������� ���� � ����� ��� �������������
  - ����������� ������ ������ ����� � ���������� �� �����, ���� �����
    ������� �� ���������� � ������
  - ���������� ��������� �������� ��� �����
  - ������� �������������� ��������� �����
  - CellTips - Hint ��� �����, � ������� ����� �� ���������� ������� �
    ������ (������ ToolTips � TTreeView, ������ ��� Delphi3 � ����).
  - ����������� ���������� ��������� ������� �� ��������� ������
  - ����������� ����������� � ���������� ��������� �����
  - �������� ����������� �� ���������������� ��������� ����� � ������
    ��������� (������ TStringGrid.OnDrawCell)
  - ����������� ��������� ���� � ����� ������ ������ �� �� �� ���������
    (�.�. �� ������������ OnDrawCell)
  - ����������� ��� ��������� �� ��������� �������� ���� ������� �� ������
    � private ����� � ����� ���� ����� �������������� � �������� - ��������
  - ���� ��������� �������� � ������� ��� ������ � ��������

  �� ��������������:

  - ������ ������ �����
  - RangeSelect (��������� ���������� ����� ������������)
  - ����� ������ �������������� (������ �� ���� ����, �� � �� ������� �������
    Mask.pas, �� ����� �������)

  �������:

  - ��� ������ ��������� ��� ������ � ����������� ������� �� ���
    (������ Columnclick � TListView)
  - CellTips, �� ��������� �� Hint (��� ToolTips � TTreeView)

  ����� �. �������
  E-mail: roman@sar.nnov.ru
}

unit Ex_Grid;

interface

uses
  Windows, Messages, SysUtils, CommCtrl, Classes, Controls, Graphics, Forms,
  StdCtrls, Math, ImgList;

type

{ ��������������� ������ }

  TGridHeaderSections = class;
  TGridHeader = class;
  TGridColumn = class;
  TGridColumns = class;
  TGridRows = class;
  TGridFixed = class;
  TCustomGridView = class;

{ TGridHeaderSection }

  {
    ������ ���������.

    ��������:

    Column -         ������ ��������������� �������. ��� ��������� �
                     �������������� ������, �������������� ����������
                     ������������.
    Bounds -         ������������� ������.
    FixedSize -      ������� ��������� ��� ���� �� ��� �������������
                     ����������.
    Header -         ������ �� ��������� �������.
    Level -          ������� ���������. ����� ������� ��������� �����
                     ������� 0, ��� ��� - 1 � �.�.
    Parent -         ������ �� ������� ������.
    ParentSections - ������ �� ������ ������, �������� ����������� ������
                     ������.

    Alignment -      ������������ ������ ��������� �� �����������.
    Caption -        ����� ���������. ������������� ��������� �������.
    Sections -       ������ ������������� (�.�. ������ �����).
    Width -          ������ ���������. ����� ������ �������������� �������
                     ��� ����� ����� �������������.
    WordWrap -       ������� ���� ������ ���������.
  }

  TGridHeaderSection = class(TCollectionItem)
  private
    FSections: TGridHeaderSections;
    FCaption: string;
    FWidth: Integer;
    FAlignment: TAlignment;
    FWordWrap: Boolean;
    function GetBounds: TRect;
    function GetColumn: Integer;
    function GetFixedSize: Boolean;
    function GetHeader: TGridHeader;
    function GetLevel: Integer;
    function GetParent: TGridHeaderSection;
    function GetParentSections: TGridHeaderSections;
    function GetSections: TGridHeaderSections;
    function GetWidth: Integer;
    procedure SetAlignment(Value: TAlignment);
    procedure SetCaption(const Value: string);
    procedure SetSections(Value: TGridHeaderSections);
    procedure SetWidth(Value: Integer);
    procedure SetWordWrap(Value: Boolean);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Bounds: TRect read GetBounds;
    property Column: Integer read GetColumn;
    property FixedSize: Boolean read GetFixedSize;
    property Header: TGridHeader read GetHeader;
    property Level: Integer read GetLevel;
    property Parent: TGridHeaderSection read GetParent;
    property ParentSections: TGridHeaderSections read GetParentSections;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property Caption: string read FCaption write SetCaption;
    property Width: Integer read GetWidth write SetWidth default 64;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
    property Sections: TGridHeaderSections read GetSections write SetSections;
  end;

{ TGridHeaderSections }

  {
    ������ ������ ���������.

    ���������:

    Add -         �������� ����� ������ � ������.
    Synchronize - ���������� ���������� ������ ������ � �����������
                  ��������� ��������.

    ��������:

    Header -      ������ �� ��������� �������.
    MaxColumn -   ������������ ������ �������.
    MaxLevel -    ������������ ������� �������������.
    Owner -       ������ �� ������ - ���������.
    Sections -    ������ �������������.
  }

  TGridHeaderSections = class(TCollection)
  private
    FHeader: TGridHeader;
    FOwner: TGridHeaderSection;
    function GetMaxColumn: Integer;
    function GetMaxLevel: Integer;
    function GetSection(Index: Integer): TGridHeaderSection;
    procedure SetSection(Index: Integer; Value: TGridHeaderSection);
  protected
    function GetOwner: TPersistent; {$IFNDEF VER90} override; {$ENDIF}
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AHeader: TGridHeader; AOwner: TGridHeaderSection);
    function Add: TGridHeaderSection;
    procedure Synchronize(Columns: TGridColumns);
    property Header: TGridHeader read FHeader;
    property MaxColumn: Integer read GetMaxColumn;
    property MaxLevel: Integer read GetMaxLevel;
    property Owner: TGridHeaderSection read FOwner;
    property Sections[Index: Integer]: TGridHeaderSection read GetSection write SetSection; default;
  end;

{ TGridHeader }

  {
    ��������� �������.

    ��������:

    Grid -              ������ �� �������.
    Height -            ������.
    MaxColumn -         ������������ ������ �������.
    MaxLevel -          ������������ ������� �������������.
    Width -             ������

    AutoSynchronize -   ������������� ���������������� ������ ��������� �
                        ���������.
    Color -             ���� ����.
    Font -              �����.
    FullSynchronizing - ��������� ���������������� ������ ��������� �
                        ���������, ������� ����� ��������� � ������������
                        ������. � ��������� ������ ���������������� ������
                        ���������� ������ � ����������� �������.
    GridColor -         ����� �� � �������� ����� ��������� ���� �������.
    GridFont -          ����� �� � �������� ������ ��������� ����� �������.
    SectionHeight -     ������ ����� ������ (������������)
    Sections -          ������ �������������.
    Synchronized -      ������ ��������� ���������������� � ���������
                        �������.

    �������:

    OnChange -        ������� �� ��������� ����������.
  }

  TGridHeader = class(TPersistent)
  private
    FGrid: TCustomGridView;
    FSections: TGridHeaderSections;
    FSectionHeight: Integer;
    FSynchronized: Boolean;
    FAutoSynchronize: Boolean;
    FFullSynchronizing: Boolean;
    FColor: TColor;
    FGridColor: Boolean;
    FFont: TFont;
    FGridFont: Boolean;
    FOnChange: TNotifyEvent;
    procedure FontChange(Sender: TObject);
    function GetHeight: Integer;
    function GetMaxColumn: Integer;
    function GetMaxLevel: Integer;
    function GetWidth: Integer;
    procedure GridColorChanged(NewColor: TColor);
    procedure GridFontChanged(NewFont: TFont);
    procedure SetAutoSynchronize(Value: Boolean);
    procedure SetColor(Value: TColor);
    procedure SetFont(Value: TFont);
    procedure SetGridColor(Value: Boolean);
    procedure SetGridFont(Value: Boolean);
    procedure SetSections(Value: TGridHeaderSections);
    procedure SetSectionHeight(Value: Integer);
    procedure SetSynchronized(Value: Boolean);
  protected
    procedure Change; virtual;
  public
    constructor Create(AGrid: TCustomGridView);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Grid: TCustomGridView read FGrid;
    property Height: Integer read GetHeight;
    property MaxColumn: Integer read GetMaxColumn;
    property MaxLevel: Integer read GetMaxLevel;
    property Width: Integer read GetWidth;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property AutoSynchronize: Boolean read FAutoSynchronize write SetAutoSynchronize default True;
    property Color: TColor read FColor write SetColor default clBtnFace;
    property Font: TFont read FFont write SetFont;
    property FullSynchronizing: Boolean read FFullSynchronizing write FFullSynchronizing default False;
    property GridColor: Boolean read FGridColor write SetGridColor default False;
    property GridFont: Boolean read FGridFont write SetGridFont default True;
    property Sections: TGridHeaderSections read FSections write SetSections;
    property SectionHeight: Integer read FSectionHeight write SetSectionHeight default 17;
    property Synchronized: Boolean read FSynchronized write SetSynchronized default True;
  end;

{ TGridColumn }

  {
    ������� �������.

    ��������: 

    Columns -   ������ �� ������ �������.

    Alignment - ������������ ������ �������.
    Caption -   ����� ���������.
    FixedSize - ������ ������� ���������.
    MaxLength - ������������ ����� �������������� ������.
    MultiLine - ����� �� ���� ����� � ������� �������������.
    ReadOnly  - �� �������������.
    Visible -   ���������.
    Width -     ������ �������. ���� ������� �� ������, ���������� ����.
    DefWidth -  �������� ������ �������. �� ������� �� ��������� �������.
  }

  TGridColumn = class(TCollectionItem)
  private
    FColumns: TGridColumns;
    FCaption: string;
    FWidth: Integer;
    FDefWidth: Integer;
    FFixedSize: Boolean;
    FMaxLength: Integer;
    FAlignment: TAlignment;
    FReadOnly: Boolean;
    FMultiLine: Boolean;
    FVisible: Boolean;
    function GetWidth: Integer;
    procedure SetAlignment(Value: TAlignment);
    procedure SetCaption(const Value: string);
    procedure SetMaxLength(Value: Integer);
    procedure SetMultiLine(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure SetVisible(Value: Boolean);
    procedure SetWidth(Value: Integer);
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    property Columns: TGridColumns read FColumns;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property Caption: string read FCaption write SetCaption;
    property FixedSize: Boolean read FFixedSize write FFixedSize default False;
    property MaxLength: Integer read FMaxLength write SetMaxLength default 0;
    property MultiLine: Boolean read FMultiLine write SetMultiLine default False;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property Visible: Boolean read FVisible write SetVisible default True;
    property Width: Integer read GetWidth write SetWidth default 64;
    property DefWidth: Integer read FWidth write SetWidth default 64;
  end;

{ TGridColumns }

  {
    ������ ������� �������.

    ���������:

    Add -     �������� �������.

    ��������:

    Columns - ������ �������.
    Grid    - ������ �� �������.
  }

  TGridColumns = class(TCollection)
  private
    FGrid: TCustomGridView;
    FOnChange: TNotifyEvent;
    function GetColumn(Index: Integer): TGridColumn;
    procedure SetColumn(Index: Integer; Value: TGridColumn);
  protected
    function GetOwner: TPersistent; {$IFNDEF VER90} override; {$ENDIF}
    procedure Update(Item: TCollectionItem); override;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    constructor Create(AGrid: TCustomGridView);
    function Add: TGridColumn;
    property Columns[Index: Integer]: TGridColumn read GetColumn write SetColumn; default;
    property Grid: TCustomGridView read FGrid;
  end;

{ TGridRows }

  {
    ������ �������.

    ��������:

    MaxCount -  ����������� ���������� ���������� ����� � �������. �������
                �� ������ ������.
                
    Count -     ���������� ����� � �������.
    Grid -      ������ �� �������.
    Height -    ������ ����� ������. �� ����� ���� ������ ������ ��������
                �������.

    �������:

    OnChange -        ������� �� ��������� ����������.
  }

  TGridRows = class(TPersistent)
  private
    FGrid: TCustomGridView;
    FCount: Integer;
    FHeight: Integer;
    FOnChange: TNotifyEvent;
    function GetMaxCount: Integer;
    procedure SetHeight(Value: Integer);  
  protected
    procedure Change; virtual;
    procedure SetCount(Value: Integer); virtual;
  public
    constructor Create(AGrid: TCustomGridView);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property MaxCount: Integer read GetMaxCount;
    property Grid: TCustomGridView read FGrid;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property Count: Integer read FCount write SetCount default 0;
    property Height: Integer read FHeight write SetHeight default 17;
  end;

{ TGridFixed }

  {
    ��������� �������������� ������� �������.

    Count -     ���������� ������������� ��������. �� ����� ���� ������, ���
                ���������� �������� ������� ����� 1.
    Color -     ���� ������������� �����.
    Font -      �����.
    GridColor - ����� �� � �������� ����� ������������� ���� �������.
    GridFont -  ����� �� � �������� ������ ������������� ����� �������.

    �������:

    OnChange -  ������� �� ��������� ����������.
  }

  TGridFixed = class(TPersistent)
  private
    FGrid: TCustomGridView;
    FCount: Integer;
    FColor: TColor;
    FGridColor: Boolean;
    FFont: TFont;
    FGridFont: Boolean;
    FOnChange: TNotifyEvent;
    procedure FontChange(Sender: TObject);
    procedure GridColorChanged(NewColor: TColor);
    procedure GridFontChanged(NewFont: TFont);
    procedure SetColor(Value: TColor);
    procedure SetFont(Value: TFont);
    procedure SetGridColor(Value: Boolean);
    procedure SetGridFont(Value: Boolean);
  protected
    procedure Change; virtual;
    procedure SetCount(Value: Integer); virtual;
  public
    constructor Create(AGrid: TCustomGridView);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Grid: TCustomGridView read FGrid;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property Color: TColor read FColor write SetColor default clBtnFace;
    property Count: Integer read FCount write SetCount default 0;
    property Font: TFont read FFont write SetFont;
    property GridColor: Boolean read FGridColor write SetGridColor default False;
    property GridFont: Boolean read FGridFont write SetGridFont default True;
  end;

{ TGridCell }

  TGridCell = record
    Col: Longint;
    Row: Longint;
  end;

{ TGridScrollBar }

  {
    ������ ��������� �������.

    ���������:

    Change -        ���������� ������ ����� ��������� �������. 
    Scroll -        ���������� ��������������� ����� ���������� ������� ���
                    ������������� ������ ���������.
    ScrollMessage - ���������� ��������� Windows � ������� �� ��������.
    SetParams -     ���������� �������.
    SetPosition -   ���������� �������.
    SetPositionEx - ���������� �������.

    ��������:

    Grid -          ������ �� �������.
    Kind -          ��� ��������� (�������������� ��� ������������).
    LineStep -      ����� ���.
    LineSize -      ������ ������������� ����� ���� ��� �������� �� 1
                    �������.
    PageStep -      ������� ���.
    Position -      ������� �������.
    Range -         ��������.

    Tracking -      ������� ����������� ��������� ������� ��� �����������
                    ������ ������������ ������.
    Visible -       ��������� ���������.

    �������:

    OnChange -      ��������� ��������� ���������.
    OnScroll -      ���������� ��������������� ����� ���������� ���������
                    ���������.
  }

  TGridScrollEvent = procedure(Sender: TObject; ScrollCode: Integer; var ScrollPos: Integer) of object;

  TGridScrollBar = class(TPersistent)
  private
    FGrid: TCustomGridView;
    FKind: TScrollBarKind;
    FPosition: Integer;
    FRange: Integer;
    FPageStep: Integer;
    FLineStep: Integer;
    FLineSize: Integer;
    FTracking: Boolean;
    FVisible: Boolean;
    FUpdateCount: Integer;
    FOnScroll: TGridScrollEvent;
    FOnChange: TNotifyEvent;
    function GetScrollPos(WinPos: Integer): Integer;
    function GetWinPos(ScrollPos: Integer): Integer;
    procedure SetLineSize(Value: Integer);
    procedure SetLineStep(Value: Integer);
    procedure SetPageStep(Value: Integer);
    procedure SetRange(Value: Integer);
    procedure SetVisible(Value: Boolean);
    procedure Update;
  protected
    procedure Change; virtual;
    procedure Scroll(ScrollCode: Integer; var ScrollPos: Integer); virtual;
    procedure ScrollMessage(var Message: TWMScroll);
    procedure SetParams(ARange, APageStep, ALineStep: Integer);
    procedure SetPosition(Value: Integer);
    procedure SetPositionEx(Value: Integer; ScrollCode: Integer);
  public
    constructor Create(AGrid: TCustomGridView; AKind: TScrollBarKind);
    procedure Assign(Source: TPersistent); override;
    property Grid: TCustomGridView read FGrid;
    property Kind: TScrollBarKind read FKind;
    property LineStep: Integer read FLineStep write SetLineStep;
    property LineSize: Integer read FLineStep write SetLineSize;
    property PageStep: Integer read FPageStep write SetPageStep;
    property Position: Integer read FPosition write SetPosition;
    property Range: Integer read FRange write SetRange;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnScroll: TGridScrollEvent read FOnScroll write FOnScroll;
  published
    property Tracking: Boolean read FTracking write FTracking default True;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

{ TGridListBox }

  {
    ���������� ������ ������ ��������������.
  }

  TGridListBox = class(TCustomListBox)
  private
    FGrid: TCustomGridView;
    FSearchText: String;
    FSearchTime: Longint;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    property Grid: TCustomGridView read FGrid;
  end;

{ TGridEdit }

  {
    ������ ����� �������.

    ���������:

    PaintButton -      �������� ������.
    UpdateBounds -     ����������� ��������� � ������� ������ � �����������
                       ������� �� (���������� ��������������� �� ������
                       Show).
    UpdateColors -     ����������� ����� ������ � ������.
    UpdateContents -   ����������� ������ ������, ������������ ����� ������
                       � ����������� ��������������.
    UpdateList -       ���������� ����������� ������.
    UpdateListBounds - ����������� ��������� � ������� ����������� ������.
    UpdateStyle -      ����������� ���� ������.

    CloseUp -          ������� ���������� ������.
    DropDown -         ������� ���������� ������. ���� ��� ������ - ������
                       (EditStyle = geEllipsis), �� ����������� ������� ��
                       ������.
    Press -            ������� �� ������ � ���������� (������ ��� �����
                       Ctrl+Enter ��� MultiLine = False).
    SelectNext -       ������� ������� ��������� �������� �� ������ (�����
                       Ctrl+Enter ��� MultiLine = False).

    ��������:

    ButtonRect -       ������������� ������.
    ButtonWidth -      ������ ������.
    DropDownCount -    ���������� ����� � ���������� ������.
    DropList -         ���������� ������.
    EditStyle -        ��� ������.
    Grid -             ������ �� ������.
    LineCount -        ���������� ����� � ������.
    MultiLine -        ����� �� ���� ����� � ������ �������������.
  }

  TGridEditStyle = (geSimple, geEllipsis, gePickList, geDataList);

  TGridEdit = class(TCustomEdit)
  private
    FGrid: TCustomGridView;
    FClickTime: Longint;
    FEditStyle: TGridEditStyle;
    FMultiLine: Boolean;
    FDropDownCount: Integer;
    FDropList: TGridListBox;
    FDropListVisible: Boolean;
    FButtonWidth: Integer;
    FButtonTracking: Boolean;
    FButtonPressed: Boolean;
    function GetButtonRect: TRect;
    function GetLineCount: Integer;
    function GetVisible: Boolean;
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SetButtonWidth(Value: Integer);
    procedure SetEditStyle(Value: TGridEditStyle);
    procedure StartButtonTracking(X, Y: Integer);
    procedure StepButtonTracking(X, Y: Integer);
    procedure StopButtonTracking;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMPaste(var Message); message WM_PASTE;
    procedure WMCut(var Message); message WM_CUT;
    procedure WMClear(var Message); message WM_CLEAR;
    procedure WMCancelMode(var Message: TMessage); message WM_CANCELMODE;
    procedure WMKillFocus(var Message: TMessage); message WM_KILLFOCUS;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DblClick; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure PaintButton(DC: HDC); virtual;
    procedure PaintWindow(DC: HDC); override;
    procedure UpdateBounds; virtual;
    procedure UpdateColors; virtual;
    procedure UpdateContents; virtual;
    procedure UpdateList; virtual;
    procedure UpdateListBounds; virtual;
    procedure UpdateStyle; virtual;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CloseUp(Accept: Boolean);
    procedure Deselect;
    procedure DropDown;
    procedure Invalidate; override;
    procedure Hide;
    procedure Press;
    procedure SelectNext;
    procedure SetFocus; override;
    procedure Show;
    property ButtonRect: TRect read GetButtonRect;
    property ButtonWidth: Integer read FButtonWidth write SetButtonWidth;
    property Color;
    property DropDownCount: Integer read FDropDownCount write FDropDownCount;
    property DropList: TGridListBox read FDropList;
    property EditStyle: TGridEditStyle read FEditStyle write SetEditStyle;
    property Font;
    property Grid: TCustomGridView read FGrid;
    property LineCount: Integer read GetLineCount;
    property MaxLength;
    property MultiLine: Boolean read FMultiLine write FMultiLine;
    property Visible: Boolean read GetVisible;
  end;

{ TGridTipsWindow }

  TGridTipsWindowClass = class of TGridTipsWindow;
  
  TGridTipsWindow = class(THintWindow)
  private
    FGrid: TCustomGridView;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
    procedure Paint; override;
  public
    procedure ActivateHint(Rect: TRect; const AHint: string); override;
{$IFNDEF VER90}
    procedure ActivateHintData(Rect: TRect; const AHint: string; AData: Pointer); override;
    function CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect; override; 
{$ENDIF}
  end;

{ TCustomGridView }

  {
    �������.

    ���������:

    AcquireFocus -         ��������� ������ �� ������ ��� ������ �����.
                           ���������� False, ���� �� ���� ���� �������� �����
                           �� ����������.
    CellClick -            ������� ������ �� ������.
    Change -               ������ �������.
    Changing -             ������ ����������.
    ColumnResize -         �������� ������ �������.
    ColumnResizing -       ���������� ������ �������.
    CreateColumn -         ������� �������.
    CreateEdit -           ������� ������ ��������������.
    CreateEditList -       ������� ���������� ������ ������ ��������������.
    CreateFixed -          ������� ������ ������������� �������.
    CreateHeader -         ������� ���������.
    CreateHeaderSection -  ������� ������ ���������.
    CreateRows -           ������� ������ �����.
    CreateScrollBar -      ������� ������ ���������.
    EditButtonPress -      ��������� ������� �� ������ ������ ��������������.
    EditCanModify -        ����� �� ������������� ����� � ������.
    EditCanAcceptKey -     ����� �� ������� ��������� ������ � ������.
    EditCanShow -          ����� �� ���� �������� ������ �����.
    GetCellBorder -        ������� ������ ������ ������ (�������� ��
                           ����������� ������������ ������� ����). ��
                           ��������� �� ������ ������ ������� ��������.
    GetCellColors -        ��������� ������ ������ � ����������� �� ������,
                           ��������� � �.�.
    GetCellImage -         ������� ����� �������� ������.
    GetCellText -          ������� ����� ������.
    GetCursorCell -        ����� ������, �� ������� ����� ���������� ������.
                           � �������� ���������� ���������� ������ � ��������
                           �� ���� ������. ���� ���������� ����� ��������
                           ������ �� ����� ��������� �����, � ���������
                           �����������  ������ ��������� ��������� ������.
                           �������� �������� ����� ��������� ���������
                           ��������:
                             goLeft -     ���������� �� ��������� �� ����
                                          ������� �����.
                             goRight -    ���������� �� ��������� �� ����
                                          ������� ������.
                             goUp -       ���������� �� ��������� �� ����
                                          ������� �����.
                             goDown -     ���������� �� ��������� �� ����
                                          ������� ����.
                             goPageUp -   ���������� �� ��������� ��
                                          �������� �����.
                             goPageDown - ���������� �� ��������� ��
                                          �������� ����.
                             goHome -     ���������� � ������� ����� ����
                                          �������.
                             goEnd -      ���������� � ������ ������ ����
                                          �������.
                             goSelect -   �������� ��������� ������. ����
                                          ������ �� ��������, �����
                                          ���������� �� ��� �� ������ ��� �
                                          ��� �� �������.
                             goFirst -    ����� ������ ��������� ������.
    GetEditList -          ��������� ���������� ������ ������ ��������������.
    GetEditListBounds -    ���������� ��������� ����������� ������ ������
                           ��������������.
    GetEditRect -          ������� ������������� ��� ������ ��������������.
                           �� ��������� ����� �������������� ������.
    GetEditStyle -         ������� ����� ����� ��������������.
    GetEditText -          ������� ����� ������ ��� ��������������.
    GetHeaderColors -      ��������� ������ ������ ���������.
    HideCursor -           �������� ������.
    HideEdit -             ������ ������ ��������������.
    HideFocus -            �������� ������������� ������.
    PaintCells -           �������� ������.
    PaintCell -            �������� ������.
    PaintCells -           �������� ������.
    PaintCellText -        �������� ����� ������.
    PaintFixed -           �������� ������������� ������.
    PaintFocus -           �������� ������������� ������.
    PaintFreeField -       �������� �������, ��������� �� �����.
    PaintGridLines -       �������� ����� �����.
    PaintHeader -          �������� ������ ���������.
    PaintHeaders -         �������� ���������.
    PaintHeaderSections -  �������� ������ ���������. 
    PaintResizeLine -      �������� ����� ��� ��������� ������� �������.
    SetEditText -          ��������� ����� � ������ �� ������ �����.
                           ���������� ��� ����� ������. ���� ����� ��
                           �����������, ������� ������� ����������.
    SetCursor -            ��������� ������ � ��������� ������.
    ShowCursor -           �������� ������.
    ShowEdit -             �������� ������ ��������������.
    ShowEditChar -         �������� ������ �������������� � �������� ��
                           ������.
    ShowFocus -            �������� ������������� ������.
    UpdateCursor -         ���������� ��������� �������.
    UpdateColors -         ���������� ������ ��������� � ������������� ���
                           ��������� ����� �������.
    UpdateEdit -           ���������� ���������, ������ ������ ����� � ��
                           ���������.
    UpdateFocus -          ���������� ����� �� ������, ���� ��� ��������.
    UpdateFonts -          ���������� ������� ��������� � ������������� ���
                           ��������� ������ �������.
    UpdateHeader -         ���������� ��������� (���������� � ����������� �
                           ���������, ���� ����� ���� AutoSynchronize ���
                           Synchronized).
    UpdateScrollBars -     ���������� �������� ����� ���������.
    UpdateScrollPos -      ���������� ��������� ������� ����� ���������.
    UpdateScrollRange -    ���������� �������� ������� ������� �����.
    UpdateEditText -       ���������� ������ ������� �� ������ �����.

    InvalidateCell -       ������������ ������.
    InvalidateColumn -     ������������ �������.
    InvalidateFixed -      ������������ ������������� �������.
    InvalidateFocus -      ������������ ����� (������ ��� ������).
    InvalidateGrid -       ������������ ������� (��� ������).
    InvalidateHeader -     ������������ ���������.
    InvalidateRect -       �������� ������������� �������.
    InvalidateRow -        ������������ ������.
    IsActiveControl -      �������� �� ������� ������� �������� �����������
                           �����.
    IsCellAcceptCursor -   ����� �� ���������� ������ � ������.
    IsCellCorrect -        �������� ������������ ������ (��������� ������,
                           ���������, ����� �� ������� �������� � �����).
    IsCellHasImage -       �������� �� ������� �������� � ������.
    IsCellFocused -        �������� �� ��������� ������ � �����.
    IsCellVisible -        �������� ��������� ����� �� ������.
    IsColumnVisible -      �������� ��������� ������� �� ������.
    IsFocusAllowed -       ������� ��������� ������. ����� �����, ����
                           ��������� ��������� ������ ��� ���������
                           ��������������. � ��������� ������ �� �����
                           ������ ��������� ������ �����.
    IsRowVisible -         �������� ��������� ������.
    GetCellAt -            ����� ������ �� �����. ���������� (-1, -1), ����
                           �� �������.
    GetCellRect -          ������������� ������.
    GetColumnAt -          ����� ������� �� �����. ���������� -1, ���� ��
                           �������.
    GetColumnMaxWidth -    ����������� ������ �������� ������ � ���������
                           �������.
    GetColumnRect -        ������������� �������.
    GetColumnsWidth -      ��������� ������ ������� � ��������� �� ���������.
    GetFixedRect -         ������������� ������������� �������.
    GetFixedWidth -        ��������� ������ ������������� �������.
    GetFocusRect -         ������������� ������. �� ��������� ����������� �
                           ������ ����������� ��������� � ������� ��������.
    GetGridHeight -        ������ ������� ����� �����.
    GetGridOrigin -        �������� ������ ������ ������������ ������
                           �������� ���� �������� �������������� �������
                           (�.�. �������� ���������).
    GetGridRect -          ������������� ������� ����� �����.
    GetHeaderHeight -      ������ ���������. ����� 0, ���� �� �����.
    GetHeaderRect -        ������������� ���������.
    GetResizeSection -     ������� ������ ���������, ��� ������ ��������
                           ������� ��������� ��������� �����.
    GetRowAt -             ����� ������ �� �����.
    GetRowRect -           ������������� ������.
    GetRowsHeight -        ������� ��������� ������ ����� �� ��������� ��
                           ���������.
    GetTipsRect -          ��������� ������������� ��� ������ ��������� �
                           ������� ������.
    GetTipsWindow -        ������� ����� ���� ��������� ������.
    LockUpdate -           ������������� �����������.
    UnLockUpdate -         �������������� �����������.

    ��������:

    CellFocused -          ������� ��������� �������.
    Cells -                ������ � ����������� ������.
    CellSelected -         ������� ������������ �������.
    Edit -                 ������ ��������������.
    EditCell -             ������ ��������������.
    Editing -              ���� �������������� ������.
    TipsCell -             ������, ��� ������� ������������� ���������.
    VisOrigin -            ������ ������� ������.
    VisSize -              ���������� ������� �����.

    AllowEdit -            ��������� �� ��������� �������������� �������.
    AlwaysSelected -       ������ ���������� ����� ����������.
    BorderStyle -          ������ �������.
    Columns -              ������ ������� �������.
    EndEllipsis -          �������� ��� ��� �������������� � ������ ����� �
                           ... (����������) �� �����. �������� ������ ���
                           ������������� ������ � ����������� �����. ������
                           ������ �� �������� ���������.
    Fixed -                ��������� ������������� �������.
    GridLines -            �������� ��� ��� ����� �����.
    Header -               ���������.
    HideSelection -        ������ ��� ��� ������ ��� ���������� ������.
    Images -               ������ ��������.
    RightClickSelect -     ����������� ��� ��� ��������� ������ ������
                           �������� �����.
    Rows -                 ��������� ����� ������.
    RowSelect -            ��������� �� ����� ������ ��� �� ������.
    ShowCellTips -         ���������� ��� ��� Hint � ������� ������, ����
                           ����� �� ���������� ������� � ������ (��� D3 �
                           ����). ��������: ������� �� ����������� Hint-�,
                           ��� ����������� ��������� ���������� ����������
                           ShowHint � True. ���� ShowCellTips �����������,
                           �� ������� Hint - ������������ �� ����� (�.�.
                           ���� Hint, ���� CellTips).
    ShowFocusRect -        ���������� ����� ������.
    ShowHeader -           ����������� ���������.
    VertScrollBar -        ������������ ��������.

    �������:

    OnCellClick -          ������ ������ �� ������.
    OnChange -             C�������� ���������� ������. ���������� �����
                           ����� ��������� ������� �������.
    OnChangeColumns -      ��������� ��������� ������� �������.
    OnChangeFixed -        ��������� ��������� ������������� ������� �������.
    OnChangeRows -         ��������� ��������� ����� �������.
    OnChanging -           �������� ���������� ������. ����������
                           ��������������� ����� ���������� ������ �������.
    OnColumnResize -       ������ ������� ����������.
    OnColumnResizing -     ���������� ������ �������.
    OnDrawCell -           ��������� ������. ���� ���������� ��������
                           ����� ������, �� �������� ����������� ���������,
                           ������� ��������������� ������ ��������� �
                           ������� OnGetCellColors.
    OnDrawHeader -         ��������� ������ ������. ���� ���������� ��������
                           ����� ������, �� �������� ����������� ���������,
                           ������� ��������������� ������ ��������� �
                           ������� OnGetHeaderColors.
    OnEditAcceptKey -      �������� ������������ ������� ������.
    OnEditButtonPress -    ������ ������ � ���������� � ������ �����.
    OnEditSelectNext -     ����� Ctrl+Enter �� ������ � ����������� �������
                           (�� ���� ������� � ������ �������� ���������
                           �������� �� ������).
    OnGetCellImage -       ������� ����� �������� ������.
    OnGetCellColors -      ����������� ����� ������.
    OnGetCellText -        �������� ����� ������.
    OnGetEditList -        ��������� ���������� ������ ������ ��������������.
    OnGetEditListBounds -  ���������� ��������� � ������� ����������� ������
                           ������ ��������������.
    OnGetEditStyle -       ���������� ����� ������ ��������������.
    OnGetEditText -        ������� ����� ������ ��� ��������������. ��
                           ��������� ������� ����� ������.
    OnGetHeaderColors -    ����������� ����� ������ ���������.
    OnResize -             ��������� ������� �������.
    OnSetEditText -        ���������� ���� ������. ���������� ��� �����������
                           �������. ���� ����� �� �����������, �������
                           ������� ����������.
  }

  TGridOffset = (goLeft, goRight, goUp, goDown, goPageUp, goPageDown,
    goHome, goEnd, goSelect, goFirst);

  TGridTextEvent = procedure(Sender: TObject; Cell: TGridCell; var Value: string) of object;
  TGridCellColorsEvent = procedure(Sender: TObject; Cell: TGridCell; Canvas: TCanvas) of object;
  TGridCellImageEvent = procedure(Sender: TObject; Cell: TGridCell; var ImageIndex: Integer) of object;
  TGridCellClickEvent = procedure(Sender: TObject; Cell: TGridCell; Shift: TShiftState; X, Y: Integer) of object;
  TGridCellAcceptCursorEvent = procedure(Sender: TObject; Cell: TGridCell; var Accept: Boolean) of object;
  TGridCellNotifyEvent = procedure(Sender: TObject; Cell: TGridCell) of object;
  TGridHeaderColorsEvent = procedure(Sender: TObject; Section: TGridHeaderSection; Canvas: TCanvas) of object;
  TGridDrawCellEvent = procedure(Sender: TObject; Cell: TGridCell; var Rect: TRect; var DefaultDrawing: Boolean) of object;
  TGridDrawHeaderEvent = procedure(Sender: TObject; Section: TGridHeaderSection; Rect: TRect; var DefaultDrawing: Boolean) of object;
  TGridColumnResizeEvent = procedure(Sender: TObject; Column: Integer; var Width: Integer) of object;
  TGridChangingEvent = procedure(Sender: TObject; var Cell: TGridCell; var Selected: Boolean) of object;
  TGridChangedEvent = procedure(Sender: TObject; Cell: TGridCell; Selected: Boolean) of object;
  TGridEditStyleEvent = procedure(Sender: TObject; Cell: TGridCell; var Style: TGridEditStyle) of object;
  TGridEditListEvent = procedure(Sender: TObject; Cell: TGridCell; Items: TStrings) of object;
  TGridEditListBoundsEvent = procedure(Sender: TObject; Cell: TGridCell; var Rect: TRect) of object;
  TGridAcceptKeyEvent = procedure(Sender: TObject; Key: Char; Accept: Boolean) of object;

  TCustomGridView = class(TCustomControl)
  private
    FHorzScrollBar: TGridScrollBar;
    FVertScrollBar: TGridScrollBar;
    FHeader: TGridHeader;
    FColumns: TGridColumns;
    FRows: TGridRows;
    FFixed: TGridFixed;                         
    FImages: TImageList;
    FImagesLink: TChangeLink;
    FCellFocused: TGridCell;
    FCellSelected: Boolean;
    FVisOrigin: TGridCell;
    FVisSize: TGridCell;
    FBorderStyle: TBorderStyle;
    FHideSelection: Boolean;
    FShowHeader: Boolean;
    FGridLines: Boolean;
    FGridLineWidth: Integer;
    FEndEllipsis: Boolean;
    FShowFocusRect: Boolean;
    FAlwaysSelected: Boolean;
    FRowSelect: Boolean;
    FRightClickSelect: Boolean;
    FHitTest: TPoint;
    FColResizing: Boolean;
    FColResizeSection: TGridHeaderSection;
    FColResizeOffset: Integer;
    FColResizeRect: TRect;
    FColResizePos: Integer;
    FColResizeCount: Integer;
    FLockUpdate: Integer;
    FAllowEdit: Boolean;
    FAlwaysEdit: Boolean;
    FEdit: TGridEdit;
    FEditCell: TGridCell;
    FEditing: Boolean;
    FShowCellTips: Boolean;
    FTipsCell: TGridCell;
    FOnGetCellText: TGridTextEvent;
    FOnGetCellColors: TGridCellColorsEvent;
    FOnGetCellImage: TGridCellImageEvent;
    FOnGetHeaderColors: TGridHeaderColorsEvent;
    FOnDrawCell: TGridDrawCellEvent;
    FOnDrawHeader: TGridDrawHeaderEvent;
    FOnColumnResizing: TGridColumnResizeEvent;
    FOnColumnResize: TGridColumnResizeEvent;
    FOnChangeColumns: TNotifyEvent;
    FOnChangeRows: TNotifyEvent;
    FOnChangeFixed: TNotifyEvent;
    FOnCellAcceptCursor: TGridCellAcceptCursorEvent;
    FOnChanging: TGridChangingEvent;
    FOnChange: TGridChangedEvent;
    FOnCellClick: TGridCellClickEvent;
    FOnGetEditStyle: TGridEditStyleEvent;
    FOnGetEditText: TGridTextEvent;
    FOnSetEditText: TGridTextEvent;
    FOnGetEditList: TGridEditListEvent;
    FOnGetEditListBounds: TGridEditListBoundsEvent;
    FOnEditAcceptKey: TGridAcceptKeyEvent;
    FOnEditButtonPress: TGridCellNotifyEvent;
    FOnEditSelectNext: TGridCellNotifyEvent;
    FOnResize: TNotifyEvent;
    function GetCell(Col, Row: Integer): string;
    procedure ColumnsChange(Sender: TObject);
    procedure FixedChange(Sender: TObject);
    procedure HeaderChange(Sender: TObject);
    procedure HorzScroll(Sender: TObject; ScrollCode: Integer; var ScrollPos: Integer);
    procedure HorzScrollChange(Sender: TObject);
    procedure ImagesChange(Sender: TObject);
    procedure RowsChange(Sender: TObject);
    procedure SetAllowEdit(Value: Boolean);
    procedure SetAlwaysEdit(Value: Boolean);
    procedure SetAlwaysSelected(Value: Boolean);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetColumns(Value: TGridColumns);
    procedure SetCell(Col, Row: Integer; Value: string);
    procedure SetCellFocused(Value: TGridCell);
    procedure SetCellSelected(Value: Boolean);
    procedure SetEditing(Value: Boolean);
    procedure SetEndEllipsis(Value: Boolean);
    procedure SetFixed(Value: TGridFixed);
    procedure SetGridLines(Value: Boolean);
    procedure SetHeader(Value: TGridHeader);
    procedure SetHideSelection(Value: Boolean);
    procedure SetHorzScrollBar(Value: TGridScrollBar);
    procedure SetImages(Value: TImageList);
    procedure SetRows(Value: TGridRows);
    procedure SetRowSelect(Value: Boolean);
    procedure SetShowCellTips(Value: Boolean);
    procedure SetShowFocusRect(Value: Boolean);
    procedure SetShowHeader(Value: Boolean);
    procedure SetVertScrollBar(Value: TGridScrollBar);
    procedure SetVisOrigin(Value: TGridCell);
    procedure VertScroll(Sender: TObject; ScrollCode: Integer; var ScrollPos: Integer);
    procedure VertScrollChange(Sender: TObject);
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMChar(var Msg: TWMChar); message WM_CHAR;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMShowHintChanged(var Message: TMessage); message CM_SHOWHINTCHANGED;
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
  protected
    function AcquireFocus: Boolean;
    procedure CellClick(Cell: TGridCell; Shift: TShiftState; X, Y: Integer); virtual;
    procedure Change(var Cell: TGridCell; var Selected: Boolean); virtual;
    procedure ChangeColumns; virtual;
    procedure ChangeFixed; virtual;
    procedure ChangeRows; virtual;
    procedure ChangeScale(M, D: Integer); override;
    procedure Changing(var Cell: TGridCell; var Selected: Boolean); virtual;
    procedure ColumnResize(Column: Integer; var Width: Integer); virtual;
    procedure ColumnResizing(Column: Integer; var Width: Integer); virtual;
    function CreateColumn: TGridColumn; virtual;
    function CreateColumns: TGridColumns; virtual;
    function CreateEdit: TGridEdit; virtual;
    function CreateEditList: TGridListBox; virtual;
    function CreateFixed: TGridFixed; virtual;
    function CreateHeader: TGridHeader; virtual;
    function CreateHeaderSection: TGridHeaderSection; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    function CreateRows: TGridRows; virtual;
    function CreateScrollBar(Kind: TScrollBarKind): TGridScrollBar; virtual;
    procedure DoExit; override;
    procedure EditButtonPress(Cell: TGridCell); virtual;
    procedure EditSelectNext(Cell: TGridCell); virtual;
    function EditCanModify: Boolean; virtual;
    function EditCanAcceptKey(Key: Char): Boolean; virtual;
    function EditCanShow: Boolean; virtual;
    function GetCellBorder(Cell: TGridCell): Integer; virtual;
    procedure GetCellColors(Cell: TGridCell; Canvas: TCanvas); virtual;
    function GetCellImage(Cell: TGridCell): Integer; virtual;
    function GetCellText(Cell: TGridCell): string; virtual;
    function GetClientOrigin: TPoint; override;
    function GetClientRect: TRect; override;
    function GetCursorCell(Cell: TGridCell; Offset: TGridOffset): TGridCell; virtual;
    procedure GetEditList(Cell: TGridCell; Items: TStrings); virtual;
    procedure GetEditListBounds(Cell: TGridCell; var Rect: TRect); virtual;
    function GetEditRect(Cell: TGridCell): TRect; virtual;
    function GetEditStyle(Cell: TGridCell): TGridEditStyle; virtual;
    function GetEditText(Cell: TGridCell): string; virtual;
    procedure GetHeaderColors(Section: TGridHeaderSection; Canvas: TCanvas); virtual;
    function GetTipsRect(Cell: TGridCell; MaxWidth: Integer): TRect; virtual;
    function GetTipsWindow: TGridTipsWindowClass; virtual;
    procedure HideCursor; virtual;
    procedure HideEdit; virtual;
    procedure HideFocus; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure PaintCell(Cell: TGridCell; Rect: TRect); virtual;
    procedure PaintCells; virtual;
    procedure PaintCellText(Cell: TGridCell; Rect: TRect; Canvas: TCanvas); virtual;
    procedure PaintFixed; virtual;
    procedure PaintFreeField; virtual;
    procedure PaintFocus; virtual;
    procedure PaintGridLines; virtual;
    procedure PaintHeader(Section: TGridHeaderSection; Rect: TRect); virtual;
    procedure PaintHeaders(DrawFixed: Boolean); virtual;
    procedure PaintHeaderSections(Sections: TGridHeaderSections; AllowFixed: Boolean; Rect: TRect); virtual;
    procedure PaintResizeLine;
    procedure Resize; dynamic;
    procedure SetCursor(Cell: TGridCell; Selected, Visible: Boolean); virtual;
    procedure SetEditText(Cell: TGridCell; var Value: string); virtual;
    procedure ShowCursor; virtual;
    procedure ShowEdit; virtual;
    procedure ShowEditChar(C: Char); virtual;
    procedure ShowFocus; virtual;
    procedure StartColResize(Section: TGridHeaderSection; X, Y: Integer);
    procedure StepColResize(X, Y: Integer);
    procedure StopColResize(Abort: Boolean);
    procedure UpdateCursor; virtual;
    procedure UpdateColors; virtual;
    procedure UpdateEdit(Activate: Boolean); virtual;
    procedure UpdateFocus; virtual;
    procedure UpdateFonts; virtual;
    procedure UpdateHeader; virtual;
    procedure UpdateScrollBars; virtual;
    procedure UpdateScrollPos; virtual;
    procedure UpdateScrollRange;
    procedure UpdateSelection(var Cell: TGridCell; var Selected: Boolean); virtual;
    procedure UpdateEditText; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Invalidate; override;
    procedure InvalidateCell(Cell: TGridCell);
    procedure InvalidateColumn(Column: Integer);
    procedure InvalidateFixed;
    procedure InvalidateFocus; virtual;
    procedure InvalidateGrid;
    procedure InvalidateHeader;
    procedure InvalidateRect(Rect: TRect);
    procedure InvalidateRow(Row: Integer);
    function IsActiveControl: Boolean;
    function IsCellAcceptCursor(Cell: TGridCell): Boolean; virtual;
    function IsCellCorrect(Cell: TGridCell): Boolean; 
    function IsCellHasImage(Cell: TGridCell): Boolean; virtual;
    function IsCellFocused(Cell: TGridCell): Boolean;
    function IsCellVisible(Cell: TGridCell; PartialOK: Boolean): Boolean;
    function IsColumnVisible(Column: Integer): Boolean;
    function IsFocusAllowed: Boolean;
    function IsRowVisible(Row: Integer): Boolean;
    function GetCellAt(X, Y: Integer): TGridCell;
    function GetCellRect(Cell: TGridCell): TRect;
    function GetColumnAt(X, Y: Integer): Integer;
    function GetColumnMaxWidth(Column: Integer): Integer;
    function GetColumnRect(Column: Integer): TRect;
    function GetColumnsWidth(Index1, Index2: Integer): Integer;
    function GetFixedRect: TRect;
    function GetFixedWidth: Integer;
    function GetFocusRect: TRect; virtual;
    function GetGridHeight: Integer;
    function GetGridOrigin: TPoint;
    function GetGridRect: TRect;
    function GetHeaderHeight: Integer;
    function GetHeaderRect: TRect;
    function GetResizeSection(X, Y: Integer): TGridHeaderSection;
    function GetRowAt(X, Y: Integer): Integer;
    function GetRowRect(Row: Integer): TRect;
    function GetRowsHeight(Index1, Index2: Integer): Integer;
    procedure LockUpdate;
    procedure UnLockUpdate(Redraw: Boolean);
    property AllowEdit: Boolean read FAllowEdit write SetAllowEdit default False;
    property AlwaysEdit: Boolean read FAlwaysEdit write SetAlwaysEdit default False;
    property AlwaysSelected: Boolean read FAlwaysSelected write SetAlwaysSelected default False;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property Columns: TGridColumns read FColumns write SetColumns;
    property Cells[Col, Row: Integer]: string read GetCell write SetCell;
    property CellFocused: TGridCell read FCellFocused write SetCellFocused;
    property CellSelected: Boolean read FCellSelected write SetCellSelected;
    property Edit: TGridEdit read FEdit;
    property EditCell: TGridCell read FEditCell;
    property Editing: Boolean read FEditing write SetEditing;
    property EndEllipsis: Boolean read FEndEllipsis write SetEndEllipsis default True;
    property GridLines: Boolean read FGridLines write SetGridLines default True;
    property Fixed: TGridFixed read FFixed write SetFixed;
    property Header: TGridHeader read FHeader write SetHeader;
    property HideSelection: Boolean read FHideSelection write SetHideSelection default False;
    property HorzScrollBar: TGridScrollBar read FHorzScrollBar write SetHorzScrollBar;
    property Images: TImageList read FImages write SetImages;
    property RightClickSelect: Boolean read FRightClickSelect write FRightClickSelect default True;
    property Rows: TGridRows read FRows write SetRows;
    property RowSelect: Boolean read FRowSelect write SetRowSelect default False;
    property ShowCellTips: Boolean read FShowCellTips write SetShowCellTips;
    property ShowFocusRect: Boolean read FShowFocusRect write SetShowFocusRect default True;
    property ShowHeader: Boolean read FShowHeader write SetShowHeader default True;
    property TipsCell: TGridCell read FTipsCell;
    property VertScrollBar: TGridScrollBar read FVertScrollBar write SetVertScrollBar;
    property VisOrigin: TGridCell read FVisOrigin write SetVisOrigin;
    property VisSize: TGridCell read FVisSize;
    property OnCellAcceptCursor: TGridCellAcceptCursorEvent read FOnCellAcceptCursor write FOnCellAcceptCursor;
    property OnCellClick: TGridCellClickEvent read FOnCellClick write FOnCellClick;
    property OnChange: TGridChangedEvent read FOnChange write FOnChange;
    property OnChangeColumns: TNotifyEvent read FOnChangeColumns write FOnChangeColumns;
    property OnChangeFixed: TNotifyEvent read FOnChangeFixed write FOnChangeFixed;
    property OnChangeRows: TNotifyEvent read FOnChangeRows write FOnChangeRows;
    property OnChanging: TGridChangingEvent read FOnChanging write FOnChanging;
    property OnColumnResizing: TGridColumnResizeEvent read FOnColumnResizing write FOnColumnResizing;
    property OnColumnResize: TGridColumnResizeEvent read FOnColumnResize write FOnColumnResize;
    property OnDrawCell: TGridDrawCellEvent read FOnDrawCell write FOnDrawCell;
    property OnDrawHeader: TGridDrawHeaderEvent read FOnDrawHeader write FOnDrawHeader;
    property OnEditAcceptKey: TGridAcceptKeyEvent read FOnEditAcceptKey write FOnEditAcceptKey;
    property OnEditButtonPress: TGridCellNotifyEvent read FOnEditButtonPress write FOnEditButtonPress;
    property OnEditSelectNext: TGridCellNotifyEvent read FOnEditSelectNext write FOnEditSelectNext;
    property OnGetCellColors: TGridCellColorsEvent read FOnGetCellColors write FOnGetCellColors;
    property OnGetCellImage: TGridCellImageEvent read FOnGetCellImage write FOnGetCellImage;
    property OnGetCellText: TGridTextEvent read FOnGetCellText write FOnGetCellText;
    property OnGetEditStyle: TGridEditStyleEvent read FOnGetEditStyle write FOnGetEditStyle;
    property OnGetEditList: TGridEditListEvent read FOnGetEditList write FOnGetEditList;
    property OnGetEditListBounds: TGridEditListBoundsEvent read FOnGetEditListBounds write FOnGetEditListBounds;
    property OnGetEditText: TGridTextEvent read FOnGetEditText write FOnGetEditText;
    property OnGetHeaderColors: TGridHeaderColorsEvent read FOnGetHeaderColors write FOnGetHeaderColors;
    property OnSetEditText: TGridTextEvent read FOnSetEditText write FOnSetEditText;
    property OnResize: TNotifyEvent read FOnResize write FOnResize;
  end;

{ TGridView }

  TGridView = class(TCustomGridView)
  public
    property Canvas;
  published
    property Align;
    property AllowEdit;
    property AlwaysEdit;
    property AlwaysSelected;
    property BorderStyle;
    property Color;
    property Columns;
    property Ctl3D;
    property EndEllipsis;
    property Font;
    property Fixed;
    property GridLines;
    property Header;
    property HideSelection;
    property Hint;
    property HorzScrollBar;
    property Images;
    property ParentColor default False;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property RightClickSelect;
    property Rows;
    property RowSelect;
    property ShowCellTips;
    property ShowFocusRect;
    property ShowHeader;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property VertScrollBar;
    property Visible;
    property OnCellAcceptCursor;
    property OnCellClick;
    property OnChange;
    property OnChangeColumns;
    property OnChangeFixed;
    property OnChangeRows;
    property OnChanging;
    property OnClick;
    property OnColumnResizing;
    property OnColumnResize;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawCell;
    property OnDrawHeader;
    property OnEditAcceptKey;
    property OnEditButtonPress;
    property OnEditSelectNext;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetCellColors;
    property OnGetCellImage;
    property OnGetCellText;
    property OnGetEditList;
    property OnGetEditListBounds;
    property OnGetEditStyle;
    property OnGetEditText;
    property OnGetHeaderColors;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnSetEditText;
    property OnStartDrag;
    property OnResize;
  end;

function GridCell(Col, Row: Integer): TGridCell;
function IsCellEqual(Cell1, Cell2: TGridCell): Boolean;
function IsCellEmpty(Cell: TGridCell): Boolean;

implementation

uses
  Ex_Utils;

{ �������� }

function GridCell(Col, Row: Integer): TGridCell;
begin
  Result.Col := Col;
  Result.Row := Row;
end;

function IsCellEqual(Cell1, Cell2: TGridCell): Boolean;
begin
  Result := (Cell1.Col = Cell2.Col) and (Cell1.Row = Cell2.Row);
end;

function IsCellEmpty(Cell: TGridCell): Boolean;
begin
  Result := (Cell.Col = -1) or (Cell.Row = -1);
end;

{ TGridHeaderSection }

constructor TGridHeaderSection.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FWidth := 64;
end;

destructor TGridHeaderSection.Destroy;
begin
  FSections.Free;
  inherited Destroy;
end;

function TGridHeaderSection.GetBounds: TRect;

  function DoGetBounds(Sections: TGridHeaderSections; var Rect: TRect): Boolean;
  var
    I: Integer;
    S: TGridHeaderSection;
    R: TRect;
  begin
    R.Left := Rect.Left;
    R.Right := Rect.Left;
    for I := 0 to Sections.Count - 1 do
    begin
      S := Sections[I];
      R.Left := R.Right;
      R.Right := R.Left + S.Width;
      { ������ ������� - ����� }
      if S = Self then
      begin
        Rect := R;
        Result := True;
        Exit;
      end;
      { ��������� ��� ������ }
      if DoGetBounds(S.Sections, R) then
      begin
        Rect := R;
        Result := True;
        Exit;
      end;
    end;
    Result := False;
  end;

begin
  { ��� ��������� - ��� �������� }
  if (Header = nil) or (Header.Grid = nil) then
  begin
    Result := Rect(0, 0, 0, 0);
    Exit;
  end;
  { �������������� ������ - ����� ��������� }
  with Result do
  begin
    Left := Header.Grid.GetGridOrigin.X;
    Right := Left + Header.Width;
  end;
  { ���� ����� � ������ ���� }
  if not DoGetBounds(Header.Sections, Result) then
  begin
    Result := Rect(0, 0, 0, 0);
    Exit;
  end;
  { ������� � ������ ������� }
  with Result do
  begin
    Top := Level * Header.SectionHeight;
    if Sections.Count > 0 then
      Bottom := Result.Top + Header.SectionHeight
    else
      Bottom := Header.Height;
  end;
  { ������������� ��������� }
  if FixedSize then
    OffsetRect(Result, - Header.Grid.GetGridOrigin.X, 0);
end;

function TGridHeaderSection.GetColumn: Integer;
var
  C: Integer;

  function DoGetColumn(Sections: TGridHeaderSections): Boolean;
  var
    I: Integer;
    S: TGridHeaderSection;
  begin
    for I := 0 to Sections.Count - 1 do
    begin
      S := Sections[I];
      { ���� �� ������������ }
      if S.Sections.Count = 0 then
      begin
        { ��� ������� - ������� }
        if S = Self then
        begin
          Result := True;
          Exit;
        end;
        Inc(C);
      end;
      { �������� �� ��� ������������ ����� }
      if DoGetColumn(S.Sections) then
      begin
        Result := True;
        Exit;
      end;
    end;
    Result := False;
  end;

begin
  { ���� ���� ������������ ���������� ������� ���������� �� ��� }
  if Sections.Count > 0 then
  begin
    Result := Sections[Sections.Count - 1].Column;
    Exit;
  end;
  { ����� ������� ������� }
  if Header <> nil then
  begin
    C := 0;
    if DoGetColumn(Header.Sections) then
    begin
      Result := C;
      Exit;
    end;
  end;
  Result := 0;
end;

function TGridHeaderSection.GetFixedSize: Boolean;
begin
  if Sections.Count > 0 then
  begin
    Result := Sections[0].FixedSize;
    Exit;
  end;
  if (Header = nil) or (Header.Grid = nil) then
  begin
    Result := False;
    Exit;
  end;
  Result := Column < Header.Grid.Fixed.Count;
end;

function TGridHeaderSection.GetHeader: TGridHeader;
begin
  if ParentSections <> nil then
  begin
    Result := ParentSections.Header;
    Exit;
  end;
  Result := nil;
end;

function TGridHeaderSection.GetLevel: Integer;
begin
  if Parent <> nil then
  begin
    Result := Parent.Level + 1;
    Exit;
  end;
  Result := 0
end;

function TGridHeaderSection.GetParent: TGridHeaderSection;
begin
  if ParentSections <> nil then
  begin
    Result := ParentSections.Owner;
    Exit;
  end;
  Result := nil;
end;

function TGridHeaderSection.GetParentSections: TGridHeaderSections;
begin
  if Collection <> nil then
  begin
    Result := TGridHeaderSections(Collection);
    Exit;
  end;
  Result := nil;
end;

function TGridHeaderSection.GetSections: TGridHeaderSections;
begin
  if FSections = nil then FSections := TGridHeaderSections.Create(Header, Self);
  Result := FSections;
end;

function TGridHeaderSection.GetWidth: Integer;
var
  I: Integer;
  S: TGridHeaderSection;
begin
  { ���� ���� ������������, �� ������ ���� ����� ����� ������������� }
  if Sections.Count > 0 then
  begin
    Result := 0;
    for I := 0 to Sections.Count - 1 do
    begin
      S := Sections[I];
      Result := Result + S.Width;
    end;
    Exit;
  end;
  { ����� ���������� ������ ��������������� ������� }
  if (Header <> nil) and (Header.Grid <> nil) then
  begin
    I := GetColumn;
    if I < Header.Grid.Columns.Count then
    begin
      Result := Header.Grid.Columns[I].Width;
      Exit;
    end;
  end;
  { ��� ������� - ���� ������ }
  Result := FWidth;
end;

procedure TGridHeaderSection.SetAlignment(Value: TAlignment);
begin
  if Alignment <> Value then
  begin
    FAlignment := Value;
    Changed(False);
  end;
end;

procedure TGridHeaderSection.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Changed(False);
  end;
end;

procedure TGridHeaderSection.SetSections(Value: TGridHeaderSections);
begin
  Sections.Assign(Value);
end;

procedure TGridHeaderSection.SetWidth(Value: Integer);
begin
  if (Value >= 0) and (Width <> Value) then
  begin
    if (Header <> nil) and (Header.Grid <> nil) then
      if Column > Header.Grid.Columns.Count - 1 then
        if Sections.Count > 0 then
        begin
          with Sections[Sections.Count - 1] do
            SetWidth(Width + (Value - Self.Width));
          Exit;
        end;
    FWidth := Value;
    Changed(False);
  end;
end;

procedure TGridHeaderSection.SetWordWrap(Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    Changed(False);
  end;
end;

procedure TGridHeaderSection.Assign(Source: TPersistent);
begin
  if Source is TGridHeaderSection then
  begin
    Sections := TGridHeaderSection(Source).Sections;
    Caption := TGridHeaderSection(Source).Caption;
    Width := TGridHeaderSection(Source).Width;
    Alignment := TGridHeaderSection(Source).Alignment;
    WordWrap := TGridHeaderSection(Source).WordWrap;
    Exit;
  end;
  inherited Assign(Source);
end;

{ TGridHeaderSections }

constructor TGridHeaderSections.Create(AHeader: TGridHeader; AOwner: TGridHeaderSection);
begin
  inherited Create(TGridHeaderSection);
  FHeader := AHeader;
  FOwner := AOwner;
end;

function TGridHeaderSections.GetMaxColumn: Integer;
begin
  if Count > 0 then
  begin
    Result := Sections[Count - 1].Column;
    Exit;
  end;
  Result := 0;
end;

function TGridHeaderSections.GetMaxLevel: Integer;

  procedure DoGetMaxLevel(Sections: TGridHeaderSections);
  var
    I: Integer;
    S: TGridHeaderSection;
  begin
    for I := 0 to Sections.Count - 1 do
    begin
      S := Sections[I];
      if Result < S.Level then Result := S.Level;
      DoGetMaxLevel(S.Sections);
    end;
  end;

begin
  Result := 0;
  DoGetMaxLevel(Self);
end;

function TGridHeaderSections.GetSection(Index: Integer): TGridHeaderSection;
begin
  Result := TGridHeaderSection(inherited GetItem(Index));
end;

procedure TGridHeaderSections.SetSection(Index: Integer; Value: TGridHeaderSection);
begin
  inherited SetItem(Index, Value);
end;

function TGridHeaderSections.GetOwner: TPersistent;
begin
  Result := Header;
end;

procedure TGridHeaderSections.Update(Item: TCollectionItem);
begin
  if Header <> nil then Header.Change;
end;

function TGridHeaderSections.Add: TGridHeaderSection;
begin
  if (Header = nil) or (Header.Grid = nil) then
  begin
    Result := TGridHeaderSection(inherited Add);
    Exit;
  end;
  Result := Header.Grid.CreateHeaderSection;
end;

procedure TGridHeaderSections.Synchronize(Columns: TGridColumns);
var
  I, C: Integer;

  procedure DoDeleteSections(Sections: TGridHeaderSections);
  var
    I: Integer;
    S: TGridHeaderSection;
  begin
    for I := Sections.Count - 1 downto 0 do
    begin
      S := Sections[I];
      DoDeleteSections(S.Sections);
      if (S.Sections.Count = 0) and (S.Column > Columns.Count - 1) then S.Free;
    end;
  end;

  procedure DoSynchronizeSections(Sections: TGridHeaderSections);
  var
    I: Integer;
    S: TGridHeaderSection;
  begin
    for I := Sections.Count - 1 downto 0 do
    begin
      S := Sections[I];
      if S.Sections.Count = 0 then
      begin
        C := S.Column;
        S.Width := Columns[C].Width;              
        if Header.FullSynchronizing then
        begin
          S.Caption := Columns[C].Caption;
          S.Alignment := Columns[C].Alignment;
        end;
      end
      else
        DoSynchronizeSections(S.Sections);
    end;
  end;

begin
  if (Header <> nil) and (Header.Grid.ComponentState * [csReading, csLoading] = []) then
  begin
    BeginUpdate;
    try
      { ��������� ���� - ��������� ��� ������� }
      if Count = 0 then
      begin
        for I := 0 to Columns.Count - 1 do
          with Add do
          begin
            Caption := Columns[I].Caption;
            Width := Columns[I].Width;
            Alignment := Columns[I].Alignment;
          end;
        Exit;
      end;
      { ���� ������ ������ - ���������, ����� ������� ������ }
      C := Sections[Count - 1].Column;
      if C < Columns.Count - 1 then
      begin
        I := C;
        repeat
          Inc(I);
          Add;
        until I >= Columns.Count - 1;
      end
      else
        if C > Columns.Count - 1 then DoDeleteSections(Self);
      { � ������ ������ �������������� ���������, ������������ � ������� }
      DoSynchronizeSections(Self);
    finally
      EndUpdate;
    end;
  end;
end;

{ TGridHeader }

constructor TGridHeader.Create(AGrid: TCustomGridView);
begin
  inherited Create;
  FGrid := AGrid;
  FColor := clBtnFace;
  FSections := TGridHeaderSections.Create(Self, nil);
  FSectionHeight := 17;
  FSynchronized := True;
  FAutoSynchronize := True;
  FColor := clBtnFace;
  FFont := TFont.Create;
  FFont.OnChange := FontChange;
  FGridFont := True;
end;

destructor TGridHeader.Destroy;
begin
  FOnChange := nil;
  FSections.Free;
  FFont.Free;
  inherited Destroy;
end;

procedure TGridHeader.FontChange(Sender: TObject);
begin
  FGridFont := False;
  Change;
end;

function TGridHeader.GetHeight: Integer;
begin
  Result := (GetMaxLevel + 1) * SectionHeight - 1;
end;

function TGridHeader.GetMaxColumn: Integer;
begin
  Result := Sections.MaxColumn;
end;

function TGridHeader.GetMaxLevel: Integer;
begin
  Result := Sections.MaxLevel;
end;

function TGridHeader.GetWidth: Integer;
var
  I: Integer;
  S: TGridHeaderSection;
begin
  Result := 0;
  for I := 0 to Sections.Count - 1 do
  begin
    S := Sections[I];
    Result := Result + S.Width;
  end;
end;

procedure TGridHeader.GridColorChanged(NewColor: TColor);
begin
  if FGridColor then
  begin
    SetColor(NewColor);
    FGridColor := True;
  end;
end;

procedure TGridHeader.GridFontChanged(NewFont: Tfont);
begin
  if FGridFont then
  begin
    SetFont(NewFont);
    FGridFont := True;
  end;
end;

procedure TGridHeader.SetAutoSynchronize(Value: Boolean);
begin
  if FAutoSynchronize <> Value then
  begin
    FAutoSynchronize := Value;
    if Value then Synchronized := True;
  end;
end;

procedure TGridHeader.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    FGridColor := False;
    Change;
  end;
end;

procedure TGridHeader.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TGridHeader.SetGridColor(Value: Boolean);
begin
  if FGridColor <> Value then
  begin
    FGridColor := Value;
    if Grid <> nil then GridColorChanged(Grid.Color);
  end;
end;

procedure TGridHeader.SetGridFont(Value: Boolean);
begin
  if FGridFont <> Value then
  begin
    FGridFont := Value;
    if Grid <> nil then GridFontChanged(Grid.Font);
  end;
end;

procedure TGridHeader.SetSections(Value: TGridHeaderSections);
begin
  { ������������� ��������� }
  FSections.Assign(Value);
  { ���������� ���� ������������� }
  SetSynchronized(False);
end;

procedure TGridHeader.SetSectionHeight(Value: Integer);
begin
  if FSectionHeight <> Value then
  begin
    FSectionHeight := Value;
    Change;
  end;
end;

procedure TGridHeader.SetSynchronized(Value: Boolean);
begin
  if FSynchronized <> Value then
  begin
    FSynchronized := Value;
    if (Value or FAutoSynchronize) and (Grid <> nil) then
    begin
      FSynchronized := True;
      Sections.Synchronize(Grid.Columns);
    end;
  end;
end;

procedure TGridHeader.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TGridHeader.Assign(Source: TPersistent);
begin
  if Source is TGridHeader then
  begin
    Sections := TGridHeader(Source).Sections;
    SectionHeight := TGridHeader(Source).SectionHeight;
    Synchronized := TGridHeader(Source).Synchronized;
    AutoSynchronize := TGridHeader(Source).AutoSynchronize;
    Color := TGridHeader(Source).Color;
    GridColor := TGridHeader(Source).GridColor;
    Font := TGridHeader(Source).Font;
    GridFont := TGridHeader(Source).GridFont;                       
    Exit;
  end;
  inherited Assign(Source);
end;

{ TGridColumn }

constructor TGridColumn.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FColumns := TGridColumns(Collection);
  FWidth := 64;
  FDefWidth := 64;
  FAlignment := taLeftJustify;
  FVisible := True;
end;

function TGridColumn.GetWidth: Integer;
begin
  { � ����� �� ������� }
  if not FVisible then
  begin
    Result := 0;
    Exit;
  end;
  { ���������� ������ }
  Result := FWidth;
end;

procedure TGridColumn.SetAlignment(Value: TAlignment);
begin
  if Alignment <> Value then
  begin
    FAlignment := Value;
    Changed(False);
  end;
end;

procedure TGridColumn.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Changed(False);
  end;
end;

procedure TGridColumn.SetMaxLength(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FMaxLength <> Value then
  begin
    FMaxLength := Value;
    Changed(False);
  end;
end;

procedure TGridColumn.SetMultiLine(Value: Boolean);
begin
  if FMultiLine <> Value then
  begin
    FMultiLine := Value;
    Changed(False);
  end;
end;

procedure TGridColumn.SetReadOnly(Value: Boolean);
begin
  if FReadOnly <> Value then
  begin
    FReadOnly := Value;
    Changed(False);
  end;
end;

procedure TGridColumn.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed(True);
  end;
end;

procedure TGridColumn.SetWidth(Value: Integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    FDefWidth := Value;
    Changed(True);
  end;
end;

procedure TGridColumn.Assign(Source: TPersistent);
begin
  if Source is TGridColumn then
  begin
    Caption := TGridColumn(Source).Caption;
    DefWidth := TGridColumn(Source).DefWidth;
    FixedSize := TGridColumn(Source).FixedSize;
    MaxLength := TGridColumn(Source).MaxLength;
    Alignment := TGridColumn(Source).Alignment;
    ReadOnly := TGridColumn(Source).ReadOnly;
    MultiLine := TGridColumn(Source).MultiLine;
    Visible := TGridColumn(Source).Visible;
    Exit;
  end;
  inherited Assign(Source);
end;

{ TGridColumns }

constructor TGridColumns.Create(AGrid: TCustomGridView);
begin
  inherited Create(TGridColumn);
  FGrid := AGrid;
end;

function TGridColumns.GetColumn(Index: Integer): TGridColumn;
begin
  Result := TGridColumn(inherited GetItem(Index));
end;

procedure TGridColumns.SetColumn(Index: Integer; Value: TGridColumn);
begin
  inherited SetItem(Index, Value);
end;

function TGridColumns.GetOwner: TPersistent;
begin
  Result := FGrid; 
end;

procedure TGridColumns.Update(Item: TCollectionItem);
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

function TGridColumns.Add: TGridColumn;
begin
  if Grid = nil then
  begin
    Result := TGridColumn(inherited Add);
    Exit;
  end;
  Result := Grid.CreateColumn;
end;

{ TGridRows }

constructor TGridRows.Create(AGrid: TCustomGridView);
begin
  inherited Create;
  FGrid := AGrid;
  FHeight := 17;
end;

destructor TGridRows.Destroy;
begin
  FOnChange := nil;
  SetCount(0);
  inherited Destroy;
end;

function TGridRows.GetMaxCount: Integer;
begin
  Result := (MaxInt - 2) div Height - 2;
end;

procedure TGridRows.SetHeight(Value: Integer);
begin
  if Assigned(Grid.Images) then
    with Grid.Images do
      if Value < Height + 1 then Value := Height + 1;
  if FHeight <> Value then
  begin
    FHeight := Value;
    if Count > MaxCount then SetCount(Count) else Change;
  end;
end;

procedure TGridRows.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TGridRows.SetCount(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if Value > MaxCount then Value := MaxCount;
  if FCount <> Value then
  begin
    FCount := Value;
    Change;
  end;
end;

procedure TGridRows.Assign(Source: TPersistent);
begin
  if Source is TGridRows then
  begin
    Count := TGridRows(Source).Count;
    Height := TGridRows(Source).Height;
    Exit;
  end;
  inherited Assign(Source);
end;

{ TGridFixed }

constructor TGridFixed.Create(AGrid: TCustomGridView);
begin
  inherited Create;
  FGrid := AGrid;
  FColor := clBtnFace;
  FFont := TFont.Create;
  FFont.OnChange := FontChange;
  FGridFont := True;
end;

destructor TGridFixed.Destroy;
begin
  FOnChange := nil;
  FFont.Free;
  inherited Destroy;
end;

procedure TGridFixed.FontChange(Sender: TObject);
begin
  FGridFont := False;
  Change;
end;

procedure TGridFixed.GridColorChanged(NewColor: TColor);
begin
  if FGridColor then
  begin
    SetColor(NewColor);
    FGridColor := True;
  end;
end;

procedure TGridFixed.GridFontChanged(NewFont: TFont);
begin
  if FGridFont then
  begin
    SetFont(NewFont);
    FGridFont := True;
  end;
end;

procedure TGridFixed.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    FGridColor := False;
    Change;
  end;
end;

procedure TGridFixed.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TGridFixed.SetGridColor(Value: Boolean);
begin
  if FGridColor <> Value then
  begin
    FGridColor := Value;
    if Grid <> nil then GridColorChanged(Grid.Color);
  end;
end;

procedure TGridFixed.SetGridFont(Value: Boolean);
begin
  if FGridFont <> Value then
  begin
    FGridFont := Value;
    if Grid <> nil then GridFontChanged(Grid.Font);
  end;
end;

procedure TGridFixed.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TGridFixed.SetCount(Value: Integer);
begin
  { ����������� �������� }
  if Value < 0 then Value := 0;
  if (Grid <> nil) and (Value > Grid.Columns.Count - 1) then Value := Grid.Columns.Count - 1;
  { ������������� }
  if FCount <> Value then
  begin
    FCount := Value;
    Change;
  end;
end;

procedure TGridFixed.Assign(Source: TPersistent);
begin
  if Source is TGridFixed then
  begin
    Count := TGridFixed(Source).Count;
    Color := TGridFixed(Source).Color;
    GridColor := TGridFixed(Source).GridColor;
    Font := TGridFixed(Source).Font;
    GridFont := TGridFixed(Source).GridFont;
    Exit;
  end;
  inherited Assign(Source);
end;

{ TGridScrollBar }

const
  MaxScroll = 30000;

constructor TGridScrollBar.Create(AGrid: TCustomGridView; AKind: TScrollBarKind);
begin
  inherited Create;
  FGrid := AGrid;
  FKind := AKind;
  FPosition := 0;
  FRange := 0;
  FPageStep := 100;
  FLineStep := 8;
  FLineSize := 1;
  FTracking := True;
  FVisible := True;
end;

function TGridScrollBar.GetScrollPos(WinPos: Integer): Integer;
begin
  Result := MulDiv(WinPos, Range, MaxScroll);
end;

function TGridScrollBar.GetWinPos(ScrollPos: Integer): Integer;
begin
  if Range <> 0 then
  begin
    Result := MulDiv(ScrollPos, MaxScroll, Range);
    Exit;
  end;
  Result := 0;
end;

procedure TGridScrollBar.SetLineSize(Value: Integer);
begin
  if Value < 1 then FLineSize := 1 else FLineSize := Value;
end;

procedure TGridScrollBar.SetLineStep(Value: Integer);
begin
  SetParams(Range, PageStep, Value);
end;

procedure TGridScrollBar.SetPageStep(Value: Integer);
begin
  SetParams(Range, Value, LineStep);
end;

procedure TGridScrollBar.SetRange(Value: Integer);
begin
  SetParams(Value, PageStep, LineStep);
end;

procedure TGridScrollBar.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Update;
  end;
end;

procedure TGridScrollBar.Update;
const
  Code: array[Boolean] of Integer = (SB_VERT, SB_HORZ);
var
  ScrollInfo: TScrollInfo;
begin
  if FGrid.HandleAllocated then
  begin
    ScrollInfo.cbSize := SizeOf(ScrollInfo);
    ScrollInfo.fMask := SIF_ALL;
    ScrollInfo.nMin := 0;
    if Visible and (Range > PageStep) then
      ScrollInfo.nMax := MaxScroll
    else
      ScrollInfo.nMax := 0;
    ScrollInfo.nPage := GetWinPos(PageStep);
    ScrollInfo.nPos := GetWinPos(Position);
    ScrollInfo.nTrackPos := GetWinPos(Position);
    SetScrollInfo(FGrid.Handle, Code[Kind = sbHorizontal], ScrollInfo, FUpdateCount = 0);
  end;
end;

procedure TGridScrollBar.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TGridScrollBar.Scroll(ScrollCode: Integer; var ScrollPos: Integer);
begin
  if Assigned(FOnScroll) then FOnScroll(Self, ScrollCode, ScrollPos);
end;

procedure TGridScrollBar.ScrollMessage(var Message: TWMScroll);
begin
  with Message do
  begin
    Inc(FUpdateCount);
    try
      case ScrollCode of
        SB_LINELEFT: SetPositionEx(Position - LineStep, ScrollCode);
        SB_LINERIGHT: SetPositionEx(Position + LineStep, ScrollCode);
        SB_PAGELEFT: SetPositionEx(Position - PageStep, ScrollCode);
        SB_PAGERIGHT: SetPositionEx(Position + PageStep, ScrollCode);
        SB_THUMBPOSITION: SetPositionEx(GetScrollPos(Pos), ScrollCode);
        SB_THUMBTRACK: if Tracking then SetPositionEx(GetScrollPos(Pos), ScrollCode);
        SB_ENDSCROLL: SetPositionEx(Position, ScrollCode);
      end;
    finally
      Dec(FUpdateCount);
      Update;
    end;
  end;
end;

procedure TGridScrollBar.SetParams(ARange, APageStep, ALineStep: Integer);
begin
  { ����������� ����� �������� }
  if APageStep < 0 then APageStep := 0;
  if ALineStep < 0 then ALineStep := 0;
  if ARange < 0 then ARange := 0;
  { ���������� �� ��� ������ }
  if (FRange <> ARange) or (FPageStep <> APageStep) or (FLineStep <> ALineStep) then
  begin
    { ������������� ����� �������� }
    FRange := ARange;
    FPageStep := APageStep;
    FLineStep := ALineStep;
    { ����������� ������� }
    if FPosition > FRange - FPageStep then FPosition := FRange - FPageStep;
    if FPosition < 0 then FPosition := 0;
    { ��������� �������� }
    Update;
  end;
end;

procedure TGridScrollBar.SetPosition(Value: Integer);
begin
  SetPositionEx(Value, SB_ENDSCROLL);
end;

procedure TGridScrollBar.SetPositionEx(Value: Integer; ScrollCode: Integer);
var
  R: TRect;

  procedure UpdatePosition;
  begin
    if Value > Range - PageStep then Value := Range - PageStep;
    if Value < 0 then Value := 0;
  end;

begin
  { ��������� ������� }
  UpdatePosition;
  { ���������� �� ������� }
  if Value <> FPosition then
  begin
    { ������� �������� }
    Scroll(ScrollCode, Value);
    { ����� ��������� }
    UpdatePosition;
  end;
  { ���������� �� ������� ����� ������� ������������ }
  if Value <> FPosition then
  begin
    { �������� ����� }
    with FGrid do
    begin
      { ����� ����� }
      HideFocus;
      { �������� }
      if FKind = sbHorizontal then
      begin
        R := GetClientRect;
        R.Left := R.Left + GetFixedWidth;
        ScrollWindow(Handle, (FPosition - Value) * FLineSize, 0, @R, @R);
      end
      else
      begin
        R := GetGridRect;
        ScrollWindow(Handle, 0, (FPosition - Value) * FLineSize, @R, @R);
      end;
      { ������������� ����� ������� }
      FPosition := Value;
      { ���������� ����� }
      ShowFocus;
    end;
    { ������������� �������� }
    Update;
    { ��������� }
    Change;
  end;
end;

procedure TGridScrollBar.Assign(Source: TPersistent);
begin
  if Source is TGridScrollBar then
  begin
    Inc(FUpdateCount);
    try
      PageStep := TGridScrollBar(Source).PageStep;
      LineStep := TGridScrollBar(Source).LineStep;
      Range := TGridScrollBar(Source).Range;
      Position := TGridScrollBar(Source).Position;
      Tracking := TGridScrollBar(Source).Tracking;
      Visible := TGridScrollBar(Source).Visible;
      Exit;
    finally
      Dec(FUpdateCount);
    end;
  end;
  inherited Assign(Source);
end;

{ TGridListBox }

constructor TGridListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ParentShowHint := False;
  ShowHint := False;
end;

procedure TGridListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_BORDER;
    ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

procedure TGridListBox.CreateWnd;
begin
  inherited CreateWnd;
  Windows.SetParent(Handle, 0);
  CallWindowProc(DefWndProc, Handle, WM_SETFOCUS, 0, 0);
end;

procedure TGridListBox.Keypress(var Key: Char);
var
  TickCount: Integer;
begin
  case Key of
    #8, #27:
      { ���������� ����� ������ }
      FSearchText := '';
    #32..#255:
      { ���������� ����� }
      begin
        TickCount := GetTickCount;
        if TickCount - FSearchTime > 2000 then FSearchText := '';
        FSearchTime := TickCount;
        if Length(FSearchText) < 32 then FSearchText := FSearchText + Key;
        SendMessage(Handle, LB_SELECTSTRING, WORD(-1), Longint(PChar(FSearchText)));
        Key := #0;
      end;
  end;
  inherited Keypress(Key);
end;

procedure TGridListBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if Grid <> nil then Grid.Edit.CloseUp((X >= 0) and (Y >= 0) and (X < Width) and (Y < Height));
end;

{ TGridEdit }

constructor TGridEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  { ���������� ���������� }
  FEditStyle := geSimple;
  FDropDownCount := 8;
  FButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  { ��������� �������� ���� }
  ParentCtl3D := False;
  Ctl3D := False;
  TabStop := False;
  BorderStyle := bsNone;
  ParentShowHint := False;
  ShowHint := False;
end;

function TGridEdit.GetButtonRect: TRect;
begin
  Result := Rect(Width - FButtonWidth, 0, Width, Height);
end;

function TGridEdit.GetLineCount: Integer;
begin
  Result := Ex_Utils.GetLineCount(Text); 
end;

function TGridEdit.GetVisible: Boolean;
begin
  Result := IsWindowVisible(Handle);
end;

procedure TGridEdit.ListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then CloseUp(PtInRect(FDropList.ClientRect, Point(X, Y)));
end;

procedure TGridEdit.SetButtonWidth(Value: Integer);
begin
  if FButtonWidth <> Value then
  begin
    FButtonWidth := Value;
    Repaint;
  end;
end;

procedure TGridEdit.SetEditStyle(Value: TGridEditStyle);
begin
  if FEditStyle <> Value then
  begin
    FEditStyle := Value;
    Repaint;
  end;
end;

procedure TGridEdit.StartButtonTracking(X, Y: Integer);
begin
  MouseCapture := True;
  FButtonTracking := True;
  StepButtonTracking(X, Y);
end;

procedure TGridEdit.StepButtonTracking(X, Y: Integer);
var
  R: TRect;
  P: Boolean;
begin
  R := GetButtonRect;
  P := PtInRect(R, Point(X, Y));
  if FButtonPressed <> P then
  begin
    FButtonPressed := P;
    InvalidateRect(Handle, @R, False);
  end;
end;

procedure TGridEdit.StopButtonTracking;
begin
  if FButtonTracking then
  begin
    StepButtonTracking(-1, -1);
    FButtonTracking := False;
    MouseCapture := False;
  end;
end;

procedure TGridEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS + DLGC_WANTCHARS;
end;

procedure TGridEdit.WMCancelMode(var Message: TMessage);
begin
  StopButtonTracking;
  inherited;
end;

procedure TGridEdit.WMKillFocus(var Message: TMessage);
begin
  inherited;
  CloseUp(False);
end;

procedure TGridEdit.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  Invalidate;
end;

procedure TGridEdit.WMPaint(var Message: TWMPaint);
begin
  PaintHandler(Message);
end;

procedure TGridEdit.WMLButtonDblClk(var Message: TWMLButtonDblClk);
var
  P: TPoint;
begin
  with Message do
  begin
    P := Point(XPos, YPos);
    if (FEditStyle <> geSimple) and PtInRect(GetButtonRect, P) then Exit;
  end;
  inherited;
end;

procedure TGridEdit.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
begin
  GetCursorPos(P);
  { �� ������ �� ����� �� ������ }
  if (FEditStyle <> geSimple) and PtInRect(GetButtonRect, ScreenToClient(P)) then
  begin
    Windows.SetCursor(LoadCursor(0, IDC_ARROW));
    Exit;
  end;
  { ��������� �� ��������� }
  inherited;
end;

procedure TGridEdit.WMPaste(var Message);
begin
  if (Grid = nil) or Grid.EditCanModify then inherited;
end;

procedure TGridEdit.WMClear(var Message);
begin
  if (Grid = nil) or Grid.EditCanModify then inherited;
end;

procedure TGridEdit.WMCut(var Message);
begin
  if (Grid = nil) or Grid.EditCanModify then inherited;
end;

procedure TGridEdit.CMCancelMode(var Message: TCMCancelMode);
begin
  if (Message.Sender <> Self) and (Message.Sender <> FDropList) then CloseUp(False);
end;

procedure TGridEdit.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TGridEdit.CMShowingChanged(var Message: TMessage);
begin
  { ���������� ��������� ��������� ����� ��������� �������� Visible }
end;

procedure TGridEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE;
end;

procedure TGridEdit.DblClick;
begin
  if Grid <> nil then Grid.DblClick;
end;

procedure TGridEdit.KeyDown(var Key: Word; Shift: TShiftState);

  procedure SendToParent;
  begin
    if Grid <> nil then
    begin
      Grid.KeyDown(Key, Shift);
      Key := 0;
    end;
  end;

  procedure ParentEvent;
  var
    GridKeyDown: TKeyEvent;
  begin
    if Grid <> nil then
    begin
      GridKeyDown := Grid.OnKeyDown;
      if Assigned(GridKeyDown) then GridKeyDown(Grid, Key, Shift);
    end;
  end;

begin
  { ������������ ������� }
  case Key of
    VK_UP,
    VK_DOWN:
      { ����������� ������ }
      if (Shift = [ssCtrl]) or ((Shift = []) and (not MultiLine)) then SendToParent;
    VK_PRIOR,
    VK_NEXT:
      { ����������� ������ }
      if Shift = [ssCtrl] then SendToParent;
    VK_ESCAPE:
      { ������ }
      SendToParent;
    VK_INSERT:
      { ������� }
      if (Shift = [ssCtrl]) or ReadOnly then SendToParent;
    VK_LEFT,
    VK_RIGHT,
    VK_HOME,
    VK_END:
      { ����������� ������ ��� ������� Ctrl }
      if Shift = [ssCtrl] then SendToParent;
  end;
  { ������ �� ���������� - ������� }
  if Key <> 0 then
  begin
    ParentEvent;
    inherited KeyDown(Key, Shift);
  end;
end;

procedure TGridEdit.KeyPress(var Key: Char);
begin
  if Grid <> nil then
  begin
    { �������� ������� ������� }
    Grid.KeyPress(Key);
    { ��������� ����������� ������� }
    if (Key in [#32..#255]) and not Grid.EditCanAcceptKey(Key) then
    begin
      Key := #0;
      MessageBeep(0);
    end;
    { ��������� ������ }
    case Key of
      #9, #27:
        { TAB, ESC ������� }
        Key := #0;
      ^H, ^V, ^X, #32..#255:
        { BACKSPACE, ������� ������� �������, ���� ������ ������������� }
        if not Grid.EditCanModify then Key := #0;
    end;
  end;
  { ��������� �� ������ }
  if Key <> #0 then inherited KeyPress(Key);
end;

procedure TGridEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if Grid <> nil then Grid.KeyUp(Key, Shift);
end;

procedure TGridEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  { ��������� ������� �� ������ }
  if (Button = mbLeft) and (EditStyle <> geSimple) and PtInrect(ButtonRect, Point(X, Y)) then
  begin
    { ����� �� ������ }
    if FDropListVisible then
      { ��������� ��� }
      CloseUp(False)
    else
    begin
      { �������� ������� �� ������ �, ���� �����, ��������� ������ }
      StartButtonTracking(X, Y);
      if EditStyle <> geEllipsis then DropDown;
    end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TGridEdit.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
  M: TSmallPoint;
begin
  if FButtonTracking then
  begin
    { ������� �� ������ }
    StepButtonTracking(X, Y);
    { ��� ��������� ������ }
    if FDropListVisible then
    begin
      { �������� ����� �� ������ }
      P := FDropList.ScreenToClient(ClientToScreen(Point(X, Y)));
      { ���� ������ �� ������ }
      if PtInRect(FDropList.ClientRect, P) then
      begin
        { ���������� ������� �� ������ }
        StopButtonTracking;
        { ��������� ������� �� ������ }
        M := PointToSmallPoint(P);
        SendMessage(FDropList.Handle, WM_LBUTTONDOWN, 0, Integer(M));
        Exit;
      end;
    end;
  end;
  { ��������� �� ��������� }
  inherited MouseMove(Shift, X, Y);
end;

procedure TGridEdit.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  P: Boolean;
begin
  P := FButtonPressed;
  { ��������� ������� }
  StopButtonTracking;
  { ������� �� ������ }
  if (Button = mbLeft) and (EditStyle = geEllipsis) and P then Press;
  { ��������� �� ��������� }
  inherited MouseUp(Button, Shift, X, Y);
end;

function ControlRectToClientRect(Source, Dest: TControl; Rect: TRect): TRect;
begin
  { � ���������� ������ }
  Result.TopLeft := Source.ClientToScreen(Rect.TopLeft);
  Result.BottomRight := Source.ClientToScreen(Rect.BottomRight);
  { � ���������� ���������� ������� }
  Result.TopLeft := Dest.ScreenToClient(Result.TopLeft);
  Result.BottomRight := Dest.ScreenToClient(Result.BottomRight);
end;

procedure TGridEdit.PaintButton(DC: HDC);
var
  R: TRect;
  Flags: Integer;
begin
  { ������ ������ }
  if EditStyle <> geSimple then               
  begin
    { �������� ������������� ������ }
    R := GetButtonRect;
    { ������ ������ }
    if EditStyle = geEllipsis then
    begin
      { ������ � ���������� }
      Flags := 0;
      if FButtonPressed then Flags := BF_FLAT;
      DrawEdge(DC, R, EDGE_RAISED, BF_RECT or BF_MIDDLE or Flags);
      Flags := ((R.Right - R.Left) shr 1) - 1 + Ord(FButtonPressed);
      PatBlt(DC, R.Left + Flags, R.Top + Flags, 2, 2, BLACKNESS);
      PatBlt(DC, R.Left + Flags - 3, R.Top + Flags, 2, 2, BLACKNESS);
      PatBlt(DC, R.Left + Flags + 3, R.Top + Flags, 2, 2, BLACKNESS);
    end
    else
    begin
      { ������ ������ }
      Flags := 0;
      if FButtonPressed then Flags := DFCS_FLAT or DFCS_PUSHED;
      DrawFrameControl(DC, R, DFC_SCROLL, Flags or DFCS_SCROLLCOMBOBOX);
(*
      if FButtonPressed then Flags := DFCS_FLAT;
      DrawEdge(DC, R, EDGE_RAISED, BF_RECT or BF_MIDDLE or Flags);
      Flags := ((R.Right - R.Left) shr 1) - 1 + Ord(FButtonPressed);
      PatBlt(DC, R.Left + Flags - 2, R.Top + Flags + 0, 7, 1, BLACKNESS);
      PatBlt(DC, R.Left + Flags - 1, R.Top + Flags + 1, 5, 1, BLACKNESS);
      PatBlt(DC, R.Left + Flags - 0, R.Top + Flags + 2, 3, 1, BLACKNESS);
      PatBlt(DC, R.Left + Flags + 1, R.Top + Flags + 3, 1, 1, BLACKNESS);
*)
    end;
  end;
end;

procedure TGridEdit.PaintWindow(DC: HDC);
begin
  { ������ ������ }
  PaintButton(DC);
  { ��������� �� ��������� }
  inherited PaintWindow(DC);
end;

procedure TGridEdit.UpdateBounds;
const
  Flags = SWP_SHOWWINDOW or SWP_NOREDRAW;
var
  R, F: TRect;
  L, T, W, H, X, Y: Integer;

  function TextHeight(const S: string): Integer;
  var
    Canvas: TControlCanvas;
  begin
    { ������� ������� }
    Canvas := TControlCanvas.Create;
    try
      { ����������� ��� ��������� ������ }
      Canvas.Control := Self;
      Canvas.Font := Self.Font;
      { ��������� }
      Result := Canvas.TextHeight(Self.Text);
    finally
      Canvas.Free;
    end;
  end;

begin
  if Grid <> nil then
  begin
    { ���������� ������������� ������ ������ ���� }
    R := Grid.GetEditRect(Grid.EditCell);
    { ���������� ������������� }
    F := R;
    { ����������� ������ � ����������� � �������������� }
    with Grid.GetFixedRect do
    begin
      if R.Left < Right then R.Left := Right;
      if R.Right < Right then R.Right := Right;
    end;
    { ����������� ������ � ����������� � ���������� }
    with Grid.GetHeaderRect do
    begin
      if R.Top < Bottom then R.Top := Bottom;
      if R.Bottom < Bottom then R.Bottom := Bottom;
    end;
    { ������������� ��������� }
    W := R.Right - R.Left;
    H := R.Bottom - R.Top;
    SetWindowPos(Handle, HWND_TOP, R.Left, R.Top, W, H, Flags);
    { ��������� ����� ������� ������ }
    L := F.Left - R.Left;
    T := F.Top - R.Top;
    W := F.Right - F.Left;
    H := F.Bottom - F.Top;
    X := Grid.GetCellBorder(Grid.EditCell);
    Y := ((F.Bottom - F.Top) - Abs(TextHeight(Text))) mod 2;
    { ��������� ������ }
    if EditStyle <> geSimple then Dec(W, ButtonWidth - 4);
    { ������������� ������� ������ }
    R := Bounds(L + X, T + 1, W - (X + 6), H - Y);
    SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@R));
  end
end;
                                                   
procedure TGridEdit.UpdateColors;
var
  Canvas: TCanvas;
begin
  if Grid <> nil then
  begin
    Canvas := TCanvas.Create;
    try
      { �������� ����� ������ }
      Grid.GetCellColors(Grid.EditCell, Canvas);
      { ���������� �� }
      Color := Canvas.Brush.Color;
      Font := Canvas.Font;
    finally
      Canvas.Free;
    end;
  end;
end;

procedure TGridEdit.UpdateContents;
begin
  { ��������� ��������� ������ }
  if Grid <> nil then
  begin
    Self.ReadOnly := Grid.Columns[Grid.EditCell.Col].ReadOnly;
    Self.MaxLength := Grid.Columns[Grid.EditCell.Col].MaxLength;
    Self.MultiLine := Grid.Columns[Grid.EditCell.Col].MultiLine;
    Self.Text := Grid.GetEditText(Grid.EditCell);
  end;
end;

procedure TGridEdit.UpdateList;
begin
  { ��������� ���������� ������ }
  if (Grid <> nil) and (FDropList <> nil) then
  begin
    { ������� ������ ������ }
    FDropList.Items.Clear;
    { ��������� ����� }
    Grid.GetEditList(Grid.EditCell, FDropList.Items);
    { ������������� ���������� ������� }
    SendMessage(FDropList.Handle, LB_SELECTSTRING, WORD(-1), Longint(PChar(Text)));
  end;
end;

procedure TGridEdit.UpdateListBounds;
var
  I, X, W: Integer;
  R: TRect;
begin
  { � ���� �� ������� }
  if (Grid = nil) or (FDropList <> nil) then
    { ��������� ������� ����������� ������ }
    with FDropList do
    begin
      Canvas.Font := Font;
      { ���������� ������ ������� ������ }
      if Items.Count > 0 then
      begin
        W := 0;
        for I := 0 to Items.Count - 1 do
        begin
          X := Canvas.TextWidth(Items[I]);
          if W < X then W := X;
        end;
        ClientWidth := W + 6;
      end
      else
        ClientWidth := 100;
      { ����������� �� ������ ������� }
      R := Grid.GetCellRect(Grid.EditCell);
      Width := MaxIntValue([Width, R.Right - R.Left]);
      { ���������� ������ }
      if (FDropDownCount < 1) or (Items.Count = 0) then
        ClientHeight := ItemHeight
      else if Items.Count < FDropDownCount then
        ClientHeight := Items.Count * ItemHeight
      else
        ClientHeight := FDropDownCount * ItemHeight;
      { ��������� }
      Left := Self.ClientOrigin.X + Self.Width - Width;
      Top := Self.ClientOrigin.Y + Self.Height;
      { ����������� � ������������ � ���������� ������������ }
      R := BoundsRect;
      Grid.GetEditListBounds(Grid.EditCell, R);
      BoundsRect := R;
    end;
end;

procedure TGridEdit.UpdateStyle;
var
  Style: TGridEditStyle;
begin
  { �������� ����� ������ }
  Style := geSimple;
  if Grid <> nil then Style := Grid.GetEditStyle(Grid.EditCell);
  { ������������� }
  EditStyle := Style;
end;

{
  Delete the requested message from the queue, but throw back
  any WM_QUIT msgs that PeekMessage may also return.
}
procedure KillMessage(Wnd: HWND; Msg: Integer);
var
  M: TMsg;
begin
  M.Message := 0;
  if PeekMessage(M, Wnd, Msg, Msg, PM_REMOVE) and (M.Message = WM_QUIT) then PostQuitMessage(M.wParam);
end;

procedure TGridEdit.WndProc(var Message: TMessage);

  procedure DoDropDownKeys(var Key: Word; Shift: TShiftState);
  begin
    case Key of
      VK_UP, VK_DOWN:
        { �������� ��� �������� }
        if ssAlt in Shift then
        begin
          Key := 0;
          if FDropListVisible then CloseUp(True) else DropDown;
        end;
      VK_RETURN, VK_ESCAPE:
        { �������� ������ }
        if (not (ssAlt in Shift)) and FDropListVisible then
        begin
          KillMessage(Handle, WM_CHAR);
          Key := 0;
          CloseUp(Key = VK_RETURN);
        end;
    end;
  end;

  procedure DoButtonKeys(var Key: Word; Shift: TShiftState);
  begin
    if (Key = VK_RETURN) and (Shift = [ssCtrl]) then
    begin
      KillMessage(Handle, WM_CHAR);
      Key := 0;
      { �������� ������� �� ������ }
      case EditStyle of
        geEllipsis: Press;
        gePickList,
        geDataList: if not FDropListVisible then SelectNext;
      end;
    end;
  end;

begin
  case Message.Msg of
    WM_KEYDOWN,
    WM_SYSKEYDOWN,
    WM_CHAR:
        with TWMKey(Message) do
        begin
          { �������� ������ }
          if EditStyle in [gePickList, geDataList] then
          begin
            DoDropDownKeys(CharCode, KeyDataToShiftState(KeyData));
            { �������� ���������� ������� ������ }
            if (CharCode <> 0) and FDropListVisible then
            begin
              with TMessage(Message) do SendMessage(FDropList.Handle, Msg, WParam, LParam);
              Exit;
            end;
          end;
          { �������� ������� �� ������ }
          if not MultiLine then
          begin
            DoButtonKeys(CharCode, KeyDataToShiftState(KeyData));
            if CharCode = 0 then Exit;
          end;
        end;
    WM_LBUTTONDOWN:
      { ������� ������� ����� }
      begin
        if GetMessageTime - FClickTime < GetDoubleClickTime then Message.Msg := WM_LBUTTONDBLCLK;
        FClickTime := 0;
      end;
  end;
  inherited WndProc(Message);
end;

procedure TGridEdit.CloseUp(Accept: Boolean);
const
  Flags = SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW;
var
  I: Integer;
begin
  if FDropListVisible then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    { �������� ������ }
    SetWindowPos(FDropList.Handle, 0, 0, 0, 0, 0, Flags);
    FDropListVisible := False;
    Invalidate;
    { ������������� ��������� �������� }
    if Accept and (Grid <> nil) then
    begin
      I := FDropList.ItemIndex;
      if I <> -1 then Text := FDropList.Items[DropList.ItemIndex];
    end;
  end;
end;

procedure TGridEdit.Deselect;
begin
  SendMessage(Handle, EM_SETSEL, $7FFFFFFF, Longint($FFFFFFFF));
end;

procedure TGridEdit.DropDown;
const
  Flags = SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW;
begin
  if (Grid <> nil) and (EditStyle in [gePickList, geDataList]) then
  begin
    { ������� ������ }
    if FDropList = nil then
    begin
      FDropList := Grid.CreateEditList;
      FDropList.Visible := False;
      FDropList.Parent := Self;
      FDropList.FGrid := Grid;
      FDropList.OnMouseUp := ListMouseUp;
      FDropList.IntegralHeight := True;
      FDropList.Font := Font;
    end;
    { �������� ������, ������������� ������� }
    UpdateList;
    UpdateListBounds;
    { ���������� ������ }
    SetWindowPos(FDropList.Handle, HWND_TOP, FDropList.Left, FDropList.Top, 0, 0, Flags);
    FDropListVisible := True;
    Invalidate;
    { ������������� �� ���� ����� }
    Windows.SetFocus(Handle);
  end;
end;

procedure TGridEdit.Invalidate;
var
  Cur: TRect;
begin
  { ��������� ������� }
  if Grid = nil then
  begin
    inherited Invalidate;
    Exit;
  end;
  { ���������������� }
  ValidateRect(Handle, nil);
  InvalidateRect(Handle, nil, True);
  { ��������� ������������� ������� }
  Windows.GetClientRect(Handle, Cur);
  MapWindowPoints(Handle, Grid.Handle, Cur, 2);
  ValidateRect(Grid.Handle, @Cur);
  InvalidateRect(Grid.Handle, @Cur, False);
end;

procedure TGridEdit.Hide;
const
  Flags = SWP_HIDEWINDOW or SWP_NOZORDER or SWP_NOREDRAW;
begin
  if (Grid <> nil) and HandleAllocated and Visible then
  begin
    { ���������� ���� �������������� }
    Grid.FEditing := False;
    { �������� ������ ����� }
    Invalidate;
    SetWindowPos(Handle, 0, 0, 0, 0, 0, Flags);
    { ������� ����� }
    if Focused then Windows.SetFocus(Grid.Handle);
  end;
end;

procedure TGridEdit.Press;
begin
  if Grid <> nil then Grid.EditButtonPress(Grid.EditCell);
end;

procedure TGridEdit.SelectNext;
begin
  if Grid <> nil then Grid.EditSelectNext(Grid.EditCell);
end;

procedure TGridEdit.SetFocus;
begin
  if IsWindowVisible(Handle) then Windows.SetFocus(Handle);
end;

procedure TGridEdit.Show;
begin
  if Grid <> nil then
  begin
    { ��������� ���� �������������� }
    Grid.FEditing := True;
    { ����������� ����� (������� ������ �� ��������� ������) }
    UpdateColors;
    { �������� ������� }
    UpdateBounds;
    { ������������� ����� }
    if Grid.Focused then Windows.SetFocus(Handle);
  end;
end;

{ TGridTipsWindow }

procedure TGridTipsWindow.WMNCPaint(var Message: TMessage);
begin
  Canvas.Handle := GetWindowDC(Handle);
  try
    Canvas.Pen.Color := clBlack;
    Canvas.Brush.Color := Color;
    Canvas.Rectangle(0, 0, Width, Height);
  finally
    Canvas.Handle := 0;
  end;
end;

procedure TGridTipsWindow.CMTextChanged(var Message: TMessage);
begin
  { ���������� �������, ����� "�������" ������ ���� }
end;

procedure TGridTipsWindow.Paint;
begin
  { � ���� �� ������� }
  if FGrid = nil then
  begin
    inherited Paint;
    Exit;
  end;
  { �������� ����� ������ }
  FGrid.GetCellColors(FGrid.FTipsCell, Canvas);
  { ����������� ����� }
  Canvas.Brush.Color := Color;
  Canvas.Font.Color := clInfoText;
  { ������ ����� }
  FGrid.PaintCellText(FGrid.FTipsCell, ClientRect, Canvas);
end;

procedure TGridTipsWindow.ActivateHint(Rect: TRect; const AHint: string);
const
  Flags = SWP_SHOWWINDOW or SWP_NOACTIVATE;
begin
  Caption := AHint;
  UpdateBoundsRect(Rect);
  SetWindowPos(Handle, HWND_TOPMOST, Rect.Left, Rect.Top, Width, Height, Flags);
  Invalidate;
end;

{$IFNDEF VER90}

procedure TGridTipsWindow.ActivateHintData(Rect: TRect; const AHint: string; AData: Pointer);
begin
  FGrid := AData;
  inherited ActivateHintData(Rect, AHint, AData);
end;

function TGridTipsWindow.CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect;
var
  R: TRect;
begin
  { ������ �� ������� }
  FGrid := AData;
  { ���� �� ������� }
  if FGrid = nil then
  begin
    Result := inherited CalcHintRect(MaxWidth, AHint, AData);
    Exit;
  end;
  { ������������� ��������� }
  R := FGrid.GetTipsRect(FGrid.FTipsCell, MaxWidth);
  { ����������� ���������, ��������� ������ }
  OffsetRect(R, -R.Left, -R.Top);
  { ��������� }
  Result := R;
end;

{$ENDIF}

{ TCustomGridView }

constructor TCustomGridView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csClickEvents, csDoubleClicks, csOpaque];
  Width := 185;
  Height := 105;
  Color := clWindow;
  ParentColor := False;
  TabStop := True;
  FHorzScrollBar := CreateScrollBar(sbHorizontal);
  FHorzScrollBar.OnScroll := HorzScroll;
  FHorzScrollBar.OnChange := HorzScrollChange;
  FVertScrollBar := CreateScrollBar(sbVertical);
  FVertScrollBar.LineSize := 17;
  FVertScrollBar.OnScroll := VertScroll;
  FVertScrollBar.OnChange := VertScrollChange;
  FHeader := CreateHeader;
  FHeader.OnChange := HeaderChange;
  FColumns := CreateColumns;
  FColumns.OnChange := ColumnsChange;
  FRows := CreateRows;
  FRows.OnChange := RowsChange;
  FFixed := CreateFixed;
  FFixed.OnChange := FixedChange;
  FImagesLink := TChangeLink.Create;
  FImagesLink.OnChange := ImagesChange;
  FBorderStyle := bsSingle;
  FShowHeader := True;
  FGridLines := True;
  FGridLineWidth := 1;
  FEndEllipsis := True;
  FShowFocusRect := True;
  FRightClickSelect := True;
  FEditCell := GridCell(-1, -1);
end;

destructor TCustomGridView.Destroy;
begin
  FImagesLink.Free;
  FRows.Free;
  FColumns.Free;
  FHeader.Free;
  FHorzScrollBar.Free;
  FVertScrollBar.Free;
  inherited Destroy;
end;

function TCustomGridView.GetCell(Col, Row: Integer): string;
begin
  Result := GetCellText(GridCell(Col, Row));
end;

procedure TCustomGridView.ColumnsChange(Sender: TObject);
begin
  if [csReading, csLoading] * ComponentState = [] then
  begin
    Header.Synchronized := False;
    Fixed.Count := Fixed.Count;
  end;
  UpdateScrollBars;
  UpdateScrollRange;
  UpdateEdit(Editing);
  UpdateCursor;
  Invalidate;
  ChangeColumns;
end;

procedure TCustomGridView.FixedChange(Sender: TObject);
begin
  UpdateScrollBars;
  UpdateScrollRange;
  UpdateEdit(Editing);
  UpdateCursor;
  Invalidate;
  ChangeFixed; 
end;

procedure TCustomGridView.HeaderChange(Sender: TObject);
begin
  UpdateScrollBars;
  UpdateScrollRange;
  UpdateEdit(Editing);
  Invalidate;
end;

procedure TCustomGridView.HorzScroll(Sender: TObject; ScrollCode: Integer; var ScrollPos: Integer);
begin
  UpdateFocus;
end;

procedure TCustomGridView.HorzScrollChange(Sender: TObject);
begin
  UpdateScrollRange;
  UpdateEdit(Editing);
end;

procedure TCustomGridView.ImagesChange(Sender: TObject);
begin
  InvalidateGrid;
end;

procedure TCustomGridView.RowsChange(Sender: TObject);
begin
  UpdateScrollBars;
  UpdateScrollRange;
  UpdateEdit(Editing);
  UpdateCursor;
  InvalidateGrid;
  ChangeRows;
end;

procedure TCustomGridView.SetAllowEdit(Value: Boolean);
begin
  if FAllowEdit <> Value then
  begin
    FAllowEdit := Value;
    if Value then RowSelect := False else AlwaysEdit := False;
    UpdateEdit(Editing);
  end;
end;

procedure TCustomGridView.SetAlwaysEdit(Value: Boolean);
begin
  if FAlwaysEdit <> Value then
  begin
    FAlwaysEdit := Value;
    if Value then AllowEdit := True;
    UpdateEdit(Editing);
  end;
end;

procedure TCustomGridView.SetAlwaysSelected(Value: Boolean);
begin
  if FAlwaysSelected <> Value then
  begin
    FAlwaysSelected := Value;
    FCellSelected := FCellSelected or Value;
    InvalidateFocus;
  end;
end;

procedure TCustomGridView.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TCustomGridView.SetCell(Col, Row: Integer; Value: string);
begin
  SetEditText(GridCell(Col, Row), Value);
end;

procedure TCustomGridView.SetCellFocused(Value: TGridCell);
begin
  SetCursor(Value, CellSelected, True);
end;

procedure TCustomGridView.SetCellSelected(Value: Boolean);
begin
  SetCursor(CellFocused, Value, True);
end;

procedure TCustomGridView.SetColumns(Value: TGridColumns);
begin
  FColumns.Assign(Value);
end;

procedure TCustomGridView.SetEditing(Value: Boolean);
begin
  if Value then
  begin
    ShowEdit;
    if FEdit <> nil then FEdit.Deselect;
  end
  else
    HideEdit;
end;

procedure TCustomGridView.SetEndEllipsis(Value: Boolean);
begin
  if FEndEllipsis <> Value then
  begin
    FEndEllipsis := Value;
    InvalidateGrid;
  end;
end;

procedure TCustomGridView.SetFixed(Value: TGridFixed);
begin
  FFixed.Assign(Value);
end;

procedure TCustomGridView.SetHeader(Value: TGridHeader);
begin
  Header.Assign(Value);
end;

procedure TCustomGridView.SetHideSelection(Value: Boolean);
begin
  if FHideSelection <> Value then
  begin
    FHideSelection := Value;
    InvalidateFocus;
  end;
end;

procedure TCustomGridView.SetHorzScrollBar(Value: TGridScrollBar);
begin
  FHorzScrollBar.Assign(Value);
end;

procedure TCustomGridView.SetGridLines(Value: Boolean);
begin
  if FGridLines <> Value then
  begin
    FGridLines := Value;
    InvalidateGrid;
  end;
end;

procedure TCustomGridView.SetShowCellTips(Value: Boolean);
begin
  if FShowCellTips <> Value then
  begin
    FShowCellTips := Value;
    ShowHint := ShowHint or Value;
  end;
end;

procedure TCustomGridView.SetShowFocusRect(Value: Boolean);
begin
  if FShowFocusRect <> Value then
  begin
    FShowFocusRect := Value;
    InvalidateFocus;
  end;
end;

procedure TCustomGridView.SetShowHeader(Value: Boolean);
begin
  if FShowHeader <> Value then
  begin
    FShowHeader := Value;
    UpdateScrollBars;
    UpdateScrollRange;
    UpdateEdit(Editing);
    UpdateCursor;
    Invalidate;
  end;
end;

procedure TCustomGridView.SetImages(Value: TImageList);
begin
  if FImages <> Value then
  begin
    if Assigned(FImages) then FImages.UnRegisterChanges(FImagesLink);
    FImages := Value;
    if Assigned(FImages) then FImages.RegisterChanges(FImagesLink);
    UpdateEdit(Editing);
    InvalidateGrid;
  end;
end;

procedure TCustomGridView.SetRows(Value: TGridRows);
begin
  FRows.Assign(Value);
end;

procedure TCustomGridView.SetRowSelect(Value: Boolean);
begin
  if FRowSelect <> Value then
  begin
    FRowSelect := Value;
    if Value then AllowEdit := False else UpdateEdit(Editing);
    InvalidateGrid;
  end;
end;

procedure TCustomGridView.SetVertScrollBar(Value: TGridScrollBar);
begin
  FVertScrollBar.Assign(Value);
end;

procedure TCustomGridView.SetVisOrigin(Value: TGridCell);
var
  SOrigin: TGridCell;
begin
  if (FVisOrigin.Col <> Value.Col) or (FVisOrigin.Row <> Value.Row) then
  begin
    SOrigin := FVisOrigin;
    FVisOrigin := Value;
    if SOrigin.Col <> Value.Col then
      Invalidate
    else
      InvalidateGrid;
  end;
end;

procedure TCustomGridView.VertScroll(Sender: TObject; ScrollCode: Integer; var ScrollPos: Integer);
begin
  UpdateFocus;
end;

procedure TCustomGridView.VertScrollChange(Sender: TObject);
begin
  UpdateScrollRange;
  UpdateEdit(Editing);
end;

procedure TCustomGridView.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS + DLGC_WANTCHARS;
end;

procedure TCustomGridView.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if Rows.Count > 0 then
  begin
    InvalidateFocus;
    if (FEdit = nil) or (Message.FocusedWnd <> FEdit.Handle) then HideCursor;
  end;
end;

procedure TCustomGridView.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if Rows.Count > 0 then
  begin
    InvalidateFocus;
    if (FEdit = nil) or (Message.FocusedWnd <> FEdit.Handle) then ShowCursor;
  end;
end;

procedure TCustomGridView.WMChar(var Msg: TWMChar);
begin
  { ���������� ������ �����, ���� ����� }
  if AllowEdit and (Char(Msg.CharCode) in [^H, #32..#255]) then
  begin
    ShowEditChar(Char(Msg.CharCode));
    Exit;
  end;
  { ����� ��������� �� ��������� }
  inherited;
end;

procedure TCustomGridView.WMSize(var Message: TWMSize);
begin
  inherited;
  UpdateScrollBars;
  UpdateScrollRange;
  UpdateEdit(Editing);
  Resize;
end;

procedure TCustomGridView.WMHScroll(var Message: TWMHScroll);
begin
  if Message.ScrollBar = 0 then
    FHorzScrollBar.ScrollMessage(Message)
  else
    inherited;
end;

procedure TCustomGridView.WMVScroll(var Message: TWMVScroll);
begin
  if Message.ScrollBar = 0 then
    FVertScrollBar.ScrollMessage(Message)
  else
    inherited;
end;

procedure TCustomGridView.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  FHitTest := ScreenToClient(SmallPointToPoint(Message.Pos));
end;

procedure TCustomGridView.WMSetCursor(var Message: TWMSetCursor);
begin
  with Message, FHitTest do
    if (HitTest = HTCLIENT) and not (csDesigning in ComponentState) then
      if ShowHeader and PtInRect(GetHeaderRect, FHitTest) then
        if GetResizeSection(X, Y) <> nil then
        begin
          Windows.SetCursor(Screen.Cursors[crHSplit]);
          Exit;
        end;
  inherited;
end;

procedure TCustomGridView.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TCustomGridView.CMCancelMode(var Message: TCMCancelMode); 
begin
  if FEdit <> nil then FEdit.WndProc(TMessage(Message));
  inherited;
end;

procedure TCustomGridView.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (FBorderStyle = bsSingle) then RecreateWnd;
  inherited;
end;

procedure TCustomGridView.CMFontChanged(var Message: TMessage);
begin
  { ���������� ����� }
  Canvas.Font := Font;
  { ����������� ����� � ��������� � ������������� }
  UpdateFonts;
  { ��������� �� ��������� }
  inherited;
end;

procedure TCustomGridView.CMColorChanged(var Message: TMessage);
begin
  { ���������� ���� }
  Brush.Color := Color;
  { ����������� ���� � ��������� � ������������� }
  UpdateColors;
  { ��������� �� ��������� }
  inherited;
end;

procedure TCustomGridView.CMShowHintChanged(var Message: TMessage);
begin
  ShowCellTips := ShowCellTips and ShowHint;
end;

{$IFNDEF VER90}

procedure TCustomGridView.CMHintShow(var Message: TMessage);
var
  R: TRect;
  T: string;
begin
  with Message, PHintInfo(LParam)^ do
  begin
    { � ����� �� ��������� }
    if not ShowCellTips then
    begin
      inherited;
      Exit;
    end;
    { ���� ������, �� ������� ��������� ������ }
    FTipsCell := GetCellAt(CursorPos.X, CursorPos.Y);
    { ���� �� ������ - ��������� ���, ����� }
    if IsCellEmpty(FTipsCell) then
    begin
      Result := 1;
      Exit;
    end;
    { � �� ���� �� �������������� ���� ������ }
    if IsCellEqual(EditCell, FTipsCell) and Editing then
    begin
      Result := 1;
      Exit;
    end;
    { �������� ������������� ������ }
    R := GetEditRect(FTipsCell);
    { �������� ������������� ������ }
    Inc(R.Left, GetCellBorder(FTipsCell));
    Dec(R.Right, 6);
    { ��������� ���������� ����� }
    IntersectRect(R, R, ClientRect);
    { �������� ����� ������ }
    T := GetCellText(FTipsCell);
    { ����������� ����� � ����� ������ }
    GetCellColors(FTipsCell, Canvas);
    { � �������� �� ����� �� ������ }
    if Canvas.TextWidth(T) < R.Right - R.Left then
    begin
      Result := 1;
      Exit;
    end;
    { �������� ������������� ��������� }
    R := GetTipsRect(FTipsCell, HintMaxWidth);
    { ����������� ��������� � ����� ��������� }
    HintPos := ClientToScreen(R.TopLeft);
    HintStr := T;
    { ����������� ������������� ��������� }
    R := GetCellRect(FTipsCell);
    if FTipsCell.Col < Fixed.Count then
    begin
      R.Left := MaxIntValue([R.Left, 0]);
      R.Right := MinIntValue([R.Right, GetFixedWidth]);
    end
    else
    begin
      R.Left := MaxIntValue([R.Left, GetFixedWidth]);
      R.Right := MinIntValue([R.Right, ClientWidth]);
    end;
    InflateRect(R, 1, 1);
    CursorRect := R;
    { ��� ���� ��������� }
    HintWindowClass := GetTipsWindow;
    HintData := Self;
    { ��������� }
    Result := 0;
  end;
end;

{$ELSE}

procedure TCustomGridView.CMHintShow(var Message: TMessage);
begin
  inherited;
end;

{$ENDIF}

function TCustomGridView.AcquireFocus: Boolean;
begin
  Result := True;
  { ����� �� ������������� ����� }
  if not (csDesigning in ComponentState) and CanFocus then
  begin
    UpdateFocus;
    Result := IsActiveControl;
  end;
end;

procedure TCustomGridView.CellClick(Cell: TGridCell; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnCellClick) then FOnCellClick(Self, Cell, Shift, X, Y);
end;

procedure TCustomGridView.Change(var Cell: TGridCell; var Selected: Boolean);
begin
  if Assigned(FOnChange) then FOnChange(Self, Cell, Selected);
end;

procedure TCustomGridView.ChangeColumns;
begin
  if Assigned(FOnChangeColumns) then FOnChangeColumns(Self);
end;

procedure TCustomGridView.ChangeFixed;
begin
  if Assigned(FOnChangeFixed) then FOnChangeFixed(Self);
end;

procedure TCustomGridView.ChangeRows;
begin
  if Assigned(FOnChangeRows) then FOnChangeRows(Self);
end;

procedure TCustomGridView.ChangeScale(M, D: Integer);
var
  S: Boolean;
  I: Integer;
begin
  inherited ChangeScale(M, D);
  if M <> D then
  begin
    S := Header.Synchronized;
    try
      with Columns do
      begin
        BeginUpdate;
        try             
          for I := 0 to Count - 1 do
            Columns[I].Width := MulDiv(Columns[I].Width, M, D);
        finally
          EndUpdate;
        end;
      end;
      with Rows do
        Height := MulDiv(Height, M, D);
      with Header do
      begin
        SectionHeight := MulDiv(SectionHeight, M, D);
        Font.Size := MulDiv(Font.Size, M, D);
      end;
    finally
      Header.Synchronized := S;
    end;
  end;
end;

procedure TCustomGridView.Changing(var Cell: TGridCell; var Selected: Boolean);
begin
  if Assigned(FOnChanging) then FOnChanging(Self, Cell, Selected);
end;

procedure TCustomGridView.ColumnResize(Column: Integer; var Width: Integer);
begin
  if Assigned(FOnColumnResize) then FOnColumnResize(Self, Column, Width);
end;

procedure TCustomGridView.ColumnResizing(Column: Integer; var Width: Integer);
begin
  if Assigned(FOnColumnResizing) then FOnColumnResizing(Self, Column, Width);
end;

function TCustomGridView.CreateColumn: TGridColumn;
begin
  Result := TGridColumn(TGridColumn.Create(FColumns));
end;

function TCustomGridView.CreateColumns: TGridColumns;
begin
  Result := TGridColumns.Create(Self);
end;

function TCustomGridView.CreateEdit: TGridEdit;
begin
  Result := TGridEdit.Create(Self);
end;

function TCustomGridView.CreateEditList: TGridListBox;
begin
  Result := TGridListBox.Create(Self);
end;

function TCustomGridView.CreateFixed: TGridFixed;
begin
  Result := TGridFixed.Create(Self);
end;

function TCustomGridView.CreateHeader: TGridHeader;
begin
  Result := TGridHeader.Create(Self);
end;

function TCustomGridView.CreateHeaderSection: TGridHeaderSection;
begin
  Result := TGridHeaderSection(TGridHeaderSection.Create(FHeader.Sections));
end;

procedure TCustomGridView.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of Longint = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_TABSTOP;
    Style := Style or BorderStyles[FBorderStyle];
    if FBorderStyle = bsSingle then
      if NewStyleControls and Ctl3D then
      begin
        Style := Style and not WS_BORDER;
        ExStyle := ExStyle or WS_EX_CLIENTEDGE;
      end
      else
        Style := Style or WS_BORDER;
  end;
end;

function TCustomGridView.CreateRows: TGridRows;
begin
  Result := TGridRows.Create(Self);
end;

function TCustomGridView.CreateScrollBar(Kind: TScrollBarKind): TGridScrollBar;
begin
  Result := TGridScrollBar.Create(Self, Kind);
end;

procedure TCustomGridView.DoExit;
begin
  inherited DoExit;
  { ������������� ����� � ����� ������ �������������� }
  if Editing and (not AlwaysEdit) then
  try
    UpdateEditText;
    HideEdit;
  except
    Windows.SetFocus(Handle);
    raise;
  end;
end;

procedure TCustomGridView.EditButtonPress(Cell: TGridCell);
begin
  if Assigned(FOnEditButtonPress) then FOnEditButtonPress(Self, Cell);
end;

procedure TCustomGridView.EditSelectNext(Cell: TGridCell);
begin
  if Assigned(FOnEditSelectNext) then FOnEditSelectNext(Self, Cell);
end;

function TCustomGridView.EditCanModify: Boolean;
begin
  Result := not Columns[CellFocused.Col].ReadOnly;
end;

function TCustomGridView.EditCanAcceptKey(Key: Char): Boolean;
begin
  Result := True;
  if Assigned(FOnEditAcceptKey) then FOnEditAcceptKey(Self, Key, Result);
end;

function TCustomGridView.EditCanShow: Boolean;
begin
  { ��������� ����� ������� � �������� }
  if [csReading, csLoading, csDesigning] * ComponentState <> [] then
  begin
    Result := False;
    Exit;
  end;
  { ��������� }
  Result := HandleAllocated and AllowEdit and (AlwaysEdit or IsActiveControl);
end;

function TCustomGridView.GetCellBorder(Cell: TGridCell): Integer;
begin
  if IsCellHasImage(Cell) then Result := 2 else Result := 6;
end;

procedure TCustomGridView.GetCellColors(Cell: TGridCell; Canvas: TCanvas);
begin
  { ������������� ������ }
  if Cell.Col < Fixed.Count then
  begin
    Canvas.Brush.Color := Fixed.Color;
    Canvas.Font := Fixed.Font;
  end
  else
  begin
    { ������� ������ }
    Canvas.Brush.Color := Self.Color;
    Canvas.Font := Self.Font;
    { ���������� ������ }
    if IsFocusAllowed and CellSelected and IsCellFocused(Cell) then
      { ���� �� ����� �� ������� }
      if Focused then
      begin
        Canvas.Brush.Color := clHighlight;
        Canvas.Font.Color := clHighlightText;
      end
      { ���� �� ������ ���������� ������ }
      else if not HideSelection then
      begin
        Canvas.Brush.Color := clBtnFace;
        Canvas.Font.Color := Font.Color;
      end;
  end;
  { ������� ������������ }
  if Assigned(FOnGetCellColors) then FOnGetCellColors(Self, Cell, Canvas);
end;

function TCustomGridView.GetCellImage(Cell: TGridCell): Integer;
begin
  { � ���� �� �������� }
  if not Assigned(Images) then
  begin
    Result := -1;
    Exit;
  end;
  { ��� ������ �������� ���� ������, ��� ��������� ��� }
  if Cell.Col = Fixed.Count then Result := 0 else Result := -1;
  { ������� ������������ }
  if Assigned(FOnGetCellImage) then FOnGetCellImage(Self, Cell, Result);
end;

function TCustomGridView.GetCellText(Cell: TGridCell): string;
begin
  Result := '';
  if Assigned(FOnGetCellText) then FOnGetCellText(Self, Cell, Result);
end;

function TCustomGridView.GetClientOrigin: TPoint;
begin
  if Parent = nil then
  begin
    Result.X := 0;
    Result.Y := 0;
    Exit;
  end;
  Result := inherited GetClientOrigin;
end;

function TCustomGridView.GetClientRect: TRect;
begin
  if Parent = nil then
  begin
    Result.Left := 0;
    Result.Top := 0;
    Result.Right := Width;
    Result.Bottom := Height;
    Exit;
  end;
  Result := inherited GetClientRect;
end;

function TCustomGridView.GetCursorCell(Cell: TGridCell; Offset: TGridOffset): TGridCell;

  function DoMoveLeft(O: Integer): TGridCell;
  var
    I: Integer;
    C: TGridCell;
  begin
    { ����� �������� ������� }
    I := MaxIntValue([Cell.Col - O, Fixed.Count]);
    { ���������� ������� �� �������������, ���� �� ���������� �������� }
    while I >= Fixed.Count do
    begin
      C := GridCell(I, Cell.Row);
      { �������� ���������� ������ }
      if IsCellAcceptCursor(C) then
      begin
        Result := C;
        Exit;
      end;
      { ���������� ������� }
      Dec(I);
    end;
    { ��������� }
    Result := Cell;
  end;

  function DoMoveRight(O: Integer): TGridCell;
  var
    I: Integer;
    C: TGridCell;
  begin
    { ����� �������� ������� }
    I := MinIntValue([Cell.Col + O, Columns.Count - 1]);
    { ���������� ������� �� ���������, ���� �� ���������� �������� }
    while I <= Columns.Count - 1 do
    begin
      C := GridCell(I, Cell.Row);
      { �������� ���������� ������ }
      if IsCellAcceptCursor(C) then
      begin
        Result := C;
        Exit;
      end;
      { ��������� ������� }
      Inc(I);
    end;
    { ��������� }
    Result := Cell;
  end;

  function DoMoveUp(O: Integer): TGridCell;
  var
    J: Integer;
    C: TGridCell;
  begin
    { ����� �������� ������ }
    J := MaxIntValue([Cell.Row - O, 0]);
    { ���������� ������ �� ������, ���� �� ���������� �������� }
    while J >= 0 do
    begin
      C := GridCell(Cell.Col, J);
      { �������� ���������� ������ }
      if IsCellAcceptCursor(C) then
      begin
        Result := C;
        Exit;
      end;
      { ���������� ������ }
      Dec(J);
    end;
    { ��������� }
    Result := Cell;
  end;

  function DoMoveDown(O: Integer): TGridCell;
  var
    J: Integer;
    C: TGridCell;
  begin
    { ����� �������� ������ }
    J := MinIntValue([CellFocused.Row + O, Rows.Count - 1]);
    { ���������� ������ �� ���������, ���� �� ���������� �������� }
    while J <= Rows.Count - 1 do
    begin
      C := GridCell(Cell.Col, J);
      { �������� ���������� ������ }
      if IsCellAcceptCursor(C) then
      begin
        Result := C;
        Exit;
      end;
      { ��������� ������ }
      Inc(J);
    end;
    { ��������� }
    Result := Cell;
  end;

  function DoMoveHome: TGridCell;
  var
    I, J: Integer;
    C: TGridCell;
  begin
    { ����� �������� ������� }
    I := Fixed.Count;
    { ���������� ������� �� �������, ���� �� ���������� �������� }
    while I <= Cell.Col do
    begin
      { ����� �������� ������ }
      J := 0;
      { ���������� ������ �� �������, ���� �� ���������� �������� }
      while J <= Cell.Row do
      begin
        C := GridCell(I, J);
        { �������� ���������� ������ }
        if IsCellAcceptCursor(C) then
        begin
          Result := C;
          Exit;
        end;
        { ��������� ������ }
        Inc(J);
      end;
      { ��������� ������� }
      Inc(I);
    end;
    { ��������� }
    Result := Cell;
  end;

  function DoMoveEnd: TGridCell;
  var
    I, J: Integer;
    C: TGridCell;
  begin
    { ����� �������� ������� }
    I := Columns.Count - 1;
    { ���������� ������� �� �������, ���� �� ���������� �������� }
    while I >= Cell.Col do
    begin
      J := Rows.Count - 1;
      { ���������� ������ �� �������, ���� �� ���������� �������� }
      while J >= Cell.Row do
      begin
        C := GridCell(I, J);
        { �������� ���������� ������ }
        if IsCellAcceptCursor(C) then
        begin
          Result := C;
          Exit;
        end;
        { ���������� ������ }
        Dec(J);
      end;
      { ���������� ������� }
      Dec(I);
    end;
    { ��������� }
    Result := Cell;
  end;

  function DoSelect: TGridCell;

    function DoSelectLeft: TGridCell;
    var
      I: Integer;
      C: TGridCell;
    begin
      I := MaxIntValue([Cell.Col, Fixed.Count]);
      { ���������� ������� �� �������, ���� �� ���������� �������� }
      while I <= CellFocused.Col do
      begin
        C := GridCell(I, Cell.Row);
        { �������� ���������� ������ }
        if IsCellAcceptCursor(C) then
        begin
          Result := C;
          Exit;
        end;
        { ��������� ������� }
        Inc(I);
      end;
      { ������ �� ������� }
      Result := Cell;
    end;

    function DoSelectRight: TGridCell;
    var
      I: Integer;
      C: TGridCell;
    begin
      I := MinIntValue([Cell.Col, Columns.Count - 1]);
      { ���������� ������� �� �������, ���� �� ���������� �������� }
      while I >= CellFocused.Col do
      begin
        C := GridCell(I, Cell.Row);
        { �������� ���������� ������ }
        if IsCellAcceptCursor(C) then
        begin
          Result := C;
          Exit;
        end;
        { ���������� ������� }
        Dec(I);
      end;
      { ������ �� ������� }
      Result := Cell;
    end;

    function DoSelectUp: TGridCell;
    var
      J: Integer;
      C: TGridCell;
    begin
      J := MaxIntValue([Cell.Row, 0]);
      { ���������� ������ �� �������, ���� �� ���������� �������� }
      while J <= CellFocused.Row do
      begin
        C := GridCell(Cell.Col, J);
        { �������� ���������� ������ }
        if IsCellAcceptCursor(C) then
        begin
          Result := C;
          Exit;
        end;
        { ��������� ������ }
        Inc(J);
      end;
      { ������ �� ������� }
      Result := Cell;
    end;

    function DoSelectDown: TGridCell;
    var
      J: Integer;
      C: TGridCell;
    begin
      J := MinIntValue([Cell.Row, Rows.Count - 1]);
      { ���������� ������ �� �������, ���� �� ���������� �������� }
      while J >= CellFocused.Row do
      begin
        C := GridCell(Cell.Col, J);
        { �������� ���������� ������ }
        if IsCellAcceptCursor(C) then
        begin
          Result := C;
          Exit;
        end;
        { ���������� ������ }
        Dec(J);
      end;
      { ������ �� ������� }
      Result := Cell;
    end;

  begin
    { � �������� �� ��������� ������ }
    if IsCellAcceptCursor(Cell) then
    begin
      Result := Cell;
      Exit;
    end;
    { ���� ��������� ����� �� ������� - ���� ����� }
    if Cell.Col < CellFocused.Col then
    begin
      Result := DoSelectLeft;
      if IsCellAcceptCursor(Result) then Exit;
    end;
    { ���� ��������� ������ �� ������� - ���� ������ }
    if Cell.Col > CellFocused.Col then
    begin
      Result := DoSelectRight;
      if IsCellAcceptCursor(Result) then Exit;
    end;
    { ���� ��������� ��� �������� - ���� ������ }
    if Cell.Row < CellFocused.Row then
    begin
      Result := DoSelectUp;
      if IsCellAcceptCursor(Result) then Exit;
    end;
    { ��������� ��� �������� - ���� ����� }
    if Cell.Row > CellFocused.Row then
    begin
      Result := DoSelectDown;
      if IsCellAcceptCursor(Result) then Exit;
    end;
    { ������ �� ���������� }
    Result := CellFocused;
  end;

  function DoFirst: TGridCell;
  var
    C: TGridCell;
    I, J: Integer;
  begin
    J := 0;
    { ���������� ������ �� �������, ���� �� ���������� �������� }
    while J <= Rows.Count - 1 do
    begin
      I := Fixed.Count;
      { ���������� ������� �� ���������, ���� �� ���������� �������� }
      while I <= Columns.Count - 1 do
      begin
        C := GridCell(I, J);
        { �������� ���������� ������ }
        if IsCellAcceptCursor(C) then
        begin
          Result := C;
          Exit;
        end;
        { ���������  ������� }
        Inc(I);
      end;
      { ��������� ������ }
      Inc(J);
    end;
    { ��������� �� ��������� }
    Result := CellFocused;
  end;

begin
  case Offset of
    goLeft:
      { �������� �� ������� ����� }
      Result := DoMoveLeft(1);
    goRight:
      { �������� ������ �� ���� ������� }
      Result := DoMoveRight(1);
    goUp:
      { �������� ����� �� ���� ������� }
      Result := DoMoveUp(1);
    goDown:
      { �������� ���� �� ���� ������� }
      Result := DoMoveDown(1);
    goPageUp:
      { �������� �� �������� ����� }
      Result := DoMoveUp(VisSize.Row - 1);
    goPageDown:
      { �������� �� �������� ���� }
      Result := DoMoveDown(VisSize.Row - 1);
    goHome:
      { � ������ ������� }
      Result := DoMoveHome;
    goEnd:
      { � ����� ������� }
      Result := DoMoveEnd;
    goSelect:
      { �������� ������ }
      Result := DoSelect;
    goFirst:
      { ������� ������ ��������� ������ }
      Result := DoFirst;
    else
      { ��������� ���������� }
      Result := Cell;
  end;
end;

procedure TCustomGridView.GetEditList(Cell: TGridCell; Items: TStrings);
begin
  if Assigned(FOnGetEditList) then FOnGetEditList(Self, Cell, Items);
end;

procedure TCustomGridView.GetEditListBounds(Cell: TGridCell; var Rect: TRect);
begin
  if Assigned(FOnGetEditListBounds) then FOnGetEditListBounds(Self, Cell, Rect);
end;

function TCustomGridView.GetEditRect(Cell: TGridCell): TRect;
var
  L: Integer;
begin
  Result := GetCellRect(Cell);
  { ����� ��� �������� }
  if IsCellHasImage(Cell) then
  begin
    { �������� ��������� �� ������ �������� + 2 }
    Inc(Result.Left, Images.Width + 2);
    { ��������� ������ ���� }
    L := GetColumnsWidth(0, Cell.Col);
    if Result.Left > L then Result.Left := L;
  end;
  { ��������� ����� }
  if GridLines then
  begin
    Dec(Result.Right, FGridLineWidth);
    Dec(Result.Bottom, FGridLineWidth);
  end;
end;

function TCustomGridView.GetEditStyle(Cell: TGridCell): TGridEditStyle;
begin
  Result := geSimple;
  if Assigned(FOnGetEditStyle) then FOnGetEditStyle(Self, Cell, Result);
end;

function TCustomGridView.GetEditText(Cell: TGridCell): string;
begin
  Result := GetCellText(Cell);
  if Assigned(FOnGetEditText) then FOnGetEditText(Self, Cell, Result);
end;

procedure TCustomGridView.GetHeaderColors(Section: TGridHeaderSection; Canvas: TCanvas);
begin
  { ����������� ����� }
  Canvas.Brush.Color := Header.Color;
  Canvas.Font := Header.Font;
  { ������� ������������ }
  if Assigned(FOnGetHeaderColors) then FOnGetHeaderColors(Self, Section, Canvas);
end;

function TCustomGridView.GetTipsRect(Cell: TGridCell; MaxWidth: Integer): TRect;
var
  T: string;
  Rect, R: TRect;
  P: TDrawTextParams;
  F, W, H, B, X, Y: Integer;
begin
  { �������� ����� ������ }
  T := GetCellText(Cell);
  { �������� ������������� ������ }
  Rect := GetEditRect(Cell);                                                 
  { ������� ����� }
  if Columns[Cell.Col].MultiLine or EndEllipsis then
  begin
    { ��������� ������ ������ }
    FillChar(P, SizeOf(P), 0);
    P.cbSize := SizeOf(P);
    P.iLeftMargin := GetCellBorder(Cell);
    P.iRightMargin := 6;
    { �������� ������ }
    F := DT_NOPREFIX;
    { �������������� ������������ }
    case Columns[Cell.Col].Alignment of
      taLeftJustify: F := F or DT_LEFT;
      taCenter: F := F or DT_CENTER;
      taRightJustify: F := F or DT_RIGHT;
    end;
    { ������������ ������������ }
    if not Columns[Cell.Col].MultiLine then
    begin
      { �������������� ������������ }
      F := F or DT_SINGLELINE or DT_VCENTER;
      { ��������� �� ����� �� ��������� }
    end;
    { ������������� ������ }
    R := Rect;
    { ������� ���� ��������� }
    with GetTipsWindow.Create(Self) do
    try
      GetCellColors(Cell, Canvas);
      DrawTextEx(Canvas.Handle, PChar(T), Length(T), R, F or DT_CALCRECT, @P)
    finally
      Free;
    end;
    { ������� ������ }
    W := MaxIntValue([Rect.Right - Rect.Left, R.Right - R.Left]);
    H := MaxIntValue([Rect.Bottom - Rect.Top, R.Bottom - R.Top]);
    { �������� ������ ��� ������������ �� ������ }
    X := W - (Rect.Right - Rect.Left);
    X := (X div 2 + (X mod 2));
    { �������� �� ��������� }
    Y := 0;
    if not Columns[Cell.Col].Multiline then
    begin
      Y := H - (Rect.Bottom - Rect.Top);
      Y := Y div 2;
    end;
  end
  else
  begin
    { ������ }
    B := GetCellBorder(Cell);
    { ������ � ������ ������ }
    with GetTipsWindow.Create(Self) do
    try
      { ��������� ����� }
      GetCellColors(Cell, Canvas);
      { ������� ������ }
      W := MaxIntValue([Rect.Right - Rect.Left, B + Canvas.TextWidth(T) + 6]);
      H := MaxIntValue([Rect.Bottom - Rect.Top, Canvas.TextHeight(T)]);
      { �������� ������ ��� ������������ �� ������ }
      X := W - (Rect.Right - Rect.Left);
      X := X div 2;
      { �������� �� ��������� }
      Y := H - (Rect.Bottom - Rect.Top);
      Y := Y div 2;
    finally
      Free;
    end;
  end;
  { ��������� ������������� }
  case Columns[Cell.Col].Alignment of
    taCenter:
      begin
        R.Left := Rect.Left - X;
        R.Right := R.Left + W;
      end;
    taRightJustify:
      begin
        R.Right := Rect.Right;
        R.Left := R.Right - W;
      end;
    else
      begin
        R.Left := Rect.Left;
        R.Right := R.Left + W;
      end;
  end;
  R.Top := Rect.Top - Y;
  R.Bottom := R.Top + H;
  { ��������� ������ }
  InflateRect(R, 1, 1);
  { ��������� }
  Result := R;
end;

function TCustomGridView.GetTipsWindow: TGridTipsWindowClass;
begin
  Result := TGridTipsWindow;
end;

procedure TCustomGridView.HideCursor;
begin
  if IsFocusAllowed then
  begin
    InvalidateFocus;
    Exit;
  end;
  HideEdit;
end;

procedure TCustomGridView.HideEdit;
begin
  if FEdit <> nil then
  begin
    FEditCell := GridCell(-1, -1);
    FEdit.Hide;
  end;
end;

procedure TCustomGridView.HideFocus;
begin
  if IsFocusAllowed then PaintFocus;
end;

procedure TCustomGridView.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_LEFT: SetCursor(GetCursorCell(CellFocused, goLeft), True, True);
    VK_RIGHT: SetCursor(GetCursorCell(CellFocused, goRight), True, True);
    VK_UP: SetCursor(GetCursorCell(CellFocused, goUp), True, True);
    VK_DOWN: SetCursor(GetCursorCell(CellFocused, goDown), True, True);
    VK_PRIOR: SetCursor(GetCursorCell(CellFocused, goPageUp), True, True);
    VK_NEXT: SetCursor(GetCursorCell(CellFocused, goPageDown), True, True);
    VK_HOME: SetCursor(GetCursorCell(CellFocused, goHome), True, True);
    VK_END: SetCursor(GetCursorCell(CellFocused, goEnd), True, True);
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TCustomGridView.KeyPress(var Key: Char);
begin
  { ��������� �� ��������� }
  inherited KeyPress(Key);
  { ����� ENTER - ���������� ������ �����, ���� ����� }
  if Key = #13 then
  begin
    Key := #0;
    { ���� �� �������������� }
    if Editing then
    begin
      { ��������� ����� }
      UpdateEditText;
      { ����� ������ }
      if not AlwaysEdit then HideEdit;
    end
    else
      { ���������� ������ ����� }
      if not AlwaysEdit then ShowEdit;
  end;
  { ����� ESC - ��������� ������ ����� }
  if Key = #27 then
  begin
    Key := #0;
    { ����� ������ }
    if Editing and (not AlwaysEdit) then HideEdit;
  end;
end;

procedure TCustomGridView.Loaded;
begin
  inherited Loaded;
  { ����������� ��������� }
  UpdateHeader;
  UpdateColors;
  UpdateFonts;
  UpdateEdit(False);
  { ���� ������ ������ ������ }
  CellFocused := GetCursorCell(CellFocused, goFirst);
end;

procedure TCustomGridView.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  S: TGridHeaderSection;
  I, W: Integer;
  C: TGridCell;
begin
  { ������������� ����� �� ���� }
  if not AcquireFocus then
  begin
    MouseCapture := False;
    Exit;
  end;
  { ��������� ����� ���������� ������ }
  if (Button = mbLeft) or ((Button = mbRight) and RightClickSelect) then
    { ���� ����� � ������ }
    if PtInRect(GetGridRect, Point(X, Y)) then
    begin
      C := GetCellAt(X, Y);
      { �� ������ �� � ����� � ������ }
      if IsCellEmpty(C) then
      begin
        { ����� ��������� ������� }
        SetCursor(CellFocused, False, False);
      end
      { ��������� � ����-�� }
      else
      begin
        { �������� ������ }
        SetCursor(C, True, True);
        CellClick(C, Shift, X, Y);
        { ���� ������ � ������� - ��������� ������ �������������� }
        if (Shift = [ssLeft, ssDouble]) and IsCellEqual(C, CellFocused) and AllowEdit then
        begin
          ShowEdit;
          if Editing then Exit;
        end;
      end;
    end;
  { ����� ������� }
  if Button = mbLeft then
  begin
    { ������� ������ ��������� ������� ������� }
    if PtInRect(GetHeaderRect, FHitTest) then
    begin
      if ShowHeader then
      begin
        { ������ �� ������ �� ���� ������ ��������� }
        S := GetResizeSection(X, Y);
        if S <> nil then
        begin
          if ssDouble In Shift then
          begin
            { ������������� ������ ������� ������ ������������ ������ ������ }
            I := S.Column;
            if I < Columns.Count then
            begin
              W := GetColumnMaxWidth(I);
              ColumnResize(I, W);
              Columns[I].Width := W;
            end;
          end
          else
            { �������� ��������� ������� }
            StartColResize(S, X, Y);
          { �� ������� ������ }
          Exit;
        end;
      end;
    end;
  end;
  { ������ ������� }
  if Button = mbRight then
    { ���� ���� ��������� ������� - ���������� }
    if FColResizing then
    begin
      { ���������� ��������� }
      StopColResize(True);
      { �� ������� ������ }
      Exit;
    end;
  { ���������� �� ��������� }
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TCustomGridView.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  { ���� ���� ��������� ������� - ���������� }
  if FColResizing then
  begin
    { ���������� ��������� ������� ������� }
    StepColResize(X, Y);
    { �� ������� ������ }
    Exit;
  end;
  { ���������� �� ��������� }
  inherited MouseMove(Shift, X, Y);
end;

procedure TCustomGridView.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  { ���� ���� ��������� ������� - ����������� }
  if FColResizing then
  begin
    { ����������� ��������� ������� ������� }
    StopColResize(False);
    { �� ������� ������ }
    Exit;
  end;
  { ���������� �� ��������� }
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TCustomGridView.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FImages) then Images := nil;
end;

procedure TCustomGridView.Paint;
begin
  { ��������� }
  if ShowHeader and RectVisible(Canvas.Handle, GetHeaderRect) then
  begin
    { ������������� ����� }
    PaintHeaders(True);
    { �������� ������������� �������������� ��������� }
    with GetHeaderRect do
      ExcludeClipRect(Canvas.Handle, 0, Top, GetFixedWidth, Bottom);
    { ������� ����� }
    PaintHeaders(False);
    { �������� ������������� ��������� }
    with GetHeaderRect do
      ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
  end;
  { ���� ������ � ����� }
  PaintFreeField;
  { ������������� ������ }
  if (Fixed.Count > 0) and RectVisible(Canvas.Handle, GetFixedRect) then
  begin
    { ������ }
    PaintFixed;
    { �������� ������������� ������������� }
    with GetFixedRect do
      ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
  end;
  { ������� ������ }
  if (VisSize.Col > 0) and (VisSize.Row > 0) then
  begin
    { ����� }
    if GridLines then PaintGridLines;
    { ������ }
    PaintCells;
    { ������������� ������ }
    if IsFocusAllowed then
    begin
      PaintFocus;
    end;
  end;
  { ����� ��������� ������ ������� }
  if FColResizing and (FColResizeCount > 0) then PaintResizeLine;
end;

function GetRGBColor(Value: TColor): DWORD;
begin
  Result := ColorToRGB(Value);
  case Result of
    clNone: Result := CLR_NONE;
    clDefault: Result := CLR_DEFAULT;
  end;
end;

procedure TCustomGridView.PaintCell(Cell: TGridCell; Rect: TRect);
const
  DS: array[Boolean] of Longint = (ILD_NORMAL, ILD_SELECTED);
var
  DefDraw: Boolean;
  I, X, Y: Integer;
  IW, IH: Integer;
  IDS: Longint;
  BKC, BLC: DWORD;
  R: TRect;
  C: TColor;
  H: Boolean;
begin
  { ������������� ����� � ����� ������ }
  GetCellColors(Cell, Canvas);
  { ������� ���� ����� �� ������ ����� ����� }
  if GridLines then
  begin
    Dec(Rect.Right, FGridLineWidth);
    Dec(Rect.Bottom, FGridLineWidth);
  end;
  { ��������� ������������ }
  DefDraw := True;
  try
    if Assigned(FOnDrawCell) then FOnDrawCell(Self, Cell, Rect, DefDraw);
  except
    Application.HandleException(Self);
  end;
  { ��������� �� ��������� }
  if DefDraw then
  begin
    { �������� ����� �������� }
    I := -1;
    if Assigned(Images) then I := GetCellImage(Cell);
    { ������ �������� }
    if I <> -1 then
    begin
      { �������� ������������� �������� }
      R.Left := Rect.Left;
      R.Top := Rect.Top;
      R.Right := R.Left + (Images.Width + 2);
      R.Bottom := Rect.Bottom;
      { ��������� ��� }
      if R.Right > Rect.Right then R.Right := Rect.Right;
      { ������ }
      with Canvas do
      begin
        { �������� ������� ������ ���������� ������ }
        H := (RowSelect and (Cell.Col = Fixed.Count) and (Cell.Row = CellFocused.Row)) or (not RowSelect and IsCellEqual(Cell, CellFocused));
        { ���������� ���� ���� ������ }
        C := Brush.Color;
        { ������������� ���� ���� �������� }
        if H then Brush.Color := Color;
        { �������� ��� }
        FillRect(R);
        { ��������� �������� }
        X := R.Right - Images.Width;
        if X < R.Left + 2 then X := R.Left + 2;
        Y := R.Top;
        { ������ �������� (���������� ��� ��������� �������� ����� �������) }
        IW := Images.Width;
        if X + IW > R.Right then IW := R.Right - X;
        IH := Images.Height;
        if Y + IH > R.Bottom then IH := R.Bottom - Y;
        { ����� � ������� ����� �������� }
        IDS := DS[IsCellFocused(Cell) and CellSelected and Focused and H];
        BKC := GetRGBColor(Images.BkColor);
        BLC := GetRGBColor(Images.BlendColor);
        { ������ �������� }
        ImageList_DrawEx(Images.Handle, I, Canvas.Handle, X, Y, IW, IH, BKC, BLC, IDS);
        { ��������������� ���� ���� ������ }
        Brush.Color := C;
      end;
    end;
    { ������� ��������� ������ ����� }
    if not (IsCellEqual(Cell, FEditCell) and (not IsFocusAllowed)) then
    begin
      { �������� ������������� ������ }
      R := Rect;
      { ��������� �������� }
      if I <> -1 then Inc(R.Left, Images.Width + 2);
      if R.Left > R.Right then R.Left := R.Right;
      { ������ ����� }
      with Canvas do
      begin
        { �������� ���� ��� ������� }
        FillRect(R);
        { ������� ����� }
        PaintCellText(Cell, R, Canvas);
      end;
    end;
    { ������� ������������� ����� }
    if Cell.Col < Fixed.Count then
    begin
      { ��������������� ���� ��������������, ����������� ����� }
      if GridLines then
      begin
        Inc(Rect.Right, FGridLineWidth);
        Inc(Rect.Bottom, FGridLineWidth);
      end;
      { ������� ����� ������, ���� ���� ����� }
      if GridLines then
        with Canvas do
        begin
          Pen.Color := clBtnShadow;
          MoveTo(Rect.Left, Rect.Bottom - 2);
          LineTo(Rect.Right, Rect.Bottom - 2);
          Pen.Color := clBtnHighlight;
          MoveTo(Rect.Left, Rect.Bottom - 1);
          LineTo(Rect.Right, Rect.Bottom - 1);
        end;
      { ������� ������ ������, ���� ���� ����� ��� ��������� ������� }
      if GridLines or (Cell.Col = Fixed.Count - 1) then
      begin
        { �������� ��� ������� ������ }
        I := Ord(Cell.Col < Fixed.Count - 1);
        { ������� ������ }
        with Canvas do
        begin
          Pen.Color := clBtnShadow;
          MoveTo(Rect.Right - 2, Rect.Top);
          LineTo(Rect.Right - 2, Rect.Bottom - I);
          Pen.Color := clBtnHighlight;
          MoveTo(Rect.Right - 1, Rect.Top);
          LineTo(Rect.Right - 1, Rect.Bottom - I);
        end;
      end;
    end;
  end;
end;

procedure TCustomGridView.PaintCells;
var
  I, J: Integer;
  L, T, W: Integer;
  R: TRect;
  C: TGridCell;
begin
  { ����� � ������� ������� ������� ����� }
  L := GetColumnsWidth(0, VisOrigin.Col - 1) + GetGridOrigin.X;
  T := GetRowsHeight(0, VisOrigin.Row - 1) + GetGridOrigin.Y;
  { �������������� ������� ������� }
  R.Bottom := T;
  { ���������� ������ }
  for J := 0 to FVisSize.Row - 1 do
  begin
    { ������� ������������� �� ��������� }
    R.Top := R.Bottom;
    R.Bottom := R.Bottom + Rows.Height;
    { �������������� ����� ������� }
    R.Right := L;
    { ��������� ������� }
    for I := 0 to FVisSize.Col - 1 do
    begin
      { ������ � �� ������ }
      C := GridCell(VisOrigin.Col + I, VisOrigin.Row + J);
      W := Columns[C.Col].Width;
      { ������ ������ ������� ������ }
      if W > 0 then
      begin
        { ������� ������������� �� ����������� }
        R.Left := R.Right;
        R.Right := R.Right + W;
        { ������ ������ }
        if RectVisible(Canvas.Handle, R) then PaintCell(C, R);
      end;
    end;
  end;
end;

procedure TCustomGridView.PaintCellText(Cell: TGridCell; Rect: TRect; Canvas: TCanvas);
var
  T: string;
  P: TDrawTextParams;
  F, X, Y, A: Integer;
begin
  { �������� ����� ������ }
  T := GetCellText(Cell);
  { ������� ����� }
  if Columns[Cell.Col].MultiLine or EndEllipsis then
  begin
    { ��������� ������ ������ }
    FillChar(P, SizeOf(P), 0);
    P.cbSize := SizeOf(P);
    P.iLeftMargin := GetCellBorder(Cell);
    P.iRightMargin := 6;
    { �������� ������ }
    F := DT_NOPREFIX;
    { �������������� ������������ }
    case Columns[Cell.Col].Alignment of
      taLeftJustify: F := F or DT_LEFT;
      taCenter: F := F or DT_CENTER;
      taRightJustify: F := F or DT_RIGHT;
    end;
    { ������������ ������������ }
    if not Columns[Cell.Col].MultiLine then
    begin
      { �������������� ������������ }
      F := F or DT_SINGLELINE or DT_VCENTER;
      { ��������� �� ����� }
      if Columns[Cell.Col].Alignment = taLeftJustify then F := F or DT_END_ELLIPSIS
    end;
    { ������� ����� }
    DrawTextEx(Canvas.Handle, PChar(T), Length(T), Rect, F, @P);
  end
  else
  begin
    { �������� �� ����������� }
    case Columns[Cell.Col].Alignment of
      taCenter:
        begin
          X := GetCellBorder(Cell) + (Rect.Right - Rect.Left) div 2;
          A := TA_CENTER;
        end;
      taRightJustify:
        begin
          X := (Rect.Right - Rect.Left) - 6;
          A := TA_RIGHT;
        end;
      else
        begin
          X := GetCellBorder(Cell);
          A := TA_LEFT;
        end;
    end;
    { �������� �� ��������� }
    Y := ((Rect.Bottom - Rect.Top) - Abs(Canvas.TextHeight(T))) div 2;
    { ����������� ����� ������ }
    with Canvas do
    begin
      SetTextAlign(Handle, A);
      TextRect(Rect, Rect.Left + X, Rect.Top + Y, T);
      SetTextAlign(Handle, TA_LEFT);
    end;
  end;
end;

procedure TCustomGridView.PaintFixed;
var
  I, J, W: Integer;
  R: TRect;
  C: TGridCell;
begin
  { ������������� ������ }
  R.Bottom := GetRowsHeight(0, VisOrigin.Row - 1) + GetGridOrigin.Y;
  for J := 0 to FVisSize.Row - 1 do
  begin
    R.Top := R.Bottom;
    R.Bottom := R.Bottom + Rows.Height;
    R.Right := 0;
    for I := 0 to Fixed.Count - 1 do
    begin
      C := GridCell(I, VisOrigin.Row + J);
      W := Columns[C.Col].Width;
      if W > 0 then
      begin
        R.Left := R.Right;
        R.Right := R.Right + W;
        if RectVisible(Canvas.Handle, R) then PaintCell(C, R);
      end;
    end;
  end;
  { ������� ������ }
  R.Left := 0;
  R.Right := GetColumnsWidth(0, Fixed.Count - 1);
  R.Top := GetRowsHeight(0, VisOrigin.Row + FVisSize.Row - 1) + GetGridOrigin.Y;
  R.Bottom := GetGridRect.Bottom;
  with Canvas do
  begin
    Pen.Color := clBtnShadow;
    MoveTo(R.Right - 2, R.Top - 1);
    LineTo(R.Right - 2, R.Bottom);
    Pen.Color := clBtnHighlight;
    MoveTo(R.Right - 1, R.Bottom - 1);
    LineTo(R.Right - 1, R.Top - 1);
  end;
  { ����� ��������� ������ ������� }
  if FColResizing and (FColResizeCount > 0) then PaintResizeLine;
end;

procedure TCustomGridView.PaintFocus;
var
  R: TRect;
begin
  { � ����� �� ����� }
  if ShowFocusRect and Focused and (VisSize.Row > 0) then
  begin
    { ������������� ������ }
    R := GetFocusRect;
    { ��������� ����� }
    if GridLines then
    begin
      Dec(R.Right, FGridLineWidth);
      Dec(R.Bottom, FGridLineWidth);
    end;
    { ����� }
    GetCellColors(CellFocused, Canvas);
    { ������ }
    with Canvas do
    begin
      { �������� ����� ��� ��������� � ������������� }
      with GetHeaderRect do ExcludeClipRect(Handle, Left, Top, Right, Bottom);
      with GetFixedRect do ExcludeClipRect(Handle, Left, Top, Right, Bottom);
      { ����� }
      DrawFocusRect(R);
    end;
  end;
end;

procedure TCustomGridView.PaintFreeField;
var
  X, Y: Integer;
  R: TRect;
begin
  { ���� ������ }
  if VisSize.Col = 0 then
    X := GetColumnRect(VisOrigin.Col).Left
  else
    X := GetColumnRect(VisOrigin.Col + VisSize.Col - 1).Right;
  { ����� �� ��� }
  if X < ClientWidth then
  begin
    R := GetGridRect;
    R.Left := X;
    R.Right := ClientWidth;
    with Canvas do
    begin
      Brush.Color := Color;
      FillRect(R);
    end;
  end;
  { ���� ����� }
  if VisSize.Row = 0 then
    Y := GetRowRect(VisOrigin.Row).Top
  else
    Y := GetRowRect(VisOrigin.Row + VisSize.Row - 1).Bottom;
  { ����� �� ��� }
  if Y < ClientHeight then
  begin
    { ��� �������������� }
    R := GetGridRect;
    R.Right := GetFixedWidth;
    R.Top := Y;
    R.Bottom := ClientHeight;
    with Canvas do
    begin
      Brush.Color := Fixed.Color;
      FillRect(R);
    end;
    { ��� �������� }
    R := GetGridRect;
    R.Left := GetFixedWidth;
    R.Top := Y;
    R.Bottom := ClientHeight;
    with Canvas do
    begin
      Brush.Color := Color;
      FillRect(R);
    end;
  end;
end;

type
  PIntArray = ^TIntArray;
  TIntArray = array[0..MaxListSize - 1] of Integer;

procedure FillDWord(var Dest; Count, Value: Integer); register;
asm
  XCHG  EDX, ECX
  PUSH  EDI
  MOV   EDI, EAX
  MOV   EAX, EDX
  REP   STOSD
  POP   EDI
end;

procedure TCustomGridView.PaintGridLines;
const
  LineColors: array[Boolean] of TColor = (clSilver, clGray);
var
  PointsList: PIntArray;
  PointCount: Integer;
  StrokeList: PIntArray;
  StrokeCount: Integer;
  I: Integer;
  L, R, T, B, X, Y: Integer;
  Index: Integer;
begin
  { ��������� ���������� ����� ����� }
  StrokeCount := FVisSize.Col + FVisSize.Row;
  PointCount := StrokeCount * 2;
  { �������� ������ ��� ����� }
  StrokeList := AllocMem(StrokeCount * SizeOf(Integer));
  PointsList := AllocMem(PointCount * SizeOf(TPoint));
  { ������������� ������� ���������� ����� ��������� }
  FillDWord(StrokeList^, StrokeCount, 2);
  { ����� ������������ ����� }
  T := GetGridRect.Top;
  B := GetRowsHeight(0, VisOrigin.Row + FVisSize.Row - 1) + GetGridOrigin.Y;
  X := GetColumnsWidth(0, VisOrigin.Col - 1) + GetGridOrigin.X;
  for I := 0 to FVisSize.Col - 1 do
  begin
    X := X + Columns[VisOrigin.Col + I].Width;
    Index := I * 4;
    PointsList^[Index + 0] := X - 1;
    PointsList^[Index + 1] := T;
    PointsList^[Index + 2] := X - 1;
    PointsList^[Index + 3] := B;
  end;
  { ����� �������������� ����� }
  L := GetGridRect.Left + GetFixedWidth;
  R := GetColumnsWidth(0, VisOrigin.Col + VisSize.Col - 1) + GetGridOrigin.X;
  Y := GetRowsHeight(0, VisOrigin.Row - 1) + GetGridOrigin.Y;
  for I := 0 to FVisSize.Row - 1 do
  begin
    Y := Y + Rows.Height;
    Index := FVisSize.Col * 4 + I * 4;
    PointsList^[Index + 0] := L;
    PointsList^[Index + 1] := Y - 1;
    PointsList^[Index + 2] := R;
    PointsList^[Index + 3] := Y - 1;
  end;
  { ������ }
  with Canvas do
  begin
    Pen.Color := LineColors[ColorToRGB(Color) = clSilver];
    Pen.Width := FGridLineWidth;
    PolyPolyLine(Handle, PointsList^, StrokeList^, StrokeCount);
  end;
  { ����������� ������ }
  FreeMem(PointsList);
  FreeMem(StrokeList);
end;

procedure TCustomGridView.PaintHeader(Section: TGridHeaderSection; Rect: TRect);
var
  DefDraw: Boolean;
  F: Integer;
  P: TDrawTextParams;
  T: string;
  R: TRect;
begin
  { ������������� ���� � ����� ������ }
  GetHeaderColors(Section, Canvas);
  { ��������� ������������ }
  DefDraw := True;
  try
    if Assigned(FOnDrawHeader) then FOnDrawHeader(Self, Section, Rect, DefDraw);
  except
    Application.HandleException(Self);
  end;
  { ��������� �� ��������� }
  if DefDraw then
  begin
    { �������� ����� ��������� }
    T := Section.Caption;
    { ������ }
    with Canvas do
    begin
      { ������� }
      FillRect(Rect);
      { ��������� ������ ������ }
      FillChar(P, SizeOf(P), 0);
      P.cbSize := SizeOf(P);
      P.iLeftMargin := 6;
      P.iRightMargin := 6;
      { ������������ }
      F := DT_END_ELLIPSIS or DT_NOPREFIX;
      case Section.Alignment of
        taLeftJustify: F := F or DT_LEFT;
        taRightJustify: F := F or DT_RIGHT;
        taCenter: F := F or DT_CENTER;
      end;
      case Section.WordWrap of
        False: F := F or 0;
        True: F := F or DT_WORDBREAK;
      end;
      { �������� ������������� ����� }
      R := Rect;
      DrawTextEx(Handle, PChar(T), Length(T), R, F or DT_CALCRECT, @P);
      OffsetRect(R, 0, ((Rect.Bottom - Rect.Top) - (R.Bottom - R.Top)) div 2);
      R.Left := Rect.Left;
      R.Right := Rect.Right;
      { ������� ����� }
      DrawTextEx(Handle, PChar(T), Length(T), R, F, @P);
      { ������� ����� }
      Pen.Color := clBtnShadow;
      MoveTo(Rect.Left, Rect.Bottom - 2);
      LineTo(Rect.Right - 1, Rect.Bottom - 2);
      Pen.Color := clBtnHighlight;
      MoveTo(Rect.Left, Rect.Bottom - 1);
      LineTo(Rect.Right - 2, Rect.Bottom - 1);
      { ������� ������ }
      Pen.Color := clBtnShadow;
      MoveTo(Rect.Right - 2, Rect.Top - 2);
      LineTo(Rect.Right - 2, Rect.Bottom - 1);
      Pen.Color := clBtnHighlight;
      MoveTo(Rect.Right - 1, Rect.Top - 1);
      LineTo(Rect.Right - 1, Rect.Bottom - 1);
    end;
  end;
end;

procedure TCustomGridView.PaintHeaders(DrawFixed: Boolean);
var
  R: TRect;
begin
  { ������������ }
  if DrawFixed then
  begin
    R.Left := 0;
    R.Right := Header.Width;
  end
  else
  begin
    R.Left := GetGridOrigin.X;
    R.Right := R.Left + Header.Width;
  end;
  R.Top := 0;
  R.Bottom := Header.Height + 1;
  PaintHeaderSections(Header.Sections, DrawFixed, R);
  { ���������� ����� }
  if DrawFixed then
  begin
    R.Left := Header.Width;
    R.Right := GetFixedWidth
  end
  else
  begin
    R.Left := GetGridOrigin.X + Header.Width;
    R.Right := Width;
  end;
  with Canvas do
  begin
    Brush.Color := Header.Color;
    FillRect(R);
  end;
  { ����� ������� ����� }
  if DrawFixed then
  begin
    R.Left := 0;
    R.Right := GetFixedWidth;
  end
  else
  begin
    R.Left := GetFixedWidth;
    R.Right := Width;
  end;
  R.Top := 0;
  R.Bottom := Header.Height;
  with Canvas do
  begin
    Pen.Color := clBtnShadow;
    MoveTo(R.Left, R.Bottom - 1);
    LineTo(R.Right, R.Bottom - 1);
    Pen.Color := clBtnHighlight;
    MoveTo(R.Left, R.Bottom);
    LineTo(R.Right, R.Bottom);
  end;
  { ����� ��������� ������ ������� }
  if FColResizing and (FColResizeCount > 0) then PaintResizeLine;
end;

procedure TCustomGridView.PaintHeaderSections(Sections: TGridHeaderSections; AllowFixed: Boolean; Rect: TRect);
var
  I: Integer;
  S: TGridHeaderSection;
  R, SR: TRect;
begin
  { ������ �����, ���� ��� ������������� }
  if Sections.Count = 0 then Exit;
  { ������ ������������, ���� ���� }
  if RectVisible(Canvas.Handle, Rect) then
  begin
    R := Rect;
    R.Right := R.Left;
    for I := 0 to Sections.Count - 1 do
    begin
      S := Sections[I];
      { ��������������� ��������� �� ������ }
      if AllowFixed and not S.FixedSize then Exit;
      R.Left := R.Right;
      R.Right := R.Left + S.Width;
      { ������ ��������� �� ������ }
      if R.Right > R.Left then
      begin
        { ������������� }
        SR := R;
        if S.Sections.Count > 0 then
          SR.Bottom := R.Top + Header.SectionHeight;
        { ��������� (������) }
        PaintHeader(S, SR);
        { ������������ }
        if S.Sections.Count > 0 then
        begin
          { �������� ������ ������ }
          SR.Top := R.Top + Header.SectionHeight;
          SR.Bottom := R.Bottom;
          { ������������ ����� }
          PaintHeaderSections(S.Sections, AllowFixed, SR);
        end;
      end;
    end;
  end;
end;

procedure TCustomGridView.PaintResizeLine;
var
  OldPen: TPen;
begin
  OldPen := TPen.Create;
  try
    with Canvas do
    begin
      OldPen.Assign(Pen);
      try
        Pen.Style := psSolid;
        Pen.Mode := pmXor;
        Pen.Width := 1;
        with FColResizeRect do
        begin
          MoveTo(FColResizePos, Top);
          LineTo(FColResizePos, Bottom);
        end;
      finally
        Pen := OldPen;
      end;
    end;
  finally
    OldPen.Free;
  end;
end;

procedure TCustomGridView.Resize;
begin
  if Assigned(FOnResize) then FOnResize(Self);
end;

procedure TCustomGridView.SetEditText(Cell: TGridCell; var Value: string);
begin
  if Assigned(FOnSetEditText) then FOnSetEditText(Self, Cell, Value);
end;

procedure TCustomGridView.SetCursor(Cell: TGridCell; Selected, Visible: Boolean);
begin
  { ��������� ��������� }
  UpdateSelection(Cell, Selected);
  { ���������� �� ��� ������ }
  if (not IsCellEqual(FCellFocused, Cell)) or (FCellSelected <> Selected) then
  begin
    { ������ �������� }
    Changing(Cell, Selected);
    { ������������� �������� ������ }
    if not IsCellEqual(FCellFocused, Cell) then
    begin
      { ���� ���������� ������ - ��������� ����� }
      UpdateEditText;
      { ������ ������}
      HideCursor;
      FCellFocused := Cell;
      FCellSelected := Selected;
      if Visible then UpdateScrollPos;
      ShowCursor;
    end
    { ������������� ��������� }
    else if FCellSelected <> Selected then
    begin
      HideCursor;
      FCellSelected := Selected;
      ShowCursor;
    end;
    { ������ ��������� }
    Change(FCellFocused, FCellSelected);
  end;
end;

procedure TCustomGridView.ShowCursor;
begin
  if IsFocusAllowed then
  begin
    InvalidateFocus;
    Exit;
  end;
  ShowEdit;
end;

procedure TCustomGridView.ShowEdit;
begin
  UpdateEdit(True);
end;

procedure TCustomGridView.ShowEditChar(C: Char);
begin
  { ���������� ������ ����� }
  ShowEdit;
  { ��������� ������ }
  if (Edit <> nil) and Editing then PostMessage(Edit.Handle, WM_CHAR, Word(C), 0);
end;

procedure TCustomGridView.ShowFocus;
begin
  if IsFocusAllowed then PaintFocus;
end;

procedure TCustomGridView.StartColResize(Section: TGridHeaderSection; X, Y: Integer);
var
  I: Integer;
begin
  FColResizeSection := Section;
  { ��������� ��������� ������������� ��� ��������� ������� }
  with FColResizeSection do
  begin
    I := Column;
    if I <= Columns.Count - 1 then
    begin
      FColResizeRect := GetColumnRect(I);
      FColResizeRect.Left := FColResizeRect.Left{ + Columns[I].MinWidth};
    end
    else
      FColResizeRect := Bounds;
    if Section <> nil then
      FColResizeRect.Top := Level * Header.SectionHeight
    else
      FColResizeRect.Top := 0;
    FColResizeRect.Bottom := Height;
  end;
  { ��������� ����� ������� }
  FColResizePos := FColResizeRect.Right;
  FColResizeOffset := FColResizePos - X;
  { ����� �������� ������ ������� }
  FColResizeCount := 0;
  FColResizing := True;
  { ����������� ����� }
  MouseCapture := True;
end;

procedure TCustomGridView.StepColResize(X, Y: Integer);
var
  W: Integer;
begin
  { � ���� �� ��������� ������� ������� }
  if FColResizing then
  begin
    { ����� ��������� ����� }
    X := X + FColResizeOffset;
    if X < FColResizeRect.Left then X := FColResizeRect.Left;
    { ����� ������ }
    W := X - FColResizeRect.Left;
    Columnresizing(FColResizeSection.Column, W);
    X := FColResizeRect.Left + W;
    { �������� ����� }
    if FColResizePos <> X then
    begin
      { ����������� ������ ����� }
      if FColResizeCount > 0 then PaintResizeLine;
      Inc(FColResizeCount);
      { ����� ��������� ����� }
      FColResizePos := X;
      { ������ ����� ����� }
      PaintResizeLine;
    end
    else
    begin
      { ������ ����� ������ ��� }
      if FColResizeCount = 0 then PaintResizeLine;
      Inc(FColResizeCount);
    end;
  end;
end;

procedure TCustomGridView.StopColResize(Abort: Boolean);
var
  I, W: Integer;
begin
  if FColResizing then
  begin
    { ����������� ����� }
    MouseCapture := False;
    { ��������� ������� ��������� }
    FColResizing := False;
    { ���� �� ������ ���� ����������� }
    if FColResizeCount > 0 then
    begin
      { ����������� ����� }
      PaintResizeLine;
      { ������������� ������ ������� }
      if not Abort then
        with FColResizeSection do
        begin
          { ����� ������ }
          I := Column;
          W := FColResizePos - FColResizeRect.Left;
          ColumnResize(I, W);
          { ������������� ������ }
          if I < Columns.Count then Columns[I].Width := W;
          Width := W;
        end;
    end;
  end;
end;

procedure TCustomGridView.UpdateCursor;
begin
  if not IsCellAcceptCursor(CellFocused) then
    SetCursor(GetCursorCell(CellFocused, goFirst), FCellSelected, True);
end;

procedure TCustomGridView.UpdateColors;
begin
  Header.GridColorChanged(Color);
  Fixed.GridColorChanged(Color);
end;

procedure TCustomGridView.UpdateEdit(Activate: Boolean);

  procedure DoUpdateEdit;
  begin
    FEditCell := FCellFocused;
    FEdit.UpdateStyle;
    FEdit.UpdateContents;
    FEdit.SelectAll;
  end;

begin
  { � ��������� �� ������ ����� }
  if EditCanShow then
  begin
    { ������� ������ �����, ���� �� ��� }
    if FEdit = nil then
    begin
      FEdit := CreateEdit;
      FEdit.Parent := Self;
      FEdit.FGrid := Self;
      { ������������� ��������� }
      DoUpdateEdit;
    end
    else if not IsCellEqual(FEditCell, FCellFocused) then
    begin
      Activate := Activate or Editing;
      HideEdit;
      DoUpdateEdit;
    end;
    { ���������� ������ }
    if Activate then FEdit.Show;
  end
  else
    { ����� ������ }
    HideEdit;
end;

procedure TCustomGridView.UpdateFocus;
begin                                                                              
  if not ((csDesigning in ComponentState) or IsActiveControl) then
    { � ����� �� ������������� ����� }
    if TabStop and (CanFocus or (GetParentForm(Self) = nil)) then
    begin
      SetFocus;
      if AlwaysEdit and (Edit <> nil) then UpdateEdit(True);
    end;
end;

procedure TCustomGridView.UpdateFonts;
begin
  Header.GridFontChanged(Font);
  Fixed.GridFontChanged(Font);
end;

procedure TCustomGridView.UpdateHeader;
begin
  with Header do
    if AutoSynchronize or Synchronized then Sections.Synchronize(Columns);
end;

procedure TCustomGridView.UpdateScrollBars;
var
  R, P, L: Integer;
begin
  { ��������� ������������� ��������� }
  with GetGridRect do
  begin
    R := Rows.Count - 1;
    P := (Bottom - Top) div Rows.Height - 1;
    L := 1;
    with VertScrollBar do
    begin
      SetLineSize(Rows.Height);
      SetParams(R, P, L);
    end;
  end;
  { ��������� ��������������� ��������� }
  with GetGridRect do
  begin
    R := GetColumnsWidth(0, Columns.Count - 1) - GetFixedWidth;
    P := (Right - Left) - GetFixedWidth;
    L := 8;
    with HorzScrollBar do
    begin
      SetLineSize(1);
      SetParams(R, P, L);
    end;
  end;
end;

procedure TCustomGridView.UpdateScrollPos;
var
  DX, DY, X, Y: Integer;
  R: TRect;
begin
  DX := 0;
  DY := 0;
  with GetGridRect do
  begin
    { �������� �� ����������� }
    if not RowSelect then
    begin
      R := GetColumnRect(CellFocused.Col);
      X := Left + GetFixedWidth;
      if R.Right > Right then DX := Right - R.Right;
      if R.Left < X then DX := X - R.Left;
      if R.Right - R.Left > Right - X then DX := X - R.Left;
    end;
    { �������� �� ��������� }
    R := GetRowRect(CellFocused.Row);
    if R.Bottom > Bottom then DY := Bottom - R.Bottom;
    if R.Top < Top then DY := Top - R.Top;
    if R.Bottom - R.Top > Bottom - Top then DY := Top - R.Top;
    Y := DY div Rows.Height;
    if (FVisSize.Row > 1) and (DY mod Rows.Height <> 0) then Dec(Y);
    DY := Y;
  end;
  { �������� ��������� }
  with VertScrollBar do Position := Position - DY;
  with HorzScrollBar do Position := Position - DX;
end;

procedure TCustomGridView.UpdateScrollRange;
var
  I, X: Integer;
begin
  if Columns.Count > 0 then
  begin
    X := - HorzScrollBar.Position + GetFixedWidth;
    I := Fixed.Count;
    while I < Columns.Count - 1 do
    begin
      X := X + Columns[I].Width;
      if X >= GetGridRect.Left + GetFixedWidth then Break;
      Inc(I);
    end;
    FVisOrigin.Col := I;
    while I < Columns.Count - 1 do
    begin
      if X >= GetGridRect.Right then Break;
      Inc(I);
      X := X + Columns[I].Width;
    end;
    FVisSize.Col := I - FVisOrigin.Col + 1;
  end
  else
  begin
    FVisOrigin.Col := 0;
    FVisSize.Col := 0;
  end;
  if Rows.Count > 0 then
  begin
    FVisOrigin.Row := VertScrollBar.Position;
    FVisSize.Row := GetGridHeight div Rows.Height;
    if GetGridHeight mod Rows.Height > 0 then Inc(FVisSize.Row);
    if FVisSize.Row + FVisOrigin.Row  > Rows.Count then FVisSize.Row := Rows.Count - FVisOrigin.Row;
  end
  else
  begin
    FVisOrigin.Row := 0;
    FVisSize.Row := 0;
  end;
end;

procedure TCustomGridView.UpdateSelection(var Cell: TGridCell; var Selected: Boolean);
begin
  { �������� ����� ��������� }
  Selected := Selected or FAlwaysSelected;
  Selected := Selected and (Rows.Count > 0) and (Columns.Count > 0);
  { �������� ������ �� ������� }
  with Cell do
  begin
    if Col < Fixed.Count then Col := Fixed.Count;
    if Col < 0 then Col := 0;
    if Col > Columns.Count - 1 then Col := Columns.Count - 1;
    if Row < 0 then Row := 0;
    if Row > Rows.Count - 1 then Row := Rows.Count - 1;
  end;
  { ��������� ����� }
  Cell := GetCursorCell(Cell, goSelect);
end;

procedure TCustomGridView.UpdateEditText;
var
  Text: string;
begin
  if (Edit <> nil) and IsCellCorrect(EditCell) then
  try
    { ��������� ����� ����� ����� }
    Text := Edit.Text;
    try
      SetEditText(EditCell, Text);
    finally
      Edit.Text := Text;
    end;
  except
    { ���������� ������ � ������� }
    UpdateScrollPos;
    { ������ }
    raise;
  end;
end;

procedure TCustomGridView.Invalidate;
begin
  if (FLockUpdate = 0) and IsControlVisible(Self) then inherited Invalidate;
end;

procedure TCustomGridView.InvalidateCell(Cell: TGridCell);
begin
  HideFocus;
  InvalidateRect(GetCellRect(Cell));
  ShowFocus;
end;

procedure TCustomGridView.InvalidateColumn(Column: Integer);
begin
  HideFocus;
  InvalidateRect(GetColumnRect(Column));
  ShowFocus;
end;

procedure TCustomGridView.InvalidateFixed;
begin
  InvalidateRect(GetFixedRect);
end;

procedure TCustomGridView.InvalidateFocus;
var
  Rect: TRect;
begin
  Rect := GetFocusRect;
  { ����������� ������������� ������ (�� �� ���������� ��������) }
  if RowSelect then
    UnionRect(Rect, Rect, GetCellRect(GridCell(Fixed.Count, CellFocused.Row)))
  else
    UnionRect(Rect, Rect, GetCellRect(CellFocused));
  { ��������� ������������� }
  InvalidateRect(Rect);
end;

procedure TCustomGridView.InvalidateGrid;
begin
  InvalidateRect(GetGridRect);
end;

procedure TCustomGridView.InvalidateHeader;
begin
  if ShowHeader then InvalidateRect(GetHeaderRect);
end;

procedure TCustomGridView.InvalidateRect(Rect: TRect);
begin
  if (FLockUpdate = 0) then InvalidateControlRect(Self, Rect, False);
end;

procedure TCustomGridView.InvalidateRow(Row: Integer);
begin
  InvalidateRect(GetRowRect(Row));
end;

function TCustomGridView.IsActiveControl: Boolean;
var
  H: HWND;
begin
  { ���������� ���������� �� ����� }
  if (GetParentForm(Self) <> nil) and (GetParentForm(Self).ActiveControl = Self) then
  begin
    Result := True;
    Exit;
  end;
  { ���������� �� ��������� }
  H := GetFocus;
  while IsWindow(H) do
  begin
    if H = WindowHandle then
    begin
      Result := True;
      Exit;
    end;
    H := GetParent(H);
  end;
  { ������ �� ����� }
  Result := False;
end;

function TCustomGridView.IsCellAcceptCursor(Cell: TGridCell): Boolean;
begin
  { � ��������� �� ������ }
  if not IsCellCorrect(Cell) then
  begin
    Result := False;
    Exit;
  end;
  { ��������� �� ��������� }
  Result := True;
  { ����� �� ������������� ������ �� ������ }
  if Assigned(FOnCellAcceptCursor) then FOnCellAcceptCursor(Self, Cell, Result);
end;

function TCustomGridView.IsCellCorrect(Cell: TGridCell): Boolean;
var
  C, R, V: Boolean;
begin
  { ���������� ���������, ������ ������� � ������������ ������ }
  with Cell do
  begin
    C := (Col >= Fixed.Count) and (Col < Columns.Count);
    R := (Row >= 0) and (Row < Rows.Count);
    V := C and Columns[Col].Visible and (Columns[Col].Width > 0);
  end;
  { ��������� }
  Result := C and R and V;
end;

function TCustomGridView.IsCellHasImage(Cell: TGridCell): Boolean;
begin
  Result := Assigned(Images) and (GetCellImage(Cell) <> -1);
end;

function TCustomGridView.IsCellFocused(Cell: TGridCell): Boolean;
begin
  Result := ((Cell.Col = CellFocused.Col) or RowSelect) and
    (Cell.Row = CellFocused.Row) and (Cell.Col >= Fixed.Count);
end;

function TCustomGridView.IsCellVisible(Cell: TGridCell; PartialOK: Boolean): Boolean;
var
  CR, GR, R: TRect;
begin
  { �������� ������� ������ � ����� }
  CR := GetCellRect(Cell);
  GR := GetGridRect;
  { ����������� }
  Result := IntersectRect(R, CR, GR);
  { ������ ��������� }
  if not PartialOK then Result := EqualRect(R, CR);
end;

function TCustomGridView.IsColumnVisible(Column: Integer): Boolean;
var
  R: TRect;
begin
  Result := IntersectRect(R, GetColumnRect(Column), GetGridRect);
end;

function TCustomGridView.IsFocusAllowed: Boolean;
begin
  Result := RowSelect or (not (Editing or AlwaysEdit));
end;

function TCustomGridView.IsRowVisible(Row: Integer): Boolean;
var
  R: TRect;
begin
  Result := IntersectRect(R, GetRowRect(Row), GetGridRect);
end;

function TCustomGridView.GetCellAt(X, Y: Integer): TGridCell;
var
  C, R: Integer;
begin
  C := GetColumnAt(X, Y);
  R := GetRowAt(X, Y);
  if (C <> -1) and (R <> -1) then
  begin
    Result.Col := C;
    Result.Row := R;
  end
  else
  begin
    Result.Col := -1;
    Result.Row := -1;
  end;
end;

function TCustomGridView.GetCellRect(Cell: TGridCell): TRect;
begin
  IntersectRect(Result, GetColumnRect(Cell.Col), GetRowRect(Cell.Row));
end;

function TCustomGridView.GetColumnAt(X, Y: Integer): Integer;
var
  L, R: Integer;
begin
  if PtInRect(GetGridRect, Point(X, Y)) then
  begin
    Result := 0;
    { ���� ����� ������������� }
    L := 0;
    while Result <= Fixed.Count - 1 do
    begin
      R := L + Columns[Result].Width;
      if (R <> L) and (X >= L) and (X < R) then Exit;
      L := R;
      Inc(Result);
    end;
    { ���� ����� ������� }
    L := L + GetGridOrigin.X;
    while Result <= Columns.Count - 1 do
    begin
      R := L + Columns[Result].Width;
      if (R <> L) and (X >= L) and (X < R) then Exit;
      L := R;
      Inc(Result);
    end;
  end;
  Result := -1;
end;

function TCustomGridView.GetColumnMaxWidth(Column: Integer): Integer;
var
  I, W: Integer;
  C: TGridCell;
  S: string;
begin
  Result := 0;
  for I := 0 to FVisSize.Row - 1 do
  begin
    C := GridCell(Column, VisOrigin.Row + I);
    GetCellColors(C, Canvas);
    S := GetCellText(C);
    W := Canvas.TextWidth(S);
    if IsCellHasImage(C) then Inc(W, Images.Width + 2);
    if Result < W then Result := W;
  end;
  Inc(Result, 15);
end;

function TCustomGridView.GetColumnRect(Column: Integer): TRect;
begin
  if (Column < 0) or (Column >= Columns.Count) then
  begin
    Result.Left := 0;
    Result.Right := 0;
  end
  else
  begin
    if Column < Fixed.Count then
      Result.Left := GetColumnsWidth(0, Column - 1)
    else
      Result.Left := GetColumnsWidth(0, Column - 1) + GetGridOrigin.X;
    Result.Right := Result.Left + Columns[Column].Width;
  end;
  Result.Top := GetGridOrigin.Y;
  Result.Bottom := Result.Top + GetRowsHeight(0, Rows.Count - 1);
end;

function TCustomGridView.GetColumnsWidth(Index1, Index2: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := Index1 to Index2 do Inc(Result, Columns[I].Width);
end;

function TCustomGridView.GetHeaderHeight: Integer;
begin
  Result := Header.Height;
end;

function TCustomGridView.GetHeaderRect: TRect;
begin
  Result := ClientRect;
  if ShowHeader then
    Result.Bottom := Result.Top + GetHeaderHeight + 1
  else
    Result.Bottom := Result.Top;
end;

function TCustomGridView.GetFixedRect: TRect;
var
  I: Integer;
begin
  Result := GetGridRect;
  with Result do
  begin
    Right := Left;
    for I := 0 to Fixed.Count - 1 do Inc(Right, Columns[I].Width);
  end;
end;

function TCustomGridView.GetFixedWidth: Integer;
begin
  with GetFixedRect do Result := Right - Left;
end;

function TCustomGridView.GetFocusRect: TRect;
var
  C, L: Integer;
begin
  if RowSelect then
  begin
    { ������������� ������ }
    Result := GetRowRect(CellFocused.Row);
    Result.Left := Result.Left + GetFixedWidth;
  end
  else
    { ������������� ������ }
    Result := GetCellRect(CellFocused);
  { �������� ������� ����� ������� ������ }
  C := CellFocused.Col;
  if RowSelect then C := Fixed.Count;
  { ����� ��� �������� }
  if IsCellHasImage(GridCell(C, CellFocused.Row)) then
  begin
    { �������� ��������� �� ������ �������� + 2 }
    Inc(Result.Left, Images.Width + 2);
    { �������� ������� ����� ��������� ������ }
    L := GetColumnsWidth(0, C);
    { ��������� ������ ���� ���������� }
    if Result.Left > L then Result.Left := L;
  end;
end;

function TCustomGridView.GetGridHeight: Integer;
begin
  Result := ClientHeight;
  if ShowHeader then Dec(Result, GetHeaderHeight + 1);
end;

function TCustomGridView.GetGridOrigin: TPoint;
begin
  Result.X := GetGridRect.Left - HorzScrollBar.Position;
  Result.Y := GetGridRect.Top - VertScrollBar.Position * Rows.Height;
end;

function TCustomGridView.GetGridRect: TRect;
begin
  Result := ClientRect;
  if ShowHeader then Inc(Result.Top, GetHeaderHeight + 1);
end;

function TCustomGridView.GetResizeSection(X, Y: Integer): TGridHeaderSection;

  function FindSection(Sections: TGridHeaderSections; var Section: TGridHeaderSection): Boolean;
  var
    I, C: Integer;
    R: TRect;
    S: TGridHeaderSection;
  begin
    for I := Sections.Count - 1 downto 0 do
    begin
      { �������� ������ � �� ������� }
      S := Sections[I];
      C := S.Column;
      { ���� ������ ��� ������� ������� } 
      if (C > Columns.Count - 1) or Columns[C].Visible then
      begin
        { �������� ������������� ������� ��������� ������� }
        R := S.Bounds;
        with R do
        begin
          if R.Right > R.Left then Left := Right - 7;
          Right := Right + 5;
        end;
        { ������ �� ����� � ���� }
        if PtInRect(R, Point(X, Y)) then
        begin
          { ��������� ������ �� ������������� ������ }
          if (C < Columns.Count) and (Columns[C].FixedSize) then
          begin
            Section := nil;
            Result := False;
          end
          else
          begin
            Section := S;
            Result := True;
          end;
          { ������ ����� - ����� }
          Exit;
        end;
        { ���� ������ � ������������� }
        if FindSection(S.Sections, Section) then
        begin
          Result := True;
          Exit;
        end;
      end;
    end;
    Section := nil;
    Result := False;
  end;

begin
  FindSection(Header.Sections, Result);
end;

function TCustomGridView.GetRowAt(X, Y: Integer): Integer;
var
  Row: Integer;
begin
  if PtInRect(GetGridRect, Point(X, Y)) then
  begin
    Row := (Y - GetGridOrigin.Y) div Rows.Height;
    if (Row >= 0) and (Row < Rows.Count) then
    begin
      Result := Row;
      Exit;
    end;
  end;
  Result := -1;
end;

function TCustomGridView.GetRowRect(Row: Integer): TRect;
begin
  Result.Left := GetGridOrigin.X;
  Result.Right := Result.Left + GetColumnsWidth(0, Columns.Count - 1);
  Result.Top := GetRowsHeight(0, Row - 1) + GetGridOrigin.Y;
  Result.Bottom := Result.Top + Rows.Height;
end;

function TCustomGridView.GetRowsHeight(Index1, Index2: Integer): Integer;
begin
  if Index2 < Index1 then
  begin
    Result := 0;
    Exit;
  end;
  Result := (Index2 - Index1 + 1) * Rows.Height;
end;

procedure TCustomGridView.LockUpdate;
begin
  Inc(FLockUpdate);
end;

procedure TCustomGridView.UnLockUpdate(Redraw: Boolean);
begin
  Dec(FLockUpdate);
  if (FLockUpdate = 0) and Redraw then Invalidate;
end;

end.
