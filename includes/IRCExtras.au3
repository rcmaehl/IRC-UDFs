#include-once

; #INDEX# =======================================================================================================================
; Title .........: IRC Extras UDF
; AutoIt Version : 3.3.14.0+
; Description ...: UDF to perform extra useful functions in coorindination with the IRC UDF
; Author(s) .....: Robert Maehl (rcmaehl) based on work by chip/mcgod
; Dll ...........:
; ===============================================================================================================================

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
	$_sPacketPart1 = StringMid($_sPacketPart1, 2, StringInStr($_sPacketPart1, "!") - 2)
	Local $_sReturn = $_sPacketPart1 ; By Default, Return Source
	Switch AscW(StringLeft($_sPacketPart3, 1))
		Case 33, 35, 38, 43 ; If Recipent was a Channel, Return Channel
			$_sReturn = $_sPacketPart3
	EndSwitch
	Return $_sReturn
EndFunc   ;==>_IRCReplyTo


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCStripSpecial
; Description ...: Cleans special characters sometimes seen in IRC
; Syntax ........: _IRCStripSpecial($_sData[, $_bNoCTCP = False])
; Parameters ....: $_sData              - Data to clean up.
;                  $_bFlags             - Flags for Characters to strip
; Return values .: Returns cleaned up message.
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 08/06/2015
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCStripSpecial($_sData, $_bFlags)
	Local $_sReturn = $_sData ; By Default Return Original Data
	If BitAND($_bFlags, 1) Then ; If $RM_FORMAT
		$_sReturn = StringReplace($_sReturn, ChrW(15), "") ; Remove Character Reset Encodings
		$_sReturn = StringReplace($_sReturn, ChrW(31), "") ; Remove Underline Character Encodings
		$_sReturn = StringReplace($_sReturn, ChrW(29), "") ; Remove Bold Character Encodings
	EndIf
	If BitAND($_bFlags, 2) Then ; If $RM_COLOR
		$_sReturn = StringReplace($_sReturn, ChrW(2), "") ; Remove End Of Character Coloring Encodings
		$_sReturn = StringRegExpReplace($_sReturn, ChrW(3) & "\d\d(?:,\d\d)?", "") ; Remove Character Coloring Encodings
	EndIf
	If BitAND($_bFlags, 4) Then ; If $RM_CTCP
		$_sReturn = StringReplace($_sReturn, ChrW(1), "") ; Remove CTCP Character Encodings
	EndIf
	Return $_sReturn
EndFunc   ;==>_IRCStripSpecial
