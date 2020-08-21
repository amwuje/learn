# $language = "VBScript"
# $interface = "1.0"
'============================================================================================='
'		程序名称：VBS对话框.vbS
'		程序说明：VBS对话框
'		作者：黄彰
'		最后更新时间:20170628
'============================================================================================='
'Sub main()
'	Set objDialog = crt.CreateObject("SAFRCFileDlg.FileSave")  
'	Set objFSO = crt.CreateObject("Scripting.FileSystemObject")  
'	objDialog.FileName = InputBox("文件名称：","文件名","Test")  
'	objDialog.FileType = InputBox("文件类型：","类型",".txt")  
'	intReturn = objDialog.OpenFileSaveDlg  
'	If intReturn Then  
'		objFSO.CreateTextFile objDialog.FileName & objDialog.FileType,True,True  
'	Else  
'		crt.Quit  
'	End If  
'	if not continue("Do you wish to continue","Continue?") Then exit sub
'	if not continue("The time is now:"&time&"Do you wish to continue?","How about now?") Then exit sub
'	Msgbox"感谢！"
'End Sub
'		
'Function continue(strMsg,strTitle)
'	If Msgbox(strMsg,vbyesno + vbQuestion +vbdefaultbutton1,strTitle)<>vbyes then
'		continue=False
'	Else
'		continue=True
'	End if
'End Function


Function writelog(name)
	Dim logfilename
	strPath = BrowseForFolder("请选择LOG保存所在目录")
	logfilename =strPath & name &".log"
	'MsgBox logfilename
	crt.session.LogFileName = logfilename
	crt.session.Log(true)
End Function

'选择目录
Function BrowseForFolder(ByVal strTips)
  Dim objFolder
  Set objFolder = CreateObject("Shell.Application").BrowseForFolder (&H0, strTips, &H0010 + &H0001)
  If (Not objFolder Is Nothing) Then BrowseForFolder = objFolder.Self.Path  'objFolder.Items().Item().Path
End Function

Sub Main()
	writelog"test"
End sub


