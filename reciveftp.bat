@echo off

:inic
cd users

:o
echo catching the user
if not exist reciverin.l (
    echo waiting for reciverin.l
    timeout /t 1 > nul
    goto o
) else (
    set /p user=<reciverin.l
    del reciverin.l
    goto sender
)

:sender
echo %user%
echo wip
cd %user%
set /p username=<username
set /p password=<password
set /p server=<server
echo %username%
echo %password%
echo %server%

:loop
echo Checking file...
curl --user %username%:%password% --head --silent ftp://%server%/test.txt > header.txt
for /F "tokens=2 delims=: " %%i in ('type header.txt ^| findstr /i "Content-Length:"') do set server_file_size=%%i
if exist test.txt (
    for %%A in (test.txt) do set local_file_size=%%~zA
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
    curl --user %username%:%password% -o test.txt ftp://%server%/test.txt
    echo refreshing text screen
    echo 0>text.refresh
)

goto loop
