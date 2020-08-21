#$language = "Python" 
#$interface = "1.0" 
import re import sys import os 
ip=["132.108.19.1","132.108.19.8","132.108.19.10"] 
#ping"检查函数"
# testing report: only by crt 6.6.1 no 
def check_ping(ip): global objtab
objtab.Screen.WaitForString(">") objtab.Screen.Send("ping "+ip+"\n")
szOutput = objtab.Screen.ReadString(["alive","9o>"], 3) index = objtab.Screen.MatchIndex #crt.Dialog.MessageBox("提示 " +ip ) if (index == 0): crt.Dialog.MessageBox("Timed out!")
elif (index == 1): crt.Dialog.MessageBox(ip+" [ping OK")
elif (index == 3):
crt.Dialog.MessageBox(ip+" [Found '>'")
#主程序
def main(): global objtab errcode = 0 try:
	objtab	=	crt.Session.ConnectInTab("/SSH2	/PASSWORD	Hyzsj@11
eric@132.108.19.9",True) except ScriptError:
errcode=crt.GetLastError()
if errcode !=0:
crt.Dialog.MessageBox("connection fialed")
else:
objtab.Activate()
crt.Dialog.MessageBox("程序开始执行!") objtab.Screen.WaitForString(">") objtab.Screen.Send("\n") for s in ip:
check_ping(s)
objtab.Screen.Send("\n") objtab.Screen.WaitForString(">") objtab.Screen.Send("exit \n")
#开始执行
