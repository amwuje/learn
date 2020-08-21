# $language = "VBScript"
# $interface = "1.0"
'============================================================================================='
'        程序名称：SG.VBS
'        程序说明：SG/DRA巡检脚本
'        作者：黄彰
'        完成时间：20170524
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
	sgip1 ="10.225.80.100"		'HFL6
	sgip1 ="10.1.207.20"			'HFH2
	sgip1 ="10.225.218.21"		'HFLDRA1
	sgip1 ="10.225.218.38"		'HFLDRA2
	sgip1 ="134.96.47.6"		'联通HSTPA	
	fesip1="172.16.110.3"		'FES1
	fesip2="172.16.110.4"		'FES2
	fesip3="172.16.110.5"		'FES3
	fesip4="134.96.47.8"		'联通FES1
	fesip5="134.96.47.8"		'联通FES2
	fexip1="172.16.101.101"	'FLEXMANAGER
	fexip2="172.16.101.102"	'FLEXMANAGER
	fexip3="172.16.101.105"	'FLEXMANAGER
	fexip4="172.16.101.106"	'FLEXMANAGER
	fexip5="172.16.101.109"	'FLEXMANAGER
	fexip5="172.16.101.110"	'FLEXMANAGER

'============================================================================================='
'        程序全局常量区
'============================================================================================='
'登陆SG
Function loginsg 
	'登陆用户名，密码变量 
	dim passwd
	dim username
	passwd ="Spat705@1"
	username ="root"
	'连接主机 
	'向屏幕光标后发送以下文字内容，\r表示回车执行
    crt.Screen.Send("telnet " &sgip& chr(13))
    '等待出现登陆用户名提示login，等待时间是10s 
    crt.screen.WaitForString("ogin:",5) 
    '输入用户名，回车 
    crt.screen.send username & chr(13) 
    '等待出现登陆密码提示login，等待时间是10s 
    crt.screen.WaitForString("assword:",5) 
    '输入密码，回车 
    crt.screen.send passwd & chr(13) 
    If crt.screen.WaitForString("Login incorrect", 3) = True Then 
        result = crt.Dialog.MessageBox("服务器登陆失败，请检查IP地址、用户名、密码是否输入正确！", "提示信息",ICON_INFO) 
        crt.quit 
    End If 
    crt.screen.Synchronous = false 
End Function 

Sub Main 
    '系统登陆 
    loginsg 
    '结束会话日志 
 
End Sub 