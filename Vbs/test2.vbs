#$language = "VBScript"
#$interface = "1.0"

  crt.Screen.Synchronous = True 
  crt.Screen.WaitForString "#"
  crt.Sleep 500
  crt.Screen.Send "ls" & VbCr
  crt.Sleep 500
  Dim aa
  aa = crt.Dialog.Prompt("����������,ʹ��Ĭ�Ͽɲ���", "Local IP", "pwd", False)
  crt.Screen.Send aa & VbCr
  crt.Sleep 500
  crt.Sleep 500
  crt.Screen.Send LocalIp & VbCr
  crt.Sleep 500
  Dim bb
  bb = crt.Dialog.Prompt("������Local IP,ʹ��Ĭ�Ͽɲ���IP", "Local IP", "114.114.114.114", False)
  crt.Screen.Send bb & VbCr
   Dim SwitchKey
SwitchKey=crt.Screen.WaitForStrings("nxuser","oracle","alcatel",5)
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
  crt.Screen.Synchronous = False 
