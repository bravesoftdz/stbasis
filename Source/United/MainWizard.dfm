object fmMainWizard: TfmMainWizard
  Left = 180
  Top = 148
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '��������'
  ClientHeight = 393
  ClientWidth = 542
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 352
    Width = 542
    Height = 3
    Align = alBottom
    Shape = bsTopLine
  end
  object Bevel2: TBevel
    Left = 0
    Top = 57
    Width = 542
    Height = 3
    Align = alTop
    Shape = bsTopLine
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 355
    Width = 542
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 172
      Top = 0
      Width = 370
      Height = 38
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btClose: TButton
        Left = 288
        Top = 8
        Width = 75
        Height = 25
        Hint = '������� ��������� � ������� ��������� ���������'
        Cancel = True
        Caption = '������'
        TabOrder = 0
        OnClick = btCloseClick
      end
      object btFinish: TButton
        Left = 207
        Top = 8
        Width = 75
        Height = 25
        Hint = '������� ��������� � ����������� ��������� ���������'
        Caption = '������'
        TabOrder = 1
      end
      object btPrior: TButton
        Left = 36
        Top = 8
        Width = 75
        Height = 25
        Hint = '������� � ���������� �������� ���������'
        Caption = '< �����'
        TabOrder = 2
        OnClick = btPriorClick
      end
      object btNext: TButton
        Left = 117
        Top = 8
        Width = 75
        Height = 25
        Hint = '������� � ��������� �������� ���������'
        Caption = '����� >'
        Default = True
        TabOrder = 3
        OnClick = btNextClick
      end
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 542
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 169
      Height = 57
      Align = alLeft
      Caption = '  �������� �� ������'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object pnImage: TPanel
      Left = 482
      Top = 0
      Width = 60
      Height = 57
      Align = alRight
      BevelOuter = bvNone
      BorderWidth = 5
      Color = clWhite
      TabOrder = 0
      object shpImage: TShape
        Left = 5
        Top = 5
        Width = 50
        Height = 47
        Align = alClient
        Brush.Style = bsClear
      end
      object ImageLogo: TImage
        Left = 5
        Top = 5
        Width = 50
        Height = 47
        Align = alClient
        Center = True
        Picture.Data = {
          055449636F6E0000010004001010100000000000280100004600000020201000
          00000000E80200006E0100002020000000000000A80800005604000030300000
          00000000A80E0000FE0C00002800000010000000200000000100040000000000
          C000000000000000000000001000000000000000000000000000800000800000
          00808000800000008000800080800000C0C0C000808080000000FF0000FF0000
          00FFFF00FF000000FF00FF00FFFF0000FFFFFF008484847C7C7C7C704848484B
          C767C780048484B8BC7C78700848484B87C7C700008484847C7C700000084848
          C7C6000000008484766000000000008800000000000000888000000000000888
          7700000000000888FF0000000000081871000000000008887700000000000088
          77000000000000008000000000000000000000000001FFFF0001FFFF8001FFFF
          8003FFFFC007FFFFE00FFFFFF01FFFFFFCFFFFFFFC7FFFFFF83FFFFFF83FFFFF
          F83FFFFFF83FFFFFFC3FFFFFFC3FFFFFFE3FFFFF280000002000000040000000
          0100040000000000800200000000000000000000100000000000000000000000
          000080000080000000808000800000008000800080800000C0C0C00080808000
          0000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0004848484
          848484848C6C6C7C7C7C7C70084848484848484B4BC7C7C7C7C7C7C004848484
          848484B8B8BC7C7C7C7C7C700848484848484B8B8B8BC7C7C7C7C7C004848484
          848487B8B8BC7C7C7C7C7C700048484848484B8B8B8BC7C7C7C7C7C000048484
          84848478B8BC7C7C7C7C7C00000048484848484BCBC7C7C7C7C7C00000000484
          848484848C7C7C7C7C7C00000000004848484848C7C7C7C7C7C0000000000004
          848484848C7C7C7C7C0000000000000048480848C7C7C7C7C000000000000000
          048484B4BC7C7C7C00000000000000000008888B87C7C0000000000000000000
          00007878B700000000000000000000000000078B8B0000000000000000000000
          00000878B80000000000000000000000000087877B7B00000000000000000000
          00087878B7B7B00000000000000000000007878B7FFF70000000000000000000
          00087878FFFFB0000000000000000000000787877B7FF0000000000000000000
          00087078B70FB0000000000000000000000787778B7B70000000000000000000
          00087878B8B7B0000000000000000000000787878B8B70000000000000000000
          0000787877700000000000000000000000000000000000000000000000000000
          0000000008000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000080000001
          80000001800000018000000180000001C0000001E0000003F0000007F800000F
          FC00001FFE00003FFF00007FFF8000FFFFE007FFFFF03FFFFFF83FFFFFF83FFF
          FFF00FFFFFE007FFFFE007FFFFE007FFFFE007FFFFE007FFFFE007FFFFE007FF
          FFE007FFFFF00FFFFFFC0FFFFFFC0FFFFFFC0FFFFFFE1FFFFFFFFFFF28000000
          2000000040000000010008000000000080040000000000000000000000010000
          0000000000000000000080000080000000808000800000008000800080800000
          C0C0C000C0DCC000F0CAA600D4F0FF00B1E2FF008ED4FF006BC6FF0048B8FF00
          25AAFF0000AAFF000092DC00007AB90000629600004A730000325000D4E3FF00
          B1C7FF008EABFF006B8FFF004873FF002557FF000055FF000049DC00003DB900
          003196000025730000195000D4D4FF00B1B1FF008E8EFF006B6BFF004848FF00
          2525FF000000FE000000DC000000B900000096000000730000005000E3D4FF00
          C7B1FF00AB8EFF008F6BFF007348FF005725FF005500FF004900DC003D00B900
          310096002500730019005000F0D4FF00E2B1FF00D48EFF00C66BFF00B848FF00
          AA25FF00AA00FF009200DC007A00B900620096004A00730032005000FFD4FF00
          FFB1FF00FF8EFF00FF6BFF00FF48FF00FF25FF00FE00FE00DC00DC00B900B900
          960096007300730050005000FFD4F000FFB1E200FF8ED400FF6BC600FF48B800
          FF25AA00FF00AA00DC009200B9007A009600620073004A0050003200FFD4E300
          FFB1C700FF8EAB00FF6B8F00FF487300FF255700FF005500DC004900B9003D00
          960031007300250050001900FFD4D400FFB1B100FF8E8E00FF6B6B00FF484800
          FF252500FE000000DC000000B9000000960000007300000050000000FFE3D400
          FFC7B100FFAB8E00FF8F6B00FF734800FF572500FF550000DC490000B93D0000
          963100007325000050190000FFF0D400FFE2B100FFD48E00FFC66B00FFB84800
          FFAA2500FFAA0000DC920000B97A000096620000734A000050320000FFFFD400
          FFFFB100FFFF8E00FFFF6B00FFFF4800FFFF2500FEFE0000DCDC0000B9B90000
          969600007373000050500000F0FFD400E2FFB100D4FF8E00C6FF6B00B8FF4800
          AAFF2500AAFF000092DC00007AB90000629600004A73000032500000E3FFD400
          C7FFB100ABFF8E008FFF6B0073FF480057FF250055FF000049DC00003DB90000
          319600002573000019500000D4FFD400B1FFB1008EFF8E006BFF6B0048FF4800
          25FF250000FE000000DC000000B90000009600000073000000500000D4FFE300
          B1FFC7008EFFAB006BFF8F0048FF730025FF570000FF550000DC490000B93D00
          009631000073250000501900D4FFF000B1FFE2008EFFD4006BFFC60048FFB800
          25FFAA0000FFAA0000DC920000B97A000096620000734A0000503200D4FFFF00
          B1FFFF008EFFFF006BFFFF0048FFFF0025FFFF0000FEFE0000DCDC0000B9B900
          009696000073730000505000F2F2F200E6E6E600DADADA00CECECE00C2C2C200
          B6B6B600AAAAAA009E9E9E0092929200868686007A7A7A006E6E6E0062626200
          565656004A4A4A003E3E3E0032323200262626001A1A1A000E0E0E00F0FBFF00
          A4A0A000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
          FFFFFF0000F48D8D8C8C8B8B8B8B8B8A8A978A8A8A8A8A798679797979857878
          780900000000818DF08C8C8B8B8B8B8B8A8A8A8AF7F789867986798579787878
          780900000000F48D8C8C8B8B8B8B8B8A8B8AF8E919E9EA797986797979850978
          788400000000F1818D8C8C8B8B8B8B8B8AEC190E19190EE98679857979787878
          78000000000000F58D8C8C8B8B8B8B8B8BEB1AEB19190EE98679798579787878
          09000000000000F3818D8C8C8C8B8B8B8BEC190EEB190EE97979797985787878
          0000000000000000818D8D8C8C8C8B8B8B8BECE90E19E9797979857978787809
          0000000000000000F2818D8D8C8C8C8B8B8B8BEAE9F786798579797985857900
          000000000000000000F4818D8DF08C8C8B8BEC978AE878797979798579797800
          00000000000000000000F2818D8D8C8C8CEE8B8A8A79E7797985797979790000
          0000000000000000000000EFF5818D8DF0EE8C8A8A79E77879798A8A79000000
          000000000000000000000000EC81818DF0F08C8B8A86E8E88A8A8A8B00000000
          0000000000000000000000000000EE8DF2F1EDEBE9F7EA068A8B000000000000
          00000000000000000000000000000000F8ED191918F8EA060000000000000000
          0000000000000000000000000000000000EBED19EB1800000000000000000000
          0000000000000000000000000000000000EBEDECEC1800000000000000000000
          0000000000000000000000000000000000EBECECEBE917000000000000000000
          00000000000000000000000000000000EBECECEA191818180000000000000000
          000000000000000000000000000000EBEEECEBEA180C0B0B0B00000000000000
          000000000000000000000000000000EBEDECEC190C0B0A0A0B17000000000000
          000000000000000000000000000000EDECECECEC170AD6D60B0B000000000000
          000000000000000000000000000000ECEDECECEC0C0BE7E40BD6000000000000
          000000000000000000000000000000ECEC00EBE918E700F70BD6000000000000
          000000000000000000000000000000ECECEEEA1819EAE9E70CD6000000000000
          000000000000000000000000000000ECEEECEA19EA191918170B000000000000
          000000000000000000000000000000ECEEEDEC19EAEA19180B17000000000000
          00000000000000000000000000000000EBEDEBEA1919180B0B00000000000000
          0000000000000000000000000000000000EBEEEDECEE1521EC00000000000000
          0000000000000000000000000000000000002121212121210000000000000000
          000000000000000000000000000000000000EFF52121F5EF0000000000000000
          00000000000000000000000000000000000000ECF3F3ED000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000080000003C0000003C0000003C0000007E0000007E000000FF000000F
          F000001FF800001FFC00003FFE00007FFF0000FFFFC003FFFFF00FFFFFF83FFF
          FFF83FFFFFF81FFFFFF00FFFFFE007FFFFE003FFFFE003FFFFE003FFFFE003FF
          FFE003FFFFE003FFFFE003FFFFF007FFFFF807FFFFFC0FFFFFFC0FFFFFFE1FFF
          FFFFFFFF2800000030000000600000000100080000000000800A000000000000
          0000000000010000000000000000000000008000008000000080800080000000
          8000800080800000C0C0C000C0DCC000F0CAA600D4F0FF00B1E2FF008ED4FF00
          6BC6FF0048B8FF0025AAFF0000AAFF000092DC00007AB90000629600004A7300
          00325000D4E3FF00B1C7FF008EABFF006B8FFF004873FF002557FF000055FF00
          0049DC00003DB900003196000025730000195000D4D4FF00B1B1FF008E8EFF00
          6B6BFF004848FF002525FF000000FE000000DC000000B9000000960000007300
          00005000E3D4FF00C7B1FF00AB8EFF008F6BFF007348FF005725FF005500FF00
          4900DC003D00B900310096002500730019005000F0D4FF00E2B1FF00D48EFF00
          C66BFF00B848FF00AA25FF00AA00FF009200DC007A00B900620096004A007300
          32005000FFD4FF00FFB1FF00FF8EFF00FF6BFF00FF48FF00FF25FF00FE00FE00
          DC00DC00B900B900960096007300730050005000FFD4F000FFB1E200FF8ED400
          FF6BC600FF48B800FF25AA00FF00AA00DC009200B9007A009600620073004A00
          50003200FFD4E300FFB1C700FF8EAB00FF6B8F00FF487300FF255700FF005500
          DC004900B9003D00960031007300250050001900FFD4D400FFB1B100FF8E8E00
          FF6B6B00FF484800FF252500FE000000DC000000B90000009600000073000000
          50000000FFE3D400FFC7B100FFAB8E00FF8F6B00FF734800FF572500FF550000
          DC490000B93D0000963100007325000050190000FFF0D400FFE2B100FFD48E00
          FFC66B00FFB84800FFAA2500FFAA0000DC920000B97A000096620000734A0000
          50320000FFFFD400FFFFB100FFFF8E00FFFF6B00FFFF4800FFFF2500FEFE0000
          DCDC0000B9B90000969600007373000050500000F0FFD400E2FFB100D4FF8E00
          C6FF6B00B8FF4800AAFF2500AAFF000092DC00007AB90000629600004A730000
          32500000E3FFD400C7FFB100ABFF8E008FFF6B0073FF480057FF250055FF0000
          49DC00003DB90000319600002573000019500000D4FFD400B1FFB1008EFF8E00
          6BFF6B0048FF480025FF250000FE000000DC000000B900000096000000730000
          00500000D4FFE300B1FFC7008EFFAB006BFF8F0048FF730025FF570000FF5500
          00DC490000B93D00009631000073250000501900D4FFF000B1FFE2008EFFD400
          6BFFC60048FFB80025FFAA0000FFAA0000DC920000B97A000096620000734A00
          00503200D4FFFF00B1FFFF008EFFFF006BFFFF0048FFFF0025FFFF0000FEFE00
          00DCDC0000B9B900009696000073730000505000F2F2F200E6E6E600DADADA00
          CECECE00C2C2C200B6B6B600AAAAAA009E9E9E0092929200868686007A7A7A00
          6E6E6E0062626200565656004A4A4A003E3E3E0032323200262626001A1A1A00
          0E0E0E00F0FBFF00A4A0A000808080000000FF0000FF000000FFFF00FF000000
          FF00FF00FFFF0000FFFFFF000000818D8D8D8C8C8C8C8B8B8B8B8B8A8B8B8A8A
          8A8A8A8A8A8A8A8A86798686867978797979787878787809090000000000F581
          8D8D8C8C8C8C8B8B8B8B8B8B8B8B8A8A8A8A8A8A8A8A8A8A8679868686797879
          7979787878787809090000000000F3F48D8D8C8C8C8C8B8B8B8B8B8B8A8B8B8A
          8A8A8A8AF7E98A8A8679868686797879797978787878780909000000000000F5
          818D8D8C8C8C8C8B8B8B8B8B8A8B8B8A8AEAE9E91919E9E98686868686797879
          797978787878090909000000000000F3F48D8D8C8C8C8C8B8B8B8B8B8A8B8B8A
          8AE91A0D0D0E0E19E979868679797979797878787878780900000000000000EF
          818D8D8C8C8C8C8B8B8B8B8B8B8B8B8AEB19191913130D191AF7868679797979
          79787878787878090000000000000000F5818D8D8C8C8B8C8B8B8B8B8B8B8B8A
          F81A1213EB1919191AE986867978797979787878787878090000000000000000
          00F4818D8D8C8C8B8C8B8B8B8B8B8B8BEB1A190D1919EB121AE9867979787979
          7978787878787800000000000000000000F5F38D8D8C8C8C8C8C8B8B8B8B8B8B
          0619190E13120D1AE97979797879797979787878787878000000000000000000
          00F181F38D8D8C8C8C8C8B8B8B8B8B8B8BF80E0E190E0E0EF786797979797979
          78787878787800000000000000000000000000818D8D8D8C8C8C8C8C8B8B8B8B
          8B8B06EA19EAE9F7867879797979797978787878787800000000000000000000
          000000818D8D8D8D8C8C8C8C8C8C8B8B8B8BEC9797F786797879797979797979
          78797979780000000000000000000000000000F4818D8D8D8D8C8C8C8C8C8C8B
          8BECEB8A8AF7E878797979797979797979787979000000000000000000000000
          00000000F481818D8D8D8D8C8C8C8C8CEDED8B8A8A7979E77879797979797878
          787986780000000000000000000000000000000000F5F5F38D8D8D8D8C8C8CEE
          ED8B8B8A8A7979E7787979797879797979868600000000000000000000000000
          000000000000F5F5818D8D8D8D8D8CEEEF8C8B8A8A7979E77879787979868A8A
          8A86000000000000000000000000000000000000000000F5F481818D8D8DF0EE
          8C8C8B8A8A7979E8787979868A8A8A7986000000000000000000000000000000
          0000000000000000F5F100F48D8DF0EF8D8C8B8B8A7979F779868A8A8A8A7900
          000000000000000000000000000000000000000000000000000000F28181F0F1
          F1EEEDEBF7E879F7EA8A8A8B7979000000000000000000000000000000000000
          000000000000000000000000F1F1F3F2F019192418E88BECED8B797900000000
          000000000000000000000000000000000000000000000000000000000000EBEB
          EDF8EB1918F8ECE9797900000000000000000000000000000000000000000000
          00000000000000000000000000000000ECECEB19EBE579000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          EBEDECEBEDE60000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000EBEDECECECE700000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          EBEDECF8EBEAE7E5E30000000000000000000000000000000000000000000000
          000000000000000000000000000000EBECECF8EA191919191917000000000000
          000000000000000000000000000000000000000000000000000000000000EBED
          ECECEBEA24181817171816000000000000000000000000000000000000000000
          00000000000000000000000000EB13ECECF8EA191818170B0A0B170A00000000
          0000000000000000000000000000000000000000000000000000000000ECEDEC
          ECEBEA1918170B0A0A0A0B160000000000000000000000000000000000000000
          000000000000000000000000EDEDEDECECECF8EA170B0A0A0A0A0B1616000000
          00000000000000000000000000000000000000000000000000000000EDEDEDEC
          ECECECF8170A0A0A0A0A0B161600000000000000000000000000000000000000
          000000000000000000000000EDEDEDECECECECEC180A0A0AD60A0A0B16000000
          00000000000000000000000000000000000000000000000000000000EDEDEDEC
          ECF8F8EB180B0BF7F7E30A0A1600000000000000000000000000000000000000
          000000000000000000000000EDEDECEC8DF8EA191817078D8DE50B0A16000000
          00000000000000000000000000000000000000000000000000000000EDEDECEC
          8C8D07181818EA8D8DE6170B1600000000000000000000000000000000000000
          000000000000000000000000EDEDEDEBECEBE7191919192418180C0B16000000
          00000000000000000000000000000000000000000000000000000000EBECEDEC
          EAEA1919191919191818170B0B00000000000000000000000000000000000000
          00000000000000000000000000EBEDEDECEBEA19EA191919181817170B000000
          0000000000000000000000000000000000000000000000000000000000EBEDED
          ECF81919191919192418170B0000000000000000000000000000000000000000
          0000000000000000000000000000EB13EDECEB191919192418EBE70000000000
          00000000000000000000000000000000000000000000000000000000000000EB
          ECEBEA19191919F8EEF3EB000000000000000000000000000000000000000000
          00000000000000000000000000000000EBF0EFEFEFEFF1F3F4F5EA0000000000
          0000000000000000000000000000000000000000000000000000000000000000
          EB21F4212121212121F5EA000000000000000000000000000000000000000000
          0000000000000000000000000000000000F321212121212121F3000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00EBF52121212121F5EB00000000000000000000000000000000000000000000
          000000000000000000000000000000000000EA21F5F5F521ED00000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000E6EAEAEA07000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000C00000000007FFFFC00000000007FFFFC0000000
          0007FFFFE00000000007FFFFE0000000000FFFFFE0000000000FFFFFF0000000
          000FFFFFF8000000001FFFFFF8000000001FFFFFF8000000003FFFFFFC000000
          003FFFFFFE000000007FFFFFFE00000000FFFFFFFF00000000FFFFFFFF800000
          01FFFFFFFFC0000003FFFFFFFFE0000007FFFFFFFFF000001FFFFFFFFFFC0000
          3FFFFFFFFFFF0000FFFFFFFFFFFFC003FFFFFFFFFFFFF01FFFFFFFFFFFFFF03F
          FFFFFFFFFFFFF03FFFFFFFFFFFFFF007FFFFFFFFFFFFE003FFFFFFFFFFFFC001
          FFFFFFFFFFFF8000FFFFFFFFFFFF8000FFFFFFFFFFFF00007FFFFFFFFFFF0000
          7FFFFFFFFFFF00007FFFFFFFFFFF00007FFFFFFFFFFF00007FFFFFFFFFFF0000
          7FFFFFFFFFFF00007FFFFFFFFFFF00007FFFFFFFFFFF80007FFFFFFFFFFF8000
          FFFFFFFFFFFFC001FFFFFFFFFFFFE001FFFFFFFFFFFFF001FFFFFFFFFFFFF001
          FFFFFFFFFFFFF803FFFFFFFFFFFFF803FFFFFFFFFFFFFC07FFFFFFFFFFFFFE0F
          FFFFFFFFFFFFFFFFFFFFFFFF}
        Transparent = True
      end
    end
  end
  object PC: TPageControl
    Left = 0
    Top = 60
    Width = 542
    Height = 292
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 2
  end
end