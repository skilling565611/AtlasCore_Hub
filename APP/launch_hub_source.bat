@echo off
setlocal

REM ======================================================
REM Configuration Area (Version 1.0)
REM Source launch is enabled. EXE packaging support stays
REM configured and active. EXE build runs only when there
REM is an explicit request/approval.
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
echo 2. Packaging Settings Status (EXE build on explicit request)
echo 0. Exit
echo.
set /p choice=Select an option [0-2]: 

if "%choice%"=="1" goto launch_source
if "%choice%"=="2" goto packaging_later
if "%choice%"=="0" goto end

echo.
echo Invalid option. Please choose 0, 1, or 2.
pause
goto menu

:load_exe_config
set "EXE_SUPPORT_ENABLED=1"
set "EXE_SETTINGS_ACTIVE=1"
set "EXE_BUILD_ALLOWED_WHEN_REQUESTED=1"
set "EXE_BUILD_EXECUTION_APPROVED=0"
set "EXE_OUTPUT_NAME=AtlasCoreHub.exe"
set "EXE_BUILD_TOOL=pyinstaller"
set "EXE_BUILD_FLAGS=--onefile --windowed"

if not exist "%EXE_CONFIG_FILE%" goto :eof

for /f "usebackq tokens=1* delims==" %%A in (`powershell -NoProfile -ExecutionPolicy Bypass -Command "$cfg = Get-Content -Raw '%EXE_CONFIG_FILE%' | ConvertFrom-Json; $support = if ($cfg.exe.support_enabled) { '1' } else { '0' }; $active = if ($cfg.exe.settings_active) { '1' } else { '0' }; $allowed = if ($cfg.exe.build_allowed_when_requested) { '1' } else { '0' }; $approved = if ($cfg.exe.build_execution_approved) { '1' } else { '0' }; @('EXE_SUPPORT_ENABLED=' + $support,'EXE_SETTINGS_ACTIVE=' + $active,'EXE_BUILD_ALLOWED_WHEN_REQUESTED=' + $allowed,'EXE_BUILD_EXECUTION_APPROVED=' + $approved,'EXE_OUTPUT_NAME=' + $cfg.exe.output_name,'EXE_BUILD_TOOL=' + $cfg.exe.build_tool,'EXE_BUILD_FLAGS=' + $cfg.exe.build_flags)"`) do (
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
echo EXE packaging support is configured and ready.
echo.
echo - Support enabled: %EXE_SUPPORT_ENABLED%
echo - Settings active: %EXE_SETTINGS_ACTIVE%
echo - Build allowed when requested: %EXE_BUILD_ALLOWED_WHEN_REQUESTED%
echo - Build execution approved now: %EXE_BUILD_EXECUTION_APPROVED%
echo - Output name: %EXE_OUTPUT_NAME%
echo - Build tool: %EXE_BUILD_TOOL%
echo - Build flags: %EXE_BUILD_FLAGS%
echo.
echo EXE build is permitted only on explicit request.
echo This launcher does not auto-create, auto-build, run, or test any EXE.
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
REM - Current configurable EXE values (loaded from JSON):
REM   - EXE_SUPPORT_ENABLED, EXE_SETTINGS_ACTIVE
REM   - EXE_BUILD_ALLOWED_WHEN_REQUESTED (policy toggle)
REM   - EXE_BUILD_EXECUTION_APPROVED (set only when explicit build is requested)
REM   - EXE_OUTPUT_NAME, EXE_BUILD_TOOL, EXE_BUILD_FLAGS
REM - Potential future packaging add-ons (NOT approved/installed):
REM   - PyInstaller (pip package) for .exe bundling
REM   - cx_Freeze or Nuitka as alternative packagers
REM - Potential future Windows requirements:
REM   - Visual C++ Redistributable (depending on packaging target)
REM - External tools status: built-in PowerShell used only for JSON parsing
