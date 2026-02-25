@echo off
REM NES Build Script - Assembles modular.asm into modular.nes using NESASM3
REM Make sure NESASM3.exe is in your PATH or this folder

setlocal
set ASM=modular.asm
set OUT=modular.nes
set NESASM=NESASM3.exe

if not exist %NESASM% (
    echo NESASM3.exe not found! Please download NESASM3 and place it here or in your PATH.
    exit /b 1
)

%NESASM% %ASM% -o %OUT%
if errorlevel 1 (
    echo Build failed!
    exit /b 1
)
echo Build succeeded: %OUT%
endlocal
pause
