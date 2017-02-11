unit URptPms_PriceLeaseInspector2;

interface

uses classes, Forms;

procedure RtpLeaseRunInspector2(Thread: TThread; Form, Options: TForm; sFileName, sTypeOperation: string;
                               UseStyle: Boolean; SyncOfficeId: String);

implementation

uses Windows, sysutils, controls, graphics, IBQuery, IBDatabase, Db, IBCustomDataSet, Excel97,
     UMainUnited, URptPms_Price, URptThread, UPremisesTsvData, UPremisesTsvOptions;

procedure RtpLeaseRunInspector2(Thread: TThread; Form, Options: TForm; sFileName, sTypeOperation: string;
                                UseStyle: Boolean; SyncOfficeId: String);
var
 tran: TIBTransaction;
 qrStation: TIBQuery;
 qrPremises,qrAgent: TIbQuery;
 sqls: string;
 Sh,ShMain: OleVariant;
 Wb: OleVariant;
 R: OleVariant;
 oldY,curY: Integer;
 Data: Variant;
 Row: Integer;
 TCPB: TCreateProgressBar;
 TSPBS: TSetProgressBarStatus;
 incAgent: Integer;
 pb1: THandle;
 Flag1: Boolean;
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
 Sh.Range[Sh.Cells[1,1],Sh.Cells[1,1]].Value:=TRptExcelThreadPms_Price(THread).FPlantName;
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
 qrStation:=TIBQuery.Create(nil);
 qrPremises:=TIBQuery.Create(nil);
 qrAgent:=TIBQuery.Create(nil);
 tran:=TIBTransaction.Create(nil);
 Screen.Cursor:=crHourGlass;
 try
   tran.AddDatabase(IBDB);
   IBDB.AddTransaction(tran);
   qrStation.Transaction:=tran;
   qrStation.Database:=IBDB;
   qrPremises.Transaction:=tran;
   qrPremises.Database:=IBDB;
   qrAgent.Transaction:=tran;
   qrAgent.Database:=IBDB;
   tran.Active:=true;

   sqls:='Select sortnumber from '+tbPms_Station+
         ' group by sortnumber '+
         ' order by sortnumber';
   qrStation.SQL.Add(sqls);
   qrStation.Active:=true;
   qrStation.Last;
   qrStation.First;

   sqls:=SQLRbkPms_Agent+
         ' where pms_agent_id in (select p.pms_agent_id from pms_premises p '+
         ' where p.datearrivals>='+QuotedStr(DateToStr(fmParent.dtpDateFrom.DateTime))+
         ' and p.datearrivals<='+QuotedStr(DateToStr(fmParent.dtpDateTo.DateTime))+
         ' and p.typeoperation='+inttostr(1)+fmParent.GetRecyledFilter+fmParent.GetStationFilter+')'+
         ' order by sortnumber';
   qrAgent.SQL.Add(sqls);
   qrAgent.Active:=true;
   qrAgent.Last;
   qrAgent.First;

   ShMain:=Sh;
   Sh.Name:='��� ������������';
   curY:=2;
   FillChar(TCPB,SizeOf(TCPB),0);
   TCPB.Min:=0;
   TCPB.Max:=qrAgent.RecordCount;
   TCPB.Color:=clNavy;
   pb1:=_CreateProgressBar(@TCPB);
   incAgent:=0;
   try
     while not qrAgent.Eof do begin
       Flag1:=true;
       qrStation.First;
       while not qrStation.Eof do begin
         if TRptExcelThreadPms_Price(THread).Terminated then exit;
         sqls:=SQLRbkPms_PremisesRpt+
               ' where p.datearrivals>='+QuotedStr(DateToStr(fmParent.dtpDateFrom.DateTime))+
               ' and p.datearrivals<='+QuotedStr(DateToStr(fmParent.dtpDateTo.DateTime))+
               ' and p.pms_station_id in ('+GetPms_Station_IdBySortNumber(qrStation.FieldByName('sortnumber').AsInteger)+')'+
               ' and p.pms_agent_id='+qrAgent.FieldByname('pms_agent_id').AsString+
               ' and p.typeoperation=1 '+
               fmParent.GetRecyledFilter+
               fmParent.GetStationFilter+
               fmParent.GetOfficeFilter+
               fmParent.GetOrder;

         qrPremises.SQL.Clear;
         qrPremises.SQL.Add(sqls);
         qrPremises.Active:=true;
         qrPremises.Last;
         if not qrPremises.IsEmpty then begin

           if Flag1 then begin
             inc(curY);
             R:=Sh.Range[Sh.Cells[curY,1],Sh.Cells[curY,ColumnCount]];
             R.Merge;
             R.HorizontalAlignment:=xlCenter;
             R.VerticalAlignment:=xlCenter;
             R.Font.Size:=9;
             R.Font.Bold:=true;
             R.Value:='����� '+qrAgent.FieldByname('name').AsString;
           end;

           if not Flag1 then begin
             inc(curY);
             R:=Sh.Range[Sh.Cells[curY,1],Sh.Cells[curY,ColumnCount]];
             R.Merge;
             R.HorizontalAlignment:=xlCenter;
             R.VerticalAlignment:=xlCenter;
             R.Font.Size:=8;
             R.Font.Bold:=true;
           end;
           Flag1:=false;

           oldY:=curY+1;
           Row:=1;
           Data:=VarArrayCreate([1,qrPremises.RecordCount,1,ColumnCount],varVariant);
           qrPremises.First;
           while not qrPremises.Eof do begin
             if TRptExcelThreadPms_Price(THread).Terminated then exit;
             inc(curY);
             if IscnppDateArrivals then
               Data[Row,IndcnppDateArrivals]:=FormatDateTime(fmtSmallDate,qrPremises.FieldByName('datearrivals').AsDateTime);
             if IscnppRegionName then
               Data[Row,IndcnppRegionName]:=qrPremises.FieldByName('regionname').AsString;
             if IscnppCountRoomName then
               Data[Row,IndcnppCountRoomName]:=qrPremises.FieldByName('countroomname').AsString;
             if IscnppStreetName then
               Data[Row,IndcnppStreetName]:=qrPremises.FieldByName('streetname').AsString;
             if IscnppHouseNumber then
               Data[Row,IndcnppHouseNumber]:=qrPremises.FieldByName('housenumber').AsString;
             if IscnppApartmentNumber then
               Data[Row,IndcnppApartmentNumber]:=qrPremises.FieldByName('apartmentnumber').AsString;
             if IscnppNote then
               Data[Row,IndcnppNote]:=qrPremises.FieldByName('note').AsString;
             if IscnppPhoneName then
               Data[Row,IndcnppPhoneName]:=qrPremises.FieldByName('phonename').AsString;
             if IscnppFurnitureName then
               Data[Row,IndcnppFurnitureName]:=qrPremises.FieldByName('furniturename').AsString;
             if IscnppFloorCountFloorTypeHouseName then
               Data[Row,IndcnppFloorCountFloorTypeHouseName]:=iff((Trim(qrPremises.FieldByName('floor').AsString)<>'')or
                                                                (Trim(qrPremises.FieldByName('countfloor').AsString)<>''),
                                                                qrPremises.FieldByName('floor').AsString+'/'+
                                                                qrPremises.FieldByName('countfloor').AsString+
                                                                qrPremises.FieldByName('typehousename').AsString,'');
             if IscnppPlanningName then
               Data[Row,IndcnppPlanningName]:=qrPremises.FieldByName('planningname').AsString;
             if IscnppTypeRoomName then
               Data[Row,IndcnppTypeRoomName]:=qrPremises.FieldByName('typeroomname').AsString;
             if IscnppGeneralDwellingKitchenArea then
               Data[Row,IndcnppGeneralDwellingKitchenArea]:=Iff((Trim(qrPremises.FieldByName('generalarea').AsString)<>'') or
                                                              (Trim(qrPremises.FieldByName('dwellingarea').AsString)<>'') or
                                                              (Trim(qrPremises.FieldByName('kitchenarea').AsString)<>''),
                                                              qrPremises.FieldByName('generalarea').AsString+'/'+
                                                              qrPremises.FieldByName('dwellingarea').AsString+'/'+
                                                              qrPremises.FieldByName('kitchenarea').AsString,'');
             if IscnppDoorName then
               Data[Row,IndcnppDoorName]:=qrPremises.FieldByName('doorname').AsString;
             if IscnppBalconyName then
               Data[Row,IndcnppBalconyName]:=qrPremises.FieldByName('balconyname').AsString;
             if IscnppSanitaryNodeName then
               Data[Row,IndcnppSanitaryNodeName]:=qrPremises.FieldByName('sanitarynodename').AsString;
             if IscnppWaterName then
               Data[Row,IndcnppWaterName]:=qrPremises.FieldByName('Watername').AsString;
             if IscnppHeatName then
               Data[Row,IndcnppHeatName]:=qrPremises.FieldByName('Heatname').AsString;
             if IscnppStoveName then
               Data[Row,IndcnppStoveName]:=qrPremises.FieldByName('stovename').AsString;
             if IscnppPriceUnitPrice then
               Data[Row,IndcnppPriceUnitPrice]:=qrPremises.FieldByName('price').AsString+qrPremises.FieldByName('unitpricename').AsString;
             if IscnppPaymentTerm then
               Data[Row,IndcnppPaymentTerm]:=iff((Trim(qrPremises.FieldByName('payment').AsString)<>'')or
                                               (Trim(qrPremises.FieldByName('term').AsString)<>''),
                                               qrPremises.FieldByName('payment').AsString+'/'+
                                               qrPremises.FieldByName('term').AsString,'');
             if IscnppAgentName then
               Data[Row,IndcnppAgentName]:=qrPremises.FieldByName('fullagent').AsString;
             if IscnppStationName then
               Data[Row,IndcnppStationName]:=qrPremises.FieldByName('stationname').AsString;
             if IscnppContactClientInfo then
               Data[Row,IndcnppContactClientInfo]:=Trim(TranslateContact(Trim(qrPremises.FieldByName('contact').AsString))+' '+qrPremises.FieldByName('clientinfo').AsString);
             if IscnppDateTimeUpdate then
               Data[Row,IndcnppDateTimeUpdate]:=FormatDateTime(fmtSmallDate,qrPremises.FieldByName('datetimeupdate').AsDateTime);
             if IscnppPrice then
               Data[Row,IndcnppPrice]:=qrPremises.FieldByName('price').AsString;
             inc(Row);
             R:=Sh.Range[Sh.Cells[curY,1],Sh.Cells[curY,ColumnCount]];
             if UseStyle and (Trim(qrPremises.FieldByName('stylestyle').AsString)<>'') then
               R.Style:=qrPremises.FieldByName('stylestyle').AsString;
             qrPremises.Next;
           end;
           R:=Sh.Range[Sh.Cells[oldY,1],Sh.Cells[curY,ColumnCount]];
           R.Font.Size:=6;
           R.Value:=Data;

           if IscnppPhoneName then begin
             OldFontName:=Sh.Range[Sh.Cells[1,IndcnppPhoneName],Sh.Cells[1,IndcnppPhoneName]].Font.Name;
             Sh.Columns[IndcnppPhoneName].Font.Name:=fmOptions.edPhoneColumn.Font.Name;
             Sh.Range[Sh.Cells[2,IndcnppPhoneName],Sh.Cells[2,IndcnppPhoneName]].Font.Name:=Sh.Range[Sh.Cells[2,1],Sh.Cells[2,1]].Font.Name;
             Sh.Range[Sh.Cells[1,IndcnppPhoneName],Sh.Cells[1,IndcnppPhoneName]].Font.Name:=OldFontName;
           end;

         end;
         qrStation.Next;
       end;
       inc(incAgent);
       FillChar(TSPBS,SizeOf(TSPBS),0);
       TSPBS.Progress:=incAgent;
       TSPBS.Max:=qrAgent.RecordCount;
       _SetProgressBarStatus(pb1,@TSPBS);
       qrAgent.Next;
     end;
   finally
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

 finally
   tran.free;
   qrAgent.Free;
   qrPremises.Free;
   qrStation.Free;
   Screen.Cursor:=crDefault;
 end;
end;

end.
