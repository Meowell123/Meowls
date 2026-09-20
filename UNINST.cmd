@echo off
if exist "%ipath%\" (
    echo The current Meowls installation path is %ipath%.
    echo Uninstalling...
    timeout /t 3 /nobreak > NUL

    rmdir /S /Q "%ipath%"
    if not exist "%ipath%\" (
        (
           echo $p = [Environment]::GetEnvironmentVariable^('Path', 'User'^);
           echo $n = ^($p^) -Replace [Regex]::Escape^(";%ipath%"^), "";
           echo [Environment]::SetEnvironmentVariable^('Path', $n, 'User'^);
           echo [Environment]::SetEnvironmentVariable^('ipath', $null, 'User'^);
        ) > "%temp%\pathcleanup.ps1"
        
        powershell -ExecutionPolicy Bypass -File "%temp%\pathcleanup.ps1" > NUL 2>&1
        del "%temp%\pathcleanup.ps1" > NUL 2>&1
        
        if exist C:\ProgramData\Chocolatey\bin\RefreshEnv.cmd (
           call C:\ProgramData\Chocolatey\bin\RefreshEnv.cmd > NUL 2>&1
        )
        echo Successfully uninstalled.
    ) else (
        echo Uninstallation failed.
    )
) else (
    echo No installation of Meowls was found.
)
