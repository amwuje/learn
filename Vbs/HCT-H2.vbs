#$language = "VBScript"
#$interface = "1.0"
  
  crt.Screen.Synchronous = True

  crt.Screen.WaitForString "#"
  crt.Sleep 500
  crt.Screen.Send "telnet 172.16.100.0"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "login:"
  crt.Sleep 500
  crt.Screen.Send "root"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "Password:"
  crt.Sleep 500 
  crt.Screen.Send "softswitch"  & VbCr
  crt.Sleep 500 
  crt.Screen.WaitForString "#"
  crt.Sleep 500
  crt.Screen.Send "smv"  & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">"
  crt.Sleep 500
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
  crt.Sleep 1500
  crt.Screen.Send "ll"  & VbCr & VbCr  & VbCr & VbCr  & VbCr & VbCr  & VbCr & VbCr & VbCr
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "cat *_eabs_*.log"  & VbCr
  crt.Screen.WaitForString ">"
  crt.Sleep 1500
  crt.Screen.Send "ll"  & VbCr & VbCr & VbCr & VbCr & VbCr  & VbCr
  crt.Screen.WaitForString ">"
  crt.Sleep 500
  crt.Screen.Send "cat *_unix_*.log"  & VbCr
  crt.Screen.WaitForString "+ checking end +"
  crt.Sleep 500
  crt.Screen.Send "ll"  & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr
  crt.Screen.WaitForString ">"
  crt.Sleep 500 
  crt.Screen.Send "cat *_s12_*.log"  & VbCr
  crt.Screen.WaitForString "+ checking end +"
  crt.Sleep 500
  crt.Screen.Send "ll"  & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr & VbCr
  crt.Screen.WaitForString ">"
  crt.Sleep 500
  crt.Screen.Send "telnet 172.16.101.101" & VbCr
  crt.Screen.WaitForString "FlexManager login:" 
  crt.Screen.Send "admin"  & VbCr
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "fans"   & VbCr
  crt.Sleep 1200
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "faults" & VbCr
  crt.Sleep 1200
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "hainfo" & VbCr
  crt.Sleep 1200
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "exit"   & VbCr
  crt.Screen.WaitForString ">" 
  crt.Screen.Send  VbCr & VbCr 
  crt.Screen.Send "telnet 172.16.101.102" & VbCr
  crt.Screen.WaitForString "FlexManager login:" 
  crt.Screen.Send "admin"  & VbCr
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "fans"   & VbCr
  crt.Sleep 1200
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "faults" & VbCr
  crt.Sleep 1200
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "hainfo" & VbCr
  crt.Sleep 1200                
  crt.Screen.WaitForString ">"
  crt.Screen.Send "exit"   & VbCr
  crt.Screen.WaitForString ">" 
  crt.Screen.Send  VbCr & VbCr 
  crt.Screen.Send "telnet 172.16.101.105" & VbCr
  crt.Screen.WaitForString "FlexManager login:" 
  crt.Screen.Send "admin"  & VbCr
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "fans"   & VbCr
  crt.Sleep 1200
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "faults" & VbCr
  crt.Sleep 1200
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "hainfo" & VbCr
  crt.Sleep 1200                
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "exit"   & VbCr
  crt.Screen.WaitForString ">" 
  crt.Screen.Send  VbCr & VbCr 
  crt.Screen.Send "telnet 172.16.101.106" & VbCr
  crt.Screen.WaitForString "FlexManager login:" 
  crt.Screen.Send "admin"  & VbCr
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "fans"   & VbCr
  crt.Sleep 1200
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "faults" & VbCr
  crt.Sleep 1200
  crt.Screen.WaitForString ">" 
  crt.Screen.Send "hainfo" & VbCr
  crt.Sleep 1200                
  crt.Screen.WaitForString ">" 
  crt.Sleep 500
  crt.Screen.Send "exit"   & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Sleep 500
  crt.Screen.Send "listalarm"   & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString ">" 
  crt.Sleep 500
  crt.Screen.Send "exit"   & VbCr
  crt.Sleep 500
  crt.Screen.WaitForString "#"
  crt.Screen.Send "exit"   & VbCr
  crt.Session.Disconnect
  
  'tail -400 /var/log/messages|grep ntp" & VbCr'    
  'lsgw 10.0.59.23 % 也可以后面跟IP,可看出该IP的LINE数量及电路的状态'
  'Chr(3)  --->ctrl+c'
  'Chr(29) --->ctrl+]' 
  'ct spa | mgrep ‘10.0.85.134’'
  'grep -i fatal SeTraceXXXX   '
  'topa ' 
  'caohejing:OAMMGR-1-A:/usr/local/sbin>expert_check.pl
  'caohejing:OAMMGR-1-A:/var/log/sp/trace>ct spa | mgrep '10.10.128.67' 
  'tail -f SeTrace | trace_filt | grep sipce-1   

  crt.Screen.Synchronous = False  
  


