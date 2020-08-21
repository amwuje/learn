# $language = "VBScript" 
# $interface = "1.0" 
'=============================================================================================' 
'    �������ƣ�CentOS.VBS 
'    ����˵����CentOS����ϵͳ����/Ѳ��ű� 
'    ���ߣ�֣�̶� 
'    ���ʱ�䣺2008-5-7 
'=============================================================================================' 
'=============================================================================================' 
'    ����ȫ�ֱ����� 
'=============================================================================================' 
dim ip 
'=============================================================================================' 
'    ����ȫ�ֳ����� 
'=============================================================================================' 
' button parameter options 
Const ICON_STOP = 16                 ' display the ERROR/STOP icon. 
Const ICON_QUESTION = 32             ' display the ' ' icon 
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
'    ������������ 
'=============================================================================================' 
'��½���� 
Function login 
    '����IP��ַ,��½�û������������ 
    dim    passwd 
    dim username 
    Dim result 
    Dim flag 
    flag =1 
    '�Ͽ��������� 
    crt.session.Disconnect 
    '�����Ի���ȡ��IP��ַ����½�û����ƣ�����ȱ��� 
    ip = crt.Dialog.Prompt("�����������IP��ַ:", "CentOS", "192.168.99.197", false) 
    If (Trim(ip) = "")  Or (ip = IDABORT) Then 
        result = crt.Dialog.MessageBox("��û�������½��IP��ַ��CRT�����˳���", "��ʾ��Ϣ",ICON_INFO) 
        crt.quit 
    End If 
    flag =1 
    While flag = 1 
        username = crt.Dialog.Prompt("�������½�û���:", "CentOS", "root", false) 
        If     username = IDABORT Then 
            result = crt.Dialog.MessageBox("��ѡ����û�������û����ƣ�CRT�����Ƴ���", "��ʾ��Ϣ",ICON_INFO)            
            crt.quit 
        End If 
        If (Trim(username) = "")Then 
            result = crt.Dialog.MessageBox("�������½�û����ƣ�", "��ʾ��Ϣ",ICON_INFO) 
        Else 
            flag = 0 
        End If 
    wend 
    passwd = crt.Dialog.Prompt("�������½�û�����:", "CentOS", "root", true) 
    '�������� 
    crt.screen.Synchronous = true 
    crt.session.Connect("ssh root@" & ip) 
    '�ȴ����ֵ�½�û�����ʾlogin���ȴ�ʱ����10s 
    'crt.screen.WaitForString "login:" 
    '�����û������س� 
    'crt.screen.send username & chr(13) 
    '�ȴ����ֵ�½������ʾlogin���ȴ�ʱ����10s 
    crt.screen.WaitForString "Password:" 
    '�������룬�س� 
    crt.screen.send passwd & chr(13) 
    If crt.screen.WaitForString("invalid login name or password", 3) = True Then 
        result = crt.Dialog.MessageBox("��������½ʧ�ܣ�����IP��ַ���û����������Ƿ�������ȷ��", "��ʾ��Ϣ",ICON_INFO) 
        crt.quit 
    End If 
    crt.screen.Synchronous = false 
End Function 
'��¼��ǰ�Ự��־���� 
Function writelog    
    Dim result 
    Dim logfilename 
    Dim flag 
    flag =1 
    While flag =1 
        logfilename = crt.Dialog.Prompt("�����뱾�λỰLOG�ļ�λ��", "CentOS", "c:\"  & ip &".log", false) 
        If Trim(logfilename) = ""  Or  (logfilename = IDABORT) then 
            result = crt.Dialog.MessageBox("ǿ�ҽ��鱣��Ự��־", "��ʾ��Ϣ",ICON_INFO) 
        Else 
            flag = 0 
        End if 
    wend 
    crt.session.LogFileName = logfilename 
    crt.session.Log(true) 
End Function 
Function  setline 
    crt.screen.send chr(13) & chr(13) 
'    crt.Sleep 1000 
End Function 
Function setcommand(cmdstr, sec) 
    setline 
    sec = sec * 1000 
    crt.screen.send cmdstr & Chr(13) 
    crt.Sleep sec 
End Function 
'ȡ�÷�����������Ϣ 
Function get_machinfo 
    '����������Ϣ 
    setcommand "hostname",1 
    setcommand "prtconf |grep 'Machine Serial Number'",6 
    '�����豸��� 
    setcommand "lsdev -C |grep proc",2 
    setcommand "lsattr -El mem0",2 
    setcommand "lsdev -Cc disk",2 
    setcommand "lsdev -Cc adapter",2 
    setcommand "lsdev -Cc tape",2 
    '����������� 
    setcommand "ifconfig -a",2 
    setcommand "more /etc/hosts",2 
    '���������Ϣ 
    setcommand "uname -a ",2 
    setcommand "oslevel -s",5 
    setcommand "instfix -i |grep ML",10 
    '����������Ϣ 
    setcommand "lsvg ",2 
    setcommand "lsvg -o",2 
    setcommand "lsvg -l rootvg",2 
    '�����ļ�ϵͳ��Ϣ 
    setcommand "df -g ",2 
    '������־��Ϣ 
    setcommand "errpt ",2 
    setcommand "errpt  -a",2 
    setcommand "sysdumpdev -l ",2 
    '����ϵͳ���� 
    setcommand "lsps -a",2 
    setcommand "vmstat 2 10",25 
    setcommand "iostat 2 10",25 
End Function 
'=============================================================================================' 
'    ������������main���� 
'=============================================================================================' 
'������ 
Sub Main 
    Dim result 
'    crt.screen.Synchronous = true 
    'ϵͳ��½ 
    login 
    'д��־ 
    writelog 
    'ȡ�÷�������Ϣ 
    get_machinfo 
    result = crt.Dialog.MessageBox("��Ϣ�ռ���ϣ��Ƿ��Ƴ�CRT ", "��ʾ��Ϣ", ICON_QUESTION Or BUTTON_YESNO Or DEFBUTTON2) 
    If    result = IDYES Then 
        crt.quit 
    End If 
    '�����Ự��־ 
    crt.session.Log(false) 
'    crt.screen.Synchronous = false 
End Sub 