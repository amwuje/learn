#$language = "VBScript"
#$interface = "1.0"
 
crt.Screen.Synchronous = True
 
' This automatically generated script may need to be
' edited in order to work correctly.
 
Sub Main
         Dim i
         i = 10
         Do While i > 0
                   crt.Screen.Send "df" & chr(13)
                   crt.Screen.WaitForStrings "#","$",">"
                   crt.Screen.Send "echo ok" & chr(13)
                   crt.Screen.WaitForStrings "#","$",">"          
                   crt.Sleep 1000
                   i=i-1
         Loop
End Sub