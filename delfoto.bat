@echo %echo_debug%
attrib -r -a *.arw
for /r %%i in (*.jpg) do attrib +r +a %%~ni.arw
del /a:-a *.arw 
attrib -r +a *.arw