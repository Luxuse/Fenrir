@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: ----- Language Detection -----
set "LANG=EN"
if exist "%~dp0*.lg" (
  for %%f in ("%~dp0*.lg") do (
    set "lgFile=%%~nf"
    if /i "!lgFile!"=="1" set "LANG=FR"
    if /i "!lgFile!"=="2" set "LANG=EN"
    if /i "!lgFile!"=="3" set "LANG=RU"
  )
)

:: ----- Language Strings -----
if "%LANG%"=="FR" (
  set "STR_ERROR_NO_FILE=Erreur : Aucun fichier ou dossier specifie."
  set "STR_USAGE=Usage : %~nx0 ^<chemin\fichier_ou_dossier^>"
  set "STR_ERROR_ACCESS=Erreur : Impossible d'acceder a"
  set "STR_SELECT_FORMAT=Selectionner le format de compression :"
  set "STR_FENRIR=Fenrir"
  set "STR_7ZIP=7-Zip classique"
  set "STR_CHOICE=Choix"
  set "STR_INVALID_CHOICE=Choix invalide."
  set "STR_USE_ENCRYPTION=Utiliser le chiffrement ?"
  set "STR_YES=Oui"
  set "STR_NO=Non"
  set "STR_SELECT_ENC_METHOD=Selectionner la methode de chiffrement :"
  set "STR_CUSTOM=Personnalise"
  set "STR_ENTER_METHOD=Entrer la methode complete (ex: aes+serpent/cfb+twofish) :"
  set "STR_ENTER_PASSWORD=Entrer le mot de passe :"
  set "STR_SELECT_LEVEL=FreeArc - selectionner le niveau de compression :"
  set "STR_SMALL_TEXT=petit texte"
  set "STR_FAST=rapide"
  set "STR_GOOD=bon (sans chiffrement)"
  set "STR_ULTRA=ultra"
  set "STR_COMPRESSING_ZSTD=Compression avec Zstd niveau 19..."
  set "STR_COMPRESSING_FREEARC=Compression avec FreeArc"
  set "STR_COMPRESSING_ZPAQ=Compression avec zpaqfranz"
  set "STR_TO=vers"
  set "STR_7ZIP_SELECT_LEVEL=7-Zip - selectionner le niveau de compression :"
  set "STR_BALANCED=equilibre"
  set "STR_BETTER=meilleur"
  set "STR_MAX=maximum"
  set "STR_COMPRESSING_7ZIP=Compression avec 7-Zip"
  set "STR_COMPLETE=Compression terminee."
  set "STR_FAILED=Echec de la compression !"
  set "STR_INVALID_LEVEL=Niveau invalide."
) else if "%LANG%"=="RU" (
  set "STR_ERROR_NO_FILE=Ошибка: Не указан файл или папка."
  set "STR_USAGE=Использование: %~nx0 ^<путь\файл_или_папка^>"
  set "STR_ERROR_ACCESS=Ошибка: Невозможно получить доступ к"
  set "STR_SELECT_FORMAT=Выберите формат сжатия:"
  set "STR_FENRIR=Фенрир"
  set "STR_7ZIP=7-Zip классический"
  set "STR_CHOICE=Выбор"
  set "STR_INVALID_CHOICE=Неверный выбор."
  set "STR_USE_ENCRYPTION=Использовать шифрование?"
  set "STR_YES=Да"
  set "STR_NO=Нет"
  set "STR_SELECT_ENC_METHOD=Выберите метод шифрования:"
  set "STR_CUSTOM=Пользовательский"
  set "STR_ENTER_METHOD=Введите полный метод (напр: aes+serpent/cfb+twofish):"
  set "STR_ENTER_PASSWORD=Введите пароль:"
  set "STR_SELECT_LEVEL=FreeArc - выберите уровень сжатия:"
  set "STR_SMALL_TEXT=маленький текст"
  set "STR_FAST=быстрый"
  set "STR_GOOD=хороший (без шифрования)"
  set "STR_ULTRA=ультра"
  set "STR_COMPRESSING_ZSTD=Сжатие с Zstd уровень 19..."
  set "STR_COMPRESSING_FREEARC=Сжатие с FreeArc"
  set "STR_COMPRESSING_ZPAQ=Сжатие с zpaqfranz"
  set "STR_TO=в"
  set "STR_7ZIP_SELECT_LEVEL=7-Zip - выберите уровень сжатия:"
  set "STR_BALANCED=сбалансированный"
  set "STR_BETTER=лучше"
  set "STR_MAX=максимум"
  set "STR_COMPRESSING_7ZIP=Сжатие с 7-Zip"
  set "STR_COMPLETE=Сжатие завершено."
  set "STR_FAILED=Сжатие не удалось!"
  set "STR_INVALID_LEVEL=Неверный уровень."
) else (
  set "STR_ERROR_NO_FILE=Error: No file or folder specified."
  set "STR_USAGE=Usage: %~nx0 ^<path\file_or_folder^>"
  set "STR_ERROR_ACCESS=Error: Cannot access"
  set "STR_SELECT_FORMAT=Select compression format:"
  set "STR_FENRIR=Fenrir"
  set "STR_7ZIP=7-Zip classic"
  set "STR_CHOICE=Choice"
  set "STR_INVALID_CHOICE=Invalid choice."
  set "STR_USE_ENCRYPTION=Use encryption?"
  set "STR_YES=Yes"
  set "STR_NO=No"
  set "STR_SELECT_ENC_METHOD=Select encryption method:"
  set "STR_CUSTOM=Custom"
  set "STR_ENTER_METHOD=Enter full method (e.g. aes+serpent/cfb+twofish):"
  set "STR_ENTER_PASSWORD=Enter password:"
  set "STR_SELECT_LEVEL=FreeArc - select compression level:"
  set "STR_SMALL_TEXT=small text"
  set "STR_FAST=fast"
  set "STR_GOOD=good (no encryption)"
  set "STR_ULTRA=ultra"
  set "STR_COMPRESSING_ZSTD=Compressing with Zstd level 19..."
  set "STR_COMPRESSING_FREEARC=Compressing with FreeArc"
  set "STR_COMPRESSING_ZPAQ=Compressing with zpaqfranz"
  set "STR_TO=to"
  set "STR_7ZIP_SELECT_LEVEL=7-Zip - select compression level:"
  set "STR_BALANCED=balanced"
  set "STR_BETTER=better"
  set "STR_MAX=max"
  set "STR_COMPRESSING_7ZIP=Compressing with 7-Zip"
  set "STR_COMPLETE=Compression complete."
  set "STR_FAILED=Compression failed!"
  set "STR_INVALID_LEVEL=Invalid level."
)

:: ----- Argument check -----
if "%~1"=="" (
  echo %STR_ERROR_NO_FILE%
  echo %STR_USAGE%
  pause
  exit /b 1
)

:: ----- Save current directory -----
set "originalDir=%cd%"
pushd "%~dp1" || (
  echo %STR_ERROR_ACCESS% "%~dp1".
  pause
  exit /b 1
)

:: ----- Input info -----
set "inputNameExt=%~nx1"
set "baseName=%~n1"

:FORMAT_MENU
cls
:: ───────── Banner ─────────
if exist "%~dp0banner.txt" (
  echo(
  type "%~dp0banner.txt" 
)
echo.
echo %STR_SELECT_FORMAT%
echo   1. %STR_FENRIR%
echo   2. %STR_7ZIP%   (.7z)
echo.
set "fmt="
set /p "fmt=%STR_CHOICE% (1-2): "
if "%fmt%"=="1" (
  set "ext=fen"
  goto ENCRYPTION_MENU
) else if "%fmt%"=="2" (
  set "ext=7z"
  goto SEVENZ_LEVEL_MENU
) else (
  echo %STR_INVALID_CHOICE%
  pause
  goto FORMAT_MENU
)

:ENCRYPTION_MENU
cls
echo.
echo %STR_USE_ENCRYPTION%
echo   1. %STR_YES%
echo   2. %STR_NO%
echo.
set "enc_choice="
set /p "enc_choice=%STR_CHOICE% (1-2): "
if "%enc_choice%"=="1" (
  goto ENCRYPTION_METHOD_MENU
) else if "%enc_choice%"=="2" (
  goto ARC_LEVEL_MENU
) else (
  echo %STR_INVALID_CHOICE%
  pause
  goto ENCRYPTION_MENU
)

:ENCRYPTION_METHOD_MENU
cls
echo.
echo %STR_SELECT_ENC_METHOD%
echo   1. AES-256
echo   2. Blowfish
echo   3. Twofish
echo   4. Serpent
echo   5. %STR_CUSTOM%
echo.
set "enc_method="
set /p "choice=%STR_CHOICE% (1-5): "
if "%choice%"=="1" set "enc_method=aes-256"
if "%choice%"=="2" set "enc_method=blowfish"
if "%choice%"=="3" set "enc_method=twofish"
if "%choice%"=="4" set "enc_method=serpent"
if "%choice%"=="5" (
  set /p "enc_method=%STR_ENTER_METHOD% "
)
if not defined enc_method (
  echo %STR_INVALID_CHOICE%
  pause
  goto ENCRYPTION_METHOD_MENU
)
set /p "password=%STR_ENTER_PASSWORD% "
goto ARC_LEVEL_MENU

:ARC_LEVEL_MENU
cls
echo.
echo %STR_SELECT_LEVEL%
echo   1. %STR_SMALL_TEXT%
echo   2. %STR_FAST%
echo   3. %STR_GOOD%
echo   4. %STR_ULTRA%
echo.
set "mode="
set /p "lvl=%STR_CHOICE% (1-4): "
if "%lvl%"=="1" set "mode=-i0 -mc:rep/maxsrep+razor"
if "%lvl%"=="2" set "mode=-m2x -s;"
if "%lvl%"=="3" (
    echo.
    echo %STR_COMPRESSING_ZSTD%
    :: Check if input is a folder
    if exist "%inputNameExt%\*" (
        :: Create temporary tar of folder
        "C:\ProgramData\Fenrir\_Freearc\bsdtar.exe" -cf "%baseName%.tar" "%inputNameExt%"
        if errorlevel 1 goto ERR
        :: Compress tar with Zstd
        "C:\ProgramData\Fenrir\_Freearc\zstd.exe" -19 -o "%baseName%.tar.zstd" "%baseName%.tar"
        if errorlevel 1 goto ERR
        :: Delete temporary tar
        del "%baseName%.tar"
    ) else (
        :: If simple file, compress directly
        "C:\ProgramData\Fenrir\_Freearc\zstd.exe" -19 -o "%inputNameExt%.zstd" "%inputNameExt%"
        if errorlevel 1 goto ERR
    )
    goto SUCCESS
)
if "%lvl%"=="4" (
    echo.
    echo %STR_COMPRESSING_ZPAQ% %STR_TO% %baseName%.Zfen...
    "C:\ProgramData\Fenrir\_Freearc\zpaqfranz.exe" add "%baseName%.Zfen" "%inputNameExt%" -m4 -t16
    if errorlevel 1 goto ERR
    goto SUCCESS
)

if not defined mode (
  echo %STR_INVALID_LEVEL%
  pause
  goto ARC_LEVEL_MENU
)
echo.
echo %STR_COMPRESSING_FREEARC% (%mode%) %STR_TO% %baseName%.%ext%...
if defined enc_method (
  set "enc_cmd=--encryption=%enc_method% --password="!password!""
) else (
  set "enc_cmd="
)
"C:\ProgramData\Fenrir\_FreeArc\arc.exe" a "%baseName%.%ext%" %mode% %enc_cmd% "%inputNameExt%"
if errorlevel 1 goto ERR
goto SUCCESS

:SEVENZ_LEVEL_MENU
cls
echo.
echo %STR_7ZIP_SELECT_LEVEL%
echo   1. -mx1 (%STR_FAST%)
echo   2. -mx3 (%STR_BALANCED%)
echo   3. -mx5 (%STR_BETTER%)
echo   4. -mx7 (%STR_ULTRA%)
echo   5. -mx9 (%STR_MAX%)
echo.
set "mx="
set /p "lvl7=%STR_CHOICE% (1-5): "
if "%lvl7%"=="1" set "mx=-mx1"
if "%lvl7%"=="2" set "mx=-mx3"
if "%lvl7%"=="3" set "mx=-mx5"
if "%lvl7%"=="4" set "mx=-mx7"
if "%lvl7%"=="5" set "mx=-mx9"

if not defined mx (
  echo %STR_INVALID_CHOICE%
  pause
  goto SEVENZ_LEVEL_MENU
)
echo.
echo %STR_COMPRESSING_7ZIP% (%mx%) %STR_TO% %baseName%.%ext%...
"C:\ProgramData\Fenrir\_FreeArc\7z.exe" a %mx% "%baseName%.%ext%" "%inputNameExt%"
if errorlevel 1 goto ERR
goto SUCCESS

:SUCCESS
echo.
echo %STR_COMPLETE%
popd
pause
exit /b 0

:ERR
echo.
echo %STR_FAILED%
popd
pause
exit /b 1