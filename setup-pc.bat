@echo off
chcp 65001 >nul
echo ============================================================
echo  🧠 Setting up Vibe Coding Brain on Windows PC...
echo ============================================================

set "REPO_DIR=%~dp0"
:: Remove trailing backslash
if "%REPO_DIR:~-1%"=="\" set "REPO_DIR=%REPO_DIR:~0,-1%"

set "GEMINI_DIR=%USERPROFILE%\.gemini"
set "CONFIG_DIR=%GEMINI_DIR%\config"

if not exist "%CONFIG_DIR%" (
    mkdir "%CONFIG_DIR%"
)

echo [1/4] Linking GEMINI.md...
copy /Y "%REPO_DIR%\GEMINI.md" "%GEMINI_DIR%\GEMINI.md" >nul
echo    - GEMINI.md synced.

echo [2/4] Linking rules...
powershell -NoProfile -Command "Remove-Item -Force -Recurse -ErrorAction SilentlyContinue '%CONFIG_DIR%\rules'; New-Item -ItemType Junction -Path '%CONFIG_DIR%\rules' -Target '%REPO_DIR%\rules' | Out-Null"
echo    - Rules junction linked.

echo [3/4] Linking skills...
powershell -NoProfile -Command "Remove-Item -Force -Recurse -ErrorAction SilentlyContinue '%CONFIG_DIR%\skills'; New-Item -ItemType Junction -Path '%CONFIG_DIR%\skills' -Target '%REPO_DIR%\skills' | Out-Null"
echo    - Skills junction linked.

echo [4/4] Linking templates...
powershell -NoProfile -Command "Remove-Item -Force -Recurse -ErrorAction SilentlyContinue '%CONFIG_DIR%\templates'; New-Item -ItemType Junction -Path '%CONFIG_DIR%\templates' -Target '%REPO_DIR%\templates' | Out-Null"
echo    - Templates junction linked.

echo.
echo ============================================================
echo  🎉 น้อง Sunday ในเครื่อง PC พร้อมทำงานด้วย Master Brain แล้วค่ะ!
echo ============================================================
echo.
pause
