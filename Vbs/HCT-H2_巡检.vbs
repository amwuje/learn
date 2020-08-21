#$language = "VBScript"
#$interface = "1.0"
  
  crt.Screen.Synchronous = True
  crt.Screen.WaitForString "#"
  crt.Sleep 500
  crt.Screen.Send "smv"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">"
  crt.Sleep 500
  crt.Screen.Send "dns"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">"
  crt.Sleep 500
  crt.Screen.Send "ifconfig -a"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">"
  crt.Sleep 500
  crt.Screen.Send "telnet 172.16.101.101" & VbCr
  crt.Screen.WaitForString "FlexManager login:" 
  crt.Screen.Send "admin"  & VbCr
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "fans"   & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "faults" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "volts" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "hainfo" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "exit"   & VbCr
  crt.Screen.WaitForString ">" 
  crt.Screen.Send  VbCr & VbCr 
  crt.Screen.Send "telnet 172.16.101.102" & VbCr
  crt.Screen.WaitForString "FlexManager login:" 
  crt.Screen.Send "admin"  & VbCr
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "fans"   & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "faults" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "volts" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "hainfo" & VbCr
  crt.Sleep 500                
  crt.Screen.WaitForString ">"
  crt.Screen.Send "exit"   & VbCr
  crt.Screen.WaitForString ">" 
  crt.Screen.Send  VbCr & VbCr 
  crt.Screen.Send "telnet 172.16.101.105" & VbCr
  crt.Screen.WaitForString "FlexManager login:" 
  crt.Screen.Send "admin"  & VbCr
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "fans"   & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "faults" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "volts" & VbCr
  crt.Sleep 500  
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "hainfo" & VbCr
  crt.Sleep 500                
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "exit"   & VbCr
  crt.Screen.WaitForString ">" 
  crt.Screen.Send  VbCr & VbCr 
  crt.Screen.Send "telnet 172.16.101.106" & VbCr
  crt.Screen.WaitForString "FlexManager login:" 
  crt.Screen.Send "admin"  & VbCr
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "fans"   & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "faults" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "volts" & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "hainfo" & VbCr
  crt.Sleep 500                
  crt.Screen.WaitForString ">" 
  crt.Sleep 500
  crt.Screen.Send "exit"   & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Sleep 500
  crt.Screen.Send "st -q"   & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "alluptime"   & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "telnet 172.16.110.3"   & VbCr
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
  crt.Screen.Send "vi fan sta" & VbCr
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
  crt.Screen.Send "telnet 172.16.110.4"   & VbCr
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
  crt.Screen.Send "vi fan sta" & VbCr
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
  crt.Screen.Send "cd /var/log"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "ls"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "df -k"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "cd report"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "ls"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "ll MeasReport/"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "ll backup/"  & VbCr  
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "glt"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">"
  crt.Sleep 500
  crt.Screen.Send "for var in $(ls|tail -15);do cat $var| grep -i ipp;done"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">"
  crt.Sleep 500
  crt.Screen.Send "path=/var/log/HCT/$(date -d yesterday +%Y-%m-%d)"  & VbCr
  crt.Sleep 500
  crt.Screen.Send "cd $path"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">"
  crt.Sleep 500
  crt.Screen.Send "ll"  & VbCr & VbCr  & VbCr 
  crt.Screen.WaitForString ">"
  crt.Sleep 500
  crt.Screen.Send "cat *_summary_*.log"  & VbCr
  crt.Screen.WaitForString ">"
  crt.Sleep 500
  crt.Screen.Send "ll"  & VbCr
  crt.Screen.WaitForString ">"
  crt.Sleep 500
  crt.Screen.Synchronous = False  
  
  
  
  
  
  
  



