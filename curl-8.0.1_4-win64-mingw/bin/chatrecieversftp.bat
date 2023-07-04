@echo off
setlocal enabledelayedexpansion
cls
title test CHBAT v1.5
::requirements
set /p filename=<=filename.save
if not exist users (
    echo creating user folder
    mkdir users
    cls
    goto ftpUsers
) else (
    goto ftpUsers
)

:ftpUsers
if not exist username.u (
    :changeusername
    cls
    echo What username would you like to use?
    set /p "uusername="
    echo !uusername! > username.u 
    set /p "uusername=" < username.u
    cd users 
    echo !uusername!
    pause
) else (
    set /p "uusername=" < username.u
    echo !uusername!
    cd users
)
:ftpuserschoose
cls
echo select the user or option
echo Write create to make a new user or settings to enter the settings and write exit to exit:
::display the user list
dir /b
set /p optusr=
if /i "%optusr%"=="exit" (
    goto exit
)
if /i "%optusr%"=="settings" (
    goto settings
)
if /i "%optusr%"=="create" (
    cls
    goto inic
) else (
    IF NOT EXIST %optusr% (
        echo %optusr% does not exist
        pause
        cls
        goto ftpUsers
    ) else (
      cd %optusr%
set /p ftpUsername=<username
set /p ftpServer=<server
set /p ftpPassword=<password
cd ..
echo !optusr!>reciverin.l
cd ..
start reciveftp.bat
cd users
cd !optusr!
cls
goto loop
    )
)


:inic
cls
echo Enter The custom name:
set /p Customname=
Echo Enter the IP address or the Host name of the SFTP server:
set /p ftpServer=
Echo Enter the username to log in to the SFTP server:
set /p ftpUsername=
Echo Enter the password to log in to the SFTP server:
set /p ftpPassword=

::user creator system
if exist !Customname! (
    echo that username is already taken
    pause
    cls && goto inic
) else (
    echo creating user
    mkdir !Customname!
    cd !Customname!
    echo !ftpUsername!>username
    echo !ftpServer!>server
    echo !ftpPassword!>password
     cd ..
        echo !optusr!>reciverin.l
        cd ..
        start reciveftp.bat
        cd users
        cd !optusr!
        cls
    goto loop
)

::messaging system WIP
:loop
goto send2

:send2
cls
type test.txt
echo  server credetials %ftpUsername% %uusername% %ftpPassword% %ftpServer%
set /p send=insert message here:
if /i "%send%"=="exit" (
  cd ..
    goto ftpuserschoose
)
echo sended
echo %DATE% %TIME% %uusername% %send%>>test.txt
curl -u %ftpUsername%:%ftpPassword% -T "test.txt" ftp://%ftpServer%
cls
goto send2

::user creator systemtest.txt
goto send2

:settings
echo WIP settings
echo change username "username"
echo change the name of the message file "filename"
set /p settings=
if "%settings%"=="filename" goto filename
if "%settings%"=="exit" goto ftpUsers
if "%settings%"=="username" goto changeusername

echo That option is not available
pause
goto settings

:filename
cls
echo write the new file name WIP NOT WORKING
set /p filename=
cd ..
echo %filename%>filename.save
echo filename set
goto settings


:exit
