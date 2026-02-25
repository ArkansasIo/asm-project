@echo off
REM Build all NES ASM modules with ca65/ld65
REM Requires ca65.exe, ld65.exe, nes.cfg in this folder or PATH

setlocal
set ASM=main_ca65.asm
set OBJ=main_ca65.o
set OUT=main_ca65.nes
set CFG=nes.cfg
set CA65=ca65.exe
set LD65=ld65.exe

if not exist %CA65% (
    echo ca65.exe not found! Please download cc65 and place ca65.exe here or in your PATH.
    exit /b 1
)
if not exist %LD65% (
    echo ld65.exe not found! Please download cc65 and place ld65.exe here or in your PATH.
    exit /b 1
)

%CA65% %ASM% -o %OBJ%
if errorlevel 1 (
    echo Assembly failed!
    exit /b 1
)

%LD65% %OBJ% -o %OUT% -C %CFG%
if errorlevel 1 (
    echo Linking failed!
    exit /b 1
)
echo Build succeeded: %OUT%
endlocal
pause
