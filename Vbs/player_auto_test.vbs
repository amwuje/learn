#$language = "VBScript"
#$interface = "1.0"
Sub Main
 Do While(1)
  crt.Screen.Send "./media_normalplayer" & chr(13)
  crt.Sleep 10000
  ' Pause
  crt.Screen.Send "2" & chr(13)
  crt.Sleep 3000
  ' Resume
  crt.Screen.Send "3" & chr(13)
  crt.Sleep 5000
  ' Stop
  crt.Screen.Send "1" & chr(13)
  crt.Sleep 2000
  ' restart
  crt.Screen.Send "3" & chr(13)
  crt.Sleep 10000   
  ' Volume down
  For i=1 to 5
   crt.Screen.Send "5" & chr(13)
   crt.Sleep 1000
  Next
  ' Volume up
  For i=1 to 5
   crt.Screen.Send "4" & chr(13)
   crt.Sleep 1000
  Next
  ' Mute
  crt.Screen.Send "6" & chr(13)
  crt.Sleep 5000
  ' Stop
  crt.Screen.Send "0" & chr(13)
  crt.Screen.WaitForString "#"
 Loop
End Sub