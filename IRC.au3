; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCChannelInvite
; Description ...: Invite a User to a Channel
; Syntax ........: _IRCChannelInvite($_vIRC, $_sUser, $_sChannel)
; Parameters ....: $_vIRC               - Socket Identifier from _IRCConnect().
;                  $_sUser              - User to Invite.
;                  $_sChannel           - Channel to Invite $_sUser to.
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and sets @error:
;                  |1 = Invalid Socket Identifier, sets @extended: (1, if empty; 2, if -1)
;                  |2 = Invalid User, sets @extended: (1, if empty; 2, if not IRC compliant)
;                  |3 = Invalid Channel, sets @extended: (1, if empty; 2, if not IRC compliant)
;                  |4 = Failure Sending, sets @extended to TCPSend error returned
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 06/07/2015
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCChannelInvite($_vIRC, $_sUser, $_sChannel)
	Local $_sReturn = 1
	Select ;Parameter Checking, Trust No One
		Case $_vIRC = ""
			$_sReturn = SetError(1, 1, 0)
		Case $_vIRC = -1
			$_sReturn = SetError(1, 2, 0)
		Case $_sUser = ""
			$_sReturn = SetError(2, 1, 0)
		Case StringInStr($_sUser, " ")
			$_sReturn = SetError(2, 2, 0)
		Case $_sChannel = ""
			$_sReturn = SetError(3, 1, 0)
		Case Not $_sChannel = ""
			Switch AscW(StringLeft($_sChannel, 1))
				Case 0 To 32, 34, 36, 37, 39 To 42, 44 To 1114111 ; AKA Not 33,35,38,43
					$_sReturn = SetError(3, 2, 0)
			EndSwitch
		Case StringInStr($_sChannel, " ")
			$_sReturn = SetError(3, 2, 0)
	EndSelect
	If $_sReturn = 1 Then
		TCPSend($_vIRC, "INVITE " & $_sUser & " " & $_sChannel & @CRLF)
		If @error Then $_sReturn = SetError(4, @error & @extended, 0)
	EndIf
	Return $_sReturn
EndFunc   ;==>_IRCChannelInvite


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCChannelJoin
; Description ...: Joins a Channel(s)
; Syntax ........: _IRCChannelJoin ($_vIRC, $_sChannels, $_sKeys)
; Parameters ....: $_vIRC               - Socket Identifier from _IRCConnect().
;                  $_sChannels          - Channel(s) to Join; If a list, it is comma seperated.
;                  $_sKeys              - [optional] Key(s) for the Channel(s); If a list, it is comma seperated.
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and sets @error:
;                  |1 = Invalid Socket Identifier, sets @extended: (1, if empty; 2, if -1)
;                  |2 = Invalid Channel(s), sets @extended: (1, if empty; 2, if not IRC compliant)
;                  |3 = Error Sending, sets @extended to TCPSend error returned
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 07/07/2015
; Remarks .......: Modified from Chips' coding, _IRCJoinChannel($_vIRC, "0") Quits all channels, To Do: Check Channel Input
; Related .......: _IRCChannelPart
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCChannelJoin($_vIRC, $_sChannels, $_sKeys = "")
	Local $_sReturn = 1
	Select ;Parameter Checking, Trust No One
		Case $_vIRC = ""
			$_sReturn = SetError(1, 1, 0)
		Case $_vIRC = -1
			$_sReturn = SetError(1, 2, 0)
		Case $_sChannels = ""
			$_sReturn = SetError(2, 1, 0)
		Case StringInStr($_sChannels, " ")
			$_sReturn = SetError(2, 2, 0)
	EndSelect
	If $_sReturn = 1 Then
		If Not $_sKeys = "" Then $_sKeys = " " & $_sKeys
		TCPSend($_vIRC, "JOIN " & $_sChannels & $_sKeys & @CRLF)
		If @error Then $_sReturn = SetError(3, @error & @extended, 0)
	EndIf
	Return $_sReturn
EndFunc   ;==>_IRCChannelJoin


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCChannelKick
; Description ...: Kicks a User from a Channel
; Syntax ........: _IRCChannelKick($_vIRC, $_sChannel, $_sUser[, $_sMsg = ""])
; Parameters ....: $_vIRC               - Socket Identifier from _IRCConnect().
;                  $_sChannel           - Channel to Kick $_sUser From.
;                  $_sUser              - User to Kick.
;                  $_sMsg               - [optional] Kick Message. Default is "".
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and sets @error:
;                  |1 = Invalid Socket Identifier, sets @extended: (1, if empty; 2, if -1)
;                  |2 = Invalid Channel, sets @extended: (1, if empty; 2, if not IRC compliant)
;                  |3 = Invalid User, sets @extended: (1, if empty; 2, if not IRC compliant)
;                  |4 = Failure Sending, sets @extended to TCPSend error returned
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 07/07/2015
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCChannelKick($_vIRC, $_sChannel, $_sUser, $_sMsg = "")
	Local $_sReturn = 1
	Select ;Parameter Checking, Trust No One
		Case $_vIRC = ""
			$_sReturn = SetError(1, 1, 0)
		Case $_vIRC = -1
			$_sReturn = SetError(1, 2, 0)
		Case $_sChannel = ""
			$_sReturn = SetError(2, 1, 0)
		Case Not $_sChannel = ""
			Switch AscW(StringLeft($_sChannel, 1))
				Case 0 To 32, 34, 36, 37, 39 To 42, 44 To 1114111 ; AKA Not 33,35,38,43
					$_sReturn = SetError(2, 2, 0)
			EndSwitch
		Case StringInStr($_sChannel, " ")
			$_sReturn = SetError(2, 2, 0)
		Case $_sUser = ""
			$_sReturn = SetError(3, 1, 0)
		Case StringInStr($_sUser, " ")
			$_sReturn = SetError(3, 2, 0)
	EndSelect
	If $_sReturn = 1 Then
		If Not $_sMsg = "" Then $_sMsg = " :" & $_sMsg
		TCPSend($_vIRC, "KICK " & $_sChannel & " " & $_sUser & $_sMsg & @CRLF)
		If @error Then Return SetError(4, @error & @extended, 0)
	EndIf
	Return $_sReturn
EndFunc   ;==>_IRCChannelKick


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCChannelPart
; Description ...: Leaves a Channel(s)
; Syntax ........: _IRCChannelPart($_vIRC, $_sChannels[, $_sMsg = ""])
; Parameters ....: $_vIRC               - Socket Identifier from _IRCConnect().
;                  $_sChannels          - Channel(s) to Part.
;                  $_sMsg               - [optional] Part Message. Default is "".
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and sets @error:
;                  |1 = Invalid Socket Identifier, sets @extended: (1, if empty; 2, if -1)
;                  |2 = Invalid Channel(s), sets @extended: (1, if empty; 2, if not IRC compliant)
;                  |3  = Error Sending, sets @extended to TCPSend error returned
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 09/28/2014
; Remarks .......: To Do: Check Channel Input for Errors
; Related .......: _IRCChannelJoin
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCChannelPart($_vIRC, $_sChannels, $_sMsg = "")
	Local $_sReturn = 1
	Select ;Parameter Checking, Trust No One
		Case $_vIRC = ""
			$_sReturn = SetError(1, 1, 0)
		Case $_vIRC = -1
			$_sReturn = SetError(1, 2, 0)
		Case $_sChannels = ""
			$_sReturn = SetError(2, 1, 0)
		Case StringInStr($_sChannels, " ")
			$_sReturn = SetError(2, 2, 0)
	EndSelect
	If $_sReturn = 1 Then
		If Not $_sMsg = "" Then $_sMsg = " :" & $_sMsg
		TCPSend($_vIRC, "PART " & $_sChannels & $_sMsg & @CRLF)
		If @error Then $_sReturn = SetError(3, @error & @extended, 0)
	EndIf
	Return $_sReturn
EndFunc   ;==>_IRCChannelPart


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCChannelTopic
; Description ...: Query or Set a Channel Topic
; Syntax ........: _IRCChannelTopic($_vIRC, $_sChannel, $_sTopic)
; Parameters ....: $_vIRC               - Socket Identifier from _IRCConnect().
;                  $_sChannel           - Channel to Query or Set Topic.
;                  $_sTopic             - [optional] Topic to Set. Default is Null.
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and sets @error:
;                  |1 = No Socket
;                  |2 = Invalid Channel, sets @extended: (1, if empty; 2, if not IRC compliant)
;                  |3 = Error Sending, sets @extended to TCPSend error returned
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 09/28/2014
; Remarks .......: Queries Topic by Default.
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCChannelTopic($_vIRC, $_sChannel, $_sTopic = Null)
	Select ;Parameter Checking, Trust No One
		Case $_vIRC = ""
			Return SetError(1, 1, 0)
		Case $_vIRC = -1
			Return SetError(1, 2, 0)
		Case $_sChannel = ""
			Return SetError(2, 1, 0)
		Case Not $_sChannel = ""
			Switch AscW(StringLeft($_sChannel, 1))
				Case 0 To 32, 34, 36, 37, 39 To 42, 44 To 1114111 ; AKA Not 33,35,38,43
					Return SetError(2, 2, 0)
			EndSwitch
		Case StringInStr($_sChannel, " ")
			Return SetError(2, 2, 0)
	EndSelect
	If $_sTopic = Null Then
		TCPSend($_vIRC, "TOPIC " & $_sChannel & @CRLF)
		If @error Then Return SetError(3, @error & @extended, 0)
	Else
		TCPSend($_vIRC, "TOPIC " & $_sChannel & " :" & $_sTopic & @CRLF)
		If @error Then Return SetError(3, @error & @extended, 0)
	EndIf
	Return 1
EndFunc   ;==>_IRCChannelTopic


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCConnect
; Description ...: Connects to an IRC Server. Sets Nick, User Mode, and Real Name.
; Syntax ........: _IRCConnect($_sServer, $_iPort, $_sNick[, $_sMode = 0[, $_sRealName = $_sNick[, $_sPass = ""]]])
; Parameters ....: $_sServer            - Server IP to Connect to.
;                  $_iPort              - Port to Connect to.
;                  $_sNick              - Nick to use.
;                  $_sMode              - [optional] User Mode. Default is 0.
;                  $_sRealName          - [optional] Real Name to use. Default is $_sNick.
;                  $_sPass              - [optional] Password for the IRC server. Default is "".
; Return values .: Success - Returns Socket Identifier
;                  Failure - Returns 0 and sets @error:
;                  |1 = Invalid Server, sets @extended: (1, if blank; 2 if invalid address/IP)
;                  |2 = Invalid Port, sets @extended: (1, if blank; 2, if not a 1-5 digit interger; 3, if out of range)
;                  |3 = Invalid Nick, sets @extended: (1, if empty; 2, if not IRC compliant)
;                  |4 = Invalid Mode, sets @extended: (1, if blank; 2, if not an interger)
;                  |5 = Invalid Real Name
;                  |6 = IP Conversion Error, sets @extened to TCPNameToIP error returned
;                  |7 = Connection Error, sets @extended to TCPConnect error returned
;                  |8 = Error Sending, sets @extended to TCPSend error returned
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 10/25/2014
; Remarks .......: Modified from Chips' coding
; Related .......: _IRCDisconnect
; Link ..........:
; Example .......: No
; ===============================================================================================================================s
Func _IRCConnect($_sServer, $_iPort, $_sNick, $_sMode = 0, $_sRealName = $_sNick, $_sPass = "")
	Local $_iCheck1 = StringRegExp($_sServer,"^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$")
	Local $_iCheck2 = StringRegExp($_sServer,"^([a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,6}$")
	Select ;Parameter Checking, Trust No One
		Case $_sServer = ""
			Return SetError(1, 1, 0)
		Case $_iCheck1 <> 1 And $_iCheck2 <> 1
			Return SetError(1, 2, 0)
		Case $_iPort = ""
			Return SetError(2, 1, 0)
		Case StringRegExp($_iPort,"^\d{1,5}$") <> 1
			Return SetError(2, 2, 0)
		Case $_iPort < 1 Or $_iPort > 65535
			Return SetError(3, 2, 0)
		Case $_sNick = ""
			Return SetError(3, 1, 0)
		Case StringInStr($_sNick, " ")
			Return SetError(2, 2, 0)
		Case StringLen($_sMode) = 0
			Return SetError(4, 1, 0)
		Case Not IsInt($_sMode)
			Return SetError(4, 2, 0)
		Case $_sRealName = ""
			Return SetError(5, 0, 0)
	EndSelect
	Local $_sIP = TCPNameToIP($_sServer)
	If @error Then Return SetError(6, @error & @extended, 0)
	Local $_vSock = TCPConnect($_sIP, $_iPort)
	If $_vSock = -1 Or $_vSock = 0 Then Return SetError(7, @error & @extended, 0)
	If Not $_sPass = "" Then
		TCPSend($_vSock, "PASS " & $_sPass & @CRLF)
		If @error Then Return SetError(8, @error & @extended, 0)
	EndIf
	TCPSend($_vSock, "NICK " & $_sNick & @CRLF)
	If @error Then Return SetError(8, @error & @extended, 0)
	TCPSend($_vSock, "USER " & $_sNick & " " & $_sMode & " 0 :" & $_sRealName & @CRLF)
	If @error Then Return SetError(8, @error & @extended, 0)
	Return $_vSock
EndFunc   ;==>_IRCConnect


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCDisconnect
; Description ...: Disconnects from an IRC server
; Syntax ........: _IRCDisconnect($_vIRC[, $_sMsg = "IRC.au3 04/20/2014"])
; Parameters ....: $_vIRC               - Socket Identifier from _IRCConnect().
;                  $_sMsg               - [optional] Disconnect Message. Default is "IRC.au3 04/20/2014".
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and sets @error:
;                  |1 = Invalid Socket Identifier, sets @extended: (1, if empty; 2, if -1)
;                  |2 = Error Sending, sets @extended to TCPSend error returned
;                  |3 = Error Closing Socket, sets @extended to TCPCloseSocket error returned
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 09/28/2014
; Remarks .......: Modified from Chips' coding
; Related .......: _IRCConnect
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCDisconnect($_vIRC, $_sMsg = "IRC.au3 04/20/2014")
	Select ;Parameter Checking, Trust No One
		Case $_vIRC = ""
			Return SetError(1, 1, 0)
		Case $_vIRC = -1
			Return SetError(1, 2, 0)
	EndSelect
	If Not $_sMsg = "" Then $_sMsg = " :" & $_sMsg
	TCPSend($_vIRC, "QUIT" & $_sMsg & @CRLF)
	If @error Then Return SetError(2, @error & @extended, 0)
	TCPCloseSocket($_vIRC)
	If @error Then Return SetError(3, @error & @extended, 0)
	Return 1
EndFunc   ;==>_IRCDisconnect


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCGetMsg
; Description ...: Receive Packets from an IRC server
; Syntax ........: _IRCGetMsg($_vIRC[, $_iChars = -1])
; Parameters ....: $_vIRC               - Socket Identifier from _IRCConnect().
;                  $_iChars             - [optional] Number of Characters to Receive. Default is -1.
; Return values .: Success - Returns data received
;                  Failure - Returns 0 and sets @error:
;                  |1 = Invalid Socket Identifier, sets @extended: (1, if empty; 2, if -1)
;                  |2 = Invalid Character Count, sets @extended: (1, if empty; 2, if not an interger; 3, if invalid interger)
;                  |3 = Failure Recieving, sets @extended to TCPRecv error returned
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 09/28/2014
; Remarks .......: Due to variable packet length, _IRCGetMsg may recieve more than 1 packet. Default _iChars setting receives
;                  characters at 1 characters per loop until it gets a Line Feed as the last character.
;                  To Do: Have _IRCGetMsg operate similar to GUIGetMsg(1)
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCGetMsg($_vIRC, $_iChars = -1)
	Select ;Parameter Checking, Trust No One
		Case $_vIRC = ""
			Return SetError(1, 1, 0)
		Case $_vIRC = -1
			Return SetError(1, 2, 0)
		Case $_iChars = ""
			Return SetError(2, 1, 0)
		Case Not IsInt($_iChars)
			Return SetError(2, 2, 0)
		Case $_iChars = 0 Or $_iChars < -1
			Return SetError(2, 3, 0)
	EndSelect
	If $_iChars = -1 Then
		Local $_vRecv = ""; Required due to '&=' below
		Do
			$_vRecv &= TCPRecv($_vIRC, 1)
			If @error and Not @error = -1 Then SetError(3, @error & @extended, 0)
		Until AscW(StringRight($_vRecv, 1)) = 10
	Else
		$_vRecv = TCPRecv($_vIRC, $_iChars)
		If @error and Not @error = -1 Then Return SetError(3, @error & @extended, 0)
	EndIf
	Return $_vRecv
EndFunc   ;==>_IRCGetMsg


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCMultiMode
; Description ...: Queries or Sets a Channel or User Mode
; Syntax ........: _IRCMultiMode($_vIRC, $_sTarget[, $_sMode = ""[, $_sParams = ""]])
; Parameters ....: $_vIRC               - Socket Identifier from _IRCConnect().
;                  $_sTarget            - Channel or User to Query or Set Mode(s).
;                  $_sMode              - [optional] Mode(s) to Query or Set. Default is "".
;                  $_sParams            - [optional] Parameters for Mode(s). Default is "".
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and sets @error:
;                  |1 = Invalid Socket Identifier, sets @extended: (1, if empty; 2, if -1)
;                  |2 = Invalid Channel or User; sets @extended: (1, if empty; 2, if not IRC compliant)
;                  |3 = Invalid Mode
;                  |4 = Error Sending, sets @extended to TCPSend error returned
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 09/28/2014
; Remarks .......: Modified from Chips' coding, Queries Channel or User Mode by Default
;                  To Do: Check if User or Channel and Accept or Deny $_sParams accordingly
;                  WARNING: This may or may not be split into two functions in the future
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCMultiMode($_vIRC, $_sTarget, $_sMode = "", $_sParams = "")
	Select ;Parameter Checking, Trust No One
		Case $_vIRC = ""
			Return SetError(1, 1, 0)
		Case $_vIRC = -1
			Return SetError(1, 2, 0)
		Case $_sTarget = ""
			Return SetError(2, 1, 0)
		Case Not $_sTarget = ""
			Switch AscW(StringLeft($_sTarget, 1))
				Case 0 To 32, 34, 36, 37, 39 To 42, 44 To 47, 58 To 64, 91 To 96, 123 To 1114111 ; AKA Not 33,35,38,43,48 To 57,65 To 90,97 To 122
					Return SetError(2, 2, 0)
			EndSwitch
		Case StringInStr($_sTarget, " ")
			Return SetError(2, 2, 0)
		Case $_sMode = "" And Not $_sParams = ""
			Return SetError(3, 0, 0)
	EndSelect
	If Not $_sMode = "" Then $_sMode = " " & $_sMode
	If Not $_sParams = "" Then $_sParams = " " & $_sParams
	TCPSend($_vIRC, "MODE " & $_sTarget & $_sMode & $_sParams & @CRLF)
	If @error Then Return SetError(3, @error & @extended, 0)
	Return 1
EndFunc   ;==>_IRCMultiMode


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCMultiSendMsg
; Description ...: Sends a Message to a Channel or User
; Syntax ........: _IRCMultiSendMsg($_vIRC, $_sTarget, $_sMsg[, $_bTrim = True])
; Parameters ....: $_vIRC               - Socket Identifier from _IRCConnect().
;                  $_sTarget            - Channel or User to Send Message.
;                  $_sMsg               - Message to Send.
;                  $_bTrim              - [optional] Message Trimming. Default is True.
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and sets @error:
;                  |1 = Invalid Socket Identifier, sets @extended: (1, if empty; 2, if -1)
;                  |2 = Invalid Channel or User, sets @extended: (1, if empty; 2, if not IRC compliant)
;                  |3 = Invalid Message
;                  |4 = Invalid Trim Optionl, sets @extended: (1, if empty; 2, if not boolean)
;                  |5 = Error Sending, sets @extended to TCPSend error returned
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 09/28/2014
; Remarks .......: Modified from Chips' coding; To Do: Better message length calculations
;                  WARNING: This may or may not be split into two functions in the future
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCMultiSendMsg($_vIRC, $_sTarget, $_sMsg, $_bTrim = True)
	Select ;Parameter Checking, Trust No One
		Case $_vIRC = ""
			Return SetError(1, 1, 0)
		Case $_vIRC = -1
			Return SetError(1, 2, 0)
		Case $_sTarget = ""
			Return SetError(2, 1, 0)
		Case Not $_sTarget = ""
			Switch AscW(StringLeft($_sTarget, 1))
				Case 0 To 32, 34, 36, 37, 39 To 42, 44 To 47, 58 To 64, 91 To 96, 123 To 1114111 ; AKA Not 33,35,38,43,48 To 57,65 To 90,97 To 122
					Return SetError(2, 2, 0)
			EndSwitch
		Case StringInStr($_sTarget, " ")
			Return SetError(2, 2, 0)
		Case $_sMsg = ""
			Return SetError(3, 0, 0)
		Case $_bTrim = ""
			Return SetError(4, 1, 0)
		Case Not IsBool($_bTrim)
			Return SetError(4, 2, 0)
	EndSelect
	If $_bTrim Then $_sMsg = StringLeft($_sMsg, 368)
	If (StringLen($_sTarget) + StringLen($_sMsg) + 16 + 16 + 64 + 32) > 512 Then
		Do
			$_sSend = StringLeft($_sMsg, 368)
			$_sMsg = StringTrimLeft($_sMsg, 368)
			TCPSend($_vIRC, "PRIVMSG " & $_sTarget & " :" & $_sSend & @CRLF)
			If @error Then Return SetError(5, @error & @extended, 0)
		Until StringLen($_sMsg) = 0
	Else
		TCPSend($_vIRC, "PRIVMSG " & $_sTarget & " :" & $_sMsg & @CRLF)
		If @error Then Return SetError(5, @error & @extended, 0)
	EndIf
	Return 1
EndFunc   ;==>_IRCMultiSendMsg


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCRaw
; Description ...: Sends Raw Data to the Server
; Syntax ........: _IRCRaw($_vIRC, $_sMsg)
; Parameters ....: $_vIRC               - Socket Identifier from _IRCConnect().
;                  $_sMsg               - Message to Send.
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and sets @error:
;                  |1 = Invalid Socket Identifier, sets @extended: (1, if empty; 2, if -1)
;                  |2 = Invalid Message
;                  |3 = Error Sending, sets @extended to TCPSend error returned
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 09/28/2014
; Remarks .......: Stripped from Chips' _IRCSendMessage, Use this to bypass UDF IRC Compliance
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCRaw($_vIRC, $_sMsg)
	Select ;Parameter Checking, Trust No One
		Case $_vIRC = ""
			Return SetError(1, 1, 0)
		Case $_vIRC = -1
			Return SetError(1, 2, 0)
		Case $_sMsg = ""
			Return SetError(2, 0, 0)
	EndSelect
	TCPSend($_vIRC, $_sMsg & @CRLF)
	If @error Then Return SetError(3, @error & @extended, 0)
	Return 1
EndFunc   ;==>_IRCRaw


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCSelfOper
; Description ...: IRC Operator Login Command
; Syntax ........: _IRCSelfOper($_vIRC, $_sUser, $_sPass)
; Parameters ....: $_vIRC               - Socket Identifier from _IRCConnect()
;                  $_sUser              - Username to use.
;                  $_sPass              - Password to use.
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and sets @error:
;                  |1 = Invalid Socket Identifier, sets @extended: (1, if empty; 2, if -1)
;                  |2 = Invalid Username, sets @extended: (1, if empty; 2, if not IRC compliant)
;                  |3 = Invalid Password, sets @extended: (1, if empty; 2, if not IRC compliant)
;                  |4 = Error Sending, sets @extended to TCPSend error returned
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 09/28/2014
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCSelfOper($_vIRC, $_sUser, $_sPass)
	Select ;Parameter Checking, Trust No One
		Case $_vIRC = ""
			Return SetError(1, 1, 0)
		Case $_vIRC = -1
			Return SetError(1, 2, 0)
		Case $_sUser = ""
			Return SetError(2, 1, 0)
		Case StringInStr($_sUser, " ")
			Return SetError(2, 2, 0)
		Case $_sPass = ""
			Return SetError(3, 1, 0)
		Case StringInStr($_sPass, " ")
			Return SetError(3, 2, 0)
	EndSelect
	TCPSend($_vIRC, "OPER " & $_sUser & " " & $_sPass & @CRLF)
	If @error Then Return SetError(4, @error & @extended, 0)
	Return 1
EndFunc   ;==>_IRCSelfOper


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCSelfSetNick
; Description ...: Changes the User's Nick
; Syntax ........: _IRCSelfSetNick($_vIRC, $_sNick)
; Parameters ....: $_vIRC               - Socket Identifier from _IRCConnect().
;                  $_sNick              - Nick to use.
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and sets @error:
;                  |1 = Invalid Socket Identifier, sets @extended: (1, if empty; 2, if -1)
;                  |2 = Invalid Nick, sets @extended: (1, if empty; 2, if not IRC compliant)
;                  |3 = Failure Sending, sets @extended to TCPSend error returned
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 09/28/2014
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCSelfSetNick($_vIRC, $_sNick)
	Select ;Parameter Checking, Trust No One
		Case $_vIRC = ""
			Return SetError(1, 1, 0)
		Case $_vIRC = -1
			Return SetError(1, 2, 0)
		Case $_sNick = ""
			Return SetError(2, 1, 0)
		Case StringInStr($_sNick, " ")
			Return SetError(2, 2, 0)
	EndSelect
	TCPSend($_vIRC, "NICK " & $_sNick & @CRLF)
	If @error Then Return SetError(3, @error & @extended, 0)
	Return 1
EndFunc   ;==>_IRCSelfSetNick


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCSelfSetStatus
; Description ...: Sets the User to Away (AFK) or Not
; Syntax ........: _IRCSelfSetStatus($_vIRC[, $_sMsg = ""])
; Parameters ....: $_vIRC               - Socket Identifier from _IRCConnect().
;                  $_sMsg               - [optional] Away Message. Default is "".
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and sets @error:
;                  |1 = Invalid Socket Identifier, sets @extended: (1, if empty; 2, if -1)
;                  |2 = Failure Sending, sets @extended to TCPSend error returned
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 09/28/2014
; Remarks .......: Defaults to setting the User Not AFK
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCSelfSetStatus($_vIRC, $_sMsg = "")
	Select ;Parameter Checking, Trust No One
		Case $_vIRC = ""
			Return SetError(1, 1, 0)
		Case $_vIRC = -1
			Return SetError(1, 2, 0)
	EndSelect
	If Not $_sMsg = "" Then $_sMsg = " :" & $_sMsg
	TCPSend($_vIRC, "AWAY" & $_sMsg & @CRLF)
	If @error Then Return SetError(2, @error & @extended, 0)
	Return 1
EndFunc   ;==>_IRCSelfSetStatus


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCServerPing
; Description ...: Sends a PING to the Server
; Syntax ........: _IRCServerPing($_vIRC, $_sServer = "")
; Parameters ....: $_vIRC               - Socket Identifier from _IRCConnect().
;                  $_sServer            - Server to Ping.
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and sets @error:
;                  |1 = Invalid Socket Identifier, sets @extended: (1, if empty; 2, if -1)
;                  |2 = Invalid Server
;                  |3 = Error Sending, sets @extended to TCPSend error returned
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 09/28/2014
; Remarks .......: Modified from Chips' coding
; Related .......: _IRCServerPong
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCServerPing($_vIRC, $_sServer)
	Select ;Parameter Checking, Trust No One
		Case $_vIRC = ""
			Return SetError(1, 1, 0)
		Case $_vIRC = -1
			Return SetError(1, 2, 0)
		Case $_sServer = ""
			Return SetError(2, 0, 0)
	EndSelect
	TCPSend($_vIRC, "PING " & $_sServer & @CRLF)
	If @error Then Return SetError(3, @error & @extended, 0)
	Return 1
EndFunc   ;==>_IRCServerPing


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCServerPong
; Description ...: Replies to a PING from the Server
; Syntax ........: _IRCServerPong($_vIRC, $_sRet)
; Parameters ....: $_vIRC                 - Socket Identifier from _IRCConnect().
;                  $_sServer              - Server to Reply to.
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and sets @error:
;                  |1 = Invalid Socket Identifier, sets @extended: (1, if empty; 2, if -1)
;                  |2 = Invalid Server
;                  |3 = Error Sending, sets @extended to TCPSend error returned
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 09/28/2014
; Remarks .......: Modified from Chips' coding
; Related .......: _IRCServerPing
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCServerPong($_vIRC, $_sServer)
	Select ;Parameter Checking, Trust No One
		Case $_vIRC = ""
			Return SetError(1, 1, 0)
		Case $_vIRC = -1
			Return SetError(1, 2, 0)
		Case $_sServer = ""
			Return SetError(2, 0, 0)
	EndSelect
	TCPSend($_vIRC, "PONG " & $_sServer & @CRLF)
	If @error Then Return SetError(3, @error & @extended, 0)
	Return 1
EndFunc   ;==>_IRCServerPong


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCServerTime
; Description ...: Gets the Current Time from a Server on the Network
; Syntax ........: _IRCServerTime($_vIRC[, $_sServer = ""])
; Parameters ....: $_vIRC               - Socket Identifier from _IRCConnect().
;                  $_sServer            - [optional] Server to get time from. Default is "".
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and sets @error:
;                  |1 = Invalid Socket Identifier, sets @extended: (1, if empty; 2, if -1)
;                  |2 = Invalid Server
;                  |3 = Failure Sending, sets @extended to TCPSend error returned
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 09/28/2014
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCServerTime($_vIRC, $_sServer = "")
	Select ;Parameter Checking, Trust No One
		Case $_vIRC = ""
			Return SetError(1, 1, 0)
		Case $_vIRC = -1
			Return SetError(1, 2, 0)
		Case StringInStr($_sServer, " ")
			Return SetError(2, 0, 0)
	EndSelect
	If Not $_sServer = "" Then $_sServer = " " & $_sServer
	TCPSend($_vIRC, "TIME" & $_sServer & @CRLF)
	If @error Then Return SetError(3, @error & @extended, 0)
	Return 1
EndFunc   ;==>_IRCServerTime


; #FUNCTION# ====================================================================================================================
; Name ..........: _IRCServerVersion
; Description ...: Gets the Current Version from a Server on the Network
; Syntax ........: _IRCServerVersion($_vIRC[, $_sServer = ""])
; Parameters ....: $_vIRC               - Socket Identifier from _IRCConnect().
;                  $_sServer            - [optional] Server to get Version from. Default is "".
; Return values .: Success - Returns 1
;                  Failure - Returns 0 and sets @error:
;                  |1 = Invalid Socket Identifier, sets @extended: (1, if empty; 2, if -1)
;                  |2 = Invalid Server
;                  |3 = Failure Sending, sets @extended to TCPSend error returned
; Author ........: Robert Maehl (rcmaehl)
; Modified ......: 09/28/2014
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IRCServerVersion($_vIRC, $_sServer = "")
	Select ;Parameter Checking, Trust No One
		Case $_vIRC = ""
			Return SetError(1, 1, 0)
		Case $_vIRC = -1
			Return SetError(1, 2, 0)
		Case StringInStr($_sServer, " ")
			Return SetError(2, 0, 0)
	EndSelect
	If Not $_sServer = "" Then $_sServer = " " & $_sServer
	TCPSend($_vIRC, "VERSION" & $_sServer & @CRLF)
	If @error Then Return SetError(3, @error & @extended, 0)
	Return 1
EndFunc   ;==>_IRCServerVersion
