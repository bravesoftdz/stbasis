unit NTimeData;

{$I stbasis.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, IBDatabase, IBCustomDataSet, Db, IBQuery, dbgrids, UMainUnited;

type
  TdmNormalTime = class(TDataModule)
    ilNormalTime: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSetMode=(smNone,smRectangle,smCols,smRows,smAll);

const
  IntNameSeat='���������� ����������';
  IntNameDocument='������ ����������';
  
  IntNameSchedule='�������� �������� � ���� �������';
  IntHintSchedule='';
  IntNameShift='���������� ����';
  IntHintShift='';
  IntNameNet='���������� �����';
  IntHintNet='';
  IntNameClass='���������� ��������';
  IntHintClass='';
  IntNameAbsence='���������� ����� ������';
  IntHintAbsence='';
  IntNameCategory='���������� ���������';
  IntHintCategory='';
  IntNameCategoryType='���������� ����� ���������';
  IntHintCategoryType='';
  IntNameSeatClass='������� ����������';
  IntHintSeatClass='';

  SplashCaptionShift='���������� ����';
  MenuItemCaptionShift='�����';
  MenuItemHintShift='';
  tbShift='shift';
  CaptionShiftEdit='�����';
  CaptionShiftSelect='����� �����';
  CaptionShiftAdd='�������� �����';
  CaptionShiftUpdate='�������� �����';
  CaptionShiftDelete='������� ����� <%s>?';
  sqlAddShift='insert into shift (name,addpaypercent,shift_id) values (''%s'',%d,%d)';
  sqlSelShift='select name,addpaypercent from shift where shift_id=%d';
  sqlDelShift='delete from shift where shift_id=%d';
  sqlUpdShift='update shift set name=''%s'',addpaypercent=%d where shift_id=%d';
  sqlSelShiftAll='select shift_id,name,addpaypercent from shift ';
  fldShiftName='name';
  fldShiftShiftID='shift_id';
  fldShiftAddPayPercent='addpaypercent';
  iniLastShift='LastShift';

  tbCalendar='calendar';
  fldCalendarCalendarID='calendar_id';
  fldCalendarStartDate='startdate';
  sqlSelStartDateCalendar='select startdate from calendar where calendar_id=%d';
  iniLastCalendar='LastCalendar';

  SplashCaptionSchedule='�������� �������� � ���� �������';
  MenuItemCaptionSchedule='������� � ����� �������';
  MenuItemHintSchedule='';
  tbSchedule='schedule';
  sqlSelSchedule='select name,avgyear from schedule where schedule_id=%d';
  sqlAddSchedule='insert into schedule (name,avgyear,schedule_id,calendar_id) values (''%s'',%s,%d,%d)';
  sqlUpdSchedule='update schedule set name=''%s'',avgyear=%s,schedule_id=%d where schedule_id=%d';
  sqlDelSchedule='delete from schedule where schedule_id=%d';
  CaptionScheduleEdit='������� � ����� �������';
  CaptionScheduleSelect='����� �������';
  CaptionScheduleAdd='�������� ������';
  CaptionScheduleUpdate='�������� ������';
  CaptionScheduleDelete='������� ������ <%s> ��������� �� %s?';
  fldScheduleScheduleID='schedule_id';
  fldScheduleName='name';
  fldScheduleAvgYear='avgyear';
  iniLastSchedule='LastSchedule';

  SplashCaptionNet='���������� �����';
  MenuItemCaptionNet='�����';
  MenuItemHintNet='';
  tbNet='net';

  SplashCaptionClass='���������� ��������';
  MenuItemCaptionClass='�������';
  MenuItemHintClass='';
  tbClass='class';

  SplashCaptionCategory='���������� ���������';
  MenuItemCaptionCategory='���������';
  MenuItemHintCategory='';
  tbCategory='category';

  SplashCaptionAbsence='���������� ����� ������';
  MenuItemCaptionAbsence='���� ������';
  MenuItemHintAbsence='';
  tbAbsence='absence';
  CaptionAbsenceSelect='����� ���� ������';
  CaptionAbsenceEdit='���� ������';
  CaptionAbsenceAdd='�������� ��� ������';
  CaptionAbsenceUpdate='�������� ��� ������';
  CaptionAbsenceDelete='������� ��� ������ <%s>?';
  fldAbsenceAbsenceID='absence_id';
  fldAbsenceName='name';
  fldAbsenceShortName='shortname';
  sqlAddAbsence='insert into absence (name,shortname,absence_id) values (''%s'',''%s'',%d)';
  sqlSelAbsence='select name,shortname from absence where absence_id=%d';
  sqlUpdAbsence='update absence set name=''%s'',shortname=''%s'' where absence_id=%d';
  sqlDelAbsence='delete from absence where Absence_id=%d';
  sqlSelAbsenceAll='select absence_id,name,shortname from absence ';
  iniLastAbsence='LastAbsence';

  tbSeatClass='seatclass';
  MenuItemCaptionSeatClass='������� ����������';
  MenuItemHintSeatClass='������� ����������';

  SplashCaptionCategoryType='���������� ����� ���������';
  MenuItemCaptionCategoryType='���� ���������';
  MenuItemHintCategoryType='';
  tbCategoryType='categorytype';
  CaptionCategoryTypeEdit='���� ���������';
  CaptionCategoryTypeSelect='����� ���� ���������';
  CaptionCategoryTypeAdd='�������� ��� ���������';
  CaptionCategoryTypeUpdate='�������� ��� ���������';
  CaptionCategoryTypeDelete='������� ��� ��������� <%s>?';
  sqlAddCategoryType='insert into categorytype (name,categorytype_id) values (''%s'',%d)';
  sqlSelCategoryType='select name from categorytype where categorytype_id=%d';
  sqlDelCategoryType='delete from categorytype where categorytype_id=%d';
  sqlUpdCategoryType='update categorytype set name=''%s'' where categorytype_id=%d';
  sqlSelCategoryTypeAll='select categorytype_id,name from categorytype ';
  fldCategoryTypeCategoryTypeID='categorytype_id';
  fldCategoryTypeName='name';
  iniLastCategoryType='LastCategoryType';

  tbNormalTime='normaltime';
  fldNormalTimeWorkDate='workdate';
  fldNormalTimeShiftID='shift_id';
  fldNormalTimeTimeCount='timecount';
  iniLastNormalTime='LastNormalTime';
var
  isInitData: Boolean=False;

  dmNormalTime: TdmNormalTime;
  dbSTBasis: TIBDatabase;
  trDefault: TIBTransaction;

  ListOptionHandles: TList;
  ListToolBarHandles: TList;
  ListInterfaceHandles: TList;
  ListMenuHandles: TList;

  hInterfaceRbkSchedule: THandle;
  hInterfaceRbkShift: THandle;
  hInterfaceRbkNet: THandle;
  hInterfaceRbkClass: THandle;
  hInterfaceRbkAbsence: THandle;
  hInterfaceRbkCategory: THandle;
  hInterfaceRbkCategoryType: THandle;
  hInterfaceRbkSeatClass: THandle;

  hMenuRBooks: THandle;

  hMenuRBooksSchedule: THandle;
  hMenuRBooksShift: THandle;
  hMenuRBooksNet: THandle;
  hMenuRBooksClass: THandle;
  hMenuRBooksAbsence: THandle;
  hMenuRBooksCategory: THandle;
  hMenuRBooksCategoryType: THandle;
  hMenuRBooksSeatClass: THandle;

  hToolButtonSchedule: THandle;
  hToolButtonShift: THandle;
  hToolButtonNet: THandle;
  hToolButtonClass: THandle;
  hToolButtonAbsence: THandle;
  hToolButtonCategory: THandle;
  hToolButtonCategoryType: THandle;
  hToolButtonSeatClass: THandle;

procedure ReturnModalParamsFromDataSetAndGrid(DataSet: TDataSet; Grd: TCustomDBGrid; Param: PParamRBookInterface);

implementation

{$R *.DFM}

procedure ReturnModalParamsFromDataSetAndGrid(DataSet: TDataSet; Grd: TCustomDBGrid; Param: PParamRBookInterface);
var
  i{,j}: Integer;
begin
  if DataSet=nil then exit;
  if Grd=nil then exit;
  if DataSet.IsEmpty then exit;
  DataSet.DisableControls;
  try
   SetLength(Param.Result,DataSet.FieldCount);
   for i:=0 to DataSet.FieldCount-1 do
     Param.Result[i].FieldName:=DataSet.Fields[i].FieldName;
{   if Param.Visual.MultiSelect then begin
     for i:=0 to DataSet.FieldCount-1 do begin
       for j:=0 to Grd.SelectedRows.Count-1 do begin
         SetLength(Param.Result[i].Values,Grd.SelectedRows.Count);
         DataSet.GotoBookmark(pointer(Grd.SelectedRows.Items[j]));
         Param.Result[i].Values[j]:=DataSet.Fields[i].Value;
       end;
     end;
    end else begin}
      for i:=0 to DataSet.FieldCount-1 do begin
         SetLength(Param.Result[i].Values,1);
         Param.Result[i].Values[0]:=DataSet.Fields[i].Value;
      end;
//    end;
  finally
   DataSet.EnableControls;
  end;
end;

end.
