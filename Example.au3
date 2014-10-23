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
    Local $Mode = 0                         ; User Mode to Use
    Local $RealName = "Au3Bot"              ; Real Name to Use

	;Channel Variables
    Local $Channels = "#channel1,#channel2" ; Channels to Join
    Local $Keys = "key1,key2"               ; Channel Passwords

	;Channel User List Variables
    Local $UserLists = ""

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
                Case ":Closing" ; Connection Closed
                    ConsoleWrite($sData[$i] & @CRLF); Output to Console for Visual Example of Data Received
                    TCPShutdown()
                    Exit(0)
                Case "001"; Connected to Server (Actually Server Welcome)
                    ConsoleWrite($sData[$i]); Output to Console for Visual Example of Data Received
                    _IRCChannelJoin($Sock, $Channels, $Keys); Join the Channels Specified
                    _IRCMultiMode($Sock, $Nick, "+i")
                Case "353"; Parse Channel User List
                    $Filtered = StringReplace($sTemp[5], "#", "p"); Filter out # as you can't use it in Assign()
                    $UserLists &= $Filtered & " "
                    $UserList = StringMid($sData[$i], StringInStr($sData[$i], ":", 0, 2) + 1); Get User List
                    If Not IsDeclared($Filtered & "_users") Then Assign($Filtered & "_users", ""); Create variable so the Eval in Assign doesn't fail
                    Assign($Filtered & "_users", Eval($Filtered & "_users") & $UserList); Add users to userlist
                    ConsoleWrite($sData[$i] & @CRLF); Output to Console for Visual Example of Data Received
                Case "366"; Joined Channel (Actually End of Channel User List)
                    ConsoleWrite($sData[$i]); Output to Console for Visual Example of Data Received
                    _IRCMultiSendMsg($Sock, $sChannels[1], "Hello, this is an example IRC script")
                    _IRCSelfSetNick($Sock, "Au2Bot")
                    _IRCChannelPart($Sock, $sChannels[1], "Leaving.")
				Case "JOIN"
                    ConsoleWrite($sData[$i] & @CRLF); Output to Console for Visual Example of Data Received
				Case "NICK"
                    ConsoleWrite($sData[$i] & @CRLF); Output to Console for Visual Example of Data Received
                    $User = StringMid($sTemp[1], 2, StringInStr($sTemp[1], "!") - 2); Get User Who Changed Nicks
                    $NewNick = StringMid($sData[$i], StringInStr($sData[$i], ":", 0, 2) + 1); Get User's New Nick
                    $sCurrent = StringSplit($UserLists, " "); Get channel lists and update nicks
                    For $i = 1 To $sCurrent[0] Step 1
                        $After = ""
                        $Split = StringSplit(Eval($sCurrent[$i] & "_users"), " ")
                        For $ii = 1 to $Split[0] Step 1
                            $Status = ""
                            If StringRegExp(StringLeft($Split[$ii],1), "[@~+%&]") Then
                                If StringRegExp($Split[$ii], "^[@~+%&]*" & $User & "$") Then
                                    $Status = StringLeft($Split[$ii], 1)
                                EndIf
                            EndIf
                            $After &= $Status & StringRegExpReplace($Split[$ii], "^[@~+%&]*" & $User & "$", $NewNick) & " "
                        Next
                        Assign($sCurrent[$i] & "_users", StringTrimRight($After,1))
                    Next
				Case "PART"
                    ConsoleWrite($sData[$i] & @CRLF); Output to Console for Visual Example of Data Received
                Case "PRIVMSG" ; Message Received in a Channel or PM
                    ConsoleWrite($sData[$i] & @CRLF); Output to Console for Visual Example of Data Received
                    $User = StringMid($sTemp[1], 2, StringInStr($sTemp[1], "!") - 2); Get User Who Sent the Message
                    $Message = StringMid($sData[$i], StringInStr($sData[$i], ":", 0, 2) + 1); Get Full Message
                    $Recipient = $sTemp[3]
                    Switch $Message
                        Case "!quit"
                            _IRCDisconnect($Sock, $User & " told me to.")
                            TCPShutdown()
                            Exit(0)
                        Case "!users"
                            _IRCMultiSendMsg($Sock, $Recipient, Eval(StringReplace($Recipient, "#", "p") & "_users"))
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


JOIN:
    You receive this when someone (Including yourself) joins a channel.
    Check http://tools.ietf.org/html/rfc1459#section-4.2.1 and http://tools.ietf.org/html/rfc2812#section-3.2.1 for specifics

    SYNTAXES:
        :Nick!Name@Host JOIN Channel

    EXAMPLES:
        :Au3Bot!~Au3Bot@unaffiliated/why JOIN #fcofix


KICK:
    You receive this when someone gets kicked (Including yourself!)
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
    You receive this when someone (Including yourself) changes their nick.
    Check http://tools.ietf.org/html/rfc1459#section-4.1.2 and http://tools.ietf.org/html/rfc2812#section-3.1.2 for specifics

    SYNTAXES:
        :Nick!Name@Host NICK :NewNick

    EXAMPLES:
        :rcmaehl!~why@unaffiliated/why NICK :rcmaehl2


PART:
    You receive this when someone (Including yourself) parts a channel.
    Check http://tools.ietf.org/html/rfc1459#section-4.2.2 and http://tools.ietf.org/html/rfc2812#section-3.2.2 for specifics

    SYNTAXES:
        :Nick!Name@Host PART Channel
        :Nick!Name@Host PART Channel :"message"

    EXAMPLES:
        :rcmaehl!~why@unaffiliated/why PART #fcofix
        :rcmaehl!~why@unaffiliated/why PART #fcofix :"test message"


PRIVMSG:
    You receive this when someone has sent a message in a channel or to you personally.
    Check http://tools.ietf.org/html/rfc1459#section-4.4.1 and http://tools.ietf.org/html/rfc2812#section-3.3.1 for specifics

    SYNTAXES:
        :Nick!Name@Host PRIVMSG Channel :Message
        :Nick!Name@Host PRIVMSG Recipient :Message

    EXAMPLES:
        :rcmaehl!~why@unaffiliated/why PRIVMSG #Channel :test message
        :rcmaehl!~why@unaffiliated/why PRIVMSG Au3Bot :Hi Au3bot


#ce