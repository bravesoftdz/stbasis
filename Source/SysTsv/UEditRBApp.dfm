inherited fmEditRBApp: TfmEditRBApp
  Left = 348
  Top = 191
  Caption = 'fmEditRBApp'
  ClientHeight = 266
  ClientWidth = 307
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbName: TLabel [0]
    Left = 8
    Top = 12
    Width = 67
    Height = 13
    Caption = '����������:'
  end
  object lbRole: TLabel [1]
    Left = 47
    Top = 38
    Width = 28
    Height = 13
    Caption = '����:'
  end
  object lbImage: TLabel [2]
    Left = 24
    Top = 64
    Width = 51
    Height = 13
    Caption = '��������:'
  end
  inherited pnBut: TPanel
    Top = 228
    Width = 307
    TabOrder = 10
    inherited Panel2: TPanel
      Left = 122
    end
  end
  inherited cbInString: TCheckBox
    Left = 8
    Top = 210
    TabOrder = 9
  end
  object edName: TEdit [5]
    Left = 86
    Top = 9
    Width = 215
    Height = 21
    MaxLength = 100
    TabOrder = 0
    OnChange = edNameChange
  end
  object edRole: TEdit [6]
    Left = 86
    Top = 35
    Width = 215
    Height = 21
    MaxLength = 100
    TabOrder = 1
    OnChange = edNameChange
    OnKeyPress = edRoleKeyPress
  end
  object srlbxImage: TScrollBox [7]
    Left = 86
    Top = 62
    Width = 138
    Height = 123
    TabOrder = 2
    object imImage: TImage
      Left = 0
      Top = 0
      Width = 134
      Height = 119
      AutoSize = True
      Center = True
      Stretch = True
      OnMouseDown = imImageMouseDown
      OnMouseMove = imImageMouseMove
      OnMouseUp = imImageMouseUp
    end
  end
  object bibImageLoad: TButton [8]
    Left = 231
    Top = 62
    Width = 70
    Height = 20
    Hint = '��������� ��������'
    Cancel = True
    Caption = '���������'
    TabOrder = 3
    OnClick = bibImageLoadClick
  end
  object bibImageSave: TButton [9]
    Left = 231
    Top = 88
    Width = 70
    Height = 20
    Hint = '��������� ��������'
    Caption = '���������'
    TabOrder = 4
    OnClick = bibImageSaveClick
  end
  object bibImageCopy: TButton [10]
    Left = 231
    Top = 114
    Width = 70
    Height = 20
    Hint = '���������� � �����'
    Cancel = True
    Caption = '����������'
    TabOrder = 5
    OnClick = bibImageCopyClick
  end
  object bibImagePaste: TButton [11]
    Left = 231
    Top = 140
    Width = 70
    Height = 20
    Hint = '�������� �� ������ '
    Caption = '��������'
    TabOrder = 6
    OnClick = bibImagePasteClick
  end
  object chbImageStretch: TCheckBox [12]
    Left = 86
    Top = 190
    Width = 137
    Height = 17
    Caption = '�����������'
    Checked = True
    State = cbChecked
    TabOrder = 8
    OnClick = chbImageStretchClick
  end
  object bibImageClear: TButton [13]
    Left = 231
    Top = 165
    Width = 70
    Height = 20
    Hint = '�������� ��������'
    Caption = '��������'
    TabOrder = 7
    OnClick = bibImageClearClick
  end
  inherited IBTran: TIBTransaction
    Left = 232
    Top = 9
  end
  object OD: TOpenPictureDialog
    Options = [ofEnableSizing]
    Left = 11
    Top = 99
  end
  object SD: TSavePictureDialog
    Options = [ofEnableSizing]
    Left = 43
    Top = 99
  end
end
