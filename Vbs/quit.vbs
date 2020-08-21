# $language = "VBScript"
# $interface = "1.0"

crt.session.disconnect
crt.Quit


	dim n
	n=0
	do
	n=n+1
	crt.Screen.WaitForStrings "#","$",">"
	crt.Sleep 500
    crt.Screen.send "rexec 1 "&n&" vi clock sync" & chr(13)
	if n >20 then
	exit do
	end if
	loop
