# $language = "VBScript"
# $interface = "1.0"
'============================================================================================='
'		程序名称：ZDTJ.vbS
'		程序说明：SG/DRA 自动统计
'		作者：黄彰
'		最后更新时间:20190219
'============================================================================================='

'获取当前日期
'获取前一天日期
    Dim y, m, d, h, mm, s,dateFormat    
    y = Year(now)
    m = Month(now)
    d = Day(now)-1
    h = Hour(now)
    mm = Minute(now)
    s = Second(now)   
    If Len(m) = 1 Then
        m = "0" & m
    End If
    If Len(d) = 1 Then
        d = "0" & d
    End If
    If Len(h) = 1 Then
        h = "0" & h
    End If
    If Len(mm) = 1 Then
        mm = "0" & mm
    End If
    If Len(s) = 1 Then
        s = "0" & s
    End If    
		dateFormat1 = y & m & d   
		dateFormat2 = y &"-"& m &"-"&d  '把指定的日期格式转换为：YY-MM-DD-hh-mm-ss
		'crt.Dialog.MessageBox dateFormat1
'获取当前脚本文件路径
	Dim fileSystemObject,currPath
  Set fileSystemObject = CreateObject("Scripting.FileSystemObject")
  currPath = fileSystemObject.getFolder(".").Path		' 获取当前文件路径
	'crt.Dialog.MessageBox currPath	

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


'log保存
Function writelog(name)
	Dim logfilename
	logfilename =currPath&"\" &dateFormat2&"_"&name &".log"
	'MsgBox logfilename
	crt.session.LogFileName = logfilename
	crt.session.Log(true)
End Function


'P6_GT写入统计结果
Function writeGT_p6(xm,wy)
	screenrow=crt.screen.CurrentRow-2
	crt.Sleep 1000
	GT = crt.Screen.Get(screenrow,10,screenrow,18)
	Dim fso, f1
		Set fso = CreateObject("Scripting.FileSystemObject")
		Set f1 = fso.OpenTextFile(currPath&"\" &dateFormat2&"_Total.txt", 8,True)
		f1.writeline(wy&"   |SCCP|"&GT&"|")
		f1.close
	'crt.Dialog.MessageBox getscreen
End Function

'P12_GT写入统计结果
Function writeGT_p12(xm,wy)
	screenrow=crt.screen.CurrentRow-3
	crt.Sleep 1000
	MSGRECV= crt.Screen.Get(screenrow,18,screenrow,27)
	SCCPRECV= crt.Screen.Get(screenrow,55,screenrow,63)
	Dim fso, f1
		Set fso = CreateObject("Scripting.FileSystemObject")
		Set f1 = fso.OpenTextFile(currPath&"\" &dateFormat2&"_Total.txt", 8,True)
		f1.writeline(wy&"   |MSGRECV|"&MSGRECV&"|SCCPRECV|"&SCCPRECV&"|")
		f1.close
	'crt.Dialog.MessageBox getscreen
End Function

'P6_T3写入统计结果
Function writeT3_p6(xm,wy)
	screenrow=crt.screen.CurrentRow-1
	crt.Sleep 1000
	LKSET = crt.Screen.Get(screenrow,1,screenrow,15)
	SLC   = crt.Screen.Get(screenrow,25,screenrow,29)
	TY  = crt.Screen.Get(screenrow,56,screenrow,60)
	TXLOAD = crt.Screen.Get(screenrow,83,screenrow,92)
	RXLOAD = crt.Screen.Get(screenrow,114,screenrow,122)
	TOTAL  = crt.Screen.Get(screenrow,123,screenrow,132)
	Dim fso, f1
		Set fso = CreateObject("Scripting.FileSystemObject")
		Set f1 = fso.OpenTextFile(currPath&"\" &dateFormat2&"_Total.txt", 8,True)
		f1.writeline(wy&"   "&LKSET&SLC&TY&TXLOAD&RXLOAD&TOTAL)
		f1.close
	'crt.Dialog.MessageBox getscreen
End Function

'P12_T3写入统计结果
Function writeT3_p12(xm,wy)
	screenrow=crt.screen.CurrentRow-1
	crt.Sleep 1000
	LKSET = crt.Screen.Get(screenrow,1,screenrow,21)
	SLC   = crt.Screen.Get(screenrow,21,screenrow,25)
	TY  = crt.Screen.Get(screenrow,55,screenrow,58)
	TXLOAD = crt.Screen.Get(screenrow,81,screenrow,90)
	RXLOAD = crt.Screen.Get(screenrow,112,screenrow,121)
	TOTAL  = crt.Screen.Get(screenrow,121,screenrow,130)
	Dim fso, f1
		Set fso = CreateObject("Scripting.FileSystemObject")
		Set f1 = fso.OpenTextFile(currPath&"\" &dateFormat2&"_Total.txt", 8,True)
		f1.writeline(wy&"   "&LKSET&SLC&TY&TXLOAD&RXLOAD&TOTAL)
		f1.close
	'crt.Dialog.MessageBox getscreen
End Function

'写入alarm结果
Function writeAlarm(xm,wy)
	screenrow=crt.screen.CurrentRow
	crt.Sleep 1000
	getscreen = crt.Screen.Get2(screenrow1-1,1,screenrow1,150)
	Dim fso, f1
		Set fso = CreateObject("Scripting.FileSystemObject")
		Set f1 = fso.OpenTextFile(currPath&"\" &dateFormat2&"_Alarm.txt", 8,True)
		f1.writeline(getscreen)
		f1.close
	'crt.Dialog.MessageBox getscreen
End Function

'DRA MSG写入统计结果
Function writeMSG_DRA(xm,wy)
	screenrow=crt.screen.CurrentRow-6
	crt.Sleep 1000
	RCV_MPS = crt.Screen.Get(screenrow,93,screenrow,99)
	MPS_Rate = crt.Screen.Get(screenrow,133,screenrow,135)
	Dim fso, f1
		Set fso = CreateObject("Scripting.FileSystemObject")
		Set f1 = fso.OpenTextFile(currPath&"\" &dateFormat2&"_Total.txt", 8,True)
		f1.writeline(wy&"   |RCV_MPS|"&RCV_MPS&"|MPS_Rate|"&MPS_Rate&"|")
		f1.close
	'crt.Dialog.MessageBox getscreen
End Function

'DRA 最高CPU 链路负荷写入统计结果
Function writemax_DRA(xm,wy)
	screenrow=crt.screen.CurrentRow-1
	crt.Sleep 1000
	getscreen = crt.Screen.Get(screenrow,1,screenrow,130)
	Dim fso, f1
		Set fso = CreateObject("Scripting.FileSystemObject")
		Set f1 = fso.OpenTextFile(currPath&"\" &dateFormat2&"_Total.txt", 8,True)
		f1.writeline(wy&"   |"&getscreen)
		f1.close
	'crt.Dialog.MessageBox getscreen
End Function

Function t3_p6
    crt.Screen.Send "t3_p6_v2.py "& chr(13)
    crt.Screen.WaitForString "-->"
    crt.Sleep 500
    crt.Screen.send "c" & chr(13) 
    crt.Screen.WaitForString "-->"
    crt.Sleep 500
    crt.Screen.send "d,"&dateFormat2&"-1100" & chr(13) 
    crt.Screen.WaitForString ")"
    crt.Sleep 500
    crt.Screen.send "n" & chr(13)
    crt.Screen.WaitForString "-->"
    crt.Sleep 500
    crt.Screen.send "q" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
End Function

'SG_P6
Function totalSG(wy,username,passwd,sgip)
    crt.Screen.Send "telnet " &sgip& chr(13)
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
    t3_p6
    crt.Sleep 500
    crt.Screen.send "cat /var/log/report/MeasReport/Meas-"&dateFormat2&"-11*.log | grep -i TAB09C05 -A 3 -B 8" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    writeGT_p6 "GT",wy
    crt.Screen.send "sort -t'|' -k14n /var/measfile/traffic/T3_Result_"&dateFormat2&"-1100_All |grep 64k" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    writeT3_p6 "T3",wy
    crt.Screen.send "sort -t'|' -k14n /var/measfile/traffic/T3_Result_"&dateFormat2&"-1100_All |grep 2m" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    writeT3_p6 "T3",wy
    crt.Screen.send  chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.session.Log(false)
		writelog wy
    crt.Screen.send "listalarm" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1000
End Function

'SG_P12
Function P12totalSG(wy,username,passwd,sgip)
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
    crt.Screen.send "n7count.sh "&dateFormat1&".10" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    writeGT_p12 "GT",wy
    crt.Screen.send "/usr/local/sbin/gt_t3_tool/t3.exe -f 3-N7LINK_"&dateFormat1&".101500.csv" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "sort -t'|' -k13n /var/measfile/traffic/"&dateFormat1&".101500.txt  |grep 64K" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    writeT3_p12 "T3",wy
    crt.Screen.send "sort -t'|' -k13n /var/measfile/traffic/"&dateFormat1&".101500.txt  |grep 2M" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    writeT3_p12 "T3",wy
    crt.Screen.send  chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.session.Log(false)
		writelog wy
    crt.Screen.send "listalarm" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1000
End Function

'DRA_P12
Function totalDRA(wy,username,passwd,sgip)
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
    crt.Screen.send "countsum.sh "&dateFormat1&".17" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1000
    writeMSG_DRA "MSG",wy
    crt.Screen.send "sort -t, -k3n /var/measfile/Recently/2-DIAMCPU_"&dateFormat1&".174500.csv" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1000
    writemax_DRA "CPU",wy
    crt.Screen.send "sort -t, -k14n /var/measfile/Recently/4-DIAMLINK_"&dateFormat1&".174500.csv" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    writemax_DRA "LINK",wy
    crt.Screen.send  chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.session.Log(false)
		writelog wy
    crt.Screen.send "listalarm" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1000
End Function

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
	Crt.screen.send "7599:lkset=all,option=link." & chr(13)
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
	login1 "root","5020mgc-12","10.225.80.104","HFL6"		'登录OWP，如果是再OWP上运行脚本，则不需要这一步，加单引号
	totalSG "HFL6","alausr","Chji826@1","10.225.80.100"
	checkS12 "172.16.64.0"
	crt.session.Disconnect
End Function

Function HFH2
	login1 "root","5020mgc-12","10.1.207.28","HFH2"
	totalSG "HFH2","alausr","Chji826!1","10.1.207.20"
	checkS12 "172.16.64.0"
	crt.session.Disconnect
End Function

Function HFL7
	login1 "root","5020mgc-12","10.225.212.33","HFL7"		'登录OWP，如果是再OWP上运行脚本，则不需要这一步，加单引号
	P12totalSG "HFL7","alausr","Chji826@1","10.225.212.36"
	crt.session.Disconnect
End Function

Function HNAL8
	login1 "root","5020mgc-12","10.225.191.242","HNAL8"		'登录OWP，如果是再OWP上运行脚本，则不需要这一步，加单引号
	P12totalSG "HNAL8","alausr","Chji826@1","10.225.191.243"
	crt.session.Disconnect
End Function

Function HFLDRA1
	login1 "root","5020mgc-12","10.225.218.24","HFLDRA01"		'登录OWP，如果是再OWP上运行脚本，则不需要这一步，加单引号
	totalDRA "HFDRA01","alausr","Chji826@1","10.225.218.21"
	crt.session.Disconnect
End Function

Function HFLDRA2
	login1 "root","5020mgc-12","10.225.218.24","HFLDRA02"		'登录OWP，如果是再OWP上运行脚本，则不需要这一步，加单引号
	totalDRA "HFDRA02","alausr","Chji826@1","10.225.218.38"
	crt.session.Disconnect
End Function

Sub Main
	if crt.session.Log(Ture)=Ture then
		 crt.session.Log(false)
	end if
	HFH2
	crt.Sleep 1000
	HFL6
	crt.Sleep 1000
	HFL7
	crt.Sleep 1000
	HNAL8
	crt.Sleep 1000
	HFLDRA1
	crt.Sleep 1000
	HFLDRA2
	crt.Sleep 1000
	crt.Screen.Synchronous = false 
	crt.Quit
End Sub 