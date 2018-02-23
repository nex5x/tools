@echo %echo_debug%
if /i "%1"=="/a" goto att
if /i "%1"=="/d" goto deatt
if /i "%1"=="/s" goto show
if /i "%1"=="/c" goto create
if /i "%1"=="/p" goto parent
goto hlp

:show
if "%2"=="" goto hlp
echo Select vdisk file=%~f2 > diskpart.scr
echo attach vdisk >> diskpart.scr
echo detail disk >> diskpart.scr
echo detach vdisk >> diskpart.scr
goto ex

:att
if "%2"=="" goto hlp
echo Select vdisk file=%~f2 > diskpart.scr
echo attach vdisk >> diskpart.scr
if "%3" == "" goto ex
echo select partition 1 >> diskpart.scr
echo time /t 1 >> diskpart.scr
echo assign mount=%3 noerr >> diskpart.scr
goto ex

:deatt
if "%2"=="" goto hlp
echo Select vdisk file=%~f2 > diskpart.scr
echo detach vdisk >> diskpart.scr
goto ex

:create
if "%2"=="" goto hlp
if "%3"=="" goto hlp
echo CREATE VDISK FILE=%~f2 MAXIMUM=%3 TYPE=EXPANDABLE> diskpart.scr
echo attach vdisk >>diskpart.scr
if /i "%4"=="/p" goto hlp
echo CREATE PARTITION PRIMARY >>diskpart.scr
echo format QUICK >>diskpart.scr
echo assign >>diskpart.scr
goto ex

:parent
if "%2"=="" goto hlp
if "%3"=="" goto hlp
echo CREATE VDISK FILE=%~f2 PARENT=%~f3 > diskpart.scr
goto ex


:ex
echo exit >> diskpart.scr
diskpart -s diskpart.scr
goto end

:hlp
Echo Usage VhdDisk [/A^|/D^|/S^|C] VHDFilename [MountPath]^|[VDisk Size]
echo /a Attach a Vdisk,must include the VHD file name.
echo     It can append a string which will be the MountPath when attach the Vdisk.
echo     If no,will assign a default DriveLetter.
echo /d Detach Vdisk,must include the VHD file name.
echo /s Show a Vdisk detail,must include the VHD file name.
echo /c Create a Vdisk,must include the VHD file name and VDisk Size.
echo     If with /p,Will create a Primaray partition and format it as NTFS.
echo Good Job!
:end
rem  type diskpart.scr
if exist diskpart.scr del diskpart.scr