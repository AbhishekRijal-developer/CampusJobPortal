@echo off
REM Run MySQL setup script
cd /d "%~dp0"

setlocal enabledelayedexpansion

REM Try common MySQL locations
if exist "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" (
    set "MYSQL=C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"
) else if exist "C:\Program Files (x86)\MySQL\MySQL Server 8.0\bin\mysql.exe" (
    set "MYSQL=C:\Program Files (x86)\MySQL\MySQL Server 8.0\bin\mysql.exe"
) else (
    echo ERROR: MySQL not found
    exit /b 1
)

echo Using MySQL: !MYSQL!
echo Running database setup script...
"!MYSQL!" -u root -p1234 < "database_setup.sql"

if errorlevel 1 (
    echo ERROR: Database setup failed
    exit /b 1
) else (
    echo Database setup completed successfully
    exit /b 0
)
