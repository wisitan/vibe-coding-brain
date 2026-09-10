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
if exist "%GEMINI_DIR%\GEMINI.md" del /F /Q "%GEMINI_DIR%\GEMINI.md"
mklink /H "%GEMINI_DIR%\GEMINI.md" "%REPO_DIR%\GEMINI.md" 2>nul
if errorlevel 1 (
    copy /Y "%REPO_DIR%\GEMINI.md" "%GEMINI_DIR%\GEMINI.md" >nul
)
echo    - GEMINI.md linked.

echo [2/4] Linking rules...
if exist "%CONFIG_DIR%\rules" rmdir /S /Q "%CONFIG_DIR%\rules"
mklink /J "%CONFIG_DIR%\rules" "%REPO_DIR%\rules" >nul
echo    - Rules linked.

echo [3/4] Linking skills...
if exist "%CONFIG_DIR%\skills" rmdir /S /Q "%CONFIG_DIR%\skills"
mklink /J "%CONFIG_DIR%\skills" "%REPO_DIR%\skills" >nul
echo    - Skills linked.

echo [4/4] Linking templates...
if exist "%CONFIG_DIR%\templates" rmdir /S /Q "%CONFIG_DIR%\templates"
mklink /J "%CONFIG_DIR%\templates" "%REPO_DIR%\templates" >nul
echo    - Templates linked.

echo.
echo ============================================================
echo  🎉 น้อง Sunday ในเครื่อง PC พร้อมทำงานด้วย Master Brain แล้วค่ะ!
echo ============================================================
echo.
pause
