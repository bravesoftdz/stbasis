inherited fmEditRBAlgorithm: TfmEditRBAlgorithm
  Left = 320
  Top = 54
  Caption = 'fmEditRBAlgorithm'
  ClientHeight = 404
  ClientWidth = 336
  PixelsPerInch = 96
  TextHeight = 13
  object lbName: TLabel [0]
    Left = 8
    Top = 11
    Width = 79
    Height = 13
    Caption = '������������:'
  end
  inherited pnBut: TPanel
    Top = 366
    Width = 336
    TabOrder = 2
    inherited Panel2: TPanel
      Left = 151
    end
  end
  inherited cbInString: TCheckBox
    Left = 8
    Top = 352
  end
  object edName: TEdit [3]
    Left = 96
    Top = 7
    Width = 226
    Height = 21
    MaxLength = 100
    TabOrder = 0
    OnChange = edNameChange
  end
  object pc: TPageControl [4]
    Left = 6
    Top = 33
    Width = 321
    Height = 316
    ActivePage = tsBaseSumm
    HotTrack = True
    MultiLine = True
    TabOrder = 3
    object tsBaseSumm: TTabSheet
      Caption = '������� �����'
      object lbTypeBaseSumm: TLabel
        Left = 9
        Top = 4
        Width = 22
        Height = 13
        Caption = '���:'
      end
      object cmbTypeBaseSumm: TComboBox
        Left = 40
        Top = 1
        Width = 267
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = cmbTypeBaseSummChange
        Items.Strings = (
          '���� ����� � ������'
          '����. �����'
          '������ �� ������ �������'
          '�� ������������ ��������'
          '�����������'
          '������� ������� ������')
      end
      object grbBaseSumm: TGroupBox
        Left = 5
        Top = 26
        Width = 303
        Height = 239
        Caption = ' ������������� '
        TabOrder = 1
        object lbbs_amountmonthsback: TLabel
          Left = 63
          Top = 19
          Width = 142
          Height = 13
          Caption = '���������� ������� �����:'
        end
        object lbbs_totalamountmonths: TLabel
          Left = 10
          Top = 43
          Width = 195
          Height = 13
          Caption = '����������� �� ���������� �������:'
        end
        object lbbs_multiplyfactoraverage: TLabel
          Left = 40
          Top = 91
          Width = 165
          Height = 13
          Caption = '�������� �� ���� ��� �������:'
        end
        object lbbs_divideamountperiod: TLabel
          Left = 37
          Top = 67
          Width = 168
          Height = 13
          Caption = '������ �� ���������� ��������:'
        end
        object lbbs_salary: TLabel
          Left = 170
          Top = 115
          Width = 35
          Height = 13
          Caption = '�����:'
        end
        object lbbs_tariffrate: TLabel
          Left = 113
          Top = 139
          Width = 92
          Height = 13
          Caption = '�������� ������:'
        end
        object lbbs_averagemonthsbonus: TLabel
          Left = 74
          Top = 163
          Width = 130
          Height = 13
          Caption = 'C������������� ������:'
        end
        object lbbs_annualbonuses: TLabel
          Left = 116
          Top = 187
          Width = 88
          Height = 13
          Caption = '������� ������:'
        end
        object lbbs_minsalary: TLabel
          Left = 80
          Top = 211
          Width = 124
          Height = 13
          Caption = '����������� ��������:'
        end
        object edbs_amountmonthsback: TEdit
          Left = 215
          Top = 16
          Width = 59
          Height = 21
          MaxLength = 6
          ReadOnly = True
          TabOrder = 0
          Text = '0'
          OnChange = edbs_amountmonthsbackChange
        end
        object udbs_amountmonthsback: TUpDown
          Left = 274
          Top = 16
          Width = 15
          Height = 21
          Associate = edbs_amountmonthsback
          Min = 0
          Position = 0
          TabOrder = 1
          Wrap = False
        end
        object edbs_totalamountmonths: TEdit
          Left = 215
          Top = 40
          Width = 59
          Height = 21
          MaxLength = 6
          ReadOnly = True
          TabOrder = 2
          Text = '0'
          OnChange = edbs_amountmonthsbackChange
        end
        object udbs_totalamountmonths: TUpDown
          Left = 274
          Top = 40
          Width = 15
          Height = 21
          Associate = edbs_totalamountmonths
          Min = 0
          Position = 0
          TabOrder = 3
          Wrap = False
        end
        object edbs_multiplyfactoraverage: TEdit
          Left = 215
          Top = 88
          Width = 74
          Height = 21
          MaxLength = 15
          TabOrder = 6
          Text = '0'
          OnChange = edbs_amountmonthsbackChange
          OnKeyPress = edbs_multiplyfactoraverageKeyPress
        end
        object edbs_divideamountperiod: TEdit
          Left = 215
          Top = 64
          Width = 59
          Height = 21
          MaxLength = 6
          ReadOnly = True
          TabOrder = 4
          Text = '0'
          OnChange = edbs_amountmonthsbackChange
        end
        object udbs_divideamountperiod: TUpDown
          Left = 274
          Top = 64
          Width = 15
          Height = 21
          Associate = edbs_divideamountperiod
          Min = 0
          Position = 0
          TabOrder = 5
          Wrap = False
        end
        object edbs_salary: TEdit
          Left = 215
          Top = 112
          Width = 74
          Height = 21
          MaxLength = 15
          TabOrder = 7
          Text = '0'
          OnChange = edbs_amountmonthsbackChange
          OnKeyPress = edbs_multiplyfactoraverageKeyPress
        end
        object edbs_tariffrate: TEdit
          Left = 215
          Top = 136
          Width = 74
          Height = 21
          MaxLength = 15
          TabOrder = 8
          Text = '0'
          OnChange = edbs_amountmonthsbackChange
          OnKeyPress = edbs_multiplyfactoraverageKeyPress
        end
        object edbs_averagemonthsbonus: TEdit
          Left = 215
          Top = 160
          Width = 74
          Height = 21
          MaxLength = 15
          TabOrder = 9
          Text = '0'
          OnChange = edbs_amountmonthsbackChange
          OnKeyPress = edbs_multiplyfactoraverageKeyPress
        end
        object edbs_annualbonuses: TEdit
          Left = 215
          Top = 184
          Width = 74
          Height = 21
          MaxLength = 15
          TabOrder = 10
          Text = '0'
          OnChange = edbs_amountmonthsbackChange
          OnKeyPress = edbs_multiplyfactoraverageKeyPress
        end
        object edbs_minsalary: TEdit
          Left = 215
          Top = 208
          Width = 74
          Height = 21
          MaxLength = 15
          TabOrder = 11
          Text = '0'
          OnChange = edbs_amountmonthsbackChange
          OnKeyPress = edbs_multiplyfactoraverageKeyPress
        end
      end
    end
    object tsFactor: TTabSheet
      Caption = '����. �������� �������'
      ImageIndex = 1
      object Label10: TLabel
        Left = 9
        Top = 13
        Width = 22
        Height = 13
        Caption = '���:'
      end
      object cmbTypeFactor: TComboBox
        Left = 40
        Top = 10
        Width = 267
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = cmbTypeFactorChange
        Items.Strings = (
          '��������������'
          '�� ������� ��� �������'
          '����. �����'
          '�����������')
      end
      object grbTypeFactor: TGroupBox
        Left = 5
        Top = 36
        Width = 303
        Height = 103
        Caption = ' ������������� '
        TabOrder = 1
        object lbkrv_typeratetime: TLabel
          Left = 104
          Top = 19
          Width = 104
          Height = 13
          Caption = '��� �����-�������:'
        end
        object lbkrv_amountmonthsback: TLabel
          Left = 13
          Top = 43
          Width = 195
          Height = 13
          Caption = '����������� �� ���������� �������:'
        end
        object lbkrv_totalamountmonths: TLabel
          Left = 66
          Top = 67
          Width = 142
          Height = 13
          Caption = '���������� ������� �����:'
        end
        object edkrv_typeratetime: TEdit
          Left = 215
          Top = 16
          Width = 59
          Height = 21
          MaxLength = 6
          ReadOnly = True
          TabOrder = 0
          Text = '0'
          OnChange = edkrv_typeratetimeChange
        end
        object udkrv_typeratetime: TUpDown
          Left = 274
          Top = 16
          Width = 15
          Height = 21
          Associate = edkrv_typeratetime
          Min = 0
          Position = 0
          TabOrder = 1
          Wrap = False
        end
        object edkrv_amountmonthsback: TEdit
          Left = 215
          Top = 40
          Width = 59
          Height = 21
          MaxLength = 6
          ReadOnly = True
          TabOrder = 2
          Text = '0'
          OnChange = edkrv_typeratetimeChange
        end
        object udkrv_amountmonthsback: TUpDown
          Left = 274
          Top = 40
          Width = 15
          Height = 21
          Associate = edkrv_amountmonthsback
          Min = 0
          Position = 0
          TabOrder = 3
          Wrap = False
        end
        object edkrv_totalamountmonths: TEdit
          Left = 215
          Top = 64
          Width = 59
          Height = 21
          MaxLength = 6
          ReadOnly = True
          TabOrder = 4
          Text = '0'
          OnChange = edkrv_typeratetimeChange
        end
        object udkrv_totalamountmonths: TUpDown
          Left = 274
          Top = 64
          Width = 15
          Height = 21
          Associate = edkrv_totalamountmonths
          Min = 0
          Position = 0
          TabOrder = 5
          Wrap = False
        end
      end
    end
    object tsMultiply: TTabSheet
      Caption = '�������� ��'
      ImageIndex = 2
      object Label14: TLabel
        Left = 9
        Top = 13
        Width = 22
        Height = 13
        Caption = '���:'
      end
      object cmbTypeMultiply: TComboBox
        Left = 40
        Top = 10
        Width = 267
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = cmbTypeMultiplyChange
        Items.Strings = (
          '��������������'
          '������� ���'
          '������� ����'
          '�� ������� ������')
      end
      object grbMultiply: TGroupBox
        Left = 5
        Top = 36
        Width = 303
        Height = 55
        Caption = ' ������������� '
        TabOrder = 1
        object lbu_besiderowtable: TLabel
          Left = 12
          Top = 23
          Width = 41
          Height = 13
          Caption = '������:'
        end
        object edu_besiderowtable: TEdit
          Left = 64
          Top = 20
          Width = 207
          Height = 21
          Color = clBtnFace
          MaxLength = 100
          ReadOnly = True
          TabOrder = 0
          OnChange = edu_besiderowtableChange
          OnKeyDown = edu_besiderowtableKeyDown
        end
        object bibu_besiderowtable: TBitBtn
          Left = 271
          Top = 20
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 1
          OnClick = bibu_besiderowtableClick
        end
      end
    end
    object tsPercent: TTabSheet
      Caption = '�������'
      ImageIndex = 3
      object Label15: TLabel
        Left = 9
        Top = 13
        Width = 22
        Height = 13
        Caption = '���:'
      end
      object cmbTypePercent: TComboBox
        Left = 40
        Top = 10
        Width = 267
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = cmbTypePercentChange
        Items.Strings = (
          '��������������'
          '����. �������'
          '���� �������� �������'
          '������� ����������� �����'
          '����. ������� ������'
          '�� ������� ��������� �� �����')
      end
      object grbPercent: TGroupBox
        Left = 5
        Top = 36
        Width = 303
        Height = 55
        Caption = ' ������������� '
        TabOrder = 1
        object lbp_percentadditionalcharge: TLabel
          Left = 20
          Top = 23
          Width = 60
          Height = 13
          Caption = '��� ������:'
        end
        object edp_percentadditionalcharge: TEdit
          Left = 88
          Top = 20
          Width = 183
          Height = 21
          Color = clBtnFace
          MaxLength = 100
          ReadOnly = True
          TabOrder = 0
          OnChange = edp_percentadditionalchargeChange
          OnKeyDown = edp_percentadditionalchargeKeyDown
        end
        object bibp_percentadditionalcharge: TBitBtn
          Left = 271
          Top = 20
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 1
          OnClick = bibp_percentadditionalchargeClick
        end
      end
    end
  end
  inherited IBTran: TIBTransaction
    Left = 128
    Top = 369
  end
end
