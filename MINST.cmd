@echo off
set /p "p=Select install path: "
mkdir "%p%\Meowls"

echo Meowls will be installed to %p%\Meowls.
set "ipath=%p%\Meowls"

timeout /t 2 /nobreak > NUL
echo Installing...
echo Extracting files: 