inherited fmRBConst: TfmRBConst
  Left = 321
  Top = 167
  Width = 580
  Caption = 'Справочник констант'
  Icon.Data = {
    0000010001001010100000000000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    0000FFFF0000FFFF0000E1C70000F38F0000F39F0000F33F0000F23F0000F07F
    0000F37F0000F3BF0000F3A70000E1C70000FFFF0000FFFF0000FFFF0000}
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnBackGrid: TPanel
    Width = 572
    inherited pnBut: TPanel
      Left = 488
      inherited pnModal: TPanel
        inherited bibView: TButton
          OnClick = bibViewClick
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
      Width = 488
    end
  end
  inherited pnFind: TPanel
    Width = 572
    inherited edSearch: TEdit
      Anchors = [akLeft, akTop, akBottom]
    end
    object Button1: TButton
      Left = 488
      Top = 0
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 1
      Visible = False
    end
  end
  inherited pnBottom: TPanel
    Width = 572
    inherited bibOk: TButton
      Left = 409
    end
    inherited bibClose: TButton
      Left = 491
    end
  end
end
