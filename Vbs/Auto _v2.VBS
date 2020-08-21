# $language = "VBScript"
# $interface = "1.0"
' =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  = '
'		程序名称：Auto.vbS
'		程序说明：SG/DRA 自动统计
'		作者：黄彰
'		最后更新时间:20190416
'		20190315 新增原始统计log文件保存
'		20190315 新增原始统计输出可以选择路径
'   20190416 新增P6版 alluptime命令查看板卡运行状态
'		20191010 优化统计值获取脚本
'		20191010 新增输出统计直接为csv文件，统计类容增加，跟详细。
' =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  = '

'获取前一天日期
    Dim y, m, d, h, mm, s,dateFormat
    my_date1 = DateAdd("d", -1, Date)
		my_date2 = DateAdd("d", -0, Date)    
    y = DatePart("yyyy",my_date1)
    m = Right("0" & DatePart("m",my_date1),2)
    d1  = Right("0" & DatePart("d",my_date1),2)
    d2  = Right("0" & DatePart("d",my_date2),2)
    h = Hour(now)
    mm = Minute(now)
    s = Second(now)   
    If Len(m) = 1 Then
        m = "0" & m
    End If
    If Len(d1) = 1 Then
        d1 = "0" & d1
    End If
    If Len(d2) = 1 Then
        d2 = "0" & d2
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
'当前时间的前一天并且格式转换为：YYMMDD
		dateFormat1 = y & m & d1   
'当前时间的前一天并且格式转换为：YY-MM-DD
		dateFormat2 = y &"-"& m &"-"&d1  '把指定的日期格式转换为：YY-MM-DD-hh-mm-ss
'当前时间并且格式转换为：YYMMDDhh
		dateFormat3 = y & m & d2 & h

	'Msgbox dateFormat1
	'Msgbox dateFormat2
	'Msgbox dateFormat3

'获取当前脚本文件路径
	Dim fileSystemObject,currPath,strPath
  	Set fileSystemObject = CreateObject("Scripting.FileSystemObject")	
	'currPath = fileSystemObject.getFolder(".").Path		' 获取当前脚本所在路径
	'strPath = BrowseForFolder("Please select a directory:")  '弹出对话框选择统计输出路径
	currPath = "D:\5020SG\AutoTotal"	' 手动定义文件路径
	'currPath = strPath
	'crt.Dialog.MessageBox currPath	
	'Msgbox "你选的位置是：" & vbCrLf & strPath
' 创建结果文件目录
	If(fileSystemObject.FolderExists(currPath &"\" &dateFormat2) = False) Then	' 创建结果文件目录
		fileSystemObject.createFolder(currPath &"\" &dateFormat2)
	End If


' 浏览文件夹
Function BrowseForFolder(ByVal strTips)
  Dim objFolder
  Set objFolder = CreateObject("Shell.Application").BrowseForFolder (&H0, strTips, &H0010 + &H0001)
  If (Not objFolder Is Nothing) Then BrowseForFolder = objFolder.Self.Path  'objFolder.Items().Item().Path
End Function



'定义Total, Alarm LOG路径
	dim draFile,draFile1,stpFile,stpFile1,fileAlarm
	draFile = currPath&"\DRA_Total.CSV"
	draFile1 = currPath&"\"&dateFormat2&"_DRA_Total.CSV"
	'draFile1 = currPath&"\" &dateFormat2&"\"&dateFormat2&"_DRA_Total.CSV"
	stpFile = currPath&"\STP_Total.CSV"
	stpFile1 = currPath&"\" &dateFormat2&"\"&dateFormat2&"_STP_Total.CSV"
	fileAlarm = currPath&"\" &dateFormat2&"\"&dateFormat2&"_"
	fileTmp = currPath&"\" &dateFormat2&"\Tmp\"&dateFormat2&"_"


'定义Total获取命令脚本
	dim P6_SCCP,P6_LINK64K,P6_LINK2M
	dim P12_SCCP,P12_LINK64K,P12_LINK2M
	dim msgsum,cpusum,linksum
	P6_SCCP = "cat /var/log/report/MeasReport/Meas-"&dateFormat2&"-11*.log | grep -i TAB09C05 -A 3 -B 8 |cut -d* -f 1 |sed -n 11p |sed 's/ //g'"
	P6_LINK64K = "sort -t'|' -k14n /var/measfile/traffic/T3_Result_"&dateFormat2&"-1100_All |grep 64k |cut -d'|' -f 2,4,7,10,13,14 |tail -n 1 |sed 's/|/,/g' |sed 's/ //g'"
	P6_LINK2M = "sort -t'|' -k14n /var/measfile/traffic/T3_Result_"&dateFormat2&"-1100_All |grep 2m |cut -d'|' -f 2,4,7,10,13,14 |tail -n 1 |sed 's/|/,/g'  |sed 's/ //g'"

	P12_SCCP = "n7count.sh "&dateFormat1&".10 |cut -d, -f 2,5  |sort -t, -k1n |tail -n 1 |sed 's/ //g'"
	P12_LINK64K = "sort -t'|' -k13n /tmp/t3/"&dateFormat1&".101500.txt  |grep 64K |cut -d'|' -f 2,3,6,9,12,13 |tail -n 1 |sed 's/|/,/g' |sed 's/ //g'|sed 's/P64K/64k/g'"
	P12_LINK2M = "sort -t'|' -k13n /tmp/t3/"&dateFormat1&".101500.txt  |grep 2M |cut -d'|' -f 2,3,6,9,12,13 |tail -n 1 |sed 's/|/,/g' |sed 's/ //g'|sed 's/P2M/2m/g'"

	msgsum = "countsum.sh "&dateFormat1&".17|cut -d, -f 7,8,11  |sort -t, -k1n |tail -n 1 |sed 's/ //g'"
	cpusum = "cat /var/measfile/Recently/2-DIAMCPU_"&dateFormat1&".174500.csv | sort -t, -k2n |tail -n 1 |sed 's/ //g'"
	linksum = "cat /var/measfile/Recently/4-DIAMLINK_"&dateFormat1&".174500.csv | cut -d, -f 1,14,15 | sort -t, -k2n |tail -n 1 |sed 's/ //g'"


'登录OWP方法一直接通过bat文件调用vbs脚本登录
Function login1(user,pass,ip,tab)
	Set objtab = crt.Session.ConnectInTab("/SSH2 /PASSWORD " &pass& " " &user&"@"&ip,True)
	'nError = Err.Number
	'strErr = Err.Description
	'On Error Goto 0
	objtab.caption  = ""&tab
	crt.Screen.WaitForStrings "#","$",">"
	crt.Screen.Send ""&chr(13)
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

'原始统计文件保存
Function writeTmp(wy,name)
	Dim logfilename
	'logfilename  = currPath&"\" &dateFormat2&"_"&name &".log"
	'MsgBox logfilename
	crt.session.LogFileName = fileTmp&wy&"_"&name &".txt"
	crt.session.Log(true)
End Function

'告警保存
Function writelog(name)
	Dim logfilename
	'logfilename  = currPath&"\" &dateFormat2&"_"&name &".log"
	'MsgBox logfilename
	crt.session.LogFileName = fileAlarm&name &".log"
	crt.session.Log(true)
End Function


'写入alarm结果
Function writeAlarm(xm,wy)
	screenrow = crt.screen.CurrentRow
	crt.Sleep 1000
	getscreen = crt.Screen.Get2(screenrow1-1,1,screenrow1,150)
	Dim fso, f1
		Set fso = CreateObject("Scripting.FileSystemObject")
		Set f1 = fso.OpenTextFile(fileTotal, 8,True)
		f1.writeline(getscreen)
		f1.close
	'crt.Dialog.MessageBox getscreen
End Function

'DRA 写入统计结果
Function write_DRA(draTotal,wy)
	Dim fso, f1
		Set fso = CreateObject("Scripting.FileSystemObject")
		Set f1 = fso.OpenTextFile(draFile, 8,True)
		'f1.writeline("Name,Time,RCV_MPS,SND_MPS,MPS_Rate,Diam_Name,AVRGLOAD,PEAKLOAD,Link_Name,AVRGRECV,PEAKRECV")
		f1.writeline(draTotal)
		f1.close
	'crt.Dialog.MessageBox getscreen
End Function

'STP 写入统计结果
Function write_STP(stpTotal,wy)
	Dim fso, f1
		Set fso = CreateObject("Scripting.FileSystemObject")
		Set f1 = fso.OpenTextFile(stpFile, 8,True)
		'f1.writeline("Name,Time,RCV_MPS,SND_MPS,MPS_Rate,Diam_Name,AVRGLOAD,PEAKLOAD,Link_Name,AVRGRECV,PEAKRECV")
		f1.writeline(stpTotal)
		f1.close
	'crt.Dialog.MessageBox getscreen
End Function

'DRA 最高CPU 链路负荷写入统计结果


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
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send  chr(13)
    crt.Screen.WaitForStrings "#","$",">"
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
    crt.session.Log(false)
		writeTmp wy,"GT"
    crt.Screen.send "cat /var/log/report/MeasReport/Meas-"&dateFormat2&"-11*.log | grep -i TAB09C05 -A 3 -B 8" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Screen.send  chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.session.Log(false)
		writeTmp wy,"T3_Link"
    crt.Screen.send "cat /var/measfile/traffic/T3_Result_"&dateFormat2&"-1100_All " & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Screen.send  chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.session.Log(false)
    crt.Screen.send P6_SCCP & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1500
		screenrow = crt.screen.CurrentRow-1
		stpSccp = crt.Screen.Get(screenrow,1,screenrow,50)
		crt.Screen.send  chr(13)
    crt.Screen.send P6_LINK64K & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1500
		screenrow = crt.screen.CurrentRow-1
		stpLink64k = crt.Screen.Get(screenrow,1,screenrow,50)
		crt.Screen.send  chr(13)
    crt.Screen.send P6_LINK2M & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1500
		screenrow = crt.screen.CurrentRow-1
		stpLink2m = crt.Screen.Get(screenrow,1,screenrow,50)
		stpMgc = " "
		stpTotal = wy&","&dateFormat2&","&stpMgc&","&stpSccp&","&stpLink64k&","&stpLink2m
		'crt.Dialog.MessageBox stpTotal
		write_STP stpTotal,wy	
		crt.Sleep 1000
		writelog wy	
		crt.Screen.send  chr(13)
    crt.Screen.send "listalarm" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1000
    crt.Screen.send "alluptime" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1000
    crt.Screen.send "meastool 5691 "&dateFormat1&"00 "&dateFormat3 & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1000
End Function

'SG_P12
Function P12totalSG(wy,username,passwd,sgip)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send  chr(13)
    crt.Screen.WaitForStrings "#","$",">"
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
    crt.session.Log(false)
		writeTmp wy,"GT"
    crt.Screen.send "n7count.sh "&dateFormat1&".10" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.session.Log(false)
    	If (wy = "HFH2")Then 
					crt.Screen.send "/usr/local/sbin/gt_t3_tool/t3.exe -f 4-N7LINK_"&dateFormat1&".101500.csv" & chr(13)
			Else 
					crt.Screen.send "/usr/local/sbin/gt_t3_tool/t3.exe -f 3-N7LINK_"&dateFormat1&".101500.csv" & chr(13)
			End If     
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1000
    crt.Screen.send  chr(13)
    crt.Screen.WaitForStrings "#","$",">"
		writeTmp wy,"T3_Link"
    crt.Screen.send "cat /tmp/t3/"&dateFormat1&".101500.txt" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Screen.send  chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.session.Log(false)
    crt.Screen.send P12_SCCP & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1500
		screenrow = crt.screen.CurrentRow-1
		stpSccp = crt.Screen.Get(screenrow,1,screenrow,50)
		crt.Screen.send  chr(13)
    crt.Screen.send P12_LINK64K & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1500
		screenrow = crt.screen.CurrentRow-1
		stpLink64k = crt.Screen.Get(screenrow,1,screenrow,50)
		crt.Screen.send  chr(13)
    crt.Screen.send P12_LINK2M & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1500
		screenrow = crt.screen.CurrentRow-1
		stpLink2m = crt.Screen.Get(screenrow,1,screenrow,50)
		stpTotal =  wy&","&dateFormat2&","&stpSccp&","&stpLink64k&","&stpLink2m
		'crt.Dialog.MessageBox stpTotal
		write_STP stpTotal,wy		
		writelog wy
    crt.Screen.send "listalarm" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1000
    crt.Screen.send "listalarmhis" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1000
End Function


'DRA_P12
Function totalDRA(wy,username,passwd,sgip)		
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send  chr(13)
    crt.Screen.WaitForStrings "#","$",">"
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
    crt.Screen.send  chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.session.Log(false)
		writeTmp wy,"MPS"
    crt.Screen.send "countsum.sh "&dateFormat1&".17" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.session.Log(false)
		writeTmp wy,"CPU"
    crt.Screen.send "cat /var/measfile/Recently/2-DIAMCPU_"&dateFormat1&".174500.csv" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.session.Log(false)
		writeTmp wy,"LINK"
    crt.Screen.send "cat /var/measfile/Recently/4-DIAMLINK_"&dateFormat1&".174500.csv" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.session.Log(false)
    crt.Screen.send  chr(13)
    crt.Screen.send msgsum & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1500
		screenrow = crt.screen.CurrentRow-1
		draMsg = crt.Screen.Get(screenrow,1,screenrow,50)
		crt.Screen.send  chr(13)
    crt.Screen.send cpusum & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1500
		screenrow = crt.screen.CurrentRow-1
		draCpu = crt.Screen.Get(screenrow,1,screenrow,50)
		crt.Screen.send  chr(13)
    crt.Screen.send linksum & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1500
		screenrow = crt.screen.CurrentRow-1
		draLink = crt.Screen.Get(screenrow,1,screenrow,50)
		draTotal = wy&","&dateFormat2&","&draMsg&","&draCpu&","&draLink
		'crt.Dialog.MessageBox draTotal
		write_DRA draTotal,wy	
		writelog wy
		crt.Screen.send  chr(13)
    crt.Screen.send "listalarm" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1000
    crt.Screen.send "listalarmhis" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 1000
End Function

Function checkS12(s12ip)
	dim psw
	psw = 1
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
	Wait = crt.screen.WaitForString("LOGGED ON", 3)
	if Wait = -1 then
		do
		psw = psw+1
		crt.screen.sendkeys("^c")
		crt.screen.WaitForString "USERID"
		crt.Sleep 500
		crt.screen.send "PSW00"&psw&";"
		crt.screen.WaitForString "PASSWORD"
		crt.Sleep 500
		crt.screen.send "PSW00"&psw&";"
		Wait = crt.screen.WaitForString("LOGGED ON", 3)
		if Wait = 0 then
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
	Crt.screen.send "7599:lkset = all,option = link." & chr(13)
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
	P12totalSG "HFH2","alausr","Chji826!1","10.1.207.20"
	crt.session.Disconnect
End Function

Function HFL7
	login1 "root","5020mgc-12","10.225.212.33","HFL7"		'登录OWP，如果是再OWP上运行脚本，则不需要这一步，加单引号
	P12totalSG "HFL7","alausr","Chji826@1","10.225.212.36"
	crt.session.Disconnect
End Function

Function HNAL8
	login1 "root","5020mgc-12","10.225.191.242","HNAL8"		'登录OWP，如果是再OWP上运行脚本，则不需要这一步，加单引号
	P12totalSG "HNAL8","alausr","Chji826@1","10.225.191.245"
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
	if crt.session.Log(Ture) = Ture then
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