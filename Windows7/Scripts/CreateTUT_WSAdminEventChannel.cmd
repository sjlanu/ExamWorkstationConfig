rem Authors
rem -------
rem Sami Lanu <sami.lanu@tut.fi>
rem
rem Copyright
rem ---------
rem
rem Copyright 2016 Tampere University of Technology
rem
rem variables not working for "eventcreate.exe" command
rem Use search/replace to replace "testing" for something suitable
IF EXIST "c:\windows\logs\testing_eventchannel_created.log" goto :EOF
c:\windows\system32\eventcreate.exe /T INFORMATION /L APPLICATION /SO testing /ID 124 /D testing > c:\windows\logs\testing_eventchannel_created.log