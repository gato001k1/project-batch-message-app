@echo off
:inic
if not exist file.txt(
echo %random%%random%%random%%random%>file.txt
)else(
    echo %random%%random%%random%%random%>>file.txt

)
set /p file_contents=<file.txt
echo The filkue contenkmts are: %file_contents%
pause