@echo off &&@if /i "%ed%" == "on" echo on

if "%1" == "" goto usage
if "%2" == "" goto usage
if /i "%2" == "/d" goto dhcp
if /i "%2" == "dhcp" goto dhcp_d
if /i "%2" == "/dhcp" goto dhcp_d
if /i "%2" == "/r" goto restart_interface
if /i "%2" == "/dns" goto dns
if /i "%2" == "/ics" goto ics
if /i "%2" == "/1" goto set1

if "%3" == "" goto no_gw
if /i "%3" == "/b"  goto set_b
if /i "%4" == "/b" (netsh in ip se ad %1 static %2 255.255.0.0 %3 1) else (netsh in ip se ad %1 static %2 255.255.255.0 %3 1)

goto end

:no_gw
netsh in ip se ad %1 static %2 255.255.255.0
goto end

:set_b
netsh in ip se ad %1 static %2 255.255.0.0
goto end

:dhcp
netsh in ip se ad "%1" dhcp
goto end

:dns
if "%3" == "" goto usage
if "%3" == "/114" goto dns_114
if "%3" == "/g" goto dns_google
if "%3" == "/202" goto 202
if "%3" == "/b" goto baidu
if "%3" == "/a" goto ali
if "%3" == "/pod" goto pod
if "%3" == "/d" goto dns_dhcp
netsh in ip se dn %1 static %3
goto end 
:dns_google
netsh in ip se dn %1 static 8.8.8.8
netsh in ip ad dn %1 114.114.114.114
goto end
:dns_114
netsh in ip se dn %1 static 114.114.114.114
netsh in ip ad dn %1 8.8.8.8
goto end:202
netsh in ip se dn %1 static 202.106.196.115
netsh in ip ad dn %1 114.114.114.114
goto end
:baidu
netsh in ip se dn %1 static 180.76.76.76
netsh in ip ad dn %1 114.114.114.114
goto end
:ali
netsh in ip se dn %1 static 223.5.5.5
netsh in ip ad dn %1 114.114.114.114
goto end
:pod
netsh in ip se dn %1 static 119.29.29.29
netsh in ip ad dn %1 114.114.114.114
goto end
:dns_dhcp
netsh in ip se dn %1 dhcp
goto end

:dhcp_d
netsh in ip se ad "%1" dhcp
netsh in ip se dn "%1" dhcp
goto end

:restart_interface
netsh in se in %1 disabled
if /i "%3" == "/d" (
net stop dhcp /y
rem choice /t 25 /d y /n >nul 
timeout /t 25
net start dhcp)
netsh in se in %1 enable
timeout /t 10
netsh in ip sh config %1
goto end

:ics
cscript /nologo c:\prog\tools\ics.vbs "ap" "%1" %3
goto end

:set1
netsh in ip se ad %1 static 192.168.1.191 255.255.255.0 192.168.1.254 1
goto end

:usage
Echo  Usage : setip [Interface] IPaddress^|dhcp[/d]^|/dns^|ics  [gateway^|/b^|dns_ip^|/r [/d^|/dr]]
:end
