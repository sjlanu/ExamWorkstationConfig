rem Authors
rem -------
rem
rem Sami Lanu <sami.lanu@tut.fi>
rem
rem Copyright
rem ---------
rem
rem Copyright 2016 Tampere University of Technology
rem
rem @ECHO OFF
set BUDIR="local-backup-folder"
set CONTENTDIR="\\path\to\contentdir"
rem create backupdir
if not exist "%BUDIR%" mkdir "%BUDIR%"

rem Set read deny permission for common exam account
icacls.exe "%BUDIR%" /deny exam-account:(OI)(CI)(RX)

rem Copy backupscript locally
copy "%CONTENTDIR%\backup_exam_files.ps1" "%BUDIR%"

rem Run backupscript
powershell.exe -executionpolicy bypass -file "%BUDIR%\backup_exam_files.ps1"