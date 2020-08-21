#$language = "VBScript"
#$interface = "1.0"
crt.Screen.Synchronous = True
Function Login(ptab,name,host,pwd,cmd)
   Dim tab,scr
   Set tab = ptab.Clone()
   tab.Caption = name
   Set scr = tab.Screen
   scr.Send("ssh " & host & VbCr)
   scr.WaitForString(host & "'s password: ")
   scr.Send(pwd & VbCr)
   scr.Send(cmd & VbCr)
   Set Login = tab
End Function
Sub Main
   Dim conf,tab
   Set conf = crt.OpenSessionConfiguration("session_name")
   Set tab = conf.ConnectInTab()
   Set tab = Login(tab,"name1","user1@host1","xxx","cd /home/")
   Set tab = Login(tab,"name2","user2@host2","xxx","shell cmd")
End Sub