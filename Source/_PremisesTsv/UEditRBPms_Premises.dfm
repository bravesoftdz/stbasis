inherited fmEditRBPms_Premises: TfmEditRBPms_Premises
  Left = 556
  Top = 168
  Caption = 'fmEditRBPms_Premises'
  ClientHeight = 563
  ClientWidth = 631
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbDateArrivalsFrom: TLabel [0]
    Left = 89
    Top = 12
    Width = 96
    Height = 13
    Caption = '���� �����������:'
    FocusControl = dtpDateArrivalsFrom
  end
  object lbTo: TLabel [1]
    Left = 280
    Top = 12
    Width = 15
    Height = 13
    Caption = '��:'
    Visible = False
  end
  object lbRecyled: TLabel [2]
    Left = 423
    Top = 6
    Width = 71
    Height = 26
    Alignment = taRightJustify
    Caption = '������ �����������:'
    FocusControl = cmbRecyled
    WordWrap = True
  end
  object lbFloor: TLabel [3]
    Left = 396
    Top = 109
    Width = 29
    Height = 13
    Alignment = taRightJustify
    Caption = '����:'
    FocusControl = edFloor
  end
  object lbCountFloor: TLabel [4]
    Left = 499
    Top = 109
    Width = 58
    Height = 13
    Alignment = taRightJustify
    Caption = '���������:'
    FocusControl = edCountFloor
  end
  object lbTypeHouse: TLabel [5]
    Left = 434
    Top = 133
    Width = 51
    Height = 13
    Alignment = taRightJustify
    Caption = '��� ����:'
    FocusControl = cmbTypeHouse
  end
  object lbHouse: TLabel [6]
    Left = 376
    Top = 90
    Width = 27
    Height = 13
    Caption = '���'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object bvHouse: TBevel [7]
    Left = 408
    Top = 96
    Width = 213
    Height = 3
    Shape = bsTopLine
  end
  object lbContact1: TLabel [8]
    Left = 9
    Top = 50
    Width = 49
    Height = 13
    Caption = '1 �������'
    FocusControl = edContact1
  end
  object lbClientInfo: TLabel [9]
    Left = 392
    Top = 50
    Width = 94
    Height = 13
    Caption = '������ (��������)'
    FocusControl = ComboBoxClientInfo
  end
  object lbDelim1: TLabel [10]
    Left = 95
    Top = 69
    Width = 6
    Height = 13
    Caption = ', '
  end
  object lbDelim2: TLabel [11]
    Left = 189
    Top = 69
    Width = 6
    Height = 13
    Caption = ', '
  end
  object lbContact2: TLabel [12]
    Left = 104
    Top = 50
    Width = 49
    Height = 13
    Caption = '2 �������'
    FocusControl = edContact2
  end
  object lbContact3: TLabel [13]
    Left = 199
    Top = 50
    Width = 49
    Height = 13
    Caption = '3 �������'
    FocusControl = edContact3
  end
  object lbDelim3: TLabel [14]
    Left = 284
    Top = 69
    Width = 6
    Height = 13
    Caption = ', '
  end
  object lbContact4: TLabel [15]
    Left = 294
    Top = 50
    Width = 49
    Height = 13
    Caption = '4 �������'
    FocusControl = edContact4
  end
  object lbDelim4: TLabel [16]
    Left = 379
    Top = 69
    Width = 3
    Height = 13
  end
  object lbContact: TLabel [17]
    Left = 8
    Top = 34
    Width = 49
    Height = 13
    Caption = '�������'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel [18]
    Left = 64
    Top = 40
    Width = 557
    Height = 3
    Shape = bsTopLine
  end
  object lbRegion: TLabel [19]
    Left = 30
    Top = 109
    Width = 34
    Height = 13
    Alignment = taRightJustify
    Caption = '�����:'
    FocusControl = cmbRegion
  end
  object lbStreet: TLabel [20]
    Left = 29
    Top = 157
    Width = 35
    Height = 13
    Alignment = taRightJustify
    Caption = '�����:'
    FocusControl = cmbStreet
  end
  object lbHouseNumber: TLabel [21]
    Left = 21
    Top = 181
    Width = 43
    Height = 13
    Alignment = taRightJustify
    Caption = '� ����:'
    FocusControl = edHouseNumber
  end
  object lbApartmentNumber: TLabel [22]
    Left = 186
    Top = 181
    Width = 66
    Height = 13
    Alignment = taRightJustify
    Caption = '� ��������:'
    FocusControl = edApartmentNumber
  end
  object lbAddress: TLabel [23]
    Left = 8
    Top = 90
    Width = 37
    Height = 13
    Caption = '�����'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel2: TBevel [24]
    Left = 55
    Top = 96
    Width = 305
    Height = 3
    Shape = bsTopLine
  end
  object lbCountRoom: TLabel [25]
    Left = 31
    Top = 225
    Width = 77
    Height = 13
    Alignment = taRightJustify
    Caption = '���-�� ������:'
    FocusControl = cmbCountRoom
  end
  object lbTypeRoom: TLabel [26]
    Left = 46
    Top = 249
    Width = 62
    Height = 13
    Alignment = taRightJustify
    Caption = '��� ������:'
    FocusControl = cmbTypeRoom
  end
  object lbPlanning: TLabel [27]
    Left = 43
    Top = 273
    Width = 65
    Height = 13
    Alignment = taRightJustify
    Caption = '����������:'
    FocusControl = cmbPlanning
  end
  object lbGeneralArea: TLabel [28]
    Left = 22
    Top = 297
    Width = 86
    Height = 13
    Alignment = taRightJustify
    Caption = '����� �������:'
    FocusControl = edGeneralArea
  end
  object lbDwellingArea: TLabel [29]
    Left = 22
    Top = 321
    Width = 86
    Height = 13
    Alignment = taRightJustify
    Caption = '����� �������:'
    FocusControl = edDwellingArea
  end
  object lbKitchenArea: TLabel [30]
    Left = 27
    Top = 345
    Width = 81
    Height = 13
    Alignment = taRightJustify
    Caption = '������� �����:'
    FocusControl = edKitchenArea
  end
  object lbPhone: TLabel [31]
    Left = 270
    Top = 225
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = '�������:'
    FocusControl = cmbPhone
  end
  object lbBalcony: TLabel [32]
    Left = 233
    Top = 249
    Width = 85
    Height = 13
    Alignment = taRightJustify
    Caption = '������/������:'
    FocusControl = cmbBalcony
  end
  object lbSanitaryNode: TLabel [33]
    Left = 273
    Top = 273
    Width = 45
    Height = 13
    Alignment = taRightJustify
    Caption = '�������:'
    FocusControl = cmbSanitaryNode
  end
  object lbCondition: TLabel [34]
    Left = 261
    Top = 314
    Width = 57
    Height = 26
    Alignment = taRightJustify
    Caption = '��������� (������):'
    FocusControl = cmbCondition
    WordWrap = True
  end
  object lbStove: TLabel [35]
    Left = 284
    Top = 297
    Width = 34
    Height = 13
    Alignment = taRightJustify
    Caption = '�����:'
    FocusControl = cmbStove
  end
  object lbFurniture: TLabel [36]
    Left = 465
    Top = 249
    Width = 42
    Height = 13
    Alignment = taRightJustify
    Caption = '������:'
    FocusControl = cmbFurniture
  end
  object lbDoor: TLabel [37]
    Left = 471
    Top = 273
    Width = 36
    Height = 13
    Alignment = taRightJustify
    Caption = '�����:'
    FocusControl = cmbDoor
  end
  object lbTerm: TLabel [38]
    Left = 479
    Top = 297
    Width = 28
    Height = 13
    Alignment = taRightJustify
    Caption = '����:'
    FocusControl = edTerm
  end
  object lbPayment: TLabel [39]
    Left = 452
    Top = 321
    Width = 55
    Height = 13
    Alignment = taRightJustify
    Caption = '������ ��:'
    FocusControl = edPayment
  end
  object lbPrice: TLabel [40]
    Left = 454
    Top = 441
    Width = 29
    Height = 13
    Alignment = taRightJustify
    Caption = '����:'
    FocusControl = edPrice
  end
  object lbDocument: TLabel [41]
    Left = 453
    Top = 225
    Width = 54
    Height = 13
    Alignment = taRightJustify
    Caption = '��������:'
    FocusControl = cmbDocument
  end
  object lbSaleStatus: TLabel [42]
    Left = 234
    Top = 345
    Width = 84
    Height = 13
    Alignment = taRightJustify
    Caption = '������ �������:'
    FocusControl = cmbSaleStatus
  end
  object lbSelfForm: TLabel [43]
    Left = 243
    Top = 369
    Width = 75
    Height = 13
    Alignment = taRightJustify
    Caption = '����� ���-��:'
    FocusControl = cmbSelfForm
  end
  object lbTypePremises: TLabel [44]
    Left = 255
    Top = 393
    Width = 63
    Height = 13
    Alignment = taRightJustify
    Caption = '��� ����-��:'
    FocusControl = cmbTypePremises
  end
  object lbApartment: TLabel [45]
    Left = 8
    Top = 204
    Width = 57
    Height = 13
    Caption = '��������'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel3: TBevel [46]
    Left = 72
    Top = 210
    Width = 549
    Height = 3
    Shape = bsTopLine
  end
  object lbNote: TLabel [47]
    Left = 10
    Top = 480
    Width = 66
    Height = 13
    Alignment = taRightJustify
    Caption = '����������:'
    FocusControl = edNote
  end
  object lbStation: TLabel [48]
    Left = 302
    Top = 481
    Width = 37
    Height = 13
    Alignment = taRightJustify
    Caption = '������:'
    FocusControl = cmbStation
  end
  object lbAgent: TLabel [49]
    Left = 415
    Top = 481
    Width = 32
    Height = 13
    Alignment = taRightJustify
    Caption = '�����:'
    FocusControl = cmbAgent
  end
  object lbAdditional: TLabel [50]
    Left = 8
    Top = 459
    Width = 94
    Height = 13
    Caption = '�������������'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel4: TBevel [51]
    Left = 112
    Top = 465
    Width = 509
    Height = 3
    Shape = bsTopLine
  end
  object lbNN: TLabel [52]
    Left = 8
    Top = 12
    Width = 22
    Height = 13
    Caption = '��'
    FocusControl = edNN
  end
  object lbGroundArea: TLabel [53]
    Left = 442
    Top = 339
    Width = 65
    Height = 26
    Alignment = taRightJustify
    Caption = '������� ���.�������:'
    FocusControl = edGroundArea
    WordWrap = True
  end
  object lbWater: TLabel [54]
    Left = 24
    Top = 369
    Width = 84
    Height = 13
    Alignment = taRightJustify
    Caption = '�������������:'
    FocusControl = cmbWater
  end
  object lbHeat: TLabel [55]
    Left = 50
    Top = 393
    Width = 58
    Height = 13
    Alignment = taRightJustify
    Caption = '���������:'
    FocusControl = cmbHeat
  end
  object lbStyle: TLabel [56]
    Left = 521
    Top = 481
    Width = 33
    Height = 13
    Alignment = taRightJustify
    Caption = '�����:'
    FocusControl = cmbStyle
  end
  object lbBuilder: TLabel [57]
    Left = 442
    Top = 393
    Width = 66
    Height = 13
    Alignment = taRightJustify
    Caption = '����������:'
    FocusControl = cmbBuilder
  end
  object lbDelivery: TLabel [58]
    Left = 475
    Top = 370
    Width = 33
    Height = 13
    Alignment = taRightJustify
    Caption = '�����:'
    FocusControl = edDelivery
  end
  object lbBlockSection: TLabel [59]
    Left = 418
    Top = 157
    Width = 67
    Height = 13
    Alignment = taRightJustify
    Caption = '���� ������:'
    FocusControl = edBlockSection
  end
  object lbDecoration: TLabel [60]
    Left = 62
    Top = 418
    Width = 46
    Height = 13
    Alignment = taRightJustify
    Caption = '�������:'
    FocusControl = edDecoration
  end
  object lbGlassy: TLabel [61]
    Left = 254
    Top = 418
    Width = 64
    Height = 13
    Alignment = taRightJustify
    Caption = '����������:'
    FocusControl = edGlassy
  end
  object lbPrice2: TLabel [62]
    Left = 447
    Top = 417
    Width = 61
    Height = 13
    Alignment = taRightJustify
    Caption = '���� �� �2:'
    FocusControl = edPrice2
  end
  object lbCityRegion: TLabel [63]
    Left = 11
    Top = 134
    Width = 57
    Height = 13
    Alignment = taRightJustify
    Caption = '���. �����:'
    FocusControl = cmbCityRegion
  end
  object Label1: TLabel [64]
    Left = 11
    Top = 506
    Width = 136
    Height = 13
    Alignment = taRightJustify
    Caption = '���������� ��� �������:'
    FocusControl = edAdvertismentNote
  end
  inherited pnBut: TPanel
    Top = 526
    Width = 631
    Height = 37
    TabOrder = 57
    inherited Panel2: TPanel
      Left = 446
      Height = 37
    end
    object bibAdvertisment: TButton
      Left = 382
      Top = 5
      Width = 75
      Height = 25
      Hint = '�����������'
      Caption = '�������'
      TabOrder = 4
      OnClick = bibAdvertismentClick
    end
  end
  inherited cbInString: TCheckBox
    Left = 92
    Top = 537
    Height = 13
    TabOrder = 56
  end
  object dtpDateArrivalsFrom: TDateTimePicker [67]
    Left = 193
    Top = 8
    Width = 81
    Height = 22
    CalAlignment = dtaLeft
    Date = 37679.8510557176
    Time = 37679.8510557176
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 1
    OnChange = dtpDateArrivalsFromChange
  end
  object dtpDateArrivalsTo: TDateTimePicker [68]
    Left = 305
    Top = 8
    Width = 81
    Height = 22
    CalAlignment = dtaLeft
    Date = 37679.8510557176
    Time = 37679.8510557176
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 2
    Visible = False
  end
  object btPeriod: TButton [69]
    Left = 392
    Top = 8
    Width = 22
    Height = 22
    Hint = '����� �������'
    Caption = '...'
    TabOrder = 3
    Visible = False
    OnClick = btPeriodClick
  end
  object cmbRecyled: TComboBox [70]
    Left = 501
    Top = 7
    Width = 122
    Height = 24
    Style = csOwnerDrawFixed
    ItemHeight = 18
    TabOrder = 4
    OnChange = cmbRecyledChange
    OnDrawItem = cmbRecyledDrawItem
    Items.Strings = (
      '��������'
      '�������'
      '���')
  end
  object edFloor: TEdit [71]
    Left = 435
    Top = 106
    Width = 50
    Height = 21
    TabOrder = 17
    OnChange = edContact1Change
  end
  object edCountFloor: TEdit [72]
    Left = 567
    Top = 106
    Width = 50
    Height = 21
    TabOrder = 18
    OnChange = edContact1Change
    OnKeyPress = edContact1KeyPress
  end
  object cmbTypeHouse: TComboBox [73]
    Left = 495
    Top = 130
    Width = 122
    Height = 21
    ItemHeight = 13
    TabOrder = 19
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object edContact1: TEdit [74]
    Left = 8
    Top = 65
    Width = 56
    Height = 21
    TabOrder = 5
    OnChange = edContact1Change
    OnEnter = edContact1Enter
    OnExit = edContact1Exit
    OnKeyDown = edContact1KeyDown
  end
  object edContact2: TEdit [75]
    Left = 102
    Top = 65
    Width = 56
    Height = 21
    TabOrder = 7
    OnChange = edContact1Change
    OnEnter = edContact1Enter
    OnExit = edContact1Exit
    OnKeyDown = edContact1KeyDown
  end
  object edContact3: TEdit [76]
    Left = 197
    Top = 65
    Width = 56
    Height = 21
    TabOrder = 9
    OnChange = edContact1Change
    OnEnter = edContact1Enter
    OnExit = edContact1Exit
    OnKeyDown = edContact1KeyDown
  end
  object edContact4: TEdit [77]
    Left = 292
    Top = 65
    Width = 56
    Height = 21
    TabOrder = 11
    OnChange = edContact1Change
    OnEnter = edContact1Enter
    OnExit = edContact1Exit
    OnKeyDown = edContact1KeyDown
  end
  object ed1: TEdit [78]
    Left = 66
    Top = 65
    Width = 25
    Height = 21
    Hint = '��� �������� 1'
    TabOrder = 6
    OnChange = edContact1Change
  end
  object ed2: TEdit [79]
    Left = 160
    Top = 65
    Width = 25
    Height = 21
    Hint = '��� �������� 2'
    TabOrder = 8
    OnChange = edContact1Change
  end
  object ed3: TEdit [80]
    Left = 255
    Top = 65
    Width = 25
    Height = 21
    Hint = '��� �������� 3'
    TabOrder = 10
    OnChange = edContact1Change
  end
  object ed4: TEdit [81]
    Left = 350
    Top = 65
    Width = 25
    Height = 21
    Hint = '��� �������� 4'
    TabOrder = 12
    OnChange = edContact1Change
  end
  object cmbRegion: TComboBox [82]
    Left = 73
    Top = 106
    Width = 288
    Height = 21
    ItemHeight = 13
    TabOrder = 13
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnExit = edContact1Exit
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object cmbStreet: TComboBox [83]
    Left = 73
    Top = 154
    Width = 288
    Height = 21
    ItemHeight = 13
    TabOrder = 14
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnExit = edContact1Exit
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object edHouseNumber: TEdit [84]
    Left = 73
    Top = 178
    Width = 100
    Height = 21
    TabOrder = 15
    OnChange = edContact1Change
    OnExit = edContact1Exit
  end
  object edApartmentNumber: TEdit [85]
    Left = 261
    Top = 178
    Width = 100
    Height = 21
    TabOrder = 16
    OnChange = edContact1Change
    OnExit = edContact1Exit
  end
  object cmbCountRoom: TComboBox [86]
    Left = 118
    Top = 222
    Width = 104
    Height = 21
    ItemHeight = 13
    TabOrder = 21
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object cmbTypeRoom: TComboBox [87]
    Left = 118
    Top = 246
    Width = 104
    Height = 21
    ItemHeight = 13
    TabOrder = 22
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object cmbPlanning: TComboBox [88]
    Left = 118
    Top = 270
    Width = 82
    Height = 21
    ItemHeight = 13
    TabOrder = 23
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object edGeneralArea: TEdit [89]
    Left = 118
    Top = 294
    Width = 103
    Height = 21
    TabOrder = 25
    OnChange = edPrice2Change
    OnKeyPress = edPriceKeyPress
  end
  object edDwellingArea: TEdit [90]
    Left = 118
    Top = 318
    Width = 103
    Height = 21
    TabOrder = 26
    OnChange = edContact1Change
    OnKeyPress = edPriceKeyPress
  end
  object edKitchenArea: TEdit [91]
    Left = 118
    Top = 342
    Width = 103
    Height = 21
    TabOrder = 27
    OnChange = edContact1Change
    OnKeyPress = edPriceKeyPress
  end
  object cmbPhone: TComboBox [92]
    Left = 328
    Top = 222
    Width = 104
    Height = 21
    ItemHeight = 13
    TabOrder = 31
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object cmbBalcony: TComboBox [93]
    Left = 328
    Top = 246
    Width = 104
    Height = 21
    ItemHeight = 13
    TabOrder = 32
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object cmbSanitaryNode: TComboBox [94]
    Left = 328
    Top = 270
    Width = 104
    Height = 21
    ItemHeight = 13
    TabOrder = 33
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object cmbCondition: TComboBox [95]
    Left = 328
    Top = 318
    Width = 104
    Height = 21
    ItemHeight = 13
    TabOrder = 35
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object cmbStove: TComboBox [96]
    Left = 328
    Top = 294
    Width = 104
    Height = 21
    ItemHeight = 13
    TabOrder = 34
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object cmbFurniture: TComboBox [97]
    Left = 517
    Top = 246
    Width = 104
    Height = 21
    ItemHeight = 13
    TabOrder = 41
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object cmbDoor: TComboBox [98]
    Left = 517
    Top = 270
    Width = 104
    Height = 21
    ItemHeight = 13
    TabOrder = 42
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object edTerm: TEdit [99]
    Left = 517
    Top = 294
    Width = 104
    Height = 21
    TabOrder = 43
    OnChange = edContact1Change
  end
  object edPayment: TEdit [100]
    Left = 517
    Top = 318
    Width = 104
    Height = 21
    TabOrder = 44
    OnChange = edContact1Change
  end
  object edPrice: TEdit [101]
    Left = 493
    Top = 438
    Width = 87
    Height = 21
    TabOrder = 50
    OnChange = edPrice2Change
    OnKeyPress = edPriceKeyPress
  end
  object cmbDocument: TComboBox [102]
    Left = 517
    Top = 222
    Width = 104
    Height = 21
    ItemHeight = 13
    TabOrder = 40
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object btPlanning: TButton [103]
    Left = 201
    Top = 270
    Width = 21
    Height = 21
    Hint = '������� ���������� �� �����������'
    Caption = '...'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 24
    OnClick = btPlanningClick
  end
  object cmbSaleStatus: TComboBox [104]
    Left = 328
    Top = 342
    Width = 104
    Height = 21
    ItemHeight = 13
    TabOrder = 36
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object cmbSelfForm: TComboBox [105]
    Left = 328
    Top = 366
    Width = 104
    Height = 21
    ItemHeight = 13
    TabOrder = 37
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object cmbTypePremises: TComboBox [106]
    Left = 328
    Top = 390
    Width = 104
    Height = 21
    ItemHeight = 13
    TabOrder = 38
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object cmbPricePlus: TComboBox [107]
    Left = 493
    Top = 438
    Width = 40
    Height = 21
    Hint = '������� �� ����'
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 49
    Visible = False
    Items.Strings = (
      '='
      '>'
      '<'
      '>='
      '<='
      '<>')
  end
  object cmbUnitPrice: TComboBox [108]
    Left = 582
    Top = 438
    Width = 40
    Height = 21
    Hint = '������� ��������� ����'
    ItemHeight = 13
    TabOrder = 51
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
    Items.Strings = (
      '='
      '>'
      '<'
      '>='
      '<='
      '<>')
  end
  object edNote: TEdit [109]
    Left = 83
    Top = 477
    Width = 208
    Height = 21
    TabOrder = 52
    OnChange = edContact1Change
  end
  object cmbStation: TComboBox [110]
    Left = 346
    Top = 478
    Width = 60
    Height = 21
    ItemHeight = 13
    TabOrder = 53
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object cmbAgent: TComboBox [111]
    Left = 453
    Top = 477
    Width = 60
    Height = 21
    ItemHeight = 13
    TabOrder = 54
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object edNN: TEdit [112]
    Left = 37
    Top = 8
    Width = 45
    Height = 21
    TabOrder = 0
    OnChange = edContact1Change
  end
  object edGroundArea: TEdit [113]
    Left = 517
    Top = 342
    Width = 104
    Height = 21
    TabOrder = 45
    OnChange = edContact1Change
    OnKeyPress = edPriceKeyPress
  end
  object cmbWater: TComboBox [114]
    Left = 118
    Top = 366
    Width = 104
    Height = 21
    ItemHeight = 13
    TabOrder = 28
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object cmbHeat: TComboBox [115]
    Left = 118
    Top = 390
    Width = 104
    Height = 21
    ItemHeight = 13
    TabOrder = 29
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object cmbStyle: TComboBox [116]
    Left = 561
    Top = 477
    Width = 60
    Height = 21
    ItemHeight = 13
    TabOrder = 55
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object cmbBuilder: TComboBox [117]
    Left = 517
    Top = 390
    Width = 104
    Height = 21
    ItemHeight = 13
    TabOrder = 47
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object edDelivery: TEdit [118]
    Left = 517
    Top = 366
    Width = 104
    Height = 21
    TabOrder = 46
    OnChange = edContact1Change
  end
  object edBlockSection: TEdit [119]
    Left = 495
    Top = 154
    Width = 122
    Height = 21
    TabOrder = 20
    OnChange = edContact1Change
    OnKeyPress = edContact1KeyPress
  end
  object edDecoration: TEdit [120]
    Left = 118
    Top = 414
    Width = 103
    Height = 21
    TabOrder = 30
    OnChange = edContact1Change
  end
  object edGlassy: TEdit [121]
    Left = 328
    Top = 414
    Width = 103
    Height = 21
    TabOrder = 39
    OnChange = edContact1Change
  end
  object edPrice2: TEdit [122]
    Left = 516
    Top = 414
    Width = 104
    Height = 21
    TabOrder = 48
    OnChange = edPrice2Change
    OnKeyPress = edPriceKeyPress
  end
  object cmbCityRegion: TComboBox [123]
    Left = 73
    Top = 130
    Width = 288
    Height = 21
    ItemHeight = 13
    TabOrder = 58
    OnChange = edContact1Change
    OnEnter = cmbStreetEnter
    OnExit = edContact1Exit
    OnKeyDown = cmbStreetKeyDown
    OnKeyUp = cmbStreetKeyUp
  end
  object edAdvertismentNote: TEdit [124]
    Left = 160
    Top = 503
    Width = 460
    Height = 21
    TabOrder = 59
    OnChange = edContact1Change
  end
  object cbAdverisment: TCheckBox [125]
    Left = 284
    Top = 537
    Width = 133
    Height = 13
    Caption = '������ �� �������'
    TabOrder = 60
    Visible = False
  end
  object ComboBoxClientInfo: TComboBox [126]
    Left = 384
    Top = 65
    Width = 238
    Height = 21
    ItemHeight = 13
    TabOrder = 61
    OnChange = ComboBoxClientInfoChange
  end
  inherited IBTran: TIBTransaction
    Left = 176
    Top = 493
  end
  object iL: TImageList
    Left = 208
    Top = 488
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF00FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BF000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008080800080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000020FF2000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BF000000BF000000BF000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000C0C0C000C0C0C000C0C0C000808080008080
      8000000000000000000000000000000000000000000000000000000000003868
      2000487830005890400068A050000000000000FF000020F8280038F8400050F0
      580068E8780078E0900000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BF000000BF000000BF000000BF000000FFFF
      FF00000000000000000000000000000000000000000000000000808080008080
      800080808000C0C0C00000800000C0C0C000C0C0C000C0C0C000808080008080
      800080808000000000000000000000000000000000000000000098D8A8003058
      180040702800508038006098480000FF000010FF100028F8280040F0480050F0
      600068E8780080E0980098D8B000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BF000000BF000000BF000000FFFFFF00BF000000BF00
      0000FFFFFF00000000000000000000000000000000000000000080808000C0C0
      C000C0C0C00000800000008000000080000080808000C0C0C000808080008080
      8000808080000000000000000000000000000000000080E0980080E090002850
      10003860200048783000588840000000000018FF180028F8300040F0480058E8
      680070E8800088E09800A0D8B800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00BF000000BF000000BF000000FFFFFF000000000000000000BF00
      0000BF000000FFFFFF000000000000000000000000000000000080808000C0C0
      C00000800000C0C0C00000800000C0C0C00000800000C0C0C000808080008080
      8000808080008080800000000000000000000000000070E8800068E878000000
      0000000000000000000000000000000000000000000030F83800000000000000
      0000204000002040000028480000284800000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF008080
      80008080800080808000BF000000FFFFFF00FFFFFF0000000000000000000000
      0000BF000000FFFFFF0000000000000000000000000080808000C0C0C000C0C0
      C00000800000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008080
      80008080800080808000000000000000000058E8680058F0600050F0600050F0
      60000000000048F0580000000000000000000000000000000000000000000000
      0000000000003058180038601800386020000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000BF000000FFFFFF00000000000000000080808000C0C0C0000080
      00000080000000800000C0C0C0000080000000800000C0C0C000C0C0C0008080
      80008080800080808000000000000000000048F0500040F0480040F0480038F8
      400038F8400038F8400000000000000000000000000000000000000000000000
      0000407028004870300048783000487830000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF008080
      800080808000808080008080800080808000FFFFFF0000000000000000000000
      00000000000000000000BF000000FFFFFF000000000080808000C0C0C000C0C0
      C00000800000C0C0C000C0C0C0008080800000800000C0C0C000C0C0C0008080
      8000808080008080800080808000000000000000000028F8300028F8300028F8
      280020F828000000000000000000000000000000000000000000000000000000
      0000588840005888400058904000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000BF00000080808000C0C0C000C0C0C000C0C0
      C000C0C0C0000080000000800000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF008080800080808000808080000000000018FF180018FF180010FF180010FF
      100010FF10000000000000000000000000000000000000000000000000000000
      000068A0500068A8500068A85800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF008080
      800080808000000000000000000000000000FFFFFF0000000000000000000000
      00000000000000000000000000000000000080808000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000FFFFFF00FFFFFF0080808000C0C0C000C0C0C000C0C0
      C000FFFFFF0080808000808080000000000000FF000000FF000000FF000000FF
      0000000000000000000000000000000000000000000000000000000000005890
      40000000000070B0600000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000C0C0C000C0C0C000FFFF
      FF00FFFFFF00FFFFFF008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000FFFFFF00FFFFFF0080808000000000000000000000000000000000000000
      000000FF000010FF100000000000000000000000000000000000487028005888
      400068A050000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF008080
      8000808080000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF008080
      8000808080000000000080808000C0C0C000C0C0C000C0C0C000FFFFFF00FFFF
      FF008080800080808000000000000000000000000000000000000000000018FF
      200020F8280030F8380038F84000000000000000000030581000406828005080
      38006098480070B0580000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800080808000C0C0C000C0C0
      C0008080800000000000C0C0C000C0C0C000FFFFFF00FFFFFF00808080008080
      80000000000000000000000000000000000000000000000000000000000038F8
      400040F0500050F0580058F06000000000002040000028501000386820004878
      30000000000068A8580000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000C0C0C00080808000FFFFFF00FFFFFF008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000060E8700068E8780078E0880080E090002040000028480000386018000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080E0900088E0A00098D8A800A0D8B800A0D8B80020400000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFE0FFFFF0000FF9FF807FFBF0000
      FF0FE007E1030000FE0FC003C00100008007C003810100008023C0019FB00000
      803380010BF800008039800103F00000803C800087F10000803E000007F10000
      873F00000FEB0000803F0000F3C70000857F0003E183000080FF000FE10B0000
      81FFC03FF01F0000FFFFF0FFF03F0000}
  end
end