@echo off
REM Build Docker image locally

echo Building Docker image...
docker build -t demo:latest .

if %errorlevel% equ 0 (
    echo.
    echo [SUCCESS] Docker image built successfully!
    echo Image: demo:latest
) else (
    echo.
    echo [ERROR] Docker build failed!
    exit /b 1
)

