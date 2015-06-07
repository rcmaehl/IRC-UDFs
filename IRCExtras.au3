; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCReplyTo
; Description ...: Used to Determine Where to Reply a PRIVMsg
; Syntax ........: _IRCReplyTo($_sPacketPart1, $_sPacketPart3)
; Parameters ....: $_sPacketPart1       - Parameter 1 of the PRIVMSG Packet Recieved (Source)
;                  $_sPacketPart3       - Parameter 3 of the PRIVMSG Packet Recieved (Recipent)
; Return values .: Returns who to reply to for a PRIVMsg
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 06/07/2015
; Remarks .......: Also cleans up the Username for replying
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCReplyTo($_sPacketPart1, $_sPacketPart3)
	Local $_sReturn = $_sPacketPart1 ; By Default, Return Source
	$_sPacketPart1 = StringMid($_sPacketPart1, 2, StringInStr($_sPacketPart1, "!") - 2)
	Switch AscW(StringLeft($_sPacketPart3, 1))
		Case 33, 35, 38, 43 ; If Recipent was a Channel, Return Channel
			$_sReturn = $_sPacketPart3
	EndSwitch
	Return $_sReturn
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCStripSpecial
; Description ...: Cleans special characters sometimes seen in IRC
; Syntax ........: _IRCStripSpecial($_sData[, $_bNoCTCP = False])
; Parameters ....: $_sData              - Data to clean up.
;                  $_bNoCTCP            - [optional] Cleans CTCP characters if True. Default is False.
; Return values .: Returns cleaned up message.
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 10/14/2014
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCStripSpecial($_sData, $_bNoCTCP = False)
	Local $_sReturn = $_sData ; By Default Return Original Data
	$_sReturn = StringReplace($_sReturn, "", "") ; Remove Character Reset Encodings
	$_sReturn = StringReplace($_sReturn, "", "") ; Remove Underline Character Encodings
	$_sReturn = StringReplace($_sReturn, "", "") ; Remove Bold Character Encodings
	$_sReturn = StringReplace($_sReturn, "", "") ; Remove End Of Character Coloring Encodings
	$_sReturn = StringRegExpReplace($_sReturn, "\d\d(?:,\d\d)?", "") ; Remove Character Coloring Encodings
	If $_bNoCTCP Then
		$_sReturn = StringReplace($_sReturn, "", "") ; Remove CTCP Character Encodings
	EndIf
	Return $_sReturn
EndFunc