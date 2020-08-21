@echo "kill CRT process"
taskkill /F /IM SecureCRT.exe
start D:\SecureCRT\SecureCRT.EXE /SCRIPT %~dp0SG_DRA.vbs
pause