@echo off
echo.
echo Scanning start...
echo.
echo ==========================
echo DISM check health [1/6]
echo ==========================
echo.
echo Running CheckHealth...

DISM.exe /Online /Cleanup-image /CheckHealth

REM %errorlevel% == exit code from last executed program
if %errorlevel% neq 0 (
    echo DISM CheckHealth encountered an error!
    pause
    exit /b %errorlevel%
)
echo.
echo ==========================
echo DISM scan health [2/6]
echo ==========================
echo.
echo Running ScanHealth...
DISM.exe /Online /Cleanup-image /Scanhealth

if %errorlevel% neq 0 (
    echo DISM Scanhealth encountered an error!
    pause
    exit /b %errorlevel%
)
echo.
echo =========================
echo DISM restore health [3/6]
echo =========================
echo.
echo Running RestoreHealth...

REM repairs the Windows component store.
DISM.exe /Online /Cleanup-image /Restorehealth

if %errorlevel% neq 0 (
    echo DISM RestoreHealth encountered an error!
    pause
    exit /b %errorlevel%
)
echo.
echo =========================
echo SFC scan	[4/6]
echo =========================
echo.
echo Running sfc scannow...

REM checks and repairs protected system files
sfc /scannow
if %errorlevel% neq 0 (
    echo sfc scannow encountered an error!
    pause
    exit /b %errorlevel%
)
echo.
echo ========================
echo DNS cache [5/6]
echo ========================
echo.
REM Flush DNS cache
echo Flushing DNS cache...
ipconfig /flushdns

if %errorlevel% neq 0 (
    echo WARNING: DNS flush failed.
)
echo ========================
echo C drive scan [6/6]
echo ========================
REM Scan Windows drive for filesystem errors
echo Scanning C drive...
chkdsk C: /scan
REM note: only successfully performing scan
REM Does not perform offline repairs.
if %errorlevel% neq 0 (
    echo WARNING: C drive scan failed.
)
echo.
echo =================================
echo Maintenance process completed.
echo =================================
echo You can close the terminal.
echo pause