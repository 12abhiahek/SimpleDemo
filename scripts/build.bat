@echo off
REM Build the project with Maven

echo Building Demo project...
call mvn clean package -DskipTests

if %errorlevel% equ 0 (
    echo.
    echo [SUCCESS] Build successful!
    echo JAR file: target\demo.jar
) else (
    echo.
    echo [ERROR] Build failed!
    exit /b 1
)

