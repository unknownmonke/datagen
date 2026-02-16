@echo off
setlocal

set VERSION=1.14.5

docker run ^
       --rm ^
       --env-file %cd%/license.env ^
       --net=host ^
       -v %cd%/root.json:/home/root.json ^
       -v %cd%/data:/home/data ^
       -v %cd%/connections:/home/connections ^
       -v %cd%/generators:/home/generators ^
       shadowtraffic/shadowtraffic:%VERSION% ^
       --config /home/root.json

REM Dry-run mode : --stdout --sample 10

if %ERRORLEVEL% neq 0 (
    echo Command failed with error code %ERRORLEVEL%
    exit /b %ERRORLEVEL%
)

echo Command completed successfully