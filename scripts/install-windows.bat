@echo off
REM Installation script for Windows
REM Copies tracked files to %APPDATA%\Code\User\prompts\

setlocal enabledelayedexpansion

set "REPO_ROOT=%~dp0.."
set "TARGET_DIR=%APPDATA%\Code\User\prompts"

echo Installing Copilot customizations to %TARGET_DIR%...

REM Create target directory if it doesn't exist
if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"

REM Copy all files recursively, skipping scripts, .git, and __pycache__
for /r "%REPO_ROOT%" %%F in (*) do (
    set "FILE=%%F"
    set "FILE=!FILE:%REPO_ROOT%\=!"
    
    REM Skip scripts, .git, __pycache__ directories
    if "!FILE:scripts\=!" == "!FILE!" (
        if "!FILE:.git\=!" == "!FILE!" (
            if "!FILE:__pycache__\=!" == "!FILE!" (
                set "DEST=%TARGET_DIR%\!FILE!"
                
                REM Create directory if needed
                for %%D in ("!DEST!") do if not exist "%%~dpD" mkdir "%%~dpD"
                
                REM Copy file
                copy /Y "%%F" "!DEST!" >nul
                echo ✓ !FILE!
            )
        )
    )
)

echo.
echo Installation complete!
echo Files installed to: %TARGET_DIR%
pause
