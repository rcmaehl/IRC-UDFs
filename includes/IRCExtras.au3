#AutoIt3Wrapper_Au3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w- 7
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
; Modified ......: 08/23/2016
; Remarks .......: Also cleans up the Username for replying
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCReplyTo($_sPacketPart1, $_sPacketPart3)
	$_sPacketPart1 = StringMid($_sPacketPart1, 2, StringInStr($_sPacketPart1, "!") - 2)
	Switch AscW(StringLeft($_sPacketPart3, 1))
		Case 33, 35, 38, 43 ; If Recipent was a Channel, Return Channel
			Return $_sPacketPart3
		Case Else
			Return $_sPacketPart1 ; By Default, Return Source
	EndSwitch
EndFunc   ;==>_IRCReplyTo


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCStripSpecial
; Description ...: Cleans special characters sometimes seen in IRC
; Syntax ........: _IRCStripSpecial($_sData, $_dFlags)
; Parameters ....: $_sData              - Data to clean up.
;                  $_dFlags             - Flags for Characters to strip
;                  |$RM_CTCP   - Remove CTCP Formatting
;                  |$RM_COLOR  - Remove Colorization
;                  |$RM_FORMAT - Remove Bolds and Underlines
; Return values .: Returns cleaned up message.
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 09/02/2016
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCStripSpecial($_sData, $_dFlags)
	Local $_sReturn = $_sData ; By Default Return Original Data
	If $_dFlags > 7 Then ; Should never be more than all flags
		$_dFlags = 7
	EndIf
	If BitAND($_dFlags, 1) Then ; If $RM_FORMAT
		$_sReturn = StringReplace($_sReturn, ChrW(15), "") ; Remove Character Reset Encodings
		$_sReturn = StringReplace($_sReturn, ChrW(31), "") ; Remove Underline Character Encodings
		$_sReturn = StringReplace($_sReturn, ChrW(29), "") ; Remove Bold Character Encodings
	EndIf
	If BitAND($_dFlags, 2) Then ; If $RM_COLOR
		$_sReturn = StringReplace($_sReturn, ChrW(2), "") ; Remove End Of Character Coloring Encodings
		$_sReturn = StringRegExpReplace($_sReturn, ChrW(3) & "\d\d(?:,\d\d)?", "") ; Remove Character Coloring Encodings
	EndIf
	If BitAND($_dFlags, 4) Then ; If $RM_CTCP
		$_sReturn = StringReplace($_sReturn, ChrW(1), "") ; Remove CTCP Character Encodings
	EndIf
	Return $_sReturn
EndFunc   ;==>_IRCStripSpecial
