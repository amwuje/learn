# $language = "VBScript"
# $interface = "1.0"
'============================================================================================='
'        程序名称：SG-HCT.VBS
'        程序说明：SG/DRA HCT巡检脚本
'        作者：黄彰
'        完成时间：20170612
'============================================================================================='

'MyDate 当前系统日期
'Dim MyDate 
'MyDate = Date		
'MsgBox MyDate

'返回当前系统时间
'Dim MyTime 
'MyTime = Time		
'MsgBox MyTime

'获取当前日期方法一
Dim Y
Dim M
Dim D
Dim YDM
Y=Year(Now)
M=Month(Now)
D=Day(Now)
YDM=Y&"-"&M&"-"&D
MsgBox YDM

'获取当前日期方法二
Dim Currentdate1
Currentdate1=date()
msgbox Currentdate1

'获取当前日期方法三
Dim Currentdate2
Currentdate2=year(Now)&"-"&Month(Now)&"-"&day(Now)
msgbox Currentdate2

'获取当前日期方法四
dim ystr
dim mstr
dim dstr
dim datem1
ystr=year(Now)
mstr=Month(Now)
if len(mstr)<2 then mstr="0"&mstr
dstr=day(Now)
if len(dstr)<2 then dstr="0"&dstr
dateml=ystr&"-"&mstr&"-"&dstr
msgbox(dateml)

'获取当前时间
Dim CurrentTime
dim T
CurrentTime=Hour(Now)&":"&Minute(Now)&":"&Second(Now)
T = CurrentTime 
msgbox T

'windows下使用VBS取当前日期的前一天，并修正输出格式
dim my_date1
dim my_date2
my_date1 = DateAdd("d",-1,date)
msgbox my_date1

my_date2 = DatePart("yyyy",my_date1) & "-" & Right("0" & DatePart("m",my_date1), 2) & "-" & Right("0" & DatePart("d",my_date1),2)
msgbox my_date2

my_date3 = DatePart("yyyy",(DateAdd("d",-1,date))) & "-" & Right("0" & DatePart("m",(DateAdd("d",-1,date))), 2) & "-" & Right("0" & DatePart("d",(DateAdd("d",-1,date))),2)
msgbox my_date3

