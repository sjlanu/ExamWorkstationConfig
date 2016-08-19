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
rem Content dir with "\" in the end
rem "%~dp0" = directory of this script
set CONTENTDIR=%~dp0

cscript %CONTENTDIR%PinItem.vbs /item:"c:\ProgramData\Microsoft\Windows\Start Menu\Programs\Mozilla Firefox.lnk"
cscript %CONTENTDIR%PinItem.vbs /item:"c:\ProgramData\Microsoft\Windows\Start Menu\Programs\JetBrains\JetBrains PyCharm Community Edition 3.4.1.lnk"
cscript %CONTENTDIR%PinItem.vbs /item:"c:\ProgramData\Microsoft\Windows\Start Menu\Programs\MATLAB\R2014a\MATLAB R2014a.lnk"
cscript %CONTENTDIR%PinItem.vbs /item:"c:\Windows\system32\notepad.exe"
cscript %CONTENTDIR%PinItem.vbs /item:"c:\Windows\system32\calc.exe"
cscript %CONTENTDIR%PinItem.vbs /item:"c:\ProgramData\Microsoft\Windows\Start Menu\Programs\PDF-XChange\PDF-XChange Editor.lnk"
cscript %CONTENTDIR%PinItem.vbs /item:"C:\Windows\System32\mspaint.exe"
cscript %CONTENTDIR%PinItem.vbs /item:"C:\Program Files\7-Zip\7zFM.exe"