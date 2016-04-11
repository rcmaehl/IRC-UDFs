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

	WEnd
EndFunc
