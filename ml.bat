@echo %echo_debug%
set s1=50
set s2=70

if "%1" == "" goto tips

for /f "tokens=1,2 delims=." %%i in ("%1") do (
if "%%i" == "" goto tips
if "%%j" == "" (mklink /d c:\Disks\%1.%s1% \\192.168.1.%s1%\%%i && mklink /d c:\Disks\%1.%s2% \\192.168.1.%s2%\%%i) else mklink /d c:\Disks\%1 \\192.168.1.%%j\%%i
)

goto end

:tips
echo Usage : ml  DATA.10          DATA is the share path, 10 is the server IP last number.

:end
set s1=
set s2=