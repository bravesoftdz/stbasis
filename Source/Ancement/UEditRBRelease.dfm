inherited fmEditRBRelease: TfmEditRBRelease
  Left = 567
  Top = 229
  Caption = 'fmEditRBRelease'
  ClientHeight = 167
  ClientWidth = 377
  PixelsPerInch = 96
  TextHeight = 13
  object lbNumRelease: TLabel [0]
    Left = 14
    Top = 11
    Width = 83
    Height = 13
    Caption = '����� �������:'
    FocusControl = edNumRelease
  end
  object lbDate: TLabel [1]
    Left = 22
    Top = 39
    Width = 75
    Height = 13
    Alignment = taRightJustify
    Caption = '���� �������:'
    FocusControl = dtpDate
  end
  object lbAbout: TLabel [2]
    Left = 31
    Top = 66
    Width = 66
    Height = 13
    Caption = '����������:'
    FocusControl = edAbout
  end
  object lbToDate: TLabel [3]
    Left = 218
    Top = 39
    Width = 15
    Height = 13
    Alignment = taRightJustify
    Caption = '��:'
    FocusControl = dtpToDate
    Visible = False
  end
  object lbPublishing: TLabel [4]
    Left = 53
    Top = 93
    Width = 47
    Height = 13
    Alignment = taRightJustify
    Caption = '�������:'
    FocusControl = edPublishing
  end
  inherited pnBut: TPanel
    Top = 129
    Width = 377
    TabOrder = 8
    inherited Panel2: TPanel
      Left = 192
    end
  end
  inherited cbInString: TCheckBox
    Left = 108
    Top = 113
    TabOrder = 7
  end
  object dtpDate: TDateTimePicker [7]
    Left = 108
    Top = 35
    Width = 95
    Height = 22
    CalAlignment = dtaLeft
    Date = 37147
    Time = 37147
    Checked = False
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 1
    OnChange = edNumReleaseChange
  end
  object edNumRelease: TEdit [8]
    Left = 108
    Top = 8
    Width = 93
    Height = 21
    TabOrder = 0
    OnChange = edNumReleaseChange
    OnKeyPress = edNumReleaseKeyPress
  end
  object edAbout: TEdit [9]
    Left = 108
    Top = 63
    Width = 261
    Height = 21
    TabOrder = 4
    OnChange = edNumReleaseChange
  end
  object dtpToDate: TDateTimePicker [10]
    Left = 244
    Top = 35
    Width = 95
    Height = 22
    CalAlignment = dtaLeft
    Date = 37147
    Time = 37147
    Checked = False
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 2
    Visible = False
    OnChange = edNumReleaseChange
  end
  object bibTodate: TButton [11]
    Left = 346
    Top = 35
    Width = 22
    Height = 22
    Hint = '�������'
    Caption = '...'
    TabOrder = 3
    Visible = False
    OnClick = bibTodateClick
  end
  object edPublishing: TEdit [12]
    Left = 108
    Top = 89
    Width = 233
    Height = 21
    Color = clBtnFace
    MaxLength = 100
    ReadOnly = True
    TabOrder = 5
  end
  object bibPublishing: TButton [13]
    Left = 347
    Top = 89
    Width = 21
    Height = 21
    Caption = '...'
    TabOrder = 6
    OnClick = bibPublishingClick
  end
  inherited IBTran: TIBTransaction
    Left = 16
    Top = 9
  end
end
