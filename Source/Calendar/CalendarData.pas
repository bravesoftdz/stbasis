unit CalendarData;

{$I stbasis.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, DB, DBGrids, IBDatabase, UMainUnited;


type
  TdmCalendar = class(TDataModule)
    ilCalendar: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSelMode=(slmNone,slmRectangle,slmCols,slmRows,slmAll);

const
  tlbCaptionActualTime='���� �������� �������';
  tlbHintActualTime='';

  IntNameDocunents='������ ����������';
  fldDocumentsDocID='docum_id';
  fldDocumentsName='num';

  IntNameCalendar='���������� ����������';
  IntHintCalendar='';
  IntNameCalendarView='�������� ���������';
  IntHintCalendarView='';
  MenuItemCaptionCalendarView='�������� ���������';
  MenuItemHintCalendarView='�������� ��������� � ������������� ����';
  MenuItemCaptionCalendarEdit='�������� ����������';
  MenuItemHintCalendarEdit='�������������� ����������, ����������, ���������';
  FormCaptionCalendarEdit='�������� ����������';
  FormCaptionCalendarSelect='����� ���������';
  FormCaptionHolidaySelect='����� ���������';
  FormCaptionCarrySelect='����� ��������';
  tbCalendar='calendar';
  fldCalendarCalendarID='calendar_id';
  fldCalendarStartDate='startdate';
  sqlSelStartDateCalendar='select startdate from calendar where calendar_id=%d';
  tbHoliday='holiday';
  tbCarry='carry';
  fldCarryCarryID='carry_id';
  fldHolidayHolidayID='holiday_id';

  IntNameChargeGroup='���������� ����� ����������';
  IntHintChargeGroup='���������� ����� ����������';
//  SplashCaptionChargeGroup='���������� ����� ����������';
  MenuItemCaptionChargeGroup='������ ����������';
  MenuItemHintChargeGroup='';
  CaptionChargeGroupSelect='����� ������ ����������';
  CaptionChargeGroupEdit='������ ����������';
  CaptionChargeGroupAdd='�������� ������ ����������';
  CaptionChargeGroupUpdate='�������� ������ ����������';
  CaptionChargeGroupDelete='������� ������ ���������� <%s>?';
  fldChargeGroupChargeGroupID='chargegroup_id';
  fldChargeGroupName='name';
  fldChargeGroupCode='code';
  fldChargeGroupGroupID='group_id';
  tbChargeGroup='chargegroup';
  sqlAddChargeGroup='insert into chargegroup (name,code,group_id,chargegroup_id) values (''%s'',''%s'',%s,%d)';
  sqlSelChargeGroup='select name,code,group_id from chargegroup where chargegroup_id=%d';
  sqlUpdChargeGroup='update chargegroup set name=''%s'',code=''%s'',group_id=%s where chargegroup_id=%d';
  sqlDelChargeGroup='delete from chargegroup where chargegroup_id=%d';
  sqlSelChargeGroupAll='select chargegroup_id,name,code,group_id from chargegroup ';

  IntNameRoundType='���������� ����� ����������';
  IntHintRoundType='���������� ����� ����������';
//  SplashCaptionRoundType='���������� ����� ����������';
  MenuItemCaptionRoundType='���� ����������';
  MenuItemHintRoundType='';
  CaptionRoundTypeSelect='����� ���� ����������';
  CaptionRoundTypeEdit='���� ����������';
  CaptionRoundTypeAdd='�������� ��� ����������';
  CaptionRoundTypeUpdate='�������� ��� ����������';
  CaptionRoundTypeDelete='������� ��� ���������� <%s>?';
  fldRoundTypeRoundTypeID='roundtype_id';
  fldRoundTypeName='name';
  fldRoundTypeFactor='factor';
  tbRoundType='roundtype';
  sqlAddRoundType='insert into roundtype (name,factor,roundtype_id) values (''%s'',%d,%d)';
  sqlSelRoundType='select name,factor from roundtype where roundtype_id=%d';
  sqlUpdRoundType='update roundtype set name=''%s'',factor=%d where roundtype_id=%d';
  sqlDelRoundType='delete from roundtype where roundtype_id=%d';
  sqlSelRoundTypeAll='select roundtype_id,name,factor from roundtype ';

  tbDivergence='divergence';

  fldShiftShiftID='shift_id';
  fldShiftName='name';

  IntNameActualTime='����������� ���������';
  IntHintActualTime='����������� ���������';
  MenuItemCaptionActualTime='����������� ���������';
  MenuItemHintActualTime='';
  tbActualTime='actualtime';

var
  isInitData: Boolean=False;
  
  dmCalendar: TdmCalendar;
  dbSTBasis: TIBDatabase;
  trDefault: TIBTransaction;

  ListOptionHandles: TList;
  ListToolBarHandles: TList;
  ListInterfaceHandles: TList;
  ListMenuHandles: TList;

  hMenuRBooks,hMenuService: THandle;

  hMenuRBooksCalendar: THandle;
  hInterfaceRbkCalendar: THandle;
  hToolButtonCalendar: THandle;

  hMenuRBooksCalendarView: THandle;
  hInterfaceRbkCalendarView: THandle;
  hToolButtonCalendarView: THandle;

  hMenuRBooksActualTime: THandle;
  hInterfaceRbkActualTime: THandle;
  hToolButtonActualTime: THandle;

  hMenuRBooksChargeGroup: THandle;
  hInterfaceRbkChargeGroup: THandle;
  hToolButtonChargeGroup: THandle;

  hMenuRBooksRoundType: THandle;
  hInterfaceRbkRoundType: THandle;
  hToolButtonRoundType: THandle;

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
