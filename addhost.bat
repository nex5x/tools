@echo off &&@if /i "%ed%" == "on" echo on

if "%1" == "" goto showhost
if "%1" == "/?" goto showuseage
if "%1" == "/e" goto edit
if "%2" == "" goto addlocal

copy c:\Windows\System32\drivers\etc\hosts c:\Windows\System32\drivers\etc\hosts.bak
echo %1 %2 >> c:\Windows\System32\drivers\etc\hosts
goto end

:showuseage
echo addhost IP    host -- add a new record
echo addhost IP_or_host -- add 127.0.0.1 
echo addhost  /e 	-- Edit
goto end

:addlocal
echo 127.0.0.1 %1 >> c:\Windows\System32\drivers\etc\hosts
goto end

:edit
C:\Prog\NoteXPad\NoteXPad.exe c:\Windows\System32\drivers\etc\hosts
goto end

:showhost
type c:\Windows\System32\drivers\etc\hosts
:end