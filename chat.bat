@echo off


if exist curl.exe (
goto curlpathsetb
) else (
    set curlpath=curl
    echo is recommended to have the curl provided.
    pause
    goto stof
)
:curlpathsetb
set "curlpath=%~dp0curl.exe"
    echo %curlpath% set
    goto stof

:stof
if exist echoon (
    @echo on
) else (
@echo off    
)
setlocal enabledelayedexpansion
cls
title test CHBAT v1.7.1
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
::display the user list          users
del header.txt 2>nul

echo " ________  ___  ___  ________  ________  _________   
echo "|\   ____\|\  \|\  \|\   __  \|\   __  \|\___   ___\ 
echo "\ \  \___|\ \  \\\  \ \  \|\ /\ \  \|\  \|___ \  \_| 
echo " \ \  \    \ \   __  \ \   __  \ \   __  \   \ \  \  
echo "  \ \  \____\ \  \ \  \ \  \|\  \ \  \ \  \   \ \  \ 
echo "   \ \_______\ \__\ \__\ \_______\ \__\ \__\   \ \__\
echo "    \|_______|\|__|\|__|\|_______|\|__|\|__|    \|__|  1.7.1                                              

echo ------------------------------------------------------------------------------------------------------------------------
dir /b
echo ------------------------------------------------------------------------------------------------------------------------ 
echo select the user or option
echo "create" To add a new server
echo "settings" To go to settings
echo "exit" To exit
echo use "*" To use the functions
set /p optusr=#:

if /i "%optusr%"=="*exit" (
    goto EOF
)


if /i "%optusr%"=="*create" (
    cls
    goto inic
)


if /i "%optusr%"=="*settings" (
    cls
    goto settings
) 
    IF NOT EXIST %optusr% (
        echo %optusr% does not exist
        pause
        cls
        goto ftpuserschoose
    ) else (
goto fixelse1
    )
:fixelse1
      cd %optusr%
set /p ftpUsername=<username
set /p ftpServer=<server
set /p ftpPassword=<password
    set /p filename_save=<filename.save
cd ..
echo !optusr!>reciverin.l
   echo !filename_save!>reciver_filename.l
cd ..

goto SCKF


:SCKF2
cd users
cd !optusr!
cls
goto loop



:inic
cls
echo Enter The name of your server:
set /p optusr=#:
if exist !optusr! (
    echo that custom name already exists
    pause
    cls
    goto inic
)
Echo Enter the IP address or the Host name of the SFTP or FTP server:
set /p ftpServer=#:
Echo Enter the username to log in to the SFTP or FTP server:
set /p ftpUsername=#:
Echo Enter the password to log in to the SFTP or FTP server:
set /p ftpPassword=#:
rem user creator system   users
    echo creating user
    mkdir !optusr!
    cd !optusr!
rem                optusr
    echo !ftpUsername!>username
    echo !ftpServer!>server
    echo !ftpPassword!>password
cls
:cl
echo is the server sftp?
set /p sftpchoose=(Y,N):
if "%sftpchoose%"=="y" (
    echo o > sftp
    set sftpmode="sftp"
    cls
    goto confix
    )
if "%sftpchoose%"=="n" (
    set sftpmode="ftp"
    cls
    goto confix
    )
    echo option not valid
    pause
    cls
    goto cl
:confix
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
"%curlpath%" -u %username%:%password% -T "%filename%" %sftpmode%://%server% -k
echo Checking connection If upload doesent work There is not a connection to the server
    timeout /t 2 > nul
echo filename set
pause
cls
goto setuphide

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
echo %server%
"%curlpath%" -u %username%:%password% -T "%filename_save%" %sftpmode%://%server% -k
echo Checking connection If upload doesent work There is not a connection to the server
    timeout /t 2 > nul
echo Random filename set: %filename_save%
pause
cls
goto setuphide


:setuphide
echo Do you want to hide the Reciver?
set /p reciverhide= y,n :
if "%reciverhide%"=="y" (
goto hidereciver
)
 if "%reciverhide%"=="n"(
    goto nohidereciver
 )
echo option no aviable
pause
goto setuphide

:hidereciver
echo f > hidereciver
echo reciver activated
pause
goto con

:nohidereciver
del hidereciver > nul
echo reciver deactivated
pause
goto con

:con
cls
rem                           starting reciver
:reciever
    set /p filename_save=<filename.save
    echo > %filename_save%
    rem x users
    cd ..
    echo !optusr!>reciverin.l
    echo !filename_save!>reciver_filename.l
    cd ..
    rem main
    cd users
    cd !optusr!
    rem optuser

if EXIST hidereciver (
    cd ..
    rem users
    cd ..
    rem main
    echo Set WshShell = CreateObject^("WScript.Shell"^) > temp.vbs
          echo WshShell.Run chr(34^) ^& "reciveftp.bat" ^& Chr(34^), 0 >> temp.vbs
             echo Set WshShell = Nothing >> temp.vbs
    cscript //B temp.vbs
    del temp.vbs
        ) else (
            cd ..
            cd ..
        start reciveftp.bat
        )

    cd users
    cd !optusr!
    cls
    goto loop


rem messaging system WIP
rem set /p sftpmode=<sftp
:loop
goto send2
rem                                                optusr
:send2
if EXIST sftp (
 set "sftpmode=sftp"
) else (
set "sftpmode=ftp"
)
echo !sftpmode!
rem      display
set /p filename_save=<filename.save
cd ..
cd ..
echo !optusr! > display.user
echo !filename_save! > display.filename
start display.bat
cd users
cd !optusr!
echo 0 > text.refresh
:send3
cls
echo write use * to use options
echo options: exit, reset (to reset the reciver), upload , download, exitre: (to exit reciver when hided or not)
echo Server credentials: usr: %ftpUsername% usrn: %uusername% pass: %ftpPassword% serv: %ftpServer% file.save: %filename_save% 2>nul
set /p send=insert message here:


if /i "%send%"=="*exitre" (

    goto exitre1
)
if /i "%send%"=="*exit" (
  cd ..
    goto ftpuserschoose
)
if /i "%send%"=="*reset" (
  cd ..
    goto resetreciver
)
if /i "%send%"=="*upload" (
    goto sendfile
)
if /i "%send%"=="*download" (
        goto download
)
echo sended
echo %DATE% %TIME% %uusername% %send%>>%filename_save%
echo 0 > text.refresh
echo > nntfdp
"%curlpath%" -u %ftpUsername%:%ftpPassword% -T "%filename_save%" %sftpmode%://%ftpServer% -k

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
echo ------------------------------------------------------------------------------------------------------------------------
echo WIP settings
echo change username "username"
echo change the name of the message file "filename"
echo to turn echo on "echo on"
echo to change the protocol used on a profile "protocol"
echo to activate or deactivate notifications "notifications"
echo to hide the reciver for a specific user "hide"
echo to edit a current server added "edit"
echo exit
echo ------------------------------------------------------------------------------------------------------------------------

set /p settings=#:
if "%settings%"=="filename" goto filename
if "%settings%"=="exit" (
    cd users
goto ftpuserschoose
)

if "%settings%"=="edit" goto editserver
if "%settings%"=="hide" goto setuphideconfig
if "%settings%"=="username" goto changeusername
if "%settings%"=="echo on" goto echoon
if "%settings%"=="protocol" goto protocolchange
if "%settings%"=="notifications" goto notifcls
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
set /p sftpmode=<sftp
if "%sftpmode%"=="on2" (
 set sftpmode=sftp
) else (
    set sftpmode=ftp
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
"%curlpath%" -u %username%:%password% -T "%filename%" %sftpmode%://%server% -k
echo Checking connection If upload doesent work There is not a connection to the server
    timeout /t 2 > nul
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
"%curlpath%" -u %username%:%password% -T "%filename_save%" %sftpmode%://%server% -k
echo Checking connection If upload doesent work There is not a connection to the server
    timeout /t 2 > nul
echo Random filename set: %filename_save%
pause
cd ..
cd ..
cls
goto s

:resetreciver
cls
cd %optusr%
echo s > exit.pp
echo closing reciver
cd ..
echo sending reciverin.l
echo !optusr!>reciverin.l
        echo sending reciver_filename.l
        echo !filename_save!>reciver_filename.l
cd ..
echo starting reciver
start reciveftp.bat
cd users
cd %optusr%
echo > exit
echo completed
    timeout /t 2 > nul
    cls
goto send3

:echoon
set /p activateechoon=activate Y/ Deactivate /N #:
if "%activateechoon%"=="Y" (
echo > echoon
echo echo on has been activated
echo restart the app
set /p restartr= want to restart the app (Y,N)

if /i "%restartr%"=="Y" (
    echo restarting
    start chat.bat
    timeout /t 2 > nul
    goto EOF
) else (
    goto settings
)
) else if "%activateechoon%"=="N" (
    echo echo has been deactivated
    del echoon
    
    set /p restartr= want to restart the app (Y,N) ?

if /i "%restartr%"=="Y" (
    echo restarting
    start chat.bat
    timeout /t 2 > nul
    goto EOF
) else (
    goto settings
)


     
)

goto settings

start

:protocolchange
cls
cd users
echo for what server u want to change the protocol
dir /b
set /p user_protocol=
IF NOT EXIST %user_protocol% (
        echo %user_protocol% does not exist
        pause
        cls
        goto protocolchange
) else (
cd %user_protocol%
)
:changeprotocol
cls 
set /p protocolused=ftp or sftp :
if "%protocolused%"=="ftp" (
    del sftp
    cd ..
    cd ..
    cls
    goto s
)
if "%protocolused%"=="sftp" (
    echo on2 > sftp
    cd ..
    cd ..
    cls
    goto s
)
echo that option is not valid
pause
cls
goto changeprotocol

:notifcls
cd users
echo for what server u want to activate or deactivate notifications?
dir /b
set /p server_notif=
IF NOT EXIST %server_notif% (
        echo %server_notif% does not exist
        pause
        cls
        goto notifcls
) else (
cd %server_notif%
:tude
set /p notifchange= activate notifications "n,y"
if "%notifchange%"=="y" (
echo > notif
echo done!
cd ..
cd ..

goto s
)
if "%notifchane%"=="n" (
    del notif
    echo done!
    cd ..
    cd ..
    cls
    goto s
 )
echo that user doesent exist
pause
cls
goto tude
)





:sendfile
set /p send=insert where the file is located or drop the file here:
for %%F in ("%send%") do set "sendEND=%%~nxF"
echo sending file
echo %DATE% %TIME% %uusername% New file uploaded do *download and then put %sendEND% to download the file >> %filename_save%

echo 0 > text.refresh
echo > nntfdp
"%curlpath%" -u %ftpUsername%:%ftpPassword% -T "%filename_save%" %sftpmode%://%ftpServer% -k
"%curlpath%" -u %ftpUsername%:%ftpPassword% -T "%send%" %sftpmode%://%ftpServer% -k
echo > nntfdp
echo sended
pause
goto send3

:download
set /p downloadsf=insert the name of the file inculding extension:
"%curlpath%" --user %ftpUsername%:%ftpPassword% -o %downloadsf% %sftpmode%://%ftpServer%/%downloadsf% -k
pause
goto send3


:setuphideconfig
cd users
echo for what server u want to hide or unhide the reciver?
echo ------------------------------------------------------------------------------------------------------------------------
dir /b
echo ------------------------------------------------------------------------------------------------------------------------
set /p hideconfig=
IF NOT EXIST %hideconfig% (
        echo %hideconfig% does not exist
        pause
        cls
        goto setuphideconfig
) else (
    cd %hideconfig%
)
cls

echo Do you want to hide the Reciver?
set /p reciverhide= y,n :
if "%reciverhide1%"=="y" (

goto hidereciversetting

) 

if "%reciverhide1%"=="n" (

goto nohidereciversetting

) 


:hidereciversetting
echo f > hidereciver
echo reciver hided
pause
cls
cd ..
cd ..
goto s

:nohidereciversetting
del hidereciver > nul
echo reciver unhided
pause
cd ..
cd ..
cls
goto s

:SCKF
cd users
cd !optusr!
if EXIST hidereciver (
    cd ..
    cd ..
    echo Set WshShell = CreateObject^("WScript.Shell"^) > temp.vbs
          echo WshShell.Run chr(34^) ^& "reciveftp.bat" ^& Chr(34^), 0 >> temp.vbs
             echo Set WshShell = Nothing >> temp.vbs
    cscript //B temp.vbs
    del temp.vbs
    goto SCKF2
        ) else (
            cd ..
            cd ..
        start reciveftp.bat

        goto SCKF2
        )

:editserver

cd users
echo ------------------------------------------------------------------------------------------------------------------------
dir /b
echo ------------------------------------------------------------------------------------------------------------------------
echo for what server u want to change the credentials
set /p creden=
IF NOT EXIST %creden% (
        echo %creden% does not exist
        pause
        cls
        goto editserver
) else (
    cd %creden%
)
cls
Echo Enter the IP address or the Host name of the SFTP or FTP server:
set /p ftpServer1=#:
Echo Enter the username to log in to the SFTP or FTP server:
set /p ftpUsername1=#:
Echo Enter the password to log in to the SFTP or FTP server:
set /p ftpPassword1=#:
rem user creator system   users
    echo changing the credentials
rem                optusr
    echo !ftpUsername1!>username
    echo !ftpServer1!>server
    echo !ftpPassword1!>password
cls 
cd ..
cd ..
goto s












:exitre1
echo s > exit.pp
echo exited
goto send3

:EOF
exit
