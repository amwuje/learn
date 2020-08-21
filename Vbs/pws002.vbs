Sub Main
crt.screen.WaitForString "#"
crt.screen.send "telnet 172.16.64.0" & VbCr
crt.screen.WaitForString "COMMAND."
set WshShell = CreateObject("WScript.Shell")
WshShell.SendKeys "{ESC}"
crt.screen.WaitForString "<"
crt.screen.send "PSW002;"
crt.screen.WaitForString "<"
crt.screen.send "DHH#002;"
crt.screen.WaitForString "<"
crt.screen.send "417."
crt.screen.WaitForString ">"
crt.screen.send "CFDB" & VbCr
crt.screen.WaitForString ">"
crt.screen.send "SET PSW" & VbCr
crt.screen.WaitForString ">"
crt.screen.send "PSW002" & VbCr
crt.screen.WaitForString ">"
crt.screen.send "DHH#002" & VbCr
crt.screen.WaitForString ">"
crt.screen.send "MM" & VbCr
End Sub