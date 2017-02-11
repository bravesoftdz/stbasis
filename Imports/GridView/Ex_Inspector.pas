{
  ���������� �������������� �����������

  ��������� ������� (������� �������)

  ����� �. �������
  E-mail: roman@sar.nnov.ru
}

unit Ex_Inspector;

interface

uses
  Windows, Messages, CommCtrl, Classes, Controls, Graphics, Forms, StdCtrls,
  Math, Ex_Grid;

type

{ TInspectorEdit }

  TInspectorEdit = class(TGridEdit)
  protected
    procedure UpdateBounds; override;
    procedure UpdateColors; override;
  public
    procedure Invalidate; override;
  end;

{ TCustomInspector }

  {
    ������� ����� ��� �������� ����������� ������� �� ������
    ObjectInspector � Delphi.

    �� ����� ����� �������. ����������� ������ ������ TCustomGridView ���
    �������� �������� ���� (���� ������ �������, "����������" ����� � �.�.).
    �� ��������� �������� ��� ������� - ������� ���� ������� � �������
    ��������. ������ ��������� � ��������� ��������������.
  }

  TCustomInspector = class(TCustomGridView)
  private
    FHitTest: TPoint;
    FColUpdate: Integer;
    FTipsUpdate: Integer;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
  protected
    procedure ChangeColumns; override;
    function ColResizeAllowed(X, Y: Integer): Boolean;
    function CreateEdit: TGridEdit; override;
    procedure ColumnResizing(Column: Integer; var Width: Integer); override;
    function GetCellBorder(Cell: TGridCell): Integer; override;
    procedure GetCellColors(Cell: TGridCell; Canvas: TCanvas); override;
    procedure GetEditListBounds(Cell: TGridCell; var Rect: TRect); override;
    function GetEditRect(Cell: TGridCell): TRect; override;
    function GetTipsRect(Cell: TGridCell; MaxWidth: Integer): TRect; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    procedure PaintCell(Cell: TGridCell; Rect: TRect); override;
    procedure PaintFixed; override;
    procedure PaintFocus; override;
    procedure Resize; override;
    procedure UpdateColumns;
  public
    constructor Create(AOwner: TComponent); override;
    function GetFocusRect: TRect; override;
  end;

{ TInspector }

  TInspector = class(TCustomInspector)
  published
    property Align;
    property BorderStyle;
    property Color default clBtnFace;
    property Ctl3D;
    property EndEllipsis;
    property Font;
    property ParentColor default False;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowCellTips;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnCellClick;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEditAcceptKey;
    property OnEditButtonPress;
    property OnEditSelectNext;
    property OnEnter;
    property OnExit;
    property OnGetCellText;
    property OnGetEditList;
    property OnGetEditStyle;
    property OnGetEditText;
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

implementation

{ TInspectorEdit }

procedure TInspectorEdit.UpdateBounds;
begin
  { ���������� ��������� }
  inherited UpdateBounds;
  { ����������� ������ ������ }
  ButtonWidth := Height;
end;

procedure TInspectorEdit.UpdateColors;
begin
  { �������� ����� �� ��������� }
  inherited UpdateColors;
  { ����������� ��� � ���� ������ }
  Color := clWindow;
  Font.Color := clBtnText;
end;

procedure TInspectorEdit.Invalidate;
begin
  { ��������� ������ }
  inherited Invalidate;
  { ��������� ����� }
  if Grid <> nil then Grid.InvalidateFocus;
end;

{ TCustomInspector }

procedure TCustomInspector.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  FHitTest := ScreenToClient(SmallPointToPoint(Message.Pos));
end;

procedure TCustomInspector.WMSetCursor(var Message: TWMSetCursor);
begin
  with Message, FHitTest do
    if (HitTest = HTCLIENT) and not (csDesigning in ComponentState) then
      if ColResizeAllowed(X, Y) then
      begin
        Windows.SetCursor(Screen.Cursors[crHSplit]);
        Exit;
      end;
  inherited;
end;

constructor TCustomInspector.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  { ����� }
  Color := clBtnFace;
  { �������������� }
  RowSelect := False;
  AllowEdit := True;
  AlwaysEdit := True;
  { ������� }
  with Columns do
  begin
    { ������� ������� }
    with Add do
    begin
      FixedSize := True;
      MultiLine := False;
      ReadOnly := True;
    end;
    { ������� �������� }
    with Add do
    begin
      FixedSize := True;
      MultiLine := False;
    end;
  end;
  { �������������� � �������� ��������� }
  Header.Synchronized := True;
  ShowHeader := False;
  { ������������� }
  with Fixed do
  begin
    Count := 1;
    GridColor := True;
  end;
  { ������ ��������� }
  HorzScrollBar.Visible := False;
  { ������ }
  EndEllipsis := False;
  GridLines := False;
end;

procedure TCustomInspector.ChangeColumns;
begin
  UpdateColumns;
end;

function TCustomInspector.ColResizeAllowed(X, Y: Integer): Boolean;
begin
  Result := (Columns.Count > 0) and (X >= Columns[0].Width - 4) and (X <= Columns[0].Width);
end;

procedure TCustomInspector.ColumnResizing(Column: Integer; var Width: Integer);
begin
  if Width > ClientWidth - 35 then Width := ClientWidth - 35;
  if Width < 35 then Width := 35;
end;                                       

function TCustomInspector.GetCellBorder(Cell: TGridCell): Integer;
begin
  Result := 2;
end;

procedure TCustomInspector.GetCellColors(Cell: TGridCell; Canvas: TCanvas);
const
  FontColors: array[Boolean] of TColor = (clBtnText, clNavy);
begin
  Canvas.Brush.Color := Self.Color;
  Canvas.Font := Self.Font;
  Canvas.Font.Color := FontColors[Cell.Col = 1];
end;

procedure TCustomInspector.GetEditListBounds(Cell: TGridCell; var Rect: TRect);
begin
  { ��������� ������������ ����� }
  Dec(Rect.Left, 2);
  { ��������� �� ��������� }
  inherited GetEditListBounds(Cell, Rect);
end;

function TCustomInspector.GetEditRect(Cell: TGridCell): TRect;
begin
  { �������� ������������� ������ }
  Result := GetCellRect(Cell);
  { ��������� ������ ����� (��� CellTips ����� ������ �� ����) }
  if FTipsUpdate = 0 then Dec(Result.Bottom, 1);
end;

function TCustomInspector.GetFocusRect: TRect;
begin
  { �������� ������������� ������ }
  Result := GetRowRect(CellFocused.Row);
  { ��������� ������ }
  InflateRect(Result, 2, 2);
  Dec(Result.Bottom, 1);
end;

function TCustomInspector.GetTipsRect(Cell: TGridCell; MaxWidth: Integer): TRect;
begin
  Inc(FTipsUpdate);
  try
    { �������� ������������� ��������� }
    Result := inherited GetTipsRect(Cell, MaxWidth);
  finally
    Dec(FTipsUpdate);
  end;
end;                                                     

function TCustomInspector.CreateEdit: TGridEdit;
begin
  Result := TInspectorEdit.Create(Self);
end;

procedure TCustomInspector.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  { ������������� ����� �� ���� }
  if not AcquireFocus then
  begin
    MouseCapture := False;
    Exit;
  end;
  { ����� ������� }
  if Button = mbLeft then
  begin
    { ������� ������ ��������� ������� ������� }
    if ColResizeAllowed(X, Y) then
    begin
      { �������� ��������� ������� }
      StartColResize(Header.Sections[0], X, Y);
      { �� ������� ������ }
      Exit;
    end;
  end;
  { ���������� �� ��������� }
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TCustomInspector.Paint;
begin
  { ��������� �� ��������� }
  inherited Paint;
  { ������ ����� ������ ������ }
  PaintFocus;
end;

procedure TCustomInspector.PaintCell(Cell: TGridCell; Rect: TRect);
const
  LineColors: array[Boolean] of TColor = (clSilver, clGray);
  LineIndent: array[Boolean] of Integer = (2, 0);
begin
  { ��������� �� ��������� }
  inherited PaintCell(Cell, Rect);
  { ������� ����� ��� ����� ��� ������ }
  if Cell.Row <> CellFocused.Row then
    with Canvas do
    begin
      Pen.Color := LineColors[ColorToRGB(Color) = clSilver];
      MoveTo(Rect.Left, Rect.Bottom - 1);
      LineTo(Rect.Right - LineIndent[Cell.Col = 1], Rect.Bottom - 1);
    end;
end;

procedure TCustomInspector.PaintFixed;
begin
  { ��������� �� ��������� }
  inherited PaintFixed;
  { ������ ����� ������ ������ }
  PaintFocus;
end;

procedure TCustomInspector.PaintFocus;
var
  R: TRect;
begin
  if (Rows.Count > 0) and (IsCellVisible(CellFocused, True)) then
  begin
    R := GetFocusRect;
    DrawEdge(Canvas.Handle, R, EDGE_SUNKEN, BF_RECT);
  end;
end;

procedure TCustomInspector.Resize;
begin
  { ����������� ������� }
  UpdateColumns;
  { ��������� �� ��������� }
  inherited Resize;
end;

procedure TCustomInspector.UpdateColumns;
begin
  { � �� ���� �� ������ ��������� }
  if (FColUpdate = 0) and (Columns.Count = 2) then
  begin
    Inc(FColUpdate);
    try
      { ����������� ������ ������� �������� }
      Columns[1].Width := ClientWidth - Columns[0].Width;
      if Columns[1].Width < 35 then
      begin
        Columns[1].Width := 35;
        Columns[0].Width := ClientWidth - Columns[1].Width + 1;
      end;
      { ����������� ������ ������� ���� }
      if Columns[0].Width < 35 then Columns[0].Width := 35;
    finally
      Dec(FColUpdate);
    end;
  end;
end;

end.
