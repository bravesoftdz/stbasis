inherited fmEditRBConnectiontype: TfmEditRBConnectiontype
  Left = 300
  Caption = 'fmEditRBConnectiontype'
  ClientHeight = 105
  ClientWidth = 309
  PixelsPerInch = 96
  TextHeight = 13
  object lbName: TLabel [0]
    Left = 8
    Top = 20
    Width = 84
    Height = 13
    Caption = '�������� �����:'
  end
  inherited pnBut: TPanel
    Top = 67
    Width = 309
    TabOrder = 2
    inherited Panel2: TPanel
      Left = 124
    end
  end
  inherited cbInString: TCheckBox
    Top = 45
  end
  object edName: TEdit [3]
    Left = 99
    Top = 16
    Width = 202
    Height = 21
    MaxLength = 100
    TabOrder = 0
    OnChange = edNameChange
  end
  inherited IBTran: TIBTransaction
    Left = 216
    Top = 33
  end
end
