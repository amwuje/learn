#$language = "VBScript"
#$interface = "1.0"
  
  crt.Screen.Synchronous = True
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "telnet 172.16.110.3"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "Login:"  
  crt.Screen.Send "diag"   & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "Password:" 
  crt.Screen.Send "-assured"   & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi al ac"   & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi date" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi ch" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi red gr" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi mod tem all" & VbCr
  crt.Sleep 1500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi uptime all" & VbCr
  crt.Sleep 1500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi ip if" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi route table" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi spc tdm2tdm" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "save" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "ls config*" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi ver all" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi clock st" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "rc 1 11" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi clock st" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "exit" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "rc 1 9" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi clock sync" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "exit" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "rc 1 12" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi clock sync" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "exit" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "logout" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "telnet 172.16.110.4"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "Login:"  
  crt.Screen.Send "diag"   & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "Password:" 
  crt.Screen.Send "-assured"   & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi al ac"   & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi date" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi ch" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi red gr" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi mod tem all" & VbCr
  crt.Sleep 1500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi uptime all" & VbCr
  crt.Sleep 1500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi ip if" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi route table" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi spc tdm2tdm" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "save" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "ls config*" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi ver all" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi clock st" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "rc 1 11" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi clock st" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "exit" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "rc 1 9" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi clock sync" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "exit" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "rc 1 12" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "vi clock sync" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "exit" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#" 
  crt.Screen.Send "logout" & VbCr
  crt.Sleep 500
  crt.Screen.Synchronous = False  