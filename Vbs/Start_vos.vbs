# $language = "VBScript"
# $interface = "1.0"

crt.Screen.Synchronous=True

Sub Main
	On Error Resume Next
	Dim result
	If crt.Session.Connected Then crt.Session.Disconnect
	'connected to the '10.1.207.20'
	Set objtab = crt.Session.ConnectInTab("/SSH2 /PASSWORD 5020mgc-12 root@10.1.207.28",True)
	'Capture error code and description (if any)
	nError = Err.Number
	strErr =Err.Description
	'Now,tell the script host that it should handle errors as usual now:
	On Error Goto 0
	'change tab name
	objtab.caption = "Gdb_vos"
	'enter the folder
	crt.Screen.Send "cd /home/" & chr(13)
End Sub	
	