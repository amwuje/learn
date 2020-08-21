# $language = "VBScript"
# $interface = "1.0"
' =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  = '
'		程序名称：copy.vbS
'		程序说明：自动备份
'		作者：黄彰
'		最后更新时间:20190416
' =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  = '

'获取前一天日期
    Dim y, m, d, h, mm, s,dateFormat
    my_date1 = DateAdd("d", -1, Date)
		my_date2 = DateAdd("d", -0, Date)    
    y = DatePart("yyyy",my_date1)
    m = Right("0" & DatePart("m",my_date1),2)
    d1  = Right("0" & DatePart("d",my_date1),2)
    d2  = Right("0" & DatePart("d",my_date2),2)
    h = Hour(now)
    mm = Minute(now)
    s = Second(now)   
    If Len(m) = 1 Then
        m = "0" & m
    End If
    If Len(d1) = 1 Then
        d1 = "0" & d1
    End If
    If Len(d2) = 1 Then
        d2 = "0" & d2
    End If
    If Len(h) = 1 Then
        h = "0" & h
    End If
    If Len(mm) = 1 Then
        mm = "0" & mm
    End If
    If Len(s) = 1 Then
        s = "0" & s
    End If    
'当前时间的前一天并且格式转换为：YYMMDD
		dateFormat1 = y & m & d1   
'当前时间的前一天并且格式转换为：YY-MM-DD
		dateFormat2 = y &"-"& m &"-"&d1  '把指定的日期格式转换为：YY-MM-DD-hh-mm-ss
'当前时间并且格式转换为：YYMMDDhh
		dateFormat3 = y & m & d2 & h

	'Msgbox dateFormat1
	'Msgbox dateFormat2
	'Msgbox dateFormat3


'获取当前脚本文件路径
	Dim fileSystemObject,currPath,strPath
  	Set fileSystemObject = CreateObject("Scripting.FileSystemObject")	
	'currPath = fileSystemObject.getFolder(".").Path		' 获取当前脚本所在路径
	'strPath = BrowseForFolder("Please select a directory:")  '弹出对话框选择统计输出路径
	currPath = "D:\5020SG\AutoTotal"	' 手动定义文件路径
	'currPath = strPath
	'crt.Dialog.MessageBox currPath	
	'Msgbox "你选的位置是：" & vbCrLf & strPath
' 创建结果文件目录
	If(fileSystemObject.FolderExists(currPath &"\" &dateFormat2) = False) Then	' 创建结果文件目录
		fileSystemObject.createFolder(currPath &"\" &dateFormat2)
	End If
	
'定义Total, Alarm LOG路径
	dim draFile,draFile1,stpFile,stpFile1,fileAlarm
	draFile = currPath&"\DRA_Total.CSV"
	draFile1 = currPath&"\"&dateFormat2&"_DRA_Total.CSV"
	'draFile1 = currPath&"\" &dateFormat2&"\"&dateFormat2&"_DRA_Total.CSV"
	stpFile = currPath&"\STP_Total.CSV"
	stpFile1 = currPath&"\" &dateFormat2&"\"&dateFormat2&"_STP_Total.CSV"
	fileAlarm = currPath&"\" &dateFormat2&"\"&dateFormat2&"_"
	fileTmp = currPath&"\" &dateFormat2&"\Tmp\"&dateFormat2&"_"
	
	fileSystemObject.CopyFile draFile,draFile1
' 浏览文件夹
Function BrowseForFolder(ByVal strTips)
  Dim objFolder
  Set objFolder = CreateObject("Shell.Application").BrowseForFolder (&H0, strTips, &H0010 + &H0001)
  If (Not objFolder Is Nothing) Then BrowseForFolder = objFolder.Self.Path  'objFolder.Items().Item().Path
End Function
