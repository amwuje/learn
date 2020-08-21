#$language = "VBScript"
#$interface = "1.0"

for i=1 to 2
  Set CurrentTab = crt.GetTab(i)
  CurrentTab.Activate
  If CurrentTab.Session.connected = True Then
    'send ping command and return carriage
    CurrentTab.Screen.Send "ping -c " & i & " 127.0.0.1 " & vbCr     
    crt.Sleep 5000
    CurrentTab.Screen.Send Chr(26)  'send ctrl+z
  End if
Next