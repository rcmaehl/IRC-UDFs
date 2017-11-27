; FUNCTION# ===========================================================================================================
; Name...........: _ValidIP
; Description ...: Verifies whether an IP address is a valid IPv4 address or not
; Syntax.........: _ValidIP($sIP)
; Parameters ....: $sIP - IP address to validate
;
; Return values .: Success - Array containing split IP Address, IP address in Hex, and the Class of the IP address
;                            array[0] - [3] = the IP address split into octets
;                            array[4]       = IP address in Hex
;                            array[5]       = Class of the IP address [A through D]
;                  Failure - -1, sets @error
;                  |1 - IP address starts with an invalid number = 0, 127 , 169 or is > 239
;                  |2 - one of the octets of the IP address is out of the range 0-255 or contains invalid characters
;                  |3 - IP Address is not a valid dotted IP address (ex. valid address 190.40.100.20)
;                  |4 - Last octet ends in 0 or 255 which are invalid for an IP address
; Author ........: BrewManNH
; Modified.......:
; Remarks .......: This will accept an IP address that is 4 octets long, and contains only numbers and falls within
;                  valid IP address values. Class A networks can't start with 0 or 127. 169.xx.xx.xx is reserved and is
;                  invalid and any address that starts above 239, ex. 240.xx.xx.xx is reserved. The address range
;                  224-239 1s reserved as well for Multicast groups but can be a valid IP address range if you're using
;                  it as such. Any IP address ending in 0 or 255 is also invalid for an IP
; Related .......:
; Link ..........:
; Example .......: Yes
; =====================================================================================================================
Func _ValidIP($sIP)
    Local $adIPAddressInfo[6]

    Local $aArray = StringSplit($sIP, ".", 2)

    If Not IsArray($aArray) Or UBound($aArray) <> 4 Then Return SetError(3, 0, -1)

    Local $dString = "0x"

    If $aArray[0] <= 0 Or $aArray[0] > 239 Or $aArray[0] = 127 Or $aArray[0] = 169 Then
        Return SetError(1, 0, -1)
    EndIf

    For $I = 0 To 3
        If $I < 3 Then
            If $aArray[$I] < 0 Or $aArray[$I] > 255 Or Not StringIsDigit($aArray[$I]) Then
                Return SetError(2, 0, -1)
            EndIf
        Else
            If Not StringIsDigit($aArray[$I]) Then
                Return SetError(2, 0, -1)
            EndIf

            If $aArray[$I] < 1 Or $aArray[$I] > 254 Then
                Return SetError(4, 0, -1)
            EndIf
        EndIf

        $dString &= StringRight(Hex($aArray[$I]), 2)

        $adIPAddressInfo[$I] = $aArray[$I]
    Next

    $adIPAddressInfo[4] = $dString

    Switch $aArray[0]
        Case 1 To 126
            $adIPAddressInfo[5] = "A"
            Return $adIPAddressInfo
        Case 128 To 191
            $adIPAddressInfo[5] = "B"
            Return $adIPAddressInfo
        Case 192 To 223
            $adIPAddressInfo[5] = "C"
            Return $adIPAddressInfo
        Case 224 To 239
            $adIPAddressInfo[5] = "D"
            Return $adIPAddressInfo
    EndSwitch
EndFunc   ;==>_ValidIP

; Outputting Colors to Console

; SCITE
; ConsoleWrite('! = Bold Red' & @LF)
; ConsoleWrite('> = Blue' & @LF)
; ConsoleWrite('- = Orange' & @LF)
; ConsoleWrite('+ = Green' & @LF)
; ConsoleWrite('(5) : = Red (jump to line 5 when double-clicked)' & @LF)
; ConsoleWrite('Start with String or Integer then ' & @TAB & '6' & ' = Pink (jump to line 6 when double-clicked)' & @LF)
; ConsoleWrite('(' & @ScriptLineNumber & ') : = Red (jump to line ' & @ScriptLineNumber & ' when double-clicked)' & @CRLF)

; Sorting a TreeView

; DllCall('user32.dll','int','SendMessage','hwnd',$hWnd,'uint',$TVM_SORTCHILDREN,'wparam',true,'lparam',$hItem)
