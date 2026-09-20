@echo off
set /p "p=Select install path: "
mkdir "%p%\Meowls"

echo Meowls will be installed to %p%\Meowls.
set "ipath=%p%\Meowls"

timeout /t 2 /nobreak > NUL
echo Installing...
echo Extracting files: %ipath%\meowls.exe 
(
    echo Get-ChildItem ^| ForEach-Object {
    echo     Write-Host "'$_'" -ForegroundColor Cyan
    echo }
) > "%ipath%\meowls.ps1"

powershell -Command "Install-Module ps2exe -Scope CurrentUser; Invoke-ps2exe -inputFile '%ipath%\meowls.ps1' -outputFile '%ipath%\meowls.exe'" > NUL 2>&1

del "%ipath%\meowls.ps1"
echo Successfully installed.