@echo off &&@if /i "%ed%" == "on" echo on


if /i "%1" == "/?" goto tips
if /i "%1" == "/s" goto sleep
if /i "%1" == "/r" goto reboot
if /i "%1" == "/h" goto HIBERNATE
if /i "%1" == "/l" goto lock
if /i "%1" == "/off" goto shutdown
goto tips

:sleep
powercfg -h off
rundll32.exe powrprof.dll,SetSuspendState 0,1,0
powercfg -h on
goto end

:HIBERNATE
shutdown /h
goto end

:reboot
shutdown -r -t 0
goto end

:shutdown
shutdown -s -t 0
goto end

:lock
rundll32.exe user32.dll,LockWorkStation
goto end

:tips
echo  Power  [ /S ^| /H ^| /R ^| /L ^| /off ]
echo           /S   : Sleep
echo           /H   : HIBERNATE
echo           /R   : Reboot
echo           /L   : Lock Computer
echo           /off  : Shutdown

:end
