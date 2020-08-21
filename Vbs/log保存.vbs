# $language = "VBScript"
# $interface = "1.0"
'============================================================================================='
'		程序名称：VBS对话框.vbS
'		程序说明：VBS对话框
'		作者：黄彰
'		最后更新时间:20170628
'============================================================================================='
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


