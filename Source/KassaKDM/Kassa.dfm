object Form1: TForm1
  Left = 293
  Top = 154
  Width = 433
  Height = 310
  Caption = 'Form1'
  Color = clGrayText
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 168
    Top = 32
    object MOpen: TMenuItem
      Caption = '�������'
      OnClick = MOpenClick
    end
    object MDic: TMenuItem
      Caption = '�����������'
      object Mkas: TMenuItem
        Caption = '�����'
        object MCB: TMenuItem
          Caption = '���������'
          OnClick = MCBClick
        end
        object MCA: TMenuItem
          Caption = '����������'
          OnClick = MCAClick
        end
      end
    end
    object MMag: TMenuItem
      Caption = '�������'
      object MPlanAc: TMenuItem
        Caption = '���� ������'
        OnClick = MPlanAcClick
      end
      object MKassa: TMenuItem
        Caption = '�����'
        OnClick = MKassaClick
      end
      object NMPosting: TMenuItem
        Caption = '���������'
        OnClick = NMPostingClick
      end
    end
  end
  object OpenDialog: TOpenDialog
    FileName = 'D:\progr\NewDB\Data\STBASIS.GDB'
    Filter = '*.gdb'
    InitialDir = 'D:\progr\NewDB\Data\STBASIS.GDB'
    Left = 56
    Top = 32
  end
  object IBDatabase: TIBDatabase
    DatabaseName = 'D:\progr\NewDB\Data\STBASIS.GDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=sysmaster'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = IBTransaction
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 88
    Top = 96
  end
  object IBTransaction: TIBTransaction
    Active = False
    DefaultDatabase = IBDatabase
    Left = 160
    Top = 96
  end
end
