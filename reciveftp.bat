@echo off
title RECIVER
if exist curl.exe (
goto curlpathsetb
) else (
    set curlpath=curl
    echo is recommended to have the curl provided.
    pause
    goto inic
)
rem to fix a if () bug
:curlpathsetb
    set "curlpath=%~dp0curl.exe"
    echo %curlpath% set
    goto inic

:inic
cd users

:o

echo catching the user
if not exist reciverin.l (
    echo waiting for reciverin.l
    echo waiting for reciver_filename.l0
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
echo setting the protocol mode
set /p sftpmode=<sftp
if EXIST sftp (
 set sftpmode=sftp
 goto loop2
) else (
    set sftpmode=ftp
)

:loop
echo Checking if exit
if exist exit.pp (
echo Exiting Bye!
del exit.pp
    timeout /t 2 > nul
goto EOF

)
echo Checking file...
timeout /t 1 > nul
"%curlpath%" --user %username%:%password% --head --silent %sftpmode%://%server%/%filename_save% -k > header.txt
echo "%curlpath%" --user %username%:%password% --head --silent %sftpmode%://%server%/%filename_save% -k m header.txt
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
    "%curlpath%" --user %username%:%password% -o %filename_save% %sftpmode%://%server%/%filename_save% -k
    echo "%curlpath%" --user %username%:%password% -o %filename_save% %sftpmode%://%server%/%filename_save% -k
    echo refreshing text screen
    echo 0>text.refresh
    echo sending notification
    if NOT EXIST nntfdp (
        if EXIST notif (
            powershell -Command "[reflection.assembly]::loadwithpartialname('System.Windows.Forms'); [reflection.assembly]::loadwithpartialname('System.Drawing'); $notify = new-object system.windows.forms.notifyicon; $notify.icon = [System.Drawing.SystemIcons]::Information; $notify.visible = $true; $notify.showballoontip(10,'New Message!','You have received New Message from %user%!',[system.windows.forms.tooltipicon]::None)"
            goto loop
        )
    ) else (
        del nntfdp
        goto loop
    )
)

goto loop


:loop2
if NOT EXIST sftpchecker (
    mkdir sftpchecker
    goto sftpchecked
) else (
    goto sftpchecked
)

:sftpchecked
echo Checking if exit
if exist exit.pp (
echo Exiting Bye!
del exit.pp
    timeout /t 2 > nul
goto EOF

)
if exist %filename_save% (
    for %%A in (%filename_save%) do set local_file_size=%%~zA
) else (
    echo The message file does not exist.
    set local_file_size=0
)
cd sftpchecker
    "%curlpath%" --user %username%:%password% -o %filename_save% %sftpmode%://%server%/%filename_save% -k
if exist %filename_save% (
    for %%A in (%filename_save%) do set server_file_size=%%~zA
    cd ..
) else (
    echo The message file does not exist.
    set server_file_size=0
)

echo File size on the server: %server_file_size%
echo File size on the local machine: %local_file_size%

if %local_file_size% equ %server_file_size% (
    echo File is the same, no changes made.
) else (
    echo File has changed. Downloading file...
    "%curlpath%" --user %username%:%password% -o %filename_save% %sftpmode%://%server%/%filename_save% -k
    echo "%curlpath%" --user %username%:%password% -o %filename_save% %sftpmode%://%server%/%filename_save% -k
    echo refreshing text screen
    echo 0>text.refresh
    echo sending notification
    if NOT EXIST nntfdp (
        if EXIST notif (
            powershell -Command "[reflection.assembly]::loadwithpartialname('System.Windows.Forms'); [reflection.assembly]::loadwithpartialname('System.Drawing'); $notify = new-object system.windows.forms.notifyicon; $notify.icon = [System.Drawing.SystemIcons]::Information; $notify.visible = $true; $notify.showballoontip(10,'New Message!','You have received New Message from %user%!',[system.windows.forms.tooltipicon]::None)"
            goto sftpchecked
        )
    ) else (
        del nntfdp
        goto sftpchecked
    )
)
goto sftpchecked


:EOF
exit
