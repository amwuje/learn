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

Function  setline
        crt.screen.send chr(13) & chr(13) 
'        crt.Sleep 1000
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
    setcommand "view chassis",1
		setcommand "view alarm active",1
		setcommand "view spc tdm2hdlc",1  
		setcommand "vi spc tdm2hdlc nok state",1
		setcommand "view spc monitor",1
		'setcommand "view link state <link>",1
		setcommand "view over status",1
		setcommand "vi version all",2
		setcommand "view date",1
		setcommand "view clock status",1
		setcommand "rexec 1 1 vi clock sync",1
		setcommand "view redundancy groups",1
		setcommand "view mmgr pool all",1
		setcommand "view uptime all",2
		setcommand "view module temperature all",1
		setcommand "view alarm history $(date -d +%m-%d-%y)",1
		setcommand "diag view pif port all",1
End Function

Sub Main
        Dim result
'        crt.screen.Synchronous = true
        '系统登陆
        'login

        '写日志
        'writelog

        '取得服务器信息
        get_machinfo
        
        'result = crt.Dialog.MessageBox("信息收集完毕，是否推出CRT?", "提示信息", ICON_QUESTION Or BUTTON_YESNO Or DEFBUTTON2)
        'If        result = IDYES Then
                crt.quit
        'End If

        '结束会话日志
        crt.session.Log(false)
'        crt.screen.Synchronous = false
End Sub
