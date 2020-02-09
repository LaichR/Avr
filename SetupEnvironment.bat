echo off
if [%1] == [] (echo [41m** no environment specified ** [0m ) & (goto :EOF)
set Project=%1
set ProjectRoot=%CD%\%Project%
set ProjectBuild=%ProjectRoot%\Build
set ToolsRoot=%CD%\ToolChain
set PyScripts=%ToolsRoot%\PyScripts
set AvrGcc=%ToolsRoot%\avr8-gnu-toolchain-win32_x86
set AvrDude=%ToolsRoot%\avrdude-6.3-mingw32
set DotNetLib=%ToolsRoot%\DotNetLib
set Batch=%ToolsRoot%\Batch
if not exist %1 mkdir %1
if not exist %1\Build mkdir %1\Build
if not exist %ProjectRoot%\make.bat copy %Batch%\make.bat %ProjectRoot%
if not exist %ProjectRoot%\%Project%.vcxproj python.exe %PyScripts%\GenerateVsProject.py
cd %ProjectRoot%
call cmd.exe /K echo  [32m **  environment set to %Project% ** [0m
