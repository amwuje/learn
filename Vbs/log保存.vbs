# $language = "VBScript"
# $interface = "1.0"
'============================================================================================='
'		�������ƣ�VBS�Ի���.vbS
'		����˵����VBS�Ի���
'		���ߣ�����
'		������ʱ��:20170628
'============================================================================================='
Function writelog(name)
	Dim logfilename
	strPath = BrowseForFolder("��ѡ��LOG��������Ŀ¼")
	logfilename =strPath & name &".log"
	'MsgBox logfilename
	crt.session.LogFileName = logfilename
	crt.session.Log(true)
End Function

'ѡ��Ŀ¼
Function BrowseForFolder(ByVal strTips)
  Dim objFolder
  Set objFolder = CreateObject("Shell.Application").BrowseForFolder (&H0, strTips, &H0010 + &H0001)
  If (Not objFolder Is Nothing) Then BrowseForFolder = objFolder.Self.Path  'objFolder.Items().Item().Path
End Function

Sub Main()
	writelog"test"
End sub


