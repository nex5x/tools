setlocal enabledelayedexpansion
for /f "delims=<> tokens=2 " %%i in ('findstr "<id>.*</id> <name>.*</name>" domainlist') do set dl=%dl% %%i