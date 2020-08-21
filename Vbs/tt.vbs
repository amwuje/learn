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
        'setcommand "more /etc/hosts",2

        '主机软件信息
        setcommand "uname -a ",2
        'setcommand "oslevel -s",5
        'setcommand "instfix -i |grep ML",10

        '主机卷组信息
        'setcommand "lsvg ",2
       ' setcommand "lsvg -o",2
        'setcommand "lsvg -l rootvg",2

        '主机文件系统信息
        setcommand "df -h ",2

        '主机日志信息
        'setcommand "errpt ",2
        'setcommand "errpt  -a",2
        'setcommand "sysdumpdev -l ",2


        '主机系统性能
        setcommand "lsps -a",2
        setcommand "vmstat 2 10",25
        setcommand "iostat 2 10",25

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
        
        result = crt.Dialog.MessageBox("信息收集完毕，是否推出CRT?", "提示信息", ICON_QUESTION Or BUTTON_YESNO Or DEFBUTTON2)
        If        result = IDYES Then
                crt.quit
        End If

        '结束会话日志
        crt.session.Log(false)
'        crt.screen.Synchronous = false
End Sub
