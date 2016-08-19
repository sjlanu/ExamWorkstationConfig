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
# 55 second delay to allow TaskBar to load first
ping 127.0.0.1 -n 55 > nul
cscript //NoLogo //B "\\groupserver.intra.tut.fi\gpinstall$\Logonscripts\ExamComputers\UnPinTaskbar_2.vbs"
rem cscript "\\groupserver.intra.tut.fi\gpinstall$\Logonscripts\ExamComputers\UnPinTaskbar.vbs" /item:"C:\Program Files\Internet Explorer\iexplore.exe" /taskbar
rem cscript "\\groupserver.intra.tut.fi\gpinstall$\Logonscripts\ExamComputers\UnPinTaskbar.vbs" /item:"%ProgramFiles(x86)%\Windows Media Player\wmplayer.exe" /taskbar
rem cscript "\\groupserver.intra.tut.fi\gpinstall$\Logonscripts\ExamComputers\UnPinTaskbar.vbs" /item:"%windir%\explorer.exe" /taskbar