::@echo %echo_debug%

set VPN_name=MacroVPN
set vpn_user=halo
rem set vpn_user=halo99
rem set vpn_user=wohoo
set vpn_pass=778899
set vpn_gw=us2.macrovpn.com



if "%1" == "" goto :tips
if /i "%1" == "-r" goto :R_Status
if /i "%1" == "-v" goto :V_Status
if /i "%1" == "-D" goto :VPN_Dial
if /i "%1" == "-h" goto :VPN_hang
if /i "%1" == "-all" goto :VPN_All

for /f  "delims=[ tokens=2" %%i in ('%windir%\system32\ping.exe %1 -n 1^|find "["') do (
for /f  "delims=] tokens=1" %%j in ("%%i") do set IP=%%j
)
route add %ip% mask 255.255.255.255 10.1.1.1
set ip=
goto end

:VPN_All
for /f  %%i in ('rasdial %vpn_name% %vpn_user% %vpn_pass% /phone:%vpn_gw%  ^|find "已经"') do set V_S=%%i
if "%V_S%"=="" rasdial %vpn_name% %vpn_user% %vpn_pass% /phone:%vpn_gw% 
:goto VPN_All

:VPN_All_adding
set VPN_tar_ip1=173.212.202.146 	% 51luoben %
set VPN_tar_ip2=74.63.245.184		% 紅磨坊 www.erop2p.com %
set VPN_tar_ip3=
set VPN_tar_ip4=
set VPN_tar_ip5=
set VPN_tar_ip6=
set VPN_tar_ip7=
set VPN_tar_ip8=
set VPN_tar_ip9=
set VPN_tar_ip10=67.19.136.218		% 花和尚 www.sexymonk.com %

for /f "delims== tokens=2" %%i in ('set vpn_tar_ip') do route add %%i mask 255.255.255.255 10.1.1.1

set VPN_tar_ip1=
set VPN_tar_ip2=
set VPN_tar_ip3=
set VPN_tar_ip4=
set VPN_tar_ip5=
set VPN_tar_ip6=
set VPN_tar_ip7=
set VPN_tar_ip8=
set VPN_tar_ip9=
set VPN_tar_ip10=
goto end

:tips
echo Usage : Addvpn xxx.com    // to add the site in VPN
echo Usage : Addvpn -r         // to show the route
echo Usage : Addvpn -v         // to show the VPN Status
echo Usage : Addvpn -d         // to Dial the VPN
echo Usage : Addvpn -h         // to hangupthe VPN
goto end

:R_Status
route print |find "10.1.1.1"
goto end

:V_Status
rasdial %VPN_name% |find "%VPN_name%"
if errorlevel 0 echo VPN is ON.
goto end

:VPN_Dial
rasdial %vpn_name% %vpn_user% %vpn_pass% /phone:%vpn_gw% 
goto end

:VPN_hang
rasdial  %VPN_name% /d
goto end

:old_version
for /f "tokens=1 delims=:" %%i in ('ipconfig^|findstr /n  /i "%vpnname%"') do set ln=%%i
for /f "skip=%ln% tokens=1,2 delims=:" %%i in ('ipconfig') do echo %%i:%%j >> vpn_ip.txt
for /f "tokens=2 delims=:" %%i in ('findstr /i "IP address" VPN_IP.txt') do set VPNip=%%i
for /f "tokens=1 delims= " %%i in ("%VPNip%") do set VPNip=%%i
goto end
for /f "tokens=1 delims=:" %%i in ('ipconfig^|findstr /n  /i "%vpnname%"') do set ln=%%i
for /f "skip=%ln% tokens=1,2 delims=:" %%i in ('ipconfig') do echo %%i:%%j >> vpn_ip.txt
for /f "tokens=2 delims=:" %%i in ('findstr /i "IP address" VPN_IP.txt') do set VPNip=%%i
for /f "tokens=1 delims= " %%i in ("%VPNip%") do set VPNip=%%i

if exist c:\windows\default.gw (set /p defaultGW= < c:\windows\default.gw) else for /f "tokens=3 delims=: " %%i in ('route print ^| find "Default Gateway:"') do set defaultGW=%%i

if "%defaultGW%" == "" (
echo No Gateway, tring find last Gateway...
if exist c:\windows\default.gw (set /p defaultGW= < c:\windows\default.gw) else goto end
) else echo %defaultGW% > c:\windows\default.gw



route -f add %vpn_gw% mask 255.255.255.255 %defaultGW%
route add 0.0.0.0 mask 0.0.0.0 %VPNip%
rem route add 211.94.0.0 mask 255.255.0.0 %defaultGW%
rem route add 10.127.0.0 mask 255.255.0.0 %defaultGW%


:end
set VPN_name=
set vpn_user=
set vpn_pass=
set vpn_gw=


