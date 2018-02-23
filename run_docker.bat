@echo %echo_debug% 

if "%1" == "/k" goto kill_all_contain

:d
set /p dockercmd=Docker 
if "%dockercmd%" == "" goto d
if "%dockercmd%" == "exit" goto end
if "%dockercmd%" == "/?"  goto h
docker %dockercmd% 
set dockercmd=
goto d

:h
docker --help 
goto d

:tips

:kill_all_contain
for /f %%i in ('docker ps -a') do docker rm %%

:end
set dockercmd=