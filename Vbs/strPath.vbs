# $language = "VBScript"
# $interface = "1.0"
'============================================================================================='
'		�������ƣ�strPath
'		����˵������ε����ļ���ѡ��򣬻�ȡ�û�ѡ���·����
'		���ߣ�����
'		������ʱ��:20190313
'============================================================================================='

'ʾ��
strPath = BrowseForFolder("��ѡ�񱣴�Ŀ¼��")
Msgbox "��ѡ��λ���ǣ�" & vbCrLf & strPath

' ����ļ���
Function BrowseForFolder(ByVal strTips)
  Dim objFolder
  Set objFolder = CreateObject("Shell.Application").BrowseForFolder (&H0, strTips, &H0010 + &H0001)
  If (Not objFolder Is Nothing) Then BrowseForFolder = objFolder.Self.Path  'objFolder.Items().Item().Path
End Function