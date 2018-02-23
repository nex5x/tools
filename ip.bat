@echo off &&@if /i "%ed%" == "on" echo on


if /i "%1" == "/h" goto tips
if /i "%1" == "/?" goto tips
if /i "%1" == "/w" goto WAN_IP
if /i "%1" == "/g" goto gw
if /i "%1" == "/f" ipconfig /flushdns && goto end
if /i "%1" == "" goto ip
if /i "%1" == "/nic" goto nic
if /i "%1" == "/add" goto addip
if /i "%1" == "/del" goto delip
if /i "%1" == "/a" netsh in ip sh con && goto end
if /i "%1" == "/all" netsh in ip sh con && goto end
if /i "%1" == "/l" netsh in ip sh in && goto end
netsh in ip sh con %1
goto end

:ip
rem for /F "tokens=4" %%* in ('route print ^| findstr "\<0.0.0.0\>"') do @echo IP is : %%* 
rem goto end
:cur_nic
for /F "tokens=5" %%i in ('netsh in ip sh ro ^| findstr "0.0.0.0"') do set nic_num=%%i
for /f "tokens=1,4,5" %%i in ('netsh in ip sh in') do 	if "%%i" == "%nic_num%"  set nic_name=%%k  && echo 接口%%k连接状态： %%j
netsh in ip sh con %nic_name% 
set nic_name=
set nic_num=
goto end

:gw
for /F "tokens=3" %%* in ('route print ^| findstr "\<0.0.0.0\>"') do @echo The Default Gateway is : %%* 
goto end

:WAN_IP
set url=http://2017.ip138.com/ic.asp
set http_file=%TEMP%\IP.TXT
curl -s %url% -o %http_file%

for /f "tokens=1,2,3 delims=[] " %%i in (%TEMP%\IP.TXT) do set dip=%%k
echo %dip%

del %TEMP%\IP.TXT
set dip=
set url=
set http_file=
goto end

:nic
for /f "tokens=2 delims=:" %%i in ('ipconfig /all ^| find "描述"') do @echo %%i
goto end

:addip
if not "%3" == "" netsh in ip ad ad "%2" %3 & goto end
for /F "tokens=5" %%i in ('netsh in ip sh ro ^| findstr "0.0.0.0"') do set nic_num=%%i
for /f "tokens=1,4,5" %%i in ('netsh in ip sh in') do 	if "%%i" == "%nic_num%"  set nic_name=%%k  && echo 接口%%k连接状态： %%j
netsh in ip ad ad  %nic_name% %2
netsh in ip sh con %nic_name% 
set nic_name=
set nic_num=
goto end

:delip
if not "%3" == "" netsh in ip de ad  "%2" %3 & goto end
for /F "tokens=5" %%i in ('netsh in ip sh ro ^| findstr "0.0.0.0"') do set nic_num=%%i
for /f "tokens=1,4,5" %%i in ('netsh in ip sh in') do 	if "%%i" == "%nic_num%"  set nic_name=%%k  && echo 接口%%k连接状态： %%j
netsh in ip de ad  %nic_name% %2
netsh in ip sh con %nic_name% 
set nic_name=
set nic_num=
goto end


:tips
echo  IP  [ /a(ll) ^| /g ^| /w ^| /nic]

:end
