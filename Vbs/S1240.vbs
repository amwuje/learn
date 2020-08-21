# $language = "VBScript"
# $interface = "1.0"
crt.Screen.Synchronous=True

Function login2(user,pass,ip,,port,tab)
	'Set objtab = crt.Session.ConnectInTab("/SSH2 /PASSWORD " &pass& " " &user&"@"&ip,True)
	Set objtab = crt.session.ConnectInTab("/telnet 10.147.76.50 951")
	'nError = Err.Number
	'strErr = Err.Description
	'On Error Goto 0
	objtab.caption =""&tab
	crt.Screen.WaitForStrings "#","$",">"
	crt.Screen.Send ""&chr(13)
	crt.Screen.WaitForStrings "#","$",">"
	crt.Sleep 500
End Function

Sub Main 
	if crt.session.Log(ture)=Ture then
	crt.session.Log(false)
	end if
	login2
	crt.Screen.Synchronous = false 
	'crt.Quit
End Sub 