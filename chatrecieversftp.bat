@echo off
title test CHBAT v1.0
::WIP
if EXIST numdif ( 
for /f "tokens=*" %%a in (numdif.lf) do set numdifnum=%%a
goto inic
) else (
echo %random%%random%%random%%random% > numdif.lf )

:inic
echo Ingrese la dirección IP o el nombre de host del servidor SFTP:
set /p ftpServer=

echo Ingrese el nombre de usuario para iniciar sesión en el servidor SFTP:
set /p ftpUsername=

echo Ingrese la contraseña para iniciar sesión en el servidor SFTP:
set /p ftpPassword=

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
