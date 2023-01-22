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
curl -u %sftpUsername%:%sftpPassword% ftp://%ftpServer% -Q "get message.txt path/to/remote/file/test1"
curl -u %sftpUsername%:%sftpPassword% ftp://%ftpServer% -Q "get crlm.rl path/to/remote/file/test1"
echo Ingrese el mensaje a enviar o escribe <> para recargar
set /p message=
:: this is to confirm if there is any new message
if EXIST crlm.rl type message.txt && del crlm.rl && goto loop
if "%message%"=="<>" clear && type message.txt
clear
echo %message% >> message1.txt
::this is to diplay the incoming messages
type message.txt

curl -u %sftpUsername%:%ftpPassword% ftp://%ftpServer% -Q "put message%numdifnum%.txt path/to/remote/file/test1"
curl -u %sftpUsername%:%ftpPassword% ftp://%ftpServer% -Q "put crlm%numdifnum%.rl path/to/remote/file/test1"

goto loop
