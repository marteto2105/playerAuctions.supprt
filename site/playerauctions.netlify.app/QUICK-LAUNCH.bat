@echo off
echo 🚀 PlayerAuctions Website - Quick Launch
echo ========================================
echo.

REM Check if Node.js is available
where node >nul 2>nul
if %errorlevel% equ 0 (
    echo ✅ Node.js found! Starting web server...
    echo.
    echo 🌐 Opening server at http://localhost:8000
    echo    Press Ctrl+C to stop the server
    echo.
    
    REM Start the Node.js server
    start "" cmd /k "cd /d "%~dp0" && node server.js"
    
    REM Wait a moment for server to start
    timeout /t 2 /nobreak >nul
    
    REM Open browser
    start "" "http://localhost:8000"
    
) else (
    echo ❌ Node.js not found. Using direct file opening instead...
    echo.
    echo 📁 Opening website directly from files...
    
    REM Open the working HTML file directly
    if exist "%~dp0working-site.html" (
        start "" "file:///%~dp0working-site.html"
        echo ✅ Opened working-site.html
    ) else if exist "%~dp0index.html" (
        start "" "file:///%~dp0index.html"
        echo ✅ Opened index.html
    ) else (
        echo ❌ No HTML files found!
        echo.
        echo Please install Node.js from https://nodejs.org/
        echo or check that HTML files exist in this folder.
        pause
        exit /b 1
    )
)

echo.
echo 🎯 Your website should now be open in your browser!
echo.
echo 💡 If you see any issues, try refreshing the page (F5)
echo.
echo Press any key to close this window...
pause >nul