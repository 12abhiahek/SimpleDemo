@echo off
REM Run tests for the project

echo Running tests for Demo project...
call mvn test

if %errorlevel% equ 0 (
    echo.
    echo [SUCCESS] All tests passed!
) else (
    echo.
    echo [ERROR] Some tests failed!
    exit /b 1
)

