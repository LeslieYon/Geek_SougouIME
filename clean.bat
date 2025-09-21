@echo off

:: Check for administrator privileges
net session >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo This script requires administrator privileges to run. Please run as administrator.
    pause
    exit /b 1
)

setlocal EnableDelayedExpansion

:: Initialize success and failure counters
set "SUCCESS_COUNT=0"
set "FAIL_COUNT=0"

:: Function: Get Sogou Input installation path
call :GetSogouPath
if %ERRORLEVEL% neq 0 (
    echo Failed to retrieve SogouInput path.
    exit /b %ERRORLEVEL%
)

:: Function: Get Sogou Input configuration directory
call :GetSogouConfigPath
if %ERRORLEVEL% neq 0 (
    echo Failed to retrieve SogouInput configuration path.
    exit /b %ERRORLEVEL%
)

:: Call function to perform file operations
call :PerformFileOperations "%SOGOU_PATH%"

:: Call function to delete LOG directory
call :DeleteLogDirectory "%SOGOU_CONFIG_PATH%"

:: Output operation summary
echo.
echo Operation Summary:
echo Successful operations: %SUCCESS_COUNT%
echo Failed operations: %FAIL_COUNT%

endlocal
pause
exit /b 0

:GetSogouPath
:: Try to query WOW6432Node path under 64-bit system
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SogouInput" /ve >nul 2>&1
if %ERRORLEVEL% equ 0 (
    for /f "tokens=2*" %%i in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\SogouInput" /ve ^| findstr /i "REG_SZ"') do (
        set "SOGOU_PATH=%%j"
    )
) else (
    :: If WOW6432Node does not exist, try to query path under 32-bit system
    reg query "HKEY_LOCAL_MACHINE\SOFTWARE\SogouInput" /ve >nul 2>&1
    if %ERRORLEVEL% equ 0 (
        for /f "tokens=2*" %%i in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\SogouInput" /ve ^| findstr /i "REG_SZ"') do (
            set "SOGOU_PATH=%%j"
        )
    ) else (
        echo Error: SogouInput registry key not found.
        set "SOGOU_PATH="
        exit /b 1
    )
)

:: Check if path was successfully retrieved and verify existence
if not defined SOGOU_PATH (
    echo Error: Failed to retrieve SogouInput path.
    exit /b 1
)

:: Verify if path exists
if not exist "!SOGOU_PATH!\" (
    echo Error: SogouInput path "!SOGOU_PATH!" does not exist.
    set "SOGOU_PATH="
    exit /b 1
)

echo Retrieved SogouInput Path: "!SOGOU_PATH!"
exit /b 0

:GetSogouConfigPath
:: Get LocalLow directory from environment variable and construct Sogou config path
set "SOGOU_CONFIG_PATH=%USERPROFILE%\AppData\LocalLow\SogouPY"

:: Check if config path was successfully retrieved and verify existence
if not defined SOGOU_CONFIG_PATH (
    echo Error: Failed to retrieve SogouInput configuration path.
    exit /b 1
)

:: Verify if path exists
if not exist "!SOGOU_CONFIG_PATH!\" (
    echo Error: SogouInput configuration path "!SOGOU_CONFIG_PATH!" does not exist.
    set "SOGOU_CONFIG_PATH="
    exit /b 1
)

echo Retrieved SogouInput Config Path: "!SOGOU_CONFIG_PATH!"
exit /b 0

:PerformFileOperations
set "BASE_PATH=%~1\14.12.0.1506"
set "SOGOUEXE_PATH=%~1\SogouExe"

:: 1. Rename beacon_sdk.dll
echo Renaming "!BASE_PATH!\beacon_sdk.dll" to beacon_sdk.dll.bak...
if exist "!BASE_PATH!\beacon_sdk.dll" (
    ren "!BASE_PATH!\beacon_sdk.dll" "beacon_sdk.dll.bak"
    if errorlevel 1 (
        echo Error: Failed to rename beacon_sdk.dll.
        set /a FAIL_COUNT+=1
    ) else (
        echo Successfully renamed beacon_sdk.dll.
        set /a SUCCESS_COUNT+=1
    )
) else (
    echo Warning: "!BASE_PATH!\beacon_sdk.dll" does not exist.
    set /a FAIL_COUNT+=1
)

:: 2. Rename SGWebRender.exe
echo Renaming "!BASE_PATH!\SGWebRender.exe" to SGWebRender.exe.bak...
if exist "!BASE_PATH!\SGWebRender.exe" (
    ren "!BASE_PATH!\SGWebRender.exe" "SGWebRender.exe.bak"
    if errorlevel 1 (
        echo Error: Failed to rename SGWebRender.exe.
        set /a FAIL_COUNT+=1
    ) else (
        echo Successfully renamed SGWebRender.exe.
        set /a SUCCESS_COUNT+=1
    )
) else (
    echo Warning: "!BASE_PATH!\SGWebRender.exe" does not exist.
    set /a FAIL_COUNT+=1
)

:: 3. Rename HWSignature.dll
echo Renaming "!BASE_PATH!\HWSignature.dll" to HWSignature.dll.bak...
if exist "!BASE_PATH!\HWSignature.dll" (
    ren "!BASE_PATH!\HWSignature.dll" "HWSignature.dll.bak"
    if errorlevel 1 (
        echo Error: Failed to rename HWSignature.dll.
        set /a FAIL_COUNT+=1
    ) else (
        echo Successfully renamed HWSignature.dll.
        set /a SUCCESS_COUNT+=1
    )
) else (
    echo Warning: "!BASE_PATH!\HWSignature.dll" does not exist.
    set /a FAIL_COUNT+=1
)

:: 4. Copy runtime.ini to Data directory
echo Copying "!BASE_PATH!\runtime.ini" to "!BASE_PATH!\Data"...
if not exist "!BASE_PATH!\Data" (
    echo Creating directory "!BASE_PATH!\Data"...
    mkdir "!BASE_PATH!\Data"
    if errorlevel 1 (
        echo Error: Failed to create Data directory.
        set /a FAIL_COUNT+=1
    ) else (
        echo Successfully created Data directory.
        set /a SUCCESS_COUNT+=1
    )
)
if exist "!BASE_PATH!\runtime.ini" (
    copy "!BASE_PATH!\runtime.ini" "!BASE_PATH!\Data\runtime.ini" >nul
    if errorlevel 1 (
        echo Error: Failed to copy runtime.ini.
        set /a FAIL_COUNT+=1
    ) else (
        echo Successfully copied runtime.ini to Data directory.
        set /a SUCCESS_COUNT+=1
    )
) else (
    echo Warning: "!BASE_PATH!\runtime.ini" does not exist.
    set /a FAIL_COUNT+=1
)

:: 5. Rename SogouExe.exe
echo Renaming "!SOGOUEXE_PATH!\SogouExe.exe" to SogouExe.exe.bak...
if exist "!SOGOUEXE_PATH!\SogouExe.exe" (
    ren "!SOGOUEXE_PATH!\SogouExe.exe" "SogouExe.exe.bak"
    if errorlevel 1 (
        echo Error: Failed to rename SogouExe.exe.
        set /a FAIL_COUNT+=1
    ) else (
        echo Successfully renamed SogouExe.exe.
        set /a SUCCESS_COUNT+=1
    )
) else (
    echo Warning: "!SOGOUEXE_PATH!\SogouExe.exe" does not exist.
    set /a FAIL_COUNT+=1
)

:: 6. Rename SogouSvc.exe
echo Renaming "!SOGOUEXE_PATH!\SogouSvc.exe" to SogouSvc.exe.bak...
if exist "!SOGOUEXE_PATH!\SogouSvc.exe" (
    ren "!SOGOUEXE_PATH!\SogouSvc.exe" "SogouSvc.exe.bak"
    if errorlevel 1 (
        echo Error: Failed to rename SogouSvc.exe.
        set /a FAIL_COUNT+=1
    ) else (
        echo Successfully renamed SogouSvc.exe.
        set /a SUCCESS_COUNT+=1
    )
) else (
    echo Warning: "!SOGOUEXE_PATH!\SogouSvc.exe" does not exist.
    set /a FAIL_COUNT+=1
)

exit /b 0

:DeleteLogDirectory
set "LOG_PATH=%~1\LOG"

:: 7. Delete LOG directory and its contents
echo Deleting "!LOG_PATH!" directory and its contents...
if exist "!LOG_PATH!\" (
    rmdir /s /q "!LOG_PATH!"
    if errorlevel 1 (
        echo Error: Failed to delete LOG directory.
        set /a FAIL_COUNT+=1
    ) else (
        echo Successfully deleted LOG directory.
        set /a SUCCESS_COUNT+=1
    )
) else (
    echo Warning: "!LOG_PATH!" does not exist.
    set /a FAIL_COUNT+=1
)

exit /b 0
