@rem �ֶ�����KMS����Office
@echo off &&@if /i "%ed%" == "on" echo on

:selkms
echo ��ѡ��KMS���������
echo 1 -- xykz.f3322.org
echo 2 -- kms.03k.org
echo 3 -- kms-win.msdn123.com
echo 4 -- kms.lotro.cc
echo 5 -- kms.shuax.com
echo 6 -- kms.chinancce.com
echo 7 -- m.zpale.com
echo 8 -- cy2617.jios.org
CHOICE /T 1 /C 1234678  /D 1 /M ��ѡ��1~8
if  ERRORLEVEL 7 set kms=m.zpale.comv 		&&echo echo ��ѡ�񼤻��������%kms%&& goto act
if  ERRORLEVEL 6 set kms=kms.chinancce.com	 &&echo echo ��ѡ�񼤻��������%kms%&& goto act
if  ERRORLEVEL 5 set kms=kms.shuax.com 		&&echo echo ��ѡ�񼤻��������%kms%&& goto act
if  ERRORLEVEL 4 set kms=kms.lotro.cc 		&&echo echo ��ѡ�񼤻��������%kms%&& goto act
if  ERRORLEVEL 3 set kms=kms-win.msdn123.com &&echo echo ��ѡ�񼤻��������%kms%&& goto act
if  ERRORLEVEL 2 set kms= kms.03k.org		 &&echo echo ��ѡ�񼤻��������%kms%&& goto act
if  ERRORLEVEL 1 set kms=xykz.f3322.org 		&&echo echo ��ѡ�񼤻��������%kms%&& goto act
:errorkmssel
��ѡ����ȷ�ļ����������
echo  goto end


:act
set cur_dir=%cd%
set office_dir="C:\Program Files\Microsoft Office\Office15\"
CHOICE /T 1 /C YN /cs  /D Y /M Office��װ·���Ƿ�Ϊ%office_dir%
if errorlevel 2 set /p office_dir=������Office·��

cd /d %office_dir%

echo ����KMS 		&&  cscript /nologo OSPP.VBS /sethst:%kms%
echo ���� 			&& cscript /nologo OSPP.VBS /act
echo Office����״̬	&& cscript /nologo OSPP.VBS /dstatus

:end 
set k=
set v=
cd %cur_dir%
set office_dir=