@echo off
setlocal ENABLEEXTENSIONS
set DP0=%~dp0
set ROOT=%DP0:~0,-1%

set PLATFORM=x86
set OKIBA_BRANCH=develop

if not defined INSTALLER_URL (
  set INSTALLER_URL=https://raw.githubusercontent.com/neguse11/cm3d2_plugins_okiba/%OKIBA_BRANCH%/scripts/installer.bat
)
set INSTALLER_FILE=installer.bat

powershell -Command "(New-Object Net.WebClient).DownloadFile('%INSTALLER_URL%', '%ROOT%\%INSTALLER_FILE%')"
if not exist "%ROOT%\%INSTALLER_FILE%" (
  echo インストーラーのダウンロードに失敗しました
  exit /b 1
)

call "%ROOT%\%INSTALLER_FILE%"
del "%ROOT%\%INSTALLER_FILE%"

if defined OKIBA_DONT_SELF_DELETE ( exit /b 0 )
(goto) 2>nul & del "%~f0"
