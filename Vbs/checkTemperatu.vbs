#$language = "VBScript"
#$interface = "1.0"
'||=================================||
'||Query BackBone Switch Temperature||
'||Edit By 王敩                     ||
'||2009-6-26                        ||
'||Ver 1.0                          ||
'||=================================||

'===========Start Define Global Parameters=========
Dim FSO
Dim line
Dim SwitchArr(4,3)  '设备列表，行数代表设备数量，列用于存放相关数据
Dim SplitKeyW(4,2) '取字符用关键字列表
Dim TempString '临时存放温度相关行
Dim NowRow '存放当前光标所在行号
'常量定义
Const ForReading = 1
Const ForAppending=8
Const ForWriting=2
Const HighTemperatureAlarmFile="D:\SecureScript\roomtemphigh.wav"
Const HighTemperatureShowFile="D:\温度过高.txt"
beep = chr(007)
'定义数据库连接
Set conn=CreateObject("ADODB.Connection")
conn.Open"driver={sql server};server=x.x.x.x;uid=sa;pwd=sa;"&"database=NMC;"
'数组定义
SwitchArr(0,0)="x.x.x.x"
SwitchArr(0,1)="19"  '代表温度关键字所在的行，用于SecureCRT
SwitchArr(0,2)="设备一"
SwitchArr(1,0)="y.y.y.y"
SwitchArr(1,1)="4"
SwitchArr(1,2)="设备二"
SwitchArr(2,0)="z.z.z.z"
SwitchArr(2,1)="4"
SwitchArr(2,2)="设备三"
SwitchArr(3,0)="w.w.w.w"
SwitchArr(3,1)="4"
SwitchArr(3,2)="设备四"
SplitKeyW(0,0)="temperature:"    '温度字符前面的字符
SplitKeyW(0,1)="C"               '温度字符后面的字符
SplitKeyW(1,0)="="
SplitKeyW(1,1)="degre"
SplitKeyW(2,0)="="
SplitKeyW(2,1)="degre"
SplitKeyW(3,0)="="
SplitKeyW(3,1)="degre"
'==============================Main Sub=======================================================
Sub main
    '数据库路径及连接参数
    pass="*******"      '登陆设备的密码
    username="*******"  '登陆设备的用户名
 For i=0 To 3 
   '连接设备，通过堡垒主机中转
  crt.Screen.WaitForString "2,3]"
  crt.Screen.Send "1" & VbCr
  crt.Screen.WaitForString "ip address and Enter:"
  crt.Screen.Send SwitchArr(i,0) & VbCr
  
  'crt.sleep 2000
  If (crt.Screen.WaitForString("Username:",5))=True Then
   crt.Screen.Send username & VbCr
   crt.Screen.WaitForString("Password:")
   crt.Screen.Send pass & VbCr
   crt.Screen.WaitForString ">",5
   crt.Screen.Send "show environment temperature" & VbCr
   crt.Screen.WaitForString ">",5
   NowRow=crt.Screen.CurrentRow '取得当前光标所在行号
   TempString=crt.Screen.Get2 (NowRow-Int(SwitchArr(i,1)),1,NowRow-Int(SwitchArr(i,1)),50)  '提取温度所在行

   KeyStringStart=InStr(TempString,SplitKeyW(i,0))
   KeyStringEnd=InStr(TempString,SplitKeyW(i,1))
   If KeyStringStart<>0 And KeyStringEnd<>0 Then
    TemperatureStr=Mid(TempString,KeyStringStart+Len(SplitKeyW(i,0)),KeyStringEnd-(KeyStringStart+Len(SplitKeyW(i,0))))
    '温度大于36度报警，一般36度对应机房温度在23度左右
    If Int(TemperatureStr)>36 Then
     set wshShell = CreateObject("wscript.Shell")
     '使用文本文件显示报警，同时播放五次声音
     WshShell.Run "cmd /c @echo 时间：{"&Now()&"}机房：{"&SwitchArr(i,2)&"温度过高:"&TemperatureStr&"度}>"&HighTemperatureShowFile
     WshShell.Run "notepad.exe "&HighTemperatureShowFile
     'WshShell.Run "cmd /c @echo " & beep& beep& beep& beep, 0
     WshShell.Run HighTemperatureAlarmFile
     crt.sleep 2000
     WshShell.Run HighTemperatureAlarmFile
     crt.sleep 2000
     WshShell.Run HighTemperatureAlarmFile
     crt.sleep 2000
     WshShell.Run HighTemperatureAlarmFile
     crt.sleep 2000
    End If 
    '准备将温度写入数据库
    strSqlInsert="insert into AutoLog_RoomTemperature (TemperatureTime,Temperature,TemperatureRoom) values ('"&Now()&"','"&TemperatureStr&"','"&SwitchArr(i,2)&"')"
    conn.Execute(strSqlInsert)
   Else
    set wshShell = CreateObject("wscript.Shell")
    WshShell.Run "cmd /c @echo 时间：{"&Now()&"}机房：{"&SwitchArr(i,2)&"关键字出错,开始字符:{"&KeyStringStart&"}结束字符:{"&KeyStringEnd&"}"
    WshShell.Run "notepad.exe "&HighTemperatureShowFile
   End If
   crt.Screen.Send "exit" & VbCr
  End If
 Next
 crt.Screen.WaitForString "2,3]"
 crt.Screen.Send "3" & VbCr
 crt.session.disconnect()
 crt.quit
End Sub