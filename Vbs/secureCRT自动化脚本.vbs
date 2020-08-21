#$language = "VBScript"
#$interface = "1.0"

'接到一个需求：
'通过ssh连接交换机，然后获得交换机配置信息，将信息保存于本地文件。
'简而言之，就是一键获取交换机配置信息。
'根据提示，secureCRT 可以使用vbs脚本。因为我这没有交换机，所以就用个ubuntu虚拟机的ifconfig代替交换机配置信息。

'crt.Screen.Synchronous = True

' This automatically generated script may need to be
' edited in order to work correctly.

Sub Main

    Const ForReading = 1, ForWriting = 2, ForAppending = 8
    Dim fso,file1,line,str1,params
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set file1 = fso.OpenTextFile("F:\securecrt\config.txt",Forreading, False)        
    crt.Screen.Synchronous = True


    Dim szPrompt, szResult
    szPrompt = "root"


    Dim objFso,objStream
    Set  objFSO  =   CreateObject( "Scripting.FileSystemObject" ) 

  'Dim host
  'host = "192.168.1.104"
  'Dim user
  'user = "username"
  ' Prompt for a password instead of embedding it in a script...
  '
  'Dim passwd
  'passwd = "password"
  ' Build a command-line string to pass to the Connect method.
  '

  DO While file1.AtEndOfStream <> True
       '读出每行
       line = file1.ReadLine
       '分离每行的参数 IP地址 密码 En密码
       params = Split (line)


      cmd = "/SSH2 /L " & params(1) & " /PASSWORD " & params(2) & " /C 3DES /M MD5 " & params(0)
      crt.Session.Connect cmd

    crt.Screen.Send "clear" & chr(13)
    crt.Screen.WaitForString chr(27) & "[H" & chr(27) & "[Jroot@ubuntu:" & chr(126) & "# "
    crt.Screen.Send "ifconfig" & chr(13)


    szResult = crt.Screen.ReadString(szPrompt)
    crt.Dialog.MessageBox szResult


    'crt.Session.Disconnect

    Set objStream = objFso.OpenTextFile("F:\securecrt\" & params(0) & ".txt",ForWriting, True) 
    'Set objStream = objFso.OpenTextFile("F:\securecrt\result.txt",ForWriting, True) 
    objStream.Write(szResult)
    objStream.close

    crt.Session.Disconnect

       loop
    crt.Screen.Synchronous = False

End Sub

'19行的 Set file1 = fso.OpenTextFile("F:\securecrt\config.txt",Forreading, False) '是打开配置文件，这个配置文件写死了，偷懒了呵呵。
'配置文件的行模式如下：
'ip username password
 
'62行的 Set objStream = objFso.OpenTextFile("F:\securecrt\" & params(0) & ".txt",ForWriting, True) '是打开记录信息文件，以ip地址为文件名，文件路径也写死了。
 
'在cmd下敲入 F:\securecrt\SecureCRT.exe \script yourscriptfilename.vbs 就OK
'然后新建个bat文件，把“F:\securecrt\SecureCRT.exe \script yourscriptfilename.vbs” 敲进去，这样双击这个 yourbatfilename.bat '更直接。