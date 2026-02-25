@echo off
REM Build Dragon Warrior NES ROM with ca65/ld65

setlocal
set ASM=dragonwarrior_main_ca65.asm
set OBJ=dragonwarrior_main_ca65.o
set OUT=dragonwarrior.nes
set CFG=8bitstudio.cfg
set CA65=ca65.exe
set LD65=ld65.exe

if not exist %CA65% (
    if exist ..\ca65.exe set CA65=..\ca65.exe
)
if not exist %LD65% (
    if exist ..\ld65.exe set LD65=..\ld65.exe
)

if not exist %CA65% (
    echo ca65.exe not found. Put it in repo root or src\ or PATH.
    exit /b 1
)
if not exist %LD65% (
    echo ld65.exe not found. Put it in repo root or src\ or PATH.
    exit /b 1
)

%CA65% %ASM% -o %OBJ%
if errorlevel 1 (
    echo Assembly failed.
    exit /b 1
)

%LD65% %OBJ% -o %OUT% -C %CFG%
if errorlevel 1 (
    echo Linking failed.
    exit /b 1
)

if not exist ..\roms\dragonwarrior mkdir ..\roms\dragonwarrior
copy /Y %OUT% ..\roms\dragonwarrior\dragonwarrior.nes >nul
echo Build succeeded: %OUT%
echo Copied ROM: ..\roms\dragonwarrior\dragonwarrior.nes
endlocal
