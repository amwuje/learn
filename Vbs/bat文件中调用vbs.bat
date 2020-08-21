@echo "kill CRT process"
taskkill /F /IM SecureCRT.exe
start D:\SecureCRT\SecureCRT.EXE /SCRIPT E:\VBS\Start_vos1.vbs
pause