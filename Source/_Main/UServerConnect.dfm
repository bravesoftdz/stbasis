�
 TFMSERVERCONNECT 0;  TPF0TfmServerConnectfmServerConnectLeftTop� BorderIconsbiSystemMenu BorderStylebsDialogCaption���������� � ��������ClientHeight� ClientWidth"Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrderPositionpoScreenCenterScaledOnCreate
FormCreatePixelsPerInch`
TextHeight 	TGroupBoxgbDBServerInfoLeftTopWidthHeight� Caption ���������� �� ������� TabOrder  TLabellblServerNameLeftTop3WidthFHeightCaption��� �������:FocusControl
cbDBServer  TLabellblProtocolLeftTopLWidth� HeightCaption������� �������� ����������:FocusControl
cbProtocol  TLabellblDatabaseLeftTopfWidthDHeightCaption���� ������:FocusControledtDatabase  	TComboBox
cbProtocolLeft� TopIWidthSHeightStylecsDropDownList
ItemHeightTabOrderItems.StringsTCP/IPNetBEUISPX   TRadioButtonrbLocalServerLeftTopWidth}HeightCaption��������� ������TabOrder OnClickrbLocalServerClick  TRadioButtonrbRemoteServerLeft� TopWidth{HeightCaption��������� ������TabOrderOnClickrbLocalServerClick  	TComboBox
cbDBServerLeft]Top0Width� Height
ItemHeightTabOrder  TEditedtDatabaseLeftYTopcWidth� HeightParentShowHintShowHint	TabOrder  TButtonbtnSelDBLeft� TopcWidthHeightHintSelect databaseCaption...TabOrderOnClickbtnSelDBClick   TPanelPanel1Left Top� Width"Height$AlignalBottom
BevelOuterbvNoneTabOrder TPanelPanel2LeftTop Width
Height$AlignalRight
BevelOuterbvNoneTabOrder  TButtonbtOkLeftgTopWidthKHeightCaptionOKDefault	TabOrderOnClick	btOkClick  TButtonbtCancelLeft� TopWidthKHeightCancel	Caption������ModalResultTabOrder  TButtonbibTestLeftTopWidthKHeightCaption����TabOrder OnClickbibTestClick    TOpenDialogod
DefaultExt*.fdbFilterF���� ������ Firebird (*.fdb)|*.fdb|���� ������ Interbase (*.gdb)|*.gdbOptionsofEnableSizing LeftTop�    