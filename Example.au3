#include "IRC.au3"

Main()

Func Main()

	Local $Server = "irc.freenode.net"; IRC Server
	Local $Port = 6667; IRC Server Port
	Local $Nick = "Au3Bot"; Nick to Use
	Local $Mode = 0; User Mode to Use
	Local $RealName = "Au3Bot"; Real Name to Use
	Local $Pass = ""; IRC Server Password
	Local $Channels = "#channel1,#channel2"; Channels to Join
	Local $Keys = "key1,key2"; Channel Passwords

	TCPStartup()
	Local $Sock = _IRCConnect($Server, $Port, $Nick, $Mode, $RealName, $Pass); Connects to IRC. Sends Password, if any. Declares User Identity.
	If @error Then
		MsgBox(1, "IRC Example", "Server Connection Error: " & @error & " Extended: " & @extended); Display message on Error
		Exit(1)
	EndIf

	While 1
		$Recv = _IRCGetMsg($Sock); Receive Packets from the Server
		If Not $Recv Then ContinueLoop ;If Nothing Received then Continue Checking
		Local $sData = StringSplit($Recv, @CRLF); Split Packets if multiple Received
		Local $sChannels = StringSplit($Channels, ",")
		For $i = 1 To $sData[0] Step 1; Handles each Packet seperately
			Local $sTemp = StringSplit($sData[$i], " "); Splits Packet into Command Message and Parameters
			If $sTemp[1] = "PING" Then
				_IRCServerPong($Sock, $sTemp[2]); Checks for Pings from Server and Replies
				ConsoleWrite($sData[$i] & @CRLF)
			ElseIf $sTemp[0] <= 2 Then; Error Handling
				ConsoleWrite($sData[$i])
				ContinueLoop
			EndIf
			Switch $sTemp[2]; What to do on each Command
				Case "001"; Connected to Server (Actually Server Welcome)
					ConsoleWrite($sData[$i]); Output to Console for Visual Example of Data Received
					_IRCChannelJoin($Sock, $Channels, $Keys); Join the Channels Specified
					_IRCMultiMode($Sock, $Nick, "+i")
				Case "366"; Joined Channel (Actually End of Channel User List)
					ConsoleWrite($sData[$i]); Output to Console for Visual Example of Data Received
					_IRCMultiSendMsg($Sock, $sChannels[1], "Hello, this is an example IRC script")
					_IRCSelfSetNick($Sock, "Au2Bot")
					_IRCChannelPart($Sock, $sChannels[1], "Leaving.")
				Case ":Closing" ; Connection Closed
					ConsoleWrite($sData[$i] & @CRLF); Output to Console for Visual Example of Data Received
					Exit(0)
				Case "PRIVMSG" ; Message Received in a Channel or PM
					ConsoleWrite($sData[$i] & @CRLF); Output to Console for Visual Example of Data Received
					$User = StringMid($stemp[1], 2, StringInStr($stemp[1], "!") - 2); Get User Who Sent the Message
					$Message = StringMid($sdata[$i], StringInStr($sdata[$i], ":", 0, 2) + 1); Get Full Message
					$Recipient = $sData[3]
					Switch $Message
						Case "!quit"
							_IRCDisconnect($Sock, $User & " told me to.")
						Case Else
							;;;
					EndSwitch
				Case Else
					ConsoleWrite($sData[$i] & @CRLF); Output to Console for Visual Example of Data Received
			EndSwitch
		Next
	WEnd
EndFunc

#cs

== Common Recieved Messages ==

Server = Server who sent the message
Nick = A User who the message is from
Name = Settable by user, set in the USER command
Host = Host Mask (Can be your IP or something that represents it)

Notes:
    This list is not complete as there's dozens of IRC Daemons
    This list is based on the second part of the received info


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


KICK:
    You receive this when someone gets kicked (Including yourself!)
    Check http://tools.ietf.org/html/rfc1459#section-4.2.8 and http://tools.ietf.org/html/rfc2812#section-3.2.8 for specifics

    SYNTAXES:
        :Nick!Name@Host KICK Channel User1 :Reason

    EXAMPLE:
        :rcmaehl!~why@unaffiliated/why KICK #fcofix Au3Bot :No Bots Allowed


PRIVMSG:
    You receive this when someone has sent a message in a channel or to you personally.
    Check http://tools.ietf.org/html/rfc1459#section-4.4.1 and http://tools.ietf.org/html/rfc2812#section-3.3.1 for specifics

    SYNTAXES:
        :Nick!Name@Host PRIVMSG Channel :Message
        :Nick!Name@Host PRIVMSG Recipient :Message

    EXAMPLES:
        :rcmaehl!~why@unaffiliated/why PRIVMSG #Channel :test message
        :rcmaehl!~why@unaffiliated/why PRIVMSG Au3Bot :Hi Au3bot


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


JOIN:
    You receive this when someone (Including yourself) joins a channel.
    Check http://tools.ietf.org/html/rfc1459#section-4.2.1 and http://tools.ietf.org/html/rfc2812#section-3.2.1 for specifics

    SYNTAXES:
        :Nick!Name@Host JOIN Channel

    EXAMPLES:
        :Au3Bot!~Au3Bot@unaffiliated/why JOIN #fcofix


PART:
    You receive this when someone (Including yourself) parts a channel.
    Check http://tools.ietf.org/html/rfc1459#section-4.2.2 and http://tools.ietf.org/html/rfc2812#section-3.2.2 for specifics

    SYNTAXES:
        :Nick!Name@Host PART Channel
        :Nick!Name@Host PART Channel :"message"

    EXAMPLES:
        :rcmaehl!~why@unaffiliated/why PART #fcofix
        :rcmaehl!~why@unaffiliated/why PART #fcofix :"test message"


#ce