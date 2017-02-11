inherited fmSrvImport: TfmSrvImport
  Left = 384
  Top = 232
  Width = 580
  Height = 420
  ActiveControl = bibLoad
  Caption = 'fmSrvImport'
  Constraints.MinHeight = 420
  Constraints.MinWidth = 580
  Icon.Data = {
    0000010001001010100000000000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000C00000000000000CC0000000000000CCCCCCC00FFF
    FF0CCCCCCCC00FFFF0CCCCCCCCC00F00FF0CCCCCCCC00FFFFFF0CCCCCCC00F00
    FFFF0CC000000FFFFFFFF0C000000F00F000000000000FFFF0FF000000000F08
    F0F0000000000FFFF0000000000000000000000000000000000000000000FFDF
    0000FF9F0000FF1F00000000000000000000000000000000000000000000001F
    0000001F0000001F0000007F000000FF000001FF000003FF0000FFFF0000}
  PixelsPerInch = 96
  TextHeight = 13
  object spl: TSplitter
    Left = 0
    Top = 211
    Width = 572
    Height = 3
    Cursor = crSizeNS
    Align = alTop
    MinSize = 100
  end
  object pnBut: TPanel
    Left = 0
    Top = 348
    Width = 572
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object lbCount: TLabel
      Left = 94
      Top = 15
      Width = 42
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = '�����: 0'
    end
    object bibLoad: TButton
      Left = 7
      Top = 9
      Width = 75
      Height = 25
      Hint = '��������� ������������� ������'
      Anchors = [akLeft, akBottom]
      Caption = '���������'
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      OnClick = bibLoadClick
    end
    object bibImport: TButton
      Left = 292
      Top = 9
      Width = 109
      Height = 25
      Hint = '������������� � ���������� ...'
      Anchors = [akRight, akBottom]
      Caption = '������������� ...'
      TabOrder = 1
      OnClick = bibImportClick
    end
    object bibBreak: TButton
      Left = 408
      Top = 9
      Width = 75
      Height = 25
      Hint = '�������� ����������'
      Anchors = [akRight, akBottom]
      Caption = '��������'
      Enabled = False
      TabOrder = 2
      OnClick = bibBreakClick
    end
    object bibClose: TButton
      Left = 490
      Top = 9
      Width = 75
      Height = 25
      Hint = '�������'
      Anchors = [akRight, akBottom]
      Caption = '�������'
      TabOrder = 3
      OnClick = bibCloseClick
    end
  end
  object pnGrbBack: TPanel
    Left = 0
    Top = 41
    Width = 572
    Height = 170
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 5
    Constraints.MinHeight = 100
    TabOrder = 1
    object grbRichEdit: TGroupBox
      Left = 5
      Top = 5
      Width = 562
      Height = 160
      Align = alClient
      Caption = ' ������������� ������ '
      TabOrder = 0
      object pnBackRichEdit: TPanel
        Left = 2
        Top = 15
        Width = 558
        Height = 143
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        TabOrder = 0
      end
    end
  end
  object pnGrid: TPanel
    Left = 0
    Top = 214
    Width = 572
    Height = 134
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    Constraints.MinHeight = 100
    TabOrder = 2
  end
  object pnRelease: TPanel
    Left = 0
    Top = 0
    Width = 572
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbRelease: TLabel
      Left = 226
      Top = 18
      Width = 80
      Height = 13
      Anchors = [akTop, akRight]
      Caption = '������ ������:'
    end
    object edRelease: TEdit
      Left = 316
      Top = 15
      Width = 223
      Height = 21
      Anchors = [akTop, akRight]
      Color = clBtnFace
      MaxLength = 100
      ReadOnly = True
      TabOrder = 0
    end
    object bibRelease: TButton
      Left = 539
      Top = 15
      Width = 21
      Height = 21
      Hint = '�������'
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 1
      OnClick = bibReleaseClick
    end
  end
  object od: TOpenDialog
    Filter = 
      '����� RTF (*.rtf)|*.rtf|����� TXT (*.txt)|*.txt|��� ����� (*.*)|' +
      '*.*'
    Options = [ofAllowMultiSelect, ofEnableSizing]
    Left = 58
    Top = 103
  end
  object ds: TDataSource
    Left = 40
    Top = 205
  end
  object qr: TIBQuery
    BufferChunks = 1
    CachedUpdates = False
    ParamCheck = False
    Left = 88
    Top = 205
  end
  object tran: TIBTransaction
    Active = False
    AutoStopAction = saNone
    Left = 128
    Top = 205
  end
end
