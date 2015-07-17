#include <Array.au3>
#include "IRC.au3"

Main()

Func Main()

	;Connection Variables

	;Server Specific Connection Variables
	Local $Server = "irc.freenode.net"      ; IRC Server
	Local $Port = 6667                      ; IRC Server Port
	Local $Pass = ""                        ; IRC Server Password

	;User Specific Connection Variables
	Local $Nick = "Au3Bot"                  ; Nick Name to Use
	Local $Nick2 = "Au3Bot2"                ; Nick Name to Use if First Choice isn't available
	Local $Mode = 0                         ; User Mode to Use
	Local $RealName = "Au3Bot"              ; Real Name to Use

	;Channel Variables
	Local $Channels = "#channel1,#channel2" ; Channels to Join
	Local $Keys = "key1,key2"               ; Channel Passwords

	;Channel User List Variables
	Local $aUsers = ""                      ; Empty Array Used to Collect Users in a Channel on Join
	Local $aChannels[0] = []                ; Array of Channels this Script is in

	;Time Out Variables
	Local $iLastPing = 0                    ; Variable Containing Last Ping Time
	Local $iTimeOut = 300000                ; Ping Timeout Amount in Milliseconds

	;Debug Variables
	Local $iExit = 0                        ; Exit Code

	;Start Up Networking
	Opt("TCPTimeout", 200)
	TCPStartup()

	Local $Sock = _IRCConnect($Server, $Port, $Nick, $Mode, $RealName, $Pass); Connects to IRC. Sends Password, if any. Declares User Identity.
	If @error Then
		ConsoleWrite("Server Connection Error: " & @error & " Extended: " & @extended & @CRLF); Display message on Error
		$iExit = 1
		Close($iExit)
	Else
		$iLastPing = TimerInit()
	EndIf

	While 1
		$sRecv = _IRCGetMsg($Sock) ; Receive Packets from the Server
		If @error Then
			$iError = @error
			$iExtended = @extended
			ConsoleWrite("Recv Error: " & $iError & " Extended: " & $iExtended & @CRLF); Display message on Error
			$iExit = 1
			ExitLoop
		EndIf
		If Not $sRecv Then ContinueLoop ; If Nothing Received then Continue Checking
		If TimerDiff($iLastPing) >= $iTimeOut Then
			ConsoleWrite("Disconnected - Ping Timeout" & @CRLF)
			$iExit = 1
			ExitLoop
		EndIf
		ConsoleWrite($sRecv) ; Write Received Data to Visual Console
		Local $sChannels = StringSplit($Channels, ",")
		Local $sTemp = StringSplit($sRecv, " ") ; Splits Packet into Command Message and Parameters

		Switch $sTemp[1] ; Server/User Handling

			Case "PING"
				$iLastPing = TimerInit()
				_IRCServerPong($Sock, $sTemp[2]); Checks for Pings from Server and Replies

			Case Else
				; Server/User Handling Stuff

		EndSwitch

		If $sTemp[0] <= 2 Then ContinueLoop ; Error Handling, So Next Line Doesn't Fail

		Switch $sTemp[2] ; What type of message did our program get?

			Case ":Closing" ; Connection Closed
				$iExit = 1
				ExitLoop

			Case "001" ; Server Welcome (RFC2812)
				_IRCChannelJoin($Sock, $Channels, $Keys); Join the Channels Specified
				_IRCMultiMode($Sock, $Nick, "+i")

;			Case "002" ; Your Host (RFC2812)

;			Case "003" ; Server Created (RFC2812)

;			Case "004" ; Server Info (RFC2812)

;			Case "005" And $sTemp[3] = ":Try"; Try Another Server (See 'Case "010"') (RFC2812)
;				$iExit = 1
;				ExitLoop

;			Case "005" ; Server Protocol Support (Bahamut, Unreal, Ultimate)

;			Case "006" ; Map? (Unreal)

;			Case "007" ; End of Map (Unreal)

;			Case "008" ; Server Notice Mask (ircu)

;			Case "009" ; Server Memory Total? (ircu)

;			Case "010" And Not TCPNameToIP($sTemp[3]) = "" ; Easy new server format from 'Case "005"', Possibly unreliable

;			Case "010" ; Server Memory Usage? (ircu)

			Case "332" ; Channel Topic
				$sChannel = $sTemp[4]
				$sChannel = StringReplace($sChannel, "#", "p") ; Filter out # as you can't use it in Assign()
				$sChannel = StringReplace($sChannel, "&", "a") ; Filter out & as you can't use it in Assign()
				$sTopic = StringTrimLeft($sRecv, StringInStr($sRecv,":", 0, 2)) ; Get Channel Topic
				$sTopic = StringStripCR($sTopic)
				$sTopic = StringReplace($sTopic, @LF, "")
				Assign($sChannel & "_topic", $sTopic)

			Case "333" ; Who Set Channel Topic and When
				$sChannel = $sTemp[4]
				$sChannel = StringReplace($sChannel, "#", "p") ; Filter out # as you can't use it in Assign()
				$sChannel = StringReplace($sChannel, "&", "a") ; Filter out & as you can't use it in Assign()
				Assign($sChannel & "_topic_user", $sTemp[5])
				Assign($sChannel & "_topic_time", $sTemp[6])

			Case "353" ; Parse Channel User List
				$sChannel = $sTemp[5]
				$sChannel = StringReplace($sChannel, "#", "p") ; Filter out # as you can't use it in Assign()
				$sChannel = StringReplace($sChannel, "&", "a") ; Filter out & as you can't use it in Assign()
				$sUserList = StringTrimLeft($sRecv, StringInStr($sRecv,":", 0, 2)) ; Get User List
				$sUserList = StringStripCR($sUserList)
				$sUserList = StringReplace($sUserList, @LF, "")
				$aUsers &= StringReplace($sUserList, " ", "|")
				$aUsers &= "|"

			Case "366" ; Joined Channel (Actually End of Channel User List)
				$aUsers = StringReplace($aUsers, "~", "")
				$aUsers = StringReplace($aUsers, "&", "")
				$aUsers = StringReplace($aUsers, "!", "")
				$aUsers = StringReplace($aUsers, "@", "")
				$aUsers = StringReplace($aUsers, "%", "")
				$aUsers = StringReplace($aUsers, "+", "")
				$aUsers = StringTrimRight($aUsers, 1)
				$aUsers = StringSplit($aUsers, "|", 2)
				Assign($sChannel & "_users", $aUsers)
				$aUsers = "" ; Empty Array for Next Channel

			Case "433" ; Nick already in use
				_IRCSelfSetNick($Sock, $Nick2)
				$Nick = $Nick2

			Case "JOIN"
				$sUser = StringMid($sTemp[1], 2, StringInStr($sTemp[1], "!") - 2); Get User Who Joined

				If $sUser <> $Nick Then ; Not Myself
					$sChannel = StringReplace($sChannel, "#", "p")
					$sChannel = StringReplace($sChannel, "&", "a")
					$aUsers = Eval($sChannel & "_users")
					_ArrayAdd($aUsers, $sUser)
					Assign($sChannel & "_users", $aUsers)
				Else
					$sTemp[3] = StringReplace($sTemp[3], ":", "")
					$sTemp[3] = StringReplace($sTemp[3], @CR, "")
					$sTemp[3] = StringReplace($sTemp[3], @LF, "")
					_ArrayAdd($aChannels, $sTemp[3])
				EndIf

			Case "KICK"
				$sUser = $sTemp[4]
				$sChannel = $sTemp[3]

				If $sUser <> $Nick Then ; Not Myself
					$sChannel = StringReplace($sChannel, "#", "p")
					$sChannel = StringReplace($sChannel, "&", "a")
					$aUsers = Eval($sChannel & "_users")
					$iIndex = _ArraySearch($aUsers, $sUser)
					_ArrayDelete($aUsers, $iIndex)
					Assign($sChannel & "_users", $aUsers)
				Else
					$sTemp[3] = StringReplace(StringReplace($sTemp[3], @CR, ""), @LF, "")
					$iIndex = _ArraySearch($aChannels, $sTemp[3])
					_ArrayDelete($aChannels, $iIndex)
				EndIf

			Case "NICK"
				$sUser = StringMid($sTemp[1], 2, StringInStr($sTemp[1], "!") - 2); Get User Who Changed Nicks
				$sNick = StringReplace($sTemp[3], @LF, "")
				$sNick = StringReplace($sNick, @CR, "")
				$sNick = StringTrimLeft($sNick, 1)

				If $sUser <> $Nick Then ; Not Myself
					$iIndex = UBound($aChannels)
					For $i = 0 To $iIndex - 1 Step 1
						$sChannel = $aChannels[$i]
						$sChannel = StringReplace($sChannel, "#", "p")
						$sChannel = StringReplace($sChannel, "&", "a")
						$aUsers = Eval($sChannel & "_users")
						$iIndex = _ArraySearch($aUsers, $sUser)
						If $iIndex = -1 Then ContinueLoop
						$aUsers[$iIndex] = $sNick
						Assign($sChannel & "_users", $aUsers)
					Next
				Else
					$Nick = $sNick
				EndIf

			Case "QUIT"
				$sUser = StringMid($sTemp[1], 2, StringInStr($sTemp[1], "!") - 2); Get User Who Left

				If $sUser <> $Nick Then ; Not Myself
					$iIndex = UBound($aChannels)
					For $i = 0 To $iIndex - 1 Step 1
						$sChannel = $aChannels[$i]
						$sChannel = StringReplace($sChannel, "#", "p")
						$aUsers = Eval($sChannel & "_users")
						$iIndex = _ArraySearch($aUsers, $sUser)
						If $iIndex = -1 Then ContinueLoop
						$aUsers[$iIndex] = $sUser
						Assign($sChannel & "_users", $aUsers)
					Next
				Else
					ConsoleWrite("EXCEPTION: Should not see self QUIT." & @CRLF)
					$iExit = 1
					ExitLoop
				EndIf

			Case "PART"
				$sUser = StringMid($sTemp[1], 2, StringInStr($sTemp[1], "!") - 2); Get User Who Left

				If $sUser <> $Nick Then ; Not Myself
					$aUsers = Eval($sChannel & "_users")
					$iIndex = _ArraySearch($aUsers, $sUser)
					_ArrayDelete($aUsers, $iIndex)
					Assign($sChannel & "_users", $aUsers)
				Else
					$sTemp[3] = StringReplace(StringReplace($sTemp[3], @CR, ""), @LF, "")
					$iIndex = _ArraySearch($aChannels, $sTemp[3])
					_ArrayDelete($aChannels, $iIndex)
				EndIf

			Case "PRIVMSG" ; Message Received in a Channel or PM
				$sUser = StringMid($sTemp[1], 2, StringInStr($sTemp[1], "!") - 2); Get User Who Sent the Message
				$sMessage = StringMid($sRecv, StringInStr($sRecv, ":", 0, 2) + 1); Get Full Message
				$sMessage = StringReplace(StringReplace($sMessage, @CR, ""), @LF, ""); Strip Carrage Returns and Line Feeds
				$aMessage = StringSplit($sMessage, " ")
				$sRecipient = $sTemp[3]

				Select

					Case $sMessage = "!channels"
						_IRCMultiSendMsg($Sock, $sRecipient, _ArrayToString($aChannels, ", "))

					Case $sMessage = "!nick"
						_IRCSelfSetNick($Sock, "Au2Bot")

					Case $aMessage[1] = "!quit"
						If $aMessage[0] > 1 Then
							$sQuitMsg = StringReplace($sMessage, "!quit ", "", 1)
							_IRCDisconnect($Sock, $sQuitMsg)
						Else
							_IRCDisconnect($Sock, $sUser & " told me to.")
						EndIf
						$iExit = 0
						ExitLoop

					Case $sMessage = "!topic"
						$sChannel = $sRecipient
						$sChannel = StringReplace($sChannel, "#", "p")
						$sChannel = StringReplace($sChannel, "&", "a")
						_IRCMultiSendMsg($Sock, $sRecipient, Eval($sChannel & "_topic"))

					Case $sMessage = "!users"
						$sChannel = $sRecipient
						$sChannel = StringReplace($sChannel, "#", "p")
						$sChannel = StringReplace($sChannel, "&", "a")
						_IRCMultiSendMsg($Sock, $sRecipient, _ArrayToString(Eval($sChannel & "_users"), ", "))

					Case Else
						;;;

				EndSelect

			Case "TOPIC" ; Topic Change
				$sChannel = $sTemp[3]
				$sChannel = StringReplace($sChannel, "#", "p") ; Filter out # as you can't use it in Assign()
				$sChannel = StringReplace($sChannel, "&", "a") ; Filter out & as you can't use it in Assign()
				$sTopic = StringTrimLeft($sRecv, StringInStr($sRecv,":", 0, 2)) ; Get Channel Topic
				$sTopic = StringStripCR($sTopic)
				$sTopic = StringReplace($sTopic, @LF, "")
				Assign($sChannel & "_topic", $sTopic)

			Case Else
				;;;

		EndSwitch
	WEnd
	Close($iExit = 1)
EndFunc

Func Close($iExitCode)
	Sleep(2000)
	TCPShutdown()
	Exit($iExitCode)
EndFunc

#cs

== Common Recieved Messages ==

Server = Server who sent the message
Nick = A User who the message is from
Name = Settable by user, set in the USER command
Host = Host Mask (Can be your IP or something that represents it)

Any 3 digit Code:
	Contains information based on various events
	Check https://www.alien.net.au/irc/irc2numerics.html for specifics

	SYNTAXES:
		:Server ### Recipient
		:Server ### Recipient :Info
		:Server ### Recipient Info :Info

	EXAMPLES:
		:hobana.freenode.net 001 Au3Bot :Welcome to the freenode Internet Relay Chat Network Au3Bot
		:hobana.freenode.net 002 Au3Bot :Your host is hobana.freenode.net[62.231.75.133/6667], running version ircd-seven-1.1.3
		:hobana.freenode.net 461 Au3Bot PING :Not enough parameters

JOIN:
	You receive this when someone, including yourself, joins a channel.
	Check http://tools.ietf.org/html/rfc1459#section-4.2.1 and http://tools.ietf.org/html/rfc2812#section-3.2.1 for specifics

	SYNTAXES:
		:Nick!Name@Host JOIN Channel

	EXAMPLES:
		:Au3Bot!~Au3Bot@unaffiliated/why JOIN #fcofix


KICK:
	You receive this when someone, including yourself, gets kicked
	Check http://tools.ietf.org/html/rfc1459#section-4.2.8 and http://tools.ietf.org/html/rfc2812#section-3.2.8 for specifics

	SYNTAXES:
		:Nick!Name@Host KICK Channel User1 :Reason

	EXAMPLE:
		:rcmaehl!~why@unaffiliated/why KICK #fcofix Au3Bot :No Bots Allowed

MODE:
	You receive this when a user or channel mode is changed.
	Check http://tools.ietf.org/html/rfc1459#section-4.2.3.1, http://tools.ietf.org/html/rfc1459#section-4.2.3.2,
	http://tools.ietf.org/html/rfc2812#section-3.1.5, and http://tools.ietf.org/html/rfc2812#section-3.2.3

	SYNTAXES:
		:Nick MODE Nick :+Mode
		:Nick MODE Nick :-Mode
		:Nick!Name@host MODE Channel :+Mode
		:Nick!Name@host MODE Channel :-Mode
		:Nick!Name@host MODE Channel :+Mode User
		:Nick!Name@host MODE Channel :-Mode User

	EXAMPLES:
		:Au3Bot MODE Au3Bot :+i
		:rcmaehl!~why@unaffiliated/why MODE #fcofix +s
		:rcmaehl!~why@unaffiliated/why MODE #fcofix +o rcmaehl
		:ChanServ!ChanServ@services. MODE #fcofix -o rcmaehl


NICK:
	You receive this when someone, including yourself, changes their nick.
	Check http://tools.ietf.org/html/rfc1459#section-4.1.2 and http://tools.ietf.org/html/rfc2812#section-3.1.2 for specifics

	SYNTAXES:
		:Nick!Name@Host NICK :NewNick

	EXAMPLES:
		:rcmaehl!~why@unaffiliated/why NICK :rcmaehl2

PART:
	You receive this when someone, including yourself, parts a channel.
	Check http://tools.ietf.org/html/rfc1459#section-4.2.2 and http://tools.ietf.org/html/rfc2812#section-3.2.2 for specifics

	SYNTAXES:
		:Nick!Name@Host PART Channel
		:Nick!Name@Host PART Channel :"message"

	EXAMPLES:
		:rcmaehl!~why@unaffiliated/why PART #fcofix
		:rcmaehl!~why@unaffiliated/why PART #fcofix :"test message"

PING:
	You receive this when there's been no activity on your connection to the server for a certain period of time to confirm you're still connected.
	Check https://tools.ietf.org/html/rfc1459#section-4.6.2 and http://tools.ietf.org/html/rfc2812#section-3.7.2 for specifics

	SYNTAXES:
		PING :Server
		PING :RandomString

	EXAMPLES:
		PING :cameron.freenode.net
		PING :3dS4UmiS

PRIVMSG:
	You receive this when someone has sent a message in a channel or to you personally.
	Check http://tools.ietf.org/html/rfc1459#section-4.4.1 and http://tools.ietf.org/html/rfc2812#section-3.3.1 for specifics

	SYNTAXES:
		:Nick!Name@Host PRIVMSG Channel :Message
		:Nick!Name@Host PRIVMSG Recipient :Message

	EXAMPLES:
		:rcmaehl!~why@unaffiliated/why PRIVMSG #Channel :test message
		:rcmaehl!~why@unaffiliated/why PRIVMSG Au3Bot :Hi Au3bot

TOPIC:
	You receive this when someone, including yourself, has changed a channel topic
	Check http://tools.ietf.org/html/rfc1459#section-4.2.4 and http://tools.ietf.org/html/rfc2812#section-3.2.4 for specifics

	SYNTAXES:
		:Nick!Name@Host TOPIC Channel :Topic

	EXAMPLES:
		:rcmaehl!~why@unaffiliated/why TOPIC #Channel :I've set the channel topic!

#ce