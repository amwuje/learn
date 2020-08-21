#$language = "VBScript"
#$interface = "1.0"

'============================================================================================='
'		程序名称：currPath.vbS
'		程序说明：获取当前脚本文件路径
'		作者：黄彰
'		最后更新时间:20190219
'============================================================================================='

Function currPath()
	Dim fileSystemObject
  Set fileSystemObject = CreateObject("Scripting.FileSystemObject")
  currPath = fileSystemObject.getFolder(".").Path		' 获取当前文件路径
	crt.Dialog.MessageBox currPath	
End Function

Sub main
	currPath
End sub