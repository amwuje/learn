# $language = "VBScript"
# $interface = "1.0"
'============================================================================================='
'        �������ƣ�SG.VBS
'        ����˵����SG/DRAѲ��ű�
'        ���ߣ�����
'        ���ʱ�䣺20170524
'============================================================================================='

'============================================================================================='
'        ����ȫ�ֱ�����
'============================================================================================='
	dim sgip1
	dim sgip2
	dim sgip3
	dim sgip4
	dim sgip5
	dim fesip1
	dim fesip2
	dim fesip3
	dim flxip1
	dim flxip2
	dim flxip3
	dim flxip4
	dim flxip5
	sgip1 ="10.225.80.100"		'HFL6
	sgip1 ="10.1.207.20"			'HFH2
	sgip1 ="10.225.218.21"		'HFLDRA1
	sgip1 ="10.225.218.38"		'HFLDRA2
	sgip1 ="134.96.47.6"		'��ͨHSTPA	
	fesip1="172.16.110.3"		'FES1
	fesip2="172.16.110.4"		'FES2
	fesip3="172.16.110.5"		'FES3
	fesip4="134.96.47.8"		'��ͨFES1
	fesip5="134.96.47.8"		'��ͨFES2
	fexip1="172.16.101.101"	'FLEXMANAGER
	fexip2="172.16.101.102"	'FLEXMANAGER
	fexip3="172.16.101.105"	'FLEXMANAGER
	fexip4="172.16.101.106"	'FLEXMANAGER
	fexip5="172.16.101.109"	'FLEXMANAGER
	fexip5="172.16.101.110"	'FLEXMANAGER

'============================================================================================='
'        ����ȫ�ֳ�����
'============================================================================================='
'��½SG
Function loginsg 
	'��½�û������������ 
	dim passwd
	dim username
	passwd ="Spat705@1"
	username ="root"
	'�������� 
	'����Ļ�����������������ݣ�\r��ʾ�س�ִ��
    crt.Screen.Send("telnet " &sgip& chr(13))
    '�ȴ����ֵ�½�û�����ʾlogin���ȴ�ʱ����10s 
    crt.screen.WaitForString("ogin:",5) 
    '�����û������س� 
    crt.screen.send username & chr(13) 
    '�ȴ����ֵ�½������ʾlogin���ȴ�ʱ����10s 
    crt.screen.WaitForString("assword:",5) 
    '�������룬�س� 
    crt.screen.send passwd & chr(13) 
    If crt.screen.WaitForString("Login incorrect", 3) = True Then 
        result = crt.Dialog.MessageBox("��������½ʧ�ܣ�����IP��ַ���û����������Ƿ�������ȷ��", "��ʾ��Ϣ",ICON_INFO) 
        crt.quit 
    End If 
    crt.screen.Synchronous = false 
End Function 

Sub Main 
    'ϵͳ��½ 
    loginsg 
    '�����Ự��־ 
 
End Sub 