@echo off
if "%1" neq "" goto next
mshta vbscript:createobject("wscript.shell").run("%~fs0 "^&date-1,1,0)(window.close)
goto :eof
:next
for /f "tokens=1-3 delims=/-\:" %%a in ("%1") do  set "y=%%a"&set "m=0%%b"&set "d=0%%c"
set "str=%y%%m:~-2%%d:~-2%"
echo 昨天的日期为：%str%
pause>nul