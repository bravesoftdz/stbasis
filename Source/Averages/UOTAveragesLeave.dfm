object fmOTAveragesLeave: TfmOTAveragesLeave
  Left = 395
  Top = 33
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '����� �������'
  ClientHeight = 590
  ClientWidth = 518
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 53
    Height = 13
    Caption = '���������'
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 72
    Height = 13
    Caption = '����� ������'
  end
  object Label3: TLabel
    Left = 296
    Top = 160
    Width = 203
    Height = 13
    Caption = '������� ������ ������������ ������'
  end
  object Label5: TLabel
    Left = 8
    Top = 512
    Width = 79
    Height = 13
    Caption = '����� �������'
  end
  object Label6: TLabel
    Left = 8
    Top = 376
    Width = 95
    Height = 13
    Caption = '��������� �������'
  end
  object Label7: TLabel
    Left = 8
    Top = 560
    Width = 84
    Height = 13
    Caption = '����� ��������'
  end
  object Label22: TLabel
    Left = 8
    Top = 536
    Width = 67
    Height = 13
    Caption = '���. ������'
  end
  object bibEmp: TBitBtn
    Left = 320
    Top = 16
    Width = 21
    Height = 21
    Hint = '�������'
    Caption = '...'
    TabOrder = 1
    OnClick = bibEmpClick
  end
  object edEmp: TEdit
    Left = 72
    Top = 16
    Width = 241
    Height = 21
    Color = clBtnFace
    MaxLength = 100
    ReadOnly = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 312
    Top = 560
    Width = 123
    Height = 25
    Caption = '��������� ������'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    OnClick = Button1Click
  end
  object cbEmpPlants: TComboBox
    Left = 88
    Top = 48
    Width = 257
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
  end
  object EditPercent: TRxSpinEdit
    Left = 336
    Top = 176
    Width = 121
    Height = 21
    ButtonKind = bkStandard
    MaxValue = 100
    MinValue = 1
    Value = 100
    TabOrder = 6
  end
  object CurrencyEdit1: TCurrencyEdit
    Left = 104
    Top = 512
    Width = 121
    Height = 21
    AutoSize = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 9
  end
  object RadioGroup1: TRadioGroup
    Left = 296
    Top = 88
    Width = 217
    Height = 57
    Caption = '��� �������'
    Items.Strings = (
      '�� 6-�� ������� ������� ������'
      '������������� ����'
      '�� ����������� ����')
    TabOrder = 4
  end
  object RxDBGrid1: TRxDBGrid
    Left = 8
    Top = 392
    Width = 505
    Height = 113
    Color = clBtnFace
    DataSource = dsData
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'FDate'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LeaveDaysCount'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LeaveHoursCount'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NormalDaysCount'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NormalHoursCount'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CalendarDays'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OnePay'
        Visible = True
      end>
  end
  object Button2: TButton
    Left = 440
    Top = 560
    Width = 75
    Height = 25
    Caption = '�������'
    TabOrder = 13
    OnClick = Button2Click
  end
  object CurrencyEdit2: TCurrencyEdit
    Left = 104
    Top = 560
    Width = 121
    Height = 21
    AutoSize = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 11
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 208
    Width = 505
    Height = 161
    Caption = '���������� �� ��������� �������'
    TabOrder = 7
    object LabelM1: TLabel
      Left = 8
      Top = 16
      Width = 71
      Height = 13
      Caption = '<��� ������>'
    end
    object Label9: TLabel
      Left = 8
      Top = 32
      Width = 43
      Height = 13
      Caption = '���. ���'
    end
    object Label10: TLabel
      Left = 8
      Top = 56
      Width = 50
      Height = 13
      Caption = '���. ����'
    end
    object Label11: TLabel
      Left = 8
      Top = 128
      Width = 54
      Height = 13
      Caption = '���. �����'
    end
    object Bevel1: TBevel
      Left = 168
      Top = 16
      Width = 9
      Height = 137
      Shape = bsLeftLine
    end
    object LabelM2: TLabel
      Left = 176
      Top = 16
      Width = 71
      Height = 13
      Caption = '<��� ������>'
    end
    object Label12: TLabel
      Left = 176
      Top = 32
      Width = 43
      Height = 13
      Caption = '���. ���'
    end
    object Label13: TLabel
      Left = 176
      Top = 56
      Width = 50
      Height = 13
      Caption = '���. ����'
    end
    object Label14: TLabel
      Left = 176
      Top = 128
      Width = 54
      Height = 13
      Caption = '���. �����'
    end
    object Bevel2: TBevel
      Left = 336
      Top = 16
      Width = 9
      Height = 137
      Shape = bsLeftLine
    end
    object LabelM3: TLabel
      Left = 344
      Top = 16
      Width = 71
      Height = 13
      Caption = '<��� ������>'
    end
    object Label8: TLabel
      Left = 344
      Top = 32
      Width = 43
      Height = 13
      Caption = '���. ���'
    end
    object Label15: TLabel
      Left = 344
      Top = 56
      Width = 50
      Height = 13
      Caption = '���. ����'
    end
    object Label16: TLabel
      Left = 344
      Top = 128
      Width = 54
      Height = 13
      Caption = '���. �����'
    end
    object Label4: TLabel
      Left = 8
      Top = 80
      Width = 55
      Height = 13
      Caption = '����� ���'
    end
    object Label17: TLabel
      Left = 8
      Top = 104
      Width = 62
      Height = 13
      Caption = '����� ����'
    end
    object Label18: TLabel
      Left = 176
      Top = 80
      Width = 55
      Height = 13
      Caption = '����� ���'
    end
    object Label19: TLabel
      Left = 176
      Top = 104
      Width = 62
      Height = 13
      Caption = '����� ����'
    end
    object Label20: TLabel
      Left = 344
      Top = 80
      Width = 55
      Height = 13
      Caption = '����� ���'
    end
    object Label21: TLabel
      Left = 344
      Top = 104
      Width = 62
      Height = 13
      Caption = '����� ����'
    end
    object EditM1D: TEdit
      Left = 72
      Top = 32
      Width = 89
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object EditM1H: TEdit
      Left = 72
      Top = 56
      Width = 89
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
    object EditM2D: TEdit
      Left = 240
      Top = 32
      Width = 89
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 5
    end
    object EditM2H: TEdit
      Left = 240
      Top = 56
      Width = 89
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 6
    end
    object EditM1P: TCurrencyEdit
      Left = 72
      Top = 128
      Width = 89
      Height = 21
      AutoSize = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 4
    end
    object EditM2P: TCurrencyEdit
      Left = 240
      Top = 128
      Width = 89
      Height = 21
      AutoSize = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 9
    end
    object EditM3D: TEdit
      Left = 408
      Top = 32
      Width = 89
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 10
    end
    object EditM3H: TEdit
      Left = 408
      Top = 56
      Width = 89
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 11
    end
    object EditM3P: TCurrencyEdit
      Left = 408
      Top = 128
      Width = 89
      Height = 21
      AutoSize = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 14
    end
    object EditM1ND: TEdit
      Left = 72
      Top = 80
      Width = 89
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object EditM1NH: TEdit
      Left = 72
      Top = 104
      Width = 89
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 3
    end
    object EditM2ND: TEdit
      Left = 240
      Top = 80
      Width = 89
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 7
    end
    object EditM2NH: TEdit
      Left = 240
      Top = 104
      Width = 89
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 8
    end
    object EditM3ND: TEdit
      Left = 408
      Top = 80
      Width = 89
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 12
    end
    object EditM3NH: TEdit
      Left = 408
      Top = 104
      Width = 89
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 13
    end
  end
  object RadioGroup3: TRadioGroup
    Left = 8
    Top = 88
    Width = 281
    Height = 113
    Caption = '��� �������'
    Items.Strings = (
      '������ ���������� �������'
      '������ ������������ �������'
      '������ ����������� ����������'
      '������ ������ �������'
      '������ ����������� �������'
      '������ ������� ����������� ������ �� ����'
      '������ ����������� �����������')
    TabOrder = 5
  end
  object grbBirthDate: TGroupBox
    Left = 352
    Top = 8
    Width = 161
    Height = 73
    Caption = '������'
    TabOrder = 3
    object lbBirthDateFrom: TLabel
      Left = 8
      Top = 20
      Width = 9
      Height = 13
      Caption = '�:'
    end
    object lbBirthDateTo: TLabel
      Left = 8
      Top = 44
      Width = 15
      Height = 13
      Caption = '��:'
    end
    object dtpBirthDateFrom: TDateTimePicker
      Left = 32
      Top = 16
      Width = 97
      Height = 22
      CalAlignment = dtaLeft
      Date = 37147
      Time = 37147
      ShowCheckbox = True
      Checked = False
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 0
    end
    object dtpBirthDateTo: TDateTimePicker
      Left = 32
      Top = 40
      Width = 97
      Height = 22
      CalAlignment = dtaLeft
      Date = 37147
      Time = 37147
      ShowCheckbox = True
      Checked = False
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
    end
    object bibBirthDate: TBitBtn
      Left = 133
      Top = 25
      Width = 21
      Height = 21
      Hint = '�������'
      Caption = '...'
      TabOrder = 2
      OnClick = bibBirthDateClick
    end
  end
  object CurrencyEdit3: TCurrencyEdit
    Left = 104
    Top = 536
    Width = 121
    Height = 21
    AutoSize = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 10
  end
  object quEmpPlant: TIBQuery
    Transaction = trRead
    BufferChunks = 1000
    CachedUpdates = False
    Left = 128
  end
  object trRead: TIBTransaction
    Active = False
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    AutoStopAction = saNone
    Left = 208
  end
  object memData: TRxMemoryData
    Active = True
    FieldDefs = <
      item
        Name = 'FDate'
        DataType = ftDate
      end
      item
        Name = 'LeaveDaysCount'
        DataType = ftInteger
      end
      item
        Name = 'LeaveHoursCount'
        DataType = ftFloat
      end
      item
        Name = 'NormalDaysCount'
        DataType = ftInteger
      end
      item
        Name = 'NormalHoursCount'
        DataType = ftFloat
      end
      item
        Name = 'CalendarDays'
        DataType = ftInteger
      end
      item
        Name = 'OnePay'
        DataType = ftCurrency
      end>
    Left = 208
    Top = 432
    object memDataFDate: TDateField
      DisplayLabel = '����'
      FieldName = 'FDate'
    end
    object memDataLeaveDaysCount: TIntegerField
      DisplayLabel = '��� ������'
      FieldName = 'LeaveDaysCount'
    end
    object memDataLeaveHoursCount: TFloatField
      DisplayLabel = '���� ������'
      FieldName = 'LeaveHoursCount'
    end
    object memDataNormalDaysCount: TIntegerField
      DisplayLabel = '����� ����'
      FieldName = 'NormalDaysCount'
    end
    object memDataNormalHoursCount: TFloatField
      DisplayLabel = '����� �����'
      FieldName = 'NormalHoursCount'
    end
    object memDataCalendarDays: TIntegerField
      DisplayLabel = '����������� ���'
      FieldName = 'CalendarDays'
    end
    object memDataOnePay: TCurrencyField
      DisplayLabel = '�����'
      FieldName = 'OnePay'
    end
  end
  object dsData: TDataSource
    DataSet = memData
    Left = 280
    Top = 456
  end
end
