rem ffdfs
rem edit with vi only
@echo off
c:\apps\admintools\examscripts\SetACL-32bit.exe -on root\cimv2 -ot wmi -actn list | find /I "your_nagios_user" > nul
if not %errorlevel% EQU 0 exit /b 1
