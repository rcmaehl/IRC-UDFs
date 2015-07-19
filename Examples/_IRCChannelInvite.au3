#include ".\..\IRC.au3"

; Allow some TCP lag
Opt("TCPTimeout", 200)

; Start Example
Example()

Func Example()

	;Start Up Networking
	TCPStartup()

	; Connect to IRC. Send Password, if any. Declare User Identity.
	Local $Sock = _IRCConnect("irc.freenode.net", 6667, "Au3bot", 0, "Au3Bot", "")

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

	; Start Loop
	While 1

		; Receive Data
		$sRecv = _IRCGetMsg($Sock)

		; If Error Getting Data
		If @error Then

			; Display Message on Error
			ConsoleWrite("Recv Error: " & @error & " Extended: " & @extended & @CRLF); Display message on Error

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

		; Split Data into Commands and Parameters for Processing
		Local $sTemp = StringSplit($sRecv, " ")

		; If Not Usable, then Skip this Data
		If $sTemp[0] <= 2 Then ContinueLoop

		Switch $sTemp[2] ; What type of message did our program get?

			; On Server Welcome
			Case "001"

				; Join #ircudftest
				_IRCChannelJoin($Sock, "#ircudftest")

			; On Channel Join
			Case "366"

				; Invite Chanserv to #defocus
				_IRCChannelInvite($Sock, "chanserv", "#ircudftest")

				; Shutdown Networking
				TCPShutdown()

				; Exit
				Exit

		EndSwitch
	WEnd
EndFunc