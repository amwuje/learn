#$language = "VBScript"
#$interface = "1.0"
Sub main
	' turn on synchronous mode so we don't miss any data
	crt.Screen.Synchronous = True
	crt.session.Connect("/telnet 10.0.0.1")
	crt.Screen.WaitForString "BJ_S1> (enable)"
	crt.Screen.Send "show spantree 31 " & VbCr
	Do while (crt.Screen.WaitForString("--More--",3)<>False)
		crt.Screen.Send " "
	Loop
	crt.Screen.Send "show spantree 32" & VbCr
	Do while (crt.Screen.WaitForString("--More--",3)<>False)
		crt.Screen.Send " "
	Loop
End sub
