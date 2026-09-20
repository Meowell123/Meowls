@echo off
set /p "p=Select install path: "
mkdir "%p%\Meowls" 2> NUL

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
echo Adding Meowls to PATH...
timeout /t 3 /nobreak > NUL

powershell -Command "$p = [Environment]::GetEnvironmentVariable('Path', 'User'); if ($p -notlike '*%ipath%*') { [Environment]::SetEnvironmentVariable('Path', $p + ';%ipath%', 'User') }" > NUL 2>&1

setx ipath "%ipath%" > NUL 2>&1
echo Successfully installed.

if exist C:\ProgramData\Chocolatey\bin\RefreshEnv.cmd (
   call C:\ProgramData\Chocolatey\bin\RefreshEnv.cmd > NUL 2>&1
)