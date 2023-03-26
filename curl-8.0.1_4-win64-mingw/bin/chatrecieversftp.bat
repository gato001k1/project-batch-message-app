@echo off

title test CHBAT v1.5
::requieriments
if not exist users(
    mkdir users
    cd users
    )else(
        cd users
)
:ftpUsers
cls
echo select users up to N/A? friends or users

echo Write create to make a new user or friend :)
::display the user friends list
dir /b
set /p optusr=
if "%optusr%"=="create" (
    cls
    goto inic
  )else(
    cd %optusr%
    set /p usernametaker=<username
    set /p servertaker=<server
    set /p passwordtaker=<password
)
:inic
echo ingrese el nombre de el amigo :):
set /p friendname=

echo Ingrese la dirección IP o el nombre de host del servidor SFTP:
set /p ftpServer=

echo Ingrese el nombre de usuario para iniciar sesión en el servidor SFTP:
set /p ftpUsername=

echo Ingrese la contraseña para iniciar sesión en el servidor SFTP:
set /p ftpPassword=
::user creator system
if exist %ftpUsername%(
    echo that username is already taken
    pause
    cls && goto inic
         )else(
        echo %ftpUsername%>>ftpusers.users
mkdir %friendname%
cd %friendname%
echo %ftpUsername%>username
echo %ftpServerd%>server
echo %ftpPassword%>password
)


::messaging system
:loop
curl -u %ftpUsername%:%ftpPassword% -o message.txt ftp://%ftpServer%:21/message.txt
curl -u %ftpUsername%:%ftpPassword% -o crlm.rl ftp://%ftpServer%:21/crlm.rl
echo Ingrese el mensaje a enviar o escribe <> para recargar
set /p message=
:: this is to confirm if there is any new message
if EXIST crlm.rl type message.txt && del crlm.rl && goto loop
if "%message%"=="<>" clear && type message.txt
clear
echo %message% >> message1.txt
::this is to diplay the incoming messages
type message.txt

curl -u %ftpUsername%:%ftpPassword% -T message%numdifnum%.txt ftp://%ftpServer%:21/
curl -u %ftpUsername%:%ftpPassword% -T crlm%numdifnum%.rl ftp://%ftpServer%:21/

goto loop
