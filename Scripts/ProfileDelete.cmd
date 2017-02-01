# Authors
# -------
#
# Sami Lanu <sami.lanu@tut.fi>
#
# Copyright
# ---------
#
# Copyright 2017 Tampere University of Technology
@echo off
rem Content dir with "\" in the end
rem "%~dp0" = directory of this script
set CONTENTDIR=%~dp0
set MYSCRIPTS="c:\myscipts"
set UNCPATH="\\path\to"
set SCRIPT="Del-exam_prof-c_temp.ps1"

if not exist %MYSCRIPTS% mkdir %MYSCRIPTS%
copy /Y %UNCPATH%\%SCRIPT% %MYSCRIPTS%
powershell.exe -executionpolicy bypass -file %MYSCRIPTS%\%SCRIPT%