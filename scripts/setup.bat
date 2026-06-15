@echo off
REM Quick CI/CD Setup Helper Script for Windows

echo ================================
echo Demo Project CI/CD Setup Helper
echo ================================
echo.

echo Checking prerequisites...
echo.

REM Check Java
for /f "tokens=*" %%i in ('java -version 2^>^&1 ^| findstr /R "version"') do set JAVA_VERSION=%%i
if "%JAVA_VERSION%"=="" (
    echo [WARNING] Java is not installed
) else (
    echo [OK] %JAVA_VERSION%
)

REM Check Maven
where mvn >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] Maven found
) else (
    echo [WARNING] Maven is not installed
)

REM Check Docker
where docker >nul 2>nul
if %errorlevel% equ 0 (
    for /f "tokens=*" %%i in ('docker --version') do echo [OK] %%i
) else (
    echo [WARNING] Docker is not installed
)

REM Check Docker Compose
where docker-compose >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] Docker Compose found
) else (
    echo [WARNING] Docker Compose is not installed
)

REM Check Git
where git >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] Git found
) else (
    echo [WARNING] Git is not installed
)

echo.
echo Available commands:
echo.
echo scripts\build.bat     - Build the project locally
echo scripts\test.bat      - Run tests locally
echo scripts\docker-build.bat - Build Docker image locally
echo scripts\docker-run.bat   - Run Docker containers
echo.
echo Setup complete! You can now:
echo 1. Push to GitHub to trigger CI/CD workflows
echo 2. Create a tag to trigger release workflow
echo 3. Check Actions tab in GitHub for workflow runs

