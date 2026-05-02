@echo off
setlocal

REM ======================================================
REM Configuration Area (Version 1.0)
REM Source launch is enabled. Packaging config is prepared
REM for later and intentionally disabled.
REM ======================================================

set "APP_ROOT=%~dp0"
set "PYTHON_CMD=python"
set "SOURCE_ENTRY=main.py"
set "EXE_CONFIG_FILE=%APP_ROOT%exe_config.json"

REM ======================================================
REM AtlasCore Hub Source Launcher (Version 1.0)
REM Launches Python source only. No EXE usage.
REM ======================================================

title AtlasCore Hub - Source Launcher v1.0

call :load_exe_config

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

:load_exe_config
set "EXE_BUILD_ENABLED=0"
set "EXE_OUTPUT_NAME=AtlasCoreHub.exe"
set "EXE_BUILD_TOOL=pyinstaller"
set "EXE_BUILD_FLAGS=--onefile --windowed"

if not exist "%EXE_CONFIG_FILE%" goto :eof

for /f "usebackq tokens=1* delims==" %%A in (`powershell -NoProfile -ExecutionPolicy Bypass -Command "$cfg = Get-Content -Raw '%EXE_CONFIG_FILE%' | ConvertFrom-Json; $enabled = if ($cfg.exe.build_enabled) { '1' } else { '0' }; @('EXE_BUILD_ENABLED=' + $enabled,'EXE_OUTPUT_NAME=' + $cfg.exe.output_name,'EXE_BUILD_TOOL=' + $cfg.exe.build_tool,'EXE_BUILD_FLAGS=' + $cfg.exe.build_flags)"`) do (
    set "%%A=%%B"
)
goto :eof

:launch_source
cls
echo Launching AtlasCore Hub from Python source...
echo.
if not exist "%APP_ROOT%%SOURCE_ENTRY%" (
    echo ERROR: Could not find APP\%SOURCE_ENTRY%
    echo This launcher must stay in the APP folder.
    pause
    goto menu
)

%PYTHON_CMD% "%APP_ROOT%%SOURCE_ENTRY%"

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
echo - EXE settings are configured but disabled (EXE_BUILD_ENABLED=%EXE_BUILD_ENABLED%).
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
REM - Current configurable source-launch values:
REM   - PYTHON_CMD, APP_ROOT, SOURCE_ENTRY
REM - Current required config file:
REM   - APP\exe_config.json (read for future EXE settings)
REM - Future configurable EXE values (disabled, loaded from JSON):
REM   - EXE_BUILD_ENABLED, EXE_OUTPUT_NAME, EXE_BUILD_TOOL, EXE_BUILD_FLAGS
REM - Potential future packaging add-ons (NOT approved/installed):
REM   - PyInstaller (pip package) for .exe bundling
REM   - cx_Freeze or Nuitka as alternative packagers
REM - Potential future Windows requirements:
REM   - Visual C++ Redistributable (depending on packaging target)
REM - External tools status: built-in PowerShell used only for JSON parsing
