@echo off
title TSTCHTBAT
echo Ingrese la dirección IP o el nombre de host del servidor SFTP:
set /p sftpServer=

echo Ingrese el nombre de usuario para iniciar sesión en el servidor SFTP:
set /p sftpUsername=

echo Ingrese la contraseña para iniciar sesión en el servidor SFTP:
set /p sftpPassword=

:loop
curl -u %sftpUsername%:%sftpPassword% sftp://%sftpServer% -Q "get message.txt path/to/remote/file/test1"
curl -u %sftpUsername%:%sftpPassword% sftp://%sftpServer% -Q "get crlm.rl path/to/remote/file/test1"
echo Ingrese el mensaje a enviar o escribe <> para recargar
set /p message=
:: this is to confirm if there is any new message
if EXIST crlm.rl type message.txt && del crlm.rl && goto loop
if "%message%"=="<>" clear && type message.txt
clear
echo %message% >> message1.txt
::this is to diplay the incoming messages
type message.txt

curl -u %sftpUsername%:%sftpPassword% sftp://%sftpServer% -Q "put message1.txt path/to/remote/file/test1"
curl -u %sftpUsername%:%sftpPassword% sftp://%sftpServer% -Q "put crlm1.rl path/to/remote/file/test1"

goto loop

