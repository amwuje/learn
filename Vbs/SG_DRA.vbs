# $language = "VBScript"
# $interface = "1.0"
'============================================================================================='
'		程序名称：SG_DRA.vbS
'		程序说明：SG/DRA 自动巡检
'		作者：黄彰
'		最后更新时间:20170620
'============================================================================================='

'获取当前日期
dim ystr
dim mstr
dim dstr
dim datem
ystr=year(Now)
mstr=Month(Now)
if len(mstr)<2 then mstr="0"&mstr
dstr=day(Now)
if len(dstr)<2 then dstr="0"&dstr
datem=ystr&"-"&mstr&"-"&dstr
'msgbox(datem)


'保存log
Function writelog(name)
	Dim logfilename
	logfilename ="D:\5020SG\STPDRA巡检\" &datem&"\"& name &".log"
	'MsgBox logfilename
	crt.session.LogFileName = logfilename
	crt.session.Log(true)
End Function

'登录OWP方法一直接通过bat文件调用vbs脚本登录
Function login1(user,pass,ip,tab)
	Set objtab = crt.Session.ConnectInTab("/SSH2 /PASSWORD " &pass& " " &user&"@"&ip,True)
	'nError = Err.Number
	'strErr = Err.Description
	'On Error Goto 0
	objtab.caption =""&tab
	crt.Screen.WaitForStrings "#","$",">"
	crt.Screen.Send ""&chr(13)
	crt.Screen.WaitForStrings "#","$",">"
	crt.Sleep 500
	'crt.Screen.Send "ifconfig"&chr(13)
	'crt.Screen.WaitForStrings "#","$",">"
	'crt.Sleep 500
	'crt.Screen.Send "exit"& chr(13)
	'crt.Screen.WaitForStrings "#","$",">"
	'crt.Sleep 500
End Function

'登录OWP方法二
Function login2(ip)
	crt.Screen.Send("ssh root@" &ip& chr(13))
	crt.Screen.WaitForString "assword:"
	crt.Sleep 500
	crt.Screen.send "5020mgc-12" & chr(13)
	crt.Screen.WaitForStrings "#","$",">"
	crt.Sleep 500
End Function

'SG巡检
Function checkSG(username,passwd,sgip)
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
    crt.Screen.send "dns" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "st -q" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "listalarm" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "alluptime" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "df -kh" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "date" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "ntpq -pn" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "tail -f /var/log/report/report.log" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 15000
    crt.Screen.sendkeys("^c")
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "ls -lrt /var/log/report/MeasReport/"  & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "ls -lrt /var/measfile/Recently/"  & chr(13) 
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "ls -lrt /var/core/itce"  & chr(13) 
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "ls -lrt /opt/tftpboot/ramdisk"  & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "ls -lrt /opt/lxrd/lxroot"  & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
End Function

'HCT巡检
 Function checkHCT
		dim path
		dim my_date
		'path="/var/log/HCT/$(date -d yesterday +%Y-%m-%d)"
		my_date = DatePart("yyyy",(DateAdd("d",-1,date))) & "-" & Right("0" & DatePart("m",(DateAdd("d",-1,date))), 2) & "-" & Right("0" & DatePart("d",(DateAdd("d",-1,date))),2)
		'MsgBox my_date
		path="/var/log/HCT/"& my_date
		'MsgBox path
	crt.Screen.send("cd " &path& chr(13))
	crt.Screen.WaitForStrings "#","$",">"
	crt.Sleep 500
	crt.Screen.send "ls -lrt" & chr(13)
	crt.Screen.WaitForStrings path
	crt.Sleep 500
	crt.Screen.send "cat *summary*.log" & chr(13)
	crt.Screen.WaitForStrings path
	crt.Sleep 500
	crt.Screen.send "cat *unix*.log" & chr(13)
	crt.Screen.WaitForStrings path
	crt.Sleep 500
	crt.Screen.send "cat *s12*.log" & chr(13)
	crt.Screen.WaitForStrings path
	crt.Sleep 500
	crt.Screen.send "cd " & chr(13)
	crt.Screen.WaitForStrings "#","$",">"
	crt.Screen.send "exit"  & chr(13)
	crt.Screen.WaitForStrings "#","$",">"
	crt.Sleep 500
	crt.Screen.send "exit"  & chr(13)
	crt.Screen.WaitForStrings "#","$",">"
	crt.Sleep 500
End Function 

'FES巡检
Function checkFES(username,passwd,fesip)
    crt.Screen.Send("telnet " &fesip& chr(13))
    crt.Screen.WaitForString "ogin:",3
    crt.Sleep 500
    crt.Screen.send username & chr(13) 
    crt.Screen.WaitForString "assword:",3
    crt.Sleep 500
    crt.Screen.send passwd & chr(13)
    crt.Screen.WaitForStrings "#","$",">","main#"
    crt.Sleep 500
    crt.Screen.send "vi ch" & chr(13)
    crt.Screen.WaitForStrings "#","$",">","main#"
    crt.Sleep 500
    crt.Screen.send "vi al ac" & chr(13)
    If crt.Screen.WaitForString ("Continue:",3)=True Then
				crt.Sleep 500
				crt.Screen.send "q" & chr(13)
				crt.Screen.WaitForStrings "#","$",">","main#"
    		crt.Sleep 500
		End If	
		crt.Screen.send " " & chr(13)
    crt.Screen.WaitForStrings "#","$",">","main#"
    crt.Sleep 500
  	crt.Screen.Send "vi spc tdm2h" &chr(13) 
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
    crt.Sleep 500
  	'crt.Screen.Send "vi spc tdm2tdm" &chr(13) 
	'  	Wait= -1
	'  	'MsgBox Wait
	'  	do
	'		crt.Sleep 500
	'		crt.Screen.Send chr(13)
	'		Wait=crt.screen.WaitForString("Continue:", 3)
	'		if Wait= 0 then
	'		exit do
	'		end if 
	'  	loop 
    'crt.Sleep 500	
    crt.Screen.send "vi spc tdm2h nok state" & chr(13)
   	crt.Screen.WaitForStrings "diag:main#"
    crt.Sleep 500
    crt.Screen.send "vi spc monitor" & chr(13)
    crt.Screen.WaitForStrings "diag:main#"
    crt.Sleep 500
    crt.Screen.send "vi over status" & chr(13)
    crt.Screen.WaitForStrings "diag:main#"
    crt.Sleep 500
    crt.Screen.send "vi ver all" & chr(13)
   crt.Screen.WaitForStrings "diag:main#"
    crt.Sleep 500
    crt.Screen.send "vi date" & chr(13)
    crt.Screen.WaitForStrings "diag:main#"
    crt.Sleep 500
    crt.Screen.send "vi clo sta" & chr(13)
    crt.Screen.WaitForStrings "diag:main#"
    crt.Sleep 500
	dim n 
	n=0
	do
		n=n+1
		crt.Screen.send "rexec 1 "&n &" vi clock sync" & chr(13)
		crt.Screen.WaitForStrings "diag:main#",5
		crt.Sleep 500
		if n > 19 then
		exit do
		end if
	loop    
    crt.Screen.send "vi red grou" & chr(13)
    crt.Screen.WaitForStrings "diag:main#"
    crt.Sleep 500
    crt.Screen.send "vi mmgr pool all" & chr(13)
    crt.Screen.WaitForStrings "diag:main#"
    crt.Sleep 500
    crt.Screen.send "vi upt all" & chr(13)
    crt.Screen.WaitForStrings "diag:main#"
    crt.Sleep 500
    crt.Screen.send "vi mod tem all" & chr(13)
    crt.Screen.WaitForStrings "diag:main#"
    crt.Sleep 500
    crt.Screen.send "d vi pif port all" & chr(13)
    crt.Screen.WaitForStrings "diag:main#"
    crt.Sleep 500
    crt.Screen.send "logout" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
End Function

'FLEXMANAGER巡检
Function checkFLEX(username,flexip)
	crt.Screen.Send("telnet " &flexip& chr(13))
	crt.Screen.WaitForString "ogin:"
	crt.Sleep 500
	crt.Screen.send username & chr(13) 
	crt.Screen.WaitForStrings "#","$",">"
	crt.Sleep 500
	crt.Screen.send "faults" & chr(13)
	crt.Screen.WaitForStrings "#","$",">"
	crt.Sleep 500
	crt.Screen.send "faults latched clear" & chr(13)
	crt.Screen.WaitForStrings "#","$",">"
	crt.Sleep 500
	crt.Screen.send "faults clear" & chr(13)
	crt.Screen.WaitForStrings "#","$",">"
	crt.Sleep 500
	crt.Screen.send "fans" & chr(13)
	crt.Screen.WaitForStrings "#","$",">"
	crt.Sleep 500
	crt.Screen.send "hainfo" & chr(13)
	crt.Screen.WaitForStrings "#","$",">"
	crt.Sleep 500
	crt.Screen.send "exit" & chr(13)
	crt.Screen.WaitForStrings "#","$",">"
	crt.Sleep 500
End Function

'S12巡检
Function checkS12(s12ip)
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
	Crt.screen.send "MM" & chr(13)
	Crt.screen.WaitForString ">"
	Crt.Sleep 500
	Crt.screen.send "7599:LKSET=ALL,OPTION=LINK." & chr(13)
	Crt.screen.WaitForString ">"
	Crt.Sleep 500
	Crt.screen.send "AC C" & chr(13)
	Crt.screen.WaitForString ">"
	Crt.Sleep 500
	Crt.screen.send "HRTBL:" & chr(13)
	Crt.screen.WaitForString ">"
	Crt.Sleep 500
	Crt.screen.send "AC D" & chr(13)
	Crt.screen.WaitForString ">"
	Crt.Sleep 500
	Crt.screen.send "HRTBL:" & chr(13)
	Crt.screen.WaitForString ">"
	Crt.Sleep 500
	Crt.screen.send "DAC ALL" & chr(13)
	Crt.screen.WaitForString ">"
	Crt.Sleep 500
	Crt.screen.send ":IDS ALL" & chr(13)
	Crt.screen.WaitForString ">"
	Crt.Sleep 500
	Crt.screen.send "MM" & chr(13)
	Crt.screen.WaitForString ">"
	Crt.Sleep 500
	Crt.screen.send ";" & chr(13)
	Crt.screen.WaitForString ">"
	Crt.Sleep 500
	Crt.Screen.sendkeys("^]")
	Crt.screen.WaitForString ">"
	Crt.Sleep 500
	Crt.screen.send "quit" & chr(13)
End Function

Function HFL6
	writelog "安徽省合肥市HFL6网元"&Month(Now)&"月份-SG"
	login1 "root","5020mgc-12","10.225.80.104","HFL6"		'登录OWP，如果是再OWP上运行脚本，则不需要这一步，加单引号
	checkSG "root","Spat705@1","10.225.80.100"
	crt.session.Log(false)
	writelog "3安徽移动L6"
	checkHCT
	crt.session.Log(false)
	writelog "安徽省合肥市HFL6网元"&Month(Now)&"月份-FES"
	checkFES "diag","-assured","172.16.110.3"
	checkFES "diag","-assured","172.16.110.4"
	'checkFES "diag","-assured","172.16.110.5"
	crt.session.Log(false)
	writelog "安徽省合肥市HFL6网元"&Month(Now)&"月份-FLEXMANAGER"
	checkFLEX "admin","172.16.101.101"
	checkFLEX "admin","172.16.101.102"
	checkFLEX "admin","172.16.101.105"
	checkFLEX "admin","172.16.101.106"
	crt.session.Log(false)
	writelog "安徽省合肥市HFL6网元"&Month(Now)&"月份-S12"
	checkS12 "172.16.64.0"
	crt.session.Log(false)
	crt.session.Disconnect
End Function

Function HFH2
	writelog "安徽省合肥市HFH2网元"&Month(Now)&"月份-SG"
	login1 "root","5020mgc-12","10.1.207.28","HFH2"		'登录OWP，如果是再OWP上运行脚本，则不需要这一步，加单引号
	checkSG "root","Spat705!1","10.1.207.20"
	crt.session.Log(false)
	writelog "2安徽移动H2"
	checkHCT
	crt.session.Log(false)
	writelog "安徽省合肥市HFH2网元"&Month(Now)&"月份-FES"
	checkFES "diag","-assured","172.16.110.3"
	checkFES "diag","-assured","172.16.110.4"
	checkFES "diag","-assured","172.16.110.5"
	crt.session.Log(false)
	writelog "安徽省合肥市HFH2网元"&Month(Now)&"月份-FLEXMANAGER"
	checkFLEX "admin","172.16.101.101"
	checkFLEX "admin","172.16.101.102"
	checkFLEX "admin","172.16.101.105"
	checkFLEX "admin","172.16.101.106"
	crt.session.Log(false)
	writelog "安徽省合肥市HFH2网元"&Month(Now)&"月份-S12"
	checkS12 "172.16.64.0"
	crt.session.Log(false)
	crt.session.Disconnect
End Function

Function HSTPA
	writelog "安徽省合肥市HSTPA网元"&Month(Now)&"月份-SG"
	login1 "root","5020mgc-12","134.96.47.14","HSTPA"		'登录OWP，如果是再OWP上运行脚本，则不需要这一步，加单引号
	checkSG "root","softswitch","134.96.47.6"
	crt.session.Log(false)
	writelog "1安徽联通HSTP"
	checkHCT
	crt.session.Log(false)
	writelog "安徽省合肥市HSTPA网元"&Month(Now)&"月份-FES"
	checkFES "diag","-assured","134.96.47.8"
	checkFES "diag","-assured","134.96.47.9"
	crt.session.Log(false)
	writelog "安徽省合肥市HSTPA网元"&Month(Now)&"月份-FLEXMANAGER"
	checkFLEX "admin","172.16.101.101"
	checkFLEX "admin","172.16.101.102"
	checkFLEX "admin","172.16.101.105"
	checkFLEX "admin","172.16.101.106"
	checkFLEX "admin","172.16.101.109"
	checkFLEX "admin","172.16.101.110"
	crt.session.Log(false)
	writelog "安徽省合肥市HSTPA网元"&Month(Now)&"月份-S12"
	checkS12 "172.16.64.0"
	crt.session.Log(false)
	crt.session.Disconnect
End Function

Function HFLDRA1
	writelog "安徽省合肥市HFLDRA01网元"&Month(Now)&"月份-SG"
	login1 "root","5020mgc-12","10.225.218.24","HFLDRA01"		'登录OWP，如果是再OWP上运行脚本，则不需要这一步，加单引号
	checkSG "alausr","Chji826@1","10.225.218.21"
	crt.session.Log(false)
	writelog "4安徽移动LDRA1"
	checkHCT
	crt.session.Log(false)
	crt.session.Disconnect
End Function

Function HFLDRA2
	writelog "安徽省合肥市HFLDRA02网元"&Month(Now)&"月份-SG"
	login1 "root","5020mgc-12","10.225.218.24","HFLDRA02"		'登录OWP，如果是再OWP上运行脚本，则不需要这一步，加单引号
	checkSG "alausr","Chji826@1","10.225.218.38"
	crt.session.Log(false)
	writelog "5安徽移动LDRA2"
	checkHCT
	crt.session.Log(false)
	crt.session.Disconnect
End Function

Sub Main
	if crt.session.Log(ture)=Ture then
	crt.session.Log(false)
	end if
	HFH2
	crt.Sleep 1000
	HFL6
	crt.Sleep 1000
	'HSTPA
	'crt.Sleep 1000
	HFLDRA1
	crt.Sleep 1000
	HFLDRA2
	crt.Sleep 1000
	crt.Screen.Synchronous = false 
	crt.Quit
End Sub 