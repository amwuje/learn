# $language = "VBScript"
# $interface = "1.0"
' =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  = '
'		�������ƣ�copy.vbS
'		����˵�����Զ�����
'		���ߣ�����
'		������ʱ��:20190416
' =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  = '

'��ȡǰһ������
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
'��ǰʱ���ǰһ�첢�Ҹ�ʽת��Ϊ��YYMMDD
		dateFormat1 = y & m & d1   
'��ǰʱ���ǰһ�첢�Ҹ�ʽת��Ϊ��YY-MM-DD
		dateFormat2 = y &"-"& m &"-"&d1  '��ָ�������ڸ�ʽת��Ϊ��YY-MM-DD-hh-mm-ss
'��ǰʱ�䲢�Ҹ�ʽת��Ϊ��YYMMDDhh
		dateFormat3 = y & m & d2 & h

	'Msgbox dateFormat1
	'Msgbox dateFormat2
	'Msgbox dateFormat3


'��ȡ��ǰ�ű��ļ�·��
	Dim fileSystemObject,currPath,strPath
  	Set fileSystemObject = CreateObject("Scripting.FileSystemObject")	
	'currPath = fileSystemObject.getFolder(".").Path		' ��ȡ��ǰ�ű�����·��
	'strPath = BrowseForFolder("Please select a directory:")  '�����Ի���ѡ��ͳ�����·��
	currPath = "D:\5020SG\AutoTotal"	' �ֶ������ļ�·��
	'currPath = strPath
	'crt.Dialog.MessageBox currPath	
	'Msgbox "��ѡ��λ���ǣ�" & vbCrLf & strPath
' ��������ļ�Ŀ¼
	If(fileSystemObject.FolderExists(currPath &"\" &dateFormat2) = False) Then	' ��������ļ�Ŀ¼
		fileSystemObject.createFolder(currPath &"\" &dateFormat2)
	End If
	
'����Total, Alarm LOG·��
	dim draFile,draFile1,stpFile,stpFile1,fileAlarm
	draFile = currPath&"\DRA_Total.CSV"
	draFile1 = currPath&"\"&dateFormat2&"_DRA_Total.CSV"
	'draFile1 = currPath&"\" &dateFormat2&"\"&dateFormat2&"_DRA_Total.CSV"
	stpFile = currPath&"\STP_Total.CSV"
	stpFile1 = currPath&"\" &dateFormat2&"\"&dateFormat2&"_STP_Total.CSV"
	fileAlarm = currPath&"\" &dateFormat2&"\"&dateFormat2&"_"
	fileTmp = currPath&"\" &dateFormat2&"\Tmp\"&dateFormat2&"_"
	
	fileSystemObject.CopyFile draFile,draFile1
' ����ļ���
Function BrowseForFolder(ByVal strTips)
  Dim objFolder
  Set objFolder = CreateObject("Shell.Application").BrowseForFolder (&H0, strTips, &H0010 + &H0001)
  If (Not objFolder Is Nothing) Then BrowseForFolder = objFolder.Self.Path  'objFolder.Items().Item().Path
End Function
