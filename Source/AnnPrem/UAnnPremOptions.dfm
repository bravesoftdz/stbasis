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
    Height = 349
    ActivePage = tsSrvImport
    Align = alClient
    TabOrder = 0
    object tsSrvImport: TTabSheet
      Caption = 'tsSrvImport'
      object pnSrvImport: TPanel
        Left = 0
        Top = 0
        Width = 408
        Height = 321
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object LabelFormat: TLabel
          Left = 24
          Top = 107
          Width = 227
          Height = 13
          Caption = '������ �������������� ������ ���������:'
        end
        object chbImportSelectInvalidChar: TCheckBox
          Left = 6
          Top = 8
          Width = 387
          Height = 17
          Caption = '���������� ������� ������ ��� �������, �� �������� � ������:'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object meImportValidChars: TMemo
          Left = 24
          Top = 28
          Width = 377
          Height = 69
          Lines.Strings = (
            '�����Ũ��������������������������'
            '��������������������������������'
            '0123456789'
            ' ��,.?!@#$%^&*()_+\/[]{}<>:;-=')
          ScrollBars = ssVertical
          TabOrder = 1
        end
        object meFormat: TMemo
          Left = 23
          Top = 124
          Width = 377
          Height = 125
          Lines.Strings = (
            '%COUNTROOM_NAME %STREET_NAME %NOTE '
            '%PREMISES_PHONES')
          ScrollBars = ssVertical
          TabOrder = 2
        end
        object CheckBoxDelNextChar: TCheckBox
          Left = 24
          Top = 256
          Width = 313
          Height = 17
          Caption = '������� ��������� ������, ���� �������� ���� ������'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object CheckBoxAutoTranslateRegion: TCheckBox
          Left = 24
          Top = 275
          Width = 313
          Height = 17
          Caption = '������������� ������������� ����� �� �����'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
        object CheckBoxUseOriginalText: TCheckBox
          Left = 24
          Top = 294
          Width = 353
          Height = 17
          Caption = '������������ ��� ������� ������ ������������ �������� '
          Checked = True
          State = cbChecked
          TabOrder = 5
        end
      end
    end
  end
end
