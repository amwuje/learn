# $language = "VBScript"
# $interface = "1.0"
'============================================================================================='
'        程序名称：SG.VBS
'        程序说明：SG/DRA巡检脚本
'        作者：黄彰
'        完成时间：20170612
'============================================================================================='

'============================================================================================='
'        程序全局变量区
'============================================================================================='
	dim sgip1
	dim sgip2
	dim sgip3
	dim sgip4
	dim sgip5
	dim fesip1
	dim fesip2
	dim fesip3
	dim flxip1
	dim flxip2
	dim flxip3
	dim flxip4
	dim flxip5
	dim s12ip
	sgip1 ="10.225.80.100"		'HFL6
	sgip2 ="10.1.207.20"		'HFH2
	sgip3 ="10.225.218.21"		'HFLDRA1
	sgip4 ="10.225.218.38"		'HFLDRA2
	sgip5 ="134.96.47.6"		'联通HSTPA	
	fesip1="172.16.110.3"		'FES1
	fesip2="172.16.110.4"		'FES2
	fesip3="172.16.110.5"		'FES3
	fesip4="134.96.47.8"		'联通FES1
	fesip5="134.96.47.9"		'联通FES2
	flexip1="172.16.101.101"	'FLEXMANAGER
	flexip2="172.16.101.102"	'FLEXMANAGER
	flexip3="172.16.101.105"	'FLEXMANAGER
	flexip4="172.16.101.106"	'FLEXMANAGER
	flexip5="172.16.101.109"	'FLEXMANAGER
	flexip6="172.16.101.110"	'FLEXMANAGER
	s12ip="172.16.64.0"


Function checkSG
		dim username
		dim passwd
		username="root"
		passwd="Spat705@1"
    crt.Screen.Send("telnet " &sgip1& chr(13))
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

 Function checkHCT
		dim path
		path="/var/log/HCT/$(date -d yesterday +%Y-%m-%d)"
    crt.Screen.send("cd " &path& chr(13))
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "ls -lrt" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "cat *summary*.log" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "cat *unix*.log" & chr(13)
    crt.Screen.WaitForStrings "#","$",">","checking end" 
    crt.Sleep 500
    crt.Screen.send "cat *s12*.log" & chr(13)
    crt.Screen.WaitForStrings "#","$",">","checking end" 
    crt.Sleep 500
    crt.Screen.send "cd " & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
	crt.Sleep 500
End Function 

Function checkFES1
		dim username
		dim passwd
		username="diag"
		passwd="-assured"
    crt.Screen.Send("telnet " &fesip1& chr(13))
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
    crt.Screen.WaitForStrings "Continue:"
    crt.Sleep 500
    crt.Screen.send "q" & chr(13)
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
    crt.Screen.send "vi spc tdm2h nok state" & chr(13)
   	crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi spc monitor" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi over status" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi ver all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi date" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi clo sta" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 1 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 2 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 3 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 4 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 5 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 6 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 7 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 13 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 14 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 15 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 16 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 17 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 18 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 19 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi red grou" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi mmgr pool all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "view uptime all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi mod tem all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "d vi pif port all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "logout" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
End Function

Function checkFES2
		dim username
		dim passwd
		username="diag"
		passwd="-assured"
    crt.Screen.Send("telnet " &fesip2& chr(13))
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
    crt.Screen.WaitForStrings "Continue:"
    crt.Sleep 500
    crt.Screen.send "q" & chr(13)
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
    crt.Screen.send "vi spc tdm2h nok state" & chr(13)
   	crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi spc monitor" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi over status" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi ver all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi date" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi clo sta" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 1 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 2 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 3 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 4 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 5 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 6 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 7 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 13 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 14 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 15 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 16 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 17 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 18 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 19 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi red grou" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi mmgr pool all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "view uptime all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi mod tem all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "d vi pif port all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "logout" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
End Function

Function checkFES3
		dim username
		dim passwd
		username="diag"
		passwd="-assured"
    crt.Screen.Send("telnet " &fesip3& chr(13))
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
    crt.Screen.WaitForStrings "Continue:"
    crt.Sleep 500
    crt.Screen.send "q" & chr(13)
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
    crt.Screen.send "vi spc tdm2h nok state" & chr(13)
   	crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi spc monitor" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi over status" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi ver all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi date" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi clo sta" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 1 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 2 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 3 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 4 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 5 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 6 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 7 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 13 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 14 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 15 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 16 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 17 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 18 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 19 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi red grou" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi mmgr pool all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "view uptime all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi mod tem all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "d vi pif port all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "logout" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
End Function

Function checkFES4
		dim username
		dim passwd
		username="diag"
		passwd="-assured"
    crt.Screen.Send("telnet " &fesip4& chr(13))
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
    crt.Screen.WaitForStrings "Continue:"
    crt.Sleep 500
    crt.Screen.send "q" & chr(13)
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
    crt.Screen.send "vi spc tdm2h nok state" & chr(13)
   	crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi spc monitor" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi over status" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi ver all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi date" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi clo sta" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 1 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 2 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 3 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 4 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 5 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 6 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 7 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 13 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 14 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 15 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 16 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 17 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 18 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 19 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi red grou" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi mmgr pool all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "view uptime all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi mod tem all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "d vi pif port all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "logout" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
End Function

Function checkFES5
		dim username
		dim passwd
		username="diag"
		passwd="-assured"
    crt.Screen.Send("telnet " &fesip5& chr(13))
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
    crt.Screen.WaitForStrings "Continue:"
    crt.Sleep 500
    crt.Screen.send "q" & chr(13)
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
    crt.Screen.send "vi spc tdm2h nok state" & chr(13)
   	crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi spc monitor" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi over status" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi ver all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi date" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi clo sta" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 1 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 2 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 3 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 4 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 5 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 6 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 7 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 13 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 14 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 15 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 16 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 17 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 18 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "rexec 1 19 vi clock sync" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi red grou" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi mmgr pool all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "view uptime all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "vi mod tem all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "d vi pif port all" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
    crt.Screen.send "logout" & chr(13)
    crt.Screen.WaitForStrings "#","$",">"
    crt.Sleep 500
End Function

Function checkFLEX1
	dim username
	dim passwd
	username="admin"
	crt.Screen.Send("telnet " &flexip1& chr(13))
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

Function checkFLEX2
	dim username
	dim passwd
	username="admin"
	crt.Screen.Send("telnet " &flexip2& chr(13))
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

Function checkFLEX3
	dim username
	dim passwd
	username="admin"
	crt.Screen.Send("telnet " &flexip3& chr(13))
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

Function checkFLEX4
	dim username
	dim passwd
	username="admin"
	crt.Screen.Send("telnet " &flexip4& chr(13))
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

Function checkFLEX5
	dim username
	dim passwd
	username="admin"
	crt.Screen.Send("telnet " &flexip5& chr(13))
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

Function checkFLEX6
	dim username
	dim passwd
	username="admin"
	crt.Screen.Send("telnet " &flexip6& chr(13))
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

Function checkS12
	dim psw
	psw=1
	crt.Screen.Send("telnet " &s12ip& chr(13))
	crt.screen.WaitForString "COMMAND."
	crt.Sleep 500
	set WshShell = CreateObject("WScript.Shell")
	WshShell.SendKeys "{ESC}"
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
	Crt.screen.send ":ALLCEI ALL,DISRES,NA" & chr(13)
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
Sub Main 
    'checkSG
    'checkHCT
    'checkFES1
    'checkFES2
    'checkFES3
    'checkFES4
    'checkFES5
    'checkFLEX1
	'checkFLEX2
	'checkFLEX3
	'checkFLEX4
	'checkFLEX5
	'checkFLEX6
	checkS12
    'crt.Screen.Synchronous = false 
    'crt.quit 
End Sub 