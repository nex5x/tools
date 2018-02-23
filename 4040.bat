@echo off &&@if /i "%ed%" == "on" echo on

set sss=-c \Users\karl\AppData\Roaming\npm\node_modules\shadowsocks\bwg.json
if "%1" == "-?" goto :tips
if /i "%1" == "-help" goto :tips
if /i "%1" == "-h" goto :tips
if /i "%1" == "/aws" set sss=-c \Users\karl\AppData\Roaming\npm\node_modules\shadowsocks\aws.json
if /i "%1" == "/st" set sss=-c \Users\karl\AppData\Roaming\npm\node_modules\shadowsocks\st.json
if /i "%1" == "/hk" set sss=-c \Users\karl\AppData\Roaming\npm\node_modules\shadowsocks\hk.json
if /i "%1" == "/b" set sss=-c \Users\karl\AppData\Roaming\npm\node_modules\shadowsocks\bwg.json
if /i "%1" == "/n" set sss=-c \Users\karl\AppData\Roaming\npm\node_modules\shadowsocks\nodeserv.json

:startss
start /min start4040.cmd %sss%
rem  start /min "echo sslocal %sss% |C:\Windows\System32\cmd.exe /k C:\PROGRA~1\nodejs\nodevars.bat"
goto end




:tips
echo Usage : 4040  [/aws]        // With /aws will use AWS,with nothing use VPS


:end
set sss=

