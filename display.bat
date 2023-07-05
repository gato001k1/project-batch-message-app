@echo off

set /p user=<display.user
echo %user%
del display.user
cd users
cd %user%
:loop
if exist text.refresh (
goto 2
) else (
    goto loop
)

:2
cls
type test.txt
del text.refresh
goto loop
