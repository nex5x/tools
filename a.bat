<# :
@echo off
rem ��ǿ���������,���뱣��Ϊ ".bat"��".cmd"��".ps1"����ִ��
powershell Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
more +8 "%~f0" >"%~dpn0.ps1"
powershell -File "%~dpn0.ps1"
del "%~dpn0.ps1" & exit /b
#>
$stime = get-date
$stime
get-date