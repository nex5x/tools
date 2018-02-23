@echo off &&@if /i "%ed%" == "on" echo on

if /i "%1" == "/h" goto tips
if /i "%1" == "/?" goto tips
if /i "%1" == "" goto tips
if /i "%1" == "/l" goto port2task
if  %1 lss 65535 if %1 gtr 1 goto port2task

:task2port
for /f "tokens=1,2" %%i in ('tasklist  ^|  find /i "%1"') do echo %%i && netstat -ano | find "%%j"
goto end

:port2task
if  "%1" == "/l" (
	set pp=0.0.0.0:0
)else ( set pp=:%1
)
echo ListenPort	 	Process
echo ============================
for /f "tokens=2,3,7 delims=: " %%h in ('netstat -ano^|findstr /c:"%pp% "^|findstr /i  listen') do for /f "tokens=1" %%s in ('tasklist /nh /fi "pid eq %%j"') do echo %%h	: %%i	 	%%s
set pp=
goto end


:tips

echo PortTask  [ 1~65535 ^| ProgramName ]

:end