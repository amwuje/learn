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


'��ȡǰһ������
Dim yestaday1 yestaday2
my_date1 = DateAdd("d", -1, Date)

'��ָ�������ڸ�ʽת��Ϊ��YY-MM-DD
yestaday1 = DatePart("yyyy",my_date1) & "-" & Right("0" & DatePart("m",my_date1), 2) & "-" & Right("0" & DatePart("d",my_date1),2)
'��ָ�������ڸ�ʽת��Ϊ��YYMMDD
yestaday2 = DatePart("yyyy",my_date1) &Right("0" & DatePart("m",my_date1), 2)  & Right("0" & DatePart("d",my_date1),2)
MsgBox yestaday1
MsgBox yestaday2

'��ȡ��ǰ����
ystr=year(Now)

mstr=Month(Now)

if len(mstr)<2 then mstr="0"&mstr

dstr=day(Now)

if len(dstr)<2 then dstr="0"&dstr

dateml=ystr&mstr&dstr

msgbox(dateml)