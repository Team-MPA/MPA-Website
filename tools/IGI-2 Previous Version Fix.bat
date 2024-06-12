@echo off
@mode 52,5
color 70
title (C) Team MPA

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    ECHO.
	ECHO **************************************************
	ECHO       Requesting Administrative Privileges
	ECHO **************************************************
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

:main
REG DELETE "HKLM\SOFTWARE\WOW6432Node\IGI 2 Retail" /f >nul
REG DELETE "HKLM\SOFTWARE\IGI 2 Retail" /f >nul
cls
echo.
echo     IGI 2 RETAIL Registry Deleted Successfully!
echo        Now you can Install IGI 2 from Setup!
pause >nul