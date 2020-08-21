# $language = "VBScript"
# $interface = "1.0"
'============================================================================================='
'		�������ƣ�SG.vbS
'		����˵����SG/DRA �Զ�Ѳ��
'		���ߣ�����
'		������ʱ��:20170616
'============================================================================================='

'��¼OWP
Function login(ip)
	crt.Screen.Send("ssh root@" &ip& chr(13))
	crt.Screen.WaitForString "assword:"
	crt.Sleep 500
	crt.Screen.send "5020mgc-12" & chr(13)
	crt.Screen.WaitForStrings "#","$",">"
	crt.Sleep 500
	
End Function

'����log
Function writelog(name)
	Dim logfilename
	logfilename ="E:\log\" & name &".log"
	'MsgBox logfilename
	crt.session.LogFileName = logfilename
	crt.session.Log(true)
End Function

'SGѲ��
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

'HCTѲ��
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

'FESѲ��
Function checkFES(username,passwd,fesip)
    crt.Screen.Send("telnet " &fesip& chr(13))
    crt.Screen.WaitForString "ogin:"
    crt.Sleep 500
    crt.Screen.send username & chr(13) 
    crt.Screen.WaitForString "assword:"
    crt.Sleep 500
    crt.Screen.send passwd & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi ch" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi al ac" & chr(13)
    If crt.Screen.WaitForString ("Continue:",3)=True Then
				crt.Sleep 500
				crt.Screen.send "q" & chr(13)
				crt.Screen.WaitForStrings "#","$",">"
    		crt.Sleep 500
		End If	
		crt.Screen.send " " & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
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

'FLEXMANAGERѲ��
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
	'crt.Screen.send "faults latched clear" & chr(13)
	'crt.Screen.WaitForStrings "#","$",">"
	'crt.Sleep 500
	'crt.Screen.send "faults clear" & chr(13)
	'crt.Screen.WaitForStrings "#","$",">"
	'crt.Sleep 500
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

'S12Ѳ��
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
	writelog "����ʡ�Ϸ���HFL6��Ԫ"&Month(Now)&"�·�-SG"
	checkSG "root","Spat705@1","10.225.80.100"
	crt.session.Log(false)
	writelog "3�����ƶ�L6"
	checkHCT
	crt.session.Log(false)
	writelog "����ʡ�Ϸ���HFL6��Ԫ"&Month(Now)&"�·�-FES"
	checkFES "diag","-assured","172.16.110.3"
	checkFES "diag","-assured","172.16.110.4"
	'checkFES "diag","-assured","172.16.110.5"
	crt.session.Log(false)
	writelog "����ʡ�Ϸ���HFL6��Ԫ"&Month(Now)&"�·�-FLEXMANAGER"
	checkFLEX "admin","172.16.101.101"
	checkFLEX "admin","172.16.101.102"
	checkFLEX "admin","172.16.101.105"
	checkFLEX "admin","172.16.101.106"
	crt.session.Log(false)
	writelog "����ʡ�Ϸ���HFL6��Ԫ"&Month(Now)&"�·�-S12"
	checkS12 "172.16.64.0"
	crt.session.Log(false)
End Function

Function HFH2
	writelog "����ʡ�Ϸ���HFH2��Ԫ"&Month(Now)&"�·�-SG"
	checkSG "root","Spat705!1","10.1.207.20"
	crt.session.Log(false)
	writelog "2�����ƶ�H2"
	checkHCT
	crt.session.Log(false)
	writelog "����ʡ�Ϸ���HFH2��Ԫ"&Month(Now)&"�·�-FES"
	checkFES "diag","-assured","172.16.110.3"
	checkFES "diag","-assured","172.16.110.4"
	checkFES "diag","-assured","172.16.110.5"
	crt.session.Log(false)
	writelog "����ʡ�Ϸ���HFH2��Ԫ"&Month(Now)&"�·�-FLEXMANAGER"
	checkFLEX "admin","172.16.101.101"
	checkFLEX "admin","172.16.101.102"
	checkFLEX "admin","172.16.101.105"
	checkFLEX "admin","172.16.101.106"
	crt.session.Log(false)
	writelog "����ʡ�Ϸ���HFH2��Ԫ"&Month(Now)&"�·�-S12"
	checkS12 "172.16.64.0"
	crt.session.Log(false)
End Function

Function HSTPA
	writelog "����ʡ�Ϸ���HFL6��Ԫ"&Month(Now)&"�·�-SG"
	checkSG "root","softswitch","134.96.47.6"
	crt.session.Log(false)
	writelog "1������ͨHSTP"
	checkHCT
	crt.session.Log(false)
	writelog "����ʡ�Ϸ���HFH2��Ԫ"&Month(Now)&"�·�-FES"
	checkFES "diag","-assured","134.96.47.8"
	checkFES "diag","-assured","134.96.47.9"
	crt.session.Log(false)
	writelog "����ʡ�Ϸ���HFH2��Ԫ"&Month(Now)&"�·�-FLEXMANAGER"
	checkFLEX "admin","172.16.101.101"
	checkFLEX "admin","172.16.101.102"
	checkFLEX "admin","172.16.101.105"
	checkFLEX "admin","172.16.101.106"
	checkFLEX "admin","172.16.101.109"
	checkFLEX "admin","172.16.101.110"
	crt.session.Log(false)
	writelog "����ʡ�Ϸ���HFH2��Ԫ"&Month(Now)&"�·�-S12"
	checkS12 "172.16.64.0"
	crt.session.Log(false)
End Function

Function HFLDRA1
	writelog "����ʡ�Ϸ���HFLDRA01��Ԫ"&Month(Now)&"�·�-SG"
	checkSG "alausr","Chji826@1","10.225.218.21"
	crt.session.Log(false)
	writelog "4�����ƶ�LDRA1"
	checkHCT
	crt.session.Log(false)
End Function

Function HFLDRA2
	writelog "����ʡ�Ϸ���HFLDRA02��Ԫ"&Month(Now)&"�·�-SG"
	checkSG "alausr","Chji826@1","10.225.218.38"
	crt.session.Log(false)
	writelog "5�����ƶ�LDRA2"
	checkHCT
	crt.session.Log(false)
End Function

Sub Main
	if crt.session.Log(ture)=Ture then
	crt.session.Log(false)
	end if
	login"10.225.80.104"		'��¼OWP���������OWP�����нű�������Ҫ��һ��
	HFL6
	login"10.1.207.28"
	HFH2
	'HSTPA
	login"10.225.218.24"
	HFLDRA1
	login"10.225.218.24"
	HFLDRA2
	crt.Screen.Synchronous = false 
	crt.session.disconnect
	crt.Quit
End Sub 