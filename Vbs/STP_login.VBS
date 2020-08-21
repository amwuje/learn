# $language = "VBScript"
# $interface = "1.0"
'============================================================================================='
'		程序名称：S12.vbS
'		程序说明：S12自动登录脚本
'		作者：黄彰
'		最后更新时间:20170628
'============================================================================================='
'获取当前日期时间
dim ystr
dim mstr
dim dstr
dim datem
Dim CurrentTime
dim Tim
ystr=year(Now)
mstr=Month(Now)
if len(mstr)<2 then mstr="0"&mstr
dstr=day(Now)
if len(dstr)<2 then dstr="0"&dstr
CurrentTime=Hour(Now)&":"&Minute(Now)&":"&Second(Now)
Tim = CurrentTime 	
datem=ystr&"-"&mstr&"-"&dstr&"_"&Tim
'msgbox(dateml)

'保存log
Function writelog(name)
	Dim logfilename
	logfilename ="E:\" & name &".log"
	'MsgBox logfilename
	crt.session.LogFileName = logfilename
	crt.session.Log(true)
End Function

'登录OWP方法一直接通过bat文件调用vbs脚本登录
Function owplogin(user,pass,ip,tab)
	Set objtab = crt.Session.ConnectInTab("/SSH2 /PASSWORD " &pass& " " &user&"@"&ip,True)
	objtab.caption =""&tab
	crt.Screen.WaitForStrings "#","$",">"
	crt.Screen.Send ""&chr(13)
	crt.Screen.WaitForStrings "#","$",">"
	crt.Sleep 500
End Function

Function sglogin(username,passwd,sgip)
    crt.Screen.Send("telnet " &sgip& chr(13))
    crt.Screen.WaitForString "ogin:"
    crt.Sleep 500
    crt.Screen.send username & chr(13) 
    crt.Screen.WaitForString "assword:"
    crt.Sleep 500
    crt.Screen.send passwd & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "smv" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
End Function

Function s12login(s12ip)
	dim psw
	psw=1
	crt.Screen.Send("telnet " &s12ip& chr(13))
	crt.screen.WaitForString "COMMAND."
	crt.Sleep 500
	'set WshShell = CreateObject("WScript.Shell")
	'WshShell.SendKeys "{ESC}"
	Crt.Screen.sendkeys("^c")
	crt.screen.WaitForString "USERID"
	crt.Sleep 500
	crt.screen.send "PSW00"&psw&";"
	crt.screen.WaitForString "PASSWORD"
	crt.Sleep 500
	crt.screen.send "PSW00"&psw&";"
	dim Wait
	Wait=crt.screen.WaitForString("LOGGED ON", 3)
	if Wait=-1 then
		do
		psw=psw+1
		crt.screen.sendkeys("^c")
		crt.screen.WaitForString "USERID"
		crt.Sleep 500
		crt.screen.send "PSW00"&psw&";"
		crt.screen.WaitForString "PASSWORD"
		crt.Sleep 500
		crt.screen.send "PSW00"&psw&";"
		Wait=crt.screen.WaitForString("LOGGED ON", 3)
			if Wait=0 then
			exit do
			end if
		loop
	end if	
	crt.screen.send "417."
	crt.screen.WaitForString ">"
	crt.Sleep 500
	crt.screen.send "CFDB" & chr(13)
	crt.screen.WaitForString ">"
	crt.Sleep 500
	crt.screen.send "SET PSW" & chr(13)
	crt.screen.WaitForString "USERID"
	crt.Sleep 500
	crt.screen.send "PSW00"&psw & chr(13)
	crt.screen.WaitForString "PASSWORD"
	crt.Sleep 500
	crt.screen.send "PSW00"&psw & chr(13)
	crt.screen.WaitForString ">"
	crt.Sleep 500
	Crt.screen.send "MM" & chr(13)
	Crt.screen.WaitForString ">"
	Crt.Sleep 500
	Crt.screen.send "19." & chr(13)
	Crt.screen.WaitForString ">"
	Crt.Sleep 500
End Function

Function HFH2
	dim continue
	writelog "HFH2_"&datem
	owplogin"root","5020mgc-12","10.1.207.28","HFH2"
	sglogin"root","Spat705!1","10.1.207.20"
	If Msgbox("是否登录S12？",vbyesno + vbQuestion +vbdefaultbutton2,"S12登录")=vbyes then
	s12login"172.16.64.0"
	Else
	crt.Screen.Synchronous = false
	End if
	
End Function

Sub Main 
	if crt.session.Log(ture)=Ture Then
		crt.session.Log(false)
	else
		HFH2
	end if
	HFH2
	'crt.Screen.Synchronous = false 
	'crt.Quit
End Sub 
