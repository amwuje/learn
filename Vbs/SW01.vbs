#$language = "VBScript"
#$interface = "1.0"
  
  crt.Screen.Synchronous = True
  crt.Screen.WaitForString ">"
  crt.Sleep 500
  crt.Screen.Send "ssh sw01@10.151.130.2"  & VbCr
  crt.Sleep 1000
  crt.Screen.Send "Asbwap#1sw01"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#"
  crt.Sleep 500
  crt.Screen.Send "enable"  & VbCr
  crt.Sleep 1000
  crt.Screen.Send "Wap2_networkssw01"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#"
  crt.Screen.Synchronous = False 
  


