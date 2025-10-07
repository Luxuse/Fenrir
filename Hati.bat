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
  set "STR_EXTRACT_START=DEBUT DE L'EXTRACTION"
  set "STR_ERROR_NO_FILE=Erreur : aucun fichier specifie."
  set "STR_ERROR_NOT_FOUND=Erreur : le fichier"
  set "STR_IS_NOT_FOUND=est introuvable."
  set "STR_FILE=Fichier"
  set "STR_SIZE=Taille"
  set "STR_MB=Mo"
  set "STR_START_EXTRACT=Debut de l'extraction..."
  set "STR_EXTRACT_WITH_7ZIP=Extraction avec 7-Zip..."
  set "STR_EXTRACT_WITH_7Z=Extraction avec 7z..."
  set "STR_EXTRACT_WITH_SHARKY=Extraction avec Sharky..."
  set "STR_EXTRACT_WITH_ZPAQ=Extraction avec zpaqfranz..."
  set "STR_EXTRACT_WITH_FREEARC=Extraction avec FreeArc..."
  set "STR_SUCCESS=Extraction terminee avec succes."
  set "STR_FAILED=Erreur : l'extraction a echoue."
) else if "%LANG%"=="RU" (
  set "STR_EXTRACT_START=НАЧАЛО ИЗВЛЕЧЕНИЯ"
  set "STR_ERROR_NO_FILE=Ошибка: файл не указан."
  set "STR_ERROR_NOT_FOUND=Ошибка: файл"
  set "STR_IS_NOT_FOUND=не найден."
  set "STR_FILE=Файл"
  set "STR_SIZE=Размер"
  set "STR_MB=МБ"
  set "STR_START_EXTRACT=Начало извлечения..."
  set "STR_EXTRACT_WITH_7ZIP=Извлечение с 7-Zip..."
  set "STR_EXTRACT_WITH_7Z=Извлечение с 7z..."
  set "STR_EXTRACT_WITH_SHARKY=Извлечение с Sharky..."
  set "STR_EXTRACT_WITH_ZPAQ=Извлечение с zpaqfranz..."
  set "STR_EXTRACT_WITH_FREEARC=Извлечение с FreeArc..."
  set "STR_SUCCESS=Извлечение завершено успешно."
  set "STR_FAILED=Ошибка: извлечение не удалось."
) else (
  set "STR_EXTRACT_START=EXTRACTION START"
  set "STR_ERROR_NO_FILE=Error: no file specified."
  set "STR_ERROR_NOT_FOUND=Error: file"
  set "STR_IS_NOT_FOUND=not found."
  set "STR_FILE=File"
  set "STR_SIZE=Size"
  set "STR_MB=MB"
  set "STR_START_EXTRACT=Starting extraction..."
  set "STR_EXTRACT_WITH_7ZIP=Extracting with 7-Zip..."
  set "STR_EXTRACT_WITH_7Z=Extracting with 7z..."
  set "STR_EXTRACT_WITH_SHARKY=Extracting with Sharky..."
  set "STR_EXTRACT_WITH_ZPAQ=Extracting with zpaqfranz..."
  set "STR_EXTRACT_WITH_FREEARC=Extracting with FreeArc..."
  set "STR_SUCCESS=Extraction completed successfully."
  set "STR_FAILED=Error: extraction failed."
)

cls
:: ───────── Banner ─────────
if exist "%~dp0banner.txt" (
    echo(
    type "%~dp0banner.txt"
    echo(
) else (
    echo ====== %STR_EXTRACT_START% ======
)

:: ───────── Checks ─────────
if "%~1"=="" (
    echo %STR_ERROR_NO_FILE%
    pause & exit /b 1
)

if not exist "%~1" (
    echo %STR_ERROR_NOT_FOUND% "%~1" %STR_IS_NOT_FOUND%
    pause & exit /b 1
)

:: File info
for %%F in ("%~1") do (
    set "normalizedPath=%%~fF"
    set "arcSize=%%~zF"
    set "fileExt=%%~xF"
    set "fileDir=%%~dpF"
)

set /a arcSizeMB=arcSize/1048576

echo(
echo %STR_FILE% : !normalizedPath!
echo %STR_SIZE%  : !arcSizeMB! %STR_MB%
echo(
echo %STR_START_EXTRACT%
echo(

:: ───────── Extraction by extension ─────────
if /i "!fileExt!"==".bz2" (
    echo %STR_EXTRACT_WITH_7ZIP%
    "C:\ProgramData\Fenrir\_Freearc\7z.exe" x "!normalizedPath!" -o"!fileDir!" -y || goto :ERR
) else if /i "!fileExt!"==".7z" (
    echo %STR_EXTRACT_WITH_7Z%
    set "outDir=!fileDir:~0,-1!"
    "C:\ProgramData\Fenrir\_Freearc\7z.exe" x "!normalizedPath!" -o"!fileDir!" -y || goto :ERR
) else if /i "!fileExt!"==".iso" (
    echo %STR_EXTRACT_WITH_7Z%
    set "outDir=!fileDir:~0,-1!"
    "C:\ProgramData\Fenrir\_Freearc\7z.exe" x "!normalizedPath!" -o"!fileDir!" -y || goto :ERR
) else if /i "!fileExt!"==".zip" (
    echo %STR_EXTRACT_WITH_7Z%
    set "outDir=!fileDir:~0,-1!"
    "C:\ProgramData\Fenrir\_Freearc\7z.exe" x "!normalizedPath!" -o"!fileDir!" -y || goto :ERR
) else if /i "!fileExt!"==".rar" (
    echo %STR_EXTRACT_WITH_7Z%
    set "outDir=!fileDir:~0,-1!"
    "C:\ProgramData\Fenrir\_Freearc\7z.exe" x "!normalizedPath!" -o"!fileDir!" -y || goto :ERR
) else if /i "!fileExt!"==".zstd" (
    echo %STR_EXTRACT_WITH_SHARKY%
    set "outDir=!fileDir:~0,-1!"
    "C:\ProgramData\Fenrir\_shark\sharky.exe" -d -i "!normalizedPath!" -o "!outDir!" || goto :ERR
) else if /i "!fileExt!"==".tar" (
    echo %STR_EXTRACT_WITH_7Z%
    set "outDir=!fileDir:~0,-1!"
    "C:\ProgramData\Fenrir\_Freearc\7z.exe" x "!normalizedPath!" -o"!fileDir!" -y || goto :ERR
) else if /i "!fileExt!"==".Zfen" (
    echo %STR_EXTRACT_WITH_ZPAQ%
    set "outDir=!fileDir:~0,-1!"
    "C:\ProgramData\Fenrir\_Freearc\zpaqfranz.exe" x "!normalizedPath!" || goto :ERR
) else (
    echo %STR_EXTRACT_WITH_FREEARC%
    "C:\ProgramData\Fenrir\_Freearc\arc.exe" x "!normalizedPath!" -o+ || goto :ERR
)

:: ───────── End ─────────
echo(
echo %STR_SUCCESS%
pause
exit /b 0

:ERR
echo(
echo %STR_FAILED%
pause
exit /b 1