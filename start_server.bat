@echo off
setlocal enabledelayedexpansion
title Steve's Diamond Catch - Windows Game Server

cd /d "%~dp0"

:: Detect local IPv4 address on Windows
set IP=127.0.0.1
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i /c:"IPv4 Address" /c:"IPv4-Adresse"') do (
    for /f "tokens=1" %%b in ("%%a") do (
        set IP=%%b
        goto :found_ip
    )
)
:found_ip
set IP=%IP: =%

set PORT=8080

echo =======================================================
echo    STEVE'S DIAMOND CATCH - WINDOWS SERVER
echo =======================================================
echo.
echo  1. Make sure your smartphone and PC are connected to
echo     the same Wi-Fi network.
echo.
echo  2. On your iPhone (Safari) or Android (Chrome), open:
echo.
echo     👉   http://%IP%:%PORT%   👈
echo.
echo  3. Tap 'Add to Home Screen' (iOS) or 'Install App'
echo     (Android) for full-screen arcade mode!
echo.
echo  Press Ctrl+C in this window to stop the server.
echo =======================================================
echo.

:: Check for Python
where python >nul 2>nul
if %errorlevel% equ 0 (
    python -m http.server %PORT%
    goto :end
)

:: Check for Python launcher 'py'
where py >nul 2>nul
if %errorlevel% equ 0 (
    py -m http.server %PORT%
    goto :end
)

:: Check for python3
where python3 >nul 2>nul
if %errorlevel% equ 0 (
    python3 -m http.server %PORT%
    goto :end
)

:: Check for Node npx
where npx >nul 2>nul
if %errorlevel% equ 0 (
    npx serve -p %PORT% .
    goto :end
)

:: If Python or Node is not installed, use built-in Windows PowerShell server
echo [NOTICE] Python or Node not found. Launching built-in PowerShell server...
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0start_server.ps1"

:end
pause
