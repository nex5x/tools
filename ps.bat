<# :
@echo off &&@if /i "%ed%" == "on" echo on

if /i "%1" == "" tasklist & goto end
if /i "%1" == "/?" goto usage
if /i "%1" == "-?" goto usage
if /i "%1" == "/h" goto usage
if /i "%1" == "-h" goto usage
if /i "%2" == "" tasklist |findstr /i %1 & goto end
if /i "%2" == "/c" goto taskmem
if /i "%2" == "/k" goto kill_a_task
goto end

:kill_a_task
for /f "tokens=1,2 delims= " %%i in ('tasklist ^|findstr /i %1') do echo %%i,%%j
goto end

:taskmem
setlocal enabledelayedexpansion
for /f "tokens=1,5 delims= " %%i in ('tasklist ^|findstr /i %1') do (
set mmx1=%%j 
echo %%i : !mmx1!
set mmx2=!mmx1:,=! 
set /a mm=!mm!+!mmx2!
)
::echo !mm!
::PowerShell -c "(!mm!).ToString('0,0')"

::cscript /nologo %~dp0a.vbs !mm!
more +40 "%~f0" >"%~dpn0.vbs"
cscript /nologo  %~dpn0.vbs !mm!
del "%~dpn0.vbs"

set mm=
set mmx1=
set mmx2=
:end

exit /b
#>
Set objArgs = WScript.Arguments
If objArgs.count =0 then wscript.quit
num=objArgs(0)
   if num=0 or isnull(num) then
       formatnuma="0"
   else
       formatnuma=formatnumber(num,0)
   end if

WScript.echo "Total Memory£º"&formatnuma&"K"
