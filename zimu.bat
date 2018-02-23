@echo %echo_debug%
set subfile=
set subext=
set videofile=
set subtype=


echo %1


cd /d "%~dp1"

for  %%i in (*.mkv) do set videofile=%%~ni
set "subext=%~x1"
set "subfile=%~n1"

call :getext "%~n1"

ren %1 "%videofile%%subtype%%subext%"



:end 
::prompt $p$g
set subfile=
set subext=
set videofile=
set subtype=
::pause
goto :eof

:getext
set "subtype=%~x1"