@echo off &&@if /i "%ed%" == "on" echo on

if /i "%1"=="/a" goto addpath

:showpath
cscript /nologo c:\prog\tools\chara.vbs "%path%"
goto end

:addpath
if "%2"=="" path=%path%;%cd%; & goto end
path=%path%;%~f2;
::::echo [System.Environment]::SetEnvironmentVariable("Path","%path%",[System.EnvironmentVariableTarget]::Machine) >  %~dp0pathtemp.ps1
::::powershell %~dp0pathtemp.ps1
::::del %~dp0pathtemp.ps1

:end
