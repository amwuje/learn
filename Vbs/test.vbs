#$language = "VBScript"
#$interface = "1.0"
Dim SwitchKey
Dim LocalIp 
  crt.Screen.Synchronous = True
  crt.Screen.WaitForString "choice:"
  crt.Sleep 500
  crt.Screen.Send "1"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "No:"
  crt.Sleep 500
  crt.Screen.Send "10.151.130.41"  & VbCr
  crt.Sleep 500 
  crt.Screen.WaitForString "No:"
  crt.Sleep 500
  crt.Screen.Send "0"  & VbCr
  crt.Sleep 500   
  crt.Screen.WaitForString ">"
  crt.Sleep 1000
  crt.Screen.Send "su -"  & VbCr
  crt.Sleep 500
  crt.Screen.Send "WAP_hsl3fc01"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#"
  crt.Screen.Synchronous = False 
