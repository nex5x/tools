@echo %echo_debug%

rem for /f "delims== tokens=1,2" %%i in (c:\prog\tools\vpn.ini) do set %%i=%%j
set VPN_name=VPN 
set vpn_user=wohoo01
set vpn_pass=778899
set vpn_server=216.24.198.62

if "%1" == "" goto :tips
if "%1" == "/?" goto :tips
if "%1" == "-?" goto :tips
if /i "%1" == "-help" goto :tips
if /i "%1" == "-r" goto :R_Status
if /i "%1" == "-v" goto :V_Status
if /i "%1" == "-D" goto :VPN_Dial
if /i "%1" == "-h" goto :VPN_hang
if /i "%1" == "-k" goto :Kill_IP
if /i "%1" == "-all" goto :VPN_All



for /f "delims=: tokens=2" %%i in ('netsh in ip sh ad %VPN_name% ^| find "IP"') do set VPNip=%%i
set VPNip=%VPNip: =%
set vpn_gw=%VPNip%


for /f  "delims=的 tokens=1" %%i in ('%windir%\system32\ping.exe %1 -n 1^|find "的 Ping 统计信息"') do route add %%i mask 255.255.255.255 %vpn_gw% 
set ip=
goto end

:VPN_All
for /f %%i in (d:\prog\tools\vpn.lst) do for /f  "delims=[ tokens=2" %%j in ('%windir%\system32\ping.exe %%i -n 1^|find "["') do for /f  "delims=] tokens=1" %%k in ("%%j") do route add %%k mask 255.255.255.255 %vpn_gw% 

goto end

:R_Status
route print |find "%vpn_gw%"
goto end

:V_Status
rasdial |find "%VPN_name%"

goto end

:VPN_Dial
rasdial %vpn_name% %vpn_user% %vpn_pass% /phone:%vpn_server% 
for /f "delims=: tokens=2" %%i in ('netsh in ip sh ad %VPN_name% ^| find "IP"') do set VPNip=%%i
set VPNip=%VPNip: =%
set vpn_gw=%VPNip%
set vpn_user=
set vpn_pass=
set vpn_server=
goto end

:VPN_hang
rasdial  %VPN_name% /d
set VPNip=
set vpn_gw=
set VPN_name=
goto end


:Kill_IP
for /f  %%i in ('gw /s ^|find "%vpn_gw%"') do (
if "%%i" NEQ "0.0.0.0" route delete %%i
)

goto end

rem for /f  "delims=[ tokens=2" %%i in ('%windir%\system32\ping.exe %1 -n 1^|find "["') do (
for /f  "delims=] tokens=1" %%j in ("%%i") do set IP=%%j
)

:tips
echo Usage : vpn xxx.com    	// to add the site in VPN
echo Usage : vpn -r         	// to show the route
echo Usage : vpn -v         	// to show the VPN Status
echo Usage : vpn -d         	// to Dial the VPN
echo Usage : vpn -h         	// to hangupthe VPN
echo Usage : vpn -k 		// Kill_IP
echo Usage : vpn -all    	// to add all pre-site

:end
rem set VPNip=
rem set vpn_gw=
set vpn_user=
set vpn_pass=
set vpn_server=
set vpn_name=