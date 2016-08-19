# Authors
# -------
#
# Sami Lanu <sami.lanu@tut.fi>
#
# Copyright
# ---------
#
# Copyright 2016 Tampere University of Technology
#
rem @echo off
set CONTENTDIR = \\path\to\xml\
set TASKNAME = name_of_backup_task
cls
schtasks /query > doh
findstr /B /I "%TASKNAME%" doh >nul
if %errorlevel%==0  goto :exists
goto :create

:create
schtasks /create /XML "%CONTENTDIR%\schtask_backup_exam.xml" /tn %TASKNAME%

:exists
exit /b 0