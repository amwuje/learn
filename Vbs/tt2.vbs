#$language = "VBScript"
#$interface = "1.0"
   Dim SwitchKey
   Dim LocalIp

LocalIp = crt.Dialog.Prompt("������Local IP,ʹ��Ĭ�Ͽɲ���IP", "Local IP", "199.0.0.244", False)
  crt.Screen.Synchronous = True 

SwitchKey=crt.Screen.WaitForStrings("nxuser","oracle","alcatel",5)
crt.Dialog.MessageBox LocalIp
Select case SwitchKey
case 1
MsgBox "nxuser�û�"
case 2
MsgBox "oracle�û�"
case 3
MsgBox "alcatel�û�"
case else
MsgBox "root�û�"
End Select
crt.Dialog.MessageBox SwitchKey
screenrow=crt.screen.CurrentRow
crt.Screen.Send "help" & VbCr
crt.Sleep 2000
getscreen = crt.Screen.Get2(screenrow-3,1,screenrow-1,41)
crt.Dialog.MessageBox getscreen

crt.Screen.Synchronous = False 
