if exist echoon (
    @echo on
) else (
@echo off    
)

setlocal enabledelayedexpansion
cls
title test CHBAT v1.6 TEST
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
random
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
) else (
    set /p "uusername=" < username.u
    echo !uusername!
    cd users
)
:ftpuserschoose
cls
echo select the user or option
echo Write create to make a new user or settings to enter the settings and write exit to exit:
::display the user list          users
del header.txt 2>nul
dir /b
set /p optusr=

if /i "%optusr%"=="exit" (
    goto exit
)


if /i "%optusr%"=="create" (
    cls
    goto inic
)


if /i "%optusr%"=="settings" (
    cls
    goto settings
) 
    IF NOT EXIST %optusr% (
        echo %optusr% does not exist
        pause
        cls
        goto ftpuserschoose
    ) else (
      cd %optusr%
set /p ftpUsername=<username
set /p ftpServer=<server
set /p ftpPassword=<password
    set /p filename_save=<filename.save
cd ..
echo !optusr!>reciverin.l
   echo !filename_save!>reciver_filename.l
cd ..
start reciveftp.bat
cd users
cd !optusr!
cls
goto loop
    )



:inic
cls
echo Enter The custom name:
set /p optusr=
if exist !optusr! (
    echo that custom name already exists
    pause
    cls
    goto inic
)
Echo Enter the IP address or the Host name of the SFTP server:
set /p ftpServer=
Echo Enter the username to log in to the SFTP server:
set /p ftpUsername=
Echo Enter the password to log in to the SFTP server:
set /p ftpPassword=
rem user creator system   users
    echo creating user
    mkdir !optusr!
    cd !optusr!
rem                optusr
    echo !ftpUsername!>username
    echo !ftpServer!>server
    echo !ftpPassword!>password
cls
echo write the new file name or random
set /p filename=
if "%filename%"=="random" (
    cls
    goto random_file2
)
echo %filename%.txt>filename.save
echo fixing
    echo 475872309570475-57-3475-347-57509875027057-57-3475-43543850843590843-58-358-3458-03485-4385-34850238-5843-58-403985-034285-834-58342-958-385-8342-58-34285-843-583-085-384-5823858> %filename_save%
    set /p username=<username
set /p password=<password
set /p server=<server
echo %filename_save%
echo %username%
echo %password%
echo %server%
curl -u %username%:%password% -T "%filename%" ftp://%server%
echo filename set
pause
goto cl

:random_file2
echo %random%%random%.txt>filename.save
set /p filename_save=<filename.save
echo fixing
echo 475872309570475-57-3475-347-57509875027057-57-3475-43543850843590843-58-358-3458-03485-4385-34850238-5843-58-403985-034285-834-58342-958-385-8342-58-34285-843-583-085-384-5823858> %filename_save%
set /p username=<username
set /p password=<password
set /p server=<server
echo %filename_save%
echo %username%
echo %password%
echo %server%
curl -u %username%:%password% -T "%filename_save%" ftp://%server%
echo Random filename set: %filename_save%
pause

goto cl
rem                           starting reciver
    :cl
    set /p filename_save=<filename.save
    echo > %filename_save%
    rem users
    cd ..
    echo !optusr!>reciverin.l
    echo !filename_save!>reciver_filename.l
    cd ..
    rem main
    start reciveftp.bat
    cd users
    cd !optusr!
    cls
    goto loop


rem messaging system WIP
:loop
goto send2
rem                                                optusr
:send2
rem      display
set /p filename_save=<filename.save
cd ..
cd ..
echo !optusr! > display.user
echo !filename_save! > display.filename
start display.bat
cd users
cd !optusr!
:send3
cls
echo write *reset to reset the reciver and exit to exit
echo Server credentials: usr %ftpUsername% usrn %uusername% pass %ftpPassword% serv %ftpServer% file.save %filename_save% 2>nul
set /p send=insert message here:

if /i "%send%"=="exit" (
  cd ..
    goto ftpuserschoose
)
if /i "%send%"=="*reset" (
  cd ..
    goto resetreciver
)
echo sended
echo %DATE% %TIME% %uusername% %send%>>%filename_save%
echo 0 > text.refresh
curl -u %ftpUsername%:%ftpPassword% -T "%filename_save%" ftp://%ftpServer%
cls
goto send3

::user creator systemtest.txt
goto send2
rem                                                       users
:settings

cls
cd ..

:s

rem                                                  main
echo WIP settings
echo change username "username"
echo change the name of the message file "filename"
echo to turn echo on "echo on"
echo exit
set /p settings=
if "%settings%"=="filename" goto filename
if "%settings%"=="exit" (
    cd users
goto ftpuserschoose
)

if "%settings%"=="username" goto changeusername
if "%settings%"=="echo on" goto echo on

echo That option is not available
pause
goto settings

:filename
cls
cd users
echo for what user u want to change
dir /b
set /p user_name=
IF NOT EXIST %user_name% (
        echo %user_name% does not exist
        pause
        cls
        goto filename
) else (
cd %user_name%
)
echo write the new file name or random
set /p filename=


if "%filename%"=="random" (
    cls
goto random_file
)


rem                    optusr
echo %filename%.txt>filename.save
set /p filename_save=<filename.save
echo 475872309570475-57-3475-347-57509875027057-57-3475-43543850843590843-58-358-3458-03485-4385-34850238-5843-58-403985-034285-834-58342-958-385-8342-58-34285-843-583-085-384-5823858 > %filename_save%
echo fixing
    set /p username=<username
set /p password=<password
set /p server=<server
echo %filename_save%
echo %username%
echo %password%
echo %server%
curl -u %username%:%password% -T "%filename%" ftp://%server%
echo filename set
pause
cd ..
cd ..
cls
goto s

:random_file
cls
echo %random%%random%.txt>filename.save
set /p filename_save=<filename.save
echo 475872309570475-57-3475-347-57509875027057-57-3475-43543850843590843-58-358-3458-03485-4385-34850238-5843-58-403985-034285-834-58342-958-385-8342-58-34285-843-583-085-384-5823858 > %filename_save%
echo fixing
set /p username=<username
set /p password=<password
set /p server=<server
echo %filename_save%
echo %username%
echo %password%
echo %server%
curl -u %username%:%password% -T "%filename_save%" ftp://%server%
echo Random filename set: %filename_save%
pause
cd ..
cd ..
cls
goto s

:resetreciver
cls
echo please close the reciver
pause
echo sending reciverin.l
echo !optusr!>reciverin.l
        echo sending reciver_filename.l
        echo !filename_save!>reciver_filename.l
cd ..
echo starting reciver
start reciveftp.bat
cd users
cd %optusr%
echo completed
    timeout /t 2 > nul
    cls
goto send3

:echooff
echo > echoon
echo on has been activated
echo restart the app
set /p restartr= want to restart the app (Y,N) ?

if /i "%restartr%"=="Y" (
    echo restarting
    start chat.bat
    timeout /t 2 > nul
    goto exit
)
goto settings



:exit
