@echo off
color 57
title HardSoft Viewer
mode con cols=67 lines=42
setlocal  ENABLEDELAYEDEXPANSION
echo Prepare For View ...
del /f "%TEMP%\temp.txt" 2>nul
dxdiag /t %TEMP%\temp.txt
del /f "%COMPUTERNAME%.txt" 2>nul
echo Start Hardware Viewer ...
echo System Information: >>%COMPUTERNAME%.txt
echo       Computer Name = %COMPUTERNAME%>>%COMPUTERNAME%.txt
:system
rem This must 30s

if EXIST "%TEMP%\temp.txt" (
    for /f "tokens=1,2,* delims=:" %%a in ('findstr /c:" Machine name:" /c:" Operating System:" /c:" System Model:" /c:" Processor:" /c:"  Memory:" /c:" Card name:" /c:"Display Memory:" "%TEMP%\temp.txt"') do (
         set /a tee+=1
	rem if !tee! == 1 echo       Computer Name =%%b>>%COMPUTERNAME%.txt
	 if !tee! == 2 echo       OS       Type =%%b>>%COMPUTERNAME%.txt
	 if !tee! == 3 echo       System  Model =%%b>>%COMPUTERNAME%.txt
         if !tee! == 4 echo       CPU     Model =%%b>>%COMPUTERNAME%.txt
	 if !tee! == 5 echo       RAM      Size =%%b>>%COMPUTERNAME%.txt
	 if !tee! == 6 echo DisplayCard : >>%COMPUTERNAME%.txt
         if !tee! == 6 echo       Display  Card =%%b>>%COMPUTERNAME%.txt
 	 if !tee! == 7 echo       DisplayMemory =%%b>>%COMPUTERNAME%.txt
)   ) else (
    ping /n 2 127.1>nul
    goto system
)
set tee=0
echo Mother Board:>>%COMPUTERNAME%.txt
for /f "tokens=1,* delims==" %%a in ('wmic BASEBOARD get Manufacturer^,Product^,Version^,SerialNumber /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       Manufacturer     =%%b>>%COMPUTERNAME%.txt
     if "!tee!" == "4" echo       MotherBoard Model=%%b>>%COMPUTERNAME%.txt

)
set tee=0

)
echo Hard Disk: >>%COMPUTERNAME%.txt
for /f "skip=2 tokens=*" %%a in ('wmic DISKDRIVE get model ^,size /value') do (
   echo.      %%a>>%COMPUTERNAME%.txt
)

set tee=0 
echo Network Card:>>%COMPUTERNAME%.txt
for /f "tokens=2* delims==:" %%a in ('ipconfig/all^|find /i "Description" ^| findstr /v "Microsoft" ^| findstr /v "Tunneling"') do (
   set  name=%%a 
   echo      NetCard Model =%%a>>%COMPUTERNAME%.txt
)
for /f "tokens=2* delims==:" %%a in ('ipconfig/all^|find /i "Physical Address" ^| findstr /v "00-00-00-00"') do (
    set  name=%%a
    echo      MAC Address =%%a>>%COMPUTERNAME%.txt
)
for /f "tokens=2* delims==:" %%a in ('ipconfig/all^|find /i "描述" ^| findstr /v "Microsoft" ^| findstr /v "Tunneling"') do (
    set  name=%%a
    echo      NetCard Model =%%a>>%COMPUTERNAME%.txt
)
for /f "tokens=2* delims==:" %%a in ('ipconfig/all^|find /i "物理地址" ^| findstr /v "00-00-00-00"') do (
    set  name=%%a
    echo      MAC Address =%%a>>%COMPUTERNAME%.txt
)

ver|find /i "windows xp">nul 2>nul&&goto xp||goto win7
:xp
for /f "tokens=2* delims==:" %%a in ('ipconfig/all^|find /i "IP Address"') do (
    set  name=%%a
    echo      IP Address =%%a>>%COMPUTERNAME%.txt
)
echo.>>%COMPUTERNAME%.txt
echo Start Software Viewer For XP...
echo Software Information:>>%COMPUTERNAME%.txt
for /f "tokens=7 delims=\" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" ^| findstr /v "KB" 2^>nul') do (
 for /f "skip=4 tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%%i" /v DisplayName 2^>nul' ) do (
	echo %%b>>%COMPUTERNAME%.txt
  )
)
for /f "tokens=2 delims=\" %%x in ('reg query HKU') do (
  for /f "tokens=8 delims=\" %%a in ('reg query "HKU\%%x\Software\Microsoft\Windows\CurrentVersion\Uninstall" 2^>nul') do (
     for /f "skip=4 tokens=2*" %%i in ('reg query "HKU\%%x\Software\Microsoft\Windows\CurrentVersion\Uninstall\%%a"  /v "DisplayName" 2^>nul') do (
      echo %%j>>%COMPUTERNAME%.txt
     )
  )
)

echo ==================================================================
echo USB Information:
echo USB Information:>>%COMPUTERNAME%.txt
for /f "skip=4 tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\usbstor" /v "start" 2^>nul' ) do (
	if "%%b"=="0x4" echo 	USB is Close
	if "%%b"=="0x3" echo 	USB is Open,Please Tag It.
	if "%%b"=="0x4" echo 	USB is Close>>%COMPUTERNAME%.txt
	if "%%b"=="0x3" echo 	USB is Open,Please Tag It.>>%COMPUTERNAME%.txt
)
echo Language Code:>>%COMPUTERNAME%.txt
for /f "skip=4 tokens=2*" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Control\Nls\Language" /v "Default" 2^>nul' ) do (
	if "%%b"=="0404" echo 	Language:big5>>%COMPUTERNAME%.txt
	if "%%b"=="0804" echo 	Language:gbk>>%COMPUTERNAME%.txt
)

goto last

:win7
for /f "tokens=2* delims==:" %%a in ('ipconfig/all^|find /i "IPV4"') do (
    set  name=%%a
    echo      IP Address = %%a>>%COMPUTERNAME%.txt
)
echo.>>%COMPUTERNAME%.txt
echo Start Software Viewer For Win7/8 ...
rem for 32 win7
echo Software Information:>>%COMPUTERNAME%.txt
for /f "tokens=7 delims=\" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" ^| findstr /v "KB" 2^>nul ') do (
    for /f "skip=2 tokens=3* delims= " %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%%i" /v DisplayName 2^>nul') do (
		echo %%a %%b>>%COMPUTERNAME%.txt
	)
)
for /f "tokens=8 delims=\" %%i in ('reg query "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" 2^>nul ^| findstr /v "KB" 2^>nul ') do (
    for /f "skip=2 tokens=3* delims= " %%a in ('reg query "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\%%i" /v DisplayName 2^>nul') do (
		echo %%a %%b>>%COMPUTERNAME%.txt
	)
)
for /f "tokens=2 delims=\" %%x in ('reg query HKU') do (
  for /f "tokens=8 delims=\" %%a in ('reg query "HKU\%%x\Software\Microsoft\Windows\CurrentVersion\Uninstall" 2^>nul') do (
     for /f "skip=2 tokens=2*" %%i in ('reg query "HKU\%%x\Software\Microsoft\Windows\CurrentVersion\Uninstall\%%a"  /v "DisplayName" 2^>nul') do (
      echo %%j>>%COMPUTERNAME%.txt
     )
  )
)

for /f "tokens=2 delims=\" %%x in ('reg query HKU') do (
  for /f "tokens=9 delims=\" %%a in ('reg query "HKU\%%x\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" 2^>nul') do (
     for /f "skip=2 tokens=2*" %%i in ('reg query "HKU\%%x\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\%%a"  /v "DisplayName" 2^>nul') do (
      echo %%j>>%COMPUTERNAME%.txt
     )
  )
)


echo ==================================================================
echo USB Information:
echo USB Information:>>%COMPUTERNAME%.txt
for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\usbstor" /v "start" 2^>nul' ) do (
	if "%%b"=="0x4" echo 	USB is Close
	if "%%b"=="0x3" echo 	USB is Open,Please Tag It.
	if "%%b"=="0x4" echo 	USB is Close>>%COMPUTERNAME%.txt
	if "%%b"=="0x3" echo 	USB is Open,Please Tag It.>>%COMPUTERNAME%.txt
)
echo Language Code:>>%COMPUTERNAME%.txt
for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Control\Nls\Language" /v "Default" 2^>nul' ) do (
	if "%%b"=="0404" echo 	Language:big5>>%COMPUTERNAME%.txt
	if "%%b"=="0804" echo 	Language:gbk>>%COMPUTERNAME%.txt
)


:last
echo ==================================================================
echo Admin Users:
echo Admin Users:>>%COMPUTERNAME%.txt
for /f "skip=6 tokens=*" %%i in ('net localgroup Administrators ^| findstr /v "㏑" ^| findstr /v "命" ^| findstr /v "command"') do (
	echo       %%i
	echo       %%i>>%COMPUTERNAME%.txt
)
echo Power Users:
echo Power Users:>>%COMPUTERNAME%.txt
for /f "skip=6 tokens=*" %%i in ('net localgroup "Power Users" ^| findstr /v "㏑" ^| findstr /v "命" ^| findstr /v "command"') do (
	echo       %%i
	echo       %%i>>%COMPUTERNAME%.txt
)
echo ==================================================================
echo FileShare Information:
echo.>>%COMPUTERNAME%.txt
echo FileShare Information:>>%COMPUTERNAME%.txt
for /f "skip=4 tokens=*" %%i in ('net share 2^>nul ^| findstr /v "㏑" ^| findstr /v "命" ^| findstr /v "command"' ) do (
   echo  %%i
   echo  %%i>>%COMPUTERNAME%.txt

)
echo =========================Viewer Over==============================
net use \\172.17.44.248 asc /user:asc 1>nul 2>nul
copy %COMPUTERNAME%.txt \\172.17.44.248\HardFile\
net use \\172.17.44.248\IPC$ /del 1>nul 2>nul
pause
start %COMPUTERNAME%.txt
del %0
