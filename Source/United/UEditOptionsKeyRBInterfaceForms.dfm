object fmEditOptionsKeyRBInterfaceForms: TfmEditOptionsKeyRBInterfaceForms
  Left = 639
  Top = 291
  BorderStyle = bsDialog
  Caption = 'fmEditOptionsKeyRBInterfaceForms'
  ClientHeight = 103
  ClientWidth = 264
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbCommand: TLabel
    Left = 8
    Top = 14
    Width = 48
    Height = 13
    Caption = '�������:'
  end
  object lbKey: TLabel
    Left = 72
    Top = 42
    Width = 48
    Height = 13
    Caption = '�������:'
  end
  object pnBut: TPanel
    Left = 0
    Top = 65
    Width = 264
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Panel2: TPanel
      Left = 79
      Top = 0
      Width = 185
      Height = 38
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object bibOk: TButton
        Left = 22
        Top = 5
        Width = 75
        Height = 25
        Hint = '�����������'
        Caption = 'OK'
        Default = True
        TabOrder = 0
        OnClick = bibOkClick
      end
      object bibCancel: TButton
        Left = 104
        Top = 5
        Width = 75
        Height = 25
        Hint = '��������'
        Cancel = True
        Caption = '������'
        ModalResult = 2
        TabOrder = 1
      end
    end
  end
  object cmbCommand: TComboBox
    Left = 64
    Top = 11
    Width = 193
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object hkKey: THotKey
    Left = 130
    Top = 40
    Width = 127
    Height = 19
    HotKey = 0
    InvalidKeys = [hcNone, hcShift]
    Modifiers = []
    TabOrder = 1
  end
end
