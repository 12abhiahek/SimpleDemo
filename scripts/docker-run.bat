@echo off
REM Run Docker containers with docker-compose

if "%1"=="down" (
    echo Stopping Docker containers...
    docker-compose down
    echo Containers stopped.
) else (
    echo Starting Docker containers...
    docker-compose up -d
    echo.
    echo [SUCCESS] Containers started!
    echo.
    echo Services running:
    echo - App 1: http://localhost:8081
    echo - App 2: http://localhost:8082
    echo - App 3: http://localhost:8083
    echo - Nginx (Load Balancer): http://localhost:80
    echo.
    echo View logs: docker-compose logs -f
    echo Stop containers: docker-run.bat down
)

