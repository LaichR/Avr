echo off
set GitRoot=%cd%
if [%1] == [] (echo [41m** no Project specified ** [0m ) & (goto :EOF)
set Project=%1
if [%2] == [] (set ProjectRootFolder=%GitRoot%) else (set ProjectRootFolder=%2)
 
set ProjectRoot=%ProjectRootFolder%\%Project%
set ProjectBuild=%ProjectRoot%\Build
set ToolsRoot=%CD%\ToolChain
set PyScripts=%ToolsRoot%\PyScripts
set AvrGcc=%ToolsRoot%\avr8-gnu-toolchain-win32_x86
set AvrDude=%ToolsRoot%\avrdude-6.3-mingw32
set DotNetLib=%ToolsRoot%\DotNetLib
set Batch=%ToolsRoot%\Batch
if not exist "%ProjectRoot%\" mkdir "%ProjectRoot%"
if not exist "%ProjectRoot%\Build\" mkdir "%ProjectRoot%\Build"
if not exist "%ProjectRoot%\make.bat" copy "%Batch%\make.bat" "%ProjectRoot%"
if not exist "%ProjectRoot%\%Project%.vcxproj" python.exe "%PyScripts%\GenerateVsProject.py"
if not exist "%ProjectRoot%\MakeAndRun.bat" python.exe "%PyScripts%\GenerateMakeAndRun.py"
cd "%ProjectRoot%"
call cmd.exe /K echo  [32m **  environment set to %Project% ** [0m
