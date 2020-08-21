#$language = "VBScript"
#$interface = "1.0"

  crt.Screen.Synchronous = True 
  crt.Screen.WaitForString "#"
  crt.Sleep 500
  crt.Screen.Send "ls" & VbCr
  crt.Sleep 500
  Dim aa
  aa = crt.Dialog.Prompt("请输入命令,使用默认可不填", "Local IP", "pwd", False)
  crt.Screen.Send aa & VbCr
  crt.Sleep 500
  crt.Sleep 500
  crt.Screen.Send LocalIp & VbCr
  crt.Sleep 500
  Dim bb
  bb = crt.Dialog.Prompt("请输入Local IP,使用默认可不填IP", "Local IP", "114.114.114.114", False)
  crt.Screen.Send bb & VbCr
   Dim SwitchKey
SwitchKey=crt.Screen.WaitForStrings("nxuser","oracle","alcatel",5)
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
  crt.Screen.Synchronous = False 
