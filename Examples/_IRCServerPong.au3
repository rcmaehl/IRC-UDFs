#include <IRC.au3>

; Allow some TCP lag
Opt("TCPTimeout", 500)

; Start Example
Example()

Func Example()

	; Start Up Networking
	TCPStartup()

	; Connect to IRC. Send Password, if any. Declare User Identity.
	Local $Sock = _IRCConnect("irc.freenode.net", 6667, "Au3bot" & Random(1000, 9999, 1), 0, "Au3Bot", "")

	; If Error Connecting
	If @error Then

		; Display Message on Error
		ConsoleWrite("Server Connection Error: " & @error & " Extended: " & @extended & @CRLF)

		; Shutdown Networking
		TCPShutdown()

		; Exit with Error
		Exit 1

	EndIf

	; Prepare to Receive Data
	Local $sRecv = ""

	; Start Timer
	Local $hTime = TimerInit()

	; Start Loop
	While 1

		; Receive Data
		$sRecv = _IRCGetMsg($Sock)

		; If Error Getting Data
		If @error Then

			; Display Message on Error
			ConsoleWrite("Recv Error: " & @error & " Extended: " & @extended & @CRLF)

			; Shutdown Networking
			TCPShutdown()

			; Exit with Error
			Exit 1

		; Otherwise, If No Data
		ElseIf Not $sRecv Then

			; Continue Checking
			ContinueLoop

		EndIf

		; Write Received Data to Console
		ConsoleWrite($sRecv)

		Local $sTemp = StringSplit($sRecv, " ") ; Splits Packet into Command Message and Parameters

		Switch $sTemp[1] ; Server/User Handling

			Case "PING"
				Local $sPing = StringReplace($sTemp[2], ":", "")
				_IRCServerPong($Sock, $sPing); Checks for Pings from Server and Replies

			Case Else
				; Server/User Handling Stuff

		EndSwitch

		; If We've Received Data for 10 Minutes
		If TimerDiff($hTime) >= 600000 Then

			; Disconnect
			_IRCDisconnect($Sock)

			; Shutdown Networking
			TCPShutdown()

			; Exit
			Exit

		EndIf

	WEnd
EndFunc
