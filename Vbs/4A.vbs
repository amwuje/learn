#$language = "VBScript"
#$interface = "1.0"
  crt.Screen.Synchronous = True
  
	dim ystr
	dim mstr
	dim dstr
	dim datem
	Dim CurrentTime
	dim Tim
	ystr=year(Now)
	mstr=Month(Now)
	if len(mstr)<2 then mstr="0"&mstr
	dstr=day(Now)
	if len(dstr)<2 then dstr="0"&dstr
	CurrentTime=Hour(Now)&":"&Minute(Now)&":"&Second(Now)
	Tim = CurrentTime 	
	datem=ystr&"-"&mstr&"-"&dstr&"_"&Tim
	'msgbox(dateml)
Function login4A(no,pass,tab)
	Set objtab = crt.session.ConnectInTab("/telnet 10.243.96.145 9023")
	nError = Err.Number
	strErr = Err.Description
	On Error Goto 0
	objtab.caption =""&tab
	crt.Screen.WaitForString "ogin"
	crt.Sleep 500
	crt.Screen.send "kthuangzhang" & chr(13) 
	crt.Screen.WaitForString "assword:"
	crt.Sleep 500
	crt.Screen.send "@spatial1" & chr(13)
  crt.Screen.WaitForString "choice:"
  crt.Sleep 500
  crt.Screen.Send "1"  & chr(13)
  crt.Sleep 500
  crt.Screen.WaitForString "No:"
  crt.Sleep 500
  crt.Screen.Send no & chr(13)
  crt.Sleep 500 
  crt.Screen.WaitForString "No:"
  crt.Sleep 500
  crt.Screen.Send "0"  & chr(13)
  crt.Sleep 500   
  crt.Screen.WaitForStrings "#","$",">"
  crt.Sleep 500
End Function 

Function writelog(name)
	Dim logfilename
	strPath = BrowseForFolder("请选择LOG保存所在目录")
	logfilename =strPath &"\"& name &"_"&datem&".log"
	'MsgBox logfilename
	crt.session.LogFileName = logfilename
	crt.session.Log(Ture)
End Function

'选择目录
Function BrowseForFolder(ByVal strTips)
  Dim objFolder
  Set objFolder = CreateObject("Shell.Application").BrowseForFolder (&H0, strTips, &H0010 + &H0001)
  If (Not objFolder Is Nothing) Then BrowseForFolder = objFolder.Self.Path  'objFolder.Items().Item().Path
End Function

Sub Main()
	if crt.session.Log(ture)=Ture then
	crt.session.Log(false)
	end if
	dim no
	dim pass
	wy=crt.Dialog.Prompt("请输入网元,使用默认可不填", "输入网元", "HFLDRA1", False)
	Select Case wy
	Case"HFLDRA1"
	no="0"
	pass="Spat705!1"
	Case"HFL6"
	no="1"
	pass="Spat705!1"
	Case"HFLDRA2"
	no="2"
	pass="Spat705!1"
	Case"HFH2"
	no="3"
	pass="Spat705!1"
	Case Else
	End Select
	writelog wy
	login4A no,pass,wy
	crt.Screen.Synchronous = False 
End sub
  