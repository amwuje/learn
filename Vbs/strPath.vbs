# $language = "VBScript"
# $interface = "1.0"
'============================================================================================='
'		程序名称：strPath
'		程序说明：如何弹出文件夹选择框，获取用户选择的路径。
'		作者：黄彰
'		最后更新时间:20190313
'============================================================================================='

'示例
strPath = BrowseForFolder("请选择保存目录：")
Msgbox "你选的位置是：" & vbCrLf & strPath

' 浏览文件夹
Function BrowseForFolder(ByVal strTips)
  Dim objFolder
  Set objFolder = CreateObject("Shell.Application").BrowseForFolder (&H0, strTips, &H0010 + &H0001)
  If (Not objFolder Is Nothing) Then BrowseForFolder = objFolder.Self.Path  'objFolder.Items().Item().Path
End Function