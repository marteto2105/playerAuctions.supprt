@echo off
echo 🚀 Opening 301.tv/ehtedh style link...
echo.
echo 📱 Accessing: ehtedh.html (Short Link)
echo 🎯 Target: working-site.html (PlayerAuctions Order #2458291)
echo.

:: Check if the file exists
if exist "ehtedh.html" (
    echo ✅ Opening short link interface...
    start "" "ehtedh.html"
    echo 🎉 Done! You should see the countdown redirect page.
) else (
    echo ❌ Error: ehtedh.html not found!
    echo 📍 Looking in: %cd%
    echo.
    echo 🔧 Trying alternative access...
    if exist "working-site.html" (
        echo ✅ Found working-site.html - opening directly...
        start "" "working-site.html"
    ) else (
        echo ❌ Could not find working-site.html either!
        echo 📂 Please check your directory structure.
    )
)

echo.
echo 📝 Available shortcuts:
echo   - ehtedh.html (this short link)
echo   - go.html (previous short link)
echo   - working-site.html (main site)
echo   - LAUNCH-WEBSITE.html (launcher)
echo.
echo 💡 Tip: Bookmark the ehtedh.html page for quick access!
pause