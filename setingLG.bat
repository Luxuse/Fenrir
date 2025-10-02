@echo off
chcp 65001 >nul
title Menu 3 choix
setlocal

:MENU
cls
echo ============================
echo    Fenrir    Language set
echo ============================
echo [1] French
echo [2] English
echo [3] Russian
echo [Q] Quitter
echo ========================
set /p "choix=Your input : "

if /i "%choix%"=="1" goto CHOIX1
if /i "%choix%"=="2" goto CHOIX2
if /i "%choix%"=="3" goto CHOIX3
if /i "%choix%"=="Q" goto END

echo Invalid choice !
pause
goto MENU

:CHOIX1
echo Language=French > "%~dp01.lg"
echo 1.lg (French) a été créé.
pause
goto MENU

:CHOIX2
echo Language=English > "%~dp02.lg"
echo 2.lg (English) a été créé.
pause
goto MENU

:CHOIX3
echo Language=Russian > "%~dp03.lg"
echo 3.lg (Russian) a été créé.
pause
goto MENU

:END
endlocal
exit
