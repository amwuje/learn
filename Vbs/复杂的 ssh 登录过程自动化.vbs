#$language = "VBScript"
#$interface = "1.0"

Sub main
	' Constant used by OpenTextFile()
	Const ForReading = 1
	' Open a file, read it in & send it one line at a time
	Dim fso, f, passwd
	Set fso = CreateObject("Scripting.FileSystemObject")
	' 请把密码保存在这个文件里，注意修改为自己的路径
	Set f = fso.OpenTextFile("C:\Users\Jun\Desktop\passwd.txt", ForReading, 0)
	do While f.AtEndOfStream <> True
	    ' Read each line of the printers file.
	    passwd = f.Readline
	    Exit Do
	loop
	
	' Get ipAddress from current tabName
	caption = crt.window.caption
	Set re = New RegExp
	re.Global = True
	re.IgnoreCase = True
	re.MultiLine = True
	key = "(?:1?\d?\d|2[0-4]\d|25[0-5])"
	re.Pattern = "\b" & key & "\." & key & "\." & key & "\." & key & "\b"
	set ex = re.Execute(caption)
	For Each e In ex
		'str = str & e & vbCrLf
		ipv4 = e
		Exit For
	Next
	
	' Debug
	'PrintResult(crt.Dialog.MessageBox("Login Succ..."))
	
	' turn on synchronous mode so we don't miss any data
	crt.Screen.Synchronous = True
	
	' Wait for a string that looks like "login: " or "Login: "
	crt.Screen.WaitForString "ogin:"
	' Send your cmd or data followed by a carriage return
	crt.Screen.Send "ssh work@" & ipv4 & VbCr
	
	crt.Screen.WaitForString "ermission :"
	crt.Screen.Send "2" & VbCr
	
	crt.Screen.WaitForString "kerberos password :"
	crt.Screen.Send passwd & VbCr
	
	'crt.Screen.WaitForString "assword:"
	'crt.Screen.Send "2" & VbCr
	
	' turn off synchronous mode to restore normal input processing
	crt.Screen.Synchronous = False
End Sub