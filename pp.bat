@echo off &&@if /i "%ed%" == "on" echo on

set vpnnic=zerotier
if /i "%1" == "/l"  goto list
if "%1" == ""  goto list
if /i "%1" == "/d"  goto removePP
if /i "%1" == "/add"  goto addPPIP
if /i "%1" == "/a"  goto Add2Local
if /i "%1" == "/dz"  goto removePPVPN
if /i "%1" == "/da"  goto removeALL
if /i "%1" == "/default"  goto default
goto usage


:list
netsh interface portproxy show v4tov4
goto end


:addPPIP
if "%2" == ""  goto usage
if "%3" == ""  goto usage
if "%4" == ""  goto usage
if "%5" == ""  goto usage
netsh interface portproxy add v4tov4 listenaddress=%2 listenport=%3 connectaddress=%4 connectport=%5
goto end

:removePP
if "%2" == ""  goto usage
if "%3" == ""  goto usage
netsh interface portproxy delete v4tov4 listenaddress=%2 listenport=%3
goto end

:removePPVPN
if "%2" == ""  goto usage
for /f "tokens=3" %%i in ('netsh in ip sh con %vpnnic%^|find "IP"') do set zip=%%i
netsh interface portproxy delete v4tov4 listenaddress=0.0.0.0 listenport=%2
goto end

:Add2Local
if "%2" == ""  goto usage
if "%3" == ""  goto usage
set zport=%4
if "%4" == ""  set zport=%3
rem for /f "tokens=3" %%i in ('netsh in ip sh con %vpnnic%^|find "IP"') do set zip=%%i
netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=%zport% connectaddress=%2 connectport=%3
goto end

:default
set defaultPP1=192.168.1.50,5000,1357
set defaultPP2=192.168.1.50,6690,6690
set defaultPP3=192.168.1.247,443,6543
set defaultPP4=192.168.1.18,443,3399
set defaultPP5=192.168.1.70,4789,4789



rem for /f "tokens=3" %%i in ('netsh in ip sh con %vpnnic%^|find "IP"') do set zip=%%i
for /f "tokens=2,3,4 delims==," %%i in ('set defaultPP') do netsh interface portproxy add v4tov4 listenaddress=0.0.0.0	 listenport=%%k connectaddress=%%i connectport=%%j

goto end



:removeALL
for /f "tokens=1,2" %%i in ('netsh interface portproxy show v4tov4') do netsh interface portproxy delete v4tov4 listenaddress=%%i listenport=%%j
goto end


:usage
Echo 端口转发工具用法：PP  /l                          --       列出转发记录
echo                   PP  /default                    --       Biuld Default PortForward at 0.0.0.0
echo                   PP  /da                         --       删除所有转发记录
echo                   PP  /d     [监听IP][监听端口]   --       删除指定记录
echo                   PP  /add   [监听IP][监听端口][内部IP][内部端口]
echo                   PP  /a     [内部IP][内部端口][监听端口]
echo                   PP  /dz    [监听端口]           --       删除指定记录（仅需端口号） 

:end
set zip=
set zport=
