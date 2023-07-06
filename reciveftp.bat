@echo off
title RECIVER

:inic
cd users

:o
echo catching the user
if not exist reciverin.l (
    echo waiting for reciverin.l
    echo waiting for reciver_filename.l
    timeout /t 1 > nul
    goto o
) else (
    set /p user=<reciverin.l
    set /p filename_save=<reciver_filename.l
    del reciverin.l
    del reciver_filename.l
    goto sender
)

:sender
echo %user%
echo wip
cd %user%
set /p username=<username
set /p password=<password
set /p server=<server
echo %filename_save%
echo %username%
echo %password%
echo %server%

:loop
echo Checking file...
timeout /t 1 > nul
curl --user %username%:%password% --head --silent ftp://%server%/%filename_save% > header.txt
for /F "tokens=2 delims=: " %%i in ('type header.txt ^| findstr /i "Content-Length:"') do set server_file_size=%%i
if exist %filename_save% (
    for %%A in (%filename_save%) do set local_file_size=%%~zA
) else (
    echo The message file does not exist.
    set local_file_size=0
)

echo File size on the server: %server_file_size%
echo File size on the local machine: %local_file_size%

if %local_file_size% equ %server_file_size% (
    echo File is the same, no changes made.
) else (
    echo File has changed. Downloading file...
    curl --user %username%:%password% -o %filename_save% ftp://%server%/%filename_save%
    echo refreshing text screen
    echo 0>text.refresh
)

goto loop
