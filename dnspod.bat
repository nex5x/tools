<# :
@echo off &@if /i "%ed%" == "on" echo on

REM 代码如有改动，切记修改VBS文件行数

if "%dns_pod_token%" =="" (echo 环境变量dns_pod_token未准备。& goto end)
setlocal enabledelayedexpansion

wmic ENVIRONMENT where "name='dns_record_update'" get UserName,VariableValue |findstr SYSTEM > %~dpn0_update.env
for /f  "tokens=2 delims=<>	 " %%i in (%~dpn0_update.env) do set dns_record_update=%%i
del %~dpn0_update.env

if /i "%1" == "/l" goto list
if /i "%1" == "/J" set fm=json& goto end
if /i "%1" == "/X" set fm=XML& goto end
if /i "%1" == "/f" goto flushddns
if /i "%1" == "/?" goto usage
if /i "%1" == "/h" goto usage
if /i "%1" == "-h" goto usage
if /i "%1" == "-?" goto usage


setlocal enabledelayedexpansion
set dns_record_update_lst=!dns_record_update:;=^

!
for /f "tokens=1,2,3,4 delims=,@" %%i in ("!dns_record_update_lst!") do echo %%i：%%j.%%k(%%l)
goto end
:flushddns
set dns_record_update_lst=!dns_record_update:;=^

!
for /f "tokens=1,2,3,4 delims=,@" %%i in ("!dns_record_update_lst!") do echo %%j.%%k&  curl -X POST https://dnsapi.cn/Record.Ddns -d "login_token=%dns_pod_token%&domain_id=%%i&record_id=%%l&record_type=A&record_line_id=0&sub_domain=%%j&format=XML" --silent | findstr "</message>"
goto end


:list
REM 代码如有改动，切记修改VBS文件行数
more +131 %~f0> %~dpn0.vbs    

if "%2" == "" goto listdomain
echo %2| find "." &&goto listdomainname
:listdomain_id
if exist reclist.txt del reclist.txt
rem for /f "delims=<> tokens=2 " %%i in ('curl -X POST https://dnsapi.cn/Record.List -d  "login_token=%dns_pod_token%&domain_id=%2&format=XML" --silent ^|findstr "<id>.*</id> <name> <value>"') do echo %%i >> listrec.txt
curl -X POST https://dnsapi.cn/Record.List -d  "login_token=%dns_pod_token%&domain_id=%2&format=XML" --silent ^|findstr "<id>.*</id> <name> <value>" >>reclist.txt
cscript /nologo %~dpn0.vbs /r reclist.txt
::del reclist.txt
goto end

:listdomainname
goto end



:listdomain

if exist domainlist.txt del domainlist.txt
curl -X POST https://dnsapi.cn/Domain.List -d "login_token=%dns_pod_token%&format=XML" --silent  |findstr "<id>.*</id> <name>.*</name>" >> domainlist.txt
for /f "tokens=1,3,5 delims=：— " %%i in ( 'cscript /nologo %~dpn0.vbs /D  domainlist.txt') do echo 域名 %%i：%%j：%%k & set dns_pod_domain_ID%%i=%%j & set dns_pod_domain_name%%i=%%k & set dd_total=%%i

del domainlist.txt
set dn=
set /p dn=选择序号显示域名记录：
rem CHOICE /T 1 /C 1234678  /D 1 /M "请选择1 ~ 8"

if "%dn%" == "0" goto end
::for /f "delims==" %%i in ('set dns_pod_domain_id') do set dd_total=%%i
if "%dn%" lss "1" goto end
if %dn% gtr %dd_total% goto end
rem if %dn% gtr %dd_total:~17,2% goto end

curl -X POST https://dnsapi.cn/Record.List -d  "login_token=%dns_pod_token%&domain_id=!dns_pod_domain_id%dn%!&format=XML" --silent -o reclist.txt
cscript /nologo %~dpn0.vbs /r reclist.txt > recclist.txt
del reclist.txt
type recclist.txt

::echo  !dns_pod_domain_name%dn%!（!dns_pod_domain_id%dn%!）
for /f "tokens=1,3,4 delims=：（）	  " %%i in ('findstr 指向 recclist.txt') do set dns_pod_record_name%%i=%%j.%domain_name% & set dns_pod_record_id%%i=%%k & set dr_total=%%i & set dns_pod_subd%%i=%%j
if exist recclist.txt del recclist.txt


set /p dr=选择序号将记录添加到动态更新列表：
::if "%dn%" == "0" goto end
::for /f "delims==" %%i in ('set dns_pod_domain_id') do set dd_total=%%i
if "%dr%" lss "1" goto end
if %dr% gtr %dr_total% goto end
set dns_pod_selected_domain0=!dns_pod_domain_id%dn%!
set dns_pod_selected_record0=!dns_pod_record_id%dr%!
set dns_pod_selected_subd0=!dns_pod_subd%dr%!

set dns_pod_selected_domain=%dns_pod_selected_domain0: =%
set dns_pod_selected_record=%dns_pod_selected_record0: =%
set dns_pod_selected_subd=%dns_pod_selected_subd0: =%
::set dns_record_update
::for /f %%i in ('set dns_record_update^|findstr %dns_pod_selected_record%') do echo %%i& set dns_record_found=%%i
::if "%dns_record_found%" == "" goto update_ddns
set dns_record_update|findstr %dns_pod_selected_record% && goto end

goto  update_ddns
:update_ddns


echo %dns_record_update%%dns_pod_selected_domain%,%dns_pod_selected_subd%@!dns_pod_domain_name%dn%!,%dns_pod_selected_record%;
set  dns_record_update=%dns_record_update%%dns_pod_selected_domain%,%dns_pod_selected_subd%@!dns_pod_domain_name%dn%!,%dns_pod_selected_record%;
set dns_record_update
setx dns_record_update "%dns_record_update: =%" -m

if exist recclist.txt del recclist.txt



goto end

:Usage
Echo DDNS [/l [ID]^|/a] 	With nothing will update the H.XXX .
echo 			With /l ,Will list DomaiList ,With [id] will list RecordList .
echo DDNS /? ^| -? ^| -h

:end

rem for /f "tokens=1 delims==" %%i in ('set dns_pod_domain') do set  %%i=
::for /l %%i in (1,1, %dd_total:~-1%) do set dns_pod_domain%%i=
::set dn=
::set dd_total=
if exist %~dpn0.vbs del %~dpn0.vbs

exit /b

#>
































    Set objArgs = WScript.Arguments
    If objArgs.count =0 then wscript.quit 
    If objArgs(0)="/D" or objArgs(0)="/d" Then
    	Set fso = CreateObject("Scripting.FileSystemObject")
    	if Fso.FileExists(objArgs(1)) then
    		set  ds=fso.OpenTextFile(objArgs(1),1)
    		dl = ds.readall
    		dl=replace(dl,vbcrlf,"#")
    		dl=replace(dl,"<id>","ID：")
    		dl=replace(dl,"</id>","  ——  ")
    		dl=replace(dl,"<name>","Domain：")
    		dl=replace(dl,"</name>","")
    		    		
    		d=split(dl,"#")
    		for i=1 to (ubound(d)+1)/2
    			WScript.echo  i&"："&d(i*2-2)&d(i*2-1)
    		next
    	end if
    ElseIf  objArgs(0)="/R" or objArgs(0)="/r"  Then
    	Set fso = CreateObject("Scripting.FileSystemObject")
    	if objargs.count=1 then wscript.quit
    		if  Fso.FileExists(objArgs(1)) then
    		set  rs=fso.OpenTextFile(objArgs(1),1)
    		i=1
			Do Until rs.AtEndOfStream
				ss=rs.ReadLine
				
				if ss="<domain>" then  we = "Domain "
				if ss="</domain>" then  WScript.echo  we & wen &"（"&weid&"）"
				if ss="<item>" then we ="Item "
				if ss="</item>" then 
					WScript.echo  i&"："&wett&"记录：	" & wen &"（"&weid&"）	指向：" & wevv
					i=i+1
				end if 
				
				if we ="Domain " then
					if instr(ss,"<id>") then
						ss=replace(ss,"<id>","")
						ss=replace(ss,"</id>","")
						weid= ss
					end if
				
					if instr(ss,"<name>") then
						ss=replace(ss,"<name>","")
						ss=replace(ss,"</name>","")
						wen=ss
											
					end if				
				elseif we="Item " then 
					if instr(ss,"<id>") then
						ss=replace(ss,"<id>","")
						ss=replace(ss,"</id>","")
						weid= ss
					end if
					if instr(ss,"<value>") then
						ss=replace(ss,"<value>","")
						ss=replace(ss,"</value>","")
						wevv= ss
					end if
					if instr(ss,"<type>") then
						ss=replace(ss,"<type>","")
						ss=replace(ss,"</type>","")
						wett= ss
					end if
					if instr(ss,"<name>") then
						ss=replace(ss,"<name>","")
						ss=replace(ss,"</name>","")
						wen=ss
					end if				
				end if
			Loop 	
    		end if 
    else
    		WScript.echo 
    End If

