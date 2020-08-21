#$language = "VBScript"
#$interface = "1.0"
   Dim SwitchKey
   Dim LocalIp

LocalIp = crt.Dialog.Prompt("请输入Local IP,使用默认可不填IP", "Local IP", "199.0.0.244", False)
  crt.Screen.Synchronous = True 

SwitchKey=crt.Screen.WaitForStrings("nxuser","oracle","alcatel",5)
crt.Dialog.MessageBox LocalIp
Select case SwitchKey
case 1
MsgBox "nxuser用户"
case 2
MsgBox "oracle用户"
case 3
MsgBox "alcatel用户"
case else
MsgBox "root用户"
End Select
crt.Dialog.MessageBox SwitchKey
screenrow=crt.screen.CurrentRow
crt.Screen.Send "help" & VbCr
crt.Sleep 2000
getscreen = crt.Screen.Get2(screenrow-3,1,screenrow-1,41)
crt.Dialog.MessageBox getscreen

crt.Screen.Synchronous = False 
