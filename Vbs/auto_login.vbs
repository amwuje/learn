# $language = "VBScript" 
# $interface = "1.0" 
Sub Main 
'连接主机192.168.0.2 
crt.session.Connect("/telnet 192.168.0.2") 
'等待出现登陆用户名提示login，等待时间是10s 
crt.screen.WaitForString "login:",10 
'输入用户名，回车 
crt.screen.send "minico" & Chr(13) 
'等待出现登陆密码提示login，等待时间是10s 
crt.screen.WaitForString "Password:",10 
'输入密码，回车 
crt.screen.send "123456" 
crt.screen.send Chr(13) 
End Sub 