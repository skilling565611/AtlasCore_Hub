@echo off
setlocal

REM ======================================================
REM AtlasCore Hub Source Launcher (Version 1.0)
REM Launches Python source only. No EXE usage.
REM ======================================================

title AtlasCore Hub - Source Launcher v1.0

:menu
cls
echo ===============================================
echo         AtlasCore Hub - Source Launcher
echo ===============================================
echo.
echo 1. Launch AtlasCore Hub (Python source)
echo 2. Packaging Option (Later - disabled)
echo 3. Exit
echo.
set /p choice=Select an option [1-3]: 

if "%choice%"=="1" goto launch_source
if "%choice%"=="2" goto packaging_later
if "%choice%"=="3" goto end

echo.
echo Invalid option. Please choose 1, 2, or 3.
pause
goto menu

:launch_source
cls
echo Launching AtlasCore Hub from Python source...
echo.
if not exist "%~dp0main.py" (
    echo ERROR: Could not find APP\main.py
    echo This launcher must stay in the APP folder.
    pause
    goto menu
)

python "%~dp0main.py"

echo.
echo App process finished.
pause
goto menu

:packaging_later
cls
echo Packaging is intentionally disabled right now.
echo.
echo - No EXE is created by this launcher.
echo - No packaging tools are called.
echo - Enable packaging only after explicit approval.
echo.
pause
goto menu

:end
endlocal
exit /b 0

REM Update Requirements
REM - Current required runtime: Python installed and available on PATH
REM - Current required files: APP\main.py and APP\hub.py
REM - Potential future packaging add-ons (NOT approved/installed):
REM   - PyInstaller (pip package) for .exe bundling
REM   - cx_Freeze or Nuitka as alternative packagers
REM - Potential future Windows requirements:
REM   - Visual C++ Redistributable (depending on packaging target)
REM - External tools status: none used by this file at this time
