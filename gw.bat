@echo %echo_debug%
set gw1=192.168.0.1
set gw2=192.168.0.254
set gw3=192.168.1.1
set gw4=192.168.1.254
set gw5=192.168.2.254
set gw6=192.168.4.254
set big=6

if ""== "%1" goto tip
if /i "/S"== "%1" goto show
if /i "/a"== "%1" goto auto
if /i "/P"== "%1" goto pinging
if /i "/R"== "%1" goto config_gw


:tip
echo Usage : GW [/R or /S] [Selecttion or Gateway IP]
echo gw /r -- Assign The Router.
Echo gw /s -- Show Route Table.
echo gw /p -- ping the gateway.
echo gw /a -- Assign a pre-set gateway.
goto end

:show
route print | find " 0.0.0.0"
goto end

:config_gw
route delete 0.0.0.0
route add 0.0.0.0 mask 0.0.0.0 %2
goto show_gw
goto end

:auto
if "%2" gtr "%big%" goto showautoset
if "%2" lss "1" goto showautoset
set %%i=%2
route delete 0.0.0.0
for /f "tokens=2 delims==" %%i in ('set gw%2') do route add 0.0.0.0 mask 0.0.0.0 %%i
goto show

:showautoset
echo gw.bat /a GatewayNo.
FOR /L %%i IN (1,1,%big%) DO for /f "tokens=2 delims==" %%j in ('set gw%%i') do echo gw /a %%i -- will set gateway as %%j
goto show


:pinging
shift
if "%1" gtr "%big%" goto 263
if "%1" lss "1" goto 263
for /f "tokens=2 delims==" %%i in ('set gw%1') do ping %%i	
goto end

:263
ping 263.net

:show_gw
rem for /f "tokens=2 delims=:" %%i in ('route print ^|find /i "Default Gateway"') do set gw=%%i
rem if %gw=="" echo Default Gateway Is :%gw%
rem set gw=
:end

set big=
