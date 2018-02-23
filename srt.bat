rem @echo %echo_debug%

if ""== "%1" goto end

for /r %1 %%j in (*.mkv) do (


for %%i in (\\%%~Pj\*.sample.mkv) do ren %%i *.mkk

for %%i in (\\%%~Pj\*.mkv) do (
	if exist %%~ni.srt goto end
	if exist \\%%~Pj\*.chs.srt (
		ren \\%%~Pj\*.chs.srt %%~ni.srt
		goto end)
	if exist \\%%~Pj\*.srt ren \\%%~Pj\*.srt %%~ni.srt
)
:end
if exist \\%%~Pj\*.mkk ren \\%%~Pj\*.mkk *.mkv
)

:o