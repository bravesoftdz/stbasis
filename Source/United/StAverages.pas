unit StAverages;

interface

uses StCalendarUtil;
{
  Sick CalculateType
        1       ������ ������� �� ������ �����������
        2       ������ ������� �� ����� �� �������
        3       ������ ������� ��� ������� ������
        4       ������ ������� �� ������������ � �����
        5       ������ ������� ��� �������� ������
        6       ������ �������  �� ����. �����������
}
{
  Sick CalculateSubType
        1               ������� ��������
        2               ��������, ����� � �.�.
        3               ������ �� 3-�, ������� �� 16-��
}
{
  Sick CalculateTimeType
        1               �� ����
        2               �� �����
}
type
  TEmployeeSickInfo=packed record
   Emp_id:Integer;//���������
   EmpPlant_id:Integer;//���������
   StartDate,EndDate:TDateTime;//������ �������
   WorkAbsence_ids:TRecordsIDs;
   Oklad:Currency;//�����
   OkladFlag:Boolean;
   PayPercent:Integer;//������� ������ �� �����
   CalculateType,CalculateSubType:Integer;
   CalculateTimeType:Integer;
   WithoutPay:Boolean;//��� ������
  end;

  TSickItem=packed record
   FDate:TDateTime;
   SickDaysCount:Integer;
   SickHoursCount:Double;
   NormalDaysCount:Integer;
   NormalHoursCount:Double;
   CalendarDays:Integer;
   WithoutPay:Boolean;
   PayPercent:Integer;
   OnePay:Currency;
  end;

  TSick=array of TSickItem;

  TSalaryInfoItem=packed record
   Month:TDateTime;
   ODays:Word;
   NDays:Word;
   OHours:Double;
   NHours:Double;
   Pay:Currency;
  end;

  TSalaryInfo=array of TSalaryInfoItem;

{
  Leave CalculateType
        1       ������ ���������� �������
        2       ������ ������������ �������
        3       ������ ����������� ����������
        4       ������ ������ �������
        5       ������ ����������� �������
        6       ������ ������� ����������� ������ �� ����
        7       ������ ����������� �����������
}

{
  Leave CalculateSubType
        1               �� 6-�� ������� ������� ������
        2               ������������� ����
        3               �� ����������� ����
}

  TEmployeeLeaveInfo=packed record
   Emp_id:Integer;//���������
   EmpPlant_id:Integer;//���������
   StartDate,EndDate:TDateTime;//������ �������
   WorkAbsence_ids:TRecordsIDs;
   Oklad:Currency;//�����
   OkladFlag:Boolean;
   PayPercent:Integer;//������� ������ �� �����
   CalculateType,CalculateSubType:Integer;
  end;

  TLeaveItem=packed record
   FDate:TDateTime;
   LeaveDaysCount:Integer;
   LeaveHoursCount:Double;
   NormalDaysCount:Integer;
   NormalHoursCount:Double;
   CalendarDays:Integer;
   OnePay:Currency;
  end;

  TLeave=array of TLeaveItem;

procedure CalculateSickList(Emp:TEmployeeSickInfo;var CalcShift:Integer;var ASalaryInfo:TSalaryInfo;var ASick:TSick;var AveragePay,AllPay:Currency);
procedure CalculateLeaveList(Emp:TEmployeeLeaveInfo;var CalcShift:Integer;var ASalaryInfo:TSalaryInfo;var ALeave:TLeave;var AveragePay,Lucre,AllPay:Currency);

implementation

uses UMainUnited, Math, SysUtils, Windows, Forms, DateUtil, StSalaryKit;

//����� ���������
function CoolRound(F:Extended;N:Byte):Extended;
begin
 if N=0 then Result:=Round(F) else
  Result:=Int((F+0.5/IntPower(10,N))*IntPower(10,N))/IntPower(10,N);
end;

function Get_Sick_Magic_Code:Integer;
begin
 //755 �� ���� ���������� ��� ����������
 Result:=755;
end;

function Get_Leave_Magic_Code:Integer;
begin
 //??? �� ���� ����������
 Result:=0;
end;

function GetSalary(AEmpPlant_id:Integer;AMonth:TDateTime;N:Integer):Currency;
begin
 try
  Result:=GetOnSalary(AEmpPlant_id,GetCalcPeriodByDate(AMonth),N);
 except
  Result:=0;
  ShowInfo(0,'���������� � ������� ������� ���. �����.');
 end;
end;

//����� ����������� �������� ������
function GetSickConst01:Integer;
begin
 Result:=15;
end;

//�������� ����������� �������� ������
function GetSickConst02:Double;
begin
 Result:=1.3;
end;

//������� ������ �� ����������� ��� ���� �� �������
function GetSickConst03:Integer;
begin
 Result:=50;
end;

//���-�� ���� ������ ������ ���� �� �������
function GetSickConst04:Integer;
begin
 Result:=7;
end;

//���-�� ���� ������ ������ ��� ���� � �.�. ���� �� �������
function GetSickConst05:Integer;
begin
 Result:=10;
end;

//���-�� �� ������������ ���� ������� ������
function GetSickConst06:Integer;
begin
 Result:=5;
end;

//���-�� ���. ���. ���� ���. ������
function GetLeaveConst08:Integer;
begin
 Result:=12;
end;

//����������� ������� ������ ��� ������������ ������� ������
function GetLeaveConst09:Integer;
begin
 Result:=5;
end;

//�������������� ���-�� ���� ��� ������� �� 5-�� ��� 6-�� ������� ���. ������
function GetLeaveConst13:Double;
begin
 Result:=25.25;
end;

//�������������� ���-�� ���� ��� ������� �� ����������� ����
function GetLeaveConst14:Double;
begin
 Result:=29.6;
end;

function GetMinPay(AMonth:TDateTime):Currency;
begin
 Result:=GetMROT(AMonth);
end;

procedure CalculateSickList(Emp:TEmployeeSickInfo;var CalcShift:Integer;var ASalaryInfo:TSalaryInfo;var ASick:TSick;var AveragePay,AllPay:Currency);

var S,F:TDateTime;
    RecurseCount:Integer;

procedure AddSickDataRecord(var ASick:TSick;const D:TDateTime;PeriodInDays:Integer;PeriodInHours:Double;const ACalendarDays:Integer;const Percent:Integer;const AWithOutPay:Boolean);
var NewID:Integer;
    S,F:TDateTime;
begin
 NewID:=High(ASick)+2;
 SetLength(ASick,NewID);
 with ASick[NewID-1] do
 begin
  FDate:=D;
  if PeriodInDays<0 then PeriodInDays:=0;
  SickDaysCount:=PeriodInDays;
  if PeriodInHours<0 then PeriodInHours:=0;
  SickHoursCount:=PeriodInHours;
  S:=EncodeDate(ExtractYear(D),ExtractMonth(D),1);
  F:=IncMonth(S,1);
  F:=IncDay(F,-1);
  NormalDaysCount:=Round(GetNormalTime(GetEmpPlantSchedule(Emp.EmpPlant_id),nil,S,F,False,[dtOrdinary,dtFree,dtHoliday]));
  NormalHoursCount:=GetNormalTime(GetEmpPlantSchedule(Emp.EmpPlant_id),nil,S,F,True,[dtOrdinary,dtFree,dtHoliday]);
  CalendarDays:=ACalendarDays;
  WithoutPay:=AWithOutPay;
  PayPercent:=Percent;
  OnePay:=0;
 end;
end;

procedure GetSalaries(N:Integer);
var StartDate:TDateTime;
begin
 CalcShift:=N;
 Inc(RecurseCount);
 StartDate:=IncMonth(Emp.StartDate,N);
 ASalaryInfo[0].Pay:=0;
 ASalaryInfo[1].Pay:=0;
 ASalaryInfo[0].Month:=IncMonth(StartDate,-1);
 ASalaryInfo[1].Month:=IncMonth(StartDate,-2);
 if (not Emp.WithoutPay) and (Emp.CalculateType<>5) then
 begin
  ASalaryInfo[0].Pay:=GetSalary(Emp.EmpPlant_id,ASalaryInfo[0].Month,Get_Sick_Magic_Code);
  ASalaryInfo[1].Pay:=GetSalary(Emp.EmpPlant_id,ASalaryInfo[1].Month,Get_Sick_Magic_Code);
 end else Exit;
 if (ASalaryInfo[0].Pay=0) and (ASalaryInfo[1].Pay=0) then
 begin
  if RecurseCount=5 then Exit;
  GetSalaries(N-1);
  Exit;
 end;
end;

procedure PrepareSickListPeriod;
var StartDate,EndDate:TDateTime;
    PeriodInHours:Double;
    I,PeriodInDays,Percent,CalendarDays:Integer;
    Y,M,D:Word;
begin
 PeriodInDays:=0;
 PeriodInHours:=0;
 CalendarDays:=0;
 Percent:=Emp.PayPercent;

 StartDate:=Emp.StartDate;
 EndDate:=Emp.EndDate;

 if (Emp.CalculateType=2) then
  case Emp.CalculateSubType of
   1:begin//���� �� �������
      I:=0;
      while (StartDate<=EndDate) and (I<GetSickConst04) do
      begin
       Inc(CalendarDays);
       if (not IsFreeDay(StartDate)) and (not IsHoliday(StartDate)) then
       begin
        Inc(PeriodInDays);
        if (DayOfWeek(StartDate)=6) or (IsHoliday(IncDay(StartDate,1))) then
         PeriodInHours:=PeriodInHours+7
        else
         PeriodInHours:=PeriodInHours+8.25;
       end
       else
        if (IsFreeDay(StartDate)) and (IsHoliday(StartDate)) then
        begin
         Dec(PeriodInDays);
         PeriodInHours:=PeriodInHours-8.25;
        end;
       if IsLastDay(StartDate) then
       begin//���������� �������� �������������.
        AddSickDataRecord(ASick,StartDate,PeriodInDays,PeriodInHours,CalendarDays,Percent,False);
        PeriodInDays:=0;
        PeriodInHours:=0;
        CalendarDays:=0;
       end;
       StartDate:=IncDay(StartDate,1);
       Inc(I);
      end;
      if PeriodInDays>0 then//���������� LAST ������a �������������.
       AddSickDataRecord(ASick,StartDate,PeriodInDays,PeriodInHours,CalendarDays,Percent,False);
      Percent:=GetSickConst03;
     end;
   2:begin//��������, ����� � �.�.
      I:=0;
      while (StartDate<=EndDate) and (I<GetSickConst05) do
      begin
       Inc(CalendarDays);
       if (not IsFreeDay(StartDate)) and (not IsHoliday(StartDate)) then
       begin
        Inc(PeriodInDays);
        if (DayOfWeek(StartDate)=6) or (IsHoliday(IncDay(StartDate,1))) then
         PeriodInHours:=PeriodInHours+7
        else
         PeriodInHours:=PeriodInHours+8.25;
       end
       else
        if (IsFreeDay(StartDate)) and (IsHoliday(StartDate)) then
        begin
         Dec(PeriodInDays);
         PeriodInHours:=PeriodInHours-8.25;
        end;
       if IsLastDay(StartDate) then
       begin//���������� �������� �������������.
        AddSickDataRecord(ASick,StartDate,PeriodInDays,PeriodInHours,CalendarDays,Percent,False);
        PeriodInDays:=0;
        PeriodInHours:=0;
        CalendarDays:=0;
       end;
       StartDate:=IncDay(StartDate,1);
       Inc(I);
      end;
      if PeriodInDays>0 then//���������� LAST ������a �������������.
       AddSickDataRecord(ASick,StartDate,PeriodInDays,PeriodInHours,CalendarDays,Percent,False);
      Percent:=GetSickConst03;
     end;
   end;// END CASE

 if (Emp.CalculateType=3) then
 begin
  I:=GetSickConst06;
  while (StartDate<=EndDate) and (I>0) do
  begin
   Inc(CalendarDays);
   if (not IsFreeDay(StartDate)) and (not IsHoliday(StartDate)) then
   begin
    Inc(PeriodInDays);
    if (DayOfWeek(StartDate)=6) or (IsHoliday(IncDay(StartDate,1))) then
     PeriodInHours:=PeriodInHours+7
    else
     PeriodInHours:=PeriodInHours+8.25;
   end
   else
    if (IsFreeDay(StartDate)) and (IsHoliday(StartDate)) then
    begin
     Dec(PeriodInDays);
     PeriodInHours:=PeriodInHours-8.25;
    end;
   if not IsHoliday(StartDate) then Dec(I);
   if IsLastDay(StartDate) then//���������� �������� �������������.
   begin
    AddSickDataRecord(ASick,StartDate,PeriodInDays,PeriodInHours,CalendarDays,Percent,True);
    PeriodInDays:=0;
    PeriodInHours:=0;
    CalendarDays:=0;
   end;
   StartDate:=IncDay(StartDate,1);
  end;
  if PeriodInDays>0 then//���������� LAST ������a �������������.
   AddSickDataRecord(ASick,StartDate,PeriodInDays,PeriodInHours,CalendarDays,Percent,True);
 end;

 PeriodInDays:=0;PeriodInHours:=0;CalendarDays:=0;
 if Emp.CalculateType<>5 then
 begin
  while StartDate<=EndDate do
  begin
   Inc(CalendarDays);
   if (not IsFreeDay(StartDate)) and (not IsHoliday(StartDate)) then
   begin
    Inc(PeriodInDays);
    if (DayOfWeek(StartDate)=6) or (IsHoliday(IncDay(StartDate,1))) then
     PeriodInHours:=PeriodInHours+7
    else
     PeriodInHours:=PeriodInHours+8.25;
   end
   else
    if (IsFreeDay(StartDate)) and (IsHoliday(StartDate)) then
    begin
     Dec(PeriodInDays);
     PeriodInHours:=PeriodInHours-8.25;
    end;
   if IsLastDay(StartDate) then
   begin//���������� �������� �������������.
    AddSickDataRecord(ASick,StartDate,PeriodInDays,PeriodInHours,CalendarDays,Percent,False);
    PeriodInDays:=0;
    PeriodInHours:=0;
    CalendarDays:=0;
   end;
   StartDate:=IncDay(StartDate,1);
  end;
  if PeriodInDays>0 then//���������� LAST ������a �������������.
   AddSickDataRecord(ASick,StartDate,PeriodInDays,PeriodInHours,CalendarDays,Percent,False);
 end
 else
 begin//5 type
  DecodeDate(StartDate,Y,M,D);
  //����� �������������.
  AddSickDataRecord(ASick,EncodeDate(Y,M,1),0,0,0,0,False);
 end;
end;

procedure DoCalculate;
var I:Integer;
    AveragePayOld:Currency;
begin
 if Emp.CalculateType=5 then
 begin//������ ��� �������� ������
  AveragePay:=0;
  AllPay:=CoolRound(GetSickConst01*GetSickConst02*GetMinPay(Emp.StartDate),CurrencyDecimals);
  ASick[0].OnePay:=AllPay;//����� ����� �������
 end
 else
 begin//������ �� �������
  AveragePay:=0;
  if not Emp.WithoutPay then
  case Emp.CalculateTimeType of
   //�� ����
   1:if (ASalaryInfo[0].ODays+ASalaryInfo[1].ODays)<>0 then
      AveragePay:=(ASalaryInfo[0].Pay+ASalaryInfo[1].Pay)/(ASalaryInfo[0].ODays+ASalaryInfo[1].ODays);
   //�� �����
   2:if (ASalaryInfo[0].OHours+ASalaryInfo[1].OHours)<>0 then
      AveragePay:=(ASalaryInfo[0].Pay+ASalaryInfo[1].Pay)/(ASalaryInfo[0].OHours+ASalaryInfo[1].OHours);
  end;
  AveragePay:=CoolRound(AveragePay,CurrencyDecimals);
  AveragePayOld:=AveragePay;
  AllPay:=0;
  //���������� ������� ������������������
  for I:=Low(ASick) to High(ASick) do
  begin
   AveragePay:=AveragePayOld;
   if not Emp.WithoutPay then
    if ((Emp.CalculateType=1) and (Emp.CalculateSubType<>2)) or
     (Emp.CalculateType=2) or
     ((Emp.CalculateType=3) and (Emp.CalculateSubType<>2)) then
    begin//�������� �� ������� �����
     case Emp.CalculateTimeType of
      1:if Emp.OkladFlag then
        begin//�����
         if ASick[I].NormalDaysCount<>0 then
         begin
          if AveragePay>(Emp.Oklad*2/ASick[I].NormalDaysCount) then
           AveragePay:=Emp.Oklad*2/ASick[I].NormalDaysCount;
         end;
        end
        else
        begin//�����
         if (ASick[I].NormalDaysCount<>0) or (ASick[I].NormalHoursCount<>0) then
         begin
          if AveragePay>(Emp.Oklad*ASick[I].NormalHoursCount*2/ASick[I].NormalDaysCount) then
           AveragePay:=Emp.Oklad*ASick[I].NormalHoursCount*2/ASick[I].NormalDaysCount;
         end
        end;
      2:if Emp.OkladFlag then
        begin//�����
         if ASick[I].NormalHoursCount<>0 then
         begin
          if AveragePay>(Emp.Oklad*2/ASick[I].NormalHoursCount) then
           AveragePay:=Emp.Oklad*2/ASick[I].NormalHoursCount;
         end;
        end
        else
        begin//�����
         if AveragePay>(Emp.Oklad*2) then
          AveragePay:=Emp.Oklad*2;
        end;
     end;
    end;
   if not ASick[I].WithoutPay then
    case Emp.CalculateTimeType of
     1:ASick[I].OnePay:=CoolRound(ASick[I].SickDaysCount*AveragePay/100*ASick[I].PayPercent,CurrencyDecimals);
     2:ASick[I].OnePay:=CoolRound(ASick[I].SickHoursCount*AveragePay/100*ASick[I].PayPercent,CurrencyDecimals);
    end
   else ASick[I].OnePay:=0;
   AllPay:=AllPay+ASick[I].OnePay;
  end;
  AllPay:=CoolRound(AllPay,CurrencyDecimals);
 end;
end;

begin
 //������������ �������, ����� ������ :-)
 case Emp.CalculateType of
  1:if Emp.CalculateSubType>1 then Emp.PayPercent:=100;
  3:if Emp.CalculateSubType>1 then Emp.PayPercent:=100;
  4:Emp.PayPercent:=100;
  5:Emp.PayPercent:=0;
  6:Emp.PayPercent:=100;
 end;
 //���-�� ������� ��� ��������� ���.�����
 RecurseCount:=0;
 CalcShift:=0;

 //��� ������� ���������� 2 ������
 SetLength(ASalaryInfo,2);
 //�������� ������� ���� ���
 SetLength(ASick,0);
 //��������� ASalaryInfo
 GetSalaries(0);
 PrepareSickListPeriod;
 S:=EncodeDate(ExtractYear(ASalaryInfo[0].Month),ExtractMonth(ASalaryInfo[0].Month),1);
 F:=IncMonth(S,1);
 F:=IncDay(F,-1);
 ASalaryInfo[0].ODays:=Round(GetActualTime(Emp.EmpPlant_id,Emp.WorkAbsence_ids,nil,S,F,False));
 ASalaryInfo[0].OHours:=GetActualTime(Emp.EmpPlant_id,Emp.WorkAbsence_ids,nil,S,F,True);
 S:=EncodeDate(ExtractYear(ASalaryInfo[1].Month),ExtractMonth(ASalaryInfo[1].Month),1);
 F:=IncMonth(S,1);
 F:=IncDay(F,-1);
 ASalaryInfo[1].ODays:=Round(GetActualTime(Emp.EmpPlant_id,Emp.WorkAbsence_ids,nil,S,F,False));
 ASalaryInfo[1].OHours:=GetActualTime(Emp.EmpPlant_id,Emp.WorkAbsence_ids,nil,S,F,True);
 DoCalculate;
end;

procedure CalculateLeaveList(Emp:TEmployeeLeaveInfo;var CalcShift:Integer;var ASalaryInfo:TSalaryInfo;var ALeave:TLeave;var AveragePay,Lucre,AllPay:Currency);

var S,F:TDateTime;
    RecurseCount:Integer;

procedure AddLeaveDataRecord(var ALeave:TLeave;const D:TDateTime;PeriodInDays:Integer;PeriodInHours:Double;const ACalendarDays:Integer);
var NewID:Integer;
    S,F:TDateTime;
begin
 NewID:=High(ALeave)+2;
 SetLength(ALeave,NewID);
 with ALeave[NewID-1] do
 begin
  FDate:=D;
  if PeriodInDays<0 then PeriodInDays:=0;
  LeaveDaysCount:=PeriodInDays;
  if PeriodInHours<0 then PeriodInHours:=0;
  LeaveHoursCount:=PeriodInHours;
  S:=EncodeDate(ExtractYear(D),ExtractMonth(D),1);
  F:=IncMonth(S,1);
  F:=IncDay(F,-1);
  NormalDaysCount:=Round(GetNormalTime(GetEmpPlantSchedule(Emp.EmpPlant_id),nil,S,F,False,[dtOrdinary,dtFree,dtHoliday]));
  NormalHoursCount:=GetNormalTime(GetEmpPlantSchedule(Emp.EmpPlant_id),nil,S,F,True,[dtOrdinary,dtFree,dtHoliday]);
  CalendarDays:=ACalendarDays;
  OnePay:=0;
 end;
end;

procedure GetSalaries(N:Integer);
var StartDate:TDateTime;
begin
 CalcShift:=N;
 Inc(RecurseCount);
 StartDate:=IncMonth(Emp.StartDate,N);
 ASalaryInfo[0].Month:=IncMonth(StartDate,-1);
 ASalaryInfo[1].Month:=IncMonth(StartDate,-2);
 ASalaryInfo[2].Month:=IncMonth(StartDate,-3);
 ASalaryInfo[0].Pay:=GetSalary(Emp.EmpPlant_id,ASalaryInfo[0].Month,Get_Leave_Magic_Code);
 ASalaryInfo[1].Pay:=GetSalary(Emp.EmpPlant_id,ASalaryInfo[1].Month,Get_Leave_Magic_Code);
 ASalaryInfo[2].Pay:=GetSalary(Emp.EmpPlant_id,ASalaryInfo[2].Month,Get_Leave_Magic_Code);
 if (ASalaryInfo[0].Pay=0) and (ASalaryInfo[1].Pay=0) and (ASalaryInfo[2].Pay=0) then
 begin
  if RecurseCount=5 then Exit;
  GetSalaries(N-1);
  Exit;
 end;
end;

procedure PrepareLeaveListPeriod;
var StartDate,EndDate:TDateTime;
    PeriodInHours,FridayInc,WorkInc:Double;
    A,CalendarDays,Period:Integer;
begin
// GotoLModesRecord(taLeaveStaffCMode.Value-1);
 Period:=0;PeriodInHours:=0;CalendarDays:=0;A:=1;
 StartDate:=Emp.StartDate;
 EndDate:=Emp.EndDate;
 if Emp.CalculateType in [1,2,4,5,6] then
 begin
  WorkInc:=8.25;
  FridayInc:=7;
  while StartDate<=EndDate do
  begin
   if not IsHoliday(StartDate) then Inc(CalendarDays);

   if Emp.CalculateType<>4 then
   begin
    if (DayOfWeek(StartDate)<>1) and (not IsHoliday(StartDate)) then
     Inc(Period)
    else
     if (DayOfWeek(StartDate)=1) and (IsHoliday(StartDate)) then
      Dec(Period);
   end else//���� ��� ����� �������
   if (not IsFreeDay(StartDate)) and (not IsHoliday(StartDate)) then
   begin
    Inc(Period);
   end else
    if (IsFreeDay(StartDate)) and (IsHoliday(StartDate)) then Dec(Period);

   if Emp.CalculateSubType=3 then Period:=CalendarDays;//� ������� �� ������. ���� ��� �����

   if (not IsFreeDay(StartDate)) and (not IsHoliday(StartDate)) then
   begin
    if (DayOfWeek(StartDate)=6) or (IsHoliday(IncDay(StartDate,1))) then
     PeriodInHours:=PeriodInHours+FridayInc//��������� � ����������� �� ������-�����
    else
     PeriodInHours:=PeriodInHours+WorkInc;
   end else
    if (IsFreeDay(StartDate)) and (IsHoliday(StartDate)) then
    begin
     PeriodInHours:=PeriodInHours-WorkInc;
    end;

   if IsLastDay(StartDate) then
   begin//���������� ��������
    AddLeaveDataRecord(ALeave,StartDate,Period,PeriodInHours,CalendarDays);
    Inc(A);if A>3 then A:=3;
    Period:=0;
    PeriodInHours:=0;
    CalendarDays:=0;
   end;
   StartDate:=IncDay(StartDate,1);
  end;
  if CalendarDays>0 then//���������� LAST ������a
   AddLeaveDataRecord(ALeave,StartDate,Period,PeriodInHours,CalendarDays);
 end else
 begin
  AddLeaveDataRecord(ALeave,StartDate,0,0,0);
 end;
end;

procedure DoCalculate;
var I:Integer;
    AveragePayOld:Currency;
    MonthHour,Cooficient,Znamenatel:Double;
begin
 //������ �� �������
 MonthHour:=166.7;
 //������������ ������
 if Emp.CalculateType in [1,3,7] then
  Lucre:=CoolRound(Emp.PayPercent*GetMinPay(Emp.StartDate)*GetLeaveConst08/100,CurrencyDecimals);
 if GetLeaveConst09=5 then Cooficient:=1.2 else Cooficient:=1;
 AveragePay:=ASalaryInfo[0].Pay+ASalaryInfo[1].Pay+ASalaryInfo[2].Pay;//���������
 case Emp.CalculateSubType of
  //�� 6 �������
  1:begin
     Znamenatel:=0;
     if ASalaryInfo[0].ODays=ASalaryInfo[0].NDays then Znamenatel:=Znamenatel+GetLeaveConst13 else Znamenatel:=Znamenatel+ASalaryInfo[0].ODays*Cooficient;
     if ASalaryInfo[1].ODays=ASalaryInfo[1].NDays then Znamenatel:=Znamenatel+GetLeaveConst13 else Znamenatel:=Znamenatel+ASalaryInfo[1].ODays*Cooficient;
     if ASalaryInfo[2].ODays=ASalaryInfo[2].NDays then Znamenatel:=Znamenatel+GetLeaveConst13 else Znamenatel:=Znamenatel+ASalaryInfo[2].ODays*Cooficient;
     AveragePay:=AveragePay/Znamenatel;
    end;
  //�������������
  2:begin
     Znamenatel:=0;
     if ASalaryInfo[0].OHours=ASalaryInfo[0].NHours then Znamenatel:=Znamenatel+MonthHour else Znamenatel:=Znamenatel+ASalaryInfo[0].OHours;
     if ASalaryInfo[1].OHours=ASalaryInfo[1].NHours then Znamenatel:=Znamenatel+MonthHour else Znamenatel:=Znamenatel+ASalaryInfo[1].OHours;
     if ASalaryInfo[2].OHours=ASalaryInfo[2].NHours then Znamenatel:=Znamenatel+MonthHour else Znamenatel:=Znamenatel+ASalaryInfo[2].OHours;
     AveragePay:=AveragePay/Znamenatel;
    end;
  //�� �����������
  3:begin
     Znamenatel:=0;
     if ASalaryInfo[0].ODays=ASalaryInfo[0].NDays then Znamenatel:=Znamenatel+GetLeaveConst14 else Znamenatel:=Znamenatel+ASalaryInfo[0].ODays;
     if ASalaryInfo[1].ODays=ASalaryInfo[1].NDays then Znamenatel:=Znamenatel+GetLeaveConst14 else Znamenatel:=Znamenatel+ASalaryInfo[1].ODays;
     if ASalaryInfo[2].ODays=ASalaryInfo[2].NDays then Znamenatel:=Znamenatel+GetLeaveConst14 else Znamenatel:=Znamenatel+ASalaryInfo[2].ODays;
     AveragePay:=AveragePay/Znamenatel;
    end;
 end;
 AveragePay:=CoolRound(AveragePay,CurrencyDecimals);
 AveragePayOld:=AveragePay;
 AllPay:=0;
 //���������� ������� ������������������
 for I:=Low(ALeave) to High(ALeave) do
 begin
  AveragePay:=AveragePayOld;
  case Emp.CalculateSubType of
   1,3:ALeave[I].OnePay:=CoolRound(ALeave[I].LeaveDaysCount*AveragePay,CurrencyDecimals);
   2:ALeave[I].OnePay:=CoolRound(ALeave[I].LeaveHoursCount*AveragePay,CurrencyDecimals);
  end;
  AllPay:=AllPay+ALeave[I].OnePay;
 end;
 AllPay:=CoolRound(AllPay,CurrencyDecimals);
end;

begin
 //����������� ������ � �����������
 if Emp.CalculateType=2 then Emp.CalculateSubType:=3;

 //���-�� ������� ��� ��������� ���.�����
 RecurseCount:=0;
 CalcShift:=0;

 //��� ������� 3 ������
 SetLength(ASalaryInfo,3);
 //�������� ���� ���
 SetLength(ALeave,0);
 //��������� ASalaryInfo
 GetSalaries(0);
 PrepareLeaveListPeriod;
 S:=EncodeDate(ExtractYear(ASalaryInfo[0].Month),ExtractMonth(ASalaryInfo[0].Month),1);
 F:=IncMonth(S,1);
 F:=IncDay(F,-1);
 ASalaryInfo[0].ODays:=Round(GetActualTime(Emp.EmpPlant_id,Emp.WorkAbsence_ids,nil,S,F,False));
 ASalaryInfo[0].OHours:=GetActualTime(Emp.EmpPlant_id,Emp.WorkAbsence_ids,nil,S,F,True);
 ASalaryInfo[0].NDays:=Round(GetNormalTime(GetEmpPlantSchedule(Emp.EmpPlant_id),nil,S,F,False,[dtOrdinary,dtFree,dtHoliday]));
 ASalaryInfo[0].NHours:=GetNormalTime(GetEmpPlantSchedule(Emp.EmpPlant_id),nil,S,F,True,[dtOrdinary,dtFree,dtHoliday]);
 S:=EncodeDate(ExtractYear(ASalaryInfo[1].Month),ExtractMonth(ASalaryInfo[1].Month),1);
 F:=IncMonth(S,1);
 F:=IncDay(F,-1);
 ASalaryInfo[1].ODays:=Round(GetActualTime(Emp.EmpPlant_id,Emp.WorkAbsence_ids,nil,S,F,False));
 ASalaryInfo[1].OHours:=GetActualTime(Emp.EmpPlant_id,Emp.WorkAbsence_ids,nil,S,F,True);
 ASalaryInfo[1].NDays:=Round(GetNormalTime(GetEmpPlantSchedule(Emp.EmpPlant_id),nil,S,F,False,[dtOrdinary,dtFree,dtHoliday]));
 ASalaryInfo[1].NHours:=GetNormalTime(GetEmpPlantSchedule(Emp.EmpPlant_id),nil,S,F,True,[dtOrdinary,dtFree,dtHoliday]);
 S:=EncodeDate(ExtractYear(ASalaryInfo[2].Month),ExtractMonth(ASalaryInfo[2].Month),1);
 F:=IncMonth(S,1);
 F:=IncDay(F,-1);
 ASalaryInfo[2].ODays:=Round(GetActualTime(Emp.EmpPlant_id,Emp.WorkAbsence_ids,nil,S,F,False));
 ASalaryInfo[2].OHours:=GetActualTime(Emp.EmpPlant_id,Emp.WorkAbsence_ids,nil,S,F,True);
 ASalaryInfo[3].NDays:=Round(GetNormalTime(GetEmpPlantSchedule(Emp.EmpPlant_id),nil,S,F,False,[dtOrdinary,dtFree,dtHoliday]));
 ASalaryInfo[3].NHours:=GetNormalTime(GetEmpPlantSchedule(Emp.EmpPlant_id),nil,S,F,True,[dtOrdinary,dtFree,dtHoliday]);
 DoCalculate;
end;

end.

