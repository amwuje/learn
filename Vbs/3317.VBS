# $language = "VBScript"
# $interface = "1.0"
'============================================================================================='
'        程序名称：.VBS
'        程序说明：S12里面自动执行命令脚本
'        作者：黄彰
'        完成时间：2017-5-25
'============================================================================================='
dim mm
mm="MM"

Function  setline
        crt.screen.send mm & Chr(13)
		'crt.Sleep 1000
End Function


Function setcommand(cmdstr, sec)
        setline
		crt.screen.WaitForString ">" 
        sec = sec * 1000
		crt.screen.send cmdstr & Chr(13)
        crt.Sleep sec
End Function


'3317
Function get_machinfo

setcommand "3317:GTAR=E164_INTAL_TT0,DN=K'86106477332.",2
setcommand "3317:GTAR=E164_INTAL_TT0,DN=K'86106477333.",2
setcommand "3317:GTAR=E164_INTAL_TT0,DN=K'86106477334.",2
setcommand "3317:GTAR=E164_INTAL_TT0,DN=K'86106477335.",2

End Function

Sub Main 
    '3317 
    get_machinfo 
End Sub 