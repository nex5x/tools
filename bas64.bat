 :: Base64.cmd Beta -- Base64 ������� 01/28/2007 By 0401
@echo off
setlocal enabledelayedexpansion
set op=
set Key=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=
set hexstr=0 1 2 3 4 5 6 7 8 9 A B C D E F
set d=0
for %%i in (%hexstr%) do set d!d!=%%i&set/a d+=1
if "%~1"=="" goto :help
if "%~1"=="/?" goto :help
for %%i in (d D e E h H) do (
        if "%~1"=="/%%i" call :arg%%i %*
        if exist "%~1" (
                if exist "%~1/" set error=Sorry����֧�ֶ�һ��Ŀ¼���� Base64 ���롣& goto :error
                set op=encode
                set infile=%~sf1
        )
)
if defined error goto :error
if defined op goto :%op%
set error=��Ч�Ĳ������ļ�����%1��& goto :error

:arge
set op=encode
:argd
if not defined op set op=decode
set infile=%~sf2
if not defined infile set error=û��ָ�������ļ���& exit/b
if not exist "%infile%" set error=�Ҳ���ָ���ļ���%infile%��& exit/b
set outfile=%~f3
goto :eof
:argh
set op=help
goto :eof
:error
echo %error%
exit/b

goto :encode
s �ļ���С
l �ļ�����100H f����������ڴ�ĳ��ȡ�
c ֻ���������һ�α����ʱ��
k �ж� c1 c2 c3
w ÿ�����ɼ���4���ֽڵı����ַ���Ĭ��18
q �жϵ���wʱ���һ�б����ַ���
n �������˵��ظ����ֽ�
:encode
>nul (chcp 437&graftabl 936)
cls
for %%i in (%infile%) do set s=%%~zi
if %s% equ 0 exit/b
if %s% gtr 65535 set error=����ʧ�ܣ��ļ���С����Ϊ 64KB��& goto :error
set/p=�����ʼ���У����Եȡ�<nul
set of=B64ENC
set/p=<nul>"%~dp0%of%"
set/a l=s+255
call :d2h %l%
set l=%hex%
call :d2h %s%
echo exit|%comspec%/kprompt f cs:100 l %l% 0A$_r cx$_%hex%$_n a.t1$_w$_f cs:100 l %l% 0D$_n b.t1$_w$_q$_|debug>nul
fc/b %infile% a.t1|find ": ">.t1
fc/b %infile% b.t1|find ": ">>.t1
sort .t1>.t2
call :time t1
set n=
set c=0
set k=0
set q=0
set w=18
for /f "tokens=1,2" %%i in (.t2) do (
        if not "!n!"=="%%i" (
                set/a d=0x%%j
                set/a k+=1
                if !k! equ 1 set c1=!d!
                if !k! equ 2 set c2=!d!
                if !k! equ 3 set c3=!d!
                if !k! equ 3 (
                        set/a e1="c1>>2!
                        set/a e2="((c1&3)<<4)|(c2>>4)"
                        set/a e3="((c2&15)<<2)|(c3>>6)"
                        set/a e4="c3&63"
                        call set b64=!b64!%%Key:~!e1!,1%%%%Key:~!e2!,1%%%%Key:~!e3!,1%%%%Key:~!e4!,1%%
                        set/a q+=1
                        if !q! equ !w! (
                                echo !b64!>>"%~dp0%of%"
                                set b64=
                                set q=0
                                if !c! equ 0 (
                                        set/a c+=1
                                        call :time t2
                                        set/a t="s/(w*3)*(t2-t1)/100"
                                        echo ����ʣ��ʱ�� !t! �롣
                                )
                                set/p=#<nul
                        )
                        set k=0
                )
        )
        set n=%%i
)
if !k! equ 1 (
        set/a e1="c1>>2"
        set/a e2="(c1&3)<<4"
        call set b64=!b64!%%Key:~!e1!,1%%%%Key:~!e2!,1%%==
)
if !k! equ 2 (
        set/a e1="c1>>2"
        set/a e2="((c1&3)<<4)|(c2>>4)"
        set/a e3="((c2&15)<<2)"
        call set b64=!b64!%%Key:~!e1!,1%%%%Key:~!e2!,1%%%%Key:~!e3!,1%%=
)
echo.
if defined b64 echo %b64%>>"%~dp0%of%"
if defined outfile move/y "%~dp0%of%" "%outfile%"
echo ������ɡ�
del a.t1 b.t1 .t1 .t2
::chcp 936>nul
exit/b

goto :decode
k �����ж� e1 e2 e3 e4
e e������ÿ��д����ֽ�����Ĭ����24���ֽ�����һ��debug��e������������޸ģ�3<=e<=24��
s1 ת�����HEX��
m �ж�s1�Ƿ����ָ�����ֽ���
q ÿ���У������ֽ�*3��������
cx ��ʾ�ļ���С���ֽڣ���ÿ����һ�μ�3����Ϊÿ4���ֽڽ���Ϊ3���ֽ�
cs e��������cs�ε�ַ�ڵĶ���ƫ�ƴ�д��
v1 ÿ���ֽ�����2��2���ֽڼȻس��뻻�У�
v2 ����
v3 q��3�� �����жϴ����1������ʱ��
:decode
>nul (chcp 437&graftabl 936)
cls
set/p=������<nul
set/p=<nul>dbg.src
set/p v1=<%infile%
set/p=%v1%<nul>.t1
for %%i in (.t1) do set/a q=%%~zi/4&set v1=%%~zi+2&del .t1
for %%i in (%infile%) do set/a v2=%%~zi/v1+1
set/a v3="q*3"
call :time t1
set e=24
set k=1
set m=1
set cx=0
set cs=256
for /f %%i in (%infile%) do (
        set str=%%i
        for /l %%j in (1,1,%q%) do (
                if not defined str if %%j lss %q% goto :decend
                for /l %%k in (0,1,3) do (
                        for /l %%l in (0,1,64) do (
                                if "!str:~%%k,1!"=="!Key:~%%l,1!" (
                                        if !k! equ 1 set e1=%%l
                                        if !k! equ 2 set e2=%%l
                                        if !k! equ 3 set e3=%%l
                                        if !k! equ 4 set e4=%%l
                                        set/a k+=1
                                )
                        )
                )
                set/a c1="(e1<<2)|(e2>>4)"
                call :d2h !c1!
                set s1=!s1! !hex!
                set/a c2="((e2&15)<<4)|(e3>>2)"
                call :d2h !c2!
                set s1=!s1! !hex!
                set/a c3="((e3&3)<<6)|e4"
                call :d2h !c3!
                set s1=!s1! !hex!
                
                set k=1
                set/a cx+=3
                set/a m=cx"%%"e
                if !m! equ 0 (
                        if !e4! equ 64 (
                                set/a cx-=1
                                set s1=!s1:~0,-3!
                                if !e3! equ 64 (
                                        set/a cx-=1
                                        set s1=!s1:~0,-3!
                                )
                        )
                        call :d2h !cs!
                        echo e !hex! !s1! >>dbg.src
                        set/a cs+=e
                        set s1=
                )
                set str=!str:~4!
        )
        if !cx! equ %v3% (
                call :time t2
                set/a ts=t2-t1
                set/a t="ts*v2/100"
                echo ���ļ��� !v2! �У�ÿ����ʱԼ !ts! ���룬����ʣ��ʱ�� !t! �롣
        )
        set/p=#<nul
)
:decend
if defined s1 (
        if %e4% equ 64 (
                set/a cx-=1
                set s1=!s1:~0,-3!
                if %e3% equ 64 (
                        set/a cx-=1
                        set s1=!s1:~0,-3!
                )
        )
        call :d2h %cs%
        echo e !hex! !s1! >>dbg.src
)
call :d2h %cx%
(echo r cx
echo %hex%
echo n b64dec
echo w
echo q) >>dbg.src
echo.
debug<dbg.src>nul
if defined outfile move/y b64dec "%outfile%"
echo ������ɡ�
del dbg.src
::chcp 936>nul
exit/b

:time
for /f "tokens=1-4 delims=:." %%i in ("%time%") do (
        set/a time1="%%i*360000"
        set/a time2="(1%%j-100)*6000"
        set/a time3="(1%%k-100)*100"
        set/a time4="1%%l-100"
)
set/a %~1=time1+time2+time3+time4
exit/b
:d2h
set/a d=%1
set hex=
if %d% equ 0 set hex=00&exit/b
if %d% gtr 255 (set c=4) else (set c=2)
for /l %%i in (1,1,%c%) do (
        set/a td=d"&"15
        set/a d">>="4
        call set hex=%%d!td!%%!hex!
)
exit/b

:help
for /f "tokens=1 delims=:" %%i in ('findstr/n /c:"=help=" "%~f0"') do more +%%i "%~f0">con & goto :eof
Base64 Encode n Decode Beta By 0401
Usage:
Base64 [/e] filename1 [filename2]
       [/d filename1] [filename2]
       [/h]
    /e        Base64 ��������������ļ���С���� 64KB
    /d        Base64 �������
    filename1 �����ļ���
    filename2 ����ļ���
              /e ȱʡ����ļ���Ϊ B64ENC
              /d ȱʡ����ļ���Ϊ B64DEC
    /h        ����