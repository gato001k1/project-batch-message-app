@echo off
:inic
cd users 
echo catching the user
if not exist reciverin.l (
echo waiting for reciverin.l
      ) else (
       set /p user<=reciverin.l
       DEL reciverin.l
        goto sender
      )

:sender
echo %user%
echo wip
cd %user%
set /p username<=username
set /p password<=password
set /p server<=server
echo %username%
echo %password%
echo %server%
:loop
rem file checking system checks if the file of the ftp server is the same than the one that you have
curl --%username%:%password% --head --silent ftp://%server%/test.txt > header.txt && for /f "tokens=2 delims=: " %i in ('findstr /i "Content-Length:" header.txt') do echo %i
if exist test.txt (
for /F "tokens=3" %%A in ('"dir /-C test.txt|findstr /C:"File(s)""') do (
   set localfile_size=%%A
  )
 ) else (
      echo the message file doesent exist
 )
if %localfile_size% == %i% (
echo changes made 
echo downloading file
curl -u %username%:%password% -o ftp://%server%/test.txt
goto loop
 ) else (
echo file is same not changes made
goto loop
 )
