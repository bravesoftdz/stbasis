�
 TFRMMAIN 0_  TPF0TfrmMainfrmMainLeftTopWidth^Height� CaptionLoad testing serverColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrderOnCreate
FormCreate	OnDestroyFormDestroyPixelsPerInch`
TextHeight TLabelLabel1LeftTopWidth� HeightCaptionMax number of connections:  TLabelLabel2Left� Top WidthoHeightCaptionLeave blank for no maxFont.CharsetDEFAULT_CHARSET
Font.ColorclGrayFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TLabelLabel3LeftTop;Width� HeightCaptionNumber of client connections  TLabellblClientConnectionsLeft� Top;WidthHeightCaption[ 0 ]  TEditedtNumConnectionsLeft� TopWidth5HeightTabOrder   TButton	btnServerLeftToptWidthKHeightCaptionStart serverTabOrderOnClickbtnServerClick  TButtonbtnExitLeftUToptWidthKHeightCaptionExitTabOrderOnClickbtnExitClick  	TCheckBoxchkThreadPoolLeftTopRWidthuHeightCaptionUse thread poolTabOrder  TIdTCPServerIdTCPServerBindings CommandHandlers DefaultPort�#Greeting.NumericCode MaxConnectionReply.NumericCode MaxConnectionReply.Text.Strings@ERR - Max number of connections reached - please try again later 	OnConnectIdTCPServerConnect	OnExecuteIdTCPServerExecuteOnDisconnectIdTCPServerDisconnectOnExceptionIdTCPServerExceptionOnListenExceptionIdTCPServerListenExceptionReplyExceptionCode 
ReplyTexts ReplyUnknownCommand.NumericCode Left,Top  TIdThreadMgrPoolIdThreadMgrPoolLeftTop   