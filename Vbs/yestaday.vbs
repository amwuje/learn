# $language = "VBScript"
# $interface = "1.0"
'============================================================================================='
'		程序名称：Auto.vbS
'		程序说明：SG/DRA 自动统计
'		作者：黄彰
'		最后更新时间:20190416
'		20190315 新增原始统计log文件保存
'		20190315 新增原始统计输出可以选择路径
'   20190416 新增P6版 alluptime命令查看板卡运行状态
'============================================================================================='


'获取前一天日期
Dim yestaday1 yestaday2
my_date1 = DateAdd("d", -1, Date)

'把指定的日期格式转换为：YY-MM-DD
yestaday1 = DatePart("yyyy",my_date1) & "-" & Right("0" & DatePart("m",my_date1), 2) & "-" & Right("0" & DatePart("d",my_date1),2)
'把指定的日期格式转换为：YYMMDD
yestaday2 = DatePart("yyyy",my_date1) &Right("0" & DatePart("m",my_date1), 2)  & Right("0" & DatePart("d",my_date1),2)
MsgBox yestaday1
MsgBox yestaday2

'获取当前日期
ystr=year(Now)

mstr=Month(Now)

if len(mstr)<2 then mstr="0"&mstr

dstr=day(Now)

if len(dstr)<2 then dstr="0"&dstr

dateml=ystr&mstr&dstr

msgbox(dateml)