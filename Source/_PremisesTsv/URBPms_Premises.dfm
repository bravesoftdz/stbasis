inherited fmRBPms_Premises: TfmRBPms_Premises
  Left = 526
  Top = 328
  Width = 548
  Height = 420
  Caption = '������������'
  Constraints.MinHeight = 420
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBackGrid: TPanel
    Width = 540
    Height = 330
    inherited pnBut: TPanel
      Left = 456
      Height = 330
      inherited pnModal: TPanel
        Height = 229
        inherited bibFilter: TButton
          Top = 67
        end
        inherited bibView: TButton
          Top = 35
          OnClick = bibViewClick
        end
        inherited bibRefresh: TButton
          Top = 3
        end
        inherited bibAdjust: TButton
          Top = 99
        end
        inherited bibPreview: TButton
          Top = 131
        end
        object btExtension: TButton
          Left = 3
          Top = 163
          Width = 75
          Height = 25
          Hint = '�������� �� ����'
          Caption = '��������'
          TabOrder = 5
          OnClick = btExtensionClick
          OnKeyDown = FormKeyDown
        end
        object btAdvertisment: TButton
          Left = 3
          Top = 195
          Width = 75
          Height = 25
          Caption = '�������'
          ParentShowHint = False
          ShowHint = False
          TabOrder = 6
          OnClick = btAdvertismentClick
        end
      end
      inherited pnSQL: TPanel
        inherited bibAdd: TButton
          OnClick = bibAddClick
        end
        inherited bibChange: TButton
          OnClick = bibChangeClick
        end
        inherited bibDel: TButton
          OnClick = bibDelClick
        end
      end
    end
    inherited pnGrid: TPanel
      Width = 456
      Height = 330
      object tcGrid: TTabControl
        Left = 5
        Top = 5
        Width = 446
        Height = 320
        Align = alClient
        HotTrack = True
        Images = iL
        TabOrder = 0
        Tabs.Strings = (
          '�������'
          '������'
          '�������')
        TabIndex = 0
        OnChange = tcGridChange
        OnChanging = tcGridChanging
      end
    end
  end
  inherited pnFind: TPanel
    Width = 540
    inherited edSearch: TEdit
      Anchors = [akLeft, akTop, akBottom]
    end
  end
  inherited pnBottom: TPanel
    Top = 358
    Width = 540
    inherited bibOk: TButton
      Left = 377
    end
    inherited bibClose: TButton
      Left = 459
    end
  end
  inherited Mainqr: TIBQuery
    AfterScroll = MainqrAfterScroll
    CachedUpdates = True
    UpdateObject = IBUpd
  end
  object iL: TImageList
    Left = 136
    Top = 168
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
