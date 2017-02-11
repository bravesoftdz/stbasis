unit UEditOptionsRBInterfaceScript;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, RAHLEditor;

type
  TfmEditOptionsRBInterfaceScript = class(TForm)
    pnBut: TPanel;
    Panel2: TPanel;
    bibOk: TButton;
    bibCancel: TButton;
    lbName: TLabel;
    edName: TEdit;
    lbHint: TLabel;
    edHint: TEdit;
    grbCode: TGroupBox;
    pnCode: TPanel;
    procedure bibOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    function CheckFieldsFill: Boolean;
  public
    RaEditor: TRAHLEditor;
    procedure SetEditorParams(Editor: TRAHLEditor);
  end;

var
  fmEditOptionsRBInterfaceScript: TfmEditOptionsRBInterfaceScript;

implementation

uses UMainUnited;

{$R *.DFM}

function TfmEditOptionsRBInterfaceScript.CheckFieldsFill: Boolean;
begin
  Result:=true;
  if trim(edName.Text)='' then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[lbName.Caption]));
    edName.SetFocus;
    Result:=false;
    exit;
  end;
  if edHint.Visible then
   if trim(edHint.Text)='' then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[lbHint.Caption]));
    edHint.SetFocus;
    Result:=false;
    exit;
   end;
  if grbCode.Visible then
   if trim(RaEditor.Lines.Text)='' then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[grbCode.Caption]));
    RaEditor.SetFocus;
    Result:=false;
    exit;
   end;
end;

procedure TfmEditOptionsRBInterfaceScript.bibOkClick(Sender: TObject);
begin
  if not CheckFieldsFill then exit;
  ModalResult:=mrOk;
end;

procedure TfmEditOptionsRBInterfaceScript.FormCreate(Sender: TObject);
begin
  RaEditor:=TRAHLEditor.Create(nil);
  RaEditor.Parent:=pnCode;
  RaEditor.Align:=alClient;
end;

procedure TfmEditOptionsRBInterfaceScript.FormDestroy(Sender: TObject);
begin

  RaEditor.Free;
end;

procedure TfmEditOptionsRBInterfaceScript.SetEditorParams(Editor: TRAHLEditor);
begin
  if Editor=nil then exit;
  RaEditor.Colors.Assign(Editor.Colors);
  RaEditor.Font.Assign(Editor.Font);
  RaEditor.Color:=Editor.color;
  RaEditor.GutterWidth:=Editor.GutterWidth;
  RaEditor.GutterColor:=Editor.GutterColor;
  RaEditor.RightMarginVisible:=Editor.RightMarginVisible;
  RaEditor.RightMargin:=Editor.RightMargin;
  RaEditor.RightMarginColor:=Editor.RightMarginColor;
  RaEditor.SelForeColor:=Editor.SelForeColor;
  RaEditor.SelBackColor:=Editor.SelBackColor;
  RaEditor.SelBlockFormat:=Editor.SelBlockFormat;
end;

procedure TfmEditOptionsRBInterfaceScript.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Application.hint:='';
end;

end.
