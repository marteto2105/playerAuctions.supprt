@echo off
echo 🚀 PlayerAuctions Website Launcher
echo =====================================
echo.
echo Opening your website in the default browser...
echo.

REM Get the current directory
set "SCRIPT_DIR=%~dp0"

REM Try to open the working HTML file first (most reliable)
if exist "%SCRIPT_DIR%working-site.html" (
    echo ✅ Opening working-site.html (recommended)
    start "" "file:///%SCRIPT_DIR%working-site.html"
) else if exist "%SCRIPT_DIR%index.html" (
    echo ✅ Opening index.html
    start "" "file:///%SCRIPT_DIR%index.html"
) else (
    echo ❌ No HTML files found in: %SCRIPT_DIR%
    echo.
    echo Please check if the HTML files exist in this folder.
    pause
    exit /b 1
)

echo.
echo 🌐 Your website should now be open in your browser!
echo.
echo 💡 If the website doesn't display correctly, try:
echo    1. Press F5 to refresh the page
echo    2. Check if JavaScript is enabled in your browser
echo    3. Try opening working-site.html directly from File Explorer
echo.
echo Press any key to close this window...
pause > nul