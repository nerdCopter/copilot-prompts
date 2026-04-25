@echo off
REM Installation script for Windows
REM Copies files to %APPDATA%\Code\User\prompts\

setlocal

REM Resolve repo root to absolute path
pushd "%~dp0.."
set "REPO_ROOT=%CD%"
popd

set "TARGET_DIR=%APPDATA%\Code\User\prompts"

echo Installing Copilot customizations to %TARGET_DIR%...
echo This will copy files to: %TARGET_DIR%
echo WARNING: Existing files with the same name will be overwritten.
echo.
set /p "CONFIRM=Continue? [y/N] "
if /i not "%CONFIRM%" == "y" (
    echo Aborted.
    exit /b 0
)
echo.

REM robocopy: /E = recurse, /XD = exclude directories
robocopy "%REPO_ROOT%" "%TARGET_DIR%" /E /XD scripts .git __pycache__ /NJH /NJS

echo.
echo Installation complete!
echo Files installed to: %TARGET_DIR%
pause
