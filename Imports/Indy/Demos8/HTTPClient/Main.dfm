�
 TFORM1 0F  TPF0TForm1Form1LeftTop� WidthpHeight>BorderWidthCaptionHTTP Client DemoColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrderPosition	poDefault
OnActivateFormActivateOnClose	FormCloseOnCreate
FormCreateOnShowFormShowPixelsPerInch`
TextHeight 	TSplitter	Splitter1Left Top�Width^HeightCursorcrVSplitAlignalBottomBeveled	  TPanelPanel1Left Top Width^Height� AlignalTop
BevelOuterbvNoneTabOrder  TLabelLabel1Left Top,Width'HeightCaptionProtocol  TLabelLabel2Left Top WidthHeightCaptionURL  TLabelLabel3Left TopXWidth$HeightCaptionMethod  TBitBtnbtnGoLeftlTopWidthKHeightCaptionGo!Default	ModalResultTabOrder OnClick
btnGoClick
Glyph.Data
z  v  BMv      v   (                                       �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� UUUUUUUUUUU���UUUUTLLUUUUU�ww_�UUT�D�DUUUWu�Uw_UULC4DDEUUuWUU�T��4��3UW�W�Uw�T��3DD3UWUWw�Uw_���3���EU�w�UUL�33��D�Www��U�333����www��UL�333<LEWwwwU��<�3<��u�u_w�u\��333LUW��www��T�3333�UWWwwww�UU33�<3�UUwwUuwuUUS<���UUUWu��wUUUU\L�UUUUUWwwUUU	NumGlyphs  TBitBtnbtnStopLeft�TopWidthKHeightCaptionStopTabOrderOnClickbtnStopClick
Glyph.Data
z  v  BMv      v   (                                       �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 33333333333���33339��33333�ww��339����3337w�w�33�3ps��33w�7?7�9�� 9�37ww3w�99�ps3�37�w7337��3��339�w�w�37�39�339�w�77�37�33ps39�w�37�7�3339�w�3w�7�33 	�9�w�3ws�s9�3 	�937?�wsw��9�3 ��37s�www33��ps9�33w?���s339����3337w37w33339��333337ww333	NumGlyphs  	TComboBoxcbURLLeft TopWidth]Height
ItemHeightTabOrderOnChangecbURLChange  	TComboBox
cbProtocolLeft Top<WidthiHeightStylecsDropDownList
ItemHeightTabOrderOnChangecbProtocolChangeItems.Strings1.01.1   	TCheckBoxcbSSLLeft Top� WidthiHeight	AlignmenttaLeftJustifyCaptionUse SSLTabOrderOnClick
cbSSLClick  	TComboBoxcbMethodLeft TophWidthiHeightStylecsDropDownList
ItemHeightTabOrderItems.StringsHeadGetPostOptionsTracePut   	TGroupBox	GroupBox1LeftpTop,Width� HeightECaption Authentication TabOrder TLabelLabel4LeftTopWidth0HeightCaptionUsername  TLabelLabel5LeftTop,Width.HeightCaptionPassword  TEdit
edUsernameLeft@TopWidthYHeightTabOrder   TEdit
edPasswordLeft@Top(WidthYHeightPasswordChar*TabOrder   	TGroupBox	GroupBox2LeftpToptWidth� HeightECaption Use Proxy TabOrder TLabelLabel6LeftTopWidthHeightCaptionServer  TLabelLabel7LeftTop,WidthHeightCaptionPort  TEditedProxyServerLeft@TopWidthYHeightTabOrder   TEditedProxyPortLeft@Top(WidthYHeightTabOrder   	TGroupBox	GroupBox3Left Top,Width� HeightECaption Post Information TabOrder TMemo
mePostDataLeftTopWidth� Height-TabOrder OnExitmePostDataExit   	TGroupBox	GroupBox4LeftToptWidth� HeightECaption Post from file TabOrder	 TLabelLabel8LeftTop,Width*HeightCaptionFilename  TSpeedButtonSpeedButton1Left� Top(WidthHeightCaption...OnClickSpeedButton1Click  TLabelLabel9LeftTopWidthCHeightCaptionContent-Type   TEdit
edPostFileLeftPTop(Width}HeightTabOrder OnExitedPostFileExit  TEditedContentTypeLeftPTopWidth}HeightTabOrder   	TCheckBoxcbShowHideLogsLeft Top� WidthiHeight	AlignmenttaLeftJustifyCaptionShow/Hide logsTabOrder
OnClickcbShowHideLogsClick   TMemomemoHTMLLeft Top� Width^Height� AlignalClient
ScrollBars
ssVerticalTabOrder  
TStatusBar
StatusBar1Left TopWidth^HeightPanelsStylepsOwnerDrawWidth�  Widthd  SimplePanel  TProgressBarProgressBar1LeftTopWidth� HeightMin MaxdSmooth	TabOrder  TPanelLogPanelLeft Top�Width^HeightfAlignalBottom
BevelOuterbvNoneCaptionLogPanelTabOrder 	TSplitter	Splitter2Left	Top WidthHeightfCursorcrHSplitBeveled	  TPanelPanel3Left Top Width	HeightfAlignalLeft
BevelOuterbvNoneCaptionPanel3TabOrder  TLabelLabel10Left Top Width	HeightAlignalTopCaptionRequest  TLabelLabel12Left TopYWidth	HeightCursorcrHandPointAlignalBottom	AlignmenttaCenterCaptionClear request logFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.StylefsUnderline 
ParentFontOnClickLabel12Click  TMemoRequestMemoLeft TopWidth	HeightLAlignalClient
ScrollBarsssBothTabOrder    TPanelPanel4LeftTop WidthRHeightfAlignalClient
BevelOuterbvNoneCaptionPanel4TabOrder TLabelLabel11Left Top WidthRHeightAlignalTopCaptionResponse  TLabelLabel13Left TopYWidthRHeightCursorcrHandPointAlignalBottom	AlignmenttaCenterCaptionClear response logFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.StylefsUnderline 
ParentFontOnClickLabel13Click  TMemoResponseMemoLeft TopWidthRHeightLAlignalClient
ScrollBarsssBothTabOrder     TIdAntiFreezeIdAntiFreeze1OnlyWhenIdleLeft(Top�   TIdHTTPHTTPOnStatus
HTTPStatus	InterceptLogDebug	IOHandlerIdSSLIOHandlerSocket1OnWorkHTTPWorkOnWorkBeginHTTPWorkBegin	OnWorkEndHTTPWorkEndReadTimeout RecvBufferSize AllowCookies	HandleRedirects	ProtocolVersionpv1_0Request.ContentLength Request.ContentRangeEnd Request.ContentRangeStart Request.Accepttext/html, */*Request.BasicAuthenticationRequest.Password1Request.UserAgent&Mozilla/3.0 (compatible; Indy Library)'Request.ProxyParams.BasicAuthenticationRequest.ProxyParams.ProxyPort OnAuthorizationHTTPAuthorizationCookieManagerIdCookieManager1LeftTop�   TOpenDialogOpenDialog1Left`TopL  TIdLogEventLogDebugActive	LogTimeReplaceCRLF
OnReceivedLogDebugReceivedOnSentLogDebugSentOnStatusLogDebugStatusLeftHTop�   TIdSSLIOHandlerSocketIdSSLIOHandlerSocket1SSLOptions.Method	sslvSSLv2SSLOptions.ModesslmUnassignedSSLOptions.VerifyMode SSLOptions.VerifyDepth PassThroughLefthTop�   TIdCookieManagerIdCookieManager1Left(Top�    