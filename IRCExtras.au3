; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCReplyTo
; Description ...: Used to Determine Where to Reply a PRIVMsg
; Syntax ........: _IRCReplyTo($_sPacketPart1, $_sPacketPart3)
; Parameters ....: $_sPacketPart1       - Parameter 1 of the PRIVMSG Packet Recieved (Source)
;                  $_sPacketPart3       - Parameter 3 of the PRIVMSG Packet Recieved (Recipent)
; Return values .: Returns who to reply to for a PRIVMsg
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 04/17/2014
; Remarks .......: Also cleans up the Username for replying
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCReplyTo($_sPacketPart1, $_sPacketPart3)
	$_sPacketPart1 = StringMid($_sPacketPart1, 2, StringInStr($_sPacketPart1, "!") - 2)
	Switch AscW(StringLeft($_sPacketPart3, 1))
		Case 33, 35, 38, 43
			Return($_sPacketPart3)
		Case Else
			Return($_sPacketPart1)
	EndSwitch
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCStripSpecial
; Description ...: Cleans special characters sometimes seen in IRC
; Syntax ........: _IRCStripSpecial($_sData[, $_bNoCTCP = False])
; Parameters ....: $_sData              - Data to clean up.
;                  $_bNoCTCP            - [optional] Cleans CTCP characters if True. Default is False.
; Return values .: Returns cleaned up message.
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 09/25/2014
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCStripSpecial($_sData, $_bNoCTCP = False)
	$_sData = StringReplace($_sData, "", "") ;Reset
	$_sData = StringReplace($_sData, "", "") ;Underline
	$_sData = StringReplace($_sData, "", "") ;Bold
	$_sData = StringReplace($_sData, "", "")
	$_sData = StringRegExpReplace($_sData, "\d\d(?:,\d\d)?", "") ;Colors
	If $_bNoCTCP Then $_sData = StringReplace($_sData, "", "")
	Return $_sData
EndFunc