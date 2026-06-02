@echo off
setlocal enabledelayedexpansion

echo ============================================
echo  Kernel Module Installation Script
echo ============================================
echo.

REM Set the directory where this script is located
set "SCRIPT_DIR=%~dp0"

REM Ensure the target directory exists on the device
echo [*] Creating /vendor/lib/modules on device...
adb shell "mkdir -p /vendor/lib/modules"

echo [*] Pushing all .ko files to /vendor/lib/modules...
for %%f in ("%SCRIPT_DIR%*.ko") do (
    echo     Pushing %%~nxf ...
    adb push "%%f" /vendor/lib/modules/
)

echo.

REM Define the prioritized module list (in order)
set "PRIORITY_LIST=mmi_relay.ko mmi_info.ko mmi_annotate.ko mmi_sys_temp.ko mmi_lpm_dbg.ko mmi_charger.ko sensors_class.ko anc_fps_mmi.ko fpc1020_mmi.ko ilitek_v4_mmi.ko"

echo [*] Installing prioritized modules first...
for %%m in (%PRIORITY_LIST%) do (
    echo     Checking for %%m ...
    adb shell "[ -f /vendor/lib/modules/%%m ]" >nul 2>&1
    if not errorlevel 1 (
        echo         Installing %%m ...
        adb shell "insmod /vendor/lib/modules/%%m"
    ) else (
        echo         Skipping %%m (file not found)
    )
)

echo.
echo [*] Installing remaining modules...
for %%f in ("%SCRIPT_DIR%*.ko") do (
    set "MODULE=%%~nxf"
    REM Check if this module is already in the priority list
    set "IS_PRIORITY=0"
    for %%p in (%PRIORITY_LIST%) do (
        if /i "!MODULE!"=="%%p" set "IS_PRIORITY=1"
    )
    if "!IS_PRIORITY!"=="0" (
        echo     Installing !MODULE! ...
        adb shell "insmod /vendor/lib/modules/!MODULE!"
    )
)

echo.
echo [*] All modules installed.
echo ============================================
pause
endlocal