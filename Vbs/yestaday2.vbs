# $language = "VBScript"
# $interface = "1.0"
'============================================================================================='
'		�������ƣ�Auto.vbS
'		����˵����SG/DRA �Զ�ͳ��
'		���ߣ�����
'		������ʱ��:20190416
'		20190315 ����ԭʼͳ��log�ļ�����
'		20190315 ����ԭʼͳ���������ѡ��·��
'   20190416 ����P6�� alluptime����鿴�忨����״̬
'============================================================================================='


    Dim y, m, d, h, mm, s,dateFormat
    my_date1 = DateAdd("d", -1, Date)
		my_date2 = DateAdd("d", -0, Date)    
    y = DatePart("yyyy",my_date1)
    m = Right("0" & DatePart("m",my_date1),2)
    d1 =Right("0" & DatePart("d",my_date1),2)
    d2 =Right("0" & DatePart("d",my_date2),2)
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
'��ָ�������ڸ�ʽת��Ϊ��YYMMDD
		dateFormat1 = y & m & d1   
'��ָ�������ڸ�ʽת��Ϊ��YY-MM-DD
		dateFormat2 = y &"-"& m &"-"&d1  '��ָ�������ڸ�ʽת��Ϊ��YY-MM-DD-hh-mm-ss
		dateFormat3 = y & m & d2 & h

	'Msgbox dateFormat1
	'Msgbox dateFormat2
	'Msgbox dateFormat3