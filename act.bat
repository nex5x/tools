@rem �ֶ�����KMS���� Windows 
@echo off &&@if /i "%ed%" == "on" echo on

:selOS
echo  �������Windows VL��KMS������Կ�б�ѡ��Windows�汾
echo 1 -- Win10רҵ��KMS�� W269N-WFGWX-YVC9B-4J6C9-T83GX
echo 2 -- Win10��ҵ��KMS�� NPPR9-FWDCX-D2C8J-H872K-2YT43
echo 3 -- Win10LTSB��KMS�� DCPHK-NFMTC-H88MJ-PFHPY-QJ4BJ
echo 4 -- Win10��ͥ��KMS�� TX9XD-98N7V-6WMQ6-BX7FG-H8Q99
echo 5 -- Win10������KMS�� NW6C2-QMPVW-D7KKK-3GKT6-VCFB2
echo 6 -- Win7רҵ��KMS��  FJ82H-XT6CR-J8D7P-XQJJ2-GPDD4
echo 7 -- Win7��ҵ��KMS��  33PXH-7Y6KF-2VJC9-XBBR8-HVTHH
set /p v=��ѡ��Windows�汾
if v==1 set k=W269N-WFGWX-YVC9B-4J6C9-T83GX && goto selkms
if v==2 set k=NPPR9-FWDCX-D2C8J-H872K-2YT43 && goto selkms
if v==3 set k=DCPHK-NFMTC-H88MJ-PFHPY-QJ4BJ && goto selkms
if v==4 set k=TX9XD-98N7V-6WMQ6-BX7FG-H8Q99 && goto selkms
if v==5 set k=NW6C2-QMPVW-D7KKK-3GKT6-VCFB2 && goto selkms
if v==6 set k=FJ82H-XT6CR-J8D7P-XQJJ2-GPDD4 && goto selkms
if v==7 set k=33PXH-7Y6KF-2VJC9-XBBR8-HVTHH && goto selkms
echo ��ѡ����ȷ�Ĳ���ϵͳ�汾��
goto end

:selkms
rem  KMS���������
echo 1 -- xykz.f3322.org
echo 2 -- kms.03k.org
echo 3 -- kms-win.msdn123.com
echo 4 -- kms.lotro.cc
echo 5 -- kms.shuax.com
echo 6 -- kms.chinancce.com
echo 7 -- m.zpale.com
echo 8 -- cy2617.jios.org
CHOICE /T 2 /C1234678  /D 1 /M ��ѡ�񼤻������
if  ERRORLEVEL gtr 8   goto errorkmssel
if  ERRORLEVEL 7 set kms=m.zpale.comv 		&& goto act
if  ERRORLEVEL 6 set kms=kms.chinancce.com	 && goto act
if  ERRORLEVEL 5 set kms=kms.shuax.com 		&& goto act
if  ERRORLEVEL 4 set kms=kms.lotro.cc 		&& goto act
if  ERRORLEVEL 3 set kms=kms-win.msdn123.com && goto act
if  ERRORLEVEL 2 set kms= kms.03k.org		 && goto act
if  ERRORLEVEL 1 set kms=xykz.f3322.org 		&& goto act
:errorkmssel
��ѡ����ȷ�ļ����������
echo  goto end



:act
slmgr /up
slmgr /ipk %k%
slmgr /skms %kms%
slmgr /ato 
slmgr /dlv

:end 
set k=
set v=