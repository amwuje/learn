# $language = "VBScript"
# $interface = "1.0"
'============================================================================================='
'		�������ƣ�VBS�Ի���.vbS
'		����˵����VBS�Ի���
'		���ߣ�����
'		������ʱ��:20170628
'============================================================================================='
'Sub main()
'	Set objDialog = crt.CreateObject("SAFRCFileDlg.FileSave")  
'	Set objFSO = crt.CreateObject("Scripting.FileSystemObject")  
'	objDialog.FileName = InputBox("�ļ����ƣ�","�ļ���","Test")  
'	objDialog.FileType = InputBox("�ļ����ͣ�","����",".txt")  
'	intReturn = objDialog.OpenFileSaveDlg  
'	If intReturn Then  
'		objFSO.CreateTextFile objDialog.FileName & objDialog.FileType,True,True  
'	Else  
'		crt.Quit  
'	End If  
'	if not continue("Do you wish to continue","Continue?") Then exit sub
'	if not continue("The time is now:"&time&"Do you wish to continue?","How about now?") Then exit sub
'	Msgbox"��л��"
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


