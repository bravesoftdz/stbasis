object fmOptions: TfmOptions
  Left = 356
  Top = 158
  Width = 424
  Height = 383
  Caption = 'fmOptions'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pc: TPageControl
    Left = 0
    Top = 0
    Width = 416
    Height = 356
    ActivePage = tsRbkAnnouncement
    Align = alClient
    TabOrder = 0
    object tsRptExport: TTabSheet
      Caption = 'tsRptExport'
      object pnRptExport: TPanel
        Left = 0
        Top = 0
        Width = 408
        Height = 328
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object grbAddition: TGroupBox
          Left = 5
          Top = 1
          Width = 397
          Height = 117
          Caption = ' ����������� '
          TabOrder = 0
          object lbBeforePhones: TLabel
            Left = 12
            Top = 18
            Width = 101
            Height = 13
            Caption = '����� ����������:'
          end
          object lbBeforeCP: TLabel
            Left = 13
            Top = 42
            Width = 100
            Height = 13
            Caption = '����� ����������:'
          end
          object Label5: TLabel
            Left = 212
            Top = 18
            Width = 93
            Height = 13
            Caption = '����� ���������:'
          end
          object lbAfterCP: TLabel
            Left = 204
            Top = 42
            Width = 101
            Height = 13
            Caption = '����� �����������:'
          end
          object lbBeforeHP: TLabel
            Left = 21
            Top = 66
            Width = 92
            Height = 13
            Caption = '����� ��������:'
          end
          object lbAfterHP: TLabel
            Left = 210
            Top = 66
            Width = 95
            Height = 13
            Caption = '����� ���������:'
          end
          object lbBeforeWP: TLabel
            Left = 32
            Top = 90
            Width = 81
            Height = 13
            Caption = '����� �������:'
          end
          object lbAfterWP: TLabel
            Left = 221
            Top = 90
            Width = 84
            Height = 13
            Caption = '����� ��������:'
          end
          object edBeforePhones: TEdit
            Left = 120
            Top = 15
            Width = 73
            Height = 21
            TabOrder = 0
            Text = ' ���.: '
          end
          object edBeforeCP: TEdit
            Left = 120
            Top = 39
            Width = 73
            Height = 21
            TabOrder = 2
            Text = ' '
          end
          object edAfterPhones: TEdit
            Left = 312
            Top = 15
            Width = 73
            Height = 21
            TabOrder = 1
          end
          object edAfterCP: TEdit
            Left = 312
            Top = 39
            Width = 73
            Height = 21
            TabOrder = 3
            Text = ' (����.)'
          end
          object edBeforeHP: TEdit
            Left = 120
            Top = 63
            Width = 73
            Height = 21
            TabOrder = 4
            Text = ' '
          end
          object edAfterHP: TEdit
            Left = 312
            Top = 63
            Width = 73
            Height = 21
            TabOrder = 5
            Text = ' (���.)'
          end
          object edBeforeWP: TEdit
            Left = 120
            Top = 87
            Width = 73
            Height = 21
            TabOrder = 6
            Text = ' '
          end
          object edAfterWP: TEdit
            Left = 312
            Top = 87
            Width = 73
            Height = 21
            TabOrder = 7
            Text = ' (���.)'
          end
        end
        object grbExportFonts: TGroupBox
          Left = 5
          Top = 121
          Width = 397
          Height = 45
          Caption = ' ������ '
          TabOrder = 1
          object lbFontExportKeyWords: TLabel
            Left = 10
            Top = 18
            Width = 88
            Height = 13
            Caption = '�������� �����:'
          end
          object lbFontExportText: TLabel
            Left = 231
            Top = 18
            Width = 33
            Height = 13
            Caption = '�����:'
          end
          object edFontExportKeyWords: TEdit
            Left = 105
            Top = 14
            Width = 90
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            Text = '������'
          end
          object bibFontExportKeyWords: TButton
            Left = 200
            Top = 14
            Width = 21
            Height = 21
            Caption = '...'
            Constraints.MaxHeight = 21
            Constraints.MaxWidth = 21
            TabOrder = 1
            OnClick = bibFontExportKeyWordsClick
          end
          object edFontExportText: TEdit
            Left = 270
            Top = 14
            Width = 90
            Height = 21
            TabOrder = 2
            Text = '������'
          end
          object bibFontExportText: TButton
            Left = 365
            Top = 14
            Width = 21
            Height = 21
            Caption = '...'
            Constraints.MaxHeight = 21
            Constraints.MaxWidth = 21
            TabOrder = 3
            OnClick = bibFontExportTextClick
          end
        end
        object grbCaseExport: TGroupBox
          Left = 5
          Top = 169
          Width = 398
          Height = 136
          Caption = ' �������� �������� ���������� '
          TabOrder = 2
          object chbExportWithImport: TCheckBox
            Left = 24
            Top = 37
            Width = 247
            Height = 17
            Caption = '�������������� ������� �������� �������'
            TabOrder = 0
          end
          object chbExportNoText: TCheckBox
            Left = 24
            Top = 54
            Width = 315
            Height = 17
            Caption = '�������������� ��� �������� ���� � ������ ����������'
            TabOrder = 1
          end
          object chbExportUpperKeyWords: TCheckBox
            Left = 24
            Top = 71
            Width = 279
            Height = 17
            Caption = '��������� � �������� �������� �������� �����'
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
          object chbExportWordKeyWithDelim: TCheckBox
            Left = 24
            Top = 88
            Width = 214
            Height = 17
            Hint = '��������� �������� ����� � ����� ���������� �������'
            Caption = '��������� �������� ����� �������'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            OnClick = chbExportWordKeyWithDelimClick
          end
          object edExportWordKeyWithDelim: TEdit
            Left = 239
            Top = 87
            Width = 31
            Height = 21
            Color = clBtnFace
            Enabled = False
            MaxLength = 10
            TabOrder = 4
            Text = ' '
          end
          object chbAndText: TCheckBox
            Left = 279
            Top = 88
            Width = 109
            Height = 17
            Hint = '� ������� ����� ������'
            Caption = '� ������� �����'
            Enabled = False
            TabOrder = 5
          end
          object rbForEditing: TRadioButton
            Left = 11
            Top = 19
            Width = 145
            Height = 17
            Caption = '��� ����������� ����'
            Checked = True
            TabOrder = 6
            TabStop = True
            OnClick = rbForEditingClick
          end
          object rbForSite: TRadioButton
            Left = 11
            Top = 107
            Width = 182
            Height = 17
            Caption = '��� �����'
            TabOrder = 7
            OnClick = rbForEditingClick
          end
        end
        object chbExportWithAutoReplace: TCheckBox
          Left = 5
          Top = 309
          Width = 300
          Height = 17
          Caption = '��������� ������� ���������� ��� ������'
          TabOrder = 3
        end
      end
    end
    object tsSrvImport: TTabSheet
      Caption = 'tsSrvImport'
      ImageIndex = 1
      object pnSrvImport: TPanel
        Left = 0
        Top = 0
        Width = 408
        Height = 328
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object grbSrvImport: TGroupBox
          Left = 5
          Top = 1
          Width = 270
          Height = 173
          Caption = ' �������� '
          TabOrder = 0
          object lbBeforeTree: TLabel
            Left = 90
            Top = 21
            Width = 85
            Height = 13
            Caption = '����� ��������:'
          end
          object lbAfterTree: TLabel
            Left = 96
            Top = 45
            Width = 79
            Height = 13
            Caption = '����� �������:'
          end
          object lbPointerTree: TLabel
            Left = 68
            Top = 69
            Width = 107
            Height = 13
            Caption = '����������� ������:'
          end
          object lbBeforeContact: TLabel
            Left = 15
            Top = 93
            Width = 160
            Height = 13
            Caption = '����� ���������� ���������:'
          end
          object lbBeforeHome: TLabel
            Left = 23
            Top = 117
            Width = 152
            Height = 13
            Caption = '����� �������� ���������:'
          end
          object lbBeforeWork: TLabel
            Left = 34
            Top = 141
            Width = 141
            Height = 13
            Caption = '����� ������� ���������:'
          end
          object edBeforeTree: TEdit
            Left = 185
            Top = 18
            Width = 73
            Height = 21
            MaxLength = 10
            TabOrder = 0
            Text = '['
          end
          object edAfterTree: TEdit
            Left = 185
            Top = 42
            Width = 73
            Height = 21
            MaxLength = 10
            TabOrder = 1
            Text = ']'
          end
          object edPointerTree: TEdit
            Left = 185
            Top = 66
            Width = 73
            Height = 21
            MaxLength = 10
            TabOrder = 2
            Text = '\'
          end
          object edBeforeContact: TEdit
            Left = 185
            Top = 90
            Width = 73
            Height = 21
            MaxLength = 10
            TabOrder = 3
            Text = '�.����.'
          end
          object edBeforeHome: TEdit
            Left = 185
            Top = 114
            Width = 73
            Height = 21
            MaxLength = 10
            TabOrder = 4
            Text = '�.���.'
          end
          object edBeforeWork: TEdit
            Left = 185
            Top = 138
            Width = 73
            Height = 21
            MaxLength = 10
            TabOrder = 5
            Text = '�.���.'
          end
        end
        object chbImportWithOutKeyWords: TCheckBox
          Left = 6
          Top = 178
          Width = 371
          Height = 17
          Caption = '������������� ���������� ��� ������������� �������� ����'
          TabOrder = 1
        end
        object chbImportLoadTranslateQuotas: TCheckBox
          Left = 6
          Top = 196
          Width = 395
          Height = 17
          Caption = '������������� ��������������� ��� ������� ������� � ������ ����'
          TabOrder = 2
        end
        object chbImportConvertWords: TCheckBox
          Left = 6
          Top = 214
          Width = 387
          Height = 17
          Caption = '�������������� ����������� ���������� ����� � �������'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
        object chbImportSelectInvalidChar: TCheckBox
          Left = 6
          Top = 232
          Width = 387
          Height = 17
          Caption = '���������� ������� ������ ��� �������, �� �������� � ������:'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
        end
        object meImportValidChars: TMemo
          Left = 24
          Top = 252
          Width = 377
          Height = 69
          Lines.Strings = (
            '�����Ũ��������������������������'
            '��������������������������������'
            '0123456789'
            ' ��,.?!@#$%^&*()_+\/[]{}<>:;-=')
          ScrollBars = ssVertical
          TabOrder = 5
        end
      end
    end
    object tsRbkAnnouncement: TTabSheet
      Caption = 'tsRbkAnnouncement'
      ImageIndex = 2
      object pnRbkAnnouncement: TPanel
        Left = 0
        Top = 0
        Width = 408
        Height = 328
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object lbPercentDouble: TLabel
          Left = 40
          Top = 128
          Width = 183
          Height = 13
          Caption = '����������� ������� ����������:'
          Enabled = False
        end
        object chbAutoAdd: TCheckBox
          Left = 10
          Top = 9
          Width = 261
          Height = 17
          Caption = '������������� ��������� ���� ����������'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object chbAutoOpenTree: TCheckBox
          Left = 10
          Top = 33
          Width = 319
          Height = 17
          Caption = '������������� ��������� ���� ������ ��� ���������'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object grbAnnouncementPhones: TGroupBox
          Left = 9
          Top = 154
          Width = 298
          Height = 63
          Caption = ' ����� ��������� '
          TabOrder = 7
          object lbAnnouncementNN: TLabel
            Left = 15
            Top = 24
            Width = 212
            Height = 13
            Caption = '���������� ���� � ��������� ���������:'
          end
          object edAnnouncementNN: TEdit
            Left = 234
            Top = 21
            Width = 34
            Height = 21
            ReadOnly = True
            TabOrder = 0
            Text = '6'
          end
          object udAnnouncementNN: TUpDown
            Left = 268
            Top = 21
            Width = 15
            Height = 21
            Associate = edAnnouncementNN
            Min = 3
            Max = 10
            Position = 6
            TabOrder = 1
            Wrap = False
          end
        end
        object chbAnnouncementTreePath: TCheckBox
          Left = 10
          Top = 57
          Width = 191
          Height = 17
          Caption = '���������� ���� �����������'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = chbAnnouncementTreePathClick
        end
        object chbAnnouncementCheckRusWords: TCheckBox
          Left = 10
          Top = 81
          Width = 311
          Height = 17
          Caption = '������������� ��������� ����������'
          Checked = True
          State = cbChecked
          TabOrder = 3
          OnClick = chbAnnouncementTreePathClick
        end
        object chbAnnouncementDoStep95: TCheckBox
          Left = 10
          Top = 225
          Width = 311
          Height = 17
          Caption = '������ ������� ���������� (�� 100%)'
          Checked = True
          State = cbChecked
          TabOrder = 8
          Visible = False
          OnClick = chbAnnouncementTreePathClick
        end
        object chbAnnouncementViewDouble: TCheckBox
          Left = 10
          Top = 105
          Width = 175
          Height = 17
          Caption = '���������� ������ ������'
          TabOrder = 4
          OnClick = chbAnnouncementViewDoubleClick
        end
        object edPercentDouble: TEdit
          Left = 234
          Top = 125
          Width = 34
          Height = 21
          Color = clBtnFace
          Enabled = False
          ReadOnly = True
          TabOrder = 5
          Text = '85'
        end
        object udPercentDouble: TUpDown
          Left = 268
          Top = 125
          Width = 15
          Height = 21
          Associate = edPercentDouble
          Enabled = False
          Min = 0
          Position = 85
          TabOrder = 6
          Wrap = False
        end
      end
    end
    object tsRptExportTreeHeading: TTabSheet
      Caption = 'tsRptExportTreeHeading'
      ImageIndex = 3
      object pnRptExportTreeHeading: TPanel
        Left = 0
        Top = 0
        Width = 408
        Height = 328
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object rgExportTreeHeading: TRadioGroup
          Left = 8
          Top = 6
          Width = 225
          Height = 99
          Caption = ' ��������� '
          ItemIndex = 0
          Items.Strings = (
            '��� ��������� ���� � �����������'
            '��� ����������� ����'
            '��� �����')
          TabOrder = 0
        end
      end
    end
  end
  object fd: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 228
    Top = 120
  end
end
