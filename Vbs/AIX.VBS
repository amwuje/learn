# $language = "VBScript"
# $interface = "1.0"
'============================================================================================='
'        程序名称：AIX.VBS
'        程序说明：AIX主机系统配置/巡检脚本
'        作者：郑继东
'        完成时间：2008-5-7
'============================================================================================='

'============================================================================================='
'        程序全局变量区
'============================================================================================='
dim ip

'============================================================================================='
'        程序全局常量区
'============================================================================================='
' button parameter options
Const ICON_STOP = 16                 ' display the ERROR/STOP icon.
Const ICON_QUESTION = 32             ' display the '?' icon
Const ICON_WARN = 48                 ' display a '!' icon.
Const ICON_INFO= 64                  ' displays "info" icon.
Const BUTTON_OK = 0                  ' OK button only
Const BUTTON_CANCEL = 1              ' OK and Cancel buttons
Const BUTTON_ABORTRETRYIGNORE = 2    ' Abort, Retry, and Ignore buttons
Const BUTTON_YESNOCANCEL = 3         ' Yes, No, and Cancel buttons
Const BUTTON_YESNO = 4               ' Yes and No buttons
Const BUTTON_RETRYCANCEL = 5         ' Retry and Cancel buttons
Const DEFBUTTON1 = 0        ' First button is default
Const DEFBUTTON2 = 256      ' Second button is default
Const DEFBUTTON3 = 512      ' Third button is default

' Possible MessageBox() return values
Const IDOK = 1              ' OK button clicked
Const IDCANCEL = 2          ' Cancel button clicked
Const IDABORT = 3           ' Abort button clicked
Const IDRETRY = 4           ' Retry button clicked
Const IDIGNORE = 5          ' Ignore button clicked
Const IDYES = 6             ' Yes button clicked
Const IDNO = 7              ' No button clicked

'============================================================================================='
'        程序辅助函数区
'============================================================================================='

'登陆函数
Function login
	'定义IP地址,登陆用户名，密码变量
	dim passwd
	dim username
	
	Dim result
	Dim flag
	flag =1 
	
	'断开主机连接
	crt.session.Disconnect
	
	'开启对话框，取得IP地址，登陆用户名称，密码等变量
	ip = crt.Dialog.Prompt("请输入服务器IP地址:", "AIX", "192.168.99.208", false)
	If (Trim(ip) = "")  Or (ip = IDABORT) Then 
			result = crt.Dialog.MessageBox("您没有输入登陆的IP地址，CRT将被退出！", "提示信息",ICON_INFO)
			crt.quit
	End If
	
	
	flag =1 
	While flag = 1 
			username = crt.Dialog.Prompt("请输入登陆用户名:", "AIX", "root", false)
			If         username = IDABORT Then
					result = crt.Dialog.MessageBox("您选择了没有输入用户名称，CRT将被推出！", "提示信息",ICON_INFO)                        
					crt.quit
			End If
	
			If (Trim(username) = "")Then 
					result = crt.Dialog.MessageBox("请输入登陆用户名称！", "提示信息",ICON_INFO)
			Else 
					flag = 0
			End If 
	wend
	
	passwd = crt.Dialog.Prompt("请输入登陆用户密码:", "AIX", "@spatial1", true)
	
	'连接主机
	crt.screen.Synchronous = true
	crt.session.Connect("/telnet " & ip)
	'crt.session.Connect("/SSH2 /PASSWORD @spatial1 root@192.168.99.208") '创建一个ssh连接session
	'crt.session.ConnectInTab("/SSH2 /PASSWORD @spatial1 root@192.168.99.208") '新标签创建session
	'等待出现登陆用户名提示login，等待时间是10s
	crt.screen.WaitForString "login:"
	'输入用户名，回车
	crt.screen.send username & chr(13)
	
	'等待出现登陆密码提示login，等待时间是10s
	crt.screen.WaitForString "Password:"
	'输入密码，回车
	crt.screen.send passwd & chr(13)
	
	If crt.screen.WaitForString("invalid login name or password", 3) = True Then
			result = crt.Dialog.MessageBox("服务器登陆失败，请检查IP地址、用户名、密码是否输入正确！", "提示信息",ICON_INFO)
			crt.quit
	End If
	crt.screen.Synchronous = false
End Function

'记录当前会话日志函数
Function writelog        
	Dim result
	Dim logfilename
	Dim flag
	flag =1
	
	While flag =1 
			logfilename = crt.Dialog.Prompt("请输入本次会话LOG文件位置", "AIX", "C:\Users\huang\Desktop\SecureCRT VBS/"  & ip &".log", false)
			If Trim(logfilename) = ""  Or  (logfilename = IDABORT) then
					result = crt.Dialog.MessageBox("强烈建议保存会话日志", "提示信息",ICON_INFO)
			Else
					flag = 0
			End if
	wend
	crt.session.LogFileName = logfilename
	crt.session.Log(true)
End Function

Function  setline
	crt.screen.send chr(13) & chr(13) 
	crt.Sleep 1000
End Function


Function setcommand(cmdstr, sec)
	setline
	sec = sec * 1000
	crt.screen.send cmdstr & Chr(13)
	crt.Sleep sec
End Function


'取得服务器基本信息
Function get_machinfo
	
	'主机基本信息
	setcommand "hostname",1
	setcommand "prtconf |grep 'Machine Serial Number'",6
	
	'主机设备情况
	setcommand "lsdev -C |grep proc",2
	setcommand "lsattr -El mem0",2
	setcommand "lsdev -Cc disk",2
	setcommand "lsdev -Cc adapter",2
	setcommand "lsdev -Cc tape",2
	
	
	'主机网卡情况
	setcommand "ifconfig -a",2
	setcommand "more /etc/hosts",2
	
	'主机软件信息
	setcommand "uname -a ",2
	setcommand "oslevel -s",5
	setcommand "instfix -i |grep ML",10
	
	'主机卷组信息
	setcommand "lsvg ",2
	setcommand "lsvg -o",2
	setcommand "lsvg -l rootvg",2
	
	'主机文件系统信息
	setcommand "df -h ",2
	
	'主机日志信息
	setcommand "errpt ",2
	setcommand "errpt  -a",2
	setcommand "sysdumpdev -l ",2
	
	
	'主机系统性能
	setcommand "lsps -a",2
	setcommand "vmstat 2 10",25
	setcommand "iostat 2 10",25

End Function

'============================================================================================='
'        程序主函数（main）区
'============================================================================================='

'主函数
Sub Main
        Dim result
        crt.screen.Synchronous = true
        '系统登陆
        login

        '写日志
        writelog

        '取得服务器信息
        get_machinfo
        
        result = crt.Dialog.MessageBox("信息收集完毕，是否推出CRT?", "提示信息", ICON_QUESTION Or BUTTON_YESNO Or DEFBUTTON2)
        If        result = IDYES Then
                crt.quit
        End If
		'结束会话日志
		crt.session.Log(false)
		crt.screen.Synchronous = false
End Sub