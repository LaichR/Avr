python %PyScripts%\GenerateMake.py %ProjectRoot% %ProjectBuild% elf %2
pushd %ProjectBuild%
call make.exe -f "%ProjectBuild%\Makefile" %1
popd
