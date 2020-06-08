
set ProjectRoot=C:\Users\rolfl\Documents\GitHub\Avr\AvrLib
set ProjectBuild=%ProjectRoot%\Build
set ToolsRoot=C:\Users\rolfl\Documents\GitHub\Avr\ToolChain
set PyScripts=%ToolsRoot%\PyScripts
set AvrGcc=%ToolsRoot%\avr8-gnu-toolchain-win32_x86
set AvrDude=%ToolsRoot%\avrdude-6.3-mingw32
set DotNetLib=%ToolsRoot%\DotNetLib
python %PyScripts%\GenerateMake.py %ProjectRoot% %ProjectBuild% elf
pushd %ProjectBuild%
call make.exe -f "%ProjectBuild%\Makefile" flash
popd
