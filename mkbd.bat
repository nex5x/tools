@echo  off
if exist "%1\BDMV" goto mkbd
echo No BD found...
goto end

:mkbd
cd /d "%1"
echo Creating ....
md CERTIFICATE
cd CERTIFICATE
md BACKUP
cd ..\BDMV
md BACKUP
cd BACKUP
md CLIPINF
md PLAYLIST
md BDJO
md JAR
md AUXDATA
md META
cd ..
md AUXDATA
md BDJO
md JAR
md META
cd ..
echo Done.

:end