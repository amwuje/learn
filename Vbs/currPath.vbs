#$language = "VBScript"
#$interface = "1.0"

'============================================================================================='
'		�������ƣ�currPath.vbS
'		����˵������ȡ��ǰ�ű��ļ�·��
'		���ߣ�����
'		������ʱ��:20190219
'============================================================================================='

Function currPath()
	Dim fileSystemObject
  Set fileSystemObject = CreateObject("Scripting.FileSystemObject")
  currPath = fileSystemObject.getFolder(".").Path		' ��ȡ��ǰ�ļ�·��
	crt.Dialog.MessageBox currPath	
End Function

Sub main
	currPath
End sub