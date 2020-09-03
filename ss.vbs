cwd = CreateObject("Scripting.FileSystemObject").GetFile(Wscript.ScriptFullName).ParentFolder.Path
path = cwd & "\wsl2port.ps1"
 
Set shell = CreateObject("Shell.Application")
shell.ShellExecute path,"","","runas",1
 
WScript.Quit