#$language = "VBScript"
#$interface = "1.0"
'用于自动备份思科配置
	crt.Screen.Synchronous = True
Sub main
	dim host(100)                                              '定义一个数组
	host(0)="10.127.10.10"                                     '每行定义一个要备份的设备IP，有多少台设备，就写几行
	host(1)="10.127.10.11"
	host(2)="10.127.10.12"
	host(3)="10.127.10.13"
	host(4)="10.127.10.14"
	For Each ip in host
	If ip="" Then exit for
	If crt.Session.Connected Then crt.Session.Disconnect
	crt.Session.Connect " /Telnet " & ip             'ip即host值
	crt.Screen.WaitForString "Username: "
	crt.Screen.Send "xxx" & chr(13)              'xxx是用户名，本例中所有设备的用户名和密码都一样
	crt.Screen.WaitForString "Password: "
	crt.Screen.Send "xxx" & chr(13)              'xxx是密码
	crt.Screen.WaitForString "#"
	crt.Screen.Send "copy running-config ftp" & chr(13)
	crt.Screen.WaitForString "Address or name of remote host []?"
	crt.Screen.Send "10.127.30.74"& chr(13) '请根据实际FTP地址更改
	crt.Screen.WaitForString "? "
	crt.Screen.Send chr(13)
	crt.Screen.WaitForString "#"
	crt.Screen.Send "q" & chr(13)
	Next
end sub