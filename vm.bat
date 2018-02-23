@echo %echo_debug%

set exepath=C:\Progra~1\Oracle\VirtualBox

if /i "%1" == "/h" goto hlp
if /i "%1" == "/?" goto hlp
if /i "%1" == "/s" goto startvm
if /i "%1" == "/d" goto stopvm
if /i "%1" == "/i" goto vminfo
if /i "%1" == "/l" goto vmlist

if /i "%1" == "-h" goto hlp
if /i "%1" == "-?" goto hlp
if /i "%1" == "-s" goto startvm
if /i "%1" == "-d" goto stopvm
if /i "%1" == "-i" goto vminfo
if /i "%1" == "-l" goto vmlist


Echo Bad Command.
goto hlp

:startvm
if "%2" == "" goto hlp
echo CreateObject("Wscript.Shell").run "%exepath%\VBoxHeadless.exe -s %2 -v on",0 > temp.vbs
cscript temp.vbs
del temp.vbs
goto end

:stopvm
if "%2" == "" goto hlp
%exepath%\VBoxManage.exe controlvm  %2 poweroff
goto end

:vminfo
%exepath%\VBoxManage.exe showvminfo %2
goto end

:vmlist
%exepath%\VBoxManage.exe list runningvms
goto end

:hlp
echo VM [Command] VMname
echo Command can be "-s -d -i -l"
echo           -s  --  StartVM
echo           -d  --  StopVM
echo           -i  --  ShowVMinfo
echo           -l  --  Show Running VMs

:end
set exepath=


