@echo off
REM Veltrix Sports - GitHub Setup Script

echo ============================================
echo VELTRIX SPORTS - GitHub Backup Setup
echo ============================================
echo.

REM Step 1: Initialize Git
echo [1/6] Initializing Git repository...
cd C:\Users\bezal\Downloads\veltrix_sports
git init
echo.

REM Step 2: Create .gitignore
echo [2/6] Creating .gitignore...
echo # Veltrix Sports .gitignore > .gitignore
echo. >> .gitignore
echo # Flutter >> .gitignore
echo .dart_tool/ >> .gitignore
echo .packages >> .gitignore
echo build/ >> .gitignore
echo. >> .gitignore
echo # Android >> .gitignore
echo android/.gradle/ >> .gitignore
echo android/app/debug/ >> .gitignore
echo android/app/profile/ >> .gitignore
echo android/app/release/ >> .gitignore
echo. >> .gitignore
echo # iOS >> .gitignore
echo ios/Pods/ >> .gitignore
echo ios/.symlinks/ >> .gitignore
echo ios/Flutter/Flutter.framework >> .gitignore
echo. >> .gitignore
echo # IDE >> .gitignore
echo .vscode/ >> .gitignore
echo.idea/ >> .gitignore
echo *.iml >> .gitignore
echo. >> .gitignore
echo # OS >> .gitignore
echo .DS_Store >> .gitignore
echo Thumbs.db >> .gitignore
echo. >> .gitignore
echo # Environment >> .gitignore
echo .env >> .gitignore
echo .env.local >> .gitignore
echo. >> .gitignore
echo # Python >> .gitignore
echo __pycache__/ >> .gitignore
echo *.pyc >> .gitignore
echo. >> .gitignore
echo # Temporary >> .gitignore
echo *.tmp >> .gitignore
echo *.bak >> .gitignore
echo. >> .gitignore
echo # Keep diagrams >> .gitignore
echo !diagrams/ >> .gitignore
echo. >> .gitignore
echo # Keep documentation >> .gitignore
echo !*.md >> .gitignore
echo !*.txt >> .gitignore
echo !*.docx >> .gitignore
echo.

REM Step 3: Add files
echo [3/6] Adding files to Git...
git add .
echo.

REM Step 4: Commit
echo [4/6] Creating initial commit...
git commit -m "Initial commit: Veltrix Sports documentation and diagrams"
echo.

REM Step 5: Create GitHub repo
echo [5/6] Creating GitHub repository...
echo.
echo Please follow these steps:
echo 1. Go to https://github.com/new
echo 2. Repository name: veltrix-sports
echo 3. Description: Veltrix Sports - Coaching, Events & Ticketing Platform
echo 4. Select: Public (or Private)
echo 5. Click "Create repository"
echo 6. Copy the repository URL
echo.
set /p REPO_URL="Enter your GitHub repository URL: "
echo.

REM Step 6: Push to GitHub
echo [6/6] Pushing to GitHub...
git remote add origin %REPO_URL%
git branch -M main
git push -u origin main
echo.

echo ============================================
echo SUCCESS! Documentation backed up to GitHub
echo ============================================
echo.
echo Repository URL: %REPO_URL%
echo.
echo Your documentation is now safely backed up!
echo.
pause
