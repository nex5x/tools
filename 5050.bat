@echo off &&@if /i "%ed%" == "on" echo on

for /f "tokens=5 delims= " %%i in ('netstat -ano^|find "5050"') do set port5050=%%i

if /i "%port5050%" == "" goto 5050
for /f "tokens=1 delims= " %%i in ('tasklist ^|find "%port5050%"') do set t_plink=%%i
if /i "%t_plink%"=="plink.exe" (
echo The port is already opened.
)  else  (
echo Port 5050 is used by another program,pls check and run again.
)
rem pause
goto end

:5050
if "%1" == "" goto myssh
if "%1" == "/free" goto boafanx
rem echo Usage : 5050 IP user pwd port
start /min plink -N -D 5050 -pw %3 %2@%1 -P %4
goto end

:boafanx
rem http://boafanx.tabboa.com/free/
start /min plink -N -D 5050 -pw eyo3 boa@208.110.83.242 -P 1336

:myssh
start /min plink -N -D 5050 -pw wolf@vps sshu@204.44.65.170 -P 2233
:end
set port5050=
set t_plink=