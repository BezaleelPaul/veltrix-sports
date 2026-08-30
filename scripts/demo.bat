@echo off
echo ============================================
echo   Veltrix Sports - Demo Launcher
echo ============================================
echo.
echo Choose demo mode:
echo   1. Web (Browser)
echo   2. Web + Mobile Emulator (Side by Side)
echo   3. All Platforms Demo
echo.
set /p choice="Enter choice (1-3): "

if "%choice%"=="1" goto web
if "%choice%"=="2" goto webmobile
if "%choice%"=="3" goto all
goto web

:web
echo.
echo Starting web server...
start http://localhost:8080
cd build\web
python -m http.server 8080
goto end

:webmobile
echo.
echo Starting web server...
start http://localhost:8080
start "" python -m http.server 8080 -d "%~dp0build\web"
echo.
echo Starting Android emulator...
flutter emulators --launch Pixel_6 2>nul
echo.
echo Waiting 10s for emulator to boot...
timeout /t 10 /nobreak >nul
echo.
echo Launching mobile app...
start flutter run -d emulator
pause
goto end

:all
echo.
echo Starting web server...
start http://localhost:8080
start "" python -m http.server 8080 -d "%~dp0build\web"
echo.
echo Starting Android emulator...
flutter emulators --launch Pixel_6 2>nul
echo.
echo Waiting 10s for emulator to boot...
timeout /t 10 /nobreak >nul
echo.
echo Launching mobile app...
start flutter run -d emulator
echo.
echo ============================================
echo   DEMO SETUP COMPLETE
echo ============================================
echo.
echo   Web:        http://localhost:8080
echo   Mobile:     Android Emulator (Pixel_6)
echo   iOS:        Use Chrome DevTools (F12) mobile view
echo.
echo   To toggle dark mode:
echo   - Web: Click sun/moon icon in header
echo   - Mobile: Settings > Dark Mode toggle
echo.
pause
goto end

:end
