inherited fmRBNomenclature: TfmRBNomenclature
  Left = 393
  Top = 165
  Width = 635
  Height = 452
  Caption = '������������'
  Icon.Data = {
    0000010001001010100000000000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    000000000FFF000000000000FF0F00000000000FF0FF000000000F000FFF0007
    11111180FF0F001F7FF800FFF0F000FF7F00FFF00F0F00FF7F08000000F000FF
    7F0FF0F8100000FF7F0000F8100000FF7F0FF0F8100000FF7F0FF0F8100000FF
    7FFFFFF8000000FF00000000000000000000000000000000000000000000FFF0
    0000FFE00000FFC00000E0000000800000008000000080000000800000008000
    000080030000800300008003000080030000800F00008FFF0000FFFF0000}
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBackGrid: TPanel
    Width = 627
    Height = 343
    inherited pnBut: TPanel
      Left = 543
      Height = 343
      inherited pnModal: TPanel
        Height = 242
        inherited bibView: TBitBtn
          OnClick = bibViewClick
        end
        object chbNoTreeView: TCheckBox
          Left = 9
          Top = 136
          Width = 73
          Height = 17
          Hint = '���������� ������������ �������'
          Caption = '�������'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = chbNoTreeViewClick
        end
      end
      inherited pnSQL: TPanel
        inherited bibAdd: TBitBtn
          OnClick = bibAddClick
        end
        inherited bibChange: TBitBtn
          OnClick = bibChangeClick
        end
        inherited bibDel: TBitBtn
          OnClick = bibDelClick
        end
      end
    end
    inherited pnGrid: TPanel
      Width = 543
      Height = 343
      object splDetail: TSplitter
        Left = 5
        Top = 187
        Width = 533
        Height = 3
        Cursor = crSizeNS
        Align = alBottom
      end
      object splGroup: TSplitter
        Left = 190
        Top = 5
        Width = 3
        Height = 182
        Cursor = crSizeWE
      end
      object pnDetail: TPanel
        Left = 5
        Top = 190
        Width = 533
        Height = 148
        Align = alBottom
        BevelOuter = bvNone
        Constraints.MinHeight = 148
        TabOrder = 0
        object tcDetail: TTabControl
          Left = 0
          Top = 0
          Width = 533
          Height = 148
          Align = alClient
          HotTrack = True
          TabOrder = 0
          Tabs.Strings = (
            '����'
            '������� ���������'
            '�������� �������')
          TabIndex = 0
          OnChange = tcDetailChange
          object pntsDetail: TPanel
            Left = 4
            Top = 24
            Width = 525
            Height = 120
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object pnButDetail: TPanel
              Left = 444
              Top = 0
              Width = 81
              Height = 120
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 0
              object bibAddDetail: TBitBtn
                Left = 6
                Top = 5
                Width = 70
                Height = 23
                Anchors = [akTop, akRight]
                Caption = '��������'
                TabOrder = 0
                OnKeyDown = FormKeyDown
              end
              object bibChangeDetail: TBitBtn
                Left = 6
                Top = 34
                Width = 70
                Height = 23
                Anchors = [akTop, akRight]
                Caption = '��������'
                TabOrder = 1
                OnKeyDown = FormKeyDown
              end
              object bibDelDetail: TBitBtn
                Left = 6
                Top = 63
                Width = 70
                Height = 23
                Anchors = [akTop, akRight]
                Caption = '�������'
                TabOrder = 2
                OnKeyDown = FormKeyDown
              end
              object bibAdjustDetail: TBitBtn
                Left = 6
                Top = 92
                Width = 70
                Height = 23
                Anchors = [akTop, akRight]
                Caption = '���������'
                TabOrder = 3
                OnClick = bibAdjustDetailClick
                OnKeyDown = FormKeyDown
              end
            end
          end
        end
      end
      object pnGroup: TPanel
        Left = 5
        Top = 5
        Width = 185
        Height = 182
        Align = alLeft
        BevelOuter = bvNone
        Constraints.MinWidth = 100
        TabOrder = 1
      end
    end
  end
  inherited pnFind: TPanel
    Width = 627
    inherited edSearch: TEdit
      Anchors = [akLeft, akTop, akBottom]
    end
  end
  inherited pnBottom: TPanel
    Top = 371
    Width = 627
    inherited bibOk: TBitBtn
      Left = 464
    end
    inherited bibClose: TBitBtn
      Left = 546
    end
  end
  inherited ds: TDataSource
    Left = 280
    Top = 64
  end
  inherited Mainqr: TIBQuery
    OnCalcFields = MainqrCalcFields
    CachedUpdates = True
    DataSource = dsGroup
    ParamCheck = True
    UpdateObject = IBUpd
    Left = 312
    Top = 64
  end
  inherited IBTran: TIBTransaction
    Left = 344
    Top = 65
  end
  inherited pmGrid: TPopupMenu
    Left = 376
    Top = 65
  end
  inherited IBUpd: TIBUpdateSQL
    Left = 408
    Top = 65
  end
  object IL: TImageList
    Left = 304
    Top = 113
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF008484840000000000000000000000000084848400FFFF
      FF0000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00848484000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60084848400000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C600000000008484840000000000000000000000000084848400FFFF
      FF00848484008484840084848400FFFFFF00848484008484840084848400FFFF
      FF00848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0084848400000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60084848400000000008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C600848484000000000084848400FFFFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF0000000000848484008484840000000000000000000000000084848400FFFF
      FF0084848400848484008484840084848400FFFFFF008484840084848400FFFF
      FF00848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF00848484000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      840000000000C6C6C6008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C60084848400000000008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840000FFFF008484840000000000000000000000000084848400FFFF
      FF00848484008484840084848400FFFFFF008484840084848400FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00C6C6C60000FFFF0084848400000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6
      C60000FFFF00C6C6C6008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000084848400FFFFFF0000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF0084848400848484008484840084848400FFFFFF008484840084848400FFFF
      FF00848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000FFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF0084848400848484008484
      8400848484008484840084848400000000000000000084848400FFFFFF00C6C6
      C60000FFFF00C6C6C60000FFFF00C6C6C600FFFFFF0084848400848484008484
      840084848400848484008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484840000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF008484840000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484840000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFFFFFE0030000
      C000E000C00300008000C000C00300008000C000C003000080008000C0030000
      80008000C003000080000000C003000080000000C003000080000000C0030000
      80008000C003000080008000C003000080018001C0030000C07FC07FC0030000
      E0FFE0FFC0070000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
  object dsGroup: TDataSource
    DataSet = qrGroup
    Left = 24
    Top = 65
  end
  object qrGroup: TIBQuery
    Transaction = tranGroup
    AfterScroll = qrGroupAfterScroll
    BufferChunks = 50
    CachedUpdates = False
    ParamCheck = False
    Left = 24
    Top = 113
  end
  object tranGroup: TIBTransaction
    Active = False
    DefaultAction = TARollback
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    AutoStopAction = saNone
    Left = 24
    Top = 161
  end
  object dsDetail: TDataSource
    DataSet = qrDetail
    Left = 36
    Top = 305
  end
  object qrDetail: TIBQuery
    Transaction = tranDetail
    AfterScroll = qrGroupAfterScroll
    BufferChunks = 50
    CachedUpdates = True
    DataSource = ds
    UpdateObject = updDetail
    Left = 80
    Top = 305
  end
  object tranDetail: TIBTransaction
    Active = False
    DefaultAction = TARollback
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    AutoStopAction = saNone
    Left = 120
    Top = 305
  end
  object updDetail: TIBUpdateSQL
    Left = 168
    Top = 305
  end
end