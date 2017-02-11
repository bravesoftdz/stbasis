unit URptPms_PriceLandClient;

interface

uses classes, Forms;

procedure RtpLandRunClient(Thread: TThread; Form, Options: TForm; sFileName, sTypeOperation: string;
                           UseStyle: Boolean; SyncOfficeId: String);

implementation

uses Windows, sysutils, controls, graphics, IBQuery, IBDatabase, Db, IBCustomDataSet, Excel97,
     UMainUnited, URptPms_Price, URptThread, UPremisesTsvData, UPremisesTsvOptions;

procedure RtpLandRunClient(Thread: TThread; Form, Options: TForm; sFileName, sTypeOperation: string;
                           UseStyle: Boolean; SyncOfficeId: String);
var
 tran: TIBTransaction;
 qrDirection,qrCityRegion: TIBQuery;
 qrPremises,qrObject: TIbQuery;
 sqls: string;
 Sh,ShMain: OleVariant;
 Wb: OleVariant;
 R: OleVariant;
 oldY,curY: Integer;
 Data: Variant;
 Row: Integer;
 TCPB: TCreateProgressBar;
 TSPBS: TSetProgressBarStatus;
 incCR,incR,incTP: Integer;
 pb1,pb2: THandle;
 oldDirectionId: Integer;
 ColumnCount: Integer;
 OldFontName: string;
 fmParent: TfmRptPms_Price;
begin
 fmParent:=TfmRptPms_Price(Form);
 ColumnCount:=fmParent.GetColumnCount;
 if ColumnCount=0 then exit;
 Excel.WorkBooks.Open(sFileName);
 wb:=Excel.WorkBooks.Item[1];
 Sh:=Wb.Sheets.Item[1];
 TRptExcelThreadPms_Price(THread).Synchronize(TRptExcelThreadPms_Price(THread).GetPlantName);
 //Sh.Range[Sh.Cells[1,1],Sh.Cells[1,1]].Value:=TRptExcelThreadPms_Price(THread).FPlantName;
 R:=Sh.Range[Sh.Cells[1,ColumnCount],Sh.Cells[1,ColumnCount]];
 R.Value:=sTypeOperation+' - '+FormatDateTime(fmtCurDate,fmParent.curdate);
 R.HorizontalAlignment:=xlRight;
 R.Font.Bold:=true;


 if IscnppPhoneName then begin
   OldFontName:=Sh.Range[Sh.Cells[1,IndcnppPhoneName],Sh.Cells[1,IndcnppPhoneName]].Font.Name;
   Sh.Columns[IndcnppPhoneName].Font.Name:=fmOptions.edPhoneColumn.Font.Name;
   Sh.Range[Sh.Cells[2,IndcnppPhoneName],Sh.Cells[2,IndcnppPhoneName]].Font.Name:=Sh.Range[Sh.Cells[2,1],Sh.Cells[2,1]].Font.Name;
   Sh.Range[Sh.Cells[1,IndcnppPhoneName],Sh.Cells[1,IndcnppPhoneName]].Font.Name:=OldFontName;
 end;

 qrDirection:=TIBQuery.Create(nil);
 qrCityRegion:=TIBQuery.Create(nil);
 qrPremises:=TIBQuery.Create(nil);
 qrObject:=TIBQuery.Create(nil);
 tran:=TIBTransaction.Create(nil);
 Screen.Cursor:=crHourGlass;
 try
   tran.AddDatabase(IBDB);
   IBDB.AddTransaction(tran);
   qrDirection.Transaction:=tran;
   qrDirection.Database:=IBDB;
   qrCityRegion.Transaction:=tran;
   qrCityRegion.Database:=IBDB;
   qrPremises.Transaction:=tran;
   qrPremises.Database:=IBDB;
   qrObject.Transaction:=tran;
   qrObject.Database:=IBDB;
   tran.Active:=true;

   sqls:=SQLRbkPms_Direction+
         ' where pms_direction_id in (select p.pms_direction_id from pms_premises p '+
         ' where p.datearrivals>='+QuotedStr(DateToStr(fmParent.dtpDateFrom.DateTime))+
         ' and p.datearrivals<='+QuotedStr(DateToStr(fmParent.dtpDateTo.DateTime))+
         ' and p.typeoperation='+inttostr(3)+fmParent.GetRecyledFilter+fmParent.GetStationFilter+')'+
         ' order by sortnumber';
   qrDirection.SQL.Add(sqls);
   qrDirection.Active:=true;
   qrDirection.Last;
   qrDirection.First;

   sqls:=SQLRbkPms_City_Region+
         ' where pms_city_region_id in (select p.pms_city_region_id from pms_premises p '+
         ' where p.datearrivals>='+QuotedStr(DateToStr(fmParent.dtpDateFrom.DateTime))+
         ' and p.datearrivals<='+QuotedStr(DateToStr(fmParent.dtpDateTo.DateTime))+
         ' and p.typeoperation='+inttostr(3)+fmParent.GetRecyledFilter+fmParent.GetStationFilter+')'+
         ' order by sortnumber';
   qrCityRegion.SQL.Add(sqls);
   qrCityRegion.Active:=true;
   qrCityRegion.Last;
   qrCityRegion.First;

   sqls:=SQLRbkPms_Object+
         ' where pms_object_id in (select p.pms_object_id from pms_premises p '+
         ' where p.datearrivals>='+QuotedStr(DateToStr(fmParent.dtpDateFrom.DateTime))+
         ' and p.datearrivals<='+QuotedStr(DateToStr(fmParent.dtpDateTo.DateTime))+
         ' and p.typeoperation='+inttostr(3)+fmParent.GetRecyledFilter+fmParent.GetStationFilter+')'+
         ' order by sortnumber';
   qrObject.SQL.Add(sqls);
   qrObject.Active:=true;
   qrObject.Last;
   qrObject.First;

   ShMain:=Sh;
   incTP:=1;


   curY:=4;
   Sh:=ShMain;
   Sh.Name:='�����';
   oldDirectionId:=-1;

   FillChar(TCPB,SizeOf(TCPB),0);
   TCPB.Min:=0;
   TCPB.Max:=qrDirection.RecordCount;
   TCPB.Color:=clNavy;
   pb1:=_CreateProgressBar(@TCPB);
   incCR:=0;
   FillChar(TCPB,SizeOf(TCPB),0);
   TCPB.Min:=0;
   TCPB.Max:=qrCityRegion.RecordCount;
   TCPB.Color:=clBlue;
   pb2:=_CreateProgressBar(@TCPB);
   try
     qrDirection.First;
     while not qrDirection.Eof do begin
       if TRptExcelThreadPms_Price(THread).Terminated then exit;
       incR:=0;
       qrCityRegion.First;
       while not qrCityRegion.Eof do begin
         if TRptExcelThreadPms_Price(THread).Terminated then exit;
         sqls:=SQLRbkPms_PremisesRpt+
               ' where p.pms_object_id=1 and p.pms_salestatus_id<>44 and p.datearrivals>='+QuotedStr(DateToStr(fmParent.dtpDateFrom.DateTime))+
               ' and p.datearrivals<='+QuotedStr(DateToStr(fmParent.dtpDateTo.DateTime))+
               ' and p.pms_direction_id='+qrDirection.FieldByname('pms_direction_id').AsString+
               ' and p.pms_city_region_id='+qrCityRegion.FieldByname('pms_city_region_id').AsString+
               ' and p.typeoperation='+inttostr(3)+
               fmParent.GetRecyledFilter+
               fmParent.GetStationFilter+
               fmParent.GetOfficeFilter+
               fmParent.GetOrder;
                 
         qrPremises.SQL.Clear;
         qrPremises.SQL.Add(sqls);
         qrPremises.Active:=true;
         qrPremises.Last;
         if not qrPremises.IsEmpty then begin
           if oldDirectionId<>qrDirection.FieldByname('pms_direction_id').AsInteger then begin
             inc(curY);
             R:=Sh.Range[Sh.Cells[curY,1],Sh.Cells[curY,ColumnCount]];
             R.Merge;
             R.HorizontalAlignment:=xlCenter;
             R.VerticalAlignment:=xlCenter;
             R.Font.Size:=16;
             R.Font.Bold:=true;
             R.Value:=qrDirection.FieldByname('note').AsString;
             R.Rows.AutoFit;
           end;
           oldDirectionId:=qrDirection.FieldByname('pms_direction_id').AsInteger;

           inc(curY);
           R:=Sh.Range[Sh.Cells[curY,1],Sh.Cells[curY,ColumnCount]];
           R.Merge;
           R.HorizontalAlignment:=xlLeft;
           R.VerticalAlignment:=xlCenter;
           R.Font.Size:=10;
           R.Font.Bold:=true;
           R.Font.Underline:=xlUnderlineStyleSingle;
           R.Value:=qrCityRegion.FieldByname('name').AsString;

           oldY:=curY+1;
           Row:=1;
           Data:=VarArrayCreate([1,qrPremises.RecordCount,1,ColumnCount],varVariant);
           qrPremises.First;
           while not qrPremises.Eof do begin
             if TRptExcelThreadPms_Price(THread).Terminated then exit;
             inc(curY);
             if IscnppDateArrivals then
               Data[Row,IndcnppDateArrivals]:=FormatDateTime(fmtSmallDate,qrPremises.FieldByName('datearrivals').AsDateTime);
             if IscnppCountRoomName then
               Data[Row,IndcnppCountRoomName]:=qrPremises.FieldByName('countroomname').AsString;
             if IscnppTypeRoomName then
               Data[Row,IndcnppTypeRoomName]:=qrPremises.FieldByName('typeroomname').AsString;
             if IscnppPlanningName then
               Data[Row,IndcnppPlanningName]:=qrPremises.FieldByName('planningname').AsString;
             if IscnppRegionName then
               Data[Row,IndcnppRegionName]:=qrPremises.FieldByName('regionname').AsString;
             if IscnppStreetName then
               Data[Row,IndcnppStreetName]:=qrPremises.FieldByName('streetname').AsString;
             if IscnppPhoneName then
               Data[Row,IndcnppPhoneName]:=qrPremises.FieldByName('phonename').AsString;
             if IscnppSaleStatusName then
               Data[Row,IndcnppSaleStatusName]:=qrPremises.FieldByName('salestatusname').AsString;
             if IscnppNote then
               Data[Row,IndcnppNote]:=qrPremises.FieldByName('note').AsString;
             if IscnppFloor then
               Data[Row,IndcnppFloor]:=qrPremises.FieldByName('floor').AsString;
             if IscnppCountFloor then
               Data[Row,IndcnppCountFloor]:=qrPremises.FieldByName('countfloor').AsString;
             if IscnppTypeHouseName then
               Data[Row,IndcnppTypeHouseName]:=qrPremises.FieldByName('typehousename').AsString;
             if IscnppGeneralArea then
               Data[Row,IndcnppGeneralArea]:=qrPremises.FieldByName('generalarea').AsString;
             if IscnppDwellingArea then
               Data[Row,IndcnppDwellingArea]:=qrPremises.FieldByName('dwellingarea').AsString;
             if IscnppKitchenArea then
               Data[Row,IndcnppKitchenArea]:=qrPremises.FieldByName('kitchenarea').AsString;
             if IscnppSanitaryNodeName then
               Data[Row,IndcnppSanitaryNodeName]:=qrPremises.FieldByName('sanitarynodename').AsString;
             if IscnppWaterName then
               Data[Row,IndcnppWaterName]:=qrPremises.FieldByName('Watername').AsString;
             if IscnppHeatName then
               Data[Row,IndcnppHeatName]:=qrPremises.FieldByName('Heatname').AsString;
             if IscnppConditionName then
               Data[Row,IndcnppConditionName]:=qrPremises.FieldByName('conditionname').AsString;
             if IscnppBalconyName then
               Data[Row,IndcnppBalconyName]:=qrPremises.FieldByName('balconyname').AsString;
             if IscnppStoveName then
               Data[Row,IndcnppStoveName]:=qrPremises.FieldByName('stovename').AsString;
             if IscnppSelfFormName then
               Data[Row,IndcnppSelfFormName]:=qrPremises.FieldByName('selfformname').AsString;
             if IscnppPriceUnitPrice then
               Data[Row,IndcnppPriceUnitPrice]:=qrPremises.FieldByName('price').AsString+qrPremises.FieldByName('unitpricename').AsString;
             if IscnppAgentName then
               Data[Row,IndcnppAgentName]:=qrPremises.FieldByName('fullagent').AsString;
             if IscnppStationName then
               Data[Row,IndcnppStationName]:=qrPremises.FieldByName('stationname').AsString;
             if IscnppDateTimeUpdate then
               Data[Row,IndcnppDateTimeUpdate]:=FormatDateTime(fmtSmallDate,qrPremises.FieldByName('datetimeupdate').AsDateTime);
             if IscnppDelivery then
               Data[Row,IndcnppDelivery]:=qrPremises.FieldByName('delivery').AsString;
             if IscnppBuilderName then
               Data[Row,IndcnppBuilderName]:=qrPremises.FieldByName('buildername').AsString;
             if IscnppPrice2 then
               Data[Row,IndcnppPrice2]:=qrPremises.FieldByName('price2').AsString;
             if IscnppPrice then
               Data[Row,IndcnppPrice]:=qrPremises.FieldByName('price').AsString;
             //byBart
             if IscnppTaxes then
               Data[Row,IndcnppTaxes]:=qrPremises.FieldByName('taxes').AsString;
             if IscnppDateTimeInsert then
               Data[Row,IndcnppDateTimeInsert]:=FormatDateTime(fmtSmallDate,qrPremises.FieldByName('datetimeinsert').AsDateTime);

             if IscnppAreaBuilding then
               Data[Row,IndcnppAreaBuilding]:=qrPremises.FieldByName('areabuilding').AsString;
             if IscnppLandFeature then
               Data[Row,IndcnppLandFeature]:=qrPremises.FieldByName('landfeature').AsString;
             if IscnppLandMark then
               Data[Row,IndcnppLandMark]:=qrPremises.FieldByName('LandMark').AsString;
             if IscnppCommunications then
               Data[Row,IndcnppCommunications]:=qrPremises.FieldByName('Communications').AsString;
             if IscnppLeaseOrSale then
               Data[Row,IndcnppLeaseOrSale]:=qrPremises.FieldByName('LeaseOrSale').AsString;

             if IscnppGroundArea then
               Data[Row,IndcnppGroundArea]:=qrPremises.FieldByName('GroundArea').AsString;
             if IscnppObject then
               Data[Row,IndcnppObject]:=qrPremises.FieldByName('Object').AsString;
             if IscnppDirection then
               Data[Row,IndcnppDirection]:=qrPremises.FieldByName('Direction').AsString;
             if IscnppAccessWays then
               Data[Row,IndcnppAccessWays]:=qrPremises.FieldByName('AccessWays').AsString;
             if IscnppRemoteness then
               Data[Row,IndcnppRemoteness]:=qrPremises.FieldByName('Remoteness').AsString;


             //--

             inc(Row);
             R:=Sh.Range[Sh.Cells[curY,1],Sh.Cells[curY,ColumnCount]];
             if UseStyle and (Trim(qrPremises.FieldByName('stylestyle').AsString)<>'') then
               R.Style:=qrPremises.FieldByName('stylestyle').AsString;
             qrPremises.Next;
           end;
           R:=Sh.Range[Sh.Cells[oldY,1],Sh.Cells[curY,ColumnCount]];
        //   R.Font.Size:=8;
           R.Value:=Data;

           if IscnppPhoneName then begin
             OldFontName:=Sh.Range[Sh.Cells[1,IndcnppPhoneName],Sh.Cells[1,IndcnppPhoneName]].Font.Name;
             Sh.Columns[IndcnppPhoneName].Font.Name:=fmOptions.edPhoneColumn.Font.Name;
             Sh.Range[Sh.Cells[2,IndcnppPhoneName],Sh.Cells[2,IndcnppPhoneName]].Font.Name:=Sh.Range[Sh.Cells[2,1],Sh.Cells[2,1]].Font.Name;
             Sh.Range[Sh.Cells[1,IndcnppPhoneName],Sh.Cells[1,IndcnppPhoneName]].Font.Name:=OldFontName;
           end;

           inc(curY);
           R:=Sh.Range[Sh.Cells[curY,1],Sh.Cells[curY,ColumnCount]];
           R.Merge;
         end;
         inc(incR);
         FillChar(TSPBS,SizeOf(TSPBS),0);
         TSPBS.Progress:=incR;
         TSPBS.Max:=qrCityRegion.RecordCount;
         _SetProgressBarStatus(pb2,@TSPBS);
         qrCityRegion.Next;
       end;
       inc(incCR);
       FillChar(TSPBS,SizeOf(TSPBS),0);
       TSPBS.Progress:=incCR;
       TSPBS.Max:=qrDirection.RecordCount;
       _SetProgressBarStatus(pb1,@TSPBS);
       qrDirection.Next;
     end;
   finally
     TRptExcelThreadPms_Price(THread).FCurPB:=pb2;
     TRptExcelThreadPms_Price(THread).Synchronize(TRptExcelThreadPms_Price(THread).FreeCurPB);
     TRptExcelThreadPms_Price(THread).FCurPB:=pb1;
     TRptExcelThreadPms_Price(THread).Synchronize(TRptExcelThreadPms_Price(THread).FreeCurPB);
   end;

   if IscnppPhoneName then begin
     OldFontName:=Sh.Range[Sh.Cells[1,IndcnppPhoneName],Sh.Cells[1,IndcnppPhoneName]].Font.Name;
     Sh.Columns[IndcnppPhoneName].Font.Name:=fmOptions.edPhoneColumn.Font.Name;
     Sh.Range[Sh.Cells[2,IndcnppPhoneName],Sh.Cells[2,IndcnppPhoneName]].Font.Name:=Sh.Range[Sh.Cells[2,1],Sh.Cells[2,1]].Font.Name;
     Sh.Range[Sh.Cells[1,IndcnppPhoneName],Sh.Cells[1,IndcnppPhoneName]].Font.Name:=OldFontName;
   end;

   ShMain.Activate;
   Wb.Save;
   VarClear(ShMain);
   VarClear(Sh);
   VarClear(R);
   VarClear(Wb);

 finally
   tran.free;
   qrObject.Free;
   qrPremises.Free;
   qrCityRegion.Free;
   qrDirection.Free;
   Screen.Cursor:=crDefault;
 end;
end;

end.
