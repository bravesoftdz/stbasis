�
 TFORM1 0e  TPF0TForm1Form1LeftTTopWidth�Height�Caption	MAPS DemoColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrderOnCreate
FormCreatePixelsPerInch`
TextHeight TLabelLabel1Left"Top� Width6HeightCaption&IP Address:Font.CharsetDEFAULT_CHARSET
Font.ColorclMaroonFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TLabelLabel2LeftTop� WidthPHeightCaptionYour DNS serverFont.CharsetDEFAULT_CHARSET
Font.ColorclMaroonFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TLabelLabel3Left� Top� Width� HeightCaption Use "IPCONFIG /all" to find this  TMemoMemo1LeftTop� Width�Height� TabOrder   TButton
btnCheckIPLeft� Top� WidthiHeightCaption	Check nowTabOrderOnClickbtnCheckIPClick  TMemoMemo2LeftTopWidth�Height� Lines.StringsBWelcome to the Mail Abuse Prevention System Demonstration program. RThis program will consult the MAPS system to see if an I.P. Address is on the RBL S(Real Time Blacklist), DUL (Dial Up List), and the RSS (Relay Spam Stopper).  This Nprogram also provides suggested bounce messages for E-Mail systems to use when-rejecting E-Mail from computers on this list. PThese services work through simple DNS and the principals can be applied to manySE-mail systems in use.  Unfortunately, this demonstration program does have merit.  <For a test entry for the RBL, use the I.P. Address 127.0.0.2<For a test entry for the DUL, use the I.P. Address 127.0.0.3 TabOrder  	TComboBoxcboListLeft`Top� Width� Height
ItemHeightTabOrderText	127.0.0.2  TEdittxtDNSServerLeft`Top� WidthyHeightTabOrder  TIdDNSResolverIdDNSResolver1ActiveBroadcastEnabledHost129.71.2.25Port5ReceiveTimeout�>LeftXTop(   