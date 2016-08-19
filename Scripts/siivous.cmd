# Authors
# -------
#
# Sami Lanu <sami.lanu@tut.fi>
#
# Copyright
# ---------
#
# Copyright 2016 Tampere University of Technology
@echo off
rmdir /S /Q C:\temp
mkdir c:\temp
rem Grant modify rights to Users group
icacls.exe "C:\temp" /grant *S-1-5-11:(OI)(CI)(M)