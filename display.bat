@echo off
title DISPLAY
set /p user=<display.user
set /p filename=<display.filename
echo %user% #%filename%
del display.user
del display.filename
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
type %filename%
del text.refresh
goto loop
