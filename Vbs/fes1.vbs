#$language = "VBScript"
#$interface = "1.0"
  
  crt.Screen.Synchronous = True
  crt.Screen.WaitForString "#]" 
  crt.Screen.Send "telnet 172.16.110.3"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "Login:"  
  crt.Screen.Send "diag"   & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "Password:" 
  crt.Screen.Send "-assured"   & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi spc tdm2h" &chr(13) 
  crt.Sleep 500
  dim Wait
  Wait= -1
  'MsgBox Wait
  do
  crt.Sleep 500
	crt.Screen.Send chr(13)
	Wait=crt.screen.WaitForString("Continue:", 3)
	if Wait= 0 then
	exit do
	end if 
  loop 
    crt.Screen.Send "vi ch" &chr(13)  

  crt.Screen.Synchronous = False  