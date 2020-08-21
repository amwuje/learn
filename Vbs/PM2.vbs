#$language = "VBScript"
#$interface = "1.0"
  
  crt.Screen.Synchronous = True
  crt.Screen.WaitForString ">"
  crt.Sleep 500
  crt.Screen.Send "su -"  & VbCr
  crt.Sleep 500
  crt.Screen.Send "WAP_hsl3pm02"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#"
  crt.Sleep 500
  crt.Screen.Synchronous = False 
  



