#$language = "VBScript"
#$interface = "1.0"

crt.Screen.Synchronous = True

' This automatically generated script may need to be
' edited in order to work correctly.

Sub Main
    for i = 0 to 100
    crt.Session.Disconnect
    crt.Session.Connect("/TELNET 10.1.207.20")
    crt.Screen.WaitForString "login:"
    crt.Screen.Send "root" & chr(13)
    crt.Screen.WaitForString "Password:"
    crt.Screen.Send "Spat705!1" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Screen.Send "df" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.sleep 1000
    next
End Sub

