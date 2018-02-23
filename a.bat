<# :
@echo off
rem 增强代码兼容性,代码保存为 ".bat"、".cmd"、".ps1"均可执行
powershell Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
more +8 "%~f0" >"%~dpn0.ps1"
powershell -File "%~dpn0.ps1"
del "%~dpn0.ps1" & exit /b
#>
$stime = get-date
$stime
get-date