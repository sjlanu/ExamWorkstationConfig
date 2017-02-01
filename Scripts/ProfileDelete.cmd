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

powershell.exe -executionpolicy bypass -file %CONTENTDIR%Del-exam_prof-c_temp.ps1