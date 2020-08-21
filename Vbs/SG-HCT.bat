@echo "kill CRT process"
taskkill /F /IM SecureCRT.exe
start D:\SecureCRT\SecureCRT.EXE /SCRIPT %~dp0SG-HCT_V6.vbs
pause