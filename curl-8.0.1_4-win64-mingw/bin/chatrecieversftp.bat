@echo off
cls
title test CHBAT v1.5
::requieriments
set /p %filename%<=filename.save
if not exist users (
    echo creating user folder
    mkdir users
    cd users
    cls
      ) else (
        cd users
        goto ftpUsers
 )
:ftpUsers
if not exist username.u (
    :usernamef
    cls
    echo what username would you want to use 
    set /p uusername=
    echo %uusername%>username.u                                               
 ) else (
    set /p uusername=<username.u
 )
cls
echo select the user or option

echo Write create to make a new user or settings to enter the settings:
::display the user friends list
dir /b
set /p optusr=
if "%optusr%"=="settings" (
 goto settings
 )
if "%optusr%"=="create" (
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
     set /p usernametaker=<username
     set /p servertaker=<server
     set /p passwordtaker=<password
     cd ..
    echo %optusr%>reciverin.l
    cd ..
    start reciverftp.bat
    cd users
    cd %optsur%
         cls

     goto loop
        )
  )
:inic
cls
echo Enter the name of The custom name :)
set /p Customname=
Echo Enter the IP address or the Host name of the SFTP server:
set /p ftpServer=
Echo Enters the username to log in to the SFTP server:
set /p ftpUsername=
Echo Enters the password to log in to the SFTP server:
set /p ftpPassword=

::user creator system
if exist %Customname% (
    echo that username is already taken
    pause
    cls && goto inic
  ) else (
    echo creating user
    mkdir %Customname%
    cd %Customname%
    echo %ftpUsername%>username
    echo %ftpServer%>server
    echo %ftpPassword%>password
    goto loop
  )


::messaging system WIP
:loop
  goto send2
:send2
set /p send=
   echo %DATE% %TIME% %uusername% %send%>>test.txt
    curl -u %ftpUsername%:%ftpPassword% -T "test.txt" ftp://%ftpServer%
goto send2


:inic
cls
echo Enter the name of The custom name :)
set /p Customname=
Echo Enter the IP address or the Host name of the SFTP server:
set /p ftpServer=
Echo Enters the username to log in to the SFTP server:
set /p ftpUsername=
Echo Enters the password to log in to the SFTP server:
set /p ftpPassword=

::user creator systemtest.txt
goto send2

:settings
echo WIP settings
echo change username "username"
echo change the name of the message file "filename"
set /p settings=
if "%settings%"=="filename" goto filename
if "%settings%"=="exit" goto ftpUsers
if "%settings%"=="username" goto usernamef

  echo That option is not available
  pause
  goto settings

:filename
cls
echo write the new file name 
set /p filename=
cd ..
echo %filename%>filename.save
echo filename set
goto settings
