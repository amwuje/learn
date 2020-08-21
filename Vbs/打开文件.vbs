Sub Main
    '打开保存设备管理地址以及密码的文件
    Const ForReading = 1, ForWriting = 2, ForAppending = 8
    Dim fso,file1,line,str1,params
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set file1 = fso.OpenTextFile("d:\config.txt",Forreading, False)        
    crt.Screen.Synchronous = True
    DO While file1.AtEndOfStream <> True
       '读出每行
       line = file1.ReadLine
       '分离每行的参数 IP地址 密码 En密码
       params = Split (line)
       'Telnet到这个设备上
       crt.Session.Connect "/TELNET " & params(0)
       '输入telnet密码
       crt.Screen.WaitForString "Password:"
       crt.Screen.Send params(1) & vbcr
       '进特权模式
       crt.Screen.Send "enable" & vbcr
       crt.Screen.WaitForString "Password:"
       crt.Screen.Send params(2) & vbcr
       crt.Screen.waitForString "#"
        '备份目前Startup配置
       str1 = "copy startup tftp://192.168.1.2/"
       str1 = str1 & "backup(" & params(0) &")" & ".cfg"
       crt.Screen.Send str1 & vbcr
       crt.Screen.WaitForString "]?"
       crt.Screen.Send vbcr
       crt.Screen.WaitForString "]?"
       crt.Screen.Send vbcr
       '备份完成后退出
       crt.Screen.waitForString "#",3
       crt.Session.Disconnect

       loop
    crt.Screen.Synchronous = False           
End Sub
