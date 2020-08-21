#$language = "VBScript"
#$interface = "1.0"
  
  crt.Screen.Synchronous = True
  crt.Screen.WaitForString "1"
  crt.Sleep 500
  crt.Screen.Send chr(13)
  crt.Sleep 500
  crt.Screen.WaitForString "password"
  crt.Sleep 500
  crt.Screen.Send "123"  & VbCr
  crt.Sleep 1500 
  crt.Screen.Send chr(27)
  crt.Sleep 500   
  crt.Screen.Send chr(27)
  crt.Sleep 500 
  crt.Screen.Send chr(27)
  crt.Sleep 500 
  crt.Screen.Send chr(27)
  crt.Sleep 500 
  crt.Screen.Send chr(27)
  crt.Sleep 1000
  crt.Screen.Send chr(13)
  crt.Sleep 500
  crt.Screen.Send chr(27)
  crt.Sleep 500 
  crt.Screen.Send chr(27)
  crt.Sleep 500
  crt.Screen.Send chr(13)
  crt.Sleep 500
  crt.Screen.Send chr(27)
  crt.Sleep 500
  crt.Screen.Send chr(13)  
  crt.Screen.Synchronous = False 
