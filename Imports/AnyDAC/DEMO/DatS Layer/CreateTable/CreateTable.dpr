program CreateTable;

uses
  Forms,
  fCreateTable in 'fCreateTable.pas' {frmCreateTable},
  fMainBase in '..\..\fMainBase.pas' {frmMainBase},
  fDatSLayerBase in '..\fDatSLayerBase.pas' {frmDatSLayerBase},
  uDatSUtils in '..\..\uDatSUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCreateTable, frmCreateTable);
  Application.Run;
end.
