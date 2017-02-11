library components;

{$I stbasis.inc}     

{$R 'CmptsTsv\Html.res' 'CmptsTsv\Html.rc'}

uses
  SysUtils,
  Classes,
  Windows,
  UMainUnited in 'United\UMainUnited.pas',
  UCmptsTsvCode in 'CmptsTsv\UCmptsTsvCode.pas',
  UCmptsTsvData in 'CmptsTsv\UCmptsTsvData.pas',
  UCmptsTsvDM in 'CmptsTsv\UCmptsTsvDM.pas' {dm: TDataModule},
  tsvHint in 'United\tsvHint.pas',
  tsvStrEdit in 'CmptsTsv\tsvStrEdit.pas' {StrEditDlg},
  ZnClasses in 'CmptsTsv\ZnClasses.pas',
  ZnConsts in 'CmptsTsv\ZnConsts.pas',
  ZnEditors in 'CmptsTsv\ZnEditors.pas',
  ZnOverride in 'CmptsTsv\ZnOverride.pas',
  ZnUtils in 'CmptsTsv\ZnUtils.pas',
  Quickdir in 'CmptsTsv\Quickdir.pas' {frmQuickDirs},
  PictEdit in 'CmptsTsv\Pictedit.pas' {PictureEditDialog},
  ClipMon in 'CmptsTsv\CLIPMON.PAS',
  ClipIcon in 'CmptsTsv\CLIPICON.PAS',
  VCLUtils in 'CmptsTsv\Vclutils.pas',
  RxGraph in 'CmptsTsv\RxGraph.pas',
  MaxMin in 'CmptsTsv\MAXMIN.PAS',
  RXConst in 'CmptsTsv\RXCONST.PAS',
  RXCConst in 'CmptsTsv\RXCCONST.PAS',
  tsvOtherEdit in 'CmptsTsv\tsvOtherEdit.pas',
  FileUtil in 'CmptsTsv\Fileutil.pas',
  DateUtil in 'CmptsTsv\DATEUTIL.PAS',
  RxPrgrss in 'CmptsTsv\RXPRGRSS.PAS',
  tsvMenuEdit in 'CmptsTsv\tsvMenuEdit.pas' {fmMenuEditor},
  tsvTreeEdit in 'CmptsTsv\tsvTreeEdit.pas' {fmTreeEditor},
  tsvCollectionEdit in 'CmptsTsv\tsvCollectionEdit.pas' {fmCollectionEditor},
  IBDatabaseEdit in 'CmptsTsv\IBDatabaseEdit.pas' {IBDatabaseEditForm},
  IBDBReg in 'CmptsTsv\IBDBReg.pas',
  IBEventsEditor in 'CmptsTsv\IBEventsEditor.pas' {IBEventsEditor},
  IBTransactionEdit in 'CmptsTsv\IBTransactionEdit.pas' {IBTransactionEditForm},
  IBUpdateSQLEditor in 'CmptsTsv\IBUpdateSQLEditor.pas' {IBUpdateSQLEditForm},
  tsvFilterEdit in 'CmptsTsv\tsvFilterEdit.pas' {fmFilterEditor},
  tsvMaskEdit in 'CmptsTsv\tsvMaskEdit.pas' {fmMaskEditor},
  tsvListEdit in 'CmptsTsv\tsvListEdit.pas' {fmListEditor},
  tsvImageListEdit in 'CmptsTsv\tsvImageListEdit.pas' {fmImageListEditor},
  tsvListBox in 'United\tsvListBox.pas',
  tsvInterpreterCore in 'United\tsvInterpreterCore.pas',
  tsvInterpreterSystem in 'CmptsTsv\tsvInterpreterSystem.pas',
  tsvInterpreterClasses in 'CmptsTsv\tsvInterpreterClasses.pas',
  tsvInterpreterSysUtils in 'CmptsTsv\tsvInterpreterSysUtils.pas',
  tsvInterpreterIB in 'CmptsTsv\tsvInterpreterIB.pas',
  tsvStorage in 'CmptsTsv\tsvStorage.pas',
  tsvAngleLabel in 'CmptsTsv\tsvAngleLabel.pas',
  tsvGradient in 'CmptsTsv\tsvGradient.pas',
  LightColorPropertyEditor in 'CmptsTsv\LightColorPropertyEditor.pas',
  LightColors in 'CmptsTsv\LightColors.pas',
  UComponents in 'CmptsTsv\UComponents.pas',
  tsvInterpreterDb in 'CmptsTsv\tsvInterpreterDb.pas',
  tsvInterpreterControls in 'CmptsTsv\tsvInterpreterControls.pas',
  ToolEdit in 'CmptsTsv\RX\TOOLEDIT.PAS',
  CurrEdit in 'CmptsTsv\RX\CURREDIT.PAS',
  tsvMemDS in 'CmptsTsv\tsvMemDS.pas',
  FR_Class in 'CmptsTsv\FastReport\FR_CLASS.PAS',
  FR_View in 'CmptsTsv\FastReport\FR_View.pas' {frPreviewForm},
  FRD_Wrap in 'CmptsTsv\FastReport\FRD_WRAP.PAS',
  FR_Arg in 'CmptsTsv\FastReport\FR_Arg.pas' {frFuncArgForm},
  FR_AttrE in 'CmptsTsv\FastReport\FR_ATTRE.PAS' {frAttrEditorForm},
  FR_BarC in 'CmptsTsv\FastReport\FR_BarC.pas' {frBarCodeForm},
  FR_BndEd in 'CmptsTsv\FastReport\FR_BndEd.pas' {frBandEditorForm},
  FR_BTyp in 'CmptsTsv\FastReport\FR_BTyp.pas' {frBandTypesForm},
  FR_Chart in 'CmptsTsv\FastReport\FR_Chart.pas' {frChartForm},
  FR_ChBox in 'CmptsTsv\FastReport\FR_ChBox.pas',
  FR_Color in 'CmptsTsv\FastReport\FR_Color.pas',
  FR_Combo in 'CmptsTsv\FastReport\FR_Combo.pas',
  FR_Const in 'CmptsTsv\FastReport\FR_Const.pas',
  FR_Cross in 'CmptsTsv\FastReport\FR_Cross.pas' {frCrossForm},
  FR_Cross1 in 'CmptsTsv\FastReport\FR_Cross1.pas',
  FR_Ctrls in 'CmptsTsv\FastReport\FR_Ctrls.pas',
  FR_DBFldEditor in 'CmptsTsv\FastReport\FR_DBFldEditor.pas' {frDBFieldsEditorForm},
  FR_DBFldList in 'CmptsTsv\FastReport\FR_DBFldList.pas' {frDBFieldsListForm},
  FR_DBLookupCtl in 'CmptsTsv\FastReport\FR_DBLookupCtl.pas',
  FR_DBNewLookup in 'CmptsTsv\FastReport\FR_DBNewLookup.pas' {frDBLookupFieldForm},
  FR_DBOp in 'CmptsTsv\FastReport\FR_DBOP.PAS',
  FR_DBRel in 'CmptsTsv\FastReport\FR_DBRel.pas',
  FR_DBSet in 'CmptsTsv\FastReport\FR_DBSet.pas',
  FR_DBSQLEdit in 'CmptsTsv\FastReport\FR_DBSQLEdit.pas' {frDBSQLEditorForm},
  FR_DBUtils in 'CmptsTsv\FastReport\FR_DBUtils.pas',
  FR_DCtrl in 'CmptsTsv\FastReport\FR_DCtrl.pas',
  FR_Desgn in 'CmptsTsv\FastReport\FR_Desgn.pas' {frDesignerForm},
  FR_Dict in 'CmptsTsv\FastReport\FR_Dict.pas' {frDictForm},
  FR_Dock in 'CmptsTsv\FastReport\FR_Dock.pas' {frFloatWindow},
  FR_Dopt in 'CmptsTsv\FastReport\FR_Dopt.pas' {frDocOptForm},
  FR_DSet in 'CmptsTsv\FastReport\FR_DSET.PAS',
  FR_DsOpt in 'CmptsTsv\FastReport\FR_DsOpt.pas' {frDesOptionsForm},
  FR_E_CSV in 'CmptsTsv\FastReport\FR_E_CSV.PAS' {frCSVExportForm},
  FR_E_HTM in 'CmptsTsv\FastReport\FR_E_HTM.PAS' {frHTMExportForm},
  FR_E_RTF in 'CmptsTsv\FastReport\FR_E_RTF.PAS' {frRTFExportForm},
  FR_E_TXT in 'CmptsTsv\FastReport\FR_E_TXT.pas' {frTXTExportForm},
  FR_Edit in 'CmptsTsv\FastReport\FR_Edit.pas' {frEditorForm},
  FR_Expr in 'CmptsTsv\FastReport\FR_EXPR.PAS' {frExprForm},
  FR_Flds in 'CmptsTsv\FastReport\FR_Flds.pas' {frFieldsForm},
  FR_Flds1 in 'CmptsTsv\FastReport\FR_Flds1.pas' {frInsFieldsForm},
  FR_FmtEd in 'CmptsTsv\FastReport\FR_Fmted.pas' {frFmtForm},
  FR_Funcs in 'CmptsTsv\FastReport\fr_funcs.pas' {frFuncForm},
  FR_GEdit in 'CmptsTsv\FastReport\FR_GEdit.pas' {frGEditorForm},
  FR_GrpEd in 'CmptsTsv\FastReport\FR_GrpEd.pas' {frGroupEditorForm},
  FR_Hilit in 'CmptsTsv\FastReport\FR_HILIT.PAS' {frHilightForm},
  FR_IFlds in 'CmptsTsv\FastReport\FR_IFLDS.PAS' {frInsertFieldsForm},
  FR_Insp in 'CmptsTsv\FastReport\FR_Insp.pas' {frInspForm},
  FR_Intrp in 'CmptsTsv\FastReport\fr_intrp.pas',
  FR_LEdit in 'CmptsTsv\FastReport\FR_LEdit.pas' {frLinesEditorForm},
  FR_Newrp in 'CmptsTsv\FastReport\FR_Newrp.pas' {frTemplForm},
  FR_OLE in 'CmptsTsv\FastReport\FR_OLE.PAS' {frOleForm},
  FR_PageF in 'CmptsTsv\FastReport\FR_PageF.pas' {frPageForm},
  FR_Pars in 'CmptsTsv\FastReport\FR_Pars.pas',
  FR_pgopt in 'CmptsTsv\FastReport\FR_Pgopt.pas' {frPgoptForm},
  FR_PopupLB in 'CmptsTsv\FastReport\FR_PopupLB.pas' {frPopupListBox},
  FR_PrDlg in 'CmptsTsv\FastReport\FR_PrDlg.pas' {frPrintForm},
  FR_Prntr in 'CmptsTsv\FastReport\FR_Prntr.pas',
  FR_progr in 'CmptsTsv\FastReport\FR_PROGR.PAS' {frProgressForm},
  FR_PTabl in 'CmptsTsv\FastReport\FR_PTabl.pas',
  FR_reg in 'CmptsTsv\FastReport\FR_REG.PAS',
  FR_Restr in 'CmptsTsv\FastReport\FR_RESTR.PAS' {frRestrictionsForm},
  FR_Rich in 'CmptsTsv\FastReport\FR_Rich.pas' {frRichForm},
  FR_RRect in 'CmptsTsv\FastReport\FR_RRect.pas' {frRoundRectForm},
  FR_Shape in 'CmptsTsv\FastReport\FR_Shape.pas',
  FR_Srch in 'CmptsTsv\FastReport\FR_SRCH.PAS' {frPreviewSearchForm},
  FR_Templ in 'CmptsTsv\FastReport\FR_TEMPL.PAS' {frTemplNewForm},
  FR_Utils in 'CmptsTsv\FastReport\FR_Utils.pas',
  FR_Var in 'CmptsTsv\FastReport\FR_Var.pas' {frVarForm},
  FR_Vared in 'CmptsTsv\FastReport\FR_Vared.pas' {frVaredForm},
  FR_VBnd in 'CmptsTsv\FastReport\FR_VBnd.pas' {frVBandEditorForm},
  frBarcod in 'CmptsTsv\FastReport\frBarcod.pas',
  FRD_DB in 'CmptsTsv\FastReport\FRD_DB.PAS' {frDBPropForm},
  FRD_Flde in 'CmptsTsv\FastReport\FRD_FLDE.PAS' {frFieldsEditorForm},
  FRD_Fldl in 'CmptsTsv\FastReport\FRD_FLDL.PAS' {frFieldsListForm},
  FRD_Form in 'CmptsTsv\FastReport\FRD_FORM.PAS' {frParamsDialogForm},
  FRD_List in 'CmptsTsv\FastReport\FRD_LIST.PAS' {frDatasetsForm},
  FRD_look in 'CmptsTsv\FastReport\FRD_LOOK.PAS' {frLookupFieldForm},
  FRD_md in 'CmptsTsv\FastReport\FRD_MD.PAS' {frFieldsLinkForm},
  FRD_Mngr in 'CmptsTsv\FastReport\FRD_Mngr.pas',
  FRD_parm in 'CmptsTsv\FastReport\FRD_PARM.PAS' {frParamsForm},
  FRD_Prop in 'CmptsTsv\FastReport\FRD_PROP.PAS' {frPropForm},
  FRD_Qry in 'CmptsTsv\FastReport\FRD_QRY.PAS' {frQueryPropForm},
  FRD_Tbl in 'CmptsTsv\FastReport\FRD_TBL.PAS' {frTablePropForm},
  FR_About in 'CmptsTsv\FastReport\FR_About.pas' {frAboutForm},
  FRD_Tbl1 in 'CmptsTsv\FastReport\FRD_TBL1.PAS' {frSelectTblForm},
  RxCombos in 'CmptsTsv\RX\RXCOMBOS.PAS',
  RXCtrls in 'CmptsTsv\RX\RxCtrls.pas',
  RxRichEd in 'CmptsTsv\RX\RxRichEd.pas',
  RXClock in 'CmptsTsv\RX\RXCLOCK.PAS',
  Animate in 'CmptsTsv\RX\Animate.pas',
  RXGrids in 'CmptsTsv\RX\RXGRIDS.PAS',
  GIFCtrl in 'CmptsTsv\RX\GIFCTRL.PAS',
  RxCalc in 'CmptsTsv\RX\RXCALC.PAS',
  TimerLst in 'CmptsTsv\RX\TIMERLST.PAS',
  RxNotify in 'CmptsTsv\RX\RxNotify.pas',
  RXDBCtrl in 'CmptsTsv\RX\RXDBCTRL.PAS',
  RxLookup in 'CmptsTsv\RX\RxLookup.pas',
  DBRichEd in 'CmptsTsv\RX\DBRICHED.PAS',
  RxDBComb in 'CmptsTsv\RX\RXDBCOMB.PAS',
  RxMemDS in 'CmptsTsv\RX\RxMemDS.pas',
  tsvInterpreterVirtualTree in 'CmptsTsv\tsvInterpreterVirtualTree.pas',
  tsvInterpreterContnrs in 'CmptsTsv\tsvInterpreterContnrs.pas',
  tsvInterpreterDbCtrls in 'CmptsTsv\tsvInterpreterDbCtrls.pas',
  tsvInterpreterDbGirds in 'CmptsTsv\tsvInterpreterDbGirds.pas',
  tsvInterpreterDialogs in 'CmptsTsv\tsvInterpreterDialogs.pas',
  tsvInterpreterExtCtrls in 'CmptsTsv\tsvInterpreterExtCtrls.pas',
  tsvInterpreterForms in 'CmptsTsv\tsvInterpreterForms.pas',
  tsvInterpreterGraphics in 'CmptsTsv\tsvInterpreterGraphics.pas',
  tsvInterpreterGrids in 'CmptsTsv\tsvInterpreterGrids.pas',
  tsvInterpreterMenus in 'CmptsTsv\tsvInterpreterMenus.pas',
  tsvInterpreterStdCtrls in 'CmptsTsv\tsvInterpreterStdCtrls.pas',
  tsvInterpreterFastReport in 'CmptsTsv\tsvInterpreterFastReport.pas',
  tsvInterpreterWindows in 'CmptsTsv\tsvInterpreterWindows.pas',
  tsvInterpreterComObj in 'CmptsTsv\tsvInterpreterComObj.pas',
  tsvHintEx in 'United\tsvHintEx.pas',
  tsvInterpreterRx in 'CmptsTsv\tsvInterpreterRx.pas',
  tsvHtmlCore in 'United\tsvHtmlCore.pas',
  tsvHtmlControls in 'CmptsTsv\tsvHtmlControls.pas',
  tsvHtmlView in 'CmptsTsv\tsvHtmlView.pas' {fmHtmlView},
  tsvEntry in 'CmptsTsv\tsvEntry.pas',
  tsvInterpreterStbasis in 'CmptsTsv\tsvInterpreterStbasis.pas',
  tsvInterpreterComCtrls in 'CmptsTsv\tsvInterpreterComCtrls.pas',
  tsvVirtualDbTree in 'CmptsTsv\tsvVirtualDbTree.pas',
  StbasisSUtils in 'United\StbasisSUtils.pas',
  tsvInterpreterRTFStream in 'CmptsTsv\tsvInterpreterRTFStream.pas',
  DTDSchema in 'CmptsTsv\XML\DTDSchema.pas',
  msxml in 'CmptsTsv\XML\msxml.pas',
  msxmldom in 'CmptsTsv\XML\msxmldom.pas',
  xdom in 'CmptsTsv\XML\xdom.pas',
  XDRSchema in 'CmptsTsv\XML\XDRSchema.pas',
  XMLConst in 'CmptsTsv\XML\XMLConst.pas',
  XMLDoc in 'CmptsTsv\XML\XMLDoc.pas',
  xmldom in 'CmptsTsv\XML\xmldom.pas',
  XMLIntf in 'CmptsTsv\XML\XMLIntf.pas',
  XMLSchema99 in 'CmptsTsv\XML\XMLSchema99.pas',
  XMLSchema in 'CmptsTsv\XML\XMLSchema.pas',
  XMLSchemaTags in 'CmptsTsv\XML\XMLSchemaTags.pas',
  Types in 'CmptsTsv\XML\Types.pas',
  tsvXMLDoc in 'CmptsTsv\tsvXMLDoc.pas',
  tsvHttpSend in 'CmptsTsv\tsvHttpSend.pas',
  tsvInterpreterTsv in 'CmptsTsv\tsvInterpreterTsv.pas',
  tsvInterpreterIndy in 'CmptsTsv\tsvInterpreterIndy.pas',
  AbZipper in 'CmptsTsv\Abbrevia\source\AbZipper.pas',
  tsvInterpreterAbbrevia in 'CmptsTsv\tsvInterpreterAbbrevia.pas',
  tsvInterpreterCheckList in 'CmptsTsv\tsvInterpreterCheckList.pas',
  tsvStrings in 'United\tsvStrings.pas',
  tsvInterpreterAnyDac in 'CmptsTsv\tsvInterpreterAnyDac.pas',
  tsvRTFStream in 'CmptsTsv\tsvRTFStream.pas',
  tsvInterpreterXml in 'CmptsTsv\tsvInterpreterXml.pas';

{$R 'CmptsTsv\Res\Align.Res'}
{$R 'CmptsTsv\Res\Alignment.Res'}
{$R 'CmptsTsv\Res\BevelCut.Res'}
{$R 'CmptsTsv\Res\BevelShape.Res'}
{$R 'CmptsTsv\Res\BevelStyle.Res'}
{$R 'CmptsTsv\Res\BitBtnKind.Res'}
{$R 'CmptsTsv\Res\BorderStyle.Res'}
{$R 'CmptsTsv\Res\ButtonLayout.Res'}
{$R 'CmptsTsv\Res\CheckBoxState.Res'}
{$R 'CmptsTsv\Res\ComboBoxStyle.Res'}
{$R 'CmptsTsv\Res\DefaultMonitor.Res'}
{$R 'CmptsTsv\Res\EdgeStyle.Res'}
{$R 'CmptsTsv\Res\EditCharCase.Res'}
{$R 'CmptsTsv\Res\FormBorderStyle.Res'}
{$R 'CmptsTsv\Res\FormStyle.Res'}
{$R 'CmptsTsv\Res\LeftRightCheckBox.Res'}
{$R 'CmptsTsv\Res\LeftRightRadioButton.Res'}
{$R 'CmptsTsv\Res\ListBoxStyle.Res'}
{$R 'CmptsTsv\Res\ModalResult.Res'}
{$R 'CmptsTsv\Res\PopupAlignment.Res'}
{$R 'CmptsTsv\Res\Position.Res'}
{$R 'CmptsTsv\Res\ScrollBarKind.Res'}
{$R 'CmptsTsv\Res\ScrollStyle.Res'}
{$R 'CmptsTsv\Res\ShapeType.Res'}
{$R 'CmptsTsv\Res\StatusPanelBevel.Res'}
{$R 'CmptsTsv\Res\TabPosition.Res'}
{$R 'CmptsTsv\Res\TextLayout.Res'}
{$R 'CmptsTsv\Res\ViewStyle.Res'}
{$R 'CmptsTsv\Res\WindowState.Res'}

procedure DLLEntryPoint(dwReason: DWord);
begin
  case dwReason of
    DLL_PROCESS_ATTACH: begin
     // InitAll;
    end;
    DLL_PROCESS_DETACH: begin          
      DeInitAll;
    end;
  end;
end;

exports
  GetInfoLibrary_ name ConstGetInfoLibrary,
  RefreshLibrary_ name ConstRefreshLibrary,
  SetConnection_ name ConstSetConnection,
  GetInfoComponentsLibrary_ name ConstGetInfoComponentsLibrary,
  InitAll_ name ConstInitAll;

{$R *.RES}
  
begin
  Randomize;
  DllProc := @DLLEntryPoint;
  DLLEntryPoint(DLL_PROCESS_ATTACH);
end.

