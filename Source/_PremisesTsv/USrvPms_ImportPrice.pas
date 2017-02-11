unit USrvPms_ImportPrice;

interface
{$I stbasis.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  USrvMain, StdCtrls, ExtCtrls, Buttons, tsvDbGrid, Db, dbgrids,
  RxMemDS, IBDatabase, IBCustomDataSet, IBQuery, comctrls, Grids, tsvValedit,
  Menus, DBClient;

type
  TTypeCondition=(tcRBook,tcField);

  TfmSrvPms_ImportPrice = class(TfmSrvMain)
    od: TOpenDialog;
    pnBut: TPanel;
    bibLoad: TButton;
    pnGrbBack: TPanel;
    spl: TSplitter;
    pnGrid: TPanel;
    ds: TDataSource;
    bibImport: TButton;
    bibBreak: TButton;
    bibClose: TButton;
    qr: TIBQuery;
    tran: TIBTransaction;
    lbCount: TLabel;
    grbCondition: TGroupBox;
    pnBackCondition: TPanel;
    pnConditionPlus: TPanel;
    pnValEdit: TPanel;
    bibLoadCondition: TButton;
    bibSaveCondition: TButton;
    odCondition: TOpenDialog;
    sdCondition: TSaveDialog;
    cmbTypeOperation: TComboBox;
    lbTypeOperation: TLabel;
    lbTypePremises: TLabel;
    edTypePremises: TEdit;
    bibTypePremises: TButton;
    lbUnitPrice: TLabel;
    edUnitPrice: TEdit;
    bibUnitPrice: TButton;
    pmGrid: TPopupMenu;
    miSaveGridToFile: TMenuItem;
    miLoadGridFromFile: TMenuItem;
    sdGrid: TSaveDialog;
    cds: TClientDataSet;
    odGrid: TOpenDialog;
    miClearGrid: TMenuItem;
    lbGrid: TLabel;
    miDeleteGrid: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bibLoadClick(Sender: TObject);
    procedure bibCloseClick(Sender: TObject);
    procedure bibBreakClick(Sender: TObject);
    procedure bibImportClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bibLoadConditionClick(Sender: TObject);
    procedure bibSaveConditionClick(Sender: TObject);
    procedure bibTypePremisesClick(Sender: TObject);
    procedure edTypePremisesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edUnitPriceKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bibUnitPriceClick(Sender: TObject);
    procedure miSaveGridToFileClick(Sender: TObject);
    procedure miLoadGridFromFileClick(Sender: TObject);
    procedure miClearGridClick(Sender: TObject);
    procedure miDeleteGridClick(Sender: TObject);
  private
    ListLogItems: TList;
    strCondition: TStringList;
    pms_typepremises_id: Variant;
    pms_unitprice_id: Variant;

    sidTypeRoom,sidPlanning,sidPhone,sidSaleStatus,sidDocument,sidTypeHouse,sidUnitPrice,
    sidBalcony,sidCondition,sidStove,sidSanitaryNode,sidSelfForm,sidTypePremises,
    sidAgent,sidStation,sidRegion,sidStreet,sidCountRoom,sidFurniture,sidDoor,
    sidHeat,sidWater,sidBuilder,sidCityRegion: TStringList;

    LastKey: Word;
    vlEditor: TValueListEditor;
    procedure OnRptLoadTerminate(Sender: TObject);
    procedure OnRptImportTerminate(Sender: TObject);
    procedure MemTableAfterScroll(DataSet: TDataSet);
    procedure GridEditButtonClick(Sender: TObject);

    function CheckFieldsFill: Boolean;

    procedure FillCondition;
    procedure FillRBooks;

    procedure FillsidTypeRoom;
    procedure FillsidPlanning;
    procedure FillsidPhone;
    procedure FillsidSaleStatus;
    procedure FillsidDocument;
    procedure FillsidTypeHouse;
    procedure FillsidBalcony;
    procedure FillsidCondition;
    procedure FillsidStove;
    procedure FillsidSanitaryNode;
    procedure FillsidSelfForm;
    procedure FillsidTypePremises;
    procedure FillsidAgent;
    procedure FillsidStation;
    procedure FillsidRegion;
    procedure FillsidCityRegion;
    procedure FillsidStreet;
    procedure FillsidCountRoom;
    procedure FillsidFurniture;
    procedure FillsidDoor;
    procedure FillsidUnitPrice;
    procedure FillsidHeat;
    procedure FillsidWater;
    procedure FillsidBuilder;

    procedure LoadConditionFromFile(const FileName: string);
    procedure SaveConditionToFile(const FileName: string);

    procedure ClearListLogItems;
    function GetImportLogItemByHandle(LogItemHandle: THandle): Pointer;
    function GetImportLogItemById(id: Integer): Pointer;
    procedure FreeListLogItem(P: Pointer);
    procedure AddToListLogItems(Text: string; id: Integer);

    procedure MemTableBeforeDelete(DataSet: TDataSet);
    procedure ClearGrid;
  public
    NumRelease: string;
    NoteRelease: string;
    release_id: Integer;
    Grid: TNewDBgrid;
    MemTable: TRxMemoryData;

    procedure SaveToIni;override;
    procedure LoadFromIni;override;

    procedure ViewCount;
  end;

var
  fmSrvPms_ImportPrice: TfmSrvPms_ImportPrice;

implementation

uses UPremisesTsvData, UMainUnited, UPremisesTsvCode, StrUtils, UPremisesTsvOptions,
     ActiveX, comobj, StbasisSUtils;

{$R *.DFM}

var
  IndexEmpty: Integer;
  IndexDateArrivals: Integer;
  IndexTypeRoom: Integer;
  IndexPlanning: Integer;
  IndexPhone: Integer;
  IndexSaleStatus: Integer;
  IndexDocument: Integer;
  IndexTypeHouse: Integer;
  IndexGeneralArea: Integer;
  IndexDwellingArea: Integer;
  IndexKitchenArea: Integer;
  IndexAllArea1: Integer;
  IndexAllArea2: Integer;
  IndexBalcony: Integer;
  IndexCondition: Integer;
  IndexStove: Integer;
  IndexSanitaryNode: Integer;
  IndexSelfForm: Integer;
  IndexTypePremises: Integer;
  IndexPrice: Integer;
  IndexNote: Integer;
  IndexContact: Integer;
  IndexContactPlus: Integer;
  IndexClientInfo: Integer;
  IndexAgent: Integer;
  IndexStation: Integer;
  IndexRegion: Integer;
  IndexStreet: Integer;
  IndexHouseNumber: Integer;
  IndexApartmentNumber: Integer;
  IndexHouseApartment1: Integer;
  IndexCountRoom: Integer;
  IndexFloor: Integer;
  IndexCountFloor: Integer;
  IndexFurniture: Integer;
  IndexDoor: Integer;
  IndexTerm: Integer;
  IndexPayment: Integer;
  IndexTermPayment1: Integer;
  IndexTermPayment2: Integer;
  IndexDateUpdate: Integer;
  IndexUnitPrice: Integer;
  IndexPriceUnitPrice: Integer;
  IndexHeat: Integer;
  IndexWater: Integer;
  IndexBuilder: Integer;
  IndexDelivery: Integer;
  IndexNN: Integer;
  IndexCityRegion: Integer;
  IndexPrice2: Integer;
  IndexGlassy: Integer;
  IndexDecoration: Integer;


type
  PInfo=^TInfo;
  TInfo=packed record
    FieldName: string;
    Condition: TTypeCondition;
  end;

  PImportLogItem=^TImportLogItem;
  TImportLogItem=packed record
    hLogItem: THandle;
    id: Integer;
  end;

type
  TThreadLoad=class(TObject)
  private
    FCurPB: THandle;
    procedure FreeCurPB;
  public
    fmParent: TfmSrvPms_ImportPrice;
    Terminated: Boolean;
    OnTerminate: TNotifyEvent;
    constructor Create;
    destructor Destroy;override;
    procedure Execute;
    procedure DoTerminate;
    procedure Terminate;
  end;


  TThreadImport=class(TObject)
  private
    FCurPB: THandle;
    procedure FreeCurPB;
  public
    Terminated: Boolean;
    OnTerminate: TNotifyEvent;
    fmParent: TfmSrvPms_ImportPrice;
    constructor Create;
    destructor Destroy;override;
    procedure Execute;
    procedure DoTerminate;
    procedure Terminate;
  end;


var
  RptLoad: TThreadLoad;
  RptImport: TThreadImport;

{ TThreadLoad }

constructor TThreadLoad.Create;
begin
//  Priority:=tpNormal;
  inherited Create;
end;

procedure TThreadLoad.FreeCurPB;
var
  TSPBS: TSetProgressBarStatus;
begin
  FillCHar(TSPBS,SizeOf(TSPBS),0);
  TSPBS.Progress:=0;
  _SetProgressBarStatus(FCurPB,@TSPBS);
  _FreeProgressBar(FCurPB);
end;

destructor TThreadLoad.Destroy;
begin
  FreeCurPB;
//  TerminateThread(Handle,0);
  inherited Destroy;
end;

procedure TThreadLoad.Terminate;
begin
  Terminated:=true;
end;

procedure TThreadLoad.Execute;

  function GetIdByStrings(str: TStringList; S: string): Variant;
  var
    val: Integer;
  begin
    val:=str.IndexOf(S);
    if val<>-1 then begin
      Result:=Integer(str.Objects[val]);
    end else begin
      Result:=Null;
    end;
  end;

  procedure SetArea(V: OleVariant; Delim: string);
  var
    tmps: string;
    s1: string;
    Apos: Integer;
  begin
    tmps:=V;
    if Trim(tmps)='' then V:=null
    else V:=tmps;
    Apos:=Pos(Delim,tmps);
    if Apos>0 then begin
      s1:=Copy(tmps,1,APos-1);
      if Trim(s1)='' then V:=null
      else V:=Trim(s1);
      fmParent.MemTable.FieldByName('GeneralArea').Value:=V;
      tmps:=Copy(tmps,APos+Length(Delim),Length(tmps));
      if Trim(tmps)='' then V:=null
      else V:=Trim(tmps);
      Apos:=Pos(Delim,tmps);
      if APos>0 then begin
        s1:=Copy(tmps,1,APos-1);
        if Trim(s1)='' then V:=null
        else V:=Trim(s1);
        fmParent.MemTable.FieldByName('DwellingArea').Value:=V;
        tmps:=Copy(tmps,APos+Length(Delim),Length(tmps));
        if Trim(tmps)='' then V:=null
        else V:=Trim(tmps);
        fmParent.MemTable.FieldByName('KitchenArea').Value:=V;
      end else fmParent.MemTable.FieldByName('DwellingArea').Value:=V;
    end else fmParent.MemTable.FieldByName('GeneralArea').Value:=V;
  end;

  procedure SetHouseApartment(V: OleVariant; Delim: string);
  var
    tmps: string;
    s1: string;
    Apos: Integer;
  begin
    tmps:=V;
    if Trim(tmps)='' then V:=null
    else V:=tmps;
    Apos:=Pos(Delim,tmps);
    if Apos>0 then begin
      s1:=Copy(tmps,1,APos-1);
      if Trim(s1)='' then V:=null
      else V:=Trim(s1);
      fmParent.MemTable.FieldByName('housenumber').Value:=V;
      tmps:=Copy(tmps,APos+Length(Delim),Length(tmps));
      if Trim(tmps)='' then V:=null
      else V:=Trim(tmps);
      fmParent.MemTable.FieldByName('apartmentnumber').Value:=V;
    end else fmParent.MemTable.FieldByName('housenumber').Value:=V;
  end;

  procedure SetTermPayment(V: OleVariant; Delim: string);
  var
    tmps: string;
    s1: string;
    Apos: Integer;
  begin
    tmps:=V;
    if Trim(tmps)='' then V:=null
    else V:=tmps;
    Apos:=Pos(Delim,tmps);
    if Apos>0 then begin
      s1:=Copy(tmps,1,APos-1);
      if Trim(s1)='' then V:=null
      else V:=Trim(s1);
      fmParent.MemTable.FieldByName('term').Value:=V;
      tmps:=Copy(tmps,APos+Length(Delim),Length(tmps));
      if Trim(tmps)='' then V:=null
      else V:=Trim(tmps);
      fmParent.MemTable.FieldByName('payment').Value:=V;
    end else fmParent.MemTable.FieldByName('term').Value:=V;
  end;

  procedure SetPriceUnitPrice(V: OleVariant);
  var
    i: Integer;
    s: string;
    snew: string;
    id: Variant;
    V1: OleVariant;
  begin
    V1:='';
    if Trim(V)='' then V:='';
    if V<>null then begin
      s:=V;
      if not isFloat(s) then begin
        for i:=1 to Length(s) do begin
          if i=1 then begin
            snew:=s[i];
            V1:=snew;
          end else begin
            if isFloat(snew+s[i]) then begin
              snew:=snew+s[i];
            end else begin
              V1:=Copy(s,i,Length(s));
              V:=snew;
              break;
            end;
          end;
        end;
      end;  
    end;
    fmParent.MemTable.FieldByName('price').Value:=iff(isFloat(V),V,Null);
    id:=GetIdByStrings(fmParent.sidUnitPrice,V1);
    if id<>Null then begin
      fmParent.MemTable.FieldByName('UnitPricename').Value:=V1;
      fmParent.MemTable.FieldByName('pms_UnitPrice_id').Value:=id;
    end;
  end;

  procedure SetContactPlus(V: OleVariant);
  const
    Delim=',';
    Space=' ';

    function PrepearStr(s: string): string;
    var
      i: Integer;
    begin
      Result:='';
      s:=ChangeString(s,' ','');
      for i:=1 to Length(s) do begin
        if isInteger(Result+s[i]) then begin
          Result:=Result+s[i];
        end else begin
          Result:=Result+Space+Copy(s,i,Length(s));
          break;
        end;
      end;
    end;

  var
    s,s1,news: string;
    Apos: Integer;
  begin
    s:=V;
    s1:=s;
    Apos:=-1;
    while APos<>0 do begin
      APos:=AnsiPos(Delim,s);
      if APos>0 then begin
        s1:=Copy(s,1,Apos-1);
        s:=Copy(s,APos+Length(Delim),Length(s));
      end else s1:=s;
      if Trim(news)='' then
        news:=Trim(PrepearStr(s1))
      else news:=news+Delim+Space+Trim(PrepearStr(s1));
    end;
    fmParent.MemTable.FieldByName('contact').Value:=iff(Trim(news)<>'',Trim(news),Null);
  end;

  procedure AppendToMemTable(V: OleVariant; Col: Integer);
  var
    s: string;
    Index: integer;
    id: Variant;
  begin
    if (Col<0) or (Col>fmParent.vlEditor.RowCount-1) then exit;
    s:=fmParent.vlEditor.Values[inttostr(Col)];
    Index:=fmParent.strCondition.IndexOf(s);
    if Index=IndexEmpty then exit;
    if Index=IndexDateArrivals then begin
      if Trim(V)='' then V:=Null
      else if not isDate(V) then
       raise Exception.CreateFmt(fmtBadFieldType,[fmParent.strCondition.Strings[IndexDateArrivals]]);
      fmParent.MemTable.FieldByName('datearrivals').Value:=V;
    end;
    if Index=IndexTypeRoom then begin
      id:=GetIdByStrings(fmParent.sidTypeRoom,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('typeroomname').Value:=V;
        fmParent.MemTable.FieldByName('pms_typeroom_id').Value:=id;
      end;
    end;
    if Index=IndexPLanning then begin
      id:=GetIdByStrings(fmParent.sidPlanning,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('Planningname').Value:=V;
        fmParent.MemTable.FieldByName('pms_Planning_id').Value:=id;
      end;
    end;
    if Index=IndexPhone then begin
      id:=GetIdByStrings(fmParent.sidPhone,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('Phonename').Value:=V;
        fmParent.MemTable.FieldByName('pms_Phone_id').Value:=id;
      end;
    end;
    if Index=IndexSaleStatus then begin
      id:=GetIdByStrings(fmParent.sidSaleStatus,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('SaleStatusname').Value:=V;
        fmParent.MemTable.FieldByName('pms_SaleStatus_id').Value:=id;
      end;
    end;
    if Index=IndexDocument then begin
      id:=GetIdByStrings(fmParent.sidDocument,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('Documentname').Value:=V;
        fmParent.MemTable.FieldByName('pms_Document_id').Value:=id;
      end;
    end;
    if Index=IndexTypeHouse then begin
      id:=GetIdByStrings(fmParent.sidTypeHouse,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('TypeHousename').Value:=V;
        fmParent.MemTable.FieldByName('pms_TypeHouse_id').Value:=id;
      end;
    end;
    if Index=IndexBalcony then begin
      id:=GetIdByStrings(fmParent.sidBalcony,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('Balconyname').Value:=V;
        fmParent.MemTable.FieldByName('pms_Balcony_id').Value:=id;
      end;
    end;
    if Index=IndexHeat then begin
      id:=GetIdByStrings(fmParent.sidHeat,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('heatname').Value:=V;
        fmParent.MemTable.FieldByName('pms_heat_id').Value:=id;
      end;
    end;
    if Index=IndexWater then begin
      id:=GetIdByStrings(fmParent.sidWater,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('watername').Value:=V;
        fmParent.MemTable.FieldByName('pms_water_id').Value:=id;
      end;
    end;
    if Index=IndexBuilder then begin
      id:=GetIdByStrings(fmParent.sidBuilder,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('buildername').Value:=V;
        fmParent.MemTable.FieldByName('pms_builder_id').Value:=id;
      end;
    end;
    if Index=IndexCondition then begin
      id:=GetIdByStrings(fmParent.sidCondition,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('Conditionname').Value:=V;
        fmParent.MemTable.FieldByName('pms_Condition_id').Value:=id;
      end;
    end;
    if Index=IndexStove then begin
      id:=GetIdByStrings(fmParent.sidStove,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('Stovename').Value:=V;
        fmParent.MemTable.FieldByName('pms_Stove_id').Value:=id;
      end;
    end;
    if Index=IndexSanitaryNode then begin
      id:=GetIdByStrings(fmParent.sidSanitaryNode,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('SanitaryNodename').Value:=V;
        fmParent.MemTable.FieldByName('pms_SanitaryNode_id').Value:=id;
      end;
    end;
    if Index=IndexSelfForm then begin
      id:=GetIdByStrings(fmParent.sidSelfForm,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('SelfFormname').Value:=V;
        fmParent.MemTable.FieldByName('pms_SelfForm_id').Value:=id;
      end;
    end;
    if Index=IndexTypePremises then begin
      id:=GetIdByStrings(fmParent.sidTypePremises,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('TypePremisesname').Value:=V;
        fmParent.MemTable.FieldByName('pms_TypePremises_id').Value:=id;
      end;
    end;
    if Index=IndexAgent then begin
      id:=GetIdByStrings(fmParent.sidAgent,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('Agentname').Value:=V;
        fmParent.MemTable.FieldByName('pms_Agent_id').Value:=id;
      end;
    end;
    if Index=IndexStation then begin
      id:=GetIdByStrings(fmParent.sidStation,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('Stationname').Value:=V;
        fmParent.MemTable.FieldByName('pms_Station_id').Value:=id;
      end;
    end;
    if Index=IndexRegion then begin
      id:=GetIdByStrings(fmParent.sidRegion,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('Regionname').Value:=V;
        fmParent.MemTable.FieldByName('pms_Region_id').Value:=id;
      end;
    end;
    if Index=IndexCityRegion then begin
      id:=GetIdByStrings(fmParent.sidCityRegion,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('Cityregionname').Value:=V;
        fmParent.MemTable.FieldByName('pms_city_Region_id').Value:=id;
      end;
    end;
    if Index=IndexStreet then begin
      id:=GetIdByStrings(fmParent.sidStreet,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('Streetname').Value:=V;
        fmParent.MemTable.FieldByName('pms_Street_id').Value:=id;
      end;
    end;
    if Index=IndexCountRoom then begin
      id:=GetIdByStrings(fmParent.sidCountRoom,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('CountRoomname').Value:=V;
        fmParent.MemTable.FieldByName('pms_CountRoom_id').Value:=id;
      end;
    end;
    if Index=IndexFurniture then begin
      id:=GetIdByStrings(fmParent.sidFurniture,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('Furniturename').Value:=V;
        fmParent.MemTable.FieldByName('pms_Furniture_id').Value:=id;
      end;
    end;
    if Index=IndexDoor then begin
      id:=GetIdByStrings(fmParent.sidDoor,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('Doorname').Value:=V;
        fmParent.MemTable.FieldByName('pms_Door_id').Value:=id;
      end;
    end;
    if Index=IndexUnitPrice then begin
      id:=GetIdByStrings(fmParent.sidUnitPrice,V);
      if id<>Null then begin
        fmParent.MemTable.FieldByName('UnitPricename').Value:=V;
        fmParent.MemTable.FieldByName('pms_UnitPrice_id').Value:=id;
      end;
    end;
    if Index=IndexGeneralArea then begin
      if Trim(V)='' then V:=Null
      else if not isFloat(V) then
       raise Exception.CreateFmt(fmtBadFieldType,[fmParent.strCondition.Strings[IndexGeneralArea]]);
      fmParent.MemTable.FieldByName('GeneralArea').Value:=V;
    end;
    if Index=IndexDwellingArea then begin
      if Trim(V)='' then V:=Null
      else if not isFloat(V) then
       raise Exception.CreateFmt(fmtBadFieldType,[fmParent.strCondition.Strings[IndexDwellingArea]]);
      fmParent.MemTable.FieldByName('DwellingArea').Value:=V;
    end;
    if Index=IndexKitchenArea then begin
      if Trim(V)='' then V:=Null
      else if not isFloat(V) then
       raise Exception.CreateFmt(fmtBadFieldType,[fmParent.strCondition.Strings[IndexKitchenArea]]);
      fmParent.MemTable.FieldByName('KitchenArea').Value:=V;
    end;
    if Index=IndexPrice then begin
      if Trim(V)='' then V:=Null
      else if not isFloat(V) then
       raise Exception.CreateFmt(fmtBadFieldType,[fmParent.strCondition.Strings[IndexPrice]]);
      fmParent.MemTable.FieldByName('Price').Value:=V;
    end;
    if Index=IndexNote then begin
      if Trim(V)='' then V:=Null;
      if fmParent.MemTable.FieldByName('note').Value<>Null then begin
        if V<>Null then begin
          fmParent.MemTable.FieldByName('note').Value:=fmParent.MemTable.FieldByName('note').Value+' '+V;
        end else begin
          fmParent.MemTable.FieldByName('note').Value:=fmParent.MemTable.FieldByName('note').Value;
        end;
      end else fmParent.MemTable.FieldByName('note').Value:=V;
    end;
    if Index=IndexContact then begin
      if Trim(V)='' then V:=Null;
      if fmParent.MemTable.FieldByName('contact').Value<>Null then begin
        if V<>Null then begin
          fmParent.MemTable.FieldByName('contact').Value:=fmParent.MemTable.FieldByName('contact').Value+', '+V;
        end else begin
          fmParent.MemTable.FieldByName('contact').Value:=fmParent.MemTable.FieldByName('contact').Value;
        end;
      end else fmParent.MemTable.FieldByName('contact').Value:=V;
    end;
    if Index=IndexClientInfo then begin
      if Trim(V)='' then V:=Null;
      fmParent.MemTable.FieldByName('clientinfo').Value:=V;
    end;
    if Index=IndexDelivery then begin
      if Trim(V)='' then V:=Null;
      fmParent.MemTable.FieldByName('delivery').Value:=V;
    end;
    if Index=IndexHouseNumber then begin
      if Trim(V)='' then V:=Null;
      fmParent.MemTable.FieldByName('housenumber').Value:=V;
    end;
    if Index=IndexApartmentNumber then begin
      if Trim(V)='' then V:=Null;
      fmParent.MemTable.FieldByName('apartmentnumber').Value:=V;
    end;
    if Index=IndexFloor then begin
      if Trim(V)='' then V:=Null;
      fmParent.MemTable.FieldByName('floor').Value:=V;
    end;
    if Index=IndexCountFloor then begin
      if Trim(V)='' then V:=Null
      else if not isInteger(V) then
       raise Exception.CreateFmt(fmtBadFieldType,[fmParent.strCondition.Strings[IndexCountFloor]]);
      fmParent.MemTable.FieldByName('countfloor').Value:=V;
    end;
    if Index=IndexTerm then begin
      if Trim(V)='' then V:=Null;
      fmParent.MemTable.FieldByName('term').Value:=V;
    end;
    if Index=IndexPayment then begin
      if Trim(V)='' then V:=Null;
      fmParent.MemTable.FieldByName('payment').Value:=V;
    end;
    if Index=IndexDateUpdate then begin
      if Trim(V)='' then V:=Null
      else if not isDateTime(V) then
       raise Exception.CreateFmt(fmtBadFieldType,[fmParent.strCondition.Strings[IndexDateUpdate]]);
      fmParent.MemTable.FieldByName('dateupdate').Value:=V;
    end;
    if Index=IndexAllArea1 then begin
      try
        SetArea(V,'/');
      except
        raise Exception.CreateFmt(fmtBadFieldType,[fmParent.strCondition.Strings[IndexAllArea1]]);
      end;  
    end;
    if Index=IndexAllArea2 then begin
      try
        SetArea(V,'\');
      except
        raise Exception.CreateFmt(fmtBadFieldType,[fmParent.strCondition.Strings[IndexAllArea2]]);
      end;
    end;
    if Index=IndexHouseApartment1 then begin
      try
        SetHouseApartment(V,'-');
      except
        raise Exception.CreateFmt(fmtBadFieldType,[fmParent.strCondition.Strings[IndexHouseApartment1]]);
      end;
    end;
    if Index=IndexTermPayment1 then begin
      try
        SetTermPayment(V,'\');
      except
        raise Exception.CreateFmt(fmtBadFieldType,[fmParent.strCondition.Strings[IndexTermPayment1]]);
      end;
    end;
    if Index=IndexTermPayment2 then begin
      try
        SetTermPayment(V,'/');
      except
        raise Exception.CreateFmt(fmtBadFieldType,[fmParent.strCondition.Strings[IndexTermPayment2]]);
      end;
    end;
    if Index=IndexPriceUnitPrice then begin
      try
        SetPriceUnitPrice(V);
      except
        raise Exception.CreateFmt(fmtBadFieldType,[fmParent.strCondition.Strings[IndexPriceUnitPrice]]);
      end;
    end;
    if Index=IndexContactPlus then begin
      try
        SetContactPlus(V);
      except
        raise Exception.CreateFmt(fmtBadFieldType,[fmParent.strCondition.Strings[IndexContactPlus]]);
      end;
    end;
    if Index=IndexNN then begin
      if Trim(V)='' then V:=Null;
      fmParent.MemTable.FieldByName('nn').Value:=V;
    end;
    if Index=IndexPrice2 then begin
      if Trim(V)='' then V:=Null
      else if not isFloat(V) then
       raise Exception.CreateFmt(fmtBadFieldType,[fmParent.strCondition.Strings[IndexPrice2]]);
      fmParent.MemTable.FieldByName('Price2').Value:=V;
    end;
    if Index=IndexGlassy then begin
      if Trim(V)='' then V:=Null;
      fmParent.MemTable.FieldByName('glassy').Value:=V;
    end;
    if Index=IndexDecoration then begin
      if Trim(V)='' then V:=Null;
      fmParent.MemTable.FieldByName('decoration').Value:=V;
    end;
  end;

var
  TCPB: TCreateProgressBar;
  TSPBS: TSetProgressBarStatus;
  Excel: OleVariant;
  i,j,rwCount,clCount: Integer;
  wb: OleVariant;
  sh: OleVariant;
  V: OleVariant;
  S: OleVariant;
  pb: THandle;
  Data: OleVariant;
  OldAfterScroll: TDataSetNotifyEvent;
begin
  try
   CoInitialize(nil);
   try
     try
       Excel:=CreateOleObject(ConstExcelOle);
       Excel:=Excel.Application;
       Excel.WorkBooks.Open(fmParent.od.FileName);
       wb:=Excel.WorkBooks.Item[1];
       Sh:=Wb.Sheets.Item[1];
       S:=Excel.Selection;
       if VarIsEmpty(S) then exit;
       rwCount:=S.Rows.Count;
       if rwCount=0 then exit;
       clCount:=S.Columns.Count;
       if clCount=0 then exit;
       Data:=S.Value;
       FillChar(TCPB,SizeOf(TCPB),0);
       TCPB.Min:=0;
       TCPB.Max:=rwCount;
       TCPB.Color:=clNavy;
       pb:=_CreateProgressBar(@TCPB);
       fmParent.MemTable.DisableControls;
       OldAfterScroll:=fmParent.MemTable.AfterScroll;
       fmParent.MemTable.AfterScroll:=nil;
       try
         for i:=1 to rwCount do begin
           Application.ProcessMessages;
           if Terminated then exit;
           fmParent.MemTable.Append;
           fmParent.MemTable.FieldByName('id').AsInteger:=i;
           for j:=1 to clCount do begin
             Application.ProcessMessages;
             if Terminated then exit;
             try
               V:=Data[i,j];
               AppendToMemTable(V,j);
             except
              {$IFDEF DEBUG}
                on E: Exception do begin
                 try
                   fmParent.AddToListLogItems(Format(fmtLoadPriceError,[E.Message,V]),i);
                 except
                 end;
                end;
              {$ENDIF}
             end;
           end;
           fmParent.MemTable.Post;
           FillChar(TSPBS,SizeOf(TSPBS),0);
           TSPBS.Progress:=i;
           TSPBS.Max:=rwCount;
           _SetProgressBarStatus(pb,@TSPBS);
         end;
       finally
         fmParent.MemTable.AfterScroll:=OldAfterScroll;
         fmParent.MemTable.EnableControls;
         FCurPB:=pb;
         FreeCurPB;
       end;
     except
      {$IFDEF DEBUG}
        on E: Exception do begin
         try
           Assert(false,E.message);
         except
           Application.HandleException(nil);
         end;
        end;
      {$ENDIF}
     end;
   finally
     if not VarIsEmpty(Excel) then begin
       Excel.Quit;
     end;
     CoUninitialize;
     DoTerminate;
   end;
  finally

  end;
end;


procedure TThreadLoad.DoTerminate;
begin
  if Assigned(OnTerminate) then
    OnTerminate(Self);
end;

{ TThreadImport }

constructor TThreadImport.Create;
begin
//  Priority:=tpNormal;
  inherited Create;
end;

procedure TThreadImport.FreeCurPB;
var
  TSPBS: TSetProgressBarStatus;
begin
  FillCHar(TSPBS,SizeOf(TSPBS),0);
  TSPBS.Progress:=0;
  _SetProgressBarStatus(FCurPB,@TSPBS);
  _FreeProgressBar(FCurPB);
end;

destructor TThreadImport.Destroy;
begin
  FreeCurPB;
//  TerminateThread(Handle,0);
  inherited Destroy;
end;

procedure TThreadImport.Execute;
var
  incr: Integer;
  TCPB: TCreateProgressBar;
  TSPBS: TSetProgressBarStatus;
  OldAfterScroll: TDataSetNotifyEvent;
  sqls: string;
  qr: TIBQuery;
  tran: TIBTransaction;
  id: string;
  dt: TDateTime;
  CU: TInfoConnectUser;
  mt: TRxMemoryData;
  TCLI: TCreateLogItem;
  pb: THandle;
  isCheckDouble: Boolean;
  sync_id: String;
begin
 try
   try
    if fmParent.MemTable.IsEmpty then exit;
    TCPB.Min:=0;
    TCPB.Max:=fmParent.MemTable.RecordCount-1;
    TCPB.Hint:='';
    TCPB.Color:=clNavy;
    pb:=_CreateProgressBar(@TCPB);
    _SetSplashStatus('������ ������');
    fmParent.MemTable.DisableControls;
    OldAfterScroll:=fmParent.MemTable.AfterScroll;
    fmParent.MemTable.AfterScroll:=nil;
    qr:=TIBQuery.Create(nil);
    tran:=TIBTransaction.Create(nil);
    isCheckDouble:=fmOptions.chbCheckDoubleOnImport.Checked;
    try
     tran.AddDatabase(IBDB);
     IBDB.AddTransaction(tran);
     tran.Params.Text:=DefaultTransactionParamsTwo;
     qr.Database:=IBDB;
     qr.Transaction:=tran;
     qr.ParamCheck:=false;

     dt:=_GetDateTimeFromServer;
     FillChar(CU,SizeOf(TInfoConnectUser),0);
     _GetInfoConnectUser(@CU);
     fmParent.MemTable.First;
     incr:=0;

     SetGenIdByName(IBDB,genCheckPremises,0);

     if isCheckDouble then
       GetGenIdByName(IBDB,genCheckPremises,1);
     repeat
      Application.ProcessMessages;
      if Terminated then exit;
      try
       try
        mt:=fmParent.MemTable;
        if mt.FieldByName('datearrivals').Value=null then
          raise Exception.CreateFmt(fmtImportFieldRequired,[fmParent.strCondition.Strings[IndexDateArrivals]]);
        if mt.FieldByName('pms_region_id').Value=null then
          raise Exception.CreateFmt(fmtImportFieldRequired,[fmParent.strCondition.Strings[IndexRegion]]);
        if mt.FieldByName('pms_street_id').Value=null then
          raise Exception.CreateFmt(fmtImportFieldRequired,[fmParent.strCondition.Strings[IndexStreet]]);
        if mt.FieldByName('pms_countroom_id').Value=null then
          raise Exception.CreateFmt(fmtImportFieldRequired,[fmParent.strCondition.Strings[IndexCountRoom]]);
        if mt.FieldByName('contact').Value=null then
          raise Exception.CreateFmt(fmtImportFieldRequired,[fmParent.strCondition.Strings[IndexContact]]);
        if mt.FieldByName('pms_agent_id').Value=null then
          raise Exception.CreateFmt(fmtImportFieldRequired,[fmParent.strCondition.Strings[IndexAgent]]);

        id:=inttostr(GetGenId(IBDB,tbPms_Premises,1));
        sync_id:=CreateUniqueId;
        
        with fmParent do begin

          sqls:='Insert into '+tbPms_Premises+
                ' (Pms_Premises_id,pms_typehouse_id,pms_stove_id,pms_street_id,whoinsert_id,pms_agent_id,'+
                'pms_door_id,pms_sanitarynode_id,pms_condition_id,whoupdate_id,pms_balcony_id,pms_furniture_id,'+
                'datearrivals,pms_station_id,pms_planning_id,pms_typeroom_id,contact,clientinfo,pms_countroom_id,'+
                'pms_region_id,housenumber,apartmentnumber,pms_phone_id,floor,countfloor,generalarea,'+
                'pms_document_id,dwellingarea,kitchenarea,typeoperation,price,pms_unitprice_id,term,payment,note,datetimeinsert,'+
                'datetimeupdate,pms_salestatus_id,pms_selfform_id,pms_typepremises_id,pms_heat_id,pms_water_id,'+
                'pms_builder_id,delivery,recyled,sync_id,nn,pms_city_region_id,price2,glassy,decoration'+
                ') values '+
                ' ('+id+
                ','+iff(mt.FieldByName('pms_typehouse_id').Value=null,'null',mt.FieldByName('pms_typehouse_id').AsString)+
                ','+iff(mt.FieldByName('pms_Stove_id').Value=null,'null',mt.FieldByName('pms_Stove_id').AsString)+
                ','+iff(mt.FieldByName('pms_Street_id').Value=null,'null',mt.FieldByName('pms_Street_id').AsString)+
                ','+inttostr(CU.User_id)+
                ','+iff(mt.FieldByName('pms_Agent_id').Value=null,'null',mt.FieldByName('pms_Agent_id').AsString)+
                ','+iff(mt.FieldByName('pms_door_id').Value=null,'null',mt.FieldByName('pms_door_id').AsString)+
                ','+iff(mt.FieldByName('pms_sanitarynode_id').Value=null,'null',mt.FieldByName('pms_sanitarynode_id').AsString)+
                ','+iff(mt.FieldByName('pms_condition_id').Value=null,'null',mt.FieldByName('pms_condition_id').AsString)+
                ','+inttostr(CU.User_id)+
                ','+iff(mt.FieldByName('pms_balcony_id').Value=null,'null',mt.FieldByName('pms_balcony_id').AsString)+
                ','+iff(mt.FieldByName('pms_furniture_id').Value=null,'null',mt.FieldByName('pms_furniture_id').AsString)+
                ','+iff(mt.FieldByName('datearrivals').Value=null,'null',QuotedStr(mt.FieldByName('datearrivals').AsString))+
                ','+iff(mt.FieldByName('pms_station_id').Value=null,'null',mt.FieldByName('pms_station_id').AsString)+
                ','+iff(mt.FieldByName('pms_planning_id').Value=null,'null',mt.FieldByName('pms_planning_id').AsString)+
                ','+iff(mt.FieldByName('pms_typeroom_id').Value=null,'null',mt.FieldByName('pms_typeroom_id').AsString)+
                ','+iff(mt.FieldByName('contact').Value=null,'null',QuotedStr(mt.FieldByName('contact').AsString))+
                ','+iff(mt.FieldByName('clientinfo').Value=null,'null',QuotedStr(mt.FieldByName('clientinfo').AsString))+
                ','+iff(mt.FieldByName('pms_countroom_id').Value=null,'null',mt.FieldByName('pms_countroom_id').AsString)+
                ','+iff(mt.FieldByName('pms_region_id').Value=null,'null',mt.FieldByName('pms_region_id').AsString)+
                ','+iff(mt.FieldByName('housenumber').Value=null,'null',QuotedStr(mt.FieldByName('housenumber').AsString))+
                ','+iff(mt.FieldByName('apartmentnumber').Value=null,'null',QuotedStr(mt.FieldByName('apartmentnumber').AsString))+
                ','+iff(mt.FieldByName('pms_phone_id').Value=null,'null',mt.FieldByName('pms_phone_id').AsString)+
                ','+iff(mt.FieldByName('floor').Value=null,'null',QuotedStr(mt.FieldByName('floor').AsString))+
                ','+iff(mt.FieldByName('countfloor').Value=null,'null',QuotedStr(mt.FieldByName('countfloor').AsString))+
                ','+iff(mt.FieldByName('generalarea').Value=null,'null',QuotedStr(ChangeChar(mt.FieldByName('generalarea').AsString,',','.')))+
                ','+iff(mt.FieldByName('pms_document_id').Value=null,'null',mt.FieldByName('pms_document_id').AsString)+
                ','+iff(mt.FieldByName('dwellingarea').Value=null,'null',QuotedStr(ChangeChar(mt.FieldByName('dwellingarea').AsString,',','.')))+
                ','+iff(mt.FieldByName('kitchenarea').Value=null,'null',QuotedStr(ChangeChar(mt.FieldByName('kitchenarea').AsString,',','.')))+
                ','+IntTostr(cmbTypeOperation.ItemIndex)+
                ','+iff(mt.FieldByName('price').Value=null,'null',QuotedStr(ChangeChar(mt.FieldByName('price').AsString,',','.')))+
                ','+iff(mt.FieldByName('pms_unitprice_id').Value=null,iff(Trim(edUnitPrice.Text)='','null',inttostr(pms_unitprice_id)),mt.FieldByName('pms_unitprice_id').AsString)+
                ','+iff(mt.FieldByName('term').Value=null,'null',QuotedStr(mt.FieldByName('term').AsString))+
                ','+iff(mt.FieldByName('payment').Value=null,'null',QuotedStr(mt.FieldByName('payment').AsString))+
                ','+iff(mt.FieldByName('note').Value=null,'null',QuotedStr(mt.FieldByName('note').AsString))+
                ','+QuotedStr(DateTimeToStr(dt))+
                ','+iff(mt.FieldByName('dateupdate').Value=null,QuotedStr(mt.FieldByName('datearrivals').AsString),QuotedStr(mt.FieldByName('dateupdate').AsString))+
                ','+iff(mt.FieldByName('pms_salestatus_id').Value=null,'null',mt.FieldByName('pms_salestatus_id').AsString)+
                ','+iff(mt.FieldByName('pms_selfform_id').Value=null,'null',mt.FieldByName('pms_selfform_id').AsString)+
                ','+iff(mt.FieldByName('pms_typepremises_id').Value=null,iff(Trim(edTypePremises.Text)='','null',inttostr(pms_typepremises_id)),mt.FieldByName('pms_typepremises_id').AsString)+
                ','+iff(mt.FieldByName('pms_heat_id').Value=null,'null',mt.FieldByName('pms_heat_id').AsString)+
                ','+iff(mt.FieldByName('pms_water_id').Value=null,'null',mt.FieldByName('pms_water_id').AsString)+
                ','+iff(mt.FieldByName('pms_builder_id').Value=null,'null',mt.FieldByName('pms_builder_id').AsString)+
                ','+iff(mt.FieldByName('delivery').Value=null,'null',QuotedStr(mt.FieldByName('delivery').AsString))+
                ','+inttostr(0)+
                ','+QuotedStr(sync_id)+
                ','+QuotedStr(mt.FieldByName('nn').AsString)+
                ','+iff(mt.FieldByName('pms_city_region_id').Value=null,'null',mt.FieldByName('pms_city_region_id').AsString)+
                ','+iff(mt.FieldByName('price2').Value=null,'null',QuotedStr(ChangeChar(mt.FieldByName('price2').AsString,',','.')))+
                ','+QuotedStr(mt.FieldByName('glassy').AsString)+
                ','+QuotedStr(mt.FieldByName('decoration').AsString)+
                ')';

        end;
        qr.SQL.Clear;
        qr.SQL.Add(sqls);
        qr.Transaction.Active:=true;
        qr.ExecSQL;
        qr.Transaction.Commit;

        fmParent.MemTable.Delete;
       except
        {$IFDEF DEBUG}
          on E: Exception do begin
           try
             fmParent.AddToListLogItems(TranslateIBError(E.Message),fmParent.MemTable.FieldByName('id').AsInteger);
             fmParent.MemTable.Next;
           except
           end;
          end;
        {$ENDIF}
       end;
      finally
        inc(incr);
        TSPBS.Progress:=incr;
        TSPBS.Max:=TCPB.Max;
        TSPBS.Hint:='';
        _SetProgressBarStatus(pb,@TSPBS);
      end;
     until incr>TCPB.Max;
    finally
      if isCheckDouble then
        GetGenIdByName(IBDB,genCheckPremises,-1);
      qr.Free;
      tran.Free;
      fmParent.MemTable.AfterScroll:=OldAfterScroll;
      fmParent.MemTable.EnableControls;
      TCLI.Text:=PChar(Format(fmtImportCount,[TCPB.Max-fmParent.MemTable.RecordCount+1]));
      TCLI.TypeLogItem:=tliInformation;
      TCLI.ViewLogItemProc:=nil;
      _CreateLogItem(@TCLI);
      FCurPB:=pb;
      FreeCurPB;
    end;
   finally
    DoTerminate;
   end;
 except
  {$IFDEF DEBUG}
    on E: Exception do begin
     try
       Assert(false,E.message);
     except
       Application.HandleException(nil);
     end;
    end;
  {$ENDIF}
 end;
end;

procedure TThreadImport.DoTerminate;
begin
  if Assigned(OnTerminate) then
    OnTerminate(Self);
end;

procedure TThreadImport.Terminate;
begin
  Terminated:=true;
end;

{ TfmSrvImport }

procedure TfmSrvPms_ImportPrice.FormCreate(Sender: TObject);
var
  cl: TColumn;
  fd: TFieldDef;
begin
 inherited;
 try
  Caption:=NameSrvPms_ImportPrice;

  qr.Database:=IBDB;
  qr.Transaction:=tran;
  tran.AddDatabase(IBDB);
  IBDB.AddTransaction(tran);

  ListLogItems:=TList.Create;
  strCondition:=TStringList.Create;

  sidTypeRoom:=TStringList.Create;
  sidPlanning:=TStringList.Create;
  sidPhone:=TStringList.Create;
  sidSaleStatus:=TStringList.Create;
  sidDocument:=TStringList.Create;
  sidTypeHouse:=TStringList.Create;
  sidBalcony:=TStringList.Create;
  sidCondition:=TStringList.Create;
  sidStove:=TStringList.Create;
  sidSanitaryNode:=TStringList.Create;
  sidSelfForm:=TStringList.Create;
  sidTypePremises:=TStringList.Create;
  sidAgent:=TStringList.Create;
  sidStation:=TStringList.Create;
  sidRegion:=TStringList.Create;
  sidCityRegion:=TStringList.Create;
  sidStreet:=TStringList.Create;
  sidCountRoom:=TStringList.Create;
  sidFurniture:=TStringList.Create;
  sidDoor:=TStringList.Create;
  sidUnitPrice:=TStringList.Create;
  sidHeat:=TStringList.Create;
  sidWater:=TStringList.Create;
  sidBuilder:=TStringList.Create;

  vlEditor:=TValueListEditor.Create(Self);
  vlEditor.Parent:=pnValEdit;
  vlEditor.Align:=alClient;
  vlEditor.FixedCols:=1;
  vlEditor.KeyOptions:=[keyUnique];
  vlEditor.DefaultRowHeight:=16;
  vlEditor.ColWidths[0]:=25;

  FillRBooks;
  FillCondition;

  cmbTypeOperation.ItemIndex:=0;

  MemTable:=TRxMemoryData.Create(nil);
  MemTable.BeforeDelete:=MemTableBeforeDelete;
  
  Grid:=TNewdbGrid.Create(self);
  Grid.Parent:=pnGrid;
  Grid.Align:=alClient;
  Grid.DataSource:=ds;
  Grid.Name:='Grid';
  Grid.RowSelected.Visible:=true;
  Grid.VisibleRowNumber:=_GetOptions.VisibleRowNumber;
  AssignFont(_GetOptions.RBTableFont,Grid.Font);
  Grid.TitleFont.Assign(Grid.Font);
  Grid.RowSelected.Font.Assign(Grid.Font);
  Grid.RowSelected.Brush.Style:=bsClear;
  Grid.RowSelected.Brush.Color:=_GetOptions.RBTableRecordColor;
  Grid.RowSelected.Font.Color:=clWhite;
  Grid.RowSelected.Pen.Style:=psClear;
  Grid.CellSelected.Visible:=true;
  Grid.CellSelected.Brush.Color:=_GetOptions.RBTableCursorColor;
  Grid.CellSelected.Font.Assign(Grid.Font);
  Grid.CellSelected.Font.Color:=clHighlightText;
  Grid.TitleCellMouseDown.Font.Assign(Grid.Font);
  Grid.Options:=Grid.Options+[dgEditing]-[dgTabs];
  Grid.RowSizing:=false;
  Grid.ReadOnly:=not MemTable.CanModify;
  Grid.OnKeyDown:=FormKeyDown;
  Grid.ColumnSortEnabled:=false;
  Grid.OnEditButtonClick:=GridEditButtonClick;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='sync_id';
  fd.DataType:=ftString;
  fd.Size:=Length(CreateUniqueId);
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='datearrivals';
  fd.DataType:=ftDate;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexDateArrivals];
  cl.Width:=60;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_city_region_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='cityregionname';
  fd.DataType:=ftString;
  fd.Size:=DomainNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexCityRegion];
  cl.Width:=100;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_region_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='regionname';
  fd.DataType:=ftString;
  fd.Size:=DomainNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexRegion];
  cl.Width:=100;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_street_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='streetname';
  fd.DataType:=ftString;
  fd.Size:=DomainNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexStreet];
  cl.Width:=100;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='housenumber';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexHouseNumber];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='ApartmentNumber';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexApartmentNumber];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_countroom_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='countroomname';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexCountRoom];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_typeroom_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='typeroomname';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexTypeRoom];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_planning_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='planningname';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexPlanning];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='floor';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexFloor];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='countfloor';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexCountFloor];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_phone_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='phonename';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexPhone];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_furniture_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='furniturename';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexFurniture];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='generalarea';
  fd.DataType:=ftBCD;
  fd.Precision:=DomainMoneyPrecision;
  fd.Size:=DomainMoneySize;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexGeneralArea];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='dwellingarea';
  fd.DataType:=ftBCD;
  fd.Precision:=DomainMoneyPrecision;
  fd.Size:=DomainMoneySize;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexDwellingArea];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='kitchenarea';
  fd.DataType:=ftBCD;
  fd.Precision:=DomainMoneyPrecision;
  fd.Size:=DomainMoneySize;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexKitchenArea];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_door_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='doorname';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexDoor];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_sanitarynode_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='sanitarynodename';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexSanitaryNode];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_balcony_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='balconyname';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexBalcony];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_condition_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='conditionname';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexCondition];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_stove_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='stovename';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexStove];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='price';
  fd.DataType:=ftBCD;
  fd.Precision:=DomainMoneyPrecision;
  fd.Size:=DomainMoneySize;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexPrice];
  cl.Width:=50;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_unitprice_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='unitpricename';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[Indexunitprice];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='term';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexTerm];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='payment';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexPayment];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='contact';
  fd.DataType:=ftString;
  fd.Size:=DomainNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexContact];
  cl.Width:=100;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='clientinfo';
  fd.DataType:=ftString;
  fd.Size:=DomainNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexClientInfo];
  cl.Width:=100;


  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='note';
  fd.DataType:=ftString;
  fd.Size:=DomainNoteLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexNote];
  cl.Width:=100;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_agent_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='agentname';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexAgent];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_station_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='stationname';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexStation];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_typepremises_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='typepremisesname';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexTypePremises];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_selfform_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='selfformname';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexSelfForm];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_typehouse_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='typehousename';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexTypeHouse];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_document_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='documentname';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexDocument];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_salestatus_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='salestatusname';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexSaleStatus];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_heat_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='heatname';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexHeat];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_water_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='watername';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexWater];
  cl.Width:=30;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='pms_builder_id';
  fd.DataType:=ftInteger;
  fd.CreateField(MemTable);

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='buildername';
  fd.DataType:=ftString;
  fd.Size:=DomainNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.ButtonStyle:=cbsEllipsis;
  cl.ReadOnly:=true;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexBuilder];
  cl.Width:=100;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='delivery';
  fd.DataType:=ftString;
  fd.Size:=DomainShortNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexDelivery];
  cl.Width:=50;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='dateupdate';
  fd.DataType:=ftDate;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexDateUpdate];
  cl.Width:=60;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='nn';
  fd.DataType:=ftString;
  fd.Size:=DomainNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexNN];
  cl.Width:=50;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='price2';
  fd.DataType:=ftBCD;
  fd.Precision:=DomainMoneyPrecision;
  fd.Size:=DomainMoneySize;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexPrice2];
  cl.Width:=50;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='glassy';
  fd.DataType:=ftString;
  fd.Size:=DomainNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexGlassy];
  cl.Width:=50;

  fd:=MemTable.FieldDefs.AddFieldDef;
  fd.Name:='decoration';
  fd.DataType:=ftString;
  fd.Size:=DomainNameLength;
  fd.CreateField(MemTable);

  cl:=Grid.Columns.Add;
  cl.FieldName:=fd.Name;
  cl.Title.Caption:=strCondition.Strings[IndexDecoration];
  cl.Width:=50;

  MemTable.AfterScroll:=MemTableAfterScroll;
  MemTable.Active:=true;

  qr.Active:=false;

  ds.DataSet:=MemTable;

  cl:=GetColumnByFieldName(Grid.Columns,'phonename');
  if cl<>nil then
   cl.Font.Assign(fmOptions.edPhoneColumn.Font);

  Grid.PopupMenu:=pmGrid;

  LoadFromIni;
 except
  {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmSrvPms_ImportPrice.FormDestroy(Sender: TObject);
begin
  inherited;

  ClearListLogItems;
  ListLogItems.Free;
  
  FreeAndNil(RptLoad);
  FreeAndNil(RptImport);
  Grid.Free;
  MemTable.Free;
  strCondition.Free;

  sidTypeRoom.Free;
  sidPlanning.Free;
  sidPhone.Free;
  sidSaleStatus.Free;
  sidDocument.Free;
  sidTypeHouse.Free;
  sidBalcony.Free;
  sidCondition.Free;
  sidStove.Free;
  sidSanitaryNode.Free;
  sidSelfForm.Free;
  sidTypePremises.Free;
  sidAgent.Free;
  sidStation.Free;
  sidCityRegion.Free;
  sidRegion.Free;
  sidStreet.Free;
  sidCountRoom.Free;
  sidFurniture.Free;
  sidDoor.Free;
  sidUnitPrice.Free;
  sidHeat.Free;
  sidWater.Free;
  sidBuilder.Free;

  if FormState=[fsCreatedMDIChild] then
   fmSrvPms_ImportPrice:=nil;
end;

procedure TfmSrvPms_ImportPrice.bibLoadClick(Sender: TObject);
begin
  if od.Execute then begin
    Screen.Cursor:=crHourGlass;
    try
      MemTable.EmptyTable;
      ViewCount;
      Update;
      FillsidTypeRoom;
      FillsidPlanning;
      FillsidPhone;
      FillsidSaleStatus;
      FillsidDocument;
      FillsidTypeHouse;
      FillsidBalcony;
      FillsidCondition;
      FillsidStove;
      FillsidSanitaryNode;
      FillsidSelfForm;
      FillsidTypePremises;
      FillsidAgent;
      FillsidStation;
      FillsidRegion;
      FillsidCityRegion;
      FillsidStreet;
      FillsidCountRoom;
      FillsidFurniture;
      FillsidDoor;
      FillsidUnitPrice;
      FillsidHeat;
      FillsidWater;
      FillsidBuilder;

      grbCondition.Enabled:=false;
      Grid.Enabled:=false;
      bibLoad.Enabled:=false;
      bibImport.Enabled:=false;
      bibBreak.Enabled:=true;
    finally
      Screen.Cursor:=crDefault;
    end;
    ClearListLogItems;
    if RptLoad<>nil then exit;
    RptLoad:=TThreadLoad.Create;
    RptLoad.fmParent:=Self;
    RptLoad.OnTerminate:=OnRptLoadTerminate;
    RptLoad.Execute;
  end;
end;

procedure TfmSrvPms_ImportPrice.SaveToIni;

  procedure SaveGridProp;
  var
   i: Integer;
   cl: TColumn;
  begin
   for i:=0 to Grid.Columns.Count-1 do begin
    cl:=Grid.Columns.Items[i];
    WriteParam(ClassName,'clmnID'+Grid.Name+inttostr(i),cl.ID);
    WriteParam(ClassName,'clmnIndex'+Grid.Name+inttostr(i),cl.Index);
    WriteParam(ClassName,'clmnWidth'+Grid.Name+inttostr(i),cl.Width);
    WriteParam(ClassName,'clmnVisible'+Grid.Name+inttostr(i),cl.Visible);
   end;
  end;

begin
  inherited;
  SaveGridProp;
  WriteParam(ClassName,'release_id',release_id);
end;

procedure TfmSrvPms_ImportPrice.LoadFromIni;

  procedure LoadGridProp;
  var
   i: Integer;
   cl: TColumn;
   id: Integer;
  begin
   for i:=0 to Grid.Columns.Count-1 do begin
    id:=ReadParam(ClassName,'clmnID'+Grid.Name+inttostr(i),i);
    cl:=TColumn(Grid.Columns.FindItemID(id));
    if cl<>nil then begin
     cl.Index:=ReadParam(ClassName,'clmnIndex'+Grid.Name+inttostr(i),cl.Index);
     cl.Width:=ReadParam(ClassName,'clmnWidth'+Grid.Name+inttostr(i),cl.Width);
     cl.Visible:=ReadParam(ClassName,'clmnVisible'+Grid.Name+inttostr(i),cl.Visible);
    end;
   end;
  end;

begin
  inherited;
  LoadGridProp;
  release_id:=ReadParam(ClassName,'release_id',release_id);
end;

procedure TfmSrvPms_ImportPrice.bibCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmSrvPms_ImportPrice.OnRptLoadTerminate(Sender: TObject);
begin
  FreeAndNil(RptLoad);
  bibBreakClick(nil);
end;

procedure TfmSrvPms_ImportPrice.OnRptImportTerminate(Sender: TObject);
begin
  FreeAndNil(RptImport);
  bibBreakClick(nil);
end;

procedure TfmSrvPms_ImportPrice.bibBreakClick(Sender: TObject);
begin
  if RptLoad<>nil then RptLoad.Terminate;
  if RptImport<>nil then RptImport.Terminate;
  if Memtable.RecordCount>0 then
   Grid.Options:=Grid.Options+[dgEditing]
  else Grid.Options:=Grid.Options-[dgEditing];
  grbCondition.Enabled:=true;                                     
  Grid.Enabled:=true;
  Grid.Invalidate;
  MemTableAfterScroll(nil);
  bibLoad.Enabled:=true;
  bibImport.Enabled:=true;
  bibBreak.Enabled:=false;
  ViewCount;
  Grid.SetFocus;
end;

procedure TfmSrvPms_ImportPrice.ViewCount;
begin
  lbCount.Caption:=Format('�����: %d',[MemTable.RecordCount]);
end;

procedure TfmSrvPms_ImportPrice.MemTableAfterScroll(DataSet: TDataSet);
begin
  if MemTable.IsEmpty then exit;
end;

procedure TfmSrvPms_ImportPrice.GridEditButtonClick(Sender: TObject);
var
  fl: TField;
  TPRBI: TParamRBookInterface;
begin
  fl:=Grid.SelectedField;
  if fl=nil then exit;
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tvibvModal;
  if AnsiSameText(fl.FieldName,'cityregionname') then begin
   TPRBI.Locate.KeyFields:='pms_city_region_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_city_region_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_City_Region,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_city_region_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_city_region_id');
     MemTable.FieldByName('cityregionname').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'regionname') then begin
   TPRBI.Locate.KeyFields:='pms_region_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_region_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_Region,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_region_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_region_id');
     MemTable.FieldByName('regionname').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'streetname') then begin
   TPRBI.Locate.KeyFields:='pms_street_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_street_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_Street,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_street_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_street_id');
     MemTable.FieldByName('streetname').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'countroomname') then begin
   TPRBI.Locate.KeyFields:='pms_countroom_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_countroom_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_countroom,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_countroom_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_countroom_id');
     MemTable.FieldByName('countroomname').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'typeroomname') then begin
   TPRBI.Locate.KeyFields:='pms_typeroom_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_typeroom_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_typeroom,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_typeroom_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_typeroom_id');
     MemTable.FieldByName('typeroomname').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'planningname') then begin
   TPRBI.Locate.KeyFields:='pms_planning_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_planning_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_planning,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_planning_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_planning_id');
     MemTable.FieldByName('planningname').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'phonename') then begin
   TPRBI.Locate.KeyFields:='pms_phone_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_phone_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_phone,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_phone_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_phone_id');
     MemTable.FieldByName('phonename').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'furniturename') then begin
   TPRBI.Locate.KeyFields:='pms_furniture_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_furniture_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_furniture,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_furniture_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_furniture_id');
     MemTable.FieldByName('furniturename').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'doorname') then begin
   TPRBI.Locate.KeyFields:='pms_door_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_door_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_door,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_door_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_door_id');
     MemTable.FieldByName('doorname').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'sanitarynodename') then begin
   TPRBI.Locate.KeyFields:='pms_sanitarynode_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_sanitarynode_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_sanitarynode,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_sanitarynode_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_sanitarynode_id');
     MemTable.FieldByName('sanitarynodename').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'balconyname') then begin
   TPRBI.Locate.KeyFields:='pms_balcony_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_balcony_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_balcony,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_balcony_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_balcony_id');
     MemTable.FieldByName('balconyname').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'stovename') then begin
   TPRBI.Locate.KeyFields:='pms_stove_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_stove_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_stove,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_stove_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_stove_id');
     MemTable.FieldByName('stovename').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'agentname') then begin
   TPRBI.Locate.KeyFields:='pms_agent_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_agent_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_agent,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_agent_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_agent_id');
     MemTable.FieldByName('agentname').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'stationname') then begin
   TPRBI.Locate.KeyFields:='pms_station_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_station_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_station,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_station_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_station_id');
     MemTable.FieldByName('stationname').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'typepremisesname') then begin
   TPRBI.Locate.KeyFields:='pms_typepremises_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_typepremises_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_typepremises,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_typepremises_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_typepremises_id');
     MemTable.FieldByName('typepremisesname').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'selfformname') then begin
   TPRBI.Locate.KeyFields:='pms_selfform_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_selfform_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_selfform,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_selfform_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_selfform_id');
     MemTable.FieldByName('selfformname').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'typehousename') then begin
   TPRBI.Locate.KeyFields:='pms_typehouse_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_typehouse_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_typehouse,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_typehouse_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_typehouse_id');
     MemTable.FieldByName('typehousename').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'documentname') then begin
   TPRBI.Locate.KeyFields:='pms_document_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_document_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_document,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_document_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_document_id');
     MemTable.FieldByName('documentname').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'salestatusname') then begin
   TPRBI.Locate.KeyFields:='pms_salestatus_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_salestatus_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_salestatus,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_salestatus_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_salestatus_id');
     MemTable.FieldByName('salestatusname').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'unitpricename') then begin
   TPRBI.Locate.KeyFields:='pms_unitprice_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_unitprice_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_unitprice,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_unitprice_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_unitprice_id');
     MemTable.FieldByName('unitpricename').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'heatname') then begin
   TPRBI.Locate.KeyFields:='pms_heat_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_heat_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_Heat,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_heat_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_heat_id');
     MemTable.FieldByName('heatname').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'watername') then begin
   TPRBI.Locate.KeyFields:='pms_water_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_water_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_water,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_water_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_water_id');
     MemTable.FieldByName('watername').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
  if AnsiSameText(fl.FieldName,'buildername') then begin
   TPRBI.Locate.KeyFields:='pms_builder_id';
   TPRBI.Locate.KeyValues:=MemTable.FieldByName('pms_builder_id').Value;
   TPRBI.Locate.Options:=[loCaseInsensitive];
   if _ViewInterfaceFromName(NameRbkPms_builder,@TPRBI) then begin
     MemTable.Edit;
     MemTable.FieldByName('pms_builder_id').AsInteger:=GetFirstValueFromPRBI(@TPRBI,'pms_builder_id');
     MemTable.FieldByName('buildername').AsString:=GetFirstValueFromPRBI(@TPRBI,'name');
     MemTable.Post;
   end;
  end;
end;

function TfmSrvPms_ImportPrice.CheckFieldsFill: Boolean;
begin
  Result:=true;
{  if trim(edRelease.Text)='' then begin
    ShowErrorEx(Format(ConstFieldNoEmpty,[lbRelease.Caption]));
    bibRelease.SetFocus;
    Result:=false;
    exit;
  end;}
end;

procedure TfmSrvPms_ImportPrice.bibImportClick(Sender: TObject);
begin
  if not CheckFieldsFill then exit;
  grbCondition.Enabled:=false;
  Grid.Enabled:=false;
  bibLoad.Enabled:=false;
  bibImport.Enabled:=false;
  bibBreak.Enabled:=true;
  ClearListLogItems;
  if RptImport<>nil then exit;
  RptImport:=TThreadImport.Create;
  RptImport.fmParent:=Self;
  RptImport.OnTerminate:=OnRptImportTerminate;
  RptImport.Execute;
end;

procedure TfmSrvPms_ImportPrice.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  but: Integer;  
begin
  if Key=LastKey then begin
   LastKey:=0;
   exit;
  end;
  if Shift=[] then begin
   case Key of
    VK_F2: begin
      MemTable.Insert;
    end;
    VK_F3: begin
      MemTable.Edit;
      Grid.EditorMode:=true;
    end;
    VK_F4: begin
      if not MemTable.isEmpty then begin
       but:=DeleteWarningEx('������� �����������?');
       if but=mrYes then begin
         MemTable.Delete;
         ViewCount;
       end;
      end; 
    end;
    VK_F5: begin
      MemTable.Refresh;
    end; 
    VK_F6: begin
    end;
    VK_F7: begin
    end;
    VK_F8: begin
    end;
    VK_UP,VK_DOWN: begin
//      Grid.SetFocus;
    end;
    VK_F9: begin
    end;
   end;
  end;
  _MainFormKeyDown(Key,Shift);
  LastKey:=Key;
end;

procedure TfmSrvPms_ImportPrice.FillCondition;
var
  i: Integer;
const
  MaxRow=256;
begin
  vlEditor.TitleCaptions.Clear;
  vlEditor.TitleCaptions.Add('�');
  vlEditor.TitleCaptions.Add('�������� � ����');
  for i:=1 to MaxRow do begin
    vlEditor.InsertRow(inttostr(i),'',true);
    vlEditor.ItemProps[inttostr(i)].ReadOnly:=true;
    vlEditor.ItemProps[inttostr(i)].EditStyle:=esPickList;
    vlEditor.ItemProps[inttostr(i)].PickList:=strCondition;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillRBooks;
begin
  IndexEmpty:=strCondition.Add('');
  IndexDateArrivals:=strCondition.Add('���� ����������');
  IndexTypeRoom:=strCondition.Add('��� ������');
  IndexPlanning:=strCondition.Add('����������');
  IndexPhone:=strCondition.Add('�������');
  IndexSaleStatus:=strCondition.Add('������ �������');
  IndexDocument:=strCondition.Add('���������');
  IndexTypeHouse:=strCondition.Add('��� ����');
  IndexGeneralArea:=strCondition.Add('����� �������');
  IndexDwellingArea:=strCondition.Add('����� �������');
  IndexKitchenArea:=strCondition.Add('������� �����');
  IndexAllArea1:=strCondition.Add('�����/�����/�����');
  IndexAllArea2:=strCondition.Add('�����\�����\�����');
  IndexBalcony:=strCondition.Add('������');
  IndexCondition:=strCondition.Add('������');
  IndexStove:=strCondition.Add('�����');
  IndexSanitaryNode:=strCondition.Add('�������');
  IndexSelfForm:=strCondition.Add('����� �������������');
  IndexTypePremises:=strCondition.Add('��� ������������');
  IndexPrice:=strCondition.Add('����');
  IndexUnitPrice:=strCondition.Add('������� ��������� ����');
  IndexPriceUnitPrice:=strCondition.Add('����������� ��������� ����');
  IndexNote:=strCondition.Add('����������');
  IndexContact:=strCondition.Add('�������');
  IndexContactPlus:=strCondition.Add('������� (����.)');
  IndexClientInfo:=strCondition.Add('������');
  IndexAgent:=strCondition.Add('�����');
  IndexStation:=strCondition.Add('������ ���������');
  IndexRegion:=strCondition.Add('�����');
  IndexStreet:=strCondition.Add('�����');
  IndexHouseNumber:=strCondition.Add('���');
  IndexApartmentNumber:=strCondition.Add('��������');
  IndexHouseApartment1:=strCondition.Add('���-��������');
  IndexCountRoom:=strCondition.Add('���������� ������');
  IndexFloor:=strCondition.Add('����');
  IndexCountFloor:=strCondition.Add('���������');
  IndexFurniture:=strCondition.Add('������');
  IndexDoor:=strCondition.Add('�����');
  IndexTerm:=strCondition.Add('����');
  IndexPayment:=strCondition.Add('������ ��');
  IndexTermPayment1:=strCondition.Add('����\������ ��');
  IndexTermPayment2:=strCondition.Add('����/������ ��');
  IndexDateUpdate:=strCondition.Add('���� ����������');
  IndexHeat:=strCondition.Add('���������');
  IndexWater:=strCondition.Add('�������������');
  IndexBuilder:=strCondition.Add('����������');
  IndexDelivery:=strCondition.Add('�����');
  IndexNN:=strCondition.Add('����� ��');
  IndexCityRegion:=strCondition.Add('��������� �����');
  IndexPrice2:=strCondition.Add('���� �� �2');
  IndexGlassy:=strCondition.Add('����������');
  IndexDecoration:=strCondition.Add('�������');
end;

procedure TfmSrvPms_ImportPrice.bibLoadConditionClick(Sender: TObject);
begin
  if not odCondition.Execute then exit;
  LoadConditionFromFile(odCondition.FileName);
end;

procedure TfmSrvPms_ImportPrice.bibSaveConditionClick(Sender: TObject);
begin
  if not sdCondition.Execute then exit;
  SaveConditionToFile(sdCondition.FileName);
end;

procedure TfmSrvPms_ImportPrice.FillsidTypeRoom;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_TypeRoom,@TPRBI) then begin
    sidTypeRoom.BeginUpdate;
    try
      sidTypeRoom.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_TypeRoom_id');
        sidTypeRoom.AddObject(sname,TObject(id));
      end;
    finally
      sidTypeRoom.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidPlanning;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_Planning,@TPRBI) then begin
    sidPlanning.BeginUpdate;
    try
      sidPlanning.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_Planning_id');
        sidPlanning.AddObject(sname,TObject(id));
      end;
    finally
      sidPlanning.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidPhone;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_Phone,@TPRBI) then begin
    sidPhone.BeginUpdate;
    try
      sidPhone.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_Phone_id');
        sidPhone.AddObject(sname,TObject(id));
      end;
    finally
      sidPhone.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidSaleStatus;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_SaleStatus,@TPRBI) then begin
    sidSaleStatus.BeginUpdate;
    try
      sidSaleStatus.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_SaleStatus_id');
        sidSaleStatus.AddObject(sname,TObject(id));
      end;
    finally
      sidSaleStatus.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidDocument;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_Document,@TPRBI) then begin
    sidDocument.BeginUpdate;
    try
      sidDocument.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_Document_id');
        sidDocument.AddObject(sname,TObject(id));
      end;
    finally
      sidDocument.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidTypeHouse;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_TypeHouse,@TPRBI) then begin
    sidTypeHouse.BeginUpdate;
    try
      sidTypeHouse.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_TypeHouse_id');
        sidTypeHouse.AddObject(sname,TObject(id));
      end;
    finally
      sidTypeHouse.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidBalcony;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_Balcony,@TPRBI) then begin
    sidBalcony.BeginUpdate;
    try
      sidBalcony.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_balcony_id');
        sidBalcony.AddObject(sname,TObject(id));
      end;
    finally
      sidBalcony.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidHeat;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_Heat,@TPRBI) then begin
    sidHeat.BeginUpdate;
    try
      sidHeat.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_heat_id');
        sidHeat.AddObject(sname,TObject(id));
      end;
    finally
      sidHeat.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidWater;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_Water,@TPRBI) then begin
    sidWater.BeginUpdate;
    try
      sidWater.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_water_id');
        sidWater.AddObject(sname,TObject(id));
      end;
    finally
      sidWater.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidBuilder;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_Builder,@TPRBI) then begin
    sidBuilder.BeginUpdate;
    try
      sidBuilder.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_builder_id');
        sidBuilder.AddObject(sname,TObject(id));
      end;
    finally
      sidBuilder.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidCondition;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_Condition,@TPRBI) then begin
    sidCondition.BeginUpdate;
    try
      sidCondition.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_Condition_id');
        sidCondition.AddObject(sname,TObject(id));
      end;
    finally
      sidCondition.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidStove;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_Stove,@TPRBI) then begin
    sidStove.BeginUpdate;
    try
      sidStove.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_Stove_id');
        sidStove.AddObject(sname,TObject(id));
      end;
    finally
      sidStove.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidSanitaryNode;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_SanitaryNode,@TPRBI) then begin
    sidSanitaryNode.BeginUpdate;
    try
      sidSanitaryNode.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_SanitaryNode_id');
        sidSanitaryNode.AddObject(sname,TObject(id));
      end;
    finally
      sidSanitaryNode.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidSelfForm;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_SelfForm,@TPRBI) then begin
    sidSelfForm.BeginUpdate;
    try
      sidSelfForm.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_SelfForm_id');
        sidSelfForm.AddObject(sname,TObject(id));
      end;
    finally
      sidSelfForm.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidTypePremises;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_TypePremises,@TPRBI) then begin
    sidTypePremises.BeginUpdate;
    try
      sidTypePremises.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_TypePremises_id');
        sidTypePremises.AddObject(sname,TObject(id));
      end;
    finally
      sidTypePremises.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidAgent;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_Agent,@TPRBI) then begin
    sidAgent.BeginUpdate;
    try
      sidAgent.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_Agent_id');
        sidAgent.AddObject(sname,TObject(id));
      end;
    finally
      sidAgent.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidStation;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_Station,@TPRBI) then begin
    sidStation.BeginUpdate;
    try
      sidStation.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_Station_id');
        sidStation.AddObject(sname,TObject(id));
      end;
    finally
      sidStation.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidRegion;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_Region,@TPRBI) then begin
    sidRegion.BeginUpdate;
    try
      sidRegion.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_Region_id');
        sidRegion.AddObject(sname,TObject(id));
      end;
    finally
      sidRegion.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidCityRegion;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_City_Region,@TPRBI) then begin
    sidCityRegion.BeginUpdate;
    try
      sidCityRegion.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_City_Region_id');
        sidCityRegion.AddObject(sname,TObject(id));
      end;
    finally
      sidCityRegion.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidStreet;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' name ';
  if _ViewInterfaceFromName(NameRbkPms_Street,@TPRBI) then begin
    sidStreet.BeginUpdate;
    try
      sidStreet.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_Street_id');
        sidStreet.AddObject(sname,TObject(id));
      end;
    finally
      sidStreet.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidCountRoom;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_CountRoom,@TPRBI) then begin
    sidCountRoom.BeginUpdate;
    try
      sidCountRoom.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_CountRoom_id');
        sidCountRoom.AddObject(sname,TObject(id));
      end;
    finally
      sidCountRoom.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidFurniture;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_Furniture,@TPRBI) then begin
    sidFurniture.BeginUpdate;
    try
      sidFurniture.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_Furniture_id');
        sidFurniture.AddObject(sname,TObject(id));
      end;
    finally
      sidFurniture.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidDoor;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_Door,@TPRBI) then begin
    sidDoor.BeginUpdate;
    try
      sidDoor.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_Door_id');
        sidDoor.AddObject(sname,TObject(id));
      end;
    finally
      sidDoor.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.FillsidUnitPrice;
var
  TPRBI: TParamRBookInterface;
  s,e,i: Integer;
  sname: string;
  id: Integer;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tviOnlyData;
  TPRBI.Condition.OrderStr:=' sortnumber ';
  if _ViewInterfaceFromName(NameRbkPms_UnitPrice,@TPRBI) then begin
    sidUnitPrice.BeginUpdate;
    try
      sidUnitPrice.Clear;
      GetStartAndEndByPRBI(@TPRBI,s,e);
      for i:=s to e do begin
        sname:=GetValueByPRBI(@TPRBI,i,'name');
        id:=GetValueByPRBI(@TPRBI,i,'pms_UnitPrice_id');
        sidUnitPrice.AddObject(sname,TObject(id));
      end;
    finally
      sidUnitPrice.EndUpdate;
    end;
  end;
end;

procedure TfmSrvPms_ImportPrice.LoadConditionFromFile(const FileName: string);
var
  fs: TFileStream;
  rd: TReader;
  V,NCount,i: Integer;
begin
  fs:=nil;
  try
    fs:=TFileStream.Create(FileName,fmOpenRead);
    rd:=TReader.Create(fs,4096);
    try
      V:=rd.readInteger;
      if V=ConstVersionCondition_V1 then begin
        cmbTypeOperation.ItemIndex:=rd.readInteger;
        NCount:=rd.readInteger;
        for i:=1 to NCount do begin
          vlEditor.Cells[1,i]:=rd.ReadString;
        end;
      end;
    finally
      rd.Free;
    end;
  finally
    fs.Free;
  end;
end;

procedure TfmSrvPms_ImportPrice.SaveConditionToFile(const FileName: string);
var
  fs: TFileStream;
  wr: TWriter;
  i: Integer;
begin
  fs:=nil;
  try
    fs:=TFileStream.Create(FileName,fmCreate);
    wr:=TWriter.Create(fs,4096);
    try
      wr.WriteInteger(ConstVersionCondition_V1);
      wr.WriteInteger(cmbTypeOperation.ItemIndex);
      wr.WriteInteger(vlEditor.RowCount-1);
      for i:=1 to vlEditor.RowCount-1 do begin
        wr.WriteString(vlEditor.Cells[1,i]);
      end;
    finally
      wr.Free;
    end;
  finally
    fs.Free;
  end;
end;

procedure TfmSrvPms_ImportPrice.bibTypePremisesClick(Sender: TObject);
var
  TPRBI: TParamRBookInterface;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tvibvModal;
  TPRBI.Locate.KeyFields:='pms_typepremises_id';
  TPRBI.Locate.KeyValues:=pms_typepremises_id;
  if _ViewInterfaceFromName(NameRbkPms_TypePremises,@TPRBI) then begin
    edTypePremises.Text:=GetFirstValueFromPRBI(@TPRBI,'name');
    pms_typepremises_id:=GetFirstValueFromPRBI(@TPRBI,'pms_typepremises_id');
    if pms_typepremises_id then ;
  end;
end;

procedure TfmSrvPms_ImportPrice.edTypePremisesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key=VK_DELETE)or(Key=VK_BACK) then begin
    edTypePremises.Text:='';
    pms_typepremises_id:=Unassigned;
  end;
end;

procedure TfmSrvPms_ImportPrice.edUnitPriceKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key=VK_DELETE)or(Key=VK_BACK) then begin
    edUnitPrice.Text:='';
    pms_unitprice_id:=Unassigned;
  end;
end;

procedure TfmSrvPms_ImportPrice.bibUnitPriceClick(Sender: TObject);
var
  TPRBI: TParamRBookInterface;
begin
  FillChar(TPRBI,SizeOf(TPRBI),0);
  TPRBI.Visual.TypeView:=tvibvModal;
  TPRBI.Locate.KeyFields:='pms_unitprice_id';
  TPRBI.Locate.KeyValues:=pms_unitprice_id;
  if _ViewInterfaceFromName(NameRbkPms_UnitPrice,@TPRBI) then begin
    edUnitPrice.Text:=GetFirstValueFromPRBI(@TPRBI,'name');
    pms_unitprice_id:=GetFirstValueFromPRBI(@TPRBI,'pms_unitprice_id');
    if pms_unitprice_id then ;
  end;
end;

procedure TfmSrvPms_ImportPrice.FreeListLogItem(P: Pointer);
begin
  if P=nil then exit;
  _FreeLogItem(PImportLogItem(P).hLogItem);
  ListLogItems.Remove(P);
  Dispose(PImportLogItem(P));
end;

procedure TfmSrvPms_ImportPrice.ClearListLogItems;
var
  i: Integer;
  P: PImportLogItem;
begin
  for i:=ListLogItems.Count-1 downto 0 do begin
    P:=ListLogItems.Items[i];
    FreeListLogItem(P);
  end;
end;

function TfmSrvPms_ImportPrice.GetImportLogItemById(id: Integer): Pointer;
var
  i: Integer;
  P: PImportLogItem;
begin
  Result:=nil;
  for i:=0 to ListLogItems.Count-1 do begin
    P:=ListLogItems.Items[i];
    if P.id=id then begin
      Result:=P;
      exit;
    end;
  end;
end;

function TfmSrvPms_ImportPrice.GetImportLogItemByHandle(LogItemHandle: THandle): Pointer;
var
  i: Integer;
  P: PImportLogItem;
begin
  Result:=nil;
  for i:=0 to ListLogItems.Count-1 do begin
    P:=ListLogItems.Items[i];
    if P.hLogItem=LogItemHandle then begin
      Result:=P;
      exit;
    end;
  end;
end;

procedure fmSrvPms_ImportPriceViewLogItemProc(Owner: Pointer; LogItemHandle: THandle); stdcall;
var
  P: PImportLogItem;
begin
  if not isValidPointer(Owner) then exit;
  P:=TfmSrvPms_ImportPrice(Owner).GetImportLogItemByHandle(LogItemHandle);
  if isValidPointer(P) then
    TfmSrvPms_ImportPrice(Owner).MemTable.Locate('id',P.id,[loCaseInsensitive]);
end;

procedure TfmSrvPms_ImportPrice.AddToListLogItems(Text: string; id: Integer);
var
  TCLI: TCreateLogItem;
  P: PImportLogItem;
  hLogItem: THandle;
begin
  FillChar(TCLI,SizeOf(TCLI),0);
  TCLI.Owner:=Self;
  TCLI.Text:=PChar(Text);
  TCLI.TypeLogItem:=tliError;
  TCLI.ViewLogItemProc:=fmSrvPms_ImportPriceViewLogItemProc;
  hLogItem:=_CreateLogItem(@TCLI);
  if hLogItem<>LOGITEM_INVALID_HANDLE then begin
    New(P);
    FillChar(P^,SizeOf(P^),0);
    P.hLogItem:=hLogItem;
    P.id:=id;
    ListLogItems.Add(P);
    _ViewLog(true);
  end;
end;

procedure TfmSrvPms_ImportPrice.MemTableBeforeDelete(DataSet: TDataSet);
begin
  FreeListLogItem(GetImportLogItemById(MemTable.FieldByName('id').AsInteger));
end;

procedure TfmSrvPms_ImportPrice.miSaveGridToFileClick(Sender: TObject);
var
  WithData: Boolean;
  i: Integer;
  pb: Thandle;
  TCPB: TCreateProgressBar;
  TSPBS: TSetProgressBarStatus;
  b: TBookmark;
begin
  sdGrid.DefaultExt:=dfeXML;
  sdGrid.Filter:=fltXML;
  if not sdGrid.Execute then exit;
  Screen.Cursor:=crHourGlass;
  try
    WithData:=true;
    cds.Active:=false;
    cds.FieldDefs.Clear;
    cds.FieldDefs.Assign(MemTable.FieldDefs);
    cds.CreateDataSet;
    cds.Active:=true;
    Update;
    if WithData then begin
      MemTable.DisableControls;
      b:=MemTable.GetBookmark;
      pb:=0;
      try
        MemTable.Last;
        FillChar(TCPB,SizeOf(TCPB),0);
        TCPB.Min:=0;
        TCPB.Max:=MemTable.RecordCount;
        TCPB.Color:=clNavy;
        pb:=_CreateProgressBar(@TCPB);
        MemTable.First;
        FillChar(TSPBS,SizeOf(TSPBS),0);
        while not MemTable.Eof do begin
          cds.Append;
          for i:=0 to MemTable.FieldCount-1 do begin
            cds.Fields[i].Value:=MemTable.Fields[i].Value;
          end;
          cds.Post;
          MemTable.Next;
          TSPBS.Progress:=TSPBS.Progress+1;
          TSPBS.Max:=TCPB.Max;
          _SetProgressBarStatus(pb,@TSPBS);
        end;
      finally
        _FreeProgressBar(pb);
        MemTable.GotoBookmark(b);
        MemTable.EnableControls;
      end;
    end;
  finally
    cds.SaveToFile(sdGrid.FileName);
    Screen.Cursor:=crDefault;
  end;  
end;

procedure TfmSrvPms_ImportPrice.miLoadGridFromFileClick(Sender: TObject);
var
  i: Integer;
  pb: Thandle;
  TCPB: TCreateProgressBar;
  TSPBS: TSetProgressBarStatus;
begin
  ClearGrid;
  odGrid.DefaultExt:=dfeXML;
  odGrid.Filter:=fltXML;
  if not odGrid.Execute then exit;
  Screen.Cursor:=crHourGlass;
  try
    cds.Active:=false;
    cds.LoadFromFile(odGrid.FileName);
    cds.Active:=true;
    Update;
    MemTable.DisableControls;
    pb:=0;
    try
      cds.Last;
      FillChar(TCPB,SizeOf(TCPB),0);
      TCPB.Min:=0;
      TCPB.Max:=cds.RecordCount;
      TCPB.Color:=clNavy;
      pb:=_CreateProgressBar(@TCPB);
      cds.First;
      FillChar(TSPBS,SizeOf(TSPBS),0);
      while not cds.Eof do begin
        MemTable.Append;
        for i:=0 to cds.FieldCount-1 do begin
          MemTable.Fields[i].Value:=cds.Fields[i].Value;
        end;
        MemTable.Post;
        cds.Next;
        TSPBS.Progress:=TSPBS.Progress+1;
        TSPBS.Max:=TCPB.Max;
        _SetProgressBarStatus(pb,@TSPBS);
      end;
    finally
      _FreeProgressBar(pb);
      MemTable.EnableControls;
    end;
  finally
    ViewCount;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TfmSrvPms_ImportPrice.miClearGridClick(Sender: TObject);
begin
  ClearGrid;
end;

procedure TfmSrvPms_ImportPrice.ClearGrid;
var
  mr: TModalResult;
begin
  if not MemTable.IsEmpty then begin
    mr:=ShowQuestionEx('�������� ��������������� ��������?');
    if mr=mrYes then begin
      MemTable.EmptyTable;
      ClearListLogItems;
    end;  
  end;
  ViewCount;  
end;

procedure TfmSrvPms_ImportPrice.miDeleteGridClick(Sender: TObject);
begin
  if not MemTable.IsEmpty then
    MemTable.Delete; 
  ViewCount;
end;

end.
