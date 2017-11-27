#include "..\includes\IRC.au3"
#include "..\includes\IRCExtras.au3"
#include <Array.au3>
#include <String.au3>
#include <GUIEdit.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <TreeViewConstants.au3>


Main()

Func Main()

	;Connection Variables

	;Server Specific Connection Variables
	Local $Server = "irc.freenode.net"       ; IRC Server
	Local $Port = 8000                       ; IRC Server Port
	Local $Pass = ""                         ; IRC Server Password

	;User Specific Connection Variables
	Local $Nick = "Au3Bot" & Random(0,999,1) ; Nick Name to Use
	Local $Nick2 = "Au3Bot" & Random(0,999,1); Nick Name to Use if First Choice isn't available
	Local $Mode = 0                          ; User Mode to Use
	Local $RealName = "Au3Bot"               ; Real Name to Use
	Local $UserPass = ""                     ; Username Password to Use
	Local $GhostInUse = True                 ; Ghost Username if in Use

	;Channel Variables
	Local $Channels = "#channel1,#channel2"  ; Channels to Join
	Local $Keys = "key1,key2"                ; Channel Passwords

	;Channel User List Variables
	Local $aUsers = ""                       ; Empty Array Used to Collect Users in a Channel on Join
	Local $aChannels[0] = []                 ; Array of Channels this Script is in

	;Time Out Variables
	Local $iLastPing = 0                     ; Variable Containing Last Ping Time
	Local $iTimeOut = 300000                 ; Ping Timeout Amount in Milliseconds

	;Debug Variables
	Local $sSplit = ""                       ; Message Split Storage
	Local $iExit = 0                         ; Exit Code

	;TreeView Variables
	Local $Servers[1] = [0]                  ; Server Array
	Local $CurrentS = 0					     ; Current server index
	Local $Channel[1][100]					 ; Channel Array

	;Create GUI
	Local $hGUI = GUICreate($Server, 800, 600, -1, -1, BitXOR($GUI_SS_DEFAULT_GUI, $WS_MINIMIZEBOX))

		Local $hFileMenu = GUICtrlCreateMenu("File")
			Local $hExitItem = GUICtrlCreateMenuItem("Exit", $hFileMenu)

;		Local $hServerMenu = GUICtrlCreateMenu("Server")
;			Local $hConnect = GUICtrlCreateMenuItem("Connect", $hServerMenu)

		Local $hTree = GUICtrlCreateTreeView(0, 0, 100, 600, BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP))
		Local $hOutput = GUICtrlCreateEdit("", 100, 0, 700, 540, $ES_READONLY+$ES_AUTOVSCROLL+$ES_MULTILINE+$WS_VSCROLL)
		Local $hInput = GUICtrlCreateInput("", 100, 560, 700, 20)

	GUISetState(@SW_SHOW, $hGUI)

	;Start Up Networking
	Opt("TCPTimeout", 500)
	TCPStartup()

	Local $Sock = _IRCConnect($Server, $Port, $Nick, $Mode, $RealName, $Pass); Connects to IRC. Sends Password, if any. Declares User Identity.

	If @error Then
		$sCurrOutput = GUICtrlRead($hOutput)
		GUICtrlSetData($hOutput, $sCurrOutput &  "Server Connection Error: " & @error & " Extended: " & @extended & @CRLF); Display message on Error
	Else
		$iLastPing = TimerInit()
	EndIf

	While 1
		Switch GUIGetMsg()

				Case $GUI_EVENT_CLOSE
					$iExit = 0
					ExitLoop

				Case $hExitItem
					$iExit = 0
					ExitLoop

				Case Else

		EndSwitch

		$sRecv = _IRCGetMsg($Sock) ; Receive Packets from the Server
		If @error Then ; If Error Getting Message
			$iError = @error
			$iExtended = @extended
			$sCurrOutput = GUICtrlRead($hOutput)
			$iLines = _GUICtrlEdit_GetLineCount($hOutput)
			GUICtrlSetData($hOutput, $sCurrOutput & "Recv Error: " & $iError & " Extended: " & $iExtended & @CRLF); Display message on Error
			_GUICtrlEdit_LineScroll($hOutput, 0, $iLines)
			$iExit = 1
			ExitLoop
		ElseIf Not $sRecv Then ; If Nothing Received Then Continue Checking
			ContinueLoop
		ElseIf TimerDiff($iLastPing) >= $iTimeOut Then
			$sCurrOutput = GUICtrlRead($hOutput)
			$iLines = _GUICtrlEdit_GetLineCount($hOutput)
			GUICtrlSetData($hOutput, $sCurrOutput & "Disconnected - Ping Timeout" & @CRLF)
			_GUICtrlEdit_LineScroll($hOutput, 0, $iLines)
			$iExit = 1
			ExitLoop
		EndIf
		$iLines = _GUICtrlEdit_GetLineCount($hOutput)
		GUICtrlSetData($hOutput, GUICtrlRead($hOutput) & $sRecv) ; Write Received Data to GUI Console
		_GUICtrlEdit_LineScroll($hOutput, 0, $iLines)

		$sSplit = StringSplit($sRecv, " ") ; Splits Packet into Command Message and Parameters

		Switch $sSplit[1] ; Server/User Handling

			Case "PING"
				$iLastPing = TimerInit()
				$sPing = StringReplace($sSplit[2], ":", "")
				_IRCServerPong($Sock, $sPing); Checks for Pings from Server and Replies

			Case Else
				$sServer = _StringBetween($sSplit[1], ".", ".")

		EndSwitch

		If $sSplit[0] <= 2 Then ContinueLoop ; Error Handling, So Next Line Doesn't Fail

		Switch $sSplit[2] ; What type of message did our program get?

			Case ":Closing" ; Connection Closed
				$iExit = 1
				ExitLoop

			Case $RPL_WELCOME ; Server Welcome (RFC2812)
				$sServer = StringSplit($Server, ".")[2]
				ConsoleWrite($Server & " became: " & $sServer)
				$Servers[0] += 1
				$Current = $Servers[0]
				ReDim $Servers[$Servers[0] + 1]
				$Servers[$Current] = GUICtrlCreateTreeViewItem($sServer, $hTree)
				If Not $UserPass = "" Then _IRCMultiSendMsg($Sock, "NICKSERV", "IDENTIFY " & $Nick & " " & $UserPass)
				_IRCChannelJoin($Sock, $Channels, $Keys); Join the Channels Specified
				_IRCMultiMode($Sock, $Nick, "+i")

;			Case "002" ; Your Host (RFC2812)

;			Case "003" ; Server Created (RFC2812)

;			Case "004" ; Server Info (RFC2812)

;			Case "005" And $sSplit[3] = ":Try"; Try Another Server (See 'Case "010"') (RFC2812)
;				$iExit = 1
;				ExitLoop

;			Case "005" ; Server Protocol Support (Bahamut, Unreal, Ultimate)

;			Case "006" ; Map? (Unreal)

;			Case "007" ; End of Map (Unreal)

;			Case "008" ; Server Notice Mask (ircu)

;			Case "009" ; Server Memory Total? (ircu)

;			Case "010" And Not TCPNameToIP($sSplit[3]) = "" ; Easy new server format from 'Case "005"', Possibly unreliable

;			Case "010" ; Server Memory Usage? (ircu)

			Case $RPL_TOPIC ; Channel Topic
				$sChannel = $sSplit[4]
				$sChannel = StringReplace($sChannel, "#", "p") ; Filter out # as you can't use it in Assign()
				$sChannel = StringReplace($sChannel, "&", "a") ; Filter out & as you can't use it in Assign()
				$sTopic = StringTrimLeft($sRecv, StringInStr($sRecv,":", 0, 2)) ; Get Channel Topic
				$sTopic = StringStripCR($sTopic)
				$sTopic = StringReplace($sTopic, @LF, "")
				Assign($sChannel & "_topic", $sTopic)

			Case $RPL_TOPICWHOTIME ; Who Set Channel Topic and When
				$sChannel = $sSplit[4]
				$sChannel = StringReplace($sChannel, "#", "p") ; Filter out # as you can't use it in Assign()
				$sChannel = StringReplace($sChannel, "&", "a") ; Filter out & as you can't use it in Assign()
				Assign($sChannel & "_topic_user", $sSplit[5])
				Assign($sChannel & "_topic_time", $sSplit[6])

			Case $RPL_NAMREPLY ; Parse Channel User List
				$sChannel = $sSplit[5]
				$sChannel = StringReplace($sChannel, "#", "p") ; Filter out # as you can't use it in Assign()
				$sChannel = StringReplace($sChannel, "&", "a") ; Filter out & as you can't use it in Assign()
				$sUserList = StringTrimLeft($sRecv, StringInStr($sRecv,":", 0, 2)) ; Get User List
				$sUserList = StringStripCR($sUserList)
				$sUserList = StringReplace($sUserList, @LF, "")
				$aUsers &= StringReplace($sUserList, " ", "|")
				$aUsers &= "|"

			Case $RPL_ENDOFNAMES ; Joined Channel (Actually End of Channel User List)
				$aUsers = StringReplace($aUsers, "~", "") ; Strip out Channel Statuses
				$aUsers = StringReplace($aUsers, "&", "")
				$aUsers = StringReplace($aUsers, "!", "")
				$aUsers = StringReplace($aUsers, "@", "")
				$aUsers = StringReplace($aUsers, "%", "")
				$aUsers = StringReplace($aUsers, "+", "")
				$aUsers = StringTrimRight($aUsers, 1)
				$aUsers = StringSplit($aUsers, "|", 2)
				Assign($sChannel & "_users", $aUsers)
				$sChannel = "" ; Empty Channel for Next Channel, Just in Case
				$aUsers = "" ; Empty Array for Next Channel

			Case $ERR_UNAVAILRESOURCE ; Nick unavailable
				_IRCSelfSetNick($Sock, $Nick2)
				$Nick = $Nick2

			Case "443" ; Nick already in use
				_IRCSelfSetNick($Sock, $Nick2)
				$Nick = $Nick2
				If $GhostInUse Then
					_IRCMultiSendMsg($Sock, "NICKSERV", "GHOST " & $Nick & " " & $Pass)
					_IRCSelfSetNick($Sock, $Nick)
					$Nick = $Nick
				EndIf

			Case "JOIN"
				$sUser = StringMid($sSplit[1], 2, StringInStr($sSplit[1], "!") - 2); Get User Who Joined
				$sChannel = $sSplit[3] ; Get Channel They Joined

				If $sUser <> $Nick Then ; Not Myself
					$sChannel = StringReplace($sChannel, "#", "p")
					$sChannel = StringReplace($sChannel, "&", "a")
					$aUsers = Eval($sChannel & "_users")
					_ArrayAdd($aUsers, $sUser)
					Assign($sChannel & "_users", $aUsers)
				Else
					$Channels = GUICtrlCreateTreeViewItem($sChannel, $Servers[0])
					$sSplit[3] = StringReplace($sSplit[3], ":", "")
					$sSplit[3] = StringReplace($sSplit[3], @CR, "")
					$sSplit[3] = StringReplace($sSplit[3], @LF, "")
					_ArrayAdd($aChannels, $sSplit[3])
				EndIf

			Case "KICK"
				$sUser = $sSplit[4] ; Get User Who Got Kicked
				$sChannel = $sSplit[3] ; Get Channel They Got Kicked From

				If $sUser <> $Nick Then ; Not Myself
					$sChannel = StringReplace($sChannel, "#", "p") ; Update username tracker
					$sChannel = StringReplace($sChannel, "&", "a")
					$aUsers = Eval($sChannel & "_users")
					$iIndex = _ArraySearch($aUsers, $sUser)
					_ArrayDelete($aUsers, $iIndex)
					Assign($sChannel & "_users", $aUsers)
				Else
					$sSplit[3] = StringReplace(StringReplace($sSplit[3], @CR, ""), @LF, "") ; Update username tracker
					$iIndex = _ArraySearch($aChannels, $sSplit[3])
					_ArrayDelete($aChannels, $iIndex)
				EndIf

			Case "NICK"
				$sUser = StringMid($sSplit[1], 2, StringInStr($sSplit[1], "!") - 2); Get User Who Changed Nicks
				$sNick = StringReplace($sSplit[3], @LF, "")
				$sNick = StringReplace($sNick, @CR, "")
				$sNick = StringTrimLeft($sNick, 1)

				$iIndex = UBound($aChannels) ; Update username tracker
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

				If $sUser = $Nick Then $Nick = $sNick ; My Nick Changed

			Case "QUIT"
				$sUser = StringMid($sSplit[1], 2, StringInStr($sSplit[1], "!") - 2); Get User Who Left

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
					$iLines = _GUICtrlEdit_GetLineCount($hOutput)
					GUICtrlSetData($hOutput, GUICtrlRead($hOutput) & "EXCEPTION: Should not see self QUIT." & @CRLF)
					_GUICtrlEdit_LineScroll($hOutput, 0, $iLines)
					$iExit = 1
					ExitLoop
				EndIf

			Case "PART"
				$sUser = StringMid($sSplit[1], 2, StringInStr($sSplit[1], "!") - 2); Get User Who Parted
				$sChannel = $sSplit[3] ; Get Channel They Parted

				If $sUser <> $Nick Then ; Not Myself
					$aUsers = Eval($sChannel & "_users")
					$iIndex = _ArraySearch($aUsers, $sUser)
					_ArrayDelete($aUsers, $iIndex)
					Assign($sChannel & "_users", $aUsers)
				Else
					$sSplit[3] = StringReplace(StringReplace($sSplit[3], @CR, ""), @LF, "")
					$iIndex = _ArraySearch($aChannels, $sSplit[3])
					_ArrayDelete($aChannels, $iIndex)
				EndIf

			Case "PRIVMSG" ; Message Received in a Channel or PM
				$sUser = StringMid($sSplit[1], 2, StringInStr($sSplit[1], "!") - 2); Get User Who Sent the Message
				$sMessage = StringMid($sRecv, StringInStr($sRecv, ":", 0, 2) + 1); Get Full Message
				$sMessage = StringReplace(StringReplace($sMessage, @CR, ""), @LF, ""); Strip Carrage Returns and Line Feeds
				$aMessage = StringSplit($sMessage, " ")
				$sRecipient = _IRCReplyTo($sSplit[1], $sSplit[3])

				Select

					Case $sMessage = "!channels"
						_IRCMultiSendMsg($Sock, $sRecipient, _ArrayToString($aChannels, ", "))

					Case $sMessage = "!help"
						_IRCMultiSendMsg($Sock, $sRecipient, "I'm sorry, I don't have a help file yet!")

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
				$sChannel = $sSplit[3]
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
	Close($iExit, $hGUI)
EndFunc

Func Close($iExitCode, $hWindow)
	Sleep(2000)
	GUIDelete($hWindow)
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
	Check http://defs.ircdocs.horse/defs/numerics.html for specifics

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
